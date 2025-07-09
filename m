Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF10C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 10:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 336AB40665;
	Wed,  9 Jul 2025 12:25:41 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by mails.dpdk.org (Postfix) with ESMTP id C07F04065C;
 Wed,  9 Jul 2025 12:25:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN/AuDtNfJOQGYRfOLkx8UUT55GG8BLd1Da1xsQ/SKyZ3iF/np8josJY8RaT8iL3Ydd8jO7I001QdlCn47jsE3NqWp5CRK6L0jUJgaG3TByAhtlexdbImbJGl31UBx98CAHr1wrETgZYnHhqBYDW2eS0kY1pl8sWoRo+3xdzuWWowYoxaYkKeCI4nuTUEp6oUR6sM1qLG+VnNzcwYSkjPaMNF8tScCEF5ETMk9p+A5MJl/m4JJf03rD0kCOPBO74412zGAZFAzQYOHOTBH3L/ERNujD3XuoLga7Gt5B7VJQUHZDODTZuDuLOpEFdjfVtj+UCAHuZV0Zr/BsAsa20YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v66OAV9fz6UEGVqZuGmyJCtmcL4qXvT6IMKcDjNUUpA=;
 b=Cl9gNw9sR67nxm5Vl1aJDPNX/nu+U1412o6LuN8U/Pf//jghpzNKMvpEGLHALPEziYu6h48bj9XO13fNAHceii8GMNmsJ/OJXvReaiWcepBhv7cM3Hl5eqqY/zolyrN4B75munjU7Ux3rjHtXeEz7XRolXYUEL+4IHACK8hIkDVWu2fQBjH7z8dpo7WyNypotaWKCWSaOISgcw9h5oYwERWbdhFwCyFD6o4yctS5/ek1FiB/SRtOLxrjOHuAeNm6lJ7qJ8hwPLnYiKT2dh0dnbEQaKHuV58r4Ey0EM1l8/KmQ6z2de3UBQkKJ6Wo2Hlrt+Lpqw4kUCvyuTtoHwIpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v66OAV9fz6UEGVqZuGmyJCtmcL4qXvT6IMKcDjNUUpA=;
 b=Lm9i/dKYgxfovvn3LZr0YP7gF411wTWBmpZJIA3EAx/gj2kqYmMS9CINUTv8fBHtSDgZO0ncfwgYk2mIyLUgZU+RXb+HYN3Qrsf+x+5t5gfK2nGr4Fi9laFfaj7Blf69ZRupsWGpmn8KbzZTtl1z7fQsZaNcX40dWPdlQPnqnXNiKBlBXbLkP69/aF60x30+eDmY8bIpoo2oMTRIkL0XUP635Y6taTlA6sezpLxaFl4BgMKk0onrdVnxRxwafdYTmYrUCEcDeMty+zz7qNcCaCl8QsXHKtAUBEJ+xjgBnw2RflsCpbr44wGie4ND2F6gsVh2IrqvyFio9DPI40wslQ==
Received: from BLAPR03CA0175.namprd03.prod.outlook.com (2603:10b6:208:32f::14)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 9 Jul
 2025 10:25:35 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::a0) by BLAPR03CA0175.outlook.office365.com
 (2603:10b6:208:32f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 10:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 10:25:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 03:25:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 03:25:16 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 03:25:14 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH] net/mlx5: fix panic for non template age rules flush
Date: Wed, 9 Jul 2025 13:25:07 +0300
Message-ID: <20250709102508.229287-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 81270f5c-e71b-4103-3013-08ddbed2f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DoXNggl47UNlJO+ogpnE3Pd4rk3Nn/V14AUL2l5Ud9gzPtKdgCw3/VOqL8Vu?=
 =?us-ascii?Q?LmZTwyHSELfueyjVZ0e90+tCVUPyPq95FIBIttBaqmvTemOzKMKIrO1L7RcM?=
 =?us-ascii?Q?qwQIhW16wXR3M/kxh1FBaflfi7Oezfc2VffO57vANJyG3p+k09ozTuOb9v+X?=
 =?us-ascii?Q?Ig1czvPjcw4lC+ejE9ayaZ+//NjXmwCOCStKITcFwY0nLrz2W3SGS3Nfq2vb?=
 =?us-ascii?Q?pPOS0wCWmfTVeQiIu7wfsltCftlK/+ZHq9xU/nfA9tixKuZqPv8kqrlmuYNt?=
 =?us-ascii?Q?vPqVSp5JHb6JAJyDnuU0L7TBCqo7/lRV6suCGpNkUMyZck3wEePOuC3Oag+2?=
 =?us-ascii?Q?uB3m5xTmMDlRhqfjerne9+4XSwyJOzMG9bJbIAWHI2QLNeqMXPgECT+qiqE/?=
 =?us-ascii?Q?STUYjlm7n0mNbaPrnST+0u2ANt4H+Ek/BjC2q1soA6F5IY1OTMwraD7qo018?=
 =?us-ascii?Q?ka3izEUDZcaVcKOfdGPmsu/EPtAFMJ5bUvYNieKGNsj9rnU2S8F/IucXVXyk?=
 =?us-ascii?Q?WM18K4LqvFAmq1MK7WCWuTBp0AcmnZ//kpGHAMxadysifBhKA7jgEM/uxnTQ?=
 =?us-ascii?Q?Aw/KBo1B3rSpsrPyLJSvxTa36ohO7OO6AhBnrJ9my2BCKNgBFqdynupGiieg?=
 =?us-ascii?Q?FtAcsHJk+8OrjzHRtXEIfu9wG+RLvSqpbVRr5PSwh8ZsfdAexoTrwsAKqUOF?=
 =?us-ascii?Q?rsvI/YK1xv5+Z3H5pxKZBWqeDz9aUq/2CoqsvXuvvw3CinM6gN3lPIgauKH7?=
 =?us-ascii?Q?4+jNJGnrcuw2sKjb+2gImjLTgUrcFHbwLme2bqsQkXX1SRk1WHwDxu9vdU4P?=
 =?us-ascii?Q?kfQvb3aJWZZtS93YRLsgmuEDHpZrKIVZBuQAjPgnBXzV9P23xVj0hmEVM9TL?=
 =?us-ascii?Q?/EmmQjyB8SA9mSOVWZDJI2MJY45V15RebSXTr99969VWZJmm++QKk5Yd0NG1?=
 =?us-ascii?Q?to3HpWGZgUhxUV9+AD/XAhOKNZBMRI0yCDUchTmD2PQdLOyrj333sedA926a?=
 =?us-ascii?Q?8eOfSf8GqWHIQuBWT1oVJs41rs/s63CrhcB/fT37qRNUHLhIxU419fLn1uTj?=
 =?us-ascii?Q?mzxIBlE+7IYomt2eN9P5JPiG9Tf35zn8MUU6qwn0CLiYMJXbK2pTsxReFakw?=
 =?us-ascii?Q?2sIbuoi3okddnOWqVf06QXPdZ/ISvqcjUz6U3bbLL+j7i7d1deCbQfYd4Jht?=
 =?us-ascii?Q?JfEDN9XeV6M0aOz3vIju2VvqFihsLRDstzBufIfwJlECvCfByX42EIx/ES8T?=
 =?us-ascii?Q?nB5Iwt+m82pm57gLyWRQuAvSMBsDnZIsDnniZGZnwygvzBYYvvuLGn7RXnCc?=
 =?us-ascii?Q?A73Z/uFPudTfKgrsmBrYadZ7QFfgieIGosxJYJCgjqKENZg8O6ctJ+aFrBHK?=
 =?us-ascii?Q?gTJzoYvl3TKgFBQTt8H8h5HLn2n91qk1sa5SxFkAUbGfkY1lr6vnaH0PbkDs?=
 =?us-ascii?Q?ZZ0WaABRGiHrwCl3bqn/7wmfV9z9DnGtWOEeVNkmKG92aciy8V7SYmQNWoea?=
 =?us-ascii?Q?eORJUE5Umk1zhTT7BG852pBI4qYdqf+ZsM+G?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:25:35.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81270f5c-e71b-4103-3013-08ddbed2f108
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

When a user creates a non-template rule with both age and counter actions,
both actions share the same counter.
If a flow flush occurs, the rule is destroyed and the counter is released.
However, the age sampling callback may still access the counter after it
has been freed, leading to a panic on assertion in debug mode.

This creates a race condition: one thread samples the age while another
releases the counter used by the age action.
The fix is to recheck whether the counter is still in use
before triggering an assertion, as it may have been released
after the initial check.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index fce7a7e815f..6cb748b1352 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -172,8 +172,13 @@ mlx5_hws_aging_check(struct mlx5_priv *priv, struct mlx5_hws_cnt_pool *cpool)
 			/*
 			 * AGE parameter with state "FREE" couldn't be pointed
 			 * by any counter since counter is destroyed first.
-			 * Fall-through.
+			 * Since this check is async, we may reach race condition
+			 * where the counter was freed, after the in_used was checked.
+			 * Fall-through in case the counter is still used and age was freed.
 			 */
+			if (!cpool->pool[i].in_used)
+				continue;
+			/* FALLTHROUGH */
 		default:
 			MLX5_ASSERT(0);
 			continue;
-- 
2.21.0

