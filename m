Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6580F327AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 06:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6AF5402B8;
	Tue, 21 Apr 2026 08:47:05 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by mails.dpdk.org (Postfix) with ESMTP id 354EE4029B;
 Tue, 21 Apr 2026 08:47:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkqqelMMiaDVtRau92OR/BflnYPJxgTLW8Al+akXIBd+xwv4B7m6m2ah23n+Eq4DhWrYlud59mMwaDet69E9CUhj7WNkLEdq9uPMMInDuAFaMD1t/uELY4pPJ6v/9ZRVNMh4zGHADzyk6WrjgH05wlUw1OsH4eFzjLk1HV6TM2EmIbBpG5UUrSAhVdE7lEE+KiRWFEkOanDg6wMXyt0Swm4vxWZsPOfjmvQqmkG7Vy3SiDHKN0SV5cW3UgP/XheQkrP8l+3hlw+agaK20d3yzY9YBIkpShsmGcdwWhuyFGkgj1ZHyPhDjc1M2Yfn89JB9z2JmCiuEbLk2xffN72iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUK9HzJgNDUHCXbZ6wZ0Jxy55y/1plFDpP8yzzpugb8=;
 b=HM2j5VbZPrqFGrYuELISB7c+vypiiZrhaJDlWiR5Pc3EQXNnq70YUbn71k5Moy+lLgR0pyU/rgmKPWIKuXo2i3Pm7CFOCqPqNB0KT6mbPjhhBehE4APofvTv4KebEtO1HcQVTlDyDi6B1dRfoNP6GghQjfSKyUlZ837vfE2HBxQJuKMgriUjBXvgCgRe9JH57I3W+ZD5jnjFeOB964VJ1iaAjyWC7Gmsajyv/PLqY0EsPAfIax6HaUR5UqWfndzryOOKUl4EWRTRyyc5uc1Bo+Zv870R4yP3J5mo8lq7r/z1oTuZzgWkA+R480i5TAKryZJ9KLcy9s4PLp348H5E0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUK9HzJgNDUHCXbZ6wZ0Jxy55y/1plFDpP8yzzpugb8=;
 b=YU9aYzP6OEeN7CdeD/VvAfvMPwNvrv7zCPRZVtMcBdvzrxW8G2JaPdHtYt6JGRVLAjB5cenSNkAroP4W4KtMdsr8V3H0H13l0LbhIvxARS/eKjJgg1rTe2s67vPRit9t7aTGL0vtWxNTVnnrDIXF/uk/4Hyvxf/JtD4y7BK7dDnzeSbuUK2b0GB2zbXLagT9e4erAPoW+2V6bMuoRmaIJ8SNEdbXRPehDSwzMLAUzj0Fw3BkR6fGB+n6WHhajnCT7scExH24og3BCUKOu7lENOK1V7ejMHhRDfsABXTTevEzKgffhrdNex6JCzUV0fLOi7oJ3pQCukFjHQdNcavQ9A==
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 06:46:56 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::69) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 06:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 06:46:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 23:46:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 23:46:46 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 23:46:41 -0700
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
Subject: 23.11.7 patches review and test
Date: Tue, 21 Apr 2026 09:46:37 +0300
Message-ID: <20260421064637.2506152-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adf3a9c-79db-4cea-bb11-08de9f71c7b7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: J0NVI/8guDa8Wx5cXx+9dLH4hPiBmB8Gg+ezFw9MkpuuVC2axg8cT8tlQqjFSFsd5XW0XV+EklLHI5BZkfLYNbkw9pe6maBihu/XIstSPNbnQ6tH3bUyN1Ww+OG/oqCMYVhQ5+1848YbcyL0U14m1/vjGSRKUpqhuzb+IvFYhhf15OS9L1RW97vVkGrXTutPvcSE39cX99ADWghaiqPQ1JEc4uC4cgwgGQ2Q/0CwktoHaQ8r6tHUGL+HnqyS04daIy8QlfBTuQNBlpIyF7yLd2vVwi73cAi50E8L5OMHHC/cuqtctSg9STLzfOIXiUnAYCM9bnk/MK95/cVIrKrczf8eSFZrSQSnvQsA0KJ+Z8MHqVNs2UU3yqA9IEerOXkCzKA0eJWR08PQofAEx2PGG5vTMsuCwxIqGSMUQmaw+rpWRwfvDuNmx8tqwQdw/rYffwm0P6jsGvo2jsRUl9E6MB7Pbl8P5Np/DBbG6BJ1VK5Dz58DDkzcHpnQEdFs4iXqJPfM+uAUQbUGOGWZBSSk4T6ycMTMnoc6b5Hh39kHEfqVh1NVwTKZm/CAe7mOlYxLSExwz1WQRBfuxI6pbpQ1XOFOMLj5LJsrl8wnnyYrVUU7OVIQ6PjKtOINH5HNDK8j8IYfvD0P8XHFHrGBzIzFSHS6M5Za7J5s6MOovaWG2b9A+40m2+93ZAwkbtpyQjArY95r7KuRbognFMIEJfg4qOeaI7eV1p9wmZgjMaTITXf6MCZBVAsrQ6hjN42pUURcUGVEdHPcP/xE1uSl9KDI/w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Aa2KqtYB6mkMdpFTkWdgMUQJGTWScFBRupGAnHnXXPNqsBSowgtbX4hq8XUQLZ8s1mhRvnckM5lC8qy4IxfaPiJNNjR1DTk/ZMmb0uzcJBm/gmYIo+IROuRgb1dH5lJioJq/xsf4vfXJt9UE+CwdXts99mxVreog9FDv3/VjtHtpzd3te4VYj5AtiiLiHVLMpTfhXxfQsUUFDcIgrGQLZkFVLRfaeAFBoNx7e5daqUcJICwhOi35UI05Yqz5Gi8S0nOIdZmoKH87K0Vo5BOucNJInAf6wyjvpt8YKvR/pPVoiRFj936G83c4/MAaaejlpIbnyNXwm21hv9zc7uS93p+RIi0f0nuFZuT3MxQDMM6W2FFPisCsv2zpHvGfehRq3VOqo/u5ZIMYxtwnex+yfm4B76IDKDGvQuAnQDxxZPKGqNHZI1T5XFPGSrGMJQY0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:46:56.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adf3a9c-79db-4cea-bb11-08de9f71c7b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

Here is a list of patches targeted for stable release 23.11.7.

The planned date for the final release is 30 April 2026.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.7-rc1

These patches are located at branch 23.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Shani

---
Aarnav JP (2):
      examples/packet_ordering: fix format specifier for port ID
      examples/ptpclient: fix format specifier for port ID

Anatoly Burakov (12):
      net/ixgbe: fix memory leak in security flows
      net/ixgbe: fix potential null dereference with IPsec config
      net/ixgbe: fix potential null dereference in IPsec flow
      net/ixgbe: fix pointer handling in IPsec
      net/i40e: move filter config to flow create
      net/i40e: fix IPv6 GTPU handling
      net/iavf: fix memory leak on egress IPsec flows
      net/iavf: fix memory leak on uninit
      net/iavf: fix IPv4 flow subscription
      net/ice: fix memory leak in DCF QoS bandwidth config
      net/ice: fix memory leak in FDIR flow parsing
      net/iavf: fix struct size in IPsec status get

Anurag Mandal (3):
      app/testpmd: fix function names in logs
      net/i40e: fix QinQ stripping
      net/iavf: fix deletion of primary MAC address

Ashok Kumar Natarajan (5):
      net/axgbe: fix MAC TCR speed select field width
      net/axgbe: add 100 Mbps MAC speed select
      net/axgbe: fix auto-negotiation capabilities
      net/axgbe: fix SGMII auto-negotiation status bits
      net/axgbe: fix 100M SGMII mode

Bruce Richardson (31):
      net/iavf: revert check for PF Rx timestamp support
      rcu: fix build with MSVC
      test/red: fix some undefined behaviour
      test/timer: fix hang on secondary process failure
      buildtools/test: suppress empty output
      eal: fix variable shadowing
      bbdev: fix variable shadowing
      ethdev: fix variable shadowing
      eventdev: fix variable shadowing
      net: fix variable shadowing
      pcapng: fix variable shadowing
      pipeline: fix variable shadowing
      power: fix variable shadowing
      table: fix variable shadowing
      bus/pci: fix variable shadowing
      net/cpfl: fix variable shadowing
      net/e1000: fix variable shadowing
      net/i40e: fix variable shadowing
      net/ice: fix variable shadowing
      net/ixgbe: fix variable shadowing
      app/graph: fix variable shadowing
      app/pdump: fix variable shadowing
      app/testpmd: fix variable shadowing
      config/arm: fix 32-bit build
      hash: fix maybe-uninitialized warnings on build
      net/intel: fix memory leak on Tx queue setup failure
      test: fix dependencies on net null driver
      hash: fix overflow of 32-bit offsets
      test/security: skip inline protocol test if no HW support
      net/bonding: clamp Rx free threshold for small rings
      usertools/pmdinfo: fix search for PMD info string

Chengwen Feng (2):
      net/hns3: fix outer UDP checksum with simple BD
      eal: introduce more macros for bit definition

Ciara Loftus (7):
      doc: fix TSO and checksum offload feature status for ice
      doc: fix TSO feature status for iavf
      doc: fix inline crypto feature status for iavf
      doc: fix TSO feature status for i40e
      net/i40e: validate raw flow items before dereferencing
      doc: remove references to obsolete testpmd flag
      net/i40e: fix raw flow item validation

Congjie Zhou (1):
      eal/linux: fix fbarray name collision in containers

Dariusz Sosnowski (10):
      app/testpmd: fix flow queue job leaks
      net/mlx5: fix flow mark reading after reconfigure
      net/mlx5: fix shared Rx queue limitations
      common/mlx5: fix bonding check
      net/mlx5: fix bonding check
      net/mlx5: fix probing to allow BlueField Socket Direct
      net/mlx5: fix VLAN strip info for CQE compression
      net/mlx5: fix flex item capability check
      common/mlx5: fix error logging for queue modify
      net/mlx5: report share group and queue ID

David Marchand (9):
      bus/ifpga: fix const pointer in device name parsing
      crypto/caam_jr: fix const pointer in UIO filename parsing
      net/enetfec: fix const pointer in UIO filename parsing
      net/memif: fix const pointer in socket check
      app/procinfo: fix const pointer in collectd format
      net/tap: remove log when running without multiprocess
      net/af_xdp: fix external mbuf transmit
      common/mlx5: fix MAC deletion on Linux
      examples/vm_power_manager: fix format specifier for port ID

Emma Finn (1):
      examples/fips_validation: fix dangling pointers

Garvit Varshney (1):
      crypto/cnxk: return decrypted data for RSA verify

Gregory Etelson (3):
      net: fix packet type for stacked VLAN
      net/mlx5: fix MPESW PF probe for any number of ports
      net/mlx5: fix IPv6 SRH flex node header length

Itai Sharoni (1):
      net/mlx5/windows: fix MAC address ownership tracking

Ivan Malov (4):
      common/sfc_efx/base: fix flow control on legacy MCDI
      net/sfc: rework capability check that is done on FEC set
      net/sfc: drop AUTO from FEC capabilities and fix comment
      net/sfc: fix reporting status of autonegotiation

Jacob Keller (1):
      net/iavf: negotiate PTP before reporting Rx timestamping

John McNamara (1):
      net/i40e: fix unused variable

Kai Ji (1):
      crypto/openssl: fix SM2 public key buffer overflow

Kevin Traynor (5):
      eal/linux: handle interrupt epoll events
      interrupts: add interrupt event info
      net/mlx5: check DevX disconnect/error interrupt events
      examples/ipsec-secgw: fix build with glibc 2.43
      examples/vm_power: check truncation of socket path

Liangxing Wang (1):
      app/dma-perf: fix reversed CPU copy

Long Li (14):
      net/netvsc: fix race conditions on VF add/remove events
      net/netvsc: support multi-process VF device removal
      net/mana: fix PD resource leak on device close
      net/netvsc: fix devargs memory leak on hotplug
      net/mana: fix fast-path ops setup in secondary process
      net/mlx5: fix fast-path ops setup in secondary process
      net/mlx4: fix fast-path ops setup in secondary process
      net/netvsc: fix subchannel leak on device removal
      net/netvsc: fix double-free of primary Rx queue on uninit
      net/netvsc: fix resource leak on init failure
      net/netvsc: fix event callback leak on Rx filter failure
      net/netvsc: fix resource leaks on MTU change
      net/mana: fix CQE suppression handling on error completions
      net/netvsc: switch data path to synthetic on device stop

Luca Boccassi (1):
      test/debug: fix IOVA mode on PPC64 without huge pages

Maayan Kashani (1):
      net/mlx5: fix redundant control rules in promiscuous mode

Maciej Paczkowski (1):
      net/ice/base: fix integer types in comparisons

Marat Khalili (6):
      bpf: fix x86 call stack alignment for external calls
      bpf: disallow empty program
      bpf: fix add/subtract overflow
      bpf: fix starting with conditional jump
      bitops: allow variable as first argument of shift macros
      bpf: fix signed shift overflows in ARM JIT

Martin Spinler (5):
      net/nfb: use constant values for max Rx/Tx queues count
      net/nfb: fix bad pointer access in queue stats
      net/nfb: use process private variable for internal
      net/nfb: fix resources release
      net/nfb: stop only started queues in fail path

Maxime Coquelin (3):
      vhost: fix virtqueue array size for control queue
      vhost: fix descriptor chain bounds check in control queue
      vhost: fix mmap error check in VDUSE IOTLB miss handler

Maxime Leroy (8):
      net/dpaa2: warn on Rx descriptor limit in high perf mode
      net/dpaa2: fix resource leak on soft parser failure
      net/dpaa2: fix link after port stop/start
      net/dpaa2: fix spurious VLAN insertion on non-VLAN packet
      net/dpaa2: fix L4 packet type in slow parse path
      net/dpaa2: fix L3/L4 checksum offload flags
      net/dpaa2: fix burst mode info
      net/dpaa2: add SG table walk upper bound in Rx

Morten Brørup (2):
      eal: fix cache guard for pedantic compilation
      mbuf: fix packet data read

Nithinsen Kaithakadan (1):
      test/crypto: fix mbuf segment number

Pavan Nikhilesh (1):
      event/cnxk: fix Rx offload flags

Piotr Krzewinski (1):
      cryptodev: fix memory corruption in secondary process

Radu Nicolau (1):
      pdcp: add digest physical address

Rahul Bhansali (1):
      event/cnxk: fix crash on CN10K

Rakesh Kudurumalla (2):
      common/cnxk: fix engine capabilities fetch logic
      examples/l2fwd-jobstats: fix stats availability

Robin Jarry (3):
      net/iavf: fix reported max Tx and Rx queues
      telemetry: fix adding dict in container array
      hash: avoid leaking entries on RCU defer queue failure

Rongwei Liu (1):
      net/mlx5: fix job leak on indirect meter creation failure

Sergei Iashin (1):
      eventdev/eth_rx: fix crash with telemetry

Shaiq Wani (1):
      net/idpf: fix typo in CQ scan threshold macro name

Shani Peretz (6):
      examples/ethtool: fix size of mempool name
      net/mlx5/hws: fix stack alignment for ASan compatibility
      net/mlx5/hws: fix null dereference in rule skip
      net/mlx5: allow MTU mismatch for running shared queue
      app/testpmd: fix memory leak in port flow configure
      net/mlx5: fix meter ASO action leak on release to pool

Song Yoong Siang (3):
      net/e1000: use device timestamp for clock read in igc
      net/e1000: fix allocation of context desc for launch time
      net/e1000: fix igc launch time calculation

Sriram Yagnaraman (2):
      net/memif: fix descriptor Tx flags corruption
      net/memif: fix multi-segment Rx corruption

Stephen Hemminger (26):
      bus/fslmc: fix const pointer in device name parsing
      common/cnxk: fix array out-of-bounds
      examples/fips_validation: fix RSA memcpy
      net/bnxt: fix build with GCC 16
      test/table: avoid input line overflow
      test/crypto: check for vdev args overflow
      pcapng: document return values
      pcapng: use malloc instead of fixed buffer size
      pcapng: chain additional mbuf when comment exceeds tailroom
      test/pcapng: skip test if null driver missing
      net/mlx5: fix use-after-free in ASO management init
      net/tap: use correct length for interface names
      net/tap: fix resource leaks in secondary process probe
      net/tap: free IPC reply buffer on queue count mismatch
      net/tap: fix use-after-free on remote flow creation failure
      net/tap: free remote flow when implicit rule already exists
      test/pcapng: fix for Windows
      test: add pause to synchronization spinloops
      test/atomic: scale test based on core count
      test/mcslock: scale test based on core count
      test/stack: scale test based on core count
      test/timer: scale test based on core count
      test/timer: replace volatile with C11 atomics
      test: add file-prefix for all fast-tests on Linux
      test/trace: fix parallel execution with traces enabled
      examples/vmdq_dcb: initialize all configuration structures

Talluri Chaitanyababu (1):
      app/testpmd: fix DCB forwarding TC mismatch handling

Thierry Herbelot (1):
      net/intel: update key length when getting RSS key

Thomas Monjalon (4):
      common/mlx5: fix variable shadowing
      net/mvpp2: fix variable shadowing
      eal/x86: fix TSC frequency query
      examples/ethtool: fix error message about ports limit

Venkatesh Vemula (1):
      net/intel: fix comma operator warnings

Viacheslav Ovsiienko (2):
      net/mlx5: fix flex parser creation length attribute
      net/mlx5: fix send skew settings when using wait on time

Vipin Varghese (1):
      app/dma-perf: fix buffer overflow with high core count

Vladimir Medvedkin (1):
      fib: fix prefix addition handling

Xavier Guillaume (1):
      net/af_packet: fix MTU set data size calculation

Xiaoyu Min (1):
      net/mlx5: fix HW flow counter query

Yang Xu (1):
      net/mlx5: fix port down in link detection failure

Yunjian Wang (1):
      net/mlx5: fix memory leak after device spawn failure
