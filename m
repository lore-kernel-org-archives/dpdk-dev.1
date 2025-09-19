Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D72DCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D5CF40B9E;
	Fri, 19 Sep 2025 11:20:32 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 3323A406B6
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:25 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021102.outbound.protection.outlook.com [52.101.70.102])
 by mx-outbound12-166.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5CYzegyPYNZPA8+nrylzPHZA6j3k41tWzdBA7p/UoTztFEbwsk4NbUdorBHztQ2QQMuJtj1Oz0kU4m9CumjjKC0zbv9zkihsZ8cNJQo67K4KpqwPQp9V9KuG95KP1NpacT8WwZLIBsdxwlucJ/XajIl8zcJCq4Wp0eAiKQz5ZGZZk96c7V/9ajqjWNTTfKe27Y0jCwSZ+VZnF/NEm/FoKonHnFRArVffy7lbD83d57ZGntYYJkT/x5Y6IdMHgK5eb9pcUHXA/uCGrlKIgK4z0KguKxkcxSuWclEhq9YLHNPMlo0iaNvM4mOK4ZmF8CHiM5GsEmNYSoGVDy1Hd1sTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eaj+NpO+W8Ubua/Tocy1A1FIEVjaNPf/8N4KWZBcyA=;
 b=AY8qf5MX3lgFuGnJn550XeJuCWXD2C02CfvnELMobF+6BbuzRS8z+470prdfr0TNb4CKVoTAqFq02rZSrDvhaA0u/uZIM1GHO2oTJVaujFpxM7xLspavG+vCasoRkHMcjshn+Hk3wPNNj79PHMKSoxL9n1R7A8xbBefJNY+iUP3ALPiEP1tXD4yrey+dbIV2QdOqUWttiGdtx+gV9JkqRUoWCjSLbQpJgVa4PSSosgtNl6PrTQc7YLlGnJMKlp748z1qkRr8t2WvILiPfC9JgMOS7o/CfYYotnMzcAENxa2HPyHHlvGfgXHZjk2bUXIx5VRMZox2kjXp9udj03e0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eaj+NpO+W8Ubua/Tocy1A1FIEVjaNPf/8N4KWZBcyA=;
 b=Zm1k/wncDHBjbzQvXMf/LyJzXGX/3SC1PfZ0WC7ROQGm2u7yiQ7VbypbVzlWvklglIR4v5Du4FrI/6oorBpL/BuJ0SRAjOf8BZv5NEjnMSvFzrelbUOH5OstK/Z3POLAXi2GiTjcQBZy8yKSS03eARlp02kAEA+IxifUa7KUuCM=
Received: from DU2PR04CA0352.eurprd04.prod.outlook.com (2603:10a6:10:2b4::23)
 by VE1P190MB0829.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 09:20:21 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::bc) by DU2PR04CA0352.outlook.office365.com
 (2603:10a6:10:2b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 09:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:20 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 11/16] net/ntnic: rename common hash and flow functions
Date: Fri, 19 Sep 2025 11:14:56 +0200
Message-ID: <20250919091504.1548351-12-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|VE1P190MB0829:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c4b9fb8-9ba6-4859-14de-08ddf75dc19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/tZEQO9I2XokWBNZ39tQXZytDx0IkdKlebq7NVIFEzPtYdxg8UlttbzqXEOV?=
 =?us-ascii?Q?iA8kPEPyN5IZaXnRHcg92Iz+QZ9MNVrJU7dkYmOODkSj8OemvdLVOZlHRShK?=
 =?us-ascii?Q?p0nfdJpYm+57HPyK150HBJnK2920a9q/ClrdE225z5RgNqlfz8qV3xItfQdZ?=
 =?us-ascii?Q?zrOFmKaWfFeWQHPvZ3l2Cq0VHYn9H6QUN0lq8n116Wn3wLou7Ud8saM3P3ck?=
 =?us-ascii?Q?wxdyb63SWlOLN1AjtEv9us0+Zf/A3lUTlMv3UWkT0vmh1Zn8Wpk3OrLEkeJL?=
 =?us-ascii?Q?TTfK1vKLfmwm8IVBGzBhiV4SLwecABlo5hMsRH2MVqx8cQ9+0yUCgcOpyU/x?=
 =?us-ascii?Q?A7E4ZVdWIh/o7RWXJHrpinT1wcGp69yBPF22o0DW6EgRKYpn+YotKjZ76bHH?=
 =?us-ascii?Q?BT/Y1ps4YlVh/lWbc/6lZOWS9HDMw4XMDmYpHUVlix/wQNS40LETkuBOuqy4?=
 =?us-ascii?Q?jvm0A/d10E0cDkvYiE0/+33/W5Lv75zdhRUpbcMFEy2XJhdz1DuDeNDpyhNy?=
 =?us-ascii?Q?9UBJAp2zvPELj2JYsvNiD+zApzDcedJb8QRAPPhdQyvt0lSi0O/BtpCgt5Gn?=
 =?us-ascii?Q?0GUXR5SYzXL4OKEnqFfeFqlMhw4en2FPds8wOP+Cc9WShu6ioQqmAWXJhp99?=
 =?us-ascii?Q?K9O7H9wvNqafS11ux88RPt29+4Tz87LQnJInZiqt9uG6a/8x6kpaiXRieQtT?=
 =?us-ascii?Q?ADIndEH+qUnYlCHF0kPzZzHAnnQ7dKBT0tL81JmNUr7mjU8jdIEQBWSElFyj?=
 =?us-ascii?Q?6CICzR7WeZ4GdZAm/fmuPF0StXK/vfKK7ZmEQUve/AKD5r8BVPuEQi45ZQrQ?=
 =?us-ascii?Q?MRUiZdAI1Wc3adqXNJAu3lesq0IhZKS61sBVvG0volUjq/kW2C6HD+/RLubI?=
 =?us-ascii?Q?etdlRrm9V3YoFksVMO1XDvFMcgRbxqpYz1wQQtNZExMzNMAp02SIjvtuTwa3?=
 =?us-ascii?Q?SsKaXqFoRS7d26ByiXjdBjZ4kEVNDWGX/cNtHuGaSbbVX4urE4tKpZHw2pw5?=
 =?us-ascii?Q?pIWSrevCUo26qNWdXhHt+T5+uQ38F65sj4JAQnF2t97c4mKZuzlTlc9rl0mu?=
 =?us-ascii?Q?jGqYmoStQ3JVoYo7QFPGg4OmgREu2dKQE/M8+Ke3RJ6jF2nATWzIyp0DCe7A?=
 =?us-ascii?Q?SkwTr39yC9cEB+cTa4fVIo5LtIDymHvkBB0jPzTVNVgnOs5exFEn5XtY2S+J?=
 =?us-ascii?Q?MCSlWfX038zFlwXIVIxWpen4nLVw97kFitMGAbrLfV1pr0kfOYVsxJSbMMaY?=
 =?us-ascii?Q?bcAuC+8Y5Cs56U+ounRWPsaylHXAkPAWU/A37WAXvJWtLg2/rBhms3UqCb4r?=
 =?us-ascii?Q?4vPp19E8o/H5B/WfO8okjXstqN0qngsN9xgm3xsdQTWmOFZgoI0/PmaIqv+4?=
 =?us-ascii?Q?00Dl3X2GjNz5Bvmu0XdaJ7P6uv7AEADk7Befisi//1Z5ti+yMXwDL6HTUQ6K?=
 =?us-ascii?Q?4jew3PluAmwDtPIomiQZ7+bYrCTRdsbippjDuYyxJvttQhMZeYFQQ+pWvpjw?=
 =?us-ascii?Q?GEBcnWmGJ6tTIS+zRX3bGWTLt4VLjTfq+VGz?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +tXfAfksQjDYaoLjWtUt//LJJb8etXwjQTRhbvTTbw3GtMQwpPXoCYyVW9vCCDJEmSqrxYbsz5JDnVi2EnxnZRtCJUGbCejlqPJOxuCutX+a2WxaVrtSmMOhAZA5BCMkIGlrZ9xVP9NEQurfBtf5OmfWNhiPNiV9h5vJISTsRhXfppEQfaamwyKv3sRCE1qLG15J+bfxpa3OHbguaI4OXK2w8EG5LglR8EPHZ0m80o0iOnmhPD02F2lAftGHgA2Gb5+1igJ/wJcOSG/dTYW95GHZMEBQ4Ds1lPbNC6C2YKii7VqlmcOWHWSbT0Tcbd8Ub6KcrS89RoBj0ZReThn5fBPfOvi4mTgKbp40SQAFV24uDuVufce7XHDsbTjwomTE/nqo4F5bkfAuv+PVZLclFcy9i4D5n+zjxXXKTtRj39/l1bG2aJ/O7Pl3DjdI8zgYn0UdD8befqt3/YbRMUixfp/NjUB+DYLprFk4mLG/Ur+O1aZa27l4GHrgTOhYntZYB8eEQPbRMJbsM7DM4K46rVjF0j1w2wv2KdmWMQxVl2bKXYRwQsWfA+hcGCj6OMgX4rmT2Jaes9KDqVp/gKAt5ypQrhbziiOEm+3/xseJVIjk3gJUwD9CooAjarrXahdyZE9upP7Ky4vzaDuhXMywTg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:20.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b9fb8-9ba6-4859-14de-08ddf75dc19e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0829
X-BESS-ID: 1758273623-303238-7633-1134-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGxpZGQGYGUNTA0tLSwtTQ1C
 w1zcLUxDg5ycgkzSTNLC3VwNwk1djQUKk2FgC43SFpQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan21-180.eu-central-1b.ess.aws.cudaops.com]
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

Rename common hash and flow functions to have consistent naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api.h                 |  8 ++++----
 drivers/net/ntnic/nthw/flow_api/flow_api.c           | 12 ++++++------
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c       |  8 ++++----
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h       |  2 +-
 .../flow_api/profile_inline/flow_api_hw_db_inline.c  |  4 ++--
 .../profile_inline/flow_api_profile_inline.c         |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                     |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 582de3b281..869158258e 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -56,7 +56,7 @@ struct nt_eth_rss_conf {
 	enum rte_eth_hash_function algorithm;
 };
 
-int sprint_nt_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask);
+int nthw_sprint_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask);
 
 struct flow_eth_dev {
 	/* NIC that owns this port device */
@@ -171,7 +171,7 @@ void nthw_flow_nic_set_error(enum flow_nic_err_msg_e msg, struct rte_flow_error
  * Resources
  */
 
-extern const char *dbg_res_descr[];
+extern const char *nthw_dbg_res_descr[];
 
 #define flow_nic_set_bit(arr, x)                                                                  \
 	do {                                                                                      \
@@ -199,7 +199,7 @@ extern const char *dbg_res_descr[];
 		typeof(res_type) _temp_res_type = (res_type);                                     \
 		size_t _temp_index = (index);                                                     \
 		NT_LOG(DBG, FILTER, "mark resource used: %s idx %zu",                             \
-		       dbg_res_descr[_temp_res_type], _temp_index);                               \
+		       nthw_dbg_res_descr[_temp_res_type], _temp_index);                          \
 		RTE_ASSERT(flow_nic_is_bit_set(_temp_ndev->res[_temp_res_type].alloc_bm,          \
 					   _temp_index) == 0);                                    \
 		flow_nic_set_bit(_temp_ndev->res[_temp_res_type].alloc_bm, _temp_index);          \
@@ -210,7 +210,7 @@ extern const char *dbg_res_descr[];
 		typeof(res_type) _temp_res_type = (res_type);                                 \
 		size_t _temp_index = (index);                                                     \
 		NT_LOG(DBG, FILTER, "mark resource unused: %s idx %zu",                         \
-		       dbg_res_descr[_temp_res_type], _temp_index);                               \
+		       nthw_dbg_res_descr[_temp_res_type], _temp_index);                          \
 		flow_nic_unset_bit((_ndev)->res[_temp_res_type].alloc_bm, _temp_index);           \
 	} while (0)
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 4d1c9c8d7c..dee2ee137a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -18,7 +18,7 @@
 		name, #name   \
 	}
 
-const char *dbg_res_descr[] = {
+const char *nthw_dbg_res_descr[] = {
 	[RES_QUEUE] = "RES_QUEUE",
 	[RES_CAT_CFN] = "RES_CAT_CFN",
 	[RES_CAT_COT] = "RES_CAT_COT",
@@ -41,7 +41,7 @@ const char *dbg_res_descr[] = {
 	[RES_INVALID] = "RES_INVALID",
 };
 
-static_assert(RTE_DIM(dbg_res_descr) == RES_END,
+static_assert(RTE_DIM(nthw_dbg_res_descr) == RES_END,
 	"The list of debug descriptions is not fully completed");
 
 static struct flow_nic_dev *dev_base;
@@ -212,7 +212,7 @@ void nthw_flow_nic_free_resource(struct flow_nic_dev *ndev, enum res_type_e res_
 int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "Reference resource %s idx %i (before ref cnt %" PRIu32 ")",
-		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
+		nthw_dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 
 	if (ndev->res[res_type].ref[index] == (uint32_t)-1)
@@ -225,7 +225,7 @@ int nthw_flow_nic_ref_resource(struct flow_nic_dev *ndev, enum res_type_e res_ty
 int nthw_flow_nic_deref_resource(struct flow_nic_dev *ndev, enum res_type_e res_type, int index)
 {
 	NT_LOG(DBG, FILTER, "De-reference resource %s idx %i (before ref cnt %" PRIu32 ")",
-		dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
+		nthw_dbg_res_descr[res_type], index, ndev->res[res_type].ref[index]);
 	RTE_ASSERT(flow_nic_is_resource_used(ndev, res_type, index));
 	RTE_ASSERT(ndev->res[res_type].ref[index]);
 	/* deref */
@@ -494,7 +494,7 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 
 	for (unsigned int i = 0; i < RES_COUNT; i++) {
 		int err = 0;
-		NT_LOG(DBG, FILTER, "RES state for: %s", dbg_res_descr[i]);
+		NT_LOG(DBG, FILTER, "RES state for: %s", nthw_dbg_res_descr[i]);
 
 		for (unsigned int ii = 0; ii < ndev->res[i].resource_count; ii++) {
 			int ref = ndev->res[i].ref[ii];
@@ -983,7 +983,7 @@ static struct rss_type_info rss_to_string[] = {
 	RSS_TO_STRING(RTE_ETH_RSS_L3_SRC_ONLY),
 };
 
-int sprint_nt_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask)
+int nthw_sprint_rss_mask(char *str, uint16_t str_len, const char *prefix, uint64_t hash_mask)
 {
 	if (str == NULL || str_len == 0)
 		return -1;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
index 76ff79cbe1..9a7069194b 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -130,7 +130,7 @@ static __rte_always_inline void unset_bits_and_log(uint64_t *hash_mask, uint64_t
 	char rss_buffer[4096];
 	uint16_t rss_buffer_len = sizeof(rss_buffer);
 
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
+	if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", *hash_mask & hash_bits) == 0)
 		NT_LOG(DBG, FILTER, "Configured RSS types:%s", rss_buffer);
 	unset_bits(hash_mask, hash_bits);
 }
@@ -141,14 +141,14 @@ static __rte_always_inline void unset_bits_if_all_enabled(uint64_t *hash_mask, u
 		unset_bits(hash_mask, hash_bits);
 }
 
-int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_conf)
+int nthw_hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_conf)
 {
 	uint64_t fields = rss_conf.rss_hf;
 
 	char rss_buffer[4096];
 	uint16_t rss_buffer_len = sizeof(rss_buffer);
 
-	if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
+	if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", fields) == 0)
 		NT_LOG(DBG, FILTER, "Requested RSS types:%s", rss_buffer);
 
 	/*
@@ -645,7 +645,7 @@ int hsh_set(struct flow_nic_dev *ndev, int hsh_idx, struct nt_eth_rss_conf rss_c
 
 	if (fields || res != 0) {
 		nthw_mod_hsh_rcp_set(&ndev->be, HW_HSH_RCP_PRESET_ALL, hsh_idx, 0, 0);
-		if (sprint_nt_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
+		if (nthw_sprint_rss_mask(rss_buffer, rss_buffer_len, " ", rss_conf.rss_hf) == 0) {
 			NT_LOG(ERR, FILTER, "RSS configuration%s is not supported for hash func %s.",
 				rss_buffer, (enum rte_eth_hash_function)toeplitz ?
 					"Toeplitz" : "NTH10");
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
index 38901b3e8a..124225c455 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
@@ -11,7 +11,7 @@
 #include "hw_mod_backend.h"
 #include "flow_api.h"
 
-int hsh_set(struct flow_nic_dev *ndev, int hsh_idx,
+int nthw_hsh_set(struct flow_nic_dev *ndev, int hsh_idx,
 	struct nt_eth_rss_conf rss_conf);
 
 #endif /* _FLOW_HSH_CFG_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index b1a2d9dfa3..5de4f6bae7 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -598,7 +598,7 @@ void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struc
 			fprintf(file, "      %016lx\n", data->hash_mask);
 
 			/* convert hash mask to human readable RTE_ETH_RSS_* form if possible */
-			if (sprint_nt_rss_mask(str_buffer, rss_buffer_len, "\n      ",
+			if (nthw_sprint_rss_mask(str_buffer, rss_buffer_len, "\n      ",
 					data->hash_mask) == 0) {
 				fprintf(file, "    Hash mask flags:%s\n", str_buffer);
 			}
@@ -2830,7 +2830,7 @@ struct hw_db_hsh_idx nthw_db_inline_hsh_add(struct flow_nic_dev *ndev, void *db_
 	tmp_rss_conf.rss_hf = data->hash_mask;
 	memcpy(tmp_rss_conf.rss_key, data->key, MAX_RSS_KEY_LEN);
 	tmp_rss_conf.algorithm = data->func;
-	int res = hsh_set(ndev, idx.ids, tmp_rss_conf);
+	int res = nthw_hsh_set(ndev, idx.ids, tmp_rss_conf);
 
 	if (res != 0) {
 		idx.error = 1;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index e0cdd12626..a1f9e3addf 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3977,7 +3977,7 @@ int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 			.rss_hf = RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_PORT,
 			.algorithm = 0,
 		};
-		hsh_set(ndev, 0, hsh_5_tuple);
+		nthw_hsh_set(ndev, 0, hsh_5_tuple);
 		nthw_mod_hsh_rcp_flush(&ndev->be, 0, 1);
 
 		flow_nic_mark_resource_used(ndev, RES_HSH_RCP, 0);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 3f96a144c7..4812713bd6 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1770,7 +1770,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 	tmp_rss_conf.algorithm = rss_conf->algorithm;
 
 	tmp_rss_conf.rss_hf = rss_conf->rss_hf;
-	int res = hsh_set(ndev, hsh_idx, tmp_rss_conf);
+	int res = nthw_hsh_set(ndev, hsh_idx, tmp_rss_conf);
 
 	if (res == 0) {
 		flow_filter_ops->nthw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
-- 
2.45.0

