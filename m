Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDFC369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 19:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC66402F1;
	Tue,  8 Apr 2025 21:13:15 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 01F164027F;
 Tue,  8 Apr 2025 21:13:14 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id CDA834026B
 for <announce@dpdk.org>; Tue,  8 Apr 2025 21:13:11 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso5246428f8f.2
 for <announce@dpdk.org>; Tue, 08 Apr 2025 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744139591; x=1744744391; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=854jaHajWEKvG0csHPTKyRGEcOtL1diswM4IRgomdX4=;
 b=XRjZne64GE7RdC/OSffYLEDLyyQBkPAlLHb/c8YVYe1lnXhfD6ghuWDxS3vo/kvtjL
 vdy3TNZCHkLqRdUQxyTRw+t5qKvPFAc/KUJzzxF8xRFJBlcjG/c8thaeirv/X067ZvT8
 EVaJahsn+OeAdMTfxaugq770lbc8bD9rt97UTy4ccQIbhNTKqRVmXJF1JSAkDWhO6sy3
 g3fYpg8e2qtld9QgpcJN3GnsMGehUuo8wyePK/dIvOx2wfZoW0n2ekvhH4E3xWk1X3ML
 2fFeDFtzGMxijJqzkqvKJDYdFVeo9qlvm8L3AeBxeUTo7Z+Q9/oyqsL1oZXRngGskrvY
 698A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744139591; x=1744744391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=854jaHajWEKvG0csHPTKyRGEcOtL1diswM4IRgomdX4=;
 b=Y7xQa2xy7317KfhUiumTLAIGg1ti/qW2B92kqKn/93weMLOZhtTn6pPkzl179B+mi4
 IJWAgkywukA1Fb2ZRzhgjR2VkJhwZuWR0bWCLZ+YuYiG6+nesX7bHq75sjHoeYsC0knZ
 b0T+8L5cWk3MHTj7KNQ3Fa78/1jyTxHfgzBNct/uq96tz0qtTbuguom3h0ZonrNx50fr
 tY+rObTHUTnzg+tYtE27HfhEUkTpFrQ8MmvybGmwTxZNMmm4SNc18NX38epLSqfU5IT/
 5ErtC+VKckv6Z6tUm7+Ao4zJLqj3RU3w3lCkFmqZtNRNNk4eXckuTnmVMV+d7bPTjFvq
 7x5g==
X-Gm-Message-State: AOJu0YzpNqEklL2yr0CdqRBBIFGoYmbiD5NF6qiWHKhOQyG443VZNUXr
 RcDSaoEqn0nPmhWm2xsl8z3L6xSdpeUn7hL4enwybM4eQe1Ax95d4RVHFN6I
X-Gm-Gg: ASbGncscG3RrUtyRv5TqkO340h8Y7Yi/YzHSr9DKAymAC1nOtm7nSvURAQ0Nt0Toni2
 YGPF3Y44j/fl3HEl01dCfAbCGn6QKHQ6f43ZFvOC+PQvYTaaIyR7EKncrSTbM6bZ8MU7gogF8cl
 /yPmZwqL8NVgF6E3gTiBRNhwOO6S6sRvH8AluQTTu4T9bPYvUin2SRTFvt1KzIz0HTLHLWAVSGq
 xh+caC9yzKXRPfH1KYj+WeQh5g0iAah6RKxv5PpCsYfKuATSY4h7V8glaeXlGKzKPxdoSK7CuwG
 ThFfxbrSjXv/RYOCeFfnsvifOh/oNN/UZOI1LYBsIXrIpTIYxw==
X-Google-Smtp-Source: AGHT+IEehBPzxuC+L0h6HmIJ/iPKKApkq1MHwv6E0WWOUSrWcFel8gvXDF960ZxLBgDY+F20npyDsg==
X-Received: by 2002:a05:6000:250d:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-39d87aa7edfmr345061f8f.19.1744139590926; 
 Tue, 08 Apr 2025 12:13:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9f00:cbd:8eb8:2aef])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43f0e5e8dfasm35651155e9.27.2025.04.08.12.13.10
 for <announce@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 12:13:10 -0700 (PDT)
From: luca.boccassi@gmail.com
To: announce@dpdk.org
Subject: DPDK 22.11.8 released
Date: Tue,  8 Apr 2025 20:13:06 +0100
Message-ID: <20250408191308.700112-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
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

Here is a new stable release:
	https://fast.dpdk.org/rel/dpdk-22.11.8.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=22.11

Luca Boccassi

---
 .github/workflows/build.yml                 |   2 +-
 .mailmap                                    |  17 +-
 VERSION                                     |   2 +-
 app/test-bbdev/test_vectors/fft_9.data      | 870 ----------------------------
 app/test-bbdev/test_vectors/fft_byp_28.data |  48 +-
 app/test-pmd/cmdline.c                      |  65 ++-
 app/test-pmd/cmdline_flow.c                 |  31 +-
 app/test-pmd/config.c                       |   4 +-
 app/test/test_bpf.c                         |   2 +-
 app/test/test_cryptodev.c                   |  29 +-
 app/test/test_cryptodev.h                   |   1 -
 app/test/test_cryptodev_aes_test_vectors.h  |   6 +-
 app/test/test_dmadev_api.c                  |  16 +-
 app/test/test_event_eth_rx_adapter.c        |   2 +-
 app/test/test_link_bonding.c                |  73 ++-
 app/test/test_pcapng.c                      |   2 +-
 app/test/test_ring_stress_impl.h            |   2 +-
 buildtools/get-numa-count.py                |   2 +-
 config/meson.build                          |  13 +-
 devtools/check-meson.py                     |   2 +-
 doc/guides/nics/e1000em.rst                 |   5 +
 doc/guides/nics/features.rst                |   1 +
 doc/guides/nics/features/gve.ini            |   1 +
 doc/guides/nics/features/mana.ini           |   1 -
 doc/guides/nics/features/netvsc.ini         |   1 -
 doc/guides/nics/features/virtio.ini         |   1 -
 doc/guides/nics/features/vmxnet3.ini        |   1 -
 doc/guides/nics/igb.rst                     |  12 +
 doc/guides/nics/igc.rst                     |   5 +
 doc/guides/nics/ionic.rst                   |  16 +-
 doc/guides/nics/ixgbe.rst                   |  22 +-
 doc/guides/prog_guide/rte_flow.rst          |   2 +-
 doc/guides/rel_notes/release_22_11.rst      | 226 ++++++++
 drivers/bus/pci/pci_common.c                |  14 +-
 drivers/common/cnxk/cnxk_security.c         |   2 +-
 drivers/common/cnxk/roc_bphy_cgx.c          |  12 +-
 drivers/common/cnxk/roc_dpi_priv.h          |   2 +-
 drivers/common/cnxk/roc_npa.h               |   2 +-
 drivers/crypto/cnxk/cnxk_se.h               |   2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |   8 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c          |   7 +-
 drivers/crypto/openssl/rte_openssl_pmd.c    |  13 +-
 drivers/crypto/virtio/virtio_cryptodev.c    |  14 +-
 drivers/crypto/virtio/virtio_rxtx.c         |   3 +-
 drivers/event/dpaa/dpaa_eventdev.c          |  10 +-
 drivers/net/af_packet/rte_eth_af_packet.c   |  30 +-
 drivers/net/bnxt/bnxt_ethdev.c              |  22 +-
 drivers/net/bnxt/tf_core/tf_sram_mgr.c      |   4 +-
 drivers/net/bonding/rte_eth_bond_8023ad.h   |   3 +
 drivers/net/bonding/rte_eth_bond_pmd.c      |  24 +-
 drivers/net/cnxk/cn10k_tx.h                 |   7 +-
 drivers/net/cnxk/cn9k_tx.h                  |   7 +-
 drivers/net/cxgbe/cxgbe_flow.c              |  14 +-
 drivers/net/dpaa/dpaa_rxtx.c                |   7 +-
 drivers/net/dpaa2/dpaa2_flow.c              |  14 +-
 drivers/net/dpaa2/dpaa2_rxtx.c              |   6 +-
 drivers/net/e1000/base/e1000_80003es2lan.c  |   2 +-
 drivers/net/e1000/base/e1000_82575.c        |   5 +-
 drivers/net/e1000/base/e1000_base.c         |   3 +-
 drivers/net/e1000/base/e1000_defines.h      |   1 +
 drivers/net/e1000/base/e1000_ich8lan.c      |   2 +
 drivers/net/e1000/base/e1000_mac.c          |  12 +-
 drivers/net/e1000/base/e1000_nvm.c          |   4 +-
 drivers/net/e1000/base/e1000_phy.c          |  25 +-
 drivers/net/e1000/base/e1000_vf.c           |  12 +-
 drivers/net/e1000/em_ethdev.c               |  80 +++
 drivers/net/e1000/igb_ethdev.c              | 176 ++++++
 drivers/net/enetfec/enet_ethdev.c           |   1 -
 drivers/net/hinic/hinic_pmd_flow.c          |  14 +-
 drivers/net/hns3/hns3_cmd.c                 |  18 +-
 drivers/net/hns3/hns3_cmd.h                 |   4 +-
 drivers/net/hns3/hns3_dump.c                |   4 +
 drivers/net/hns3/hns3_ethdev.c              |  29 +-
 drivers/net/hns3/hns3_intr.c                |   4 +-
 drivers/net/hns3/hns3_intr.h                |   2 +-
 drivers/net/hns3/hns3_rxtx.c                |   2 +-
 drivers/net/i40e/i40e_fdir.c                |  10 +-
 drivers/net/i40e/i40e_rxtx_vec_avx2.c       |   2 +-
 drivers/net/i40e/i40e_rxtx_vec_avx512.c     |   6 +-
 drivers/net/i40e/meson.build                |   3 +
 drivers/net/iavf/iavf_ethdev.c              |  15 +-
 drivers/net/iavf/iavf_rxtx.c                |   6 +-
 drivers/net/iavf/iavf_rxtx.h                |   2 +
 drivers/net/iavf/iavf_rxtx_vec_avx2.c       |   2 +-
 drivers/net/iavf/iavf_rxtx_vec_neon.c       |   8 +-
 drivers/net/ice/ice_ethdev.c                |   4 +
 drivers/net/ice/ice_rxtx.c                  |  10 +
 drivers/net/ice/ice_rxtx_vec_avx2.c         |   2 +-
 drivers/net/idpf/idpf_rxtx_vec_avx512.c     |   6 +-
 drivers/net/igc/base/igc_defines.h          |   1 +
 drivers/net/igc/base/igc_i225.c             |  24 +-
 drivers/net/igc/base/igc_mac.c              |  10 +-
 drivers/net/igc/base/igc_nvm.c              |   4 +-
 drivers/net/igc/base/igc_phy.c              |   8 +-
 drivers/net/igc/igc_ethdev.c                |  81 +++
 drivers/net/ixgbe/ixgbe_ethdev.c            | 242 ++++++++
 drivers/net/ixgbe/ixgbe_rxtx.h              |   2 +-
 drivers/net/mana/mana.c                     | 100 ++--
 drivers/net/mana/mana.h                     |   6 +-
 drivers/net/mana/mp.c                       |   2 +-
 drivers/net/mlx4/mlx4_flow.c                |   6 +-
 drivers/net/mlx5/hws/mlx5dr_definer.c       |  26 +-
 drivers/net/mlx5/hws/mlx5dr_definer.h       |  18 +-
 drivers/net/mlx5/linux/mlx5_os.c            |   5 +
 drivers/net/mlx5/mlx5_flow.c                |  19 +-
 drivers/net/mlx5/mlx5_flow.h                |   2 +-
 drivers/net/mlx5/mlx5_flow_dv.c             |  63 +-
 drivers/net/mlx5/mlx5_flow_hw.c             | 100 ++--
 drivers/net/mlx5/mlx5_hws_cnt.c             |   5 +-
 drivers/net/mlx5/mlx5_rxtx.c                |  80 +++
 drivers/net/mlx5/mlx5_rxtx_vec.c            |   3 +
 drivers/net/mlx5/mlx5_trigger.c             |  24 +-
 drivers/net/netvsc/hn_ethdev.c              |  29 +-
 drivers/net/netvsc/hn_vf.c                  |  13 +-
 drivers/net/nfp/nfp_flow.c                  |  14 +-
 drivers/net/qede/base/ecore_dcbx.c          |   8 +-
 drivers/net/qede/qede_debug.c               |   5 +
 drivers/net/sfc/sfc_repr.c                  |   4 -
 drivers/net/tap/tap_flow.c                  |  30 +-
 drivers/net/thunderx/base/nicvf_mbox.c      |  42 +-
 drivers/net/txgbe/base/txgbe_phy.c          |   8 +-
 drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c  |  24 +-
 examples/ipsec-secgw/event_helper.c         |   2 +-
 examples/ipsec-secgw/sa.c                   |   4 +-
 examples/l3fwd-power/main.c                 |   4 +-
 examples/l3fwd/main.c                       |   5 +-
 examples/ptpclient/ptpclient.c              |   2 +-
 lib/eal/common/eal_common_devargs.c         |   2 +-
 lib/eal/common/eal_common_lcore.c           |  17 +-
 lib/eal/linux/eal_dev.c                     |   3 -
 lib/eal/linux/eal_memory.c                  |   1 +
 lib/eal/x86/include/rte_vect.h              |   4 -
 lib/ethdev/rte_ethdev.c                     |  14 +-
 lib/ethdev/rte_ethdev.h                     |   8 +-
 lib/ethdev/rte_flow.h                       |  44 +-
 lib/mempool/rte_mempool.c                   |   4 +-
 lib/pdump/rte_pdump.c                       |   3 +
 lib/stack/rte_stack_lf_c11.h                |   2 +-
 lib/vhost/vhost.c                           |   5 +-
 lib/vhost/vhost_user.c                      |   4 +-
 lib/vhost/virtio_net.c                      |  13 +
 141 files changed, 1809 insertions(+), 1526 deletions(-)
Aleksandr Loktionov (2):
      net/igc/base: fix MAC address hash bit shift
      net/e1000/base: fix MAC address hash bit shift

Amir Avivi (2):
      net/igc/base: fix iterator type
      net/e1000/base: fix iterator type

Anatoly Burakov (3):
      net/e1000/base: correct mPHY access logic
      net/e1000: fix crashes in secondary processes
      net/ixgbe: fix crashes in secondary processes

Andre Muezerie (5):
      eal/x86: fix some intrinsics header include for Windows
      net/bnxt: fix indication of allocation
      common/idpf: fix void function returning a value
      net/intel: fix void functions returning a value
      stack: fix pop in C11 implementation

Andrew Boyer (1):
      doc: update ionic driver guide

Ariel Otilibili (5):
      net/sfc: remove unnecessary assignment
      net/enetfec: remove useless assignment
      use Python raw string notation
      eal/linux: remove useless assignments
      mempool: fix errno in empty create

Arkadiusz Kusztal (2):
      test/crypto: fix check for OOP header data
      app/test: fix a merge problem in oop patch

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
      net/mlx5: fix leak in HWS flow counter action
      ci: point at GitHub mirror

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

Ferruh Yigit (1):
      ethdev: convert string initialization

Gavin Hu (1):
      net/mlx5: fix polling CQEs

Gowrishankar Muthukrishnan (3):
      crypto/virtio: fix data queues iteration
      examples/vhost_crypto: fix user callbacks
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

Konstantin Ananyev (1):
      test/ring: fix init with custom number of lcores

Long Li (3):
      net/netvsc: scan all net devices under the PCI device
      net/netvsc: remove device if its net devices removed
      net/mana: fix multi-process tracking

Long Wu (1):
      net/bonding: fix dedicated queue setup

Luca Boccassi (3):
      version: 22.11.8-rc1
      Revert "examples/vhost_crypto: fix user callbacks"
      version: 22.11.8

Maayan Kashani (7):
      net/mlx5: adjust actions per rule limitation
      net/mlx5: fix flush of non-template flow rules
      net/mlx5: fix GRE flow match with SWS
      net/mlx5: fix LACP packet handling in isolated mode
      net/mlx5/hws: fix crash using represented port without ID
      net/mlx5/hws: fix GTP flags matching
      net/mlx5: fix GRE matching on root table

Matthew Smith (1):
      net/ice: fix dropped packets when using VRRP

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
      build: force GCC 15 to initialize padding bits
      raw/cnxk_gpio: fix file descriptor leak
      net/i40e: remove duplicate code
      eal: fix devargs layers parsing out of bounds
      net/qede: fix debug messages array
      examples/ptpclient: fix message parsing
      net/hinic: fix flow type bitmask overflow
      crypto/dpaa2_sec: fix bitmask truncation
      crypto/dpaa_sec: fix bitmask truncation
      event/dpaa: fix bitmask truncation
      net/dpaa: fix bitmask truncation
      net/dpaa2: fix bitmask truncation
      net/qede: fix nested loops
      examples/l3fwd: fix socket ID check
      common/cnxk: fix null check
      test/bonding: fix active backup receive test
      doc: fix feature flags for queue start/stop
      app/testpmd: fix out-of-bound reference in offload config
      pdump: clear statistics when enabled

Tejasree Kondoj (1):
      examples/ipsec-secgw: fix cryptodev and eventdev IDs

Tudor Cornea (1):
      net/af_packet: fix socket close on device stop

Vamsi Attunuru (1):
      common/cnxk: fix DPI mailbox structure

Viacheslav Ovsiienko (1):
      net/mlx5: fix hardware packet type translation

Vladimir Medvedkin (1):
      net/ice: fix memory leak in scalar Rx

Wathsala Vithanage (1):
      crypto/openssl: fix CMAC auth context update

Yang Ming (2):
      eal/linux: fix memseg length in legacy mem init
      net/iavf: fix mbuf release in Arm multi-process

Yunjian Wang (2):
      vhost: check GSO size validity
      vhost: check descriptor chains length

Zaiyu Wang (1):
      net/txgbe: remove useless condition for SW-FW sync
