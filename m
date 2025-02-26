Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E92C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6DEC402D8;
	Wed, 26 Feb 2025 09:03:27 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5A1F74027C;
 Wed, 26 Feb 2025 09:03:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba84qjnyg8A5TSIJbKf+fKF0it1P3fHaG6ZIsnp9R3TxcM7bT3dlZAUmQbpXeEKcVPYYTTeqTckpxNlsdHup7uTMP1ekUcPVe6tsvjUeXMJrPdy4THe5Qq1OsjWfA8WtpL5/RI+gp/KKNWPzxCI6UvpK+mCLRqcpeJ8NkI2OmU1pUsCLQEIVpTqkTlNgHXThYuIqurbdbjF4OSwKz7tUsNP3oBylXyPvTM3v0Yi4GLaPHjw1Y8XjfisLQsSjRcPKotSGGT6rtdc0Ljf0rVwk6tVkUEBcsV1M1eRSpcEY5flHDViDesngzJiAwI6N9GSRvqdHU+A1BljlhLvdrWXKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7xOBj/ZLm7Leyf3rNtTLG8WPTNTQ9+pbwFY48RaNaQ=;
 b=iJHURTOoSFrhx0WPVDumUzHGe5i+0aC8ST5PvrfuuL/dGgB7y8hKOe0SEnM3JnrGMoEjMuGquVLZT7hvTvZC9+QmvsZkEU5cOemsAUwp9404tktsAOeQWmm/PhQwYPtFmhPljujDiB8Uj/eGnofnC+LOhzJDH9P9I5Zrv06kmVBCqlaJiyTSNTSnZ26XAgvj/hjiXzOlSZbG4l3lFik/sEV8MZGY9Wh+ONp9TWNzgFE0vDsTFQYmRCm55NXqEgdfBP/9P7F8K8z/7EjuaalB7PUwrHksZiJEjuyPRf2PWL+OLGM5l/tHQ3t+dTwG8AZMAynVLjmbbIslVGYyWqEptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7xOBj/ZLm7Leyf3rNtTLG8WPTNTQ9+pbwFY48RaNaQ=;
 b=CY7bfdWOXtSfHMMTRG/alhU9/7V8h96HMlzETjeGvqw7RUlCaHY7yJ4bBwm94D94lQqw/Xqi7jpaGxKqUDeVdJM8aE9INq1mdVlo49NLWlyltBipi12dR3qUvoo8GNxu0stuun4BrUa2qjiCqRzEo3KlUcBYDIxnrInYcieMo+BPtaWrx/7e4CR1W7ib0tTC4Kzw1z8c1jrVj6DDMddoe4DGy3vdDu/YtLfW2zqfYNwm/N09tR2nwDKexfaGYQH4oD75CiFTpXSW1QFBMfD43H5SrxETDBKyLIO+teKks7c1Fsn2qLp96kdQ4Vw0Vqaa6f8ISh8lVuENQayBGtigaw==
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::999) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 08:03:23 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::5e) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Wed,
 26 Feb 2025 08:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:03:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:03:09 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:03:08 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 00:03:06 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
Subject: [PATCH 1/2] doc: fix MPLS limitations under HWS
Date: Wed, 26 Feb 2025 10:02:56 +0200
Message-ID: <20250226080258.30127-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba03907-d778-4c97-a3f3-08dd563c0ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJORFhdIPNXBA7bicoy1/GTcMrTLsLE56S1xbXSlLClt2F5EIMfg6LWeugu9?=
 =?us-ascii?Q?wJPzjIuIvRHZzOgnHq91aD4+pFD7OBfC1EoiyFDiTkib+fgAtyw9WWlLFEWI?=
 =?us-ascii?Q?yfODWPUQ2KmdZmXQDEu8Mn8WsSu/G3QZuUNHnjCW/JoL4jlBmS+bHuhXAKyN?=
 =?us-ascii?Q?yfVJ0bY0tBQwGJEr6i3dxNHDrD1elQI45KXAbxg55XWNc9bn1A61LmlPR5bs?=
 =?us-ascii?Q?2ot8QqqrahuklAKsTrWT2FYEzPLUuLR/sz4JhgPBhDQ+oIPEU7HnDs4OJlov?=
 =?us-ascii?Q?NMJd2qDAVF5xVgm88ybMnbgiqWEmHujOHczZMgkjWnPAvbJNVI4K/YbJiSZw?=
 =?us-ascii?Q?CbMCNfIP+h/HS9w21PciBzBKQE/Obugr1jF0IP+OLPnlri90q1TjjzNXDNEB?=
 =?us-ascii?Q?G9tKg1h/V0x4wL8yVs9REXqrSKCShSEhTqsAAAyHBAwYW/OHo0vwyQKuhvhQ?=
 =?us-ascii?Q?dkEtSOFhZapOcMQKa2dpjE4eIkfcr10LJJTr37n9SjSzmXJ/y5xAdAxWWQLr?=
 =?us-ascii?Q?xElAXwG67KgPhoyJahrb18fodQqIt8Dmnx3n9g0mzVk6AKZNIBrAT5861yMk?=
 =?us-ascii?Q?aTf6KUtdCmIBw+xl+GSUighAS0Bu3efdd3N+DS8w4rtAUJ+sHxcaqQ9J2dv8?=
 =?us-ascii?Q?8+YmMTSPjGEXNYESr97jfuVMBVytHosw6gzFDErNqbA6COq94uusfJYvHdFn?=
 =?us-ascii?Q?ax1Ff5L7sfbSnApVvbd2gY43Lh4it38g0GiOiTkgrmgxMje0/gHHHE+dBiI3?=
 =?us-ascii?Q?w4G/1i+/PR4ofVY+cDx2PhvzhJLh77B3yuMGYjf+r2qN7znknxtiTyDZkXUw?=
 =?us-ascii?Q?xaXDSOtVzV+5dZmNKyLRnkGvXGShGBKOLw5GKjcZOec7tu96LtI6xLIhdUNh?=
 =?us-ascii?Q?F4WBkCsFnuiT2TPTcGuiK9/SU+72yc9Ln8os8NIPJdwLdmPNtTBBH95TcCOy?=
 =?us-ascii?Q?2TrToirffMCo1KsEI2Zx0xlk+Y5HXAlFtSHHbaWigEEesAACQf/GvoenE6cl?=
 =?us-ascii?Q?DiknjT7/4kHTc9+Bvm5Xh0kkJeMHQrnMtMjdFM6WuGA+mH8p/nTZqtlCgzHD?=
 =?us-ascii?Q?ZjloQJtDtFv1o+lo3Gz6WunEERKfoHc7Py8Kz/xNyNKhnu87JLo4yaqwfDXb?=
 =?us-ascii?Q?ZfiYW+8ZeHz9YkuWKj+P7U1SrQcJ8n6dRd+9Fou8az6oz+qKp8z4xh2cH4Xd?=
 =?us-ascii?Q?BCK8bAZchmDFwpNlXVSs7uMXxIg/Sxl2plRe2gdDmqIjjQBx0aDQm0nR/UxM?=
 =?us-ascii?Q?i/jMhqz35QpHDvjB9/8dB11ofQU+pQ3BdpLHwByTc+MW3AC3Rxz4+UxXbV+A?=
 =?us-ascii?Q?lYCVNFhUuSG1Mn8lbLDo4rvk3IEkJW14tIM0C2fqNPBZnyFmeg6OoV8tGTDf?=
 =?us-ascii?Q?/iVtKFKnGhA34Y0ycq8t7eKUh+TFpHTpNkM9aStU5rWUQW3K9jG4FjD1gIIC?=
 =?us-ascii?Q?VL0eQUbu4gVK16BIQ56LednWR4GereKyHOvhcZI2Wm1OZhh+R/eFUKQRYQE3?=
 =?us-ascii?Q?pct5fpPpOMXHVVg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:03:23.4937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba03907-d778-4c97-a3f3-08dd563c0ad6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39
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

Update missing limitations.

Fixes: 1e2a51f545b6 ("net/mlx5: support MPLS tunnel with HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 690b46a9743..316c3397d2e 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -279,6 +279,14 @@ Limitations
        which results in L3 encap.
     d. Only in transfer (switchdev) mode.
 
+  - MPLS:
+
+    - RTE_FLOW_ITEM_TYPE_MPLS matching is not supported for mlxcfg ``FLEX_PARSER_PROFILE_ENABLE`` = 1.
+    - RTE_FLOW_ITEM_TYPE_MPLS matching is not supported on group 0.
+    - Testpmd commands "set mplsoudp_encap" and "set mplsoudp_decap" support only one MPLS.
+    - For non relaxed pattern template, MPLSoUDP match is assumed when trying to match MPLS w/o former
+      protocol match.
+
 - When using Verbs flow engine (``dv_flow_en`` = 0), flow pattern without any
   specific VLAN will match for VLAN packets as well:
 
-- 
2.21.0

