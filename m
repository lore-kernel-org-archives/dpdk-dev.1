Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D43D1CDB7
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 00:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFADB4029D;
	Thu,  4 Dec 2025 01:56:12 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 84B064027D
 for <dev@dpdk.org>; Thu,  4 Dec 2025 01:56:11 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso2359925e9.2
 for <dev@dpdk.org>; Wed, 03 Dec 2025 16:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764809771; x=1765414571; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hiI8/wmngMY0cY+/1+sc46+Cah7Nb43yNAN2wv7kWW8=;
 b=E6vrxxrgXEIJEKltYY/byDjGzZ3Qp/spC4D20mFXp5NNsZKODKgKqWiYIBiiLQKaqt
 RJuYNPjDQNqCZuf5QmiF6P5SX+bVAO+Y4bvqG1zx/w2Jur6comTRERrtYZFW+nP+HwKt
 7ZSM6aoWdELyvLaWAmS5ci7lk3H/sx8COiz66Eb7q2GK2kweTkj0KfoOGK6+POpcFpOi
 Z3XsHfPUD7f5XtKjDK9UJa50UWSo2VIlN1NhutETUpMHA7PcsXs5t7wUSLo4MX7aWXwo
 GAqUXCeCVVmX6SKlcpOvEzLSucosPqbDbYgDeozLpOANcxOlglgxUWvAnJ7uPA+PISHA
 DD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764809771; x=1765414571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiI8/wmngMY0cY+/1+sc46+Cah7Nb43yNAN2wv7kWW8=;
 b=IpCe+wPWeKEMMvE+l8oo4WdXSLkTDY04+brBKpMdE7rHcw2LoTIVgapDenWTecEj13
 9W222y6w3OjSB5PMLkBe6eA/I2VfjJMygSRgHvpkpHNpgT3/hZf8fZi/dRyp22Ef7eEi
 qFRhJOMo56gTOhht8Bi506JPNNMHPLv0rNTa7eejPR/2Zrss0+OwFO8UYFEanIlAnTKp
 gc7GkSGsrpGVioju8/Gu3sJgmoh1lfAdLAuYzYG9lodIWWZA64WO2Wmcq/R7cnK7o9ht
 scYaRfu+gHgiBPpTaV4zcJsZNxq+CVrnLv772jsr7ftH5oAiRXH0B/nCo5h4nf2o2yph
 V28w==
X-Gm-Message-State: AOJu0Yy1EhYFTeZNhF0gLIE3rHv4p9BknrV/FKCI8jFEQRNM3v2N/lU8
 peMgMP9ad3YlRaI+HsVJ1dSZuYkM74wqU37ISVqGibBXlUJkkSZRI3m7
X-Gm-Gg: ASbGnctWA1jhGskFX8RVQd/xdJKbNFB/MtrwwoAs98X7R9ktPbfrUczkjNEAuRuqAKX
 nih0SWwS/2pRkrPDHsdE5bDVoFFKPdbjD+wozusQLFRJKU8fF+TBecEriNoglYp46Za0lj4y6+w
 kr1T0nUbCCi1aDeFwxgxpTef8RnB4rFkueBaTlfHIaENMFPf3FUONP14zJdcK40X7InrqN02v1p
 ga+DcnDOUC7fOAxlqH2/fmcCnCjnPLyWSnw2WvktiohX8IPOlYKUr9P8Itnsw/Z+XXaTYoupwyN
 LKnaawVt1DRVGsWTJV4caNrY26yRjsRCJSJ1mrVEELUrvur3GRNQOHJCB+5ymMFAjMh/xDZkPuF
 CibNLYMihgmKn3WXGJLTENFw1EB+T6IEKrqU4fULafOFRW4zmiU4QFXHKb8m0RDiuUgMYX9O/2p
 GEdyfU0gXdprhYflA3I0d6JYAPoQw=
X-Google-Smtp-Source: AGHT+IFJdRPVdj4GO+IDuiuFqVEWht7RJESXbGT2xQffkHr1o6LpKBbAVmFgn/qcETXS5jotkXO/Hg==
X-Received: by 2002:a05:6000:2288:b0:42b:40b5:e681 with SMTP id
 ffacd0b85a97d-42f731870eemr4216474f8f.26.1764809770707; 
 Wed, 03 Dec 2025 16:56:10 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:30ab:fcfb:e19f:e47d])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42f7d353f80sm72541f8f.41.2025.12.03.16.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 16:56:09 -0800 (PST)
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
Subject: 22.11.11 patches review and test
Date: Thu,  4 Dec 2025 00:56:02 +0000
Message-ID: <20251204005603.3236032-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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

Here is a list of patches targeted for stable release 22.11.11.

The planned date for the final release is December 18th.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.11-rc1

These patches are located at branch 22.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Aarnav JP (1):
      net/cnxk: fix default meter pre-color

Adrian Schollmeyer (1):
      net/mlx5: store MTU at Rx queue allocation time

Amiya Ranjan Mohakud (1):
      net/vmxnet3: disable RSS for single queue for ESX8.0+

Anatoly Burakov (3):
      net/ice: remove indirection for FDIR filters
      net/ice: fix memory leak in raw pattern parse
      vfio: fix custom containers in multiprocess

Andrew Boyer (1):
      doc: add Pollara 400 device in ionic guide

Anurag Mandal (1):
      net/i40e: fix symmetric Toeplitz hashing for SCTP

Bing Zhao (1):
      app/flow-perf: fix rules array length

Brick Yang (2):
      net/dpaa2: fix L3/L4 checksum results
      net/dpaa2: receive packets with additional parse errors

Bruce Richardson (8):
      net/intel: fix assumption about tag placement order
      net/ice: fix initialization with 8 ports
      ethdev: fix VLAN filter parameter description
      net/ice: fix vector Rx VLAN offload flags
      net/fm10k: fix build with GCC 16
      app/pdump: remove hard-coded memory channels
      net/ice: fix path selection for QinQ Tx offload
      net/iavf: revert check for PF Rx timestamp support

Chengwen Feng (5):
      dma/hisilicon: fix stop with pending transfers
      test/dma: fix failure condition
      net/hns3: fix overwrite mbuf in vector path
      app/testpmd: fix DCB Tx port
      app/testpmd: fix DCB Rx queues

Chinh Cao (1):
      net/ice/base: fix integer overflow on NVM init

Ciara Loftus (3):
      doc: fix feature list of ice driver
      doc: fix feature list of iavf driver
      net/e1000/base: fix crash on init with GCC 13

Dariusz Sosnowski (6):
      app/testpmd: fix conntrack action query
      net/mlx5: fix min and max MTU reporting
      net/mlx5: fix indirect flow age action handling
      net/mlx5: fix Direct Verbs counter offset detection
      net/mlx5: fix indirect RSS action hash
      net/mlx5: fix error reporting on masked indirect actions

David Marchand (21):
      eal: fix plugin dir walk
      cmdline: fix port list parsing
      cmdline: fix highest bit port list parsing
      tailq: fix lookup macro
      hash: fix unaligned access in predictable RSS
      graph: fix unaligned access in stats
      eventdev: fix listing timer adapters with telemetry
      cfgfile: fix section count with no name
      baseband/acc: fix exported header
      gpudev: fix driver header for Windows
      drivers: fix some exported headers
      test/debug: fix crash with mlx5 devices
      net/tap: fix build with LTO
      eventdev/crypto: fix build with clang 21
      rawdev: fix build with clang 21
      net/dpaa2: remove ethdev pointer from bus device
      bus/ifpga: fix const pointer in device name parsing
      crypto/caam_jr: fix const pointer in UIO filename parsing
      net/enetfec: fix const pointer in UIO filename parsing
      net/memif: fix const pointer in socket check
      app/procinfo: fix const pointer in collectd format

Dengdui Huang (4):
      app/testpmd: increase size of set cores list command
      net/hns3: fix inconsistent lock
      net/hns3: fix VLAN resources freeing
      net: fix L2 length for GRE packets

Emma Finn (1):
      crypto/qat: fix CCM request descriptor hash state size

Gagandeep Singh (1):
      net/dpaa2: fix shaper rate

Gavin Li (1):
      net/mlx5: fix multicast

Gowrishankar Muthukrishnan (1):
      crypto/virtio: fix cookies leak

Gregory Etelson (5):
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

Jacob Keller (3):
      net/ice/base: fix memory leak in HW profile handling
      net/iavf: fix check for PF Rx timestamp support
      net/iavf: fix Rx timestamp validity check

Jerin Jacob (2):
      net/iavf: fix build with clang 21
      lib: fix backticks matching in Doxygen comments

Jiawen Wu (14):
      net/txgbe: reduce memory size of ring descriptors
      net/ngbe: reduce memory size of ring descriptors
      net/txgbe: fix VF Rx buffer size in config register
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
      doc: add device arguments in txgbe guide

John Miller (1):
      net/ark: remove double mbuf free

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

Maayan Kashani (5):
      net/mlx5: fix unsupported flow rule port action
      net/mlx5: fix non-template age rules flush
      net/mlx5: fix modify field action restriction
      net/mlx5: fix device start error handling
      app/testpmd: fix flex item link parsing

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

Pavan Nikhilesh (1):
      event/cnxk: fix Rx offload flags

Prashant Gupta (1):
      net/dpaa2: fix uninitialized variable

Praveen Kaligineedi (1):
      net/gve: allocate Rx QPL pages using malloc

Radu Nicolau (2):
      crypto/qat: fix source buffer alignment
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

Rongwei Liu (2):
      net/mlx5: fix flow aging race condition
      net/mlx5: fix indirect meter index leak

Shai Brandes (2):
      net/ena: fix PCI BAR mapping on 64K page size
      net/ena/base: fix unsafe memcpy on invalid memory

Shaiq Wani (1):
      net/ice/base: fix adding special words

Shani Peretz (5):
      eal: fix DMA mask validation with IOVA mode option
      net/mlx5: fix MTU initialization
      app/crypto-perf: fix plaintext size exceeds buffer size
      net/bonding: fix MAC address propagation in 802.3ad mode
      net/mlx5: fix Tx metadata pattern template mismatch

Sivaprasad Tummala (1):
      examples/l3fwd-power: fix telemetry command registration

Stephen Hemminger (6):
      dmadev: fix debug build with tracepoints
      pdump: handle primary process exit
      net/mlx5: fix uninitialized variable
      examples/server_node_efd: fix format overflow
      examples/vdpa: fix format overflow
      bus/fslmc: fix const pointer in device name parsing

Sucharitha Sarananaga (1):
      crypto/cnxk: refactor RSA verification

Sunil Kumar Kori (1):
      common/cnxk: fix max number of SQB buffers in clean up

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

Vanshika Shukla (2):
      net/enetfec: fix out-of-bounds access in UIO mapping
      net/dpaa: fix resource leak

Venkat Kumar Ande (1):
      net/axgbe: fix build with GCC 16

Viacheslav Ovsiienko (2):
      net/mlx5: fix ESP header match after UDP for group 0
      net/mlx5: fix control flow leakage for external SQ

Vladimir Medvedkin (1):
      fib6: fix tbl8 allocation check logic

Wathsala Vithanage (4):
      ring: establish safe partial order in default mode
      ring: establish a safe partial order in hts-ring
      ring: establish safe partial order in RTS mode
      eal: correct memory ordering in MCS lock

Xingui Yang (1):
      net/hns3: fix VLAN tag loss for short tunnel frame

Yang Ming (2):
      eal: fix MP socket cleanup
      crypto/ipsec_mb: fix QP release in secondary

Yunjian Wang (1):
      vhost: fix double fetch when dequeue offloading

Zhichao Zeng (1):
      net/ice: fix statistics
