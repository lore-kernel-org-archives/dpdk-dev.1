Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B3EA8123
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3BA406FF;
	Tue, 10 Feb 2026 15:47:29 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32]) by mails.dpdk.org (Postfix) with ESMTP id 79D5B4064E
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:47:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8lm3jz8SztCcvekyroRSzyS1L1hTdwrCjWAVKeBVRXSiWjyfuVFYpGi/5cvhKNHGSmleRWHe359P39rV/kJ7eXttT0he0Rzp2D18PjHhRU3Ur+4e3Yn7E88dymkEvD6BRcihE3DKG8vv48GABgNbB6N+R1fv9jyLKw9H90mAK69V3Y5pUqvT5VEu582dQXlQnTZ4IvdNrYTVTzjT9L848u/4SjW2yN+KYOtiY75ILqDM7UPUa7ls4I120VT0/iNMjT6Nf6YqZF1uM7DEoi6RHWfEukCxEZUGp9iD5NE6YImtkVKyfgxkI4Av6uaHgJbJDkq/66PvgzYSDQD1N8TqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgDYEmp42UGGH1qs57UETpN0kBOLokw852IrpLsu7ho=;
 b=YkBGdRnlg7Be5UFlBxjTtHY4yt8P7HhOVJO/5E7+zlqGdMsa1quVSxkcdH0nwjHnC/Qv8kS5H5tVI5D9zr+Xi49t4EXuypT9uj8h9fEqAmqhk5Ett04Pzkz/mpOZRlr+CgnrfrDdAp62io4SRqEgfUf7pgvPX1xRcBhuIPx0CQovf4YIuxCDGtSWnm0zzo/K2bGYM5CSjOzy+ahQoLNlL+emecqrakRM3k8Sg6PvkiC50h26vBppe4vV2LjQEde4972GBQg7FXnT0JY/TDog5Fv833/bx+OQcNNjEuq5eBLA3uFmeqz2EYWid+Wij1WvLNC9lXedt7TNO3imyPWpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgDYEmp42UGGH1qs57UETpN0kBOLokw852IrpLsu7ho=;
 b=Z9SgUrDWLxO5P7b8nJSmKmUNC4g6EKTUKOGVzU+dHaPPZTpZ5KLPYs6jnOqwhXyuqAin2bhjqG7u4qgey8VApue85ZWgYjW6FyqhSv8cnWArTx9YHyLol2W+FmR8hwCWaZdxQBUxODIrAC7EF1gylmNQSFlUZ7fMzH74UyWGgP78Sp6cPS/GzabLW+IG1uUp+v5FnAopoyCLKA9N+mDrIMxSSWww/Nd9i2pbxCGhH0clIt8nQ+ZVbOA/6F0QsV/AdJJUHLkRuZWjDHoUQ2U/BC/Ck/8AofuC24voNOXr9dBWItggTPUHJg+Iku4Rrzr7+h04ZdPqE0aWKTstRmHCSQ==
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 14:47:23 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::5b) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Tue,
 10 Feb 2026 14:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 14:47:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 06:47:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 06:47:01 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 06:46:59 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <michaelba@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] platform/mlx5: clarify device FD closure in mlx5 guide
Date: Tue, 10 Feb 2026 16:46:53 +0200
Message-ID: <20260210144654.96538-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a4fb36-3194-4bf7-335c-08de68b34d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7XOHHHhMH6KMhowwL1ThLY9v65i2rj45ivdYTwnYlPR9yfAP/hoaWM2DZvNC?=
 =?us-ascii?Q?vvf6rSPxwndNmZPA4p3qlFNJlTkOS+FVtOYiv2ChHozR6YJPnQNr+mKAqScR?=
 =?us-ascii?Q?MmipN/fXRJxXr16tpxRor/iOE7IhWoi2LxTj3uzjAPpnqHVbC+GFfEgEwgm8?=
 =?us-ascii?Q?pTb1VHKikqPDmSf8KkqMZAB6SnAIIc04LoqNFhl1n1V0MYPd12+qi/np5tIh?=
 =?us-ascii?Q?xD1yme4m9Pnykpig0US+MWXopWIcuMiDa2RGv1arD6SWR3OVLIu+41vDwHSi?=
 =?us-ascii?Q?lx8zxXiMWwRuSELgYcNLbmB5fyryAmc6T1e4tWgljC8JBtT12VvrBr1w03vX?=
 =?us-ascii?Q?/ZFLEq4EDD5lTN1Pse455vRa78Mfcd3jIP7Y0PEbFibAXLrfRLeV44ZyEJeZ?=
 =?us-ascii?Q?2zhpivHqLhdZXXdHziB8/N/1dYOr6o1W1z38KU9aVXOXHXIBdvpc7XnA5f6E?=
 =?us-ascii?Q?pVYPf0ZP/5GlyYH/ojjSQkNABA4xv0v4FVpu5qsMjau2jl9OrhT7l3H/oaeh?=
 =?us-ascii?Q?wZbWGGiF+PWqLvmjp04yK42zUaLYxcdPC1qntf8PUrZ17ix2yDKXw2C32Kwe?=
 =?us-ascii?Q?37+OMpygj11qcryqOCL1bTOcBwr6cPt6qlCRq9TAtLZz5+Efwb0Z/0LLyD+x?=
 =?us-ascii?Q?2P2zBiFIV/YlrwjbAOPXavySKAr2/0wf/ff4R8054NMp9BPJtVch6G62siaa?=
 =?us-ascii?Q?iVz9yDGb/uOYOvp53NvyuSguVmnPE83ZYHjyHwSYdr3imvPNPXh0l/6yQ0GD?=
 =?us-ascii?Q?OZgWxOTaDXB4TtAloLRGFhuvsvkDOyOigYDK1z58n91FBiSSy1483qzYLnb4?=
 =?us-ascii?Q?hosB7WDHWQEPqwzGDZvTSXTtCAAa5wY5GeuWi8JO+P8ItxfuEBcsbLu+v+sj?=
 =?us-ascii?Q?PeNmGunHhYd4AlcgAO7Vz77re/8H29D4j9KGAkzl8e2gE+v/Yfye9xV+sD5Q?=
 =?us-ascii?Q?o/97vYn/gkDknoZsP0cB+Lz0HVygCbccAeWJmev5eixUZd11HQ+LRCe+8ZJ1?=
 =?us-ascii?Q?e2aw+26razw8lb8ohMedOdZAU3A3tgF4LQ0EeKyA1/ti2R+dq2d+B+y0NI9R?=
 =?us-ascii?Q?zudFEVtbr1zcwqE48kM1ODjALNSLnYnKxgq24PtLfhbgEQqCswuTNHhSoQ++?=
 =?us-ascii?Q?YYdrn0bQS29UftVNyrWNJ+rHceokE8s684R2/mkGeCC4Hudy5p77ATtfV0H3?=
 =?us-ascii?Q?/4aFh+apv24qVvmE+KaPSZpkY2+rEWPEVVmsrww7giB2WVfQxEdf4PxQLoJY?=
 =?us-ascii?Q?dmk62M8sV3ZzWlktEpV4KXEFFO99ft2Vd51NGTSlaJ/62qiMlINkrmgKknLE?=
 =?us-ascii?Q?UZDYT+0ln/2o6fD0OKzx09ZLxClrWTorAgqY67CC+d/W4H/fNl5BrW5zXwkJ?=
 =?us-ascii?Q?URz2Le0OjfUXNcnTDS18wTWRGz6mvA+TN3ZzZuL8aU/ER004xiDseTtRJVsU?=
 =?us-ascii?Q?bENRh07HD9+N6M36HSxsmpXv5rlTi539QF1YkWDfpJgu/CMSlXOHgVerctiW?=
 =?us-ascii?Q?jNsxnRXl+CVaX33mYKZf8dfFEo5krWw2yLwh/eK4kEd8OvOg/O9qtN1G0NCG?=
 =?us-ascii?Q?1sY247ImADVLLT/D+9DHcQvX2lRmC8HiHvtqfHYDsoq1L1cxbrB1f3EIFs/z?=
 =?us-ascii?Q?jCnRz6neLijPMfRWFtrxV7MyrORmGNiFdCjm/3cotsXRgyC7iOroG8WOD1cn?=
 =?us-ascii?Q?iA4oBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +btVEDQWhW4JJiu8JIzZuGFkeBrwhgViAX18pcHcutgMQ0xR1kg24iYEzpO2vzH11U410PyjLxhAIJvJmu43I/G0bxlrMY7Y4QF/2xaAZ0VJTjw6XbTN+/5Outossweyad1ejTgJPrOdXQ1j9tQUyCFD0DbbK5wbc2px6DvCcNsH7dkZGyDA9LX3oP4Cj5MIgrXAWe7hee6sEkIcsrJeGvMAzpzkiZnsIJmN85aB6DKblA7oC4PqjrwfcGpFc/7avqQP8HiFJ2EsA0lYiXJ31/WvrUAQvHfUbK5GmLcDQaSloDljesrHSvedFIpPvAbs1sfXUb2oMFsGzk0pHh+ly4YHBiDmU5dR8gYFAilM8F2O6ujrQ5jmrb+7uDHDF90GOkhn5Ugm8gXl34JI3urfuNqYHvB57rthYCvjPyNDyTreOprpqC0scVoVCVM3gp5W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:47:23.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a4fb36-3194-4bf7-335c-08de68b34d09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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

Document that PMD takes ownership of the duplicated cmd_fd
and closes it during device teardown.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/platform/mlx5.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index f386980fdd..285d58be4f 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -710,6 +710,7 @@ and below are the arguments supported by the common mlx5 layer.
   File descriptor of ``ibv_context`` created outside the PMD.
   PMD will use this FD to import remote CTX. The ``cmd_fd`` is obtained from
   the ``ibv_context->cmd_fd`` member, which must be dup'd before being passed.
+  The PMD closes the duplicated FD when the device is closed.
   This parameter is valid only if ``pd_handle`` parameter is specified.
 
   By default, the PMD will create a new ``ibv_context``.
-- 
2.34.1

