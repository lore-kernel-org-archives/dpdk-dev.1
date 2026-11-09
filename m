Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBE606EE83
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FnPm6ri8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34C634028F;
	Mon,  9 Nov 2026 14:37:47 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18]) by mails.dpdk.org (Postfix) with ESMTPS id 5A4654026E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 14:37:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn5CZEEQW/dfQWY+CCEuHf3K/llQMRF7K+SsoxyN89xOsU59HO4lSZz3fLYWkpXNwVgo012Q5383D0CA83FsW3QUjqtVygj7M9oRco5tYvprx5wxZOtOehj9E7m975Erv/WZD8NhXmcuH7ee4OS6frNqA+R4SKLwRx3Dt5L3SA8Gsv2zX+D5N7l/kl6cDyHj+Y03bzXERH9OzyzJitbL+c9D8J0Hwfy27Pk16Vmtt7Bfpq+T+FFYyYXrmkEZblNgBaFX2wZHvqpYe2Bc2IiVQmYDaAuT5vWdjGOPzwohS9ymWWtT0kSkPAT4ePNWpxD4N0knJWX/o17PVTJ9JoNphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEB9aYXD/BdKUpxte1VOdfgg5bLhEzaxIZ7uzNPRcgU=;
 b=deP2tZgpgYYzehmAD3Y9/CBPsGAwQPSkTmn7trA3I571c+QpimH36wKH2lEh5Z0HcGXUHUx6H+IDCwhnBW/S5+WtFSf7bC89q0rbk6qKKF3y4cZ1p0iTHyrsDfnsajLQqNWcRIQfgtRFSLoglBEoGWqZ+ayKMK9x8f3UN/SbB+BO/YAUUlioK+aKaJe5YO5HCezn539B19FItXaOxpGeQOMEeY2UrWecSj6qOMXcN06SmHQP3JRsri0xSYlUVitbLVlCjl8AEq1067U8PfJ7oyUgeNJGHyUrwkeDFbDJ9+eTos2hw3kQ0j/NnxN26pDSa5US/7CFfl0FDXbsHXmhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEB9aYXD/BdKUpxte1VOdfgg5bLhEzaxIZ7uzNPRcgU=;
 b=FnPm6ri8WQ3ILZxNrTGhT4RugznbdyTZJ5/Gm8MdDulddgtOZv+UvjVGE4PQQLJ/JIIa8ctQJAaW030rAiWTwlWRcn2eRXxwxV9PDjEK9nfav/rsD80LXohWHkuFbddEATuYRpqZkBG3JRiLLkenOHx7VMnKIn6RLYfa4cDmfHoOUOJPnu/ZxtYtgzStO9o5fuSUX5eRDtCkG5db5iwZ39akqcQK8l5tsx3AjKJtYZumTNexxaliNYr5/Zm/xih8FZdwL5bXwIvc6qmIEQ545mZ6nJJr4d85nmRRqAaP55fv4iqd+6/OdgzwqwKhytOG/Dq/Z9meeeRvHUtM5uX0wA==
Received: from PH7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:33d::6)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 13:35:39 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::10) by PH7PR02CA0029.outlook.office365.com
 (2603:10b6:510:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 13:35:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 13:35:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 05:35:21 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 05:35:21 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport; Mon, 9 Nov
 2026 05:35:19 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: [PATCH] doc: add root table encap and decap limitation in mlx5 guide
Date: Mon, 9 Nov 2026 15:35:18 +0200
Message-ID: <20261109133518.4042113-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 60765e72-e0cc-45e6-143d-08df3e6656ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|261021121427099003|56012099006|261021135927099003|261026121527099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: HfwcQmSm6VuNTN+eqkdv8+pMUZPcXiAaLlMBX09x2xV3UJYbpRnBrz2rhD4JzwKjPTdVQClWEpCyfzfxUIbrw/rmeJ6jl4evFxU5RAZ9dKCBQp3QuTNkYqIcucsbElq6oDciuQ+poaLfU7N6omUmxdVAgUj+0BQyjZqcRfVK8QQif0VU9QbgRrdX2U7w/H5TSFCWnv98gMdmUEQA9PhvV5JVPyliO1G89vRO2auQ6pUNB/GkHoEc/o25itYXuKUsQOgvxfmiMLn7PqjRc1dOnLGVtA/HO1RrYQ3TLUrcwpFCfCnagqkb6/ghFIVWUC5gdZHIAAHEYJvoGgBCUytaRtzGYnN473PvvGUYGcgd2sVkWchtmbwgWnKRRaf4axkXC7qZ9s0Nk5mNbmOeKyPylzvYk6lSJLk6GF1TQ0jww0a7ZVm2Sk/bhB7WqkPi7JDWXeatnSyG3U5Yi9OH6ro4Eng9UPaJ5asgSqMYBq+2mpLEy8/mpFYdHWqVLGrlAVZpncO4ntbAtN0d6MJLpbuE2uFFuiA5YHI95O42eTakPqH2WFDJPOoqBxIsMCL7HwQq0E1mKx1bAqdVudp7xPi98P4mRZbkrWW8K3ccl44g1qAclDh7wh+rDz1KhD69Z5NKk0posWSJaO/dt3oK9DCIrxSNN+019GNt9Yjybi5H6+n0dYvD2XaA3CzVJtWOS/2gsOQJCIaFmlC/V8kam/i24Q==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(261021121427099003)(56012099006)(261021135927099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mp/TzZ8LzVjl5MLtTzOVO8uZqX2IwbWudBaioxWS/ECtBc/08j3EkyvYFXqcBNWr8ETWb445omxMf85EoJVPfHiVBXXPGzEVC7zinoK3HuDbppu7CfSSfORHdiwNpC2Eut0eFTjpksjqSj/QCkTYaQxCWDDbbU1uc55InJH1rYPdTQ2Uje7aLwSEJsA+YbYOFJrjr6XtBKRh6OmtxV5tGtfxd+8JMtUiHKeUTzGA/X7TB13nnWnQSeoPUlYflM8WyaYY4J0EXf7xDYA/iwsmGdTc5a4+DuCi09ACPKSg57cvWPNgtCTKu2UXFJvuBKCeHZhib2FXHvzphw0zZlDnLZ/CHpwySqqtzItyxmcuOc3EcLyj9QrN8FI782qrSVgb/Jp7r0AgGiECuTrURnplbhWdxWnXzTHvqvKcyxmOsv8pp6AN84nKc8WXCtV/wPhI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:35:37.5697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60765e72-e0cc-45e6-143d-08df3e6656ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

With HW steering, tunnel encapsulation on the root table is supported
only on egress, and tunnel decapsulation only on ingress. This matches
the root packet-reformat validation in the kernel.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 86fe747c166..45efa76bcfe 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3048,6 +3048,11 @@ Limitations
 
 #. The decapsulation is always done up to the outermost tunnel detected by the HW.
 
+#. With :ref:`HW steering <mlx5_hws>`, on the HW root table:
+
+   - Encapsulating traffic into an L2 or L3 tunnel is supported only on egress.
+   - Decapsulating an L2 or L3 tunnel is supported only on ingress.
+
 
 .. _mlx5_modify:
 
-- 
2.25.1

