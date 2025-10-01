Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE1CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9900340EE7;
	Wed,  1 Oct 2025 17:10:45 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 6552340E41
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:40 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020124.outbound.protection.outlook.com
 [52.101.84.124]) by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtJROicHtd4igxIVtVTEGJ57wAblUz0aw9av4C03Enz7X0aSmH1oNpp5dMdxQUvYsz+0K+GZiiOybnKarGvekLz0erfXYLSyL6kjGXYZn3XAMEZiAWG5Y/Mpuv6yttkwsnCohQ1Vo8opAU1zX+lmjoddg4jP8zIopHBsyMlgWOPOYYx7Frcf+CrNNaaGDA5gx1Gcf6tf3l4YArR5KvxyfwMaTZ/z+J8Z+Prf9OWbONkHJU78ALlN/bYkr7fgc9s3WUcuBnfcIwUUatGFEhRQcrQvjk/em9xDiJ03DQZhqjDkSgNDLudpOquHIh1MXV9c1v45w1bYfvwNdJytyTt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFkCMHpxRiIrZy+wZTdzqf9X6EjT9gk8nBpJYxhWH6w=;
 b=bLB8dLn8qOFJj5dfrjxC07QpDM/g/R3AvG23HxJ22J0EGHHRU6zqNfIx7vMG7ee2PbNNP21F1UxzS9Awe1zB3isEg2ral6uB7/d0ooHei03rKCnYjhj3Spulf8j/AncTqv3M0TFetAO4xyeGX3RBtXBiQ1bNLRfWg707csTyX7H7BeEKpY5W9A37cFvU24he6KTh2VTh70bgKtqon2UcN9GI/ucbhbaYGfS3+MqhW+/Z8plZvELOl4jqSzBMPGguAhz9/9amiKm/SYpc4jEvjvoGNm3jKjoSQVZgu+/aiqSkNDIDBJWxsCmHB4uwTljU9rTo++z+2onS7Ny0htQmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFkCMHpxRiIrZy+wZTdzqf9X6EjT9gk8nBpJYxhWH6w=;
 b=bweuF8ZO7T0ClTHxJb9JS9DAZRg5yiAtHrwyH4SWebdGrh1qqqo2WSO0LYYx47ew+RU+qFgxdnYc6bVeF6YPi+lVdJokpVjG7UmqPwkp8hHgA6jedtgC3NZ+PJ4oTraAfMElMG1aXtVwgsTO1WpCXF3xolwHyrjBGaF2NWW0Ga4=
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by PA1P190MB2574.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:37 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::99) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:37
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 17/20] net/ntnic: extend flow dump with MBR configuration
Date: Wed,  1 Oct 2025 17:09:59 +0200
Message-ID: <20251001151018.250671-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA1P190MB2574:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a9b75902-cb26-4392-97b8-08de00fcad54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ene4Dz+SN3Pxc1/XI0UmF+Qe5ZHHVsAFizwTZ8gr4Pzl0kH0C6Fs7KuIPHzR?=
 =?us-ascii?Q?VZ6sbNFAL8++PoDHisNXSyIJGgZz6ApJ9VSeo+FwAIp9tRXzXTzPUGucnoF+?=
 =?us-ascii?Q?YjUIAieuLzHZm9rehhIHFaxllP90KOdPDOVpK4Rrn0aOtJa96aU5FPRw5SYb?=
 =?us-ascii?Q?/IsagJfIx97PmO1Ke1LS3sAsniNggcToVdm1o2rLORezdD5mBBwwMRYWUaIB?=
 =?us-ascii?Q?qUvOliueNc039bnydG6Oi1Bqk9hn+SAc/AZPCSFPQdcaOAQ3t+qprY8/Z7Xs?=
 =?us-ascii?Q?ep8H0593SV8325f/9AAMV96EU+18VSwbAVdmFLRYaDtUgsmMLssb0jS1akcd?=
 =?us-ascii?Q?XzeHqH7SuI2/43L/3Q7C4SlqPuYOVukwFxF3Fpn3X+qsGuk6/W5I7k2tHFnn?=
 =?us-ascii?Q?nzZjGpmc4B9lNq37f8frI2K+zPZsBBwL1IDL832qGOg5TaiCFDEKg4ZsUAHt?=
 =?us-ascii?Q?NKNDTqnltUDQM/M42mMGDDJZdDPeHbqePH/SxYGb7IzbhprJ4GlHGYEP3pe3?=
 =?us-ascii?Q?+VrhuIZzVbI66ADzY+eTJui0/jE2mCY27XD0e0SFLxyzYX5jlVUAONb24iag?=
 =?us-ascii?Q?teb+cwNngdJCmvxhuN/kP5dod6aPgp81IhkY5vpxLsCoQRRMhYfZK1FPOcjy?=
 =?us-ascii?Q?Ryk7m/Iy/sakCNBV2nUjNe4YeQDbGUMvK0Jx3GyxbFOzKBF/BTyM1HoPBQDw?=
 =?us-ascii?Q?79KEKdhmuCpfjvuchCuT0QBx/tdN9Pllw2WQfdjoSw7/C11VCjI5/BAQFVWL?=
 =?us-ascii?Q?llno2K+Z9waM/1+M/nVzvqFYaQXMey2NgurkaZPKDtVTXnpkJhfxg1c4oGtu?=
 =?us-ascii?Q?4ZBzqkN/es837bSCgOQYUGwC3OUfzxtAq6xLkGNd+DUIKZzwlbltwUD1gqm7?=
 =?us-ascii?Q?G8mCzz7WDbzMY5N8GKC5GnUQuX1Q+gkKJcus57TyxWv5TeDksF9P65R/QfJt?=
 =?us-ascii?Q?EqhIvdKMVrp5bwfHXUvTK/eDu+XTdswaZT4sTOy33r4bJUHUiIOhV1h5k6H3?=
 =?us-ascii?Q?zobOKtmPCcFEb3g3wYZY7wGW4WSAyBwjgET5y17xDG9ywgR2iXKa/TfKlg+h?=
 =?us-ascii?Q?FHLl+le+M+829zSzGbiDWns19jzjWRc3PhSp0GvTZ1uVDHLNMqYE8J/nuy7/?=
 =?us-ascii?Q?Oy1WwfaLNOh92A42dy8qbozsATyd9aNo0KtSQLJR7zROz/YT/Lc3T9p2y/Nj?=
 =?us-ascii?Q?BxTG1XNqO4lLSsdzgw2L9NYEjtkCgGvaXZ+bfBRFldVdI4IUrubGb5Sp+8i1?=
 =?us-ascii?Q?+uiTLPa74c2C+KHszLrIZ050yu6hg9bP/vNPVENngKsIgVY2efccgCsPgJr+?=
 =?us-ascii?Q?8sEzZQ/j7GSFvcf9z1c44zkGk7eQ2NRGl9UnDwFS5qSdz9Q8bNhYe4lf3mu/?=
 =?us-ascii?Q?slr+dzwkRtFcd4o0t2c6j4460xcQLWxpGGfgd6JXFbMiLRRbMyiFMfGhj1XR?=
 =?us-ascii?Q?YM12yTPiNGkzYDtn9QVqb/KEgb+lf33ckSDhtSe+1TY2Jp+GvBx3kdzwrCi/?=
 =?us-ascii?Q?dgI4fIGdZZ0E//218c4d4ba+CDV3ngIac38AfdxuiH7Y1bpKjYQRL658Soe+?=
 =?us-ascii?Q?d/cpSRE7tOSO7A7H0j0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RBn+AhZ7QeivQ/P/EkH0ZuAcwp4GAURJARxqT34tfdI6eYCVm+/bA49m1Ia6DMx/s2rRsOXuCpnOnTv3KkopJRSYebKK8KU0z9z57JqZra/HGMGPLu0a/h5mlr60cAvt0lw3YbPKWz4Z9JcCsvstbMVXGa1Pix07M2b8WDDlQwpWJGPBFpq66RVb8dbLxkx93DCaWVzeWGrIe6AlNv9Uh2g0lWfXZSN4E2r16EMdi4JdHJjkF4tEBGuV33hlRfMbR59IvWI4ei4D2DasDKdAkwsD0WQ6Pwjgl8zWQeoyKPe+AzfqaIf3XdI96J+YAmHNx1W+Uw2PpeLLh4egqA9xi2qYCy/APEeigod3D4lfBAKO6DvQFOR2sQI0GS/qD9oG0Xt5GxNETgQxed1J/ZnN0aA/VI4vPL8aOyTMMJKcbvqI/kk4m9qW+4ePlCEF149t7JqpErywR/+VuITNeVCCz/dqof2MQNEJQArujHwT7aTfZyETNcWHyYJWn2KhaK18jdYL2Q/iU46ZunqceS0M7s6xS213o9H04M4Ol7hqiLNJHniW6PFXgSYka6GqNEM/g73q9E0Q9Rj6dLQ4nz4g7YP7aPYj9lIu7JipNZmuWPKmDH07+nOToUOtp2msbkJMuUZJjWOA0V7jBzB3FHP//w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:37.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b75902-cb26-4392-97b8-08de00fcad54
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2574
X-BESS-ID: 1759331439-303567-7618-4438-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYW5hZAVgZQ0DQ1NcXcMtnE1D
 DF3NjM0NQiycIiLdkkxTLZzNI8xchIqTYWAAXbMqlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan13-152.eu-central-1a.ess.aws.cudaops.com]
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

