Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE2C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:42:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90028427A1;
	Fri, 21 Feb 2025 18:42:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D2BED42686
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:42:03 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7h5q3005925;
 Fri, 21 Feb 2025 09:42:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 yoJSaoreeLXsUEnuvXJ4uvfMLfRbauJHCnDYjsZc9A=; b=EYToG8fyonVoXjcrK
 gTFFpuAIZbtGHmrrN30Ze/XhN615kCU/MUcq45nUFHlUEaCcmWFPjZk+VrXN9oX3
 SQkchGJVz4oXJ38J4WAJ/lnyi98V+Yqt4fCcEPWGQ5yjeyx94BR5Iq0TfUuXn9iF
 IG4MOL6/fCjXmlQmi9pYMsgrYieMLVmkKsSvv8uCjadv1uZKBwzX5toT5WGI610t
 3Q3UkcWf6yelsXtKspUqNsrbHND9G4gt6ucIUs6TVA9RDB+FhKs41Uskrp+CNBmx
 wpPnBm+/AzjESfMFlBO0IueeOP6P8shGNrm2hMrboVKnsPNai+bYW1r9ApJT5BqS
 Bh87g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgh5xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:42:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:42:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:42:00 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id E658A3F707A;
 Fri, 21 Feb 2025 09:41:57 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [v3 6/6] test/crypto: add tests for virtio user PMD
Date: Fri, 21 Feb 2025 23:11:16 +0530
Message-ID: <588565de4bf61dbb0068ff4098ac436d1cc3d90e.1740156584.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740156584.git.gmuthukrishn@marvell.com>
References: <cover.1740156584.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3-DzfVxvao0tYXLA71hJnhZQDm-c3lLT
X-Proofpoint-ORIG-GUID: 3-DzfVxvao0tYXLA71hJnhZQDm-c3lLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

Reuse virtio_crypto tests for testing virtio_crypto_user PMD.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev.c      |  7 +++++++
 app/test/test_cryptodev.h      |  1 +
 app/test/test_cryptodev_asym.c | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 441ecc6ad5..60aacdc155 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -19737,6 +19737,12 @@ test_cryptodev_virtio(void)
 	return run_cryptodev_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_PMD));
 }
 
+static int
+test_cryptodev_virtio_user(void)
+{
+	return run_cryptodev_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
+}
+
 static int
 test_cryptodev_aesni_mb(void)
 {
@@ -20074,6 +20080,7 @@ REGISTER_DRIVER_TEST(cryptodev_dpaa_sec_autotest, test_cryptodev_dpaa_sec);
 REGISTER_DRIVER_TEST(cryptodev_ccp_autotest, test_cryptodev_ccp);
 REGISTER_DRIVER_TEST(cryptodev_uadk_autotest, test_cryptodev_uadk);
 REGISTER_DRIVER_TEST(cryptodev_virtio_autotest, test_cryptodev_virtio);
+REGISTER_DRIVER_TEST(cryptodev_virtio_user_autotest, test_cryptodev_virtio_user);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_autotest, test_cryptodev_octeontx);
 REGISTER_DRIVER_TEST(cryptodev_caam_jr_autotest, test_cryptodev_caam_jr);
 REGISTER_DRIVER_TEST(cryptodev_nitrox_autotest, test_cryptodev_nitrox);
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index bb54a33d62..f6c7478f19 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -64,6 +64,7 @@
 #define CRYPTODEV_NAME_MVSAM_PMD		crypto_mvsam
 #define CRYPTODEV_NAME_CCP_PMD		crypto_ccp
 #define CRYPTODEV_NAME_VIRTIO_PMD	crypto_virtio
+#define CRYPTODEV_NAME_VIRTIO_USER_PMD	crypto_virtio_user
 #define CRYPTODEV_NAME_OCTEONTX_SYM_PMD	crypto_octeontx
 #define CRYPTODEV_NAME_CAAM_JR_PMD	crypto_caam_jr
 #define CRYPTODEV_NAME_NITROX_PMD	crypto_nitrox_sym
diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index ac47be724f..a98e3dc824 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -4118,9 +4118,24 @@ test_cryptodev_virtio_asym(void)
 	return unit_test_suite_runner(&cryptodev_virtio_asym_testsuite);
 }
 
+static int
+test_cryptodev_virtio_user_asym(void)
+{
+	gbl_driver_id = rte_cryptodev_driver_id_get(
+			RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
+	if (gbl_driver_id == -1) {
+		RTE_LOG(ERR, USER1, "virtio user PMD must be loaded.\n");
+		return TEST_FAILED;
+	}
+
+	/* Use test suite registered for crypto_virtio_user PMD */
+	return unit_test_suite_runner(&cryptodev_virtio_asym_testsuite);
+}
+
 REGISTER_DRIVER_TEST(cryptodev_openssl_asym_autotest, test_cryptodev_openssl_asym);
 REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_asym_autotest, test_cryptodev_cn9k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
+REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
-- 
2.25.1

