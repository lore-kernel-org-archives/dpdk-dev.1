Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED8C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 09:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47891402AF;
	Thu,  7 Aug 2025 11:18:05 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by mails.dpdk.org (Postfix) with ESMTP id BB367402AA
 for <dev@dpdk.org>; Thu,  7 Aug 2025 11:18:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q96JKsGcTr2DuEFw1gwzUtOq1QfZvEN4i1EUi2jNpocJf5NfZptt8YBf7YKV5f9Y2LU/aA2QAUXRIsBRkyCVryEfVkiY4q0CgLc7dtVuJZwibaqgoi06zIHBoKNlz+QUTLYi8Nb4zoQKGfH5y2cl1z6foGtTQFNRhF4Ed4nisMowDK8kY1fEp5g1sWpZTVlNtynjczzsWXplBXHL2G18WIj2rS3Ckv7l65t7cZ79ticUM+spKnr7mFSKj/FmUkTPL2VPy8juY4oQsOngnd1j9rvSr18HrMN9yQHdNhqOhQOWPkXM81H5gK7t+lMDaqGdk3+w6m4rzdjeUxQHtcpjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gll4KX3yYmovsjtq44IvmTpGmaLuGRUJkCeYefXTK8=;
 b=NNkCajDuiaSEbR2016/FLUKJ2PNFVeLZumMQX1xsFcA07TDzW3JtapCLqgRtehz/bzEA9RxMzIFfogj80UP3tHFnvp+wFlEYshDOrA45qgkwM1DFpo4uWH9i7o7Yh0wg0o+La9E/FHppMIPqpQ/gm7H16kLt9soyP2LDT7OJA059jYZ/LfYj41PAU4f13qJDVfS33+lNQ5lLJCutiSSttbSmqgiYTBYlRcxDcVYyHT5PIu25ieS2vDigbOiwfLf04EITKPywhqnnVF79kgQmlYAXARtttA7RgUo3kkav1DQJdnT4iwnRZr1l5ic7eGyKcgelfdz4yq1BMwi1sDDThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gll4KX3yYmovsjtq44IvmTpGmaLuGRUJkCeYefXTK8=;
 b=RJhRC6Ucs3RK1cJdwzCvzRswhWgW1jSFAD7vlhTbCh4Xu2XLA1KOomoY59kJJkF5GcQAIaMkFdxcssCpNwMFgxmNTrUNjg5Eh38J440bMslbF98kjZ6zrEK7VsUjaQKQGFhVREEK1uZ4MBZP13h8HRRY+8K/kveWd1dFf1bdNUbYalM6Wvh5rRHfI1XXtQb+TbBd1jtlUSlHdjh0AiZSuKyjth7aF9q5+RNXAXEm8iKN6v7hZL3w5gwr2QgtHwtASqvR9RMHhaoQ0VFOEyaEAyvg+wCVxd4mvtjiXNqIQZAZISBcd7HvVs5IXaFHvyrGiMCN8BTTYYq+VHxF49stfw==
Received: from SN6PR04CA0107.namprd04.prod.outlook.com (2603:10b6:805:f2::48)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 09:18:00 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::fb) by SN6PR04CA0107.outlook.office365.com
 (2603:10b6:805:f2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 09:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 09:18:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 02:17:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 7 Aug 2025 02:17:51 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 02:17:49 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc: update IPv6 5-tuple matching limitation
Date: Thu, 7 Aug 2025 12:17:45 +0300
Message-ID: <20250807091746.155668-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 36711a9f-a486-4ffb-d36d-08ddd5934e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J0Ne3Xzp1L4UKquX+QtmnNeo3YVPgCPpTUKbOYwjnWigAIK8nDg2Fq7wh6d3?=
 =?us-ascii?Q?Ya019rpc4sLlN/TtwpsGieUlfbtGyHFKVL+R+HaYH6edYclE7sE776ciGpso?=
 =?us-ascii?Q?XEqYQlE5n6ZY7eRArvLUViWuGsxOG8JDdVh2ZOzt0kBvikJUal9601+58KFf?=
 =?us-ascii?Q?dMzZH+bLLOZogrJWYXHHshSp82W+totCXiKrll2NU6o4+dJIb63YbjHK628K?=
 =?us-ascii?Q?Fff+saUv8oprpig7F4Zt5VoaPvaLl8JmekEnigNxz41yF+ctolSiS8afYJLC?=
 =?us-ascii?Q?CvWus/M15Ta1fgfnPM7fJtTbbBRoZBVXdjl8Srga/MvIX5RY2xIdOWbHJ2op?=
 =?us-ascii?Q?PyVt9Xlqb7Vy33qIEjttD9o0Nt3hAruvW2isp8ZPjizs4+CnWUU+OjMuG8lF?=
 =?us-ascii?Q?nUDObpSd6luDZyLNp+8DE2xKQv5/90KD03L10Wy4+QwaGRGAxRGbUeXKOYz+?=
 =?us-ascii?Q?az+PnSDzOzsspyasdUaf3ROJGQKXa2HDsaBYOT3psR4LW9dJ5hnveAVMGa6E?=
 =?us-ascii?Q?Qyt4XEZgvkJG5ELV7SsbmS85Cdej2QrghEbekc7WOLfbyFpUVHicAcPqqXVe?=
 =?us-ascii?Q?TrMx37STKdZeS6Cc0LVEN9k2viRlRqCxdak87fe6T06S0LO0GtBG6R1nmQpV?=
 =?us-ascii?Q?1f+rqs1EkVw0MrPUpbCbBaaZd7UWHBLMA9ltxXRb/jBoac/Qc1bFzjy/xI4z?=
 =?us-ascii?Q?+Y6f8VJO6vFZuzicYgd33QFGrJg/pH5AjQwoFAxrvXHZbb4DE0eEbRrZdZnR?=
 =?us-ascii?Q?F7xhEuPTtmTMLKhQTzioacFE09cE8sN+RmIWX3btUqkoUNgWV9fDdwWwNiTg?=
 =?us-ascii?Q?RCHsG9wvUOaZ6VBXdlA3seCBSU3MZUVV+IKqJx8b9DTPjH6ft9UplAdZT8yL?=
 =?us-ascii?Q?5TUKiOB0iuAGX6CKDEZ7oPHN4PcylQnwHoA/WQOMQ55l0Zt8X2kRJ7Z0TXYP?=
 =?us-ascii?Q?4CmxeSsbvhjOhKJlVSrl6ih0NJyys6KfDVfDD9VlapDPpp4AQR6gb/gxwntA?=
 =?us-ascii?Q?H797NYozX56Yc+dAV3HRH8XM6nWz2AiLeoWwD7GyvTv1nY0qrksO0n6sBVOT?=
 =?us-ascii?Q?8WV/7kaMvRKSdADdjos36ZZm/tagSv3NMsXd7iKgVae+N0QYSuHz6XxqcJcT?=
 =?us-ascii?Q?07Sk0BLoiBjaIfNkeSCdiFVlEbSs62+QMqnWe9YrdKQbHoDIyZNSXUJzuJil?=
 =?us-ascii?Q?ltmKSawjFQEfBRaT+pOTREVVbWzjnAUkTYGQs3Oqs+0bVhHU2/gwpmyPwth8?=
 =?us-ascii?Q?ODVLB/YH6pV2PRn8LkTKpe1L8JFB7i0LhlpTVz1Rm4oJjhmqKYyovbnlA9KA?=
 =?us-ascii?Q?CHtVqQlqvcskS1A7OBIBYZPMNoHXFgogRUmuSVaKWDmniNvgP37xzWlhj5RW?=
 =?us-ascii?Q?xWdUBrHgHzRRC+1/dlPZHzdjlFUAH8DPAswyGFz4yCd75StnLhIYtARXpOdt?=
 =?us-ascii?Q?uYOn6FmiEH1FAi98DurtZzSZvHTPiicjT1rzUTGLKI2fQD9gO4vrzW+j+ErM?=
 =?us-ascii?Q?7QDLb/zb7JMurMQcu42lZ+cu7NqjDOiT7Uqy?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:18:00.4683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36711a9f-a486-4ffb-d36d-08ddd5934e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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

Update IPv6 5-tuple matching limitation,
in newer HW, IPv6 5-tuple matching is
supported.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 86fe747c166..97a200443ec 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1381,8 +1381,6 @@ Limitations
    - ``-EAGAIN`` for ``rte_eth_dev_start()``.
    - ``-EBUSY`` for ``rte_eth_dev_stop()``.
 
-#. Partial match with item template is not supported.
-
 #. The supported actions order is as below::
 
       MARK (a)
@@ -3324,7 +3322,13 @@ See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
 Limitations
 ^^^^^^^^^^^
 
-#. IPv6 5-tuple matching is not supported with :ref:`HW steering <mlx5_hws>`.
+#. IPv6 5-tuple matching is supported with :ref:`HW steering <mlx5_hws>`
+   from ConnectX-8/BlueField-3.
+   Previous NICs support matching on either IPv6 src or dst in a rule.
+   In general, the matching limitation is related to the number of DWORDS:
+   older hardware supports up to 5 DWORDS for matching,
+   while newer hardware (ConnectX-8/BlueField-3 and up)
+   supports up to 11 DWORDS for matching.
 
 #. IPv6 multicast messages are not supported on VM,
    while promiscuous mode and allmulticast mode are both set to off.
-- 
2.21.0

