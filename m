Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VJC0KzeO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11D454060C;
	Thu, 26 Nov 2026 16:43:43 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7]) by mails.dpdk.org (Postfix) with ESMTPS id B015C402C9;
 Thu, 26 Nov 2026 16:43:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAiBJYXoK/9lLrlMYgleVo1ahnTz2kXv7nZAiIZSuwRvc2duKxMLRrpkoAHmbhx7gR9I2Z9CzupElhAsQEEFY1VpxWnVH1A/l1G4kaV1Nku6lfnaMa11otbCVdF6qDT2H4KLJ7brt18sUsCFebIi8m7UDQi8q1qKYhYuaZZ6I7lyhUxPLMJnxZIBHXi5JjfipfVjjRCRU+D+iRCM2zmNjUVb2IgiaYKAc+6SgUrv+/lzg06bCAEmFt9M+3DSEZxBVTEqY3QpsWGIIAXL3wf/NZjCLPVPIaj5aprkI3ex2FEBZSjVIrXd4QnceMYGBql9/4YpQxHpc7ZUGDM4vhp70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EmbdC8Yf8r0XPqhv7HyZlPFcY3EBfkp0ysc8blQyAI=;
 b=FFkx2HLy4Rg4mSMkuCwFvEs+j463XlPC51IcIw1TwqdEmF2mKn9fkkzxm/MkT8FUUe1mrsjQKZfx3D+/BlO6pFu+dQ9iyspLu6GyBXvGcF7/dFDZVE18mRH6EUnIugvXDka4YloMZVDXocY4b5G+D+X96npKbB9PExFEb8GpijN4KwYxmaISnGdwuTZRJ88z1u6X4yCLSFY2WEgiDeua9vXfWdLu03yPnqtSKXrVtInTQamVZuaYACQY394BdiuV9WlMvKZYc6LKEBLjHalG6hneJ7E2PtCZIed8xD2nE7mJ1lmJiW+tMfVWA8Im/eGAuZakJ54IYEYdyy0TME7uYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EmbdC8Yf8r0XPqhv7HyZlPFcY3EBfkp0ysc8blQyAI=;
 b=VJC0KzeOR4TrPC6JtyAMPLZXOOhP4OjvmNXL80sczkgIVu0QCwjugYSE14xM4ZAk3lwAG6zFcu7hoEmZvAsho7vxFMbqwu8OVNvjoF6EmN0OjJUGhF7tLagT7qvrY5lXQ/C4E+0uDoMDVYd/SbEPt9tBMoTfgsN7mHFj07iWVyauyn3HTvkMgb/fIRyZ/bRv6DqNOOcdbXAXNxXae9MFe+PIm04RWWZ7NQc8uoBSPWslRHhFTB7g+aTl5zOGWOpDXfprLV7LJmlVU5d0BcqP4ti+FtSE7bSpoRNESGGcbkutapGuRcLOILDTrY71MYKsupqB+6kBvB2O9BHBnsingg==
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by IA3PR12MB707400.namprd12.prod.outlook.com (2603:10b6:208:715::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 15:43:37 +0000
Received: from BN3PEPF00022BBF.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::9c) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 15:43:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BBF.mail.protection.outlook.com (10.167.248.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 15:43:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 07:43:16 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 07:43:16 -0800
Date: Thu, 26 Nov 2026 16:42:42 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gavin Hu <gahu@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix mbuf corruption in vectorized MPRQ Rx
Message-ID: <jlvngxjd5r3ob27xdf4c2zfbz2ec2q574pzgmregnvkzavm6bb@trtmib7ps3b3>
References: <20261126142824.187895-1-gahu@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261126142824.187895-1-gahu@nvidia.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBF:EE_|IA3PR12MB707400:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f96247f-580d-4c08-336d-08df4bd4095d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|11063799006|261021121427099003|56012099006|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ifHdbCceRGTZTGlJmtu9+2NZcxx/vhxwDImNJ5RGKo+axyIGojoEw24DyOfvfLT2WF5oNAlFWJekWFPwyRQ2j95bCKgyTFLM25reqg4MgV0YMqq1EaL7zLdUJqGlxxPf3oEEqRlDhs4sHkESsodSd7c63Bic6V8EZs9HioFuvgncVqJOOMY7qB+lTXUgvFcGkZCi3/e/dQuh1lRMmvN1J3CG/h7674kfUC+jT0iiCNLzUI2EkJA/x5ecCIQ2ydcBePZjqFTCbsKL4USPWWkiS/PKM8IUH4B0XXQ+YfNJERsZqfMl7ssc+8fOMuPSmTFOLunrSc3cGbeGwcQKju8zRxzwq36PObS1ttb6GXbdeAgQrBP5txRdJTzkUeNvEBpaO/E7cbXq/2KhAsCAd8ofGKR/OM/lqm0KoSOhKfcsMAWANdfTn3vTsrDSe6MkjeiY6aZF52vJC0paGUwulyfAC8+A5+HQS7afkzddIWjCGZidGbGOxP2mXc0izt0hUFJsEeC9rZS6tn5dVEIkRHXGTWn6CrcJusALLnsNAL6064gqiFY8gi+J8VTRU+wY/lJCpPuTa9Wgjd7S7u4++XZGxhosf8s+6LlQLftTXPRoUH5dL/bTXYpxGjMbB+vSPm61z/icZzuvwADEQ8UE10F4qlj2cYDULVRdHJlpKNoFpjYIbsVuvnoRY57BP1xNlqo9N/4XLwRtoPIiuzismj2NPA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dThBUfjCCuPtWIlVCn2IV9WRM84fnH37RKkJfZMp2RzLnqDPDNg47APTzBErCg0QJqq9rrphjOlArKZ5RoUbkRhIyrTfKhD6UNwcMRT5u0pU0Cy6wTlyS14Nx7PUiaZKAl1uXlt0I67LofijDhaqCsDMi66s1bdYY3hwPc3W4W1tWH4ShbNAFoo1laqP7uZHZc864KHC+PpiepB25kY9HDQs4v5zMMckhV8iB+7QzJwMnE8oWFWD6z4m3btcPa6thmmggtOXmR/c0Lb/qHRuTyumWzXhMEEK65KNGx21HXsU0ki1/gl3g+ecVVyvodtvJtIdY6h9fnW5Cwb8Zhy59xMZ5VNgWI5GMSJSbCVK04nE9kKBOagJx+rWfvzIltboNyL9sxuN2SbugaeSWVqdTdYliSihOZDk05Go0pIcbmj5/AOfHBIhp9HRLxmUF44I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:43:37.0320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f96247f-580d-4c08-336d-08df4bd4095d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB707400
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 04:28:24PM +0200, Gavin Hu wrote:
> rxq_burst_mprq_v() caps the packets it handles by the number of
> replenished mbufs:
> 
> 	pkts_n = RTE_MIN(pkts_n, rxq->elts_ci - rxq->rq_pi);
> 
> That cap bounds rxq_cq_process_v() and the mbufs returned to the
> application, but not the compressed CQE session handled at the
> "decompress" label. rxq_cq_decompress_v() takes the session length
> from the title CQE and always writes all of it into elts[].
> 
> For SPRQ this cannot overrun: the elts mbufs are the buffers posted to
> the RQ, so the HW never completes more packets than there are mbufs.
> MPRQ posts strides instead. The HW keeps completing packets no matter
> how many elts the SW managed to replenish, so the session length is
> unrelated to the number of available elts.
> 
> Once the mbuf pool runs dry, unzipping therefore walks past the
> MLX5_VPMD_DESCS_PER_LOOP fake_mbuf guards placed at elts_ci and reaches
> the slots beyond them, which still hold mbufs already handed to the
> application. It overwrites their rearm_data and rx_descriptor_fields1.
> rearm_data covers ol_flags, so the victim loses RTE_MBUF_F_EXTERNAL
> while buf_addr and shinfo keep pointing at the MPRQ stride: the mbuf
> now claims to be direct, but its buffer lives in stride memory. The lost
> RTE_MBUF_F_EXTERNAL flag triggers incorrect mbuf handling later in the
> application, when the mbuf is attached to another one.
> 
> Compute the session length from the title CQE before unzipping, the
> same way rxq_cq_decompress_v() does, and leave the session in the CQ
> until it fits entirely in the available elts. The CQ consumer index is
> not advanced, so the session is retried on a later burst once
> replenishment succeeds.
> 
> Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gavin Hu <gahu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
