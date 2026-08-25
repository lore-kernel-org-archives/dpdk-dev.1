Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F15BC5DF94
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 08:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D93C4014F;
	Tue, 25 Aug 2026 10:18:06 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by mails.dpdk.org (Postfix) with ESMTP id 967D3400D5;
 Tue, 25 Aug 2026 10:18:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRwWtmH2FaapDWBEFh35bokw8wBVKTzab0NBT7+k1NQxsJnUFVEd3ljEqy7VfuxEfzUd8Av8wn9R7WZP1yHU6zv97Id2aexzysHmm+pVqd7vhzV6hJpE+VcVPgeQzc/V0jvrKlb2XCX2CKajn1lPF9Ffkyd90LOM0QGifuXmHMe2FxUnI0FLSmSvth6XDdpsuleVb4SfBhln3ixoFtnkWIJ1VRrR8r320LT34KwHQUako1bbKMOTdw9y4rl+lwZR+dfVtLLoRsrEt5oFp9SpIIos2yK4sRiwCvGgoJouHcNE3lK1/exJ7yWjPNgbO3L3+5eaW3xNOTixTscgI75wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VuNLVx7yzFb2dubw2F1wPFcyHe9bPaQEN+rGJWZl20=;
 b=MjxZ2b5CQm5PERS0P0SlHRunmqgsLUcjhAdhHjTggmX7Diej1XqfxoUl4876z0v5yPIIv54yCoiU6Hl8WCEbfgGGKAOVartnvjd2X0RT6LJoH9mR1wE+0ELgsITKT+6VDB6mfZ96fcx+jWKutURM5kpWHSzcT+xhuPmfx2kiZLRAYW1A4SDtCQX3MnLwWLqmeC7cR4O9RJ/CutEK4CQCxZmCGs4dNYbioh/REGMCl0NeijlG9Nmw2SF72nfrct6oysvw/mKrOqUzwH+NsyfbDtfs7fvcar9jSrVgSGGHDrHXqtL8RJ94D0e43HUVG/N0IyO8OjfW8kNlGohR4t/CVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VuNLVx7yzFb2dubw2F1wPFcyHe9bPaQEN+rGJWZl20=;
 b=RKAbnW+b9UHkzDs7nekiIuF5JMK9AL0takDnWaall8y2agMFtz4ibC/bHh50QhDcra6Uuj2XCwsaY9Vifx3SCUsgurP5/5PDeKVUcXNFG6H+6NaJz28UDH1v4uiJqtCKCjHTHqQBvk8F0cPEanWmUvQC14gbxwjyU+g2NPVpBCMQXJ9PueGMojFtcyl1S+Y/GkqIyqxdo5DV9sYrihex5apZp3ErlwBI6iGNC68SWu5pv3BqnEWhfuJ1a9Tflnzhh6DJuktAQsHsOX1sn3DYWEz0SGl0hWgr0q+hRU1kyonmRqI5aox09t5NoJ6VCvoOSPCatfgI2xxbGYFliSnhQg==
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 25 Aug
 2026 08:18:00 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::9b) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 08:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 08:18:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 01:17:42 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 01:17:41 -0700
Date: Tue, 25 Aug 2026 10:17:39 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Nelio Laranjeiro <nelio.laranjeiro@6wind.com>, "Adrien
 Mazarguil" <adrien.mazarguil@6wind.com>
Subject: Re: [PATCH 2/2] net/mlx5: reset promiscuous modes on device close
Message-ID: <ge2747agk5xmv7xqhnji5ljndo6q4g5eqpkidvgmlftlxq3fdl@46ou5kldwa6f>
References: <20260731092332.3833632-1-david.marchand@redhat.com>
 <20260731092332.3833632-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731092332.3833632-2-david.marchand@redhat.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: a2397cf2-efe9-4669-bbb6-08df028160ae
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q4o598aTrzwcrQcFCRoi0wLl5a3PllxVSf9tElZcaarM0pSKER6jqqN3465V6lp68jJHJZETtT5rHBjkzNoydfpfkRh6H7VFvZ76IjEJm/wun72/n+hEJtHDiSuI0nrGXosqEEjSsS3qFM48RPe5E/8Yt9lSG5UzpVtLOooxCHHxigYkglp07+4l+J48ZykhNa0hLCJbyWPWiZI4fipeQKpuWd2NtCD2nFsTmbcuDFHSljyMs6kL10T2BNRQ1Y9htgzovjJvmJx44td27dkOQ9hpEmEfLum9vtkZJFZEkmEQUIimhcyYeBw9NrBFT9ypWdkCTStJ3FKlNJAn6ytMoadJ+VONMsgLESS0o7CmTLdNnFpT93dIJW4pO+pGiD7GzHBHgOj4pwQiBAZ9Wb0OHnNc6MmPPC2x2xqPR9BSD6DEaPSjy9yoZWbecYUnqfjmLn4/KNhK8zsJh0/DAQieN+CZssjqJy3B9r1YndFrzOc7KWy/s0hrK4k4w6i+jggpdXxgp2qP5A6y98DigzPMVuEpRmJXdSWJKLTqRvH+WwJmKwkxRqjLoN8tYKsN/N59r6CFT8dY8bwi1IdyBd96kyUbRAsvqz7LP5KgKsle+Au9V/MT48xXCZ2pj584weFwJZEkGn6ZnnHCg16oilL96ZDXfWexACMNsmcvYc69flWA//bn2KDt2nH3gSkvbpmHM7WHyV0ds/CM1vEAuCkv9Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HSFh3setEAMMIORJl+RbKrwvzSOAUqnb6D+shqHS2liFt+DoHALdJqUBMhhJfFqBc6EHvysToKNK5lg7I6Y+v1JLd4JihO9JDp21ZE0N1WIMWUqwxz0R+iLRC4XDH42SULcjdZ0nHJiSUAfaToBhEsR6+WB5BdBp5+1s8m9LoOhchY0AQdXthDqRWs0uZizw5r84hfzEWDw/80vFQEhGSdCBEW0ulYrgOk7CZUpM7LcIflsioRDTbVHx6y0BpiMRj2GLKVm4hD/tfoLPlzYbmpQyiDUwQeWuzwFCBAQ1eXygeGI3DilTN0AwxwXPRCQapDeAfCKXzXTiIJtoar1uRrZs/ujEEY/3f98AA39Gda68MAF3vdBewWOAt7PfcKu4J/8gdZuPO0OPv/pYtAv0qxTgl4DW91qFi1iodT1qDlgCrIny4QZexnk7hR3spmR9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:18:00.4136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2397cf2-efe9-4669-bbb6-08df028160ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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

On Fri, Jul 31, 2026 at 11:23:32AM +0200, David Marchand wrote:
> Since the DPDK port is backed by a kernel netdevice, leaving this
> netdevice in promiscuous mode may have unexpected consequences.
> 
> Reset promiscuous and all multicast modes on close.
> 
> Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
