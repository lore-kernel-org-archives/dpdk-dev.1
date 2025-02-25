Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B41C021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 00:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B329402B1;
	Tue, 25 Feb 2025 01:46:17 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by mails.dpdk.org (Postfix) with ESMTP id C943440288
 for <dev@dpdk.org>; Tue, 25 Feb 2025 01:46:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyYJZ8I3n2ScT6tBGNFf0IymPk4W65ZrKol/bGInSGMv6mchyQo6DUiFWOTehBi8wRJ1JroVE5/rcRhBEZWPPRKPnnNopN94PSscfNiEOMvjYcGNFrYXXvuD6nOn8DyCIOHIut+h7oxQ9Oca7dTzg1oYJrbd9Di0AxT7HxTfmY0LSYkWh9I1v0x3tMab/EXoy9s9f8NZS6bJKdLfIAGwq5bQIILeMImWkxtqtfN2jppZj87Q9B+o/6Pyg4mdE94seqlm8ULvO5oBLoqwZK5NO6GaAC9T0jLdRKfSLU94yQcUtvATPr+4oq7GOegHRoq6scczoURUUkxh+LCP/rG++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKE1YaZapwVSOVWjoIXjDmPEJEOMmgf3wu0jpTvksHQ=;
 b=Wfi3Pw+HJ16sEE3Sob7gs9QID2DOx3FW9+vu2H8Zj95z3kendWJiGmjMXIER74oyHVosdvgLgSu35vNQJrdmwJRcAhsrJrJ+cCGNpwJY058KKJGCY1cs3nZpZoCSipmF2ky2xg5Y4bAr5ueRJkY3SGoeJVmftUqT+4KSfJGu4s3E/uGY1DCHLgRnnVRWSLaDWiGtx/BYZsyNMdHWAdCEsdoX7X2d6zn0z8LynOwdzLfZJSKf4YEofKG1z49/ArdX2xfQLWAHaR3MCyRO6EiDdSNw7PzRywLATF7WMhgwyhfTXF/xj9711I5P4y2TYzqSAxXzbBtIJQCxbCCPoHlu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKE1YaZapwVSOVWjoIXjDmPEJEOMmgf3wu0jpTvksHQ=;
 b=imKhbXWi4Rjb28Xc/I0CLRJsoO9iOnDajEoa6Rn5eNF/bXW4PxCV0o/Kud91QSOoRb+aygmBUqjzZD5F9Q+gOe+wZtyz9HxaPr4QL3OYoHIb9GcCVnF29RDmlnG0vavqu92zYiP+JiGdvwG2A7IpcpAJc8z8PhqTUn+aGypbnzKLCOPuxP1eABjLv+DRpwXVRTADqfh9/Q7K/jiRQLAC014DBfBmnpHYU1odVnCM+31SiQzqi/7xDSHtgRuCHcuSs9yU0cMfKnu5eozgIhtmTGNYvMbAKpLIwzK3Pzo7rVxnMpNcKzRA0S8gkj423fnNotNkA6RTIIkVZ+j3HEXmew==
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 00:46:06 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::a) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 00:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 00:46:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 16:45:50 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 16:45:48 -0800
From: Suanming Mou <suanmingm@nvidia.com>
To: 
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 0/3] net/mlx5: support jump FDB Rx
Date: Tue, 25 Feb 2025 08:45:24 +0800
Message-ID: <20250225004527.2066812-1-suanmingm@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae20c95-51f1-497f-5ebc-08dd5535c96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huoaJAkBVc2dymRslvXpiwiv6oBr1D4YWiYsc/wMuNzmJ4iYf8pk+H4ZJV6c?=
 =?us-ascii?Q?6jI3Zps3das22BoGz76XOp8DMbIV5daFDFabAHyUvy3vjJ+76f556crRqhdz?=
 =?us-ascii?Q?uxOvPf7vlWGjvzD936iLw6TOuec/ug76fyiEf7/u+lDWyXmqJ1X1CNwTJxsl?=
 =?us-ascii?Q?zXcQ5U7unHK3A8OBXKPyHYwaAN6RRJD8s4vlHemFzj40+90YZk1J/20C1le2?=
 =?us-ascii?Q?WD4iEa8qv5Ayj7qJBTWMw8+s/dKCU0SBzNBuo4VJewvJQWWXo2qDddrstZMJ?=
 =?us-ascii?Q?BmqfdkYBlfbrBSjJGV01KZ2PpTfqZB/ie9U34chEXAV8vujFZbK3ywlTSAaC?=
 =?us-ascii?Q?LwhBCPH/MDHnp3Jzz6HSiRFJ3FLT2GHQl5QtDmB4xrp5rqRhwWqO/jcKVmwx?=
 =?us-ascii?Q?87ZBNZgnsp0zArkO4WS9ULh55Vyscy1KJ27sB7PUNVjYsQmKFFquCwuW+JFt?=
 =?us-ascii?Q?zZzed8qBC4ssz1vfkFYR8tEZ97/i3cvg8J4AB89vkOdUc0N14QPO28tSuT1K?=
 =?us-ascii?Q?ZUf8edXldFNsNOG7Mb3UGevUEOh7rMqJQWSJrqLNFgefWXiClrFvtlU34ris?=
 =?us-ascii?Q?5wcS6+rbltijll1wZyhMsreeIBighCOj2SPXCuwm9PBJp6JisKZL/c2HX892?=
 =?us-ascii?Q?jlM59F1E0rFKxiaA8KyiKK6eSubHL5cXAdGKKKP+CXVhPconjAAbpNlETxvF?=
 =?us-ascii?Q?ERYnu0JxnRTW0i9vd2FCVdjQVBWxtGyKm01ijfUm+TZ2JD/9dBlNkDf08vQn?=
 =?us-ascii?Q?vH+e03t07KImVlTH+WDdrjd51l4XVuUKUXzvkJ1UKs9TO4K0/Km9W1MRHI0X?=
 =?us-ascii?Q?Eg/aQ2ySDBArIZSAgqRcggTogu+RwMQb3yEcDtq7bdLlO4hBMOUop8Meb0F4?=
 =?us-ascii?Q?UMHF+c3KkrUbtQq+C64OxNeL+nV40fBkTutqe8MIfVpOFs2xuUjKy71U6Q9S?=
 =?us-ascii?Q?tg6pRncVOEoaGRCltCjbiQXJdDwXTJT59xG8NqRHbgFG8lrQBIFbf6ccr6O2?=
 =?us-ascii?Q?BZpNDZASE/Cb3Q2inzyiIwyxmMg2OB5NJ56kNhxWFeCbRj5+WH03HaGzRKmM?=
 =?us-ascii?Q?6iAhcIgNY4JubAVakWtHRE15Venivuy2uJp8tqupY96/HaJYh4Y49VLCZMUG?=
 =?us-ascii?Q?8XivfNXx5mSPkBxZ+gWnAWHq5sl0ES9IWp8X45gc/csFVVc95pd8G7oHR+2i?=
 =?us-ascii?Q?tmiUFt2kq9ecxnbdIh8Q0UFOOu6BNS4dn958pfPucE4s2OAAqY/ZGb7tEWTq?=
 =?us-ascii?Q?v+8MBf+eULHc0iAcmVhRuaXpJPMzk05RfM+mZ5a5UmWbd6ba0OT0pObgqtO/?=
 =?us-ascii?Q?fAHjpAictWN9o1SwKzwFWbPhqAdIg8kvWFh2doTt0kA+s7xTIAgQVpgUZjLz?=
 =?us-ascii?Q?Q4bPEU/IfV/VOnRWCbhciFCgrt8bIfTMc915kjf/10dR1lD4/M7egqaZkoay?=
 =?us-ascii?Q?Q4WknGmnzh6x3LaV8BcOURz/4LLSYEXTccIPSoZAk0s3wVBUOFAb5QrLmaZz?=
 =?us-ascii?Q?hIlkBBCuDVp2pFY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:46:05.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae20c95-51f1-497f-5ebc-08dd5535c96a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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

Before FW introduced the JUMP_FDB_RX action feature, jump from
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces
the internal loopback for Tx case and allow the REG C0 C1 B be
preserved as well.

This series adds the jump from FDB Tx to FDB Rx support and allows
RSS action in FDB domain rule when jump FDB Rx is supported.

Suanming Mou (3):
  net/mlx5/hws: support jump FDB Rx
  net/mlx5: add jump FDB Rx flag
  net/mlx5: allow FDB RSS

 drivers/common/mlx5/mlx5_devx_cmds.c  |  8 +++++++
 drivers/common/mlx5/mlx5_devx_cmds.h  |  1 +
 drivers/common/mlx5/mlx5_prm.h        |  9 +++++++-
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++-----
 drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 ++++++++
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
 drivers/net/mlx5/hws/mlx5dr_context.c | 17 ++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
 drivers/net/mlx5/linux/mlx5_os.c      |  1 +
 drivers/net/mlx5/mlx5.h               |  1 +
 drivers/net/mlx5/mlx5_flow.c          |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c       | 32 ++++++++++++++-------------
 drivers/net/mlx5/mlx5_flow_hw.c       | 27 +++++++++++++++++-----
 14 files changed, 114 insertions(+), 29 deletions(-)

-- 
2.34.1

