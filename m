Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFFC88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9BB040269;
	Fri, 11 Sep 2026 11:38:53 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by mails.dpdk.org (Postfix) with ESMTP id 8BB8740264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:38:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmULI5XSVkp58Jz44B8yP77I7bsP17o5KK6GVvVrp1BQ7x5CvfadnBKzRTShmn1Z904VUSXxSeKrm03R6V7/Gun0KoCu2ivmmowgMr9Ja2OS8DsrRZ7Kd9tuU2JZJbWhO+x2DpnZ9oIyBYsPM4bOoNHwkwGCOIWnLoKkC1O7Jz+MnW5tPQedMBYrthFyvcb1s5ZtZ3PMYF4Aw9dqDohQNUFX8UrGjVM8aNbd2hpJXf2mMKoF//FitGe1KBD1mCHIBwGG0AabdmwqxoIcdBV90ae6EQd3+UOxJW1Kl1zYUbbtEeFgyju8hLoX631v/dI9vrTCCywTUFGfnzk8BHb87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRgbAp4sKVu5V4/VUMz2gZXkZhuUXxI9bOjVkjPxVh8=;
 b=ftbY0OdMbdTInbc9Xm6EBdlUczhmtzhjgDcFcPlKWh1w+6XRhTR8jqlrdVw6o+PS5XVmNtHOCKDPjcUsbLPwY8YZKD9wn04tZGszwQstNVWNMtg+LPxl39SGH8OBi+0EFSn6G8rirWPNWQkjp+YqCfTJNczMLRhzt+uap2Ht/JmDxAdS+lewvyDyNBDTPeSnVS0z9IUTEL2J6Ze8LvDqRCLsyIVP3PsiZFZRreu4e5kvGqFEGTLY2QdHAaFXNvhl6m7/icIZUD079ZsgX/gCCPYgPzkBrE0qlf/LhZoCOs1UcqkG0IhG6SBWQdKEA4L1e07+wXKoFulmXOaF3o4gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRgbAp4sKVu5V4/VUMz2gZXkZhuUXxI9bOjVkjPxVh8=;
 b=IPukW6Sm24BG2yrYARb1Ymmktalz6/Zb3ASUS+L1N8nwMRwNZ6VqRK95VGnSqiK9Cb6Zot7Jb5LxGyd3fN1caY9cUDgESpPtcZiL9XRJ8oohvwOvqJdCQHNQ7m8sP63AEtXKLvWDJXxcnV9HW1qZ2dDa/cy+CNQKJuPp2xRR/cuqpzBMePWMAk1DRlMoUXYPwmCojJZ+c8dbLzn+8yBbSNZPt+T7Ck54DgGKKps/HkHUafZdZLodOOlLDzygQZjLyMFL+kpmb5z4V2AwTT0QVjtIR011eW4/vBJsJ/Co/rb29N3N63gpE+epIPQlZ1r9sZz7S10mu/FTk3Q/sLvN+g==
Received: from SJ0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:a03:39f::12)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:38:48 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::71) by SJ0PR03CA0217.outlook.office365.com
 (2603:10b6:a03:39f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 09:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:38:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:38:36 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:38:35 -0700
Date: Fri, 11 Sep 2026 11:38:27 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Igor Russkikh <irusskikh@marvell.com>, Julien Aube
 <julien_dpdk@jaube.fr>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes
 <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, Jeroen de Borst
 <jeroendb@google.com>, Joshua Washington <joshwash@google.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Jingjing Wu <jingjing.wu@intel.com>, "Praveen
 Shetty" <praveen.shetty@intel.com>, Andrew Boyer <andrew.boyer@amd.com>,
 "Jakub Grajciar" <jgrajcia@cisco.com>, Matan Azrad <matan@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Martin Spinler <spinler@cesnet.cz>, Chaoyong He
 <chaoyong.he@corigine.com>, "Christian Koue Muf" <ckm@napatech.com>, Serhii
 Iliushyk <sil-plv@napatech.com>, "Vamsi Attunuru" <vattunuru@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Renyong Wan <wanry@yunsilicon.com>, Na Na
 <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang
 <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang
 <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>
Subject: Re: [PATCH v2 03/68] net: add missing include of rte_memcpy.h
Message-ID: <2eq4ipdrcek56pgqk6i4yilu7q7c22e726boggwxe6aq3kftk7@knecc4hjtl4u>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-4-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d193f51-16da-4d38-3cad-08df0fe87a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|7416014|23010399003|1800799024|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YGJXDK9hf1+3owlXzUSFdgcIGh/RmCGCC/T4KbRUNt8vhBzP207FhDFXjgDA8Z0uvSMydb6htY/SeNgLLB4wirjqacM/W1gFHnn4h3CC7uLZKFP0vXSeAqGl6OfinVB76isXmZFf47L6iFUaJmUIahJiBwFlaTziv5cQ9W9Jsc6KnKh//5U+0tYtLOdenKaJpqf8l8PcNxwMHwet9qTtR7oJRN6v7LYHLpKz9pkf5qdDrH4VHVUxfrF+K/6Bx3aSYWjG3d8DeONgHSZeKVsPkW719uQyxy1UhrEB3Bj1agwH+PyT6m0I/lnRZg8DAFd+fOANfbNzA2snJo2++aUfhb7AKaVSzyaCe/h5G0ydUwhlCYNCyZoZep4lXv5cU/MfNTpvsg5+GntJQ0PweMBbPrMJrf6Vv0Oe57D8QE4GwQDkTa5oaSd5Cyk6Epf31hFY4USCJIQJSzJQDJYlzFEVg+HlyuuLJ25QsYQNDAWpyGHumBKnDYsxO3Ab2Yiubwu/1ijCt+TNIN6zwLI2fzAr9mgSPCbDQEM/o4oP5oNXAY+jqw/Yh8uwirQfgR7svzeHlaqOEbFYNfAVFbDNowrFHqrC38GuJmkjdnk5A3dJfB3giz+b82WgrXWlQ+dQjFDPsdsCwBHZh37Pb/OGB8Lqw34tTA5qt4anc/7dUYfQEqoRYbggAQ6HPpuD6dfmFA2lM8/GXe+ccbgTvUjPY2o82A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(23010399003)(1800799024)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5aB0NhyoTz9gBR7w6gMUBI/mdFnQJKyLZE1bKJTtmaWExAAxnOyydFvaSpcvL1wwxDRUoVeHoYWjDwvwnjkbNiYB/UCDhVC6pIbWQ6ME7WLCDpJrlZe0TnAR1HxtlqJO79fpY94F8yO8X+PDlVZrEMvLINUl6NQaZi+UhIB+ACIBIb9Gz/oz0d/FHrJr7K9eXYuMfFksTyVuWQ4aOEhxxJez9ri1kwCDUboTvsHUWEaLixM9PajhOnpJhlagZzQSOSDhM6Zk0DdcKam/XbKt4nJDzibUJh+88FjPlG/IuTgM9lwUYbfHiA49aiXnitj3JYcd4NqW61Hjy1r6BLCNtw8mhEOh1RjPJeydXJVWq1g/HAFcrITTharJIHwxU2MT45/t/1U1BsFrXdCVLmuyGcwxREMmxI+FyNDQHYAKJaZ+n2BuGvq38MUdFkizP8JZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:38:47.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d193f51-16da-4d38-3cad-08df0fe87a89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737
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

On Fri, Aug 21, 2026 at 12:23:58PM -0700, Stephen Hemminger wrote:
> These files use rte_memcpy() but relied on rte_memcpy.h being
> included indirectly via another header. Add the direct include
> so that later patches which remove now-unnecessary includes of
> rte_memcpy.h do not break the build.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
