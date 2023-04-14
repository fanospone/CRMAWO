using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace CRMAWO
{
    public class GetAdAuthentication
    {
        private static bool _resultArray;
        public static bool result()
        {
            return _resultArray;
        }
        
        public bool IsAuthenticatedPost(string domain, string username, string pwd)
        {
            bool _resultArray;
            try
            {
                //_resultArray = false;
                var restclient = new RestClient(domain);
                var request = new RestRequest(Method.POST);
                string JsonToSend = "{'Username': '" + username + "','Password':'" + pwd + "'}";
                request.AddParameter("application/json; charset=utf-8", JsonToSend, ParameterType.RequestBody);
                request.RequestFormat = DataFormat.Json;
                IRestResponse response = restclient.Execute(request);
                var resultToken = response.Content.ToString();
                var payload = JObject.Parse(resultToken);
                _resultArray = payload.Value<bool>("Result");

                //Update the new path to the user in the directory.
                //return _resultArray;
            }
            catch (Exception ex)
            {
                throw new Exception("Error authenticating user. " + ex.Message);
            }
            return _resultArray;
        }
    }
}