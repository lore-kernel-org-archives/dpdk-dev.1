Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66798E88D97
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Apr 2026 09:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BE4440287;
	Sat,  4 Apr 2026 11:59:11 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0824A40281
 for <dev@dpdk.org>; Sat,  4 Apr 2026 11:59:10 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so22333495e9.0
 for <dev@dpdk.org>; Sat, 04 Apr 2026 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775296749; x=1775901549; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X5rr+HKxZ7vTuKpTDy/oZLvgu/8vqSzLteDbpGaZUu4=;
 b=XYYXxwyKxl9xCPclTgxoPRSYdcvGpLfHNhQf6l8xeShIjmg4QJPIqVEzAEYZ4AhvCq
 vEV03hoYGzQ67Rk8qTBKewLwkcxzJMJnP8q1iZuPA2UqnoL7LRvtqXPME0mrkHrOz5IA
 bA+wL7jXiWawFJ+Zh2Rg7G8ZVg5M/o8Il7y4oFQ0gC8vhHTMHmFXyhiOza0VvxaLrWeF
 LxkQldO+0Gqkpfv6lPJ4LIn6KLUthIB33fpJmOxWvWZJbFdCAbYaVpOZXfRgMItb1bIO
 bCofpUGSKFM2hHWL1mPPeZT0W7Fa2IDf+7unS9RvnEe/nQOAsew1A7eyOcn3HESvByyk
 9v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775296749; x=1775901549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5rr+HKxZ7vTuKpTDy/oZLvgu/8vqSzLteDbpGaZUu4=;
 b=hCjl8MxgaAoroiTPjjrnZ15MqaS8BYMK+5AEN3Y7pQnaii1U5d7eFcBg5xyabAC7p6
 al4ntwf3ZdnRngSEvQmCCyhXZ9hQndQAxKSZwTXshm3j0Y0upY8o7e2tcopkhyzHTGUf
 lHoo/AckD2/R656DENk9+o+SdpEJjFFj2FVoez9CWuZFkC7pzqVzM5gvCvg9niNZeNAA
 yVRdTkaAPHU/EPwACb5ocOZteWmz8gJ4odxxY9AQV1Mhn/1uzYEbQyQ6VkGtTmnYE+y+
 JhP1mWJAIeuTPzqSe4FbiOT/OOupF22P2pSBGwlaotsbOSkNattQq4nCMkYlpxKTd3sS
 n51A==
X-Gm-Message-State: AOJu0YxIv5iZmrJvaPzTMQ8mti+WCrcUTmSCRJv93YvXMasWVZMIQF7p
 GTjDuWCp2gILHbrcvkCXr/5cXViKS65e62kCORFNFxvPb/PBXVmWZOFD
X-Gm-Gg: AeBDiev35x9HRdtvuflGFYLLF/HJutwdRtJisQkowCy49VoIHqNu+kmzdxVNq6cmSgt
 kuPhbwM1g+mZJS8B7HXZF94DDmtFLkDLiPlhiUPTWzBkCm5m4mRSoDt7FoAQHvL3kgUcvvfGYjV
 aG6FHbNPgnx2H1kef4fWqdNtcmEhw3FfSSOfC0+rbpppKZ/ca8ABqkLrpjihQDXu98pNJS9Sej6
 z1SOoLaghqfT+kqugN9rxcv59rdOYTa7X2/sCxTBJfDXjEiae05DguSNQO4kTkVyahfXE0DqBWx
 MSS7x0NH6KAx6EE4opVUV6t0lh+wy6Z3W8EgrCLdiUH74xjgv1VIqfHZ7EpSmY/bnPOdIos1Eg6
 epWQ/ovSRqBhIoWUyOcl7YcFmfnJbELuEMU6TlK3wtlQPlq5cTevVVwUPwnSOywa6cN5V5Yo6kM
 9ZLBTMq1w4+aS+gDI5f0WxKicgnQCR
X-Received: by 2002:a05:600c:818c:b0:488:7784:d06 with SMTP id
 5b1f17b1804b1-488997dcc53mr84991995e9.31.1775296749081; 
 Sat, 04 Apr 2026 02:59:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:1f2e:569b:1ad5:1bd6])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4887e80a63esm428793025e9.3.2026.04.04.02.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 02:59:08 -0700 (PDT)
From: luca.boccassi@gmail.com
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
Subject: 24.11.5 patches review and test
Date: Sat,  4 Apr 2026 10:58:59 +0100
Message-ID: <20260404095902.856502-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Here is a list of patches targeted for stable release 24.11.5.

The planned date for the final release is April 16th.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.5-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Aarnav JP (2):
      examples/packet_ordering: fix format specifier for port ID
      examples/ptpclient: fix format specifier for port ID

Ajit Khaparde (1):
      net/bnxt: support statistics query when port is stopped

Anatoly Burakov (12):
      net/ixgbe: add missing E610 MAC type checks
      net/ixgbe: fix memory leak in security flows
      net/ixgbe: fix potential null dereference with IPsec config
      net/ixgbe: fix potential null dereference in IPsec flow
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
      net/axgbe: fix 100M SGMII mode
      net/axgbe: fix MAC TCR speed select field width
      net/axgbe: add 100 Mbps MAC speed select
      net/axgbe: fix auto-negotiation capabilities
      net/axgbe: fix SGMII auto-negotiation status bits

Bing Zhao (1):
      net/mlx5: fix NAT64 HW registers calculation

Bruce Richardson (30):
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

Chengwen Feng (1):
      net/hns3: fix outer UDP checksum with simple BD

Ciara Loftus (10):
      doc: fix TSO and checksum offload feature status for ice
      doc: fix TSO feature status for iavf
      doc: fix inline crypto feature status for iavf
      doc: fix TSO feature status for i40e
      net/ice: check null scheduler root node
      net/ice: fix priority mode printing in Tx scheduler dump
      net/ice: re-enable strict priority on non-root levels
      net/i40e: validate raw flow items before dereferencing
      doc: remove references to obsolete testpmd flag
      net/i40e: fix raw flow item validation

Congjie Zhou (1):
      eal/linux: fix fbarray name collision in containers

Dariusz Sosnowski (12):
      app/testpmd: fix flow queue job leaks
      net/mlx5: fix default memzone requirements in HWS
      net/mlx5: fix flow mark reading after reconfigure
      net/mlx5: fix shared Rx queue limitations
      common/mlx5: fix bonding check
      net/mlx5: fix bonding check
      net/mlx5: fix probing to allow BlueField Socket Direct
      net/mlx5: fix VXLAN and NVGRE encap in async flow API
      net/mlx5: fix VLAN strip info for CQE compression
      net/mlx5: fix flex item capability check
      common/mlx5: fix error logging for queue modify
      net/mlx5: report share group and queue ID

David Marchand (4):
      net/tap: remove log when running without multiprocess
      net/af_xdp: fix external mbuf transmit
      common/mlx5: fix MAC deletion on Linux
      examples/vm_power_manager: fix format specifier for port ID

Emma Finn (1):
      examples/fips_validation: fix dangling pointers

Garvit Varshney (1):
      crypto/cnxk: return decrypted data for RSA verify

Gregory Etelson (4):
      net: fix packet type for stacked VLAN
      net/mlx5: fix MPESW PF probe for any number of ports
      net/mlx5: fix IPv6 SRH flex node header length
      net/mlx5: fix IPv6 SRH flex parser initialization

Grzegorz Nitka (1):
      net/ice/base: fix adjust timer programming for E830

Howard Wang (1):
      net/r8169: ensure old mapping is used

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

Keegan Freyhof (2):
      net/bnxt: fix commas instead of semicolons
      net/bnxt: fix reported VLAN stripped flag for Thor2

Kevin Traynor (6):
      eal/linux: handle interrupt epoll events
      interrupts: add interrupt event info
      net/mlx5: check DevX disconnect/error interrupt events
      net/bnxt: fix uninitialized read
      examples/ipsec-secgw: fix build with glibc 2.43
      examples/vm_power: check truncation of socket path

Liangxing Wang (1):
      app/dma-perf: fix reversed CPU copy

Long Li (14):
      net/netvsc: fix race conditions on VF add/remove events
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
      net/netvsc: support multi-process VF device removal
      net/mana: fix CQE suppression handling on error completions
      net/netvsc: switch data path to synthetic on device stop

Maayan Kashani (2):
      net/mlx5: fix internal HWS pattern template creation
      net/mlx5: fix redundant control rules in promiscuous mode

Maciej Paczkowski (1):
      net/ice/base: fix integer types in comparisons

Manish Kurup (1):
      net/bnxt: fix crash in HWRM capabilities query

Marat Khalili (6):
      bpf: fix x86 call stack alignment for external calls
      bitops: allow variable as first argument of shift macros
      bpf: fix signed shift overflows in ARM JIT
      bpf: disallow empty program
      bpf: fix add/subtract overflow
      bpf: fix starting with conditional jump

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

Maxime Leroy (10):
      net/dpaa2: warn on Rx descriptor limit in high perf mode
      net/dpaa2: fix resource leak on soft parser failure
      net/dpaa2: fix link after port stop/start
      net/dpaa2: fix spurious VLAN insertion on non-VLAN packet
      net/dpaa2: fix error packet dump
      net/dpaa2: fix L4 packet type in slow parse path
      net/dpaa2: fix L3/L4 checksum offload flags
      net/dpaa2: fix software taildrop buffer access
      net/dpaa2: fix burst mode info
      net/dpaa2: add SG table walk upper bound in Rx

Morten Brørup (3):
      mbuf: fix packet copy
      eal: fix cache guard for pedantic compilation
      mbuf: fix packet data read

Nawal Kishor (1):
      common/cnxk: fix width of DPC set field

Nithinsen Kaithakadan (1):
      test/crypto: fix mbuf segment number

Piotr Krzewinski (1):
      cryptodev: fix memory corruption in secondary process

Radu Nicolau (3):
      pdcp: add digest physical address
      crypto/qat: align vector address
      hash: fix unaligned access for CRC

Rahul Bhansali (1):
      event/cnxk: fix crash on CN10K

Rakesh Kudurumalla (2):
      common/cnxk: fix engine capabilities fetch logic
      examples/l2fwd-jobstats: fix stats availability

Robin Jarry (4):
      net/iavf: fix reported max Tx and Rx queues
      telemetry: fix adding dict in container array
      hash: avoid leaking entries on RCU defer queue failure
      hash: free replaced data on overwrite when RCU is configured

Rongwei Liu (1):
      net/mlx5: fix job leak on indirect meter creation failure

Scott Mitchell (1):
      eal: fix annotation on lcore variable allocator

Sergei Iashin (1):
      eventdev/eth_rx: fix crash with telemetry

Shaiq Wani (1):
      net/idpf: fix typo in CQ scan threshold macro name

Shani Peretz (7):
      examples/ethtool: fix size of mempool name
      net/mlx5/hws: fix stack alignment for ASan compatibility
      net/mlx5/hws: fix null dereference in rule skip
      net/mlx5: allow MTU mismatch for running shared queue
      vhost: fix use-after-free race during cleanup
      app/testpmd: fix memory leak in port flow configure
      net/mlx5: fix meter ASO action leak on release to pool

Song Yoong Siang (2):
      net/e1000: use device timestamp for clock read in igc
      net/e1000: fix allocation of context desc for launch time

Sriram Yagnaraman (2):
      net/memif: fix descriptor Tx flags corruption
      net/memif: fix multi-segment Rx corruption

Stephen Hemminger (29):
      common/cnxk: fix array out-of-bounds
      examples/fips_validation: fix RSA memcpy
      net/bnxt: fix build with GCC 16
      test/table: avoid input line overflow
      test/cfgfile: avoid temp filename truncation
      test/crypto: check for vdev args overflow
      pcapng: document return values
      pcapng: use malloc instead of fixed buffer size
      pcapng: chain additional mbuf when comment exceeds tailroom
      test/pcapng: skip test if null driver missing
      net/mlx5: fix build with LTO
      net/bnxt: remove unbuilt source files
      net/mlx5: fix use-after-free in ASO management init
      net/tap: use correct length for interface names
      net/tap: fix resource leaks on creation failure
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
      test/memcpy: reduce alignment offset coverage

Talluri Chaitanyababu (1):
      app/testpmd: fix DCB forwarding TC mismatch handling

Thierry Herbelot (1):
      net/intel: update key length when getting RSS key

Thomas Monjalon (6):
      common/mlx5: fix variable shadowing
      net/mvpp2: fix variable shadowing
      eal/x86: fix TSC frequency query
      net/bnxt/tf_ulp: fix minsize build
      mem: check fbarray name truncation in secondary process
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

Yehor Malikov (1):
      vhost: fix use-after-free fdset during shutdown

Yunjian Wang (1):
      net/mlx5: fix memory leak after device spawn failure
