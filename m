Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BACC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6308E402E1;
	Tue, 18 Feb 2025 11:34:24 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by mails.dpdk.org (Postfix) with ESMTP id EC95D402E8
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:34:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRDlT+WSa4pAWtstmcaCt9jeeQyqpsrISAAGYlezsTq3j/STgviwWs7sTW4fZZUNyy1q6javlCSD2deGzQJO4uCzJLvKeB/wIIRiOvFkEaU6njAOgiKn3aMBgH2woYq6i9kjx3U+Jspt8LiivzQ6GKs2PSPHzJNEvTOQrb4TdohgMCbPlpdpw7pavL+D/CwdNGmwjfq8TRWnXwUFB0RDtSZ/bbhr/qecvEKz7kbakBMaYS6jSYyRQoutZBitIGot4xQ/Ig1Nx+NN9CyPBsh9Isk00aASynm8GJTxkofkGqDuKULri3wSCutgL8cdj9dtBZYQwTCC03+BWpgNgyAEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAg5evkZUq0CKND8TC5A/NSG7+2g4MzSEaYojFTrbGE=;
 b=g3eLH+H9r4N/5cbWFX8N5HB7Afoddp1ga4XPSX1cXlhdY2dqv65Him2xhPSgVfZWnpkk1zFelEu5C7P5Ts8ltXaHP9uheID+7caPil321zyofa+0mK3y8Mlqppb51VhX7NYS06wR0wPOFCEUgzwYjY+IyWU5+LsSLWwYAZWddkMCjTtfbHB/xuFS80x0/HRKK0sa5qu1Sw42I9ZeG+lWHfGbWUcJFVxJbB/J01Isnc5gZG35SQbCJ1xubZ9ALauWdzeekhMi2tzre9O3oyuZvXwBl0gx3SR1RtLJpWSbgYtXN1YWjyOmcLhryA/CBdhmBVKXwjSwWGX0Gz+r/POhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAg5evkZUq0CKND8TC5A/NSG7+2g4MzSEaYojFTrbGE=;
 b=duNLljdtOwb1lOBzx+6SNiPDSU8RVgVxur+ApnJz+WOC2dYRjL0+7nmCzjgEwMCLAF/zB+2TXMImaHZAmeSjNt6+Fjn0wUpWTiON52FCUlVMrdJis1ESBYbp+uJqKwmuHOXqvANJPXevBKwTmQDLAnHEAt8+qZNGiuUKSGbEvWMebfqD30U7I1VEwIm2IiXJRfyd10jz48brbet04ZHqOum+44SiNoBqOHphtEg41tP15usBP0ciBNxOMIwtvL516kwdr4serb1tcWQW6Wn7kTxG4Qh8Co+KkN0U1xaWgRzsd0bjKd4VHdZ6fwMOa6kJGl8OsBjQjLmmgMuhIYt8yg==
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 10:34:01 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::28) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 10:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 10:34:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 02:33:48 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 02:33:46 -0800
From: "Minggang Li(Gavin)" <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Aman Singh <aman.deep.singh@intel.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 2/2] app/testpmd: use flags from user if it is set
Date: Tue, 18 Feb 2025 12:33:22 +0200
Message-ID: <20250218103322.166461-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218103322.166461-1-gavinl@nvidia.com>
References: <20250218103322.166461-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fbbcca-d978-448c-5ebf-08dd5007c201
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dx3e4Zt1brQSV7rHnjFNB4afcUzQQ/gPAd5lceIfMEAp38/T0Ecufi9ppjxh?=
 =?us-ascii?Q?x+gTXIU1VezH8buug7dpBbKL+9hTGoURv+yP0PmBlwLjtpXKwK74HQwJHU+m?=
 =?us-ascii?Q?Rho04WXfvTEKAD+EzM/m2R0Mg/ASuOVeEUJ3EVMooc/b3zuBqeZuR0Eo84B1?=
 =?us-ascii?Q?8haP02j0bwKXAceogjKa18ZGPHBHEixegnluF7Fru+lxpKOZoVbAQrIsWWft?=
 =?us-ascii?Q?mB+Loxo/3792/zoihs2FX+Ao2ItYVRxZ/p9IjWxgpJdGaES1XxhqA2yG7Lb+?=
 =?us-ascii?Q?HbnqYcVOvhECseJYHZu/wTb6dI/I4rsCv0qZ295/8o0zV0hxZCNxhxrfPLrZ?=
 =?us-ascii?Q?yz7JYC5ekD6p9WDLztMdGDQXNM+7Sz/gEz30qlPT9vvYRmewBeHeC+8/PELV?=
 =?us-ascii?Q?Wa6a/S+RIPyvio+SPzAsu9KpP8fTV2oTdc2XqJfhHM9t6NDB1no5hIglESWO?=
 =?us-ascii?Q?rMulLDzETP7EUEwyyfvj9ETUrQCeaYfSwRWfRI1eym3LG/FFMAD1DSsvHtr0?=
 =?us-ascii?Q?+xvRDtkweWAS/B+zoSKyOeiYZ9MB8PdQWTQeoq3neSLd/PyJZijX8V0sWPKd?=
 =?us-ascii?Q?wQHg8sSdGLqJbqCbpYskbAvK9Ru9AuZQgaSI3lLupiyKWjMSCH1cWgAIiA41?=
 =?us-ascii?Q?rbQf6PRwx8pUKKRoHmPEK57iiSq9XwHhNz79I3Od1IxB2FNwouN6Qd+tZims?=
 =?us-ascii?Q?RR+kF60iGlFu40tbybo1jdmLVEi/it3UAj50ANIj9j0XbFnjIja8Mr5JKFsS?=
 =?us-ascii?Q?cBrQxkIVu19dLatnED5G4ylRl/AHL5HlreMDd4O1BGU0cIbIIPdI8k3FK8Wf?=
 =?us-ascii?Q?vFffaro9gAFJ8hyviJn2DLKmpb2iQVFvn/BbN5Qeu6WYv4gcqvXT5EUbkblO?=
 =?us-ascii?Q?KYQWv98A+H4Qc25N0ZCF211TivlWc3Huorcd9zIwvLu57Q2I+9ivMIiZvXmI?=
 =?us-ascii?Q?Vj9KdXL0AsYI6Ta9Us/zPzQH+g/LrlVQ0+y5tGZS+/ssch3lkfdb8LN6W8Xk?=
 =?us-ascii?Q?Uwtn11dh7RJJlv1N+5D7eyMW5qgEvctq9VgOcAwA+CulfkZQB0n+GbbcX3Pq?=
 =?us-ascii?Q?RN0bjiAsfjWcKoUvNxLUF2zty4NkxmO/rYMK2AXWsu/Mz1t0LiEqRhDUM6j1?=
 =?us-ascii?Q?S5AZgWjvbz1ClOkhZcYvr7QemqB/p405u3Rb1ZotQyxWdckyhOAhFC/17V0O?=
 =?us-ascii?Q?5Q6v3d1pMAjUy5vt3VIsb9D5893myA1np88xHkGGFmvj5bnun0zwZEBtTS2L?=
 =?us-ascii?Q?4DJaDLQKq553geys2CzgAfn6KIelD2xuzQCBMMq9zX4wPKnebFWZ6RoctKoY?=
 =?us-ascii?Q?nbnurr/wzYjFzcTL+Y/3YYHSTKQ7KwnBO7xrHvLGyw7j8wvpgraHAorFRpCi?=
 =?us-ascii?Q?+LQeWfHzNuptJaLLMLWPFqSzYlmSO2Vw0vXw+z7Nxby2gzE8nEGPsglIcG8k?=
 =?us-ascii?Q?1QXjmwJYN2QXQxqZ2w1bU4I1xr4X5r9U5vb4kkQuvgGPDjMK6QnpWK4X8MWj?=
 =?us-ascii?Q?QWmnUVHMhagdBHw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:34:00.5091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fbbcca-d978-448c-5ebf-08dd5007c201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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

It's user's responsibility to set correct flags, especially the G bit, to
distinguish the protocols, VXLAN and VXLAN-GBP, sharing the same port 4789.

It will be set to 0x8 if user does not specify the flags.

Fixes: da118115d95c ("app/testpmd: support matching any VXLAN field")
Signed-off-by: Minggang Li(Gavin) <gavinl@nvidia.com>
---
 app/test-pmd/cmdline_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index e1720e54d7..3947304b63 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13598,7 +13598,8 @@ update_fields(uint8_t *buf, struct rte_flow_item *item, uint16_t next_proto)
 		break;
 	case RTE_FLOW_ITEM_TYPE_VXLAN:
 		vxlan = (struct rte_vxlan_hdr *)buf;
-		vxlan->vx_flags = 0x08;
+		if (!vxlan->flags)
+			vxlan->flags = 0x08;
 		break;
 	case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
 		gpe = (struct rte_vxlan_gpe_hdr *)buf;
-- 
2.34.1

