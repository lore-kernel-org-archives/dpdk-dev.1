Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEBFC591C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5292E4021F;
	Thu, 26 Feb 2026 10:34:52 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by mails.dpdk.org (Postfix) with ESMTP id DEC61400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:34:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0KBHzqvhXmvOXZR3uBhLerLJLtb8SJqkQMwf2HazW073xuAs23nmsfidh6L6mUos/B9InOTbqA4mQM09euX4qieHkWtCCFjsMmfdtNFr2BQUrE0SPw08O9Jgc9nXD0m5mEVXvE2ppyJzVp7Ky+9vbT9Nzh1K88ypPttEUbOCAO2Gtfvtf5W4Q/4QCp5h6mrHtVGmEiG/5xU4FKsbMggJEwHfrzF9Vxm2p4Kl6XtopJnNRcSVIN+n1r3T41U3/pQkypzuBQsRc21OKOzr8fobMTidI0QUFNxaRZRRYSdNcLX4UKid4ZFQ+Ehy00O+8C4gYR+eXuP0ymf8zOfGZqNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31f6cASZ6kSR9WCwea2A+yxpL/TyXe5ABftCOzRNih8=;
 b=RnGqxSzG/7pGgZKPZTWhN6A8ibU6oxkqCmDxXFvKzhr/iB/n5qbrhhJj6jaSGjinLRC62RGyoz1BRshKKcrJ55gaTFABPcCMF4Om336NAlprUYiiqAwHAZgtaeQsP024yKrVwKA6LY2awxNq9QwgCzT4aEGJ3Kn7x39rCq9SsOOK3G8do81QAhbi5ggscSFl6DRdFuJEXWAxuWSPnZ6Uzib/VXuvnZa73+Th/1dxRxqFSzPa+GccJtoMIz+jOc2CzLZQGLgw8Mgs1utktkb6h0Pe4rLPKGYdjadayce0tiwwWP6rLQ1/XPDUtBs+3/pmINgGUt+NTs438pZpr67QUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=akamai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31f6cASZ6kSR9WCwea2A+yxpL/TyXe5ABftCOzRNih8=;
 b=k6dad3Oht7tmiZVr2F55yL88CaWyteMBrTuWthiokpT4USa9DMLzNcU4bEiDFs8KeA/BNEt61lCaq+ZHrF/4Qfqzp2+FXKKUAzIZ16aarogrLCYTkgZZtFwObxAztbF4oPJcnVQSVeqAnOsN9jdAQJqV6zN/1grp0Z9dHIzwhpdFEUPGbtLvvVWTFo9mrf6xMKSXQd9kyfZTnCasg4sJhjOLm9V3V03AUyODJjqJ/0FZJOakZH7VEULVAVJieuGvjH2nln8xXo124RuxmfXeYTLzf25dFTNvxLG/ioAl/JkJ7PindzogxkG+keNKTs8oVESY88IUsK9acma1PWxecA==
Received: from BL1PR13CA0217.namprd13.prod.outlook.com (2603:10b6:208:2bf::12)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 09:34:46 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::38) by BL1PR13CA0217.outlook.office365.com
 (2603:10b6:208:2bf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 09:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:34:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:34:33 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:34:32 -0800
Date: Thu, 26 Feb 2026 10:34:27 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Max Tottenham <mtottenh@akamai.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <johunt@akamai.com>
Subject: Re: [PATCH v2 3/3] net/mlx5: fix vport action flags for hotplugged
 representors
Message-ID: <dasktcmgxqqmgyn3isk4d3s775v4wxwcepejicaauojbgylefv@nid43ot5q2v6>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
 <20260209161440.1947052-4-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209161440.1947052-4-mtottenh@akamai.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: a82f489e-96a3-429a-0c80-08de751a47af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: p4YG8sCZvdpdNXoMByYgkEveSeA8jGuWOUSvOM7KJIFUSVtQHDqGTS41zj1I+o89MEsDkDjr8P63FQy1BelPf2X4+HWfjwdWEcUh+59omRkRiIOtUAx0XXk7jyNUvPo2Hrb1hylRH/BQf1BpgnR/RqSpzUvnZUl6M/LNQxLrssBZNBxi+axnCOFuUB4HeeUVC4WTC1d9ZBrIDKoDGnUTXk4ZnPqK5eAri2YNChcmCE/fnQSToRKVhbR8Pnjh+HHjWICRKAatdTrvcpFyXDOD3BipBTLDiLc5tTTTN+Bl+wdMEw41ZUJyEjXBZwRf1Qitlfi5dLGkUL7B1+ZClhCMznekbK8rEpyYzgddyhIJdE3EV/pCHQYQf15mKlRSIoxzm0czC+Oiz7pH3SAQXdH6ef632ODrkec6m19q5sD5+40w5MJjQP4+wV//xDHglj+9RGM4s2+fD81JlYQxteddbcswu+HuYt9h+RvxbiFBz9GELqrAlwgKa/vDUZirHzvHth2V48z2PBXYlri1Wkq0NAUW+FT9SltL7H8M6Jpnvm4Nj1F7VSXOs2FmL6sHkuNdiKwkL3DpluoWtb+PmdflyZUNYLotG4thbuWLh7c7yd7CkHn6QSdWaPFHImT5fL5vrqPFZqPkkKyWLMhSQZgO1m8bwj02J8gCM3V+1mi4XPCrncuxhltFTMZ4GzoMunkUq+OQThRrOI3cyfD258sZfPhEJv5nIjnQNHovdSjENHroRjb+W2aEgOjcz/1LOa2nSc9suxnzif39GZOPf8sVhff5112dlFUUO6FL9+ofAADw6gSVJPZ7NjBs+3s9Kdx2dGWvNgjegfXbccHMGvzS9A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xdXnYZyQlh8V0DxkHeOmAQ82aUFIJQNl0DobP0r4syB5VGJcv/sEl+A24xWvBOarvtgEUXbfNQRU1o/d/olb5v9jXlDyDoXEbiXtOiuYCCsa4ZUtPf2p0OcRAAJBVL7Vh0ih3k6r9u+l9iNV/x/MEczZXllIKlNVNzNGP4giada3N7roeQ0ZXRsCJsMzmAO/HI/4u7mIpAADUblzTWo8zfG9KwwGLKneIoCaBIcmn41WJqiDXFCQMrTNJ2q2WPxsgBBGXdYsb2wRyOdPJPg+Ad4NM2/UrFBxo8L3nKnN0fEp4uaHcS03NIEkmnmGyb3DqFxpwKNXSkUd5xQ/AlrE7xNGz8qAZMfLBlJ8IJrLFe5N/gEq29G6mANW/8Gwhsz7agMGqGLoLPsXFDDGA2rXTORurTntu5aEwV9nbN7GShPJLiOh7tb8sYresfQJ9oTV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:34:46.3553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82f489e-96a3-429a-0c80-08de751a47af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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

On Mon, Feb 09, 2026 at 04:14:40PM +0000, Max Tottenham wrote:
> When creating vport actions for hotplugged SF/VF representors in
> flow_hw_create_vport_action(), the function incorrectly used
> is_unified_fdb(priv) where priv is the representor's private data.
> 
> However, the vport action is stored in proxy_priv->hw_vport[] and
> will be used by flows on the proxy port. Since representors have
> unified_fdb_en=false while the proxy port (PF) may have it enabled,
> this caused a flag mismatch:
> 
> - Proxy port (port 0): unified FDB enabled
> - SF representors (ports 2, 3): unified FDB disabled
> - Vport actions for SFs created with MLX5DR_ACTION_FLAG_HWS_FDB
> - But flows on proxy port use unified FDB mode
> 
> This resulted in REPRESENTED_PORT actions counting packets correctly
> (flow matches work) but not actually forwarding them to the
> destination vport.
> 
> Fix by using is_unified_fdb(proxy_priv) to ensure the vport action
> flags match the proxy port's FDB mode, which is where the action
> will actually be used.
> 
> Fixes: flow_hw_create_vport_action() vport flag selection

Please use the following for Fixes tag:

    Fixes: ac687bb002c9 ("net/mlx5: support unified FDB domain")

> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
