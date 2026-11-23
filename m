Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F7606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FfOqLuyY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABC454027A;
	Mon, 23 Nov 2026 11:30:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 92E0040262;
 Mon, 23 Nov 2026 11:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795429857; x=1826965857;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cNuyKFSM0Hgah2yaWK3cCUC48uuj+v6mr48M34/s9x0=;
 b=FfOqLuyY9cn0eHK7L/KzBfinMGjpSyITjEYTl8T483aiOQneqzm3uhKJ
 LOj/KKiiRYQV+TPbQaTHj/bFn4uzw13issxda/yINoJyjVK72tKyKWBYK
 DmDnBTFpip2IV16Gun4abo5y5OwNI5dDLqu5i3hdvgo2vWxjon2zNudjC
 jaKLCZz+sX83ML6sGdkZ9rmJ4dE/vZsjFT2r5Hp5HtnwL8aaYBFg/eeWK
 7LFDAvdRvpJ/pNvlPdKhAryprtX8cJ/HrmL8mFepZCXsVysJBfhOP4FNe
 9GmQa2cLsfWrq5eqZu+G8hz65LyBO/7S3fXeb+TYDGaSvGM/KX9iW8+kF w==;
X-CSE-ConnectionGUID: veYbkdBrQ3mnWaloVi9Q1A==
X-CSE-MsgGUID: zzG+R63jTTOH4g0E7bqLxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4118632"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4118632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:30:35 -0800
X-CSE-ConnectionGUID: +D5jmMHAQ+CbKl/xAXJ8qQ==
X-CSE-MsgGUID: RggEaHFPSsKQxMNJiQU1MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11583399"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2026 02:30:34 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 srizor@qti.qualcomm.com, Kai Ji <kai.ji@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] crypto/ipsec_mb: fix cipher and auth length calculation
Date: Mon, 23 Nov 2026 10:30:25 +0000
Message-ID: <20261123103025.3538549-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix cipher and auth length calculation for new wireless
algorithms when encrypted digest is used.

Fixes: c7adee547cc9 ("crypto/ipsec_mb: support 256-NxA4/5/6 algorithms")
Cc: stable@dpdk.org
Cc: srizor@qti.qualcomm.com

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 54 ++++++++++++++++++--------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index ab917b3fe4..d0f2f5aa62 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1767,21 +1767,32 @@ aesni_mb_digest_appended_in_src(struct rte_crypto_op *op, IMB_JOB *job,
 	if (job->cipher_mode == IMB_CIPHER_NULL)
 		return NULL;
 
-	if (job->cipher_mode == IMB_CIPHER_ZUC_EEA3 ||
-		job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
-		job->cipher_mode == IMB_CIPHER_KASUMI_UEA1) {
+	if (job->cipher_mode == IMB_CIPHER_ZUC_EEA3
+		|| job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2
+		|| job->cipher_mode == IMB_CIPHER_KASUMI_UEA1
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		|| job->cipher_mode == IMB_CIPHER_SNOW5G_NEA4
+		|| job->cipher_mode == IMB_CIPHER_AES_NEA5
+		|| job->cipher_mode == IMB_CIPHER_ZUC_NEA6
+#endif
+		) {
 		cipher_size = (op->sym->cipher.data.offset >> 3) +
 			(op->sym->cipher.data.length >> 3);
 	} else {
 		cipher_size = (op->sym->cipher.data.offset) +
 			(op->sym->cipher.data.length);
 	}
-	if (job->hash_alg == IMB_AUTH_ZUC_EIA3 ||
-		job->hash_alg == IMB_AUTH_SNOW3G_UIA2 ||
-#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
-		job->hash_alg == IMB_AUTH_ZUC256_EIA3 ||
+	if (job->hash_alg == IMB_AUTH_ZUC_EIA3
+		|| job->hash_alg == IMB_AUTH_SNOW3G_UIA2
+		|| job->hash_alg == IMB_AUTH_KASUMI_UIA1
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+		|| job->hash_alg == IMB_AUTH_SNOW5G_NIA4
+		|| job->hash_alg == IMB_AUTH_AES_NIA5
+		|| job->hash_alg == IMB_AUTH_ZUC_NIA6
+#else
+		|| job->hash_alg == IMB_AUTH_ZUC256_EIA3
 #endif
-		job->hash_alg == IMB_AUTH_KASUMI_UIA1) {
+	    ) {
 		auth_size = (op->sym->auth.data.offset >> 3) +
 			(op->sym->auth.data.length >> 3);
 	} else {
@@ -2448,21 +2459,32 @@ post_process_mb_job(struct ipsec_mb_qp *qp, IMB_JOB *job)
 				aesni_mb_digest_appended_in_src(op, job, oop) != NULL) {
 					unsigned int auth_size, cipher_size;
 					int unencrypted_bytes = 0;
-					if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2 ||
-						job->cipher_mode == IMB_CIPHER_KASUMI_UEA1 ||
-						job->cipher_mode == IMB_CIPHER_ZUC_EEA3) {
+					if (job->cipher_mode == IMB_CIPHER_SNOW3G_UEA2
+						|| job->cipher_mode == IMB_CIPHER_KASUMI_UEA1
+						|| job->cipher_mode == IMB_CIPHER_ZUC_EEA3
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+						|| job->cipher_mode == IMB_CIPHER_SNOW5G_NEA4
+						|| job->cipher_mode == IMB_CIPHER_AES_NEA5
+						|| job->cipher_mode == IMB_CIPHER_ZUC_NEA6
+#endif
+					    ) {
 						cipher_size = (op->sym->cipher.data.offset >> 3) +
 							(op->sym->cipher.data.length >> 3);
 					} else {
 						cipher_size = (op->sym->cipher.data.offset) +
 							(op->sym->cipher.data.length);
 					}
-					if (job->hash_alg == IMB_AUTH_ZUC_EIA3 ||
-						job->hash_alg == IMB_AUTH_SNOW3G_UIA2 ||
-#if IMB_VERSION(3, 0, 0) > IMB_VERSION_NUM
-						job->hash_alg == IMB_AUTH_ZUC256_EIA3 ||
+					if (job->hash_alg == IMB_AUTH_ZUC_EIA3
+						|| job->hash_alg == IMB_AUTH_SNOW3G_UIA2
+						|| job->hash_alg == IMB_AUTH_KASUMI_UIA1
+#if IMB_VERSION(3, 0, 0) <= IMB_VERSION_NUM
+						|| job->hash_alg == IMB_AUTH_SNOW5G_NIA4
+						|| job->hash_alg == IMB_AUTH_AES_NIA5
+						|| job->hash_alg == IMB_AUTH_ZUC_NIA6
+#else
+						|| job->hash_alg == IMB_AUTH_ZUC256_EIA3
 #endif
-						job->hash_alg == IMB_AUTH_KASUMI_UIA1) {
+					    ) {
 						auth_size = (op->sym->auth.data.offset >> 3) +
 							(op->sym->auth.data.length >> 3);
 					} else {
-- 
2.52.0

