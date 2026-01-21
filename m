Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650ED262B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:18:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B8484278A;
	Wed, 21 Jan 2026 09:18:53 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by mails.dpdk.org (Postfix) with ESMTP id F0FB1400D7;
 Wed, 21 Jan 2026 09:18:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+6pWj+Ec994/eFQ8+3B6O8k6orjcVTdIcALC6bSiHPD+4/itVJZA+rqvzwO7NtDbCjymg0XuPC4YvASgo5RUF2ZE4v6cH6P871SK06U1xGTmNa1qbAd61+4buB/qfBxQFQIP8Ixz6k6yaO6LcX831Eg24keKFajbXyf65pVqb9AgTzyEvC2aCQoixo31qL5JGTRzSbJ5RPDNq0CIceQpxhbV7Cm7NQ26QeTwLuvx2cR5/Adp4xIH64SKw6fIkUxD9GAqxBCghYqD/IvdiiUkUejxjPCaLac3SoKxE/VNIxK3FlBTmI8h7VEOWJHNy3trcnaRLccKUCCA8Lr2m9COA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6xUKgb8m5TBjK8RXUlWzDX1XL805JoR2CS/1lJFvq8=;
 b=OGRe0kVrv4WK8BfjYNGBQW3BpEoxMiSJA9vJMS3g7hU8fdSqMJeYRwqsdhmrzb2trRmK2WQJi+I7Iuqsex0XhiCotLPjlVjNagGaDI6b+wyGXXN+/ZMokKibZ33QNjGTODV+tkbqcN2ey9GrmgOZNY2/P1ix60q43/NYNtjT2sqcVdz2GUB7+iyb28HIdr5McL0ttjK4iAFb92Cavo0mCbWSqR2krV1tUsisOlVAsyaXGEFvnSquuorH5mB6u7wm81lcSRZwNMSW1M4MV2Y1+vu3hVOGHyHv8fOmblA9kW7Nu8NLATuXxOVCN2B+DIXOEU56Ag2KFyn+zRJQErZE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6xUKgb8m5TBjK8RXUlWzDX1XL805JoR2CS/1lJFvq8=;
 b=WHJnODj3k87zxjNEJVHa09JPs92UJK79oRkU/7wTKlfGLEtLgdnVL4tdE3NCDZAuJf69TtDwsD+FexCtAn1RtRE1yjE4ETkgirH7q8fBzc9Rjn/hfH6z2KPDc/LyQMkQejhz2YIoYC3eCos2chb6z/3/WNRGGauDJaYzt+ftlvHN7yqzQKjTgzulX394q1Ubxym6CPNUf7vxp0FHCNFfWDfgQM/itAjffKew7RXbvy523O88DVZ5slcdh8rn/RwGba4AUu0xMMFS3ZwkgJeA57PV7aNnDBd2MyqwIwSP9vBLGF5Esn9zldFcxJlq07p0MlBh/yiAIxC3n/fq8IrP5w==
Received: from PH7P221CA0079.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::14)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 08:18:46 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::cb) by PH7P221CA0079.outlook.office365.com
 (2603:10b6:510:328::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 08:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 08:18:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:18:29 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 00:18:28 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 00:18:25 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Ori
 Kam" <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
Subject: [PATCH] net/mlx5/hws: fix null dereference in rule skip
Date: Wed, 21 Jan 2026 10:18:22 +0200
Message-ID: <20260121081822.224431-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 104e2648-93a5-43c7-98fe-08de58c5b256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQI9AJTEdaPo74eldDuN2nZ5Rudyu4zWy8aB7ziWl2aBPuy+zcVnBS9PBqTv?=
 =?us-ascii?Q?i+r1EuNDbq2oHp5FcLJPJN1uPHTWmByxE/oFLh6wivzK6vbLgDqwwwnZ8+n8?=
 =?us-ascii?Q?5JpFecIWp47Bc6wfyXkTQYaH45GUXbXYg1wu+qaechj4sS621VrUMwDhrDE1?=
 =?us-ascii?Q?Y0yu9PYivBslOCLgTPyUisQzYzQIcSdQgIvAY0RAU6aU3Kir0Mu9XTtmIMB4?=
 =?us-ascii?Q?JwfR30cezPP+v+qWZEuUvILIsQ5Yzyzk+Jw9D11qkQuuoiyCI/AJiK3Ui7xo?=
 =?us-ascii?Q?3TpiHYDHwWvXSHnLX5XuLu5CMhtZnjgR7v7SxS9FAqpfY+f7wqo6CFZYrtbN?=
 =?us-ascii?Q?55EBEJRhkoIXsd0DUXaNuhhR6CEnSMOlmjFtlu8YkoTdvKTzCt1RKPgP9mHq?=
 =?us-ascii?Q?eKhVxedKG/K692vNhXwSnK1WMc18nvO3dsAUFrr9iZzYJr27Ujmxt80oVevu?=
 =?us-ascii?Q?RMPpolGV6wnWbhXZ2DD1ePd5hAfizJR6rcp9bhauyoaj91yeVLVMaroJAYsL?=
 =?us-ascii?Q?yU90T9S9yfVhYCRCBkcxplzni2ZW+7s0OQrXKM73RqwHiZ7U1B3YICOLzPUU?=
 =?us-ascii?Q?FuxhZ7NVlS9fuTZjQGfY+EX69rtlXgdg95sEULNLbb0HH91Y1nYwmtI00unL?=
 =?us-ascii?Q?FsjwmXt8uJyksmfaCzoHaqSqpMnGKAhjFyKJVVrC1m1CEtVEARI7/m2nq45Y?=
 =?us-ascii?Q?LjW6elRA80h5ezkgKq6wgUdJUjOWa0VPfLmNbe7I4k3RZC2yG0/opM4nKbFw?=
 =?us-ascii?Q?UXFL4w6QrgMkNmIC/BEYJbcoUJptGZb6cznSSNYSN9RO6INa3amaxrBuwhmF?=
 =?us-ascii?Q?qTk/C2qIWqdk5o8+nKDl9Szc9D/O2ZlrC1+U4GMjMgozsEWlkTnemF8up3bj?=
 =?us-ascii?Q?pYoCK6/vFPy5RwcShMrU1i27nZ8gtQtvFGiPxydO7vfK9/5EaVOSvvxjqgSF?=
 =?us-ascii?Q?HmjJ1iZ/SRu4yFfB7YpmodFVziA9PgjnOX3qf7K1p5JgXE9XPw1Pwu+x4SPX?=
 =?us-ascii?Q?0VF3I6Ai7a1JdW7ZkOFCey8oJX/cWkb342vvKq0qvNaFcoCihZIKT966aAat?=
 =?us-ascii?Q?WFFubzBi7GnkORYHdBZXCGPnA2WSNxZFvuQVXzvly3tBdQw692zNaSwsgf7e?=
 =?us-ascii?Q?zldvWPKk2vf/in0kzwppVFcVWZn6wGULzKGgkq6aTGNXZbnUZSRp/MFhV7sQ?=
 =?us-ascii?Q?XqFAoxbOOciGw/ao91SaERxuBl+tKMBITkJUNvRVFrQ6kyU8WLdTVmfgkQfZ?=
 =?us-ascii?Q?J5SrZL9xwC7JvIFbN2N3FBtvv1W6p9ON8CIoljetTcuk9BX2fhr9g7OVX57v?=
 =?us-ascii?Q?66Mypr12Fy+rFEpVocEbNQxpuR+haK/+ujKO0mNpM5EOmd9W3UEsPXAvOeve?=
 =?us-ascii?Q?OE5nbiMfjNr+k41gv7MABZZnF895GkNe43hf2LogLogyduelSk76OFZL1cz8?=
 =?us-ascii?Q?rPfxbX8905X0BvHQram6lmfrrV6OByz/dFwAj+Llpu8ThD8aCYS+ReqMYMQD?=
 =?us-ascii?Q?yMO8fSd1nV2153jHZFhwFkLbk7F9kRkiaiy8FAV+fKMjsLIezMap4hNJrHU/?=
 =?us-ascii?Q?C1TRhDoxTtTsEIbksPHYmr4WiGmwZtzIC71yQpeq0YoGtv8j/4HpXtzbopaU?=
 =?us-ascii?Q?pILIIBbQfl5kJABODWY9D9LzoT1kv/fENBmnj6DUgm1rEHmYWucq8GCiHjVr?=
 =?us-ascii?Q?LJMjnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:18:45.5774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104e2648-93a5-43c7-98fe-08de58c5b256
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

When using template API with a represented_port pattern item that
has no spec, mlx5dr_rule_skip() dereferences a NULL pointer when
accessing v->port_id.

Now validating the spec before accessing port_id.

Fixes: 405242c52dd5 ("net/mlx5/hws: add rule object")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_rule.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 895ac858ec..23327d2b73 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -38,6 +38,10 @@ static void mlx5dr_rule_skip(struct mlx5dr_matcher *matcher,
 
 	if (mt->item_flags & MLX5_FLOW_ITEM_REPRESENTED_PORT) {
 		v = items[mt->vport_item_id].spec;
+		if (unlikely(!v)) {
+			DR_LOG(NOTICE, "Fail to get vport item, ignoring");
+			return;
+		}
 		vport = flow_hw_conv_port_id(matcher->tbl->ctx, v->port_id);
 		if (unlikely(!vport)) {
 			DR_LOG(ERR, "Fail to map port ID %d, ignoring", v->port_id);
-- 
2.43.0

