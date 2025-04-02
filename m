Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46538C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:12:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7851A40273;
	Wed,  2 Apr 2025 16:12:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DD96540261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 16:12:39 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5327RmIt014594
 for <dev@dpdk.org>; Wed, 2 Apr 2025 07:12:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 lTrpLrLhmElm+Unqs6AFCtHfyZjPyxFW6rvvN+DSSM=; b=P5n0GPcdUD8ICy//p
 Aq3hIwqv4EZjz+7INNZmybFWB3t3JmNGj5cgAC2bTmy68vlXr7nmlLBJzxmpdRkt
 JQKbHPoGUCXL2XJWchHkfeCfL1eDCh2p+LQpjd8pVgw2xxEr5LQFgdOy9z9s4e6u
 X0lBG30DJtsGhw33A1EIgiFbHYtDnrBJmPwhK/gO2F6vCA6JMHljDddMWwEPCfqC
 +yh2N/L6UB2GDln4DyEGfBLC9+UWryX25EsI1Mg/JbXNdpf2Z1qgvHBioNW0vIlo
 Fp/A5HukQ2C8HOZQTD4gQfqwOka2BbG0oQEATPcNzvuhedfWeuzx+rV5sdxBpY/L
 shaog==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45s0v50xc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 02 Apr 2025 07:12:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Apr 2025 07:12:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Apr 2025 07:12:37 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 1B6DA5E687A;
 Wed,  2 Apr 2025 07:12:34 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 1/3] common/cnxk: update steer rule mbox for cn20k
Date: Wed, 2 Apr 2025 19:42:26 +0530
Message-ID: <20250402141228.3773691-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321100343.1081664-1-rbhansali@marvell.com>
References: <20250321100343.1081664-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lsJR0kisnikWsJZnCS7UDPEW_tpRtBd8
X-Proofpoint-ORIG-GUID: lsJR0kisnikWsJZnCS7UDPEW_tpRtBd8
X-Authority-Analysis: v=2.4 cv=GOkIEvNK c=1 sm=1 tr=0 ts=67ed45d7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=gouDKTRxnr5h6Y9tlkAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Updated mbox npc_cn20k_read_base_steer_rule for cn20k.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change

 drivers/common/cnxk/roc_npc.c      | 3 ++-
 drivers/common/cnxk/roc_npc_mcam.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 3fd59667d8..1f2461e026 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -1921,11 +1921,11 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 		goto exit;
 	}

-	(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 	if (roc_model_is_cn20k()) {
 		struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
 		struct cn20k_mcam_entry *base_entry;

+		(void)mbox_alloc_msg_npc_cn20k_read_base_steer_rule(mbox);
 		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 		if (rc) {
 			plt_err("Failed to fetch VF's base MCAM entry");
@@ -1941,6 +1941,7 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 		struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 		struct mcam_entry *base_entry;

+		(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 		if (rc) {
 			plt_err("Failed to fetch VF's base MCAM entry");
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index a9b923d31c..286cfd2dbd 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -1314,11 +1314,11 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 			mbox = mbox_get(pst->flow->rep_mbox);
 		else
 			mbox = mbox_get(npc->mbox);
-		(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 		if (roc_model_is_cn20k()) {
 			struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
 			struct cn20k_mcam_entry *base_entry;

+			(void)mbox_alloc_msg_npc_cn20k_read_base_steer_rule(mbox);
 			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 			if (rc) {
 				mbox_put(mbox);
@@ -1336,6 +1336,7 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 			struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 			struct mcam_entry *base_entry;

+			(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
 			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
 			if (rc) {
 				mbox_put(mbox);
--
2.25.1

