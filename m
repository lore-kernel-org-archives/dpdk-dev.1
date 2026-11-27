Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17931606A324
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D9TWcoaa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4673A40291;
	Fri, 27 Nov 2026 11:04:45 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by mails.dpdk.org (Postfix) with ESMTPS id 5390740263;
 Fri, 27 Nov 2026 11:04:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwbZbXLkYgmTQM9lcAffApYyc4t9AWUvE1B0++UjKtQiFBj9KasnPPhQEx6W1rfTZg3tlsIxPaHs/MwAagxUyqe0PzZvrnVZJ5+i+lOwhipI7zVa94EvlKwdnGNO1yVXVPiy4XvjfYrGbdgciT9Ae8u+sQ+wEJqPz3qOmu76SdUrrSXVBC+HW+lBO8PfrzKqYvB45rRv0e200zgzVzrdXeUwfbRruNlX4lakLGLHfs0MiUwlVhIdm8xTE7xqGhjOqlkNnJbFTKWBFGDNs9PuMSZXt+8xzDgBfKayn/rjgXwZNoUFK3mT/PcP+Xf17TIxuSG30jvWlvp637dvwmxdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/q/zJnqPjq+vpMTqSgs5LMeYhXPxKVI800FXNFZxJo=;
 b=yK73+nIYUIAYEjKchyIBBw6XNU++beG00FqSfdvs9D4GlNfktjIMUx4T24vEHV5pDWMkpPhIbSM4giFYx3+UB0DtWlwWpvXptmWDaSCFb5zTCHEuYXReg6CqmMBysQXmMTZMy+09IBGo1DgxI0JQtSsO9zZZMExrQx79MEDw5FxqPLpK7ryw15Hbig/XRGOH0QyEHZdYBJjKldi8X9coBLh6iRszbSy52PGHI+CSNi/7b9pXCBif+JT/aj6gG4HfJDnBpqLWQaiM+bi7eVn9hLJf+UbkmWa4KXXm8rST5vYmUD+Gpzv+z5o5lsw0czxxPfy0O0B8BkDED6ktfIMBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=peresvet.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/q/zJnqPjq+vpMTqSgs5LMeYhXPxKVI800FXNFZxJo=;
 b=D9TWcoaacEJD+C2rWUMc5Muo0jLlbzC+6OWkonDJvivuhv6mb037TDgvoqTWVE/hD4kzMW221D9iZca0uAk6ul01aO1w+EwngA6ug/zwaLrdECtyKQIWzzAg3P751OdyyUcmQt26ouMerLYOW8SdexKtBq7MGWwnLQTLLYDG8tSmTMw5dK09FEpVRmVQkx37TqwNzUtyemUTH2rzk751n0PLqU/pCCGrCaVZB3GTbG5Qs0pPBC/P9Il9z3c+53f+vCS/ukXhh68txO8bEWsWZU/W6x081NiOpPAzWkEprAwWDLTFQ/si8DX95j592mUwoXb+1ObCGqTWCoSHqKx5QA==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:04:39 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::92) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 10:04:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:04:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:04:18 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:04:17 -0800
Date: Fri, 27 Nov 2026 11:03:18 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: "Daniil Bobryshev (daniil@peresvet.it)" <daniil@peresvet.it>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix Rx queue count with enhanced CQE compression
Message-ID: <zps4k53pdqj2uinorrcawyqr2bjqtk6dq4cb6v5txemujq5jil@2rfnl6oojayj>
References: <20261119203447.41203-2-daniil@peresvet.it>
 <179517316488.3655.14347438927516252681@peresvet.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179517316488.3655.14347438927516252681@peresvet.it>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7701ed08-c630-4f8d-046e-08df4c6dd906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|11063799006|261022105027099003|261026121527099003|261028144727099003|261021135927099003|261026140227099003|261009223027099003|22082099003|18002099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: qEWOAn+TempDUn203+AJbVSj8zYQ3QIsaSNBPuhFSMb5N5c2P3W3m5pxCwsyO+pxrjmWJBjqLPrxM5CRobG151IZMiscN93PxyOGFV7Az5CLtTOLyQmIrnnAJQ/HXSvEoDNUiivQAhmVssziY3qfWiFkklwZS7yR/O+hiyTxWHDB6OmCqB98L5UKv9yD7hUJMzAvYnw9U9blNSi3NImkCre4pdVgiSLTaLf1rKN7+V/KXOhVH53MGYADNCXKcVPUmkzm93DWD/0cx+dBRpllrrNCY+GcWBObfyD14JEQl6tS3w69Cea77R3m/er02ejUpoHMr8Q3blzSGzK6nqUaR8Xl/hXbLK9K47l8MgTQIfSK6hFgOGMKqHu/mKU/Rr1yl0aQH91JLOkKr5TJbddc3KmqwRg1d3exRsZkaioHViBI3iX10M3AxBPqj+a8VBMb0m8nYw4ypi8kHI9WoNu7kF3uSmECcNWalti9g6NfwlPKt9HyDT+Yi/Zzww8fQHtHMR8i9QAOSi2OOvlWBgwLh3uRfYlEFCI0XNxmo0icXiSagRbu9OY0oOM3/ePesTN1jS1rVpWqMDt6HyHw0nNpiNGTObXKdhzNYzom5fabSxJ+1Cy9DeF3meQzSiC+8wZR7g0YsGwxd2Q2pmVa+T3xm0Mt0g3RMrg3nm46y3a0diIepOTjkCXr+myn9tHrV28LK8qkCrokEqBb+8XbQ8RTXw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261028144727099003)(261021135927099003)(261026140227099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NrFQnoCiS8dn4u5XB+vcYYBsqFspQ/Mxqh1TKT/mHo1Zl/+8sja/UZ/MHtdkeN0NuZv1fBf+u5z/be594cVXa/Zf8eA2VHET5Gd7thuCcmB8l1iGnFLvJyaP73LH/rImZfTfSsGTXJRzjj3J3IJo6vysGWXhB6yw/WF8dZ+KgoOO2mgApTntVhBRhHT7x4m4Dydg54L4lxH2qfaB9R0x3j2UJAFM2odhQ1q9o4pfNwo1cP0ok+oCTW3+mcVIBCl95zx3wO3g6Duppc8ISmRAyoRgcer6tWerbku67eAY+4iOIgp3zkFj469ZubCttO3MFV1kB296i7wzNA7Wa0isGPrsc6TjFtQcvMVuHwwl4qeAMpDDnEWwGVvxGpKbU+N+aDkXidqrsZzibRuSWfHwOY3TZ4qM9lFJAyP98SH/EhDXtJ/gJTS8ms18PaaAX31J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:04:38.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7701ed08-c630-4f8d-046e-08df4c6dd906
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 02:12:44PM +0300, Daniil Bobryshev (daniil@peresvet.it) wrote:
> The ai-code-review check on this patch (https://dpdk.org/patch/173059)
> says that in the enhanced layout cq_ci should move by one entry per
> compressed CQE rather than by MLX5_CQE_NUM_MINIS() + 1, since all
> mini-CQEs of an array sit in one 64-byte entry.
> 
> I do not think so. In the enhanced layout an array of N mini-CQEs is
> written into one entry, but it still takes N entries of the CQ: the
> NIC leaves the other N - 1 reserved (02a6195cbeaa: "The invalidation of
> reserved CQEs between miniCQEs arrays is not needed"), and the next
> CQE is N entries further. The Rx burst advances the consumer index the
> same way:
> 
> - mlx5_rx_poll_len(): zip->cqe_cnt = MLX5_CQE_NUM_MINIS(op_own) + 1,
>   zip->cq_ci = rxq->cq_ci + zip->cqe_cnt, and rxq->cq_ci = zip->cq_ci
>   once the array is consumed.
> - rxq_cq_decompress_v(): the next array is looked up at &cq[mcqe_n]
>   with check_cqe_iteration(cq, rxq->cqe_n, rxq->cq_ci + pkts_n), and
>   rxq_burst_v() then does rxq->cq_ci += rxq->decompressed.
> - The kernel driver does the same in mlx5e_decompress_enhanced_cqe():
>   wq->cc moves by get_cqe_enhanced_num_mini_cqes() per array.
> 
> So in this layout, as in the basic one, the number of packets of a
> compressed CQE and the number of CQ entries it takes are the same
> value, and rx_queue_count() moves cq_ci by it. Moving by one would
> land on a reserved entry the NIC did not write in this pass.

+1 on the above
cq_ci must be incremented by the amount of mini CQEs.

> 
> With this patch, on ConnectX-6 Dx with rxq_cqe_comp_en=129 at 100G, the
> reported depth stayed within 0..568 of a 32768-entry ring, and the
> datapath threads that poll it no longer hang.
> 
> The ternary in the loop condition is the same one mlx5_rx_poll_len()
> uses; I can move it into a helper in a v2 if you prefer.

Adding this helper would be a good addition.
Would you be able to prepare a patch with it?

> 
> Thanks,
> Daniil Bobryshev (daniil@peresvet.it)
