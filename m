Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2289C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D664A402C8;
	Tue,  3 Jun 2025 17:23:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by mails.dpdk.org (Postfix) with ESMTP id BA6C74028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:23:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv0KdEg8ro2h8jXhfBeKuBdn6QBkoEI2J8lr7KeEzUcHfXUWLzXc8/GJEAB0hFYTAEPGZh4RbvY/Eu9OtKNib+LNe2wHt2/L/F+o21P2/F8wHP56Dui4u5J9uSOBe3Hd6ZhBoX51vLCjmCTPC5FqKBOfEhwfQp5lYDT7/E0LGbDyfqR7ySi7RxaDwoQ7CWXhpeDYjz9qrvk0Is06IoEERYquDW16y1/JOPNW+d0fO7kiSeCat9ufGjEO1v1xw7puQLTDymvSdBeSNS4LAF7eMTR+ZSBnmJHCOxzMyQwEfEc1l7N5E8Wdk0BTV4mEGUlxgn8zd04yxQNoVl8WZB6W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzdOvIprqlsVyc8wfbSydhMTabRiT8Xwxlldb8Os5R8=;
 b=IS1n4VHk5hiuWUnS+L5v95KU0pb396T7qIunj8g+ly1xksPSvMTQjLKYY/MyT2BGA8uGksMdO4dcR6AbOUmZ/0onX/0RjNbCpQ8Yc/6vsWgfjYsfWCRBK+T0QiSz+TuC2pEnoaAvnjFUFydUA7a6gwaJARRWbC8FmKSAaFr5MdkG+XN8O2mrGEeQ69aH9N+PQAaoFNkac2WvaH0h4t7Cf2k/CuXA7amySg798bXfMuFFfI5HD3RQI3hqeZaqQsjfAvTMxMm53rNpl9SWkMYljGG2s5jMyWrYoZC9fGdkkEDEjTEHKDA8KnCQ3wEJq04eAaoGG6flSEteL2bp6iYGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzdOvIprqlsVyc8wfbSydhMTabRiT8Xwxlldb8Os5R8=;
 b=oMZJrey8s/Q8Btis+MeqyJps5i1A2++wK9rskBxO+eqNg4kRpQOJ3SRjYrqB1j+cuiJfQbWvSMSUtqcdYJ6qZpVcVfNJ1P+yyXihsEOGEZjPUpq+TXhBUJnRHhuRlEJ3oY2AWOTsdw5DOWxHlIxNIYTegv9I4+XLP/fceHF285iuAGDvTFb9AJT8rcmWLz4k3EbXM7QTWfhAJ+9Ulnsbd6gFASofi9/BNV4R+dfgbRKc+zmawnilFdQiJcU+ECVVyN/4qcHBzoJJYKBZMfWfZhePGa5pkArFCf/w2MMIEACrIzlxPDRT3sQh7ScBn/RHWJYy8FEVPeXb1by4GxvTzw==
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Tue, 3 Jun 2025 15:23:47 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::39) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 15:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 15:23:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 08:23:25 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 08:23:24 -0700
Date: Tue, 3 Jun 2025 17:23:03 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: use portable version of __builtin_ffsl
Message-ID: <20250603152303.hgddr7yfnj4in34v@ds-vm-debian.local>
References: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1746457492-10012-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9535494a-a62a-4009-00c4-08dda2b2a2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xIxHrBt0sywv38RpvaJ2NK2BAivpp41FvRJNnlM34zb1OBonbCJCpph3Qvrt?=
 =?us-ascii?Q?aoS3YxMKjTDP/m5Ju1OOjaG/HATTctUOHe43GmFYS/c90CQSNZK3+HPtaZ4L?=
 =?us-ascii?Q?Co4F4RObt2pSqaFg2I6GiitXzX8jBXWFWUl4K00pmVaVN7trsZIBzQt9VJVy?=
 =?us-ascii?Q?KhkD2mTIfuV+RMcKumMGS1gFT8otXQ/7ElKwSuRpsKGtvaLaw2ozk6wsjVW1?=
 =?us-ascii?Q?wk/gz7qpdD8yQIzm+JRYnedzj55wIgkQQLVMHuDZ0wcvjNfId+wU699VXkh3?=
 =?us-ascii?Q?NVqfsfXBi5CwgIE5cX4SBkTdiTVq9sy4ir/ooe5nbndzG0coov6g+hXko+EY?=
 =?us-ascii?Q?3lb47a3gkTv+ZETMaovWqEWCP9+uORpI4qCF2XveAvwB4fdhNltlyVDVBGXP?=
 =?us-ascii?Q?Z5YrqgpY2KCzjLlmRgxrrUeQRQWPuFUvbWjijlbZ5zCz3O72J83bR17mctQN?=
 =?us-ascii?Q?ZX5ru3syI1aT2fiEtjnpT/FnPGQ9dIZxUM6jojNiLXGKHys7P74yZS+4cYiI?=
 =?us-ascii?Q?F66eJ1IJnff7cmpp3WmM2IkRhgODkFABI0uhuSZYLexi7XBTq1qwBC8kjKr1?=
 =?us-ascii?Q?0DAQqFWFfjAR3kYQ1oqfgTK+J6+Qe6/Fjugqe07zGqPczHT7KLfvUXDmAFIR?=
 =?us-ascii?Q?QzXxCpY3YXkxqNGUcZOMUGaP0hkP2b9656xm6i3Pd+SMNRK/V9PRotX+3+wl?=
 =?us-ascii?Q?UHCp+mAzh/Wo614ZrX3wK2rrFku1byD4ZYscEyCH9CqDmhtWeT5cbeqmCc2L?=
 =?us-ascii?Q?6a6AwD16IWZ5lojef/hKoCnXN6utXSXEiMa9lTjY7D0eZdLsyAGuPExFLLQF?=
 =?us-ascii?Q?CmNNDixt8rWVjIIK7mkPcO8VF7zAsyvSR2hiJm+mFjSen9L5RH1ix9woIwPG?=
 =?us-ascii?Q?nrB1XSJuv6Tshp6b9DqMuRFP3YxH4Q1UatQraEs301a8DmCieOmRsdNArcnO?=
 =?us-ascii?Q?fVEdd8lha+hdJT/ak7+qm8W8RdhW0NsVUxYb78zmtoZ8sNS7DlDjjzuw2m5m?=
 =?us-ascii?Q?trz4oThHMc+HumBI7XQMwOInlWURwB47RVyTtxaz2FXMvKdGsXcBDODvAph9?=
 =?us-ascii?Q?3V7SJAputD63ug4h7hsF6rCuQVZuLkBT5FTBOHYUJgV8jT2WaRlKIdsLIYjw?=
 =?us-ascii?Q?EYogVkS8DD6qr804be1XlPDZ6opBe+Y5RHQEkpnGuLi8lWUuv83Wmo//ew2Y?=
 =?us-ascii?Q?+Os/LNWCfgkcNxGhynrHOGkMqOizuO9ojWZMUdYDINwnwR9+InG9IWXRxQGH?=
 =?us-ascii?Q?VzQUjgUXIESSdKGdQzcDu8/P78qXnOH53YDCY/n0yvx3Njl9p9tHro/X7onp?=
 =?us-ascii?Q?gLUglhAM6bwg39joQ1CZwA1gV/qfDhElRZlcyLCz/NMZy53JYfV3CsxNLo+Y?=
 =?us-ascii?Q?By1bAt83CFRkAMpspAwLG7vMVw6aIZ9cju8wmcjl1Arx8ffaPbV9NWwMHBz8?=
 =?us-ascii?Q?LXhgiOKI7m6/ea8r7jevdsWmbSIiE4CMIPH0dJioWMPPZlJ6dA91vFlvmSvm?=
 =?us-ascii?Q?tFZ2iFfI3CUxIubH81K9tuBmYOPuX+IAeH5w?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:23:47.2935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9535494a-a62a-4009-00c4-08dda2b2a2c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Hi,

On Mon, May 05, 2025 at 08:04:52AM -0700, Andre Muezerie wrote:
> Builtin __builtin_ffsl is not available with MSVC therefore a
> portable replacement should be used.
> 
> Function rte_ffs32 is already available in eal and should be used
> instead.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
