Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6258C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBBA54275C;
	Tue, 17 Jun 2025 17:43:35 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by mails.dpdk.org (Postfix) with ESMTP id D54164275C
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:43:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbnnrEteJ7UkqEGlRQWqELxzbY7jJWMBUn0Kg5CZAL9ENbp46fJTnAQ9fnnmtnbRGl+9mVhG3LSAJUv8IQfCtL0N6ZxQ6qtCY3I8JG4Kio8dm+GT1zIVLDoCKiT6dGjN3P/JKAYRVzCeEN2iq41NcZWcCYNGMjMebAXQRc+lCdOiDG7eOzW/jpiynv0FDeJu9204lyytYek3DA5SxclcAKFmsPljohAAcIe248XlJ6EBCkod9r51dm8mSLen7QOWKSgSiNbFCJ2+tEPZ7KzaRoM2FlRNWn2LSCzhpRffa9FwseN3M9h5ZHhzforJ5XksSgJpN2xjwJR1xKozLcsDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3K9KwfiZpPnVdYmK+pnTTJhvsKZ24L/S4GyO1+q01E=;
 b=Fldtq0j/a8WlzLkRF7tJbRT2yQL1w4zwoj+0TNd/pFWtwyjubBCspWVXTMGOdhqfA952hkeYE04pgyWCY+vSCJBbGFjVeCd2CYCIze1BRyZq9f3O2mYhweBp8VETXB1+FHgI92RbcqQfKWZ8fM9DEulGHJHgDMpH8tkMcNK+u2kMkM9G0Imax05JvH9TWAKD/l1GJ50QTisZUV+4/28lDOaK890Rc7FdTZ23JnG7Ul/xqxyke2DA72YvxkeC8CesVHHvjUWk+Crqvw/lgI4M4V5X7D3C/TzS1gSLhp0rZy9XZtp1CEXpGEN1BEuq11mb+XXrah8k2FtPNtcFqAaaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3K9KwfiZpPnVdYmK+pnTTJhvsKZ24L/S4GyO1+q01E=;
 b=dn72YHOHl0JpJHCQTygf+O3objlgsFi/wxEyP0Qx68w9gJJQIBx5huNW/jbLO2vT48zGi1/t1R6PebVYFnHrBcUxunicV6x+AnggUG4eaa7SJcmRQHY837zv+rZczSXvql17ww79up+DvdxYQt9cnAYqJZraLojI3XnznmGPJrDPGHTWkBeRhE8lcSX+pBoPmT4q1M3FCO+gglcjuaxHmQqotJPTIyFxaP2a2iJ1j+aUVjXtVs7Ta69YNOI24De14Yfr5U+7tLOFtPNoRNJOO8AKF/ZU00PADF+0s+ye6CdcD3M7XNUqlX3X43hENRAibPbdOzqPE6vfD82fAVUPTg==
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 15:43:31 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::4b) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Tue,
 17 Jun 2025 15:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 15:43:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 08:43:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 08:43:13 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 08:43:11 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 "Aman Singh" <aman.deep.singh@intel.com>
Subject: [PATCH 3/3] app/testpmd: cross NUMA support for gro init
Date: Tue, 17 Jun 2025 18:42:54 +0300
Message-ID: <20250617154255.190093-3-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250617154255.190093-1-mkashani@nvidia.com>
References: <20250617154255.190093-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: e71c395e-2b36-40c5-0964-08ddadb5b60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WSdKQJ7I9I9kvfaASdTSFKv0f8d4yh437Y+PJ4T7JwKmHHbRCLki8Z4XVq3I?=
 =?us-ascii?Q?y0Wh63y5YBwzFtEkqviYbbwpJXWBwUklwlVqiKhsAvI985s6bj+3xun7Ub1J?=
 =?us-ascii?Q?ohkhBBIg8J6SC9tDH5vnSo6IBiusHcc6/0uvBo4yWiPDsbvHOYuBVMZ9SRtl?=
 =?us-ascii?Q?jYaWjhpYsFb/l9DWQJanvrjJjtPoK1FXHmAtiHa/VcIC0+VgzM4ONPplAlhs?=
 =?us-ascii?Q?mftbZLa+qELclAmjdBrRCKS/2gRffZrH14C4lSPjFtymHGKKLg/N+7hxpf+z?=
 =?us-ascii?Q?YBjpc976qc6EC+OqpsD+iee/+N0Gt2bA56Ldf2qKtIElJ9JQXU5mjKMhciK9?=
 =?us-ascii?Q?Vw0VDWVIImP3GweFyR0fGOdWlhxBqOy4RMW3gRQG5JQS44Y9f8CI6d/g4ALx?=
 =?us-ascii?Q?m/tFFX1/oyojW4xBtEd8A1IxyoibxjNL0tUows+Kn93SXCTZrkQNoSFbx4EY?=
 =?us-ascii?Q?XxiL2QsfyIsV6LGjQf5IPiaXVz5Q7T7Ri7xlu7OQO5t5f7PKcGLI3zDmRllc?=
 =?us-ascii?Q?l6uX+aMprm3Yg7j86KogYFWd0JVwqGbxbrgVRu5RWBBuDyoooUzUID3Cxwne?=
 =?us-ascii?Q?Pq7T+yBCcrtdsmLOOmzjJjEzBSn6168yBSeIimkGYv9LqLHxDTqno61WeCmv?=
 =?us-ascii?Q?YKz1+Bf6+semMEeGktgM7U6rgu+UTASJEEJADHHPcg3HIe/fGnl/fk0+uMHc?=
 =?us-ascii?Q?xZvoGycstGD7NshPrCHjTl8M0B5m5kooVEKiS1H9/faaRzzOD1Odk3mvuQ8n?=
 =?us-ascii?Q?IkOseeidkXgV3AC6SccgwRhpfe1hOCJXhjbAW1bVrk8sfIcZBD5sIXfF1xnF?=
 =?us-ascii?Q?zuVXcHWIiAQZunLuuyDHbWkkJ6Np6a7anvGY9FtfQDyNrz1iUQChB61+k2LW?=
 =?us-ascii?Q?+Rf+NQ54YkqeaFuatVqyffFEWx/8Bua88mE1AlFUEuA0p9zIusc1UaZsgBSf?=
 =?us-ascii?Q?8XxcBS1TFHRVICx2RAawf8VQJlpg3m7G7QpuuvrhXNP4gH4gZt2Soud38WnG?=
 =?us-ascii?Q?5WbWjYrVC/aA2BqD3SURQ3z7BzuchuTZ/LdCarAK7KwAVcuKRLPV8hWqw2mo?=
 =?us-ascii?Q?kyV/br4jlh+cFL4E5vUdnmJ6dvcl4XeWbm6IdZrBMzj78zZnmyw2z3nHpqom?=
 =?us-ascii?Q?34dA8BvYrkXch5dWipC0mFdnUo9VDCZi80BZ6+KzvewEUEd5/pHPQ3l96Vdc?=
 =?us-ascii?Q?oQHRo4Wo/0XqoOXLrU7fe4gaSGRS3CvW+HD8Es/BpnIhmkTM029npKfkuCRu?=
 =?us-ascii?Q?+1AqhiAVWbzP+vtfiI19Llep7NDp+yGrJRZXs1YGEUpD34T3vFTV1YkcvcPP?=
 =?us-ascii?Q?21PPVz5w2GPFEaMmNCD0NmV1GJGTPNxt5f/TqNimK8SgnHEwgao4LBLAvykf?=
 =?us-ascii?Q?PaaBiMt1iqXGYIw1YHWs7o1VjewWuXDjlFE487eNB4w58alLXLtj8fuPsaBn?=
 =?us-ascii?Q?ul2pxg8OmtkbETzCii5YHblofntSWPC6TNEffcW0+o/q9tSQQWWwRzbH60Zs?=
 =?us-ascii?Q?EuFDHUxgrtyH4uuW6A3L6UL+Jlxi2ow25sOa?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 15:43:30.9835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71c395e-2b36-40c5-0964-08ddadb5b60c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

If gro context allocation with specified socket failed,
Testpmd init function would return an error.

With current change,
if --no-numa option is used,
testpmd init will use SOCKET_ID_ANY for gro init.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/testpmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b5f0c022612..b00c93c4536 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1768,13 +1768,14 @@ init_config(void)
 	gro_param.max_flow_num = GRO_MAX_FLUSH_CYCLES;
 	gro_param.max_item_per_flow = MAX_PKT_BURST;
 	for (lc_id = 0; lc_id < nb_lcores; lc_id++) {
-		gro_param.socket_id = rte_lcore_to_socket_id(
+		if (!numa_support)
+			gro_param.socket_id = SOCKET_ID_ANY;
+		else
+			gro_param.socket_id = rte_lcore_to_socket_id(
 				fwd_lcores_cpuids[lc_id]);
 		fwd_lcores[lc_id]->gro_ctx = rte_gro_ctx_create(&gro_param);
-		if (fwd_lcores[lc_id]->gro_ctx == NULL) {
-			rte_exit(EXIT_FAILURE,
-					"rte_gro_ctx_create() failed\n");
-		}
+		if (fwd_lcores[lc_id]->gro_ctx == NULL)
+			rte_exit(EXIT_FAILURE, "rte_gro_ctx_create() failed\n");
 	}
 #endif
 }
-- 
2.21.0

