Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE987CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DBF34060C;
	Tue, 23 Jun 2026 06:27:32 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 505304014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:27:30 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0fuUF2831788; Mon, 22 Jun 2026 21:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 Ub9c6x4omiODLp05nOyk08ZQFZd5iOfFEbKNg8akjU=; b=XlWnK4el70a2FBffV
 L730ZGW3ntO5ISOQEIeXIBoSvMC1v4YpdH4uKpoa59kyCIGzBp2K6n1KWT8C2YDJ
 OV2XicQSzeDDeCbEoE+COpYAA+bi/p61W1iCk43H+NvsVsW9ze8iNuskjnehvQq3
 JJR7JregjyNiqw9IxUbsy3lNew53oJIfjhfIiigeU2o6Jj50W790Oy0PqKibzb3Y
 jiEGwH7OPOdKFeBxMbTl9zODmIlF+rcXrA1feYqScFNcE3mwcEYK/BXODpP2/7Bm
 oSfe9ZWzr5j2XvUF2onLKir4gZT/eSDDeVHU6P8gnySLZ4Amns6j4YfXKp8T2BgG
 N8DJg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48wnbs-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 21:27:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:27:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:27:28 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A26863F708D;
 Mon, 22 Jun 2026 21:27:26 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 1/3] test/crypto: add asym autotest support for cn20k
Date: Tue, 23 Jun 2026 09:57:21 +0530
Message-ID: <20260623042723.89226-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623042723.89226-1-ktejasree@marvell.com>
References: <20260623042723.89226-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FpDbs95LCHSklZTb25jgN8cRMWOOiEND
X-Proofpoint-GUID: FpDbs95LCHSklZTb25jgN8cRMWOOiEND
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX/vAGAf1cSatO
 6t7qBd9VdTuH3pJixSPHOPNiWtNULblhtFdflw6JrhmILS8/+X6XDhXd12MOJZPdy9NL4882BWT
 F8A9Z+SSwNtpqz93YjS0dGt4k+dAbHg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX4CD3uWzlku4A
 V5EFhojA48jaA7WsLIAOaBSML8ldtNutuk9QL5tF/no8SyGCS+fAcSeKAZ81LNtzFjSr2r5JcnK
 g6zDIDQzKZSISXdcVh6ijh+4YwxwuWOuQDD1gxLMB5R1OPR0Yb4I+p/yMW12ZPVcOJzC30uVINE
 OssrTo4HaDVeYgdRbCe+WLFY7YAzDL+Xwv/b8I/FaLDHEEHoz7lvUfIJDO0pTPMMs+MUaL523av
 9H9mjfrooocsg7Oqv3rnkzFf8TfgH1E11mFEgvAXi6MZsRL7N50ro1AFquCkU3aKQNgoCYT7HWC
 ShcnTBf5ba5ddce7PViw06eXC7o4hZI1iKgAVOkcMR6vbqEeytcyrhZwKADUOVkT1kvRNOXxsH1
 HPh3ZFQ+5Wnr0F56yhEWHcroyVv8Ov9truIcXxB6LdJnrU7mNmekac3mhdh9gpT3KUx+4ShQFy3
 XKwTvMknGN7H50o+4nQ==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a3a0b31 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=tE77Fx74zz6wD1elt1YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add crypto asym autotest support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 app/test/test_cryptodev_asym.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 90af49e485..7b8afe5f92 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -5500,6 +5500,12 @@ test_cryptodev_cn10k_asym(void)
 	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN10K_PMD));
 }
 
+static int
+test_cryptodev_cn20k_asym(void)
+{
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN20K_PMD));
+}
+
 static int
 test_cryptodev_virtio_asym(void)
 {
@@ -5517,5 +5523,6 @@ REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_asym_autotest, test_cryptodev_cn9k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
-- 
2.34.1

