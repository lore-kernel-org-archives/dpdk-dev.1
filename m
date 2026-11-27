Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D4606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dzfLy/tG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AC3D40291;
	Fri, 27 Nov 2026 10:51:53 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by mails.dpdk.org (Postfix) with ESMTPS id F2A5A40263;
 Fri, 27 Nov 2026 10:51:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkn6YYm5l2PfjWidQYZHQ2QIuoet1Iwvcni3m31ZLNQfxLiYGtFW2MiHy7cMpPR2grsz2eBiDCY+q3tqc80g7jPP2Bf/UPziLncc9qAEy7bU2gg4dlyAxR2ZIniiF2IFgp1Yyy+IbIkQHmoAlhbEVuUrQ3LRLVaPh73LKutO3fybBEwAi16DLxMJ3N+v23e+wy+YrvjbdtSkeKrYePxs1A1GJGg8Q2cqkWNK4HrxofZh5StMr20GntYMueQYHoKhEb5vhBOLYNO6+Zjy7NyI+X74MbVA0PIsVeHKjQInJ2t7wXgNNEACZXgW0BrkweEhdTI8NwvP4yi5qiHz0M6c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME4szvj5bccN4MY5jsV6c7x0m+rgncDviYiq2lFb+S0=;
 b=CQ8wpn0Ys8KTq6vZ2djniUmpbEa5APa0d31BKJIuhktKABcRWtn6fVh4eZp+wn4ZlkiR07i9HXZTa3HLrYXa21ecoRfEXDNJwvrNwADfY11cA5kh1hYJx6J0x8RQbvxnrDrSVxthEMJylm2gRVh6rtINzFMi2KxiZwjFLFTHtu5IohZq7dr7VqODeAZ/Hd36ADfr1AsPm3f+PHhF49Uxv+0WhWotl9/N8pWJjcTdyOn0uxaatRKQr9FjHPiWjm2AVW8Zc2t2G6OO95WsDwO5ar2x4dTQ4egDiybAsZjPimRb4jR8FMSl9IX1CY1umX+jd1LH3JfzSsiXRUNLQEJwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=peresvet.it smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME4szvj5bccN4MY5jsV6c7x0m+rgncDviYiq2lFb+S0=;
 b=dzfLy/tG+lI0NIlUx3S14Jj05Y8yJRHSPnVWG82hTrYBkzq6O8+G7RZoVICrtkSBJg9EYsc+pmLL/59Ahg/XQNNcC3sd9lQ9thCEhmMvyPs0cWjryCTja4SEwih3m82GGTIKsbQpAzzCwaZJuFXesst/kfKceov7giFsYH8x+FnDn3YXAgCL40EVbabdstnYMpdAuBUD90iocVru5NCFvvDs5tYVrMZM7HRKypw3QhGbuiWxNsilUmKbKbmDHtPsBMYXVJEW7GpYtRY9Pr4wT/JPzBXCVMwiHGb5flYJQuWycAlAvdxgs3HHK8g7RvclWq7ydj2EsTA+sSxQHfA/Ig==
Received: from BN0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:408:ec::8)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 09:51:46 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::85) by BN0PR04CA0093.outlook.office365.com
 (2603:10b6:408:ec::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 09:51:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 09:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:51:29 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 01:51:28 -0800
Date: Fri, 27 Nov 2026 10:51:25 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Daniil Bobryshev <daniil@peresvet.it>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix Rx queue count with enhanced CQE compression
Message-ID: <2jbfw4bxkueqluj2vmom4hpcegfqac5rmnq77c7dvleu7pyqbq@2gevsvsqjwxs>
References: <20261119203447.41203-2-daniil@peresvet.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261119203447.41203-2-daniil@peresvet.it>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0465d61c-488e-46e7-c7ff-08df4c6c0c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261026121527099003|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vwrC7szO/Ycf79WWtpGV9TsBSKBYNc8m38ysrVo269Bl8jq2EeD6LMsy8WwKo/J5JGLimryk7CSLQ0jyQPBOOxMjm4Sn2C6x0dHOMhESErnbnfIVPS1O6VBpIcxH1S2guchG0tHQ6JBKHXTWd5et5dQaRXiwzkWwjqmiS2WEEdENKEYhzGj5gYeri1GveUU+2enauAitTub3f1k31AtYxNmMwwem2kkQywEbhKdeWQSyP+XCrgs6U33P2ZSZimFA3si1hFkYnfLF46T1UlC7tfX1Y+uw17bRHL59C5uFVJ5mzcRcS9zoioENPxqgijQeEPMmGgkyoExNr8irtQ/pOfTPyb8Pz5dn2Ui7Qqf3b1t/hkWG5EsmD/qnS4j+1y8eIsCyYN9Z91ETBCueKcSFjEOBb/JCMAh/v2Qonm2xLF37P/FmluDUMw8gI3mlUNXvJqiC0MBZ7YEBSTDaud9tq80zF+E87G/Pd6m4eRlEEO2I2VwrLNGaIDsbFpK4OThR5qq5EV0dB6Kg9wa1lewpqs9dQsq0MmW/7eQ3ndhY+lGxiCW2jogJQsP5VFdONW5ilVBcAE01puLdOh0VOoT8WF85Zxd63AXgiuVp1PRFSD62c38Q1YnfM3VZMZ7HHBbFl4oa7uV942f7s3TABpJ6UJSbQjBMYVkpK1/XT7Ea2+KP2Gj5BwGmdLK0vB1uVusqqEYm2Lau9yImsY5k4PSIlw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261026121527099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gAKYejPo7GAiAmvihWMSXxTc5JqHFWNfG0zl8QYGGasBIH8pBRVqVz1WpFGXtq8/k9F7qvB6CM0Pcm5asirNUsx847p8Onfy7DiUDoCoE7SN2Nk7z8kAEMuskhG8dwsL8WBkdI4rMSF6hxwAWGLTnCf0vd8VMuxBAlMof72A4u4wgWwJdTgYryAgfSChqV7et7trOTkfDxxNqvxlv4Jd349AMV7f+85IPo/3otqNe4TAYtEVrm/LlvppmF/fmzQLe59vSO0KvI/H29hbdVjEKwPyQShDJcn5H/q0ZsQNTddfyWlXG8GPHW2L0rpZlM0r+AReGLbcX5ywX2NC6EGFeWg1Fb8ynykqKgsUXyHuYls9cDomihtoBKbVI16YU+WEJVMAIWsLe4pkqKNwsRH3ITRDtU6ZgdpkbD43Ah5nBVXMHN+ioCYhE6tMxx1Uaxm7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:51:45.7533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0465d61c-488e-46e7-c7ff-08df4c6c0c77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

On Thu, Nov 19, 2026 at 11:34:48PM +0300, Daniil Bobryshev wrote:
> With the enhanced CQE compression layout (bit 7 of the rxq_cqe_comp_en
> devarg) the Rx burst checks CQE ownership with the validity iteration
> count and takes the number of packets of a compressed session from
> op_own (MLX5_CQE_NUM_MINIS() + 1). rx_queue_count() was not updated:
> it still checks the owner bit and reads the session size from byte_cnt
> of the title CQE, as in the basic layout.
> 
> In the enhanced layout byte_cnt of a compressed CQE holds mini-CQE data
> (a packet length), so the walk moves the consumer index by an arbitrary
> amount, and since consumed CQEs are not invalidated in this layout the
> owner bit check keeps accepting stale entries. rte_eth_rx_queue_count()
> and rte_eth_rx_descriptor_status() return wrong values, and datapath
> threads that poll the queue depth were observed stuck inside
> rx_queue_count() on ConnectX-6 Dx.
> 
> When the enhanced layout is enabled, check the CQE with
> check_cqe_iteration() and count MLX5_CQE_NUM_MINIS() + 1 packets per
> compressed CQE, the same way the Rx burst does.
> 
> Fixes: 02a6195cbeaa ("net/mlx5: support enhanced CQE compression in Rx burst")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Bobryshev <daniil@peresvet.it>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
