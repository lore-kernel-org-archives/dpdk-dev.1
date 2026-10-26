Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E7606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KgLN9tZ4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88969402E4;
	Mon, 26 Oct 2026 14:24:09 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5]) by mails.dpdk.org (Postfix) with ESMTPS id 8CEDE40275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:24:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTCknw/YLBMUG81sHyX09klaXGB5Ps4b6GYIZNwRgCT050je/UC7SDR1PmLXZBTaqnYFdePlcP9T9KSfjRjSTZHcab/dn2rg2UG2Zbq4AVLMWyMVH6Z+VjqRYOyBTAknjvltFkq+FWcTlI6ya13mXFPKVK3XFxwvXJk8ALSsam3CJuNUOD5W00NTZzxwnEKqc5F+fuJEors1YV6vATa+Y1m7baUlVsCmdbYLUv51oDKFR+I4PERms6fyf3Z3YdYxI52T0z5tzUl2fct/Fe/ZclIyaM4/zfrBY3e4w7dOS4XjkdM0hwQp3JKznWkyqrrPafldQxMqtInlHDE8zgp1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4ngz/yPgERsskMsbS+3i73VhUquJV9fAbRxfgmuz64=;
 b=gh+gtecuRFs/CodfRMmDClTiY7kzUdy3eqJkXLPx/qAGKirDWMT8CwnElrcrgwRUmIYGjJdP/tzDl0nHPFNoKUhUffgNM6cgCT62VHp0yiKW54paGqBIbqgsdqHpODkh370TJZKs9Sw/0J/+Y6PkLhfdOYUTtWHcITd2ExTeWDLbgVFdCrkF8w3s9Z8Cp5UZ7bafWAkBtUQBVIlhoie2iHMJsPE+WemdYRI1Zey4F6hgH4zDGyKqRdLmCV1vlBYRmuSNJ9QK+R05dMdFEUVM6T6gsdohIm/HY4PhyYihfeg+MVumCh9Kl9Z4ChunCna1cTqhUrTc5LNu91Yn5z0POw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4ngz/yPgERsskMsbS+3i73VhUquJV9fAbRxfgmuz64=;
 b=KgLN9tZ4p98slNVUUQy6a1kEAnFe/lOJK4ka54TCCiitkp3Np0aEdvdiDVVKbHqj49OCk5nynO8qPCHGS2Oo1BH71+RDpHXbgdfBT0AI/0lOuGqYg6hD1J87tRQf/BC5J4SYdfdffy9X5jKIqMaQ+9XNJlPDFrzuFtSjCOE3ruJr1+k2RwJw5xySf3uaAGdcuBBuiT9I30WweHczhuiqrQ+wyMp7jb6BxeC8aZFXA7h4Y//17s4uGTWTudvWgZ88TPftCW6BQVD4tCYPll3hpwZdEl03Dx28qGCuiGKB7xmsVzBpuZNfEwvmMjubf1rMqaB8VdhdQWRdaqiUzQTJcg==
Received: from BL1PR13CA0371.namprd13.prod.outlook.com (2603:10b6:208:2c0::16)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:24:04 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::66) by BL1PR13CA0371.outlook.office365.com
 (2603:10b6:208:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 26
 Oct 2026 13:24:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:24:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:47 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:46 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [1/2] net/mlx5: distinguish DevX availability from DevX use
Date: Mon, 26 Oct 2026 15:23:26 +0200
Message-ID: <20261026132330.14088-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020115859.96750-1-mkashani@nvidia.com>
References: <20261020115859.96750-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: de578f09-8029-407e-8d11-08df33646841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: hE0oi7nH8Rp46JieK9ZTyrx0EO3md/U9abznaHtoNiXp754CjeLn8/nilw9yo1UuLpZeDsUWkNRZpiFxyvorZPJjY48zPd9MqKqvkyfvZuiUcnwynIhxFD758+SSO7o0+h7TObg3sr1owm709fntlbBUE0opznKp353Ovi3Q2qW9CExH2nzlA1+DQgGpO6W6TC9KyQHC2KhKIr5z/XtDcUU/hnYwTrHaDyn0GW4Pq0uDQTk4bXXKRPqTQtHPTxcD2gfjGgvWTvUYlRJTNVTRIC4YrCgb670ahAfzMGuwhp1Bn9bT0RLGR3NCxj6ivuemdxkOfepXYZxeqO58dmGC1E/13f9/uWBoNAheFAjUHokUj6J3ffhZrVbpc1v7P1DIIE1WeGYfAWBPWcsMLIULRjBZNIv6lPKEA4nbelMxcqPDYirO3UzvG5Ap4lHDUhegyMMzj7EeBK8rZSgvGNAY8rT3XbIZjpCzW+D+B+AjhG5dHop8dnpclZnOKOxWIOHWcEdJTuZEiACaSqafkzNE1AEieps8P6M2TSOEL35n2BB+WUQVC7/ypAPUzVU3Uf5qiIWWgHS6fkD1HYyR/tWwt19OeYnX4H6D8IJfaJ3/POxMibHRTpz8OFTpqF9oLbMeHseD5REJsLlCCSeUl24OnjKF97CIF3X7iFqArOSoxxcqt64XSm1r/a0KNYNf392A5GE0fqhGazRryPJZUJQSzQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dUvi9hgJ2K0bYGbDZrRltFh64EX12g2JC8rKO9kXvE8jMsTefr4c28p4O0OCv2Xhv8h6zSvVsB/U2LsGCQXzrzH9QY+k4vpTM12n1eY0L3UqTiQNIyzeaS9+9sQXzq2j8KteF1o9HbR+8752nRuXYNiHnnpJkEDaTTjgMN9mEoi2FvF8EPq/jsWtpNwYhPvFkaWl9swW9TFz49l4n3JgAy+addVRlSCeMt/TuHGfRFDKVGz5a6lZ6yMlyWuhGIq3fmV6kqN0GuPFxc2oqvGH/2YJR5kdB8vrFVwq039Egz/ecK7d2vagOb68tq5SlbJMJ5FLU8bom/n1R3fvG+eX7NzDljU+zCItMdtTScDWdy0DIzmGhwPSdPQAd5XCx+1lxIL8E9p6Jm6g+dFV6OfRiiCtGeX3e8eeyrNwsU/pFSjhZBREd9JmDmvvHj5AQpzW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:24:04.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de578f09-8029-407e-8d11-08df33646841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Series applied to next-net-mlx.
