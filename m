Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5291FC61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8FA840678;
	Tue, 25 Aug 2026 14:20:53 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by mails.dpdk.org (Postfix) with ESMTP id 4FBD8402D1;
 Tue, 25 Aug 2026 14:20:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey5k/5u0IemB1XQmqO1FvaNtkiRu6uY2LQ2IiTnb2X2B0WsC2dJ+MJJunJ0PhETAEGLR+RhmaHYsFjfrf4cLcl3suhlIzjn7F90H98bvdKqFVYNjOSQFOwZoklq5jQhAyMAAIEV7RRuts8KoOc3Ea1x8KgeGiCb071x5ewR/3PG8AqfDaulLb8hSWfNwe11/gW1ynywpcKIed8nh/16cCeckM17GXPRCy5QQf4E4IpjDalW4TIBhDn/U+9gPQLDhA3X8z7MCSqR4OVhmQEY9mTH4F83xHgHeBaVwm8fH03Q7g9AzCuk9nsEIzNgrTb/To5TKVwbzeDzbfQbOqnTpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld/4yauDaorTq+b/7BXgSCmCMRPHUhSbK1y8x8NoxyU=;
 b=hf7ZjuThrt6c6vvldtmyy5hA/EPTPWs25WjD6qSD8dq+nA+M7Tx2RFgCzuj0KpIDimlheS2g0nIE9M01lhU4UUed8dqjtRdjVLcxmdTTf8Hve9irfdBIv/M+H5liNN/a4ceKc8/42eq5XLNloutyGxQzkHFXogIC3dHoBT092lKGmz5R6IbDOEYuuNt9OvXGdMHoZTAGggF9untMHVA1zOumlDUWYttzZedSpI7lbZ+by1R7LeaQoSfFs+Vo5NP6RpDCYXT/eTWFH85y8rSYynoo1R+L5ZrqhY7w1shd2aJtfgelIz8ri1bs3HfV06t14d+ItqshYfLC3vQrpuLCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld/4yauDaorTq+b/7BXgSCmCMRPHUhSbK1y8x8NoxyU=;
 b=k4wWtQZR2FFxmHr1rm2CHemJ4SCIlvzmQoR9Fn+mr4hO5rWG20wbDsheSpbHWwJI1+umlzq58CrsMUfnK5a6UAjegYr3iv0R2C1XPqVzcKeTMBvpSx7xdeRZb1D7+n/XGyWUkJFERqJfbU5lxsMdY9MilZ+kiVwt4hcMszOjE0ZTAP8Njbdes3P7cWnfBFGC1KhdJg48+EarRlf7zyfvnyc/cIPo5Xnr11D5NAzpqJgl/zjyf1UUsRatZaPXz0qkfsypYBpo1aaLtdXbTURKJNhRJDvZoCHk6y0y43EoN2THHPNP2QPNFHgQwWQ2f0vbz1+jMSbEXkovq3krshqZFQ==
Received: from DS1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::12) by
 IA0PPFA8EB66EE9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bde)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:20:47 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::88) by DS1P222CA0007.outlook.office365.com
 (2603:10b6:8:454::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 12:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:20:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:24 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:20:24 -0700
Date: Tue, 25 Aug 2026 14:20:21 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Adrien Mazarguil
 <adrien.mazarguil@6wind.com>
Subject: Re: [PATCH v2 11/17] net/mlx4: replace strncpy with strlcpy
Message-ID: <zjgnqiopulxrq7kz3pdivk2ky4ye7fwzudwdpzjcyxo4w5qrjl@jjrt4toz5znp>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
 <20260624103658.792750-12-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624103658.792750-12-bruce.richardson@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 9929ecd2-29f5-4e1e-b3c4-08df02a34ae1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 52k4rd2FuRy20jjz37LYJ7mC1HKld5if3ohSTrzvjYa5OzI9rYWkDJ6NrVRghedFfREKYQPDATEX0zT+cndZaQbQRdTvW/fZ1u4bKrwRUQDMu/kecvK/iirFvxY27eWKrEAryn2Yw4pS+0o/5uCRzdZe//TMuTIyvsslN/0ttLTb1P+98oWzdZ14MUScdmhFOYFdujDwDWqPKlEgz8KZVVJ/hjBJgaKqOYx3ABN7KooqVYYTX78iuB7KRjJbChxeAcKhFlwEOgF8HyzLWWxuVxRVFUUMr1Jn2AYlAwQz0Fw8Ytu3IQEWByaORNvs5lO15dgJMpzTPAzYJS30t+77ScsyDuIuhPryhdMH2svw8JNE8ObVhL1n/bMk1uAt3laSZ3BDJr/sHxsJGTb9jITfMcKLKSZII2ydggZ/ORpv9EmJy9DL+3Y2kGrMrc7buOELE1uxbnrKDVIA0eBpWJwD2gl9Z2f6njgMz76jLNWbrlaNXGNrSKcmHLDUkQ22csxZnxRPEkb7iiFkPg2uKeq/zzCkx2X3Rw8ZORGci0XQ6l2Gp5WnJ3wnYYMir4sv4ZpvcqLrfatKrzKpcjRJqvGfQ0FQCzgi0Nfe549K7svqQt5X9Ps1HtM/UrfDBU1OGVXrBqUf94aSaeHWUAnJ9ciOnMkz1yf1SmrQVBgG5r+9jqyGelEASqIhJj43zyYMUHd1RKCj5n5XmUm3Nc56GOZQHQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x5rK2YdiKOEO7S5a7P3vSqUvAoxYGLIzqZxJ0UsnKzIICR8hoKAlSfc/k4ZQSuCCn15RgUs3qvobC2sX69UWMzqrl71OPH5slrntk5f6FSRIy+r3NLVC3x8MF6RrmaK7j8c2Y7Ognc44eacwW3CqwBXp2iCdRnztuGZoHmHLA3/YbJwITdYS1Ymnx5arF2IsXpIlyFxcntjyx+/h4fpI2IJs60/pCv9Vta5KBK0MeX8l6P44NtD4ciJqGvEFrBuXXe5ezI/E1yvXy8VaBxSwLOBF2zBpqL51MWJt8z0YvX6vaEIqJvMZYavv2lmhAgqhWpNtvlidDY5pPVCkjMAZKFhI/C27ngGK62Dow2JvJgIc0rRosARUTQQ7h4g7ZWwnw2vdRfXyd1kwcdroAOIvRW3/L3H0qf5SagCfQd3YU10+cHvlYWm77iUo233HmOH1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:20:46.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9929ecd2-29f5-4e1e-b3c4-08df02a34ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

On Wed, Jun 24, 2026 at 11:36:50AM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: 61cbdd419478 ("net/mlx4: separate device control functions")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I sent the previous ack on v1, sorry about that.
