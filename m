Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D9C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52928402DD;
	Tue, 18 Feb 2025 11:34:22 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by mails.dpdk.org (Postfix) with ESMTP id 5493B402DA
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:34:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRp9CQmGoUqcBlS2KGloMseR7yxRUNz71NNgFy/HyWdSNN33HGE7fgOcF4na1jYmYFTYFLe5qCdHsh5ozpJoUsy3PhEJTcj27mUk1SAth5cqQToyS7A+OyTu63rLHrvfv/bQyTeGGaxV8vhTSqvcwYs8DbTsBE3Z9xQ+nHMdwGqxn0XXhVNGDJ3ADBxagZli35ktT1+28Diz47P0sxAD10VRGIKrT3vwup90e910ZsNscpsRYCGv9CsUKxxKEF0Ur/pqD3/tEqvubbP0Dd5WbJnV2NFGAdqMVW+I/QKpW29JT6bviqJQKd1rGvT8v8KPozQa30d7ESK2XoVJ0jlfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=219bv1xJLQi/2x+DlYWAZ7p/2qhZb8+IGAVP6o8BnRY=;
 b=atYDnJPxPtQlBLOUPiKLqai8+qqyU+A7w1SrAqL8D8ZXsEGk16+9Jp2o8+f6+5vWJtPzvmLUnlCRduAs+xBE3/4TJODMWZqiKQtxx+varl+Ad3nHiKOMfWeUjZZUZXio9IE/A6/1truwsTmBO5SafUGk8FkJBAxjVzkUdljqoV7XnCE6IqrwL+DqGx79A54SnARcS2FlBnGAeRI9ww7m0teoI/VO5JnGviothz5Z6SNrnJQEakhZabwn+9KsEJ4sV15ldNZhWO5zg00I3BP2/W82lYoB1brMSdbaAbbzZ+KmrQyf2E6k2mKx0IcAq7yehq2qGBoTWduWHGOAGJ57hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=219bv1xJLQi/2x+DlYWAZ7p/2qhZb8+IGAVP6o8BnRY=;
 b=qmX3hUtRGkgxRvZPp9MOiZfBN0gdS2LWfmiDJ9Nup12pNU6AAFbNArx4RQxJU7iBaiX2ITM9HT614Bkg28q17gm7PY7WyldQ6SCPtYoAIDedYqf6x59BX5r2dy3KehOHkL+yF+Io0AKyArEqAhTpoBLvML4S1uCaWXT5psA60WCcp34gWLg1Ru52H0ZrF4HvNXNE8pnBTG8618tj21zWAvFCFRzDp4yExGjOzcmnnvKON16KGcYmGpN07vIJxdlL+qWeoVWj597iar/U1jR8cWm1fA9nu//0hQUptCB/n8c1e07Ji9WNxHJHaqobU11oE+dOGu9L5L29hkvs2j9hRw==
Received: from BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 10:33:52 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::13) by BY5PR16CA0002.outlook.office365.com
 (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Tue,
 18 Feb 2025 10:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 10:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 02:33:42 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 02:33:40 -0800
From: "Minggang Li(Gavin)" <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 0/2] use flags from user if it is set
Date: Tue, 18 Feb 2025 12:33:20 +0200
Message-ID: <20250218103322.166461-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 42834199-7ada-4390-734a-08dd5007bcc5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?acO+UPk44QLoM+2+b944gpJN2ly68GsuaC20laC/xHTAahzyUEQAaAbGRx7Q?=
 =?us-ascii?Q?KFfFPQD0RH3GHwuQhJiVZ7CJq7e7K+r/uateCfVPrgDmu/R16fCm8120Lj8V?=
 =?us-ascii?Q?rS+Ok2ymDTxv76q31fvolxXw9yzBv1/qc2e0snZqkJrK6TU1oq02z+Svga/p?=
 =?us-ascii?Q?HHce6I0UX9X8i66oFLQghnCZMEBVeGFPlcmN88eyyZe0veqmI8lSnQYzQQYP?=
 =?us-ascii?Q?J31KdA8Fr/mPJRgCKRua97Sbr3OVq0hhcB0P8gRrD0GERvnTAs+Sx7c41QO7?=
 =?us-ascii?Q?KCnNtd1Qv3lieebr8QombK9bgf6jH2XqTcVpWOK8uKt1jN9QBrOC+rf1fRsG?=
 =?us-ascii?Q?h06+xfyshLFFypAG/o0JcmZALET2NL0Pp3cpIZwIvTpfVlozgeHrMEOx8XEP?=
 =?us-ascii?Q?9w9ZNLGgldyPv0+ySgWGOUyOjeAA0QuXMZIVFEUeR8/q2QD6y/LHQz+gerIE?=
 =?us-ascii?Q?Jahr7Z+amgSarqOo7CYsBZ18vTR0iDCqF/GmHBhcb9KXcKXYP9HrOY1yJmux?=
 =?us-ascii?Q?PwYX6+iOnDVQNeE0XFvrisw2Vbx53qvkLwwktBcU2EkFaRZK8xFy0qxZWQZa?=
 =?us-ascii?Q?OSNZ/A0gYJ6REA9lzKSfqbCDOwF5Ibs/yqNV8Xq9nHEHzFyw7TagK3shmiId?=
 =?us-ascii?Q?ftH6VES0IhfvJeMaOpBUAe5kkLKHdip/26AEnBq2LVjHG0vNryxGwa2ry5aH?=
 =?us-ascii?Q?wn2OrMDw3aQ5PLikzgUh+OxpvcJ7HTF8Xm+fSsgmWMejHuedXWMJgtdt8Yf8?=
 =?us-ascii?Q?nkNyd72f3z4LyTLTfk4OPBqsZ4f12MJ7CrcQ0mj1Nmi+1tXQM0h2L9oxmioQ?=
 =?us-ascii?Q?10TBZqRVfnnMRQuLRXQXzEAJZw+oyvLRuxbj5Xv62xqKyNao5oy1eTiO5cuL?=
 =?us-ascii?Q?O6GVo6MjTJwhOEo26wxCBer437JcZpp08QN8QVOLem36TEZTjtnl4VdZKB3P?=
 =?us-ascii?Q?q1L+ujlGA/61Xg7/99pa7tiLKJM2q4JXF15VY1jT+1IYtGd2nu0Z7gSSK6i4?=
 =?us-ascii?Q?RZAYGqJHJAOAy2xdlxgctaiCg/UhA+gyiaeAMzLmKUl5owWBYfpRxnR5zpnq?=
 =?us-ascii?Q?Du8XLS8kOosKmU1HNuJ7oqKDeMCbdOWYI3+wyyraPBMEG8ti0YXbavCRNKHE?=
 =?us-ascii?Q?vKyTPOsuqCg98h+4hQxFQJoGccAGIyjLWsryyFdth/AsJ/PhoQLJT7B7rGh2?=
 =?us-ascii?Q?1xz/Czwd0K7ekDw9tSzHQCzckBAlLf2QuXfLm9oHMhvz4Gm+Gy6AZu/LXds2?=
 =?us-ascii?Q?gAQrtMH3RhucvZXWUBmIK4rvR95suniX04dQsDxPHGWjlpCok+hA0umtr7Az?=
 =?us-ascii?Q?xJ2yeP6N6b+FUHKkXEy+7MvZdKKCcV9VGGclg9YjSHN998AK450U1FvM3euU?=
 =?us-ascii?Q?erYGpIQkZhgUw2OqtSdkp5XnUtDeYRuARGR/yFynaHEbUNzGVqX7IBYXvNYm?=
 =?us-ascii?Q?L2ZNM8iIzrh1JbVPlYiVxjJ48xRdzdfoAl8PpdypczEMrTKQ/fW0ZsB/J4kN?=
 =?us-ascii?Q?2IlWdHM2NuHedak=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:33:51.7434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42834199-7ada-4390-734a-08dd5007bcc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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

This patch series also fixed mlx5 release notes on VXLAN limitations.

Minggang Li (Gavin) (2):
  doc: fix mlx5 VXLAN matching limitations
  app/testpmd: use flags from user if it is set

 app/test-pmd/cmdline_flow.c | 3 ++-
 doc/guides/nics/mlx5.rst    | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.34.1

