Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DCCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 12:32:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D37ED4065D;
	Wed, 12 Nov 2025 13:32:16 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20]) by mails.dpdk.org (Postfix) with ESMTP id 0610640281
 for <dev@dpdk.org>; Wed, 12 Nov 2025 13:32:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8YbDN6hnlUImDxyPXIrH0hnoQPQgimHO0JlYtQhXhOWYSQ9l7ek+2/fzY8aB2l9kxyzJnc09K+vMVzkx3/bw2duTsqadAA1tsKJjmxfwP1RUpwKu93+lSuv+mxyoOnA+U+W/c+PvbYaHv2/8DdQYVWT5wSK7Z3bU/ybebEJNn6/psVg14HzE/yL5nfarM8L4AbkTYNm6sNNWxOHFDIBULxecJjse5Qb9tolsdtE01XgV4qOQXG9m+pIcKLgVlXrH99ZRxa248tV+885W1EkkiB2/ESpEAtbvhZOgDC6AzhojUIqg8Nomv05YTrGhhszJw9jagJVjZiuk/TZo+aMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6E1/j0fVtU2C24vhLzOF2lH/0MNU8hS4POx2fL/TPc=;
 b=dnVkYY7LJeSAAUIG68hC4HB9vGZzvOCMoUAYn69iDsictCarRkIi0nYLy5DNP37HS8ZGWcHU0JhqWoUKRDvk/Uyxb0no3J9VteTSb9HVD0xJisyfkw4cAMyCdPHzwf4sxW0VrWa7F1KIC+oKMNCx9vHYQl6JHxY81NRIKUrMC3F+oLW1l8WDIoEHsIlKSiKGwlGcqhqCHOc3ZJLQC4OtmjisHLLdFVPfPC8/85pcE5qTlqP664yNwXSEydsKfvlG27zJ6bBsPxjG7id1JBjaar4oSeq3DbTKZbjHTQfKzF7mES0FPDj8QVOaTIa6nXDcQB+ITSQdM6R0APMVEDmm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6E1/j0fVtU2C24vhLzOF2lH/0MNU8hS4POx2fL/TPc=;
 b=srPyqBkRRD8hmLYDgSm5Hgckdfs6C7k6U2vXjmmKSAFVkIw215TIgmXPUuGiQub6JlnCXacrdb5iGNEWNRREjgLcHkymnw2AeZf8Y55qD49rU1QWx5OuJ0aOWE9ZUX7HKW7WbGkD1ID51eOfJ0n79523SmdNn0qfZzy3W3vcoN0Wl+f1QBtZ/s5NXq+8aSpHv/2xK2RuQ28F51f85vQh58ou7KNaa/Ur+woxLryikN9wlWIyMKczhlDDdGuNI5YMAqt/ZgPRWGIfjKpXCXS9PlTfhdRtRxFCKQXCCngNi/0bhuCj0IIwhQr5b6y/DF3+UXCao+z7IbkyHxnXxwQWuA==
Received: from SA9PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:6e::13)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 12:32:09 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::18) by SA9PR11CA0008.outlook.office365.com
 (2603:10b6:806:6e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 12:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 12:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:31:54 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:31:53 -0800
Date: Wed, 12 Nov 2025 13:31:50 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Jiawei Wang <jiaweiw@nvidia.com>
CC: <bingz@nvidia.com>, <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 <rasland@nvidia.com>
Subject: Re: [PATCH] doc: update the doc for support multi-host lag probe
Message-ID: <20251112123150.ejvrdniyujcxpovj@ds-vm-debian.local>
References: <20250930120247.24926-1-jiaweiw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930120247.24926-1-jiaweiw@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c1507e-b6c8-41a1-41bc-08de21e77fa7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GqMG9mzlrCKf95p4/c/ZprsAR1+fgs+wnK/B8McJ+xcCEzB+E92Y+2+twmF?=
 =?us-ascii?Q?fJWrcj3rFFcZqyETKAwRVbixToVzo8HBRTvunK9XtxWtiFROcwRfPtQo3xnT?=
 =?us-ascii?Q?8nMMX6G9N3en6lfYW2dFp2gunFeot05uoGIqyCh5l47J8Eqe/eL8VeTgyajS?=
 =?us-ascii?Q?y1D8ONZim5IJ+QLAwUQmWCTnCh2vSwlXrnF7aeFE6cmL5MTXAU8e6YPQdmDR?=
 =?us-ascii?Q?3MopCEJtl3uoWr/9h5jRijOBmtUJgnaTdNaQ+rpV/fz0vWSuR+8Ups+NxWD7?=
 =?us-ascii?Q?OGbxSoZ1ec6482PVwx2c28DcR7xeflXt0kZilkApK6ROOxKQ05cFzlHt1emp?=
 =?us-ascii?Q?Q5R81nnbuNRFEYJ+gtCZpSEhOy4s8Dy/0fjnQXn69bU7z+5I9nVkfxqsfAc1?=
 =?us-ascii?Q?jVsVUNsS0A02jNC8IQs1CMfPyScT0dVsR0cPqCL+ZWFrhxUcjaEiowpR4IbL?=
 =?us-ascii?Q?TAUUa8gCSB0ophq+NDYAtiTHntoFtk4jS+ZplknAFV1u362RVDLMZCa2idOw?=
 =?us-ascii?Q?nyQFbpIumz8AZ5MZT+MIkghCoVzzePB0j2CSmehl/aSk4HXKDID5QUA1wAVx?=
 =?us-ascii?Q?7M9i2wK95Z/IxjPv46q1prMNzr+KaMkR8+VIScrLX2ho6b2rpWqizqm9u7my?=
 =?us-ascii?Q?6NyZOlVNjApx0btGrmZXkEbyl4jyzpvqyjlyVy9zNhPyudTUomrEU3Q1QfU2?=
 =?us-ascii?Q?mS21MFV8ycYfWWmd3a40gJstYx/rTHhLq65bMBqU3C5zShTUbfpoRAkWjpvD?=
 =?us-ascii?Q?yQFaRki8Iw+k4buLb9Gc04fO7TcFIerZ617DDKGXPvs5WEHZ6DrCxa8W0FhM?=
 =?us-ascii?Q?8tdBOsiNAX6l2quroVWc0hTnncN7Mb/JT8wrTEMfmcsyeY9KYbyu853oRLik?=
 =?us-ascii?Q?DrfQPT7vKEktRqluSJg+R8af5Xzcps+9g5cqW0uLsTMhFGGWv3M+3wF9Tg6+?=
 =?us-ascii?Q?B8LtkoUfohel9UA3+TyZGmR78IuLMulsaMI/Jg0rDNOh7yhGhudC5nd/qWI2?=
 =?us-ascii?Q?3yzdTYQhNBrJ9HU/nUGYVqaVCycTyonn+6QJ6dAvegIjIq9LdtVEGpZpj0HG?=
 =?us-ascii?Q?dadsQVGIdbkGiq7dk6Hjbcm32oS1jU7TgP4an61G9PPkMGI+guUTR0/sNRbJ?=
 =?us-ascii?Q?jDjIi2JsUazFIJcmjPdBAHA84dlPDcE19e7dwtYWcWT5GPCveDLBN+UecPez?=
 =?us-ascii?Q?v0y1IZv8Xvls//6YnZA4CsJ5E46PamLTCrDpt7Uzz4Siw4QphXjzGQIbhTQI?=
 =?us-ascii?Q?piUaC6//DlMiAVXJAr5aOBV4nsJSvYPh5RlWL7VNPAdemjUA+aPdot0P2OZW?=
 =?us-ascii?Q?QRnqo6hFtQRS9fz7vC2+Xlm+20WYiflmEQLWOjYkqhfQ7Ky67e4YIi1Pd65r?=
 =?us-ascii?Q?H/uC3gom/RrD6fMFPADJr9WE6Oh7KWeaZUDo5t7cA5hWJDqH7fu/LAEzQfrG?=
 =?us-ascii?Q?ln3fMjvbuOccabKzrrb2xMSTaqDlhgLjdnOMfKBpwxNsh5vo/AYaQRk/jh6W?=
 =?us-ascii?Q?ATuC9CnaqYWOVWIgVestl281BE9EUqBImttxb3Yy2uogSCI7IRKqGThV8YxE?=
 =?us-ascii?Q?UFC5OB5+3Uapd+kpcCY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 12:32:09.4856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1507e-b6c8-41a1-41bc-08de21e77fa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

On Tue, Sep 30, 2025 at 03:02:47PM +0300, Jiawei Wang wrote:
> On the ConnectX-7 Multi-Host Setup, the PF index is not continuous,
> user need to query the PF index based on the return value of the
> related sysfs entries:
>     cat /sys/class/net/*/phys_port_name
> 
> Example output is 0 and 2 for PF1 and PF2, then use 0 and 2 of PF index::
>    -a <Primary_PCI_BDF>,representor=pf[0,2]vf[0-2]
> 
> Signed-off-by: Jiawei Wang <jiaweiw@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
