Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D1606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KU7g8VVo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F006410EA;
	Wed, 11 Nov 2026 14:12:35 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by mails.dpdk.org (Postfix) with ESMTPS id BC28E410FC
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:12:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPlyL/Ga5qfDmmQZajUKGDGbTt4g0cunvHInCESKoERywBxVKKqjxsrmU1Lhj2XCv/mRUyKINS7X8fcc2AB7FyZuSKI2Af8jzOir7jib2UXYvryoY1fzFkdtMtx62xyHdjpw5cam3mf+YlsKrSXnE9PyGRtA+jnn6aMCJWDa98b3rTEEJGZnOqL76V+Xxujcg56uzTqkZW3uX3oB1rLpyOimZF0AB787AR1uEAflzFADooj7lGCGTtEdyVHCbg6b5FzHWhrHmkiR0qjFod7OGBlJYRHUflLFSC9bwurPHCi/5VOOTag38zJJzphah6Ou/zx0QkSL7UTyjmT29f4cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=jk24RUEfSkZiigCE4PPbmE2b4nhnj/ShqTHI4/XaYFVFV1pkRvsNGicC9jh4mpmebjtZn3q5S732Z0APVSIkMtLue+y9fXDluh9TdfjOJdR1QG5I8MEzsWUDcfSoKSnv7z/n2lrOQICYWSe7fNyY5rmSaHPY3dVmMXL33RRh2sOH4MgSOYllK24P+vnkuLgA10AN2GUzMougbmMp2wf2a6ZB2uVKAiAu/gygPVufFc95dU46z7ir7Iaub0yJj84A+anYGiNQp1ZwmUbSdE8h40tJd3MjCfyK4m++XP5l9kSz1vluhxgSxivyj5MtForZIPfG9Wt+YQrh0x0RE/luqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=KU7g8VVo7dt5zq/ZVWptWP4py46lAPzf5TZjVJOBl9+jWRBTwaoh05Dw+NtfmCVm2lGAYTJI0XkpxymszbM9zBxWeUE1vBR3mi9OORIcnHVHkehWWI5b/UKcnPEqzwRTnvzwZPuILsM8ccj8xdBsz8tSXAdP9S6KZPN3rwzJ/MBUj4TbhYlscaoRLxGfoO5+oL0iuggLDFPDNSVoIrE1pYPXJ++GircaQK/vREn9yAlnQ0IsyEkqt4slXPiX8+Ll3O+3SH6U+S2Lcq7//0XH0seja6LmAE3pAU9LBC0gFymLzdqKsX5vanJUooZw92LBTaUqQ2tImfm8PU3AtLKglQ==
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:12:21 +0000
Received: from CH3PEPF0002457D.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::94) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 13:12:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0002457D.mail.protection.outlook.com (10.167.252.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:12:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:12:05 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:12:03 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5/hws: fix strict eCPRI matching
Date: Wed, 11 Nov 2026 15:11:47 +0200
Message-ID: <20261111131149.15150-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111081128.6924-1-bingz@nvidia.com>
References: <20261111081128.6924-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457D:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d77d0d-cced-49bd-2e2c-08df3ff56bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bMnHoIqRIEUjwwORo5s4PcgY/mJ+U+2FKIZtUBFUKtl1FiZ7d9RCXq1CKjgKaI/xrHgWzqvfWtYkz1voiQ/SjOgB37uAUh2f2fc/C+Z2RvJghqqNBBcWt2vI/5xiVKSljNxRkp/EibydqfnXPMiRO1Fd2+ZQxgMCGyH7P6GynjMZDKv/Iq+dEefMD/2V3E6CvEkQzA707XqnT7WABI34Bcjvmd+GIxib1mO0f1d3MkEAYMS7ed0T4qGfRVqWVrhmPB6ak4JklXJ9FbewExzlzs9p0aG8N0aAWe0gfPRRUJbTdjzJ2GlA9Xiw66y+nKFTHJN+Xzszx8tECojNz6c7aLkP1tlexyqOHa1mZvHuFRYaqrh2ymDToxmv+fNHwqYKVnWEHcR3nn+5q3JL6PpDAeLHvup1ha1xX/4uIbDK0PbzhWnq3HGIhNqIuGEd3hFwjWjFtPNwk+556m6RXir4y8yBwkaFcmy0ZmFDWqzcSUzgO2Mk5y5dJ+NW3aBpCgJLJ2YQD9DyEbxW2hEm+bgBQ3tS29zWr4+orZDp4jZ+2N2w+G1d00/fsjP+VFnvWARctnhRSfCdHNcc2qhF1099ahU9TyxB9+xTM6ot7fHlpHfqdf0AxMXnySWkS1aCDClEiJwvJJtmmnvUXZVpIkJBgtgyN6RcCe0T7+rhZJw5gfBc2+7ns41IY/u+CcJr2IDrXfv7gFGyEq1JHj7TDwseYQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KUWHFemVwzFKJU3VTAjXjE2Wapz3OnAHNTrpUtCXIKZr9ehwFiz+ytob+cI8MFu+y3vdv/WHnw+OpOTr33joQC/UXUfQgtE4U58L/E809ZxLbkyucsC+n2XIAlNj8E+/tVWHAEod5SbhR5vN9U3DJJ+si+YYO+ZRr5qJfnbqn4cUFc5zrGEoU97uUyS96iHSeO2od847QoPIOMUUZ7sd+obPGAePN6KocxdhcLcLv+COUI6UDm/WToGCZub+RRyUXHyHdTQ2Vc4o2tS4h3CSoWThF47wz221JNjJ2AcNYARnAPgVAc28oGWLZre1uj8oU5012Z3tLcmLMI8UKDQbRtTaMDHTEdxRQ2rtuXKJfL4jf9a7jccK3JNBEooK6aXBsMIzwy51ChLpVmaCH1xjAyK+P+C3Zknh9CUqgfAz1mbEjSEpFxXY9dod7F1vZlkq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:12:21.5838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d77d0d-cced-49bd-2e2c-08df3ff56bca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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
