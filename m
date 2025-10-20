Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4750CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 922C042670;
	Mon, 20 Oct 2025 18:44:10 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id EAF4740A80
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020088.outbound.protection.outlook.com [52.101.69.88])
 by mx-outbound16-221.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXsuyAPWJdGRS2JKq4JWGP4A2fx4nZ79mLVUG41KUhOkpcwOLftCj/n2YhoH1ec9x0hzOtRHhzunIwS2bjS6KK0z6Dfi9NhTgSQUUsdRhOWez7VbzID3KHJaLGPbyVrEVyW/qPOudTrjphtICaF3OOYF7DE3Hn4TFEPVw4fhwviFnMvESlOyNOTOb1z47XBOKBFR4p6JgS9NROTaBBof89rI2NG/4HtGJ0ZNN9g6GaykWk/04YW+iGBb5H/mZe25pnuYzcCTQowGzSB/4ixm3/yEe0ypKpzF6VQSJez5F0QiBTWtzjy6NGUrVMeqKlW+jfEP+QC5e24o4RmVCuK2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtOe6+1wA/aHpTcZsMJW9CHuPEIcjVV5efxWD42a7xs=;
 b=eIUOvFT8f5OkYDhWVpEwTZgbVyp5ef6wnaLhmUBZe+2Cnz+rANxK/DakLAsb4IFayMx9qdq3ErV6WLCk7Z472A3UdW7nBrbxoFdaz36VRxkyaXJmMt98lZdgd3cTePR4zGkiuz6v07hX4tyV+spgZHAZJDeh3vFdiLA6nZfjDV5Y78KBNROanu9KorAHkBq8eQKW9nCXZH+1Fico7hJHRZhZl/u/ZrpSwBtuenZJDBhylktpfxooimIsMW2uA+vWVL39hSIZRNiXCrIcXaK7J3R7qBCb1JFzUHWfNLkNH1Ts8VL19q5AqLH+EiR+eD4g8M5Bmo4jz17Ch8ZXC3jPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtOe6+1wA/aHpTcZsMJW9CHuPEIcjVV5efxWD42a7xs=;
 b=Dwj6hKuhbCep6TqSyxKkGbBCPNTDec89k34HuArrRY9KLnSX19LcjaZI5I8ekrmITeW0a/EPBzMUBWPFheFjYMH/29ds5w4OsiAzY+XsqMDHk7QcXfjnccxsAkyGyFdjAoestotY5iT5solX5xh+7WTr2qIrs9y54wQGFznz3xE=
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by PA2P190MB2125.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:408::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:48 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::bd) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:48
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 12/21] net/ntnic: add support pattern matching on inner ETH
 headers
Date: Mon, 20 Oct 2025 18:43:21 +0200
Message-ID: <20251020164336.283664-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PA2P190MB2125:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7497e7fa-a62e-48b3-990c-08de0ff7d7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M0owvpZlM45bs/mzQBk2iZqw3Sn4rFtHIgqK3RyR6nXY33pcXAtaQA3xom/v?=
 =?us-ascii?Q?MKhBZI7l7pPntmuEJ7es8QJoc8KrDRBRjrtQ1qNrq/7pVqLc2pYx1fPCF/mQ?=
 =?us-ascii?Q?HdVKJNkdvsRWNiqPto8Zh5RttaYsMCYFafTp/51IiP392vIAQodrI1EtL8VX?=
 =?us-ascii?Q?uDv0Gc93BUFoD7RDNt70c6YL8Mv50nyS8NnxrZXxILbGIhYnUUQ+aim16vG0?=
 =?us-ascii?Q?izektzNMXANdW9bslKCgBV8A+QEUAjVN9JsXikqLkOyLwpoXWQs3zQ5fHQ04?=
 =?us-ascii?Q?EXxwNLai41NGuauXyF3jXzeinCGybVPi1McPuUJii6xXMO7SHAY5SrNhoOZq?=
 =?us-ascii?Q?ebeRBbKAcArX4kI7w4AO9EMTMS3/b2cqYSkw2qp8RUw6Rq3HJkqbWAMvWxzt?=
 =?us-ascii?Q?0JjMk+QzaKsxpDVGzpQvkriLvpjigvYAF80Us+TrGIuhHvzSR9904GMRWyre?=
 =?us-ascii?Q?a2iJHCp5EI5JrMZQkcLrtZzHrC6fDuZmwzAgBR3k1qCOoXEkOXFooD3usrWQ?=
 =?us-ascii?Q?vuyi0koAPFw8rWl+qCbw42lX4vg78Zb15hR18x//ysj9YeAEQ9gS06Ky/9A0?=
 =?us-ascii?Q?MzSuJDCoHD180raGFt7dTc602fpTEtX7bA0Ho9RAuP8w8GvFmwsL43vRIZTo?=
 =?us-ascii?Q?kaHHesI+iDLWGhB92dxQlAEQMdwPruwE8pI8ZzML5ON/3MtLPjJTd47lI1gd?=
 =?us-ascii?Q?XR9HDyixr19QeIebBk0Tz7BfY4IOx2vqjsytA1y/nnb96DtK7RGOtwQK57uX?=
 =?us-ascii?Q?IRh4WuHFdpr3hTkaME1YSlKppDKGeS6RXGZGISFkWAr755YffARg9/22R5aI?=
 =?us-ascii?Q?iAdCxCifPBSumKMG4TV8SS67Pq0qnkHD08DeFLV/OLhslbZa0TQe38jwYIjN?=
 =?us-ascii?Q?HhfXtuP6+mAd2yNQeumlJtV2wbWoR6YUejmCBUa/v9g8JoRQavHYWMYAHLK1?=
 =?us-ascii?Q?DkBbdsfWKveqd4BUpGYYtqrh7XHp0TILAuNEjfn2stWwiv+9x+VUzpAe4BU6?=
 =?us-ascii?Q?vCi+t4/3F9Hi8HqEz1S22sWgIq6eBtuEwSBHTWMtRzo7yOi4np3tnzzFWwLk?=
 =?us-ascii?Q?qeG/uWf2Bilv488MzsQSNzIlNf+3+bkuAWu0dJMA2J3s+ywNgdb+aiHurbzk?=
 =?us-ascii?Q?YrK68ciIq1UdTxRAXwuDBKhdgoPw71TbvfRwFkq/dPLwEbCXOQy7NrGa0FC8?=
 =?us-ascii?Q?SD8uQJbBCY3tlKEpFssBRdyHxoE2eFuR0wQ/7HwXLossrrgi3MnyAjAVfqCf?=
 =?us-ascii?Q?gpct9/Tn6/6kTHaJd0TXDeEkPpPMHXQbyA54DWYKljqJ+m/xwk+qfawwX/jZ?=
 =?us-ascii?Q?VxC3ySU0Dl15Nhz0nztot0Ndb4el9jV2xNKcN6219Pm2Eb4sdg7tQvN6rxPg?=
 =?us-ascii?Q?D0sg657AnvasXBWZTv4WP6EKSM0XMiusv2aXx8qWtRFnv6NKMIfR/RXYbBCQ?=
 =?us-ascii?Q?oKGCsuN9I9ERuIezkeUuh3oT1NtRG51iF8mvXGm9Y8oMpZwAY73xr0Y301Qp?=
 =?us-ascii?Q?INBzY1HuLQ0IAk3dM7xbo8y8168PKxcpuRrygYuUogqJQSIprtZa+39nRuBE?=
 =?us-ascii?Q?vD0PZoUZQJZlcLpTn2c=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YhWZKJzNH2ZNGI8mbdTm5xVt134htypBWi/kMpq+jbumylh6dxiZ6Z0wSAyDY067cL5Bjq4t5/MYS6jZzUVgnAek9Fv7A/BpffAh4iMUrJAjhBMBDai+Pz3vXii6T4b7Qchxvjiq6A4o4dQUU6DBjco0j+vxohUam/N3csF0DgXw9hZe9L8bfuStlmrSid9bbSsnC8BkEcmAnWEIslgFkQIYa6F6R1ic/yyMlMGaJHriEfl9f339Ma5KFZfxWjjKhHkJ6SDo0SKqkOMuwetuopwdDwB4ISG3+AnBlQX08GgFFjgweefWFmN3XDnjHzzcVAny01qOvYbU6lHUcV1r4KFVdcQqdrAvtBKWupQ9eEWCHoaJKJ1wjCNTJwBI/chRJIBXRvtK+vY3ZdTmtc846IBmZo1OURcx4nYCHW23Xso9SWIcWcf74m02NgRg3lox3FPhdNTppYHf0fvuj/RSjWjdhCEvxWOX6N5XpxMFxHsY+quaVQHwzqNUb7mFtB6rjUFq+jHvwHohXGpvqmA1VUNAOB8iJP/YG8uM+ccwEcLRi7WdJoQtiSHFzVaNJZ7sdGO15z75JpJVnvLH35ODxUltXHtLAGDGr3IHXvkY+FSDmN3odITxE2BZ1+enM9WmI2R+xRYbxSx7X4sl7lB4aK5IvzKi5GMAWi4LBwjigPU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:48.1976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7497e7fa-a62e-48b3-990c-08de0ff7d7b3
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2125
X-BESS-ID: 1760978630-304317-25459-11879-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.88
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaWZqZAVgZQMMXczNQozSIt0c
 jcMsnU0sQyNckoCcRMTbG0NLAwV6qNBQBdedt6QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan12-246.eu-central-1a.ess.aws.cudaops.com]
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

