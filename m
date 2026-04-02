Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32ACD6AAF2
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:45:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0864C4028F;
	Thu,  2 Apr 2026 18:45:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2A5E54028E
 for <dev@dpdk.org>; Thu,  2 Apr 2026 18:45:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775148313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m8BpYKvVYhuJ0Vi2LDfFyQmjBj3hiTixz714tCwUBzA=;
 b=cWDWXRTNVTVKnSvSM85s8GAmM9OlwSCxUI0L7DzwvC6uo9pkTMBhoAFUdkJmu9swo+pT7r
 Rro8/TUiv/8HiQMeNA4Z8adl4BA9+AWRSUcw24btKqI8FuhfSxDIsnR0Pm0RWWhdkAVXW1
 XwrfLOUrL8HSi+/Q+TSoNDXhOz5+5jc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-kj3Ks9bXPkKeccKCjyjGpQ-1; Thu,
 02 Apr 2026 12:45:10 -0400
X-MC-Unique: kj3Ks9bXPkKeccKCjyjGpQ-1
X-Mimecast-MFC-AGG-ID: kj3Ks9bXPkKeccKCjyjGpQ_1775148308
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E74A01800365; Thu,  2 Apr 2026 16:45:07 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCDA530030D5; Thu,  2 Apr 2026 16:45:00 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, benjamin.walker@intel.com,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 qian.q.xu@intel.com, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com,
 Shani Peretz <shperetz@nvidia.com>
Subject: 25.11.1 patches review and test
Date: Thu,  2 Apr 2026 17:44:52 +0100
Message-ID: <20260402164454.669125-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TJn9Wf1ULtmAXPJvM92cGe_OL7cntU9Etux_Mew2T3I_1775148308
X-Mimecast-Originator: redhat.com
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

Here is a list of patches targeted for stable release 25.11.1.

The planned date for the final release is 21st April 2026.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.1-rc1

These patches are located at branch 25.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Kevin

---
Aarnav JP (2):
      examples/packet_ordering: fix format specifier for port ID
      examples/ptpclient: fix format specifier for port ID

Ajit Khaparde (1):
      net/bnxt: support statistics query when port is stopped

Anatoly Burakov (13):
      net/ixgbe: add missing E610 MAC type checks
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

Andrew Bailey (4):
      dts: show missing NIC capabilities in logs
      dts: fix doc for RSS test suite
      dts: fix doc for QinQ test suite
      dts: reduce digit count in single core forwarding metrics

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

Bing Zhao (2):
      net/mlx5: fix counters resource leak
      net/mlx5: fix NAT64 HW registers calculation

Bruce Richardson (33):
      rcu: fix build with MSVC
      net/ice/base: disable MSVC warning
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
      dma/idxd: mark portal pointer as volatile
      test: fix dependencies on net null driver
      hash: fix overflow of 32-bit offsets
      test/security: skip inline protocol test if no HW support
      net/bonding: clamp Rx free threshold for small rings
      usertools/pmdinfo: fix search for PMD info string
      net/ice/base: fix double HW reinitialization

Chengwen Feng (2):
      net/hns3: fix outer UDP checksum with simple BD
      app/testpmd: check start for DCB forwarding TC commands

Ciara Loftus (15):
      doc: fix TSO and checksum offload feature status for ice
      doc: fix TSO feature status for iavf
      doc: fix inline crypto feature status for iavf
      doc: fix TSO feature status for i40e
      net/intel: prevent selection of a null Rx burst function
      net/ice: check null scheduler root node
      net/ice: fix priority mode printing in Tx scheduler dump
      net/ice: re-enable strict priority on non-root levels
      net/i40e: fix secondary process Rx path selection
      net/iavf: fix secondary process Rx path selection
      net/ice: fix secondary process Rx path selection
      net/iavf: fix order of tags for AVX512 Tx QinQ offload
      net/i40e: validate raw flow items before dereferencing
      doc: remove references to obsolete testpmd flag
      net/i40e: fix raw flow item validation

Congjie Zhou (1):
      eal/linux: fix fbarray name collision in containers

Dariusz Sosnowski (13):
      app/testpmd: fix flow queue job leaks
      net/mlx5: fix default memzone requirements in HWS
      net/mlx5: fix flow mark reading after reconfigure
      net/mlx5: fix shared Rx queue limitations
      common/mlx5: fix bonding check
      net/mlx5: fix bonding check
      net/mlx5: fix probing to allow BlueField Socket Direct
      net/mlx5: fix default flow engine on Windows
      net/mlx5: fix VXLAN and NVGRE encap in async flow API
      net/mlx5: fix VLAN strip info for CQE compression
      net/mlx5: fix flex item capability check
      common/mlx5: fix error logging for queue modify
      net/mlx5: report share group and queue ID

David Marchand (5):
      net/tap: remove log when running without multiprocess
      net/af_xdp: fix external mbuf transmit
      eal/linux: fix HPET symbols export
      common/mlx5: fix MAC deletion on Linux
      examples/vm_power_manager: fix format specifier for port ID

Dean Marx (1):
      dts: fix docstring typo in dynamic queue suite

Dimon Zhao (10):
      net/nbl: fix integer overflow
      net/nbl: fix null pointer dereference
      net/nbl: check ioctl returns
      net/nbl: fix memzone leak on queue release
      net/nbl: fix mbuf headroom usage in packet Tx
      net/nbl: fix mbuf double-free in queue cleanup
      net/nbl: improve mailbox exception handling
      net/nbl: fix hardware stats interrupt nesting
      net/nbl: checks for unsupported UIO drivers
      net/nbl: fix queue stats on restart

Emma Finn (1):
      examples/fips_validation: fix dangling pointers

Garvit Varshney (1):
      crypto/cnxk: return decrypted data for RSA verify

Gregory Etelson (6):
      net: fix packet type for stacked VLAN
      net/mlx5: fix MPESW PF probe for any number of ports
      net/mlx5: fix flow metadata between E-Switch and VM
      net/mlx5: fix flow metadata sharing with E-Switch and VM
      net/mlx5: fix IPv6 SRH flex node header length
      net/mlx5: fix IPv6 SRH flex parser initialization

Grzegorz Nitka (1):
      net/ice/base: fix adjust timer programming for E830

Hailin Xu (1):
      doc: fix E830 recommended firmware in ice guide

Howard Wang (4):
      net/r8169: fix crash in RTL8168FP init
      net/r8169: fix RTL8168KB speed classification
      net/r8169: ensure old mapping is used
      net/r8169: fix bitmask logic for RTL8127

Itai Sharoni (1):
      net/mlx5/windows: fix MAC address ownership tracking

Ivan Malov (7):
      common/sfc_efx/base: fix flow control on legacy MCDI
      common/sfc_efx/base: fix indication of requestable FEC flags
      common/sfc_efx/base: define mask for pause mode capabilities
      net/sfc: avoid speed reset when setting FEC in started state
      net/sfc: rework capability check that is done on FEC set
      net/sfc: drop AUTO from FEC capabilities and fix comment
      net/sfc: fix reporting status of autonegotiation

Jacob Keller (1):
      net/iavf: negotiate PTP before reporting Rx timestamping

John McNamara (1):
      net/i40e: fix unused variable

Junfeng Guo (1):
      net/mlx5: fix IP tunnel detection with HWS

Kai Ji (1):
      crypto/openssl: fix SM2 public key buffer overflow

Keegan Freyhof (2):
      net/bnxt: fix commas instead of semicolons
      net/bnxt: fix reported VLAN stripped flag for Thor2

Kevin Traynor (8):
      examples/vm_power: fix format-truncation warning
      eal/linux: handle interrupt epoll events
      interrupts: add interrupt event info
      net/mlx5: check DevX disconnect/error interrupt events
      vhost: fix resource leak on driver registration failure
      net/bnxt: fix uninitialized read
      app/testpmd: fix FD leak in mbuf history command parsing
      examples/ipsec-secgw: fix build with glibc 2.43

Kishore Padmanabha (1):
      net/bnxt: fix statistics for high number of queues

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

Lukas Sismis (1):
      dts: fix doc generation for testpmd shell

Maayan Kashani (3):
      net/mlx5: fix flow devargs handling for future HW
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

Maxime Leroy (14):
      net/dpaa2: fix queue block memory leak on port close
      net/dpaa2: fix Rx error queue memory leaks
      net/dpaa2: warn on Rx descriptor limit in high perf mode
      net/dpaa2: fix resource leak on soft parser failure
      net/dpaa2: fix link after port stop/start
      bus/fslmc: fix devargs not propagated on hotplug
      net/dpaa2: fix spurious VLAN insertion on non-VLAN packet
      net/dpaa2: fix error packet dump
      net/dpaa2: fix L4 packet type in slow parse path
      net/dpaa2: fix L3/L4 checksum offload flags
      net/dpaa2: fix software taildrop buffer access
      net/dpaa2: fix burst mode info
      net/dpaa2: add SG table walk upper bound in Rx
      net/dpaa2: fix MAC stats DMA alloc per xstats call

Morten Brørup (3):
      ethdev: fix mbuf fast release requirements description
      eal: fix cache guard for pedantic compilation
      mbuf: fix packet data read

Nawal Kishor (1):
      common/cnxk: fix width of DPC set field

Nithinsen Kaithakadan (2):
      test/crypto: fix mbuf segment number
      test/crypto: fix RSA sign data length

Patrick Robb (3):
      dts: sniff only inbound packets
      dts: fix test suite filtering
      dts: avoid resources conflict on quick stop/start

Piotr Krzewinski (1):
      cryptodev: fix memory corruption in secondary process

Radu Nicolau (3):
      pdcp: add digest physical address
      crypto/qat: align vector address
      hash: fix unaligned access for CRC

Rahul Bhansali (4):
      net/cnxk: fix security flag for custom inbound SA
      common/cnxk: fix duplicated branches
      common/cnxk: fix CPT CQ roll over handling
      event/cnxk: fix crash on CN10K

Rakesh Kudurumalla (2):
      common/cnxk: fix engine capabilities fetch logic
      examples/l2fwd-jobstats: fix stats availability

Riley Fletcher (1):
      doc: add IBM Power 10 testing to 25.11 release notes

Robin Jarry (4):
      net/iavf: fix reported max Tx and Rx queues
      telemetry: fix adding dict in container array
      hash: avoid leaking entries on RCU defer queue failure
      hash: free replaced data on overwrite when RCU is configured

Rongwei Liu (1):
      net/mlx5: fix job leak on indirect meter creation failure

Sameer Vaze (1):
      compress/zlib: fix UDC checksum

Scott Mitchell (1):
      eal: fix annotation on lcore variable allocator

Sergei Iashin (1):
      eventdev/eth_rx: fix crash with telemetry

Shaiq Wani (1):
      net/idpf: fix typo in CQ scan threshold macro name

Shani Peretz (10):
      examples/ethtool: fix size of mempool name
      app/testpmd: fix memory leak in port attach
      net/mlx5/hws: fix stack alignment for ASan compatibility
      net/mlx5/hws: fix null dereference in rule skip
      net/mlx5: allow MTU mismatch for running shared queue
      vhost: fix use-after-free race during cleanup
      app/testpmd: fix memory leak in port flow configure
      config/arm: drop crypto extension from Cortex-A78AE
      net/mlx5: fix meter ASO action leak on release to pool
      net/mlx5: fix heap buffer overflow in sample group match

Song Yoong Siang (3):
      net/e1000: use device timestamp for clock read in igc
      net/e1000: fix allocation of context desc for launch time
      net/e1000: fix igc launch time calculation

Sriram Yagnaraman (2):
      net/memif: fix descriptor Tx flags corruption
      net/memif: fix multi-segment Rx corruption

Stephen Hemminger (40):
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
      common/cnxk: remove VLA in interrupt configuration
      common/cnxk: fix buffer overflow in SA setup
      net/mlx5: fix build with LTO
      net/bnxt: remove unbuilt source files
      net/mlx5: fix null dereference in Tx queue start
      net/mlx5: fix counter leak in hairpin queue setup
      net/mlx5: fix use-after-free in ASO management init
      net/mlx5: fix counter truncation in queue counter read
      net/tap: fix handling of queue stats
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
      test/bpf: fix error handling in ELF load tests
      test/bpf: fix unsupported instructions in ELF load test
      test/bpf: fix payload size for Rx/Tx load tests
      examples/vmdq_dcb: initialize all configuration structures
      test/memcpy: reduce alignment offset coverage
      test/latency: relax check on zero latency

Sunyang Wu (1):
      doc: add --query-rate option in flow-perf guide

Talluri Chaitanyababu (1):
      app/testpmd: fix DCB forwarding TC mismatch handling

Tejasree Kondoj (1):
      common/cnxk: fix cipher key length validation

Thierry Herbelot (1):
      net/intel: update key length when getting RSS key

Thomas Monjalon (7):
      common/mlx5: fix variable shadowing
      net/mvpp2: fix variable shadowing
      eal/x86: fix TSC frequency query
      net/bnxt/tf_ulp: fix minsize build
      ci: fix debug build type
      examples/ethtool: fix error message about ports limit
      mem: check fbarray name truncation in secondary process

Venkatesh Vemula (1):
      net/intel: fix comma operator warnings

Viacheslav Ovsiienko (2):
      net/mlx5: fix flex parser creation length attribute
      net/mlx5: fix send skew settings when using wait on time

Vipin Varghese (2):
      app/dma-perf: fix buffer overflow with high core count
      doc: update AMD EPYC guide

Vladimir Medvedkin (2):
      fib: fix prefix addition handling
      net/ice: fix RSS LUT access when using global LUT

Xavier Guillaume (2):
      net/af_packet: fix MTU set data size calculation
      net/af_packet: fix receive buffer overflow

Xiaoyu Min (1):
      net/mlx5: fix HW flow counter query

Yang Xu (1):
      net/mlx5: fix port down in link detection failure

Yehor Malikov (1):
      vhost: fix use-after-free fdset during shutdown

Yunjian Wang (1):
      net/mlx5: fix memory leak after device spawn failure

Zhanibek Bakin (1):
      net/null: fix Tx statistics accumulation

