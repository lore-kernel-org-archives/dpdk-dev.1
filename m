Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C81ECD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 12:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAB8F4027E;
	Fri,  8 May 2026 14:52:41 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by mails.dpdk.org (Postfix) with ESMTP id 554274013F;
 Fri,  8 May 2026 14:52:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alJ+dB34tfinXaJt0GpWH/D5skq6GGn1Rj4Jr6ZH3xd8B/StBvL9ZqS4hw16aRmm/GgME9BfTkIQi1Sk6Oo98QB8Z3bOklyKKoOss8u49QGTILxrmxbdLl2LSG2UCyrb+J55iIEDg+Ya8dEhIIJzuGp3q/1OxeAd816F7MCfjaoG7Imat4/g58Yh5BRbXMVyT5aSTgMPqlYoaPUHZO7O+Mdq6dKenHtpJ7dpGojSYmpNif6weeOtXCteO+nLn1DkND92BTJ5yIRHvR9c/q3OFst/vA2qaumlaOjbWWX5CfzsT+ADyTlssZzOH66olPcKCyH4n01tGC5QRq8pyS9U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOg0cituG8eXJE9wwqJYOkvtLMJLBgU/egXmMgYxyTA=;
 b=rYDPG2Y9GfLvPd24c7c31Qcp5M65oKhqpoah7OHGoe5Xa6+N9/95EX6dPJU7y72NiYQ3Sm9xaGmbbgtkdkTuy7du8WcptuUmiVqQBd1utulN2tbpZ3Sb2RiSHTenf3OqQGpiZ3sKtsinsb1Pkn1CXFWIr1ZPRTXgHngmh2pQn6mVOrKFrQ2KUP0TzD0/1QH+nsPjkkCqUR/bFdUal8L1NPoq16WU9ZIGVMLAOR7DDRXfvV3+g+vRmU4LYnqFkuddCLP9MrEnDK0BaKYS1Begk3KcqESGv+3NlnW/VtoVzJjJ5LoNf7jv1kDx9DetkAENKZXmfelwzmdqABxyt8vHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOg0cituG8eXJE9wwqJYOkvtLMJLBgU/egXmMgYxyTA=;
 b=qKrRmMV1f3z7aH+s5uhR9Ctz0UwGyjjhMS53G1CgYpXTZOIw7buiM8h/xxQhd0574j8QHbCIzIlng3KsftJdqlsmlvPzQF0jA4c5IOFMoLv6f3UmgLL0ZeWld+A5k5ZIbyGgXQ/BiamSmj7STlTW9/ga/pYuKO3TNpoOIOVaA1JbKr67IqonMOGIkq/333Q7Qu0l2vB3U+heEsPG8nWDDjsarISLrSEMfn6As2om2QlyMmJAVllUv1FdbHs/OWJLL0dwdhFW7ROa0cX/SN1sI12JejA0N0YE0BfeengmqknPIvDQpwP3Tapa+BtO8dfN97EF6FiCv330yP9QOZ4vpg==
Received: from BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26) by
 DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.17; Fri, 8 May 2026 12:52:29 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::f4) by BYAPR01CA0049.outlook.office365.com
 (2603:10b6:a03:94::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 12:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 12:52:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 05:52:11 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 05:52:11 -0700
Date: Fri, 8 May 2026 14:51:57 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yunjian Wang <wangyunjian@huawei.com>
CC: <dev@dpdk.org>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <rasland@nvidia.com>, <viacheslavo@nvidia.com>, <jerry.lilijun@huawei.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH 1/1] net/mlx5: fix crash if malloc FCQS fails
Message-ID: <lllajxtadm2elepidzitpia3xg5gfjayzn7yfls6d7ubf4n45g@7gsgv44mbnne>
References: <1777027713-91888-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1777027713-91888-1-git-send-email-wangyunjian@huawei.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: cf075a12-6cbe-44b5-772a-08dead00a915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GhXK5SiQ00sJMi87hCIASuZ+xj35A2BF2t8ia0DIdz7SFtOtkqkyCegZE2FSUBZmlG+c5yaF1mXKk4X470fl/iy2dPtFq+Ure5pBzN7YxAvODgiQb81dSDnKmA6Ke0H9iXV5BHKucuhUMxhSUc7U5XtKJKIYA3pEK68NiZny9mPnGMRGdsZEnPgSvnkxuBzQkZcQ6hMFBWyaVTokBOZVusWv/YCGnldRk1NpFyc+kuk4snkHELPj1/saTBllxTdP86aFivSKSt7VynOIlnu1CBwwOppgEgfyn5PtvMSEjiskb60Ks+bi359aHUNriXogja2qjIbOn+UFZ0QApv3tYA/I7k5Y1BTs1nxOpRa/pDHDBb8C9+/YjJ+14gJAQ1Q3mXRfBS08E7Y3rc9jJxrSkSmEpSXwgG31xV7QBmCs8hpkICct0NvLXnjqNIpHcZLHTNqCW8P9PUpB+X6C4EyDMX4xTHBFD8Hug/ow0RfswsIdgd7iXuD2so9FUWFWfPpmJ12R9Rv9xdeRAHptD9TKWBrxgcE0JaKvRLphyzPGx0/714MwYL1AGLLNmmXJTRTUWjxvfTyTaCYSztnnuo0yQM+4O1Lqwi97V6ddsVXL1qd074fL4BzmJe6EU4z5PFA7QFJMGQJ/CWn13DC2weR2skLGuAx47VEzZMsVclfivPk2IMikaRzYzaNXWaEfh/9RXo/S61bwOIjrlcUzwLTV8CLFb4Ti81Dx1fubLQ7ares=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PrOGedogeteslgkCqrBGjGXkuZ8JiSGuywmP55JbRehhmTII+1Jq1oBMV//kFianh8znFTBjItFmwCgCsSaIbhytPLKzZ8Yc46E2BgbPyn22jSVKCX8NM2xt5to4Ecn8rxZ3/sORFkJsYVplRtLr16i70UApqQthtAlICSPtT1Zbq4kMGMySi8d+m8NNwQZmbE/2cqrBA3GnskOsmFJfAYSLb0CfG2RwIgk01pZxedAzvrTngHzH+jwnPMxBAs4SKG3vDy8lNbmZ7dY/fDx/ydk8aLa6hXhf2wndpxct/fZAWYr1NgMZ84nQh5IcP9mXR5D1/DJTn+iP+C5RU0YBI3FMEbJC/eVKPk8OUiZZRdOFzSscrXx7uR9y8/pbndWtSai8qoExhbeSnWIjYfRNTIz/ORdYbZu1Nhkm8OmINYjHsIyo0JRNRANRwf9w7w/K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:52:28.1281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf075a12-6cbe-44b5-772a-08dead00a915
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

On Fri, Apr 24, 2026 at 06:48:33PM +0800, Yunjian Wang wrote:
> A crash is triggered when memory malloc for FCQS fails. Currently,
> the abnormal branch releases the txq, and it removes the 'txq_ctrl->obj'
> from the linked list, but the 'txq_ctrl->obj' has not actually been
> added to the linked list yet. This triggers a null pointer reference
> issue.
> 
> The call stack is as follows:
> Program terminated with signal 11, Segmentation fault.
> 1210			LIST_REMOVE(txq_ctrl->obj, next);
> (gdb) bt
>  #0 mlx5_txq_release
>  #1 mlx5_txq_start
>  #2 mlx5_dev_start
>  #3 rte_eth_dev_start
>  #4 member_start
>  #5 bond_ethdev_start
> 
> Fixes: f49f44839df3 ("net/mlx5: share Tx control code")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you for the contribution.

Best regards,
Dariusz Sosnowski
