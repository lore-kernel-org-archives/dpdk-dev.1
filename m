Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED0606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sNqAIKMQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 467E9402A3;
	Mon, 26 Oct 2026 17:27:51 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7]) by mails.dpdk.org (Postfix) with ESMTPS id BDCD340275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:27:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIXmq1XkIMITj+IJBwFOvHxOJtmkOq+E0bqo5zBXiycU1PC72EBqp1qVXzyCW3cpshzdfvC3MdxvNAqLUB7jVIYHjuSwyGcJ35ZZOVh+unLS93ynG80oQXDc7o+fEeFG0LFfShp/Hlz9CIqqinzW9ZRHuch7HZ+nvXANxGLVDP+qC/kIgIElPt2yD/soAiLPqEQQarSRrt16Vw3F8hXmOIOHJ4Uk7AKBWkjz/6fgdOR904zR2zB3IzAV1h8GFY62MXfJMCW1k7WeEaKnKOJJeegt2VS6bK4hxmaULJgAduNrueY5+KyM0YqSYYyvuka4QdZNhDvN5MGNm2VbJ6Ijjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZuJiI3Gmv+b/E8OCN8X95Tdmxa+dTG+ZrKZaVUabAY=;
 b=TH+1VWEUtTYuCZqU1BzStynJuDSCvnSzekEdE05oxo5EvD7Hz6aRhV+Kta6cNwkw+Ux5gi5U7B56VlIC524s99AT2nzlgOhAvbS2bJlCRt7dImqc67cgtctD+Fo3WKyKxzym+m+X5D3v9ZmHIA5VhROARhqAYyqIKXM+fyeZXirnPObnkg2C2BDcSttU4/RHuyyDmiVz+pDCYrMrkRzwlDP8CfTfyPSS2UkiBl38A80rWH0LBjR6rHritv1RvU0L3U1fjdm+6N7JFEZ2miw/S0ZHURZMXRoolzoJTnF9DG2dXz495mbvXe9L+4lolJK4K1NiQxtAkk+kTC0U3mwP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZuJiI3Gmv+b/E8OCN8X95Tdmxa+dTG+ZrKZaVUabAY=;
 b=sNqAIKMQcMg8PUgTOzZdfOzPy0kc2coz1RpH7RibS2UFepCJyHgYzSVm2hT4kTT5Ss41AnDsj3xjDxM5nCxrUS0B6R8sjp0uTsfZayA3YYypNlH0aUp597+Aa1SUBJmi7Ul0I7WJh3lweIFuHfCeIn0KtYldc7G6YRoQkhlucMb2z6RTJNAipV6YLrfwtcd1rCXd8OwupT0AnUTT9iIsy4nwLgBMAfVH/uasHLezQxqr9vmll0NTbWn5wWDhctFe4MrX53qILCoQMFGXab8SV4aPL0uxYNbfJv9RM2s37WqVrYaeqDrhwcwybdQjpAug49trknRgVAANnSiVMrR32g==
Received: from BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:27:42 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::af) by BL1PR13CA0169.outlook.office365.com
 (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 16:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:23 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:21 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 00/13] net/mlx5: support nested E-Switch
Date: Mon, 26 Oct 2026 17:26:56 +0100
Message-ID: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4524e183-1f34-438b-e745-08df337e0f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: TqDEzO2ukZ3m5D9TqhsSe7/PAZWky39R0ZzKM2cV0DdpI1rl4DSLhdN/ZfkYzQHo8weJDTxupKufsApACWcjNJUAeAElT0n7IN0/E58uhkJ4EXXU5GHW1F+ZkHoh6i7agf4kHKhOXuu1HJaoV4rQ1ZPvSCorJ2km1jSTHwsWGInkfSvaXh1WMoj/cCoKXcrznQoq84f9PG7FRCx/PC5X7hmsVJilj8SValnwvpTYLj2Cb/ri+fU8j/+tVd260Tz1060sK1EifPMgfqzy1sJ3HW8Eqi3BYy72pBywB8BN3aSexciB38rnPAwKjEv9d9U4yRrDXjBM3Gv3GmY8vwjBWM2As8W+I9qDR9cePXDODd2XbtM7uZmyMRotkQ6xWDo02nNT1Ssewf5kZw8tx2Vm2kjmHt+vP2eoPyRGsbQZ4iXIiEo5Q9ck86QWwmHQPrAhR+t6xIXpte4mATrEJSC0jWq8p+t/zNjA19ccH+lT4nX0cT6/G47B7aGEAkM8PNq4R83Z1WvdEOqyGIf733KSBL5h7irz4tgFCqTQp6kntrO2qoYrKMhc7e/FJAqL8VVjaYZb8yusCk3ijD89oW6wkQZc5QOkKWLV6888DNUPtiA3AViFHftuJiC+UHmmRcZ1BtXRmpoKm5S/jIELqTZKfCYMI1lFDqlGw9T/gRD0NcYp/eDWWnv1A/YtvFnSqhx3yxWwYM4rsO6u2WtdVyy4Jw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iowACjEAvI7H3IcFj0dWlLoRTAZZMJIH8ErxTh1ste+Ec1fVpH5Ge8AATxrinr7Y5Ka5vjaHn8mJNT5B3HCSi5wjDeavfn/lTsdeARLqWmqJ5jwa1Fj6tmBDY4/vghnaqcifx9IjxLnRPhN1vliqsTApoU1CfjKI04P/nvesyDHmxknkGpQh42KbA887aCWs94FP8u9Xt4h9B4dr8M7pSgbEzONknWfJh7GAo3ogbZ1ZevDk3Cz/L3u4on3QZ7F2kn/jsxacGvH8lJFQwoy/IW4KJQb8YE1Pnbmn7PCmXX73Kjcbr/b7hk3D7OIn52sXdIj1oYo2LeQRAOnXMV8FN84RoL2CLUwZ3K+WXbVkrnmKufZKzbr2ALAji7CmsSDoFcVzfbvoxX0D5F4ToHNEzL96JiYu9Z1X9vx9lnM8bMhXY1EImiOEvt2VtaCgHKge
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:42.1937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4524e183-1f34-438b-e745-08df337e0f32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NVIDIA NICs and DPUs have an embedded switch (E-Switch)
to which all associated functions (PFs, VFs, SFs) and physical ports
are connected through virtual ports (vports).
When E-Switch is in switchdev mode, it is exposed as a single IB device
with multiple ports, owned by the PF (E-Switch manager).
Uplink and each of the representor netdevs are bound to one of the IB device ports.
mlx5 PMD probes the PF device and spawns ethdev ports
for the uplink and for representors selected through representor devargs.
Type and location of each port in the E-Switch topology
are derived from phys_port_name of the related netdev.

Future FW and Linux kernel releases will introduce nested E-Switch.
Nested E-Switch groups a set of VFs or SFs into a new E-Switch instance.
Its architecture is similar to the regular E-Switch:
there is a single IB device with multiple ports,
owned by one of the grouped functions, which serves as the E-Switch manager
(transfer proxy) of the nested E-Switch.
Remaining grouped functions are bound to other IB device ports
and serve as representors.

However, nested E-Switch differs from the regular one in ways
which break assumptions made by mlx5 PMD:

- Ports of nested E-Switch are netdevs of real VFs/SFs,
  not representor netdevs created on the PF.
  Each of these functions has its own PCI or auxiliary device,
  but the IB device can be opened only through the device of E-Switch manager.
  mlx5 PMD assumes a one-to-one relation between rte_device and mlx5 common device,
  and that all ethdev ports in a single E-Switch are spawned on the same rte_device.
- These netdevs do not have phys_port_name.
  Instead, they are related to devlink ports with VIRTUAL flavour.

Goal of this patchset is to allow mlx5 PMD to probe ports of nested E-Switch.
Each of the grouped VFs/SFs is probed using its own PCI or auxiliary device,
which mlx5 PMD associates with the IB device of the nested E-Switch.
Representor devargs are not required for such ports
and ethdev port name is the name of the probed device.
Probing of ports not related to VIRTUAL devlink ports is unchanged.
Other mlx5 class drivers (compress, crypto, regex, vdpa)
still allow probing only through the IB device owner.

- Patches 1-5 - Rework Netlink helpers in common/mlx5,
  so that they can be used in common driver code, before any ethdev port is spawned.
  IB port number and IB port to ifindex queries no longer require
  the IB port to netdev cache, generic netdev query is separated from switch info query,
  and parent device (bus and device name) of a netdev is queried.
  Also adds a check whether given device is an auxiliary device.
- Patch 6 - When mlx5 common device is created, gathers a list of associated devices.
  For each IB device port, the parent device of related netdev is added to the list.
- Patch 7 - Uses associated devices list to find mlx5 common device for the probed rte_device
  and passes the probed rte_device to mlx5 class drivers.
  Only class drivers which explicitly opt in can be probed
  through a device other than the IB device owner.
- Patches 8-9 - Add Netlink queries for the devlink port related to a netdev
  (through IFLA_DEVLINK_PORT attribute, available since Linux 6.2)
  and for flavour of that devlink port.
- Patch 10 - Adds a common check whether given device is managed by any mlx5 driver.
- Patch 11 - Adds MLX5_ETH_FOREACH_SIBLING macro, which iterates over mlx5 ethdev ports
  sharing the same mlx5 common device. It replaces iteration over ports
  sharing the same rte_device, which is no longer valid for nested E-Switch.
- Patch 12 - Allows probing mlx5 networking driver through associated PCI devices (VFs).
  Ports related to VIRTUAL devlink ports are recognized as nested E-Switch ports:
  port of IB device owner is the E-Switch manager, others are representors.
  Only the port related to the probed device is spawned.
- Patch 13 - Allows probing mlx5 networking driver through associated auxiliary devices (SFs).
  Auxiliary device with multiport IB device is treated as nested E-Switch port.

Dariusz Sosnowski (13):
  common/mlx5: rework IB port number query
  common/mlx5: allow ifindex query without cache
  common/mlx5: separate netdev info from switch info
  common/mlx5: query parent device over Netlink
  common/mlx5: add check for auxiliary device
  common/mlx5: gather associated devices
  common/mlx5: always use EAL device for probing
  common/mlx5: query devlink port for netdevs
  common/mlx5: get devlink port by port index
  common/mlx5: add check for managed device
  net/mlx5: add sibling device iteration macro
  net/mlx5: allow associated devices
  net/mlx5: allow multiport auxiliary device probe

 drivers/common/mlx5/linux/meson.build        |   6 +
 drivers/common/mlx5/linux/mlx5_common_os.c   | 164 ++++++
 drivers/common/mlx5/linux/mlx5_common_os.h   |   4 +
 drivers/common/mlx5/linux/mlx5_nl.c          | 578 ++++++++++++++-----
 drivers/common/mlx5/linux/mlx5_nl.h          |  67 ++-
 drivers/common/mlx5/mlx5_common.c            | 108 +++-
 drivers/common/mlx5/mlx5_common.h            |  54 ++
 drivers/common/mlx5/windows/mlx5_common_os.c |  19 +
 drivers/common/mlx5/windows/mlx5_common_os.h |   1 +
 drivers/compress/mlx5/mlx5_compress.c        |   1 +
 drivers/crypto/mlx5/mlx5_crypto.c            |   1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c      |  24 +-
 drivers/net/mlx5/linux/mlx5_os.c             | 280 +++++++--
 drivers/net/mlx5/linux/mlx5_os.h             |   2 +-
 drivers/net/mlx5/mlx5.c                      |  81 ++-
 drivers/net/mlx5/mlx5.h                      |   8 +
 drivers/net/mlx5/mlx5_ethdev.c               |  40 +-
 drivers/net/mlx5/mlx5_flow.c                 |  24 +-
 drivers/net/mlx5/mlx5_mac.c                  |   8 +-
 drivers/net/mlx5/mlx5_trigger.c              |  10 +-
 drivers/net/mlx5/windows/mlx5_os.c           |  25 +-
 drivers/regex/mlx5/mlx5_regex.c              |   1 +
 drivers/vdpa/mlx5/mlx5_vdpa.c                |   1 +
 23 files changed, 1221 insertions(+), 286 deletions(-)

--
2.43.0

