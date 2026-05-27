Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CBFCD5BC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 10:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D28EB40285;
	Wed, 27 May 2026 12:33:26 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11]) by mails.dpdk.org (Postfix) with ESMTP id DF9444026C
 for <dev@dpdk.org>; Wed, 27 May 2026 12:33:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqpYExg8YGkVyOxtdtKPo27R3EGWqxW+IcQpKCt/E0CeNrd17qkVeTjjOo/j/F/saaGqwsKLTYQPl8QUm3erNIF9AdejIKBB38w+XAh1J8v2Ld+z5P/QvLfgpLH0x2FV4UG4ajsPNMcIrZ0EfBh+XfAH4h6GYITBNYIcWC+dTcEZsGPP3zzrrG7/x5SIeD0hvNRMyOV9aVASPOvlq4pRV4qzFjRk0oj//Hc/Jc/lh6qkiC7d9AgsEFR1St5X2cVZpHfi+v+mJHFguWd+/FBlm5sJebdCY88PQux2HrE2W829+C4vIuoS6cj2LeRjey4YqKwRwzL4qc4b5GdRT0Pafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XgX+GuP5eLnmwumMkwPJdwPPOCvVuv81Wn7iIPxQ/8=;
 b=Ff7FBCa7h7vZ0mRSHHyh1UFxOHsLzlHfc4qBvrTtNPlcEzeeTYVFi3RNtSkkdnrL/bN8aUvIQZbJ26XZekFWP+mV2jTLFUKEA41fosvBw1ceInvjSRMD/qRC/XnwnVkvY3rr198iKw/ksS49uYPvzfk7SiYs4/FInlrfnukdFOhclRWicFvxyrsSkp42zKvNnaRDylRwnbxFi6LL5xzfU9zzU36KOpwoZ1gi2V4DMZxn4olR+GkM0+sGKR0DvrzzCt8YrIowf74DI0y0munw+XSUXCNZ0SPMA2SQEI+e+FKW6E+wellQS0WTdtq6ZNkdgmHS6zVFGIPY0KVXW7ys1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XgX+GuP5eLnmwumMkwPJdwPPOCvVuv81Wn7iIPxQ/8=;
 b=qSCwjUiVKbxEsrSmR8mTv0vq7aoTzlmycJbv6+CuNBJH7nX2lDLshLzMwX88rlJCa8/5I0lPIDcNWcuhQGamBAfwwxF7taMaX4FSYB+cAGEO6LjrGOX1F1O9JcV1ZAZ+2WL47raRLpY0Tg2sdTWIudDQ64qiO05fxAmLVzpwcfQJHZhvKh0cP4I1htgB9iFq537sKn3AeBQBH54WX7o5rhRCZJIBX/1ymOmYc29dI/tKtdKhoknSQFlm+27ok8FUWF674CTfgTE1UDwYG/86gyRlQEPChKVA6Z2fYSsNPGHuKQJdQlKLVckRPrNzfU1JU6i8NNWflqGWciG3hJbD/g==
Received: from BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:33:18 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::31) by BL1PR13CA0098.outlook.office365.com
 (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 10:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 10:33:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 03:33:01 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 03:33:00 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>
Subject: [PATCH] ethdev: promote flow metadata APIs to stable
Date: Wed, 27 May 2026 12:32:46 +0200
Message-ID: <20260527103246.633327-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f0068a-4943-4f0b-6414-08debbdb5e11
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|13003099007|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: +NDwXPP5VkwhKvzmpf9PTk0jxo+Da7pD1X8s2xzYcEuj0Xg78uE6i3NFl+9MeTCxXhRxH+EsgRsJh8DatFeRkEgkDMgtacu11cHo28xRBFbw1lVmQERE96+TLMoixc/A06Vpym4+R3WgXMRVW3VDpgrOiBCuHXlQqPYfOaqhEALwPgrxsgLSs3hc/iuzTApfYSSq0GOEv0DV4kEsoLOJs0bixwDEiXGVLC5u1kqkAxYirEKTjh6P6WCCpND+yZCWn8o8ucE/Gxt1rI+vkxkGWRP39W+llEvql+8osGmqC2GkcuE/0BUnVynoAmeNyxy3X0X9w0R3FMLlCwMi5fOeTc8AzrU5R3w0zt/rltQSMqdknL2pdbZSGYU1m1JVDjxT+v8ERVuUvQBosTlRq25sr1F9+T3zXOIWLzImGErsGwSqX6ODu+2ycCQUrG0DftVbkBNIYtiDLsAVch6ecIni/UKwRLhcrfbIouIEz0kreXJK6p3kIjpXthneiIqPOLrsxjGnu+MeUeXo4+FkbSxbjKFZ6XQ5VCM86VISOUhBHdnJf25x8kjLzl21D0opaHBQjOOYwPDhQxob848j9eCIv/Lvsp+fM1Hjv5PdaB2qKKgWcoJ0QUn+1CQvAscxy62nReNVSrYcujJckpD5xqJDPfT8CEKcs4i/vuq4mVJgs53Vd1enfwfZ0si0pdlxjgzkCmgrhErDWK8U7qdaA79ER+AA8RtUgzB4tVIqTS49a28=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(13003099007)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ThbN6BQ9tHOvS+yQ2xQqlgyq+BWVf6tXPRrHkgOO3c1S2roLORwOrkWStgtLNE4CPrXzJn6/7CzVsmc/dV4QP76wz+/8NvzGJB2MM7fcaPYDprvp0CfEc77NL1xsY6Btknw1EQyF/4QYCvqKOGr1fbtqlJDr2K09QZ6XqcyMbnRVTz9DoyRUmmja6ebXLlRjvxAwdXsp97/qOUuBHQymCYBsH0TM3hn+TtQSHMyEJmbKCgSD+80E6oQQJz+TihRFBGXnuIsB0XHZJR+JiYnm9bl1sTNGN6pxUkprl2fYXEbimLybos72gZ4Tgv6YLKp32hYJhP2EBhetpnKH7Vat+Dfw1FKMzYuvw1TjlRI5GoBE3aOpdJsts5mxCJl/BJQt1JeIZkI+ZijDzeDzb5+6Xfy6lmgMJXlqoANmND854OrDqFnVB9g6GWyU5rcsTFc7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:33:18.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f0068a-4943-4f0b-6414-08debbdb5e11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

Following experimental symbols related to flow metadata
were added in v19.11:

- rte_flow_dynf_metadata_register
- rte_flow_dynf_metadata_offs
- rte_flow_dynf_metadata_mask

Type of rte_flow_dynf_metadata_offs was changed from int to int32_t
in v20.05 release.
There were no changes to these symbols since then.

This patch promotes these symbols and removes __rte_experimental
from the following inline functions:

- rte_flow_dynf_metadata_avail
- rte_flow_dynf_metadata_get
- rte_flow_dynf_metadata_set

All these symbols and functions will be used by netdev-doca
backend in Open vSwitch [1].
Stabilizing these symbols is required by current OVS policy
to remove the need for ALLOW_EXPERIMENTAL_API [2].

[1]: https://patchwork.ozlabs.org/project/openvswitch/list/?series=504726&state=%2A&archive=both
[2]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 lib/ethdev/rte_flow.c | 6 +++---
 lib/ethdev/rte_flow.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 7a51b667cf..ec0fe08355 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -281,7 +281,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_register, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
 int
 rte_flow_dynf_metadata_register(void)
 {
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index ba3bcc89a3..0c6d42c0d8 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4253,14 +4253,12 @@ extern uint64_t rte_flow_dynf_metadata_mask;
 #define RTE_MBUF_DYNFLAG_RX_METADATA (rte_flow_dynf_metadata_mask)
 #define RTE_MBUF_DYNFLAG_TX_METADATA (rte_flow_dynf_metadata_mask)
 
-__rte_experimental
 static inline uint32_t
 rte_flow_dynf_metadata_get(struct rte_mbuf *m)
 {
 	return *RTE_FLOW_DYNF_METADATA(m);
 }
 
-__rte_experimental
 static inline void
 rte_flow_dynf_metadata_set(struct rte_mbuf *m, uint32_t v)
 {
@@ -4590,7 +4588,6 @@ rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
  * @return
  *   True if registered, false otherwise.
  */
-__rte_experimental
 static inline int
 rte_flow_dynf_metadata_avail(void)
 {
@@ -4607,7 +4604,6 @@ rte_flow_dynf_metadata_avail(void)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_dynf_metadata_register(void);
 
-- 
2.47.3

