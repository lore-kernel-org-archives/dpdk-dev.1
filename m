Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CAD2FEC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57FA840E50;
	Tue, 27 Jan 2026 18:45:17 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20]) by mails.dpdk.org (Postfix) with ESMTP id 3055540E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:45:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6lAnVIZvogJcHocLe355Wp7D4ocEK41b+Uo0UwoNyvIMBDvAqjrv0Zgx4iudeQ5P7KTgVHl2UA7noCqRN6fOMmOMA6/mC0M+fQipmY+DHUgDu76LKCMDAntrbScsjYQfWZpspqtOQfieJ7dCrFq4nMI20ZJapGtF6hJjQXqWnDoiTPaqhCeBDhgT6ccUpSFT3ccz7lnW65AN5AgJTPpkLO9CCKOIqE3pCZZpEeJsTgGxKOcBSXf2/bMtLrA+q+Up2GXLmeuCDB6kpErb7Y7D8+ziUXhipEhX9ajl5A4HpjSRdYe3bRSie3muf1/Qvk2u1WdapM/ul3MQWn3+ivx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msrWjfcfY+pc+H5rod/SfsYls+MqqLys4GZ7daZ+yT8=;
 b=SMehCHIWaOpuGACkGVXPvLK9n4xIdbLXyIIUtIBNRq9uo8eXAbuKkHFvJkNqax9Zjtdh/+GekjQXlO9lPVQ+bvpQ431Tgbad6DHlZ+M4ZhQ3fobgg1RR81i2W3YudvMH8LVWXBM7dii9FH9S9eIIfryJe85CHAO4GXIMijsC6YEvl4EcLkR/7ax3kLr4G9Sh/N42MJgIGGmTZMt+XzZXbYcwBaWK3a6h1PjwMoahGj7ZGDK+QETfvJpVwycfDhhcT2hvyAeTKep5FV3aJwvLHDctqSvICH8uYv1o1arboSNKOd9ilLaPpuTTl1i/L4qvqBW9kPnfBxnAwqcZ5GrCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msrWjfcfY+pc+H5rod/SfsYls+MqqLys4GZ7daZ+yT8=;
 b=ZWUQ3hfJxIUFmZggn72YzOboAc0m54t6NS/0IF19apEiUJpG1Gw51SRUoKWVe9WXoIS8JC3nPafWlz52r8MK4Z2M5e9QSEdHWkaR/Sa4XvmWktmJL86xIzota+uHZtTM1Ki1ueDz0HGtPRIktvkiKrFmWwYBweKs1RrRi+vCwdXdN1idHJ1xAtjJ5fARh7gAVRMFq0dsB4G5h+cCBpT4pOiqIWC4+vJucFvtcdo/UGTJtGSgFOqgz9KydECIvqCS8cT2a0Uv8Gl8S+rA/9DeKG5SbvGHjDmwtF0QLSjcxsj2aF5UMd6wakk1wwUr93mYHu4ZWuIYrPJczBVDSb8cGQ==
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 17:45:09 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::35) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 17:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 17:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 09:44:48 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 09:44:47 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>
Subject: [PATCH 0/2] support dmabuf
Date: Tue, 27 Jan 2026 17:44:07 +0000
Message-ID: <20260127174429.1504288-1-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d327940-b6be-4e68-8f33-08de5dcbd066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jjCaeykZd0UW4oBc76ZCW481V7+ITbdUkcRs6BnAU04Uz0ZWFHnFn1g/UKG7?=
 =?us-ascii?Q?sDeb+Sj9jb5VhRxTeN4zpbxIT/M+WccsLJEU+EKfJCdE+j9rw4/eeRx7h2Ni?=
 =?us-ascii?Q?pThRXSUDsLmBX/O3EczHW5jVKSpxZ7hNIBo2oAIYgF+kmI1WSG3V6+JoyOdb?=
 =?us-ascii?Q?cH4b7VOW6AnpGL3NhrFjbEYmTRM+ml+bwDKpVEm8FRi3TgcawS/epPe2smU7?=
 =?us-ascii?Q?YNF2KerIPeX6nD4Oouny2/8+Kp3GbuH1UlAaqZRpbd19yvmkA02KFburALrw?=
 =?us-ascii?Q?2MDnPLMo3HWFdlopAyk1HeUuC8hwOx58O5yz9urD7NcyL+ai2P1XOu5ECtkV?=
 =?us-ascii?Q?QB87o8mUUX6LUlCpv7RXFcndx+rXEuADu2Ybp6E3V527l0oksev73UsTAtUO?=
 =?us-ascii?Q?DjksgyNBtORPoGW5eNQXd8qySsIFm1sqxBKV5L3zEb1EWk+ddzC6YuRx6eNF?=
 =?us-ascii?Q?sJmUv1mz+siklTTdON4nx/kUMct1U4Ov+ZGyvm+fEevz7Th4OEX3fXsA7Pc4?=
 =?us-ascii?Q?tV6wlHQeUimJxXbFZzWzeaCp4vLmtfCy+x9z/P97UnfYx23SHM/SlIThnm0b?=
 =?us-ascii?Q?AMRWGAK/jgeh7dIZA+sh94+sRMab/c0A1eOMHajHkr7pBuDvuFKqS5BvLXMw?=
 =?us-ascii?Q?3r7LVdkmW9/r7kKVxpA8pjndbCjuBK9iOvuF4yHnZ6tFSeW4dZ0f8gaau1m3?=
 =?us-ascii?Q?Df/FG1m7OrPjVmkCM/SIwcevW7GO3QjzCEhKjLow1Q5wmnsjCeVdHDwBejwa?=
 =?us-ascii?Q?JopAlTal4y0qNguHMFOabquk4j4SAXxlyzuU7TSHXrhGeHarj7N8fANxu8Ex?=
 =?us-ascii?Q?L+S67O4I3SB3ZHzfqaWk3rLNBBKXW6EoFdN5V8mPTPmEb3QPTk1ySTDE7XGw?=
 =?us-ascii?Q?GDdkLof7ozPy+oUPtXeJKkAvI7U0oet1ePDlwBzx4iFLBo6LEFie9Ha0O0IN?=
 =?us-ascii?Q?If7N9F4KzNE8Hvdr8Z8JJmNaxi1r8usQTAXsuJsg/WQgEbPNnBh6KYGmvYxu?=
 =?us-ascii?Q?vUWwIOx0urWpO9ygNoywpRloQY7CNNL7YrAlMD5GQD+5ycfbldgmC0wXkf4c?=
 =?us-ascii?Q?34807wCOn4M0vMFagBL0rJc9jQ1g9Rys/7E/+uY0mN7KFD+cy/bW/p2t/7Oq?=
 =?us-ascii?Q?sjt2h8Dyrt92Km+uiK9av9aEY3oUW3P7fG5Qc43gVMJO3nFurdEGvRcehVrf?=
 =?us-ascii?Q?s2mQRRvc5V29iWhg+wuWHVBN1g4EqAEyErUFtOJk2cLZhC8yOfK3KhIe0i2O?=
 =?us-ascii?Q?zeDw/8JZFCw1nAzfTZWHVA48OxOd+Kzz8ktxR89bJqAORtJODHvWhw+sgnbO?=
 =?us-ascii?Q?K2kMIKyrxiCbi/2O76tzu3f0DbrZ9ONoOX6XmUgXCP6R5Us2sKEUlLsooUA/?=
 =?us-ascii?Q?vHLdSOiBjF22Zk68xXAYx0l9I+v4icAZjBCYbJAwuA5Jq7ECBwX0kMJfAg+b?=
 =?us-ascii?Q?oNRQEz82nCUf0Wakkb00t8fmoReYc6SOfZb+Qre02PBBMXwy9ARVjbss3kUV?=
 =?us-ascii?Q?CW4E77nZZj7IaHMhFinVcdhbuT5lPrGd2uTpR9Q3uEpyhqpxmi9v/UTL5+So?=
 =?us-ascii?Q?BsxJZgZpj+bPnnRvJolz74pBZVeE9ZLfjY++hv+6XdYr7PHchrywzAl1HqSd?=
 =?us-ascii?Q?R4olKTZlouxWkk225uIzN8Y9zmev9aRch7R4L2eBKp7N4VUfY4ox4tr2rvKb?=
 =?us-ascii?Q?5gFzkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:45:08.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d327940-b6be-4e68-8f33-08de5dcbd066
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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

Add support for kernel dmabuf feature and integrate it in the mlx5 driver. 
This feature is needed to support GPUDirect on newer kernels.

Cliff Burdick (2):
  eal: support dmabuf
  common/mlx5: support dmabuf

 .mailmap                                      |   1 +
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  28 ++-
 drivers/common/mlx5/mlx5_common_mr.c          | 108 ++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 lib/eal/common/eal_common_memory.c            | 168 ++++++++++++++++++
 lib/eal/common/eal_memalloc.h                 |  21 +++
 lib/eal/common/malloc_heap.c                  |  27 +++
 lib/eal/common/malloc_heap.h                  |   5 +
 lib/eal/include/rte_memory.h                  | 125 +++++++++++++
 16 files changed, 576 insertions(+), 8 deletions(-)

-- 
2.52.0

