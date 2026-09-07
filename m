Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F7C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 888D7402E8;
	Mon,  7 Sep 2026 05:50:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F1CE4402C8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 05:50:39 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873lSus1929778; Sun, 6 Sep 2026 20:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rEfuGJmCNmo4wmJhCFp7R8e
 6QM2mhyd/gpur/USaTEY=; b=MtoKgQCPPWIsNJPaqJpIyczbexvD+hrtvRcJUqI
 6cw9ohy0EfB4jeeYk5qKNy553dp0EkefAfiG1UOZt/YaBtRbZZkApk/qmJ1VlvTa
 KAMskc5GPFKTzte5BrR7xZuvdCe5XStprJ+Av0B4xBLfBZlaUCai5xNycBqF2VIo
 YiVkw7Hx7zQOxvZlfpGLVflUOs7NgwKdFsDScBE5XgaoXTB9AYunzLgHqr7V1IUE
 juwHn/PaqbogT7sEw5Ty5ExPOTxuDjpzlb9/RmC/Dp4PZvVWamt7mHPHsqhbAVRr
 Zx78mrykar87WQnCO+PaPscsfcXkKETpQdVD7eHVHVkMQYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gggem3awf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 06 Sep 2026 20:50:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 20:50:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 20:50:37 -0700
Received: from cavium-System-Product-Name (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 4BD963F70A1;
 Sun,  6 Sep 2026 20:50:36 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH] app/testpmd: add size check for flex item
Date: Mon, 7 Sep 2026 09:20:33 +0530
Message-ID: <20260907035033.800034-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gLK-KBEEN2KBmt9xe8JteqtLAW4cTh-g
X-Proofpoint-GUID: gLK-KBEEN2KBmt9xe8JteqtLAW4cTh-g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzNyBTYWx0ZWRfXyPkhR3TJiuzq
 sukcfAIM0YyRsbvi/ET44e846027A2n1JQ6dkR23pfwxMN9D/N0uvVcBvjYWzHYNOA/ByQZQFnn
 F01bwZ5FENDtFG2jFTUc7rKmw9mveI9c7FdhvJ28kZe0zidDLiCHX0rbVABZwWe1IH3R7KagbO6
 j0rPnOoPi/d7CHENO+iDzC5nUStyGORu/uTzWxzRt7jDU4lBjqskQ3UNVaISK102kfSyKGZeWDp
 tfm5LZDfhxuIM5V2CFPO4K4zJC13bYNVeQtztkHCZntOErqQxnN8qs2sNQLycrEqT8rSx+OFavk
 r9rG1q31ulRrYSBCr7kp6puLT0dyfcRERcwy7etSuGwV0/cxkEdcVVjVUxVjFmnE9WrmTVUfAwW
 qvVeU+5qpbR27/zWqzF4UCoaBpydw52tFdWu0EGdMqIZBOMxlp55vouYnMnXG7BnNh8bZNPTD8T
 FSneyObVGebnxyZyiGA==
X-Authority-Analysis: v=2.4 cv=DIe/JSNb c=1 sm=1 tr=0 ts=6a9e348f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=e5QpUMbY7KBARxgit7cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzNyBTYWx0ZWRfX1Fv90SPmcw7b
 x1/QC5HlZclrVHiREE59K1PvHK6fyoR7Bf/1hwN7CbuRG+q6xV+5F1GpSBsfvXtYJKmFnr7qJ6B
 7nr0q5y6fgc3NPVBci2N6YUfRPb/IKM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

Adding changes for size check for flex item in testpmd.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 app/test-pmd/cmd_flex_item.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
index af6c087feb..c0bbff7b45 100644
--- a/app/test-pmd/cmd_flex_item.c
+++ b/app/test-pmd/cmd_flex_item.c
@@ -231,6 +231,12 @@ static int flex_item_config(json_t *jroot,
 		} else if (match_strkey(key, "sample_data")) {
 			json_t *ji;
 			uint32_t i, size = json_array_size(jobj);
+			if (size > FLEX_ITEM_MAX_SAMPLES_NUM) {
+				printf("Number of sample_data entries (%u) exceeds maximum %u\n",
+				       size, FLEX_ITEM_MAX_SAMPLES_NUM);
+				ret = -EINVAL;
+				goto out;
+			}
 			for (i = 0; i < size; i++) {
 				ji = json_array_get(jobj, i);
 				ret = flex_field_parse
@@ -244,6 +250,12 @@ static int flex_item_config(json_t *jroot,
 		} else if (match_strkey(key, "input_link")) {
 			json_t *ji;
 			uint32_t i, size = json_array_size(jobj);
+			if (size > FLEX_ITEM_MAX_LINKS_NUM) {
+				printf("Number of input_link entries (%u) exceeds maximum %u\n",
+				       size, FLEX_ITEM_MAX_LINKS_NUM);
+				ret = -EINVAL;
+				goto out;
+			}
 			for (i = 0; i < size; i++) {
 				ji = json_array_get(jobj, i);
 				ret = flex_link_parse(ji,
@@ -258,6 +270,12 @@ static int flex_item_config(json_t *jroot,
 		} else if (match_strkey(key, "output_link")) {
 			json_t *ji;
 			uint32_t i, size = json_array_size(jobj);
+			if (size > FLEX_ITEM_MAX_LINKS_NUM) {
+				printf("Number of output_link entries (%u) exceeds maximum %u\n",
+				       size, FLEX_ITEM_MAX_LINKS_NUM);
+				ret = -EINVAL;
+				goto out;
+			}
 			for (i = 0; i < size; i++) {
 				ji = json_array_get(jobj, i);
 				ret = flex_link_parse
-- 
2.50.1

