Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290CACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 11:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE9A14278E;
	Thu, 14 Aug 2025 13:45:25 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by mails.dpdk.org (Postfix) with ESMTP id F170A402CA;
 Thu, 14 Aug 2025 13:45:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFkpfbnKMp70IIoQv8o8JzmtopW5Nw1GOXPZIBIT/CCjngKvALJN5DCHXtKi9q4gQ3km56p9GnXFeJW1hWqUnh55i+iYkwIGwTK/rM+4eeN2o5nbg26yl9w6rrW2iAbmhVOh3oBKadTYhmxQc8MJCdWBOw5W2OaX8c3iT1KBpUxaX3ADb3kFRKPqi0bQFN3mCbw+kdQpb9eQkg3OuPGvg0WbovFod/SCWah0ZbwYCs7LwAxrLCuzQGcPJu/S6qlpjYTpmlD/8OZz4m9kPnB4Gtdox8fByyBEff0N+rYbT3jQlCXPmp0FJhG9hLi0gUQG0/2VXTlaMvDR6Tzl3c7aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejxZnPbkhHIAu6ljc3D6lXwk/Uu3adt4k20ZDgiOSmU=;
 b=OxEXRDBkfGDD7AU8pWxsegrfiegjCY8B2cRNr062RTBkYTmXE4umwpzhvQeyiend4Fbor9yM7OsYqu+dyYh9XZ0vhFH6aCCaai4wPV+rxdo98tk3CYVlN7XKmPm3ofQDN8+iABoYW6io+P1/2FRdJmJ/yfGuclCWq+ZvjwTiu0H2iIShi3fjzG2brcB99mpq08Tqg2iRvxHa9RdRH/YW5IdaXqole1CXs+TQk4pBYPD6aH0udOb5PcHoAyrzyPiVGyyaEbQ1ncwIp9TwXKqs6O/D5gRwmqXHXIOdPX1B5lYg3nSib2FJOigZ7XsPqkbxu9hu+ydYmgcWlXjnLiAy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejxZnPbkhHIAu6ljc3D6lXwk/Uu3adt4k20ZDgiOSmU=;
 b=A4rBf9PndsDgmFjGIPL/6wRdW6oJkLWqwxXJiP0/M0xaZoMRg/+oYYDVVN8ITxeRMlcUXT4zmPrumzLQRA04lEk20Akse7Fc4HZffla0kOG3gva8tmc5YiEMI+JfXlUpPEdfERxuO9wlLLA0eADBtdOnLfAUj1cbsaiXQwHCYQgxZp6VP1zHR1Qt8V9BD+eCb7BOgAMdduoBLLn5rLb6SdrF9AwWDBSNcjl99b2+jXoeCXa9YZZ7Zz5U1j99piy4nKPIqMnLRm3959wJKfL331hdXSEWpqDdBMX8sKuPJC3epS1zfJwkmXLecvywaMlJtfvhU7wTiGEoLiaSM55y5Q==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 11:45:21 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::28) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Thu,
 14 Aug 2025 11:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 11:45:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 04:45:05 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 04:45:04 -0700
Date: Thu, 14 Aug 2025 13:43:40 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v4] net/mlx5: fix connection tracking state item validation
Message-ID: <20250814114340.ln2txcg55ut2q2jz@ds-vm-debian.local>
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250814101601.3532391-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814101601.3532391-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6bb6ad-5a36-4971-70ad-08dddb280b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ABbaauWTx/zDUq+Xq9yn8qOWQcrMkBTSmYIqNlTHFTMbO8pDmuc2VHT/75BU?=
 =?us-ascii?Q?zCaQtlMeV0wI6oGH05Nw1GETjkRijocXowkf6i1NljJ8FoutoK2W6FJTEOUB?=
 =?us-ascii?Q?8qlZk9Fw69/tqZMmg3iUw0XEJ61TkI2YKSadzLLF7+GbgbyR9JFS0lTtqgO3?=
 =?us-ascii?Q?EPpqcntpPiktoFdgxpssfpGWJjyxVZZnHMnWzPwcEL+QgjXfIAm4jrXhHGFs?=
 =?us-ascii?Q?9IAB4E2xt5OlIcoKQr2E9ptQzQsi+pYgLYuTa4mDzfeH8vLPF13ajsC2KsrR?=
 =?us-ascii?Q?011SiFakhoZBDGI+5YQOKQaoqb77TWMZFcFTgnSQIbshLdnFef4nt8GFZJZx?=
 =?us-ascii?Q?fPv7zvWfHGlTMRj9I5o6wsLCl5M2PEWSZJoqv8oDV3rwGj4hhdYDNGMDnH6M?=
 =?us-ascii?Q?IpKj13Ax+T0cJLudR6qcUcWn0lFF/cYV0YJ7WbS7wXL4qyL6/ivOp3KVXS+Y?=
 =?us-ascii?Q?AXZhHXPUOgzd/2dHzanv5ju/VhxEeU/+E1K+4YHCTNOhwwSaKIhdhRoBx88H?=
 =?us-ascii?Q?1bPu4GSNrh3aKUknhoD+eqv9LT/J4Kb3XDjYNZRpS4ibcDtusGAtiDcOdeFX?=
 =?us-ascii?Q?ILqs5JqSQuYOUVrGX3Mc6vXQPSZ1PFW3rSPPr+rTl7FjfXXgaggNCcxoY5CH?=
 =?us-ascii?Q?t/N24CzsylEZhp3IxSmi9GE2L6ybznV9QvY4udscLJMfZNV+pur5OTGvxS9N?=
 =?us-ascii?Q?jTffwLBr1be3dHSN9wOSwHs795yhsf9bZWSus9ODMtimGZ0HrwEaXpKqwdp/?=
 =?us-ascii?Q?Y2JQsVZi5hyzvwMy6BEHWcIzvBajAS1AK3BrsRVRwi6aEhDYKnZj2EuGGyL+?=
 =?us-ascii?Q?so8xtHsVgQpFY5EgigWjcSN3S9rTLbFs48gKFG3E2+bJ4GCKkXU0K9rAWIau?=
 =?us-ascii?Q?/bcDkOfVZzOotD658zgQq5J4Ft10S1D4rYwgg7Ucnsx9ABHq9gPlx1rOlWZy?=
 =?us-ascii?Q?RikCxATcZmRctMBFILv+GLQWILq4UidOlYsyvtxpZ2q7GJBm87betdZJ+Qar?=
 =?us-ascii?Q?RoHitQiRezaCvqDCxvKOiCgkvdHPeLgJUawDiEJNxjBHTVmjMMs/6fWkuj0M?=
 =?us-ascii?Q?qQUJ+gewd9wkofr9mas9P1wUeNrE4qsW1JFoagRbWrTJhXEsDWDPjskJOtwU?=
 =?us-ascii?Q?f7YQ1QG19hl4N/+uKMHnhA4r6rWDYM53p8YOUr/+WPTo0Me6reHCokQ/T874?=
 =?us-ascii?Q?YsUG5hYOFTtWPWtJ9n8ZrDIlfeOJPqsTDVQe0qnbfJgrtFK36k19FsptJpsj?=
 =?us-ascii?Q?fiERE23H5vf/Ge8WCNWWXs4HsPd5+dtaixpoxs6NP3BuG5aa+u36NUHdb7a2?=
 =?us-ascii?Q?zgkxtAsQqIBI39EPtoAnDV5E9gYNt0tZ96Q6onBfteXzvfC21yrvQBAUeJ+N?=
 =?us-ascii?Q?zDRqCdOaqCPzS/9p3m8ITFeswM0gVMYFdsYqK/A+Q6O41npAt/mGDdyxb1rm?=
 =?us-ascii?Q?hX8brgc/yrDwfFM/mOWFiTh71ZAKWad89XNLrwRUphudIwzWQyXArFpV7EB5?=
 =?us-ascii?Q?L3CjP9DPGaxhBztevCfLbSHPrqvEYhGWz8DS?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:45:19.4513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6bb6ad-5a36-4971-70ad-08dddb280b9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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

Thank you for the contribution and making the changes.

On Thu, Aug 14, 2025 at 06:16:01AM -0400, Khadem Ullah wrote:
> This patch validate a connection tracking state when matching
> 'conntrack is' in rte_flow rules. Since conntrack item flags
> is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> flags is a valid value to match on.
> 
> This patch validate the CT state item.
> Fixes: aca19061e4b96 ("net/mlx5: validate connection tracking item")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
