Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09250C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B676240E34;
	Mon, 24 Feb 2025 10:54:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 376E840E17
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:49 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKP001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 /o0olEPM/5W0enuR2XND/cer6kuqACn6Hca/SeiXVQ=; b=Am77eXZpsowO71gqA
 rvYMHHxt7yuilkauCAyOPzIMYI47GU4vkz1Xpel0448WiiTGD17cBz4EQNL9LHN9
 shUtro8fWEJ/t05Fw9N6D508Wxmy9Fk0E1PdHXE1rsIvwfZ+SjOk2M3M8YhLtUpN
 iuVQ1sygLZPigkV3t2/IzbMMcBiXGxd6u5x52A/NPxaqe1aggce2EBmmEDcb8oDP
 q3A9OaD5vXDTejnL+/jBsLvGqbcFyAM1AT9hTX1Ng1/aLb/rqNPskgMexr0/gxTH
 Rc7jbo8Gf9uN/mUP1e9LL1Qnto67sBMoOaZpeK+KymnHcnNsOFQiRU2oJco7m90g
 +I8kg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh3c-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:53:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:53:18 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B3ED23F7068;
 Mon, 24 Feb 2025 01:53:15 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 05/33] common/cnxk: add cn20k CPT result struct
Date: Mon, 24 Feb 2025 15:22:13 +0530
Message-ID: <20250224095241.1263700-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tIizFgKmr1ZHMmviOZVF65dNo29CMTXD
X-Proofpoint-ORIG-GUID: tIizFgKmr1ZHMmviOZVF65dNo29CMTXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Anoob Joseph <anoobj@marvell.com>

CPT result structure is same as in cn10k. Add entry for cn20k.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index 47df3fbf9f..b308a18f0d 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -289,6 +289,16 @@ struct cpt_inst_s {
 };
 
 union cpt_res_s {
+	struct cpt_cn20k_res_s {
+		uint64_t compcode : 7;
+		uint64_t doneint : 1;
+		uint64_t uc_compcode : 8;
+		uint64_t rlen : 16;
+		uint64_t spi : 32;
+
+		uint64_t esn;
+	} cn20k;
+
 	struct cpt_cn10k_res_s {
 		uint64_t compcode : 7;
 		uint64_t doneint : 1;
-- 
2.34.1

