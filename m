Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8049C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 10:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2454640E96;
	Mon, 10 Feb 2025 11:15:37 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by mails.dpdk.org (Postfix) with ESMTP id 147E740150;
 Mon, 10 Feb 2025 11:15:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4aeg/Uxjy5Vh5bMC+DY1TkqKqxW5NWxiMWoRoVXv5/qgHzXJDx8eJWuLSONBAvnUzVMKYOYmTKhgEk5SVJjc7B+qcrGggaylZerNBSXS+W5q+Pf5nYdcd5cb1P/dmWP8IWmOUlHC2a8MKLJKb/fhwZ7Y1cmAhlfz52Mj6tvrlpyLseL08l6sMMrxNyyx1VMmM8GriF9HJ/I4CsS3JEYJYJfsO+wT+YvMoBTQRbvace0TKpEs/MOqYaW2lsQnZC7r+e6OwQLh3WfQgj6Xz9ZL4tGiGjQ3yJUkYV6rzrm7ADgdUW9EofSj6elbbueHHQiXoB6CiFe3UWlS9TZvbAjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1/vW0ryWIFzDTFB7NLIM5OH+I++dt4tZchxTUuTlYc=;
 b=lICLR+Zy7CuK1oUkcTyt+HZnQu1M9Zy5nJyd5rYfa1DdxNhG5k0R/Ty+drErasLxSU0I1Jyptn/Jo6yxwt6NnLDfX3UGNZYz/1R89xsQHgWTjRAHsSpAbmStXmTKZBnE9wV8modzNfbLhERMKzniNzxUJnL1RVGz4y/efkghwGh7AP/ManDHcKHMtY22gK1QoXdNKjWt1U603X2rPyFCpaHGR+ialHIpqpw5WzoCFgUNrCVY0E7E5Y9yF0QYBVFPBTWQdbKLLlZaqmC4bRiBlF3ULulNFTayKFfGh4vC0hjjO2LNbdLObg/i8YrDMLzwNT7xp1az3/fN5Q965KEAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1/vW0ryWIFzDTFB7NLIM5OH+I++dt4tZchxTUuTlYc=;
 b=b8kYajU7smlaclmUlON/VfJQSm6L3cucCa+jSQsU+g49WaOgvm1nprcXweaYMQX0Shws4FShU6FFicWY8WEU+vP3Q9yICZ71AYzuY8ZiIcKxraeyWltP2cLpAA2jPCoG9CKsrtDEyZzeIKUNpSQRByhBLylBaGKecaJwJJZ4iAukhb8jooDcpub8V63c+9fZfoA28JjjPpKLiXtdRdvJipmJ4y/5uCTA01LFMfpqgJPuK7LSpntEVrG7vJ6oGIjk5vocifPEuG1UUazJbhqadQtpQ+tfMP9VtksSGHNVCwxgOd72sHIXAw886XowUJ6ohYC9MmK4raSByz/aXFNS3A==
Received: from PH0PR07CA0098.namprd07.prod.outlook.com (2603:10b6:510:4::13)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 10:15:33 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::7a) by PH0PR07CA0098.outlook.office365.com
 (2603:10b6:510:4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 10:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 10:15:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 02:15:15 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 02:15:12 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix the GRE mask set on root table
Date: Mon, 10 Feb 2025 12:14:56 +0200
Message-ID: <20250210101457.306368-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d38cac-48f0-464a-8bca-08dd49bbda11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Cyrp5torR4gD94WhUy0dSFPLdogzQNP5bNYQ8aEwnIhWWi+cwz31T0s44WW?=
 =?us-ascii?Q?oGdne0qynoooaGEG0f1McP+Pnxbig/R2UFIss+LZGUR8ybyG3nHdEliwvyxQ?=
 =?us-ascii?Q?Qyu+iUS/Jt237cIf+W/adeiV5ucxBx9cjE/HbMRCXmEpTWAlQgvpaHXEcLXV?=
 =?us-ascii?Q?++zIoGDPugWx7E1Y1GUlWBPGFV0oiwqEBGYeGTzcLB8fKkQuOFBy6OpmSPzP?=
 =?us-ascii?Q?B1RXR1OPnOpWn/5pQmsLgYRLp/69+Eloyj5FObAa54E7qxjY2bqFZJiK8MYg?=
 =?us-ascii?Q?qoGpyWaWgOIPpM8/yi9Z8HsF/NYCGXKxcK6LFR+JStghBSUlG9FWPldmK5FP?=
 =?us-ascii?Q?eFMup7zDrktoxXvGXIhCruAXBDa3rJGAp6IRbFNFpNV92/erPFfqDm2L6ryb?=
 =?us-ascii?Q?CUE77IQshS+XUY+Arl8+GSqsNAqyePRtU6ygYUYQdxhu0bUOLxR9XdWNB6XW?=
 =?us-ascii?Q?waAbz0oJAaJWIj1Z6xoONudJ+yWBUE7OqoQ5qvQtT7GiOolQjuZS/ZDYueVC?=
 =?us-ascii?Q?zDlVwS0jxsBvecvSh8eiG23Z0vEe+jEJz3pEGHcmp8SdqVP4MaFPKFbzbAZa?=
 =?us-ascii?Q?Vu6KrBXUYyT8KXRX6AJyN017um8zBPfHw+u0ozdNLZ1/zuUQO/DTDcTgjJkp?=
 =?us-ascii?Q?0bfAuckip5rJi02rNtQV/CBtarDP/nN99faSLA5/1hhKtqm9UZv7pwnPRbSI?=
 =?us-ascii?Q?QkFIV2Oi1cvW0GGjTeKaI83BS0Um3kFlv2noyNNYDCSP0LZCc9av8UuGbFDA?=
 =?us-ascii?Q?9eYwIMHSZxcLvTr8hRppYLVCPeCgfmqRbY4u6AeNIGiPLw2PUAuAPzY5qiiP?=
 =?us-ascii?Q?CrR6YLXdtpOCkcMmXBP99C5G+atOlG5w2+ryNPzmoxurylbmVsXSmCE+zb+j?=
 =?us-ascii?Q?g5cXfvRaPwzBc+7yc3dzhaFbcpf3wl0mjKni9REHfXGOW1O0d3QJ94z4YRHw?=
 =?us-ascii?Q?DYekFrdUjsRGZg8djLDo3Y994Hclyt2p9UvojYco8qObv6EkQymhSlpzLXSy?=
 =?us-ascii?Q?nUTc0o7vy6Rwt/O32bFCorMRT1xb6uaYamUGdCPnUM9k/dAd21OaagESRspC?=
 =?us-ascii?Q?aCbOJbcygNbUTX2jT1BBbk05PDuqVaqKjAT4/IFVIkPz0P5axn38cJZfaGqd?=
 =?us-ascii?Q?tesWKT/lI5GyNZuuoQLfZnQYqWOcKOq9KvvG/koWEI6W+J8SjnyYVAxhXwJ8?=
 =?us-ascii?Q?Ir/njH1V3aVMfeMLC30O/uGMOWIr4b1l/feVSUM8g+DKQO0+nxEuhJzVs18C?=
 =?us-ascii?Q?eHdqLX3pJXvsy+mSehvlC9qerfU4JYDCFoke5GHA+xX5G4Tx3N4qaazg9V4s?=
 =?us-ascii?Q?BG3T97bBe/tdL/K3iZBSRuKfBXVh907vd1lA1I/hpMBtUe2oZvX748ClMRbZ?=
 =?us-ascii?Q?kcqthVN5U0QLtKVSpbL10c3zmzvcgM3owrIRniTlJEdVtAubbijNsQEYTS7E?=
 =?us-ascii?Q?oxWyjIPh158THrWaeh8I2bgQErQI8857eM2fpc6yUWHdXsl9MtMx31l9UJP/?=
 =?us-ascii?Q?WQ98GdzJFB9u2nY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:15:32.1522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d38cac-48f0-464a-8bca-08dd49bbda11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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

From: Bing Zhao <bingz@nvidia.com>

When setting the value, the GRE mask cannot reuse the one from the
value, or else the value cannot be really ANDed with the proper input
mask from the user. If the value contains more valid bits than the
mask, the rule insertion on the root table will get a failure due to
the extra bits in the value field.

Using the input mask or the default mask will help to clear the extra
bits and solve the issue.

Fixes: 25ab2cbba31d ("net/mlx5: fix GRE item translation for root table")

cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 41ebe0b61a..c65345e6ac 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -9853,8 +9853,6 @@ flow_dv_translate_item_gre(void *key, const struct rte_flow_item *item,
 		} else if (!gre_m) {
 			gre_m = &rte_flow_item_gre_mask;
 		}
-		if (key_type == MLX5_SET_MATCHER_HS_V)
-			gre_m = gre_v;
 	}
 	gre_crks_rsvd0_ver_m.value = rte_be_to_cpu_16(gre_m->c_rsvd0_ver);
 	gre_crks_rsvd0_ver_v.value = rte_be_to_cpu_16(gre_v->c_rsvd0_ver);
-- 
2.45.2

