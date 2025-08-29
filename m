Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF676C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:10:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C20040263;
	Fri, 29 Aug 2025 11:10:12 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by mails.dpdk.org (Postfix) with ESMTP id 293D44025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:10:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcTc2z3Jw9YtjTQ7U/2ZybXbpFstWXYvHdFoL1Sn9HH+j+fjlvMBEFyP19palDkeDG5V5h2RYUyB64nAssYFW/3X64aYqkaMawQUvKjdUiWpPWM9QRDp4yHy1fPNQ+ouFf6Sno6nXF9vYvLeha+K0KZdawUXsW7ibQH40EdfaiCcOphotmM2fvwyIMn1sENOBDLUq7AghoFN82dC8Xuc+JvO9Bg8iloPSQoj6U2JQhkvZSISv1M895v7sC4GeXRvQa+5RBZr786QhDqWf4uc+CFhLl3qsDFztEEP93GMMc3IVDbbBTNEZdkJh4zIA07Awr0jk/QgY37ONottcEpZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sSUci1YaVqPdNOeNRNkpYX/vVxh33sSo1NTdiC9bZ4=;
 b=eb20dQpNDvyF9HFEza2rwSc3jGGCR+LXPUE7M87pbK3vMcsrWsYKBW1qPwoMivEinC3eL5zTkH1js+IzmY/cVEnCL3rRYGR+je4BK/LC+4s1ERRUd9FPuVXyTjRmTsC7F5oF2+Phovb2XlznmSDzJEwSiwTmcirpww+OWEE1pwlxc6JR64NPAVKqUGCd1hdgWZYDLt6R9bUYeW+iVOaNdtIE/N7n9/N94AtUa9LafHNWoOKkXmtpJ2qAdQb/d9jry9XWspg4NpvWiZjNfImBqeIyg7fILHLb/9HdFUTMnaL6Ej5yVodkvjFnXJpHkzHJ504W03MsQVNL1NQTvT+IoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sSUci1YaVqPdNOeNRNkpYX/vVxh33sSo1NTdiC9bZ4=;
 b=jczfRm6o+mPd0rDTRQ7GwF4Kq7UOMfO/EK6j1EVMLYjj4pagw4CpQ2sIvYWtzyW4P68DrTHL+EiEILLDoYNAfS5auZOKmF7q0zMb53uGEvSH2+Ot/iEW4nYQVl6YITDfgWMZ61xibynbFBCR7sS2ISJulVVxX+1XDIQ2+ZSFrLbA8z0+ZDeFKtqITDBj/IO8L3wO6PB91Jvou/1l8rUYClkG5vfjf+4aX7Hf36X4LXlq08ujJS5Jx34UbMtJQ46qQjG0CfnEGiVgRxhSw3o2h34e1IiPwjqtzlsxxee3G5W4holujWfORAmy9TOE9Fb5bY9V08V2ZzImTn40v8FihQ==
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 09:10:01 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::3) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 09:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 09:10:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:49 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:47 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH V4 0/2] resolve flow creation issue for multicast MAC addresses
Date: Fri, 29 Aug 2025 12:08:28 +0300
Message-ID: <20250829090830.1049176-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825141322.974335-3-gavinl@nvidia.com>
References: <20250825141322.974335-3-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: c1deb420-20a0-4fd0-289b-08dde6dbd55f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxZkpiVQqQBmwRNakZMoeRJYx/dmIQQHyK/Pc5Ne/PAyo2zt8TTX9B39M8gk?=
 =?us-ascii?Q?pBbATPxbyyy/sRtURRpEZcPfjlILJGtYj40DLhMKtpDlpH2Mo2gYDMmxVUag?=
 =?us-ascii?Q?ZwlVsL+slJ/A59xy5ogDxPasNC86empmZyGY2G4oL13/hXcrh+OTUTD0lSoB?=
 =?us-ascii?Q?JfLx8xAga+/zxSidW4/HXteuDb56AP8MuuKSMX2rbPOQ2c5cvrfnz1K4oXje?=
 =?us-ascii?Q?jqhdq3UrbNr8U0zaeOfKI98rXX/qbSwYKk4zyGieLmz0NrmisMIQPrQ42zfS?=
 =?us-ascii?Q?DtT4yjJJRHrDyK8s1rIF0qVe25vGWp1ez7ziDLOBvEfQCc/aL2HKMxE+0rNp?=
 =?us-ascii?Q?ol6sWiFYzcIWXk8+NQ3W0/Fitk/EUbbWNHltO/zLbikZA3nXyAzUbGFfhZTt?=
 =?us-ascii?Q?RcGs7koihPfXWgpP+fVosqZhiOvgiOUPJM2yficb6d7rdWxXp19kUbTGc9/e?=
 =?us-ascii?Q?Csyle1juUn//sAdJqTrO+SDviEMKWF7jC4mUywz/CwVT9/h3fYu1AbIsiS1Z?=
 =?us-ascii?Q?UTsRUsRrn4W7gjL3CrsQfcPRTYzeXzYXPYdG62DymiTR/sgQ75SUAU57Qbyj?=
 =?us-ascii?Q?iK5eXkT7RZQ+oqevaCDF1nYtsJnEDrLkCu9JDLo+WdJzj0mzSqDXyYKjtV8v?=
 =?us-ascii?Q?efd+rO7bmRrrJ7Kfm52uuRJ2XJZktElAReu6HFeKVRl5GWf60EXdRN4wOYMV?=
 =?us-ascii?Q?KcX1fXK0STD31JdkwML0w3zm6PR6ndAvuelrJRjk7YHnna46HE5ufMrqfB6f?=
 =?us-ascii?Q?q5vhE/bdbZ2IKgzPARsehHjpmbJ0NDIt3ACwzrW3q+ub60DVeqJQaf35B+qp?=
 =?us-ascii?Q?OqubAQ283PW7u6MTzBi35KwPDNsHqXDs57qyI3kY38WoOg3Ovp36vfr7ts1u?=
 =?us-ascii?Q?CCiqPW9XYfs/8zblNG2FVIbJGMFglzsZfu73u7f4E6oyrugmTj+ltD4+xlSs?=
 =?us-ascii?Q?kJP9MhN6a7dGIhHgOKYTvytOg/IgN4upXuby9qmBZwGB3NjuaSGiMqDbzitz?=
 =?us-ascii?Q?s4+IfnQ3MA+vOTn9VJDO/9MPRTCHe5zNvb4rxnc9e/0QOOJ/XzL4byos7xNF?=
 =?us-ascii?Q?z/ShRnM1o6lV1laz3Z5KSdawh8yoqnXf8GulveeLCwECdxAuqVv1kppssP5t?=
 =?us-ascii?Q?QvwHSEGgG4Wmy6mso7VwuuA77MNvVZL0Kum0WNj8oWpbLysJH+lV9bciAwKP?=
 =?us-ascii?Q?PlZeTR7fV35kdyYckesykFwN99sK1xe+zESaUgXnCFaDtodY2H4BUt1hrRg6?=
 =?us-ascii?Q?eq4YqkAI17+a8BR2wcqkEl/MP2COpYROfcR27gek5AGQsYQqbU6HKvdqCQB0?=
 =?us-ascii?Q?PKvt4lvz/aGyIJSjrrAZPS0mjai26O/Bx3yciAhqqgh0XlYQR4DsX1PFsnQV?=
 =?us-ascii?Q?L7fmfqKj4mdyMSuPrlpoSm35v32zUTNo48+6fGE1ge2lfVYTf1fJa93XiUjl?=
 =?us-ascii?Q?CB35sJ3IKfqvCgZGIPHWt5BpnTeqV9RAYdCt0ufi6F5wuFuf2zMN+qILJY+Y?=
 =?us-ascii?Q?L5m+7tUp90ljim6SZmwJ7sKsEYqfnIXWKwwJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:10:00.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1deb420-20a0-4fd0-289b-08dde6dbd55f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

A bug was introduced by commit 2d0665a7f771 ("net/mlx5: align PF and
VF/SF MAC address handling"). Flows for multicast MAC addresses would
not be created anymore.

This patch series are to fix the issue.

Minggang Li (Gavin) (2):
  net/mlx5: update how MAC address bit-fields are used
  net/mlx5: add support for flows targeting multicast MAC addresses

 drivers/common/mlx5/linux/mlx5_nl.c | 26 ++++++++++++--------------
 drivers/common/mlx5/linux/mlx5_nl.h |  8 ++++----
 drivers/net/mlx5/linux/mlx5_os.c    | 12 +++++++++---
 drivers/net/mlx5/mlx5_trigger.c     |  5 ++++-
 4 files changed, 29 insertions(+), 22 deletions(-)

-- 
2.34.1

