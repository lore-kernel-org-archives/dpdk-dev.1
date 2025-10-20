Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D5CCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B3340ECF;
	Mon, 20 Oct 2025 18:44:16 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 8A3B740E4B
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNQ94DQgt8a4LIdaRtBYSeLwvBNXQIfPlV/3XPWBD0Vi2ssEvKms/uTLjTwUDiknwfYXMlOY2dr/YjbVSi9pvoBPkl1uPh9LiRV3lVCpChgNj3T7cAEPvSdbexITrmTRHA0KMiNl4P+TCme0Xl7Sst0OoDoGxLh3PDqTwJh3LJ/RviNyb+3rj4kvVKqJbvBTpetr1eJy//GfDPWDPLTpzpRthOJkqeTGRkKLAB0dr24Wu3MfHBSATlkbXyULoEFr5FXqK1ESQ+r+GKXT1j/y5bGkj5NLf97RTmnM7OI4hRHeq9qXKK8LszTw4JoQUA9jFtdYylWHTaS3vEjT0Y/Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFkCMHpxRiIrZy+wZTdzqf9X6EjT9gk8nBpJYxhWH6w=;
 b=hzM+rbinSat3hvcjEjuwHKz5mya3VV/Z3HLji3ZNUvVApvzoMxqXuxN2/tVS3V7x4HAGS53OCOhbUb0kxzhzFViDW6BHP9yayWyPoWOpfvCwX6IReqwTge+hGb8ewuPsbyyz93Op/oOdgRW/JPZsqG5JQTC/Gh8GTNm0O2czOJTbeWQ/+Ut95oemmREV3YY2u00sMinPlC2QoFetSOGpVlXa0CZ6M+SR74TVpj0Nfoy42O0g4FaRVcXXEMsF9v17UBshD2CQkKZZYGEdT+3M54x9bqT9CBnIHMcNGvsLR26USKOlNtCZ6XheW7QXwrVzVwnfh7cz0R3vJJPsN/mX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFkCMHpxRiIrZy+wZTdzqf9X6EjT9gk8nBpJYxhWH6w=;
 b=WiI7QtWPg8XjO5JcziV5KpWvgNk8l44pxwT/h5aRhUTR2ah20BZPnINqgAPXazUbd4SzbBYPbNyV4WD8Vqp4p51AkWtySx5T93e55NQsGm0D79YKvy94bNHyAFGrey8VtWYrwNBj/6gAnSD9/KlIqKP2v1B3Luq9FD6ff6YqmCc=
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by DU0P190MB2386.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:5a1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:52 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::11) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:52
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 17/21] net/ntnic: extend flow dump with MBR configuration
Date: Mon, 20 Oct 2025 18:43:26 +0200
Message-ID: <20251020164336.283664-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DU0P190MB2386:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d1e51d4-5b56-4aff-bcda-08de0ff7da4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i1hUZPwU7IWsfWG/iUF+OJoso2TMf04rQkvt3fgrBczgsfClpoB3iZrPc+YC?=
 =?us-ascii?Q?RnkPYpsyuonURrML6KMbhZnRbh6qCN3knB6e/21OypXTkBvgA/y0g0W5UmRq?=
 =?us-ascii?Q?Bw8XgGEYzdM/7NpYRY1ov3Ezr1n/hg8Ep2AMvfKqALM26qsHJHUp2lvZ/wxg?=
 =?us-ascii?Q?gkwRTyltiWKC1lOhXzFWLqkU3N/G8wItlRpl8dEFLpFxIOeOwst2YpILZV11?=
 =?us-ascii?Q?IDlIpBJjaWBofDQ9R8+UBsjSBPhne9/fI9Ws43GKcip2eAsd5Iik3AVa3hPa?=
 =?us-ascii?Q?1BwNcISC8jzyIsQnTpEWjaqWlh8HKcC5aYHWdSC2ig9Ri7PVy50MW3D6TuAP?=
 =?us-ascii?Q?ygv2yXMPGu6dLTydjfnv8WGNcFv5YtyminZu9qhtVDEfyDmKoB5L1CvvF0Dj?=
 =?us-ascii?Q?dxhDKOVHmQhPxDY6wqXyBghxfzFEVBEp20isqnq5xPKY1OEJMSugVvHw4def?=
 =?us-ascii?Q?w8EjsU7xYfeabC8i+MBD1l/bTph2flWgGb6/idDopZli9Xd6RFpl9qtSRpzK?=
 =?us-ascii?Q?t3ziEImvHhswxwgLGoBWxRcRMDyFGonz/yiDyRLfbZ8+V8C3+EN0/5Ak6WP6?=
 =?us-ascii?Q?OxyXM7ctMhC1IBoNlIoosYeYh2VLnboE1u/OS4yl+94bH87d6UG+w94V1x2A?=
 =?us-ascii?Q?h/yJVlwJID+HJJAGzdq07EOW4RhC8+fSG2v2iBhutc/fKMsWsjak7rzEgBLN?=
 =?us-ascii?Q?Lcdgu4O0rxGO9J2Og1J3c2WXLBq92MYhKhJq5/zdtTmNP0Rhqqt6vLUp+/bG?=
 =?us-ascii?Q?xmSQbzXmiIpanLRQCC2sBblgA2YZgAPl7OeML9zXU9Ze9SjXeMsZBgZabsT+?=
 =?us-ascii?Q?OYcM9Sgq9QQFGCdyklMEqzjD33YNmsbGEjl3UJxhfLOpQjgSl7B8QiErYIkj?=
 =?us-ascii?Q?mYKjA9mOou5dYjn7T1k8pQNw0YZibYCdt6lSpV0SRHXFzdExiyl1nI903gkf?=
 =?us-ascii?Q?gNlwMMrpsvvQXxN8QHE0lL/3bitDZeF4j0iQHLsw+XC2nznJVWSgqzgDBlHc?=
 =?us-ascii?Q?ieUOz/PNjPvliwtrGlDSzJN6N8CF0kfRo9O18jmUdMExtW27NmyJh+6WpRhu?=
 =?us-ascii?Q?WTL+wFvsuYwuc6rJ6tgpjI8w6UBeSQIrTz2z1JJuQFHYWgQHiTkZlkPk5Mcm?=
 =?us-ascii?Q?5MABoCEc0pndGxzqjib9ivpRJEuCk6fmx27tnYCkn0It+dz1s98KcYPOWzrN?=
 =?us-ascii?Q?hb1x2F5TTFeVZ141PzJzHH9F7b6tMpe8pN6ltE13qMWWGnypgJlnMjbsdhNX?=
 =?us-ascii?Q?vtQN7I9L0Gjfpy/vZoemOkbIlaoJ4L+o8DvvSVZI5245sOvrLlOnwbyBCMxz?=
 =?us-ascii?Q?OLdL9op6zm4+Pcgke3vDMdxuUpWgNUNmJ2M3jzyjtae76VO6tDiZQJTh9c9/?=
 =?us-ascii?Q?omhcfaPmlHuvQjk9f875+2TyRVfH7D97tT7uzY2fSzcs935yrUcCvnWjgLqj?=
 =?us-ascii?Q?1ujGKv9vbGDEETkK7D4LMy01kGQiSTvqhqaC6+txd2U/5HkL8yp/qm5nO0CO?=
 =?us-ascii?Q?2GhdHrK6rQpheZMKQL7voPL63CPMjf4lpBLwl2N7cQosMBcD7SRgWdNytp83?=
 =?us-ascii?Q?bbGLZ7IkJXvrgU6pq1U=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6tRdQ+/uYa9sDkT/nZa9Io7f/BpRJQB90l1Qw0KA3RBPgkeDciAm8CojMqySbOsrkm7kht61liGZMpAXr1Gm6z1w5hSawm2rtw/N2gwvzwPR+o7Fcch38+SKEMbb76nFFsSNpS6uO2tAGu9Yx0cEU3zcgvnWYk3cdvuTQXmfUzlQ+mBeUH5WWy9v61S0bzEbsZsj1m2ccj5tVH4UA7rNzbR4gz4dr7VGqO7jqbENorXcDMdghY2Qv1o49+GRjGsnR3hgF3oW93FQPhWak4ZydTmVyNoEuD+77b1h21i4Y3lmO5wAy25j4dNAnHR0uMyHcH2G8ACPx/8sCgOjs5oJsfrKeb5HJ5/7isdwJWNodgFF+gDIqfsY1/aRgXp582/6z5iouAoG3lzOD2+oCXVenrWCChqjXk8GfyTDTG9DsYoYw9MqsdoCkpk3ZQ96d5CeLSJT/VerJVZ+xvFn/ZcKvIQY4lIZTlbTO57aLAFsMGCRKPzK7hYDlSIue/jftDCEJLNGPKRf7TCvh132ze7JTJ03k6Wqc8wdWXvetqAnsoBjYQaogehTC+p1vsc0rmhP0Kxx7o9NloKMWG1FA7xgtsZEEw0PuRPR4D6ZoigFVIK5bBfiMhLJJM9TbA1ebnORgraPB7OL0wgU7nOlVgUVj2uW+gjScflxf2nAJGbqZ+I=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:52.5385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e51d4-5b56-4aff-bcda-08de0ff7da4a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2386
X-BESS-ID: 1760978634-311284-32701-8334-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYW5hZAVgZQ0DQ1NcXcMtnE1D
 DF3NjM0NQiycIiLdkkxTLZzNI8xchIqTYWAAXbMqlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan16-189.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

add dump of MBR init configuration and extend dump of MBR rules

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../profile_inline/flow_api_hw_db_inline.c    | 36 ++++++++++++--
 .../flow_api_profile_inline_config.h          | 48 +++++++++++++++++++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 17a0332a06..db40bfd368 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -23,6 +23,13 @@
 
 #define HW_DB_FT_TYPE_FLM 0
 #define HW_DB_FT_TYPE_KM 1
+
+/******************************************************************************/
+/* MBR Configuration support                                                  */
+/******************************************************************************/
+static int8_t hw_db_pkt_layer_dyn[] = NTNIC_FLOW_MBR_PKT_LAYER_PER_GROUP;
+static int8_t hw_db_pkt_layer_ofs[] = NTNIC_FLOW_MBR_PKT_LAYER_OFFSET_PER_GROUP;
+
 /******************************************************************************/
 /* Handle                                                                     */
 /******************************************************************************/
@@ -533,11 +540,34 @@ void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struc
 					&db->flm[idxs[i].id2].ft[idxs[i].id1].data;
 			fprintf(file, "  FLM_FT %" PRIu32 "\n", idxs[i].id1);
 
-			if (data->is_group_zero)
+			if (data->is_group_zero) {
 				fprintf(file, "    Jump to %d\n", data->jump);
+			} else {
+				uint32_t group_orig = 0;
 
-			else
-				fprintf(file, "    Group %d\n", data->group);
+				if (nthw_flow_group_translate_get_orig_group(ndev->group_handle,
+					data->group,
+					&group_orig) < 0) {
+					fprintf(file, "    Encoded group: %d\n", data->group);
+
+				} else {
+					fprintf(file, "    Group %d, encoded group: %d\n",
+						group_orig, data->group);
+				}
+
+				const int dyn_group_orig =
+					group_orig >= sizeof(hw_db_pkt_layer_dyn) ?
+						hw_db_pkt_layer_dyn[0] :
+						hw_db_pkt_layer_dyn[group_orig];
+
+				const int ofs_group_orig =
+					group_orig >= sizeof(hw_db_pkt_layer_ofs) ?
+						hw_db_pkt_layer_ofs[0] :
+						hw_db_pkt_layer_ofs[group_orig];
+
+				fprintf(file, "    BYT dyn %d, ofs %d\n",
+					dyn_group_orig, ofs_group_orig);
+			}
 
 			fprintf(file, "    ACTION_SET id %d\n", data->action_set.ids);
 			break;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
index c665cab16a..4be5740f1a 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
@@ -93,6 +93,54 @@
  */
 #define NTNIC_FLOW_PERIODIC_STATS_BYTE_TIMEOUT 23
 
+/*
+ * Protocol offset for packet bytes that should be used for calculations.
+ * The number of bytes (N) used for counting bytes in the FLM is determined
+ * as follows:
+ *
+ * N = FrameLength - NTNIC_FLOW_MBR_PKT_LAYER - NTNIC_FLOW_MBR_PKT_LAYER_OFFSET
+ *
+ * The frame length includes the FCS.
+ *
+ * 0: Start of frame; always zero.
+ * 1: Layer 2 header.
+ * 2: First VLAN.
+ * 3: First MPLS.
+ * 4: Layer 3 header.
+ * 5: The Identification field of IPv4 or IPv6.
+ * 6: The final IP destination address.
+ * 7: Layer 4 header.
+ * 8: Layer 4 payload.
+ * 9: Tunnel payload.
+ * 10: Tunneled layer 2 header.
+ * 11: First tunneled VLAN.
+ * 12: First tunneled MPLS.
+ * 13: Tunneled Layer 3 header.
+ * 14: The Identification field of tunneled IPv4 or IPv6.
+ * 15: The final tunneled IP destination address.
+ * 16: Tunneled layer 4 header.
+ * 17: Tunneled layer 4 payload.
+ *
+ * Default value : {0} - to count whole packet for all groups
+ * NOTE: In case that value for given `group` is not defined, then value for group 0 is used.
+ *
+ * Example: {4, 13, 13}
+ *  - count size of packet starting at:
+ *    - OUTER layer 3 for groups 0, 3 and above
+ *    - INNER layer 3 for groups 1 and 2
+ */
+#define NTNIC_FLOW_MBR_PKT_LAYER_PER_GROUP {0}
+
+/*
+ * Offset relative to the NTNIC_FLOW_MBR_PKT_LAYER. This is an 8 bit signed value.
+ *
+ * Default value: {-20} - to account for minimum spacing of 20B between frames for all groups
+ * NOTE: In case that value for given `group` is not defined, then value for group 0 is used.
+ *
+ * Example: {0} - do not apply any offset for any group
+ */
+#define NTNIC_FLOW_MBR_PKT_LAYER_OFFSET_PER_GROUP {-20}
+
 /*
  * This define sets the percentage of the full processing capacity
  * being reserved for scan operations. The scanner is responsible
-- 
2.45.0

