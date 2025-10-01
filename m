Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D24ECCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7E6540E6E;
	Wed,  1 Oct 2025 17:10:39 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 896E440E2D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:37 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020117.outbound.protection.outlook.com
 [52.101.84.117]) by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJethVbXJ3GtZ6/djIvgE7Qti+jnwqeSdf66pVloOIQytNb9BC1jkhnuw7X8WqunQGAFwY3ZoYXAJFUtnQbKD882+e4UfbQQp2/1h1A/UmdYulwbUMXQVKqskdmXq3ARgpMflNM+Ant8CA4D1jfHw/cpf9hlnZqWoMyGOgAkbdu1U+21yt5PNazDDoORBPq+X7sHSd2S8YiIORVPqb8ZaXJVihKwLPwMh1GkNFfUHvLD2Bw1PIGo130Bu2ljVw9hZnI+wP2REVLajm7zyT4YEYCt4Z8wEBSz7UdaI58RNrJKGIwIDJRn5imk2NTQbXgDyrnxOuxVlAfsnDByv/BqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtOe6+1wA/aHpTcZsMJW9CHuPEIcjVV5efxWD42a7xs=;
 b=PXqM9ePMdHzOO2P2LVry8ba6vbfrDVZBr/b6h/UMAx0UP/8l1GeRlRt2aL0848IcF9S4py731+3Bfb6ZgJteleQcql79VIDudyzyJu4CYje2A1YnvLA5LekzNomrPYfCbBv8oynYzH064gzXOC3mV8uD1kY+sh/T+EpRoZ1Zc5lvQMTTN/hMUmZElIUVFkrJdBJABiFozUfCITUpADQ/YIS9gToUpqHyfLq1jN/PMQBm/TYQSPB6xABd6+3ksf6BcbNeHv9hBjcSgHUF5RFFZRnCLK1ieDk+qTpq6aZRncPG1NjxR04fqATUk6tWsA9NeUB5bnpU2yg6rWg4gg0D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtOe6+1wA/aHpTcZsMJW9CHuPEIcjVV5efxWD42a7xs=;
 b=KdaiO3t/HytXu+9fvy1M5/A6x5UER012g6WwvIeLmYHahClCf6GDxHeDqb4Cdycr0Rb0O1DQKDZ8Y71NZ673o+KmqBlGm+ZQde0WzbE5UHoLNe63S/wt+5Q/KloK5YLrKq8dp2dMimt/vqYC+yyA5pVXUgVgDkm7lT8b8a77hEM=
Received: from DB9PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:10:1d9::34)
 by GV1P190MB1874.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:32 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::46) by DB9PR02CA0029.outlook.office365.com
 (2603:10a6:10:1d9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:31
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 12/20] net/ntnic: add support pattern matching on inner ETH
 headers
Date: Wed,  1 Oct 2025 17:09:54 +0200
Message-ID: <20251001151018.250671-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|GV1P190MB1874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 513a3d19-2a57-4443-3852-08de00fcaa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7YIvStQeG50imBa1tRvU9KP6LF3KesFQu71hnr1n66Mj+YEqEsRprFJs9GY8?=
 =?us-ascii?Q?p1265nveNope7wndwmp+pAcwNnO8cSVfKTll34BP5W3L64RWm8Z+N3kpB4N9?=
 =?us-ascii?Q?d2xu4x3mI4tX8NffJoRYlWCE4U3Jgv9IcKDVfNh4bTzO8EXMkT7xG/jnzTS6?=
 =?us-ascii?Q?G+pBDODRudHTsl6Ci9529iZi0L8dpZ3LYeYFDNE9eBicUUs4eGyyV3RI+dv7?=
 =?us-ascii?Q?UKchRGDeeuHzGU63nxyIdnic4iom0fNHRWTPPlAgD68FfDz0VkZNj/NqoYg/?=
 =?us-ascii?Q?vcg9VxUbuP2tVfs6+7o6ZF2VUj8E7x+jWJoknRIg9iWJ9GuI6swUoMQvygPY?=
 =?us-ascii?Q?QFS+9DhHZMZlhp0HENsIN64NHP1tbC2jAddE7K601DXrV4ylwEeiivSgPcOm?=
 =?us-ascii?Q?8obuBgi+PJfW+StrCZ/APABVm6Z1adh8oUxvxbq0d4c4vNTixV5kCd/8OoiD?=
 =?us-ascii?Q?eyjxCSqpE/kiT6AVsVSyf+s2SP6Q5+SwLpgEmRKjZ6AujrrKxvnyEJ0hl2RW?=
 =?us-ascii?Q?xuKL1+ELr6CQtNPTAizM+GFOKbF2HkQo6JI0q8xO5Ypd08NXkL3a7Ivnr1Ax?=
 =?us-ascii?Q?FUiuc1RjKMWUfyxzCJjMThKKY3B6/NTf8SAg/Emz0lnli6YZXzzH6t+wsAau?=
 =?us-ascii?Q?MRZ6DCJM2LLO7tWgWo1ijUzo11Q9u+7f/HWvAjBgyCrEJmkOKo7wexgpMc+5?=
 =?us-ascii?Q?/gEwzPfZ9Lje3IsS/MU41nBopnfK25uQHnockArsedF16hoyHOLVdvfOoQXz?=
 =?us-ascii?Q?vm/4hdka8CNTMBcCsJ1qqPJRTa50C6fYsAymKnE6EnDdv1wz6aDchG+t2S5o?=
 =?us-ascii?Q?E8HJyeOCG1eUEjmSZVg9Phpzv3r/ig4NPM8DaobWQKBbYk5yaIuP5JmL6mfj?=
 =?us-ascii?Q?BuE2kETsq6ShjV4c6O7/hmnnlOFcsmwBnSjwNQGsZq8n2hiGY5Y/n4UI7Nxg?=
 =?us-ascii?Q?DJYHdu5QxNYT5qjbHSIB8d9y3oVydPoANYMWvZDTllTcrVQ+yYpU5Shci0f6?=
 =?us-ascii?Q?81P6Yu5cNQSuWfakaYM0O4jgIXo8OiFYzWaKSokwyu9FySlcged4YMfTEKFs?=
 =?us-ascii?Q?ppqm07siQ8O212oU+vrxImWDAgVfipTm06YxyhBaSO+9yiRczkH/B6gjd6xl?=
 =?us-ascii?Q?94pbu8HWAaUgYf5KeFH/ZOcqAphF79qgFZoM1noMGUzG44LYtqmvcwQxPauC?=
 =?us-ascii?Q?4l44qFYkkisuHDfYIqZr0alJRoBPxFIlwDQG0O6A3e4dDNXDYNjpBrYjG1q9?=
 =?us-ascii?Q?+ybcCI6uacK8su5bbnbnpJIBjrZfY/fltb8COKaQqj4iYqrqTSsuonuYaNI8?=
 =?us-ascii?Q?dKJgHt+//CIu8WF3YiFSTNcTVhxkpT7+vd4VVPgAqdNu9CUbXHmgA7yuMBC4?=
 =?us-ascii?Q?4HhuOHm2FdydBDS1DQrcU5J6mSPIRuckfaT7PwmSJsFS6G+M3hqpZ8WGXRxn?=
 =?us-ascii?Q?ptJ6XnWjyqMABgj3FBmMRCGYMsphbQaoNr4FzChrlci2MtY2Z+0Py4x7rYN6?=
 =?us-ascii?Q?7WeLtzCi5gO2GWniP5ChlnANZ+Zxmh6jYvvZloSABOpONgZ94VTuXFzSB2f6?=
 =?us-ascii?Q?CwG7h3k79yDdB+mCMrI=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YjshRYX5HnaXwPGBc5Ft6BPfSuzPPSEPSc7yLCj1hPqZ2w2Xffbi8gbeJ+0nXWL+FaLnu1DbsbK6n91j7N3F/zD0VI9V69DDHdHdPiJQDhAuLmezcX8UeagkqnCvWEYhXZ/EV9XNi9vOYpPjIiatp/HXxJw45zxXzePJERI6rhT3op9wYBpUiCughd7H4pKtC/PVALqVtfyPEfvkQAtEljsImKvUkqzhn7Q41475S4NYDI7M5+X0hvJQUWK/78JZdBIjThEZH4LnuicSz4YLIa/vHJ/RGtC9YdwlOgmRymZSGKbTK66gJJNYIxFO72jtlsAZwCYY0F8FXaraS0mQhvhxyRVfq4146ldq3+Dx6VXCEL+O0FGUPgi03TrXXCQFiwBh1AuVIOH3uFsiH9CqRuJ6sAneBsLL7pXvWkCH5t6DVRiQtk3DeXXqv4Ki5rg9hcNolphu8wCIGfxtJg4zgYKiYhsZesNBRk3v9C/K4Uys1U9HhEymRQZ4NeAvZG1Nxg5241gpLMbOoNPYdJvgS2E+1RJJffu9s6w7Og3HHrgG1wHaQo6YnAscgcth/MYixQTcUazNjl4pj8zAVYXeNXRNNGm8mulizrvByoHleFiGV7g8f5jkbkX3q35JV3aarKQvk4cg3jLtaiK7wB/6mQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:31.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513a3d19-2a57-4443-3852-08de00fcaa36
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1874
X-BESS-ID: 1759331436-305884-7635-4386-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.117
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaWZqZAVgZQMMXczNQozSIt0c
 jcMsnU0sQyNckoCcRMTbG0NLAwV6qNBQBdedt6QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan18-214.eu-central-1b.ess.aws.cudaops.com]
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

Implements support for match on inner ETH header.
Updates flow dump output to print both outer and
inner l2 masks.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h   |  1 +
 .../profile_inline/flow_api_hw_db_inline.c    |  9 ++++--
 .../profile_inline/flow_api_hw_db_inline.h    |  1 +
 .../profile_inline/flow_api_profile_inline.c  | 30 +++++++++++--------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 6a27ba8e12..362e1666bd 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -203,6 +203,7 @@ struct nic_flow_def {
 	int l3_prot;
 	int l4_prot;
 	int tunnel_prot;
+	int tunnel_l2_prot;
 	int tunnel_l3_prot;
 	int tunnel_l4_prot;
 	int vlans;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 5de4f6bae7..5caf5b2768 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -396,10 +396,11 @@ void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struc
 			fprintf(file, "    Port msk 0x%02x, VLAN msk 0x%02x\n",
 				(int)data->mac_port_mask, (int)data->vlan_mask);
 			fprintf(file,
-				"    Proto msks: Frag 0x%02x, l2 0x%02x, l3 0x%02x, l4 0x%02x, l3t 0x%02x, l4t 0x%02x\n",
+				"    Proto msks: Frag 0x%02x, l2 0x%02x, l3 0x%02x, l4 0x%02x, l2t 0x%02x, l3t 0x%02x, l4t 0x%02x\n",
 				(int)data->ptc_mask_frag, (int)data->ptc_mask_l2,
 				(int)data->ptc_mask_l3, (int)data->ptc_mask_l4,
-				(int)data->ptc_mask_l3_tunnel, (int)data->ptc_mask_l4_tunnel);
+				(int)data->ptc_mask_l2_tunnel, (int)data->ptc_mask_l3_tunnel,
+				(int)data->ptc_mask_l4_tunnel);
 			fprintf(file, "    IP protocol: pn %u pnt %u\n", data->ip_prot,
 				data->ip_prot_tunnel);
 			break;
@@ -958,7 +959,8 @@ static int hw_db_inline_filter_apply(struct flow_nic_dev *ndev,
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_L4, cat_hw_id, 0, cat->ptc_mask_l4);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TUNNEL, cat_hw_id, 0,
 			cat->ptc_mask_tunnel);
-		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L2, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L2, cat_hw_id, 0,
+			cat->ptc_mask_l2_tunnel);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_VLAN, cat_hw_id, 0, -1);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_MPLS, cat_hw_id, 0, -1);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L3, cat_hw_id, 0,
@@ -2294,6 +2296,7 @@ static int hw_db_inline_cat_compare(const struct hw_db_inline_cat_data *data1,
 		data1->ptc_mask_l3 == data2->ptc_mask_l3 &&
 		data1->ptc_mask_l4 == data2->ptc_mask_l4 &&
 		data1->ptc_mask_tunnel == data2->ptc_mask_tunnel &&
+		data1->ptc_mask_l2_tunnel == data2->ptc_mask_l2_tunnel &&
 		data1->ptc_mask_l3_tunnel == data2->ptc_mask_l3_tunnel &&
 		data1->ptc_mask_l4_tunnel == data2->ptc_mask_l4_tunnel &&
 		data1->err_mask_ttl_tunnel == data2->err_mask_ttl_tunnel &&
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
index b2bd2f6d2d..ec36678c12 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
@@ -219,6 +219,7 @@ struct hw_db_inline_cat_data {
 	uint32_t err_mask_ttl : 2;
 	uint32_t padding1 : 9;
 
+	uint8_t ptc_mask_l2_tunnel;
 	uint8_t ip_prot;
 	uint8_t ip_prot_tunnel;
 };
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index d9c10a8eab..f8a4ab715c 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -908,6 +908,7 @@ static inline struct nic_flow_def *prepare_nic_flow_def(struct nic_flow_def *fd)
 		fd->l4_prot = -1;
 		fd->vlans = 0;
 		fd->tunnel_prot = -1;
+		fd->tunnel_l2_prot = -1;
 		fd->tunnel_l3_prot = -1;
 		fd->tunnel_l4_prot = -1;
 		fd->fragmentation = -1;
@@ -928,7 +929,8 @@ static inline struct nic_flow_def *allocate_nic_flow_def(void)
 static bool fd_has_empty_pattern(const struct nic_flow_def *fd)
 {
 	return fd && fd->vlans == 0 && fd->l2_prot < 0 && fd->l3_prot < 0 && fd->l4_prot < 0 &&
-		fd->tunnel_prot < 0 && fd->tunnel_l3_prot < 0 && fd->tunnel_l4_prot < 0 &&
+		fd->tunnel_prot < 0 && fd->tunnel_l2_prot < 0 &&
+		fd->tunnel_l3_prot < 0 && fd->tunnel_l4_prot < 0 &&
 		fd->ip_prot < 0 && fd->tunnel_ip_prot < 0 && fd->non_empty < 0;
 }
 
@@ -1798,15 +1800,11 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 				const struct rte_ether_hdr *eth_mask =
 					(const struct rte_ether_hdr *)elem[eidx].mask;
 
-				if (any_count > 0) {
-					NT_LOG(ERR, FILTER,
-						"Tunneled L2 ethernet not supported");
-					nthw_flow_nic_set_error(ERR_FAILED, error);
-					return -1;
-				}
-
 				if (eth_spec == NULL || eth_mask == NULL) {
-					fd->l2_prot = PROT_L2_ETH2;
+					if (any_count > 0 || fd->l2_prot != -1)
+						fd->tunnel_l2_prot = PROT_L2_ETH2;
+					else
+						fd->l2_prot = PROT_L2_ETH2;
 					break;
 				}
 
@@ -1876,8 +1874,10 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 
 					nthw_km_add_match_elem(&fd->km,
 						&qw_data[(size_t)(qw_counter * 4)],
-						&qw_mask[(size_t)(qw_counter * 4)], 4, DYN_L2, 0);
-					set_key_def_qw(key_def, qw_counter, DYN_L2, 0);
+						&qw_mask[(size_t)(qw_counter * 4)], 4,
+							any_count > 0 ? DYN_TUN_L2 : DYN_L2, 0);
+					set_key_def_qw(key_def, qw_counter,
+						any_count > 0 ? DYN_TUN_L2 : DYN_L2, 0);
 					qw_counter += 1;
 
 					if (!non_zero)
@@ -1898,8 +1898,10 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_data[0] = ntohs(eth_spec->ether_type) << 16 & sw_mask[0];
 
 					nthw_km_add_match_elem(&fd->km, &sw_data[0],
-						&sw_mask[0], 1, DYN_L2, 12);
-					set_key_def_sw(key_def, sw_counter, DYN_L2, 12);
+						&sw_mask[0], 1,
+						any_count > 0 ? DYN_TUN_L2 : DYN_L2, 12);
+					set_key_def_sw(key_def, sw_counter,
+						any_count > 0 ? DYN_TUN_L2 : DYN_L2, 12);
 					sw_counter += 1;
 				}
 
@@ -3699,6 +3701,8 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 				fd->ttl_sub_outer) ? -1 : 0x1,
 			.ptc_mask_tunnel = fd->tunnel_prot !=
 			-1 ? (1 << (fd->tunnel_prot > 10 ? 10 : fd->tunnel_prot)) : -1,
+			.ptc_mask_l2_tunnel =
+				fd->tunnel_l2_prot != -1 ? (1 << fd->tunnel_l2_prot) : -1,
 			.ptc_mask_l3_tunnel =
 				fd->tunnel_l3_prot != -1 ? (1 << fd->tunnel_l3_prot) : -1,
 			.ptc_mask_l4_tunnel =
-- 
2.45.0

