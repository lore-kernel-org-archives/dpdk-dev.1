Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6904C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F185C402E4;
	Mon, 27 Jul 2026 11:43:19 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 86BED400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 11:43:18 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so1126058f8f.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785145398; x=1785750198; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8KljI0Ie6Qji5bVp2vxg4o99Ut7LIImWALHRX+QbEU8=;
 b=D5Y4/BSY3rk6DOd2nhBpcQap9eOMmlIuMxbnnTsGvr5YQCrDK/G1ZF4Tgbyqmxrjdc
 7JwIbICdnF7DKDYNviHNtkwwqSa+3+SGBwc95jDQhYOhPwvvppcTEf9FRp5lIKZ/R5h3
 RTlAEBVZdUWTBnKx3ooHMfViS5eQ8QvGbg1xSCBQb/jCb7+wpQpgBQs8CBDARtEkYgCZ
 9ZKulstDrCw40URfsnvWR7BXB2i68VU7baSekB/fKA3QPsVFF4CT87OzNrgbYKdXCdhl
 arZP6JPeWz9V15dz+9Dvqu8Oy5+mgE14r3fczdQ0+ezwB0eU7e/B/+/xH+FYwXjN65nE
 xRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785145398; x=1785750198;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8KljI0Ie6Qji5bVp2vxg4o99Ut7LIImWALHRX+QbEU8=;
 b=syF6TtR0Gc/ZQ+GDVfV/kq/Bx5E+eFHhBYs+s557sHbFv3zAwCH018gZoe/V2nbxNl
 mS1p7Wsb8bbReKcnO1OzL/3smL9Zz3V11TFQDOqaTZSlC10kjQ0/AkA4zc61EWKsxDAK
 hsjPJtDFIUSzFXe9PsGICABBieDLyzQ+7hbmJT9sncWAL44+l6qPTKG5oLWGzRGKbGeX
 xlpNlDE54JkLtLjgGy1ZIyc9bPzdLcagIWJ/1NPmIJ2ZvSWOv7c6XZzoVrF0NJe3bES2
 SKPYJbOvHr+2wBOISqNVSdAFs2ZVB4o8oKaJf+OSq0G3DBSPm2OWrQS468451WUugdOr
 AbJQ==
X-Gm-Message-State: AOJu0YwZlPlx5FauKUPI9tvGyFh3fPm1IRb3lg6SUQQ96sXMPYZ7Twgs
 JvQLtrRHPV33WGRdSGFA4bTSwvIs+FapbE9WuhNQyuFbKVp89hS39Nte
X-Gm-Gg: AR+sD10p6FLWhqnrk1H07cq7osQ6ps6N2D6/hUXxrVefr2XdhLkcbwpQvGvveLP+nTi
 m0DE9fD0XFVh3AikMKpJeG0ZDUdOmnmkW0kb3F04JH4wXOxbV55JQ6BBfoFxx+e6gUSkO/XGo+O
 aVzswqfMtmEwVgIBFx7GvKfCdBuMhv8lcQkt4dWzhkH3SXPH9xgJj8YDFw8bSVuwnDY2k0dGyZW
 cPjdjDywR9/GLC2oR+Ceha3f7+/vX25ASOyynkS9NTfMy8BQH3Zidg/+hWc006+6Lixumq6cmIV
 t4C0+BrQkpTVVDAVOj1IQD9IugL4g6RhNibY02dbHwRtYlWvXAwAUgA6fM8kMGd+dpO7GZMxy6x
 EnNTImkHOh19SD9AUj8QiRev+5JEc+mYGc5Eed23g5dnZq15jAvvpHn96FmbDDUNjbegQ7qgJib
 8l9yRW+Q==
X-Received: by 2002:a05:6000:2386:b0:47f:810c:8abe with SMTP id
 ffacd0b85a97d-47f9feb544emr10042108f8f.36.1785145397746; 
 Mon, 27 Jul 2026 02:43:17 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:12c:ddcc:6e18:f764])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f85bb5127sm44454239f8f.10.2026.07.27.02.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 02:43:16 -0700 (PDT)
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
Subject: 24.11.7 patches review and test
Date: Mon, 27 Jul 2026 10:43:03 +0100
Message-ID: <20260727094306.41797-1-luca.boccassi@gmail.com>
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

Here is a list of patches targeted for stable release 24.11.7.

The planned date for the final release is 2026/08/10.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.7-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Aarnav JP (7):
      test/security: sync inline IPsec soft expiry check
      net/cnxk: fix underflow in LSO calculation
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

Anatoly Burakov (13):
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

Anurag Mandal (3):
      net/iavf: fix misleading admin queue failure logging
      net/iavf: fix race condition on link status change
      net/iavf: fix duplicate VF reset during PF reset recovery

Borys Tsyrulnikov (1):
      net/mlx5: fix double free in vectorized Rx recovery

Bruce Richardson (18):
      test: fix failing tests on FreeBSD
      cfgfile: prevent overflow on resize
      cmdline: harden parser result buffer handling
      cmdline: guard zero-size destination buffers
      eal/freebsd: fix memseg addresses in VA mode
      test/security: remove fast-free Tx flag
      test/security: fix MTU calculation underflow
      test/security: check for capabilities
      net/intel: fix use of non-recommended string functions
      test/eal: remove PCI probing for recursive calls
      examples: use strlcpy and strlcat
      net/iavf: fix local memory leaks in TM hierarchy commit
      net/iavf: fix leak of queue to traffic class mapping data
      net/iavf: fix memory leak on error when adding flow parser
      net/ice: fix buffer leak in config of Tx queue TM node
      net/iavf: fix leak of flex metadata extraction field
      net/iavf: fix leak of IPsec crypto capabilities array
      app: remove use of strncpy

Chenna Arnoori (2):
      net/bnxt: fix Rx timestamping for non-PTP packets
      net/bnxt: avoid link flap when setting flow control

Chinh Cao (1):
      net/i40e/base: fix integer overflow in NVM timing logic

Ciara Loftus (16):
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
      net/mlx5: redirect LACP traffic for legacy E-Switch
      net/mlx5: use port index as representor index

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

Gagandeep Singh (3):
      net/enetc: fix Tx BD structure
      net/dpaa: fix interrupt unregister
      net/dpaa: fix device remove

Gena Tertychnyi (1):
      eal/windows: fix core count for more cores per NUMA

Hemant Agrawal (10):
      bus/dpaa: fix FQ creation failure handling
      bus/dpaa: fix FQ query failure handling
      net/dpaa: fix CGR modification
      bus/dpaa: fix FD leak for CCSR mmap
      net/dpaa: fix xstats name for Tx undersized counter
      net/dpaa: fix BMI xstats names
      net/dpaa: remove duplicate packet types
      net/dpaa: fix BMI xstats by ID
      net/dpaa: fix checksum offload with empty L3 length
      net/dpaa: fix mbuf leak in SG FD creation

Huisong Li (3):
      power: remove duplicate uncore set frequency typedef
      power: validate enabled lcores in PMD management API
      examples/l3fwd-power: fix latency query failure handling

James Raphael Tiovalen (2):
      ethdev: fix out-of-bounds write in GENEVE option conversion
      ethdev: fix out-of-bounds write in flex item conversion

Jasper Tran O'Leary (1):
      net/gve: fix comma operator misuses

Joshua Washington (7):
      net/gve: clear out shared memory region for statistics
      net/gve: delay adding mbuf head to software ring
      net/gve: copy data to QPL buffer when mbuf read does not
      net/gve: set mbuf to null in software ring after use
      net/gve: free context mbuf on later segment drop
      net/gve: increase range of DMA memzone IDs to 64 bits
      net/gve: restrict max ring size in GQ QPL to 2K

Kalesh AP (3):
      net/bnxt: support PTP on Wh+ using HWRM interface
      net/bnxt: support Rx/Tx timestamp on Wh+ using HWRM
      net/bnxt: support PTP for Thor2

Kavya AV (1):
      net/ice: use configured outer TPID for VLAN filter in DVM

Keegan Freyhof (3):
      net/bnxt: fix NQ/CQ processing for interrupt handling
      net/bnxt: avoid queue use after free on close
      net/bnxt: clear stale Tx descriptor count

Kiran Vedere (1):
      net/mlx5: fix uninitialized skip count

Linhu Li (1):
      net/mlx5: fix flow counter race on query completion

Long Li (6):
      net/mana: fix Rx mempool leak on port stop
      net/netvsc: retry VF hotplug until device disappears
      net/netvsc: retry on SIOCGIFHWADDR failure during VF hotplug
      net/netvsc: retry full probe when IB device not ready
      net/netvsc: retry when no matching MAC found
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

Maxime Leroy (6):
      interrupts: propagate epoll error
      fib6: fix tbl8 reservation drift in trie
      net/dpaa2: add L4 destination port to RSS hash key
      net/dpaa2: use L4 port extraction for SCTP RSS
      app/testpmd: include IP fields in UDP RSS option
      net/dpaa2: fix Rx queue count for primary process

Maxime Peim (1):
      net/mlx5: prepend implicit items in sync flow creation

Md Shofiqul Islam (1):
      dma/dpaa2: propagate removal error

Menachem Fogel (1):
      net/e1000/base: fix NVM loop bounds and pointer access

Michael Pfeiffer (1):
      net/mlx5: remove nonsensical flow action class ID checks

Mingjin Ye (1):
      net/ixgbe: fix EEPROM read on copper media

Mohammad Shuab Siddique (2):
      net/bnxt: fix RSS hash mode configuration for VF
      net/bnxt: fix PTP timestamp flags in scalar Rx

Mukul Katiyar (1):
      net/ice: fix TM hierarchy deletion

Ouyang Hao (1):
      net/af_xdp: fix resource leak in close

Pavan Nikhilesh (1):
      dma/cnxk: fix crash on secondary process cleanup

Prashant Gupta (1):
      net/dpaa: add null check in scheme delete

Radu Nicolau (2):
      crypto/scheduler: fix session restore of pending enqueues
      crypto/virtio: remove explicit cookie allocation

Raghavendra Ningoji (1):
      dmadev: clarify reported completion index

Rahul Bhansali (1):
      common/cnxk: fix event type for soft expiry

Rakesh Kudurumalla (1):
      examples/ipsec-secgw: drop packets in poll mode

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

Shani Peretz (1):
      app/testpmd: fix flow job list double-free on reattach

Shijith Thotton (1):
      dma/odm: fix zero-length DMA transfer

Shuzo Ichiyoshi (2):
      net/e1000: fix igc RSS redirection table
      net/e1000: fix igc Tx descriptor ring wrap

Sivaprasad Tummala (1):
      examples: remove artificial Tx queue limit

Soumyadeep Hore (1):
      net/iavf: remove PHC polling from Rx datapath

Srikanth Yalavarthi (3):
      mldev: fix some typos in Doxygen
      doc: fix some mldev model captions
      ml/cnxk: fix overwriting layer name during load

Stephen Hemminger (36):
      net/axgbe: fix comma operator misuse
      net/pcap: fix Windows build
      net/pcap: advertise Tx multi segment
      net/pcap: fix error accounting and backpressure on Tx
      net/pcap: reject non-Ethernet interfaces
      net/af_packet: fix indentation
      app/testpmd: terminate process on second signal
      eal: add helper to initialize process-shared mutex
      ethdev: fix flow_ops_mutex for multi-process
      net/failsafe: fix hotplug mutex for multi-process
      net/atlantic: fix mbox mutex for multi-process
      net/axgbe: fix mutexes for multi-process
      net/bnxt: fix mutexes for multi-process
      net/hinic: fix mutexes for multi-process
      bitops: fix build with GCC 17
      ip_frag: fix unsafe tailq usage
      ip_frag: randomize hash seed
      mem: fix data race in Linux hugepage prefault
      telemetry: fix thread-unsafe command parsing
      ethdev: make telemetry parameter parsing thread-safe
      dmadev: validate telemetry parameters
      security: harden telemetry parameter parsing
      eventdev/eth_rx: fix thread-unsafe telemetry parsing
      eventdev/eth_rx: reject out-of-range telemetry ID
      eventdev/timer: reject out-of-range telemetry ID
      net/e1000: check flex filter mask range
      tailq: fix name truncation
      net/cnxk: fix telemetry SA info parameter parsing
      common/cnxk: fix thread-unsafe NIX telemetry parsing
      net/af_packet: fix parsing of numeric device args
      net/bonding: check mode before setting dedicated queues
      net/bonding: prevent crash on Rx/Tx from secondary process
      ip_frag: include protocol in IPv4 reassembly key
      ip_frag: drop IPv6 fragments with per-fragment headers
      ip_frag: reject oversized reassembled datagrams
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

Vladimir Medvedkin (1):
      fib6: fix error code propagation on next hop update

Wei Dai (1):
      crypto/ipsec_mb: avoid clearing SNOW3G digest in-place

Xingui Yang (1):
      net/hns3: fix L4 checksum for tunnel packets

Yunjian Wang (1):
      net/mlx5: fix handling of FCQ allocation failure

Zaiyu Wang (9):
      net/txgbe: remove duplicate xstats counters
      net/ngbe: remove duplicate xstats counters
      net/ngbe: add CDR config for YT PHY
      net/txgbe: fix traffic class priority configuration
      net/txgbe: enable Tx descriptor check per queue
      net/ngbe: support USO
      net/txgbe: support USO
      net/txgbe: fix link flow control config for Sapphire
      net/txgbe: fix mass of unknown interrupts

Zhiguang Jin (1):
      ring: fix zero-copy burst API documentation

Zoe Cheimets (1):
      net/bnxt: roll back Tx descriptors for invalid packets
