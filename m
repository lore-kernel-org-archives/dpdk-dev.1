Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02105C87FCA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 02:51:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB21340668;
	Wed, 30 Jul 2025 04:51:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 038E64025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 04:51:20 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U0JtHf029441
 for <dev@dpdk.org>; Tue, 29 Jul 2025 19:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=xzyp3SnwZETf3eUzLMUqQ5y
 KPV37kLPozO8duKU2P2U=; b=bo7DRRa02SNDMpuUPi21vkBh8wBEju7B0zIyJR4
 2uoaKsVrl2eP1ZDEKTxxms+CQ00sxySYsIMBzim+lpRremRUgfRVSvntK4kJ4ImV
 c4/SKHBdYhg5KpW2zxSsbsOejPE0OH7o/gFfH3LqgZhYLHt/Wz4B5PvSSlo2B4TG
 H488ZW71ljpK1y4Ck++73UgrjzeILR5QDGO3O2gq8z/dYOKGe2B8rp7+MEQZ+eoh
 Adqc1qInhU87yqlLs8QCh4WBu/9SmwDWSmFaewGNkZS9FTOI6UVa90REOSRW0NF0
 0+IaCEEIPLMomZoWix5/W0WjQmF3v0ikmUqZDZ4tYxWQDig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4878rkg86a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 29 Jul 2025 19:51:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Jul 2025 19:51:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Jul 2025 19:51:20 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id CCFAF3F7076;
 Tue, 29 Jul 2025 19:51:15 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Tomasz Duszynski <tduszynski@marvell.com>, "Jakub
 Palider" <jpalider@marvell.com>
Subject: [PATCH] common/cnxk: fix async event handling
Date: Wed, 30 Jul 2025 04:51:09 +0200
Message-ID: <20250730025109.1245119-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuTmhCXh c=1 sm=1 tr=0 ts=688988a8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=__TBFzwBZkx7eBeauIcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: oaXNlH6tRjvCAVPeVR-eUHntWfSFZOR1
X-Proofpoint-GUID: oaXNlH6tRjvCAVPeVR-eUHntWfSFZOR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAxOSBTYWx0ZWRfX6qkWd9JbO6I2
 d9yzUXwCE3HVPHSs7wMoBR//lprfB4YLolC6RLMmmdbsxAGsRMss84Xb+w64SLm3EHPkG96rYEX
 78x3Egfp6FiPq6gDIyV0mo3BFab9CoDZUlCWkFko1wStkIQcN1RF7+bBVOznbu7hST1vWJrZAHs
 rh7Kv/o1KlnLEdbduodHRvKbQfBOXIJc5AvbUBs6Txvc8kbgDubtS4ipjg0FD7fLvFXXXGcFBKU
 5aj+hsG39fEZA+Qwg8Cy29aFVjyMPbkUxvLhuDpQ2JEZ9qCo8YKN6T6KtqddjAciLnYxwiHakjY
 8hDnJmuEdWfZXC+WOBgm6+jOv9/JYm6iknlWqbwh1/hdtvXmfOmu8oxvDKPsJoy/zBO6tSc9lo5
 R0bXc327JSVIvnYryIxpIriGwCgJZQzf7YePKeyZqMcpHyVvF7wA/hhxWg5NK6EiL3BFhv9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_01,2025-07-28_01,2025-03-28_01
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

If async event shows up unexpectedly ack it and continue
until expected event is received.

Fixes: 857721d62d42 ("common/cnxk: add BPHY communication with atf")

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 drivers/common/cnxk/roc_bphy_cgx.c | 52 +++++++++++-------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/common/cnxk/roc_bphy_cgx.c b/drivers/common/cnxk/roc_bphy_cgx.c
index db70bafd9b..1de5195657 100644
--- a/drivers/common/cnxk/roc_bphy_cgx.c
+++ b/drivers/common/cnxk/roc_bphy_cgx.c
@@ -65,8 +65,7 @@ roc_bphy_cgx_ack(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
 }
 
 static int
-roc_bphy_cgx_wait_for_ownership(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
-				uint64_t *scr0)
+roc_bphy_cgx_wait_ack(struct roc_bphy_cgx *roc_cgx, unsigned int lmac, uint64_t *scr0, bool ack)
 {
 	int tries = 5000;
 	uint64_t scr1;
@@ -75,16 +74,18 @@ roc_bphy_cgx_wait_for_ownership(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
 		*scr0 = roc_bphy_cgx_read(roc_cgx, lmac, CGX_CMRX_SCRATCH0);
 		scr1 = roc_bphy_cgx_read(roc_cgx, lmac, CGX_CMRX_SCRATCH1);
 
-		if (FIELD_GET(SCR1_OWN_STATUS, scr1) == ETH_OWN_NON_SECURE_SW &&
-		    FIELD_GET(SCR0_ETH_EVT_STS_S_ACK, *scr0) == 0)
-			break;
-
 		/* clear async events if any */
-		if (FIELD_GET(SCR0_ETH_EVT_STS_S_EVT_TYPE, *scr0) ==
-		    ETH_EVT_ASYNC &&
-		    FIELD_GET(SCR0_ETH_EVT_STS_S_ACK, *scr0))
+		if (FIELD_GET(SCR0_ETH_EVT_STS_S_EVT_TYPE, *scr0) == ETH_EVT_ASYNC &&
+		    FIELD_GET(SCR0_ETH_EVT_STS_S_ACK, *scr0)) {
 			roc_bphy_cgx_ack(roc_cgx, lmac, scr0);
+			goto skip;
+		}
 
+		if (FIELD_GET(SCR1_OWN_STATUS, scr1) == ETH_OWN_NON_SECURE_SW &&
+		    FIELD_GET(SCR0_ETH_EVT_STS_S_ACK, *scr0) == ack)
+			break;
+
+skip:
 		plt_delay_ms(1);
 	} while (--tries);
 
@@ -92,29 +93,20 @@ roc_bphy_cgx_wait_for_ownership(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
 }
 
 static int
-roc_bphy_cgx_wait_for_ack(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
-			  uint64_t *scr0)
+roc_bphy_cgx_wait_for_ownership(struct roc_bphy_cgx *roc_cgx, unsigned int lmac, uint64_t *scr0)
 {
-	int tries = 5000;
-	uint64_t scr1;
-
-	do {
-		*scr0 = roc_bphy_cgx_read(roc_cgx, lmac, CGX_CMRX_SCRATCH0);
-		scr1 = roc_bphy_cgx_read(roc_cgx, lmac, CGX_CMRX_SCRATCH1);
-
-		if (FIELD_GET(SCR1_OWN_STATUS, scr1) == ETH_OWN_NON_SECURE_SW &&
-		    FIELD_GET(SCR0_ETH_EVT_STS_S_ACK, *scr0))
-			break;
-
-		plt_delay_ms(1);
-	} while (--tries);
+	return roc_bphy_cgx_wait_ack(roc_cgx, lmac, scr0, false);
+}
 
-	return tries ? 0 : -ETIMEDOUT;
+static int
+roc_bphy_cgx_wait_for_ack(struct roc_bphy_cgx *roc_cgx, unsigned int lmac, uint64_t *scr0)
+{
+	return roc_bphy_cgx_wait_ack(roc_cgx, lmac, scr0, true);
 }
 
 static int
-roc_bphy_cgx_intf_req(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
-		      uint64_t scr1, uint64_t *scr0)
+roc_bphy_cgx_intf_req(struct roc_bphy_cgx *roc_cgx, unsigned int lmac, uint64_t scr1,
+		      uint64_t *scr0)
 {
 	uint8_t cmd_id = FIELD_GET(SCR1_ETH_CMD_ID, scr1);
 	int ret;
@@ -142,12 +134,6 @@ roc_bphy_cgx_intf_req(struct roc_bphy_cgx *roc_cgx, unsigned int lmac,
 	if (cmd_id == ETH_CMD_INTF_SHUTDOWN)
 		goto out;
 
-	if (FIELD_GET(SCR0_ETH_EVT_STS_S_EVT_TYPE, *scr0) != ETH_EVT_CMD_RESP) {
-		plt_err("received async event instead of cmd resp event");
-		ret = -EIO;
-		goto out;
-	}
-
 	if (FIELD_GET(SCR0_ETH_EVT_STS_S_ID, *scr0) != cmd_id) {
 		plt_err("received resp for cmd %d expected for cmd %d",
 			(int)FIELD_GET(SCR0_ETH_EVT_STS_S_ID, *scr0), cmd_id);
-- 
2.34.1

