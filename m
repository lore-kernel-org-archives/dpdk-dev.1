Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4570CEC01BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CF5840647;
	Mon, 23 Mar 2026 11:11:15 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7C5DC4025F;
 Mon, 23 Mar 2026 11:11:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTYTE++vdVXlU0T76mBVofnSdWHmKVdnBxBHLKG9wwrJiqHEQk7Wru5fnPAqbmKE+uAicfstWcihFUGd6X/vu7kY4OG/BS2TH8QI5Rq9VXQuVgWs4AsytlzJ7CoexIcPrwRdL20s095d93aB+o2E2bw51wB54gV0efCc9S7TwckIJ4kbfCJQhmMZ/wxxPVoqu1DTZTYEZDx8CO7DNhVBwbBNtropErQlhk0lccLXBsIq1LVyh2jZ350ZOR0JlGf1WL9NmEYuZiMs9u/KYwwCIdXhOUh+spnu+2MdC6M8vBFLgDVs7GP2Qp67Aa9AvLQ9UC0hVRjE63bGifoT6h6BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L1huVPjm6AFZrjT3U7rb9smxN0MyJffNTnXPm39kys=;
 b=JQ2++Q3rM1dNIPVjGrytATEc8XYGZCMOJ1ZDRE7snDMK8VTMumm1TlSg0hs0lyduAUQXFf/XV4IVrr+v68q2d1N4SWJgz0L73Wnf9nuoLhTTwD26WNUoXuZ/3urVONIEJv1G9gcuKM1+eqhagMJ2gx5CQt1WfO1ekNFexATDVALSiK/4e0/slBs2gAdxwLWlZkug58+zvXO8a26e3gZfieW+Eeir3JR09J5wped3kkf89JToQ4ACoKCnqAv7BvXHp13/UeI6PlsLdZIkvGHoKxIl1ENw2oBgZaQYG6q60ICISXgokFWtc66ule+qfulHG/I6DCC2OPjFbjBGXDht5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L1huVPjm6AFZrjT3U7rb9smxN0MyJffNTnXPm39kys=;
 b=U5FVDQQLoOf68q9pXSnw19FgpGPLcwmo/BX67ALuNJloE3VGp/wEArFrvVChYUP9QVIozDrltGTHdA+gbVX1nqyVFjdRmXHdf170IwibzyYqNaJJ+zOV0sqMAzbKvQ/SrPRRM2QZXpbDOeZuwVdT1DSgEIPV1h6BXN5XNnz8hfdbby7zh/BHzCZAKdSi8MyvCGOC+X85EGWaveu7ePPr2UdH6xFlez4WZtoiBf4DWxdNo6cWTLqK+E4hjyXVH9CSoI0skrjGINMCSOjIfuFAW1izK562mcH+kFfgdakJGqNStS1h561hxhi2arUzH2NAnxJkhbY1L6mnhktI8zn8Zw==
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 10:11:11 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::fd) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 10:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 10:11:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:10:53 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 03:10:52 -0700
Date: Mon, 23 Mar 2026 11:10:48 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <matan@nvidia.com>,
 <suanmingm@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix send skew settings when using wait on time
Message-ID: <6jasd2gmb4nzxhqrklusi2g4pcfg76ngdzzmbwyt7qse34dafa@cnovkvrnumv3>
References: <20260320111410.148572-1-viacheslavo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320111410.148572-1-viacheslavo@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a9dc30-d8e3-4335-d1e0-08de88c481eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DnnyxR1oF1PlXMcDkKYyHcUZ7NyG0LPem4HqulpAlYESJ5x0++6Jgt9VQ/4jj/iujgHONPZegvORiFGcGYniqXe2BTMb/PGrS+Oe/7YN+WB0jXO6VIH3+96zkBuiagHMWyw0B+WV6UTRzXtvXjatvGl1uzTlcunlF+sO6GM3ugKRmxUL2eIvXxhKE102OWhXZ+iOMUNE/T4Wb/ZPhjWcl33OSzcGYSRLfqKRpJGKusSoLh1/QZk3z9x42qppuEptjJ3y7RaUBfM8LERi2sSFg4Z8lPCP6vAWixSLFlkwVF6Q7ajCCCS+W+Kq3rXloExTzRybaKIcr2kKqqNTo+aohpRWtuck2vAjUtFNK+yP40wDUSYP+Jv6x9eDBM2Lw89qq+N8k8sDbVldvgPe4pd0GAvFttqTgpJydNfZ3aiGmzkga4Y9IYTEhn55HL11dI0Vi8IyzhTicEG9Huz6w9czntfux+eGhGF45rcmTfg0yc1A2rp4vHrQMrKenv+lFX6FH2EMlLPPv+qV4aNQTBaeEDWupCOYlluXLkL3BmXkgzDgBoORb0dJiVkSSXvBOz70EOQglgHai6FRfAflJDOg0rhJqRIDPMv9Hx63gi4GAXN8Uhj7u/iNek0p2EMCZbazSYyu5qVdgm2PZ10nfKkWpN7BTMb5427MuPYoEFmC7/usxvmgGdHsCU8l+kfjzHDql3Qi0STVC0w2FibfEpt5RJSt7ebIp0h8jqWKwdil3XJ9D/2P2A4Xo5YzsalGqNm6Oks/D7zhbBlfCkcg4rjGrQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3NL9PNtk4dk7owT1xDH9CThBu5ZSQcn5QJf1iErjKKmFGZ3yWpBJbE41wM688UpMyJUeY059sRE4zm6dayr/PTXGV3sCzbK8NRsZfRwVTNS2EdCW96aVO2shmktlHpyq8MAtY1TKygY9Xt9BBJXghb1L5qihc+BreeE6N+wnlHprmM5fumnoDnxsHKOiMKqToE58BWfgFMQeZiwxPl6vW7jxb7Dp9lCQffOhN0pKP6lVxpLwBQBLjFdYxAsQRkfq5hMfMPQdLbrlegj/GhGpzSoqSAMeWhHtaNBCRHm0GNJw1owKc3RjNgUV995hliqEDUUx5A6xIe7d0lRFo+t/ceXyZ5lYfyyoHigCMc4w57c/2EZVxuHQDvZ9uBUAMrVxdZvK10tNWUzUhp7VV1bpg7TQyv2JHTcEjWlrFR7mnx8d05zcK21054j368pMZjWX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:11:10.5939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a9dc30-d8e3-4335-d1e0-08de88c481eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

On Fri, Mar 20, 2026 at 01:14:10PM +0200, Viacheslav Ovsiienko wrote:
> There are two modes to support tx send scheduling in mlx5 drivers,
> using the Clock Queue and tx_pp parameter, and using the wait_on_time
> hardware capability. The tx_skew devarg is applicable for both, but
> in case of tx_pp=0 (that supposes wait_on_time mode is engaged
> on ConnectX-7 and above), the tx_skew setting was missed (as
> mlx5_txpp_create was not invoked).
> 
> Fixes: 2f5122dfc41f ("net/mlx5: configure Tx queue with send on time offload")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
