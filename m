Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7771CCD183
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1B7D40E8A;
	Wed,  1 Oct 2025 17:10:40 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 84D5740E3E
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:38 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021140.outbound.protection.outlook.com
 [40.107.130.140]) by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT7r+sXTJiFzq0sGzobOYnpezOQaCotKDFqtwtzDDvXMNdYZTWzc9BeZ6WCgqDszaboPSRyCOV6jlbL0KTXy+9qFV7vQXihbHlDQEwqG1HRgTNG7bW8qBt9ithvu6+j4yhCxGjmkwQrQ+wIB16rCfwW04pjWrb2G5F4Q73JUb97E34Skz61qxfbHa/wZ52310jM4bXy5DH55wrWhxtC3+WeUuminlQAaQQuiOqdK6hbdAMxO3XmYI659pcweTMaITMeNgmNVVEEOJX9AFMzjEejat4y6CVYcf37pTtPwjUb+8KaFgxfJNZ1VLuYH5Foo2yNWRB09GsAU6Dq1F4SNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx2g1oVCxQuZTIpWqUrjepz/bfAI7uDeqK3xQVsr/Ks=;
 b=aK6iYgZFY3qqcVseIWtIYxs7HI8ttR1bbe3ieaTr2deKdw2sbm05k3Kut4YKyLXz/2A9tF6Z4ijdvpvbsohvIH1CVFhnXfL/2mPtfMBeaU3ECpuoWiLSSph2LHc8V0/Dmd0F4QnopcBf6dG1ifd41EwgAgzSB/6qjtOAZBNlIuK6r4B0ldQIN0aWCUQr4/zlId3QBeWXcaB4uyb5lwxtZop7lYdPMV095ywsaJHpOKaYcMMIO4y5ltTD7PZu3BsSuFQdOzFZ2amEUyJPGV3/MNmBeY5g2qLdJiyRBAGYmbORuRN0sJFwPLNXVc2li8anQF7G/3K3nDoC8tBR17iywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx2g1oVCxQuZTIpWqUrjepz/bfAI7uDeqK3xQVsr/Ks=;
 b=e6+eBYHndpYaBCfbHqOa6ibkb0zGs7oPj8rvAirtjdK9XPYU81WhyhdXSVyHbJ1ARqM1TgWKJkoTWJ2U6XpSIPeCSv6w2GWKhDze+iAmBenVPdz8OV/YhtROg4V80w1a/Xz2uoJncFZjy+c27E6sqio2PjtHmH8TRwkGcTDCA6A=
Received: from DB9PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:10:1d9::34)
 by GVXP190MB2519.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:289::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:33 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::3b) by DB9PR02CA0029.outlook.office365.com
 (2603:10a6:10:1d9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:32
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 13/20] net/ntnic: add support pattern matching on inner
 VLAN header
Date: Wed,  1 Oct 2025 17:09:55 +0200
Message-ID: <20251001151018.250671-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|GVXP190MB2519:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81eaaffb-5b84-403e-6e22-08de00fcaadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bR23DeDAkp6FzCcsddnzVKOrqDIvp3SJk2/ItW4jB9f1w60wQp5ixiYl/JOK?=
 =?us-ascii?Q?ZlYCRVwQNZf4tY9ZiZlVHcJL9FQ4uF5GD63KQBIjLH2tcW3tmaBTq6XqV7jR?=
 =?us-ascii?Q?ZyNlVy9fFUKJ3M+Vuu550BjneCsm0uMM824r7a24/V6vKacB1uMaZaegNXCd?=
 =?us-ascii?Q?kL6vNyEgCQbdyPGPMgdYc/D8h8hpUyZMnCLbpwzc7EZoYo5OthxZZwdHSJPb?=
 =?us-ascii?Q?sXBITa6MP/FYrAvfpOaNzlyj+Ssp71P3TiUVhAPvSPCKOJNXZg0CsAG8HY/Z?=
 =?us-ascii?Q?2j4ONEY77DvrkXe9ttImbqvV0uIalxpmUefrNlyZ8zuOLJnin/sHtsUdWk0G?=
 =?us-ascii?Q?AvmtCTwchdNXyCy44p8pzbVyU+j9OeXIlmT6P7mO7YQLO3ffFQcOpJtizWq5?=
 =?us-ascii?Q?CTOxWNEfSUG/RQeb1v/NgNbPu3DKDel0S9nh4HjqmTVi25X8OkI7bDNIp/dB?=
 =?us-ascii?Q?mRo99eE6SaPUAuVIDi5YYgOxunWMcZKhisNh4LCE+/Q/aXBH/jJpe8umfYVe?=
 =?us-ascii?Q?JL74xQmX+xWD2QO69NnRoD4FoOwek145gG6+PX8gYtAOvGuTmmXFc0bWxp7t?=
 =?us-ascii?Q?o1ODDcK8isw28uks6YJhF6IJxyqqfVpAHLqddyHJhmmpMWUWoKgsj3HChncL?=
 =?us-ascii?Q?iyt5pcC1HSoz48QF7A1vSbqsnMhLlik07M0PBKvzSRPgtat0Gr4nxK/6O/RN?=
 =?us-ascii?Q?17L2R9WPY/w9VwPJsNot8P2eGW+dEkkLstSlTFHXPQWwxUlcUD0oHC/lomhC?=
 =?us-ascii?Q?CkxkOWiNK/hgellaoBeN4u40r3x3R1ESvlmCNjWB9BGmvxJxOGEQfdQRd+nT?=
 =?us-ascii?Q?PbezsCjcYj5EjpN3RFJx3226UAEbxCEHK2RDFSuZFQGnZwQO+F4pDYACXkHM?=
 =?us-ascii?Q?7v/Qri/uXbiK//4WpDHV9+I0zcpdr/JdIQpp++caka0ksqni7xEHCjqd5CTX?=
 =?us-ascii?Q?hEqrSY0NN0QuBIoH/MRW9P+Bg7QzhpliVWH3CoM8bHQ58fQRSax6YRf1JLT8?=
 =?us-ascii?Q?a6r7pWgBnFUekqxPJm6Lw5bYBmZHivHKrVZ3hW5x4DzhM1naZ+xnj5ka3Dgn?=
 =?us-ascii?Q?p00n173SnqovKmBv99ZCm4+xcxnfkVNDCnfX8S3yaeNETP1ZBdnm7VCgJN5h?=
 =?us-ascii?Q?nw6j7Rc4EiCNcUkClVNVs1iQ9B2/yt4Na4NiVQFBeQ3b+erKDAv2DEtDSyIc?=
 =?us-ascii?Q?kxst9DKykuafvzWjViAzqSSs0Mk5PWIlFTcJhBSRr21gIg+fwyMzkbL/2xxA?=
 =?us-ascii?Q?VgQRfeTZV1SEvA2soXHdqfQLgmko1NnnCShKbZG+iVgzZD3fT09lGHr4SADr?=
 =?us-ascii?Q?c19ZfOaC13NUMVf621+2JnBXU5XbAaDaSn7zpmDC/P4W585SGvjkTYpPKsFs?=
 =?us-ascii?Q?HLrXscGqlv1g5THC6da212ZIvDZf3gjYWRx3xzr5VqWmUXlr6r0xmYLnv/Wu?=
 =?us-ascii?Q?buyYWcD7Hu7m6+XiHxL2/OwYLPOMQE2cBvPTV7RbiMkUe0PiTscOOdFWjfeF?=
 =?us-ascii?Q?zUmyUnXx51rUb8N3jjfUv9aydTBdsd2MnTP0ex6k4kFHl/krttl2N0cqxmxz?=
 =?us-ascii?Q?uZRxXvV05k7rwzJYOZg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R5DFtmRilw0BwlEmwU+7s2FkscNgJJZG+J0P85HPpUg5gjtAZgS1WJcEnlY++5EORzWZuBB0/2480QkMLk49yC3KUATYR6WMbOG3keCs+CCmnOGSDgzyw0YQ7nyLaHT4i2RILybo9Pyz+3B41hLs0xAkXOZZJIV9lZx77ST9s8VIb2Uox3AqGGvh3f7pLBm25IjitlwEqis8MJuQknn4RzcvALR51XTO2Mz1RA9n6tgrUQgvWtOwsw/MOlSgJ1kb9Xae29Vs4owJRH9c19f3ADsG45weepBCFqBU/hU3FsXM73CKOdU+bUOA0YylzDmrlrdjbnWEcL/WnDg6tXriioTYF5+lpi+irZ94OwpBM6kjplxZDBNS4r/uU80SnvyZ+DtNWGLimCrreVCb22xn8/raDMA75Q9yFYC/zPRQGfWpgL3Le8nhu0Hjr2W/NmdSkLaaa2q3806d5dh0LGomLLkypp0i550oj5qge8UgiLH2O0HZDBX296/4/V9cGwAiYNY0ZwnzAcgOSZO6nN1bXaih87SjWpatn3ThCIJ2SuKGfPtzp+M4sT9ealWaXM6/zegskTfAzMfYELT4ECsIO7HV9h1NHyB4SBDMsF5guCSzdA0tjPmfddgOmvgbaSnsPAxrsIHXZ2FsgW8d9CE0Jg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:32.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eaaffb-5b84-403e-6e22-08de00fcaadd
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2519
X-BESS-ID: 1759331437-303567-7604-4436-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.140
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaG5uZAVgZQMMnCLNHCKCUpKc
 XQzDjZ2MLUKNXYzNgw1cDcLNXCwthAqTYWADAY4nhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan18-159.eu-central-1b.ess.aws.cudaops.com]
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

