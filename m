Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBCCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 18:43:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC11B40662;
	Tue, 19 Aug 2025 20:43:47 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 2D562402DD;
 Tue, 19 Aug 2025 20:43:46 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 01C4B4021E
 for <announce@dpdk.org>; Tue, 19 Aug 2025 20:43:44 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso5946507f8f.0
 for <announce@dpdk.org>; Tue, 19 Aug 2025 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755629024; x=1756233824; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L9s3P9b3gJDAveMq2Rv0gLjvbxLfsSdx0sD3rMWIbeE=;
 b=cF9HT6M93LeugkFp4LWy61xFQYHR/InjzZJrQJdyZMJmA1/1+HH2SxDCR2leVBp7UI
 0RmHpberW6Dm4jYXBkAFp6mJGLI7hwRsasJodaWmZ8dlh13VcI5EM44aTf22EnF4t309
 vVarZl9MoWSTa7UTm5qt2MwRgD23rSDWjQWidNzh+pHSmMTp1LAaIa840rhs821IAsK8
 QC2TE8fG4w7J9zJJPBWgcoFI7yLIE485cC2hCKJu9uHDmGkR/PrYE+63IZRPKpzdJjdj
 5YKXfScVoEKnuVMz/aNS6P26vHA6mw2pUON1eK0zDZF11rs0ShdtgJN/yhLWtPvf9USP
 ljHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755629024; x=1756233824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L9s3P9b3gJDAveMq2Rv0gLjvbxLfsSdx0sD3rMWIbeE=;
 b=sOZu6iZuVeHaBRFOOf/fIPuYuVH9EilehWGf/BKzx7ysHj+67+jy/qRnrhRUVccdNU
 qem1B/FVlSRVsnwxkkry0Ci4ZFsUjWEJOnD+2RpGJImRBvbaQPjTMGmK4gj7sPYgnBWo
 Mb49XaFsviE2Ey7RnRzf6TgRrwWNB1xxrBSNhkwb15gxlL/3EDyFAkwFRXP6GXHY0zdJ
 aW367Pd553q2XtFgp/dOyNJgJn+TvQu7m8rQnGfNQBTFkazlSwK/Bi5PKfUbWCX1re9L
 V9m5xf0ORdJVrUA7ed5oHiN/XVBPn9k+W0szcqZTPGwRTHogNTTDwsWXWVQKMcsk1BEv
 Q2Zw==
X-Gm-Message-State: AOJu0Ywijp/UZbfAB7gM2ZEvAAJenObnmgqBIzLE6YGzKWH4oH9GhK7M
 /GSPG0Oi4v1Izq07Oviv2mn4syvmJahA40j/p4sH5u5g5rYIDMaLrQ9tckXFQOOR
X-Gm-Gg: ASbGncsUtQXCZhPfEgXxhIXdgSqCN0IoiwRJ5Mfuwwy2sUX1M3/WfAJnYXbsK/DhM8c
 zVN99gjyEcLyxynj+9ya24vCNoMMagMkA7ufwvNXeAjHL2tNUwYcuwZKgKBNXHWvfcho73T0MiG
 X2JdX4JSD8xgqumjder32qccMkqjTNAyNLp35I4LgIFdmEWQEQAvae9wzD1uVXSj45Xr14B06O8
 VTLRxtVgca8E41UUYq52PovcJTH8aRngGR9fHgLC8WJKI7uaylxHqLLWqnV2avkWZjPYRU0I9WU
 1Oojv7Voz8ocncZc+8tCV3Fu2f7tj2PoPi5rWR2AYYiHo76Als88AsLAPfo4EI+/lG5H+f8PxgH
 a/9Z/nXVKPER9iuazKFAXh30zVhMzelpbCGCmHA==
X-Google-Smtp-Source: AGHT+IHVx5jvX6sPY9498Npu4orqWtPAgEgSzDONsh7sj3jb+7rQKMRfzHKGzx5HFsY53+bo6EiP/g==
X-Received: by 2002:a05:6000:144a:b0:3b7:8abc:eba2 with SMTP id
 ffacd0b85a97d-3c32ca072e5mr66061f8f.20.1755629023732; 
 Tue, 19 Aug 2025 11:43:43 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4186:c02:aa0c:7609])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3c0754f3b7esm4414775f8f.30.2025.08.19.11.43.42
 for <announce@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:43:43 -0700 (PDT)
From: luca.boccassi@gmail.com
To: announce@dpdk.org
Subject: DPDK 22.11.9 released
Date: Tue, 19 Aug 2025 19:43:31 +0100
Message-ID: <20250819184337.570772-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	https://fast.dpdk.org/rel/dpdk-22.11.9.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=22.11

Luca Boccassi

---
 .github/workflows/build.yml                       |  49 +-
 .mailmap                                          |   6 +
 VERSION                                           |   2 +-
 app/test-crypto-perf/cperf_ops.c                  |   4 +-
 app/test-eventdev/test_perf_common.c              |   4 +-
 app/test-eventdev/test_pipeline_common.c          |   4 +-
 app/test-pmd/cmdline.c                            |   4 +-
 app/test-pmd/config.c                             |   3 +-
 app/test/test_cryptodev.c                         |   3 +
 app/test/test_cryptodev.h                         |   6 +-
 app/test/test_cryptodev_asym.c                    |  21 +-
 app/test/test_malloc.c                            |  77 +-
 config/arm/meson.build                            |  23 +-
 doc/guides/freebsd_gsg/build_sample_apps.rst      |   4 -
 doc/guides/linux_gsg/build_sample_apps.rst        |   4 -
 doc/guides/nics/features/txgbe.ini                |   2 +
 doc/guides/rel_notes/release_22_11.rst            | 235 ++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst       |   2 +-
 drivers/bus/auxiliary/auxiliary_common.c          |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c          |  10 +-
 drivers/bus/pci/bsd/pci.c                         |  17 +-
 drivers/bus/pci/pci_common.c                      |   1 +
 drivers/bus/vdev/vdev.c                           |   1 +
 drivers/bus/vmbus/bus_vmbus_driver.h              |   4 +
 drivers/bus/vmbus/linux/vmbus_uio.c               |   2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h                 |   9 +-
 drivers/bus/vmbus/vmbus_bufring.c                 |   9 +-
 drivers/bus/vmbus/vmbus_common_uio.c              |   2 +-
 drivers/common/cnxk/roc_cpt.c                     |   5 +
 drivers/common/cnxk/roc_nix.h                     |   2 +
 drivers/common/cnxk/roc_nix_inl.c                 |   4 +-
 drivers/common/cnxk/roc_nix_queue.c               |  11 +-
 drivers/common/cnxk/roc_npc.c                     |   5 +-
 drivers/common/cnxk/roc_npc_parse.c               |   2 +-
 drivers/common/dpaax/caamflib/desc/pdcp.h         |  22 +-
 drivers/common/mlx5/linux/mlx5_common_auxiliary.c |  11 +-
 drivers/common/mlx5/mlx5_prm.h                    |   1 +
 drivers/crypto/mlx5/mlx5_crypto.c                 |   2 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c      |   6 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c      |  13 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c      |  13 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h      | 280 +++++++
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c         |  53 +-
 drivers/crypto/virtio/virtio_cryptodev.c          |   3 +-
 drivers/crypto/virtio/virtio_rxtx.c               |  61 +-
 drivers/event/dlb2/dlb2.c                         |  44 +-
 drivers/event/dlb2/dlb2_priv.h                    |   1 -
 drivers/event/dlb2/pf/dlb2_pf.c                   |   4 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c               |   4 +-
 drivers/net/bonding/rte_eth_bond_pmd.c            |  11 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c               | 109 ++-
 drivers/net/cnxk/cnxk_ethdev.c                    |   3 +-
 drivers/net/e1000/igb_ethdev.c                    |   4 +-
 drivers/net/e1000/igb_rxtx.c                      |   6 +-
 drivers/net/fm10k/base/fm10k_mbx.c                |   2 +-
 drivers/net/fm10k/base/fm10k_osdep.h              |   2 +-
 drivers/net/fm10k/base/fm10k_pf.c                 |   8 +-
 drivers/net/fm10k/base/fm10k_type.h               |   6 +-
 drivers/net/fm10k/base/meson.build                |  14 +-
 drivers/net/hns3/hns3_cmd.h                       |   8 +
 drivers/net/hns3/hns3_common.c                    |   4 +-
 drivers/net/hns3/hns3_ethdev.c                    |  45 +-
 drivers/net/hns3/hns3_flow.c                      |  41 +-
 drivers/net/hns3/hns3_flow.h                      |   9 +-
 drivers/net/hns3/hns3_regs.c                      |   4 +-
 drivers/net/hns3/hns3_rxtx.c                      |  56 +-
 drivers/net/hns3/hns3_rxtx_vec.c                  |  10 +-
 drivers/net/i40e/base/i40e_common.c               |   5 -
 drivers/net/i40e/base/i40e_diag.c                 |   2 +-
 drivers/net/i40e/base/i40e_nvm.c                  |   1 +
 drivers/net/i40e/base/i40e_osdep.h                |   4 +-
 drivers/net/i40e/base/i40e_register.h             |  33 -
 drivers/net/i40e/base/i40e_type.h                 |  14 +-
 drivers/net/i40e/base/meson.build                 |  15 +-
 drivers/net/i40e/i40e_ethdev.c                    |   1 +
 drivers/net/i40e/i40e_regs.h                      |   9 -
 drivers/net/i40e/i40e_rxtx.c                      |   2 +
 drivers/net/iavf/iavf_ethdev.c                    |  74 +-
 drivers/net/ice/base/ice_devids.h                 |   2 +-
 drivers/net/ice/base/ice_type.h                   |   2 +-
 drivers/net/ice/ice_dcf_ethdev.c                  |   3 +-
 drivers/net/igc/igc_ethdev.c                      |   2 +-
 drivers/net/ixgbe/base/ixgbe_common.c             |   4 +-
 drivers/net/ixgbe/base/ixgbe_osdep.h              |  23 +-
 drivers/net/ixgbe/base/meson.build                |  11 -
 drivers/net/ixgbe/ixgbe_flow.c                    |   2 +
 drivers/net/ixgbe/ixgbe_rxtx.c                    |   5 +-
 drivers/net/mana/mana.c                           |  14 +
 drivers/net/mana/mana.h                           |   4 +
 drivers/net/mlx5/linux/mlx5_os.c                  |   3 +-
 drivers/net/mlx5/linux/mlx5_vlan_os.c             |  10 +-
 drivers/net/mlx5/mlx5.h                           |   1 +
 drivers/net/mlx5/mlx5_devx.c                      |   4 +-
 drivers/net/mlx5/mlx5_ethdev.c                    |  47 +-
 drivers/net/mlx5/mlx5_flow_dv.c                   |   7 +
 drivers/net/mlx5/mlx5_flow_hw.c                   | 114 +--
 drivers/net/mlx5/mlx5_flow_meter.c                | 545 --------------
 drivers/net/mlx5/mlx5_hws_cnt.c                   |  12 +-
 drivers/net/mlx5/mlx5_rxq.c                       |   2 +-
 drivers/net/mlx5/mlx5_trigger.c                   |   6 +-
 drivers/net/mlx5/mlx5_txq.c                       |  13 +-
 drivers/net/mlx5/mlx5_vlan.c                      |   2 +-
 drivers/net/netvsc/hn_ethdev.c                    |  10 +-
 drivers/net/netvsc/hn_rndis.c                     |  14 +-
 drivers/net/netvsc/hn_rxtx.c                      |  16 +-
 drivers/net/netvsc/hn_var.h                       |   4 -
 drivers/net/ngbe/base/ngbe_hw.c                   |   9 +
 drivers/net/ngbe/base/ngbe_type.h                 |   1 +
 drivers/net/ngbe/ngbe_ethdev.c                    |   6 +-
 drivers/net/null/rte_eth_null.c                   |  12 +-
 drivers/net/qede/qede_filter.c                    |  21 +-
 drivers/net/tap/tap_tcmsgs.c                      |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c                 |  13 +-
 drivers/net/txgbe/base/txgbe_type.h               |  21 +-
 drivers/net/txgbe/txgbe_ethdev.c                  |   6 +-
 drivers/net/txgbe/txgbe_ethdev.h                  |   9 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c               |  31 +-
 drivers/net/txgbe/txgbe_fdir.c                    |  62 +-
 drivers/net/txgbe/txgbe_flow.c                    | 853 ++++++++++++++++------
 drivers/net/txgbe/txgbe_rxtx.c                    |   2 +
 examples/ipsec-secgw/ipsec-secgw.c                |  11 +-
 examples/ipsec-secgw/ipsec_neon.h                 |   8 +-
 examples/ipsec-secgw/ipsec_worker.c               |   5 +-
 examples/ntb/ntb_fwd.c                            |  15 +
 lib/acl/acl_run.h                                 |   5 +
 lib/acl/acl_run_altivec.h                         |   8 +-
 lib/acl/acl_run_avx2.h                            |   4 +-
 lib/acl/acl_run_neon.h                            |   8 +-
 lib/acl/acl_run_scalar.c                          |   4 +-
 lib/acl/acl_run_sse.h                             |   8 +-
 lib/eal/common/eal_common_lcore.c                 |   2 +-
 lib/eal/common/eal_common_memory.c                |   8 +-
 lib/eal/common/eal_common_options.c               |   6 +
 lib/eal/freebsd/eal.c                             |   2 +-
 lib/eal/freebsd/eal_alarm.c                       |   8 +-
 lib/eal/include/rte_trace_point.h                 |   4 +-
 lib/eal/linux/eal.c                               |   2 +-
 lib/eal/linux/eal_alarm.c                         |   9 +-
 lib/eal/linux/eal_memory.c                        |  12 +
 lib/eal/unix/eal_unix_memory.c                    |   2 +-
 lib/ethdev/rte_ethdev.c                           |  11 +-
 lib/ethdev/rte_flow.c                             |  12 +-
 lib/pcapng/rte_pcapng.c                           |   6 +-
 lib/power/rte_power_intel_uncore.c                |  35 +-
 lib/vhost/vhost.c                                 |   6 +-
 lib/vhost/vhost_crypto.c                          |   3 +-
 146 files changed, 2220 insertions(+), 1475 deletions(-)
Amiya Ranjan Mohakud (2):
      net/iavf: fix VLAN strip setting after enabling filter
      net/iavf: fix VLAN strip disabling for ADQ v2 capability

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Ariel Otilibili (2):
      net/af_xdp: fix use after free in zero-copy Tx
      pcapng: fix null dereference in close

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (7):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver

Chaoyong He (1):
      app/testpmd: fix RSS hash key update

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Dariusz Sosnowski (5):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (5):
      ci: bump tested distributions in GHA
      acl: fix build with GCC 15 on aarch64
      eal: warn if no lcore is available
      doc: remove reference to deprecated --use-device option
      eal: add description of service corelist in usage

Dengdui Huang (12):
      net/hns3: fix integer overflow in interrupt unmap
      net/hns3: fix memory leak on failure
      net/hns3: fix extra wait for link up
      net/hns3: fix memory leak for indirect flow action
      net/hns3: fix interrupt rollback
      net/hns3: fix divide by zero
      net/hns3: fix resources release on reset
      net/hns3: fix CRC data segment
      mem: fix lockup on address space shortage
      net/hns3: check requirement for hardware GRO
      net/hns3: allow Tx vector when fast free not enabled
      net/hns3: allow Rx vector mode with VLAN filter

Dhanya Pillai (1):
      net/i40e: fix RSS on plain IPv4

Doug Foster (1):
      config/arm: add grace build config

Eugenio Pérez (1):
      vhost: search virtqueues driver data in read-only area

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (2):
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA decrypt validation

Gregory Etelson (3):
      net/mlx5: remove unsupported flow meter action in HWS
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Hengqi Chen (1):
      net/virtio: fix check of threshold for Tx freeing

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jiawen Wu (13):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix FDIR perfect mode for IPv6
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: add LRO flag in mbuf when enabled
      net/txgbe: fix to create FDIR filter for tunnel packet

Kaiwen Deng (2):
      net/e1000: fix xstats name
      net/e1000: fix igb Tx queue offloads capability

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Krzysztof Galazka (1):
      net/i40e/base: remove unused variables

Long Li (5):
      bus/vmbus: align ring buffer data to page boundary
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device

Luca Boccassi (3):
      Revert "net/virtio: fix check of threshold for Tx freeing"
      version: 22.11.9-rc1
      version: 22.11.9

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (2):
      ethdev: fix error struct in flow configure
      examples/multi_process: fix ports cleanup on exit

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (1):
      net/ice: fix querying RSS hash for DCF

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (3):
      common/cnxk: fix qsize in CPT iq enable
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Pavan Nikhilesh (1):
      eal: fix return value of lcore role

Pravin Pathak (4):
      event/dlb2: fix dequeue with CQ depth <= 16
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      app/eventdev: fix number of releases sent during cleanup

Radu Nicolau (3):
      crypto/virtio: add request check on request side
      crypto/virtio: fix driver cleanup
      crypto/qat: fix out-of-place chain/cipher/auth headers

Rahul Bhansali (3):
      net/cnxk: fix descriptor count update on reconfig
      common/cnxk: fix null pointer checks
      net/cnxk: fix lock for security session ops

Rajesh Mudimadugula (2):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shani Peretz (2):
      app/crypto-perf: fix AAD offset alignment
      crypto/mlx5: adjust CQE error struct name

Stephen Hemminger (3):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Thomas Monjalon (1):
      examples/multi_process: revert ports cleanup on exit

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Viacheslav Ovsiienko (2):
      net/mlx5: fix maximal queue size query
      net/mlx5: fix hypervisor detection in VLAN workaround

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter
