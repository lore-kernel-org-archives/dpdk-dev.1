Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BAC02199
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 14:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE3B4060A;
	Sun,  9 Feb 2025 15:02:04 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by mails.dpdk.org (Postfix) with ESMTP id 2BA32402A1;
 Sun,  9 Feb 2025 15:02:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRhUphCWx2oWd5h0qh5D72jyRc8VZTOP+qxB89dNVJ8i/ebWjnV9hhphKmk35fWGeESjSry7dw3FbIv3B6s81a+W9BXtQjeQDTrGDNjP1ND6VaRpmh4ow/+/+IKeXSjoQ1BJNJJiyJkotOIwkhMN7Xcs00+qq5mxnFkLg8lSdUFPtV/xepB/Nv4pzQ1Rbg4JjCguyu1ZBPobMQrwf9xYOEReiUUtGc7ePv99fxwIxFntQUPBw5Cgd6tnBl0Rp0bvddXzOqjQ7zYXzDvzJp+rcHM8PCJbzWYfKU05rK+/XPh4wC/dkQ1Thn3U+q8NTgijkFlF+W8aD+181sRq7rPO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVVmXL4qeL8LZztMsuArDy8evfPF9WAUx5JCzU89Jqw=;
 b=bVdLWhRNlJgyjoRKPnGc53HLVQ6Ny2CVLZO8q0QKaCXswIg2wO9Ga28Mvf7b26SGgsSfI25a3vx03qeKtvpoIG5B+THXEnJKmEAaOLc4GtB0dZOVV2FegLLQct+W6685ZcnAfKc+AGKD5TWaEbVpNWbult1bliEzJ/0odVHAHOAXERJHSpQtSyRjI/8ZkYDYu5u6IZ55agFBoID+PsmMdbbp5dsgrkYuHq5x7SOlls3hajz2hzYgSvHIh/uVfEfwVq8pPAt9zWZuuv3VeMgdjhS6n9RcXUu+Y4ArsaS58brXmKnQ33ItYPdlnmOFSDsEzzYzAiGIiuuH2OkKqzL8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVVmXL4qeL8LZztMsuArDy8evfPF9WAUx5JCzU89Jqw=;
 b=N6wPAU3TP1RXzGHzJ18FV2VKe2SqSaplhdDWiLeDtoYxGBixxeXU7rrcuPmHEE5erOBJOWRZKd04Et70UM6Gl4GHQ1eSA8FuMxQ0FAIwzyB48cQB1uNvQ8Gz1b8wYC4X26WAUz51khxXI/3MNN3BsBzCNh4hMcKZEwXiMmkOQkfBNFzJ4rvu1z1rY8Wif/gRBxQbmXUntXr3qrVtu1MjZRWxrRH7jDeYITD9zhL5nDtjLPHH0JAQpuKWLF5ahSDyC2JyRdffvrwJTsBDXE4q8ZRFTvUg+s6SD+80+rO4bKHWsCGb9XsuaxXzloN4ckSBaD3kVysikiT0lKp7uJigLw==
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 14:01:59 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::f) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 14:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 14:01:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Feb 2025
 06:01:40 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 9 Feb
 2025 06:01:38 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix packet hardware ptype translation
Date: Sun, 9 Feb 2025 16:01:06 +0200
Message-ID: <20250209140106.264556-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 72258441-5a1c-4308-e563-08dd491251bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1A+NXdmxYVY7AA1oVyXoIfVMaUKmtuO5xfVDZY2i2rbx/MQDSeerrtutEKC?=
 =?us-ascii?Q?fwhOMZ5FPbppk+mpG//P5GUw4vDbkXz8WOM9ZoN3/76XLX+BiabAKTdh+pTB?=
 =?us-ascii?Q?u4Oqu7AiXH4An/G9KnrLRWXjuNNpl19EFwNH/E28wQvSJSaoFRMTv1O9CBAN?=
 =?us-ascii?Q?mLdJQIFDvX3tXt2dk35q6GFG1NfKUhydm6ejwCF3/Gkahd7LH6lEVRkPTIEB?=
 =?us-ascii?Q?YgVCJPbT/jIkhkAfuIQJ6ayp6Madge996mCS09z8jv16876kpIJzXYRsQBWK?=
 =?us-ascii?Q?9bc33UjHpCA7fRhtmzOJ2sN1Y92lUpqZ2vIBFulePU4E+oRaRsjzba2soS0j?=
 =?us-ascii?Q?70hwcP/BAZ94Jh0/9NLL1C7WEWoTwTs2sCdowUk+R0nPYw7JXKGhOfPzFpB/?=
 =?us-ascii?Q?6zrViTkg1CEnXUikgPfuxy4jmQGXQb9C2EDBPWxvwGiulYAlCQ4prf1cFzGP?=
 =?us-ascii?Q?AT1mVUeGg5RH8H+B+NviYz12bCcBuwiWy2dmBGBH4vuP8ioZXjQYOzZ0zSd1?=
 =?us-ascii?Q?4ANbsdjx+DaDCG61SH2qbf4DQjYnwzYcn/RU2WB1tEHTDmLD9q5YXoE38571?=
 =?us-ascii?Q?vfb3zMOF5A15+BYII0Hs7oykk1gNfC0hCRXLtyueC5hWosji5iJVimRyryRH?=
 =?us-ascii?Q?zNgM7dhMrSsNfZyK+Us8F8MzzWI2ChRDMSe6BEYJd3qm51KAFjbKa+B6aUEC?=
 =?us-ascii?Q?B5ScvrgV870/MUMalE8NC2/SlfILGAoSNf48mRtBH9EUblXpdO/9fdeNlAUv?=
 =?us-ascii?Q?2gS7aBKnZRrHDfIhQAYjoGcuTVRmNbdfvUYSZZ8PQdSU88679phlRXg1jPyb?=
 =?us-ascii?Q?d8/viKOTOwSJYjuPWC8iiVYKBAYHuESqygtNmnxJ9GKXmdmTBjn4mqJfFcGr?=
 =?us-ascii?Q?1/b3yEuKxjoi2jKGDZVFj3bbCJRd5s0b6cFF6tnZT6zgBPk9p8l7DASaGH8b?=
 =?us-ascii?Q?ofKq7yt4YEqXtXjQh6aKKXncDiXXrlmxuCmBkVBq2RET818aCjJzG1ClCYFp?=
 =?us-ascii?Q?9YAJmC8JtHmsih3+BLkoxtwRQhKnWQTJnaTTtgtZrApn6DAa/M46sIGX55+z?=
 =?us-ascii?Q?MJSvLZ5EnF0rmdMNC3V3YiN6JYWQdRGCo9aHr1mvAedUkD+G8JRthtcNEBDh?=
 =?us-ascii?Q?K+SgSp5tjqNFkNvWImzHXlwIwETy4iK+xDKM9/V/QJWBBJIG51/8Z8SV06AR?=
 =?us-ascii?Q?hNo0DTUNSiUIaeJ5n6gHs4ScUaius0BJ0htIKzifav1H8BjepNvx5PNVjxvP?=
 =?us-ascii?Q?JkJc+dHmW1eKwGhusDXmLmh7tH1ypx6GFBVD1It/T4XI9wDlXCM1z/Z1U9MO?=
 =?us-ascii?Q?DK6tsW0CEzRaEfGtQGUmU2rd/o8Q52gCWQGCkpP6Gd3s6tf3ibduhocgRtq5?=
 =?us-ascii?Q?6fZEz8scv0/EUNc/jwKK0SqEojNJG31sRwwfMMcP2B30AkLhUL2ae3RATUre?=
 =?us-ascii?Q?2cEzHyKXd7jUCxS64V+bwBt/d2+qi5efS/Bmke+/AWC/5Cd5ZyiG3UCdCmy+?=
 =?us-ascii?Q?eoghmk0qUj8b780=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 14:01:58.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72258441-5a1c-4308-e563-08dd491251bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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

From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Since ConnectX-8 NIC the hardware recognizes L4 protocol in the
IP fragments if the IP offset is zero and reports the L4 protocol
type in CQE fields. This case was not supported in the ptype translation
table cause not reporting the ptype in the mbufs.

Fixes: ea16068c0064 ("net/mlx5: fix L4 packet type support")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_rxtx.c | 80 ++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
index eadadcdffb..9c075f6a56 100644
--- a/drivers/net/mlx5/mlx5_rxtx.c
+++ b/drivers/net/mlx5/mlx5_rxtx.c
@@ -118,8 +118,24 @@ mlx5_set_ptype_table(void)
 	/* Fragmented */
 	(*p)[0x21] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x25] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x29] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x2d] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x31] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
 	(*p)[0x22] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x26] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x2a] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x2e] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0x32] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
 	/* TCP */
 	(*p)[0x05] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_TCP;
@@ -145,8 +161,24 @@ mlx5_set_ptype_table(void)
 		     RTE_PTYPE_L4_NONFRAG;
 	(*p)[0xa1] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xa5] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xa9] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xad] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xb1] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
 	(*p)[0xa2] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xa6] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xaa] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xae] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
+	(*p)[0xb2] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_L4_FRAG;
 	(*p)[0x85] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_L4_TCP;
 	(*p)[0x86] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
@@ -182,15 +214,63 @@ mlx5_set_ptype_table(void)
 	(*p)[0x61] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x65] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x69] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x6d] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x71] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
 	(*p)[0x62] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x66] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x6a] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x6e] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0x72] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
 	(*p)[0xe1] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xe5] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xe9] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xed] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xf1] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
 	(*p)[0xe2] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xe6] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xea] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xee] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
+	(*p)[0xf2] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN |
+		     RTE_PTYPE_INNER_L4_FRAG;
 	/* Tunneled - TCP */
 	(*p)[0x45] = RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
 		     RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN |
-- 
2.45.2

