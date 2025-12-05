Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B506D2F7C9
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CCA5402E5;
	Fri,  5 Dec 2025 11:00:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 65E1C402DC
 for <dev@dpdk.org>; Fri,  5 Dec 2025 11:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764928802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FlmFoM5dOHYdy/KDKQnbqnsXafyHGqkxhemHapiU2hI=;
 b=CNfYf7xTJWD3v91oq1Izm2kHpV3ODQ/WL5a+v/Ee4gV1YWUXq/BvQeWLCH2pQOOKRM24Ga
 FxetzNMeiaLbqI/NWQVZfRnyS+yho7DmGUy3zow1ni691IpZNLoXUYBugQf655b8itEeiL
 LGN5HYSj5fyAul9O31SeK4wZWq4Euio=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-dwQjlWmtOBWLVGj0e13zZg-1; Fri,
 05 Dec 2025 04:59:58 -0500
X-MC-Unique: dwQjlWmtOBWLVGj0e13zZg-1
X-Mimecast-MFC-AGG-ID: dwQjlWmtOBWLVGj0e13zZg_1764928797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBC201956095; Fri,  5 Dec 2025 09:59:56 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.42.28.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8882B180028C; Fri,  5 Dec 2025 09:59:52 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
Subject: 24.11.4 patches review and test
Date: Fri,  5 Dec 2025 09:59:29 +0000
Message-ID: <20251205095931.160577-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 57jYGq4RQVNv6-LFRZRq9s6j_7xAGlAFtVHsb-qdyRc_1764928797
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

Here is a list of patches targeted for stable release 24.11.4.

The planned date for the final release is 18th December.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.4-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Kevin

---
Aarnav JP (4):
      common/cnxk: fix format specifier for bandwidth profile ID
      common/cnxk: fix NIX Rx inject enabling
      net/cnxk: fix Rx inject LF
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

Andrzej Wilczynski (1):
      net/ixgbe/base: fix PF link state request size

Anurag Mandal (1):
      net/i40e: fix symmetric Toeplitz hashing for SCTP

Ashok Kaladi (1):
      net/tap: fix BPF with cross-compilation

Bing Zhao (2):
      app/flow-perf: fix rules array length
      net/mlx5: move auxiliary data inline

Brick Yang (2):
      net/dpaa2: fix L3/L4 checksum results
      net/dpaa2: receive packets with additional parse errors

Bruce Richardson (11):
      net/intel: fix assumption about tag placement order
      net/ice: fix VLAN tag reporting on Rx
      test/func_reentrancy: fix args to EAL init call
      doc: fix display of commands in cpfl guide
      net/ice: fix initialization with 8 ports
      ethdev: fix VLAN filter parameter description
      net/ice: fix vector Rx VLAN offload flags
      net/fm10k: fix build with GCC 16
      app/pdump: remove hard-coded memory channels
      telemetry: make socket handler typedef private
      net/ice: fix path selection for QinQ Tx offload

Chengwen Feng (9):
      dma/hisilicon: fix stop with pending transfers
      test/dma: fix failure condition
      net/hns3: fix overwrite mbuf in vector path
      app/dma-perf: fix use after free
      app/dma-perf: check buffer size
      app/testpmd: fix DCB Tx port
      app/testpmd: fix DCB Rx queues
      app/dma-perf: fix on-flight DMA when verifying data
      app/dma-perf: fix stopping device

Chinh Cao (1):
      net/ice/base: fix integer overflow on NVM init

Christophe Fontaine (2):
      graph: fix xstats description allocation
      net: fix IPv6 link local compliance with RFC 4291

Ciara Loftus (6):
      net/iavf: fix Tx vector path selection logic
      doc: fix feature list of ice driver
      doc: fix feature list of iavf driver
      net/ice: remove unsupported SCTP Rx offload
      net/e1000/base: fix crash on init with GCC 13
      net/idpf: fix queue setup with TSO offload

Dariusz Sosnowski (8):
      app/testpmd: fix conntrack action query
      net/mlx5/hws: fix TIR action support in FDB
      net/mlx5: fix indirect flow age action handling
      net/mlx5: fix Direct Verbs counter offset detection
      net/mlx5: fix min and max MTU reporting
      net/mlx5: fix indirect RSS action hash
      net/mlx5: fix error reporting on masked indirect actions
      net/mlx5: fix flow tag indexes support on root table

David Marchand (22):
      test/telemetry: fix test calling all commands
      eal: fix plugin dir walk
      cmdline: fix port list parsing
      tailq: fix lookup macro
      hash: fix unaligned access in predictable RSS
      graph: fix unaligned access in stats
      eventdev: fix listing timer adapters with telemetry
      eal/arm: fix C++ build for 32-bit memcpy
      test/debug: fix crash with mlx5 devices
      net/tap: fix build with LTO
      cmdline: fix highest bit port list parsing
      eventdev/crypto: fix build with clang 21
      rawdev: fix build with clang 21
      vhost: fix external buffer in VDUSE
      net/dpaa2: remove ethdev pointer from bus device
      bus/ifpga: fix const pointer in device name parsing
      bus/uacce: fix const pointer in device matching
      common/qat: fix some const pointers
      crypto/caam_jr: fix const pointer in UIO filename parsing
      net/enetfec: fix const pointer in UIO filename parsing
      net/memif: fix const pointer in socket check
      app/procinfo: fix const pointer in collectd format

Dean Marx (2):
      dts: fix docstring in checksum suite
      dts: add reception check to checksum suite

Dengdui Huang (4):
      app/testpmd: increase size of set cores list command
      net/hns3: fix inconsistent lock
      net/hns3: fix VLAN resources freeing
      net: fix L2 length for GRE packets

Emma Finn (1):
      crypto/qat: fix CCM request descriptor hash state size

Gagandeep Singh (2):
      bus/dpaa: improve cleanup
      net/dpaa2: fix shaper rate

Gavin Li (2):
      net/mlx5: fix multicast
      net/mlx5: fix IPv6 DSCP offset in HWS sync API

Gowrishankar Muthukrishnan (1):
      crypto/virtio: fix cookies leak

Gregory Etelson (7):
      net/mlx5: fix storage of shared Rx queues
      net/mlx5: fix non-template RSS expansion
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

Jacob Keller (2):
      net/ice/base: fix memory leak in HW profile handling
      net/iavf: fix Rx timestamp validity check

Jasper Tran O'Leary (1):
      net/gve: free device resources on close

Jerin Jacob (4):
      net/iavf: fix build with clang 21
      test: fix build with clang 21
      app/eventdev: fix build with clang 21
      lib: fix backticks matching in Doxygen comments

Jiawen Wu (16):
      net/txgbe: fix checksum error counter
      net/ngbe: fix checksum error counter
      net/txgbe: reduce memory size of ring descriptors
      net/ngbe: reduce memory size of ring descriptors
      net/txgbe: fix VF Rx buffer size in config register
      net/txgbe: remove duplicate Tx queue assignment
      net/txgbe: add device arguments for FDIR
      net/txgbe: fix maximum number of FDIR filters
      net/txgbe: fix FDIR mode clearing
      net/txgbe: fix FDIR drop action for L4 match packets
      net/txgbe: fix FDIR filter for SCTP tunnel
      net/txgbe: filter FDIR match flex bytes for tunnel
      net/txgbe: fix FDIR rule raw relative for L3 packets
      net/txgbe: fix FDIR input mask
      net/txgbe: switch to FDIR when ntuple filter is full
      net/txgbe: remove unsupported flow action mark

John Miller (1):
      net/ark: remove double mbuf free

Joshua Washington (9):
      net/gve: send whole packet when mbuf is large
      net/gve: clean when insufficient Tx descriptors
      net/gve: do not write zero-length descriptors
      net/gve: validate Tx packet before sending
      net/gve: add DQO Tx descriptor limit
      net/gve: fix DQO TSO descriptor limit
      net/gve: clear DQO Tx descriptors before writing
      net/gve: fix disabling interrupts on DQ
      net/gve: free Rx mbufs if allocation fails on ring setup

Jun Yang (3):
      net/dpaa2: fix extract buffer preparation
      net/dpaa2: fix error frame dump
      net/dpaa2: fix flow rule resizing

Junlong Wang (1):
      net/zxdh: fix Arm build

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

Luca Boccassi (1):
      test/debug: fix IOVA mode on PPC64 without huge pages

Maayan Kashani (12):
      app/testpmd: fix mask in flow random item
      net/mlx5: fix index-based flow rules
      net/mlx5: fix default flow rules start
      net/mlx5: fix use after scope of RSS configuration
      net/mlx5: fix unsupported flow rule port action
      net/mlx5: fix double free in non-template flow destroy
      net/mlx5: fix non-template age rules flush
      net/mlx5: fix flow encapsulation hash
      net/mlx5: fix modify field action restriction
      app/testpmd: fix flex item link parsing
      net/mlx5: fix crash on flow rule destruction
      net/mlx5: fix device start error handling

Marat Khalili (1):
      graph: fix stats query with no node xstats

Mattias Rönnblom (1):
      bitops: improve power of 2 alignment documentation

Maxime Coquelin (3):
      vhost: add VDUSE virtqueue ready state polling workaround
      vhost: fix virtqueue info init in VDUSE vring setup
      net/virtio-user: fix used ring address calculation

Maxime Leroy (1):
      net/dpaa2: clear active VDQ state when freeing Rx queues

Megha Ajmera (1):
      sched: fix WRR parameter data type

Michael Baum (1):
      net/mlx5: fix multi-process Tx default rules

Nithinsen Kaithakadan (1):
      test/crypto: fix mbuf handling

Nupur Uttarwar (2):
      net/mlx5/hws: fix buddy memory allocation
      net/mlx5: skip Rx control flow tables in isolated mode

Pandi Kumar Maharajan (1):
      net/ice/base: fix memory leak in recipe handling

Prashant Gupta (2):
      net/dpaa2: fix uninitialized variable
      net/dpaa2: free buffers from error queue

Radu Nicolau (3):
      crypto/qat: fix ECDH
      crypto/qat: fix source buffer alignment
      test/crypto: fix vector initialization

Robin Jarry (4):
      net/tap: fix interrupt callback crash after failed start
      buildtools/pmdinfogen: fix warning with python 3.14
      graph: fix updating edge with active graph
      usertools/telemetry: fix exporter default IP binding

Roi Dayan (3):
      net/mlx5: fix leak of flow indexed pools
      net/mlx5: release representor interrupt handler
      common/mlx5: release unused mempool entries

Ronak Doshi (1):
      net/vmxnet3: fix mapping of mempools to queues

Rongwei Liu (5):
      net/mlx5: fix indirect flow action memory leak
      net/mlx5: fix flow aging race condition
      net/mlx5: remove counter alignment
      net/mlx5: fix meter mark allocation
      net/mlx5: fix indirect meter index leak

Satha Rao (1):
      common/cnxk: fix null SQ access

Serhii Iliushyk (1):
      net/ntnic: fix potential format overflow

Shai Brandes (2):
      net/ena: fix PCI BAR mapping on 64K page size
      net/ena/base: fix unsafe memcpy on invalid memory

Shaiq Wani (1):
      net/ice/base: fix adding special words

Shani Peretz (6):
      eal: fix DMA mask validation with IOVA mode option
      net/mlx5: fix MTU initialization
      app/crypto-perf: fix plaintext size exceeds buffer size
      net/bonding: fix MAC address propagation in 802.3ad mode
      net/mlx5: fix null dereference in modify header
      net/mlx5: fix Tx metadata pattern template mismatch

Sivaprasad Tummala (4):
      eal/x86: enable timeout in AMD power monitor
      examples/l3fwd-power: fix telemetry command registration
      net/mlx5: fix spurious CPU wakeups
      examples/l3fwd: add Tx burst size configuration option

Stephen Hemminger (9):
      net/bnxt: fix free of not allocated object
      test/argparse: change initialization to workaround LTO
      dmadev: fix debug build with tracepoints
      net/nfp: fix metering cleanup
      pdump: handle primary process exit
      net/mlx5: fix uninitialized variable
      examples/server_node_efd: fix format overflow
      examples/vdpa: fix format overflow
      bus/fslmc: fix const pointer in device name parsing

Sucharitha Sarananaga (1):
      crypto/cnxk: refactor RSA verification

Sunil Kumar Kori (1):
      common/cnxk: fix max number of SQB buffers in clean up

Tathagat Priyadarshi (1):
      gro: fix payload corruption in coalescing packets

Thierry Herbelot (1):
      config/arm: enable NUMA for Neoverse N2

Thomas Monjalon (12):
      efd: fix AVX2 support
      bus/pci: fix build with MinGW 13
      net/mlx5: fix build with MinGW 13
      bbdev: fix build with MinGW 13
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

Vamsi Attunuru (3):
      net/octeon_ep: handle interrupt enable failure
      net/octeon_ep: fix mbuf data offset update
      net/octeon_ep: fix device start

Vanshika Shukla (2):
      net/enetfec: fix out-of-bounds access in UIO mapping
      net/dpaa: fix resource leak

Venkat Kumar Ande (1):
      net/axgbe: fix build with GCC 16

Viacheslav Ovsiienko (4):
      net/mlx5: fix ESP item validation to match on seqnum
      net/mlx5: fix ESP header match after UDP for group 0
      net/mlx5/hws: fix ESP header match in strict mode
      net/mlx5: fix flex flow item header length

Vladimir Medvedkin (2):
      fib6: fix memory leak on delete operation
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

Yuan Wang (1):
      net/ixgbe: fix SCTP port filtering on E610

Yunjian Wang (1):
      vhost: fix double fetch when dequeue offloading

Zhichao Zeng (1):
      net/ice: fix statistics

