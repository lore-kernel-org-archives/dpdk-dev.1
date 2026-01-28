Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503BAD3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83BEF40665;
	Wed, 28 Jan 2026 07:04:46 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 856E040665
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:44 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RNTYtN379905 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 wto0WFpd7ZIhiUp9jjNcnx6ysqv+l4PU5MvO3hbhlk=; b=gp9v6Ux05hobXDRt0
 9CikunFSXmA173G8kWh2cffzze1HPfPleeTAUxxEZ99flHIpFqd7B3HV78fCDDP3
 OCuNmNNir/MX6+8rpWvwrhDwqxdi3Y4Ej4Kn+RQw4miKLbGevI1trbYxrpmKNkhh
 5FJmeU8MNVTNHl5Vxmq4SkRIxy2psDmiCqUIl+z3J2MO8/rlSkr+5WeqTtjJ4eSQ
 eLnS+9u76ZxvtZ8YIcSIeyg58iHloPNt0KIhEq9RxlZUGm5apinzTjGPhTfYHQ1b
 UxzElBKfeGk4aOewR3xyYRM/xkurNSFdxAB0U+TYro/xdOoR6ofPAFDIA8WmJLWp
 uTXQg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjqsjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:42 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 4C36C3F707C;
 Tue, 27 Jan 2026 22:04:40 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 14/18] common/cnxk: flow rule config for non-inplace
Date: Wed, 28 Jan 2026 11:33:12 +0530
Message-ID: <20260128060316.3967610-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HUvG1o58dGGoZccbbYo5isGPG6mfprr6
X-Proofpoint-ORIG-GUID: HUvG1o58dGGoZccbbYo5isGPG6mfprr6
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=6979a6fb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=K_8k4m82OxwhjqIea58A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX12zqpFg6MQKQ
 feW69ymkx93UqwEkIw/QC05xTOjmHvYS6SgscUUfRhhWLrak5SKzYsqSlnNEIuRqpx6oT5HbKG2
 pQUxGkTypcsz7bgekXfJzLma7tOlTZ+DUHVXnVx+POZAybWTwgQD4Asb4S5gHfl+RWUynBR+ERw
 oxitgKHj0ptslUuTyX4Duc/ZRB4AZE/gg4WsKY+09zeTmm8/wWnknVW9rco+1+8Eb0xcvn191lK
 ZIWhfZGsgIOBr5Kf4RwoINVvMMi8tc8VYJFKnXnPMei2ceU/ZAWS0RCnaArNHel6VWjLNgIrwVd
 cFI+9KzmKhHocCR6SlfOQtlOFm6V29C4fq04yZAvWrl2DiGIx9VH9Jimux6g520SfO5FDxR9Ois
 POeHChaiPKe6v6GFpsA/4sBDgz0RMWCXrdinzvDtgmoPXPOoOL0VZeay+AJBkU60d3WsS4h2kcn
 r/PzulqtmEJ0mhwvaNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Adds flow rule for non-inplace security action
configuration

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_npc.c | 13 ++++++++++++-
 drivers/common/cnxk/roc_npc.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 7846913417..acf0007e05 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -613,10 +613,12 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 	const struct roc_npc_action_mark *act_mark;
 	const struct roc_npc_action_meter *act_mtr;
 	const struct roc_npc_action_queue *act_q;
+	const struct roc_npc_sec_action *sec_act;
 	const struct roc_npc_action_vf *vf_act;
 	uint8_t has_spi_to_sa_act = 0;
 	int sel_act, req_act = 0;
 	uint16_t pf_func, vf_id;
+	bool is_non_inp = false;
 	int errcode = 0;
 	int mark = 0;
 	int rq = 0;
@@ -704,6 +706,15 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 			 *  session_protocol ==
 			 *    NPC_SECURITY_PROTOCOL_IPSEC
 			 */
+
+			if (!actions->no_sec_action) {
+				sec_act = (const struct roc_npc_sec_action *)actions->conf;
+				sec_action = actions;
+				is_non_inp = sec_act ? sec_act->is_non_inp : false;
+			} else {
+				is_non_inp = actions->is_non_inp;
+			}
+
 			req_act |= ROC_NPC_ACTION_TYPE_SEC;
 			rq = 0;
 			roc_nix = roc_npc->roc_nix;
@@ -724,7 +735,6 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 
 			if (roc_nix_inl_dev_is_probed())
 				flow->is_inline_dev = 1;
-			sec_action = actions;
 			break;
 		case ROC_NPC_ACTION_TYPE_VLAN_STRIP:
 			req_act |= ROC_NPC_ACTION_TYPE_VLAN_STRIP;
@@ -931,6 +941,7 @@ npc_parse_actions(struct roc_npc *roc_npc, const struct roc_npc_attr *attr,
 			flow->npc_action |= (uint64_t)rq << 20;
 			flow->npc_action2 =
 				roc_nix_inl_inb_ipsec_profile_id_get(roc_nix, true) << 8;
+			flow->npc_action2 |= is_non_inp ? (1ULL << 15) : 0;
 		} else {
 			flow->npc_action = NIX_RX_ACTIONOP_UCAST_IPSEC;
 			flow->npc_action |= (uint64_t)rq << 20;
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index b7565806c0..62385e4481 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -204,6 +204,8 @@ struct roc_npc_action {
 	enum roc_npc_action_type type; /**< Action type. */
 	const void *conf;	       /**< Pointer to action configuration object. */
 	uint16_t rss_repte_pf_func;    /**< Per flow tmp var for rss representee pffunc */
+	bool is_non_inp;	       /**< Non inplace config */
+	bool no_sec_action;	       /**< No security action */
 };
 
 struct roc_npc_action_sample {
@@ -282,6 +284,7 @@ struct roc_npc_sec_action {
 	 * XOR
 	 */
 	enum roc_npc_sec_action_alg alg;
+	bool is_non_inp;
 };
 
 struct roc_npc_attr {
-- 
2.34.1

