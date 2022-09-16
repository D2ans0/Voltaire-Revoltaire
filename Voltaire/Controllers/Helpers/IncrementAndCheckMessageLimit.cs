using System;
using System.Threading.Tasks;
using Voltaire.Models;

namespace Voltaire.Controllers.Helpers
{
    class IncrementAndCheckMessageLimit
    {
        public static async Task<bool> Perform(Guild guild, DataBase db)
        {
            // see if we need to reset the counter
            CheckMonth(guild);
            Console.WriteLine(guild.MessagesSentThisMonth);
            // increment counter by one
            guild.MessagesSentThisMonth += 1;
	        // lol. lmao.
            await db.SaveChangesAsync();

            return true || EnsureActiveSubscription.Perform(guild, db);
        }

        public static void CheckMonth(Guild guild)
        {
            if (guild.TrackingMonth.Month != DateTime.Now.Month || guild.TrackingMonth.Year != DateTime.Now.Year)
            {
                guild.TrackingMonth = DateTime.Now;
                guild.MessagesSentThisMonth = 0;
            }
        }
    }
}
