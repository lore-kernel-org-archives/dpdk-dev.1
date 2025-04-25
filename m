Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F310C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54EA64025E;
	Fri, 25 Apr 2025 21:41:46 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by mails.dpdk.org (Postfix) with ESMTP id B330A4021F;
 Fri, 25 Apr 2025 21:41:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIkKe7teBZgQXnCwT4kwQuMEJxoIxnG+7+wh7N/r5AMbPdU9lZRRgvOk7Orggij3hEJll64uJ7FdU/ZnoraDiZs/32uexVR7yPEFV/EpBAdKt0s3UfoCxo9FsS5Rfmxl/mJqZogieSryIa7avWjfeLoHIpAICj8qQCfeS87hlZ10YJXQXSQX4UpYVEFiXTg6nNRpsciBUtFfo0vbZZ+Pzz2FiFrfdFEdVFZ1AMm1XbeEodwIkm5cSziTSENOrPyeh3GXaUOpttRbP0i2c5qawyccVjJsIQBU4jidFQplZMtI9wseZhDhWsHFxSH4avIOStbhX3Z8hjLBt3k7IO5Knw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5T6WptsBQmRBgvpP/Rkh5P8HfCuUDfg0VQnla8pNeQ=;
 b=P20biMjO4L/nrvoIHD4gNKWKbnDPP+MZoKX68rS+8ANpxnUMLtiSNBkxJshXxYw3VcbtFL5/dfAXtmHhTuieUOqvA7IynMp0W8+sZdcOleDZiB26GL8JEdGpvaJ+wv4+TFo2mdm5q9OfrbgY9ot8HW7vbP1WfWfdFF9+YWV/A/FJL64Cjd7Gd2S1fZZrW7zyjdQT4muNkQqzzr2rWhJGr1wnBXTL04pfh2KtDRFkP0fDsxxiWD8VqqmAyJzf/fyAd+AvTHo8J2O1PycipEO4blffTy63mxI140sKLZA0W7qD4oRN4OOOuBRmX6535eB760Z/D0ZWLj9JsyLo6DXNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5T6WptsBQmRBgvpP/Rkh5P8HfCuUDfg0VQnla8pNeQ=;
 b=YlgIjGw5FyPR+XWyWmjrwTPvJVv6DfJ064kNncseolWWh7pROFyq1CGyfE5yRTyQzdrz9bVMMEWvAQDf4HZr/OJl9qQnAZtpwtOJn4Tx5+oKZE3zd9bpA5EXAeDnlmlGtCwUtOnZqXYeUk0KgkDBLqOFb2ZERXJ1sW/4bL/7QVO3voIGD5K3SsMumsCmqIexQ9Ptle1Wn/pNreESD1FVHz/mvDRfBew/05uEwwKBdDrV/RwRKec+RR9V4s5RMUZ215BoMGxB6+4QK1gIvE97WIVytr2bR+JFQRbkTOtUZfSIPIwqYOgdYAroM0kRJ/zri3xJFKkdJw734dit3CyYow==
Received: from CH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::10)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 19:41:40 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::13) by CH0P220CA0004.outlook.office365.com
 (2603:10b6:610:ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 19:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 19:41:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:41:25 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:41:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 0/2] net/mlx5: flow counter pool fixes
Date: Fri, 25 Apr 2025 21:41:03 +0200
Message-ID: <20250425194105.39401-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: ae227e45-0bea-4501-4d42-08dd8431330b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WsvLDkXxdJO/fV8XTsUHcRY75yY/E7mKNsJg6wS8mIie9UEWzza7c3nyNa7y?=
 =?us-ascii?Q?l1DgdZ+tn0AlxA/yKdxGn3FpuGMm6gg53iVXhlBQeuReI8Gg0dG73/MyNCex?=
 =?us-ascii?Q?pTdF8SvIkUP3fQp6X141bEv7ijJ0OG0D+S6jJYrTU5Q//naQFowNe3XsEjJh?=
 =?us-ascii?Q?5W0iwzfct5+1VfEv5S97b4KDOnRS4xgmEM4EB0OU81VKYmRflJGIXyIMvyFG?=
 =?us-ascii?Q?7LrQXil6KH1YkryMHpVp5+i+TQ6lYWiaKSmGOmlVkj/oese9KvonC4e5UTvF?=
 =?us-ascii?Q?tBuwNrzNj43G6bNS335QuEvI3cIMhDrPuDuE7KghsbnzLvl3PCNUdVX25/Xv?=
 =?us-ascii?Q?lV6ygThXotgVCXgy5XF2nwmIm4W7YlMEc4VAEz6+j16mx9YXR2ObBaodBEaB?=
 =?us-ascii?Q?ZK8lFGB5tNJnvUh+pkf/Q+PrDh3Hp0RtmhX1icciCzw3ZEflqqIea+etsSMW?=
 =?us-ascii?Q?cmeT1stxLFshjxtPi1JmMqxMb0sEcRXwS448cA5DEAwhvTZYZ++DL7NrvO5Q?=
 =?us-ascii?Q?3zQ7S+vV33kgUv71fSQmRgh0TKpMDBPZZVzwW0qwnivKXKM/rwerllLGWCI9?=
 =?us-ascii?Q?eCJkgDRWocTS6BKxx2MgdpD7kgfM6ZN+ymlVA5hYxs3zVL5fGBXk+m9Jkana?=
 =?us-ascii?Q?k3d+tJAjZSBCXi9A2HCIpE0gRcgpB1oA8rZN+6kNQr6z9ENjpboURIzD2QHz?=
 =?us-ascii?Q?ChWg2XWx0D286mue7zCTk7OiVsOnKb3J3Pg/lCedfXTEutlRXHn0r5DTgBcs?=
 =?us-ascii?Q?Vv0/2ukZvpqzExB6cy3edil/4jg/YDHEw54ro2WlfYMT/1zKkjRZzTU29eLW?=
 =?us-ascii?Q?0f378serqX/jiZfOZYhP/134i89NYlTZ51Zxe3N6YYYtP5XEge3x5Kbb2XML?=
 =?us-ascii?Q?+0VPaEWuayZlYA7i21qasiCDitf4Vn+XvoUwtgi0QrQrlWt2Zp4Nh9jUoMlE?=
 =?us-ascii?Q?huJuSa5JpFS4vmoijOvf0DPSHR4MShEm653iQkcWEhGGNz7+rqBBEnHDjkJa?=
 =?us-ascii?Q?8CDSo1LXOPDTsO9SAJnK5oGwxrnmp3xuEYhfSYv0cEd041yMiz7Sv1gucv3e?=
 =?us-ascii?Q?yn8Nm8ukd/tg0OhOTViACcKNUSlQoA/7yEc+R48l9HLZgHnhcuQsJTXofIzG?=
 =?us-ascii?Q?zJBP0gE0dvVqChx8gt+uIieT+HoLIkxdxMkCZ1pbSyG4l7PY8n3Dvk63aezo?=
 =?us-ascii?Q?peKW+Dv1Kp+AV3U2EiZEm+2fEAdwSlYRHUSRkeoeXNUGg+finYNiv8AUUXNI?=
 =?us-ascii?Q?FgVnG5z/8KkEj8CMu8prH+BZ6Q4pOMESQszq0NUwLfJpPs7pbQPviZO/Ln9L?=
 =?us-ascii?Q?VuVE8DAATd6I99/pDCyeuiYoZgy82A5wv5s4pA9Ut3coMLNGmTFtpGwLG+oh?=
 =?us-ascii?Q?1zWomls1SEs5wdQIGkfTgFJplwGaKDOANTZbIKBhc44P64Q2mJEmyOF4Xisu?=
 =?us-ascii?Q?4BWQ20+2nVRHSq3hGhzc9Mc1DrJ6c1GMo/Uj7zqk+hHrnsWct2CsvVqxl4dt?=
 =?us-ascii?Q?7z8e5buv+LjZFtnaw4bkmmevyuSmzBx1WIq+?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:41:39.9714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae227e45-0bea-4501-4d42-08dd8431330b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

This patch series includes several fixes for flow counter pool
used with HW Steering flow engine.

Dariusz Sosnowski (2):
  net/mlx5: fix counter pool init error propagation
  net/mlx5: fix counter service thread init

 drivers/net/mlx5/mlx5_hws_cnt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

--
2.39.5

