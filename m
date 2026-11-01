Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08650606A326
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mu9KXfOp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6DE40279;
	Sun,  1 Nov 2026 17:05:11 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31]) by mails.dpdk.org (Postfix) with ESMTPS id 194C740264
 for <dev@dpdk.org>; Sun,  1 Nov 2026 17:05:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJs0/UPpv2jqQPIpjlc75+211Bha2K0YsLtQDgMnoJwXQYkNXHGsCUKYPhv+IIjMGB3ep8zqpYVRohSk81cYwwhVbTDVPTQ4+ehGO+kE1lafjmw3b2GMkN05cOJK3yFpdvsFIiYdBVYv6oBPYuqYYPYLsHte5v5R8Ua8A3oPu3G9JTDJmHoqObLyLYUtuA10wcQf3pZDAfvSY9luCC1sxhq/D4Q3lZwENR8GGHNM7w966dFiSVrYkOWd+OW/Zmuf5fou0S6r3YQV5S24TO5AjU7J0ud/tty6dnr/0Di5Ohwi66ibR6iZrtZjjWhf/gChjlAYJB4V4Q5LY+7pKGVD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p/ETtxwGMeOdsHSfNNphd0FwA6D3aYNwGcwszKccKM=;
 b=sCZuHfhixcG/Poyf3PjewwxfscoRb+nJgZZCjUzjLbpTAjW+PwEA0rk5UV+K2BsYf8qSD6Bl9cJnBSllp9ww/CMtqT1SmGyBdbvFy6GoKsebhEKX+ax/v3y63xxG45fv5NvVDRBjYRih43GQG7FD6LR1pCzb8+HPbqw00KjD9ZKbzzxbl2zW9J0sFCB18DggXcYqDYTS3TnydXX5LrMBy8cN99Hi3Q2GFxbVHLMrAqiUyo4y0iKqF/DDa2gQEmskJvNdNc3D2obNFV8oLbrSyYbOZP8BSQFiWjAt6nSdUd1cvDUf1ZQIx2wEGIqe5t41Gts+lmMzTwAU884uaWzhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p/ETtxwGMeOdsHSfNNphd0FwA6D3aYNwGcwszKccKM=;
 b=mu9KXfOpUhIhom1LXOEUB3j+K+J4MvMBnULad9KUS5YOKnhS2kdK0fTzMQyhsU+LGcu2zL5gckhgQw9JqTiTo3yS0lydswqq58tWaHKrFPTTtaexQMvEEs3ky/vMGyx27ZAYq8jvGKKu8A+hGWqEHTHXASoya6YpylSzuzzpSWDOvReIHtMxi0wbBOluRzevPt52M8asKffLsJRH0qe6ARx84tMYNwKbGJUP1S/+u+jaOMUb4On7FhO7g1lEztZZMJG3trMFJ31NyjYBVE5rJ9GRYphi7jin9KzzdirtApUdrqU8csaymMWRDMh0PhOTeJjmXbMbqbr8vcZPkAmlvQ==
Received: from PH7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::22)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Sun, 1 Nov 2026
 16:05:04 +0000
Received: from CY7PEPF000000EB.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::40) by PH7P220CA0005.outlook.office365.com
 (2603:10b6:510:326::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun, 1
 Nov 2026 16:05:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY7PEPF000000EB.mail.protection.outlook.com (10.167.247.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sun, 1 Nov 2026 16:05:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 08:04:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 08:04:47 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Sun, 1 Nov 2026 08:04:45 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] doc: document group 0 IPv6 fragment VLAN limitation
Date: Sun, 1 Nov 2026 18:04:43 +0200
Message-ID: <20261101160443.3216180-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EB:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 115976ea-b566-44f6-5fa3-08df3831e3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|56012099006|11063799006|261021121427099003|261021135927099003|261026121527099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 91ADeQ2cR39J4cn8O+1F0Vg2XpIrazuBC03ws6UJNI+FNYxCPDvD2kk4+rYM9+v2eUDTue/P/uGgKPiocDDwxqaiOpIWMSqexNjTOo8SbhZp7iSerxpmvAGGauQVjTbbMVOm8NvvovAZYEQjpuyBI+brUTWM+QnhVFIarIdD1ET2KhtjCjwfjGPi8Gknp+m1FHWh/Gf9xgP1KOmLJf2uY9saIQvFu0KepiiUFJ1crzquHHBgke/X4OcHanIpZ4twalgUM/XmfVgsOQdMliAyUwVCt3RwsI1tM12ycfHMJf0ultJAJ/fgen2f5qrK0kJcy9V6gEu7eB/ZmrML8ImiQLjNvHlTiWXIog23/LGjwOWFd3ZgtiqyJYJ00uycddf8OAfVk6WhkNsQSAFHf89713RqWFZ5vu268rO05TZ6Gkqz8gwMMdK+PFXOll9SWSFKtVc16GLYzqMenYLrn88+ziJMdP8L1AS0ojWnhH0IZ24PQqkeg7OJvGLWaIuW+mGVmQL/dRGNp9u5oLRxcqw4KdWh9VhRA0pY4vwKcimXb9tKUxH88sBGvbNoCRsnSbdzb9tdgcyNFMZtAhW1g4vwIdr6BdvW9Ku2i91t2Y6kSnbF7krcoAQEmPatx+ZTilY24jvTDtooSZ8Su2LlVyVAN2CMiyj7biylTo0OJJDcSJzY0D1DYeF7cUzOH6Y2LpJ+Z6NgTZ7+FmTlNmnY0NvNKg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(56012099006)(11063799006)(261021121427099003)(261021135927099003)(261026121527099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ARNSbslMOe7siiA6nTd6IEmPhTE13SR7NZwc4v9+9TwFvR+94+7qupsxf/ny0/HIYISHRTJodfUQ9uxEQIXKyAKL18jOVkJPrCYbS8O7SJ3mPOfMLn5W31v413Mj2b/168lbNBUwXFsJAw9Dv9GlMrhOzvEii9WHIx13UhFD+A8B2X5Ks6Zsdc6mLsg3hiDoHFQt+b6CqX+Le4Wi6xw4NTfgNhP69tTJjp3fUh7mfsfG4rIPE+/I1ZZuCBZ70JL4B2dv0wsWMzCNbJcOvShUaMGMsaSXvFqg5XLPXmzDwXt8hUClnfmvY+GNzrvP4E6yghXWyjbZyasyX8e9NWCU4l9p9IQgfmsNghgacn2JRk8crjvdEoisO8VunPLisStdlq4RBZ9vF/3BgnQUO6IRUR5u2qRfYMQnNaHOfW1U7F4Qlk1apUOhpUn3MEwcM09Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 16:05:03.4588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115976ea-b566-44f6-5fa3-08df3831e3c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Matching a VLAN item together with an exact IPv6 fragment next_hdr
misses on the hardware root table, while the same pattern matches
in a non-root group. Document the limitation and the supported
group 0 alternatives.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c7bb6eb182e..8dd7ee9a969 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3731,6 +3731,14 @@ Limitations
      and the first IP fragment is received,
      then this IP fragment will miss on that flow rule.
 
+#. Matching ``RTE_FLOW_ITEM_TYPE_VLAN`` together with an exact
+   ``next_hdr`` of ``RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT``
+   is not supported on group 0 (HW root table).
+   The rule is accepted, but matching packets do not hit it.
+   Create this pattern in a non-root group.
+   On group 0, a VLAN item with a wildcard fragment ``next_hdr``,
+   and an exact ``next_hdr`` without a VLAN item, are supported.
+
 
 .. _mlx5_nat64:
 
-- 
2.25.1

