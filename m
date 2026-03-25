Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32EFEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C62C440A6B;
	Wed, 25 Mar 2026 10:08:36 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10]) by mails.dpdk.org (Postfix) with ESMTP id E9A764028F
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RERFVKWInbzXIICjUKlXwzN3tFAG2QRJrFQIksA6rgSWWLBkLwPBSNL+8n4H4VjyQMwp2AMyTyKhNzYP7A9ggJ42H+8rE24P1us3odOsQT3kqbospbZ9m4GZkjPGGV2e+/NewkCnUPmS+Yktu8W+kyvTROqVDk+lZGPh4YJeUj0HLAFA69Q23oTvab5ttLaiaT+eq5F44vda5aGs11zj3i2xW1+K2YbhX1Q//CtWAKmKQKrsJiOqG78sSfU6ad6fGJyrLLfz9p5sXkKLbFrEoe0Yr+2VnwsJRQjM3pLceEzNqyQ+45bgcph+xajUoCS/YfKsfqiif893bbGCXtgc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUhubAdlA1IpFbze5Gx2o+y8Vcaf2LKdmNw7JtPbUsA=;
 b=W5DWN1XZ6nwGzrvpfUMwf8c/nuh+/J9auTQa6q2P7mXJ06ZbkPmPVHf53rV/SEHnLmGwHNfZvDUMki5+su1rmtiyligj7urmD7UQ2hb12LP8Tdb0O82w/enpeSoE1BkYfnEEtfe3AAfTOqQAkJSs5L3c14glXYDmLotgCHuRLqhQfENCYcMgq13nkTBs/inNdXrjzaIbqXPJolm/FxDj22HBMIo0M73uX+4FTxoi95ok6+Bw9M84v2rNTMQSBEMTrwpVBC2RRjbaKsztxOxduTfidlZDfPiv751bwUyW9yLhcGfsd2aXJzMWPmXuGR5ZSeBngXYMryfBy00JwjWXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUhubAdlA1IpFbze5Gx2o+y8Vcaf2LKdmNw7JtPbUsA=;
 b=W/hnwGoT72pb5jRk9/iAV6SxerH7Xjx5Dr/1SpGK2CSAKLC+4D1m+a9DrtULKXzmrDC6eIsfgq4GdQYvMuAxfJoCsDZbaICVaC/ESnkne+7bL+zXWMB4mXpA7oEj++3OJBe6Xqc2uqnvIWFy8QsGNfWI0CJfOkqvHKuk38oxmNhHAZDPanS49EcmrFx/iU43Xyj73Hv/NRk9nfDCP+A6j7V/7YPNqMj4LAsemR6sVqiPkbO+8sj462PMcx5KGN8K0VvduPFmILVuPhcN0UnY7gEK5p2mJfv9DYfXc9PlHcskFOsJ0hGCTqrcWPNA9uFeb1w8CVAoC+9f5g3akrve6Q==
Received: from MN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:52f::27)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:08:29 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::95) by MN0PR03CA0020.outlook.office365.com
 (2603:10b6:208:52f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 09:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:08:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:13 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:10 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 0/5] net/mlx5: legacy vport match support with HWS
Date: Wed, 25 Mar 2026 10:07:52 +0100
Message-ID: <20260325090758.42403-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: a91e5505-a867-48da-be03-08de8a4e1467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: U8W9/YFfDXFUVJ8npqXkVd9OsZYjtljVvS0dgy8kFkT5xzmNphucwqhIT2V2aUJGmLQQzoIAyuA1ZJ4GG3WK1JgOaJSLoMrhIfYnaTd9GO7cTWSSoTC2xkMR/Rns7VsBB6HFqqztIzNkdaYjTzkVfCnt4Sazxnp0zZIHhrm2vLqpZji5NaqsQalc3SYjhhmexy2YOLC9Nwz/yvXofrkkK5FxPTU4bK2pcCU0TLTheaAKXAHBggModdsACyS2E6fZJ/PgYSdRu0EG5/1kLERiTGb24sHKE7goxK3e+OyVpYoWc7MPXWmoeD7hKduTgDrcOGSYjndl8ni78PJLGCum8xsQ8IpO4+9ApY8kubmc1Os/Xw0pBXZbxSWEoyrIC16V5v05qc0UfGd83/kkCXSVNYPH24mmI9GUppawFAey7IxbjPwJl9ToIIH0rP5F4RGD//u+L9Kq8e1eS/1BNmP7mtNeOxPHCjlFHpAPdeNfCjIb7plcgJKLHNN697IgU8YRLQcRLWrb1GIK3kaNtS16pKj2fm2WA5kn5A1wMDCs+qWdgyIRXrhI5vlic7sv2XmR0OwqOAY0Wx6wbsweH72wPsBn5bEbXA85XSUxagQVhi+GwuDwCVH37yFjoCGrRzTZSLLFgt/7J7YGBTfsQsP6xCwhSnhFapSKFJdHQpAYhgNcM6OkasEQuDwLU5falfvMXz64hLMTDPSYCCBu5HvV8/qslu2kfL++ITxVScdCJgNwuXP5nDHUXoFAOnoJEbHPyopNhUTvzLRlI5cdktkt1w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xsr97QXT0cO+t+HlRhm+d37u3p8nGZZuMbUzE9r64OBz4g4ithEY5ISm0g37lVUtiC7SMNBs66m5O43D6kpoGL6LRBEblRhZasxgw70UegYrECYp6g1rUHXQTONZcEGKFnUMzm3EvDasboxBUfE+27TvY+whQGbimxEqDlS3+aLZYG+VoLearZpVYrs3/gvoG1XC6BfjaHDIgmxcH1n6wf4WfMbnkj4IoRMPiDuJ0tt7DIuT6f2kMbuB3L9ed9MONTlHqGxV6Eyw8h44UZCaYaGTSg4aJM+nSgGW2dR58zZ27kNRNsTg8nuZImr0UOPYrDklQ6gdP5pCTdkDMhqTE/cgzOId+nIh2guoy++1/q8d+F1I9gjNFLOOetFupuDAww3r+SXWVb2xHFeWz9R3/N6fHAza5ScxbtVuz6w3QnfEsZHvNfztdWaWnSD1yNEG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:28.5871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91e5505-a867-48da-be03-08de8a4e1467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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

NVIDIA NICs and DPUs have an embedded switch (E-Switch)
to which all associated functions (PFs, VFs, SFs) and physical ports
are connected through virtual ports (vports).
mlx5 PMD supports devices with E-Switch enabled and
also exposes flow rule offloading to the E-Switch
through transfer flow rules.

Flow rules matching on vports (with flow item REPRESENTED_PORT)
can match on specific vport using one of the two internal mechanisms:

- vport metadata - E-Switch internally tags all packets with a metadata value
  associated with originating vport.
  mlx5 PMD can match on that metadata through a specialized HW register in each flow rule.
  vport metadata enables features such as VF-LAG, Multiport E-Switch and
  others mentioned in [1].
- legacy match - A static value known as "source vport" is assigned to each vport.
  These values are not globally unique, because they are statically assigned per E-Switch
  (e.g., VF0 on each of the PFs will have the same source_vport number).

Users can select the vport matching mode through devlink [1].
vport metadata matching mode is the default and is enough for most of the use cases.
However, internally tagging all the packets with metadata values,
increases the packet latency in the E-Switch. As described in the linked kernel docs,
disabling vport metadata matching can increase packet rate up to 20%.
If features provided by vport metadata matching are not required,
it can be disabled to increase E-Switch's throughput.

mlx5 PMD with HW Steering flow engine enabled, only supported
vport metadata mode when running on a device with enabled E-Switch.
Goal of this patchset is to enable support of devices with
disabled vport metadata matching. This is purely an internal change in mlx5 PMD.
No changes in DPDK applications should be required.

- Patches 1-2 - Extend information queried from the device by mlx5 PMD
  to include information necessary to implement legacy vport match.
  This data is always available, regardless of selected E-Switch matching mode.
- Patch 3 - Adjusts internal translation of DPDK port ID to flow rule matching data,
  so that returned data is always valid even if vport metadata matching is disabled.
  Also adds detection of vport matching mode to HWS layer.
- Patch 4 - Adds support for REPRESENTED_PORT item in HWS layer
  whenever vport metadata matching mode is disabled.
  This involves correctly translating DPDK port index to "source vport".
- Patch 5 - Removes all validation checks from mlx5 PMD which prevented probing
  on devices with disabled vport metadata matching mode.
  Adjusts internal PMD logic to work with "source vport" whenever needed.

[1]: https://docs.kernel.org/networking/devlink/mlx5.html

Dariusz Sosnowski (5):
  common/mlx5: query vport VHCA ID
  net/mlx5: store port VHCA ID
  net/mlx5: return port info regardless of register mask
  net/mlx5/hws: add source vport match in HWS
  net/mlx5: allow legacy source vport match

 drivers/common/mlx5/linux/mlx5_glue.c |  4 ++
 drivers/common/mlx5/linux/mlx5_glue.h |  2 +
 drivers/net/mlx5/hws/mlx5dr_cmd.c     | 13 +++-
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  1 +
 drivers/net/mlx5/hws/mlx5dr_definer.c | 99 ++++++++++++++++++++++-----
 drivers/net/mlx5/hws/mlx5dr_definer.h |  2 +
 drivers/net/mlx5/hws/mlx5dr_table.c   |  6 ++
 drivers/net/mlx5/linux/mlx5_os.c      | 38 +++-------
 drivers/net/mlx5/mlx5.h               |  4 ++
 drivers/net/mlx5/mlx5_flow.h          |  3 +-
 drivers/net/mlx5/mlx5_flow_dv.c       |  3 +
 drivers/net/mlx5/mlx5_flow_hw.c       | 34 ++++-----
 12 files changed, 140 insertions(+), 69 deletions(-)

--
2.47.3

