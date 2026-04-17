Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1964DFB44C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACB0402C4;
	Fri, 24 Apr 2026 09:05:52 +0200 (CEST)
Received: from send129.i.mail.ru (send129.i.mail.ru [89.221.237.224])
 by mails.dpdk.org (Postfix) with ESMTP id 5D85E402A7;
 Fri, 17 Apr 2026 07:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=YJCsJFhY7zg4fHzaYwR7AbJQVAj4N8ykuC97AAX7UTw=; t=1776403426; x=1776493426; 
 b=r+qzlaCkR1/p/YHPQ3AMo/VA83MpWhCrDxK9+WwmTiNFfmqVSN1paeyCEn6BeeDBVUekXJN0WNM
 oSfq3PL74I2YQ3zEKY6znvXZ8W55yHyeUBJ1PFjZHoX25q6cU23pQD+AkZvBKcoE3IaPRjMGHZWyC
 YMyWbq6lCasIXBkcBRAdeSCkrxE/689lXBQQrcpcM6EmftF3VD9jU7B3vbcILvdOBslH9kiXhgvCW
 qGodN7EKa4fuhq9DyY9h8+kI05z27W0p822X25qbgE2ym7/KTbhUu8YVZzLnylaKtM2vRq/1AD08U
 8SmaPnFB4BZIszMtE0LZLmh9m+lr20IJQNJw==;
Received: by exim-smtp-5c94f89c8c-jm97c with esmtpa (envelope-from
 <lyulin.2003@mail.ru>)
 id 1wDbg8-000000006wY-3Xmd; Fri, 17 Apr 2026 08:23:45 +0300
From: Denis Lyulin <lyulin.2003@mail.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Denis Lyulin <lyulin.2003@mail.ru>
Subject: [PATCH] net/bnxt: add cast to wider type before multiplication
Date: Fri, 17 Apr 2026 08:23:33 +0300
Message-Id: <20260417052334.2217652-1-lyulin.2003@mail.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-5c94f89c8c-jm97c;
 auth=pass smtp.auth=lyulin.2003@mail.ru
 smtp.mailfrom=lyulin.2003@mail.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD933EB536A6C38181680DC6D983A512C44603D2E84CEE93B6C182A05F538085040A33C4A5CB83BD25F3DE06ABAFEAF6705C359E0A46D311F4D9840CBEF3A87A59C492007A4EDD3F072
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE768BD42809A772657EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663BEDCB502AD08FC077CEBB4A405AC2E54C4950E3BD506B1160AE831A1641E1188EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C084ED00A64A654CBE8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6042F1592492B88C6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249699DF0255595E9BD76E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B17800100564F618E3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493D58E677C372A3F47E5B2F3A2B87CD4C8C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A57A18343150B229AE5002B1117B3ED69604C1CC046FB9C5870E58516B1639A14B823CB91A9FED034534781492E4B8EEADB30A456A8F293845C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659D7C5FCE942FC844959825FFA88CD4C094516E82459BA60BF0D94128D7D6298844874354D9325D57AB8341EE9D5BE9A0A218FF574BB53ABDCCAB6EC2174C8E175BB1BC6834C0A8E00DABE3362BFED2FD64C41F94D744909CE5DDE6AB186FA14AA15C35E0BAFFE8D415811D22EBD454E4C3FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVbj/KpoGcZAL3pUXBPQowTI=
X-Mailru-Sender: C0FC423AA8FD9F6963CC77E2AC28C4C9E2DD7D1A192C5B95B951B70A5BD4BD8E585157FE113586B1404621D10D0FE5F2CFB1E98417576B9F6EFAE8183A2EAE0DD521319575DF8831E3C55DE776B662A175379CF7CCB93CA93DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Some static analyzers generate warnings about possible integer
overflow on multiplication. The first parameter of
`rte_eal_alarm_set()` is `uint64_t`, so this commit adds cast
of `uint32_t` values before the multiplication to prevent overflow.
The fix is cosmetic.

Fixes: 9d0cbaecc91a ("net/bnxt: support periodic FW health monitoring")
Cc: kalesh-anakkur.purayil@broadcom.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
---
 drivers/net/bnxt/bnxt_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..bdfab3eef2 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -4861,7 +4861,7 @@ static void bnxt_dev_recover(void *arg)
 void bnxt_dev_reset_and_resume(void *arg)
 {
 	struct bnxt *bp = arg;
-	uint32_t us = US_PER_MS * bp->fw_reset_min_msecs;
+	uint64_t us = US_PER_MS * (uint64_t)bp->fw_reset_min_msecs;
 	uint16_t val = 0;
 	int rc;
 
@@ -5008,7 +5008,7 @@ static void bnxt_check_fw_health(void *arg)
 
 	info->last_reset_counter = val;
 
-	rte_eal_alarm_set(US_PER_MS * info->driver_polling_freq,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)info->driver_polling_freq,
 			  bnxt_check_fw_health, (void *)bp);
 
 	return;
@@ -5030,7 +5030,7 @@ static void bnxt_check_fw_health(void *arg)
 	else
 		wait_msec = info->normal_func_wait_period;
 
-	rte_eal_alarm_set(US_PER_MS * wait_msec,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,
 			  bnxt_fw_reset_cb, (void *)bp);
 }
 
@@ -5048,7 +5048,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)
 
 	polling_freq = bp->recovery_info->driver_polling_freq;
 
-	rte_eal_alarm_set(US_PER_MS * polling_freq,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)polling_freq,
 			  bnxt_check_fw_health, (void *)bp);
 	bp->flags |= BNXT_FLAG_FW_HEALTH_CHECK_SCHEDULED;
 
-- 
2.34.1

