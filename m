Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4079FCD5BBB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18DEF40693;
	Thu, 13 Nov 2025 11:23:47 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023113.outbound.protection.outlook.com
 [40.107.44.113]) by mails.dpdk.org (Postfix) with ESMTP id 484E540151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 11:23:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd5DLXNI2hFH8se/ejlrA/d0pYq+bUpMZKIonLuM40OtAXVZr6ZLCUsAjMF0RlHvnF5658GgadWkPNZwKcdGrwbCOGibliw0jiOALGlErsMAwH3qbLswiUW8Lr88IIA185S+xMBKc6+75GP0W9zWXG0vIddvU/MWe46/wwfG5y60Zo+A9KnvArnUmABcYYTEvfzuMPKPsjM/B8A1jbZr3c5qWWJ+EQUxUT2nKsCx/Wb1fCEnZX29hrqVR4JM4b0jWBcAcIGsGRmhanJfFwgXVIi7DhxNRWTNhPAVxsFohFi/llhZMQKCU/2R243ok0DanjaygUt8dwFXeIiQcf/3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKKMVV4fmvXQWPb82vHPufVXfarxflz6voQpVmXJD2o=;
 b=MaVhd2x4Yvyp2EP0ZKJDVJyPaz3iNH0gsWHELjv4nQUEJoKPngu6XTy9Bk25vqS8Zd2NXxJKkbz4nDNzQ1zsrJOe962Q6BH8GuGbDyhCf+fIb4U46SkHRFrn2Sq2QN+r8V1ircZYMQZRmywQUjPvVhd0Kc9VjmjzrCt06+G8eO1+SUYkWwLglt3A7dNYNCsuDq4klhthj8AUkEVQd2m2VLVXGu9bT0l4P7ibAAjMuKZWMajQ5sLHIszuWKzi7MTVbgftI6WRTTgPq00J4V4PZSUhngzsJk616GnVtu3JugSDE4c2PsiUx+JWS25TXx1AnQ8EuIYRXm6PNS5g43A05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKKMVV4fmvXQWPb82vHPufVXfarxflz6voQpVmXJD2o=;
 b=Ncrrg7bdswVjPcP02wJD2dCRn82J/tpDNfCBlndZW/fJDzRzdlGdwm7ijHWu5hzRvLZEpCCTJg9Uqp0O8uJeqn39QRYvBoPVo3ctV9Hdi0Vf/I1bbY7BMP9jPaMQ3qofarkKPM5SSQApjH7QfNMCnluVTxhhLZKqZU8b+yxPIV4pNUFPRLndlclVwRzHaOIR5fLBxlpSEItnq+j8wXUPOPfIPPcTg5/vYSuUSFtHR5ZdxfFLs9dmuD3+6516vULMyec0bUZucPWS9iZBY2XcqvNPiNzGKFifac0cWFHlIc4lgkZONGcCNzbhEMHNFhFA16SloauUq23CE1rFY/feNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by TYZPR06MB7214.apcprd06.prod.outlook.com
 (2603:1096:405:b1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 10:23:39 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:23:39 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: orika@nvidia.com,
	thomas@monjalon.net
Subject: [PATCH] ethdev: add GENEVE encapsulation and decapsulation actions
Date: Thu, 13 Nov 2025 18:21:58 +0800
Message-Id: <20251113102158.48040-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0270.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::16) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|TYZPR06MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be8fe04-f1ad-4e9d-1939-08de229eb653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dvILFm7J8YF6PluO0yfVkSRdz2q3i5nWcpRed12EoYGJ/JFAQS1lUxfdor2w?=
 =?us-ascii?Q?VR9sUc9W5W0CQyGl8+TtmjfW+wAkzN+XcZmMgHFfVtWGvVIazhjUT1Z6H3NF?=
 =?us-ascii?Q?0nSbrh9jIUyML3zb38TeXdZXXPeqm5eQih3V39YIpQ3fOfy7yfzvTJABdyd5?=
 =?us-ascii?Q?aaC44zbUiPQoLBcsoq6Gbf6AHcI9ok0rWUzqzgzhg+of16P7hRaRe4E8Rz3h?=
 =?us-ascii?Q?oISbi/h7GG2cUqFADxHDkDOb2QhKcrlnm0q0023rkxbMlwJOy71gviBythe9?=
 =?us-ascii?Q?VEIU701PGbHvb+0k0fwvS/HxjEHKzQBQX0GGm9XUpOSw8w0aw+/b8bnoJxKn?=
 =?us-ascii?Q?IU19vIEaCfb79F0AqsgPAd/8TFvtNVPbIIXaJazC6w90PqvykHP8XYNVDc3Y?=
 =?us-ascii?Q?hjVu/uy9mmmXIheoJNPWo1o/lSaEQYL373bxMIcuA/4/7Xs6gC3zO2LV9lDJ?=
 =?us-ascii?Q?75d+JzyMgOZKvQZf/59z+C6n+5eyI6G0FjDs+ouj6Yljx8jJpCq5IS46MYVC?=
 =?us-ascii?Q?TwtWTpw4g4CYLGaMPajrdENNFWe1cCVbnfL6QQEgBSDvPpRl5b1lo20bPFQc?=
 =?us-ascii?Q?UIxrAQ250e+2iZEuu3hkyxEZITliIhxrFgpp+xckPIb8IqTZ4WH9U1ATw1cW?=
 =?us-ascii?Q?0Stn/fUUcqW3locPuVV+7MIthgFFP7Y3ZEo3DS5qos6P6wccFMrbhSY5rrVN?=
 =?us-ascii?Q?eqv/CPEoYH+E1T4plu9uvmRqUV+JddkycILf+l5JQaON1at1crl+Jv8V7Wpd?=
 =?us-ascii?Q?bZpfXHw1rCPW+Dt0fUgV2YpjTWoan1JgZLWsCF3Bw+IORV47nmfVkAqPHYqz?=
 =?us-ascii?Q?Qh3o7DbG1VsTd+NFBk4TV4NDnEJzzxBmLa3WHTTfxUWpxNciHdAngdQovL/2?=
 =?us-ascii?Q?4U1Cmo3SQqzM/gQBov9tMB7STkuPLvk8rW86oUo6ELOf6oF7GX7PXT1ADEOg?=
 =?us-ascii?Q?EuSsrBncdHY7bUvM8ttCq2z5CYuGN29qlRTXzzoxlKja7J5kMTeNUPfk4u/J?=
 =?us-ascii?Q?sW09eL9VgrJPKUcQtsY2SQW9V4dT3Qph4CFhNFgJeV47hw840MgXR9CuKHaZ?=
 =?us-ascii?Q?szRPobaGbL18ZBYRMJIXXDCM4hHSr9C9VUQFXsx56YQgkP52sEijmCVpTt5Y?=
 =?us-ascii?Q?mqCtYUjk4MsMVIrDRIDp3NcLLPyxONcCHQ/bWThTsxGO/mc5Hd27HlaOqBFQ?=
 =?us-ascii?Q?wcLNM3TurMiZMlU6yWNo8PzUkfgRtVJXo3K5up/GWleKVRi+QkQFU8Hkg9Zv?=
 =?us-ascii?Q?/uE5QsPlEnn1Kf1NOC/CpjmggSKKKuqHS/7gkxb+81N4kdj9bB0+Gg5uhfH9?=
 =?us-ascii?Q?KMVC2q/3oIvBIqv4hk4WM8RdsKQ0gHyGiY7vRY/B+uI6JX9rtUn6/uFdBoIn?=
 =?us-ascii?Q?oImw9ECsPn6atlBJE+SShfXhIX2lSltZuFWpDtNCD88IO7Cat6BY340KhPcL?=
 =?us-ascii?Q?LyN/42wf+7gmm/JFZ4c0X1i+IT5n8LcrIxRj6RKDCE3HvBberdvN07ACKptW?=
 =?us-ascii?Q?CMgy5HXDmLbGDalbL4jPKnDSjVasAgVKT/2Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WI7ZCNjwxXBanqedWpVMfGM8++7MEiK4GMY4JWZE4pHbMMj4EABk4k0L0rcD?=
 =?us-ascii?Q?Txu5XEHlbw3Z6lrB6bajextUux8MRsL8tM1Xp7tV6298ls5OEFdha7s5fI38?=
 =?us-ascii?Q?xxU2ZDUgZOEZd3yUMhJU74lslA93h/2ttXAD13YcnnKXdsx8B420kTr4cGl7?=
 =?us-ascii?Q?ES7GiobLmegDQ7rraKrQX2ktQHwI+NQZsOhqbqx0/g+69ovw+5lG4UvM19vf?=
 =?us-ascii?Q?OFKTe8D3vaxZnFA326duWmvHK7GW7w22KXLfbXZK1w1JOWoxQ3uIkoUsQzMK?=
 =?us-ascii?Q?HgSUe4B+W7yUpI3KBXyoaPvdZHGKBkOi8ny/tgXt9A3JiGYdDzCgsbglEKxM?=
 =?us-ascii?Q?0XgcCTPovi/WEH2GOTRsvyjQYY+Lu+PHuj7rk0sTNKll5nPdN77U9VznBTFp?=
 =?us-ascii?Q?gGfkX9ugRudwixQlF6+F2MoxqevJXmDaeFbu8O/mdKhf+zUAbDUta/JLt72f?=
 =?us-ascii?Q?u5FGwWWzGw+YTmsHwT/r2RJlOBG9sJE00VHHdT7bybekERoZcyH+GXyQtA66?=
 =?us-ascii?Q?h+LWDxzte5t8fpk2iZHafkOyALnDImAWnLrDM+xlZ4JM35WYNNa6KeEMo5yO?=
 =?us-ascii?Q?LnO9LSuL/cFvi6SKoq6+myGekVzEmGDNQ4QEFFWDnXM86nPB2Icn3yEzGHig?=
 =?us-ascii?Q?e3aCR+Cv6e17K16h0v1EWlLgebhjyDC58b6cxA7LdhnvY00LV+VDs/2QFUzO?=
 =?us-ascii?Q?oAg58Hloy+Q5gVEp5xPCkT2gJ4eff7ctDzIt0OS5qvxZ6NRG37mTa6GbJm/h?=
 =?us-ascii?Q?ShOF3vIGrl9k3gVqGOcxe1pBVF+kv66IMvc1SqTClTPXwJTJvBYmhv1S5jZ0?=
 =?us-ascii?Q?MbeKICKMp7ujtGwwFPPD6rWlxOQCUyr4Q091Ux2U03IGizXKUJzYKTLM3hrO?=
 =?us-ascii?Q?hgshk5F02au4QKIC7JxQaKz/T2pn5LBeDTnEg3jQQWXNccvg/GPYzctQytJ8?=
 =?us-ascii?Q?6o8EVJ5W/1R5PvULbIynqRHbukY2Om71AiAZcPQXrPFhpy/qTpiUqGcGXSy5?=
 =?us-ascii?Q?wXqnb1KGQKBMqtXnoH7fYIHsCMX3Q+7DX5pnzdCLfBaikUUs3g1d0fv1Nn1x?=
 =?us-ascii?Q?6TpxzSWWJmfLttT9QgN9UcrT24Irlc+XJk27WviCipccnBNpgst1s1sdoeKo?=
 =?us-ascii?Q?u6vOL93uW11+ZoS5PABHly9K5p7f2qz4IPBU+9Hf0jX5Hg1SfsPhd8BOc9Aw?=
 =?us-ascii?Q?8u6OE71Q7zfRHzDdy56peMXLBdR/JiePS/rBXLL1kXmbQAAN5k4DXpvGA79H?=
 =?us-ascii?Q?dYoVws9Lt7kalAINccWyp0QARN1lRta6tkuwQfg7bY+znoh9ZFdXFQYvy9Oh?=
 =?us-ascii?Q?6oK7fTGxglEhyclH/WXN5cafJdMlhmNYjM8KQG1KJwe7nZ5Sw3PyLyi8BYCh?=
 =?us-ascii?Q?9/l1+jFZwYB+TuPJZ59qtSmfrHz97Qg+5RfI1KO7CdgBE+Yb/ABGou2gbYV+?=
 =?us-ascii?Q?+A6jzEatkgaNSxjDvNpHbiSMS7naeG4SeiFSzWAKU7KIofqEUWUva1Hdj2WL?=
 =?us-ascii?Q?p8gkVtLL3/5GHGurSBytAWT/k/TX9+VVBoOSYW1tqY/BIP3zhDcVOn/x2hX2?=
 =?us-ascii?Q?42oAHirkIuZrhkC1+iu4Uxk16qcZNuO0/6dA+wNN98juFEIrz9++tAJUnwYP?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be8fe04-f1ad-4e9d-1939-08de229eb653
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:23:39.6789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMe34il84rXQvCmH1tS6IaONKFQW8gZ5GHjFjooB4WwVzkbVSNqHTF/fbiiVtblQL56ejWC+TstpFmssBUh2JYqvHv1nPe8tyiLEluOUCgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7214
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
solutions using GENEVE tunnels as specified by RFC8926.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_flow.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 3d2ccdeb92..fc03489511 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -2825,6 +2825,23 @@ enum rte_flow_action_type {
 	 */
 	RTE_FLOW_ACTION_TYPE_NVGRE_DECAP,
 
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
+
 	/**
 	 * Add outer header whose template is provided in its data buffer
 	 *
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

