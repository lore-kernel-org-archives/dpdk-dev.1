Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C90C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 06:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79EED4065C;
	Wed,  5 Mar 2025 07:16:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0653940651
 for <dev@dpdk.org>; Wed,  5 Mar 2025 07:16:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253TLLL029259;
 Tue, 4 Mar 2025 22:16:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 tC1CcNzEtbFnZ4eGjIdYsY9jub3AI1VhHiRVD0ur9c=; b=KJa4hcaDYZpqiqdcI
 sK3685FjdDwaGXfSBu5KQrSVU49XCdPo7PkuTgF2LfHDboQ6t9/QGtFM21vs+KsO
 5ZUDSNPotj385i84hCwtytyRojQCFnypErueTL51V0xtHt6oOSo2s2eGXhxnGMXZ
 rlfOMFmOkKNlFl96LIRNtm8oIsBOb8VhIUrBAIX7nwq91Av9VAUc34qCYaqxIQ7y
 ex8Q6hb2acIcLDH2/wF5fn0x2oi1QyvTjaTk9nJ0oUrRZKIGq6tT3WtfdXC5XJGw
 PMzvwbDDHpu03bg6QlPxghVClMhC9eP6ND4EuSxP/uFqjod86on6/sqKhui1y5dX
 SxyNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 456er1r8ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 22:16:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Mar 2025 22:16:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Mar 2025 22:16:49 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.23.41])
 by maili.marvell.com (Postfix) with ESMTP id 929773F705F;
 Tue,  4 Mar 2025 22:16:47 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [v6 5/6] test/crypto: add asymmetric tests for virtio PMD
Date: Wed, 5 Mar 2025 11:46:13 +0530
Message-ID: <bfeababebd15a8a1993a92d813e67c2b316022dc.1741154953.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1741154953.git.gmuthukrishn@marvell.com>
References: <cover.1741154953.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j5puWeAAUqrjS-331D__8c_DVVLIqMX_
X-Proofpoint-ORIG-GUID: j5puWeAAUqrjS-331D__8c_DVVLIqMX_
X-Authority-Analysis: v=2.4 cv=TrcchCXh c=1 sm=1 tr=0 ts=67c7ec52 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=_lqa3q-sRepcItQcJYMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
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

Add asymmetric tests for Virtio PMD.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 9b5f3c545e..ac47be724f 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -4023,6 +4023,19 @@ static struct unit_test_suite cryptodev_octeontx_asym_testsuite  = {
 	}
 };
 
+static struct unit_test_suite cryptodev_virtio_asym_testsuite  = {
+	.suite_name = "Crypto Device VIRTIO ASYM Unit Test Suite",
+	.setup = testsuite_setup,
+	.teardown = testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_capability),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
+				test_rsa_sign_verify_crt),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_rsa_enc_dec_crt),
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
 static int
 test_cryptodev_openssl_asym(void)
 {
@@ -4091,8 +4104,23 @@ test_cryptodev_cn10k_asym(void)
 	return unit_test_suite_runner(&cryptodev_octeontx_asym_testsuite);
 }
 
+static int
+test_cryptodev_virtio_asym(void)
+{
+	gbl_driver_id = rte_cryptodev_driver_id_get(
+			RTE_STR(CRYPTODEV_NAME_VIRTIO_PMD));
+	if (gbl_driver_id == -1) {
+		RTE_LOG(ERR, USER1, "virtio PMD must be loaded.\n");
+		return TEST_FAILED;
+	}
+
+	/* Use test suite registered for crypto_virtio PMD */
+	return unit_test_suite_runner(&cryptodev_virtio_asym_testsuite);
+}
+
 REGISTER_DRIVER_TEST(cryptodev_openssl_asym_autotest, test_cryptodev_openssl_asym);
 REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_asym_autotest, test_cryptodev_cn9k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
+REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
-- 
2.25.1

