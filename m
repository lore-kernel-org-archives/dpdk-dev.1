Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE0CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:27:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B37444026C;
	Fri,  2 Oct 2026 13:27:16 +0200 (CEST)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTP id F1C404003C;
 Fri,  2 Oct 2026 13:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1790940103;
 bh=yXlRMLcR0kjE+23ZE5fdC6P+nqN5c4LWIWh3x4aGq6c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=NNwNb5Vi4UeY8RuwhTrheP6X1hYnqASjeJPHgHMNq03cW5YVx8qeo2C6UkQ1GJBGk
 idd2+HX9LIrrVpxQteGz9HN9Dz0dI+8cPi6kPM651LuhKgaNF2dDBY2Orftp3RG7XX
 fDAhnIfkdGhCvjPFDZ1xUFsA1D6B5zPmdCRqJKDFW4pnjz++yNITzmEcG1H7DgYRxR
 At0tj10IscvNNh5l2S4AWESJTx210aeh+3DBP4O1PqacdWmVQaxK/NtAmUNAS1ToqF
 REN4x6hGGBTvEhrvljmakQax4blw3Zt12B71j0K9mFMoWOBBfaNiaHwwdnV2H1m9+N
 PW6idBcnYx+Tw==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id 77A4DC09029;
 Fri,  2 Oct 2026 14:21:43 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id 22F58C08F86;
 Fri,  2 Oct 2026 14:21:43 +0300 (MSK)
Received: from konyukhov.avp.ru (10.16.104.193) by HQMAILSRV1.avp.ru
 (10.64.57.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:20:55 +0300
From: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, 
 Declan Doherty <declan.doherty@intel.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <sdl.dpdk@linuxtesting.org>, <dev@dpdk.org>, <stable@dpdk.org>,
 <roy.fan.zhang@intel.com>, Konyukhov Aleksandr
 <Alexander.Konyukhov@kaspersky.com>
Subject: [PATCH v2] crypto/ipsec_mb: fix Null ptr dereference in
 set_mb_job_params()
Date: Fri, 2 Oct 2026 14:20:46 +0300
Message-ID: <20261002112046.601087-1-Alexander.Konyukhov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.16.104.193]
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV1.avp.ru
 (10.64.57.51)
X-KSE-ServerInfo: HQMAILSRV1.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/02/2026 11:13:43
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 206398 [Oct 02 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Konyukhov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 126 0.3.126
 e1c111e02c8860cfcff70cd549bb6eae82fc7c38
X-KSE-AntiSpam-Info: {diag_burst_silent}
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; konyukhov.avp.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/02/2026 11:16:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/2/2026 10:38:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/10/02 10:45:00 #28647887
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Mailman-Approved-At: Fri, 02 Oct 2026 13:27:15 +0200
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
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 05dc1a039f..e3a53d9a14 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1739,9 +1739,13 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 	}
 
 	if (cipher_mode == IMB_CIPHER_NULL && oop) {
-		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
-			job->src + job->cipher_start_src_offset_in_bytes,
-			job->msg_len_to_cipher_in_bytes);
+		if (!sgl) {
+			memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
+				job->src + job->cipher_start_src_offset_in_bytes,
+				job->msg_len_to_cipher_in_bytes);
+		} else {
+			return -1;
+		}
 	}
 
 	/* Set user data to be crypto operation data struct */
-- 
2.43.0

