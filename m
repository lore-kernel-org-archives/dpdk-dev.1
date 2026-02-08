Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EEEEF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 14:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 145DB402ED;
	Sun,  8 Feb 2026 15:30:07 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by mails.dpdk.org (Postfix) with ESMTP id 0A4F6402C6
 for <dev@dpdk.org>; Sun,  8 Feb 2026 15:30:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9jSTY+HIKtl1lIxtdtoJL9a3swFBWA9djOGUuJkG0uEzqqXlFfjAXK8arJje/wuMYwSAmNpf2PWkVsH6/nNNRv0vW1LZO7b4AJS8Ovwj0nPlp6NrJKIwkDQ/nukv/dteWWAZrFYFRbw63oUT6nSIpiwui3UsH5mqbUlBvz0VPDvZC2q0aN7ab6v4jerjJDUpPz7DEk0dCjuDLyZqVkZAQDQSh/w4XSZedoW6skPAdePKQ6uUvCkVtbdqFN77S3vSKlhrqXHpzCT2tQ9YBq39m76ZOBtd52wh4Z8wo9yzCKbMGo/SPdQz32uo/27BGBk5BIDNqQJFxWi1B647h52lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5GdTmYbAM+8XZDlnNp3E5gaumjNEt26FizKP9jr3co=;
 b=xnTbqC6P/tIMgbbqQZx2O5aLAvqZboLBoTd1Rh80S1nPT/T3eqZle+K9wMdel+ssbNN+8Y6D2unZKV85kGcmPbaYqRD0tc6NId2Gr5yZGpfYyPDnpdlNNxodiuKl9MwJ2Qdi1TsbLDYwCCHGg5pm2UehzWMKNwLEGTzjUmieoOjArS3w8oAJbrbk0kMuuBp3KQujUBhOWjvZOyK/qxY7RaTvb3BYoK826+bWAoykhuwl5TNrXdOq1M+jkOsNBV9wSRpmqEuWWJyxFs8Wth4+G7pewJWsi8z1jlOhxEwNW95hNot7/v8xS/CCOC0rtc+JcnuUuQXqvLg/AHcwlCANxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5GdTmYbAM+8XZDlnNp3E5gaumjNEt26FizKP9jr3co=;
 b=UsRVkkfrID0S24CXeZytnVrGyVrIikTu4xBEsJW1KYaOF1MBVOlP2LhVhNlPC9bTbFupqraLbh9lZkAzrO0ocaK4xgw5+Dw0GWXGNJLNNpus5U6uvSyJrc/EM99nc88avdIS3l3cPMmw36PWueWqpF8NAHkJoRYj+NZrJ7nPKa4x0CNKQGSqyeiT6QRgwXFWFwoKbu3YDiJ5xmZtHuFexsXYZTM0dynLA7czEJlND26D545/CzYrHavhfuGSvUPv7WQL4FjIpkSkAjyD1uG0DpO7orr7H7DlQmr3g68GssUjgT8uZIKHblc2pgIS4N3W6w7mQPfZNGIHpOQDiqKNHg==
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 14:29:36 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::c4) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 14:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 14:29:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 06:29:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 06:29:19 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Feb 2026 06:29:17 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 2/2] net/mlx5: add mlx5 prefix to remaining internal
 functions
Date: Sun, 8 Feb 2026 16:29:08 +0200
Message-ID: <20260208142909.134443-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260208142909.134443-1-mkashani@nvidia.com>
References: <20251127112919.53710-1-mkashani@nvidia.com>
 <20260208142909.134443-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: d82344e3-c1cf-405c-f477-08de671e7c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVWn+5cDx3XsuqD7wcFRquPc+LsCeUOrcUNohz+LEz8OaT/qRJveS0OANkXu?=
 =?us-ascii?Q?wLWyGp8hdG4qrjq0s4gWxacNvyrPLDv4hdkfUBBfX00ReYwqEhww858FaOCb?=
 =?us-ascii?Q?HVZWFncAWd/69v9Kz0u9V9u8NgJoN4tE7tPiiZVdky2Ys+b+QFQ+MJzeGU3j?=
 =?us-ascii?Q?VFa3m2NYDGii5pI0RfKApLwvtjumozSVWvDrJuEaXJS9ZHlNF7QelEpQA5fl?=
 =?us-ascii?Q?mtkRcxjN6VjpqwEMomg7OBTUZqpSrmE2ckbbMqmWlsEXmHUGlawIaaB8uyqd?=
 =?us-ascii?Q?rJQWtdVtfxYzTxKJLmAFvynlDjzgmJX6bYgOhTKfZ+QbcyJIlN36fxU/8hhY?=
 =?us-ascii?Q?CvPhNrp98LhGtZr3K/8ZqE/HQZIe6lOGyDcXrTmNnEdIsDrG4JO1+cg0jFIw?=
 =?us-ascii?Q?D+53Pgqt//WfMjmmyePbleXm/I33cjWN5WNNChhJLyh+mRDS5UojMrSyyolG?=
 =?us-ascii?Q?gbQMSI4GDimC3LGqdvvhHkXNxccaVFbIyctKZBuU/JNTMnZ/+0g4giYoBsxE?=
 =?us-ascii?Q?Ykpo6L/hVePfof0BZ/H2bH8Auv/yKV59A1uyAT+d9im7JkUY4Y0gHs/p67I2?=
 =?us-ascii?Q?CErPEnfeL6uxE+Z2Fr8BO9ESu3CRUP/5RuFwj+NKReAxLfiw4h66Il9wjYPz?=
 =?us-ascii?Q?U/XnQqfsRlJP1XLNOaWxng+qsPRgOaqZiLsZ8ivWgES27RVV20pTuj/6IqzA?=
 =?us-ascii?Q?vUueYT0oDDCDveCHYo/hv/eqk2em/VKivx30Oe5+brtd4JSR1fOAsRLtQGBp?=
 =?us-ascii?Q?XQ4vu0+5StJarKmK0Ii1TuFK2DwB4P9Tc+Ga9FnlZvQfaIjXqOLCc96xuOL1?=
 =?us-ascii?Q?nCphveBcjIm3qA34KA2qawc/PlF65F42S5Q4N4/Ns/5vYXpXu8qEA2KkClcj?=
 =?us-ascii?Q?pKSa7EC/fDQPQs1jASaptd9gay6vYDet0rg76OZPBrQWUSvqy/pYZ/8ZRJK2?=
 =?us-ascii?Q?cAfTRb/rlhpP4MnRpcVjmSj0HYnvT8nC0AWGuj5ZuR1vbfVmElBbcXqH+Fvo?=
 =?us-ascii?Q?fsOdCmNjXvi/ZviGAJ8f1+2Lx7M2V/5/YFqLFa1MrbgMElIkF9nnJ+i4VPny?=
 =?us-ascii?Q?azajjh958uwVFdCuLVIO1fPHQGnA87PuDRLESORx2EUgxnFjEvJGWvvSe0ma?=
 =?us-ascii?Q?1GKQiGXQl/BgIuXQ7Wlm1UyCXSZDS2O/bWGYQe7ymQdb2OxKabJXzVlY50IL?=
 =?us-ascii?Q?j3pZUySnFFOjg8dMTKc/g3thE+/odcSEeOZ6f8RJ47qfWe/h5UvIKuBG5flW?=
 =?us-ascii?Q?h4qBHxp8CcnJOg3x5dVwouXLeQXScRD7iBeWxK88Ej+9r6maaBiMFsLoivcW?=
 =?us-ascii?Q?BLYmWzy0CM6areefnkK8APEjBN2yIToaUQQDTzKShvzNwfqQYWQwg2j3ctCm?=
 =?us-ascii?Q?h8ZSZ5buVUSwbm1LL6lYyz4AzKfzbgyfLxKL6CmTEjql94F1xDnEFZxMqQpd?=
 =?us-ascii?Q?Z3Dnn8PQluQs7EUhOEgKIEoVJasTWDUmNsrYu7SMOtmcVpPZHo5YEsXK07j5?=
 =?us-ascii?Q?sLWho2y4JLRHX4y5c8zPOuGvaeRs689PQq6V/yrM212zoCG2A9SRh/Yltwgj?=
 =?us-ascii?Q?OU9FwDjhd0isExvlog3sc93Xjzo/PD1bXEp8+1+RF8VFHJJ0/OiuW51cPXJH?=
 =?us-ascii?Q?NGt/HZCWEtuWq8MjEJtpMsS51pJW8oP/ew8LwHw7ILVeMrtegW4AK7w4domb?=
 =?us-ascii?Q?Uh7jFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4hDDSVkydxMjsSXyda5eE+490yCFV5TLdB/z+GdGJKizP6ouTrV+iC+lc8yInzZhJAw85B8liyAl/mW3Zn2FlHjqR0pC6EloB05SbB/9iBhAhT7tkddCtVqp/r5QPL4A74R2NtDhzDrEkOTqYyxj41edm2N3B9NcO2m7MdZMKQCkP7EPDY1JGt5E2CoMyFn614QzZ79xAW/bRCyRPSDOApBZS1qj3YqhO+9tYEkd1YMEAvrdIQUx57I/ETJwxrNsG21tQE7AMy9ESQO/W4o2ZpCC3phFl/KXcVRn8ftkR2SpbZiKGLJmzTMbdyYJWDu23eKsCV6y1mN3WG8gwvsIXFKeHiiMHRfI5CiUmvMy5Mt7Olh52Lb+//ooMBeY4+9agSU3Fk/2WRKYwT8hbFKrbBN0w86c2dObxj3niySSMSlDIRbCwCXPMhrm7pUAJsXw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 14:29:36.5649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82344e3-c1cf-405c-f477-08de671e7c6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
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

Several internal functions in the mlx5 driver were missing the mlx5_
prefix, which could lead to symbol conflicts when linking.
This patch
adds the proper prefix to all remaining global symbols and convert needed
global vars to static.

The following function categories were updated:

1. Flow hardware control functions:
   - flow_hw_list_destroy -> mlx5_flow_hw_list_destroy
   - flow_hw_create_flow -> mlx5_flow_hw_create_flow
   - flow_hw_set_port_info -> mlx5_flow_hw_set_port_info
   - flow_hw_create_vport_action -> mlx5_flow_hw_create_vport_action
   - flow_hw_destroy_vport_action -> mlx5_flow_hw_destroy_vport_action
   - flow_hw_get_ecpri_parser_profile ->
     mlx5_flow_hw_get_ecpri_parser_profile

2. Flow DV (Direct Verbs) functions:
   - flow_dv_convert_encap_data -> mlx5_flow_dv_convert_encap_data
   - flow_dv_translate_items_hws -> mlx5_flow_dv_translate_items_hws
   - flow_dv_tbl_resource_release -> mlx5_flow_dv_tbl_resource_release
   - __flow_dv_translate_items_hws -> mlx5_flow_dv_translate_items_hws_impl

3. Flow callback functions (26+ instances):
   - flow_dv_mreg_create_cb -> mlx5_flow_dv_mreg_create_cb
   - flow_dv_mreg_match_cb -> mlx5_flow_dv_mreg_match_cb
   - flow_dv_mreg_remove_cb -> mlx5_flow_dv_mreg_remove_cb
   - flow_dv_mreg_clone_cb -> mlx5_flow_dv_mreg_clone_cb
   - flow_dv_mreg_clone_free_cb -> mlx5_flow_dv_mreg_clone_free_cb
   - flow_dv_port_id_* callbacks (5 functions)
   - flow_dv_push_vlan_* callbacks (5 functions)
   - flow_dv_sample_* callbacks (5 functions)
   - flow_dv_dest_array_* callbacks (5 functions)
   - flow_nta_mreg_create_cb -> mlx5_flow_nta_mreg_create_cb
   - flow_nta_mreg_remove_cb -> mlx5_flow_nta_mreg_remove_cb

4. Global variable:
   - reg_to_field->mlx5_reg_to_field

After this change, all internal global symbols now have the mlx5_
prefix. Public PMD APIs correctly use the rte_pmd_mlx5_ prefix.

Following the above changes, Coverity warnings were handled.

Bugzilla ID: 1794

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_crc32.c     |   6 +-
 drivers/net/mlx5/hws/mlx5dr_crc32.h     |   2 +-
 drivers/net/mlx5/hws/mlx5dr_definer.c   |   2 +-
 drivers/net/mlx5/hws/mlx5dr_matcher.c   |  10 +-
 drivers/net/mlx5/hws/mlx5dr_rule.c      |   8 +-
 drivers/net/mlx5/linux/mlx5_flow_os.c   |   2 +-
 drivers/net/mlx5/linux/mlx5_os.c        |  87 +--
 drivers/net/mlx5/linux/mlx5_socket.c    |   4 +-
 drivers/net/mlx5/linux/mlx5_verbs.c     |   4 +-
 drivers/net/mlx5/linux/mlx5_verbs.h     |   2 +-
 drivers/net/mlx5/mlx5.c                 |  32 +-
 drivers/net/mlx5/mlx5.h                 |  18 +-
 drivers/net/mlx5/mlx5_devx.c            |   2 +-
 drivers/net/mlx5/mlx5_devx.h            |   2 +-
 drivers/net/mlx5/mlx5_driver_event.c    |   2 +-
 drivers/net/mlx5/mlx5_ethdev.c          |   4 +-
 drivers/net/mlx5/mlx5_flow.c            | 126 ++--
 drivers/net/mlx5/mlx5_flow.h            | 462 +++++++-------
 drivers/net/mlx5/mlx5_flow_dv.c         | 764 ++++++++++++------------
 drivers/net/mlx5/mlx5_flow_flex.c       |  22 +-
 drivers/net/mlx5/mlx5_flow_hw.c         | 156 ++---
 drivers/net/mlx5/mlx5_flow_meter.c      |   2 +-
 drivers/net/mlx5/mlx5_flow_verbs.c      |  14 +-
 drivers/net/mlx5/mlx5_nta_rss.c         |  56 +-
 drivers/net/mlx5/mlx5_nta_sample.c      |  34 +-
 drivers/net/mlx5/mlx5_nta_split.c       |   4 +-
 drivers/net/mlx5/mlx5_rx.c              |   4 +-
 drivers/net/mlx5/mlx5_rx.h              |   6 +-
 drivers/net/mlx5/mlx5_rxq.c             |  14 +-
 drivers/net/mlx5/mlx5_trigger.c         |   8 +-
 drivers/net/mlx5/mlx5_tx.c              |   4 +-
 drivers/net/mlx5/mlx5_tx.h              |   4 +-
 drivers/net/mlx5/mlx5_txq.c             |   8 +-
 drivers/net/mlx5/windows/mlx5_flow_os.c |   4 +-
 drivers/net/mlx5/windows/mlx5_os.c      |   2 +-
 35 files changed, 969 insertions(+), 912 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_crc32.c b/drivers/net/mlx5/hws/mlx5dr_crc32.c
index 7431462e14c..6c757e25559 100644
--- a/drivers/net/mlx5/hws/mlx5dr_crc32.c
+++ b/drivers/net/mlx5/hws/mlx5dr_crc32.c
@@ -4,7 +4,7 @@
 
 #include "mlx5dr_internal.h"
 
-uint32_t dr_ste_crc_tab32[] = {
+static const uint32_t dr_ste_crc_tab32[] = {
 	0x0, 0x77073096, 0xee0e612c, 0x990951ba, 0x76dc419, 0x706af48f,
 	0xe963a535, 0x9e6495a3, 0xedb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988,
 	0x9b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91, 0x1db71064, 0x6ab020f2,
@@ -51,7 +51,7 @@ uint32_t dr_ste_crc_tab32[] = {
 };
 
 /* CRC table for the CRC-16, the polynome is 0x100b */
-uint16_t dr_crc_inner_crc_tab16[] = {
+static const uint16_t dr_crc_inner_crc_tab16[] = {
 	0x0000, 0x100B, 0x2016, 0x301D, 0x402C, 0x5027, 0x603A, 0x7031,
 	0x8058, 0x9053, 0xA04E, 0xB045, 0xC074, 0xD07F, 0xE062, 0xF069,
 	0x10BB, 0x00B0, 0x30AD, 0x20A6, 0x5097, 0x409C, 0x7081, 0x608A,
@@ -96,7 +96,7 @@ uint32_t mlx5dr_crc32_calc(uint8_t *p, size_t len)
 	return rte_be_to_cpu_32(crc);
 }
 
-uint16_t mlx5dr_crc16_calc(uint8_t *p, size_t len, uint16_t crc_tab16[])
+uint16_t mlx5dr_crc16_calc(uint8_t *p, size_t len, const uint16_t crc_tab16[])
 {
 	uint16_t crc = 0;
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_crc32.h b/drivers/net/mlx5/hws/mlx5dr_crc32.h
index 75b6009a15a..c1fc910f518 100644
--- a/drivers/net/mlx5/hws/mlx5dr_crc32.h
+++ b/drivers/net/mlx5/hws/mlx5dr_crc32.h
@@ -13,6 +13,6 @@ uint32_t mlx5dr_crc32_calc(uint8_t *p, size_t len);
 /* Standard CRC16 calculation using the crc_tab16 param to indicate
  * the pre-calculated polynome hash values.
  */
-uint16_t mlx5dr_crc16_calc(uint8_t *p, size_t len, uint16_t crc_tab16[]);
+uint16_t mlx5dr_crc16_calc(uint8_t *p, size_t len, const uint16_t crc_tab16[]);
 
 #endif /* MLX5DR_CRC32_C_ */
diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 03d2794367e..6a016de78ea 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -2663,7 +2663,7 @@ mlx5dr_definer_get_ecpri_parser_byte_off_from_ctx(void *dr_ctx, uint32_t *byte_o
 	struct mlx5_ecpri_parser_profile *ecp;
 	uint32_t i;
 
-	ecp = flow_hw_get_ecpri_parser_profile(dr_ctx);
+	ecp = mlx5_flow_hw_get_ecpri_parser_profile(dr_ctx);
 	if (!ecp)
 		return UINT32_MAX;
 	for (i = 0; i < ecp->num; i++)
diff --git a/drivers/net/mlx5/hws/mlx5dr_matcher.c b/drivers/net/mlx5/hws/mlx5dr_matcher.c
index 7d77cf4a3e2..8c07ea88821 100644
--- a/drivers/net/mlx5/hws/mlx5dr_matcher.c
+++ b/drivers/net/mlx5/hws/mlx5dr_matcher.c
@@ -1350,11 +1350,11 @@ static int mlx5dr_matcher_init_root(struct mlx5dr_matcher *matcher)
 	flow_attr.tbl_type = type;
 
 	/* On root table matcher, only a single match template is supported */
-	ret = flow_dv_translate_items_hws(matcher->mt[0].items,
-					  &flow_attr, mask->match_buf,
-					  MLX5_SET_MATCHER_HS_M, NULL,
-					  &match_criteria,
-					  &rte_error);
+	ret = mlx5_flow_dv_translate_items_hws(matcher->mt[0].items,
+					       &flow_attr, mask->match_buf,
+					       MLX5_SET_MATCHER_HS_M, NULL,
+					       &match_criteria,
+					       &rte_error);
 	if (ret) {
 		DR_LOG(ERR, "Failed to convert items to PRM [%s]", rte_error.message);
 		goto free_mask;
diff --git a/drivers/net/mlx5/hws/mlx5dr_rule.c b/drivers/net/mlx5/hws/mlx5dr_rule.c
index 895ac858eca..4ff3d26e6f8 100644
--- a/drivers/net/mlx5/hws/mlx5dr_rule.c
+++ b/drivers/net/mlx5/hws/mlx5dr_rule.c
@@ -738,10 +738,10 @@ int mlx5dr_rule_create_root_no_comp(struct mlx5dr_rule *rule,
 
 	flow_attr.tbl_type = rule->matcher->tbl->type;
 
-	ret = flow_dv_translate_items_hws(items, &flow_attr, value->match_buf,
-					  MLX5_SET_MATCHER_HS_V, NULL,
-					  &match_criteria,
-					  &error);
+	ret = mlx5_flow_dv_translate_items_hws(items, &flow_attr, value->match_buf,
+					       MLX5_SET_MATCHER_HS_V, NULL,
+					       &match_criteria,
+					       &error);
 	if (ret) {
 		DR_LOG(ERR, "Failed to convert items to PRM [%s]", error.message);
 		goto free_value;
diff --git a/drivers/net/mlx5/linux/mlx5_flow_os.c b/drivers/net/mlx5/linux/mlx5_flow_os.c
index f5eee46e44b..5d80898b667 100644
--- a/drivers/net/mlx5/linux/mlx5_flow_os.c
+++ b/drivers/net/mlx5/linux/mlx5_flow_os.c
@@ -73,7 +73,7 @@ mlx5_flow_os_workspace_gc_release(void)
 		struct mlx5_flow_workspace *wks = gc_head;
 
 		gc_head = wks->gc;
-		flow_release_workspace(wks);
+		mlx5_flow_release_workspace(wks);
 	}
 }
 
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f73183bb14..15781828e6c 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -510,11 +510,11 @@ mlx5_alloc_shared_dr(struct rte_eth_dev *eth_dev)
 			sh->mreg_cp_tbl = mlx5_hlist_create(MLX5_FLOW_MREG_HNAME,
 							    MLX5_FLOW_MREG_HTABLE_SZ,
 							    false, true, eth_dev,
-							    flow_nta_mreg_create_cb,
-							    flow_dv_mreg_match_cb,
-							    flow_nta_mreg_remove_cb,
-							    flow_dv_mreg_clone_cb,
-							    flow_dv_mreg_clone_free_cb);
+							    mlx5_flow_nta_mreg_create_cb,
+							    mlx5_flow_dv_mreg_match_cb,
+							    mlx5_flow_nta_mreg_remove_cb,
+							    mlx5_flow_dv_mreg_clone_cb,
+							    mlx5_flow_dv_mreg_clone_free_cb);
 			if (!sh->mreg_cp_tbl) {
 				err = ENOMEM;
 				goto error;
@@ -525,41 +525,41 @@ mlx5_alloc_shared_dr(struct rte_eth_dev *eth_dev)
 	/* Init port id action list. */
 	snprintf(s, sizeof(s), "%s_port_id_action_list", sh->ibdev_name);
 	sh->port_id_action_list = mlx5_list_create(s, sh, true,
-						   flow_dv_port_id_create_cb,
-						   flow_dv_port_id_match_cb,
-						   flow_dv_port_id_remove_cb,
-						   flow_dv_port_id_clone_cb,
-						 flow_dv_port_id_clone_free_cb);
+						   mlx5_flow_dv_port_id_create_cb,
+						   mlx5_flow_dv_port_id_match_cb,
+						   mlx5_flow_dv_port_id_remove_cb,
+						   mlx5_flow_dv_port_id_clone_cb,
+						   mlx5_flow_dv_port_id_clone_free_cb);
 	if (!sh->port_id_action_list)
 		goto error;
 	/* Init push vlan action list. */
 	snprintf(s, sizeof(s), "%s_push_vlan_action_list", sh->ibdev_name);
 	sh->push_vlan_action_list = mlx5_list_create(s, sh, true,
-						    flow_dv_push_vlan_create_cb,
-						    flow_dv_push_vlan_match_cb,
-						    flow_dv_push_vlan_remove_cb,
-						    flow_dv_push_vlan_clone_cb,
-					       flow_dv_push_vlan_clone_free_cb);
+						    mlx5_flow_dv_push_vlan_create_cb,
+						    mlx5_flow_dv_push_vlan_match_cb,
+						    mlx5_flow_dv_push_vlan_remove_cb,
+						    mlx5_flow_dv_push_vlan_clone_cb,
+						    mlx5_flow_dv_push_vlan_clone_free_cb);
 	if (!sh->push_vlan_action_list)
 		goto error;
 	/* Init sample action list. */
 	snprintf(s, sizeof(s), "%s_sample_action_list", sh->ibdev_name);
 	sh->sample_action_list = mlx5_list_create(s, sh, true,
-						  flow_dv_sample_create_cb,
-						  flow_dv_sample_match_cb,
-						  flow_dv_sample_remove_cb,
-						  flow_dv_sample_clone_cb,
-						  flow_dv_sample_clone_free_cb);
+						  mlx5_flow_dv_sample_create_cb,
+						  mlx5_flow_dv_sample_match_cb,
+						  mlx5_flow_dv_sample_remove_cb,
+						  mlx5_flow_dv_sample_clone_cb,
+						  mlx5_flow_dv_sample_clone_free_cb);
 	if (!sh->sample_action_list)
 		goto error;
 	/* Init dest array action list. */
 	snprintf(s, sizeof(s), "%s_dest_array_list", sh->ibdev_name);
 	sh->dest_array_list = mlx5_list_create(s, sh, true,
-					       flow_dv_dest_array_create_cb,
-					       flow_dv_dest_array_match_cb,
-					       flow_dv_dest_array_remove_cb,
-					       flow_dv_dest_array_clone_cb,
-					      flow_dv_dest_array_clone_free_cb);
+					       mlx5_flow_dv_dest_array_create_cb,
+					       mlx5_flow_dv_dest_array_match_cb,
+					       mlx5_flow_dv_dest_array_remove_cb,
+					       mlx5_flow_dv_dest_array_clone_cb,
+					       mlx5_flow_dv_dest_array_clone_free_cb);
 	if (!sh->dest_array_list)
 		goto error;
 #else
@@ -635,11 +635,11 @@ mlx5_alloc_shared_dr(struct rte_eth_dev *eth_dev)
 			sh->mreg_cp_tbl = mlx5_hlist_create(MLX5_FLOW_MREG_HNAME,
 							    MLX5_FLOW_MREG_HTABLE_SZ,
 							    false, true, eth_dev,
-							    flow_dv_mreg_create_cb,
-							    flow_dv_mreg_match_cb,
-							    flow_dv_mreg_remove_cb,
-							    flow_dv_mreg_clone_cb,
-							    flow_dv_mreg_clone_free_cb);
+							    mlx5_flow_dv_mreg_create_cb,
+							    mlx5_flow_dv_mreg_match_cb,
+							    mlx5_flow_dv_mreg_remove_cb,
+							    mlx5_flow_dv_mreg_clone_cb,
+							    mlx5_flow_dv_mreg_clone_free_cb);
 			if (!sh->mreg_cp_tbl) {
 				err = ENOMEM;
 				goto error;
@@ -754,7 +754,7 @@ mlx5_destroy_send_to_kernel_action(struct mlx5_dev_ctx_shared *sh)
 			struct mlx5_flow_tbl_resource *tbl =
 					sh->send_to_kernel_action[i].tbl;
 
-			flow_dv_tbl_resource_release(sh, tbl);
+			mlx5_flow_dv_tbl_resource_release(sh, tbl);
 			sh->send_to_kernel_action[i].tbl = NULL;
 		}
 	}
@@ -810,6 +810,21 @@ mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 		mlx5_glue->destroy_flow_action(sh->pop_vlan_action);
 		sh->pop_vlan_action = NULL;
 	}
+	for (i = 0; i < MLX5DR_TABLE_TYPE_MAX; i++) {
+		if (sh->send_to_kernel_action[i].action) {
+			void *action = sh->send_to_kernel_action[i].action;
+
+			mlx5_glue->destroy_flow_action(action);
+			sh->send_to_kernel_action[i].action = NULL;
+		}
+		if (sh->send_to_kernel_action[i].tbl) {
+			struct mlx5_flow_tbl_resource *tbl =
+					sh->send_to_kernel_action[i].tbl;
+
+			mlx5_flow_dv_tbl_resource_release(sh, tbl);
+			sh->send_to_kernel_action[i].tbl = NULL;
+		}
+	}
 #endif /* HAVE_MLX5DV_DR */
 	if (sh->default_miss_action)
 		mlx5_glue->destroy_flow_action
@@ -1662,7 +1677,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	/* Create context for virtual machine VLAN workaround. */
 	priv->vmwa_context = mlx5_vlan_vmwa_init(eth_dev, spawn->ifindex);
 	if (mlx5_devx_obj_ops_en(sh)) {
-		priv->obj_ops = devx_obj_ops;
+		priv->obj_ops = mlx5_devx_obj_ops;
 		mlx5_queue_counter_id_prepare(eth_dev);
 		priv->obj_ops.lb_dummy_queue_create =
 					mlx5_rxq_ibv_obj_dummy_lb_create;
@@ -1674,7 +1689,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		err = ENOTSUP;
 		goto error;
 	} else {
-		priv->obj_ops = ibv_obj_ops;
+		priv->obj_ops = mlx5_ibv_obj_ops;
 	}
 	if (sh->config.tx_pp &&
 	    priv->obj_ops.txq_obj_new != mlx5_txq_devx_obj_new) {
@@ -1771,7 +1786,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			}
 		}
 		if (priv->vport_meta_mask)
-			flow_hw_set_port_info(eth_dev);
+			mlx5_flow_hw_set_port_info(eth_dev);
 		if (priv->sh->config.dv_esw_en &&
 		    priv->sh->config.dv_xmeta_en != MLX5_XMETA_MODE_LEGACY &&
 		    priv->sh->config.dv_xmeta_en != MLX5_XMETA_MODE_META32_HWS) {
@@ -1782,7 +1797,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 				goto error;
 		}
 		if (priv->sh->config.dv_esw_en &&
-		    flow_hw_create_vport_action(eth_dev)) {
+		    mlx5_flow_hw_create_vport_action(eth_dev)) {
 			DRV_LOG(ERR, "port %u failed to create vport action",
 				eth_dev->data->port_id);
 			err = EINVAL;
@@ -1823,7 +1838,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		    priv->sh &&
 		    priv->sh->config.dv_flow_en == 2 &&
 		    priv->sh->config.dv_esw_en)
-			flow_hw_destroy_vport_action(eth_dev);
+			mlx5_flow_hw_destroy_vport_action(eth_dev);
 #endif
 		if (priv->sh)
 			mlx5_os_free_shared_dr(priv);
diff --git a/drivers/net/mlx5/linux/mlx5_socket.c b/drivers/net/mlx5/linux/mlx5_socket.c
index 6ce0e59643d..3a67dff4a19 100644
--- a/drivers/net/mlx5/linux/mlx5_socket.c
+++ b/drivers/net/mlx5/linux/mlx5_socket.c
@@ -23,8 +23,8 @@
 #define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
 #define MLX5_ALL_PORT_IDS 0xffff
 
-int server_socket = -1; /* Unix socket for primary process. */
-struct rte_intr_handle *server_intr_handle; /* Interrupt handler. */
+static int server_socket = -1; /* Unix socket for primary process. */
+static struct rte_intr_handle *server_intr_handle; /* Interrupt handler. */
 
 /**
  * Handle server pmd socket interrupts.
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 01d3d6ae5d4..103a03bd1ab 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -795,7 +795,7 @@ mlx5_ibv_drop_action_create(struct rte_eth_dev *dev)
 			.rx_hash_conf = (struct ibv_rx_hash_conf){
 				.rx_hash_function = IBV_RX_HASH_FUNC_TOEPLITZ,
 				.rx_hash_key_len = MLX5_RSS_HASH_KEY_LEN,
-				.rx_hash_key = rss_hash_default_key,
+				.rx_hash_key = mlx5_rss_hash_default_key,
 				.rx_hash_fields_mask = 0,
 				},
 			.rwq_ind_tbl = ind_tbl,
@@ -1225,7 +1225,7 @@ mlx5_txq_ibv_obj_release(struct mlx5_txq_obj *txq_obj)
 	claim_zero(mlx5_glue->destroy_cq(txq_obj->cq));
 }
 
-struct mlx5_obj_ops ibv_obj_ops = {
+struct mlx5_obj_ops mlx5_ibv_obj_ops = {
 	.rxq_obj_modify_vlan_strip = mlx5_rxq_obj_modify_wq_vlan_strip,
 	.rxq_obj_new = mlx5_rxq_ibv_obj_new,
 	.rxq_event_get = mlx5_rx_ibv_get_event,
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.h b/drivers/net/mlx5/linux/mlx5_verbs.h
index 829d9fa7387..80732756413 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.h
+++ b/drivers/net/mlx5/linux/mlx5_verbs.h
@@ -12,5 +12,5 @@ void mlx5_txq_ibv_obj_release(struct mlx5_txq_obj *txq_obj);
 int mlx5_rxq_ibv_obj_dummy_lb_create(struct rte_eth_dev *dev);
 void mlx5_rxq_ibv_obj_dummy_lb_release(struct rte_eth_dev *dev);
 
-extern struct mlx5_obj_ops ibv_obj_ops;
+extern struct mlx5_obj_ops mlx5_ibv_obj_ops;
 #endif /* RTE_PMD_MLX5_VERBS_H_ */
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index d77b3035219..5a52ab180dd 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2211,11 +2211,11 @@ mlx5_alloc_hw_group_hash_list(struct mlx5_priv *priv)
 	sh->groups = mlx5_hlist_create
 			(s, MLX5_FLOW_TABLE_HLIST_ARRAY_SIZE,
 			 false, true, sh,
-			 flow_hw_grp_create_cb,
-			 flow_hw_grp_match_cb,
-			 flow_hw_grp_remove_cb,
-			 flow_hw_grp_clone_cb,
-			 flow_hw_grp_clone_free_cb);
+			 mlx5_flow_hw_grp_create_cb,
+			 mlx5_flow_hw_grp_match_cb,
+			 mlx5_flow_hw_grp_remove_cb,
+			 mlx5_flow_hw_grp_clone_cb,
+			 mlx5_flow_hw_grp_clone_free_cb);
 	if (!sh->groups) {
 		DRV_LOG(ERR, "flow groups with hash creation failed.");
 		err = ENOMEM;
@@ -2253,11 +2253,11 @@ mlx5_alloc_table_hash_list(struct mlx5_priv *priv __rte_unused)
 	snprintf(s, sizeof(s), "%s_flow_table", priv->sh->ibdev_name);
 	sh->flow_tbls = mlx5_hlist_create(s, MLX5_FLOW_TABLE_HLIST_ARRAY_SIZE,
 					  false, true, sh,
-					  flow_dv_tbl_create_cb,
-					  flow_dv_tbl_match_cb,
-					  flow_dv_tbl_remove_cb,
-					  flow_dv_tbl_clone_cb,
-					  flow_dv_tbl_clone_free_cb);
+					  mlx5_flow_dv_tbl_create_cb,
+					  mlx5_flow_dv_tbl_match_cb,
+					  mlx5_flow_dv_tbl_remove_cb,
+					  mlx5_flow_dv_tbl_clone_cb,
+					  mlx5_flow_dv_tbl_clone_free_cb);
 	if (!sh->flow_tbls) {
 		DRV_LOG(ERR, "flow tables with hash creation failed.");
 		err = ENOMEM;
@@ -2272,11 +2272,11 @@ mlx5_alloc_table_hash_list(struct mlx5_priv *priv __rte_unused)
 	 * because DV expect to see them even if they cannot be created by
 	 * RDMA-CORE.
 	 */
-	if (!flow_dv_tbl_resource_get(dev, 0, 0, 0, 0,
+	if (!mlx5_flow_dv_tbl_resource_get(dev, 0, 0, 0, 0,
 		NULL, 0, 1, 0, &error) ||
-	    !flow_dv_tbl_resource_get(dev, 0, 1, 0, 0,
+	    !mlx5_flow_dv_tbl_resource_get(dev, 0, 1, 0, 0,
 		NULL, 0, 1, 0, &error) ||
-	    !flow_dv_tbl_resource_get(dev, 0, 0, 1, 0,
+	    !mlx5_flow_dv_tbl_resource_get(dev, 0, 0, 1, 0,
 		NULL, 0, 1, 0, &error)) {
 		err = ENOMEM;
 		goto error;
@@ -2472,10 +2472,10 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_indirect_list_handles_release(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	mlx5_nta_sample_context_free(dev);
-	flow_hw_destroy_vport_action(dev);
+	mlx5_flow_hw_destroy_vport_action(dev);
 	/* dr context will be closed after mlx5_os_free_shared_dr. */
-	flow_hw_resource_release(dev);
-	flow_hw_clear_port_info(dev);
+	mlx5_flow_hw_resource_release(dev);
+	mlx5_flow_hw_clear_port_info(dev);
 	if (priv->tlv_options != NULL) {
 		/* Free the GENEVE TLV parser resource. */
 		claim_zero(mlx5_geneve_tlv_options_destroy(priv->tlv_options, sh->phdev));
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index d84445db492..4bec2127720 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2527,8 +2527,8 @@ int mlx5_counter_query(struct rte_eth_dev *dev, uint32_t cnt,
 		    bool clear, uint64_t *pkts, uint64_t *bytes, void **action);
 int mlx5_flow_dev_dump(struct rte_eth_dev *dev, struct rte_flow *flow,
 			FILE *file, struct rte_flow_error *error);
-int save_dump_file(const unsigned char *data, uint32_t size,
-		uint32_t type, uint64_t id, void *arg, FILE *file);
+int mlx5_save_dump_file(const unsigned char *data, uint32_t size,
+			uint32_t type, uint64_t id, void *arg, FILE *file);
 int mlx5_flow_query_counter(struct rte_eth_dev *dev, struct rte_flow *flow,
 	struct rte_flow_query_count *count, struct rte_flow_error *error);
 #ifdef HAVE_IBV_FLOW_DV_SUPPORT
@@ -2576,7 +2576,7 @@ int mlx5_flow_meter_ops_get(struct rte_eth_dev *dev, void *arg);
 struct mlx5_flow_meter_info *mlx5_flow_meter_find(struct mlx5_priv *priv,
 		uint32_t meter_id, uint32_t *mtr_idx);
 struct mlx5_flow_meter_info *
-flow_dv_meter_find_by_idx(struct mlx5_priv *priv, uint32_t idx);
+mlx5_flow_dv_meter_find_by_idx(struct mlx5_priv *priv, uint32_t idx);
 int mlx5_flow_meter_attach(struct mlx5_priv *priv,
 			   struct mlx5_flow_meter_info *fm,
 			   const struct rte_flow_attr *attr,
@@ -2709,12 +2709,12 @@ mlx5_aso_cqe_err_handle(struct mlx5_aso_sq *sq);
 /* mlx5_flow_flex.c */
 
 struct rte_flow_item_flex_handle *
-flow_dv_item_create(struct rte_eth_dev *dev,
-		    const struct rte_flow_item_flex_conf *conf,
-		    struct rte_flow_error *error);
-int flow_dv_item_release(struct rte_eth_dev *dev,
-		    const struct rte_flow_item_flex_handle *flex_handle,
-		    struct rte_flow_error *error);
+mlx5_flow_dv_item_create(struct rte_eth_dev *dev,
+			 const struct rte_flow_item_flex_conf *conf,
+			 struct rte_flow_error *error);
+int mlx5_flow_dv_item_release(struct rte_eth_dev *dev,
+			      const struct rte_flow_item_flex_handle *flex_handle,
+			      struct rte_flow_error *error);
 int mlx5_flex_item_port_init(struct rte_eth_dev *dev);
 void mlx5_flex_item_port_cleanup(struct rte_eth_dev *dev);
 void mlx5_flex_flow_translate_item(struct rte_eth_dev *dev, void *matcher,
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 523b53d7130..4b30a4fade5 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -1733,7 +1733,7 @@ mlx5_txq_devx_obj_release(struct mlx5_txq_obj *txq_obj)
 	}
 }
 
-struct mlx5_obj_ops devx_obj_ops = {
+struct mlx5_obj_ops mlx5_devx_obj_ops = {
 	.rxq_obj_modify_vlan_strip = mlx5_rxq_obj_modify_rq_vlan_strip,
 	.rxq_obj_modify_counter_set_id = mlx5_rxq_obj_modify_counter,
 	.rxq_obj_new = mlx5_rxq_devx_obj_new,
diff --git a/drivers/net/mlx5/mlx5_devx.h b/drivers/net/mlx5/mlx5_devx.h
index 4ab8cfbd221..3c836170f58 100644
--- a/drivers/net/mlx5/mlx5_devx.h
+++ b/drivers/net/mlx5/mlx5_devx.h
@@ -14,6 +14,6 @@ void mlx5_txq_devx_obj_release(struct mlx5_txq_obj *txq_obj);
 int mlx5_devx_modify_rq(struct mlx5_rxq_priv *rxq, uint8_t type);
 int mlx5_devx_extq_port_validate(uint16_t port_id);
 
-extern struct mlx5_obj_ops devx_obj_ops;
+extern struct mlx5_obj_ops mlx5_devx_obj_ops;
 
 #endif /* RTE_PMD_MLX5_DEVX_H_ */
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index cad1f875180..1dc8029ee50 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -32,7 +32,7 @@ struct registered_cb {
 	const void *opaque;
 };
 
-LIST_HEAD(, registered_cb) cb_list_head = LIST_HEAD_INITIALIZER(cb_list_head);
+static LIST_HEAD(, registered_cb) cb_list_head = LIST_HEAD_INITIALIZER(cb_list_head);
 
 static const char *
 generate_rx_queue_info(struct mlx5_rxq_priv *rxq)
diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index c93a7ac4f26..c022e5d4f94 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -103,7 +103,7 @@ mlx5_dev_configure(struct rte_eth_dev *dev)
 	memcpy(priv->rss_conf.rss_key,
 	       use_app_rss_key ?
 	       dev->data->dev_conf.rx_adv_conf.rss_conf.rss_key :
-	       rss_hash_default_key,
+	       mlx5_rss_hash_default_key,
 	       MLX5_RSS_HASH_KEY_LEN);
 	priv->rss_conf.rss_key_len = MLX5_RSS_HASH_KEY_LEN;
 	priv->rss_conf.rss_hf = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
@@ -397,7 +397,7 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->rx_desc_lim.nb_max = max_wqe;
 	info->tx_desc_lim.nb_max = max_wqe;
 	if (priv->sh->cdev->config.hca_attr.mem_rq_rmp &&
-	    priv->obj_ops.rxq_obj_new == devx_obj_ops.rxq_obj_new)
+	    priv->obj_ops.rxq_obj_new == mlx5_devx_obj_ops.rxq_obj_new)
 		info->dev_capa |= RTE_ETH_DEV_CAPA_RXQ_SHARE;
 	info->switch_info.name = dev->data->name;
 	info->switch_info.domain_id = priv->domain_id;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 0821c93a9ab..fddd309171e 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -124,7 +124,7 @@ extern const struct mlx5_flow_driver_ops mlx5_flow_verbs_drv_ops;
 
 const struct mlx5_flow_driver_ops mlx5_flow_null_drv_ops;
 
-const struct mlx5_flow_driver_ops *flow_drv_ops[] = {
+static const struct mlx5_flow_driver_ops *flow_drv_ops[] = {
 	[MLX5_FLOW_TYPE_MIN] = &mlx5_flow_null_drv_ops,
 #if defined(HAVE_IBV_FLOW_DV_SUPPORT) || !defined(HAVE_INFINIBAND_VERBS_H)
 	[MLX5_FLOW_TYPE_DV] = &mlx5_flow_dv_drv_ops,
@@ -1597,8 +1597,8 @@ flow_rxq_tunnel_ptype_update(struct mlx5_rxq_ctrl *rxq_ctrl)
  *   Pointer to device flow handle structure.
  */
 void
-flow_drv_rxq_flags_set(struct rte_eth_dev *dev,
-		       struct mlx5_flow_handle *dev_handle)
+mlx5_flow_drv_rxq_flags_set(struct rte_eth_dev *dev,
+			    struct mlx5_flow_handle *dev_handle)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	const int tunnel = !!(dev_handle->layers & MLX5_FLOW_LAYER_TUNNEL);
@@ -1715,7 +1715,7 @@ flow_rxq_flags_set(struct rte_eth_dev *dev, struct rte_flow *flow)
 		mlx5_flow_rxq_mark_flag_set(dev);
 	SILIST_FOREACH(priv->sh->ipool[MLX5_IPOOL_MLX5_FLOW], flow->dev_handles,
 		       handle_idx, dev_handle, next)
-		flow_drv_rxq_flags_set(dev, dev_handle);
+		mlx5_flow_drv_rxq_flags_set(dev, dev_handle);
 }
 
 /**
@@ -2467,8 +2467,8 @@ mlx5_validate_action_ct(struct rte_eth_dev *dev,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_validate_modify_field_level(const struct rte_flow_field_data *data,
-				 struct rte_flow_error *error)
+mlx5_flow_validate_modify_field_level(const struct rte_flow_field_data *data,
+				      struct rte_flow_error *error)
 {
 	if (data->level == 0 || data->field == RTE_FLOW_FIELD_FLEX_ITEM)
 		return 0;
@@ -4134,10 +4134,10 @@ flow_null_sync_domain(struct rte_eth_dev *dev __rte_unused,
 }
 
 int
-flow_null_get_aged_flows(struct rte_eth_dev *dev,
-		    void **context __rte_unused,
-		    uint32_t nb_contexts __rte_unused,
-		    struct rte_flow_error *error __rte_unused)
+mlx5_flow_null_get_aged_flows(struct rte_eth_dev *dev,
+			      void **context __rte_unused,
+			      uint32_t nb_contexts __rte_unused,
+			      struct rte_flow_error *error __rte_unused)
 {
 	DRV_LOG(ERR, "port %u get aged flows is not supported.",
 		dev->data->port_id);
@@ -4145,7 +4145,7 @@ flow_null_get_aged_flows(struct rte_eth_dev *dev,
 }
 
 uint32_t
-flow_null_counter_allocate(struct rte_eth_dev *dev)
+mlx5_flow_null_counter_allocate(struct rte_eth_dev *dev)
 {
 	DRV_LOG(ERR, "port %u counter allocate is not supported.",
 		dev->data->port_id);
@@ -4153,7 +4153,7 @@ flow_null_counter_allocate(struct rte_eth_dev *dev)
 }
 
 void
-flow_null_counter_free(struct rte_eth_dev *dev,
+mlx5_flow_null_counter_free(struct rte_eth_dev *dev,
 			uint32_t counter __rte_unused)
 {
 	DRV_LOG(ERR, "port %u counter free is not supported.",
@@ -4161,12 +4161,12 @@ flow_null_counter_free(struct rte_eth_dev *dev,
 }
 
 int
-flow_null_counter_query(struct rte_eth_dev *dev,
-			uint32_t counter __rte_unused,
-			bool clear __rte_unused,
-			uint64_t *pkts __rte_unused,
-			uint64_t *bytes __rte_unused,
-			void **action __rte_unused)
+mlx5_flow_null_counter_query(struct rte_eth_dev *dev,
+			     uint32_t counter __rte_unused,
+			     bool clear __rte_unused,
+			     uint64_t *pkts __rte_unused,
+			     uint64_t *bytes __rte_unused,
+			     void **action __rte_unused)
 {
 	DRV_LOG(ERR, "port %u counter query is not supported.",
 		 dev->data->port_id);
@@ -4184,10 +4184,10 @@ const struct mlx5_flow_driver_ops mlx5_flow_null_drv_ops = {
 	.destroy = flow_null_destroy,
 	.query = flow_null_query,
 	.sync_domain = flow_null_sync_domain,
-	.get_aged_flows = flow_null_get_aged_flows,
-	.counter_alloc = flow_null_counter_allocate,
-	.counter_free = flow_null_counter_free,
-	.counter_query = flow_null_counter_query
+	.get_aged_flows = mlx5_flow_null_get_aged_flows,
+	.counter_alloc = mlx5_flow_null_counter_allocate,
+	.counter_free = mlx5_flow_null_counter_free,
+	.counter_query = mlx5_flow_null_counter_query
 };
 
 /**
@@ -4562,7 +4562,7 @@ flow_get_rss_action(struct rte_eth_dev *dev,
  *   The specified ASO age action.
  */
 struct mlx5_aso_age_action*
-flow_aso_age_get_by_idx(struct rte_eth_dev *dev, uint32_t age_idx)
+mlx5_flow_aso_age_get_by_idx(struct rte_eth_dev *dev, uint32_t age_idx)
 {
 	uint16_t pool_idx = age_idx & UINT16_MAX;
 	uint16_t offset = (age_idx >> 16) & UINT16_MAX;
@@ -5044,7 +5044,7 @@ flow_check_hairpin_split(struct rte_eth_dev *dev,
 }
 
 int
-flow_dv_mreg_match_cb(void *tool_ctx __rte_unused,
+mlx5_flow_dv_mreg_match_cb(void *tool_ctx __rte_unused,
 		      struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -5055,7 +5055,7 @@ flow_dv_mreg_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_dv_mreg_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_dv_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct rte_eth_dev *dev = tool_ctx;
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -5171,8 +5171,8 @@ flow_dv_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_dv_mreg_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
-		      void *cb_ctx __rte_unused)
+mlx5_flow_dv_mreg_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+			   void *cb_ctx __rte_unused)
 {
 	struct rte_eth_dev *dev = tool_ctx;
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -5190,7 +5190,7 @@ flow_dv_mreg_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 }
 
 void
-flow_dv_mreg_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_mreg_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_mreg_copy_resource *mcp_res =
 			       container_of(entry, typeof(*mcp_res), hlist_ent);
@@ -5247,7 +5247,7 @@ flow_mreg_add_copy_action(struct rte_eth_dev *dev, uint32_t mark_id,
 }
 
 void
-flow_dv_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_mreg_copy_resource *mcp_res =
 			       container_of(entry, typeof(*mcp_res), hlist_ent);
@@ -6938,7 +6938,7 @@ flow_create_split_meter(struct rte_eth_dev *dev,
 						    &has_modify, &meter_id);
 	if (has_mtr) {
 		if (flow->meter) {
-			fm = flow_dv_meter_find_by_idx(priv, flow->meter);
+			fm = mlx5_flow_dv_meter_find_by_idx(priv, flow->meter);
 			if (!fm)
 				return rte_flow_error_set(error, EINVAL,
 						RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -7343,11 +7343,11 @@ flow_tunnel_from_rule(const struct mlx5_flow *flow)
  *   A flow index on success, 0 otherwise and rte_errno is set.
  */
 uintptr_t
-flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-		    const struct rte_flow_attr *attr,
-		    const struct rte_flow_item items[],
-		    const struct rte_flow_action original_actions[],
-		    bool external, struct rte_flow_error *error)
+mlx5_flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+			     const struct rte_flow_attr *attr,
+			     const struct rte_flow_item items[],
+			     const struct rte_flow_action original_actions[],
+			     bool external, struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow *flow = NULL;
@@ -7435,8 +7435,8 @@ flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	}
 	flow_split_info.flow_idx = idx;
 	flow->drv_type = flow_get_drv_type(dev, attr);
-	MLX5_ASSERT(flow->drv_type > MLX5_FLOW_TYPE_MIN &&
-		    flow->drv_type < MLX5_FLOW_TYPE_MAX);
+	/* drv_type upper limit does not require range check since it's only 2b size. */
+	MLX5_ASSERT(flow->drv_type > MLX5_FLOW_TYPE_MIN);
 	memset(rss_desc, 0, offsetof(struct mlx5_flow_rss_desc, queue));
 	/* RSS Action only works on NIC RX domain */
 	if (attr->ingress)
@@ -8077,15 +8077,15 @@ mlx5_flow_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
  *   Index of flow to destroy.
  */
 void
-flow_legacy_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-		     uintptr_t flow_idx)
+mlx5_flow_legacy_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+			      uintptr_t flow_idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow *flow = mlx5_ipool_get(priv->flows[type], (uint32_t)flow_idx);
 
 	if (!flow)
 		return;
-	MLX5_ASSERT((type >= MLX5_FLOW_TYPE_CTL) && (type < MLX5_FLOW_TYPE_MAXI));
+	MLX5_ASSERT(type < MLX5_FLOW_TYPE_MAXI);
 	MLX5_ASSERT(flow->type == type);
 	/*
 	 * Update RX queue flags only if port is started, otherwise it is
@@ -8143,7 +8143,7 @@ mlx5_flow_list_flush(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	if (priv->sh->config.dv_flow_en == 2 &&
 	    type == MLX5_FLOW_TYPE_GEN) {
 		priv->hws_rule_flushing = true;
-		flow_hw_q_flow_flush(dev, NULL);
+		mlx5_flow_hw_q_flow_flush(dev, NULL);
 		priv->hws_rule_flushing = false;
 	}
 #endif
@@ -8195,7 +8195,7 @@ mlx5_flow_stop_default(struct rte_eth_dev *dev)
 		mlx5_flow_nta_del_default_copy_action(dev);
 		if (!rte_atomic_load_explicit(&priv->hws_mark_refcnt,
 					      rte_memory_order_relaxed))
-			flow_hw_rxq_flag_set(dev, false);
+			mlx5_flow_hw_rxq_flag_set(dev, false);
 		return;
 	}
 #else
@@ -8214,7 +8214,7 @@ mlx5_flow_stop_default(struct rte_eth_dev *dev)
  *   Flag to enable or not.
  */
 void
-flow_hw_rxq_flag_set(struct rte_eth_dev *dev, bool enable)
+mlx5_flow_hw_rxq_flag_set(struct rte_eth_dev *dev, bool enable)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	unsigned int i;
@@ -8271,7 +8271,7 @@ mlx5_flow_start_default(struct rte_eth_dev *dev)
  * Release key of thread specific flow workspace data.
  */
 void
-flow_release_workspace(void *data)
+mlx5_flow_release_workspace(void *data)
 {
 	struct mlx5_flow_workspace *wks = data;
 	struct mlx5_flow_workspace *next;
@@ -10092,8 +10092,8 @@ mlx5_flow_discover_mreg_c(struct rte_eth_dev *dev)
 }
 
 int
-save_dump_file(const uint8_t *data, uint32_t size,
-	uint32_t type, uint64_t id, void *arg, FILE *file)
+mlx5_save_dump_file(const uint8_t *data, uint32_t size,
+		    uint32_t type, uint64_t id, void *arg, FILE *file)
 {
 	char line[BUF_SIZE];
 	uint32_t out = 0;
@@ -10207,8 +10207,8 @@ mlx5_flow_dev_dump_ipool(struct rte_eth_dev *dev,
 	&count.hits, &count.bytes, &action)) && action) {
 		id = (uint64_t)(uintptr_t)action;
 		type = DR_DUMP_REC_TYPE_PMD_COUNTER;
-		save_dump_file(NULL, 0, type,
-			id, (void *)&count, file);
+		mlx5_save_dump_file(NULL, 0, type,
+				    id, (void *)&count, file);
 	}
 
 	while (handle_idx) {
@@ -10233,16 +10233,16 @@ mlx5_flow_dev_dump_ipool(struct rte_eth_dev *dev,
 			id = (uint64_t)(uintptr_t)modify_hdr->action;
 			actions_num = modify_hdr->actions_num;
 			type = DR_DUMP_REC_TYPE_PMD_MODIFY_HDR;
-			save_dump_file(data, size, type, id,
-						(void *)(&actions_num), file);
+			mlx5_save_dump_file(data, size, type, id,
+					    (void *)(&actions_num), file);
 		}
 		if (encap_decap) {
 			data = encap_decap->buf;
 			size = encap_decap->size;
 			id = (uint64_t)(uintptr_t)encap_decap->action;
 			type = DR_DUMP_REC_TYPE_PMD_PKT_REFORMAT;
-			save_dump_file(data, size, type,
-						id, NULL, file);
+			mlx5_save_dump_file(data, size, type,
+					    id, NULL, file);
 		}
 	}
 	return 0;
@@ -10302,8 +10302,8 @@ mlx5_flow_dev_dump_sh_all(struct rte_eth_dev *dev,
 				size = encap_decap->size;
 				id = (uint64_t)(uintptr_t)encap_decap->action;
 				type = DR_DUMP_REC_TYPE_PMD_PKT_REFORMAT;
-				save_dump_file(data, size, type,
-					id, NULL, file);
+				mlx5_save_dump_file(data, size, type,
+						    id, NULL, file);
 				e = LIST_NEXT(e, next);
 			}
 		}
@@ -10335,8 +10335,8 @@ mlx5_flow_dev_dump_sh_all(struct rte_eth_dev *dev,
 						actions_num = modify_hdr->actions_num;
 						id = (uint64_t)(uintptr_t)modify_hdr->action;
 						type = DR_DUMP_REC_TYPE_PMD_MODIFY_HDR;
-						save_dump_file(data, size, type, id,
-								(void *)(&actions_num), file);
+						mlx5_save_dump_file(data, size, type, id,
+								    (void *)(&actions_num), file);
 						e = LIST_NEXT(e, next);
 					}
 				}
@@ -10356,8 +10356,8 @@ mlx5_flow_dev_dump_sh_all(struct rte_eth_dev *dev,
 					actions_num = modify_hdr->actions_num;
 					id = (uint64_t)(uintptr_t)modify_hdr->action;
 					type = DR_DUMP_REC_TYPE_PMD_MODIFY_HDR;
-					save_dump_file(data, size, type, id,
-							(void *)(&actions_num), file);
+					mlx5_save_dump_file(data, size, type, id,
+							    (void *)(&actions_num), file);
 					e = LIST_NEXT(e, next);
 				}
 			}
@@ -10376,8 +10376,8 @@ mlx5_flow_dev_dump_sh_all(struct rte_eth_dev *dev,
 		&count.bytes, &action)) && action) {
 			id = (uint64_t)(uintptr_t)action;
 			type = DR_DUMP_REC_TYPE_PMD_COUNTER;
-			save_dump_file(NULL, 0, type,
-					id, (void *)&count, file);
+			mlx5_save_dump_file(NULL, 0, type,
+					    id, (void *)&count, file);
 		}
 	}
 	return 0;
@@ -12425,9 +12425,9 @@ flow_disable_steering_cleanup(struct rte_eth_dev *dev)
 	mlx5_flex_item_port_cleanup(dev);
 	mlx5_indirect_list_handles_release(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
-	flow_hw_destroy_vport_action(dev);
-	flow_hw_resource_release(dev);
-	flow_hw_clear_port_info(dev);
+	mlx5_flow_hw_destroy_vport_action(dev);
+	mlx5_flow_hw_resource_release(dev);
+	mlx5_flow_hw_clear_port_info(dev);
 	if (priv->tlv_options != NULL) {
 		/* Free the GENEVE TLV parser resource. */
 		claim_zero(mlx5_geneve_tlv_options_destroy(priv->tlv_options, priv->sh->phdev));
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 030f51c509c..c8af3fe0be4 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -183,14 +183,14 @@ struct mlx5_rte_flow_item_sq {
 };
 
 /* Map from registers to modify fields. */
-extern enum mlx5_modification_field reg_to_field[];
+extern enum mlx5_modification_field mlx5_reg_to_field[];
 extern const size_t mlx5_mod_reg_size;
 
 static __rte_always_inline enum mlx5_modification_field
 mlx5_convert_reg_to_field(enum modify_reg reg)
 {
 	MLX5_ASSERT((size_t)reg < mlx5_mod_reg_size);
-	return reg_to_field[reg];
+	return mlx5_reg_to_field[reg];
 }
 
 /* Feature name to allocate metadata register. */
@@ -2056,6 +2056,7 @@ extern struct flow_hw_port_info mlx5_flow_hw_port_infos[RTE_MAX_ETHPORTS];
 static __rte_always_inline int
 flow_hw_get_sqn(struct rte_eth_dev *dev, uint16_t tx_queue, uint32_t *sqn)
 {
+	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_txq_ctrl *txq;
 	struct mlx5_external_q *ext_txq;
 
@@ -2064,6 +2065,9 @@ flow_hw_get_sqn(struct rte_eth_dev *dev, uint16_t tx_queue, uint32_t *sqn)
 		*sqn = 0;
 		return 0;
 	}
+	/* Validate tx_queue is within bounds before using as array index */
+	if (tx_queue >= priv->txqs_n)
+		return -EINVAL;
 	if (mlx5_is_external_txq(dev, tx_queue)) {
 		ext_txq = mlx5_ext_txq_get(dev, tx_queue);
 		if (ext_txq == NULL)
@@ -2300,13 +2304,13 @@ int mlx5_geneve_tlv_option_register(struct mlx5_priv *priv,
 void mlx5_geneve_tlv_options_unregister(struct mlx5_priv *priv,
 					struct mlx5_geneve_tlv_options_mng *mng);
 
-void flow_hw_set_port_info(struct rte_eth_dev *dev);
-void flow_hw_clear_port_info(struct rte_eth_dev *dev);
-int flow_hw_create_vport_action(struct rte_eth_dev *dev);
-void flow_hw_destroy_vport_action(struct rte_eth_dev *dev);
+void mlx5_flow_hw_set_port_info(struct rte_eth_dev *dev);
+void mlx5_flow_hw_clear_port_info(struct rte_eth_dev *dev);
+int mlx5_flow_hw_create_vport_action(struct rte_eth_dev *dev);
+void mlx5_flow_hw_destroy_vport_action(struct rte_eth_dev *dev);
 int
-flow_hw_init(struct rte_eth_dev *dev,
-	     struct rte_flow_error *error);
+mlx5_flow_hw_init(struct rte_eth_dev *dev,
+		  struct rte_flow_error *error);
 
 typedef uintptr_t (*mlx5_flow_list_create_t)(struct rte_eth_dev *dev,
 					enum mlx5_flow_type type,
@@ -2933,8 +2937,8 @@ mlx5_translate_tunnel_etypes(uint64_t pattern_flags)
 	return 0;
 }
 
-int flow_hw_q_flow_flush(struct rte_eth_dev *dev,
-			 struct rte_flow_error *error);
+int mlx5_flow_hw_q_flow_flush(struct rte_eth_dev *dev,
+			      struct rte_flow_error *error);
 
 /*
  * Convert rte_mtr_color to mlx5 color.
@@ -3165,9 +3169,9 @@ int mlx5_flow_validate_action_rss(const struct rte_flow_action *action,
 int mlx5_flow_validate_action_default_miss(uint64_t action_flags,
 				const struct rte_flow_attr *attr,
 				struct rte_flow_error *error);
-int flow_validate_modify_field_level
-			(const struct rte_flow_field_data *data,
-			 struct rte_flow_error *error);
+int mlx5_flow_validate_modify_field_level
+				(const struct rte_flow_field_data *data,
+				 struct rte_flow_error *error);
 int
 mlx5_flow_dv_validate_action_l2_encap(struct rte_eth_dev *dev,
 				      uint64_t action_flags,
@@ -3357,146 +3361,148 @@ int mlx5_action_handle_flush(struct rte_eth_dev *dev);
 void mlx5_release_tunnel_hub(struct mlx5_dev_ctx_shared *sh, uint16_t port_id);
 int mlx5_alloc_tunnel_hub(struct mlx5_dev_ctx_shared *sh);
 
-struct mlx5_list_entry *flow_dv_tbl_create_cb(void *tool_ctx, void *entry_ctx);
-int flow_dv_tbl_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			 void *cb_ctx);
-void flow_dv_tbl_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_tbl_clone_cb(void *tool_ctx,
-					     struct mlx5_list_entry *oentry,
-					     void *entry_ctx);
-void flow_dv_tbl_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_flow_tbl_resource *flow_dv_tbl_resource_get(struct rte_eth_dev *dev,
-		uint32_t table_level, uint8_t egress, uint8_t transfer,
-		bool external, const struct mlx5_flow_tunnel *tunnel,
-		uint32_t group_id, uint8_t dummy,
-		uint32_t table_id, struct rte_flow_error *error);
-int flow_dv_tbl_resource_release(struct mlx5_dev_ctx_shared *sh,
-				 struct mlx5_flow_tbl_resource *tbl);
-
-struct mlx5_list_entry *flow_dv_tag_create_cb(void *tool_ctx, void *cb_ctx);
-int flow_dv_tag_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			 void *cb_ctx);
-void flow_dv_tag_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_tag_clone_cb(void *tool_ctx,
-					     struct mlx5_list_entry *oentry,
-					     void *cb_ctx);
-void flow_dv_tag_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-
-int flow_modify_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			    void *cb_ctx);
-struct mlx5_list_entry *flow_modify_create_cb(void *tool_ctx, void *ctx);
-void flow_modify_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_modify_clone_cb(void *tool_ctx,
-						struct mlx5_list_entry *oentry,
-						void *ctx);
-void flow_modify_clone_free_cb(void *tool_ctx,
-				  struct mlx5_list_entry *entry);
-
-struct mlx5_list_entry *flow_dv_mreg_create_cb(void *tool_ctx, void *ctx);
-int flow_dv_mreg_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			  void *cb_ctx);
-void flow_dv_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_mreg_clone_cb(void *tool_ctx,
-					      struct mlx5_list_entry *entry,
-					      void *ctx);
-void flow_dv_mreg_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-
-int flow_encap_decap_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-				 void *cb_ctx);
-struct mlx5_list_entry *flow_encap_decap_create_cb(void *tool_ctx,
-						      void *cb_ctx);
-void flow_encap_decap_remove_cb(void *tool_ctx,
-				   struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_encap_decap_clone_cb(void *tool_ctx,
-						  struct mlx5_list_entry *entry,
+struct mlx5_list_entry *mlx5_flow_dv_tbl_create_cb(void *tool_ctx, void *entry_ctx);
+int mlx5_flow_dv_tbl_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+			      void *cb_ctx);
+void mlx5_flow_dv_tbl_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_tbl_clone_cb(void *tool_ctx,
+						  struct mlx5_list_entry *oentry,
+						  void *entry_ctx);
+void mlx5_flow_dv_tbl_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_flow_tbl_resource *mlx5_flow_dv_tbl_resource_get(struct rte_eth_dev *dev,
+	uint32_t table_level, uint8_t egress, uint8_t transfer,
+	bool external, const struct mlx5_flow_tunnel *tunnel,
+	uint32_t group_id, uint8_t dummy,
+	uint32_t table_id, struct rte_flow_error *error);
+int mlx5_flow_dv_tbl_resource_release(struct mlx5_dev_ctx_shared *sh,
+				      struct mlx5_flow_tbl_resource *tbl);
+
+struct mlx5_list_entry *mlx5_flow_dv_tag_create_cb(void *tool_ctx, void *cb_ctx);
+int mlx5_flow_dv_tag_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+			      void *cb_ctx);
+void mlx5_flow_dv_tag_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_tag_clone_cb(void *tool_ctx,
+						  struct mlx5_list_entry *oentry,
 						  void *cb_ctx);
-void flow_encap_decap_clone_free_cb(void *tool_ctx,
-				       struct mlx5_list_entry *entry);
-int __flow_encap_decap_resource_register
+void mlx5_flow_dv_tag_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+
+int mlx5_flow_modify_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+			      void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_modify_create_cb(void *tool_ctx, void *ctx);
+void mlx5_flow_modify_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_modify_clone_cb(void *tool_ctx,
+						  struct mlx5_list_entry *oentry,
+						  void *ctx);
+void mlx5_flow_modify_clone_free_cb(void *tool_ctx,
+				    struct mlx5_list_entry *entry);
+
+struct mlx5_list_entry *mlx5_flow_dv_mreg_create_cb(void *tool_ctx, void *ctx);
+int mlx5_flow_dv_mreg_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+			       void *cb_ctx);
+void mlx5_flow_dv_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_mreg_clone_cb(void *tool_ctx,
+						   struct mlx5_list_entry *entry,
+						   void *ctx);
+void mlx5_flow_dv_mreg_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+
+int mlx5_flow_encap_decap_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+				   void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_encap_decap_create_cb(void *tool_ctx,
+							void *cb_ctx);
+void mlx5_flow_encap_decap_remove_cb(void *tool_ctx,
+				     struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_encap_decap_clone_cb(void *tool_ctx,
+						       struct mlx5_list_entry *entry,
+						       void *cb_ctx);
+void mlx5_flow_encap_decap_clone_free_cb(void *tool_ctx,
+					 struct mlx5_list_entry *entry);
+int mlx5_flow_encap_decap_resource_register
 			(struct rte_eth_dev *dev,
 			 struct mlx5_flow_dv_encap_decap_resource *resource,
 			 bool is_root,
 			 struct mlx5_flow_dv_encap_decap_resource **encap_decap,
 			 struct rte_flow_error *error);
-int __flow_modify_hdr_resource_register
+int mlx5_flow_modify_hdr_resource_register
 			(struct rte_eth_dev *dev,
 			 struct mlx5_flow_dv_modify_hdr_resource *resource,
 			 struct mlx5_flow_dv_modify_hdr_resource **modify,
 			 struct rte_flow_error *error);
-int flow_encap_decap_resource_release(struct rte_eth_dev *dev,
-				     uint32_t encap_decap_idx);
-int flow_matcher_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			     void *ctx);
-struct mlx5_list_entry *flow_matcher_create_cb(void *tool_ctx, void *ctx);
-void flow_matcher_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_matcher_clone_cb(void *tool_ctx __rte_unused,
-			 struct mlx5_list_entry *entry, void *cb_ctx);
-void flow_matcher_clone_free_cb(void *tool_ctx __rte_unused,
-			     struct mlx5_list_entry *entry);
-int flow_dv_port_id_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			     void *cb_ctx);
-struct mlx5_list_entry *flow_dv_port_id_create_cb(void *tool_ctx, void *cb_ctx);
-void flow_dv_port_id_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_port_id_clone_cb(void *tool_ctx,
-				struct mlx5_list_entry *entry, void *cb_ctx);
-void flow_dv_port_id_clone_free_cb(void *tool_ctx,
-				   struct mlx5_list_entry *entry);
-
-int flow_dv_push_vlan_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			       void *cb_ctx);
-struct mlx5_list_entry *flow_dv_push_vlan_create_cb(void *tool_ctx,
-						    void *cb_ctx);
-void flow_dv_push_vlan_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_push_vlan_clone_cb(void *tool_ctx,
-				 struct mlx5_list_entry *entry, void *cb_ctx);
-void flow_dv_push_vlan_clone_free_cb(void *tool_ctx,
+int mlx5_flow_encap_decap_resource_release(struct rte_eth_dev *dev,
+					   uint32_t encap_decap_idx);
+int mlx5_flow_matcher_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+			       void *ctx);
+struct mlx5_list_entry *mlx5_flow_matcher_create_cb(void *tool_ctx, void *ctx);
+void mlx5_flow_matcher_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_matcher_clone_cb(void *tool_ctx __rte_unused,
+						   struct mlx5_list_entry *entry, void *cb_ctx);
+void mlx5_flow_matcher_clone_free_cb(void *tool_ctx __rte_unused,
 				     struct mlx5_list_entry *entry);
+int mlx5_flow_dv_port_id_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+				  void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_dv_port_id_create_cb(void *tool_ctx, void *cb_ctx);
+void mlx5_flow_dv_port_id_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_port_id_clone_cb(void *tool_ctx,
+						      struct mlx5_list_entry *entry, void *cb_ctx);
+void mlx5_flow_dv_port_id_clone_free_cb(void *tool_ctx,
+					struct mlx5_list_entry *entry);
+
+int mlx5_flow_dv_push_vlan_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+				    void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_dv_push_vlan_create_cb(void *tool_ctx,
+							 void *cb_ctx);
+void mlx5_flow_dv_push_vlan_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_push_vlan_clone_cb(void *tool_ctx,
+							struct mlx5_list_entry *entry,
+							void *cb_ctx);
+void mlx5_flow_dv_push_vlan_clone_free_cb(void *tool_ctx,
+					  struct mlx5_list_entry *entry);
+
+int mlx5_flow_dv_sample_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+				 void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_dv_sample_create_cb(void *tool_ctx, void *cb_ctx);
+void mlx5_flow_dv_sample_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_sample_clone_cb(void *tool_ctx,
+						     struct mlx5_list_entry *entry, void *cb_ctx);
+void mlx5_flow_dv_sample_clone_free_cb(void *tool_ctx,
+				       struct mlx5_list_entry *entry);
+
+int mlx5_flow_dv_dest_array_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
+				     void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_dv_dest_array_create_cb(void *tool_ctx,
+							  void *cb_ctx);
+void mlx5_flow_dv_dest_array_remove_cb(void *tool_ctx,
+				       struct mlx5_list_entry *entry);
+struct mlx5_list_entry *mlx5_flow_dv_dest_array_clone_cb(void *tool_ctx,
+							 struct mlx5_list_entry *entry,
+							 void *cb_ctx);
+void mlx5_flow_dv_dest_array_clone_free_cb(void *tool_ctx,
+					   struct mlx5_list_entry *entry);
+void mlx5_flow_dv_hashfields_set(uint64_t item_flags,
+				 struct mlx5_flow_rss_desc *rss_desc,
+				 uint64_t *hash_fields);
+void mlx5_flow_dv_action_rss_l34_hash_adjust(uint64_t rss_types,
+					     uint64_t *hash_field);
+uint32_t mlx5_flow_dv_action_rss_hrxq_lookup(struct rte_eth_dev *dev, uint32_t idx,
+					     const uint64_t hash_fields);
+int mlx5_flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+			  const struct rte_flow_item items[],
+			  const struct rte_flow_action actions[],
+			  bool external, int hairpin, struct rte_flow_error *error);
+
+struct mlx5_list_entry *mlx5_flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx);
+void mlx5_flow_hw_grp_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+int mlx5_flow_hw_grp_match_cb(void *tool_ctx,
+			      struct mlx5_list_entry *entry,
+			      void *cb_ctx);
+struct mlx5_list_entry *mlx5_flow_hw_grp_clone_cb(void *tool_ctx,
+						  struct mlx5_list_entry *oentry,
+						  void *cb_ctx);
+void mlx5_flow_hw_grp_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
 
-int flow_dv_sample_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-			    void *cb_ctx);
-struct mlx5_list_entry *flow_dv_sample_create_cb(void *tool_ctx, void *cb_ctx);
-void flow_dv_sample_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_sample_clone_cb(void *tool_ctx,
-				 struct mlx5_list_entry *entry, void *cb_ctx);
-void flow_dv_sample_clone_free_cb(void *tool_ctx,
-				  struct mlx5_list_entry *entry);
-
-int flow_dv_dest_array_match_cb(void *tool_ctx, struct mlx5_list_entry *entry,
-				void *cb_ctx);
-struct mlx5_list_entry *flow_dv_dest_array_create_cb(void *tool_ctx,
-						     void *cb_ctx);
-void flow_dv_dest_array_remove_cb(void *tool_ctx,
-				  struct mlx5_list_entry *entry);
-struct mlx5_list_entry *flow_dv_dest_array_clone_cb(void *tool_ctx,
-				   struct mlx5_list_entry *entry, void *cb_ctx);
-void flow_dv_dest_array_clone_free_cb(void *tool_ctx,
-				      struct mlx5_list_entry *entry);
-void flow_dv_hashfields_set(uint64_t item_flags,
-			    struct mlx5_flow_rss_desc *rss_desc,
-			    uint64_t *hash_fields);
-void flow_dv_action_rss_l34_hash_adjust(uint64_t rss_types,
-					uint64_t *hash_field);
-uint32_t flow_dv_action_rss_hrxq_lookup(struct rte_eth_dev *dev, uint32_t idx,
-					const uint64_t hash_fields);
-int flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		     const struct rte_flow_item items[],
-		     const struct rte_flow_action actions[],
-		     bool external, int hairpin, struct rte_flow_error *error);
-
-struct mlx5_list_entry *flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx);
-void flow_hw_grp_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-int flow_hw_grp_match_cb(void *tool_ctx,
-			 struct mlx5_list_entry *entry,
-			 void *cb_ctx);
-struct mlx5_list_entry *flow_hw_grp_clone_cb(void *tool_ctx,
-					     struct mlx5_list_entry *oentry,
-					     void *cb_ctx);
-void flow_hw_grp_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry);
-
-struct mlx5_aso_age_action *flow_aso_age_get_by_idx(struct rte_eth_dev *dev,
-						    uint32_t age_idx);
-
-void flow_release_workspace(void *data);
+struct mlx5_aso_age_action *mlx5_flow_aso_age_get_by_idx(struct rte_eth_dev *dev,
+							 uint32_t age_idx);
+
+void mlx5_flow_release_workspace(void *data);
 int mlx5_flow_os_init_workspace_once(void);
 void *mlx5_flow_os_get_specific_workspace(void);
 int mlx5_flow_os_set_specific_workspace(struct mlx5_flow_workspace *data);
@@ -3523,51 +3529,51 @@ void mlx5_flow_destroy_policy_rules(struct rte_eth_dev *dev,
 			     struct mlx5_flow_meter_policy *mtr_policy);
 int mlx5_flow_create_def_policy(struct rte_eth_dev *dev);
 void mlx5_flow_destroy_def_policy(struct rte_eth_dev *dev);
-void flow_drv_rxq_flags_set(struct rte_eth_dev *dev,
-		       struct mlx5_flow_handle *dev_handle);
+void mlx5_flow_drv_rxq_flags_set(struct rte_eth_dev *dev,
+				 struct mlx5_flow_handle *dev_handle);
 const struct mlx5_flow_tunnel *
 mlx5_get_tof(const struct rte_flow_item *items,
 	     const struct rte_flow_action *actions,
 	     enum mlx5_tof_rule_type *rule_type);
 void
-flow_hw_resource_release(struct rte_eth_dev *dev);
+mlx5_flow_hw_resource_release(struct rte_eth_dev *dev);
 int
 mlx5_geneve_tlv_options_destroy(struct mlx5_geneve_tlv_options *options,
 				struct mlx5_physical_device *phdev);
 void
-flow_hw_rxq_flag_set(struct rte_eth_dev *dev, bool enable);
-int flow_dv_action_validate(struct rte_eth_dev *dev,
-			    const struct rte_flow_indir_action_conf *conf,
-			    const struct rte_flow_action *action,
-			    struct rte_flow_error *err);
-struct rte_flow_action_handle *flow_dv_action_create(struct rte_eth_dev *dev,
-		      const struct rte_flow_indir_action_conf *conf,
-		      const struct rte_flow_action *action,
-		      struct rte_flow_error *err);
-int flow_dv_action_destroy(struct rte_eth_dev *dev,
-			   struct rte_flow_action_handle *handle,
-			   struct rte_flow_error *error);
-int flow_dv_action_update(struct rte_eth_dev *dev,
-			  struct rte_flow_action_handle *handle,
-			  const void *update,
-			  struct rte_flow_error *err);
-int flow_dv_action_query(struct rte_eth_dev *dev,
-			 const struct rte_flow_action_handle *handle,
-			 void *data,
-			 struct rte_flow_error *error);
-size_t flow_dv_get_item_hdr_len(const enum rte_flow_item_type item_type);
-int flow_dv_convert_encap_data(const struct rte_flow_item *items, uint8_t *buf,
-			   size_t *size, struct rte_flow_error *error);
+mlx5_flow_hw_rxq_flag_set(struct rte_eth_dev *dev, bool enable);
+int mlx5_flow_dv_action_validate(struct rte_eth_dev *dev,
+				 const struct rte_flow_indir_action_conf *conf,
+				 const struct rte_flow_action *action,
+				 struct rte_flow_error *err);
+struct rte_flow_action_handle *mlx5_flow_dv_action_create(struct rte_eth_dev *dev,
+				const struct rte_flow_indir_action_conf *conf,
+				const struct rte_flow_action *action,
+				struct rte_flow_error *err);
+int mlx5_flow_dv_action_destroy(struct rte_eth_dev *dev,
+				struct rte_flow_action_handle *handle,
+				struct rte_flow_error *error);
+int mlx5_flow_dv_action_update(struct rte_eth_dev *dev,
+			       struct rte_flow_action_handle *handle,
+			       const void *update,
+			       struct rte_flow_error *err);
+int mlx5_flow_dv_action_query(struct rte_eth_dev *dev,
+			      const struct rte_flow_action_handle *handle,
+			      void *data,
+			      struct rte_flow_error *error);
+size_t mlx5_flow_dv_get_item_hdr_len(const enum rte_flow_item_type item_type);
+int mlx5_flow_dv_convert_encap_data(const struct rte_flow_item *items, uint8_t *buf,
+				    size_t *size, struct rte_flow_error *error);
 void mlx5_flow_field_id_to_modify_info
 		(const struct rte_flow_field_data *data,
 		 struct field_modify_info *info, uint32_t *mask,
 		 uint32_t width, struct rte_eth_dev *dev,
 		 const struct rte_flow_attr *attr, struct rte_flow_error *error);
-int flow_dv_convert_modify_action(struct rte_flow_item *item,
-			      struct field_modify_info *field,
-			      struct field_modify_info *dest,
-			      struct mlx5_flow_dv_modify_hdr_resource *resource,
-			      uint32_t type, struct rte_flow_error *error);
+int mlx5_flow_dv_convert_modify_action(struct rte_flow_item *item,
+				       struct field_modify_info *field,
+				       struct field_modify_info *dest,
+				       struct mlx5_flow_dv_modify_hdr_resource *resource,
+				       uint32_t type, struct rte_flow_error *error);
 
 #define MLX5_PF_VPORT_ID 0
 #define MLX5_ECPF_VPORT_ID 0xFFFE
@@ -3579,35 +3585,35 @@ int mlx5_flow_get_item_vport_id(struct rte_eth_dev *dev,
 				bool *all_ports,
 				struct rte_flow_error *error);
 
-int flow_dv_translate_items_hws(const struct rte_flow_item *items,
-				struct mlx5_flow_attr *attr, void *key,
-				uint32_t key_type, uint64_t *item_flags,
-				uint8_t *match_criteria,
-				struct rte_flow_error *error);
+int mlx5_flow_dv_translate_items_hws(const struct rte_flow_item *items,
+				     struct mlx5_flow_attr *attr, void *key,
+				     uint32_t key_type, uint64_t *item_flags,
+				     uint8_t *match_criteria,
+				     struct rte_flow_error *error);
 
-int __flow_dv_translate_items_hws(const struct rte_flow_item *items,
-				struct mlx5_flow_attr *attr, void *key,
-				uint32_t key_type, uint64_t *item_flags,
-				uint8_t *match_criteria,
-				bool nt_flow,
-				struct rte_flow_error *error);
+int mlx5_flow_dv_translate_items_hws_impl(const struct rte_flow_item *items,
+					  struct mlx5_flow_attr *attr, void *key,
+					  uint32_t key_type, uint64_t *item_flags,
+					  uint8_t *match_criteria,
+					  bool nt_flow,
+					  struct rte_flow_error *error);
 
 int mlx5_flow_pick_transfer_proxy(struct rte_eth_dev *dev,
 				  uint16_t *proxy_port_id,
 				  struct rte_flow_error *error);
-int flow_null_get_aged_flows(struct rte_eth_dev *dev,
-		    void **context,
-		    uint32_t nb_contexts,
-		    struct rte_flow_error *error);
-uint32_t flow_null_counter_allocate(struct rte_eth_dev *dev);
-void flow_null_counter_free(struct rte_eth_dev *dev,
-			uint32_t counter);
-int flow_null_counter_query(struct rte_eth_dev *dev,
-			uint32_t counter,
-			bool clear,
-		    uint64_t *pkts,
-			uint64_t *bytes,
-			void **action);
+int mlx5_flow_null_get_aged_flows(struct rte_eth_dev *dev,
+				  void **context,
+				  uint32_t nb_contexts,
+				  struct rte_flow_error *error);
+uint32_t mlx5_flow_null_counter_allocate(struct rte_eth_dev *dev);
+void mlx5_flow_null_counter_free(struct rte_eth_dev *dev,
+				 uint32_t counter);
+int mlx5_flow_null_counter_query(struct rte_eth_dev *dev,
+				 uint32_t counter,
+				 bool clear,
+				 uint64_t *pkts,
+				 uint64_t *bytes,
+				 void **action);
 
 int mlx5_flow_hw_flush_ctrl_flows(struct rte_eth_dev *dev);
 
@@ -3631,21 +3637,21 @@ int mlx5_flow_pattern_validate(struct rte_eth_dev *dev,
 		const struct rte_flow_pattern_template_attr *attr,
 		const struct rte_flow_item items[],
 		struct rte_flow_error *error);
-int flow_hw_table_update(struct rte_eth_dev *dev,
-			 struct rte_flow_error *error);
+int mlx5_flow_hw_table_update(struct rte_eth_dev *dev,
+			      struct rte_flow_error *error);
 int mlx5_flow_item_field_width(struct rte_eth_dev *dev,
 			   enum rte_flow_field_id field, int inherit,
 			   const struct rte_flow_attr *attr,
 			   struct rte_flow_error *error);
 void mlx5_flow_rxq_mark_flag_set(struct rte_eth_dev *dev);
 void mlx5_flow_rxq_flags_clear(struct rte_eth_dev *dev);
-uintptr_t flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-				const struct rte_flow_attr *attr,
-				const struct rte_flow_item items[],
-				const struct rte_flow_action actions[],
-				bool external, struct rte_flow_error *error);
-void flow_legacy_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-				uintptr_t flow_idx);
+uintptr_t mlx5_flow_legacy_list_create(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+				       const struct rte_flow_attr *attr,
+				       const struct rte_flow_item items[],
+				       const struct rte_flow_action actions[],
+				       bool external, struct rte_flow_error *error);
+void mlx5_flow_legacy_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+				   uintptr_t flow_idx);
 
 static __rte_always_inline int
 flow_hw_get_srh_flex_parser_byte_off_from_ctx(void *dr_ctx __rte_unused)
@@ -3741,30 +3747,30 @@ void
 mlx5_hw_decap_encap_destroy(struct rte_eth_dev *dev,
 			    struct mlx5_indirect_list *reformat);
 int
-flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-		    const struct rte_flow_attr *attr,
-		    const struct rte_flow_item items[],
-		    const struct rte_flow_action actions[],
-		    uint64_t item_flags, uint64_t action_flags, bool external,
-		    struct rte_flow_hw **flow, struct rte_flow_error *error);
+mlx5_flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+			 const struct rte_flow_attr *attr,
+			 const struct rte_flow_item items[],
+			 const struct rte_flow_action actions[],
+			 uint64_t item_flags, uint64_t action_flags, bool external,
+			 struct rte_flow_hw **flow, struct rte_flow_error *error);
 void
-flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow);
+mlx5_flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow);
 void
-flow_hw_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-		     uintptr_t flow_idx);
+mlx5_flow_hw_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+			  uintptr_t flow_idx);
 const struct rte_flow_action_rss *
-flow_nta_locate_rss(struct rte_eth_dev *dev,
-		    const struct rte_flow_action actions[],
-		    struct rte_flow_error *error);
+mlx5_flow_nta_locate_rss(struct rte_eth_dev *dev,
+			 const struct rte_flow_action actions[],
+			 struct rte_flow_error *error);
 struct rte_flow_hw *
-flow_nta_handle_rss(struct rte_eth_dev *dev,
-		    const struct rte_flow_attr *attr,
-		    const struct rte_flow_item items[],
-		    const struct rte_flow_action actions[],
-		    const struct rte_flow_action_rss *rss_conf,
-		    uint64_t item_flags, uint64_t action_flags,
-		    bool external, enum mlx5_flow_type flow_type,
-		    struct rte_flow_error *error);
+mlx5_flow_nta_handle_rss(struct rte_eth_dev *dev,
+			 const struct rte_flow_attr *attr,
+			 const struct rte_flow_item items[],
+			 const struct rte_flow_action actions[],
+			 const struct rte_flow_action_rss *rss_conf,
+			 uint64_t item_flags, uint64_t action_flags,
+			 bool external, enum mlx5_flow_type flow_type,
+			 struct rte_flow_error *error);
 
 extern const struct rte_flow_action_raw_decap empty_decap;
 extern const struct rte_flow_item_ipv6 nic_ipv6_mask;
@@ -3785,9 +3791,9 @@ void
 mlx5_flow_nta_split_resource_free(struct rte_eth_dev *dev,
 				  struct mlx5_flow_hw_split_resource *res);
 struct mlx5_list_entry *
-flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx);
+mlx5_flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx);
 void
-flow_nta_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
+mlx5_flow_nta_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry);
 void
 mlx5_flow_nta_del_copy_action(struct rte_eth_dev *dev, uint32_t idx);
 void
@@ -3802,7 +3808,7 @@ mlx5_flow_nta_update_copy_table(struct rte_eth_dev *dev,
 				uint64_t action_flags,
 				struct rte_flow_error *error);
 
-struct mlx5_ecpri_parser_profile *flow_hw_get_ecpri_parser_profile(void *dr_ctx);
+struct mlx5_ecpri_parser_profile *mlx5_flow_hw_get_ecpri_parser_profile(void *dr_ctx);
 
 struct mlx5_mirror *
 mlx5_hw_create_mirror(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 47f6d284103..18fe7f3b848 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -111,7 +111,7 @@ flow_dv_jump_tbl_resource_release(struct rte_eth_dev *dev,
 /**
  * Initialize flow attributes structure according to flow items' types.
  *
- * flow_dv_validate() avoids multiple L3/L4 layers cases other than tunnel
+ * mlx5_flow_dv_validate() avoids multiple L3/L4 layers cases other than tunnel
  * mode. For tunnel mode, the items to be modified are the outermost ones.
  *
  * @param[in] item
@@ -217,7 +217,7 @@ flow_dv_attr_init(const struct rte_flow_item *item, union flow_dv_attr *attr,
 	attr->valid = 1;
 }
 
-struct field_modify_info modify_eth[] = {
+static struct field_modify_info modify_eth[] = {
 	{4,  0, MLX5_MODI_OUT_DMAC_47_16},
 	{2,  4, MLX5_MODI_OUT_DMAC_15_0},
 	{4,  6, MLX5_MODI_OUT_SMAC_47_16},
@@ -225,13 +225,13 @@ struct field_modify_info modify_eth[] = {
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_vlan_out_first_vid[] = {
+static struct field_modify_info modify_vlan_out_first_vid[] = {
 	/* Size in bits !!! */
 	{12, 0, MLX5_MODI_OUT_FIRST_VID},
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_ipv4[] = {
+static struct field_modify_info modify_ipv4[] = {
 	{1,  1, MLX5_MODI_OUT_IP_DSCP},
 	{1,  8, MLX5_MODI_OUT_IPV4_TTL},
 	{4, 12, MLX5_MODI_OUT_SIPV4},
@@ -239,7 +239,7 @@ struct field_modify_info modify_ipv4[] = {
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_ipv6[] = {
+static struct field_modify_info modify_ipv6[] = {
 	{1,  0, MLX5_MODI_OUT_IP_DSCP},
 	{1,  7, MLX5_MODI_OUT_IPV6_HOPLIMIT},
 	{4,  8, MLX5_MODI_OUT_SIPV6_127_96},
@@ -253,18 +253,18 @@ struct field_modify_info modify_ipv6[] = {
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_ipv6_traffic_class[] = {
+static struct field_modify_info modify_ipv6_traffic_class[] = {
 	{1,  0, MLX5_MODI_OUT_IPV6_TRAFFIC_CLASS},
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_udp[] = {
+static struct field_modify_info modify_udp[] = {
 	{2, 0, MLX5_MODI_OUT_UDP_SPORT},
 	{2, 2, MLX5_MODI_OUT_UDP_DPORT},
 	{0, 0, 0},
 };
 
-struct field_modify_info modify_tcp[] = {
+static struct field_modify_info modify_tcp[] = {
 	{2, 0, MLX5_MODI_OUT_TCP_SPORT},
 	{2, 2, MLX5_MODI_OUT_TCP_DPORT},
 	{4, 4, MLX5_MODI_OUT_TCP_SEQ_NUM},
@@ -405,11 +405,11 @@ mlx5_update_vlan_vid_pcp(const struct rte_flow_action *action,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_dv_convert_modify_action(struct rte_flow_item *item,
-			      struct field_modify_info *field,
-			      struct field_modify_info *dest,
-			      struct mlx5_flow_dv_modify_hdr_resource *resource,
-			      uint32_t type, struct rte_flow_error *error)
+mlx5_flow_dv_convert_modify_action(struct rte_flow_item *item,
+				   struct field_modify_info *field,
+				   struct field_modify_info *dest,
+				   struct mlx5_flow_dv_modify_hdr_resource *resource,
+				   uint32_t type, struct rte_flow_error *error)
 {
 	uint32_t i = resource->actions_num;
 	struct mlx5_modification_cmd *actions = resource->actions;
@@ -557,8 +557,8 @@ flow_dv_convert_action_modify_ipv4
 	}
 	item.spec = &ipv4;
 	item.mask = &ipv4_mask;
-	return flow_dv_convert_modify_action(&item, modify_ipv4, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_ipv4, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -603,8 +603,8 @@ flow_dv_convert_action_modify_ipv6
 	}
 	item.spec = &ipv6;
 	item.mask = &ipv6_mask;
-	return flow_dv_convert_modify_action(&item, modify_ipv6, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_ipv6, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -649,8 +649,8 @@ flow_dv_convert_action_modify_mac
 	}
 	item.spec = &eth;
 	item.mask = &eth_mask;
-	return flow_dv_convert_modify_action(&item, modify_eth, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_eth, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -769,8 +769,8 @@ flow_dv_convert_action_modify_tp
 		item.mask = &tcp_mask;
 		field = modify_tcp;
 	}
-	return flow_dv_convert_modify_action(&item, field, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, field, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -833,8 +833,8 @@ flow_dv_convert_action_modify_ttl
 		item.mask = &ipv6_mask;
 		field = modify_ipv6;
 	}
-	return flow_dv_convert_modify_action(&item, field, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, field, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -894,8 +894,8 @@ flow_dv_convert_action_modify_dec_ttl
 		item.mask = &ipv6_mask;
 		field = modify_ipv6;
 	}
-	return flow_dv_convert_modify_action(&item, field, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_ADD, error);
+	return mlx5_flow_dv_convert_modify_action(&item, field, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_ADD, error);
 }
 
 /**
@@ -939,8 +939,8 @@ flow_dv_convert_action_modify_tcp_seq
 	item.type = RTE_FLOW_ITEM_TYPE_TCP;
 	item.spec = &tcp;
 	item.mask = &tcp_mask;
-	return flow_dv_convert_modify_action(&item, modify_tcp, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_ADD, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_tcp, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_ADD, error);
 }
 
 /**
@@ -984,11 +984,11 @@ flow_dv_convert_action_modify_tcp_ack
 	item.type = RTE_FLOW_ITEM_TYPE_TCP;
 	item.spec = &tcp;
 	item.mask = &tcp_mask;
-	return flow_dv_convert_modify_action(&item, modify_tcp, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_ADD, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_tcp, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_ADD, error);
 }
 
-enum mlx5_modification_field reg_to_field[] = {
+enum mlx5_modification_field mlx5_reg_to_field[] = {
 	[REG_NON] = MLX5_MODI_OUT_NONE,
 	[REG_A] = MLX5_MODI_META_DATA_REG_A,
 	[REG_B] = MLX5_MODI_META_DATA_REG_B,
@@ -1006,7 +1006,7 @@ enum mlx5_modification_field reg_to_field[] = {
 	[REG_C_11] = MLX5_MODI_META_REG_C_11,
 };
 
-const size_t mlx5_mod_reg_size = RTE_DIM(reg_to_field);
+const size_t mlx5_mod_reg_size = RTE_DIM(mlx5_reg_to_field);
 
 /**
  * Convert register set to DV specification.
@@ -1036,10 +1036,10 @@ flow_dv_convert_action_set_reg
 					  RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 					  "too many items to modify");
 	MLX5_ASSERT(conf->id != REG_NON);
-	MLX5_ASSERT(conf->id < (enum modify_reg)RTE_DIM(reg_to_field));
+	MLX5_ASSERT(conf->id < (enum modify_reg)RTE_DIM(mlx5_reg_to_field));
 	actions[i] = (struct mlx5_modification_cmd) {
 		.action_type = MLX5_MODIFICATION_TYPE_SET,
-		.field = reg_to_field[conf->id],
+		.field = mlx5_reg_to_field[conf->id],
 		.offset = conf->offset,
 		.length = conf->length,
 	};
@@ -1088,12 +1088,15 @@ flow_dv_convert_action_set_tag
 	if (ret < 0)
 		return ret;
 	MLX5_ASSERT(ret != REG_NON);
-	MLX5_ASSERT((unsigned int)ret < RTE_DIM(reg_to_field));
-	reg_type = reg_to_field[ret];
+	if ((unsigned int)ret >= RTE_DIM(mlx5_reg_to_field))
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  NULL, "invalid register index");
+	reg_type = mlx5_reg_to_field[ret];
 	MLX5_ASSERT(reg_type > 0);
 	reg_c_x[0] = (struct field_modify_info){4, 0, reg_type};
-	return flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -1124,12 +1127,12 @@ flow_dv_convert_action_copy_mreg(struct rte_eth_dev *dev,
 		.mask = &mask,
 	};
 	struct field_modify_info reg_src[] = {
-		{4, 0, reg_to_field[conf->src]},
+		{4, 0, mlx5_reg_to_field[conf->src]},
 		{0, 0, 0},
 	};
 	struct field_modify_info reg_dst = {
 		.offset = 0,
-		.id = reg_to_field[conf->dst],
+		.id = mlx5_reg_to_field[conf->dst],
 	};
 	/* Adjust reg_c[0] usage according to reported mask. */
 	if (conf->dst == REG_C_0 || conf->src == REG_C_0) {
@@ -1148,10 +1151,10 @@ flow_dv_convert_action_copy_mreg(struct rte_eth_dev *dev,
 			mask = rte_cpu_to_be_32(reg_c0);
 		}
 	}
-	return flow_dv_convert_modify_action(&item,
-					     reg_src, &reg_dst, res,
-					     MLX5_MODIFICATION_TYPE_COPY,
-					     error);
+	return mlx5_flow_dv_convert_modify_action(&item,
+						  reg_src, &reg_dst, res,
+						  MLX5_MODIFICATION_TYPE_COPY,
+						  error);
 }
 
 /**
@@ -1206,9 +1209,9 @@ flow_dv_convert_action_mark(struct rte_eth_dev *dev,
 		mask = rte_cpu_to_be_32(mask) & msk_c0;
 		mask = rte_cpu_to_be_32(mask << shl_c0);
 	}
-	reg_c_x[0] = (struct field_modify_info){4, 0, reg_to_field[reg]};
-	return flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	reg_c_x[0] = (struct field_modify_info){4, 0, mlx5_reg_to_field[reg]};
+	return mlx5_flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -1292,10 +1295,10 @@ flow_dv_convert_action_set_meta
 		mask = rte_cpu_to_be_32(mask) & msk_c0;
 		mask = rte_cpu_to_be_32(mask << shl_c0);
 	}
-	reg_c_x[0] = (struct field_modify_info){4, 0, reg_to_field[reg]};
+	reg_c_x[0] = (struct field_modify_info){4, 0, mlx5_reg_to_field[reg]};
 	/* The routine expects parameters in memory as big-endian ones. */
-	return flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, reg_c_x, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -1329,8 +1332,8 @@ flow_dv_convert_action_modify_ipv4_dscp
 	ipv4_mask.hdr.type_of_service = RTE_IPV4_HDR_DSCP_MASK >> 2;
 	item.spec = &ipv4;
 	item.mask = &ipv4_mask;
-	return flow_dv_convert_modify_action(&item, modify_ipv4, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_ipv4, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 /**
@@ -1379,8 +1382,8 @@ flow_dv_convert_action_modify_ipv6_dscp
 		modify_info = modify_ipv6_traffic_class;
 	else
 		modify_info = modify_ipv6;
-	return flow_dv_convert_modify_action(&item, modify_info, NULL, resource,
-					     MLX5_MODIFICATION_TYPE_SET, error);
+	return mlx5_flow_dv_convert_modify_action(&item, modify_info, NULL, resource,
+						  MLX5_MODIFICATION_TYPE_SET, error);
 }
 
 int
@@ -2111,23 +2114,23 @@ mlx5_flow_field_id_to_modify_info
 			int reg;
 
 			off_be = (tag_index == RTE_PMD_MLX5_LINEAR_HASH_TAG_INDEX) ?
-				 16 - (data->offset + width) + 16 : data->offset;
+				16 - (data->offset + width) + 16 : data->offset;
 			if (priv->sh->config.dv_flow_en == 2)
 				reg = flow_hw_get_reg_id(dev,
-							 RTE_FLOW_ITEM_TYPE_TAG,
-							 tag_index);
+							RTE_FLOW_ITEM_TYPE_TAG,
+							tag_index);
 			else
 				reg = mlx5_flow_get_reg_id(dev, MLX5_APP_TAG,
-							   tag_index, error);
+							tag_index, error);
 			if (reg < 0)
 				return;
 			MLX5_ASSERT(reg != REG_NON);
-			MLX5_ASSERT((unsigned int)reg < RTE_DIM(reg_to_field));
+			if ((unsigned int)reg >= RTE_DIM(mlx5_reg_to_field))
+				return;
 			info[idx] = (struct field_modify_info){4, 0,
-						reg_to_field[reg]};
+						mlx5_reg_to_field[reg]};
 			if (mask)
-				mask[idx] = flow_modify_info_mask_32
-					(width, off_be);
+				mask[idx] = flow_modify_info_mask_32(width, off_be);
 			else
 				info[idx].offset = off_be;
 		}
@@ -2143,9 +2146,9 @@ mlx5_flow_field_id_to_modify_info
 			if (reg < 0)
 				return;
 			MLX5_ASSERT(reg != REG_NON);
-			MLX5_ASSERT((unsigned int)reg < RTE_DIM(reg_to_field));
+			MLX5_ASSERT((unsigned int)reg < RTE_DIM(mlx5_reg_to_field));
 			info[idx] = (struct field_modify_info){4, 0,
-						reg_to_field[reg]};
+						mlx5_reg_to_field[reg]};
 			if (mask)
 				mask[idx] = flow_modify_info_mask_32_masked
 					(width, data->offset, mark_mask);
@@ -2163,9 +2166,9 @@ mlx5_flow_field_id_to_modify_info
 			if (reg < 0)
 				return;
 			MLX5_ASSERT(reg != REG_NON);
-			MLX5_ASSERT((unsigned int)reg < RTE_DIM(reg_to_field));
+			MLX5_ASSERT((unsigned int)reg < RTE_DIM(mlx5_reg_to_field));
 			info[idx] = (struct field_modify_info){4, 0,
-						reg_to_field[reg]};
+						mlx5_reg_to_field[reg]};
 			if (mask)
 				mask[idx] = flow_modify_info_mask_32_masked
 					(width, data->offset, meta_mask);
@@ -2216,8 +2219,8 @@ mlx5_flow_field_id_to_modify_info
 			RTE_SET_USED(meta_count);
 			MLX5_ASSERT(data->offset + width <= meta_count);
 			MLX5_ASSERT(reg != REG_NON);
-			MLX5_ASSERT(reg < RTE_DIM(reg_to_field));
-			info[idx] = (struct field_modify_info){4, 0, reg_to_field[reg]};
+			MLX5_ASSERT(reg < RTE_DIM(mlx5_reg_to_field));
+			info[idx] = (struct field_modify_info){4, 0, mlx5_reg_to_field[reg]};
 			if (mask)
 				mask[idx] = flow_modify_info_mask_32_masked
 					(width, data->offset, meta_mask);
@@ -2234,16 +2237,17 @@ mlx5_flow_field_id_to_modify_info
 			if (priv->sh->config.dv_flow_en == 2)
 				reg = flow_hw_get_reg_id
 					(dev,
-					 RTE_FLOW_ITEM_TYPE_METER_COLOR, 0);
+					RTE_FLOW_ITEM_TYPE_METER_COLOR, 0);
 			else
 				reg = mlx5_flow_get_reg_id(dev, MLX5_MTR_COLOR,
-						       0, error);
+						0, error);
 			if (reg < 0)
 				return;
 			MLX5_ASSERT(reg != REG_NON);
-			MLX5_ASSERT((unsigned int)reg < RTE_DIM(reg_to_field));
+			if ((unsigned int)reg >= RTE_DIM(mlx5_reg_to_field))
+				return;
 			info[idx] = (struct field_modify_info){4, 0,
-						reg_to_field[reg]};
+						mlx5_reg_to_field[reg]};
 			if (mask)
 				mask[idx] = flow_modify_info_mask_32_masked
 					(width, data->offset, color_mask);
@@ -2392,7 +2396,7 @@ flow_dv_convert_action_modify_field
 						  attr, error);
 	}
 	item.mask = &mask;
-	return flow_dv_convert_modify_action(&item,
+	return mlx5_flow_dv_convert_modify_action(&item,
 			field, dcopy, resource, type, error);
 }
 
@@ -4305,8 +4309,8 @@ flow_dv_validate_item_aggr_affinity(struct rte_eth_dev *dev,
 }
 
 int
-flow_encap_decap_match_cb(void *tool_ctx __rte_unused,
-			     struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_encap_decap_match_cb(void *tool_ctx __rte_unused,
+			       struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_encap_decap_resource *ctx_resource = ctx->data;
@@ -4326,7 +4330,7 @@ flow_encap_decap_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_encap_decap_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_encap_decap_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -4383,12 +4387,13 @@ flow_encap_decap_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_encap_decap_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
-			     void *cb_ctx)
+mlx5_flow_encap_decap_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+			       void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_encap_decap_resource *cache_resource;
+	struct mlx5_flow_dv_encap_decap_resource *old_resource;
 	uint32_t idx;
 
 	cache_resource = mlx5_ipool_malloc(sh->ipool[MLX5_IPOOL_DECAP_ENCAP],
@@ -4399,13 +4404,14 @@ flow_encap_decap_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 				   "cannot allocate resource memory");
 		return NULL;
 	}
-	memcpy(cache_resource, oentry, sizeof(*cache_resource));
+	old_resource = container_of(oentry, typeof(*old_resource), entry);
+	memcpy(cache_resource, old_resource, sizeof(*cache_resource));
 	cache_resource->idx = idx;
 	return &cache_resource->entry;
 }
 
 void
-flow_encap_decap_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_encap_decap_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_encap_decap_resource *res =
@@ -4415,11 +4421,11 @@ flow_encap_decap_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 }
 
 int
-__flow_encap_decap_resource_register(struct rte_eth_dev *dev,
-			 struct mlx5_flow_dv_encap_decap_resource *resource,
-			 bool is_root,
-			 struct mlx5_flow_dv_encap_decap_resource **encap_decap,
-			 struct rte_flow_error *error)
+mlx5_flow_encap_decap_resource_register(struct rte_eth_dev *dev,
+					struct mlx5_flow_dv_encap_decap_resource *resource,
+					bool is_root,
+					struct mlx5_flow_dv_encap_decap_resource **encap_decap,
+					struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_dev_ctx_shared *sh = priv->sh;
@@ -4457,11 +4463,11 @@ __flow_encap_decap_resource_register(struct rte_eth_dev *dev,
 				"encaps_decaps",
 				MLX5_FLOW_ENCAP_DECAP_HTABLE_SZ,
 				true, true, sh,
-				flow_encap_decap_create_cb,
-				flow_encap_decap_match_cb,
-				flow_encap_decap_remove_cb,
-				flow_encap_decap_clone_cb,
-				flow_encap_decap_clone_free_cb,
+				mlx5_flow_encap_decap_create_cb,
+				mlx5_flow_encap_decap_match_cb,
+				mlx5_flow_encap_decap_remove_cb,
+				mlx5_flow_encap_decap_clone_cb,
+				mlx5_flow_encap_decap_clone_free_cb,
 				error);
 	if (unlikely(!encaps_decaps))
 		return -rte_errno;
@@ -4503,8 +4509,8 @@ flow_dv_encap_decap_resource_register
 	int ret;
 
 	resource->flags = dev_flow->dv.group ? 0 : 1;
-	ret = __flow_encap_decap_resource_register(dev, resource, !!dev_flow->dv.group,
-		&dev_flow->dv.encap_decap, error);
+	ret = mlx5_flow_encap_decap_resource_register(dev, resource, !!dev_flow->dv.group,
+						      &dev_flow->dv.encap_decap, error);
 	if (ret)
 		return ret;
 	dev_flow->handle->dvh.rix_encap_decap = dev_flow->dv.encap_decap->idx;
@@ -4544,8 +4550,8 @@ flow_dv_jump_tbl_resource_register
 }
 
 int
-flow_dv_port_id_match_cb(void *tool_ctx __rte_unused,
-			 struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_dv_port_id_match_cb(void *tool_ctx __rte_unused,
+			      struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_port_id_action_resource *ref = ctx->data;
@@ -4556,7 +4562,7 @@ flow_dv_port_id_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_dv_port_id_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_dv_port_id_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -4589,13 +4595,14 @@ flow_dv_port_id_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_dv_port_id_clone_cb(void *tool_ctx,
-			 struct mlx5_list_entry *entry __rte_unused,
-			 void *cb_ctx)
+mlx5_flow_dv_port_id_clone_cb(void *tool_ctx,
+			      struct mlx5_list_entry *entry __rte_unused,
+			      void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_port_id_action_resource *resource;
+	struct mlx5_flow_dv_port_id_action_resource *old_resource;
 	uint32_t idx;
 
 	resource = mlx5_ipool_zmalloc(sh->ipool[MLX5_IPOOL_PORT_ID], &idx);
@@ -4605,13 +4612,14 @@ flow_dv_port_id_clone_cb(void *tool_ctx,
 				   "cannot allocate port_id action memory");
 		return NULL;
 	}
-	memcpy(resource, entry, sizeof(*resource));
+	old_resource = container_of(entry, typeof(*old_resource), entry);
+	memcpy(resource, old_resource, sizeof(*old_resource));
 	resource->idx = idx;
 	return &resource->entry;
 }
 
 void
-flow_dv_port_id_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_port_id_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_port_id_action_resource *resource =
@@ -4660,8 +4668,8 @@ flow_dv_port_id_action_resource_register
 }
 
 int
-flow_dv_push_vlan_match_cb(void *tool_ctx __rte_unused,
-			   struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_dv_push_vlan_match_cb(void *tool_ctx __rte_unused,
+				struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_push_vlan_action_resource *ref = ctx->data;
@@ -4672,7 +4680,7 @@ flow_dv_push_vlan_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_dv_push_vlan_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_dv_push_vlan_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -4711,13 +4719,14 @@ flow_dv_push_vlan_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_dv_push_vlan_clone_cb(void *tool_ctx,
-			   struct mlx5_list_entry *entry __rte_unused,
-			   void *cb_ctx)
+mlx5_flow_dv_push_vlan_clone_cb(void *tool_ctx,
+				struct mlx5_list_entry *entry __rte_unused,
+				void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_push_vlan_action_resource *resource;
+	struct mlx5_flow_dv_push_vlan_action_resource *old_resource;
 	uint32_t idx;
 
 	resource = mlx5_ipool_zmalloc(sh->ipool[MLX5_IPOOL_PUSH_VLAN], &idx);
@@ -4727,13 +4736,14 @@ flow_dv_push_vlan_clone_cb(void *tool_ctx,
 				   "cannot allocate push_vlan action memory");
 		return NULL;
 	}
-	memcpy(resource, entry, sizeof(*resource));
+	old_resource = container_of(entry, typeof(*old_resource), entry);
+	memcpy(resource, old_resource, sizeof(*old_resource));
 	resource->idx = idx;
 	return &resource->entry;
 }
 
 void
-flow_dv_push_vlan_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_push_vlan_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_push_vlan_action_resource *resource =
@@ -4792,7 +4802,7 @@ flow_dv_push_vlan_action_resource_register
  *   sizeof struct item_type, 0 if void or irrelevant.
  */
 size_t
-flow_dv_get_item_hdr_len(const enum rte_flow_item_type item_type)
+mlx5_flow_dv_get_item_hdr_len(const enum rte_flow_item_type item_type)
 {
 	size_t retval;
 
@@ -4858,8 +4868,8 @@ flow_dv_get_item_hdr_len(const enum rte_flow_item_type item_type)
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_dv_convert_encap_data(const struct rte_flow_item *items, uint8_t *buf,
-			   size_t *size, struct rte_flow_error *error)
+mlx5_flow_dv_convert_encap_data(const struct rte_flow_item *items, uint8_t *buf,
+				size_t *size, struct rte_flow_error *error)
 {
 	struct rte_ether_hdr *eth = NULL;
 	struct rte_vlan_hdr *vlan = NULL;
@@ -4877,7 +4887,7 @@ flow_dv_convert_encap_data(const struct rte_flow_item *items, uint8_t *buf,
 					  RTE_FLOW_ERROR_TYPE_ACTION,
 					  NULL, "invalid empty data");
 	for (; items->type != RTE_FLOW_ITEM_TYPE_END; items++) {
-		len = flow_dv_get_item_hdr_len(items->type);
+		len = mlx5_flow_dv_get_item_hdr_len(items->type);
 		if (len + temp_size > MLX5_ENCAP_MAX_LEN)
 			return rte_flow_error_set(error, EINVAL,
 						  RTE_FLOW_ERROR_TYPE_ACTION,
@@ -5108,8 +5118,8 @@ flow_dv_create_action_l2_encap(struct rte_eth_dev *dev,
 			encap_data =
 				((const struct rte_flow_action_nvgre_encap *)
 						action->conf)->definition;
-		if (flow_dv_convert_encap_data(encap_data, res.buf,
-					       &res.size, error))
+		if (mlx5_flow_dv_convert_encap_data(encap_data, res.buf,
+						    &res.size, error))
 			return -rte_errno;
 	}
 	if (flow_dv_zero_encap_udp_csum(res.buf, error))
@@ -5621,7 +5631,7 @@ flow_dv_validate_action_modify_field(struct rte_eth_dev *dev,
 			return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
 					"destination offset is too big");
-		ret = flow_validate_modify_field_level(dst_data, error);
+		ret = mlx5_flow_validate_modify_field_level(dst_data, error);
 		if (ret)
 			return ret;
 		if (dst_data->tag_index &&
@@ -5652,7 +5662,7 @@ flow_dv_validate_action_modify_field(struct rte_eth_dev *dev,
 			return rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, action,
 					"source offset is too big");
-		ret = flow_validate_modify_field_level(src_data, error);
+		ret = mlx5_flow_validate_modify_field_level(src_data, error);
 		if (ret)
 			return ret;
 		if (src_data->tag_index &&
@@ -6194,8 +6204,8 @@ flow_dv_validate_action_modify_ipv6_dscp(const uint64_t action_flags,
 }
 
 int
-flow_modify_match_cb(void *tool_ctx __rte_unused,
-			struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_modify_match_cb(void *tool_ctx __rte_unused,
+			  struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_modify_hdr_resource *ref = ctx->data;
@@ -6250,7 +6260,7 @@ flow_dv_modify_ipool_get(struct mlx5_dev_ctx_shared *sh, uint8_t index)
 }
 
 struct mlx5_list_entry *
-flow_modify_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_modify_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -6317,8 +6327,8 @@ flow_modify_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_modify_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
-			void *cb_ctx)
+mlx5_flow_modify_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+			  void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -6341,7 +6351,7 @@ flow_modify_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 }
 
 void
-flow_modify_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_modify_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_modify_hdr_resource *res =
@@ -6610,10 +6620,10 @@ flow_dv_validate_action_sample(uint64_t *action_flags,
 }
 
 int
-__flow_modify_hdr_resource_register(struct rte_eth_dev *dev,
-			struct mlx5_flow_dv_modify_hdr_resource *resource,
-			struct mlx5_flow_dv_modify_hdr_resource **modify,
-			struct rte_flow_error *error)
+mlx5_flow_modify_hdr_resource_register(struct rte_eth_dev *dev,
+				       struct mlx5_flow_dv_modify_hdr_resource *resource,
+				       struct mlx5_flow_dv_modify_hdr_resource **modify,
+				       struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_dev_ctx_shared *sh = priv->sh;
@@ -6633,11 +6643,11 @@ __flow_modify_hdr_resource_register(struct rte_eth_dev *dev,
 				"hdr_modify",
 				MLX5_FLOW_HDR_MODIFY_HTABLE_SZ,
 				true, false, sh,
-				flow_modify_create_cb,
-				flow_modify_match_cb,
-				flow_modify_remove_cb,
-				flow_modify_clone_cb,
-				flow_modify_clone_free_cb,
+				mlx5_flow_modify_create_cb,
+				mlx5_flow_modify_match_cb,
+				mlx5_flow_modify_remove_cb,
+				mlx5_flow_modify_clone_cb,
+				mlx5_flow_modify_clone_free_cb,
 				error);
 	if (unlikely(!modify_cmds))
 		return -rte_errno;
@@ -6677,8 +6687,8 @@ flow_dv_modify_hdr_resource_register
 			 struct rte_flow_error *error)
 {
 	resource->root = !dev_flow->dv.group;
-	return __flow_modify_hdr_resource_register(dev, resource,
-		&dev_flow->handle->dvh.modify_hdr, error);
+	return mlx5_flow_modify_hdr_resource_register(dev, resource,
+						      &dev_flow->handle->dvh.modify_hdr, error);
 }
 
 /**
@@ -7753,10 +7763,10 @@ const struct rte_flow_item_tcp nic_tcp_mask = {
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		 const struct rte_flow_item items[],
-		 const struct rte_flow_action actions[],
-		 bool external, int hairpin, struct rte_flow_error *error)
+mlx5_flow_dv_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		      const struct rte_flow_item items[],
+		      const struct rte_flow_action actions[],
+		      bool external, int hairpin, struct rte_flow_error *error)
 {
 	int ret;
 	uint64_t aso_mask, action_flags = 0;
@@ -11709,11 +11719,12 @@ __flow_dv_adjust_buf_size(size_t *size, uint8_t match_criteria)
 }
 
 struct mlx5_list_entry *
-flow_matcher_clone_cb(void *tool_ctx __rte_unused,
-			 struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_matcher_clone_cb(void *tool_ctx __rte_unused,
+			   struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_matcher *ref = ctx->data;
+	struct mlx5_flow_dv_matcher *old_resource;
 	struct mlx5_flow_tbl_data_entry *tbl = container_of(ref->tbl,
 							    typeof(*tbl), tbl);
 	struct mlx5_flow_dv_matcher *resource = mlx5_malloc(MLX5_MEM_ANY,
@@ -11726,20 +11737,21 @@ flow_matcher_clone_cb(void *tool_ctx __rte_unused,
 				   "cannot create matcher");
 		return NULL;
 	}
-	memcpy(resource, entry, sizeof(*resource));
+	old_resource = container_of(entry, typeof(*old_resource), entry);
+	memcpy(resource, old_resource, sizeof(*resource));
 	resource->tbl = &tbl->tbl;
 	return &resource->entry;
 }
 
 void
-flow_matcher_clone_free_cb(void *tool_ctx __rte_unused,
-			     struct mlx5_list_entry *entry)
+mlx5_flow_matcher_clone_free_cb(void *tool_ctx __rte_unused,
+				struct mlx5_list_entry *entry)
 {
 	mlx5_free(entry);
 }
 
 struct mlx5_list_entry *
-flow_dv_tbl_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_dv_tbl_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -11805,11 +11817,11 @@ flow_dv_tbl_create_cb(void *tool_ctx, void *cb_ctx)
 	      key.is_fdb ? "FDB" : "NIC", key.is_egress ? "egress" : "ingress",
 	      key.level, key.id);
 	tbl_data->matchers = mlx5_list_create(matcher_name, sh, true,
-					      flow_matcher_create_cb,
-					      flow_matcher_match_cb,
-					      flow_matcher_remove_cb,
-					      flow_matcher_clone_cb,
-					      flow_matcher_clone_free_cb);
+					      mlx5_flow_matcher_create_cb,
+					      mlx5_flow_matcher_match_cb,
+					      mlx5_flow_matcher_remove_cb,
+					      mlx5_flow_matcher_clone_cb,
+					      mlx5_flow_matcher_clone_free_cb);
 	if (!tbl_data->matchers) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -11824,8 +11836,8 @@ flow_dv_tbl_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 int
-flow_dv_tbl_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
-		     void *cb_ctx)
+mlx5_flow_dv_tbl_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
+			  void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_tbl_data_entry *tbl_data =
@@ -11840,14 +11852,15 @@ flow_dv_tbl_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
 }
 
 struct mlx5_list_entry *
-flow_dv_tbl_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
-		      void *cb_ctx)
+mlx5_flow_dv_tbl_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+			  void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_tbl_data_entry *tbl_data;
 	struct rte_flow_error *error = ctx->error;
 	uint32_t idx = 0;
+	struct mlx5_flow_tbl_data_entry *old_resource;
 
 	tbl_data = mlx5_ipool_malloc(sh->ipool[MLX5_IPOOL_JUMP], &idx);
 	if (!tbl_data) {
@@ -11857,13 +11870,14 @@ flow_dv_tbl_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 				   "cannot allocate flow table data entry");
 		return NULL;
 	}
-	memcpy(tbl_data, oentry, sizeof(*tbl_data));
+	old_resource = container_of(oentry, typeof(*old_resource), entry);
+	memcpy(tbl_data, old_resource, sizeof(*tbl_data));
 	tbl_data->idx = idx;
 	return &tbl_data->entry;
 }
 
 void
-flow_dv_tbl_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_tbl_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_tbl_data_entry *tbl_data =
@@ -11894,14 +11908,14 @@ flow_dv_tbl_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
  *   Returns tables resource based on the index, NULL in case of failed.
  */
 struct mlx5_flow_tbl_resource *
-flow_dv_tbl_resource_get(struct rte_eth_dev *dev,
-			 uint32_t table_level, uint8_t egress,
-			 uint8_t transfer,
-			 bool external,
-			 const struct mlx5_flow_tunnel *tunnel,
-			 uint32_t group_id, uint8_t dummy,
-			 uint32_t table_id,
-			 struct rte_flow_error *error)
+mlx5_flow_dv_tbl_resource_get(struct rte_eth_dev *dev,
+			      uint32_t table_level, uint8_t egress,
+			      uint8_t transfer,
+			      bool external,
+			      const struct mlx5_flow_tunnel *tunnel,
+			      uint32_t group_id, uint8_t dummy,
+			      uint32_t table_id,
+			      struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	union mlx5_flow_tbl_key table_key = {
@@ -11944,7 +11958,7 @@ flow_dv_tbl_resource_get(struct rte_eth_dev *dev,
 }
 
 void
-flow_dv_tbl_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_tbl_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_tbl_data_entry *tbl_data =
@@ -12000,8 +12014,8 @@ flow_dv_tbl_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
  *   Returns 0 if table was released, else return 1;
  */
 int
-flow_dv_tbl_resource_release(struct mlx5_dev_ctx_shared *sh,
-			     struct mlx5_flow_tbl_resource *tbl)
+mlx5_flow_dv_tbl_resource_release(struct mlx5_dev_ctx_shared *sh,
+				  struct mlx5_flow_tbl_resource *tbl)
 {
 	struct mlx5_flow_tbl_data_entry *tbl_data =
 		container_of(tbl, struct mlx5_flow_tbl_data_entry, tbl);
@@ -12012,7 +12026,7 @@ flow_dv_tbl_resource_release(struct mlx5_dev_ctx_shared *sh,
 }
 
 int
-flow_matcher_match_cb(void *tool_ctx __rte_unused,
+mlx5_flow_matcher_match_cb(void *tool_ctx __rte_unused,
 			 struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -12027,7 +12041,7 @@ flow_matcher_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_matcher_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_matcher_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -12074,18 +12088,20 @@ flow_matcher_create_cb(void *tool_ctx, void *cb_ctx)
 	} else {
 #ifdef HAVE_MLX5_HWS_SUPPORT
 		items = *((const struct rte_flow_item **)(ctx->data2));
+		if (!items)
+			goto error;
 		resource->matcher_object = mlx5dr_bwc_matcher_create
 				(resource->group->tbl, resource->priority, items);
-		if (!resource->matcher_object) {
-			mlx5_free(resource);
-			return NULL;
-		}
+		if (!resource->matcher_object)
+			goto error;
 #else
-		mlx5_free(resource);
-		return NULL;
+		goto error;
 #endif
 	}
 	return &resource->entry;
+error:
+	mlx5_free(resource);
+	return NULL;
 }
 
 /**
@@ -12126,17 +12142,17 @@ flow_dv_matcher_register(struct rte_eth_dev *dev,
 	 * tunnel offload API requires this registration for cases when
 	 * tunnel match rule was inserted before tunnel set rule.
 	 */
-	tbl = flow_dv_tbl_resource_get(dev, key->level,
-				       key->is_egress, key->is_fdb,
-				       dev_flow->external, tunnel,
-				       group_id, 0, key->id, error);
+	tbl = mlx5_flow_dv_tbl_resource_get(dev, key->level,
+					    key->is_egress, key->is_fdb,
+					    dev_flow->external, tunnel,
+					    group_id, 0, key->id, error);
 	if (!tbl)
 		return -rte_errno;	/* No need to refill the error info */
 	tbl_data = container_of(tbl, struct mlx5_flow_tbl_data_entry, tbl);
 	ref->tbl = tbl;
 	entry = mlx5_list_register(tbl_data->matchers, &ctx);
 	if (!entry) {
-		flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 					  "cannot allocate ref memory");
@@ -12147,7 +12163,7 @@ flow_dv_matcher_register(struct rte_eth_dev *dev,
 }
 
 struct mlx5_list_entry *
-flow_dv_tag_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_dv_tag_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -12177,7 +12193,7 @@ flow_dv_tag_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 int
-flow_dv_tag_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
+mlx5_flow_dv_tag_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
 		     void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -12188,12 +12204,13 @@ flow_dv_tag_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
 }
 
 struct mlx5_list_entry *
-flow_dv_tag_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+mlx5_flow_dv_tag_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 		     void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_tag_resource *entry;
+	struct mlx5_flow_dv_tag_resource *old_entry;
 	uint32_t idx = 0;
 
 	entry = mlx5_ipool_malloc(sh->ipool[MLX5_IPOOL_TAG], &idx);
@@ -12203,13 +12220,14 @@ flow_dv_tag_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 				   "cannot allocate tag resource memory");
 		return NULL;
 	}
-	memcpy(entry, oentry, sizeof(*entry));
+	old_entry = container_of(oentry, typeof(*old_entry), entry);
+	memcpy(entry, old_entry, sizeof(*entry));
 	entry->idx = idx;
 	return &entry->entry;
 }
 
 void
-flow_dv_tag_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_tag_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_tag_resource *tag =
@@ -12253,11 +12271,11 @@ flow_dv_tag_resource_register
 				      "tags",
 				      MLX5_TAGS_HLIST_ARRAY_SIZE,
 				      false, false, priv->sh,
-				      flow_dv_tag_create_cb,
-				      flow_dv_tag_match_cb,
-				      flow_dv_tag_remove_cb,
-				      flow_dv_tag_clone_cb,
-				      flow_dv_tag_clone_free_cb,
+				      mlx5_flow_dv_tag_create_cb,
+				      mlx5_flow_dv_tag_match_cb,
+				      mlx5_flow_dv_tag_remove_cb,
+				      mlx5_flow_dv_tag_clone_cb,
+				      mlx5_flow_dv_tag_clone_free_cb,
 				      error);
 	if (unlikely(!tag_table))
 		return -rte_errno;
@@ -12273,7 +12291,7 @@ flow_dv_tag_resource_register
 }
 
 void
-flow_dv_tag_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_tag_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_tag_resource *tag =
@@ -12513,9 +12531,9 @@ flow_dv_translate_item_sq(void *key,
  *   Pointer to the RSS hash fields.
  */
 void
-flow_dv_hashfields_set(uint64_t item_flags,
-		       struct mlx5_flow_rss_desc *rss_desc,
-		       uint64_t *hash_fields)
+mlx5_flow_dv_hashfields_set(uint64_t item_flags,
+			    struct mlx5_flow_rss_desc *rss_desc,
+			    uint64_t *hash_fields)
 {
 	uint64_t items = item_flags;
 	uint64_t fields = 0;
@@ -12642,8 +12660,7 @@ flow_dv_sample_sub_actions_release(struct rte_eth_dev *dev,
 		act_res->rix_hrxq = 0;
 	}
 	if (act_res->rix_encap_decap) {
-		flow_encap_decap_resource_release(dev,
-						     act_res->rix_encap_decap);
+		mlx5_flow_encap_decap_resource_release(dev, act_res->rix_encap_decap);
 		act_res->rix_encap_decap = 0;
 	}
 	if (act_res->rix_port_id_action) {
@@ -12662,8 +12679,8 @@ flow_dv_sample_sub_actions_release(struct rte_eth_dev *dev,
 }
 
 int
-flow_dv_sample_match_cb(void *tool_ctx __rte_unused,
-			struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_dv_sample_match_cb(void *tool_ctx __rte_unused,
+			     struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
@@ -12691,7 +12708,7 @@ flow_dv_sample_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_dv_sample_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
+mlx5_flow_dv_sample_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
@@ -12724,9 +12741,9 @@ flow_dv_sample_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 		is_transfer = 1;
 	else if (ctx_resource->ft_type == MLX5DV_FLOW_TABLE_TYPE_NIC_TX)
 		is_egress = 1;
-	tbl = flow_dv_tbl_resource_get(dev, next_ft_id,
-					is_egress, is_transfer,
-					true, NULL, 0, 0, 0, error);
+	tbl = mlx5_flow_dv_tbl_resource_get(dev, next_ft_id,
+					    is_egress, is_transfer,
+					    true, NULL, 0, 0, 0, error);
 	if (!tbl) {
 		rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -12770,21 +12787,21 @@ flow_dv_sample_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 		flow_dv_sample_sub_actions_release(dev,
 						   &resource->sample_idx);
 	if (resource->normal_path_tbl)
-		flow_dv_tbl_resource_release(MLX5_SH(dev),
-				resource->normal_path_tbl);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), resource->normal_path_tbl);
 	mlx5_ipool_free(sh->ipool[MLX5_IPOOL_SAMPLE], idx);
 	return NULL;
 
 }
 
 struct mlx5_list_entry *
-flow_dv_sample_clone_cb(void *tool_ctx __rte_unused,
-			 struct mlx5_list_entry *entry __rte_unused,
-			 void *cb_ctx)
+mlx5_flow_dv_sample_clone_cb(void *tool_ctx __rte_unused,
+			     struct mlx5_list_entry *entry __rte_unused,
+			     void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
 	struct mlx5_flow_dv_sample_resource *resource;
+	struct mlx5_flow_dv_sample_resource *old_resource;
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_dev_ctx_shared *sh = priv->sh;
 	uint32_t idx = 0;
@@ -12792,20 +12809,21 @@ flow_dv_sample_clone_cb(void *tool_ctx __rte_unused,
 	resource = mlx5_ipool_zmalloc(sh->ipool[MLX5_IPOOL_SAMPLE], &idx);
 	if (!resource) {
 		rte_flow_error_set(ctx->error, ENOMEM,
-					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-					  NULL,
-					  "cannot allocate resource memory");
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				   NULL,
+				   "cannot allocate resource memory");
 		return NULL;
 	}
-	memcpy(resource, entry, sizeof(*resource));
+	old_resource = container_of(entry, typeof(*old_resource), entry);
+	memcpy(resource, old_resource, sizeof(*resource));
 	resource->idx = idx;
 	resource->dev = dev;
 	return &resource->entry;
 }
 
 void
-flow_dv_sample_clone_free_cb(void *tool_ctx __rte_unused,
-			     struct mlx5_list_entry *entry)
+mlx5_flow_dv_sample_clone_free_cb(void *tool_ctx __rte_unused,
+				  struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_sample_resource *resource =
 				  container_of(entry, typeof(*resource), entry);
@@ -12855,8 +12873,8 @@ flow_dv_sample_resource_register(struct rte_eth_dev *dev,
 }
 
 int
-flow_dv_dest_array_match_cb(void *tool_ctx __rte_unused,
-			    struct mlx5_list_entry *entry, void *cb_ctx)
+mlx5_flow_dv_dest_array_match_cb(void *tool_ctx __rte_unused,
+				 struct mlx5_list_entry *entry, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_dv_dest_array_resource *ctx_resource = ctx->data;
@@ -12884,7 +12902,7 @@ flow_dv_dest_array_match_cb(void *tool_ctx __rte_unused,
 }
 
 struct mlx5_list_entry *
-flow_dv_dest_array_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
+mlx5_flow_dv_dest_array_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
@@ -12989,9 +13007,9 @@ flow_dv_dest_array_create_cb(void *tool_ctx __rte_unused, void *cb_ctx)
 }
 
 struct mlx5_list_entry *
-flow_dv_dest_array_clone_cb(void *tool_ctx __rte_unused,
-			    struct mlx5_list_entry *entry __rte_unused,
-			    void *cb_ctx)
+mlx5_flow_dv_dest_array_clone_cb(void *tool_ctx __rte_unused,
+				 struct mlx5_list_entry *entry __rte_unused,
+				 void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct rte_eth_dev *dev = ctx->dev;
@@ -13017,8 +13035,8 @@ flow_dv_dest_array_clone_cb(void *tool_ctx __rte_unused,
 }
 
 void
-flow_dv_dest_array_clone_free_cb(void *tool_ctx __rte_unused,
-				 struct mlx5_list_entry *entry)
+mlx5_flow_dv_dest_array_clone_free_cb(void *tool_ctx __rte_unused,
+				      struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_dest_array_resource *resource =
 			container_of(entry, typeof(*resource), entry);
@@ -13163,15 +13181,15 @@ flow_dv_translate_action_sample(struct rte_eth_dev *dev,
 			       rss->queue_num * sizeof(uint16_t));
 			rss_desc->queue_num = rss->queue_num;
 			/* NULL RSS key indicates default RSS key. */
-			rss_key = !rss->key ? rss_hash_default_key : rss->key;
+			rss_key = !rss->key ? mlx5_rss_hash_default_key : rss->key;
 			memcpy(rss_desc->key, rss_key, MLX5_RSS_HASH_KEY_LEN);
 			/*
 			 * rss->level and rss.types should be set in advance
 			 * when expanding items for RSS.
 			 */
-			flow_dv_hashfields_set(dev_flow->handle->layers,
-					       rss_desc,
-					       &dev_flow->hash_fields);
+			mlx5_flow_dv_hashfields_set(dev_flow->handle->layers,
+						    rss_desc,
+						    &dev_flow->hash_fields);
 			hrxq = flow_dv_hrxq_prepare(dev, dev_flow,
 						    rss_desc, &hrxq_idx);
 			if (!hrxq)
@@ -13353,8 +13371,8 @@ flow_dv_translate_action_send_to_kernel(struct rte_eth_dev *dev,
 				   "required priority is not available");
 		return NULL;
 	}
-	tbl = flow_dv_tbl_resource_get(dev, 0, attr->egress, attr->transfer, false, NULL, 0, 0, 0,
-				       error);
+	tbl = mlx5_flow_dv_tbl_resource_get(dev, 0, attr->egress, attr->transfer,
+					    false, NULL, 0, 0, 0, error);
 	if (!tbl) {
 		rte_flow_error_set(error, ENODATA,
 				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
@@ -13374,7 +13392,7 @@ flow_dv_translate_action_send_to_kernel(struct rte_eth_dev *dev,
 	sh->send_to_kernel_action[ft_type].tbl = tbl;
 	return action;
 err:
-	flow_dv_tbl_resource_release(sh, tbl);
+	mlx5_flow_dv_tbl_resource_release(sh, tbl);
 	return NULL;
 }
 
@@ -13541,7 +13559,7 @@ flow_dv_aso_age_release(struct rte_eth_dev *dev, uint32_t age_idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_aso_age_mng *mng = priv->sh->aso_age_mng;
-	struct mlx5_aso_age_action *age = flow_aso_age_get_by_idx(dev, age_idx);
+	struct mlx5_aso_age_action *age = mlx5_flow_aso_age_get_by_idx(dev, age_idx);
 	uint32_t ret = rte_atomic_fetch_sub_explicit(&age->refcnt, 1, rte_memory_order_relaxed) - 1;
 
 	if (!ret) {
@@ -13743,7 +13761,7 @@ flow_dv_aso_age_params_init(struct rte_eth_dev *dev,
 {
 	struct mlx5_aso_age_action *aso_age;
 
-	aso_age = flow_aso_age_get_by_idx(dev, age_idx);
+	aso_age = mlx5_flow_aso_age_get_by_idx(dev, age_idx);
 	MLX5_ASSERT(aso_age);
 	aso_age->age_params.context = context;
 	aso_age->age_params.timeout = timeout;
@@ -14647,12 +14665,12 @@ flow_dv_translate_items_nta(struct rte_eth_dev *dev,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-__flow_dv_translate_items_hws(const struct rte_flow_item *items,
-			    struct mlx5_flow_attr *attr, void *key,
-			    uint32_t key_type, uint64_t *item_flags,
-			    uint8_t *match_criteria,
-			    bool nt_flow,
-			    struct rte_flow_error *error)
+mlx5_flow_dv_translate_items_hws_impl(const struct rte_flow_item *items,
+				      struct mlx5_flow_attr *attr, void *key,
+				      uint32_t key_type, uint64_t *item_flags,
+				      uint8_t *match_criteria,
+				      bool nt_flow,
+				      struct rte_flow_error *error)
 {
 	struct mlx5_flow_workspace *flow_wks = mlx5_flow_push_thread_workspace();
 	struct mlx5_flow_rss_desc rss_desc = { .level = attr->rss_level };
@@ -14702,28 +14720,31 @@ __flow_dv_translate_items_hws(const struct rte_flow_item *items,
 						      key_type);
 	}
 	if (wks.item_flags & MLX5_FLOW_LAYER_VXLAN_GPE) {
-		flow_dv_translate_item_vxlan_gpe(key,
-						 wks.tunnel_item,
-						 wks.item_flags,
-						 key_type);
+		if (wks.tunnel_item)
+			flow_dv_translate_item_vxlan_gpe(key,
+							 wks.tunnel_item,
+							 wks.item_flags,
+							 key_type);
 	} else if (wks.item_flags & MLX5_FLOW_LAYER_GENEVE) {
-		flow_dv_translate_item_geneve(key,
-					      wks.tunnel_item,
-					      wks.item_flags,
-					      key_type);
+		if (wks.tunnel_item)
+			flow_dv_translate_item_geneve(key,
+						      wks.tunnel_item,
+						      wks.item_flags,
+						      key_type);
 	} else if (wks.item_flags & MLX5_FLOW_LAYER_GRE) {
-		if (wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_GRE) {
+		if (wks.tunnel_item && wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_GRE) {
 			flow_dv_translate_item_gre(key,
 						   wks.tunnel_item,
 						   wks.item_flags,
 						   key_type);
-		} else if (wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_GRE_OPTION) {
+		} else if (wks.tunnel_item &&
+			   wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_GRE_OPTION) {
 			flow_dv_translate_item_gre_option(key,
 							  wks.tunnel_item,
 							  wks.gre_item,
 							  wks.item_flags,
 							  key_type);
-		} else if (wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_NVGRE) {
+		} else if (wks.tunnel_item && wks.tunnel_item->type == RTE_FLOW_ITEM_TYPE_NVGRE) {
 			flow_dv_translate_item_nvgre(key,
 						     wks.tunnel_item,
 						     wks.item_flags,
@@ -14763,14 +14784,14 @@ __flow_dv_translate_items_hws(const struct rte_flow_item *items,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_dv_translate_items_hws(const struct rte_flow_item *items,
-			    struct mlx5_flow_attr *attr, void *key,
-			    uint32_t key_type, uint64_t *item_flags,
-			    uint8_t *match_criteria,
-			    struct rte_flow_error *error)
+mlx5_flow_dv_translate_items_hws(const struct rte_flow_item *items,
+				 struct mlx5_flow_attr *attr, void *key,
+				 uint32_t key_type, uint64_t *item_flags,
+				 uint8_t *match_criteria,
+				 struct rte_flow_error *error)
 {
-	return __flow_dv_translate_items_hws(items, attr, key, key_type, item_flags, match_criteria,
-					     false, error);
+	return mlx5_flow_dv_translate_items_hws_impl(items, attr, key, key_type, item_flags,
+						     match_criteria, false, error);
 }
 
 /**
@@ -15252,7 +15273,7 @@ flow_dv_translate(struct rte_eth_dev *dev,
 			       rss->queue_num * sizeof(uint16_t));
 			rss_desc->queue_num = rss->queue_num;
 			/* NULL RSS key indicates default RSS key. */
-			rss_key = !rss->key ? rss_hash_default_key : rss->key;
+			rss_key = !rss->key ? mlx5_rss_hash_default_key : rss->key;
 			memcpy(rss_desc->key, rss_key, MLX5_RSS_HASH_KEY_LEN);
 			/*
 			 * rss->level and rss.types should be set in advance
@@ -15265,7 +15286,7 @@ flow_dv_translate(struct rte_eth_dev *dev,
 			break;
 		case MLX5_RTE_FLOW_ACTION_TYPE_AGE:
 			owner_idx = (uint32_t)(uintptr_t)action->conf;
-			age_act = flow_aso_age_get_by_idx(dev, owner_idx);
+			age_act = mlx5_flow_aso_age_get_by_idx(dev, owner_idx);
 			if (flow->age == 0) {
 				flow->age = owner_idx;
 				rte_atomic_fetch_add_explicit(&age_act->refcnt, 1,
@@ -15450,11 +15471,11 @@ flow_dv_translate(struct rte_eth_dev *dev,
 						       &grp_info, error);
 			if (ret)
 				return ret;
-			tbl = flow_dv_tbl_resource_get(dev, table, attr->egress,
-						       attr->transfer,
-						       !!dev_flow->external,
-						       tunnel, jump_group, 0,
-						       0, error);
+			tbl = mlx5_flow_dv_tbl_resource_get(dev, table, attr->egress,
+							    attr->transfer,
+							    dev_flow->external,
+							    tunnel, jump_group, 0,
+							    0, error);
 			if (!tbl)
 				return rte_flow_error_set
 						(error, errno,
@@ -15463,7 +15484,7 @@ flow_dv_translate(struct rte_eth_dev *dev,
 						 "cannot create jump action.");
 			if (flow_dv_jump_tbl_resource_register
 			    (dev, tbl, dev_flow, error)) {
-				flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
+				mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
 				return rte_flow_error_set
 						(error, errno,
 						 RTE_FLOW_ERROR_TYPE_ACTION,
@@ -15688,8 +15709,7 @@ flow_dv_translate(struct rte_eth_dev *dev,
 						     (dev_flow->flow_idx),
 						     non_shared_age->timeout);
 				}
-				age_act = flow_aso_age_get_by_idx(dev,
-								  flow->age);
+				age_act = mlx5_flow_aso_age_get_by_idx(dev, flow->age);
 				dev_flow->dv.actions[age_act_pos] =
 							     age_act->dr_action;
 			}
@@ -15720,9 +15740,9 @@ flow_dv_translate(struct rte_eth_dev *dev,
 		return -rte_errno;
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		dev_flow->symmetric_hash_function = rss_desc->symmetric_hash_function;
-		flow_dv_hashfields_set(dev_flow->handle->layers,
-				       rss_desc,
-				       &dev_flow->hash_fields);
+		mlx5_flow_dv_hashfields_set(dev_flow->handle->layers,
+					    rss_desc,
+					    &dev_flow->hash_fields);
 	}
 	/* If has RSS action in the sample action, the Sample/Mirror resource
 	 * should be registered after the hash filed be update.
@@ -16019,16 +16039,23 @@ __flow_dv_action_rss_hrxq_set(struct mlx5_shared_action_rss *action,
  *   Valid hash RX queue index, otherwise 0.
  */
 uint32_t
-flow_dv_action_rss_hrxq_lookup(struct rte_eth_dev *dev, uint32_t idx,
-			       const uint64_t hash_fields)
+mlx5_flow_dv_action_rss_hrxq_lookup(struct rte_eth_dev *dev, uint32_t idx,
+				    const uint64_t hash_fields)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_shared_action_rss *shared_rss =
 	    mlx5_ipool_get(priv->sh->ipool[MLX5_IPOOL_RSS_SHARED_ACTIONS], idx);
-	const uint32_t *hrxqs = shared_rss->hrxq;
+	const uint32_t *hrxqs;
 	uint32_t selectors = 0;
 	int ret;
 
+	if (!shared_rss) {
+		DRV_LOG(ERR, "port %u cannot get RSS action: rss_act_idx=%u",
+			dev->data->port_id, idx);
+		return 0;
+	}
+	hrxqs = shared_rss->hrxq;
+
 	ret = rx_hash_calc_selector(hash_fields, &selectors);
 	if (ret < 0) {
 		DRV_LOG(ERR, "port %u Rx hash selector calculation failed: "
@@ -16124,9 +16151,9 @@ flow_dv_apply(struct rte_eth_dev *dev, struct rte_flow *flow,
 			struct mlx5_hrxq *hrxq = NULL;
 			uint32_t hrxq_idx;
 
-			hrxq_idx = flow_dv_action_rss_hrxq_lookup(dev,
-						rss_desc->shared_rss,
-						dev_flow->hash_fields);
+			hrxq_idx = mlx5_flow_dv_action_rss_hrxq_lookup(dev,
+								       rss_desc->shared_rss,
+								       dev_flow->hash_fields);
 			if (hrxq_idx)
 				hrxq = mlx5_ipool_get
 					(priv->sh->ipool[MLX5_IPOOL_HRXQ],
@@ -16198,8 +16225,8 @@ flow_dv_apply(struct rte_eth_dev *dev, struct rte_flow *flow,
 }
 
 void
-flow_matcher_remove_cb(void *tool_ctx __rte_unused,
-			  struct mlx5_list_entry *entry)
+mlx5_flow_matcher_remove_cb(void *tool_ctx __rte_unused,
+			    struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_matcher *resource = container_of(entry,
 							     typeof(*resource),
@@ -16238,12 +16265,12 @@ flow_dv_matcher_release(struct rte_eth_dev *dev,
 
 	MLX5_ASSERT(matcher->matcher_object);
 	ret = mlx5_list_unregister(tbl->matchers, &matcher->entry);
-	flow_dv_tbl_resource_release(MLX5_SH(dev), &tbl->tbl);
+	mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), &tbl->tbl);
 	return ret;
 }
 
 void
-flow_encap_decap_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_encap_decap_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_encap_decap_resource *res =
@@ -16270,8 +16297,8 @@ flow_encap_decap_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
  *   1 while a reference on it exists, 0 when freed.
  */
 int
-flow_encap_decap_resource_release(struct rte_eth_dev *dev,
-				     uint32_t encap_decap_idx)
+mlx5_flow_encap_decap_resource_release(struct rte_eth_dev *dev,
+				       uint32_t encap_decap_idx)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_dv_encap_decap_resource *resource;
@@ -16306,11 +16333,11 @@ flow_dv_jump_tbl_resource_release(struct rte_eth_dev *dev,
 				  rix_jump);
 	if (!tbl_data)
 		return 0;
-	return flow_dv_tbl_resource_release(MLX5_SH(dev), &tbl_data->tbl);
+	return mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), &tbl_data->tbl);
 }
 
 void
-flow_modify_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_modify_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_modify_hdr_resource *res =
 		container_of(entry, typeof(*res), entry);
@@ -16348,7 +16375,7 @@ flow_dv_modify_hdr_resource_release(struct rte_eth_dev *dev,
 }
 
 void
-flow_dv_port_id_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_port_id_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_port_id_action_resource *resource =
@@ -16404,7 +16431,7 @@ flow_dv_shared_rss_action_release(struct rte_eth_dev *dev, uint32_t srss)
 }
 
 void
-flow_dv_push_vlan_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_dv_push_vlan_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_dv_push_vlan_action_resource *resource =
@@ -16464,8 +16491,7 @@ flow_dv_fate_resource_release(struct rte_eth_dev *dev,
 		flow_dv_jump_tbl_resource_release(dev, handle->rix_jump);
 		break;
 	case MLX5_FLOW_FATE_PORT_ID:
-		flow_dv_port_id_action_resource_release(dev,
-				handle->rix_port_id_action);
+		flow_dv_port_id_action_resource_release(dev, handle->rix_port_id_action);
 		break;
 	case MLX5_FLOW_FATE_SEND_TO_KERNEL:
 		/* In case of send_to_kernel action the actual release of
@@ -16481,7 +16507,7 @@ flow_dv_fate_resource_release(struct rte_eth_dev *dev,
 }
 
 void
-flow_dv_sample_remove_cb(void *tool_ctx __rte_unused,
+mlx5_flow_dv_sample_remove_cb(void *tool_ctx __rte_unused,
 			 struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_sample_resource *resource = container_of(entry,
@@ -16494,8 +16520,7 @@ flow_dv_sample_remove_cb(void *tool_ctx __rte_unused,
 		claim_zero(mlx5_flow_os_destroy_flow_action
 						      (resource->verbs_action));
 	if (resource->normal_path_tbl)
-		flow_dv_tbl_resource_release(MLX5_SH(dev),
-					     resource->normal_path_tbl);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), resource->normal_path_tbl);
 	flow_dv_sample_sub_actions_release(dev, &resource->sample_idx);
 	mlx5_ipool_free(priv->sh->ipool[MLX5_IPOOL_SAMPLE], resource->idx);
 	DRV_LOG(DEBUG, "sample resource %p: removed", (void *)resource);
@@ -16529,7 +16554,7 @@ flow_dv_sample_resource_release(struct rte_eth_dev *dev,
 }
 
 void
-flow_dv_dest_array_remove_cb(void *tool_ctx __rte_unused,
+mlx5_flow_dv_dest_array_remove_cb(void *tool_ctx __rte_unused,
 			     struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_dv_dest_array_resource *resource =
@@ -16655,7 +16680,7 @@ flow_dv_destroy(struct rte_eth_dev *dev, struct rte_flow *flow)
 		flow->counter = 0;
 	}
 	if (flow->meter) {
-		fm = flow_dv_meter_find_by_idx(priv, flow->meter);
+		fm = mlx5_flow_dv_meter_find_by_idx(priv, flow->meter);
 		if (fm)
 			mlx5_flow_meter_detach(priv, fm);
 		flow->meter = 0;
@@ -16690,8 +16715,8 @@ flow_dv_destroy(struct rte_eth_dev *dev, struct rte_flow *flow)
 		if (dev_handle->dvh.rix_dest_array)
 			flow_dv_dest_array_resource_release(dev, dev_handle);
 		if (dev_handle->dvh.rix_encap_decap)
-			flow_encap_decap_resource_release(dev,
-				dev_handle->dvh.rix_encap_decap);
+			mlx5_flow_encap_decap_resource_release(dev,
+							       dev_handle->dvh.rix_encap_decap);
 		if (dev_handle->dvh.modify_hdr)
 			flow_dv_modify_hdr_resource_release(dev, dev_handle);
 		if (dev_handle->dvh.rix_push_vlan)
@@ -16845,7 +16870,7 @@ filter_tcp_types(uint64_t rss_types, uint64_t *hash_fields)
  *   void
  */
 void
-flow_dv_action_rss_l34_hash_adjust(uint64_t orig_rss_types,
+mlx5_flow_dv_action_rss_l34_hash_adjust(uint64_t orig_rss_types,
 				   uint64_t *hash_field)
 {
 	uint64_t hash_field_protos = *hash_field & ~IBV_RX_HASH_INNER;
@@ -16916,7 +16941,7 @@ __flow_dv_action_rss_setup(struct rte_eth_dev *dev,
 		uint64_t hash_fields = mlx5_rss_hash_fields[i];
 		int tunnel = 0;
 
-		flow_dv_action_rss_l34_hash_adjust(shared_rss->origin.types,
+		mlx5_flow_dv_action_rss_l34_hash_adjust(shared_rss->origin.types,
 						   &hash_fields);
 		if (shared_rss->origin.level > 1) {
 			hash_fields |= IBV_RX_HASH_INNER;
@@ -16996,7 +17021,7 @@ __flow_dv_action_rss_create(struct rte_eth_dev *dev,
 	/* RSS type 0 indicates default RSS type (RTE_ETH_RSS_IP). */
 	origin->types = !rss->types ? RTE_ETH_RSS_IP : rss->types;
 	/* NULL RSS key indicates default RSS key. */
-	rss_key = !rss->key ? rss_hash_default_key : rss->key;
+	rss_key = !rss->key ? mlx5_rss_hash_default_key : rss->key;
 	memcpy(shared_rss->key, rss_key, MLX5_RSS_HASH_KEY_LEN);
 	origin->key = &shared_rss->key[0];
 	origin->key_len = MLX5_RSS_HASH_KEY_LEN;
@@ -17103,10 +17128,10 @@ __flow_dv_action_rss_release(struct rte_eth_dev *dev, uint32_t idx,
  *   rte_errno is set.
  */
 struct rte_flow_action_handle *
-flow_dv_action_create(struct rte_eth_dev *dev,
-		      const struct rte_flow_indir_action_conf *conf,
-		      const struct rte_flow_action *action,
-		      struct rte_flow_error *err)
+mlx5_flow_dv_action_create(struct rte_eth_dev *dev,
+			   const struct rte_flow_indir_action_conf *conf,
+			   const struct rte_flow_action *action,
+			   struct rte_flow_error *err)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint32_t age_idx = 0;
@@ -17175,9 +17200,9 @@ flow_dv_action_create(struct rte_eth_dev *dev,
  *   0 on success, otherwise negative errno value.
  */
 int
-flow_dv_action_destroy(struct rte_eth_dev *dev,
-		       struct rte_flow_action_handle *handle,
-		       struct rte_flow_error *error)
+mlx5_flow_dv_action_destroy(struct rte_eth_dev *dev,
+			    struct rte_flow_action_handle *handle,
+			    struct rte_flow_error *error)
 {
 	uint32_t act_idx = (uint32_t)(uintptr_t)handle;
 	uint32_t type = act_idx >> MLX5_INDIRECT_ACTION_TYPE_OFFSET;
@@ -17386,10 +17411,10 @@ __flow_dv_action_ct_update(struct rte_eth_dev *dev, uint32_t idx,
  *   0 on success, otherwise negative errno value.
  */
 int
-flow_dv_action_update(struct rte_eth_dev *dev,
-			struct rte_flow_action_handle *handle,
-			const void *update,
-			struct rte_flow_error *err)
+mlx5_flow_dv_action_update(struct rte_eth_dev *dev,
+			   struct rte_flow_action_handle *handle,
+			   const void *update,
+			   struct rte_flow_error *err)
 {
 	uint32_t act_idx = (uint32_t)(uintptr_t)handle;
 	uint32_t type = act_idx >> MLX5_INDIRECT_ACTION_TYPE_OFFSET;
@@ -17458,14 +17483,12 @@ __flow_dv_destroy_sub_policy_rules(struct rte_eth_dev *dev,
 			sub_policy->rix_hrxq[i] = 0;
 		}
 		if (sub_policy->jump_tbl[i]) {
-			flow_dv_tbl_resource_release(MLX5_SH(dev),
-						     sub_policy->jump_tbl[i]);
+			mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), sub_policy->jump_tbl[i]);
 			sub_policy->jump_tbl[i] = NULL;
 		}
 	}
 	if (sub_policy->tbl_rsc) {
-		flow_dv_tbl_resource_release(MLX5_SH(dev),
-					     sub_policy->tbl_rsc);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), sub_policy->tbl_rsc);
 		sub_policy->tbl_rsc = NULL;
 	}
 }
@@ -17736,10 +17759,12 @@ __flow_dv_create_domain_policy_acts(struct rte_eth_dev *dev,
 				 */
 				if (!mtrmng->drop_tbl[domain]) {
 					mtrmng->drop_tbl[domain] =
-					flow_dv_tbl_resource_get(dev,
-					MLX5_FLOW_TABLE_LEVEL_METER,
-					egress, transfer, false, NULL, 0,
-					0, MLX5_MTR_TABLE_ID_DROP, &flow_err);
+					mlx5_flow_dv_tbl_resource_get(dev,
+								      MLX5_FLOW_TABLE_LEVEL_METER,
+								      egress, transfer, false,
+								      NULL, 0,
+								      0, MLX5_MTR_TABLE_ID_DROP,
+								      &flow_err);
 					if (!mtrmng->drop_tbl[domain])
 						return -rte_mtr_error_set
 					(error, ENOTSUP,
@@ -17901,12 +17926,11 @@ __flow_dv_create_domain_policy_acts(struct rte_eth_dev *dev,
 					NULL, "cannot setup "
 					"policy jump action");
 				sub_policy->jump_tbl[i] =
-				flow_dv_tbl_resource_get(dev,
-					table, egress,
-					transfer,
-					!!dev_flow.external,
-					NULL, jump_group, 0,
-					0, &flow_err);
+				mlx5_flow_dv_tbl_resource_get(dev,
+							      table, egress,
+							      transfer, !!dev_flow.external,
+							      NULL, jump_group, 0,
+							      0, &flow_err);
 				if
 				(!sub_policy->jump_tbl[i])
 					return  -rte_mtr_error_set(error,
@@ -18136,9 +18160,9 @@ flow_dv_query_count(struct rte_eth_dev *dev, uint32_t cnt_idx, void *data,
 }
 
 int
-flow_dv_action_query(struct rte_eth_dev *dev,
-		     const struct rte_flow_action_handle *handle, void *data,
-		     struct rte_flow_error *error)
+mlx5_flow_dv_action_query(struct rte_eth_dev *dev,
+			  const struct rte_flow_action_handle *handle, void *data,
+			  struct rte_flow_error *error)
 {
 	struct mlx5_age_param *age_param;
 	struct rte_flow_query_age *resp;
@@ -18152,7 +18176,7 @@ flow_dv_action_query(struct rte_eth_dev *dev,
 
 	switch (type) {
 	case MLX5_INDIRECT_ACTION_TYPE_AGE:
-		age_param = &flow_aso_age_get_by_idx(dev, idx)->age_params;
+		age_param = &mlx5_flow_aso_age_get_by_idx(dev, idx)->age_params;
 		resp = data;
 		resp->aged = rte_atomic_load_explicit(&age_param->state,
 					      rte_memory_order_relaxed) == AGE_TMOUT ?
@@ -18221,7 +18245,7 @@ flow_dv_query_age(struct rte_eth_dev *dev, struct rte_flow *flow,
 
 	if (flow->age) {
 		struct mlx5_aso_age_action *act =
-				     flow_aso_age_get_by_idx(dev, flow->age);
+				     mlx5_flow_aso_age_get_by_idx(dev, flow->age);
 
 		age_param = &act->age_params;
 	} else if (flow->counter) {
@@ -18346,8 +18370,7 @@ flow_dv_destroy_mtr_drop_tbls(struct rte_eth_dev *dev)
 			}
 		}
 		if (mtrmng->drop_tbl[i]) {
-			flow_dv_tbl_resource_release(MLX5_SH(dev),
-				mtrmng->drop_tbl[i]);
+			mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), mtrmng->drop_tbl[i]);
 			mtrmng->drop_tbl[i] = NULL;
 		}
 	}
@@ -18536,10 +18559,11 @@ __flow_dv_create_domain_policy_rules(struct rte_eth_dev *dev,
 		return -1;
 	/* Create policy table with POLICY level. */
 	if (!sub_policy->tbl_rsc)
-		sub_policy->tbl_rsc = flow_dv_tbl_resource_get(dev,
-				MLX5_FLOW_TABLE_LEVEL_POLICY,
-				egress, transfer, false, NULL, 0, 0,
-				sub_policy->idx, &flow_err);
+		sub_policy->tbl_rsc = mlx5_flow_dv_tbl_resource_get(dev,
+								    MLX5_FLOW_TABLE_LEVEL_POLICY,
+								    egress, transfer, false,
+								    NULL, 0, 0,
+								    sub_policy->idx, &flow_err);
 	if (!sub_policy->tbl_rsc) {
 		DRV_LOG(ERR,
 			"Failed to create meter sub policy table.");
@@ -18842,10 +18866,10 @@ __flow_dv_create_domain_def_policy(struct rte_eth_dev *dev, uint32_t domain)
 		}
 		mtrmng->def_policy[domain] = def_policy;
 		/* Create the meter suffix table with SUFFIX level. */
-		jump_tbl = flow_dv_tbl_resource_get(dev,
-				MLX5_FLOW_TABLE_LEVEL_METER,
-				egress, transfer, false, NULL, 0,
-				0, MLX5_MTR_TABLE_ID_SUFFIX, &error);
+		jump_tbl = mlx5_flow_dv_tbl_resource_get(dev,
+							 MLX5_FLOW_TABLE_LEVEL_METER,
+							 egress, transfer, false, NULL, 0,
+							 0, MLX5_MTR_TABLE_ID_SUFFIX, &error);
 		if (!jump_tbl) {
 			DRV_LOG(ERR,
 				"Failed to create meter suffix table.");
@@ -18864,10 +18888,10 @@ __flow_dv_create_domain_def_policy(struct rte_eth_dev *dev, uint32_t domain)
 		 * resource getting is just to update the reference count for
 		 * the releasing stage.
 		 */
-		jump_tbl = flow_dv_tbl_resource_get(dev,
-				MLX5_FLOW_TABLE_LEVEL_METER,
-				egress, transfer, false, NULL, 0,
-				0, MLX5_MTR_TABLE_ID_SUFFIX, &error);
+		jump_tbl = mlx5_flow_dv_tbl_resource_get(dev,
+							 MLX5_FLOW_TABLE_LEVEL_METER,
+							 egress, transfer, false, NULL, 0,
+							 0, MLX5_MTR_TABLE_ID_SUFFIX, &error);
 		if (!jump_tbl) {
 			DRV_LOG(ERR,
 				"Failed to get meter suffix table.");
@@ -18882,10 +18906,10 @@ __flow_dv_create_domain_def_policy(struct rte_eth_dev *dev, uint32_t domain)
 		acts[RTE_COLOR_YELLOW].actions_n = 1;
 		/* Create jump action to the drop table. */
 		if (!mtrmng->drop_tbl[domain]) {
-			mtrmng->drop_tbl[domain] = flow_dv_tbl_resource_get
-				(dev, MLX5_FLOW_TABLE_LEVEL_METER,
-				 egress, transfer, false, NULL, 0,
-				 0, MLX5_MTR_TABLE_ID_DROP, &error);
+			mtrmng->drop_tbl[domain] = mlx5_flow_dv_tbl_resource_get
+							(dev, MLX5_FLOW_TABLE_LEVEL_METER,
+							 egress, transfer, false, NULL, 0,
+							 0, MLX5_MTR_TABLE_ID_DROP, &error);
 			if (!mtrmng->drop_tbl[domain]) {
 				DRV_LOG(ERR, "Failed to create meter "
 					"drop table for default policy.");
@@ -19008,10 +19032,10 @@ flow_dv_create_mtr_tbls(struct rte_eth_dev *dev,
 		transfer = (domain == MLX5_MTR_DOMAIN_TRANSFER) ? 1 : 0;
 		/* Create the drop table with METER DROP level. */
 		if (!mtrmng->drop_tbl[domain]) {
-			mtrmng->drop_tbl[domain] = flow_dv_tbl_resource_get(dev,
-					MLX5_FLOW_TABLE_LEVEL_METER,
-					egress, transfer, false, NULL, 0,
-					0, MLX5_MTR_TABLE_ID_DROP, &error);
+			mtrmng->drop_tbl[domain] = mlx5_flow_dv_tbl_resource_get(dev,
+							MLX5_FLOW_TABLE_LEVEL_METER,
+							egress, transfer, false, NULL, 0,
+							0, MLX5_MTR_TABLE_ID_DROP, &error);
 			if (!mtrmng->drop_tbl[domain]) {
 				DRV_LOG(ERR, "Failed to create meter drop table.");
 				goto policy_error;
@@ -19210,7 +19234,7 @@ __flow_dv_meter_get_rss_sub_policy(struct rte_eth_dev *dev,
 					wks->mark = 1;
 				dh.fate_action = MLX5_FLOW_FATE_QUEUE;
 				dh.rix_hrxq = hrxq_idx[i];
-				flow_drv_rxq_flags_set(dev, &dh);
+				mlx5_flow_drv_rxq_flags_set(dev, &dh);
 			}
 		}
 	}
@@ -19717,8 +19741,8 @@ mlx5_flow_discover_dr_action_support(struct rte_eth_dev *dev)
 	void *flow = NULL;
 	int ret = -1;
 
-	tbl = flow_dv_tbl_resource_get(dev, 0, 0, 0, false, NULL,
-					0, 0, 0, NULL);
+	tbl = mlx5_flow_dv_tbl_resource_get(dev, 0, 0, 0, false, NULL,
+					    0, 0, 0, NULL);
 	if (!tbl)
 		goto err;
 	dv_attr.match_criteria_enable = flow_dv_matcher_enable(mask.buf);
@@ -19748,7 +19772,7 @@ mlx5_flow_discover_dr_action_support(struct rte_eth_dev *dev)
 	if (matcher)
 		claim_zero(mlx5_flow_os_destroy_flow_matcher(matcher));
 	if (tbl)
-		flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
 	return ret;
 }
 
@@ -19789,8 +19813,8 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
 	void *flow = NULL;
 	int ret = -1;
 
-	tbl = flow_dv_tbl_resource_get(dev, 0, 1, 0, false, NULL,
-					0, 0, 0, NULL);
+	tbl = mlx5_flow_dv_tbl_resource_get(dev, 0, 1, 0, false, NULL,
+					    0, 0, 0, NULL);
 	if (!tbl)
 		goto err;
 	dcs = mlx5_devx_cmd_flow_counter_alloc(priv->sh->cdev->ctx, 0x4);
@@ -19835,7 +19859,7 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
 	if (matcher)
 		claim_zero(mlx5_flow_os_destroy_flow_matcher(matcher));
 	if (tbl)
-		flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
+		mlx5_flow_dv_tbl_resource_release(MLX5_SH(dev), tbl);
 	if (dcs)
 		claim_zero(mlx5_devx_cmd_destroy(dcs));
 	return ret;
@@ -19974,10 +19998,10 @@ flow_dv_counter_allocate(struct rte_eth_dev *dev)
  *   0 on success, otherwise negative errno value.
  */
 int
-flow_dv_action_validate(struct rte_eth_dev *dev,
-			const struct rte_flow_indir_action_conf *conf,
-			const struct rte_flow_action *action,
-			struct rte_flow_error *err)
+mlx5_flow_dv_action_validate(struct rte_eth_dev *dev,
+			     const struct rte_flow_indir_action_conf *conf,
+			     const struct rte_flow_action *action,
+			     struct rte_flow_error *err)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	/* called from RTE API */
@@ -19988,9 +20012,9 @@ flow_dv_action_validate(struct rte_eth_dev *dev,
 		/*
 		 * priv->obj_ops is set according to driver capabilities.
 		 * When DevX capabilities are
-		 * sufficient, it is set to devx_obj_ops.
-		 * Otherwise, it is set to ibv_obj_ops.
-		 * ibv_obj_ops doesn't support ind_table_modify operation.
+		 * sufficient, it is set to mlx5_devx_obj_ops.
+		 * Otherwise, it is set to mlx5_ibv_obj_ops.
+		 * mlx5_ibv_obj_ops doesn't support ind_table_modify operation.
 		 * In this case the indirect RSS action can't be used.
 		 */
 		if (priv->obj_ops.ind_table_modify == NULL)
@@ -20051,8 +20075,8 @@ flow_dv_mtr_policy_rss_compare(const struct rte_flow_action_rss *r1,
 	      (r2->types == 0 || r2->types == RTE_ETH_RSS_IP)))
 		return 1;
 	if (r1->key || r2->key) {
-		const void *key1 = r1->key ? r1->key : rss_hash_default_key;
-		const void *key2 = r2->key ? r2->key : rss_hash_default_key;
+		const void *key1 = r1->key ? r1->key : mlx5_rss_hash_default_key;
+		const void *key2 = r2->key ? r2->key : mlx5_rss_hash_default_key;
 
 		if (memcmp(key1, key2, MLX5_RSS_HASH_KEY_LEN))
 			return 1;
@@ -20651,9 +20675,9 @@ flow_dv_discover_priorities(struct rte_eth_dev *dev,
 }
 
 const struct mlx5_flow_driver_ops mlx5_flow_dv_drv_ops = {
-	.list_create = flow_legacy_list_create,
-	.list_destroy = flow_legacy_list_destroy,
-	.validate = flow_dv_validate,
+	.list_create = mlx5_flow_legacy_list_create,
+	.list_destroy = mlx5_flow_legacy_list_destroy,
+	.validate = mlx5_flow_dv_validate,
 	.prepare = flow_dv_prepare,
 	.translate = flow_dv_translate,
 	.apply = flow_dv_apply,
@@ -20679,15 +20703,15 @@ const struct mlx5_flow_driver_ops mlx5_flow_dv_drv_ops = {
 	.counter_free = flow_dv_counter_free,
 	.counter_query = flow_dv_counter_query,
 	.get_aged_flows = flow_dv_get_aged_flows,
-	.action_validate = flow_dv_action_validate,
-	.action_create = flow_dv_action_create,
-	.action_destroy = flow_dv_action_destroy,
-	.action_update = flow_dv_action_update,
-	.action_query = flow_dv_action_query,
+	.action_validate = mlx5_flow_dv_action_validate,
+	.action_create = mlx5_flow_dv_action_create,
+	.action_destroy = mlx5_flow_dv_action_destroy,
+	.action_update = mlx5_flow_dv_action_update,
+	.action_query = mlx5_flow_dv_action_query,
 	.sync_domain = flow_dv_sync_domain,
 	.discover_priorities = flow_dv_discover_priorities,
-	.item_create = flow_dv_item_create,
-	.item_release = flow_dv_item_release,
+	.item_create = mlx5_flow_dv_item_create,
+	.item_release = mlx5_flow_dv_item_release,
 };
 
 #endif /* HAVE_IBV_FLOW_DV_SUPPORT */
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index 12d79ffb9e1..32f126f0526 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -351,17 +351,25 @@ mlx5_flex_flow_translate_item(struct rte_eth_dev *dev,
 	spec = item->spec;
 	mask = item->mask;
 	tp = (struct mlx5_flex_item *)spec->handle;
+	/* Validate mapnum to prevent using tainted loop bound */
+	if (tp->mapnum > MLX5_FLEX_ITEM_MAPPING_NUM)
+		return;
 	for (i = 0; i < tp->mapnum && pos < (spec->length * CHAR_BIT); i++) {
 		struct mlx5_flex_pattern_field *map = tp->map + i;
 		uint32_t val, msk, def;
 		int id = mlx5_flex_get_sample_id(tp, i, &pos, is_inner);
 
-		if (id == -1)
+		/* Validate id to prevent using tainted value as array index */
+		if (id < 0)
 			continue;
 		MLX5_ASSERT(id < (int)tp->devx_fp->num_samples);
 		if (id >= (int)tp->devx_fp->num_samples ||
 		    id >= MLX5_GRAPH_NODE_SAMPLE_NUM)
 			return;
+		/* Validate width and shift to prevent using tainted values as loop bounds */
+		if (map->width == 0 || map->width > sizeof(uint32_t) * CHAR_BIT ||
+		    (uint32_t)(map->shift + map->width) > sizeof(uint32_t) * CHAR_BIT)
+			return;
 		def = (uint32_t)(RTE_BIT64(map->width) - 1);
 		def <<= (sizeof(uint32_t) * CHAR_BIT - map->shift - map->width);
 		val = mlx5_flex_get_bitfield(spec, pos, map->width, map->shift);
@@ -1369,9 +1377,9 @@ mlx5_flex_translate_conf(struct rte_eth_dev *dev,
  *   Non-NULL opaque pointer on success, NULL otherwise and rte_errno is set.
  */
 struct rte_flow_item_flex_handle *
-flow_dv_item_create(struct rte_eth_dev *dev,
-		    const struct rte_flow_item_flex_conf *conf,
-		    struct rte_flow_error *error)
+mlx5_flow_dv_item_create(struct rte_eth_dev *dev,
+			 const struct rte_flow_item_flex_conf *conf,
+			 struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flex_parser_devx devx_config = { .devx_obj = NULL };
@@ -1420,9 +1428,9 @@ flow_dv_item_create(struct rte_eth_dev *dev,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_dv_item_release(struct rte_eth_dev *dev,
-		     const struct rte_flow_item_flex_handle *handle,
-		     struct rte_flow_error *error)
+mlx5_flow_dv_item_release(struct rte_eth_dev *dev,
+			  const struct rte_flow_item_flex_handle *handle,
+			  struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flex_item *flex =
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index dc70909cff5..1ede6f8120a 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -613,14 +613,14 @@ rte_pmd_mlx5_rss_tir_register(uint16_t port_id,
 	rss_desc.const_q = rss->queue;
 	if (rss->queue_num > 1) {
 		memcpy(rss_desc.key,
-		       rss->key ? rss->key : rss_hash_default_key,
+		       rss->key ? rss->key : mlx5_rss_hash_default_key,
 		       MLX5_RSS_HASH_KEY_LEN);
 		rss_desc.key_len = MLX5_RSS_HASH_KEY_LEN;
 		rss_desc.types = !rss->types ? RTE_ETH_RSS_IP : rss->types;
 		rss_desc.symmetric_hash_function = MLX5_RSS_IS_SYMM(rss->func);
 		flow_hw_hashfields_set(&rss_desc, &rss_desc.hash_fields);
-		flow_dv_action_rss_l34_hash_adjust(rss->types,
-						   &rss_desc.hash_fields);
+		mlx5_flow_dv_action_rss_l34_hash_adjust(rss->types,
+							&rss_desc.hash_fields);
 		if (rss->level > 1) {
 			rss_desc.hash_fields |= IBV_RX_HASH_INNER;
 			rss_desc.tunnel = 1;
@@ -898,14 +898,14 @@ flow_hw_tir_action_register(struct rte_eth_dev *dev,
 		rss_desc.queue_num = rss->queue_num;
 		rss_desc.const_q = rss->queue;
 		memcpy(rss_desc.key,
-		       !rss->key ? rss_hash_default_key : rss->key,
+		       !rss->key ? mlx5_rss_hash_default_key : rss->key,
 		       MLX5_RSS_HASH_KEY_LEN);
 		rss_desc.key_len = MLX5_RSS_HASH_KEY_LEN;
 		rss_desc.types = !rss->types ? RTE_ETH_RSS_IP : rss->types;
 		rss_desc.symmetric_hash_function = MLX5_RSS_IS_SYMM(rss->func);
 		flow_hw_hashfields_set(&rss_desc, &rss_desc.hash_fields);
-		flow_dv_action_rss_l34_hash_adjust(rss->types,
-						   &rss_desc.hash_fields);
+		mlx5_flow_dv_action_rss_l34_hash_adjust(rss->types,
+							&rss_desc.hash_fields);
 		if (rss->level > 1) {
 			rss_desc.hash_fields |= IBV_RX_HASH_INNER;
 			rss_desc.tunnel = 1;
@@ -967,7 +967,7 @@ __flow_hw_actions_release(struct rte_eth_dev *dev, struct mlx5_hw_actions *acts)
 	if (acts->mark)
 		if (!(rte_atomic_fetch_sub_explicit(&priv->hws_mark_refcnt, 1,
 				rte_memory_order_relaxed) - 1))
-			flow_hw_rxq_flag_set(dev, false);
+			mlx5_flow_hw_rxq_flag_set(dev, false);
 
 	if (acts->jump) {
 		struct mlx5_flow_group *grp;
@@ -1728,7 +1728,7 @@ flow_hw_modify_field_compile(struct rte_eth_dev *dev,
 	item.mask = &mask;
 	memset(&dummy, 0, sizeof(dummy));
 	resource = &dummy.resource;
-	ret = flow_dv_convert_modify_action(&item, field, dcopy, resource, type, error);
+	ret = mlx5_flow_dv_convert_modify_action(&item, field, dcopy, resource, type, error);
 	if (ret)
 		return ret;
 	MLX5_ASSERT(resource->actions_num > 0);
@@ -2334,7 +2334,7 @@ mlx5_tbl_translate_reformat(struct mlx5_priv *priv,
 	MLX5_ASSERT(at->reformat_off != UINT16_MAX);
 	if (enc_item) {
 		MLX5_ASSERT(!encap_data);
-		ret = flow_dv_convert_encap_data(enc_item, buf, &data_size, error);
+		ret = mlx5_flow_dv_convert_encap_data(enc_item, buf, &data_size, error);
 		if (ret)
 			return ret;
 		encap_data = buf;
@@ -2690,7 +2690,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				priv->hw_tag[!!attr->group];
 			rte_atomic_fetch_add_explicit(&priv->hws_mark_refcnt, 1,
 					rte_memory_order_relaxed);
-			flow_hw_rxq_flag_set(dev, true);
+			mlx5_flow_hw_rxq_flag_set(dev, true);
 			break;
 		case RTE_FLOW_ACTION_TYPE_MARK:
 			acts->mark = true;
@@ -2709,7 +2709,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 				priv->hw_tag[!!attr->group];
 			rte_atomic_fetch_add_explicit(&priv->hws_mark_refcnt, 1,
 					rte_memory_order_relaxed);
-			flow_hw_rxq_flag_set(dev, true);
+			mlx5_flow_hw_rxq_flag_set(dev, true);
 			break;
 		case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
 			acts->rule_acts[dr_pos].action =
@@ -3212,8 +3212,8 @@ flow_hw_shared_action_get(struct rte_eth_dev *dev,
 		rss_desc.level = act_data->shared_rss.level;
 		rss_desc.types = act_data->shared_rss.types;
 		rss_desc.symmetric_hash_function = act_data->shared_rss.symmetric_hash_function;
-		flow_dv_hashfields_set(item_flags, &rss_desc, &hash_fields);
-		hrxq_idx = flow_dv_action_rss_hrxq_lookup
+		mlx5_flow_dv_hashfields_set(item_flags, &rss_desc, &hash_fields);
+		hrxq_idx = mlx5_flow_dv_action_rss_hrxq_lookup
 			(dev, act_data->shared_rss.idx, hash_fields);
 		if (hrxq_idx)
 			hrxq = mlx5_ipool_get(priv->sh->ipool[MLX5_IPOOL_HRXQ],
@@ -3695,13 +3695,15 @@ flow_hw_actions_construct(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
 			enc_item = ((const struct rte_flow_action_vxlan_encap *)
 				   action->conf)->definition;
-			if (flow_dv_convert_encap_data(enc_item, ap->encap_data, &encap_len, NULL))
+			if (mlx5_flow_dv_convert_encap_data(enc_item, ap->encap_data,
+							    &encap_len, NULL))
 				goto error;
 			break;
 		case RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP:
 			enc_item = ((const struct rte_flow_action_nvgre_encap *)
 				   action->conf)->definition;
-			if (flow_dv_convert_encap_data(enc_item, ap->encap_data, &encap_len, NULL))
+			if (mlx5_flow_dv_convert_encap_data(enc_item, ap->encap_data,
+							    &encap_len, NULL))
 				goto error;
 			break;
 		case RTE_FLOW_ACTION_TYPE_RAW_ENCAP:
@@ -4848,8 +4850,8 @@ __flow_hw_pull_comp(struct rte_eth_dev *dev,
  *    0 on success, negative value otherwise and rte_errno is set.
  */
 int
-flow_hw_q_flow_flush(struct rte_eth_dev *dev,
-		     struct rte_flow_error *error)
+mlx5_flow_hw_q_flow_flush(struct rte_eth_dev *dev,
+			  struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_hw_q *hw_q = &priv->hw_q[MLX5_DEFAULT_FLUSH_QUEUE];
@@ -5382,8 +5384,8 @@ flow_hw_table_create(struct rte_eth_dev *dev,
  *    0 on success, negative value otherwise and rte_errno is set.
  */
 int
-flow_hw_table_update(struct rte_eth_dev *dev,
-		     struct rte_flow_error *error)
+mlx5_flow_hw_table_update(struct rte_eth_dev *dev,
+			  struct rte_flow_error *error)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow_template_table *tbl;
@@ -9514,7 +9516,7 @@ flow_hw_info_get(struct rte_eth_dev *dev,
  *   Group entry on success, NULL otherwise and rte_errno is set.
  */
 struct mlx5_list_entry *
-flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
@@ -9572,11 +9574,11 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
 	}
 
 	grp_data->matchers = mlx5_list_create(matcher_name, sh, true,
-					      flow_matcher_create_cb,
-					      flow_matcher_match_cb,
-					      flow_matcher_remove_cb,
-					      flow_matcher_clone_cb,
-					      flow_matcher_clone_free_cb);
+					      mlx5_flow_matcher_create_cb,
+					      mlx5_flow_matcher_match_cb,
+					      mlx5_flow_matcher_remove_cb,
+					      mlx5_flow_matcher_clone_cb,
+					      mlx5_flow_matcher_clone_free_cb);
 	grp_data->dev = dev;
 	grp_data->idx = idx;
 	grp_data->group_id = attr->group;
@@ -9607,7 +9609,7 @@ flow_hw_grp_create_cb(void *tool_ctx, void *cb_ctx)
  *   Pointer to the entry to be removed.
  */
 void
-flow_hw_grp_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_hw_grp_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_group *grp_data =
@@ -9638,8 +9640,8 @@ flow_hw_grp_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
  *   0 on matched, 1 on miss matched.
  */
 int
-flow_hw_grp_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
-		     void *cb_ctx)
+mlx5_flow_hw_grp_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
+			  void *cb_ctx)
 {
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_group *grp_data =
@@ -9671,12 +9673,13 @@ flow_hw_grp_match_cb(void *tool_ctx __rte_unused, struct mlx5_list_entry *entry,
  *   0 on matched, 1 on miss matched.
  */
 struct mlx5_list_entry *
-flow_hw_grp_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
-		     void *cb_ctx)
+mlx5_flow_hw_grp_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
+			  void *cb_ctx)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_cb_ctx *ctx = cb_ctx;
 	struct mlx5_flow_group *grp_data;
+	struct mlx5_flow_group *old_grp_data;
 	struct rte_flow_error *error = ctx->error;
 	uint32_t idx = 0;
 
@@ -9688,7 +9691,8 @@ flow_hw_grp_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
 				   "cannot allocate flow table data entry");
 		return NULL;
 	}
-	memcpy(grp_data, oentry, sizeof(*grp_data));
+	old_grp_data = container_of(oentry, typeof(*old_grp_data), entry);
+	memcpy(grp_data, old_grp_data, sizeof(*grp_data));
 	grp_data->idx = idx;
 	return &grp_data->entry;
 }
@@ -9702,7 +9706,7 @@ flow_hw_grp_clone_cb(void *tool_ctx, struct mlx5_list_entry *oentry,
  *   Pointer to the group to be freed.
  */
 void
-flow_hw_grp_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_hw_grp_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_dev_ctx_shared *sh = tool_ctx;
 	struct mlx5_flow_group *grp_data =
@@ -9728,7 +9732,7 @@ flow_hw_grp_clone_free_cb(void *tool_ctx, struct mlx5_list_entry *entry)
  *   0 on success, positive value otherwise.
  */
 int
-flow_hw_create_vport_action(struct rte_eth_dev *dev)
+mlx5_flow_hw_create_vport_action(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_eth_dev *proxy_dev;
@@ -9778,7 +9782,7 @@ flow_hw_create_vport_action(struct rte_eth_dev *dev)
  *   Pointer to Ethernet device which will be the action destination.
  */
 void
-flow_hw_destroy_vport_action(struct rte_eth_dev *dev)
+mlx5_flow_hw_destroy_vport_action(struct rte_eth_dev *dev)
 {
 	struct rte_eth_dev *proxy_dev;
 	struct mlx5_priv *proxy_priv;
@@ -11915,7 +11919,7 @@ flow_hw_action_template_drop_init(struct rte_eth_dev *dev,
 }
 
 static void
-__flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
+__mlx5_flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow_template_table *tbl, *temp_tbl;
@@ -11924,7 +11928,7 @@ __flow_hw_resource_release(struct rte_eth_dev *dev, bool ctx_close)
 	struct mlx5_flow_group *grp, *temp_grp;
 	uint32_t i;
 
-	flow_hw_rxq_flag_set(dev, false);
+	mlx5_flow_hw_rxq_flag_set(dev, false);
 	flow_hw_flush_all_ctrl_flows(dev);
 	flow_hw_cleanup_ctrl_fdb_tables(dev);
 	flow_hw_cleanup_ctrl_nic_tables(dev);
@@ -12205,7 +12209,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 							"is not supported");
 		}
 		/* Reconfiguration, need to release all resources from previous allocation. */
-		__flow_hw_resource_release(dev, true);
+		__mlx5_flow_hw_resource_release(dev, true);
 	}
 	priv->hw_attr = flow_hw_alloc_copy_config(port_attr, nb_queue, queue_attr, nt_mode, error);
 	if (!priv->hw_attr) {
@@ -12479,7 +12483,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 	dev->flow_fp_ops = &mlx5_flow_hw_fp_ops;
 	return 0;
 err:
-	__flow_hw_resource_release(dev, true);
+	__mlx5_flow_hw_resource_release(dev, true);
 	if (_queue_attr)
 		mlx5_free(_queue_attr);
 	/* Do not overwrite the internal errno information. */
@@ -12528,18 +12532,18 @@ flow_hw_configure(struct rte_eth_dev *dev,
  *   Pointer to the rte_eth_dev structure.
  */
 void
-flow_hw_resource_release(struct rte_eth_dev *dev)
+mlx5_flow_hw_resource_release(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 
 	if (!priv->dr_ctx)
 		return;
-	__flow_hw_resource_release(dev, false);
+	__mlx5_flow_hw_resource_release(dev, false);
 }
 
 /* Sets vport tag and mask, for given port, used in HWS rules. */
 void
-flow_hw_set_port_info(struct rte_eth_dev *dev)
+mlx5_flow_hw_set_port_info(struct rte_eth_dev *dev)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	uint16_t port_id = dev->data->port_id;
@@ -12554,7 +12558,7 @@ flow_hw_set_port_info(struct rte_eth_dev *dev)
 
 /* Clears vport tag and mask used for HWS rules. */
 void
-flow_hw_clear_port_info(struct rte_eth_dev *dev)
+mlx5_flow_hw_clear_port_info(struct rte_eth_dev *dev)
 {
 	uint16_t port_id = dev->data->port_id;
 	struct flow_hw_port_info *info;
@@ -12801,7 +12805,7 @@ flow_hw_action_handle_validate(struct rte_eth_dev *dev, uint32_t queue,
 	case RTE_FLOW_ACTION_TYPE_METER_MARK:
 		return flow_hw_validate_action_meter_mark(dev, action, true, error);
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		return flow_dv_action_validate(dev, conf, action, error);
+		return mlx5_flow_dv_action_validate(dev, conf, action, error);
 	case RTE_FLOW_ACTION_TYPE_QUOTA:
 		return 0;
 	default:
@@ -12987,7 +12991,7 @@ flow_hw_action_handle_create(struct rte_eth_dev *dev, uint32_t queue,
 		handle = (void *)(uintptr_t)job->action;
 		break;
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		handle = flow_dv_action_create(dev, conf, action, error);
+		handle = mlx5_flow_dv_action_create(dev, conf, action, error);
 		break;
 	case RTE_FLOW_ACTION_TYPE_QUOTA:
 		aso = true;
@@ -13112,7 +13116,7 @@ flow_hw_action_handle_update(struct rte_eth_dev *dev, uint32_t queue,
 						  job, error);
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_RSS:
-		ret = flow_dv_action_update(dev, handle, update, error);
+		ret = mlx5_flow_dv_action_update(dev, handle, update, error);
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_QUOTA:
 		aso = true;
@@ -13230,7 +13234,7 @@ flow_hw_action_handle_destroy(struct rte_eth_dev *dev, uint32_t queue,
 		aso = true;
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_RSS:
-		ret = flow_dv_action_destroy(dev, handle, error);
+		ret = mlx5_flow_dv_action_destroy(dev, handle, error);
 		break;
 	case MLX5_INDIRECT_ACTION_TYPE_QUOTA:
 		break;
@@ -13724,8 +13728,8 @@ flow_hw_get_aged_flows(struct rte_eth_dev *dev, void **contexts,
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-flow_hw_init(struct rte_eth_dev *dev,
-	     struct rte_flow_error *error)
+mlx5_flow_hw_init(struct rte_eth_dev *dev,
+		  struct rte_flow_error *error)
 {
 	const struct rte_flow_port_attr port_attr = {0};
 	const struct rte_flow_queue_attr queue_attr = {.size = MLX5_NT_DEFAULT_QUEUE_SIZE};
@@ -13828,7 +13832,7 @@ flow_hw_modify_hdr_resource_register
 			      &dummy.dv_resource.root, &dummy.dv_resource.ft_type,
 			      &dummy.dv_resource.flags);
 	dummy.dv_resource.flags |= MLX5DR_ACTION_FLAG_SHARED;
-	ret = __flow_modify_hdr_resource_register(dev, &dummy.dv_resource,
+	ret = mlx5_flow_modify_hdr_resource_register(dev, &dummy.dv_resource,
 		&dv_resource_ptr, error);
 	if (ret)
 		return ret;
@@ -13883,7 +13887,7 @@ flow_hw_encap_decap_resource_register
 		MLX5_ASSERT(dv_resource.size <= MLX5_ENCAP_MAX_LEN);
 		memcpy(&dv_resource.buf, reformat->reformat_hdr->data, dv_resource.size);
 	}
-	ret = __flow_encap_decap_resource_register(dev, &dv_resource, is_root,
+	ret = mlx5_flow_encap_decap_resource_register(dev, &dv_resource, is_root,
 		&dv_resource_ptr, error);
 	if (ret)
 		return ret;
@@ -14286,7 +14290,7 @@ static int flow_hw_apply(const struct rte_flow_item items[],
  *   0 on success, negative errno value otherwise and rte_errno set.
  */
 int
-flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+mlx5_flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 		    const struct rte_flow_attr *attr,
 		    const struct rte_flow_item items[],
 		    const struct rte_flow_action actions[],
@@ -14328,9 +14332,9 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	/* TODO TBD flow_hw_handle_tunnel_offload(). */
 	(*flow)->nt_rule = true;
 	(*flow)->nt2hws->matcher = &matcher;
-	ret = __flow_dv_translate_items_hws(items, &flow_attr, &matcher.mask.buf,
-					    MLX5_SET_MATCHER_HS_M, NULL,
-					    NULL, true, error);
+	ret = mlx5_flow_dv_translate_items_hws_impl(items, &flow_attr, &matcher.mask.buf,
+						    MLX5_SET_MATCHER_HS_M, NULL,
+						    NULL, true, error);
 
 	if (ret)
 		goto error;
@@ -14397,7 +14401,7 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 #endif
 
 void
-flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
+mlx5_flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 {
 	int ret;
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -14427,7 +14431,7 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 	if (flow->nt2hws->flow_aux)
 		flow->nt2hws->flow_aux = NULL;
 	if (flow->nt2hws->rix_encap_decap) {
-		flow_encap_decap_resource_release(dev, flow->nt2hws->rix_encap_decap);
+		mlx5_flow_encap_decap_resource_release(dev, flow->nt2hws->rix_encap_decap);
 		flow->nt2hws->rix_encap_decap = 0;
 	}
 	if (flow->nt2hws->modify_hdr) {
@@ -14458,8 +14462,8 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
  *   Address of flow to destroy.
  */
 void
-flow_hw_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
-		     uintptr_t flow_addr)
+mlx5_flow_hw_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
+			  uintptr_t flow_addr)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct rte_flow_hw *flow = (struct rte_flow_hw *)flow_addr;
@@ -14471,7 +14475,7 @@ flow_hw_list_destroy(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 	while (!SLIST_EMPTY(&head)) {
 		flow = SLIST_FIRST(&head);
 		SLIST_REMOVE_HEAD(&head, nt2hws->next);
-		flow_hw_destroy(dev, flow);
+		mlx5_flow_hw_destroy(dev, flow);
 		/* Release flow memory by idx */
 		mlx5_ipool_free(priv->flows[type], flow->idx);
 	}
@@ -14565,10 +14569,10 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	}
 	if (action_flags & MLX5_FLOW_ACTION_RSS) {
 		const struct rte_flow_action_rss
-			*rss_conf = flow_nta_locate_rss(dev, actions, error);
-		flow = flow_nta_handle_rss(dev, attr, items, actions, rss_conf,
-					   item_flags, action_flags, external,
-					   type, error);
+			*rss_conf = mlx5_flow_nta_locate_rss(dev, actions, error);
+		flow = mlx5_flow_nta_handle_rss(dev, attr, items, actions, rss_conf,
+						item_flags, action_flags, external,
+						type, error);
 		if (flow) {
 			flow->nt2hws->rix_mreg_copy = cpy_idx;
 			cpy_idx = 0;
@@ -14579,9 +14583,9 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		goto free;
 	}
 	/* Create single flow. */
-	ret = flow_hw_create_flow(dev, type, resource.suffix.attr, resource.suffix.items,
-				  resource.suffix.actions, item_flags, action_flags,
-				  external, &flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, resource.suffix.attr, resource.suffix.items,
+				       resource.suffix.actions, item_flags, action_flags,
+				       external, &flow, error);
 	if (ret)
 		goto free;
 	if (flow) {
@@ -14592,8 +14596,8 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 		/* Fall Through to prefix flow creation. */
 	}
 prefix_flow:
-	ret = flow_hw_create_flow(dev, type, attr, items, resource.prefix.actions,
-				  item_flags, action_flags, external, &prfx_flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, attr, items, resource.prefix.actions,
+				       item_flags, action_flags, external, &prfx_flow, error);
 	if (ret)
 		goto free;
 	if (prfx_flow) {
@@ -14605,9 +14609,9 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
 	}
 free:
 	if (prfx_flow)
-		flow_hw_list_destroy(dev, type, (uintptr_t)prfx_flow);
+		mlx5_flow_hw_list_destroy(dev, type, (uintptr_t)prfx_flow);
 	if (flow)
-		flow_hw_list_destroy(dev, type, (uintptr_t)flow);
+		mlx5_flow_hw_list_destroy(dev, type, (uintptr_t)flow);
 	if (cpy_idx)
 		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
 	if (split > 0)
@@ -14842,8 +14846,8 @@ hw_mirror_clone_reformat(const struct rte_flow_action *actions,
 		       MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L3 :
 		       MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L2;
 	if (encap_item) {
-		ret = flow_dv_convert_encap_data(encap_item, reformat_buf,
-						 &reformat->reformat_data_sz, NULL);
+		ret = mlx5_flow_dv_convert_encap_data(encap_item, reformat_buf,
+						      &reformat->reformat_data_sz, NULL);
 		if (ret)
 			return -EINVAL;
 		reformat->reformat_data = reformat_buf;
@@ -15722,7 +15726,7 @@ flow_hw_validate(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 
 const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.list_create = flow_hw_list_create,
-	.list_destroy = flow_hw_list_destroy,
+	.list_destroy = mlx5_flow_hw_list_destroy,
 	.validate = flow_hw_validate,
 	.info_get = flow_hw_info_get,
 	.configure = flow_hw_configure,
@@ -15768,8 +15772,8 @@ const struct mlx5_flow_driver_ops mlx5_flow_hw_drv_ops = {
 	.query = flow_hw_query,
 	.get_aged_flows = flow_hw_get_aged_flows,
 	.get_q_aged_flows = flow_hw_get_q_aged_flows,
-	.item_create = flow_dv_item_create,
-	.item_release = flow_dv_item_release,
+	.item_create = mlx5_flow_dv_item_create,
+	.item_release = mlx5_flow_dv_item_release,
 	.flow_calc_table_hash = flow_hw_calc_table_hash,
 	.flow_calc_encap_hash = flow_hw_calc_encap_hash,
 };
@@ -17062,7 +17066,7 @@ mlx5_flow_hw_ctrl_flow_dmac_vlan_destroy(struct rte_eth_dev *dev,
 }
 
 struct mlx5_ecpri_parser_profile *
-flow_hw_get_ecpri_parser_profile(void *dr_ctx)
+mlx5_flow_hw_get_ecpri_parser_profile(void *dr_ctx)
 {
 	uint16_t port_id;
 	bool found = false;
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index cd6a8045930..3d0cf152e5d 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -2416,7 +2416,7 @@ mlx5_flow_meter_find(struct mlx5_priv *priv, uint32_t meter_id,
  *   Pointer to the meter info found on success, NULL otherwise.
  */
 struct mlx5_flow_meter_info *
-flow_dv_meter_find_by_idx(struct mlx5_priv *priv, uint32_t idx)
+mlx5_flow_dv_meter_find_by_idx(struct mlx5_priv *priv, uint32_t idx)
 {
 	struct mlx5_aso_mtr *aso_mtr;
 
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index 67d199ce15e..bb240d38d94 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -1115,7 +1115,7 @@ flow_verbs_translate_action_rss(struct mlx5_flow_rss_desc *rss_desc,
 	memcpy(rss_desc->queue, rss->queue, rss->queue_num * sizeof(uint16_t));
 	rss_desc->queue_num = rss->queue_num;
 	/* NULL RSS key indicates default RSS key. */
-	rss_key = !rss->key ? rss_hash_default_key : rss->key;
+	rss_key = !rss->key ? mlx5_rss_hash_default_key : rss->key;
 	memcpy(rss_desc->key, rss_key, MLX5_RSS_HASH_KEY_LEN);
 	/*
 	 * rss->level and rss.types should be set in advance when expanding
@@ -2184,8 +2184,8 @@ flow_verbs_sync_domain(struct rte_eth_dev *dev, uint32_t domains,
 }
 
 const struct mlx5_flow_driver_ops mlx5_flow_verbs_drv_ops = {
-	.list_create = flow_legacy_list_create,
-	.list_destroy = flow_legacy_list_destroy,
+	.list_create = mlx5_flow_legacy_list_create,
+	.list_destroy = mlx5_flow_legacy_list_destroy,
 	.validate = flow_verbs_validate,
 	.prepare = flow_verbs_prepare,
 	.translate = flow_verbs_translate,
@@ -2195,8 +2195,8 @@ const struct mlx5_flow_driver_ops mlx5_flow_verbs_drv_ops = {
 	.query = flow_verbs_query,
 	.sync_domain = flow_verbs_sync_domain,
 	.discover_priorities = flow_verbs_discover_priorities,
-	.get_aged_flows = flow_null_get_aged_flows,
-	.counter_alloc = flow_null_counter_allocate,
-	.counter_free = flow_null_counter_free,
-	.counter_query = flow_null_counter_query,
+	.get_aged_flows = mlx5_flow_null_get_aged_flows,
+	.counter_alloc = mlx5_flow_null_counter_allocate,
+	.counter_free = mlx5_flow_null_counter_free,
+	.counter_query = mlx5_flow_null_counter_query,
 };
diff --git a/drivers/net/mlx5/mlx5_nta_rss.c b/drivers/net/mlx5/mlx5_nta_rss.c
index 1785425bb50..4885ea00329 100644
--- a/drivers/net/mlx5/mlx5_nta_rss.c
+++ b/drivers/net/mlx5/mlx5_nta_rss.c
@@ -63,10 +63,10 @@ mlx5_nta_ptype_rss_flow_create(struct mlx5_nta_rss_ctx *ctx,
 #endif
 	ptype_spec->packet_type = ptype;
 	rss_conf->types = rss_type;
-	ret = flow_hw_create_flow(ctx->dev, MLX5_FLOW_TYPE_GEN, ctx->attr,
-				  ctx->pattern, ctx->actions,
-				  MLX5_FLOW_ITEM_PTYPE, MLX5_FLOW_ACTION_RSS,
-				  ctx->external, &flow, ctx->error);
+	ret = mlx5_flow_hw_create_flow(ctx->dev, MLX5_FLOW_TYPE_GEN, ctx->attr,
+				       ctx->pattern, ctx->actions,
+				       MLX5_FLOW_ITEM_PTYPE, MLX5_FLOW_ACTION_RSS,
+				       ctx->external, &flow, ctx->error);
 	if (ret == 0) {
 		SLIST_INSERT_HEAD(ctx->head, flow, nt2hws->next);
 		if (dbg_log) {
@@ -113,8 +113,8 @@ mlx5_hw_rss_expand_l3(struct mlx5_nta_rss_ctx *rss_ctx)
 	return SLIST_FIRST(rss_ctx->head);
 
 error:
-	flow_hw_list_destroy(rss_ctx->dev, rss_ctx->flow_type,
-			     (uintptr_t)SLIST_FIRST(rss_ctx->head));
+	mlx5_flow_hw_list_destroy(rss_ctx->dev, rss_ctx->flow_type,
+				  (uintptr_t)SLIST_FIRST(rss_ctx->head));
 	return NULL;
 }
 
@@ -165,8 +165,8 @@ mlx5_nta_rss_expand_l3_l4(struct mlx5_nta_rss_ctx *rss_ctx,
 	}
 	return;
 error:
-	flow_hw_list_destroy(rss_ctx->dev, rss_ctx->flow_type,
-			     (uintptr_t)SLIST_FIRST(rss_ctx->head));
+	mlx5_flow_hw_list_destroy(rss_ctx->dev, rss_ctx->flow_type,
+				  (uintptr_t)SLIST_FIRST(rss_ctx->head));
 }
 
 /*
@@ -301,9 +301,9 @@ mlx5_hw_rss_ptype_create_miss_flow(struct rte_eth_dev *dev,
 		[MLX5_RSS_PTYPE_ACTION_INDEX + 1] = { .type = RTE_FLOW_ACTION_TYPE_END }
 	};
 
-	ret = flow_hw_create_flow(dev, MLX5_FLOW_TYPE_GEN, &miss_attr,
-				  miss_pattern, miss_actions, 0,
-				  MLX5_FLOW_ACTION_RSS, external, &flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, MLX5_FLOW_TYPE_GEN, &miss_attr,
+				       miss_pattern, miss_actions, 0,
+				       MLX5_FLOW_ACTION_RSS, external, &flow, error);
 	return ret == 0 ? flow : NULL;
 }
 
@@ -347,15 +347,15 @@ mlx5_hw_rss_ptype_create_base_flow(struct rte_eth_dev *dev,
 	} while (actions[i++].type != RTE_FLOW_ACTION_TYPE_END);
 	action_flags &= ~MLX5_FLOW_ACTION_RSS;
 	action_flags |= MLX5_FLOW_ACTION_JUMP;
-	ret = flow_hw_create_flow(dev, flow_type, attr, pattern, actions,
-				  item_flags, action_flags, external, &flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, flow_type, attr, pattern, actions,
+				       item_flags, action_flags, external, &flow, error);
 	return ret == 0 ? flow : NULL;
 }
 
 const struct rte_flow_action_rss *
-flow_nta_locate_rss(struct rte_eth_dev *dev,
-		    const struct rte_flow_action actions[],
-		    struct rte_flow_error *error)
+mlx5_flow_nta_locate_rss(struct rte_eth_dev *dev,
+			 const struct rte_flow_action actions[],
+			 struct rte_flow_error *error)
 {
 	const struct rte_flow_action *a;
 	const struct rte_flow_action_rss *rss_conf = NULL;
@@ -459,8 +459,8 @@ flow_nta_create_single(struct rte_eth_dev *dev,
 		_actions = actions;
 	}
 end:
-	ret = flow_hw_create_flow(dev, flow_type, attr, items, _actions,
-				  item_flags, action_flags, external, &flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, flow_type, attr, items, _actions,
+				       item_flags, action_flags, external, &flow, error);
 	return ret == 0 ? flow : NULL;
 }
 
@@ -477,14 +477,14 @@ flow_nta_create_single(struct rte_eth_dev *dev,
 				  RTE_PTYPE_INNER_L4_TCP | RTE_PTYPE_INNER_L4_UDP)
 
 struct rte_flow_hw *
-flow_nta_handle_rss(struct rte_eth_dev *dev,
-		    const struct rte_flow_attr *attr,
-		    const struct rte_flow_item items[],
-		    const struct rte_flow_action actions[],
-		    const struct rte_flow_action_rss *rss_conf,
-		    uint64_t item_flags, uint64_t action_flags,
-		    bool external, enum mlx5_flow_type flow_type,
-		    struct rte_flow_error *error)
+mlx5_flow_nta_handle_rss(struct rte_eth_dev *dev,
+			 const struct rte_flow_attr *attr,
+			 const struct rte_flow_item items[],
+			 const struct rte_flow_action actions[],
+			 const struct rte_flow_action_rss *rss_conf,
+			 uint64_t item_flags, uint64_t action_flags,
+			 bool external, enum mlx5_flow_type flow_type,
+			 struct rte_flow_error *error)
 {
 	struct rte_flow_hw *rss_base = NULL, *rss_next = NULL, *rss_miss = NULL;
 	struct rte_flow_action_rss ptype_rss_conf = *rss_conf;
@@ -625,9 +625,9 @@ flow_nta_handle_rss(struct rte_eth_dev *dev,
 
 error:
 	if (rss_miss)
-		flow_hw_list_destroy(dev, flow_type, (uintptr_t)rss_miss);
+		mlx5_flow_hw_list_destroy(dev, flow_type, (uintptr_t)rss_miss);
 	if (rss_next)
-		flow_hw_list_destroy(dev, flow_type, (uintptr_t)rss_next);
+		mlx5_flow_hw_list_destroy(dev, flow_type, (uintptr_t)rss_next);
 	mlx5_hw_release_rss_ptype_group(dev, ptype_attr.group);
 	return NULL;
 }
diff --git a/drivers/net/mlx5/mlx5_nta_sample.c b/drivers/net/mlx5/mlx5_nta_sample.c
index 0b7b3d0c8ee..c637b0ede38 100644
--- a/drivers/net/mlx5/mlx5_nta_sample.c
+++ b/drivers/net/mlx5/mlx5_nta_sample.c
@@ -26,7 +26,7 @@ release_chained_flows(struct rte_eth_dev *dev, struct mlx5_flow_head *flow_head,
 
 	if (flow) {
 		flow->nt2hws->chaned_flow = 0;
-		flow_hw_list_destroy(dev, type, (uintptr_t)flow);
+		mlx5_flow_hw_list_destroy(dev, type, (uintptr_t)flow);
 	}
 }
 
@@ -613,18 +613,18 @@ create_mirror_aux_flows(struct rte_eth_dev *dev,
 	if (qrss_action != NULL && qrss_action->type == RTE_FLOW_ACTION_TYPE_RSS)
 		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 			"RSS action is not supported in sample action");
-	ret = flow_hw_create_flow(dev, type, &suffix_attr,
-				  secondary_pattern, suffix_actions,
-				  MLX5_FLOW_LAYER_OUTER_L2, suffix_action_flags,
-				  true, &suffix_flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, &suffix_attr,
+				       secondary_pattern, suffix_actions,
+				       MLX5_FLOW_LAYER_OUTER_L2, suffix_action_flags,
+				       true, &suffix_flow, error);
 	if (ret != 0)
 		return ret;
-	ret = flow_hw_create_flow(dev, type, &sample_attr,
-				  secondary_pattern, sample_actions,
-				  MLX5_FLOW_LAYER_OUTER_L2, sample_action_flags,
-				  true, &sample_flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, &sample_attr,
+				       secondary_pattern, sample_actions,
+				       MLX5_FLOW_LAYER_OUTER_L2, sample_action_flags,
+				       true, &sample_flow, error);
 	if (ret != 0) {
-		flow_hw_destroy(dev, suffix_flow);
+		mlx5_flow_hw_destroy(dev, suffix_flow);
 		return ret;
 	}
 	suffix_flow->nt2hws->chaned_flow = 1;
@@ -673,8 +673,8 @@ create_sample_flow(struct rte_eth_dev *dev,
 
 	if (random_mask > UINT16_MAX)
 		return NULL;
-	flow_hw_create_flow(dev, type, &sample_attr, sample_pattern, sample_actions,
-			    0, 0, true, &sample_flow, error);
+	mlx5_flow_hw_create_flow(dev, type, &sample_attr, sample_pattern, sample_actions,
+				 0, 0, true, &sample_flow, error);
 	return sample_flow;
 }
 
@@ -768,8 +768,8 @@ mlx5_nta_create_sample_flow(struct rte_eth_dev *dev,
 			.type = RTE_FLOW_ACTION_TYPE_JUMP,
 			.conf = &(struct rte_flow_action_jump) { .group = sample_group }
 		});
-	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
-				  item_flags, action_flags, true, &base_flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				       item_flags, action_flags, true, &base_flow, error);
 	if (ret != 0)
 		goto error;
 	SLIST_INSERT_HEAD(flow_head, base_flow, nt2hws->next);
@@ -819,9 +819,9 @@ mlx5_nta_create_mirror_flow(struct rte_eth_dev *dev,
 			.type = (enum rte_flow_action_type)MLX5_RTE_FLOW_ACTION_TYPE_MIRROR,
 			.conf = mirror_entry_to_mirror_action(mirror_entry)
 		});
-	ret = flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
-				  item_flags, action_flags,
-				  true, &base_flow, error);
+	ret = mlx5_flow_hw_create_flow(dev, type, attr, pattern, prefix_actions,
+				       item_flags, action_flags,
+				       true, &base_flow, error);
 	if (ret != 0)
 		goto error;
 	SLIST_INSERT_HEAD(flow_head, base_flow, nt2hws->next);
diff --git a/drivers/net/mlx5/mlx5_nta_split.c b/drivers/net/mlx5/mlx5_nta_split.c
index c95da56d729..327930ecb83 100644
--- a/drivers/net/mlx5/mlx5_nta_split.c
+++ b/drivers/net/mlx5/mlx5_nta_split.c
@@ -277,7 +277,7 @@ mlx5_flow_nta_split_resource_free(struct rte_eth_dev *dev,
  * are different, and the action used to copy the metadata is also different.
  */
 struct mlx5_list_entry *
-flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx)
+mlx5_flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 {
 	struct rte_eth_dev *dev = tool_ctx;
 	struct mlx5_priv *priv = dev->data->dev_private;
@@ -374,7 +374,7 @@ flow_nta_mreg_create_cb(void *tool_ctx, void *cb_ctx)
 }
 
 void
-flow_nta_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
+mlx5_flow_nta_mreg_remove_cb(void *tool_ctx, struct mlx5_list_entry *entry)
 {
 	struct mlx5_flow_mreg_copy_resource *mcp_res =
 			       container_of(entry, typeof(*mcp_res), hlist_ent);
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index ac663a978ee..bc0470e6af3 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -618,7 +618,7 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 		}
 		/* Try to find the actual cq_ci in hardware for shared queue. */
 		if (rxq->shared)
-			rxq_sync_cq(rxq);
+			mlx5_rxq_sync_cq(rxq);
 		rxq->err_state = MLX5_RXQ_ERR_STATE_NEED_READY;
 		/* Fall-through */
 	case MLX5_RXQ_ERR_STATE_NEED_READY:
@@ -1708,7 +1708,7 @@ mlx5_rx_queue_lwm_set(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 	}
 	rxq_data = &rxq->ctrl->rxq;
 	/* Ensure the Rq is created by devx. */
-	if (priv->obj_ops.rxq_obj_new != devx_obj_ops.rxq_obj_new) {
+	if (priv->obj_ops.rxq_obj_new != mlx5_devx_obj_ops.rxq_obj_new) {
 		rte_errno = EINVAL;
 		return -rte_errno;
 	}
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index 127abe41fb2..86636d598fc 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -215,7 +215,7 @@ struct mlx5_rxq_priv {
 
 /* mlx5_rxq.c */
 
-extern uint8_t rss_hash_default_key[];
+extern uint8_t mlx5_rss_hash_default_key[];
 
 unsigned int mlx5_rxq_cqe_num(struct mlx5_rxq_data *rxq_data);
 int mlx5_mprq_free_mp(struct rte_eth_dev *dev);
@@ -258,7 +258,7 @@ struct mlx5_external_q *mlx5_ext_rxq_get(struct rte_eth_dev *dev,
 int mlx5_rxq_release(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_rxq_verify(struct rte_eth_dev *dev);
 int mlx5_ext_rxq_verify(struct rte_eth_dev *dev);
-int rxq_alloc_elts(struct mlx5_rxq_ctrl *rxq_ctrl);
+int mlx5_rxq_alloc_elts(struct mlx5_rxq_ctrl *rxq_ctrl);
 int mlx5_ind_table_obj_verify(struct rte_eth_dev *dev);
 struct mlx5_ind_table_obj *mlx5_ind_table_obj_get(struct rte_eth_dev *dev,
 						  const uint16_t *queues,
@@ -340,7 +340,7 @@ uint16_t mlx5_rx_burst_vec(void *dpdk_rxq, struct rte_mbuf **pkts,
 			   uint16_t pkts_n);
 uint16_t mlx5_rx_burst_mprq_vec(void *dpdk_rxq, struct rte_mbuf **pkts,
 				uint16_t pkts_n);
-void rxq_sync_cq(struct mlx5_rxq_data *rxq);
+void mlx5_rxq_sync_cq(struct mlx5_rxq_data *rxq);
 
 static int mlx5_rxq_mprq_enabled(struct mlx5_rxq_data *rxq);
 
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 9210a92c5f4..01e90a08a7d 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -35,7 +35,7 @@
 
 
 /* Default RSS hash key also used for ConnectX-3. */
-uint8_t rss_hash_default_key[] = {
+uint8_t mlx5_rss_hash_default_key[] = {
 	0x2c, 0xc6, 0x81, 0xd1,
 	0x5b, 0xdb, 0xf4, 0xf7,
 	0xfc, 0xa2, 0x83, 0x19,
@@ -50,7 +50,7 @@ uint8_t rss_hash_default_key[] = {
 
 /* Length of the default RSS hash key. */
 static_assert(MLX5_RSS_HASH_KEY_LEN ==
-	      (unsigned int)sizeof(rss_hash_default_key),
+	      (unsigned int)sizeof(mlx5_rss_hash_default_key),
 	      "wrong RSS default key size.");
 
 /**
@@ -245,7 +245,7 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
  *   0 on success, negative errno value on failure.
  */
 int
-rxq_alloc_elts(struct mlx5_rxq_ctrl *rxq_ctrl)
+mlx5_rxq_alloc_elts(struct mlx5_rxq_ctrl *rxq_ctrl)
 {
 	int ret = 0;
 
@@ -422,7 +422,7 @@ mlx5_rxq_releasable(struct rte_eth_dev *dev, uint16_t idx)
 
 /* Fetches and drops all SW-owned and error CQEs to synchronize CQ. */
 void
-rxq_sync_cq(struct mlx5_rxq_data *rxq)
+mlx5_rxq_sync_cq(struct mlx5_rxq_data *rxq)
 {
 	const uint16_t cqe_n = 1 << rxq->cqe_n;
 	const uint16_t cqe_mask = cqe_n - 1;
@@ -494,7 +494,7 @@ mlx5_rx_queue_stop_primary(struct rte_eth_dev *dev, uint16_t idx)
 		return ret;
 	}
 	/* Remove all processes CQEs. */
-	rxq_sync_cq(&rxq_ctrl->rxq);
+	mlx5_rxq_sync_cq(&rxq_ctrl->rxq);
 	/* Free all involved mbufs. */
 	rxq_free_elts(rxq_ctrl);
 	/* Set the actual queue state. */
@@ -573,7 +573,7 @@ mlx5_rx_queue_start_primary(struct rte_eth_dev *dev, uint16_t idx)
 	MLX5_ASSERT(rxq != NULL && rxq->ctrl != NULL);
 	MLX5_ASSERT(rte_eal_process_type() == RTE_PROC_PRIMARY);
 	/* Allocate needed buffers. */
-	ret = rxq_alloc_elts(rxq->ctrl);
+	ret = mlx5_rxq_alloc_elts(rxq->ctrl);
 	if (ret) {
 		DRV_LOG(ERR, "Cannot reallocate buffers for Rx WQ");
 		rte_errno = errno;
@@ -898,7 +898,7 @@ mlx5_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 			rte_errno = EINVAL;
 			return -rte_errno;
 		}
-		if (priv->obj_ops.rxq_obj_new != devx_obj_ops.rxq_obj_new) {
+		if (priv->obj_ops.rxq_obj_new != mlx5_devx_obj_ops.rxq_obj_new) {
 			DRV_LOG(ERR, "port %u queue index %u shared Rx queue needs DevX api",
 				     dev->data->port_id, idx);
 			rte_errno = EINVAL;
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index b38ba9022ea..f155b1a7a05 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -68,7 +68,7 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 				continue;
 			}
 			if (!txq_ctrl->is_hairpin)
-				txq_alloc_elts(txq_ctrl);
+				mlx5_txq_alloc_elts(txq_ctrl);
 			MLX5_ASSERT(!txq_ctrl->obj);
 			txq_ctrl->obj = mlx5_malloc_numa_tolerant(flags,
 								  sizeof(struct mlx5_txq_obj),
@@ -185,7 +185,7 @@ mlx5_rxq_ctrl_prepare(struct rte_eth_dev *dev, struct mlx5_rxq_ctrl *rxq_ctrl,
 		 */
 		if (mlx5_rxq_mempool_register(rxq_ctrl) < 0)
 			return -rte_errno;
-		ret = rxq_alloc_elts(rxq_ctrl);
+		ret = mlx5_rxq_alloc_elts(rxq_ctrl);
 		if (ret)
 			return ret;
 	}
@@ -1268,7 +1268,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 			goto continue_dev_start;
 		/*If previous configuration does not exist. */
 		if (!(priv->dr_ctx)) {
-			ret = flow_hw_init(dev, &error);
+			ret = mlx5_flow_hw_init(dev, &error);
 			if (ret) {
 				DRV_LOG(ERR, "Failed to start port %u %s: %s",
 					dev->data->port_id, dev->data->name,
@@ -1406,7 +1406,7 @@ mlx5_dev_start(struct rte_eth_dev *dev)
 	}
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	if (priv->sh->config.dv_flow_en == 2) {
-		ret = flow_hw_table_update(dev, NULL);
+		ret = mlx5_flow_hw_table_update(dev, NULL);
 		if (ret) {
 			DRV_LOG(ERR, "port %u failed to update HWS tables",
 				dev->data->port_id);
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index fe9da7f8c1e..4c970130d91 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -131,7 +131,7 @@ mlx5_tx_error_cqe_handle(struct mlx5_txq_data *__rte_restrict txq,
 			return -1;
 		}
 		/* Release all the remaining buffers. */
-		txq_free_elts(txq_ctrl);
+		mlx5_txq_free_elts(txq_ctrl);
 	}
 	return 0;
 }
@@ -292,7 +292,7 @@ mlx5_tx_descriptor_status(void *tx_queue, uint16_t offset)
  * supported offloads set. The array is used to select the Tx burst
  * function for specified offloads set at Tx queue configuration time.
  */
-const struct {
+static const struct {
 	eth_tx_burst_t func;
 	unsigned int olx;
 } txoff_func[] = {
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 16307206e2a..fbf6dacb020 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -222,8 +222,8 @@ int mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_releasable(struct rte_eth_dev *dev, uint16_t idx);
 int mlx5_txq_verify(struct rte_eth_dev *dev);
 int mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq);
-void txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);
-void txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl);
+void mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl);
+void mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl);
 uint64_t mlx5_get_tx_port_offloads(struct rte_eth_dev *dev);
 void mlx5_txq_dynf_timestamp_set(struct rte_eth_dev *dev);
 int mlx5_count_aggr_ports(struct rte_eth_dev *dev);
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index ad15b20e7b9..5219642c7db 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -40,7 +40,7 @@
  *   Pointer to TX queue structure.
  */
 void
-txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl)
+mlx5_txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl)
 {
 	const unsigned int elts_n = 1 << txq_ctrl->txq.elts_n;
 	unsigned int i;
@@ -61,7 +61,7 @@ txq_alloc_elts(struct mlx5_txq_ctrl *txq_ctrl)
  *   Pointer to TX queue structure.
  */
 void
-txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl)
+mlx5_txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl)
 {
 	const uint16_t elts_n = 1 << txq_ctrl->txq.elts_n;
 	const uint16_t elts_m = elts_n - 1;
@@ -206,7 +206,7 @@ mlx5_tx_queue_stop_primary(struct rte_eth_dev *dev, uint16_t idx)
 	/* Handle all send completions. */
 	txq_sync_cq(txq);
 	/* Free elts stored in the SQ. */
-	txq_free_elts(txq_ctrl);
+	mlx5_txq_free_elts(txq_ctrl);
 	/* Prevent writing new pkts to SQ by setting no free WQE.*/
 	txq->wqe_ci = txq->wqe_s;
 	txq->wqe_pi = 0;
@@ -1349,7 +1349,7 @@ mlx5_txq_release(struct rte_eth_dev *dev, uint16_t idx)
 			mlx5_free(txq_ctrl->txq.fcqs);
 			txq_ctrl->txq.fcqs = NULL;
 		}
-		txq_free_elts(txq_ctrl);
+		mlx5_txq_free_elts(txq_ctrl);
 		dev->data->tx_queue_state[idx] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
 	if (!rte_atomic_load_explicit(&txq_ctrl->refcnt, rte_memory_order_relaxed)) {
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.c b/drivers/net/mlx5/windows/mlx5_flow_os.c
index 15c6fc56133..48d9f8520e0 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.c
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.c
@@ -303,7 +303,7 @@ mlx5_clear_thread_list(void)
 			} else if (temp == curr) {
 				curr = prev;
 			}
-			flow_release_workspace(temp->mlx5_ws);
+			mlx5_flow_release_workspace(temp->mlx5_ws);
 			CloseHandle(temp->thread_handle);
 			free(temp);
 			if (prev)
@@ -326,7 +326,7 @@ mlx5_flow_os_release_workspace(void)
 	mlx5_clear_thread_list();
 	if (first) {
 		MLX5_ASSERT(!first->next);
-		flow_release_workspace(first->mlx5_ws);
+		mlx5_flow_release_workspace(first->mlx5_ws);
 		free(first);
 	}
 	rte_thread_key_delete(ws_tls_index);
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 4a00c280095..4250ac38b0c 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -596,7 +596,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 		}
 	}
 	if (sh->cdev->config.devx) {
-		priv->obj_ops = devx_obj_ops;
+		priv->obj_ops = mlx5_devx_obj_ops;
 	} else {
 		DRV_LOG(ERR, "Windows flow must be DevX.");
 		err = ENOTSUP;
-- 
2.21.0

