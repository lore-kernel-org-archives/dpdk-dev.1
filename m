Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06940C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 09:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0087640615;
	Thu,  6 Aug 2026 11:39:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 61095402BB
 for <dev@dpdk.org>; Thu,  6 Aug 2026 11:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786009150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w1hKfQcsvg2IXEyDP9UvjWvMk2pYGyc2I2lsK0ezAx4=;
 b=f6+dPNizi6NXf7D9zJiJTWdu6D1Bu1cxXN/V5Gox2mr+cNVe7E5luftF4MhSrxnp0JGSEx
 7MJxq21mhWYeBMMCLzRBSjz4qj7N/ddlQcaCrUty2whg7drvpHkgIBnBAo97W7272uoEaA
 2qANpyJFAifFPPIIEXWeG4NO75aflIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-mXVxvnNrPW6NN3rTcuUp4w-1; Thu,
 06 Aug 2026 05:39:07 -0400
X-MC-Unique: mXVxvnNrPW6NN3rTcuUp4w-1
X-Mimecast-MFC-AGG-ID: mXVxvnNrPW6NN3rTcuUp4w_1786009145
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A60D1956049; Thu,  6 Aug 2026 09:39:05 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.48.14])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D11B427; Thu,  6 Aug 2026 09:38:59 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Raslan Darawsheh <rasland@nvidia.com>,
 Shani Peretz <shperetz@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: 25.11.3 patches review and test
Date: Thu,  6 Aug 2026 10:38:49 +0100
Message-ID: <20260806093851.498711-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: giGRb_aAa_bplrpHXEto2Z6oZrRkkxN1cmEg6d_oN04_1786009145
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

Here is a list of patches targeted for stable release 25.11.3.

The planned date for the final release is 20th August.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.3-rc2

These patches are located at branch 25.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Kevin

---
Aarnav JP (8):
      test/security: sync inline IPsec soft expiry check
      net/cnxk: fix underflow in LSO calculation
      net/cnxk: fix bitwise operand size mismatch in link mode
      common/cnxk: add cipher key length check in key set
      common/cnxk: fix static analysis issues
      common/cnxk: add auth key length check in inbound SA
      event/cnxk: fix static analysis issues
      crypto/cnxk: enforce DES/3DES cipher key length

Ajit Khaparde (4):
      net/bnxt: modify check for short Tx BD
      net/bnxt: fix QP resource count in backing store config
      net/bnxt: fix Tx address for external mbuf
      net/bnxt: avoid null Rx queue dereference

Alexey Simakov (2):
      net/enic: fix null dereference in flow mask check
      net/nfp: fix shifts in BAR size calculation

Alok Mishra (1):
      common/cnxk: fix xstats names query

Anatoly Burakov (14):
      net/ixgbe: fix flows not being scoped to port
      net/ixgbe: fix shared PF pointer in representor
      net/ixgbe: fix non-shared data in IPsec session
      net/ixgbe: fix SCTP protocol-only flow parsing
      net/ixgbe: fix L4 protocol mask handling
      net/ixgbe: reset flow state on clear paths
      ipc: fix log message in async request
      ipc: use request ID instead of pointers
      ipc: avoid deadlock in async alarm callback
      ipc: fix memory leaks on async request partial failure
      ipc: fix memory leak in async secondary path
      ipc: trigger async callback without peers
      app/testpmd: mask VLAN TCI in flow rule
      app/testpmd: mask VLAN inner type in flow rule

Andrew Bailey (2):
      dts: add retry loop to TRex traffic generation
      dts: resolve variance in performance reporting

Anurag Mandal (3):
      net/iavf: fix misleading admin queue failure logging
      net/iavf: fix duplicate VF reset during PF reset recovery
      net/iavf: fix race condition on link status change

Bing Zhao (1):
      net/mlx5: fix eCPRI match on HWS root table

Borys Tsyrulnikov (1):
      net/mlx5: fix double free in vectorized Rx recovery

Bruce Richardson (18):
      test: fix failing tests on FreeBSD
      cmdline: harden parser result buffer handling
      cmdline: guard zero-size destination buffers
      eal/freebsd: fix memseg addresses in VA mode
      test/security: remove fast-free Tx flag
      test/security: fix MTU calculation underflow
      test/security: check for capabilities
      net/intel: fix use of non-recommended string functions
      examples: use strlcpy and strlcat
      net/iavf: fix local memory leaks in TM hierarchy commit
      net/iavf: fix leak of queue to traffic class mapping data
      net/iavf: fix memory leak on error when adding flow parser
      net/ice: fix buffer leak in config of Tx queue TM node
      net/iavf: fix leak of flex metadata extraction field
      net/iavf: fix leak of IPsec crypto capabilities array
      app: remove use of strncpy
      test/eal: remove PCI probing for recursive calls
      cfgfile: prevent overflow on resize

Chenna Arnoori (2):
      net/bnxt: avoid link flap when setting flow control
      net/bnxt: fix Rx timestamping for non-PTP packets

Chinh Cao (1):
      net/i40e/base: fix integer overflow in NVM timing logic

Ciara Loftus (17):
      net/i40e: fix simple Tx prepare rejecting tunnel type flags
      net/i40e: fix VLAN flow mask validation
      net/iavf: fix disabling of promiscuous modes on close
      net/iavf: fix reset handling error log
      net/ice: fix shaper profile reference count tracking
      net/ice: fix TM node ID validation against configured queues
      net/i40e: fix blocking link wait on device start
      net/iavf: wait for PF reset start before reinitializing
      net/iavf: fix event handler refcount leak on HW reset
      net/iavf: reject oversized frames in prep callback
      net/iavf: fix scalar Rx path zero-length segment
      net/ice: fix Rx packets statistics underflow
      net/ice: fix DCF Rx packets statistics underflow
      net/iavf: fix Rx packets statistics underflow
      net/i40e: activate alarm if interrupt delivery unavailable
      net/ice: fix adapter stopped on device start failure
      net/iavf: report selected burst mode when no-poll active

Dakota Sicher (1):
      net/bnxt: skip timed Tx pacing setup when unsupported

Damodharam Ammepalli (1):
      net/bnxt: fix LRO capability reporting

Daniil Iskhakov (7):
      net/i40e: validate DDP segment header before use
      net/ixgbe: fix queue received bytes CRC adjustment
      net/ixgbe: fix good octets CRC adjustment
      net/ixgbe: fix flow control frame byte adjustment
      net/ixgbe: fix MAC/VLAN item validation for ntuple
      cryptodev: reset pointer after failure in callback init
      cmdline: prevent out-of-bounds read

Daphne Priscilla (1):
      crypto/cnxk: fix out-of-place AES-GCM

Dariusz Sosnowski (3):
      net/mlx5: fix skipping PF representors
      net/mlx5: use port index as representor index
      net/mlx5: redirect LACP traffic for legacy E-Switch

David Marchand (8):
      bus/fslmc: fix bus cleanup
      pipeline: fix build with sanitizers or debug options
      ci: update versions of actions in GHA
      bus/ifpga: remove unused AFU lookup helper
      vdpa/nfp: fix double PCI unmap on unplug
      bus/pci: fix mapping leak in bus cleanup
      bus/vmbus: fix interrupt leak in cleanup
      test/eal: remove PCI probing for vdev tests

Deepthi Kavalur (1):
      net/i40e/base: fix loop counter width in DCB parsing

Denis Lyulin (1):
      ethdev: fix pointer check in GENEVE and raw flow copy

Denis Sergeev (5):
      net/nfp: fix null dereference in flower ctrl NFD3 Tx
      net/ark: fix null dereference on allocation failure
      net/ark: use standard IPv4 address parser
      power: fix off-by-one in uncore env bounds check
      net/bnxt/tf_core: check pool use allocation

Dima Ruinskiy (2):
      net/e1000/base: fix style
      net/e1000/base: propagate PHY control register write error

Dimon Zhao (1):
      net/nbl: fix multicast reception in promiscuous mode

Gagandeep Singh (5):
      net/enetc: fix Tx BD structure
      net/enetc: fix queue initialization
      bus/dpaa: fix probing on LS1043A
      net/dpaa: fix interrupt unregister
      net/dpaa: fix device remove

Gena Tertychnyi (1):
      eal/windows: fix core count for more cores per NUMA

Gowrishankar Muthukrishnan (3):
      cryptodev: add missing asym xform names
      test/crypto: validate ML crypto keys
      test/crypto: fix prehash in ML-DSA session

Hemant Agrawal (11):
      bus/dpaa: fix FQ creation failure handling
      bus/dpaa: fix FQID endianness
      bus/dpaa: fix FQ query failure handling
      net/dpaa: fix CGR modification
      bus/dpaa: fix FD leak for CCSR mmap
      net/dpaa: fix xstats name for Tx undersized counter
      net/dpaa: fix BMI xstats names
      net/dpaa: remove duplicate packet types
      net/dpaa: fix BMI xstats by ID
      net/dpaa: fix checksum offload with empty L3 length
      net/dpaa: fix mbuf leak in SG FD creation

Howard Wang (1):
      net/r8169: fix crash during RTL8168 init

Huisong Li (3):
      power: remove duplicate uncore set frequency typedef
      power: validate enabled lcores in PMD management API
      examples/l3fwd-power: fix latency query failure handling

James Raphael Tiovalen (2):
      ethdev: fix out-of-bounds write in GENEVE option conversion
      ethdev: fix out-of-bounds write in flex item conversion

Jasper Tran O'Leary (1):
      net/gve: fix comma operator misuses

Joshua Washington (9):
      net/gve: clear out shared memory region for statistics
      net/gve: delay adding mbuf head to software ring
      net/gve: copy data to QPL buffer when mbuf read does not
      net/gve: validate buffer ID before processing Rx packet
      net/gve: set mbuf to null in software ring after use
      net/gve: free context mbuf on later segment drop
      net/gve: increase range of DMA memzone IDs to 64 bits
      net/gve: preserve ring size bounds on reset
      net/gve: restrict max ring size in GQ QPL to 2K

Jun Yang (1):
      bus/dpaa: fix BMI Rx statistics

Kalesh AP (3):
      net/bnxt: support PTP on Wh+ using HWRM interface
      net/bnxt: support Rx/Tx timestamp on Wh+ using HWRM
      net/bnxt: support PTP for Thor2

Kavya AV (2):
      app/testpmd: fix DCB queue allocation for VMDq devices
      net/ice: use configured outer TPID for VLAN filter in DVM

Keegan Freyhof (2):
      net/bnxt: fix NQ/CQ processing for interrupt handling
      net/bnxt: clear stale Tx descriptor count

Kevin Traynor (1):
      version: 25.11.3-rc1

Kiran Vedere (1):
      net/mlx5: fix uninitialized skip count

Linhu Li (1):
      net/mlx5: fix flow counter race on query completion

Long Li (7):
      net/mana: fix Rx mempool leak on port stop
      net/netvsc: retry VF hotplug until device disappears
      net/netvsc: retry on SIOCGIFHWADDR failure during VF hotplug
      net/netvsc: retry full probe when IB device not ready
      net/netvsc: retry when no matching MAC found
      net/netvsc: forward per-queue stats from VF device
      dev: report devargs truncation for multi-process hotplug

Lukasz Czapnik (1):
      net/e1000/base: fix possible variable overflow

Marat Khalili (14):
      bpf/validate: fix BPF_ADD of pointer to a scalar
      bpf/validate: fix BPF_LDX | EBPF_DW signed range
      bpf/validate: fix BPF_NEG of INT64_MIN and 0
      bpf/validate: fix BPF_DIV and BPF_MOD signed part
      bpf/validate: fix BPF_MUL ranges minimum
      bpf/validate: fix BPF_MUL signed overflow UB
      bpf/validate: fix BPF_JGT/EBPF_JSGT no-jump max
      bpf/validate: fix BPF_JMP source range calculation
      bpf/validate: fix BPF_AND min calculations
      bpf/validate: fix BPF_LSH shift-out-of-bounds UB
      bpf/validate: fix BPF_OR min calculations
      bpf/validate: fix BPF_SUB signed max zero case
      bpf/validate: fix BPF_XOR signed min calculation
      bpf/validate: prevent overflow when building graph

Marcel Telka (1):
      mem: update comment on virtual area reservation

Mattias Rönnblom (1):
      test/dispatcher: preserve event opaque field

Maxime Leroy (8):
      interrupts: propagate epoll error
      fib6: fix tbl8 reservation drift in trie
      net/dpaa2: add L4 destination port to RSS hash key
      net/dpaa2: use L4 port extraction for SCTP RSS
      ethdev: keep fast-path operations valid after stop
      ethdev: return 0 from dummy queue count
      app/testpmd: include IP fields in UDP RSS option
      net/dpaa2: fix Rx queue count for primary process

Maxime Peim (2):
      net/mlx5: prepend implicit items in sync flow creation
      eal: fix index for non-EAL lcores

Md Shofiqul Islam (2):
      bus/fslmc: propagate unplug error
      dma/dpaa2: propagate removal error

Menachem Fogel (1):
      net/e1000/base: fix NVM loop bounds and pointer access

Michael Pfeiffer (1):
      net/mlx5: remove nonsensical flow action class ID checks

Mingjin Ye (1):
      net/ixgbe: fix EEPROM read on copper media

Mohammad Shuab Siddique (3):
      net/bnxt: fix RSS hash mode configuration for VF
      net/bnxt: fix IOVA range check for external mbuf
      net/bnxt: fix PTP timestamp flags in scalar Rx

Morten Brørup (1):
      mbuf: fix mbuf operations history recording

Mukul Katiyar (1):
      net/ice: fix TM hierarchy deletion

Ouyang Hao (1):
      net/af_xdp: fix resource leak in close

Pavan Nikhilesh (2):
      dma/cnxk: fix crash on secondary process cleanup
      common/cnxk: fix VFIO MSI-X interrupt setup

Prashant Gupta (1):
      net/dpaa: add null check in scheme delete

Pratik Senapati (1):
      crypto/openssl: fix use-after-free and cleanup

Radu Nicolau (2):
      crypto/scheduler: fix session restore of pending enqueues
      crypto/virtio: remove explicit cookie allocation

Raghavendra Ningoji (1):
      dmadev: clarify reported completion index

Rahul Bhansali (1):
      common/cnxk: fix event type for soft expiry

Rakesh Kudurumalla (1):
      examples/ipsec-secgw: drop packets in poll mode

Riley Fletcher (1):
      dts: fix port info getter when not found

Rupesh Chiluka (1):
      app/dma-perf: fix hang with worker on main lcore

Sandeep Penigalapati (2):
      net/i40e: fix flexible payload filter
      net/ice: reject unsupported flow item range

Satha Rao (1):
      common/cnxk: fix TM link config selection in debug dump

Sergei Iashin (3):
      net/iavf: remove dead code in TM node parameter check
      net/octeontx: fix overflow in device name formatting
      net/octeontx/base: fix out-of-bounds DQ range lookup

Shaiq Wani (1):
      net/ice: fix L2TPv2 outer MAC in training packet

Shani Peretz (2):
      app/testpmd: fix flow job list double-free on reattach
      examples/flow_filtering: fix allocation error paths

Shijith Thotton (1):
      dma/odm: fix zero-length DMA transfer

Shuzo Ichiyoshi (2):
      net/e1000: fix igc RSS redirection table
      net/e1000: fix igc Tx descriptor ring wrap

Sivaprasad Tummala (1):
      examples: remove artificial Tx queue limit

Soumyadeep Hore (3):
      net/iavf: reuse device alarm for PHC sync
      net/iavf: remove PHC polling from Rx datapath
      net/ice: fix advertising timestamp offload

Srikanth Yalavarthi (3):
      mldev: fix some typos in Doxygen
      doc: fix some mldev model captions
      ml/cnxk: fix overwriting layer name during load

Stephen Hemminger (43):
      net/tap: avoid using Netlink socket if closed
      net/axgbe: fix comma operator misuse
      net/pcap: fix Windows build
      net/pcap: advertise Tx multi segment
      net/pcap: fix error accounting and backpressure on Tx
      net/pcap: reject non-Ethernet interfaces
      net/af_packet: fix indentation
      app/testpmd: terminate process on second signal
      ethdev: fix flow_ops_mutex for multi-process
      net/failsafe: fix hotplug mutex for multi-process
      net/atlantic: fix mbox mutex for multi-process
      net/axgbe: fix mutexes for multi-process
      net/bnxt: fix mutexes for multi-process
      net/hinic: fix mutexes for multi-process
      bitops: fix build with GCC 17
      ip_frag: fix unsafe tailq usage
      ip_frag: randomize hash seed
      test/latency: fix intermittent failure on slow platforms
      mem: fix data race in Linux hugepage prefault
      net: fix GTP tunnel parsing
      telemetry: fix thread-unsafe command parsing
      ethdev: make telemetry parameter parsing thread-safe
      dmadev: validate telemetry parameters
      security: harden telemetry parameter parsing
      eventdev: harden telemetry parameter parsing
      eventdev/eth_rx: fix thread-unsafe telemetry parsing
      eventdev/eth_rx: reject out-of-range telemetry ID
      eventdev/timer: reject out-of-range telemetry ID
      tailq: fix name truncation
      net/cnxk: fix telemetry SA info parameter parsing
      common/cnxk: fix thread-unsafe NIX telemetry parsing
      net/af_packet: fix parsing of numeric device args
      net/bonding: check mode before setting dedicated queues
      net/bonding: prevent crash on Rx/Tx from secondary process
      eal: add helper to initialize process-shared mutex
      ip_frag: include protocol in IPv4 reassembly key
      ip_frag: drop IPv6 fragments with per-fragment headers
      ip_frag: reject oversized reassembled datagrams
      crypto/uadk: use timing-safe digest comparison
      crypto/ccp: use timing-safe digest comparison
      crypto/armv8: use timing-safe digest comparison
      crypto/cnxk: use timing-safe digest comparison
      maintainers: fix app/test attributions

Thomas Monjalon (6):
      examples/vm_power_manager: fix const discarding
      devtools: fix regex matching literal plus in patches
      spinlock: remove volatile qualifier
      spinlock: fix API comments
      net/mlx5: fix Rx split segment counter type
      dts: fix topology capability comparison

Vanshika Shukla (2):
      net/dpaa: fix port handle leak
      dma/dpaa: fix out-of-bounds access in SG descriptor enqueue

Vincent Jardin (1):
      doc: fix stale packet pacing in mlx5 guide

Vitaly Lifshits (3):
      net/e1000/base: cleanup K1 exit timeout configuration
      net/e1000/base: fix typo
      net/e1000/base: clear DPG enable bit post MAC reset

Vladimir Medvedkin (1):
      fib6: fix error code propagation on next hop update

Wei Dai (1):
      crypto/ipsec_mb: avoid clearing SNOW3G digest in-place

Xingui Yang (1):
      net/hns3: fix L4 checksum for tunnel packets

Yunjian Wang (1):
      net/mlx5: fix handling of FCQ allocation failure

Zaiyu Wang (25):
      net/txgbe: remove duplicate xstats counters
      net/ngbe: remove duplicate xstats counters
      net/ngbe: add CDR config for YT PHY
      net/ngbe: fix VF promiscuous and allmulticast
      net/txgbe: fix inaccuracy in Tx rate limiting
      net/txgbe: fix link status check
      net/txgbe: fix Tx descriptor free
      net/txgbe: fix link flow control registers for Amber-Lite
      net/txgbe: fix link flow control config for Sapphire
      net/txgbe: fix mass of unknown interrupts
      net/txgbe: fix traffic class priority configuration
      net/txgbe: fix link stability for 25G NIC
      net/txgbe: fix link stability for 40G NIC
      net/txgbe: fix link stability for Amber-Lite backplane mode
      net/txgbe: fix FEC mode configuration on 25G NIC
      net/txgbe: fix SFP module identification
      net/txgbe: fix module info query
      net/txgbe: fix EEPROM query
      net/txgbe: fix Tx write-back pointer reset
      net/txgbe: enable Tx descriptor check per queue
      net/txgbe: fix Amber-Lite temperature tracking
      net/ngbe: support USO
      net/txgbe: support USO
      net/txgbe: fix null dereference in link alarm
      net/txgbe: validate lane number before use

Zhiguang Jin (1):
      ring: fix zero-copy burst API documentation

Zoe Cheimets (1):
      net/bnxt: roll back Tx descriptors for invalid packets

