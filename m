Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275AC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B53A4064A;
	Wed, 26 Feb 2025 09:39:40 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by mails.dpdk.org (Postfix) with ESMTP id 9465840649
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:39:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OznyWgtslTRYedcjHt+NzTXbBocJJBTHkXVw0y5GtGdoCQUXlLXkaH/TV8o++4LA/4YtZrha+2TKIwMrqYDCv4FsT9nFw8mYcuGaEwrKR3lVIznR/Z65tuFccEophAjHDOODnV8TR2it2CWdaliU5MHnwd4tJR2JGgH/5+Q6PnomK6pyJHqXixA81ixS3oEwVZxijgQjGvDtJojx1fYe014N8LblDRIamAPw0m6yscDrhwfkCqxW2ys3ye1s48990nLwE4mf5GBsTWr2Odz/B4FHJmDzMdtpSaF3tiIdhutLV4l5kR00Tfbol9KG7vfgwx5oO9CZLzkMZLYHH8gHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX/ySaCGRQ+T++mx1ZVU0Od1arQgeHFWlitqz71L8KE=;
 b=FCKjUroGmqW1zv20XjWEmv18n3zB/TbM5dfQ0FqM7FTL1usILVRkznxeEIlgQQi94RoMciifuZUIKw/o6mgHEfbHB1CllL9+BK3RsOkukrG+CrABNAh7WsCfHpVOTVqm0UDvobWiIo09gC8SlbTRnDwrneYXhZwAY0ug1ew2zc1uXo6Lcc7wg+WOm/8o2UzsFi0bKGHglQV2t9Yq/9PzJk67Tcl+YvIPLTCynhv8E7iDPMzG3UsztVgLvPS8OMy94Ip0MK6+hdBeSDSBwmA+9Vu44hgbijPpn5JHiFt/mHHwqOP3DwqommXXNl6cEsF5fHysXts96XGpE2+CMiNB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX/ySaCGRQ+T++mx1ZVU0Od1arQgeHFWlitqz71L8KE=;
 b=m3t/LnWgHkmx3GUs3e7ga56DVybrgj35dxERynGiELtKUW+SKNhNYLb5/m1uMzSi/WfltQHSNwHe0ZddWDMNogvHcl4FrvJeMOni0QyUoTdiNM9o2Nw0Pp69TluyMUPZTxW3/SNgIa9GyBdEMztDiSqdBwYZ6HkAxIIqrsmYUcETE3YC90Vsh904YVjILgeMaaheqgArckGuEy3rwVrT08G/76G1sjMK2UtTQjBS8DUOCtN1zW21OXletdUMHyk9YoK/cSGPxJUtoXN3wvwDAwEQpqX7TnH9+qqs2OfLPcTYJOuS6Jj1fFymge2sr1u7EH/Vk93OUZAYoyvxE2moCQ==
Received: from BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27) by
 PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:39:36 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::a0) by BL0PR01CA0014.outlook.office365.com
 (2603:10b6:208:71::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 08:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:39:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:39:19 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:39:17 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V2 1/4] common/mlx5: support FDB unified capability query
Date: Wed, 26 Feb 2025 10:38:43 +0200
Message-ID: <20250226083846.4023622-2-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226083846.4023622-1-ophirmu@nvidia.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe89931-61cd-4611-b831-08dd564119a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?So5RP27DK7h6hnDb25mRQ9LbKaBqtCdSqGDvFD9byg3Or8aAn+iACIa4ccIi?=
 =?us-ascii?Q?+lHOkk5fI07OuT8zMxq06EmiP/X8AviJG6O+fRrPqAIl3zsuW72lkp0lyKfG?=
 =?us-ascii?Q?wNzzSeAa3IyjmMrqiwSNbqO5Vk2Gvwea000wjzstUilMkdqZmC2L/lt6odke?=
 =?us-ascii?Q?FpFDPZp8MO3B/JqHtwu7y0BQClUMFgGdiQuy5l8xm6u0AN9Mi0IdUg5dRcq9?=
 =?us-ascii?Q?Ickh2oClNjR0B1oREmhUajYyLEetg05Yop28dnBBi+AjLz4BYTHtX8x5VTxe?=
 =?us-ascii?Q?F0S+Kd/luFCT3gWZeeJejM2r1jIQ+ZTNVmfbzHB60+OoL5PGSXxKnHhOdZMQ?=
 =?us-ascii?Q?7dl1mZu2nNCrzSO/v58UofxCwLu7lzDoO9n+NFat8JcFFMi12Skbgskwa0a/?=
 =?us-ascii?Q?Z52CkUR2b2lDIhBdefi9RGQmI4/VuPUHmBu8RSgs1IFnT0aLa/NPVOzdKkVI?=
 =?us-ascii?Q?GIWOgkBSOXbbQH4sy7fZ7bRcJuQNFwh+4epechlRMjJ4DURtGDMCRu4fa1fQ?=
 =?us-ascii?Q?BYLzo+ZF8Cz3FPKIBTrFEnY8aWEHc5vImNUBLEO6F+7DvNLi/N9Tra56bhVq?=
 =?us-ascii?Q?rN0HFHd7YO6uXdES1zzHOn8nkNmiT55YDE55QmWSu2okWn21jZndm4IWruWN?=
 =?us-ascii?Q?mMX6aolY5EWJ5qQp2esWxMgs6pAdY6aDsX/gzlvx341pQyqO4UjqYndcu5GJ?=
 =?us-ascii?Q?eNTah98UyrtuV86fYH3ImU6/UUOa+ZDCVqLbjmdakYjGMhw3RPeMvyXt+OUH?=
 =?us-ascii?Q?4QhXyxmw2p/TyNXdLxmhbjaI6qYA6UrIrvHTCiHmzTnUxZnryRe+dl5ykblI?=
 =?us-ascii?Q?C9w+MZPJelt5J4N4n3nIENJC4RFZ96yYe+gs73lIKVjejnipkTUPaht2nTEt?=
 =?us-ascii?Q?lL6lnOEQ/9rNZO61tCp0Nycv9A3hkwT5SXM3C2O3r0Qr4ZXk6JBwje4iT+YY?=
 =?us-ascii?Q?U6try34YlAXYEK77Mlnq+8ydF9U3oeCw+ZzBVvPsr2XYXwVyRzW54+JZFIbX?=
 =?us-ascii?Q?CwnK3wt1e4RSjGexQdrsCh3IVA7Czsi8Vtn9bb0tYOJm5W7fiFeLovhrADnH?=
 =?us-ascii?Q?IREbesdKJCg7Zpkc+qhi63CG6T5NV0h61AGCq3SN4vELg6u4W/px6EGDDmTN?=
 =?us-ascii?Q?SYpgK1bWlVtzLHNnSSQqz9y9de2B/ye5PvGKyYO0E43NP9yhzQY5oDs/OWjj?=
 =?us-ascii?Q?3e7PTpifNZ8ku6EeRAdlmnA2TOmRteTVvOYXt7trXtypIzvQaAXC85FKJyvy?=
 =?us-ascii?Q?QWwjj6fmE/U2gvipkeAS8FmBpTD5+FDFVIIxY6DcsIeZAwhTQK9qX/Y3YVBr?=
 =?us-ascii?Q?a64vSvpqbwzqm4vNPkeUYlpwlzCcOm00sohQVaEQVYSmR0sMJi3xWBCmgzDK?=
 =?us-ascii?Q?OHvUOQZoVMO8TuwNHe2NTKHtgHWeF30OLHb+5mHEDDG0pJjyqZiM3UMX3/L0?=
 =?us-ascii?Q?0ZhSnS8ATO+G5vYDrVUJwuvZNO9ydPwaUwTzScScvaI2mc0USyF6onpyW0YI?=
 =?us-ascii?Q?9H2IxbGN/uWJki4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:39:35.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe89931-61cd-4611-b831-08dd564119a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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

This commit queries the FW for the new unified FDB mode and saves it in
mlx5 shared device as fdb_unified_en bit.

Signed-off-by: Ophir Munk <ophirmu@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 3 +++
 drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index bba00a9..f504b29 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1349,6 +1349,9 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		attr->max_header_modify_pattern_length = MLX5_GET(wqe_based_flow_table_cap,
 								  hcattr,
 								  max_header_modify_pattern_length);
+		attr->fdb_unified_en = MLX5_GET(wqe_based_flow_table_cap,
+						hcattr,
+						fdb_unified_en);
 	}
 	/* Query HCA attribute for ROCE. */
 	if (attr->roce) {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 38548b4..8de4210 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -325,6 +325,7 @@ struct mlx5_hca_attr {
 	uint32_t cross_vhca:1;
 	uint32_t lag_rx_port_affinity:1;
 	uint32_t wqe_based_flow_table_sup:1;
+	uint32_t fdb_unified_en:1;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
-- 
2.8.4

