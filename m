Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1AE9B368
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53CEC402B0;
	Mon,  2 Mar 2026 12:35:24 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17]) by mails.dpdk.org (Postfix) with ESMTP id B85AA4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:35:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6ozXMwcD2CjFMF3lOx3zyTM4qVg9hkdWcQpkfONNYzI1orgvJyND7LywdY37vWAD132SLoGtw2Hy9n/dRpsUqGVlu9CBnq6VkYiZ0btb1X075HqxK2T06s/zbelTRQdKCPZR7jEN4cj0YjcT8JnoRktLHCD0QMTxqc3eyL7wTLEkqt4rtZrHa5aWoKrEu3AigUzm5W6hlOWvXJ/0ofjbQRoNsazFcv/42GOZYZVnMR5UQR5GbkMt97g3auIhzjm/BuNlv/VRgRB7uAXYtsHNdSRyZ1ODqq6eSJ8883li3Zm3KjovqOQKHZwAynGFV1uop57srxZQuP48bXjJrL1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+NYt5SFSis8i5pU+2cH9SbRntsvm0Tcu/oI7+X6bBY=;
 b=Xx+Fu9d0BcOqqHODSorgbNe+kJHLKwDENb847AGbtuO5nK+Ylf7B/o3gV6+3HdGuC90u6bLgXmdgo4zhZ3uvKB2t8GosAO3jf+Q5wMItq9N0kGnAYcG8nX6UeZcbOeZ9BWZ8wRSytJuSWHw4HuVSlk4nxPyd8EFXcwb0wWdNSyCOht9VHPicMpA9nJAljpB4t97ApQV/qpV0XyeQEMIvfnEM0cXaTXa1jzsfhr8H+iHmNqpbZavCeZyo++bimT07WQpozJfJytmVfG4GWn0E412o0W9Xwg7BoeewMvi/yHQSrjLgKi09c9d2s9BGvyMEZnpkeA3k5USeDz1BPBLNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+NYt5SFSis8i5pU+2cH9SbRntsvm0Tcu/oI7+X6bBY=;
 b=i5NqTtz37CDbS6SOckhsrWD/+4Oj53vXY0N9viN9IF2w0PWikiOgQ5f+fZIMZGaWi/FGBsnLDMFSF+hMicBKlpwZ42H6dPbFLm1VEN4q7+17EXAkEJURrOue21TaPTldE/lxxDaUi7pWU5SvXWYU01WgLTCiZTM3/At/WtTKGeiBoqjBkQktTtkv5865bFls3IXp1kxZxCs1Ccbae3ksbUb7C7//OMsfiF/7zQyfRrkiAbCaw6d9rRZjz3Vuc+bALK3l/WJutfQuvywg4dXT5MSrmOPg+KL2VYy+2pchU36ozIrtfU13Lo6N0A6Dyo5WaLbvHJRThTN0KKpBLZXrfA==
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Mon, 2 Mar
 2026 11:35:18 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4f) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 11:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 11:35:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:03 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:35:01 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 0/5] net/mlx5: add BlueField socket direct support
Date: Mon, 2 Mar 2026 12:34:38 +0100
Message-ID: <20260302113443.16648-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ea71ba-a040-458d-4ddb-08de784fc79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: uN6dVOXu7n4g8V18uE0wmrWEZe8M9ABkeUd+BRz+oizPbJDkrkVhw/oYa2Q2QTRG0sAcC9mSuFa34S37q+IGMW+zS6omP5b6ZzgR4svIhdTvegXzj4Tb8MZMg7kWopUMe2DnU1VLI9v9rs0nOsXHu88xVLb1w28+F5La5mOj+2hmmHLakz4tK/x6XaR6E0B6YbvOsULeU3Qyo8Rpt3HWyaE7T4IK1zyJePaePaM3j5hg6KTpK+Yv7PG4J9puVCmkmyOLD00ldaehhCIHPaVUqgnXC6oPM4XurFBMk3oaYlUYJEwZbCczAAobsolkzRmjBpRNtPg/9671soHYTZhYTUYUluahmXYTcVm8i+IZABsTsa3ARO7OGj6ADorgSue7KTLRsfFmxAQkXFdr91FjeWZmkrT80XZWv30TOe0a58dbT1cGvMIqcg2tQqPxLBrGQJHs1ZbAhhD/V9aLZcaGcVNzuGxLZHOGtg0BwCk3RuP16W8uZC5n9Oey1iqGxCejJNtLYauPN9Fo2A3qKaTQhXJl8VqK1GQLtSnhB4Q2Ov3ldvTDMFiFsT7OyRsI/IvAUxyrzkx9UzAnLLTKvEHkCMeh9KEVofPEb28Zj6ZjzdSMjiug5KIp+C0myr1a0jCv2trpO8rziblLeb+ezpmmMvPFumBUeqMjc2aOTd/caXINEG1Pdxp6T4B7MTO7ijuDZdSjL0fUkaXy8jzS/Z8VFS9VcAB+JYkd9IJD0bd2mqeb9GNDy86XHq5q/oALYXWurulEZ8rjjblWV/6O55cF3Zv2WjweOF6cT1UEAZXZrCWIugUFkQBHL3PUAHg0SkmnZhWxMkOiaI6M2SU5hZjRjA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfMYnjABsMBx36nu7W0TTJa/GY5ITHNXo7X8de2D+h7q45TTIJ6fUtvPKmUW/zZasVAWGXb+7Zz561XveDun41jJmPWZfrREqgV1EcB5w0Eis++5NJDbD+ww7YAk4Qx0IifLXUMuuDH6SbVcxkVFVh+OjPqTh3iBzfYJyyYRtVS1d+MKkFijdh4/CXI/oalN6kN+coezlQyLZxJQbef6xnBXxE8leYdq3EWsbcUjst+Y+olzhAaRWdnAoav14DDjBHk+qTREEJjz1f5tRNsLrQ8+ffliDS+Fzv43emH8pVr5CrVHy5JHEqIJksqHUHDyiUrbNbyPuunPlU8Bm4J+K91j8cSwWtAsXKFMyDVvbd7cng4fOFF2g4Mty2ev3VGZUqUIjp+LC0K21WsuyS+T24ZNhusjjL88kkaE8950vG2t0nNFomZjFuUonBwx9Z1F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:35:17.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ea71ba-a040-458d-4ddb-08de784fc79a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
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

Goal of this patchset is to prepare probing logic in mlx5 networking PMD
for support of BlueField DPUs with Socket Direct.
In such use case, BlueField DPU will be connected through PCI
to 2 different CPUs on the host.
Each host CPU sees 2 PFs.
Each PF is connected to one of the physical ports.

    +--------+               +--------+
    |CPU 0   |               |CPU 1   |
    |        |               |        |
    |    pf0 |               |    pf0 |
    |        |               |        |
    |    pf1 |               |    pf1 |
    |        |               |        |
    +---+----+               +-+------+
        |                      |
        |                      |
        |                      |
        +----+           +-----+
             |           |
             |           |
             |           |
         +---+-----------+----+
         |BF3 DPU             |
         |                    |
         | pf0hpf      pf1hpf |
         |                    |
         | pf2hpf      pf3hpf |
         |                    |
         |  p0          p1    |
         +------+------+------+
         | phy0 |      | phy1 |
         +------+      +------+


On BlueField DPU ARM Linux netdevs map to PFs/ports as follows:

- p0 and p1 to physical ports 0 and 1 respectively,
- pf0hpf and pf2hpf to CPU0 pf0 and CPU1 pf0 respectively,
- pf1hpf and pf3hpf to CPU0 pf1 and CPU1 pf1 respectively.

There are several possible ways to use such a setup:

- Single E-Switch (embedded switch) per each CPU PF to
  physical port connection.
- Shared E-Switch for related CPU PFs:
    - For example, both pf0hpf and pf2hpf are in the same E-Switch domain.
- Multiport E-Switch.
    - All host PFs and physical ports are in the same E-Switch domain.

When a DPDK application would be run on BlueField ARM it should be possible
for application to probe all the relevant representors
(corresponding to available netdevs).
Using testpmd syntax users will be able to do the following:

    # Probe both physical ports
    port attach 03:00.0,dv_flow_en=2,representor=pf0-1

    # Probe both host PF 0 from CPU 0
    # (VF representor index -1 is special encoding for host PF)
    port attach 03:00.0,dv_flow_en=2,representor=pf0vf65535
    # or with explicit controller index
    port attach 03:00.0,dv_flow_en=2,representor=c1pf0vf65535

    # Probe both host PF 0 from CPU 1
    port attach 03:00.0,dv_flow_en=2,representor=pf2vf65535
    # or with explicit controller index
    port attach 03:00.0,dv_flow_en=2,representor=c2pf2vf65535

Patches overview:

- Patch 1 and 2 - Fixes bond detection logic.
  Previously mlx5 PMD relied on "bond" appearing in IB device name
  which is not always the case. Moved to sysfs checks for bonding devices.
- Patch 3 - Add calculation of number of physical ports and host PFs.
  This information will be used to determine
  how DPDK port name is generated, instead of relying on
  specific setup type.
- Patch 4 - Change "representor to IB port" matching logic to directly
  compare ethdev devargs values to IB port info.
  Added optional matching on controller index.
- Patch 5 - Make DPDK port name generation dynamic and dependent on
  types/number of ports, instead of specific setup type.
  This allows more generic probing, independent of setup topology.

Dariusz Sosnowski (5):
  common/mlx5: fix bond check
  net/mlx5: fix bond check
  net/mlx5: calculate number of uplinks and host PFs
  net/mlx5: compare representors explicitly
  net/mlx5: build port name dynamically

 drivers/common/mlx5/linux/mlx5_common_os.c |  86 ++++-
 drivers/common/mlx5/linux/mlx5_common_os.h |   9 +
 drivers/net/mlx5/linux/mlx5_os.c           | 356 ++++++++++++++-------
 drivers/net/mlx5/mlx5.h                    |   2 +
 4 files changed, 338 insertions(+), 115 deletions(-)

--
2.47.3

