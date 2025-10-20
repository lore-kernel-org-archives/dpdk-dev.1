Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0835CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EA4427B4;
	Mon, 20 Oct 2025 18:44:11 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id D6F0C40E35
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:52 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023089.outbound.protection.outlook.com [52.101.72.89])
 by mx-outbound16-13.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+blfZvJu73WscYhMMoIjC1YGIto5HI7ZiE47yEeVE/2sTNcq/IbaCAlpUy5XZqA3S72YCrTO2hQR0oP3SCbh/HOJYZ57SKuv8mfyfc4xmgBzLR5/w6rShA/egwxaiZE+ZJEh7F2a3DmAESjnsrZWJG417H5HjE8rcDH09pyqFCBg/yB7fl8nhUjs6zZnB9cV9Ygl1+XQmcGYvO9oLv+UYRpnAHkgmUbp2Hxj60cNL7SQrtE5GeFViAnCPsjoMzbk50AIZb+B3Ut7bG8sKSfqgAh2xMfqRCUcZ7YC01ZZbWaeNtWwM9jccfalj8Kf+8uPN38+y1lWt9cBogjmVsA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx2g1oVCxQuZTIpWqUrjepz/bfAI7uDeqK3xQVsr/Ks=;
 b=V9yBc0NymUQ7h+U55GHVtMumlcmYTKkNObPm6xRk/lgjGZKiKDR+eKBZBhhB/G6UH7Z01UNKoZN7O14WYSe3jR33gQB7bOspD+y76kjFtRBfKGg70zXJxWMxpNXdMpH5NhGtZyTG9Dq+iKwl93EZVi3qo03LZ/Eqbr8q1H8ynpC3VgIrOhZwkFxmXyVf9Qr9t4aIHjA8E1ahp5lA9xtiFKXARMgEXpruJOq2ni/YnO4PogoxmVMjIoEVu9Yo4VKvL7x5ehJGrdxRv0Qm+fDVREcH1Sa3cCqXnfvLugr3HC3CPbB9O4+cWRgHjfgWnrXQztzPhQS/F3UtjOi9wmLB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx2g1oVCxQuZTIpWqUrjepz/bfAI7uDeqK3xQVsr/Ks=;
 b=jiAm6PO9V0OEIOvuifqOiCj7p0mEr8RmI/f+TIQFFUClCgi6R6FzwIDenU7ldzjacxlymWcjsJ/f/EtRDkR0mOHSMt32C9MZTWpLxwMwhbh8fQDYN+UXqsCrnCkHbnCJZ1JNINnWPdN/7kPegKC0exaQ8YJ463x1bLNGi9xlen4=
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by VE1P190MB0928.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1a6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Mon, 20 Oct
 2025 16:43:49 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::77) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:43:47 +0000
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
Subject: [PATCH v2 13/21] net/ntnic: add support pattern matching on inner
 VLAN header
Date: Mon, 20 Oct 2025 18:43:22 +0200
Message-ID: <20251020164336.283664-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|VE1P190MB0928:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7821f889-bfb1-4fd1-8833-08de0ff7d825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BuVTwbCWbBj1PXBZug2SFoE+UbDcROmHEc40Q6GMKB8g75HrSaKSRxy9paSE?=
 =?us-ascii?Q?vdpQGsMbsXTHkeunBq8wONkBIE3Ks9X+AXckRMyXK7/yfEZfBzr4oiL+Kk38?=
 =?us-ascii?Q?6RQDaXtlmdD6h8iqAApP91RjCNuBx2/v8/XPAChKsW4LyZM+mKqUE8/I1JkB?=
 =?us-ascii?Q?HE1KMGgX0++TxBEh/Ao6oWgYAhvW8SBwjnDtqGZ8BVUh8IcmOo/Cud9EJyJl?=
 =?us-ascii?Q?05yWTOYTSISTb0/NNl9Urg3nRBHN+xE/mUYpL0bd2kAS7TRsL/CogS+oW/n4?=
 =?us-ascii?Q?KcaCCwVIXxwDgk4VFpagoMy5ry5J1ZzNM5Lgp5n1iio1xItXS5eRIAlbLJZD?=
 =?us-ascii?Q?i2ePkkzDQ8B3bBpyA41UJYw4gwIrQi4pHWRrRxhmT1BYy+Cn4PlqmgWJ99wd?=
 =?us-ascii?Q?xW+1QWNPHpHzILNh4d83McWemWiS5rYcY3L/eEe70lG9aHgjvlJLPDevahR9?=
 =?us-ascii?Q?U85Vd0Yr2BgyIl5i57u5c7sHVcGPz4QN2V6eIkCMySjKa7Sc7f6ZM5E387bY?=
 =?us-ascii?Q?H8h+fbapf/o8en80KuWKXPGOTTnLrlXg37elvMfq+CoyKigSMniqbrAm04En?=
 =?us-ascii?Q?xowd5cDVxVK6vz7RLR5e3bqDS3hWF1+75JRSmAQAf9uBprnNqzULoCRhhK9B?=
 =?us-ascii?Q?MXpzM/p2M00RVFSxgTG5jlwq/g2gzNK30PFbwuoHaL5vWyoMl6kzJKvtrBEW?=
 =?us-ascii?Q?zdOPH7VgpGeBeM45NRL4v7JzbyGtb+22DF0KcqpST+faop00rGT05syQtnhp?=
 =?us-ascii?Q?dFutnnWfmVAm+b2/+1gcMEVBsls3r+rNpBhcQRNiy1Wdgo5qK3uaQ94qXqvL?=
 =?us-ascii?Q?imCxoZBhwJiTpucWzEASrPEcFc3wFM1rAKhgxAAMMIj1ZMRSZRC4eptxAM7H?=
 =?us-ascii?Q?Si426BwZxobWg0JsMyf6KDXi+O7sln0AmE6xgto17qopMcdOGwzeN76lGc7Z?=
 =?us-ascii?Q?Inwoa48VnndpPJHRoAwZGK+12XnAT2FnUDRoXSlWAytEhSlytzRfysU85XwI?=
 =?us-ascii?Q?BxzoYTEfsHrXufBlkORDUQ/NO8N2iJyZ98LeUXzPopEZJ027sp35BHIwvm0c?=
 =?us-ascii?Q?465CE9GtOPnAUpyQfFqi2B+XJxxfaxSVvc0nU4i4OxAfkc/0bkPAXjPIV8hW?=
 =?us-ascii?Q?K5+akZga8CYdK/iE7qPP8QOG90QKgDPddlTejLDU71Kg9m79BtAUhGo46eFw?=
 =?us-ascii?Q?VRzZKADAJhaMwNSHloqP0IzTCDzuvoOCnLWhNOxKs88hDIsNsa35AKb27vwy?=
 =?us-ascii?Q?6F8OVGg0qAwUMpUQXVO8yKIlVRIrloaLaxSohYBlhU4k+c1VnF7yNALEXusj?=
 =?us-ascii?Q?+RT3M4fWW8oQ+PazYx+MXUckP6jT919woVbdSqujvl6KYxV9cQxKw8TYE4m0?=
 =?us-ascii?Q?IYXI4StGR0ABIJbzAu/IBRuy+jpYkVYKoTZZgV3iQElCrJgyj44DS+ZPuauN?=
 =?us-ascii?Q?vZk59m9uJVxBnpGyRaIZlKAUSgASy4Nkir3eZj84edxOzM6gdgv57hFPtN3L?=
 =?us-ascii?Q?J1AQY4lnrV5JTDD2S9BNzPYgplZKS8oo1Z7SJTTXIl0xgwIreaSgszjwnCK0?=
 =?us-ascii?Q?EiPqptkpqRWXxPNnsDg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6zhWsf7Qn9QFtt5ZTdZb9+U9LbqAagLR9aRB2pntPIgePrG0hpkZVCgHgap7qXU9YT4HvoHCn4OZHfbxfgFgah8KZMgQuXcFGgH8F/Q6WsSir219eGI7IQQXLA4nesslne6geTKiLw9yAsItZz0q45cPVjdTobzc21pwxW3ejf+OQzZDFhEKRipnqDTfhYDYVLFbgGGQm7nD7X+PqoCBcsCxnYnuMIVisfhxdbJA5aYDgo+dxw76OosCTd1DpV4ToE3xhCxp0gayOtC+SSTsMAvQYuz9PMqsVcVYie9nQ8K6AuehCYHvvpZfPrq5zjeh4ud683rPBmYhZMdRSWioEal07cGyt5M2v7ZOkcXFNUPm0PGPF7GcqUgCS237gBTW6518Gx7HNxf61Ppi33QHmVMtoC4zVWGgxbN4BkSPG9QbDf4dDql9gh8z+i4dUqiy27HkR74FPLHLhbd0GnTj1mkXsO/hmzBcbetESL7p5Tgqvph4L9mOo6j4N5at2tRR7OJ8zAZjXggnpS5Qk91bdVlteCwOqPMfkxkHfJu0gMgB/jq14R+nAzcuNZJO31xu6E/sMHXSqIcBURYxGymdnokgD27czjiLFV7toCTTIWwxW6hTQKRKzf9lw++hngo5mu21G/tgbgfkfhqBl9RrrAC3G9Lwq92zxstEFshTniQ=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:48.9431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7821f889-bfb1-4fd1-8833-08de0ff7d825
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0928
X-BESS-ID: 1760978631-304109-7613-117822-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.89
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaG5uZAVgZQMMnCLNHCKCUpKc
 XQzDjZ2MLUKNXYzNgw1cDcLNXCwthAqTYWADAY4nhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-209.eu-central-1b.ess.aws.cudaops.com]
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

Implements support for match on single or multiple nested inner VLAN
headers.
Updates flow dump output to print both outer and inner VLAN masks.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h   |  1 +
 .../profile_inline/flow_api_hw_db_inline.c    |  9 ++++--
 .../profile_inline/flow_api_hw_db_inline.h    |  3 +-
 .../profile_inline/flow_api_profile_inline.c  | 31 +++++++++++++------
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 362e1666bd..c166243d4b 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -207,6 +207,7 @@ struct nic_flow_def {
 	int tunnel_l3_prot;
 	int tunnel_l4_prot;
 	int vlans;
+	int tunnel_vlans;
 	int fragmentation;
 	int ip_prot;
 	int tunnel_ip_prot;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 5caf5b2768..17a0332a06 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -393,8 +393,9 @@ void nthw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struc
 		case HW_DB_IDX_TYPE_CAT: {
 			const struct hw_db_inline_cat_data *data = &db->cat[idxs[i].ids].data;
 			fprintf(file, "  CAT %" PRIu32 "\n", idxs[i].ids);
-			fprintf(file, "    Port msk 0x%02x, VLAN msk 0x%02x\n",
-				(int)data->mac_port_mask, (int)data->vlan_mask);
+			fprintf(file, "    Port msk 0x%02x, VLAN msk 0x%02x, VLAN tun msk 0x%02x\n",
+				(int)data->mac_port_mask, (int)data->vlan_mask,
+				(int)data->vlan_mask_tunnel);
 			fprintf(file,
 				"    Proto msks: Frag 0x%02x, l2 0x%02x, l3 0x%02x, l4 0x%02x, l2t 0x%02x, l3t 0x%02x, l4t 0x%02x\n",
 				(int)data->ptc_mask_frag, (int)data->ptc_mask_l2,
@@ -961,7 +962,8 @@ static int hw_db_inline_filter_apply(struct flow_nic_dev *ndev,
 			cat->ptc_mask_tunnel);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L2, cat_hw_id, 0,
 			cat->ptc_mask_l2_tunnel);
-		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_VLAN, cat_hw_id, 0, -1);
+		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_VLAN, cat_hw_id, 0,
+			cat->vlan_mask_tunnel);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_MPLS, cat_hw_id, 0, -1);
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PTC_TNL_L3, cat_hw_id, 0,
 			cat->ptc_mask_l3_tunnel);
@@ -2296,6 +2298,7 @@ static int hw_db_inline_cat_compare(const struct hw_db_inline_cat_data *data1,
 		data1->ptc_mask_l3 == data2->ptc_mask_l3 &&
 		data1->ptc_mask_l4 == data2->ptc_mask_l4 &&
 		data1->ptc_mask_tunnel == data2->ptc_mask_tunnel &&
+		data1->vlan_mask_tunnel == data2->vlan_mask_tunnel &&
 		data1->ptc_mask_l2_tunnel == data2->ptc_mask_l2_tunnel &&
 		data1->ptc_mask_l3_tunnel == data2->ptc_mask_l3_tunnel &&
 		data1->ptc_mask_l4_tunnel == data2->ptc_mask_l4_tunnel &&
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
index ec36678c12..3a4e39b713 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.h
@@ -212,12 +212,13 @@ struct hw_db_inline_cat_data {
 	uint32_t ptc_mask_l4 : 5;
 	uint32_t padding0 : 1;
 
+	uint32_t vlan_mask_tunnel : 4;
 	uint32_t ptc_mask_tunnel : 11;
 	uint32_t ptc_mask_l3_tunnel : 3;
 	uint32_t ptc_mask_l4_tunnel : 5;
 	uint32_t err_mask_ttl_tunnel : 2;
 	uint32_t err_mask_ttl : 2;
-	uint32_t padding1 : 9;
+	uint32_t padding1 : 5;
 
 	uint8_t ptc_mask_l2_tunnel;
 	uint8_t ip_prot;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index f8a4ab715c..19c552bcd4 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -907,6 +907,7 @@ static inline struct nic_flow_def *prepare_nic_flow_def(struct nic_flow_def *fd)
 		fd->l3_prot = -1;
 		fd->l4_prot = -1;
 		fd->vlans = 0;
+		fd->tunnel_vlans = 0;
 		fd->tunnel_prot = -1;
 		fd->tunnel_l2_prot = -1;
 		fd->tunnel_l3_prot = -1;
@@ -928,7 +929,8 @@ static inline struct nic_flow_def *allocate_nic_flow_def(void)
 
 static bool fd_has_empty_pattern(const struct nic_flow_def *fd)
 {
-	return fd && fd->vlans == 0 && fd->l2_prot < 0 && fd->l3_prot < 0 && fd->l4_prot < 0 &&
+	return fd && fd->vlans == 0 && fd->tunnel_vlans == 0 && fd->l2_prot < 0 &&
+		fd->l3_prot < 0 && fd->l4_prot < 0 &&
 		fd->tunnel_prot < 0 && fd->tunnel_l2_prot < 0 &&
 		fd->tunnel_l3_prot < 0 && fd->tunnel_l4_prot < 0 &&
 		fd->ip_prot < 0 && fd->tunnel_ip_prot < 0 && fd->non_empty < 0;
@@ -1920,7 +1922,10 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					(const struct rte_vlan_hdr *)elem[eidx].mask;
 
 				if (vlan_spec == NULL || vlan_mask == NULL) {
-					fd->vlans += 1;
+					if (any_count > 0)
+						fd->tunnel_vlans += 1;
+					else
+						fd->vlans += 1;
 					break;
 				}
 
@@ -1947,9 +1952,13 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					sw_data[0] &= sw_mask[0];
 
 					nthw_km_add_match_elem(&fd->km, &sw_data[0], &sw_mask[0], 1,
-						DYN_FIRST_VLAN, 2 + 4 * fd->vlans);
-					set_key_def_sw(key_def, sw_counter, DYN_FIRST_VLAN,
-						2 + 4 * fd->vlans);
+						any_count > 0 ? DYN_TUN_VLAN : DYN_FIRST_VLAN,
+						2 + 4 * (any_count > 0 ? fd->tunnel_vlans :
+							fd->vlans));
+					set_key_def_sw(key_def, sw_counter,
+						any_count > 0 ? DYN_TUN_VLAN : DYN_FIRST_VLAN,
+						2 + 4 * (any_count > 0 ? fd->tunnel_vlans :
+							fd->vlans));
 					sw_counter += 1;
 
 				} else if (qw_counter < 2 && qw_free > 0) {
@@ -1973,10 +1982,13 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 					qw_data[2] &= qw_mask[2];
 					qw_data[3] &= qw_mask[3];
 
-					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0], 4,
-						DYN_FIRST_VLAN, 2 + 4 * fd->vlans);
-					set_key_def_qw(key_def, qw_counter, DYN_FIRST_VLAN,
-						2 + 4 * fd->vlans);
+					nthw_km_add_match_elem(&fd->km, &qw_data[0], &qw_mask[0],
+						4, any_count > 0 ? DYN_TUN_VLAN : DYN_FIRST_VLAN,
+						2 + 4 * (any_count > 0 ? fd->tunnel_vlans :
+							fd->vlans));
+					set_key_def_qw(key_def, qw_counter,
+					any_count > 0 ? DYN_TUN_VLAN : DYN_FIRST_VLAN,
+					2 + 4 * (any_count > 0 ? fd->tunnel_vlans : fd->vlans));
 					qw_counter += 1;
 					qw_free -= 1;
 
@@ -3699,6 +3711,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 			.ptc_mask_l4 = fd->l4_prot != -1 ? (1 << fd->l4_prot) : -1,
 			.err_mask_ttl = (fd->ttl_sub_enable &&
 				fd->ttl_sub_outer) ? -1 : 0x1,
+			.vlan_mask_tunnel = (0xf << fd->tunnel_vlans) & 0xf,
 			.ptc_mask_tunnel = fd->tunnel_prot !=
 			-1 ? (1 << (fd->tunnel_prot > 10 ? 10 : fd->tunnel_prot)) : -1,
 			.ptc_mask_l2_tunnel =
-- 
2.45.0

