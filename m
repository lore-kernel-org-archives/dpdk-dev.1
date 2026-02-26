Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD24FC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:36:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C765402BC;
	Thu, 26 Feb 2026 10:36:08 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by mails.dpdk.org (Postfix) with ESMTP id 16B3C4021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:36:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQqmNdyU+rCXO14TWbnazgG6CgQOMuIFtqJQCQIYwX+SaXoEV4X92bx+03vhKSYjTjOMiQTswAtLXEE3jK6ftmIgPltr3wDc2IIJuje6iYk/Bf0hf1ow7q9wECkdbmy4H28Ag/5IZ+9Zj65bVAVK7AOSt2p4Q5m6C5k1bPoXZAYi25Nq1h/DgnJuChKwKmOW5BppBgXN1pZRK3PpjUfnlsIxcgeBeqgLRz0a9YeGyv/08EO/fKVZkTb0OWGi6dcsKFPABXo+mW0e4EYJhjn5GgDjGSzTjqBVpr1diFyFjPRJHspz98NeD5ZCXauLKO6VUQIpo07aMOephymDqXrrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/WFHjtE6oBdctz69W1LSqsHKE58WNSPtPz03GphfGU=;
 b=DajyprvDwHXSnB250KsD092CqVhIg6556QTHxIeRebG+r7i4wYHCJ4e2u5y0cVCLR3cLCe60TAbgOhBXGi2ztj89Uz2uG5PbZ6yy3cQAMG9/+odOm/gR9r/c/mTtrFP3zY5LmaqUmH0tS+0LRPairiYj8KXLeEVvMNWvsUDTMav82crvHzXqcByGUIfe5Q5yA7VZ1pLhpt+BDUnD48GDspHZqkMah+31MbxvkYtfjFys9MzCvnsne2aLFTXKzpS9kiB70vJoTYH38ew+/WrNy5tisqPwyYkvIXZYW71RrrTkNRp0ROmO+ijNukmaSnf4wVcvB4na1ZYbKHiQabS2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=akamai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/WFHjtE6oBdctz69W1LSqsHKE58WNSPtPz03GphfGU=;
 b=Ggo+vllEPhmK7gdvJ7N6oGpLQ3CUK1YUH8WlIVYCL3AQSe0ypPQCkN0SAWIhfOBj06ggphQ6sYGso6BMlGL1UGPbwXlrIsf88Oav7xt/vkodluuxbAfzvjTRtDyXuZGZmzYnTkGU48pCb0Bnji/kEs7/egCB/rcFvmQA+GlQElctBX5fmvcE8G757Ys6fkv/cBqUd06qR00oW0/3gNSoeAhGCuQNTmxSA8O9EJXABg5THa47MpnyCsd4ChFOnt0MLKwoJ27XDN1N74ATmMFTueyjCOgGyPrc7k335qzROsWjr8d+b0Azxc83hd/LwmtldgGEfZod9rNtvzG/mP6Whg==
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 09:36:03 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::c4) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 09:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:36:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:35:48 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:35:47 -0800
Date: Thu, 26 Feb 2026 10:35:41 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Max Tottenham <mtottenh@akamai.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <johunt@akamai.com>
Subject: Re: [PATCH v2 1/3] common/mlx5: fix ROCE disable for auxiliary SF
 devices
Message-ID: <bnrq5rmv7tnmmuofpwiwig64rrjy77lkwsphppekgvkcf36unh@mipumwk7gdvo>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
 <20260209161440.1947052-2-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209161440.1947052-2-mtottenh@akamai.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 83470d45-160a-46c2-d7f4-08de751a757b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: cTYbqL2J8DMrjFPkoxMx3f+78VMSBrR0bLbHC2cw/9a7ss4E84Qji8JOfY69QehoVIZJZPFpaiegDN9aldwLPfEtKVb+A9sI68HiYUHlN/HQ5vyi2Fv/xbc5Gfzs1BWcK8LMdWbEY3xh82mkduXHJ08bu+GJL//O80DX9IScrxs0V1L/uRqFkQ7E8nW+FTMAOY3s+HU+cq4fgSkXPKmt0Orf5gUXR5QXOKih+abmw6rSqNnkTlpBpo2H7UPBRTKboaosz65TV9DkTs6PDzZ/2JFsyLTOcREabf8C+oLj3sDhdGJ0QGHfMpyDoAFiwmI5M6mwoGBJ5vnhHbnfzs+8LKYCh8sigtgs/0ZxdbCwsXe+kIbVeXbAirQlXW3f7cH5ZjsuR93wb7T/hVBy/bifNSvG9oyfIKEbnNGmiBMNXLh5nRBo2rImM+EQf8+rKfm3RCbshDEM/CjHQWSRdU5Ht2a5xB03DATZTt+FXdl2j0B64l0HohNgGp4LYTAqcVN6sxCx3OIK1kVuNuqwYbLYZbGOWv+j1lBEj1yvu8IZCmCMa01EzYGtBdIBsnYcc0fDuVGF72XE69n/LREV8DXJC0gevV/XqeCOR3bICGNUW299MidKup7aD6ZFZLZulQIK7Mrlop2fQnp4mAObyGCEnlVXWjPL0EExexaGc8jyrH5Pj25//ybEyEgfIMytHYCL6vJrn0bJtv2vXbWatQjZZN/NxwTXlENlyGWJKsH59Nv007omPSxEE8d5M5cGaL9Jm39KMiLpRYXKXhlqrppuQxVPL3S3z/00XhPSJysz9BRxGvqn3E3a+HQCVsjspsstbbHzHHkygzVOg3xtEakWuw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aidRLEJg6F8Bi4mZ1or6jeczeQm8r9m5rrY+VljPuUIafzg0zsfV8geA28GmpX001xID0ExftCgMmvSpSfxfKY3bdm2OjR8/1TYlqxusX96MOwnjpZe4C0Ohpn82zLWvQrpQZZBJ0JezWMSDZvgj1oznhU3enMqbw9iKSAbO+f62ZXX3Jg4jyJFVDZp4uV87OCc9zSvpEHBxbHA2RTRKwJWpzerQcq9CYpOhL9v1Zb7TbMDm8RI9OnqpKCKLz0wf30uyq970Z0dHu8y7165fUrhU+TUBZf+urK/97ra2y9xANQzFRSDa2JN+g3YviJBd58dac7nNkP46cOAa6ys4czSmFRMUGggLjTJ/KORVkvUgc9MVp4XmSYEMubnhAZvlEhGSoXRRj/q4+ywolFtW4QuHrXjfndtvOVmA9LqXS/dCc7KvClTYYyi3ZdaCIwLb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:36:03.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83470d45-160a-46c2-d7f4-08de751a757b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

On Mon, Feb 09, 2026 at 04:14:38PM +0000, Max Tottenham wrote:
> When probing an SF as a vDPA device, mlx5_roce_disable() targets the
> parent PF address (via mlx5_dev_to_pci_str). This incorrectly attempts
> to disable ROCE on the parent PF rather than the SF itself.
> 
> This causes vDPA probe failures when the parent PF already has an open
> IB context (e.g., probed for uplink ports or SF representors).
> 
> Properly disable ROCE for auxiliary devices by using the correct devlink
> attributes:
> - DEVLINK_ATTR_BUS_NAME = "auxiliary"
> - DEVLINK_ATTR_DEV_NAME = device name from rte_device->name
> 
> Refactor mlx5_nl_enable_roce_get(), mlx5_nl_enable_roce_set(), and
> mlx5_nl_driver_reload() to accept bus_name and dev_name parameters
> instead of hardcoding "pci". This allows the same netlink code path
> to work for both PCI and auxiliary bus devices.
> 
> For PCI devices, behavior is unchanged: try netlink first, fall back
> to sysfs. For auxiliary devices, only netlink is used since sysfs
> ROCE control is PCI-based.

Since this is a fix, please add the following Fixes tag:

    Fixes: 662d0dc67192 ("common/mlx5: disable RoCE in device context creation")

> 
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
