Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01520CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 05:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70BF54042C;
	Thu, 21 Aug 2025 07:25:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1706F402F1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 07:24:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oR1F008568;
 Wed, 20 Aug 2025 22:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 lAcF1l2Ftm2zTZ4UIlnO4BDvNkxkVVgJXuuTqY422Y=; b=LsGZj/DX1kIxwQ0TW
 KkM0M8guV1rISpGVs7+c/YD11KK/hRs0yEJgdf7U5UpwuzGOmgsLx4HyBskP5+Sa
 MKU2jiLL97asH74Hy3JShHveohxfopjaUZhfIJWGZ61GrPdFU5SBfYmIJ5MJ+1U4
 1xW3SoDG/dWINSjWWqWtBHESi/UU0QIvCMe+bjd00kCbbtLnb6DxY9oRaZJ2qKZN
 9o3/6N40w2FbXSujov0YVhgQWCHFwTCtkdKxyL/WoY5v5iZKJO73KH7pxyWgI/T0
 m6woWdAWAjn8eIewDS80hYuy8PM2vqe+38d8GEDQ+9LDsE4tOoFoM86sUo6LVe6X
 Wi6mQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nhhr9rrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 22:24:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 22:25:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 22:25:01 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id DCF713F70D1;
 Wed, 20 Aug 2025 22:24:54 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <kai.ji@intel.com>,
 "Sucharitha Sarananaga" <ssarananaga@marvell.com>
Subject: [PATCH 1/2] app/test-crypto-perf: validate rsa modlen
Date: Thu, 21 Aug 2025 05:24:39 +0000
Message-ID: <20250821052440.3213146-2-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821052440.3213146-1-ssarananaga@marvell.com>
References: <20250821052440.3213146-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0MCBTYWx0ZWRfX1RQEMkMPguc+
 07B1Wh6FjYp/YkgnrxbemZ6vbeGok3f15TbCkfN/QF49cG0HGJzy4NPkRULFw28FREah4iU9QCB
 P2kg0OcwtRXiH4S63TUdnnkdNLzNY1HHwEHG3x79NL5rujFc28UFO0W9q1r0ZHEmjuJiVx1CeSQ
 QfxbDdSr/c3Xc+A3H5XO/iljWP1LEtZyRIT8lGo7ARbJktJyEn+T8NK45OQcSAvTNNzxsdj5QhL
 4YtHfIQH32mJoxuUGA2uH7br8xGtkH/1V9ilAf0N/dVn4MKcQUI2RqEtcMviKN4FCArsitXOCjA
 mQ+NX7Dv78FlrnAUcmh1e5ezFyAlzg8ua3tGffOH30Nqt2w6C5VOP/D4Oj0xd7CceNFSdJCIHv8
 z1OI1wT9Vv0TjaYqlLD6pF76YKiM4Tc0I/sGELMT7oXMuI9aocXV1QHxkHGQVa33VQT5x1sw
X-Proofpoint-ORIG-GUID: De8n5NgIy-E4wzs-YQSfpziDLrJAOzg2
X-Authority-Analysis: v=2.4 cv=L/REg+T8 c=1 sm=1 tr=0 ts=68a6adaa cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=itTyZKA4Z0XqldtZzf4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: De8n5NgIy-E4wzs-YQSfpziDLrJAOzg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

