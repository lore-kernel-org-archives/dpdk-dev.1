Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D7CDE00E
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A68B40689;
	Fri, 14 Nov 2025 07:20:12 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023096.outbound.protection.outlook.com
 [40.107.44.96]) by mails.dpdk.org (Postfix) with ESMTP id 9396140151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 07:20:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvgrxfI9E/bKzHjUS8PN3/LAIa26oaKvCVAcvivAljNsEnsPqF5VWcpUr5sViHlU06oXadXt/ci50xFMIEyWv4yOcmNGb7+noVDlLfRD8wPqJvyZrEP90PDDjZ+olXaTqPncEeLpwgIWMyU4lVPqyG3poh3WMM0VM0tpMDvrc5WW3JgTL4uP6LNBYbfZ37c3IQfyHrQaoGXlq0VO3IAqtOIfpT+H4L0CW5rA5+OQtiAIaTkyCMo45CMIiJKRsZ+i5BKWTtgg+9ouu2MKpnD2LnA851e8q6s6uaerRJueXOtKIET4gLWXvDf41b1dWLktzfYMM4lQ95W91n12sHFffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lYA2rjc27SgWGUGYlQkZ+i6M8WBjjTcI17jBZDrXbA=;
 b=UMADC1N4ZbKCKIAXcUiphTcuXRKw8VcMjQc8xDwCSnhRPoOgbFETgFNsx9PturJU/FvRTpAFPVb8g6HXcIeOIrpXx+uhNLt/ffIHMxGx/h/vWL3T6/KyvXxWcbT2y1WiPR9g6JkI2RphAZzMhaqEMfCCkdtYBKfcsFjAblPr/LaLDZETUJhsc44noOq1o/QHgzsdHOIMWpTpy9TGB/gn748CI9k1zDLjsKRarLfaGrC4Jv3lNnRDqpuhFjVqw4qhlOX3kepbzoKY9Z+dCjxN+sG3UdCtmH8oQrB7ZVd6kRhi4m2Chp6MveBrzfjm34F9+2OmdxSOh8GenBn84WWLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lYA2rjc27SgWGUGYlQkZ+i6M8WBjjTcI17jBZDrXbA=;
 b=EPULYzNWd11BE8cItUFtNVQA5d1VjFByoQiPywVZHdaXDR/oKo+iN+/UvRWc1yAKypvYL4kZCcqGc1DyC3cJLlSkmMSJ6k5OiJLBg6oLCUWFQUf+sPQnB8D8mWAP4k8NwwTc2xVEo6wmTMmsT4mNRkndE3QmLEOZpk+lWtqZMXiwoOG9AES58mGH7f+8PJFEDEzhKrpvub30eux8YFDLLArcYDMwWJvvt8xb2CUySjsLuwMzLRn1gS5Z2/KI3SgT/4sJOAzyczX36hvH+EKp4mtYlwQStxLSd+JGYWCwb8TnjKUN+g3khskIXa7LQsDBV3T7cwXS5xeE+nfOOex4Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by TYZPR06MB5483.apcprd06.prod.outlook.com
 (2603:1096:400:288::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:20:06 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:20:05 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: orika@nvidia.com,
	thomas@monjalon.net,
	stephen@networkplumber.org
Subject: [PATCH v2] ethdev: add GENEVE encapsulation and decapsulation actions
Date: Fri, 14 Nov 2025 14:19:17 +0800
Message-Id: <20251114061917.20948-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|TYZPR06MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f848468-923e-4428-94de-08de2345da4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QLwzBmUwAxv/TH+ADc57y//403GTNhC+pBTCBeKPhXQdS0ObzBkRuQ4WfQVZ?=
 =?us-ascii?Q?n2BMLgLQdITLZIVoqXL4Pqxy8H89Rc7CqqE72SP8O1/3mvSj+kj44pzZxzFq?=
 =?us-ascii?Q?A9JdVuNvWugKrfPLuq4aok6qn5evhI6PBhogHxTFG+p29rXE5YS6D9Z0vKcF?=
 =?us-ascii?Q?xxHm+PbENZdBPez1ljNfjeQHm1KdBagmNWDIU84xXeEfEXakwNVN9JcIqwE8?=
 =?us-ascii?Q?X1bUQO9hk0f/BTbloTy56ozPugo+KndFjjgiwAaU6LEfkVeBsmp+dzm92J09?=
 =?us-ascii?Q?U0rbmrqJXsWUikIWnCy8QOo2eFsQmNjjMDNyGFANMaNCrb8u7L1HbIeXfuBO?=
 =?us-ascii?Q?JX6YEDtnrX39vaBsoiV3mKgtGnG7ecYzHxOoyRTmhHeg+Shtg7CIW7ceTn9E?=
 =?us-ascii?Q?tIEUquBzaS3Pix+DpfB/HawPZZGIsDmTHOyJKyCPY/1YE44S55HhQscH1LpS?=
 =?us-ascii?Q?UIEcu1gFB8zbBDMcZeGyJIlS3v0EvahpUnVW0tws2kG+93Im+rKpM7Ss6uWy?=
 =?us-ascii?Q?gw4+oAhIyV69eGWzONzddl0S/BFYS9CVBLPJ5FShbKYKGpRvIS9cCsC4sb0c?=
 =?us-ascii?Q?lCrgJfywSfXZPJGpUTQmk7nDhxrl0hJD05EFDDvKUGceV9nfV/xIVue+e8Rp?=
 =?us-ascii?Q?PAp8IUc37rxY5r+PJMR8gx5u/qNpmYse9d2Mtux1QqVXJec19EBT7rkB1Ocm?=
 =?us-ascii?Q?SNgsjCJC+CgIlEwDG9AYTBQszGgmYZFK6IbCJyo6N2gR/jToFmaoybcMA+UY?=
 =?us-ascii?Q?AtcdHLIRSxU/zIqzuBCOFjKyexWSOlDuROjWsmZGDRLfVTfJkFNpqdvui+uK?=
 =?us-ascii?Q?a0bJqCl6M5FogMYX4fAvoh1B49DeWsT6BTSf24UxIdA62V9hzC+b5rVbpUr1?=
 =?us-ascii?Q?vg0qDs/8ZL5ebQiprAMbHBMWbRQuWQl/MQ/FihI0qnV7lnLtXozoBzmvTy3Q?=
 =?us-ascii?Q?y7P/Fql2QbL+pYcdo08hLS3rl30UEgUY8wBknUuZ1L22BiO5g509xLmBDc0o?=
 =?us-ascii?Q?wR4WCsZGtqKygsMuGSPm9EQzUndmJgWD2T5ydImqe+893QHZlrkISJuYVJxA?=
 =?us-ascii?Q?ExinhqRE+Qht6La4+jtm8JFMaXmOubrHghMk5Q2OCmNsksE7IZ6+UW7dXWCw?=
 =?us-ascii?Q?LIAbWi8kpO+GKm91SLDpKATQDX9Cf2xduLKnyq9B9PsIRsE4CpkEaaQjBH+V?=
 =?us-ascii?Q?YNPHW1hQba0GUj5k0AWW3DC0JByxW/GZL3BMqAgIcnIfcVG91zbbqZHla4NK?=
 =?us-ascii?Q?bqa0LqSEokkdLKCFLmaGrKfKOgQw/W3zzn92t9zS+FnfP7NhEp8mfdHgkqqH?=
 =?us-ascii?Q?KSV3XWAb2GcVrSjHeB2hQr59NEWaIAuJfUkBU+xDIMhKwCkRePE53KdTwkBw?=
 =?us-ascii?Q?aLXlz4UtfeHusJmzAy8mnv/jQP1Pnp/aJsxjYmeBVPcxqGTHwRCgfIgzX9Yh?=
 =?us-ascii?Q?lAJGeBc3i1fBqlRvl61Cpeclzofi0fDO6MXGaIrwZAXI3pSsY+A1YSN9Kck8?=
 =?us-ascii?Q?AWEBkO51VNfH3I4Xtjs1zd91/JOxhrrS92nr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YaWtWMH8YiE8TfDRjjOCcgr4aQG/b98ja8pSSzkTdbLCIaR7KTC090aE+xR2?=
 =?us-ascii?Q?YuNVHbaierCwcdhDCVF1rTCy/dcwpj5hHQ16eUZvD6a2rmVNOHPJ5wnqhBYR?=
 =?us-ascii?Q?WyYGIggfb6RXpu1SZB32Yzy4q44rP8IZZIZcukrxtuXL69Yr5dt4SPj/ns6n?=
 =?us-ascii?Q?rr+8XyPw4iuYe89tN8rUj0PaaKppDidTxmUduwTJgfpoUr5aSt2Z80MSHyt+?=
 =?us-ascii?Q?n1s7gUf5h5xJw8sGmrBMaDq17oCortAS3Xwa3q6NiQxXHpKOBzQ8G6CCN08o?=
 =?us-ascii?Q?f94TzMb6EshrutR53Q6LSiyh4gSZFX/Zy0pLvPL2DvBmrBB7mD6GqnneO4I0?=
 =?us-ascii?Q?qjOKuJ1sVxGLTNSTxBBR+FovaOn4Ten4xo71Pfb3HsTrCkzkuHbFWBh1wp1v?=
 =?us-ascii?Q?eqKPnFoalK08RmtGUG/D7MIeP9hW/383v3iDoTm60JG+MzAwLzQWxkSlN6cV?=
 =?us-ascii?Q?QUYYCPK/OMRTKkASwo3frKehT+6jrV6d92vndanWHDvxJwt4FTSrLNzAcRYF?=
 =?us-ascii?Q?4pbTcQJhPgcuwnzbgpunRyxhRzebABEWVn6cRrQq+Rxe7kUmkXUI5oA32w/3?=
 =?us-ascii?Q?+sbKnJivBQ2QS6qk+XbTMe/MW78FbhTs0gzquW4CIJa61xRXyQyJh6k1LkwV?=
 =?us-ascii?Q?2swFQ7voK0OPAMDgswnuvq6eU/mgq3F7N8Rudm2Uxo0N/LtblPKS14wcziEI?=
 =?us-ascii?Q?K0dsJeebp/Ejont3vPlIM5Rb4sXbQa3rFgOXSYgkg6XJqidf0s6UIIsPgmBy?=
 =?us-ascii?Q?+l5H2tQoFpNEkisTaRlCvyY/s1e3VZeukpGgHBkjyE0tDhqyc50JlrmYBvNO?=
 =?us-ascii?Q?q044rTc+Heb8o/nGtkhUJkpnJPy0O4366mUhBSHfYFR2JuwJuDDiZ4/osh/M?=
 =?us-ascii?Q?V5uXp3UhnF2er4ZeGJCZhGDzKeCFzY+mg/Dnz3m/gM1TvlzpQ/hhtoPozMi7?=
 =?us-ascii?Q?If8aoDbMEh4W5E+QpVP2mRzhDRahJpaXIFT44GAWeXZw/YY5BORDfgMp9pXt?=
 =?us-ascii?Q?YsvX9htjOAhEUQVw8Cj+j++oxBEQT5Txug4TgayQx7/j9qkBNCpPnKB8f4og?=
 =?us-ascii?Q?NtuIp5Sho4Pw9kiFRehR6xdNixVk1b2peVUK0kenwXQVgxSjynatl1M9b27u?=
 =?us-ascii?Q?VmE3J/uQQ01IhpdzhKAqejFSMjoEiTf+L77Tr+cw+2Rztr9Anl0eW2E4I4QR?=
 =?us-ascii?Q?hNLEhZlTyGG1Rb+BY0f6OxGStW8kt7xT39ZHwmjNLg9IRPeDeS/8nXM2MCdo?=
 =?us-ascii?Q?8XZJqpHVUulOSrziZbAqpffQbQKqYkB5fI1K6ePdanhDu1myU9igsn2NqAve?=
 =?us-ascii?Q?KUFNjrVwSIBCCNPpi1qW5SRVpqgeLCb0K0NmIL27OEEvsPNO9TdU/PKT+ISw?=
 =?us-ascii?Q?wYg8t7dM7iN3/S8VcCofnOOCcfNWhkb+kviX7SmJ3CTrn9xqQGvnOfM67KzL?=
 =?us-ascii?Q?AIhn0850UX7shWDZj8uQBbCj7ht20TjnHC9JPIOrXrXqZpYEXBcu12060E2A?=
 =?us-ascii?Q?jnUIWUkoGUwZ6TZd5JGpn7epA8VaVI1p5n2+QKODwC5Yglv3QybOplMD1at3?=
 =?us-ascii?Q?hvmcFaStUt5ZqI7NodXUlnUW1ydoewD7kQMD31aUWonfImEhBTqtvZOnq1xE?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f848468-923e-4428-94de-08de2345da4f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:20:05.9050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hckN6duPobGggBLooHEgdaaxSmDOjeeTAz6ThjwwP26/yN2rGPLCAPuCa5EQKMD3IEvvsjw2UxJLhXIPuQbl8XkmdyXMtbUP9/TkQxwQ9XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5483
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

Add new flow action types for GENEVE tunnel manipulation:

1. RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP - For encapsulating packets into
GENEVE tunnels
2. RTE_FLOW_ACTION_TYPE_GENEVE_DECAP - For decapsulating packets from
GENEVE tunnels
3. struct rte_flow_action_geneve_encap - Data structure to define tunnel
encapsulation parameters

These actions allow users to build more flexible network virtualization
solutions using GENEVE tunnels as specified by RFC8926, which are added
at the end of the enum to maintain ABI compatibility.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_flow.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 3d2ccdeb92..84b903f8e1 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -3263,6 +3263,23 @@ enum rte_flow_action_type {
 	 * @see struct rte_flow_action_jump_to_table_index.
 	 */
 	RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX,
+
+	/**
+	 * Encapsulate flow in GENEVE tunnel defined in the
+	 * rte_flow_action_geneve_encap action structure.
+	 *
+	 * See struct rte_flow_action_geneve_encap.
+	 */
+	RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP,
+
+	/**
+	 * Decapsulate outer most GENEVE tunnel from matched flow.
+	 *
+	 * If flow pattern does not define a valid GENEVE tunnel (as specified by
+	 * RFC8296) then the PMD should return a RTE_FLOW_ERROR_TYPE_ACTION
+	 * error.
+	 */
+	RTE_FLOW_ACTION_TYPE_GENEVE_DECAP,
 };
 
 /**
@@ -3738,6 +3755,39 @@ struct rte_flow_action_nvgre_encap {
 	struct rte_flow_item *definition;
 };
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice
+ *
+ * RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP
+ *
+ * GENEVE tunnel end-point encapsulation data definition
+ *
+ * The tunnel definition is provided through the flow item pattern  the
+ * provided pattern must conform with RFC8926. The flow definition must be
+ * provided in order from the RTE_FLOW_ITEM_TYPE_ETH definition up the end item
+ * which is specified by RTE_FLOW_ITEM_TYPE_END.
+ *
+ * The mask field allows user to specify which fields in the flow item
+ * definitions can be ignored and which have valid data and can be used
+ * verbatim.
+ *
+ * Note: the last field is not used in the definition of a tunnel and can be
+ * ignored.
+ *
+ * Valid flow definition for RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP include:
+ *
+ * - ETH / IPV4 / GENEVE / END
+ * - ETH / VLAN / IPV6 / GENEVE / END
+ */
+struct rte_flow_action_geneve_encap {
+	/**
+	 * Encapsulating geneve tunnel definition
+	 * (terminated by the END pattern item).
+	 */
+	struct rte_flow_item *definition;
+};
+
 /**
  * @warning
  * @b EXPERIMENTAL: this structure may change without prior notice
-- 
2.19.0.rc0.windows.1

