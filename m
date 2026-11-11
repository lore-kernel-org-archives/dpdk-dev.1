Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE2606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oPoSvAH8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4811A410ED;
	Wed, 11 Nov 2026 14:13:13 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by mails.dpdk.org (Postfix) with ESMTPS id CA43E410EA
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:13:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFw/vTuZ3vvLuA3CD5mfbL0fhoIlz8m6X92y0ezyvU5tCAghf5JcU63ENY00cQk4/hd7B/wW80l0MdGS+lG9z5812a6wXbyu6lPzysEpzpFY5gFmOQCtLxRMYn/GKytj8cKP3kD7zBCff0icWaJO1FT9TTnAUJVTb0yl9yRnUQKeSxMPqfIc4YDjLOw2XP0LFFF9kipFnPsJ2Kvu3QkGwc8yBfI6CM+A4h+fQOTo6mR0IxHxo2UaE6cgC2vzOE69nmcHb0a2no/3wHGeYuqcgaOQM3mDKSexUv6x/PbdODlbyN2S8W9fMXhAdMNHGDqGQ6naJAkgCGPwTBPI3wDa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=qYbEYQGyuzZWi/9RIhL0e78USOoNAC+KkJr52OQClq11/WxhSv/uuX31mEcbHJ5RrLflRk49Tq6x+CTfcCEC/if4pENBS8qYJqn8fw4/DHL3+CFkn9woK2CV1Id8656gpB9rAy1dxvKM1lc3RrRrVvcZPbVo6RDR4QK5n+qfSHyXMXfxTCBIR/krOEPEFYxylCXT8bbr9eYmAoWm3pd+KcN7MmVp09wIfp5/Nw0PzaIAJenFrPs+S+4tPrOSkXNPGF6J0UlyRBWaHjcbhUuK1FqlwuviYnQbeYUULQK43mZLA0nkqz8cnUmzRPARBqGSYWyaoHl5G+1Ecm5nehb+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=oPoSvAH8eJmjigY/h+X3a/KHT9H02SDvlqTGjEozjbp5zL0dOEDVlfD2rP5HrXIU1LWkuMFecxn4DO7rxYmNc7aZamJ41VY+C6dNAyIizzdBL58mYaZrKoLDeZe4j+S7OnzHR102wGj756x4hbZVRaH44IcexsR3Avh9KTwKACk0uJv1Djl5q/ew5HN4LfMp/xMOWHJsJti/NO4dhGs67YowGHG3SpA7t1l6mxszWNR4RrlvtfQ2VcbDnn7zQOutSQWsc2O3enknkHk6msshRdUPPwvOzYaON2nk483E58WlyGt4an/eWVF45aHytuYZkNsJJr3eKZDithNv8J3+ng==
Received: from CH0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:76::32)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 13:11:04 +0000
Received: from CH3PEPF00024581.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::aa) by CH0PR04CA0027.outlook.office365.com
 (2603:10b6:610:76::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 13:11:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00024581.mail.protection.outlook.com (10.167.252.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:11:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:49 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:48 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix external egress group translation
Date: Wed, 11 Nov 2026 15:10:37 +0200
Message-ID: <20261111131038.14223-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109092347.3975686-1-mkashani@nvidia.com>
References: <20261109092347.3975686-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024581:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d9e95d-4725-4f9a-8812-08df3ff53d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fqKh9qz0HPg2Cse/Z6+rwwGvXb+Lbt+QOrsh4rtOvwpRtQ9PzYzRU2NXnzHdyzMOK7isyrx7nyIdV7d2djN59vyBrbrc6SOD0qPFHWb2GGN3fCwS2EAos8q9Il5reCQGAhJgSmhaRfwCalTDoApW7ElX5Euuxb6b4r68mkeyZIyVNI8mdfNwkua0czMPfboUY5XhOOvkcgZHjDGUFQNMGyr6DjRHS5j1DSeWWPjpLR4m0UV0LT902hr/RTK+XoBE2OyDIgRpWbwzCc5BFjNhqVDDyR8BAw11e6hFEnJ91ljpjCSaa0bprTKjxusnAjEcCy2IRNE0tI10Xo5BfUGeO6sBcGWYonSQ/AmmhtlcbGdVA8jiRemu16cm6nYCVVj61JHGAe7YgT3PeaJbLKD9gMm3jkqv/CAbiOg2fxIIzsLYGCquzTCy1W0kyDsDm6ZTRsBS32vEJoZYj8YjgZXmtKVD20Jqgv+ht6MnGWjhxnQ3c8egNN/Pl5bcBWc9kXXkEbewTNKqfFaRTSDSjDhN/5o/5lChkjcFYNdZhR/zaVHGs66DTHT8glUXNUzyZW8trQ7aUoVGB+f+65D8kRL+VuAVW53vLPGMkVAGYkr2CcaBHK4wTp+cg9D9cTcqGqxuuisstLiRGEpLsPxgfClv0T/0YmnwF6p8bsvrBstyAeUdxWJ70bLcGzJEx8GKCUCvb5qwlIdmkcp9R+F6cwZyqw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tFHkmHq8UL84tjzLovanqDfDRfksT+VB871v/R1nw0tqHLatGpD68qCIrFpfciih5RSsXsEkBLJxfBrbctl8132rWPCUpxW4zwDUGv/jQ614UIvIKHEGd1/LYoe9PHD5HvA6kUZ6iMVXkfwuBYAL0P6yF4e+bqgtArCx5kBHCnIk6LNlGuDi8G16bJODx8fiaIbDjGyxa2kwYRgup9A0eUiNJl4tzqwiOyDkGBKatc2XZQu4ODHzfKOtoNazVlmic9QmYaZCPcsjYd7/JZXR935MeJh1uTEDW9lRkra4hRYsrjpp61UBQ9glq5vXj006E7R64ov0oF3FRXUM2wDdr+JSbH9JTnczjPZLw/Qz3sMrt+kFfvfV0/tqveTbyuA55XUDhr2YU7gjcD+KKqGysGANPseO8kt+N1Zl30LDlMmZ3klOsUqnL6qe7yfkXlps
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:11:03.3716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d9e95d-4725-4f9a-8812-08df3ff53d2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024581.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
