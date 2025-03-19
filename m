Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19431C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4874740609;
	Wed, 19 Mar 2025 11:25:39 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by mails.dpdk.org (Postfix) with ESMTP id D0CA14025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:25:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsmyYZUSPkXexqG+Hh5xRKw3y8BkvIDiTaHfWEKN2nq1hVIUcNcJQNFQ9moR1US4aOnNxhM5Zx6vNHMbTK1kektDvvp8mIaEIzVA7KvZwIoMxyqNF422gER5DbLElhOLlNL0CCZCwd1NPKzyP4F/64PhXDGM6T5k5Hrr6MGRLWlpOe6Uq0zthzUmfyx2laTgUgcWnYmSadwttqkXuomY0NTxlTWNvYYjtHwI+/dPEDy1aZLGXDLLQWGm+D/ENmlFqTsQpZ2ZVYzrhbPZH62cicF9k5mG1FipN/YbzGveMxT+nnXmCxhbP8I74Nzedu56MokDc1DMJoyQV7p+seMWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOkjplwp4Brt6du0nDjh0ffSCDV19KCGFexhL9mYdOU=;
 b=zSsrvBZAGFwdbwOpnvgvJoLlxLx7UcvuilBK7g6v/axcc+deU2R4duQi3C5+Hl88vasDV/4aAheCzvsqaEHvxIYdfH4AmgIMeZyWf60uj8ZyVgi3Efmnp0ulw13y7j4p/L+zq2oZyY6RDoL7/TdyOIfJlygl5KE3AU/pH6gEpB2b7Dv+RmnphMCzvTHubXQfg+gQKLg8Yw2NZiYVRi1P3DTphXHMgljI+1r4Ygwom97tG2SkVaI0ErQ2+NnadUTYjdUXLqXDF501qihKRYQVhNwrayenGoUy+eOPTxOQ/xvg719Qm7noaF6syTZ1nYORDExANy77dKlcMoke+wlGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOkjplwp4Brt6du0nDjh0ffSCDV19KCGFexhL9mYdOU=;
 b=dwhkJgAv2OP6NDwTjJazYaPM5YivH9JQCJ/7ZPOZ8L7dCB99+kxF9FLSqpOBqZHVWrwQv+gdUWb9tWDyL+QqqA/b3skFs8bOKumuLaK5HvIuDz1NAaSyuDUhSA4TGwOkNsz1/YOuB9z9uhib1lWjQ4Ds8id0v7uIDZsq6fNe0D40DeKuy03MkSaZxrW7u0JbAzaaZTmKm+8En4dclOBumUP27k3pCNIev/AE4dA0MMmJ7+UVaSjW8c2+EHNPD+gj0BfUOsaPQAa/JuDBuepz1fN65JrylnYBl/moKXDVYuGlLocZzbcnyCLF6VMk5wlgWTdLIMy7CIsQ2vEsB9C03A==
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:25:34 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d8) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 10:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:25:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 03:25:22 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 03:25:19 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] config/arm: fix meson for native instruction set Arm CPUs
Date: Wed, 19 Mar 2025 12:25:05 +0200
Message-ID: <20250319102505.596678-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f85aa6-cce3-4aa3-d59c-08dd66d061ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whkr0eJVpcMjTi7WyXi6PFbr1DrugqPfmJKcuGIx0qUxY4xyE6rp6/carC/b?=
 =?us-ascii?Q?Lv0Hj3jVGl/LKOwS73Ah2BltfG4aKcer4X1ldJWsDLg7ntWXglJthQavnavU?=
 =?us-ascii?Q?xsiL6K3zWgIAmTWQoPXo68pvX/L3IsPx52iFRX6K/SfGdZ2J+vCEF35aPRSk?=
 =?us-ascii?Q?jbxP5DI3UVsZIHb61Sfwygw+lbyWvM2gVDhf0cBkJlcf+PMJiMD0wJxfuH9z?=
 =?us-ascii?Q?O0jcecpMwpDdBQSeMiDKrX34abu5obSVCIByvgWNKJn87XPtD3gOYY9z6U6z?=
 =?us-ascii?Q?l3vWopMZoB5/E/bkjg4t4XpecMyLMYZCdtxgUCp7cSezDHFT9+PdiY5Dq7qi?=
 =?us-ascii?Q?Q/E4giFGYIzEwdA/d8Tn24vyDUn3pFxhGS9V4J2VjBsYu/Hh/wO5PiKX62Ag?=
 =?us-ascii?Q?01ulhlyjmd+pj4+QOYs4KgRyThWYxC7O5UzTgdrOvHfd3jJE82BywOvATGwQ?=
 =?us-ascii?Q?D4QH5W2bn1HBF9q5NTre6ERBu00MQNtnpdIDrOYheJ4zsxMH49aLyW6zem/8?=
 =?us-ascii?Q?lrOqh7LAEgZRctjaMJBxTeYA4ogAqAwLVd4grV6XgysuH/R17nxwvdrWH901?=
 =?us-ascii?Q?mbwe3k31oeXGdoxPeS4gQZtz1OoSTGwi0tMqurEFoQ8Ut/2lCGuriYIFuadH?=
 =?us-ascii?Q?H9VT5O38TumHF0jUXhlBDnXLYRXkDPUfO3qa+14YcI6y1K845n9i0nIbnY9t?=
 =?us-ascii?Q?Av8Pd7BpndQC/Atx/zNuPYfV7sZrw24hKZ5sQwhvV85Z7yRjfJGyyaqmnJJg?=
 =?us-ascii?Q?P7nAPy0ZaKcSONWU1BFlwVqHjVXnrzRZbPFwK56Z21Jg6Xly+HLdye4wx2MC?=
 =?us-ascii?Q?Hy+kMif3JkjrkeoflOCt19l1jTyLkx+gnZGrWhPdpiGDGx5tjh692qh+AIo5?=
 =?us-ascii?Q?lulKaBw6jX+oyuhVXvwe6xiAr69aApXf7EG3KAvqSDULerY8l7LAp6PkfA7/?=
 =?us-ascii?Q?iHct+tpu44AUptHGS4ptCLXZBZvJdQ1+EjdqwUTIQaEoGw8FqLCvRX/Glpnm?=
 =?us-ascii?Q?ET0iVM6NVxp2fl9q223ZCRGH59SehIrVQwCvRzSenL2xK1vptRDqjOMq6BM/?=
 =?us-ascii?Q?I3bVNZ/D9PFy29V0DysW4meGXXmIck3jhk+k7qMWuV/7TK6bm1Bav6eFu8wm?=
 =?us-ascii?Q?nPl1MjarhQehQ6eXkPZghHvdmsM/nAepAQgwDU4XPSSbwhe8Pq++dkP0Pqat?=
 =?us-ascii?Q?ljxjdAmewAMQG3cacdv3OkpK/6JnhJeu97+e1EXhZvuEr3A8ATYFjg5x2Myn?=
 =?us-ascii?Q?N+tGCWxH7IZgXDmcZlfHTcGXz8JwRvebKmNTfu64nx3HTCFkHACm8yVY2el2?=
 =?us-ascii?Q?MKZ9yK1KNJOevrM6hhsWf1Gbq5+qxGoDwlgykivo6RlzHS1ETM+4uk2/6b3T?=
 =?us-ascii?Q?8WQEvmB6VnUE9oizqF2MU3el/3Fn8UXyL2dUcFpYruldXpgTP1cy+PO0vUxo?=
 =?us-ascii?Q?D9F3sQkptX/xgK0eelhx3dqleTYtl9m8+8E6ghC+eyThwaePbI5MSXijr6OI?=
 =?us-ascii?Q?8TRFjltYLSFZqIk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:25:33.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f85aa6-cce3-4aa3-d59c-08dd66d061ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

Arm meson.build unconditionally relays on the `extra_features`
member of SoC configuration.

SoC dictionary is populated for Arm CPUs with generic instruction set
only.
For Arm CPUs with native CPU instruction set the SoC dictionary is
empty.

meson setup failed for the BlueField-3 because it belongs to
the native Arm CPU instruction set.

The patch adds global definition for extra_features.

Fixes: 7829776d0abf ("config/arm: add extra -march features")
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 config/arm/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index a97a28ebb7..f971ed3c1b 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -767,6 +767,7 @@ dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
 update_flags = false
 soc_flags = []
+extra_features = []
 if dpdk_conf.get('RTE_ARCH_32')
     # 32-bit build
     dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
-- 
2.45.2

