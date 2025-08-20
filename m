Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20BCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 18:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B7A402B1;
	Wed, 20 Aug 2025 20:37:00 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0C89C40292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 20:36:58 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KI1tBw009669;
 Wed, 20 Aug 2025 11:36:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rlAcF1l2Ftm2zTZ4UIlnO4B
 DvNkxkVVgJXuuTqY422Y=; b=O3JNH/0jSYRo28zskTpmd3+qnD3L7NP7sK+aCMY
 qpta8MFxrLzB5DX/3lbFdwB4+n0BKOVJFdtvhfBga2miPjgDl47hsbV4eqdVPrEN
 1KKk6PhzBDO47GfwYyM7YbTENcmicBLX9/vQar93sMsuTV2bHeXKcUVSRBfAsqEv
 a4A/LSUiL94CjkVriBy2+k/3752BdT2Igez1/DHqLMra65SYojXNghBD7Q8tA9Zh
 zA01w1ZUCKQJZ2ItWlOa6FfqBergwKQvnA7VZsWN4EczKNquf2Dz0IIqrxBZVAG9
 QI9czzb3fXEc5E7yak755OTJCw9YgkjuURltmBOhdgFEKOA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nk9m03vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 11:36:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 11:37:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 11:37:00 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id CEBC25B692A;
 Wed, 20 Aug 2025 11:36:54 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <kai.ji@intel.com>,
 "Sucharitha Sarananaga" <ssarananaga@marvell.com>
Subject: [PATCH] app/test-crypto-perf: validate rsa modlen
Date: Wed, 20 Aug 2025 18:36:41 +0000
Message-ID: <20250820183641.3127975-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2zj7DQdxSOJ7nMpjuSuZkVvRr7Ez7q3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDE2MyBTYWx0ZWRfX4LsjODaGh0mp
 QXdBWn1ef5ONoSKePYUp5BQFEk7dx5Wqf3AbLma60fhGuy+HbfTmAAQnhYkyHxMVt+mVn+d7gIV
 5Ab6IeJp01EdhMKq7bRKpGAmS7RPy0e26U2e+hfgrNNfrVEt9mnUyoUcgt1MC3DluycXuqZOilp
 FrD01gmAXoxegPjFVCIam6slb5M3zWKJWWLZeB4WQIdRjqmDgc9+Pm0Jf6h+DMY9BPvVZo3+HK9
 gPFLjSmrkSYHruGqIDLe4+zgIGm1NS0wjXhwlgOwiLGIrUNDjI0FjLtQsOpXYZx9ajoxrpesJLN
 BQ0EBtfoRlA5RpuT2uyqcu2p3/nPoExKnEOhM3treyjpNvDkvd0ygatoo3uiyJCJMTwEjXUYFpu
 j0vq06aP6ZDgeaytpegdPO3srN43wVD5eswqJQhK1Ruu8pZjHHH4urMfB424TKuYpqXURA2g
X-Authority-Analysis: v=2.4 cv=XJ9piQhE c=1 sm=1 tr=0 ts=68a615ca cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=itTyZKA4Z0XqldtZzf4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2zj7DQdxSOJ7nMpjuSuZkVvRr7Ez7q3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
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

Added a check to verify that user configured modlen supported
or not.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 app/test-crypto-perf/cperf_options_parsing.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 0e0dc4fd06..0c7c57ce42 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1361,6 +1361,7 @@ is_valid_chained_op(struct cperf_options *options)
 int
 cperf_options_check(struct cperf_options *options)
 {
+	uint16_t modlen;
 	int i;
 
 	if (options->op_type == CPERF_CIPHER_ONLY ||
@@ -1557,8 +1558,6 @@ cperf_options_check(struct cperf_options *options)
 	}
 
 	if (options->rsa_modlen) {
-		uint16_t modlen = options->rsa_modlen / 8;
-
 		if (options->op_type != CPERF_ASYM_RSA) {
 			RTE_LOG(ERR, USER1, "Option rsa-modlen should be used only with "
 					" optype: rsa.\n");
@@ -1567,7 +1566,8 @@ cperf_options_check(struct cperf_options *options)
 
 		if (options->rsa_keytype == RTE_RSA_KEY_TYPE_QT) {
 			for (i = 0; i < (int)RTE_DIM(rsa_qt_perf_data); i++) {
-				if (rsa_qt_perf_data[i].n.length == modlen) {
+				modlen = rsa_qt_perf_data[i].n.length * 8;
+				if (options->rsa_modlen == modlen) {
 					options->rsa_data =
 						(struct cperf_rsa_test_data *)&rsa_qt_perf_data[i];
 					break;
@@ -1582,7 +1582,8 @@ cperf_options_check(struct cperf_options *options)
 			}
 		} else if (options->rsa_keytype == RTE_RSA_KEY_TYPE_EXP) {
 			for (i = 0; i < (int)RTE_DIM(rsa_exp_perf_data); i++) {
-				if (rsa_exp_perf_data[i].n.length == modlen) {
+				modlen = rsa_exp_perf_data[i].n.length * 8;
+				if (options->rsa_modlen == modlen) {
 					options->rsa_data =
 						(struct cperf_rsa_test_data *)&rsa_exp_perf_data[i];
 					break;
@@ -1597,7 +1598,8 @@ cperf_options_check(struct cperf_options *options)
 			}
 		} else {
 			for (i = 0; i < (int)RTE_DIM(rsa_pub_perf_data); i++) {
-				if (rsa_pub_perf_data[i].n.length == modlen) {
+				modlen = rsa_pub_perf_data[i].n.length * 8;
+				if (options->rsa_modlen == modlen) {
 					options->rsa_data =
 						(struct cperf_rsa_test_data *)&rsa_pub_perf_data[i];
 					break;
-- 
2.49.0

