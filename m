Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE9CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 13:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D1840671;
	Thu, 13 Nov 2025 14:18:47 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by mails.dpdk.org (Postfix) with ESMTP id 4392940151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 14:18:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L53UmsZhMBbG8hwqWXXk+WT+szmr9Jjx7AGnnml76EGU70Jazj+mBO0r6z5wk7LTaCuHSBZH1QI2dk9vmzYPUFtl+cS2oTUkyT6R35r02PB5oWk40hHjzjUEh1pB4HRAflDWzaS8iP/66d1uK05ffZk/zXcu0LukHw/fh4DMtwGTsi84IQ7Xoqjb+L0ZIQztzTYV+Ku0/q3Xz1kpMYQJLd26ghsAMZOclVQrAzhCTTR7ij219E/MRPX1iqwHcjnHWv4rX7lfLvX8YW8DogClCoE+X51el3rwBbVFOqMHuyb6oNAdnsDnxfs1wTlWaI/bmtHVHTjtypWp2rtwyVhsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+7ZrMgt7MbjjT1zQMdDvioVjSgZjgpU2gLNS4p5lZc=;
 b=eftB/hTs+FpAJ7mNzgbbrQzFjBzM8F2/TMoEciwWneCJdaE9EJ+HnA2n+rTnx3ugmbY4/xu69o3A3ahcRlPulQ4WYSCm+3/VcP4VdEwc8hupLI3z/bJ1ZDASb+CeeGAbAydxr0pGQokHqFhGXnl42oP9EvJWemfDJm4KNgzMJXcLKdvWQj2ilZOTPoUmrgURXbvdemH3eHvpmmV7UfvZyd0B9VeUK3i//GJCBPOOlZ7Am3sas96bmOBOjEqQxw164s9PRgJ5CUlUxaB+Ie3/pQdKqNFchYiF/JzbxvEvHIgvbWufsAALYVIIiNHGKi5TwEb7m13YwDQ2aCR6DNdcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+7ZrMgt7MbjjT1zQMdDvioVjSgZjgpU2gLNS4p5lZc=;
 b=Mbt9VyDE+/9lCs1+gqpgvFhYax9IDSp0WhzLj2m0aeS6gr6bkWOwAH7baxyYsvR8HQGoWJQFaTGkjo+o9BprJiiWAqlGPajDtbhTX0s6KyuVKvWgOG2k+imOwxYLWFO3FkcOUBlSbFHz0q/tr7KyOFY02FiUYfqUSmZS2Eu/Z34ruGPFkR1mcAI4K99h3/1VHKk91NjuLmUZy8/qwo6O/kGkhPpECZi/UEmiKnglvp+oL8DZkK3un9zc3F5c8FhNk3Ck/PwFkDQ8zrOPEA76xDrKtPMNTbFG7Adf32f/D3URlyquhM97srzY5Wx7mlhSBETzkOSI2bxDJYuuvm2MoA==
Received: from BYAPR06CA0010.namprd06.prod.outlook.com (2603:10b6:a03:d4::23)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:18:39 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d4) by BYAPR06CA0010.outlook.office365.com
 (2603:10b6:a03:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 13:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 13:18:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 05:18:15 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 05:18:12 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2] net/mlx5: remove representor matching devarg
Date: Thu, 13 Nov 2025 14:17:58 +0100
Message-ID: <20251113131758.1524043-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027193558.770297-1-dsosnowski@nvidia.com>
References: <20251027193558.770297-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeea5c0-ed9e-4ebd-7f76-08de22b7286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R8nY8yH/Zc3MQfwFhm947eLp5rq3BJmzah2LVZ4c5O78TRhVV8Gz78Gmybs8?=
 =?us-ascii?Q?9wOozZQIrtof3a25sTNaLFXyQnC+2LcX5n3nEik3b3DhPMCy1vwX+utvH3aT?=
 =?us-ascii?Q?wAi3lAM0KzsPGhO/SngCPzM1Z2zD4RDgF4IXW8R4JbsXORLRqLsH8NKK6keP?=
 =?us-ascii?Q?RG+9el5vBNblS07qMNsy+jgSomaW3Ndjph1dREp2ppdd6f0ELfjPBY3TIPxm?=
 =?us-ascii?Q?5ctC2mNd4MputUUuMjfydIyUayd5b0iKrGLMCalVH2LyRl3HLCQIo7uU/GAP?=
 =?us-ascii?Q?knfD5BMQwZELry+8D5h8YCZuF4Cx/zFhEzjJl17EPcis6yMsUS2Dh/n/gPzo?=
 =?us-ascii?Q?a9fjmy6ITGOBZEohF31zTWB47ufd6jZMymU+dzKSs2igyYWNbJGZI/4fiyGJ?=
 =?us-ascii?Q?ITs4504Bsjk6DIGdSmaUxhbZgwUjR5ijOzSJMwf+6QsyBlhIIAmNnfed5d6P?=
 =?us-ascii?Q?kFMbSZfGnyV0FYOCnKc0lnyZWhiwOAMTPn9I3hfKg05knXbbB3I3a16rLN2V?=
 =?us-ascii?Q?DR3PT9oeg0FihDWlPERvHrW+QX3JYWeo8rILpmFZviE2oI590lwb1deq3AwR?=
 =?us-ascii?Q?JDT+SN0LHN020XDEY67b42JkSWG44St/zyKjUZ2L7W16OXOqtdgccKCG5hCO?=
 =?us-ascii?Q?6zDdnfNUW+IZKvnedr2xpX33pELr4TIXhj2K6OAYSu2a+PjoboKXlsiAgnVs?=
 =?us-ascii?Q?YlvKcb3iJikkstqCPNOXiQrpBfRybj/cNJPBVoTt+rrPmJLZUmMASU3MJsUc?=
 =?us-ascii?Q?AfoyBJepeVvbjVE8INON+SGJVX8zW1bXo17KglhaKRXqZtB/HgO/HpkBqmTE?=
 =?us-ascii?Q?A0U35EIB9sRz7nRqb1eef5KU6vpE49sxBS+RveYVuAX8nvdn16Zy7yWqvMnw?=
 =?us-ascii?Q?oYgsFHlPr0aKQh7FtHF3jVQvXBieuNHynJNkbdkS4LIXmvGfwQuXVETQUQTD?=
 =?us-ascii?Q?RV5S2yFZS9Stm1I3Yjv6lJ0CZmoj5u40Ml2l4uJiJs/3wxtQaAfGBnH6rDQO?=
 =?us-ascii?Q?7TbQDvBtcZB0UdjB7gZLEmN3w7anfNbmmZxedS8PZAOjFMYTRzE+NV1KC/cu?=
 =?us-ascii?Q?VSUqrGVqzQKpgmitNDzlhliBbK0IzktlJDYmTLE0ro43pdMxSquKxSQ/+Ctt?=
 =?us-ascii?Q?Pcic9WaGxHZSmFH7gq83aiIVHfOvZjnV220H4id+YxHeHidkp/bNHcyeqPtQ?=
 =?us-ascii?Q?r0kBzTELhUriKOEkXz4ht9dLu/TyJBvqXisW1dLel9P/4sUh7DCbdGMYKGq4?=
 =?us-ascii?Q?LlTMxoDqsfCBcQ0Y9+fybB5jIgQtBgqiRpVlmofoaPcheJw/kRCsZwsWjVRX?=
 =?us-ascii?Q?zqXa+6l0WUNIzgEZskdhtNpRDmu5su7cq8S5nFdW+zV+Qswg6rwnt0zCGBR+?=
 =?us-ascii?Q?uDNet/VEf4u+09Xz9n08dGlmRm8kZtoaB7g8dd4nql8beDXruVZJNafEbMyx?=
 =?us-ascii?Q?R3mY1Q5HB84ONWHCS4MytHiEpaSIpzaPyizw7v/I6s/SXeFHGjhqzoad/DD6?=
 =?us-ascii?Q?YKP2HQnaE2Ii+YTpLeWZBWbYc37hA0Z/12YKQwQZo2zUIYijhvKYqnK2Exp9?=
 =?us-ascii?Q?lU+CEmzCyJgOVtqPRxo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 13:18:38.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeea5c0-ed9e-4ebd-7f76-08de22b7286a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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
Acked-by: Bing Zhao <bingz@nvidia.com>
---
v2:
- Rebased on top of the latest commit in next-net-mlx:
  commit ae657d56b1f0 ("doc: document non-template API limitations on top of HWS")

 doc/guides/nics/mlx5.rst               |  26 +---
 doc/guides/rel_notes/deprecation.rst   |  11 --
 doc/guides/rel_notes/release_25_11.rst |   8 +
 drivers/net/mlx5/linux/mlx5_os.c       |  16 --
 drivers/net/mlx5/mlx5.c                |  13 --
 drivers/net/mlx5/mlx5.h                |   1 -
 drivers/net/mlx5/mlx5_flow.c           |   5 +-
 drivers/net/mlx5/mlx5_flow.h           |   7 -
 drivers/net/mlx5/mlx5_flow_hw.c        | 194 +------------------------
 drivers/net/mlx5/mlx5_trigger.c        |  28 ++--
 drivers/net/mlx5/mlx5_txq.c            |  17 +--
 11 files changed, 25 insertions(+), 301 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index e0ec3e4f6f..6ec47a9fbc 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -745,24 +745,6 @@ for an additional list of options shared with other mlx5 drivers.

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
@@ -2388,7 +2370,6 @@ Runtime configuration

 The behaviour of port representors is configured
 with some :ref:`parameters <mlx5_representor_params>`.
-The option ``repr_matching_en`` has an impact on flow steering.

 Limitations
 ^^^^^^^^^^^
@@ -2398,9 +2379,6 @@ Limitations
 #. A driver limitation for ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR`` action
    restricts the ``port_id`` configuration to only accept the value ``0xffff``,
    indicating the E-Switch manager.
-   If the ``repr_matching_en`` parameter is enabled, the traffic will be directed
-   to the representor of the source virtual port (SF/VF), while if it is disabled,
-   the traffic will be routed based on the steering rules in the ingress domain.

 Examples
 ^^^^^^^^
@@ -3275,8 +3253,8 @@ Limitations

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
index 06bc200f25..fbcb2f5f38 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -239,6 +239,14 @@ Removed Items
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
index c742e0f282..68448f6554 100644
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
index 666216c21a..9ba4786c5b 100644
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
@@ -1432,8 +1429,6 @@ mlx5_dev_args_check_handler(const char *key, const char *val, void *opaque)
 		config->cnt_svc.service_core = tmp;
 	} else if (strcmp(MLX5_HWS_CNT_CYCLE_TIME, key) == 0) {
 		config->cnt_svc.cycle_time = tmp;
-	} else if (strcmp(MLX5_REPR_MATCHING_EN, key) == 0) {
-		config->repr_matching = !!tmp;
 	} else if (strcmp(MLX5_TXQ_MEM_ALGN, key) == 0) {
 		config->txq_mem_algn = (uint32_t)tmp;
 	}
@@ -1474,7 +1469,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 		MLX5_FDB_DEFAULT_RULE_EN,
 		MLX5_HWS_CNT_SERVICE_CORE,
 		MLX5_HWS_CNT_CYCLE_TIME,
-		MLX5_REPR_MATCHING_EN,
 		MLX5_TXQ_MEM_ALGN,
 		NULL,
 	};
@@ -1497,7 +1491,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	config->fdb_def_rule = 1;
 	config->cnt_svc.cycle_time = MLX5_CNT_SVC_CYCLE_TIME_DEFAULT;
 	config->cnt_svc.service_core = rte_get_main_lcore();
-	config->repr_matching = 1;
 	config->txq_mem_algn = log2above(alignment);
 	if (mkvlist != NULL) {
 		/* Process parameters. */
@@ -1532,11 +1525,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
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
@@ -1591,7 +1579,6 @@ mlx5_shared_dev_ctx_args_config(struct mlx5_dev_ctx_shared *sh,
 	DRV_LOG(DEBUG, "\"allow_duplicate_pattern\" is %u.",
 		config->allow_duplicate_pattern);
 	DRV_LOG(DEBUG, "\"fdb_def_rule_en\" is %u.", config->fdb_def_rule);
-	DRV_LOG(DEBUG, "\"repr_matching_en\" is %u.", config->repr_matching);
 	DRV_LOG(DEBUG, "\"txq_mem_algn\" is %u.", config->txq_mem_algn);
 	return 0;
 }
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7e4bfacd11..966e802f5f 100644
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
index ed67a90a22..2c48f1b01b 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8818,10 +8818,7 @@ mlx5_flow_isolate(struct rte_eth_dev *dev,
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
index e8b298dd1d..d7cc60f8d9 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3029,9 +3029,6 @@ struct mlx5_flow_hw_ctrl_fdb {
 	struct rte_flow_pattern_template *port_items_tmpl;
 	struct rte_flow_actions_template *jump_one_actions_tmpl;
 	struct rte_flow_template_table *hw_esw_zero_tbl;
-	struct rte_flow_pattern_template *tx_meta_items_tmpl;
-	struct rte_flow_actions_template *tx_meta_actions_tmpl;
-	struct rte_flow_template_table *hw_tx_meta_cpy_tbl;
 	struct rte_flow_pattern_template *lacp_rx_items_tmpl;
 	struct rte_flow_actions_template *lacp_rx_actions_tmpl;
 	struct rte_flow_template_table *hw_lacp_rx_tbl;
@@ -3610,11 +3607,7 @@ int mlx5_flow_hw_esw_create_sq_miss_flow(struct rte_eth_dev *dev,
 int mlx5_flow_hw_esw_destroy_sq_miss_flow(struct rte_eth_dev *dev,
 					  uint32_t sqn, bool external);
 int mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev);
-int mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
-						  uint32_t sqn, bool external);
 int mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn);
-int mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
-						   uint32_t sqn, bool external);
 int mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev,
 					      uint32_t sqn, bool external);
 int mlx5_flow_hw_destroy_tx_repr_matching_flow(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 208f50fbfd..5ba622c291 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5320,7 +5320,7 @@ __translate_group(struct rte_eth_dev *dev,
 						  "group index not supported");
 		*table_group = group + 1;
 	} else if (config->dv_esw_en &&
-		   (config->repr_matching || config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) &&
+		   config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 		   external &&
 		   flow_attr->egress) {
 		/*
@@ -8576,7 +8576,7 @@ __flow_hw_pattern_validate(struct rte_eth_dev *dev,
 			break;
 		}
 		case RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT:
-			if (attr->ingress && priv->sh->config.repr_matching)
+			if (attr->ingress)
 				return rte_flow_error_set(error, EINVAL,
 						  RTE_FLOW_ERROR_TYPE_ITEM, NULL,
 						  "represented port item cannot be used"
@@ -9051,14 +9051,12 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
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
@@ -10006,7 +10004,6 @@ flow_hw_setup_tx_repr_tagging(struct rte_eth_dev *dev, struct rte_flow_error *er
 	};

 	MLX5_ASSERT(priv->sh->config.dv_esw_en);
-	MLX5_ASSERT(priv->sh->config.repr_matching);
 	priv->hw_tx_repr_tagging_pt =
 		flow_hw_create_tx_repr_sq_pattern_tmpl(dev, error);
 	if (!priv->hw_tx_repr_tagging_pt)
@@ -10185,46 +10182,6 @@ flow_hw_create_ctrl_port_pattern_template(struct rte_eth_dev *dev,
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
@@ -10745,15 +10702,6 @@ flow_hw_cleanup_ctrl_fdb_tables(struct rte_eth_dev *dev)
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
@@ -10840,8 +10788,6 @@ flow_hw_create_fdb_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_flow_hw_ctrl_fdb *hw_ctrl_fdb;
-	uint32_t xmeta = priv->sh->config.dv_xmeta_en;
-	uint32_t repr_matching = priv->sh->config.repr_matching;
 	uint32_t fdb_def_rule = priv->sh->config.fdb_def_rule;

 	MLX5_ASSERT(priv->hw_ctrl_fdb == NULL);
@@ -10927,32 +10873,6 @@ flow_hw_create_fdb_ctrl_tables(struct rte_eth_dev *dev, struct rte_flow_error *e
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
@@ -12186,7 +12106,7 @@ __flow_hw_configure(struct rte_eth_dev *dev,
 		if (!priv->hw_tag[i])
 			goto err;
 	}
-	if (priv->sh->config.dv_esw_en && priv->sh->config.repr_matching) {
+	if (priv->sh->config.dv_esw_en) {
 		ret = flow_hw_setup_tx_repr_tagging(dev, error);
 		if (ret)
 			goto err;
@@ -16095,62 +16015,6 @@ mlx5_flow_hw_esw_create_default_jump_flow(struct rte_eth_dev *dev)
 					items, 0, actions, 0, &flow_info, false);
 }

-int
-mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(struct rte_eth_dev *dev,
-						  uint32_t sqn, bool external)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_rte_flow_item_sq sq_spec = {
-		.queue = sqn,
-	};
-	struct rte_flow_item items[] = {
-		{
-			.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_SQ,
-			.spec = &sq_spec,
-		},
-		{
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
-		.tx_repr_sq = sqn,
-	};
-
-	MLX5_ASSERT(priv->master);
-	if (!priv->dr_ctx ||
-	    !priv->hw_ctrl_fdb ||
-	    !priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
-		return 0;
-	return flow_hw_create_ctrl_flow(dev, dev,
-					priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl,
-					items, 0, copy_reg_action, 0, &flow_info, external);
-}
-
 int
 mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn)
 {
@@ -16201,56 +16065,6 @@ mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint3
 					items, 0, copy_reg_action, 0, &flow_info, false);
 }

-static bool
-flow_hw_is_matching_tx_mreg_copy_flow(struct mlx5_ctrl_flow_entry *cf,
-				      struct rte_eth_dev *dev,
-				      uint32_t sqn)
-{
-	if (cf->owner_dev != dev)
-		return false;
-	if (cf->info.type == MLX5_CTRL_FLOW_TYPE_TX_META_COPY && cf->info.tx_repr_sq == sqn)
-		return true;
-	return false;
-}
-
-int
-mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
-{
-	uint16_t port_id = dev->data->port_id;
-	uint16_t proxy_port_id = dev->data->port_id;
-	struct rte_eth_dev *proxy_dev;
-	struct mlx5_priv *proxy_priv;
-	struct mlx5_ctrl_flow_entry *cf;
-	struct mlx5_ctrl_flow_entry *cf_next;
-	int ret;
-
-	ret = rte_flow_pick_transfer_proxy(port_id, &proxy_port_id, NULL);
-	if (ret) {
-		DRV_LOG(ERR, "Unable to pick transfer proxy port for port %u. Transfer proxy "
-			     "port must be present for default SQ miss flow rules to exist.",
-			     port_id);
-		return ret;
-	}
-	proxy_dev = &rte_eth_devices[proxy_port_id];
-	proxy_priv = proxy_dev->data->dev_private;
-	if (!proxy_priv->dr_ctx ||
-	    !proxy_priv->hw_ctrl_fdb ||
-	    !proxy_priv->hw_ctrl_fdb->hw_tx_meta_cpy_tbl)
-		return 0;
-	cf = external ? LIST_FIRST(&proxy_priv->hw_ext_ctrl_flows) :
-			LIST_FIRST(&proxy_priv->hw_ctrl_flows);
-	while (cf != NULL) {
-		cf_next = LIST_NEXT(cf, next);
-		if (flow_hw_is_matching_tx_mreg_copy_flow(cf, dev, sqn)) {
-			claim_zero(flow_hw_destroy_ctrl_flow(proxy_dev, cf->flow));
-			LIST_REMOVE(cf, next);
-			mlx5_free(cf);
-		}
-		cf = cf_next;
-	}
-	return 0;
-}
-
 int
 mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn, bool external)
 {
@@ -16282,8 +16096,6 @@ mlx5_flow_hw_create_tx_repr_matching_flow(struct rte_eth_dev *dev, uint32_t sqn,
 		.tx_repr_sq = sqn,
 	};

-	/* It is assumed that caller checked for representor matching. */
-	MLX5_ASSERT(priv->sh->config.repr_matching);
 	if (!priv->dr_ctx) {
 		DRV_LOG(DEBUG, "Port %u must be configured for HWS, before creating "
 			       "default egress flow rules. Omitting creation.",
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 996c1eb6ac..c0fb98e78a 100644
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
@@ -1621,27 +1621,17 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 				goto error;
 			}
 		}
-		if (config->dv_esw_en && config->repr_matching) {
+		if (config->dv_esw_en) {
 			if (mlx5_flow_hw_create_tx_repr_matching_flow(dev, queue, false)) {
 				mlx5_txq_release(dev, i);
 				goto error;
 			}
 		}
-		/*
-		 * With extended metadata enabled, the Tx metadata copy is handled by default
-		 * Tx tagging flow rules, so default Tx flow rule is not needed. It is only
-		 * required when representor matching is disabled.
-		 */
-		if (config->dv_esw_en && !config->repr_matching &&
-		    config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-		    (priv->master || priv->representor)) {
-			ret = mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(dev, queue, false);
-		} else if (mlx5_vport_tx_metadata_passing_enabled(priv->sh)) {
-			ret = mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(dev, queue);
-		}
-		if (ret != 0) {
-			mlx5_txq_release(dev, i);
-			goto error;
+		if (mlx5_vport_tx_metadata_passing_enabled(priv->sh)) {
+			if (mlx5_flow_hw_create_nic_tx_default_mreg_copy_flow(dev, queue)) {
+				mlx5_txq_release(dev, i);
+				goto error;
+			}
 		}
 		mlx5_txq_release(dev, i);
 	}
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index e273486809..ad15b20e7b 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1453,20 +1453,12 @@ rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 			sq_miss_created = true;
 		}

-		if (priv->sh->config.repr_matching &&
-		    mlx5_flow_hw_create_tx_repr_matching_flow(dev, sq_num, true)) {
+		if (mlx5_flow_hw_create_tx_repr_matching_flow(dev, sq_num, true)) {
 			if (sq_miss_created)
 				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true);
 			return -rte_errno;
 		}

-		if (!priv->sh->config.repr_matching &&
-		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-		    mlx5_flow_hw_create_fdb_tx_default_mreg_copy_flow(dev, sq_num, true)) {
-			if (sq_miss_created)
-				mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true);
-			return -rte_errno;
-		}
 		return 0;
 	}
 #endif
@@ -1510,12 +1502,7 @@ rte_pmd_mlx5_external_sq_disable(uint16_t port_id, uint32_t sq_num)
 		if (priv->sh->config.fdb_def_rule &&
 		    mlx5_flow_hw_esw_destroy_sq_miss_flow(dev, sq_num, true))
 			return -rte_errno;
-		if (priv->sh->config.repr_matching &&
-		    mlx5_flow_hw_destroy_tx_repr_matching_flow(dev, sq_num, true))
-			return -rte_errno;
-		if (!priv->sh->config.repr_matching &&
-		    priv->sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
-		    mlx5_flow_hw_destroy_tx_default_mreg_copy_flow(dev, sq_num, true))
+		if (mlx5_flow_hw_destroy_tx_repr_matching_flow(dev, sq_num, true))
 			return -rte_errno;
 		return 0;
 	}
--
2.39.5

