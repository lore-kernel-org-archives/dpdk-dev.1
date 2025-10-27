Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A73CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 19:37:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CDC4028C;
	Mon, 27 Oct 2025 20:37:54 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8736C4021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 20:37:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYdRLRcr1WV0zsaoLm1MktIOQKdRjS7qZWaK2vk7cNp62gF+gk+SGvqqRACd88AtrMBfNrb5TKNxdL3OfTRwdjvsmuxAhAaGBZhZD/6utnCqpL/S8EQTxSse25c1FEfr1Df9sxW2VDT8hYCRs1YAc5W92Ef/n5iHleBtypZlcey1OdCu6RR6sfaYIEkqKGzIv+Hesc1PEi3T8bYfO0NWY9i9uLCmVfe7QmCJTZyxm4YNZ8KSEMK+Qzw3tpyXU8RH2L/4WMuLECemxSQxPcGbHA8Xm+C1AsMtGFHlQ5oK746oe32Ldxtt6zOQjiPNIRyKA2sfbrp8NE9vF0JZuVvXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQPUdkaKr9xS1IfWqAONT6BtsOQAkfpkQaxEn4Jm3F8=;
 b=XfjUERsQPTiH83h7dF2wvUqNVeU9R7s0bX9gvhs2mGtdUV2W9cbQ/g682FpLaXiKDUUUiQFe2chZudoYpreK9zmFRpAehAau/8loboM4ChCkbtRHLJGhCXj1ykzDjtcgmYdUO2MBqIw6+d+ggNIfVCF6YiKofP9w6Bplmevdu6CdNQ0E4BPfPnZ696osHOCI2aG+OTfDgrm9H9KE/AIOxX8EqDNUY+T5g1MBJOOPxKw0NwkRMIHIRZ0yrUEfhycP56rmFmzyGelRdpG2pOpOpPPIbkhKCfnD4ZFhcxdaDNeMmVHiF2KV4LxvohyI4ZXEabNmg01rfIHPrvGJ57eJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQPUdkaKr9xS1IfWqAONT6BtsOQAkfpkQaxEn4Jm3F8=;
 b=qKZE2qFCGAx7Ptrje3e+rHcpvATANPUT3yj4wFr4rFOCeqesix+lMLk9UhP1Uq0AWnkWQZkxyqcCS5Ni3P1GTj0ixcVk31ecMxZPxWxRo+LepVYuQ40n/NRq2Q7oqTB1lhc/MBZR/151Q9YXB5ZXP4C4xHrNsBNOwlAUKHO76WTQIlkcf1woqVPOU+/2jPCC33t7Xp5+9FzzKqI9R1/uV2TRm+Ma2WVi33xqNv0Mtc37xWy8aeLgESsCdT8bvW+hxFlIl0zW/pzz7xSfZtjWw9quWVhOYq+FNBizKhkRFHEkWjB8NI9ZIZO0jeojaZa4GXOIUb11nyYl/Q8x+Y5XaQ==
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 19:37:43 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::f9) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 19:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 19:37:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 12:37:26 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 12:37:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: remove representor matching devarg
Date: Mon, 27 Oct 2025 20:35:58 +0100
Message-ID: <20251027193558.770297-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: ef623cd9-eb80-45ba-4cf7-08de15904c1b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?afzc4Yjx+RLzq71ObGyBCs5FmX5a3N7vnip5lVILQf/wYy7l4B8Oo2SvuYEq?=
 =?us-ascii?Q?acLokJUA4Eb2ZvRsNepi/5fEI19BsXROj7uUkYiP5tAkaYePcjSj/eSIU8v8?=
 =?us-ascii?Q?7ieGkg+gLr0ggyta6s3P1L+LdpOJtcfWLidJaBLBW6uJj7IK19zEheKEYT1d?=
 =?us-ascii?Q?67Iymv7wK+wW/c4U6IV7mz7VLSDPIPod/FVZJAWSMERHrXW2c4BUngJVrY2N?=
 =?us-ascii?Q?7ophx5rbAVYCP0tTUDn5lzg6ZMaW45qJ/mK2YuMfQl9oZndwyDSwSJ0zKwxS?=
 =?us-ascii?Q?PS9Ce60ukWDdb2dgeI7QGR6ryedNsakGzgFl21Jg1RB3rJf0DQuNFY1SfeBT?=
 =?us-ascii?Q?Nl935BhrJWFzvVI6oFxHAZH3l78oILbaIcWrEY4YXhlwgw9GwriAXrAlmVEB?=
 =?us-ascii?Q?rKxAqMad/ZOylWub/KHNTPaCfBK/3FnhSIvQZvwbeI1cpAtFlHWNyJuFbnMN?=
 =?us-ascii?Q?8iSslDGSc3x9fbrXOq2Dtkx3SBQngev7EFu+5/LEUgJKbHmRxmBz26Tlq5oi?=
 =?us-ascii?Q?CDHCsntIxQW2OAPYZkyA2KEWpx9JM25LSsPCIsO9JMPcKhGZL9iaBqpDpRvW?=
 =?us-ascii?Q?1rpZT6ZePUfJRWqLLZeps4ZuLPTG45z7wgac8ViqezkVu2XwUlUOWMAIZ5PO?=
 =?us-ascii?Q?XO/k2kjcwJKk8EXaUHCDWQHBMWj9qx76F93mgDn9WYgcOJGUWsUJqR30QgfB?=
 =?us-ascii?Q?qxCizMkfr135qaKdnI9lt/JICikTLljGiX1FB5e7kLomutcMPzU5lpNHxoeI?=
 =?us-ascii?Q?mdgwzgeqZUHW8GErgnI2Nr01BYu6jkSmww0PWfSwp1eV1CFJfaXwuxoC/dEo?=
 =?us-ascii?Q?ntLfkbHHZr7HfJEN+NbjTgiCHfYCm+lDv2B3tR5x0HmR24amXGF92w9XoT6t?=
 =?us-ascii?Q?q6xVzFbiI0lKZUrIJETdqqJFFkYSGSbVuWYtX5GCCBRcH7WUOri9a+3NFyLf?=
 =?us-ascii?Q?3AEL5y7CKjZVPez97s7nxNiHoA/Tb397KecnA3XCrCDr7ProtkywJhl9vgrz?=
 =?us-ascii?Q?hok2wi4RIPjh0yWSFKjJYJNQP2Mh2TVyQYx1bhbGMim+D9GVMH95kPduN6yx?=
 =?us-ascii?Q?uf+ryZGzPBF9T3kEvCyBS1OU7zsvd4M7S+za3CoQglU41w79+T2Fcla5M9bE?=
 =?us-ascii?Q?0BBvTE3l2GVvYhFoEfyKR30ZTFkEjsw4Z8qXpANWec1hbISKucpXVSqKvETV?=
 =?us-ascii?Q?GAxakXtbcXFKXupGdl34gCjoMMbNBcTWT0rMI7QoVnXl9i2WKDmp/FlAoAb0?=
 =?us-ascii?Q?c6u7qc1l7VrY2tmkbISES3n/yonYZ+9g0qYH/me4WxFNuMpnPlvcHfdN/vtm?=
 =?us-ascii?Q?8WC/nFDiqeEsIQp5JX/DG3UNOFIb5AIicCNvN4AcxWSy2V5RsnZcQgUEQRQY?=
 =?us-ascii?Q?ev73mAJVOXrwcO2ApUVti3CihjrZBfKyiKR6Wf97NfAtk+JpNpxqrmUN79Hc?=
 =?us-ascii?Q?iDsXo+meftB86JdPt/ffWldkEIC9mj8SO+LAPJn6O/4nR8908oGST+GLqWQk?=
 =?us-ascii?Q?XhJJ1VBqmwgNZOvcRwxmB1ZMoAYI5YKot7A28gIJxGQrOXWQzAttesEHTdud?=
 =?us-ascii?Q?sQWk78aXNeUhUw3MZrA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 19:37:42.8040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef623cd9-eb80-45ba-4cf7-08de15904c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

As announced in 25.07 release deprecation notice [1],
this patch removes repr_matching_en device argument from mlx5 driver.

Applications which disabled this option were able to receive traffic
from any physical port/VF/SF on any representor.
Specifically, in most cases, this was used to process all traffic
on representor which is a transfer proxy port.
Similar behavior in mlx5 PMD can be achieved without
the use of additional device arguments, by using
RTE_FLOW_ACTION_TYPE_RSS flow action in transfer flow rules.

[1] https://doc.dpdk.org/guides-25.07/rel_notes/deprecation.html

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst               |  26 +--
 doc/guides/rel_notes/deprecation.rst   |  11 -
 doc/guides/rel_notes/release_25_11.rst |   8 +
 drivers/net/mlx5/linux/mlx5_os.c       |  16 --
 drivers/net/mlx5/mlx5.c                |  13 --
 drivers/net/mlx5/mlx5.h                |   1 -
 drivers/net/mlx5/mlx5_flow.c           |   5 +-
 drivers/net/mlx5/mlx5_flow.h           |   4 -
 drivers/net/mlx5/mlx5_flow_hw.c        | 266 +------------------------
 drivers/net/mlx5/mlx5_trigger.c        |  20 +-
 drivers/net/mlx5/mlx5_txq.c            |   3 +-
 11 files changed, 19 insertions(+), 354 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20056f61d6..d248f5a6c3 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -744,24 +744,6 @@ for an additional list of options shared with other mlx5 drivers.
 
     <Primary_PCI_BDF>,representor=pf[0,1]vf[0-2]
 
-- ``repr_matching_en`` parameter [int]
-
-  - 0. If representor matching is disabled, then there will be no implicit
-    item added. As a result, ingress flow rules will match traffic
-    coming to any port, not only the port on which flow rule is created.
-    Because of that, default flow rules for ingress traffic cannot be created
-    and port starts in isolated mode by default. Port cannot be switched back
-    to non-isolated mode.
-
-  - 1. If representor matching is enabled (default setting),
-    then each ingress pattern template has an implicit REPRESENTED_PORT
-    item added. Flow rules based on this pattern template will match
-    the vport associated with port on which rule is created.
-
-  .. note::
-
-     This parameter is deprecated and will be removed in future releases.
-
 - ``max_dump_files_num`` parameter [int]
 
   The maximum number of files per PMD entity that may be created for debug information.
@@ -2342,7 +2324,6 @@ Runtime configuration
 
 The behaviour of port representors is configured
 with some :ref:`parameters <mlx5_representor_params>`.
-The option ``repr_matching_en`` has an impact on flow steering.
 
 Limitations
 ^^^^^^^^^^^
@@ -2352,9 +2333,6 @@ Limitations
 #. A driver limitation for ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR`` action
    restricts the ``port_id`` configuration to only accept the value ``0xffff``,
    indicating the E-Switch manager.
-   If the ``repr_matching_en`` parameter is enabled, the traffic will be directed
-   to the representor of the source virtual port (SF/VF), while if it is disabled,
-   the traffic will be routed based on the steering rules in the ingress domain.
 
 Examples
 ^^^^^^^^
@@ -3183,8 +3161,8 @@ Limitations
 
 #. Only single item is supported per pattern template.
 
-#. In switch mode, when ``repr_matching_en`` is enabled (default setting),
-   matching ``RTE_FLOW_ITEM_TYPE_COMPARE`` is not supported for ``ingress`` rules.
+#. In switch mode, ``RTE_FLOW_ITEM_TYPE_COMPARE`` flow item
+   is not supported for ``ingress`` rules.
    This is because an implicit ``RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT``
    needs to be added to the matcher,
    which conflicts with the single item limitation.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 1e60ac4e82..8653d6ca03 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -147,14 +147,3 @@ Deprecation Notices
   This change will not result in any feature loss,
   as the fallback scalar paths which have feature parity with SSE
   will be used in the cases where the SSE paths would have been used.
-
-* net/mlx5: ``repr_matching_en`` device argument is deprecated
-  and will be removed in DPDK 25.11 release.
-  With disabled representor matching, behavior of Rx datapath in mlx5 PMD
-  is incompatible with current DPDK representor model.
-  Packets from any E-Switch port can arrive on any representor,
-  depending only on created flow rules.
-  Such working model should be exposed directly in DPDK ethdev API,
-  without relying on flow API.
-  Currently there is no alternative API
-  providing the same functionality as with ``repr_matching_en`` set to 0.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..ce2d72a411 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -197,6 +197,14 @@ Removed Items
   the functions ``rte_tel_data_add_array_u64`` and ``rte_tel_data_add_dict_u64`` are removed.
   They are replaced by ``rte_tel_data_add_array_uint`` and ``rte_tel_data_add_dict_uint`` respectively.
 
+* net/mlx5: ``repr_matching_en`` device argument has been removed.
+  Applications which disabled this option were able to receive traffic
+  from any physical port/VF/SF on any representor.
+  Specifically, in most cases, this was used to process all traffic on representor
+  which is a transfer proxy port.
+  Similar behavior in mlx5 PMD can be achieved without the use of additional device arguments,
+  by using ``RTE_FLOW_ACTION_TYPE_RSS`` flow action in transfer flow rules.
+
 
 API Changes
 -----------
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 8d11b1ac3a..83d3051fb8 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1777,22 +1777,6 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			err = EINVAL;
 			goto error;
 		}
-		/*
-		 * If representor matching is disabled, PMD cannot create default flow rules
-		 * to receive traffic for all ports, since implicit source port match is not added.
-		 * Isolated mode is forced.
-		 */
-		if (priv->sh->config.dv_esw_en && !priv->sh->config.repr_matching) {
-			err = mlx5_flow_isolate(eth_dev, 1, NULL);
-			if (err < 0) {
-				err = -err;
-				goto error;
-			}
-			DRV_LOG(WARNING, "port %u ingress traffic is restricted to defined "
-					 "flow rules (isolated mode) since representor "
-					 "matching is disabled",
-				eth_dev->data->port_id);
-		}
 		eth_dev->data->dev_flags |= RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
 		return eth_dev;
 #else
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b018a4f0e2..0504fc2366 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -182,9 +182,6 @@
 /* HW steering counter's query interval. */
 #define MLX5_HWS_CNT_CYCLE_TIME "svc_cycle_time"
 
-/* Device parameter to control representor matching in ingress/egress flows with HWS. */
-#define MLX5_REPR_MATCHING_EN "repr_matching_en"
-
 /*
  * Alignment of the Tx queue starting address,
  * If not set, using separate umem and MR for each TxQ.
@@ -1435,8 +1432,6 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 		config->cnt_svc.service_core = tmp;
 	} else if (strcmp(MLX5_HWS_CNT_CYCLE_TIME, key) == 0) {
 		config->cnt_svc.cycle_time = tmp;
-	} else if (strcmp(MLX5_REPR_MATCHING_EN, key) == 0) {
-		config->repr_matching = !!tmp;
 	} else if (strcmp(MLX5_TXQ_MEM_ALGN, key) == 0) {
 		config->txq_mem_algn = (uint32_t)tmp;
 	}
@@ -1477,7 +1472,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		MLX5_FDB_DEFAULT_RULE_EN,
 		MLX5_HWS_CNT_SERVICE_CORE,
 		MLX5_HWS_CNT_CYCLE_TIME,
-		MLX5_REPR_MATCHING_EN,
 		MLX5_TXQ_MEM_ALGN,
 		NULL,
 	};
@@ -1500,7 +1494,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
-	config->repr_matching = 1;
 	config->txq_mem_algn = log2above(alignment);
 	if (mkvlist != NULL) {
 		/* Process parameters. */
@@ -1535,11 +1528,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 			config->dv_xmeta_en);
 		config->dv_xmeta_en = MLX5_XMETA_MODE_LEGACY;
 	}
-	if (config->dv_flow_en != 2 && !config->repr_matching) {
-		DRV_LOG(DEBUG, "Disabling representor matching is valid only "
-			       "when HW Steering is enabled.");
-		config->repr_matching = 1;
-	}
 	if (config->tx_pp && !sh->dev_cap.txpp_en) {
 		DRV_LOG(ERR, "Packet pacing is not supported.");
 		rte_errno = ENODEV;
@@ -1594,7 +1582,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	DRV_LOG(DEBUG, "\"allow_duplicate_pattern\" is %u.",
 		config->allow_duplicate_pattern);
 	DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
-	DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.", config->repr_matching);
 	DRV_LOG(DEBUG, "\"txq_mem_algn\" is %u.", config->txq_mem_algn);
 	return 0;
 }
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 07418b0922..44ceb76c08 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -397,7 +397,6 @@ struct mlx5_sh_config {
 	uint32_t lro_allowed:1; /* Whether LRO is allowed. */
 	/* Allow/Prevent the duplicate rules pattern. */
 	uint32_t fdb_def_rule:1; /* Create FDB default jump rule */
-	uint32_t repr_matching:1; /* Enable implicit vport matching in HWS FDB. */
 	uint32_t txq_mem_algn; /* logarithm value of the TxQ address alignment. */
 	struct {
 		uint16_t service_core;
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 1de398982a..a612f1f7cf 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8793,10 +8793,7 @@ mlx5_flow_isolate(struct rte_eth_dev *dev,
 				   "port must be stopped first");
 		return -rte_errno;
 	}
-	if (!enable && !priv->sh->config.repr_matching)
-		return rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-					  "isolated mode cannot be disabled when "
-					  "representor matching is disabled");
+
 	priv->isolated = !!enable;
 	if (enable)
 		dev->dev_ops = &mlx5_dev_ops_isolate;
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index ff61706054..9bca014fc6 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3007,9 +3007,6 @@ struct mlx5_flow_hw_ctrl_fdb {
 	struct rte_flow_pattern_template *port_items_tmpl;
 	struct rte_flow_actions_template *jump_one_actions_tmpl;
 	struct rte_flow_template_table *hw_esw_zero_tbl;
-	struct rte_flow_pattern_template *tx_meta_items_tmpl;
-	struct rte_flow_actions_template *tx_meta_actions_tmpl;
-	struct rte_flow_template_table *hw_tx_meta_cpy_tbl;
 	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
 	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
 	struct rte_flow_template_table *hw_lacp_rx_tbl;
@@ -3582,7 +3579,6 @@ int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,
 int mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
 					  uint32_t sqn);
 int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev);
-int mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev);
 int mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external);
 int mlx5_flow_hw_lacp_rx_flow(struct rte_eth_dev *dev);
 int mlx5_flow_actions_validate(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 491a78a0de..f5f73b38cd 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5305,7 +5305,7 @@ __translate_group(struct rte_eth_dev *dev,
 						  "group index not supported");
 		*table_group = group + 1;
 	} else if (config->dv_esw_en &&
-		   (config->repr_matching || config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) &&
+		   config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 		   external &&
 		   flow_attr->egress) {
 		/*
@@ -8549,7 +8549,7 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			break;
 		}
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
-			if (attr->ingress && priv->sh->config.repr_matching)
+			if (attr->ingress)
 				return rte_flow_error_set(error, EINVAL,
 						  RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 						  "represented port item cannot be used"
@@ -9024,14 +9024,12 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		return NULL;
 	orig_item_nb = rc;
 	if (priv->sh->config.dv_esw_en &&
-	    priv->sh->config.repr_matching &&
 	    attr->ingress && !attr->egress && !attr->transfer) {
 		copied_items = flow_hw_prepend_item(items, orig_item_nb, &port, error);
 		if (!copied_items)
 			return NULL;
 		tmpl_items = copied_items;
 	} else if (priv->sh->config.dv_esw_en &&
-		   priv->sh->config.repr_matching &&
 		   !attr->ingress && attr->egress && !attr->transfer) {
 		if (item_flags & MLX5_FLOW_ITEM_SQ) {
 			DRV_LOG(DEBUG, "Port %u omitting implicit REG_C_0 match for egress "
@@ -9979,7 +9977,6 @@ flow_hw_setup_tx_repr_tagging(struct rte_eth_dev *dev, struct rte_flow_error *er
 	};
 
 	MLX5_ASSERT(priv->sh->config.dv_esw_en);
-	MLX5_ASSERT(priv->sh->config.repr_matching);
 	priv->hw_tx_repr_tagging_pt =
 		flow_hw_create_tx_repr_sq_pattern_tmpl(dev, error);
 	if (!priv->hw_tx_repr_tagging_pt)
@@ -10158,46 +10155,6 @@ flow_hw_create_ctrl_port_pattern_template(struct rte_eth_dev *dev,
 	return flow_hw_pattern_template_create(dev, &attr, items, error);
 }
 
-/*
- * Creating a flow pattern template with all ETH packets matching.
- * This template is used to set up a table for default Tx copy (Tx metadata
- * to REG_C_1) flow rule usage.
- *
- * @param dev
- *   Pointer to Ethernet device.
- * @param error
- *   Pointer to error structure.
- *
- * @return
- *   Pointer to flow pattern template on success, NULL otherwise.
- */
-static struct rte_flow_pattern_template *
-flow_hw_create_tx_default_mreg_copy_pattern_template(struct rte_eth_dev *dev,
-						     struct rte_flow_error *error)
-{
-	struct rte_flow_pattern_template_attr tx_pa_attr = {
-		.relaxed_matching = 0,
-		.egress = 1,
-	};
-	struct rte_flow_item_eth promisc = {
-		.hdr.dst_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.src_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.ether_type = 0,
-	};
-	struct rte_flow_item eth_all[] = {
-		[0] = {
-			.type = RTE_FLOW_ITEM_TYPE_ETH,
-			.spec = &promisc,
-			.mask = &promisc,
-		},
-		[1] = {
-			.type = RTE_FLOW_ITEM_TYPE_END,
-		},
-	};
-
-	return flow_hw_pattern_template_create(dev, &tx_pa_attr, eth_all, error);
-}
-
 /*
  * Creating a flow pattern template with all LACP packets matching, only for NIC
  * ingress domain.
@@ -10419,90 +10376,6 @@ flow_hw_create_ctrl_port_actions_template(struct rte_eth_dev *dev,
 	return flow_hw_actions_template_create(dev, &attr, actions_v, actions_m, error);
 }
 
-/*
- * Creating an actions template to use header modify action for register
- * copying. This template is used to set up a table for copy flow.
- *
- * @param dev
- *   Pointer to Ethernet device.
- * @param error
- *   Pointer to error structure.
- *
- * @return
- *   Pointer to flow actions template on success, NULL otherwise.
- */
-static struct rte_flow_actions_template *
-flow_hw_create_tx_default_mreg_copy_actions_template(struct rte_eth_dev *dev,
-						     struct rte_flow_error *error)
-{
-	struct rte_flow_actions_template_attr tx_act_attr = {
-		.egress = 1,
-	};
-	const struct rte_flow_action_modify_field mreg_action = {
-		.operation = RTE_FLOW_MODIFY_SET,
-		.dst = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.tag_index = REG_C_1,
-		},
-		.src = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.tag_index = REG_A,
-		},
-		.width = 32,
-	};
-	const struct rte_flow_action_modify_field mreg_mask = {
-		.operation = RTE_FLOW_MODIFY_SET,
-		.dst = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.level = UINT8_MAX,
-			.tag_index = UINT8_MAX,
-			.offset = UINT32_MAX,
-		},
-		.src = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.level = UINT8_MAX,
-			.tag_index = UINT8_MAX,
-			.offset = UINT32_MAX,
-		},
-		.width = UINT32_MAX,
-	};
-	const struct rte_flow_action_jump jump_action = {
-		.group = 1,
-	};
-	const struct rte_flow_action_jump jump_mask = {
-		.group = UINT32_MAX,
-	};
-	const struct rte_flow_action actions[] = {
-		[0] = {
-			.type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
-			.conf = &mreg_action,
-		},
-		[1] = {
-			.type = RTE_FLOW_ACTION_TYPE_JUMP,
-			.conf = &jump_action,
-		},
-		[2] = {
-			.type = RTE_FLOW_ACTION_TYPE_END,
-		},
-	};
-	const struct rte_flow_action masks[] = {
-		[0] = {
-			.type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
-			.conf = &mreg_mask,
-		},
-		[1] = {
-			.type = RTE_FLOW_ACTION_TYPE_JUMP,
-			.conf = &jump_mask,
-		},
-		[2] = {
-			.type = RTE_FLOW_ACTION_TYPE_END,
-		},
-	};
-
-	return flow_hw_actions_template_create(dev, &tx_act_attr, actions,
-					       masks, error);
-}
-
 /*
  * Creating an actions template to use default miss to re-route packets to the
  * kernel driver stack.
@@ -10616,43 +10489,6 @@ flow_hw_create_ctrl_sq_miss_table(struct rte_eth_dev *dev,
 	return flow_hw_table_create(dev, &cfg, &it, 1, &at, 1, error);
 }
 
-/*
- * Creating the default Tx metadata copy table on NIC Tx group 0.
- *
- * @param dev
- *   Pointer to Ethernet device.
- * @param pt
- *   Pointer to flow pattern template.
- * @param at
- *   Pointer to flow actions template.
- * @param error
- *   Pointer to error structure.
- *
- * @return
- *   Pointer to flow table on success, NULL otherwise.
- */
-static struct rte_flow_template_table*
-flow_hw_create_tx_default_mreg_copy_table(struct rte_eth_dev *dev,
-					  struct rte_flow_pattern_template *pt,
-					  struct rte_flow_actions_template *at,
-					  struct rte_flow_error *error)
-{
-	struct rte_flow_template_table_attr tx_tbl_attr = {
-		.flow_attr = {
-			.group = 0, /* Root */
-			.priority = MLX5_HW_LOWEST_PRIO_ROOT,
-			.egress = 1,
-		},
-		.nb_flows = 1, /* One default flow rule for all. */
-	};
-	struct mlx5_flow_template_table_cfg tx_tbl_cfg = {
-		.attr = tx_tbl_attr,
-		.external = false,
-	};
-
-	return flow_hw_table_create(dev, &tx_tbl_cfg, &pt, 1, &at, 1, error);
-}
-
 /**
  * Creates a control flow table used to transfer traffic
  * from group 0 to group 1.
@@ -10718,15 +10554,6 @@ flow_hw_cleanup_ctrl_fdb_tables(struct rte_eth_dev *dev)
 	if (hw_ctrl_fdb->lacp_rx_items_tmpl)
 		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb->lacp_rx_items_tmpl,
 			   NULL));
-	/* Clean up templates used for default Tx metadata copy. */
-	if (hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
-		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb->hw_tx_meta_cpy_tbl, NULL));
-	if (hw_ctrl_fdb->tx_meta_actions_tmpl)
-		claim_zero(flow_hw_actions_template_destroy(dev, hw_ctrl_fdb->tx_meta_actions_tmpl,
-			   NULL));
-	if (hw_ctrl_fdb->tx_meta_items_tmpl)
-		claim_zero(flow_hw_pattern_template_destroy(dev, hw_ctrl_fdb->tx_meta_items_tmpl,
-			   NULL));
 	/* Clean up templates used for default FDB jump rule. */
 	if (hw_ctrl_fdb->hw_esw_zero_tbl)
 		claim_zero(flow_hw_table_destroy(dev, hw_ctrl_fdb->hw_esw_zero_tbl, NULL));
@@ -10813,8 +10640,6 @@ flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb;
-	uint32_t xmeta = priv->sh->config.dv_xmeta_en;
-	uint32_t repr_matching = priv->sh->config.repr_matching;
 	uint32_t fdb_def_rule = priv->sh->config.fdb_def_rule;
 
 	MLX5_ASSERT(priv->hw_ctrl_fdb == NULL);
@@ -10900,32 +10725,6 @@ flow_hw_create_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *error
 			goto err;
 		}
 	}
-	/* Create templates and table for default Tx metadata copy flow rule. */
-	if (!repr_matching && xmeta == MLX5_XMETA_MODE_META32_HWS) {
-		hw_ctrl_fdb->tx_meta_items_tmpl =
-			flow_hw_create_tx_default_mreg_copy_pattern_template(dev, error);
-		if (!hw_ctrl_fdb->tx_meta_items_tmpl) {
-			DRV_LOG(ERR, "port %u failed to Tx metadata copy pattern"
-				" template for control flows", dev->data->port_id);
-			goto err;
-		}
-		hw_ctrl_fdb->tx_meta_actions_tmpl =
-			flow_hw_create_tx_default_mreg_copy_actions_template(dev, error);
-		if (!hw_ctrl_fdb->tx_meta_actions_tmpl) {
-			DRV_LOG(ERR, "port %u failed to Tx metadata copy actions"
-				" template for control flows", dev->data->port_id);
-			goto err;
-		}
-		hw_ctrl_fdb->hw_tx_meta_cpy_tbl =
-			flow_hw_create_tx_default_mreg_copy_table
-				(dev, hw_ctrl_fdb->tx_meta_items_tmpl,
-				 hw_ctrl_fdb->tx_meta_actions_tmpl, error);
-		if (!hw_ctrl_fdb->hw_tx_meta_cpy_tbl) {
-			DRV_LOG(ERR, "port %u failed to create table for default"
-				" Tx metadata copy flow rule", dev->data->port_id);
-			goto err;
-		}
-	}
 	/* Create LACP default miss table. */
 	if (!priv->sh->config.lacp_by_user && priv->pf_bond >= 0 && priv->master) {
 		hw_ctrl_fdb->lacp_rx_items_tmpl =
@@ -12105,7 +11904,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (!priv->hw_tag[i])
 			goto err;
 	}
-	if (priv->sh->config.dv_esw_en && priv->sh->config.repr_matching) {
+	if (priv->sh->config.dv_esw_en) {
 		ret = flow_hw_setup_tx_repr_tagging(dev, error);
 		if (ret)
 			goto err;
@@ -16003,63 +15802,6 @@ mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev)
 					items, 0, actions, 0, &flow_info, false);
 }
 
-int
-mlx5_flow_hw_create_tx_default_mreg_copy_flow(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct rte_flow_item_eth promisc = {
-		.hdr.dst_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.src_addr.addr_bytes = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-		.hdr.ether_type = 0,
-	};
-	struct rte_flow_item eth_all[] = {
-		[0] = {
-			.type = RTE_FLOW_ITEM_TYPE_ETH,
-			.spec = &promisc,
-			.mask = &promisc,
-		},
-		[1] = {
-			.type = RTE_FLOW_ITEM_TYPE_END,
-		},
-	};
-	struct rte_flow_action_modify_field mreg_action = {
-		.operation = RTE_FLOW_MODIFY_SET,
-		.dst = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.tag_index = REG_C_1,
-		},
-		.src = {
-			.field = (enum rte_flow_field_id)MLX5_RTE_FLOW_FIELD_META_REG,
-			.tag_index = REG_A,
-		},
-		.width = 32,
-	};
-	struct rte_flow_action copy_reg_action[] = {
-		[0] = {
-			.type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
-			.conf = &mreg_action,
-		},
-		[1] = {
-			.type = RTE_FLOW_ACTION_TYPE_JUMP,
-		},
-		[2] = {
-			.type = RTE_FLOW_ACTION_TYPE_END,
-		},
-	};
-	struct mlx5_ctrl_flow_info flow_info = {
-		.type = MLX5_CTRL_FLOW_TYPE_TX_META_COPY,
-	};
-
-	MLX5_ASSERT(priv->master);
-	if (!priv->dr_ctx ||
-	    !priv->hw_ctrl_fdb ||
-	    !priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
-		return 0;
-	return flow_hw_create_ctrl_flow(dev, dev,
-					priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl,
-					eth_all, 0, copy_reg_action, 0, &flow_info, false);
-}
-
 int
 mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
 {
@@ -16091,8 +15833,6 @@ mlx5_flow_hw_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool e
 		.tx_repr_sq = sqn,
 	};
 
-	/* It is assumed that caller checked for representor matching. */
-	MLX5_ASSERT(priv->sh->config.repr_matching);
 	if (!priv->dr_ctx) {
 		DRV_LOG(DEBUG, "Port %u must be configured for HWS, before creating "
 			       "default egress flow rules. Omitting creation.",
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 916ac03c16..343fb844ad 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1132,9 +1132,9 @@ mlx5_hw_representor_port_allowed_start(struct rte_eth_dev *dev)
 		rte_errno = EAGAIN;
 		return -rte_errno;
 	}
-	if (priv->sh->config.repr_matching && !priv->dr_ctx) {
-		DRV_LOG(ERR, "Failed to start port %u: with representor matching enabled, port "
-			     "must be configured for HWS", dev->data->port_id);
+	if (priv->dr_ctx == NULL) {
+		DRV_LOG(ERR, "Failed to start port %u: port must be configured for HWS",
+			dev->data->port_id);
 		rte_errno = EINVAL;
 		return -rte_errno;
 	}
@@ -1606,18 +1606,6 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 	unsigned int i;
 	int ret;
 
-	/*
-	 * With extended metadata enabled, the Tx metadata copy is handled by default
-	 * Tx tagging flow rules, so default Tx flow rule is not needed. It is only
-	 * required when representor matching is disabled.
-	 */
-	if (config->dv_esw_en &&
-	    !config->repr_matching &&
-	    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-	    priv->master) {
-		if (mlx5_flow_hw_create_tx_default_mreg_copy_flow(dev))
-			goto error;
-	}
 	for (i = 0; i < priv->txqs_n; ++i) {
 		struct mlx5_txq_ctrl *txq = mlx5_txq_get(dev, i);
 		uint32_t queue;
@@ -1633,7 +1621,7 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 				goto error;
 			}
 		}
-		if (config->dv_esw_en && config->repr_matching) {
+		if (config->dv_esw_en) {
 			if (mlx5_flow_hw_tx_repr_matching_flow(dev, queue, false)) {
 				mlx5_txq_release(dev, i);
 				goto error;
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index b090d8274d..cd831f9728 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1453,8 +1453,7 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 			sq_miss_created = true;
 		}
 
-		if (priv->sh->config.repr_matching &&
-		    mlx5_flow_hw_tx_repr_matching_flow(dev, sq_num, true)) {
+		if (mlx5_flow_hw_tx_repr_matching_flow(dev, sq_num, true)) {
 			if (sq_miss_created)
 				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num);
 			return -rte_errno;
-- 
2.39.5

