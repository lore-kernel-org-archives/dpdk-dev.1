Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB8EB7ECD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C01402E4;
	Wed,  4 Mar 2026 11:57:51 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1D25F402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 11:57:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGaici/3RrErXM/pKv4Kbm2lC/1Ea6cPOINquScHXRBH2lb+heSYv612sYw5Y/yOtn2MxuSD7xBTnHVZwPcojU0UEbXq4Y2sMlUeIoQbbnoiEs4JLHRH3sQBzLa/ILNTfQZWQwRxSHK/DfsxL8Qryc/s9oPoeq2EIZ3v+r+WE49b1gdzd2/dcWhg87aGCAay32AA2TYPfQoxAXbIHxaC8N6IgXguZsNPGlrm5s3k9JUL849YLLLKrThUpR38DrjZtVn1aZ89N6fquwo1wYStOmjvG+5GZUIR8u+Wmee2hIzr8yNw0ZU5jBBzyWE0ymtz+IFNi85zZgZo4AaZm73Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y2sZgKPDIPUmfuGUhh/kBMwE3CH2UZtrpxaK01dOys=;
 b=OE1L8j+YWfAnoQCD6sulLYs0Wsbp5erJE2XnOCQZaFyI9FXDUFfgzpyRQesgfz9hYAaLsc61xXaN3VehS7TBO2voWpHgoqfTzRO4uJ3lkROKsJQWiWAtN3FPbkP3rbNs50nQLzN7P7j9cqD4Id/CaUnStNv/9AYWc++LbZi7lR2aP5efKQYUK7FXyTFISc/rptIe9Qp/530WsTjuVT+ydS1V52dneoz6nwi/+gHuSoc0NpA8noCbWdfx4UxwfYWHffcxcOachdhNetbal1XkCyL+bOGUFq0YECRx5UpXX61I4XvlpqEb1yWusnlVtweOnHjivCbH3rvKYNRM9IQkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y2sZgKPDIPUmfuGUhh/kBMwE3CH2UZtrpxaK01dOys=;
 b=pZfbG0Yr8mF9OXQv6+24pOpy4mQHdf8T9w8w4zTYecqgKRqMC4WhS9WeYVIy4TeCWRqjgvxcs+n8OXTE/WS8AAe+V7iOXDcLHqJxw22I+dKyd/svukitLKX3Ia8sTwRgIktRFojO8ooUlr9HIpd5zSi3uYKQQFgtnh5j2Gush+3BY/uySQdg4/csqIeQL0TboTxjJhdjbiIQKL+D57+ajUOVN9dKgCNgu4QtWQayas7VbygbAdgkYgfTrTZKdD2sUgUBp99ibKyTpTi22ZLrBWJCyy9dJkwHmua3HSv+v12VWvjoq28Je1xEPl6jxrz/n4tFz5MLn8LuVOfuwoKbaw==
Received: from BYAPR03CA0015.namprd03.prod.outlook.com (2603:10b6:a02:a8::28)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Wed, 4 Mar
 2026 10:57:45 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ee) by BYAPR03CA0015.outlook.office365.com
 (2603:10b6:a02:a8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Wed,
 4 Mar 2026 10:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Wed, 4 Mar 2026 10:57:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:33 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 02:57:31 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 0/3] net/mlx5: net/mlx5: fix probing to allow BlueField
 Socket Direct
Date: Wed, 4 Mar 2026 11:57:15 +0100
Message-ID: <20260304105718.93412-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302113443.16648-1-dsosnowski@nvidia.com>
References: <20260302113443.16648-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 67841dc9-935c-475b-aecd-08de79dcdda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: GSvcqrCYQjRSQZIVnAjhr3BaA+Nm8GidZ0AHCm5hmOsGoejM53VaA9id23E8+d/hTZ1eQUn7apMXLbt3PcXp9OkKrO8EpkrYLUsjXox+3he6bOLdqahGs47+kXJIhk4K1eUAZGLVduMpISkScBV8tn+BqnP+jx254tJUdujRfB+gJh84tpWl1TwNHJPvCcsa4KyHlqD8khMiD0yyJUV3a6vMeGJkh6nanctPFbDS05uYSDDYMKgRvzuJiMQ4I5nx7naCA0/kBfBKrnDXqGt2At2rjIfPRVVcdmz2d9jJv8pdqpVNXRwGUx6IWQDdGTIp8FlJCvSzBfPEAL1GmyNs6aXG8Vbta6+evuzeigWBTOIj5srLqAhnjzr8gmKVyh+e9BkKRuGnD0/U30uxIR+KzLQrb31i+1KiboNoEPijTLkbZZKIkV4ipHArxJ2vJ0j0obhia9jXToQ17RTBmhZkKBw/y49OTpAmyuQeHmGpSjpH63ILk0QOLHdqamUC+PxP2dx3IKsgv9wbA5aqa/dxf6kvN2v+N5cSnZclDoYEkRVgszD46g0cpaOZWKYAwpaVLyie3NHfyAISDEHQ4ptqDSffYaqBJGs8Ru4io2ymGGYQkTi+0tq29Kz0uFyONZFLyBwsSpN3W7CmNKPE8llAxhWHYUq204viBE14l+MQ4HuMn2dLRRpv+bNZ8sXzakTZvjoGDZf+CqJLPkTsgV0Y1we5pK8qGiG2YyMXurAKOd6F83TjwICk+C9vQZkBMA8Xexs04LjWMNIzkMKZ5+OpHQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B95XZoeeAXUigdd/FWGgcG+l6PWhMnK96dr7ztHcUDeToKaAlp6BQKG91RNIUbeREf15Jwdfmd5kmR4ujaWE9nFChG6lTwCboAbhK62G5KD6nfYQQTBRQ/Jom+ghXppS8fol2Za6ppCSqgexKb7OJigZZGj4S3Noi2JhQ9t2Iks3hhR2Tb5seMO/isIY0PNlXNDCMRZcol+qcqAybOIWv011pi7uNvo5QIdKUV8qpP5ORG72y4VCwMG7a91ZZE3Jf9VAbblvQo8jZ3blOwa7sZNnBifKiOXIFP43W5lZB2Z69Nb94mQ6eXtkKCRt8pWyk/LYc1QjBgjRBIjLSOffDHQ+uwfIEfXwgBiBjuh1Fzt2ipzdu+K5n+XdFmcvTAMelr51ra9sTrm/lINlsAgHYSokPHwBEXnpRa5fGj46e4+WlATrQx9gDu4uuFf7/Zfe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:57:45.1102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67841dc9-935c-475b-aecd-08de79dcdda2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

Goal of this patchset is to fix probing logic in mlx5 networking PMD
to allow support of BlueField DPUs with Socket Direct.
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
    - For example, both pf0hpf and pf2hpf are in the same E-Switch.
- Multiport E-Switch.

Existing probing logic in mlx5 PMD did not support case (2).
In this case there is one physical port (uplink in mlx5 naming)
and 2 host PFs.
On such a setup mlx5 generated port names with the following syntax:

    03:00.0_representor_vfX

Port name syntax was selected based on specific setup type.
Since setup was not recognized as neither bond nor MPESW,
mlx5 selected the default name without PF index.
Since BlueField with Socket Direct would have 2 host PFs,
such probing logic caused DPDK port name collisions
on the attempt to probe 2 host PFs at the same time.

More over there were some false positives during probing on systems
with or without specific udev rules which change mlx5 IB device
name to include "bond" in the name.

This patchset addresses the above:

- Patch 1 and 2 - Fixes bond detection logic.
  Previously mlx5 PMD relied on "bond" appearing in IB device name
  which is not always the case. Moved to sysfs checks.
- Patch 3 - Fixed uplink and host PF probing logic.
  Previously mlx5 PMD relied on specific setup type.
  With this patch probing is more generic and based on
  types and number of available ports on the E-Switch.

With this patchset, a DPDK application run on BlueField ARM is able to
probe all the relevant representors (corresponding to available netdevs).
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

v1: https://patches.dpdk.org/project/dpdk/cover/20260302113443.16648-1-dsosnowski@nvidia.com/

v1->v2:
- Squash patches 3-5 and add Fixes tag,
  since these patches fix existing probing logic.

Dariusz Sosnowski (3):
  common/mlx5: fix bond check
  net/mlx5: fix bond check
  net/mlx5: fix probing to allow BlueField Socket Direct

 drivers/common/mlx5/linux/mlx5_common_os.c |  86 ++++-
 drivers/common/mlx5/linux/mlx5_common_os.h |   9 +
 drivers/net/mlx5/linux/mlx5_os.c           | 356 ++++++++++++++-------
 drivers/net/mlx5/mlx5.h                    |   2 +
 4 files changed, 338 insertions(+), 115 deletions(-)

--
2.47.3

