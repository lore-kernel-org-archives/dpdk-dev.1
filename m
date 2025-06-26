Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3DC77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 764E940E39;
	Thu, 26 Jun 2025 10:00:36 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by mails.dpdk.org (Postfix) with ESMTP id 07F5D40E37
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:00:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJXIeXsTVYCFADKCNW40bjdnkp4vaU8G68Fnl9CIqqOZDaknUqgbZct/wXFYL4DoEo6DeyHuob7mkcw/o4v54QgDc7K29kSV8DQYChaE812Dq38mjeDU3GYM0fRs2skI4Wpdgq6/AliqEFDtqpK64AKD4+7G4f2sGuTQwfhKyUZxp26G3kvdpF9sELpUDkVkc/UCbLeMnKj/jENXmB1qd3iwgjmTzTLyohCgtS1OjAr/NGx4Gs/OCjXQoS7KKQe8bbb0q3prOi7UUFLUwrfSvaegkjrhcPeSEtNGTSfEYHkdePcddQqR+FDTT1/dH3xndEEvC2a7zG6IpwtImWY8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaDkZGnVkkGivY6Sc4YEBYIrAmOPccDSfjlC7MaPT7o=;
 b=Z4qwId6ODhMa4+4vPiKWcQiCfd3VGku7LyXDV0PFoVsvIt10HmH/x0VaE410ZWqBPdvUtYoLVd0Ed/ZnkS4rDcNQHPCm2+9Wfe8XxV945yNuexbohqKHIQpmWsPrSYJODVEvTb/tBnW9ugTLycUpbT4Mmq0ckRLMTgAJDUl5PHDizDdapRfODA53gshWiYJDns3J7G/W1oBY2Zklb/vMTKcZqmDi47Fdwp+HPI2/7HCClHJNrfx0gKtlnUyxhBBmlPoif9IuG9qHSPAz5r8A1oY++Qh7lnhp7f8ltWUotB2jV+YcqUGrdo7ovFl7ceby9YeKZsEWWTsKe+0BnyX7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaDkZGnVkkGivY6Sc4YEBYIrAmOPccDSfjlC7MaPT7o=;
 b=Lpzg6+drkznIqBUwsXTMhhWiYrlFz69scC5nU4MRtqOOnrX8OCyj/szmpnBR9CEpI8m9cp401gcrhOAMwRWQxD0dJLEZLXgLQVSrrAiU9HAqeoXL1GZawNzB4IzwOynUI/3qRaozEySqWhMGf69kDV2bnD0LsUPLoYZrsJyJnrIKjZ4s0NOPGXax0d0WOxGayy7kDZ3YH8WvhNPJHQ3IY1NN6l0VNgJSIvjhmPVJ8P42x/C9M28ybiQl8Krhesb+t5IM9f3z5qRSrCWzqqhGFG83is7M5jh5ALz2+enoyTSiPMtBc9y4ud8hKbeKceFt3tsnIYbzsSiu3VF3giA/kA==
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Thu, 26 Jun 2025 08:00:28 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::e6) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Thu,
 26 Jun 2025 08:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 08:00:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 01:00:13 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 01:00:04 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, <ophirmu@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 1/4] net/mlx5: fix the table flags of mirror action
Date: Thu, 26 Jun 2025 10:59:41 +0300
Message-ID: <20250626075945.537256-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626075945.537256-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
 <20250626075945.537256-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e01082d-b43b-49c9-5faa-08ddb48783e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yr5rV9iDDmmztEK+6iy0OtB3c/0Rz600OH2epeb60ya4lnfG1FJ+EnVIMmcE?=
 =?us-ascii?Q?ZIISznjjv2ZEHknKCo0iGLtgy5k98kmL6Epfp8Ztpd6+G6jVtlhazJD4b/eI?=
 =?us-ascii?Q?/IEO2PvnwNdFY1nG9Yo5nXFJOl1HCcyub02oBlk0AdR1VIcFUTUv3zy4uR9y?=
 =?us-ascii?Q?t0as7l2TSlfYz0Cg7eC2LqqCDrHErJMgwi+qmSoCS7wc/TGBl5mbMlqJt5+P?=
 =?us-ascii?Q?2b8GXuGSp/TQfunjP/mo2h2PmpVFMHtCG0PE/Gss58juG2QTGLX+OPp6PnIb?=
 =?us-ascii?Q?eg+EKjs0jrpTiz5EBTpCgFBb9wQZuSZE1lrnJAq8avKucjGrH91neGbdTvId?=
 =?us-ascii?Q?RVcZb/dLzv+Z3Zzv39mJV5ZZ9h9A7nagtA0W6bbEafzqT964htZ5PVx9NyGw?=
 =?us-ascii?Q?xScxWFCe70pZrFNZM12hyB+/1dSq4SZ10WpnKcWv6TUnFD+jJo6JviKzTo9N?=
 =?us-ascii?Q?ZXzDW1ZK9SLKYsF8ICHVb9AoPdNBWyfzeK1iUsxQdGNBXKRJpseDG14i8jBh?=
 =?us-ascii?Q?jzI/3rLpVo162HiV4ePQgBfgrTQAhuZz8trbi0Em3ajNejs5yA1BLA9WoRxl?=
 =?us-ascii?Q?nDmU+0pexaqSMPeboqxPhffp2SbaBh9NktNO22jwoa+2mHQAO/3G3VWKVV2k?=
 =?us-ascii?Q?qQM1kL1WEJ9Hni8SCi3VWCfRun6/Ekg4QilrP34eHcVIEcWtuJuaEBWN4Ycc?=
 =?us-ascii?Q?2zVuWZgzRgSdCp4R9uBeJGvdQXjp/P/MLMSakIDTVYILhbxkyHYZ1qmWkv1s?=
 =?us-ascii?Q?ck6b2Jj7rYNYXaq1qrxLa6WfLlSMWUL6rj7F9Nxm4jJU31dy0Zx1QEXX7zuP?=
 =?us-ascii?Q?mKaBZIZwRWMmRy7eUhL2DFG2qU1I1M2OfFCMipijrpJwbexifcuqqIh0N7Kt?=
 =?us-ascii?Q?MAHq/jsxiNdZOxBtxQG3tLIMtn7YT+yQQfNTs7taJN4lssNIBiYMwfz6x2/v?=
 =?us-ascii?Q?L+ZgbyQY0244UKVv4hCzZ1Bw/PMuIijvBzMNW78Hk0mYRuUMLbrNBtUSgwrU?=
 =?us-ascii?Q?UFi72fBV4QaHaMGM6ylZ6DJUKOFC0ji3e9yK5xTFZoygc7ORL0Gexktv3ckC?=
 =?us-ascii?Q?RWrNDac1HU8aP3wuOdIm/943diRiQa+i6BdyaanZoKYCUyjsfrEE8x7+C2tJ?=
 =?us-ascii?Q?mTkazIw5L6ewpTNqvYjqGkrBLG3B8k705Vpwp7ZtAXyaOfDmEFpXEWKaH0f0?=
 =?us-ascii?Q?+2avkQwf9LHc9QJwJ0E2DDUi8HPx84g4hyXYRgANlCmkvedYuYJbYT1cZ3gX?=
 =?us-ascii?Q?cdtFGrwUfG9D7SkHSxYOVE5dJQYPX2Uw/eeASggHiYALfLi7yi80jxXwUlCP?=
 =?us-ascii?Q?Qp9NGQH7eDhJaZS62M2Cj2wuJ694XJa65q2e5mL5BT7XYxSeLwmM32Tofep3?=
 =?us-ascii?Q?1dvjTZ+0hl7RPQJLGKXXLEiJ7a/LVzoRSvFHH0Aet6bhakBAbTAOqPyJ7bvE?=
 =?us-ascii?Q?VpvK1TDN9J2h5j5VLw2VMsCmyO/9RUgU0dB2zczkQTwLmtNtiQ5jRDP8PUJu?=
 =?us-ascii?Q?w8vG3SBvaLYADPEsMjYmku4M8nCxn/+WuKZ3?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:00:28.1542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e01082d-b43b-49c9-5faa-08ddb48783e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

From: Bing Zhao <bingz@nvidia.com>

The HWS mirror action is created with STCs based on the flags. In the
past, there was a single type of FDB domain. After introducing the
unified FDB feature, there are 4 types of tables in FDB domain,
including FDB, FDB_RX, FDB_TX and FDB_UNIFIED. More STCs will be
allocated when the new FDB flags are set.

Without specifying the group ID, the default 0 would be used to
determine the table type. Since only the old FDB type was supported
on the root table. The flag was set wrongly and the STCs for other
FDB sub-types were not allocated.

When using this mirror action to create a flow in the unified FDB,
there are some errors:

  1. If there is no other action STC allocated before, the offsets
     of old FDB and unified FDB will be the same. But the value of
     the mirror is zero. The mirror action is not really applied even
     if no error is observed when pulling the result.
  2. If there is some other action STC allocated before, the offset
     0 will reflact that action but not the mirror itself. An error
     will be observed for the rule insertion.

Since the mirror is only supported in HWS non-root tables, setting
the group to some non-zero value will make STCs be allocated and
used properly.

Fixes: ac687bb002c9 ("net/mlx5: support unified FDB domain")
Cc: ophirmu@nvidia.com

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index af2e7a84a5..a8a3f3872a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14803,7 +14803,7 @@ flow_hw_async_action_list_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 	enum mlx5_indirect_list_type list_type;
 	struct rte_flow_action_list_handle *handle;
 	struct mlx5_priv *priv = dev->data->dev_private;
-	const struct mlx5_flow_template_table_cfg table_cfg = {
+	struct mlx5_flow_template_table_cfg table_cfg = {
 		.external = true,
 		.attr = {
 			.flow_attr = {
@@ -14840,6 +14840,11 @@ flow_hw_async_action_list_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 	}
 	switch (list_type) {
 	case MLX5_INDIRECT_ACTION_LIST_TYPE_MIRROR:
+		/*
+		 * Mirror action is only supported in HWS group. Setting group to
+		 * non-zero will ensure that the action resources are allocated correctly.
+		 */
+		table_cfg.attr.flow_attr.group = 1;
 		handle = mlx5_hw_mirror_handle_create(dev, &table_cfg,
 						      actions, error);
 		break;
-- 
2.48.1

