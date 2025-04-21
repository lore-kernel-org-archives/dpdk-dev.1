Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C8C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 14:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32D6E402A9;
	Mon, 21 Apr 2025 16:19:55 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by mails.dpdk.org (Postfix) with ESMTP id CE23640299;
 Mon, 21 Apr 2025 16:19:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWpvZbsYZEwe5GbHDy8uoTZr7XIZNmQz74xJFoqbtUxQQ/ZNoX3+8QYZdf0umporpMSvnqAQgIbU00JczRQrta0CZUXCjYSm9P+v86iTJ+PluTT5whGnD7pGkhpXxl1e7fDe0tyUwr+XT9d/xlQuiVScTG596hymgSHgWPePnj7wp7ZdPXdWOMXCXeWTJcSD2TI7ED2qYP9GFRJcvdP8s8vY82vZP7wtgas5TiCL0t8b2cPxF+JWnEmurUt6m9EVhEYizrvd206e1gI/mREcny2POmniT24q7GDwh0BcIGK98q1nDm2qeBatWgtkSPEB7RtOYWUrW6PykGHYoWeFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uChbWjEhXNSKjmsPnlMXyOh9EzCj2b1jX+5bBj8ooXI=;
 b=U0WgrXNO3dxMA5ZJkmOD1Ma6Z/HyI21QRyU7a/GyZqZ0Bve3XG2pe+hrLFpqi09/SBU3/OOoNzgLjG0n2WnEN+1cnUJQZ8722dc49GXSzMbHyzsxderyENv/vCES6S5wEPd/BH1HEDFxLQf1HRI0EgftJcIXdI32u7+BO2283E62fRrbgEMM0zoQHph3i4+DbxlWRwTvFec2YRKVKdIuwY64KMhZtbGKJ2yNKiNZRPXM8ibflmgV14gbymkl2xNzZFHUpdBx+fGIIfRovKTJ87+XPGbTy3XQUWFz3khPMaOi9f4+btHpcM2KMlNWuCLz23DM8h8xzQh2uJl8JJ/6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uChbWjEhXNSKjmsPnlMXyOh9EzCj2b1jX+5bBj8ooXI=;
 b=BO+UqTFVPndNCMK3xYiY2Fg4zRSSlCVIBvAbq0MCfRMHCCDJyNMr3R/1xUlitRzAydiSEp79qHvsdWxV3p0ltfHVSEtj19mz/taNrOwsjUq9oT54E3pMKsqqrViLlKbwMNg72SekUAQDbksVeJw5KGIcpLer+FnUWGAY6f0TKwbNr1BFWIjkMc3CE+zgk4Khq1wI8e7A+B/u/yUvMmb/BSnkRU4eoE2NbTfruBjbfbkPAeQSqijqWwpcMYOzDtg8Zn4ctMGFKZ5+bFTSjsG6NPrfdosooSL0V/zTi6sXGRZZxN4fndyCFdn8ONS+wiiwzFutQ0XKE5ciuGwAfcM6sQ==
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Mon, 21 Apr
 2025 14:19:49 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::b3) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 21 Apr 2025 14:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 14:19:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 07:19:37 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Apr
 2025 07:19:30 -0700
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
Subject: 23.11.4 patches review and test
Date: Mon, 21 Apr 2025 22:19:19 +0800
Message-ID: <20250421141920.622156-1-xuemingl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3c5187-a6ac-43ba-78e1-08dd80df9309
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3dmdIRsZtN7jTJAIqd1cRH2O2Fk8xAtgZZuTaXDMN+bQiKpLaCKUyITrHgX3?=
 =?us-ascii?Q?vS0U7QQ8nsabaqTLvNb0LqgqukOYJFk/XSsA4BPsDqPZJ78YZi9fWWvkbdmK?=
 =?us-ascii?Q?4GfHSpugTQUqvP4B9nGIRk+C7if5KyjkmS2WjOsP9fDdZdMTUBOiD5ouq1BJ?=
 =?us-ascii?Q?0243AQPBTr5mqC2zv4HrPT3RLrKNLQ0u6VisxnQQWN85cqmeHjbzXgAbTlMH?=
 =?us-ascii?Q?Ux8xiQ2FOl2MplhLkj1APQPCBvwKYxFbTeG/sIizVAYt4lcxGPjL0s3JBHZi?=
 =?us-ascii?Q?NGcJxwEmBoauEOb9kXHxBu7MEDWD6m17pG0MI/69CMcPdgAGdMCw2uaALiux?=
 =?us-ascii?Q?dDr1oHFPnri0zAGUTVtBw9x1od3cR6XNgLBpilgCNa270O4245fBIT3+YttC?=
 =?us-ascii?Q?I7vWJlWG+7EcTxmk40QfRQwP6CMJhcP5To7GM0LlmcVAhuipRUauH4HTYuJu?=
 =?us-ascii?Q?Rd+gWGbCDvvgHEh0v//0oqDA6cBKi2FCt58QfIoRsQxfvduqEFGLQ/9vcH++?=
 =?us-ascii?Q?iataVmQ6KtgkekedDfuXzfhXnEz2syHy6hmL7grRNLC3oUQbgv8dhoAeVFFo?=
 =?us-ascii?Q?ks2vBodUnjED0nzZe1a7VotJtTImgkp8QaLZ6+Xti3TnxjFiVm9pZYqBhYkj?=
 =?us-ascii?Q?fdXEOx1vo5tU5k/l0TgXYKjlSA6f5BTRYIElPYMVhy0HTCoDkHHDXOPMKz8K?=
 =?us-ascii?Q?HXomBqOimECeVwYN+G/3WfnYuchcjmNsmDIy5krIFO+zcBon054a/pEy9saJ?=
 =?us-ascii?Q?AeW++1WYfv5zo3azRUvoRn3A6hd4vqqc4aBwKGjpmpbV9PiboadT2eLHeipT?=
 =?us-ascii?Q?0ZKxa9LWVMtxLzw+cvq9EJ4C9ySl+ouLwbHM8ow1hsAKKMXVeHP8kgisahD7?=
 =?us-ascii?Q?KGqCmijupzWwKutb3xd5aDuM7ok6HO+W7T5mWCk3hAiZG5rLRcfnFzVN8npt?=
 =?us-ascii?Q?eMMAB4WDo9/KAqvmC+YLEca2Grc0jMLSWZJ5cCf/x+AupsyoHneHRuS8pV14?=
 =?us-ascii?Q?WlzCthnrkCJmHPZRpPQG9NWEx5zxItaTqA7bw5m8AkymmLZYrsFkgmGeLb6c?=
 =?us-ascii?Q?JTbbUk/PtshWFCLkdNqJ+sVbsQdw7fRqslfIVRzLpzeA+WtzI0Wncjtoo/ZI?=
 =?us-ascii?Q?24JgBYZjUMlRCbPDJysVSJG6GCeMCdXdccMCnbCcKcGr9Sglup9UUwZDmSuC?=
 =?us-ascii?Q?a8J0AM08w3AFqdnIdxYfsABpsD379JlsOTDmlkQrpyzukaVEIndwA9EfSUwM?=
 =?us-ascii?Q?mKZdsLkxgOupSPV/CtaKuOcrhhNQJw94Y6gUxst8AKK78/K1zuot1unU/fJ/?=
 =?us-ascii?Q?nt6FSfPHSMoaCUOkKqAD83FzFSFos2x5C4TfFWoRpRPB1mrXd9IzIpV9pc13?=
 =?us-ascii?Q?W9rKJns5EVlw42hmNMCGmKjm8KDKYryKFZ4571Umn/bvZLPlbdQ5yevBhZkA?=
 =?us-ascii?Q?doYYvOGzphfvE2YwZMB84gSN82m1NjD7OJdG2Sr9VCScZVn5B7qWjRg/VF2Q?=
 =?us-ascii?Q?EAAI8oUe3UfbYJl5BWQ2am0+CbS04B3Opwg9tdmR5BC64NYwD7Tb+Z2iYg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 14:19:48.8318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3c5187-a6ac-43ba-78e1-08dd80df9309
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

Here is a list of patches targeted for stable release 23.11.4.

The planned date for the final release is 25th April.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.4-rc4

These patches are located at branch 23.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Xueming Li <xuemingl@nvidia.com>

---
Aleksandr Loktionov (2):
      net/igc/base: fix MAC address hash bit shift
      net/e1000/base: fix MAC address hash bit shift

Alex Vesker (1):
      net/mlx5/hws: fix DV FT type convert

Alexander Kozyrev (1):
      net/mlx5/hws: fix fragmented packet type matching

Amir Avivi (2):
      net/igc/base: fix iterator type
      net/e1000/base: fix iterator type

Anatoly Burakov (3):
      net/e1000/base: correct mPHY access logic
      net/e1000: fix crashes in secondary processes
      net/ixgbe: fix crashes in secondary processes

Andre Muezerie (6):
      eal/x86: fix some intrinsics header include for Windows
      eventdev: fix format string data type in log messages
      net/bnxt: fix indication of allocation
      common/idpf: fix void function returning a value
      net/intel: fix void functions returning a value
      stack: fix pop in C11 implementation

Andrew Boyer (1):
      doc: update ionic driver guide

Ariel Otilibili (7):
      net/sfc: remove unnecessary assignment
      net/octeon_ep: remove useless assignment
      net/enetfec: remove useless assignment
      buildtools: fix some Python regex syntax warnings
      use Python raw string notation
      eal/linux: remove useless assignments
      mempool: fix errno in empty create

Arkadiusz Kusztal (2):
      test/crypto: fix check for OOP header data
      crypto/qat: fix SM3 state size

Barbara Skobiej (3):
      net/igc/base: fix data type in MAC hash
      net/e1000/base: fix data type in MAC hash
      net/e1000/base: fix reset for 82580

Bruce Richardson (6):
      net/iavf: remove reset of Tx prepare function pointer
      net/intel: fix build with icx
      test/dma: fix pointers in IOVA as PA mode
      net/iavf: check interrupt registration failure
      net/iavf: fix crash on app exit on FreeBSD
      eal: fix undetected NUMA nodes

Carolyn Wyborny (1):
      net/e1000/base: skip management check for 82575

Chengwen Feng (2):
      app/testpmd: show all DCB priority TC map
      app/testpmd: avoid crash in DCB config

David Marchand (2):
      ci: build with MSVC in GHA
      net/mlx5: fix leak in HWS flow counter action

Dengdui Huang (3):
      net/hns3: fix mbuf freeing in simple Tx path
      net/hns3: fix copper port initialization
      net/hns3: fix reset timeout

Dima Ruinskiy (5):
      net/igc/base: fix deadlock when writing i225 register
      net/igc/base: fix infinite loop
      net/igc/base: fix typo in LTR calculation
      net/igc/base: fix unused value
      net/e1000/base: fix unchecked return

Gavin Hu (1):
      net/mlx5: fix polling CQEs

Gowrishankar Muthukrishnan (5):
      crypto/virtio: fix data queues iteration
      vhost/crypto: skip fetch before vring init
      examples/vhost_crypto: fix user callbacks
      crypto/cnxk: fix asymmetric operation status code
      crypto/openssl: validate incorrect RSA signature

Gregory Etelson (1):
      net/mlx5: fix IPIP tunnel verification

Huisong Li (1):
      ethdev: fix functions available in new device event

Jakub Buchocki (1):
      net/e1000/base: fix uninitialized variable

Jianping Zhao (1):
      vhost: clear ring addresses when getting vring base

Jie Hai (2):
      net/hns3: remove PVID info dump for VF
      net/hns3: rename RAS module

Junfeng Guo (1):
      net/mlx5: fix actions translation error overwrite

Kevin Traynor (1):
      vhost: add null callback checks

Konstantin Ananyev (2):
      test/ring: fix init with custom number of lcores
      gro: fix unprocessed IPv4 packets

Long Li (3):
      net/netvsc: scan all net devices under the PCI device
      net/netvsc: remove device if its net devices removed
      net/mana: fix multi-process tracking

Long Wu (2):
      net/bonding: fix dedicated queue setup
      net/nfp: fix VF link speed problem

Maayan Kashani (8):
      net/mlx5: adjust actions per rule limitation
      net/mlx5: fix flush of non-template flow rules
      net/mlx5: fix GRE flow match with SWS
      net/mlx5: fix hairpin queue release
      net/mlx5: fix LACP packet handling in isolated mode
      net/mlx5/hws: fix crash using represented port without ID
      net/mlx5/hws: fix GTP flags matching
      net/mlx5: fix GRE matching on root table

Matthew Smith (1):
      net/ice: fix dropped packets when using VRRP

Maxime Coquelin (2):
      vhost: fix log when setting max queue num
      vhost: reset packets count when not ready

Minggang Li (Gavin) (1):
      net/mlx5: fix Netlink socket leak

Mingjin Ye (1):
      net/ixgbe: fix minimum Rx/Tx descriptors

Nawal Kishor (1):
      common/cnxk: fix atomic load in batch ops

Nicolas Chautru (1):
      test/bbdev: update FFT test vectors

Nithin Dabilpuram (1):
      common/cnxk: fix inbound IPsec SA setup

Nithinsen Kaithakadan (1):
      examples/ipsec-secgw: fix IV length in CTR 192/256

Pawel Malinowski (2):
      net/igc/base: fix semaphore timeout value
      net/e1000/base: fix semaphore timeout value

Peng Zhang (1):
      net/nfp: fix multi-PF control flag

Praveen Kaligineedi (1):
      net/gve: allocate Rx QPL pages using malloc

Przemyslaw Ciesielski (4):
      net/igc/base: fix bitwise operation type
      net/igc/base: fix NVM data type in bit shift
      net/e1000/base: fix bitwise operation type
      net/e1000/base: fix NVM data type in bit shift

Rahul Bhansali (1):
      net/cnxk: fix NIX send header L3 type

Rajesh Mudimadugula (1):
      crypto/virtio: fix redundant queue free

Sangtani Parag Satishbhai (1):
      net/bnxt: fix crash when representor is re-attached

Sasha Neftin (3):
      net/igc/base: increase PHY power up delay
      net/igc/base: reset loop variable
      net/igc/base: fix LTR for i225

Shani Peretz (1):
      bus/pci: fix registered device name

Shaokai Zhang (2):
      test/crypto: fix AES-ECB test lengths
      test/crypto: remove unused variable

Shijith Thotton (1):
      test/event: fix number of queues in eventdev conf

Stephen Hemminger (21):
      crypto/cnxk: fix build with GCC 15
      net/thunderx/base: fix build with GCC 15
      test/bonding: fix active backup receive test
      build: force GCC 15 to initialize padding bits
      net/cpfl: fix representor parsing log
      raw/cnxk_gpio: fix file descriptor leak
      eal: fix devargs layers parsing out of bounds
      net/qede: fix debug messages array
      net/hinic: fix flow type bitmask overflow
      crypto/dpaa2_sec: fix bitmask truncation
      crypto/dpaa_sec: fix bitmask truncation
      event/dpaa: fix bitmask truncation
      net/dpaa: fix bitmask truncation
      net/dpaa2: fix bitmask truncation
      net/qede: fix nested loops
      examples/l3fwd: fix socket ID check
      common/cnxk: fix null check
      doc: fix feature flags for queue start/stop
      app/testpmd: fix out-of-bound reference in offload config
      pdump: clear statistics when enabled
      examples/ptpclient: fix message parsing

Tejasree Kondoj (1):
      examples/ipsec-secgw: fix cryptodev and eventdev IDs

Tudor Cornea (1):
      net/af_packet: fix socket close on device stop

Vamsi Attunuru (1):
      common/cnxk: fix DPI mailbox structure

Viacheslav Ovsiienko (1):
      net/mlx5: fix hardware packet type translation

Vladimir Medvedkin (3):
      net/ice: fix memory leak in scalar Rx
      net/ice: fix flows handling
      net/ice: fix flow engines order

Wathsala Vithanage (1):
      crypto/openssl: fix CMAC auth context update

Xueming Li (3):
      fix ptp
      test/crypto: fix backport merge
      update version to v23.11.4

Yang Ming (2):
      eal/linux: fix memseg length in legacy mem init
      net/iavf: fix mbuf release in Arm multi-process

Yunjian Wang (2):
      vhost: check GSO size validity
      vhost: check descriptor chains length

Zaiyu Wang (1):
      net/txgbe: remove useless condition for SW-FW sync

Zerun Fu (2):
      net/nfp: fix multiple PFs check from NSP
      net/nfp: fix misuse of function return values
