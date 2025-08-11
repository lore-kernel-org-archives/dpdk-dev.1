Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2ABC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6326E40DDC;
	Mon, 11 Aug 2025 15:44:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by mails.dpdk.org (Postfix) with ESMTP id 71E94402AC;
 Mon, 11 Aug 2025 15:44:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA574Yn0b6u/0yUBM/mcGEA67ypeg2TmzxP1BBMCep8jMkLN/c0CUAE2NJdSvSkZKwsyIc1VF4Qfiq1h7PZOFtOu71bA5jbv/7tl+0m/05u3GdBSu0gV0ElmGW0K5J995isyX4+JcuxAEZ/DmvDYNEMIoSgMOr4H9HfCIV7h+T7v2X9Ybo3vuAHam9/O/2MiqrAJNSJHWMCQ2YGTu2yWnHLQgBAHYFo5Vl93FPvFhiimELUeCreW+jzwHXXrwxJpgNbAX1HttNQnf+XJfv660JbGScNmhTYPkYZkGYMx4SJwuB3CIq1OAI2a2/y4AUTX8vhx/LuZs4Lr4xH5ge3C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kftsUck3qFAw+TjO49/urx2A21mCocGvnlx+XEuGbaY=;
 b=vGnI4CizmZ+nMwIGHpnflQm02p5Yc/bfQus4eDW/SQVLM52NbtAr29ZXVtYR3p8+PWIrtQsFs6eXebbsd/9LfcP8AP9abbolVH+Gzq/HfXBjIr67FCsUaq5hc6x25eRJcljGQKlVmc+R7rx3/4RIrGUKk8CWhcieBWxLz6CbhPmKOkReobtECuWE4Gc1jcF2hpY1RWeC88wLNxi3RcKWo/A1R1Jbrp+VZkMUe88ctZ6ykUBrvsb7Jra4IIjbViSWdHRV/XHNqrVW0A5W2Nh32hDg2N/P3rYyEv4CyP36F6x9k9Nw3oax0Cw1YRtuFl3M7aJQFVP5SnVO1QBBqvmWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kftsUck3qFAw+TjO49/urx2A21mCocGvnlx+XEuGbaY=;
 b=Xzu6HPd1QrM5ZzigBZNuj8MjCGu4uJlK30w3UzAt+jmh8EWpSMWyGQNu6Bq3LXY36oqToyFoIiPQ8KmN2I4Kn9nrN029V5JyV4jqEx6+ZQ42h9mXDTDY130xnCrDWVuUlmlQhJcR0Xd356lM49zX7skUCXD490MDlWqkw91Meq1atzxAjZiw6nTO1lxfuEqtlWmqN3Hu06F4uGGYJMbjr8jozjSza0ICFnJXiWA9fMD2lx7nyh+35vPC8brl8zgLW2bCI4qYoV6RFNs5ntjuVuHSnhuociEjozqOEfXt0rYUjK7sHWPzI/dj8RHyQlmozFo0tqYF0pAdWCMj/yrsEw==
Received: from CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::11)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Mon, 11 Aug
 2025 13:44:00 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::40) by CH3P221CA0001.outlook.office365.com
 (2603:10b6:610:1e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 13:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 13:43:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 06:43:41 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 06:43:35 -0700
From: Xueming Li <xuemingl@nvidia.com>
To: <stable@dpdk.org>
CC: <dev@dpdk.org>, Abhishek Marathe <Abhishek.Marathe@microsoft.com>, "Ali
 Alnubani" <alialnu@nvidia.com>, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, <benjamin.walker@intel.com>,
 <qian.q.xu@intel.com>, <yuan.peng@intel.com>, <zhaoyan.chen@intel.com>
Subject: 23.11.5 patches review and test
Date: Mon, 11 Aug 2025 21:42:19 +0800
Message-ID: <20250811134220.45579-1-xuemingl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ad3c0f-b06c-4ba9-aaf3-08ddd8dd2081
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1VGa2FBVytUeFdyMGdub2M1MmR3VjVkbS9ZOVc2bkdzTkVRUXVEVGtvWHh3?=
 =?utf-8?B?ZTVXVG1QRGt2TEduREh4eHVvQ2lSaHFyT2NER2RvaENGY2VuMDZ1eHduQUkr?=
 =?utf-8?B?VCtZM0RvdFVtOU4yREZzRU1tUWpmRUpaTURvVDhMVC8wZkYrcnhnUlZtT1ll?=
 =?utf-8?B?K3UxKzB1MTB3R3JWRzV6aUtBV1BCZFdjdlJCQkw0UUlIcGdZM0d6MlpaNTJC?=
 =?utf-8?B?Yno0Y3hHL05Zd3hqZHhnaFlKQWI4Q2tZdHptd1hGaHducndmb0kzeVhweWNW?=
 =?utf-8?B?RE15ck5PckZHSWZsZlI1U0pXL21wMHNNazdQZTY2MHQza1p4V096TG5ESEVr?=
 =?utf-8?B?MzQ5NEZVanpjNlArd2hXUFoxM2xKaEpqQnM0Zmg5OWw4T2lENU8vaWZVdFpB?=
 =?utf-8?B?M1ZydlYwUERIM25xb2ZKVFpnMGVWQnJTKzQwbWRickUwdXEvZHJBVHZqYVlE?=
 =?utf-8?B?SjVxdEYrYlBJQnhqTXN1alFpRUdmc0s1MHI0WGhpcnZtZTd1ZnBvT1NlUGRD?=
 =?utf-8?B?TGxBbjYvRlRHSVVtVi9iWWhZaXFKMHlmWi9TR0p1YlhTT0U5Q2psYkdnT01H?=
 =?utf-8?B?cjBrN2duMjBabVlEZnNWakFjTEdhRHk2WHlWTUVmQkN3OFd0eVJBNUJKZGgx?=
 =?utf-8?B?MjNqYS9JZUh3Vi84bGRYVElTTWs1YXN2cUw3OUJxOENreVVCZzFORmNHM2V1?=
 =?utf-8?B?WVhFcHo4L1hBUXhMV3BOb3R5Z08ybW5rUUVScHk2bUNzZDRwQ09rNDJERnV0?=
 =?utf-8?B?NE82Z3RVN3ROMytvVHFXOURTVkNWT2FpOGZVQ2J1VndFTlNhaGJoUXBTUFZE?=
 =?utf-8?B?MVZPUURTUlVuVHlvZFA1cGI3czZjMkc3N3BvN1VzOWxGS3BQTHpGSG9EQ0pz?=
 =?utf-8?B?b2V0MHdSakQycXRQVi9Xd2pZOHF2Z255WldOL0pSSjNLSDY0Y09KODRUbGwy?=
 =?utf-8?B?MWliL0NWeHZTWUhJTjVXZGxkcnRBUjVUYk5XMzd0M25zMDdDWHpKa1F6azlj?=
 =?utf-8?B?ZUZyaHF2aTRMc2R5TGI1Vm5SQXJyL3d5eWg0d2RDL3RVYWVpVHcrNzFmT0d4?=
 =?utf-8?B?S2xqL2hnZ0Y1bGFjQnBESXR4eTBjOVJMWnBhOElBZytaUWpkRzIxaDFxYm1h?=
 =?utf-8?B?WWZOVEY2bGozdmtUUmhOcmh0WnZrQVdWa1lJL1kvVEFxUlp1bEtqcnRHV0pM?=
 =?utf-8?B?REN0cDBDYnV6V0hUN3N0NEFvVnQ2Zm1zbHNKekxPMngrUjFBQmhLNU4zWFIx?=
 =?utf-8?B?Q3dvTTI3ZmVPS2Rod01PNC9vZlFlNURreVVhdXhLaGJyZnNGTU5pMHhTcER0?=
 =?utf-8?B?QVdpQk4rTmhmTjdQVHZYdUdWaUZPMzByTW95UHNVNkdVS0QvMlNWbjZNM1M1?=
 =?utf-8?B?cHEyMEQwcnZVUUZQbVJpZ3dnTTFJZC96ZEUybjErQW9mZWtDTGpQUHhnYXFl?=
 =?utf-8?B?MkdSWGlyY05XUS9FeDEydWcrS3pYZkdmaUI1T0ZzY0p6VWxZT1VNeVN2djkz?=
 =?utf-8?B?WUtxVVpDSmR6L2tyZVRnTTBrZUpOTFRjV2dpV2p3Q3JZMDB2TnF3ZTFUVG1P?=
 =?utf-8?B?UW9KM2Z1UlFBMVp6KzlqQVJwWDJaM0VUZUNZaHRWdnYrbVdBYkplUEcvYlpW?=
 =?utf-8?B?ZWcvMGxvaldDazdydlUwNGdmN0x4WVdETXB3M0ROazc0T1RhbCtGSDdlQ1lp?=
 =?utf-8?B?K1RNRFFZUmlQSHc1c3cyeWhVbU5Da3c5QVB6Sk03NUF5TmppbHdTeHkxbzM4?=
 =?utf-8?B?aHZGNHM4Mkt3VFdRdUtJVWVFUUJlMUlKT3hDajZsdk1rM0ZDL2tSU0tBaVVL?=
 =?utf-8?B?K1VrdHFUcWpsUEd6WXRwa3VrRzA0eTJVMWhiUFBiZlJ5MUlWSWFYbFBKL3l0?=
 =?utf-8?B?cUh5NVIzZlE3T2NmUzBueDdGRkc3SCtUNVZoWTRxcjAyNlhybVhYdEYrQ3VR?=
 =?utf-8?B?RTlPaEtpN0ZKSGlmKy80VXU3WTZaOFNKRExuTi9pSVk5NHdDQjhuNzl3Q01y?=
 =?utf-8?B?czM0VUpPZXk5TmpFcGlXZ0ttTndiQWlxaHRpVFV0aFR1T2J6czZSVXZ3RjZQ?=
 =?utf-8?Q?zvL/a+?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:43:59.9556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ad3c0f-b06c-4ba9-aaf3-08ddd8dd2081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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

Here is a list of patches targeted for stable release 23.11.5.

The planned date for the final release is 15th August.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.5-rc1

These patches are located at branch 23.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Xueming Li <xuemingl@nvidia.com>

---
Amiya Ranjan Mohakud (1):
      net/iavf: fix VLAN strip setting after enabling filter

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Ariel Otilibili (1):
      net/af_xdp: fix use after free in zero-copy Tx

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (8):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver
      net/ice: fix inconsistency in Rx queue VLAN tag placement

Chaoyong He (5):
      net/nfp: fix crash with null RSS hash key
      net/nfp: fix hash key length logic
      app/testpmd: fix RSS hash key update
      net/nfp: standardize NFD3 Tx descriptor endianness
      net/nfp: standardize NFDk Tx descriptor endianness

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Clemens Famulla-Conrad (1):
      dts: fix deterministic doc

Dariusz Sosnowski (5):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (7):
      acl: fix build with GCC 15 on aarch64
      vhost: fix wrapping on control virtqueue rings
      eal: warn if no lcore is available
      test/lcore: fix race in per-lcore test
      doc: remove reference to deprecated --use-device option
      eal: add description of service corelist in usage
      net/virtio: revert Tx free threshold fix

Dengdui Huang (13):
      net/hns3: fix integer overflow in interrupt unmap
      net/hns3: fix memory leak on failure
      net/hns3: fix extra wait for link up
      net/hns3: fix memory leak for indirect flow action
      net/hns3: fix interrupt rollback
      net/hns3: fix divide by zero
      net/hns3: fix resources release on reset
      net/hns3: fix CRC data segment
      mem: fix lockup on address space shortage
      net/hns3: check requirement for hardware GRO
      net/hns3: allow Tx vector when fast free not enabled
      net/hns3: allow Rx vector mode with VLAN filter
      net/hns3: fix Rx packet without CRC data

Dhanya Pillai (2):
      net/ice: fix flow creation failure
      net/i40e: fix RSS on plain IPv4

Eugenio Pérez (2):
      vhost: fix net control virtqueue used length
      vhost: search virtqueues driver data in read-only area

Ferruh Yigit (1):
      ethdev: convert string initialization

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (2):
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA decrypt validation

Gregory Etelson (4):
      net/mlx5: remove unsupported flow meter action in HWS
      net/mlx5: fix mark action with shared Rx queue
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Hengqi Chen (1):
      net/virtio: fix check of threshold for Tx freeing

Ivan Malov (1):
      net/sfc: fix action order on start failure

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jaromír Smrček (1):
      doc: add kernel options required for mlx5

Jiawen Wu (11):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: add LRO flag in mbuf when enabled

Kaiwen Deng (3):
      net/e1000: fix xstats name
      net/ixgbe: enable ethertype filter for E610
      net/e1000: fix igb Tx queue offloads capability

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Long Li (5):
      bus/vmbus: align ring buffer data to page boundary
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (4):
      net/mlx5/hws: fix send queue drain on FW WQE destroy
      ethdev: fix error struct in flow configure
      examples/multi_process: fix ports cleanup on exit
      net/mlx5: fix crash in HWS counter pool destroy

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Marat Khalili (1):
      buildtools/test: scan muti-line registrations

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (2):
      net/ice: fix handling empty DCF RSS hash
      net/ice: fix querying RSS hash for DCF

Mohamed Feroz Abdul Majeeth (1):
      net/octeon_ep: increase mailbox timeout

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (3):
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation
      common/cnxk: fix qsize in CPT iq enable

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Pavan Nikhilesh (1):
      eal: fix return value of lcore role

Pravin Pathak (6):
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      event/dlb2: fix QID depth xstat
      event/dlb2: fix public symbol namespace
      app/eventdev: fix number of releases sent during cleanup
      event/dlb2: fix dequeue with CQ depth <= 16

Radu Nicolau (2):
      crypto/virtio: add request check on request side
      crypto/virtio: fix driver cleanup

Rahul Bhansali (2):
      net/cnxk: fix descriptor count update on reconfig
      common/cnxk: fix null pointer checks

Rajesh Mudimadugula (3):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length
      crypto/virtio: fix driver ID

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shani Peretz (1):
      app/crypto-perf: fix AAD offset alignment

Stephen Hemminger (5):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy
      crypto/qat: fix size calculation for memset
      latencystats: fix receive sample race

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Tanzeel Ahmed (1):
      examples/flow_filtering: fix make clean

Thomas Monjalon (1):
      examples/multi_process: revert ports cleanup on exit

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Vanshika Shukla (1):
      crypto/dpaa2_sec: fix uninitialized variable

Viacheslav Ovsiienko (3):
      net/mlx5: fix maximal queue size query
      net/mlx5: fix hypervisor detection in VLAN workaround
      net/mlx5: fix out-of-order completions in ordinary Rx burst

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Xueming Li (1):
      Revert "net/ice: fix inconsistency in Rx queue VLAN tag placement"

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter
