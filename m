Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4BDC021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 09:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3554B42E63;
	Sat, 22 Feb 2025 10:17:35 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D822A42E4F
 for <dev@dpdk.org>; Sat, 22 Feb 2025 10:17:33 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M92cFV028821;
 Sat, 22 Feb 2025 01:17:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 tC1CcNzEtbFnZ4eGjIdYsY9jub3AI1VhHiRVD0ur9c=; b=Esh3qVe23FaSSMJQV
 52MrM68QaaHERfsbpMQJZimVD3iViJhJRpctn+hFjmrU0nbWOXPAanu8PhnKEt5U
 MwgreaVGmBJL/eY15Q9j/Agm/L/4JnNfeQcvyj+3FKOBp8QC/bjqWfDah6Q2A8Yh
 tHHy1HWEX90PZ1am7t/cWycclu7ebYa9/0OACifzSH5v9ILk2TsoNgOL9CysDDoq
 LfR7Ayl57wwg2QwlhFceNdHpUH7ZD7NqHZKn2qS2iT0ADc0sZrejQJbXBM8CSP/N
 ATd9tOb24o2My1ptsr+Gpl+FQc+HwLr31Yjo6zYrZi87Tj3IvTIxeylZs9LHJhAQ
 t4snw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgjfc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 01:17:33 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 01:17:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 01:17:31 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 212EB3F705E;
 Sat, 22 Feb 2025 01:17:27 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [v4 5/6] test/crypto: add asymmetric tests for virtio PMD
Date: Sat, 22 Feb 2025 14:46:54 +0530
Message-ID: <c124296e0810aadca8c9ed718f1fc14d1b657fa1.1740212415.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212415.git.gmuthukrishn@marvell.com>
References: <cover.1740212415.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qc6OvBDMeS--P9QFtlALkQsOv6Gm78Pl
X-Proofpoint-ORIG-GUID: qc6OvBDMeS--P9QFtlALkQsOv6Gm78Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
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

