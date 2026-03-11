Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239ADFD064F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 07:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ADE14067C;
	Wed, 11 Mar 2026 08:54:39 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8]) by mails.dpdk.org (Postfix) with ESMTP id 3DC4940431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 08:54:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqsohMixBrFQ/e8aTY3M9XJI1wKoeK1A2X/C4x595MSau9H8HU1jyoVXKxlDlCvdm1sAoofFSl660MeIGpEiN8yEPa8IxvZgBYtUAN5BP/rpCXuJp3ciro+RrTe8W9kRSTyOISWQsYyjcfRHjJENZkwVkiwwKrAHVQmw9EP2KfQaBdKc5SkbKnQF0lESISITMmggCX9sqA7noTa5w5//bkRxyHoBOyls9SizJIIK5fGIA3557dY/m7k8UTlsty37aZMenfTeIv3OzGMzLXLAMkLeraRwXaK3HEy1WlddVfmpECoQH9vlGlG2KU+wu6NObjXP0RvT01GCyJ9qtPFGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWfdV1zZDP6VIICyrCia6f8lU9L+U7hLXGxhU9VVy5s=;
 b=r31Mjx0cFYScyV8zz5E8KDvIGQJIygDhYZpLDBpSDfzUH/AwlqYybMk8pXMXGNBN4bLmeZ/zNAS2jU+U2VmJTf823kf8G7AJfZrSEdYy1XNlt1YMTEJLVi2GXYlVxc+mIaavCLIHdSeEUeAMWjnVqiqNeI2mXSnab+7T8gUFC1IHHY9OzTKR5+vdzvDEsAOgBKYY6DaeuQ934zFZiModTw5uDIws3ujq8Q4Gc63F6Q/IE+zRzyQNesJ6H8CnWqplAPWhgwXDGJlA8ndHvpCgqZDLpdferxl++FOfTlaRw1L5WsYkolzWH+xZTqfx2aldRNqclE0gOmR3RGcdDfmmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWfdV1zZDP6VIICyrCia6f8lU9L+U7hLXGxhU9VVy5s=;
 b=DnPgSKwEWy9eJQBOWY4oZaATV872BipVAGPKAgbhhkg2OUu6gBf8wE6gPOM4arkF7huOJ13Zj7HKb1qEam/AgzFgxn9v7/TgW+34+nbJqgBv9WlutGFOyWeFgH4Hb7paBqmFwwn0kxXkwfyWdT6y8ZdUtY8IVHjteFtGQOtSAFuLqfqyQWR9HTnZITEEm0dYAaGXaR5wzsOm+Xn9Bwm6xHA0Cnz2xrYDwwrTcWUJS4CFXY5Uks3o1QDq9l7RnfDqPFD+WTMDxv2zn9x/NmS7vLug/X+ZjQz3Xc1Ws0FZMumY2dZFEisBHF3KRjcogFXjqOmY4KXoQjq6vtLmA5PB0w==
Received: from SA1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::27)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 07:54:31 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::44) by SA1P222CA0026.outlook.office365.com
 (2603:10b6:806:22c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 07:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 07:54:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:54:18 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:54:16 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: fix ignoring PF representor
Date: Wed, 11 Mar 2026 08:53:51 +0100
Message-ID: <20260311075352.266692-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e8c668-caf8-4d96-fbec-08de7f436d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wYo9rnKV0fLnnxoV0uxbqj3HTFnTQEraZo6jATov9Nmvfpz5yEPchhml51Ic/yi0uNdAq4f4ootiW8tbyTVeOmX74ieHJVppqS9fltokDL40e+J5FRAWG/kRIEHdIKx+rcmp4BXDc1kG1CvBpJ3t0El/CzDPOfMUV9FTGYfADO25pgqjYzQIOkRJHBAuAXfQOuMB1clQ9OiDA+mNdpFdajdpd286SJYXMZrJOu8mWaRmRJTFF5y9HEb1XniL5M3uj/UQGyfKdFsbkSi2amaZwhzzvOcRlBf26JSdHCV6AiPPkCXj3mm/1LULWAAOdU1Cmpo+0mxQuN+j+6EDoCLn631XEbcmp1ukPDnXMG+SvM0qCgziSGZkTdyaYy1UvzuPL1bE+HAur9TNWR1b4w7CdxoYqcxLeSe1ta8Gd5hdWV7CKc4+c7VQx7VF83QLe8dIoHCjmpLCITUOP4JcYisFJ9HdM09nHj7MRRIOQgP3KWUbesTZcmmbUi+FUnj8ewv+/cobODm6+o7e2xww/cB7n0BusGF37WwiUlT2Jgrv32lPNQ9cDJJjR1eBY0OCRHeMV3jqWjwDJ2GT6+qrQf6lxulzf5P4tuFI/S3pAIR6sIkpgQ/4E7eKu2kuUCE7lbNSyV8fnfQ5WWk+RMJ2WQ+8mgl89zPzCWBRM+HVdEEa5nZeBduyqGcPpsyrygZ/ASk+eitXeo7srj1llYVLT9O83z+atK8F5Uq2vbLarYEyp7IPUgwyoam9Md9jKVeaOvWH/1hxGGOvAZuvQYK+GJA22w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ufIDp65dFTy+TH9H/yC/EZlmJ8lK0g8u5gBuIk8mCix+L2+ql6U7kghz5vmt+0yB4RngEOhEoYv+nnRIZgM/Q0xXvUv2T192sSsTKRrG4EzXdzJuOWCQNv6qB90F1gRAUdQxPffE/CnUAIhN8HjNagLiCK1GUjhF63fCs27CMgtbq/Kq3Cz9zgR+vCynJodAsi8xcnL8bkKg8QRC4pACMZpXEIlok2ugMmbWoWxOhfrvCU/o7Rv6GEiUxORKh68atxn0NLtnnFlkZrx3BkiObTWTmjJKqZjlaZGZzElw4sk0p/i//CcEeyNlBd9hb7Lcmn/Zdms+NOSUPEa87VZyYMAZ5tBXLw9ifrlvPkz4pw1LZzpQX2tDzKo6TqxuxQHZcgx1uOYFYHcTsv7GaNVb8fXaHfiogJ1w2UdDsyxgk7q+gWK4LcG03jlgN1iZsGFO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 07:54:30.6389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e8c668-caf8-4d96-fbec-08de7f436d61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

Whenever a new set of representors are probed by mlx5 driver
on Multiport E-Switch setup using these device arguments:

	0000:08:00.0,dv_flow_en=2,representor=(pf1)vf1

mlx5 driver should create 2 DPDK ports.
One for 1st physical port (transfer proxy) and another for
PF1VF1 representor. Parentheses are used in representor argument
to indicate that physical port related to PF1VF1 should be ignored.

Offending patch has introduced a regression to ignore logic.
Whenever mlx5 driver checked if related physical port should be probed
and if representor_match_uplink() returned false (as it should),
this result was ignored and probing continued.
If requested VF/SF index matched PF index, physical port was probed.

This patch fixes that by adding explicit rejection of spawning physical
ports for VF/SF representors if checked port is a physical port and
driver have not already spawned it.

Fixes: f363bbe2c036 ("net/mlx5: fix probing to allow BlueField Socket Direct")

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 57a6ce7458..a717191002 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1184,6 +1184,10 @@ representor_match_port(const struct mlx5_dev_spawn_data *spawn,
 		    representor_match_uplink(spawn, spawn->info.pf_num, eth_da, pf_num))
 			return true;
 
+		/* Uplink ports should not be matched against representor_ports. */
+		if (spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK)
+			return false;
+
 		for (uint16_t f = 0; f < eth_da->nb_representor_ports; ++f) {
 			uint16_t port_num = eth_da->representor_ports[f];
 			bool pf_num_match;
-- 
2.47.3

