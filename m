Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A68C98328
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 09:34:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38AC5402D0;
	Sat, 26 Sep 2026 11:34:19 +0200 (CEST)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTP id 1468A40294;
 Fri, 25 Sep 2026 15:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1790342209;
 bh=hUYt2+Hu5E4bOZHyutfX37Cz3NhPUIHVu6OQ6kYB7GY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=aM6c2xc7ij8m0O5vIpFPccnzW5sT6go+iAMTWo/ZfrpRZca+bOBlvf+JxykVYYolO
 2ohW0pXt7sE2KpdvE1tgvg55QhTfrA5hWRnzvkJpVA49c8fp6bBAnm5IgUvK0mWoKm
 4UqeosWweCePMV7PjH2uZdImN7DfiSU8geKri2TTICCmjwt1t7O04U/3xyRoXUjHGR
 UWosEJdzbK9b2u50NL1xzqodj6pLtapr96NViUw3kk5AZehwbJAdVE5WbXztaflpMo
 41TtFt1/OLUjqgqJO0yTVe/qwUHjzPhrhp578+nDb974c2QOdmO12K9hfgW3ewA+HE
 Tt9xLnYwV/rdg==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id CAAC8C0AD9F;
 Fri, 25 Sep 2026 16:16:49 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id A02E2C0907E;
 Fri, 25 Sep 2026 16:16:49 +0300 (MSK)
Received: from konyukhov.avp.ru (10.16.104.193) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 16:16:48 +0300
From: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
To: Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>, 
 Joshua Washington <joshwash@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Konyukhov Aleksandr
 <Alexander.Konyukhov@kaspersky.com>
Subject: [PATCH] net/gve: fix redundant comparison of qpl_bufs with null
Date: Fri, 25 Sep 2026 16:16:41 +0300
Message-ID: <20260925131641.3895495-1-Alexander.Konyukhov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.16.104.193]
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/25/2026 13:02:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 206250 [Sep 25 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Konyukhov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 125 0.3.125
 408a76d0ab6a6a06c054d212c38932c1e9d7db86
X-KSE-AntiSpam-Info: {diag_burst_silent}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; konyukhov.avp.ru:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/25/2026 13:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/25/2026 11:50:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/09/25 12:47:00 #28626221
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Mailman-Approved-At: Sat, 26 Sep 2026 11:34:16 +0200
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

Memory allocation for qpl->mz and qpl->qpl_bufs occurs in the
gve_alloc_queue_page_list() function under the condition
if(is_rx) qpl_bufs = rte_zmalloc else mz = gve_alloc_using_mz.
Accordingly, if qpl->mz == NULL, then memory allocation
for qpl->qpl_bufs definitely occurred. That is, in line
gve_ethdev.c:127, an additional check if (qpl->qpl_bufs)
is not required.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9873a135bfba ("net/gve: allocate Rx QPL pages using malloc")
Cc: pkaligineedi@google.com

Signed-off-by: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
---
 drivers/net/gve/gve_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 3596a0236d..b72359a9af 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -124,7 +124,7 @@ gve_free_queue_page_list(struct gve_queue_page_list *qpl)
 	if (qpl->mz) {
 		rte_memzone_free(qpl->mz);
 		qpl->mz = NULL;
-	} else if (qpl->qpl_bufs) {
+	} else {
 		uint32_t i;
 
 		for (i = 0; i < qpl->num_entries; i++)
-- 
2.43.0

