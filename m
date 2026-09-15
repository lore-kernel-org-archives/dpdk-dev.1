Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A6C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:55:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839DB40E2F;
	Tue, 15 Sep 2026 10:55:08 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id DB68740A82;
 Tue, 15 Sep 2026 10:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru DF7A72C0BA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462505; bh=UOQRAM0rbImesd15VvBamVFsjhBSHz/ajQ2Zg50YfJY=;
 h=From:To:CC:Subject:Date:From;
 b=MSRlXzP8RQfR3QDMdMRUbLB46rhixibYCqD3vBBUZFIR/3uxlgd15XVIm75u1Yh8Q
 mFxEas1jaqlfxIKISKVQuwk2rfEPD2agiTNcWMabgavsOcJFb8rlqFrG4EFHHqb2eG
 Gp++r2q83hqKlN+Nn3AOVXMqz/p4hWoEHRbOLNwU=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id DF7A72C0BA8;
 Tue, 15 Sep 2026 11:55:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 8B8DA2C0B19
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 8B8DA2C0B19;
 Tue, 15 Sep 2026 11:55:04 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <kalesh-anakkur.purayil@broadcom.com>, 
 <somnath.kotur@broadcom.com>, Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: prevent overflow in alarm timeout calculation
Date: Tue, 15 Sep 2026 08:55:02 +0000
Message-ID: <20260915085502.430947-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-01.infotecs-nt (10.17.0.3) To
 msk-exch-02.infotecs-nt (10.17.0.2)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 05:24:00 #28584173
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

The alarm timeout is calculated by multiplying wait_msec by
US_PER_MS before passing the value to rte_eal_alarm_set().

Since wait_msec is a uint32_t, the multiplication may overflow
when performed using 32-bit arithmetic for large timeout values.

Cast wait_msec to uint64_t to ensure the multiplication is
performed in 64-bit arithmetic.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Cc: stable@dpdk.org
---
 drivers/net/bnxt/bnxt_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index a2429561b9..16a65f9770 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -4855,7 +4855,7 @@ static void bnxt_check_fw_health(void *arg)
 
 	info->last_reset_counter = val;
 
-	rte_eal_alarm_set(US_PER_MS * info->driver_polling_freq,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)info->driver_polling_freq,
 			  bnxt_check_fw_health, (void *)bp);
 
 	return;
@@ -4877,7 +4877,7 @@ static void bnxt_check_fw_health(void *arg)
 	else
 		wait_msec = info->normal_func_wait_period;
 
-	rte_eal_alarm_set(US_PER_MS * wait_msec,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,
 			  bnxt_fw_reset_cb, (void *)bp);
 }
 
@@ -4895,7 +4895,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)
 
 	polling_freq = bp->recovery_info->driver_polling_freq;
 
-	rte_eal_alarm_set(US_PER_MS * polling_freq,
+	rte_eal_alarm_set(US_PER_MS * (uint64_t)polling_freq,
 			  bnxt_check_fw_health, (void *)bp);
 	bp->flags |= BNXT_FLAG_FW_HEALTH_CHECK_SCHEDULED;
 
-- 
2.30.2

