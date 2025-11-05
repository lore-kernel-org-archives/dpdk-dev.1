Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB8CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0EBB4067D;
	Wed,  5 Nov 2025 09:55:13 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by mails.dpdk.org (Postfix) with ESMTP id E8870400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 09:55:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8v63h8pCb2GQBhLQgAvxL4sOIAKvuUgkVDuyMWWbDIH+ZFwUli+Y+WmKAuWPEnTTFEIZwGe7/Fkp2bfhuZvuN5QOdT0/kcUvA1/WJKpo8rWXff4VJ8dtbW/88CHcXl3/SlH7sHIl54LzS+9mHphLnjDEFjyJ33Kfr+5zLl3g9+Rf1HEx3X+hJF/iC8cxZMeT3kbz+hy2JR2mUvX4LlcNhmcLV9SLGpiUluXrn1XOW/tpZJc39IYNEnyWOXmx99tf+Mu4YO8xHvf/j2J3LK30Gg/zwIOo3Nr7K6QdVpYWqoeDc1/TLe4EpvbKSr9Ux+KArglUkeNY7qRVi7siP06/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjngxXZB1QIgaLbDvEpFDNDTZYPgFwhrO5sSVwRiO0E=;
 b=U3M3sNv3kn7JiwwF2nHe9mw0GtIHvESpYD6TTZN8tPcsuyZBm8WhWvz7WAFfvbtJRFv6JuqaiJkU3maQfK9i//ADgNI+jHp+nebCuECR0/L3vEOgs0Hmnm/7MxREMkOhl2D2rVl4qoWOWcPq3MfiWB8N9KD8nW7WTgKwQhdDWixjLiszUdZBRPd4tnqfUyPUBj6fOYrHNiopdXYjrqHkufDDgh4pOI/XgJThBG4UmmADfzUPQujUuOJitTFhZ5khOWpiLKyiqTc00dzto+YpxsGRgrA1yYvBCUVe+CZU588seyCpoakfOaAczjXhsid48sVUKy98lQpqLzFnPfPrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjngxXZB1QIgaLbDvEpFDNDTZYPgFwhrO5sSVwRiO0E=;
 b=GnttGTBEUsL4p9KIW3ItVoyXpkVFQw0D7u4ITgYhvGD6qC75WUu3aPZ5uY8y6Afbv3vBLt0P8kglL3OVmaxqm/OGSXxW7Axo+gT8d7OplKMdnGiRHWMdxaDY+UT1zfy028tWggBHFXm/J5aBS4MqskW6giXmykt7xUZAXxVAk4bQ1X1/qKTOI150vjx18NDSRky7VsRJ4I+NE1n31Yq4YUVATsU4myA1bdg2ucsWDnbFcg2Qc/4RMAftUtJ/HdCecjgUrsTLZbhFlVmUy9t9VgMe5Ci+yVXDWYnMRtgNMdiMbotPYiHVQnRMm/lucFmf1GRMq/KXeozuPeneP7yd/g==
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.8; Wed, 5 Nov 2025 08:55:06 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::38) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 08:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:55:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 00:55:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 5 Nov 2025 00:55:00 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 00:54:57 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Bing Zhao <bingz@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc: document non-template API limitations on top of HWS
Date: Wed, 5 Nov 2025 10:54:53 +0200
Message-ID: <20251105085453.110587-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa8e245-8489-48f9-fe39-08de1c490427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qJxge7g9tZc2NqM1sKauPvLgbYAE4YPQC2sLu6F4SAqmWL1H0ywHhLUMXeZ?=
 =?us-ascii?Q?Tg553i7Tg6wY9gYNoBSDLva9S4k75sdpuMG5bBVBTHUWeQlxCbqgeSehrjAZ?=
 =?us-ascii?Q?m2zNI/PfQoQvF3Uknx6t9JMtRh3yfdGoz8yZGzHaxdrgUZV3yTHO8EQDDCzq?=
 =?us-ascii?Q?MU2RNaPfN9ZXrLFanLH1GtxIGNghvX5SsWGN403zlvc/aC1zn2sE3oazoY30?=
 =?us-ascii?Q?/LFBeuUB/OroWXQGL05CyPqBRkaSXzf4zPzOPkbdC7b/6G7X9wM3v+5ey2NJ?=
 =?us-ascii?Q?TvgWEIjjKtyXm1Jc/sMVT8hjyxsjlGa3RJduCLPW+fY5pITaLFEoR5FuB62Z?=
 =?us-ascii?Q?1Ni6LoWas++4svGwBa8VsU3CoMrxyXJ4AKxw7PzKZdbe6oJk8m+kLjAEHHkS?=
 =?us-ascii?Q?eo4evftMegQwITrv7dYES4hmUK19jgO/U5Q0/+BvlLjQ7f1tmS6q/O39CMXU?=
 =?us-ascii?Q?Abi4bTU6BFdQQiCaNpOVWBrCCgzWbyLXrIXhUddctffWtwOYq0BIoeP5le7o?=
 =?us-ascii?Q?B/PFWDCHWDEMu8JhcWJGEVUHyg0GryjN9My6Da3Evr9a/MLZVUPKqPHGahX5?=
 =?us-ascii?Q?lTl4FIaGlRrQul4bcw03ZznB4qFJdW+ERtzN0KzvmjfaTIG80yTOwSdk5T+V?=
 =?us-ascii?Q?fBEClCZ2VIlKRaGK/uPahAXMG4uIXuMf+K6BVRGNTvxJf87+cEfyU5h8HS0/?=
 =?us-ascii?Q?8zYCPASwMWNDcf1xt9HNcHeMSukedN5yM/i0eBU0x6crI68YoGjhi0JVxP1I?=
 =?us-ascii?Q?gc3eY0NOVPw+GASNK6sfnj/OxBbWWDZMp1ZFrBp3HBDMGq9UZNE+cDxp+rlE?=
 =?us-ascii?Q?obwpCTW+ukhtVyVc9j0sBBFUZEP5Hy8hlZNL14WlPvrramEwOyV1enKjEJCw?=
 =?us-ascii?Q?G3dNmjy786CHGwXjxEnHj3MVta6gFAGP/RFiAFkVpUaO00tUEaT1UrLUpVFX?=
 =?us-ascii?Q?7HJCw+U5GMsxIjbHcpjatEi0rW6bxs36sLbe7Jyv2aty0lzIcRQ1PT+Km71W?=
 =?us-ascii?Q?E2cUT25fElwUW97tLEFSX+Sxrrio6TRmijIfH2fY2Ptbi4q8MWhqV0EshUsu?=
 =?us-ascii?Q?lpiz10W3kENyo9ElS2jkd9BVijImuSqVXS4uMTe3UpLLVAunPLGXT2RTMIRw?=
 =?us-ascii?Q?ot+GtIFcXW++lPRKm7GkrBA/hk10mzoxd1c2OGha/755AiL6TVxTYtdSUz92?=
 =?us-ascii?Q?bXahchIaKCUJ8GWkfrjTopz55ZsmAuaPhYA26r+WiR1bJvdo6J0+RlWgB/H1?=
 =?us-ascii?Q?1XBtrUVlSppjgTYARcvF0h/j28v9rYTRYqVOqtewgZD6qg6hefvMyKdTCt1h?=
 =?us-ascii?Q?YcnGzf5S8qUBDBsK+og98Ou0Nv67UeitI2pX0sINsYSCA75QkbrY5/XCglzS?=
 =?us-ascii?Q?2V2+okxmY/PL+x1ijabxmjj6C50cVtZuFe5UWvTZoSsBEp/xmoqif9hVkmlS?=
 =?us-ascii?Q?umUTtwow47s3fNkwmWDobF15qwfNQDcHGHf8XufChYoIbKUxsUblNGkmvovP?=
 =?us-ascii?Q?BjMWR5TIMFc3zBDlvfm9wQ1GeThtinPXPEevUpi6uyvpU+TTJEzcdZrwmZ9k?=
 =?us-ascii?Q?P70rvH2ajeTPuJ3rUM8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:55:05.9825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8e245-8489-48f9-fe39-08de1c490427
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

Enhance the documentation by adding information about limitations
specific to the non-template API when used with Hardware Steering.
This update provides users with a more comprehensive understanding
of the constraints in this configuration.

Remove the previously stated limitation regarding the exclusive use
of RTE flow asynchronous APIs.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20056f61d60..f18d95e5537 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1363,6 +1363,8 @@ HW steering is :ref:`enabled <mlx5_dv_flow>` with ``dv_flow_en=2``.
 Reconfiguring HW steering engine is not supported.
 Any subsequent call to ``rte_flow_configure()`` with different configuration
 than initially provided will be rejected.
+Note: The application must call rte_flow_configure before creating any flow rules
+when using async API's.
 
 Limitations
 ^^^^^^^^^^^
@@ -1401,6 +1403,49 @@ Limitations
       which results in L3 encap.
    d. Only in transfer (switchdev) mode.
 
+#. When using synchronous rte_flow APIs,
+   the following limitations and considerations apply:
+
+   - Matching Restrictions:
+
+      - RTE_FLOW_ITEM_TYPE_MARK (16-bit match) is unsupported.
+        Use RTE_FLOW_ITEM_TYPE_META (32-bit match) as an alternative.
+      - RTE_FLOW_ITEM_TYPE_PORT_REPRESENTOR is unsupported.
+        Instead, use RTE_FLOW_ITEM_TYPE_TX_QUEUE and create a separate rule for each send queue.
+      - Rules created on proxy ports without explicit represented port matching will match packets from all ports.
+      - The c_rsvd0_ver field matching of GRE is not supported on group 0(Root Table).
+      - Match Field Limitations: There are limitations on size of match fields.
+        Exceeding these limitations will result in an error, unlike other flow engine
+        (dv_flow_en < 2) that handle this by creating a tree of rules.
+
+   - Actions Restrictions:
+
+      - RTE_FLOW_ACTION_TYPE_METER is not supported.
+        Use RTE_FLOW_ACTION_TYPE_METER_MARK instead.
+
+   - Flow Creation and Query:
+
+      - vtunnel offload is not supported.
+      - Transfer Flows: Creating transfer flows on representor ports is unsupported.
+      - Aging Query: Reports aged flows only once.
+      - Duplicate Rules: When updating a rule by inserting a new one and deleting the old one,
+        for non zero group,after adding the new rule, and before the deletion of the old rule,
+        the new rule will be matched, contrary to the behavior in other flow engines (dv_flow_en < 2)
+        in which the old rule will be matched.
+
+   - Port Restrictions:
+
+      - Port start/stop ordering for eswitch - app should start the proxy port before the representors
+        and stop the representor ports before the proxy port.
+      - By default, the port is configured with zeroed rte_flow_port_attr:
+        there are zero flow queues(one is created by default), no actions, and no flags set.
+        The default flow queue size for rte_flow_queue_attr is 32 (used for the internal flow queue).
+        If the application uses any configurable actions (such as meter, age, CT, or counter),
+        the system will allocate the maximum number of available actions per port.
+        To optimize memory usage, the application should call rte_flow_configure and specify only
+        the required number of actions.
+        If the application wants to modify flow queue settings, it should also use rte_flow_configure.
+
 
 .. _mlx5_bifurcated:
 
-- 
2.21.0

