using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage;
using System.Drawing;
using System.Drawing.Imaging;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Azure.EventGrid.Models;

namespace Mod40Functions
{
    public static class TailwindFunctions
    {
        static string ConnectionString = Environment.GetEnvironmentVariable("AzureWebJobsStorage");
        const string CONTAINER = "wishlist";

        [FunctionName(nameof(MakeThumbnailHttp))]
        public static async Task<IActionResult> MakeThumbnailHttp(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string blob = req.Query["blob"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            blob = blob ?? data?.blob;

            if (string.IsNullOrWhiteSpace(blob))
            {
                return new BadRequestObjectResult("Blob is required.");
            }
            else
            {
                try
                {
                    var result = await MakeThumb(blob, log);
                    return result ? (IActionResult)new OkResult() :
                        new BadRequestObjectResult("Already exists.");
                }
                catch (Exception ex)
                {
                    log.LogError(ex, "Thumbnail failed.");
                    return new BadRequestObjectResult("Unexpected failure.");
                }
            }
        }

        [FunctionName(nameof(MakeThumbnailEventGrid))]
        public static async Task MakeThumbnailEventGrid(
            [EventGridTrigger]EventGridEvent eventWrapper,
            ILogger log)
        {
            log.LogInformation("Event grid event received.");
            log.LogInformation(eventWrapper.Data.ToString());
            if (eventWrapper.Data is StorageBlobCreatedEventData blobEvent)
            {
                await MakeThumb(blobEvent.Url, log);
            }
        }

        private static bool ThumbnailCallback() => false;

        private static async Task<bool> MakeThumb(string url, ILogger log)
        {
            log.LogInformation("Attempting to process url {url}", url);
            if (url.Contains("_thumb.jpg"))
            {
                log.LogInformation("URL passed is thumbnail.");
                return false;
            }
            var uri = new Uri(url);
            var cloudBlob = new CloudBlob(uri);
            var name = cloudBlob.Name;
            var account = CloudStorageAccount.Parse(ConnectionString);
            var client = account.CreateCloudBlobClient();
            var container = client.GetContainerReference(CONTAINER);
            var blockBlob = container.GetBlockBlobReference(name);
            using (var inputStream = await blockBlob.OpenReadAsync())
            {
                var thumb = container.GetBlockBlobReference(name.Replace(".jpg", "_thumb.jpg"));
                if (await thumb.ExistsAsync())
                {
                    log.LogInformation("Thumbnail already exists.");
                    return false;
                }
                using (var thumbStream = new MemoryStream())
                {
                    var image = Image.FromStream(inputStream);
                    var abortCallback = new Image.GetThumbnailImageAbort(ThumbnailCallback);
                    var thumbnailImage = image.GetThumbnailImage(200, 200, abortCallback, IntPtr.Zero);
                    thumbnailImage.Save(thumbStream, ImageFormat.Jpeg);
                    thumbStream.Position = 0;
                    await thumb.UploadFromStreamAsync(thumbStream);
                }
                thumb.Properties.ContentType = "image/jpeg";
                await thumb.SetPropertiesAsync();
            }
            return true;
        }
    }
}