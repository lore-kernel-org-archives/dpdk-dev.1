Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F462C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B48CC40649;
	Wed,  2 Apr 2025 16:13:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 94EB140616
 for <dev@dpdk.org>; Wed,  2 Apr 2025 16:13:00 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CkCO6005120
 for <dev@dpdk.org>; Wed, 2 Apr 2025 07:12:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 6kNZDEgq7UZe/47m9CZne3EwhiuIvMJBbyrYynkPro=; b=KaJEPb2f0Ky6yyQYg
 VAupthpl5oCi2TrjbcpbrVPTj0FwZBd2vulctnDtFnEanDXq8hDLFGT/MpQT4pRT
 CGOp9dYjLVBtNOYIVfEw8tyo67EqkVrWY6Y7UGc3a12SwQxBNh+JWEYtSvQoJ/Ev
 7Z+bvnx599nXHQkm2sTeg4Rz8hPs04c3WGrWSBLd/KPcZuJlA46NeabPIylyKTx0
 BhZs53Un8E3+7qSF2N4vLk/KrE9981TLC5yax5hb/uhEZN90L3OxsSFEPIR340IF
 k860nKuOoblyBKcY9BDltkEz9hYZpXgY4kozLNNAAiweaunWYoRAIp8lzBan4x8D
 gCddQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45s5h5086g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 02 Apr 2025 07:12:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Apr 2025 07:12:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Apr 2025 07:12:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 1FB335E687C;
 Wed,  2 Apr 2025 07:12:42 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 2/3] common/cnxk: update cn20k part numbers
Date: Wed, 2 Apr 2025 19:42:27 +0530
Message-ID: <20250402141228.3773691-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402141228.3773691-1-rbhansali@marvell.com>
References: <20250321100343.1081664-1-rbhansali@marvell.com>
 <20250402141228.3773691-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0R7hxn9u_Uw2l0EM9c6qayhqZt6FkXAV
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67ed45e8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=eOnVWreZ_NyDHwaek8EA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0R7hxn9u_Uw2l0EM9c6qayhqZt6FkXAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
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

- Update cn20k part number
- Add cnf205 support
- Add APIs for respective cn20k models

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
Signed-off-by: Harman Kalra <hkalra@marvell.com>
---
Changes in v2: No change

 drivers/common/cnxk/roc_constants.h |  4 ++--
 drivers/common/cnxk/roc_model.c     |  4 +++-
 drivers/common/cnxk/roc_model.h     | 28 +++++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_constants.h b/drivers/common/cnxk/roc_constants.h
index ac492651de..795869c9df 100644
--- a/drivers/common/cnxk/roc_constants.h
+++ b/drivers/common/cnxk/roc_constants.h
@@ -66,8 +66,8 @@
 #define PCI_SUBSYSTEM_DEVID_CN10KB  0xBD00
 #define PCI_SUBSYSTEM_DEVID_CNF10KB 0xBC00

-#define PCI_SUBSYSTEM_DEVID_CN20KA 0xA020
-#define PCI_SUBSYSTEM_DEVID_CNF20KA 0xA000
+#define PCI_SUBSYSTEM_DEVID_CN20KA 0xC220
+#define PCI_SUBSYSTEM_DEVID_CNF20KA 0xC200

 #define PCI_SUBSYSTEM_DEVID_CN9KA  0x0000
 #define PCI_SUBSYSTEM_DEVID_CN9KB  0xb400
diff --git a/drivers/common/cnxk/roc_model.c b/drivers/common/cnxk/roc_model.c
index 6289461db4..f0312a5400 100644
--- a/drivers/common/cnxk/roc_model.c
+++ b/drivers/common/cnxk/roc_model.c
@@ -18,7 +18,8 @@ struct roc_model *roc_model;
 #define SOC_PART_CN10K 0xD49
 #define SOC_PART_CN20K 0xD8E

-#define PART_206xx  0xA0
+#define PART_206xx  0xC2
+#define PART_205xxN 0xC3
 #define PART_106xx  0xB9
 #define PART_105xx  0xBA
 #define PART_105xxN 0xBC
@@ -62,6 +63,7 @@ static const struct model_db {
 	char name[ROC_MODEL_STR_LEN_MAX];
 } model_db[] = {
 	{VENDOR_ARM, PART_206xx, 0, 0, ROC_MODEL_CN206xx_A0, "cn20ka_a0"},
+	{VENDOR_ARM, PART_205xxN, 0, 0, ROC_MODEL_CNF205xxN_A0, "cnf20ka_a0"},
 	{VENDOR_ARM, PART_106xx, 0, 0, ROC_MODEL_CN106xx_A0, "cn10ka_a0"},
 	{VENDOR_ARM, PART_106xx, 0, 1, ROC_MODEL_CN106xx_A1, "cn10ka_a1"},
 	{VENDOR_ARM, PART_106xx, 1, 0, ROC_MODEL_CN106xx_B0, "cn10ka_b0"},
diff --git a/drivers/common/cnxk/roc_model.h b/drivers/common/cnxk/roc_model.h
index 0de141b0cc..38001a3a23 100644
--- a/drivers/common/cnxk/roc_model.h
+++ b/drivers/common/cnxk/roc_model.h
@@ -37,6 +37,7 @@ struct roc_model {
 #define ROC_MODEL_CNF105xxN_B0 BIT_ULL(27)
 /* CN20k Models*/
 #define ROC_MODEL_CN206xx_A0   BIT_ULL(40)
+#define ROC_MODEL_CNF205xxN_A0 BIT_ULL(41)

 /* Following flags describe platform code is running on */
 #define ROC_ENV_HW   BIT_ULL(61)
@@ -75,7 +76,8 @@ struct roc_model {

 /* CN20K models */
 #define ROC_MODEL_CN206xx   (ROC_MODEL_CN206xx_A0)
-#define ROC_MODEL_CN20K     (ROC_MODEL_CN206xx)
+#define ROC_MODEL_CNF205xxN (ROC_MODEL_CNF205xxN_A0)
+#define ROC_MODEL_CN20K     (ROC_MODEL_CN206xx | ROC_MODEL_CNF205xxN)

 /* Runtime variants */
 static inline uint64_t
@@ -320,6 +322,30 @@ roc_model_is_cn10kb(void)
 	return roc_model->flag & ROC_MODEL_CN103xx;
 }

+static inline uint64_t
+roc_model_is_cn20ka(void)
+{
+	return roc_model->flag & ROC_MODEL_CN206xx;
+}
+
+static inline uint64_t
+roc_model_is_cn20ka_a0(void)
+{
+	return roc_model->flag & ROC_MODEL_CN206xx_A0;
+}
+
+static inline uint64_t
+roc_model_is_cnf20ka(void)
+{
+	return roc_model->flag & ROC_MODEL_CNF205xxN;
+}
+
+static inline uint64_t
+roc_model_is_cnf20ka_a0(void)
+{
+	return roc_model->flag & ROC_MODEL_CNF205xxN_A0;
+}
+
 static inline bool
 roc_env_is_hw(void)
 {
--
2.25.1

