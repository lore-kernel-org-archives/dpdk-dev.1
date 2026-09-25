Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D1C98328
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 09:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ADFC4060F;
	Sat, 26 Sep 2026 11:34:20 +0200 (CEST)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTP id 0271440294;
 Fri, 25 Sep 2026 15:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1790342239;
 bh=oaYkmYOLshtuCEPbWxRMcE8cZHAH1n3eY31W9dFECQs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=IwA2qLz8HPvrexJAEepQuAyVm5LPRYYOn749vnYnkn5OE0vfT1P3p3TdPXAvEqOhZ
 UmbcpNaNaPbqr+HZy2cluzfzQS/JZcfPM4mNpCgUNDFPH4bDg3OWQdpt1xOn/AADbH
 n/W26bVVyFDaveKuzHN8rzrSVUm1r7C9yhY4ms1Wc0mAP1vWUos8NKpufGDnXinRTi
 wsAhzqlERZDIJQ3QgmCgsawt/lInW0WTys+KP5XyQbuGaAsVHz/PkBNSYYdpvt4UsM
 FI4/FWYeBkmAjyr2yvsZ4Zgki3qO62grLkuaantwY7fOoNdei1kZ9zmekrnzHRB+1Z
 cybQj4teyH1Xg==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id D0CC3C0C27E;
 Fri, 25 Sep 2026 16:17:19 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id A4C48C0B316;
 Fri, 25 Sep 2026 16:17:19 +0300 (MSK)
Received: from konyukhov.avp.ru (10.16.104.193) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 16:17:18 +0300
From: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, 
 Radu Nicolau <radu.nicolau@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Declan Doherty <declan.doherty@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <pkaligineedi@google.com>, Konyukhov
 Aleksandr <Alexander.Konyukhov@kaspersky.com>, <roy.fan.zhang@intel.com>
Subject: [PATCH] crypto/ipsec_mb: fix Null ptr dereference in
 set_mb_job_params()
Date: Fri, 25 Sep 2026 16:17:14 +0300
Message-ID: <20260925131714.3895601-1-Alexander.Konyukhov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.16.104.193]
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV1.avp.ru
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

In function set_mb_job_params pmd_aesni_mb.c:1742 check
(cipher_mode == IMB_CIPHER_NULL && oop)
is not enath to garanteed job->dst != 0, which in turn could lead to
NULL ptr dereference.

Add new check for (sgl == 0) to be shure that job->dst
was set in pmd_aesni_mb.c:1610

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 03944ff5e3df ("crypto/ipsec_mb: support null auth/cipher for aesni_mb")
Cc: roy.fan.zhang@intel.com

Signed-off-by: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 05dc1a039f..57d8925a87 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1738,7 +1738,7 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = op->sym->cipher.data.length;
 	}
 
-	if (cipher_mode == IMB_CIPHER_NULL && oop) {
+	if (cipher_mode == IMB_CIPHER_NULL && oop && !sgl) {
 		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
 			job->src + job->cipher_start_src_offset_in_bytes,
 			job->msg_len_to_cipher_in_bytes);
-- 
2.55.0.windows.2

