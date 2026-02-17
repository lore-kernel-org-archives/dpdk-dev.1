Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98333E83855
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 947A24065A;
	Tue, 17 Feb 2026 06:44:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 00C594066B
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:57 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1KJ4e798873 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 CfADlVeHCAWKgN1iP8FGN1hMs4n3JM4aN8v2SULswQ=; b=eNRh1LrpU6lvTldys
 XAj7jxX40qSQfYVHVxsBDG2W5aF3McswNX8vAUBGYlMAuV9Xz2vSlTL4C6hbGgiC
 0/ZMlV+n8ALamAmxOEhFkQMMd/OlYgPgnWZBVEa4LyqbUZb6SOo0YRfKffE9ZFvt
 OXYyL20p++gZISOmTcgbuaQakDJqiiCE+iTH6y14BXRpTRnisyD+l1SYM4TWzq32
 Y1ffzPLlormeHzR6CVHmD2Fi0kvMLdc7JPxs0BHeyjal0ipwbvBVBUsKxX4pU11+
 cZLL0yMuGGPkjGxjNVHVpgnCMGIkDHEOobsTfFQVsLQnxjici/d94D53s1g6sB61
 xhwzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8d22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:45:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:45:13 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 993385B696D;
 Mon, 16 Feb 2026 21:44:53 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 14/18] common/cnxk: flow rule config for non-inplace
Date: Tue, 17 Feb 2026 11:13:41 +0530
Message-ID: <20260217054345.2759687-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=69940059 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=6M8icqy7KmfyjBFS3KcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX7I+ee0eqo1qi
 8BjO6wkpKjQZ357xF+YZeJoJOd2MOa6R5NafT25GM8M2vlF/lHmpoXnB/I3gJVifU3lhWo4oPEl
 AIFmoIN/drQq/kgwtAe0+fSwyH1NSSdkRfHBGzuRr3y82/hSJ2xutJdujLGlQfMtu7BTtugx8bg
 8KVa5+oqfIcDakv8u7BiJbYryQhw4OVBSSnPOrAuAAcjuXD/AqujeoNkP+EHdZW6RpP853Jtq0B
 UD8IRP3s7Mya2VfJLzbXa73yqkaD6S5LyrEqkD2AIaS4Z+jAwDp7Poy0xgnXHWHjQzkhEKtNRRM
 hfD5fb0MjLWvPQB9B6p5uFiBMD/914XkJFQ5NY3penpsGZ8MNxBTuD7E+diM1+rrzv1TgKzKt3R
 dR5tTGSwtSnmEiJkZW+0rVUobYBhTPRj9Eylela4ENmerefdGJZUpmEJnqqiTw6iAeUpVxX28Lx
 GxH7PWh7GSrZLlxLGoQ==
X-Proofpoint-ORIG-GUID: PG-LS9asuemEDnErNpFNr0vp2Yq9JQN6
X-Proofpoint-GUID: PG-LS9asuemEDnErNpFNr0vp2Yq9JQN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Adds flow rule for non-inplace (Out-Of-Place) security action
configuration.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

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

