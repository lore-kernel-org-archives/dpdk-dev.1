Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF5DCD5828
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 10:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39B6140267;
	Wed,  7 Jan 2026 11:01:07 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by mails.dpdk.org (Postfix) with ESMTP id 09B5F4021E;
 Wed,  7 Jan 2026 11:01:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfV7MzkzHDV9OfQ61dJ5vk1SJvvumFIjwG5E10f8/NXhCyKWIvyiZD1pjHhQkUXLCascBZRUcMOQJWlrawuqhTVPXZ0RxFWcpytljZ77uTNrU4vIKJT5FMGI5G7KZt3iADX6CZApWfrDUrXJznffpayYUnY3JH9I0wEkhgB98XkaCyiq9u6wmKJv73DhHA4IA/Kw9gGQ0/NS0cscJ6ZP625krp0507U+h3xTBlzARH1foJ+LbQD7wh6hPD3f7bwRUIDbh8IBSG91bqiByoKJpf5eGuv0NK5b5/too/qdGOfOLELBY1XiUw2Xu3TlXq6haT+sdmzJ5sevzVj1LNF7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWjY8GPeEyhxoaI/VN3khHS3GTOT8eI5M7ATCvhD7n4=;
 b=L+n8vgHUcVx9xfkhg+rL6BFBESt/0rBnHc577H/ZS4gS1xqjLt6zgHU7CI/UVkIuQICDgOufoxBcrh+8AHEOTQoTfJFhq9o7zWtKFNAu3LSfVISfljtAgoi9iSrydgSuEN7euq0Nz2tGi7lJ9bdcfBTJoGboY55+GV1LjesIknvKwd8OLQzmR/faNwqMb/7VkTWduqRDbYXQpXQHBz81oHDKJFD4RDjj5HEWQhlGfRqVSIWwRla3yJLkr/0HFuTEv8LmCu4NM06CtSJS0AL0nB9nMVgStI+JD6o8WHkiu34c+5TMDfOMvNs3rpkiWiCKuNAvdCDJQgWyOKaBQf+mNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWjY8GPeEyhxoaI/VN3khHS3GTOT8eI5M7ATCvhD7n4=;
 b=jer1oiuO76UP3eHBr4t56WyH76EBQgpWgfR9rguW7YAIgOeHQzEMx7kdg+heaeCbwHB+shg3nLYIajCeB2Z2dOADWipeVlJQ8K3Q+cP1IhtYufH3Qp0k8+0W81pjkG4ZArsW4nFABAFScRlpwWcmltouLV/IgJUgmVF8YKEz0K9mog2wDFjoUqayjTJll7E+WGKOS7OgYG/elHpDE32ADtmTuNu/uaGin20+Q4LHJ6nBD3uOJMKRuOLjLTuHMLvWc50U4iuftxO4V7KbTzkEhjuLb2xFwtKiuIzll8j1XG21i83nyrLmKZ/ZfBdMmQ9s8WUOnA765gKNhQ9MIj2T7w==
Received: from BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 10:00:59 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::cc) by BYAPR06CA0050.outlook.office365.com
 (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 10:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 10:00:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 02:00:47 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 02:00:47 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 02:00:42 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <stable@dpdk.org>
CC: <dev@dpdk.org>, Abhishek Marathe <Abhishek.Marathe@microsoft.com>, "Ali
 Alnubani" <alialnu@nvidia.com>, <benjamin.walker@intel.com>, David
 Christensen <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, "Kevin Traynor" <ktraynor@redhat.com>, Luca Boccassi
 <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, <qian.q.xu@intel.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Yanghang Liu <yanghliu@redhat.com>, <yuan.peng@intel.com>,
 <zhaoyan.chen@intel.com>
Subject: 23.11.6 patches review and test
Date: Wed, 7 Jan 2026 12:00:13 +0200
Message-ID: <20260107100017.158232-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9ff220-6d1d-40e2-8533-08de4dd3a866
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2gvb0VBVktBNFZqSGVRWnN3NzVIY0JaVHY4blZ6WUFEMEFWTXIrL2xZaDA0?=
 =?utf-8?B?clFHTE51c3JJWXl2Q2xrZzc1MDlQY20xK2ZLQlF0MzhyNzhwenU2eit2V3lx?=
 =?utf-8?B?MnppMjgwcWtjRkMvblQwVlR1NVRKK1FTUkd5VXpkcU9EQ2hETEtLeXJJZ21h?=
 =?utf-8?B?dVB0aFZkVkY4bWVkZVRSK0tUWGNpejRGSDcrbWdLbXhKUVZGTkNnbUJmNGJR?=
 =?utf-8?B?ME1sMWFsbFY0V0FMd2dFUVVDRFdIMTJaVnVEN0t0VDRFWm5ZcHhzcWlBOTEw?=
 =?utf-8?B?S2JuUVcxOVNwVEY4YlY5ZDh0Zk4xREg2WWp4T1l3ZHVQT2c2RzlSL3I3UFVU?=
 =?utf-8?B?M3I5MTdaR1d3SGM2TzlVNkxoMHl4REJ0UTlYamROWEIwVGtKRnFkeTFwc2JD?=
 =?utf-8?B?eDVKSVUrcnRXZ0xRelM5QVRRY053UkdrNkR1YzZTZDRnVjVJMy9kRUNTMnBV?=
 =?utf-8?B?aFRqeXhxOFYxK3VydjBoZGFVdUVBME9iakN3c3dnRmNnSDdtWUJPY05HZ3B4?=
 =?utf-8?B?YVM3UFF2UEtxMjNwN0theW9lV0lHUHdSNTVLejAxQ2llRkNQSi9aWFlJVm1U?=
 =?utf-8?B?QzNRcTNZSGdYNC81VGo3SWNjeVp1NzJBcXpnMjdHOGtyRmhOUm5XTzBRekNl?=
 =?utf-8?B?dWR1aGJMSU5HQk9sR2ExaG1aNXU3TnBVK3BNUTA5L0MwUXRIYzBSZFlIVzhX?=
 =?utf-8?B?TXBYRkl5b1hHeFlWc2Q2WTdVc1BmSit4ZU8ydUNBTVNzRldnNG04YmhNazk2?=
 =?utf-8?B?czk2VE40aGdZVnoxU0t3OGFqNWZ5ZnI0ZTh2SGIxd0xmMGl0UTVOb3FQNllJ?=
 =?utf-8?B?SFVIWE5GZDI5MFBzNFhIb0h0TCtGWWxwL0ZGVkNtY3JzS2pEQVRVMytPd08y?=
 =?utf-8?B?QzBmbHg5Z0t0SnhEL0JwZjNlRGhQQXFJbE1oQStHdVV1TTJtYUxvQmZ6ejR1?=
 =?utf-8?B?NDY5dUo3bUpneThPUnNXY055T2NZdjZPNWtBbDRpaEV1aGVWZ3FVTzRmOGQw?=
 =?utf-8?B?Tk1jdjg3WlpmWExqNWpzOGV0bE5TclFBU29SZXFDd1dGYlVGaGZKUnVjT2pN?=
 =?utf-8?B?cVZlTFVSZlh3ZkRHdGwvRTB2R0xmUkZpRHljZFVBckFWdllWT2V1UERmSmhx?=
 =?utf-8?B?RmF1STVGcmdCa081d3hnUkRrN2JJdzZHbGwzRnNjQkRFZEkvUGxxaUtaZm54?=
 =?utf-8?B?OUJ4SERvQTV6aktvVmMwcUR6K1RTNTB5d3UzRjdicFJqM01JWSsyMFhZRmRk?=
 =?utf-8?B?NzV5UFJpbmlxYW5CckdzbVNBbFV0MExNeXVCOFEvSHF3RzhFVjR1Mmdtc3NN?=
 =?utf-8?B?NkdNcG1FWU5pSGx3cDRrU0l5QkcrNXA1eTVwMFAzQkZ5a05Ja3llTnBhUEFh?=
 =?utf-8?B?YUk1dk5oYWpqOXpxNEQ5cXVYWTNkUmFtUWhFR3pSQzcwejRZS2pMb1lFeEUw?=
 =?utf-8?B?STNVYlJQRWxzVWFVWUp6eWZWVm5EeGJSS1QreDJJL0JaeWRNelY4OGMvNkZ0?=
 =?utf-8?B?aVpVSmtCQ2R3cjRyVEEzUXJzcTZYT2xhTkcxSWZWaDlMMW5TZ3dUbGQrd3J0?=
 =?utf-8?B?VzZpMGNJbGF3WEVZSXUxM2tGc0FuUFlyeGZVV3pldHFFclNQckd4dU50clov?=
 =?utf-8?B?V29abTdGa0xmNTM2U3VNMFh2MVg3aUxSL2xMQU5yemZwZVVnNGM4QWhoZUJ1?=
 =?utf-8?B?eWEycWdXU2tYUm9oUTZ4dEZZbDhRSUNhdU5XUWZzVDgxU0R6TEJnclRYcHhy?=
 =?utf-8?B?SkFTcEVQWTlVYWk3TXViWlVLVlFnUnRDWHo0bnFxcjluOUlFWE4zS3V3cHFH?=
 =?utf-8?B?bnQzaHY5K2tHeXc2bFAwYk1JQTdDRjFjTDFFOHhYWjg3YzQxRFUvM21hSWph?=
 =?utf-8?B?ekQySFdUWmprYzBHcTBLSU5MNlpXQzRKK0l6NHhROTdlYkM4bk9oeEhjdjYr?=
 =?utf-8?B?OTVpTXNWSm45MkM0Q3ZFWVFHcGo2SGhNMmYwU0g3K3U1Q2NITlA0UUtkSFhv?=
 =?utf-8?B?L044dUpsL2tySVJtbWpEem16Q2FySE1zdy9sR3RBNmViRktnbWNadWQvMERN?=
 =?utf-8?B?VHJBTmluRzJIVVZpRVliZ3pMWkhJRTh1ZlNRVks2bUpvNFJmaVB5d0xwQVBW?=
 =?utf-8?Q?ryvA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(7142099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:00:59.1740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9ff220-6d1d-40e2-8533-08de4dd3a866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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

Hi all,

Here is a list of patches targeted for stable release 23.11.6.

The planned date for the final release is January 22th.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.6-rc1

These patches are located at branch 23.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Shani

---
Aarnav JP (1):
      net/cnxk: fix default meter pre-color

Adrian Schollmeyer (1):
      net/mlx5: store MTU at Rx queue allocation time

Amiya Ranjan Mohakud (1):
      net/vmxnet3: disable RSS for single queue for ESX8.0+

Anatoly Burakov (5):
      net/ice: remove indirection for FDIR filters
      net/ice: fix memory leak in raw pattern parse
      bus/pci: fix resource leak in secondary process
      bus/cdx: fix device name in probing error message
      bus/cdx: fix release in probing for secondary process

Andrew Boyer (1):
      doc: add Pollara 400 device in ionic guide

Anurag Mandal (1):
      net/i40e: fix symmetric Toeplitz hashing for SCTP

Bing Zhao (1):
      app/flow-perf: fix rules array length

Brick Yang (2):
      net/dpaa2: fix L3/L4 checksum results
      net/dpaa2: receive packets with additional parse errors

Bruce Richardson (10):
      net/ice: fix vector Rx VLAN offload flags
      net/intel: fix assumption about tag placement order
      net/ice: fix VLAN tag reporting on Rx
      doc: fix display of commands in cpfl guide
      net/ice: fix initialization with 8 ports
      ethdev: fix VLAN filter parameter description
      net/fm10k: fix build with GCC 16
      app/pdump: remove hard-coded memory channels
      telemetry: make socket handler typedef private
      net/ice: fix path selection for QinQ Tx offload

Chengwen Feng (7):
      dma/hisilicon: fix stop with pending transfers
      test/dma: fix failure condition
      net/hns3: fix overwrite mbuf in vector path
      app/dma-perf: fix use after free
      app/dma-perf: fix on-flight DMA when verifying data
      app/testpmd: fix DCB Tx port
      app/testpmd: fix DCB Rx queues

Chinh Cao (1):
      net/ice/base: fix integer overflow on NVM init

Ciara Loftus (5):
      net/iavf: fix Tx vector path selection logic
      doc: fix feature list of ice driver
      doc: fix feature list of iavf driver
      net/e1000/base: fix crash on init with GCC 13
      net/idpf: fix queue setup with TSO offload

Dariusz Sosnowski (8):
      app/testpmd: fix conntrack action query
      net/mlx5: fix min and max MTU reporting
      net/mlx5/hws: fix TIR action support in FDB
      net/mlx5: fix indirect flow age action handling
      net/mlx5: fix Direct Verbs counter offset detection
      net/mlx5: fix indirect RSS action hash
      net/mlx5: fix error reporting on masked indirect actions
      net/mlx5: fix flow tag indexes support on root table

David Marchand (19):
      test/telemetry: fix test calling all commands
      eal: fix plugin dir walk
      cmdline: fix port list parsing
      cmdline: fix highest bit port list parsing
      tailq: fix lookup macro
      hash: fix unaligned access in predictable RSS
      graph: fix unaligned access in stats
      eventdev: fix listing timer adapters with telemetry
      cfgfile: fix section count with no name
      baseband/acc: fix exported header
      eventdev: do not include driver header in DMA adapter
      gpudev: fix driver header for Windows
      drivers: fix some exported headers
      test/debug: fix crash with mlx5 devices
      net/tap: fix build with LTO
      eventdev/crypto: fix build with clang 21
      rawdev: fix build with clang 21
      vhost: fix external buffer in VDUSE
      net/dpaa2: remove ethdev pointer from bus device

Dengdui Huang (4):
      app/testpmd: increase size of set cores list command
      net/hns3: fix inconsistent lock
      net/hns3: fix VLAN resources freeing
      net: fix L2 length for GRE packets

Emma Finn (1):
      crypto/qat: fix CCM request descriptor hash state size

Ferruh Yigit (1):
      ethdev: convert string initialization

Gagandeep Singh (2):
      net/dpaa2: fix shaper rate
      bus/dpaa: improve cleanup

Gowrishankar Muthukrishnan (1):
      crypto/virtio: fix cookies leak

Gregory Etelson (6):
      net/mlx5: fix storage of shared Rx queues
      net/mlx5: fix interface name parameter definition
      net/mlx4: fix unnecessary comma
      net/mlx5: fix unnecessary commas
      net/mlx5: fix external queues access
      net/mlx5: fix send to kernel action resources release

Hemant Agrawal (8):
      net/enetfec: fix file descriptor leak on read error
      net/enetfec: fix buffer descriptor size configuration
      net/enetfec: fix Tx queue free
      net/enetfec: fix checksum flag handling and error return
      net/enetfec: reject multi-queue configuration
      net/enetfec: fix memory leak in Rx buffer cleanup
      net/enetfec: reject Tx deferred queue
      net/dpaa2: fix duplicate call of close

Itai Sharoni (1):
      net/mlx5/windows: fix match criteria in flow creation

Itamar Gozlan (1):
      net/mlx5/hws: fix flow rule hash capability

Jacob Keller (3):
      net/ice/base: fix memory leak in HW profile handling
      net/iavf: fix check for PF Rx timestamp support
      net/iavf: fix Rx timestamp validity check

Jasper Tran O'Leary (1):
      net/gve: free device resources on close

Jerin Jacob (3):
      net/iavf: fix build with clang 21
      test: fix build with clang 21
      lib: fix backticks matching in Doxygen comments

Jiawen Wu (18):
      net/txgbe: reduce memory size of ring descriptors
      net/ngbe: reduce memory size of ring descriptors
      net/txgbe: fix VF Rx buffer size in config register
      net/txgbe: add device arguments for FDIR
      net/txgbe: fix maximum number of FDIR filters
      net/txgbe: fix FDIR mode clearing
      net/txgbe: fix FDIR drop action for L4 match packets
      net/txgbe: fix FDIR rule raw relative for L3 packets
      net/txgbe: switch to FDIR when ntuple filter is full
      net/txgbe: remove unsupported flow action mark
      doc: add device arguments in txgbe guide
      net/txgbe: fix FDIR perfect mode for IPv6
      net/txgbe: fix to create FDIR filter for tunnel packet
      net/txgbe: fix FDIR filter for SCTP tunnel
      net/txgbe: filter FDIR match flex bytes for tunnel
      net/ngbe: fix checksum error counter
      net/txgbe: fix checksum error counter
      net/txgbe: fix FDIR input mask

John Miller (1):
      net/ark: remove double mbuf free

Joshua Washington (7):
      net/gve: do not write zero-length descriptors
      net/gve: validate Tx packet before sending
      net/gve: fix disabling interrupts on DQ
      net/gve: free Rx mbufs if allocation fails on ring setup
      net/gve: send whole packet when mbuf is large
      net/gve: clean when insufficient Tx descriptors
      net/gve: add DQO Tx descriptor limit

Kerem Aksu (1):
      net/af_packet: fix crash in secondary process

Kevin Traynor (1):
      doc: fix NVIDIA bifurcated driver presentation link

Khadem Ullah (5):
      app/testpmd: monitor state of primary process
      doc: add conntrack state inspect command to testpmd guide
      app/testpmd: validate DSCP and VLAN for meter creation
      net/mlx5: fix connection tracking state item validation
      app/testpmd: stop forwarding in secondary process

Maayan Kashani (5):
      net/mlx5: fix unsupported flow rule port action
      net/mlx5: fix non-template age rules flush
      net/mlx5: fix modify field action restriction
      app/testpmd: fix flex item link parsing
      net/mlx5: fix device start error handling

Mattias Rönnblom (1):
      bitops: improve power of 2 alignment documentation

Maxime Coquelin (2):
      vhost: add VDUSE virtqueue ready state polling workaround
      vhost: fix virtqueue info init in VDUSE vring setup

Megha Ajmera (1):
      sched: fix WRR parameter data type

Michael Baum (1):
      net/mlx5: fix multi-process Tx default rules

Nithinsen Kaithakadan (1):
      test/crypto: fix mbuf handling

Nupur Uttarwar (1):
      net/mlx5/hws: fix buddy memory allocation

Pandi Kumar Maharajan (1):
      net/ice/base: fix memory leak in recipe handling

Prashant Gupta (1):
      net/dpaa2: fix uninitialized variable

Radu Nicolau (2):
      crypto/qat: fix ECDH
      test/crypto: fix vector initialization

Robin Jarry (3):
      net/tap: fix interrupt callback crash after failed start
      buildtools/pmdinfogen: fix warning with python 3.14
      graph: fix updating edge with active graph

Roi Dayan (3):
      net/mlx5: fix leak of flow indexed pools
      net/mlx5: release representor interrupt handler
      common/mlx5: release unused mempool entries

Ronak Doshi (1):
      net/vmxnet3: fix mapping of mempools to queues

Rongwei Liu (3):
      net/mlx5: fix indirect flow action memory leak
      net/mlx5: fix meter mark allocation
      net/mlx5: fix indirect meter index leak

Satha Rao (1):
      common/cnxk: fix null SQ access

Shai Brandes (2):
      net/ena: fix PCI BAR mapping on 64K page size
      net/ena/base: fix unsafe memcpy on invalid memory

Shaiq Wani (1):
      net/ice/base: fix adding special words

Shani Peretz (7):
      eal: fix DMA mask validation with IOVA mode option
      net/mlx5: fix MTU initialization
      app/crypto-perf: fix plaintext size exceeds buffer size
      net/bonding: fix MAC address propagation in 802.3ad mode
      net/mlx5: fix Tx metadata pattern template mismatch
      net/hns3: fix atomic API usage for LTS compatibility
      Revert "net/mlx5: align PF and VF/SF MAC address handling"

Sivaprasad Tummala (3):
      eal/x86: enable timeout in AMD power monitor
      examples/l3fwd-power: fix telemetry command registration
      net/mlx5: fix spurious CPU wakeups

Stephen Hemminger (6):
      dmadev: fix debug build with tracepoints
      net/nfp: fix metering cleanup
      pdump: handle primary process exit
      net/mlx5: fix uninitialized variable
      examples/server_node_efd: fix format overflow
      examples/vdpa: fix format overflow

Sucharitha Sarananaga (1):
      crypto/cnxk: refactor RSA verification

Sunil Kumar Kori (1):
      common/cnxk: fix max number of SQB buffers in clean up

Tathagat Priyadarshi (1):
      gro: fix payload corruption in coalescing packets

Thierry Herbelot (1):
      config/arm: enable NUMA for Neoverse N2

Thomas Monjalon (11):
      efd: fix AVX2 support
      bus/pci: fix build with MinGW 13
      net/mlx5: fix build with MinGW 13
      test/hash: check memory allocation
      vdpa/mlx5: remove unused constant
      crypto/mlx5: remove unused constants
      regex/mlx5: remove useless constants
      common/mlx5: remove useless constants
      net/mlx5: remove useless constants
      net/mlx5: remove unused macros
      doc: fix note in FreeBSD guide

Tomasz Duszynski (1):
      common/cnxk: fix async event handling

Vamsi Attunuru (2):
      net/octeon_ep: fix device start
      net/octeon_ep: fix mbuf data offset update

Vanshika Shukla (2):
      net/enetfec: fix out-of-bounds access in UIO mapping
      net/dpaa: fix resource leak

Venkat Kumar Ande (1):
      net/axgbe: fix build with GCC 16

Viacheslav Ovsiienko (5):
      net/mlx5/hws: fix ESP header match in strict mode
      net/mlx5/hws: fix ESP header match in strict mode
      net/mlx5: fix ESP header match after UDP for group 0
      net/mlx5: fix control flow leakage for external SQ
      net/mlx5: fix flex flow item header length

Vladimir Medvedkin (1):
      fib6: fix tbl8 allocation check logic

Wathsala Vithanage (4):
      mcslock: fix memory ordering
      ring: establish safe partial order in default mode
      ring: establish a safe partial order in hts-ring
      ring: establish safe partial order in RTS mode

Xingui Yang (1):
      net/hns3: fix VLAN tag loss for short tunnel frame

Yang Ming (2):
      eal: fix MP socket cleanup
      crypto/ipsec_mb: fix QP release in secondary

Yunjian Wang (1):
      vhost: fix double fetch when dequeue offloading

Zhichao Zeng (1):
      net/ice: fix statistics
