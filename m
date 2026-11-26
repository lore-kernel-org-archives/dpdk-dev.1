Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+25Xg0e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5082240430;
	Thu, 26 Nov 2026 16:45:53 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mails.dpdk.org (Postfix) with ESMTPS id C7C72402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 16:45:51 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so92481095e9.1
 for <dev@dpdk.org>; Thu, 26 Nov 2026 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795707951; x=1796312751; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=33CEfaMFOwASTGdtROsRhniMJf75pkc3+Gt6678AbbA=;
 b=B+25Xg0ersBRvsrq4Ofo5qiINUklhy47uYOKNdRnK++iZ/wMbrhaOeCjOkxPsDM2Vr
 mljqsZKwWejFXo96iihjhzuWFGsT5khhM1/0oCU5exRMF94R+GkrVw5HYH8brmSjEYX6
 J3J6gR4jnEpDa9zZNm7zRNU4EXxg9ey6SPLIMGExOJRozatr248oQqAhBJxIQjAQkMRd
 1b82bjl6OxvlqC1bgcFoa6Rez+nauhM2Ayo3SUnUIUN5QU6hq+cQsCXAmF802Zy5uTww
 XW6ncIHs272ZZesEON/LmdeXDlgI1wYQjSZkO1LP1UVGLsminBdLLMDorTGW3Bh7ePY4
 qdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795707951; x=1796312751;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=33CEfaMFOwASTGdtROsRhniMJf75pkc3+Gt6678AbbA=;
 b=ySviingskv3Bg7slu5Hf3YZmMpccSQ4uZkBUtKuAxQKV6ggMyvudXSc9sDWBoGVT64
 oGwCpoxYIoICY4m8d3ZvWKN9OZcR6CwD0gd656e+bD2tcWFiu6WHFJUHcx6H8ck+ITG7
 oU9gXM9YJWkt4PtQpOVZe+U+R/n8jdnxmDYAH4vh8hf0Zsqm5RMQcDGgftcx6hfdtO/d
 /vQSFe6HXQC5urQ0x9ehWWSy/urPocyWS1VxOwHc1DL9LJYx2XRqI4YCIHKJzDaY4lcR
 eECPCWDIKO7P78SKu+zfVO1R8YeG6ekhIp7DJSxYjMUXArgPxn4I4BLSFthi7jvQXSQb
 7erg==
X-Gm-Message-State: APuU4Z+VtoGs1NOvmPXGYAwYvmwEDXJ/9WQDDrGOjXMywT1yL/CHgun+
 EqLa6fKw0divWo7X9KQDd7M9vFkWz58gAIPHj80GtQoiM51f5Mjt44QQ
X-Gm-Gg: AZFdTZfWeemMGh4vtyMvby25pemAj3sglbhUAkhV7JWm3PCQpsNoBfBg8XBxUkBk5sP
 ruckBjGNYH/V+uZROt+mIF8rHOlhT49Vh5azWjA1mvRsdtWfkCkPk5pbDrkiN5u7Tb2s95euHSa
 65Sdu6ZUpUYGcTRfQSY0K2D/ygxR3pO3frR+oH/z02AjANxWWAHqNXlVaU/WFTgA3L50C1y3yVV
 nnYcwwvzF/nYenS3/isPP7srNOcebpL2NVqjgfG9QeTGyt1V/MVbkhwBq+rZ+SdiIT3SHp+mEat
 CY8ihGLLlXfyeweQXaMG/MldPlZEcJigYLkzivDImiiZFeMiJXT11MLKLkGmumiuZdhTxuwdmQf
 ztyZ5gKqY17ZioMOms2zs1/PpwuXjJOHSTbtu1SGgsafWUmVSOZekTc6ZnPTpcTJFP8FX1jFVfG
 hA/0RwkxLa5KgwqTKN7fBgF2QXU/Wy2gorvA5wsD9kruP8xASHjN62ImiFgY5cmLiNLrOg0RCwO
 Lvky9gnluNVPbLBsNaDzNZqh4zVuEhbvF4GJCdGJjBiG2Ryyzr7g8eDSnpTKwz0DNOCdUedTGxi
 Q6SM11ehT0uacG6LbBgAjgSKVrIrWRiWGg==
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4bb88818156mr430120905e9.16.1795707951035; 
 Thu, 26 Nov 2026 07:45:51 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:250:b6ff:feb7:bd60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm502593795e9.0.2026.11.26.07.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:45:50 -0800 (PST)
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
Subject: 24.11.9 patches review and test
Date: Thu, 26 Nov 2026 15:45:40 +0000
Message-ID: <20261126154544.1350042-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Here is a list of patches targeted for stable release 24.11.9.

The planned date for the final release is January 11th.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.9-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Aarnav JP (5):
      test/security: fix 5-fragment IP reassembly vector
      common/cnxk: fix use-after-free during MACsec teardown
      common/cnxk: check Tx scheduler queue allocation bounds
      common/cnxk: check Rx queue before configuring flow control
      common/cnxk: check representor count before copying map

Adrian Schollmeyer (1):
      build: fix cross-compilation to x86-64

Akhil Goyal (2):
      raw/cnxk_bphy: fix Doxygen documentation
      raw/cnxk_gpio: fix out-of-bound access for negative GPIO

Aleksandr Khromov (1):
      net: fix signed shift overflow in IPv6 checksum

Alexander Goodkind (1):
      net/bnxt: fix aliasing in firmware command writes

Alexey Simakov (3):
      net/enic: check notify set return value during init
      app/graph: fix connection buffer leak
      ip_frag: fix IPv6 fragmentation of short packets

Amiya Ranjan Mohakud (1):
      common/cnxk: fix duplicate mailbox in NPA aura pool init

Anatoly Burakov (25):
      net/ixgbe: fix missing HW write in IPsec
      net/iavf: fix memory leak on IPsec SP delete
      net/iavf: fix leak on IPsec init failure
      interrupts: fix event array copy in duplicated instance
      eal/linux: fix closing of event FDs not owned by EAL
      eal/linux: fix eventfd leaks when enabling interrupts
      net/ice: do not include private headers in testpmd
      net/ixgbe: make ethertype filter table dynamic
      net/ixgbe: fix syn filter priority
      net/ixgbe: fix ntuple filter priority
      net/ixgbe: fix L4 protocol parsing for ntuple
      net/ice: release ACL slot on entry creation failure
      net/ice: fix inconsistent state on FDIR failure
      net/iavf: keep device stopped if start fails
      net/iavf: fix false success on flow validation
      net/iavf: fix memory leaks around IRQ resources
      net/iavf: fix generic flow error-path leaks
      net/iavf: skip RSS teardown during PF-initiated reset
      net/iavf: fix null engine for egress security flows
      net/iavf: fix IPsec flow metadata leaks
      ethdev: fix flow conversion with null buffer
      ethdev: add missing action types to flow conversion
      ethdev: prevent overflow in indirect flow action conversion
      net/ixgbe: fix EEPROM callback checks
      net/ixgbe: fix PTP packet detection

Andre Muezerie (1):
      dev: export driver information with MSVC

Andrei-Niculae Petre (1):
      examples/l3fwd: fix build with dataplane debug

Andrey Mokrushin (4):
      acl: reject rules with inverted range
      net: fix tunnel parsing of non-IP packets
      gso: fix segmentation of unsupported tunnel packets
      gro: fix returned packet count after UDP fragment merge

Andrey Yudin (1):
      graph: fix xstats of cloned node

Andy Moreton (5):
      common/sfc_efx/base: reduce stack in RSS context table write
      common/sfc_efx/base: reduce stack in get addr regions MCDI
      common/sfc_efx/base: reduce stack in set addr regions MCDI
      common/sfc_efx/base: fix filter saved spec handling
      common/sfc_efx/base: fix annotations in client MAC addr get

Anurag Mandal (30):
      net/af_xdp: fix default device plugin path
      net/iavf: defer device start when PF VSI not ready
      net/iavf: change no-poll flag to atomic
      net/iavf: fix VF reset detection on fast ARQ bit flip
      net/iavf: keep watchdog armed for the whole reset window
      net/iavf: skip flow flush during PF-initiated reset
      doc: fix typo in Intel VF guide
      net/ice: fix PHY capabilities buffer leak
      net/ice: fix disabling outer VLAN insertion
      net/iavf: fix memory leaks in RSS flow engine
      net/i40e: fix floating VEB leak
      net/i40e: fix FDIR memzone leak
      net/iavf: fix RSS rule overwriting an existing one
      net/ice: fix DDP package double free on init failure
      net/ice: fix resource leaks on port close
      net/ice: fix DDP filename leak
      net/ice: fix main VSI leak on init failure
      net/ice: fix MAC and VLAN filter leak on VSI release
      net/ice: fix FDIR resource leak on setup failure
      net/ice: fix ACL profile segment leak
      net/ice: fix RSS rule overwriting an existing one
      net/ice: fix null dereference on ACL init failure
      net/ice: fix DCF hardware init error path
      net/ice: fix DCF parent adapter init error path
      net/ice: fix DCF queue config buffer leak
      net/ice: fix DCF QoS buffer leak on commit
      net/ice: fix DCF QoS bandwidth replay config leak
      net/ice: fix DCF TM config leak on close
      net/ice: fix DCF representor info leak on close
      net/ice: fix DCF port leak on probe failure

Artem Novikov (3):
      net/ice: remove unreachable DCF scheduler branch
      net/ice: ignore WRED parameters for tail drop in DCF
      net/i40e: fix ethertype filter restore diagnostics

Bing Zhao (2):
      net/mlx5: fix local and host representor name collision
      net/mlx5/hws: silence wildcard represented port diagnostic

Bruce Richardson (30):
      net/ring: remove internal devarg
      ethdev: remove use of strncpy
      eventdev: improve bounds checks for names in adapter create
      vhost: remove use of strncpy
      common/cnxk: replace strncpy with strlcpy
      common/mlx5: replace strncpy with strlcpy
      crypto/mvsam: replace strncpy with strlcpy
      crypto/scheduler: replace strncpy with strlcpy
      event/cnxk: replace strncpy with strlcpy
      net/ark: replace strncpy with strlcpy
      net/bnx2x: replace strncpy with strlcpy
      net/cnxk: replace strncpy with strlcpy
      net/dpaa: replace strncpy with strlcpy
      net/ionic: replace strncpy with strlcpy
      net/mlx4: replace strncpy with strlcpy
      net/mlx5: replace strncpy with strlcpy
      net/nfp: replace strncpy with strlcpy
      net/qede: replace strncpy with strlcpy
      net/softnic: replace strncpy with strlcpy
      net/vhost: replace strncpy with strlcpy
      net/virtio: replace strncpy with strlcpy
      net/i40e: fix error handling for QinQ filter
      net/intel: fix overflow on store of single-queue settings
      eal: fix C++ build when stdatomics is set
      net/ice: check for missing fixed speed setting
      net/ice: fix overflow on storing devargs
      net/ice: fix storing field offset arg
      vdpa/ifc: fix argument parsing
      net/e1000: revert queue number
      net/ice: fix silent drop of MAC addresses in ACL rules

Chen Zhao (1):
      net/netvsc: fix event buffer leak on realloc failure

Chenna Arnoori (1):
      net/bnxt: fix bounds in MAC address pool index

Christophe Fontaine (1):
      bpf/arm64: fix offset type to allow a negative jump

Ciara Loftus (11):
      app/testpmd: fix stale queue count check order
      net/i40e: preserve RSS RETA across port stop and start
      net/i40e: program default RSS RETA at port configure
      net/ice: fix Tx queue capacity sizing after TM commit
      net/ice: fix Rx queue count reporting after TM commit
      net/ice: update Rx supported offloads masks
      net/ice: fix ACL entry limit on devices with 8 ports
      net/iavf: fix event handler leak on init failure
      net/iavf: fix watchdog clearing reset state during recovery
      net/iavf: fix race between watchdog enable and disable
      net/ice: fix DCF probing when ACL is unavailable

Dakota Sicher (1):
      net/bnxt/tf_ulp: fix parent MAC lookup path handling

Dariusz Sosnowski (3):
      net/mlx5: fix mini CQE compression format log
      net/mlx5: fix link interrupt capability on Windows
      net/mlx5: fix link status query

David Marchand (19):
      doc: remove unreferenced KNI and examples figures
      net/mlx5: fix promiscuous inconsistency on port start
      net/mlx5: reset promiscuous modes on device close
      hash: fix GFNI helpers for building with -O0
      vdpa/mlx5: fix check on error interrupt FD
      eal/freebsd: fix FD leak in alarm subsystem
      drivers/bus: fix FD leak during scan in NXP drivers
      bus/fslmc: fix device name leak
      bus/fslmc: fix some VFIO device FD and memory leaks
      net/memif: fix some interrupt FD leaks
      examples/vdpa: remove dependency on PCI library
      devtools: fix matching in doc check
      drivers/net: fix reported VMDq capability
      doc: fix DCB capability for some Intel drivers
      drivers/net: fix reported RSS capability
      dev: rename pmdinfo internal symbols
      bus/fslmc: fix interrupt leak in DPIO cleanup
      net/memif: fix use after free on listener socket close
      eal/linux: revert eventfd leak fix for MSI-X

Dawid Wesierski (2):
      net/iavf: fix bandwidth config of unshaped queues
      net/iavf: fix crash in TM ops without QoS capability

Deepthi Kavalur (1):
      net/ice/base: fix loop counter type in recipe creation

Denis Lyulin (2):
      net/bnxt: fix memset size in Tx queue start
      net/bnxt: fix integer overflow in device reset

Dmitriy Matveichev (1):
      net/memif: unregister callback on error in listener handler

Dragos Tarcatu (2):
      examples/l2fwd-event: fix port statistics memset
      eal/x86: check OS support for AVX and AVX512 state

Erez Shitrit (1):
      net/mlx5/hws: add DF bit for IPv4 header in NAT64 action

Evgeny Sokolov (5):
      net/bonding: add log for MAC address restore failure
      net/bnxt: fix MPC channel disable mask
      net/bnxt: check flow RSS config
      net/bnxt: fix context DMA array allocation size
      net/bnxt/tf_ulp: fix meter burst size

Farah Smith (3):
      net/bnxt: check packet type indexing for v3 completion
      net/bnxt/tf_core: fix out-of-bounds read in TCAM get
      net/bnxt/tf_core: add response bounds checks

Frank Dressler (1):
      doc: fix qdisc bypass default in af_packet guide

Gagandeep Singh (4):
      app/crypto-perf: reset mbuf state for IPsec outbound
      crypto/dpaa2_sec: fix GCM decrypt buffer overflow
      crypto/dpaa2_sec: fix FLE pool leak on sec FD failure
      bus/dpaa: simplify buffer release loop

Harman Kalra (1):
      common/cnxk: fix mailbox message size underflow

Hemant Agrawal (8):
      net/dpaa: fix double close and null deref on remove
      net/dpaa: propagate FMC init errors during probe
      net/dpaa: fix resource leak on probe failure
      net/dpaa: fix free port resources on close
      mempool/dpaa: fix use-after-free during pool cleanup
      dma/dpaa: fix data validation on completion path
      bus/dpaa: accept QDMA device name in devargs
      net/dpaa2: fix integer overflow in CCSR region mapping

Hernan Vargas (5):
      bbdev: remove spurious error log during queue dump
      baseband/acc: fix available descriptor count for dequeue
      baseband/acc: fix FFT window index in VF-to-PF requests
      baseband/acc: fix interrupt ring stall on unknown queue
      baseband/acc: fix LDPC encoding when switching block modes

Huisong Li (2):
      examples/l3fwd-power: fix uncore deinit for non-legacy
      examples/l3fwd-power: fix uncore help and log info

Itai Sharoni (1):
      net/mlx5: reject unsupported GRE and NVGRE flow patterns

Ivan Malov (3):
      net/sfc: set Rx queue type flags from scratch on queue setup
      net/sfc: drop wrong static qualifier from iterator variable
      net/sfc: fix shared adapter pointer in secondary process

Jack Bond-Preston (2):
      bitops: clarify power-of-two alignment limits
      crypto/armv8: validate xform auth key length

Janardhanan Arumugam (1):
      net/ice/base: fix out-of-bounds accesses in DDP and NVM code

Jasper Tran O'Leary (1):
      net/gve: fix RSS config memory leak on close

Joey Zhong (3):
      net/bnxt/tf_ulp: enforce bounds in bitstream extraction
      net/bnxt/tf_ulp: fix HA timer spinlock leak
      net/bnxt/tf_core: fix out-of-bounds accesses

Joseph Wong (7):
      net/bnxt: fix stack exhaustion in flow stats
      net/bnxt: add VF ID boundary check before usage
      net/bnxt: fix bounds on firmware-reported resource counts
      net/bnxt: fix VF info alloc error path memory leak
      net/bnxt: fix NVRAM directory integer overflow
      net/bnxt/tf_ulp: check bounds for FW-supplied IDs
      net/bnxt/tf_ulp: fix bit allocator out-of-bounds read

Joshua Washington (3):
      net/gve: fix TSO segment offset calculation
      net/gve: introduce Tx packet preparation for DQO format
      net/gve: validate minimum header length for TSO packets

Kai Ji (1):
      test/crypto: use standard memcpy for wireless cipher IV

Keegan Freyhof (3):
      net/bnxt: harden sprintf bounds for device memory names
      net/bnxt: prevent out-of-bounds access in AVX2 v2 Rx
      net/bnxt: prevent out-of-bounds access in AVX2 CRx

Kiran Kumar K (2):
      app/testpmd: fix flex item config buffer overflow
      app/testpmd: fix error handling in flow API commands

Kishore Padmanabha (7):
      net/bnxt: fix TPA agg Rx descriptor and VNIC query bounds
      net/bnxt: fix memory leak in VF VNIC query error path
      net/bnxt: check RSS queues and context init offset
      net/bnxt: validate index in pool manager API
      net/bnxt: validate direction index in TPM table
      net/bnxt/tf_ulp: fix tunnel list memory corruption
      net/bnxt: randomize flow table hash seed

Kobi Kenzi (1):
      doc: fix typo in cnxk guide

Krzysztof Galazka (1):
      net/ice/base: fix integer overflow in RL profile calculation

Luca Boccassi (2):
      doc: fix indentation issues causing build failure
      maintainers: update email address

Maayan Kashani (9):
      net/mlx5: fix HWS meter ASO SQ leak on multi-port init
      vdpa/mlx5: fix RSS flow leak on steering update failure
      vdpa/mlx5: fix memory leak with no enabled Rx queue
      eal/linux: fix dirty flag for reused hugepages in legacy mem
      drivers: fix ASan ODR violation on mlx glue symbols
      net/mlx5: fix table leak on HWS sample action destruction
      net/mlx5: fix write-after-read in flow modify action
      net/mlx5: fix double free of HWS counter pool name
      net/mlx5: report HWS counter pool allocation failure

Manish Kurup (7):
      net/bnxt/tf_core: fix CPM pool-use list insertion
      net/bnxt/tf_core: fix TCAM alloc-set key copy
      net/bnxt/tf_core: fix SRAM allocation failure handling
      net/bnxt/tf_core: validate TCAM entry get response
      net/bnxt/tf_ulp: check EM key pad result
      net/bnxt/tf_core: fix buffer leaks in RM create DB
      net/bnxt/tf_core: fix TPM pool create error return

Marat Khalili (1):
      bpf/validate: fix mask calculation for 32-bit operations

Marcel Telka (1):
      net/ice: fix missing bytes when getting EEPROM data

Marek Kasiewicz (1):
      net/iavf: fix interrupt callback race on close

Maxime Leroy (3):
      net/tap: fix crash on Tx queue release after reconfigure
      net/tap: support Rx queue interrupt enable/disable
      net/tap: drain queue FD in Rx interrupt mode

Mikhail Mamatov (1):
      net/mlx5: restore fake mbuf guards on Rx replenish failure

Mohammad Shuab Siddique (5):
      net/bnxt: validate TPA aggregation ID from completions
      net/bnxt: fix VNIC filter list walk stopping early
      net/bnxt: fix crash when creating invalid flow
      net/bnxt: fix VF RSS hash mode configuration
      net/bnxt: use long descriptors for Tx checksum offload

Morten Brørup (7):
      net: revert IPv6 traffic class and flow label fields
      mempool: fix private data area size alignment
      net/vhost: fix SW checksum when zero
      net/virtio: fix checksum offset check in Rx path
      vhost: fix checksum offset check in Rx path
      gro: fix packet type comparisons
      examples/l3fwd: fix RFC 1812 checks

Omar Munchaev (1):
      net/intel: fix use of offload validation function

Orgad Shaneh (1):
      net/mana: fix Rx interrupt vector beyond device count

Pavan Nikhilesh (3):
      event/cnxk: fix out-of-bounds access
      event/cnxk: advertise CN20K preschedule capabilities
      event/cnxk: fix new-event burst enqueue with LMTST

Prashant Gupta (2):
      net/dpaa: fix Rx queue shutdown before init
      bus/dpaa: fix channel and work queue decoding on shutdown

Pravin Pathak (1):
      event/dlb2: fix race condition during dynamic linking

Radu Nicolau (2):
      crypto/ipsec_mb: fix segmented out-of-place null cipher
      test/crypto: fix enqueue/dequeue callback case

Raghavendra Ningoji (9):
      raw/ntb: fix peer memory window count check
      raw/ntb: fix memory window bound in address remapping
      raw/ntb: fix memory window leaks
      raw/ntb: fix doorbell interrupts with VFIO MSI-X
      raw/ntb: fix Rx of incomplete packets
      raw/ntb: fix double free of Rx mbufs on stop
      raw/ntb: fix peer device status access
      raw/ntb: fix queue setup checks
      raw/ntb: fix queue leaks on setup

Rahul Bhansali (1):
      common/cnxk: fix NIX QINT count reset

Rita Ruvinsky (3):
      net/mana: fix MR length truncation for chunks over 4GB
      net/mana: fix double free of mbuf on Rx WQE post failure
      net/mana: fix Tx stall from queue space check

Robert Sanford (4):
      fib6: fix tbl8 index overflow
      rib: fix undefined behavior in left shifts
      fib: fix full table overwrite on address wraparound
      fib6: fix full table overwrite on address wraparound

Roman Khromenok (4):
      ethdev: fix out-of-bounds read of SFF-8636 thresholds
      ethdev: fix SFF-8472 external Rx power calibration
      ethdev: fix SFF-8472 calibration overflow
      app/procinfo: fix module EEPROM dump of multiple ports

Rongwei Liu (2):
      net/mlx5: fix aggregated affinity template validation
      net/mlx5: fix suffix groups without default FDB rule

Rupesh Chiluka (1):
      lpm: fix SVE bulk lookup loop bound for small bursts

Ryan Wolfe (2):
      net/gve: advertise Rx scatter in GQI queue format
      net/gve: reject MTU needing Rx scatter when disabled

Samar Yadav (1):
      net/virtio-user: fix eventfd sharing in secondary process

Sandeep Penigalapati (15):
      net/af_xdp: fix shared UMEM refcount corruption
      net/iavf: fix null dereference in eCPRI FDIR pattern
      net/ixgbe: fix spurious MACsec event on E610
      net/ixgbe: fix null dereference on EEPROM write for E610
      net/ixgbe: fix VF link status for E610
      net/failsafe: fix double release of sub-device port
      net/failsafe: fix queue release without sub-device op
      net/failsafe: fix MAC address pool size and replay
      net/failsafe: ignore unsupported link status update
      net/failsafe: fix Rx/Tx burst after sub-device removal
      net/iavf: fix minimum virtchnl API version log
      net/ice: fix DCF minimum virtchnl API version log
      doc: fix igb NIC speed
      doc: fix i40e guide
      doc: fix ixgbe guide

Serhii Iliushyk (2):
      net/ntnic: check virt queue hardware setup result
      net/ntnic: fix virt queue data in BSS

Shahaji Bhosle (1):
      net/bnxt/tf_ulp: fix ICMP L3 protocol match

Shaiq Wani (1):
      net/idpf: propagate PCI NUMA node to vport ethdev

Shrey Khandelwal (2):
      net/netvsc: update link speed when status is unchanged
      net/netvsc: fix link status not updated on host indication

Shuaisong Yang (2):
      net/hns3: fix hard-coded default value of UMV space
      common/mlx5: fix high SMMU TLB miss with mempool alignment

Shuanglin Wang (2):
      net/bnxt/tf_ulp: fix completion metadata type for Thor
      net/bnxt: fix Rx packet stall

Sid Ali Cherrati (2):
      net/i40e: fix close return
      net/ixgbe: fix close return

Sriram Yagnaraman (8):
      net/memif: guard against empty Tx burst
      net/memif: close file descriptor zero
      net/memif: do not close EAL-owned memseg FD
      net/memif: fix MAC address leak on probe failure
      net/memif: unwind partial device on create failure
      net/memif: refuse connection on stopped device
      net/memif: disconnect on device close
      net/memif: fix Tx count on invalid interrupt FD

Stephen Hemminger (43):
      eal/linux: filter uevent Netlink in kernel
      eal/linux: increase uevent socket buffer
      eal/linux: report uevent socket overrun
      net/mvpp2: fix out-of-range Tx queue stats write
      common/dpaax: fix unused variable in non-debug build
      bus/dpaa: remove unused variable
      net/qede: remove unused variable
      examples/qos_sched: fix unused variables
      examples/vhost: remove unused variables
      bus/fslmc: fix build of QBMan debug code
      bus/fslmc: fix signed comparison in buffer acquire
      crypto/caam_jr: fix descriptor dump build
      crypto/ipsec_mb: fix missing header for debug build
      power/amd_uncore: fix debug log build
      net/txgbe: validate numeric devargs
      test/hash: fix jhash 32-bit key type
      app/testpmd: revert stop forwarding in secondary process
      ipc: notify secondary on primary process exit
      eal: fail initialization if TSC frequency is zero
      power/amd_pstate: fix frequency matching on init
      drivers/power: check for errors when writing frequency
      test/power: fix nominal frequency check with amd-pstate
      examples/vm_power_manager: fix includes
      examples/vm_power_manager: fix vCPU number parsing
      examples/ethtool: fix exit flag
      net/memif: fix statistics
      net/memif: validate peer descriptors
      net/memif: validate control channel requests
      net/memif: validate descriptor length in zero-copy mode
      bus/vmbus: remove packed attribute from ring buffer
      bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
      bus/vmbus: fix missing acquire on receive ring index
      event/sw: fix unlinks in progress counter races
      bpf/x86: fix JIT encoding of fixed-width immediates
      bpf: mask shift count in interpreter per RFC 9669
      bpf/arm64: mask shift count per RFC 9669
      bpf: avoid uninitialized data warning
      net/mlx5: fix out-of-bounds stride index in vector Rx
      net/bnxt/tf_core: prevent buffer overflow in messages
      net/af_packet: check packet size after VLAN insertion
      bpf: fix index register for classic BPF indirect loads
      examples/qos_sched: fix build with LTO
      test: rewrite telemetry script in Python

Su Sai (2):
      net: fix raw checksum of multi-segments
      test/lpm6: fix delete time measurement

Sun Yuechi (1):
      crypto/openssl: fix SM2 encryption output length

Tathagat Priyadarshi (10):
      net/gve: fix DQO descriptor cleaning loop bound
      net/gve: fix DQO completion queue stall on unknown type
      net/gve: fix DQO Tx report event interval
      net/gve: add cacheline overlap margin to DQO Tx ring
      net/gve: fix Tx stall on invalid packets
      net/gve: export Tx drop counters in xstats
      net/gve: reject Tx packets that cannot fit in the ring
      net/gve: enforce DQO Tx packet length limits
      net/gve: enforce DQO TSO header and length limits
      net/mana: fix Tx burst error handling

Tengfei Zhang (5):
      net/txgbe: fix FDIR devarg integer width
      net/txgbe: fix use-after-free in flow destroy
      net/txgbe: fix flow creation failure for L2 tunnel
      net/txgbe: fix filter leak on flow creation failure
      net/txgbe: fix FDIR error handling in flow creation

Thomas Monjalon (2):
      doc: fix API comments for Doxygen 1.18.0
      ipc: fix multi-process disabling

Viacheslav Ovsiienko (1):
      common/mlx5: fix overlapping memory ranges

Vladimir Medvedkin (1):
      fib6: fix temporary tbl8 for byte-aligned prefixes

Wei Chen (1):
      cfgfile: fix undefined behavior in whitespace stripping

Wei Yan (1):
      net/mlx5: avoid wildcard drop flow in priority discovery

Weijun Pan (1):
      net/vhost: preserve Tx ownership on VLAN failure

William Bland (1):
      net: fix VLAN insert doc for shared-mbuf error code

Yang Xiaoliang (3):
      doc: fix typo in ipsec_secgw guide
      examples/skeleton: fix typo in initialization comment
      doc: fix typo in l3fwd guide

Yonghao Li (1):
      eal/x86: fix LZCNT CPU flag

Zaiyu Wang (2):
      net/txgbe: set I2C SDA hold time
      net/txgbe: remove stale outer UDP checksum flag

Zhang Tengfei (5):
      net/ixgbe: fix DCB Rx buffer size on X540 and E610
      net/txgbe: fix Rx packet buffer size with flow director
      net/txgbe: do not enable flow director on flow validate
      net/txgbe: disable flow director when no rule is left
      net/txgbe: keep flow rules per port
