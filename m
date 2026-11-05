Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFA606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eLM8MZa+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7B9A4060F;
	Thu,  5 Nov 2026 08:37:17 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by mails.dpdk.org (Postfix) with ESMTPS id B3E3B40DDB
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:37:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myAk17tPqhOw6mJtBmtav9+bFtg7aHyaux1qhUSx1RG2MwSr/Ugf3mJ2QXhgFw2x2wvs1csMxFfxrjaZLL1bZcUxZ4MK0YarGRaKnLXKp7YyNGeMaRqf+QjEZ6jQcXM0LiO625UTA4NRcVTxOEw/njsi198kqVIQyRtxiFkSArbO2mY7uHp0+NNyKAXrFEQJ3Cdpc/cDMaHUAFL1+OW80x9or4zcH5+zgwobz1Zjr1REhx+nlw6/0Kacf3u7vXo2ohpdWAGH0p5RcVngcD9O7nEzkc/KkEWUNo5MuCvlEq163aCgqFf2d/rwP01PJPQxepVTtEOeIn8CzBCZ9kw9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=J5wiW+1jVLthcUZVQT73yAHdMvsY1j59kmrodZagNsFgUOpkrp/sSyBBMd2dBhW4HEWuGojEFlAC8cHwmaVIjHNHain+SL0b1Ij8hPfdH6stVvVz6m3cNdgCG48nqfftTOclbxbas/peLeOWXqx9/BdtgLDx3IKzUFwP7UV7sMcAfQs6+x8TURjqGQpPM4t7p3rVeGsv95bsL8YipL5ER3zMUEgIbpAu5lM68sRDIOn5CjoTbkXaVes8SYEL0uNLZCD9a3SPicGqMlYnTQdC5gHL1zQmIx37zk6/lvXYtuIKQLXkK4JGJTM1GMvhBRCx/HujEn/YX2CMMmZHKW6AdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=eLM8MZa+Flq/M9187d+kPCWHMI098oBup5WvL7dg9Ak8gB6XzIHK8+z4D084hQ1NbAJJieyNq2aJsT/Ah4gSsCt7DVKewb5F058bTXKPWYzarLHsSQO6TViMAFDd3clAOabhIqN1IPtBoS6YS9dmnpDwvDU3gS1pnxOQyohA/3MEZ1C2Zx6VPlGy95ZM16QJ5nev3OeanjSk6jixPLS1RwA3pxy6Qc9SSREFDl/O5I10NeEpLdEZJ/xOEYCG/fnskNg0sU47vai9oC1hAlMi4xHCaGabPrCp4JEvVVrIlzwT+LKn4n4rEqo6EGV6a+8lN9p4AC1DZ+BQZNmYWNeSRw==
Received: from CY5PR18CA0057.namprd18.prod.outlook.com (2603:10b6:930:13::6)
 by FT1PR12MB081906.namprd12.prod.outlook.com (2603:10b6:170:23::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:37:13 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::38) by CY5PR18CA0057.outlook.office365.com
 (2603:10b6:930:13::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:37:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 07:37:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:36:55 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:36:53 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix LSC interrupt device flags
Date: Thu, 5 Nov 2026 09:36:43 +0200
Message-ID: <20261105073644.20314-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026155805.1288318-1-dsosnowski@nvidia.com>
References: <20261026155805.1288318-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|FT1PR12MB081906:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b730db1-db83-4ab8-1eee-08df3b0f9aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mEme+f5QosIcw/5irLhBCNlKnZTgEzzxd0iGhzN9DaYLB2NWLMNG3pIvqVJWJDHBgIPNELLLBI6Mmch1QwAiXLgpH2cKWEDOi1SqzjEsWKV0trGWLRdQ5unMuAdHIEda2YZm6r+dfzlHOmvxrp4z1Znwtod1ejm2i94ntaImHWoc1tp+kZacEK5VEDmuymG0LMnw7ERCSPhqHZrWAUAuTgFewC35utZXgrOAp0wtZ52YK66VPadLf19wv53r/Rs4Y3RujOqW6YeqrJ22EpOgHuWvTee3TslBaibGYexWPnnlvqArMnGD5NRsWJGKsIg0HyaZWjNNCyc9G+td8ngdxqIe11u6pCxi9NkiVdWeBiwzQngvKrFcBIKL7qxUIGSltreziTZzdttbu/rER+xOb4TFs1ZSY6I54F6bM3SG2+BJKVprBrJOGnviss5ZhvAch0mSK17VG9dHKGLMOghdvH/StdgVtJt4Vm3S00wY4CaTDaTvok7/XLLcDcO1oahS1n6BMHGcARaxrxzZuoJ0pCmWzSaxxe9zIDGL8sBeE1LwoJpBP6LwDCXiJw5pNJ/i0GOUix3gLPt8RFG9G4I8Zyka5/1j6C6S9fBxVrQHxeYlvYq6OAak8TzAVE9dccymmDD50YbIdi3+FDowk/8HFEIcipSUhOUAhHah/O8HP64THWSBtbT3yMSFovu3qw1Yk0moiRVTugMuE+8nmbPQ5w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WZLalBhecsXtph8jUCbk2QTTXnPV+GqL0CSt5/dtdMGo8/wbUfldcEkG0/d5fumRdf97UHhuYcGEU23f6PXqbbQdqG9OQYBbZ5bpjImHwH/QeoGRoP/z9PHf0o28unUWzYSaNp20cIA9zorgNQUrl1zdLFqblRX+uG5L68uG1EicUizdz4nF5zr8gujQpE5PhK4PF/YjIv06hro23S/QQQrBTYAsMQxJv61G7Lk7nbkYtRj6CdluDPYG5xP+b3StvQW4v/79a4SIV9HaDFollC8DtLstSrJsbRnqGxmB+agewh5KvuY9y8MIYKWdrEdxMGbMmSm3PM0BMAZC2JB50iDR8UmZNKSRh+2wFY2k4fPekPpEGhlOa0Wp2jVSWDsUdrk8OFW4iZPavEf75HzorAc04IDen/HPBM4Ow7pxQ3ZypOSRyUyASCRJ8TYCm2Vs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:37:11.8685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b730db1-db83-4ab8-1eee-08df3b0f9aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB081906
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
