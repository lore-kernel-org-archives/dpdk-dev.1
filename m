Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 11:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D100402A9;
	Mon, 21 Apr 2025 13:51:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 66AAB40299
 for <dev@dpdk.org>; Mon, 21 Apr 2025 13:51:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LAZoA2006226;
 Mon, 21 Apr 2025 04:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=8MRRbNSHrAd84XClrE/Ktm0
 lv3VnnCl0L9DTajrcpDo=; b=Y32HqcnYVsqShE5PbJSJCgqiXFzN8EHipyBpAUU
 cjossm3Y06KrA1giFHW0cyVK50ja+fLBI5GqRAoVnMd/bJ+CTPBR+F7RSKUfOeCI
 qZKJOxes60Q9KqFOYPOurbnRMSwAjBwQUkCOT4ddgws3VwJvyfm59jsqMWo2PpsL
 fceVQcc0b2edvUZfOI9k+HHwmBJlHEADJjmWcQGu/67nqO8V7KZ1+VIPzAVJM1VG
 FhjeiPaypNVUnLDuLUyWY5uW14lg7u7MYxyvjiAsWs8qiGKDVgj5lQgZzWvwK7Z7
 KkC9JboBdsokAM7vNMlYZghMtjhqYF8rwm0L8A7SCGhQUEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 464bbjtwem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Apr 2025 04:51:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Apr 2025 04:51:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Apr 2025 04:51:47 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id F0BE83F718A;
 Mon, 21 Apr 2025 04:51:44 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH] ethdev: add support for flow action pop E-tag
Date: Mon, 21 Apr 2025 17:21:34 +0530
Message-ID: <20250421115134.841719-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mJT6c1JkDYfoU8YtRO1bsilWMQoOHpjN
X-Proofpoint-ORIG-GUID: mJT6c1JkDYfoU8YtRO1bsilWMQoOHpjN
X-Authority-Analysis: v=2.4 cv=WfsMa1hX c=1 sm=1 tr=0 ts=68063154 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=iddp44BnxvatBgSYtLUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_05,2025-04-21_02,2024-11-22_01
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

Add support for the following OpenFlow-defined action.

RTE_FLOW_ACTION_TYPE_OF_POP_ETAG: Pop E-tag from the packet.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 app/test-pmd/cmdline_flow.c |  9 +++++++++
 lib/ethdev/rte_flow.c       |  1 +
 lib/ethdev/rte_flow.h       | 10 +++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 998527590f..c4359e965d 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -652,6 +652,7 @@ enum index {
 	ACTION_METER_STATE,
 	ACTION_OF_DEC_NW_TTL,
 	ACTION_OF_POP_VLAN,
+	ACTION_OF_POP_ETAG,
 	ACTION_OF_PUSH_VLAN,
 	ACTION_OF_PUSH_VLAN_ETHERTYPE,
 	ACTION_OF_SET_VLAN_VID,
@@ -2275,6 +2276,7 @@ static const enum index next_action[] = {
 	ACTION_METER_MARK_CONF,
 	ACTION_OF_DEC_NW_TTL,
 	ACTION_OF_POP_VLAN,
+	ACTION_OF_POP_ETAG,
 	ACTION_OF_PUSH_VLAN,
 	ACTION_OF_SET_VLAN_VID,
 	ACTION_OF_SET_VLAN_PCP,
@@ -6932,6 +6934,13 @@ static const struct token token_list[] = {
 		.next = NEXT(NEXT_ENTRY(ACTION_NEXT)),
 		.call = parse_vc,
 	},
+	[ACTION_OF_POP_ETAG] = {
+		.name = "of_pop_etag",
+		.help = "OpenFlow's OFPAT_POP_ETAG",
+		.priv = PRIV_ACTION(OF_POP_ETAG, 0),
+		.next = NEXT(NEXT_ENTRY(ACTION_NEXT)),
+		.call = parse_vc,
+	},
 	[ACTION_OF_PUSH_VLAN] = {
 		.name = "of_push_vlan",
 		.help = "OpenFlow's OFPAT_PUSH_VLAN",
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 9f8d8f3dc2..765a8b3dbb 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -213,6 +213,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(SECURITY, sizeof(struct rte_flow_action_security)),
 	MK_FLOW_ACTION(OF_DEC_NW_TTL, 0),
 	MK_FLOW_ACTION(OF_POP_VLAN, 0),
+	MK_FLOW_ACTION(OF_POP_ETAG, 0),
 	MK_FLOW_ACTION(OF_PUSH_VLAN,
 		       sizeof(struct rte_flow_action_of_push_vlan)),
 	MK_FLOW_ACTION(OF_SET_VLAN_VID,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 3d2ccdeb92..fb4f4bf9b7 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -3201,7 +3201,7 @@ enum rte_flow_action_type {
 	 * @see struct rte_flow_query_quota
 	 * @see struct rte_flow_update_quota
 	 */
-	 RTE_FLOW_ACTION_TYPE_QUOTA,
+	RTE_FLOW_ACTION_TYPE_QUOTA,
 
 	/**
 	 * Skip congestion management configuration.
@@ -3263,6 +3263,14 @@ enum rte_flow_action_type {
 	 * @see struct rte_flow_action_jump_to_table_index.
 	 */
 	RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX,
+
+	/**
+	 * Implements POP_ETAG ("pop the outer 802.1BR Etag") as defined
+	 * by the OpenFlow Switch Specification.
+	 *
+	 * No associated configuration structure.
+	 */
+	RTE_FLOW_ACTION_TYPE_OF_POP_ETAG,
 };
 
 /**
-- 
2.48.1

