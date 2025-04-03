Return-Path: <dev-bounces@dpdk.org>
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29AC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 18:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6410A40A7D;
	Thu,  3 Apr 2025 20:11:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A67F740E09
 for <dev@dpdk.org>; Thu,  3 Apr 2025 19:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743699614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQAlOCgG4O6njBI4w4H4CG4v0Re8SevZiZGFiDPl9UA=;
 b=Y6FRKq/3YRiNTGWPBEh8450HA0h3cyxNPYiUMxhD7/MR0ZMvMyKXrAQVB70eszW9eJ79Tz
 W6gKr2jZGkgMV88dFrrIuT48cYL5fR1fIOHH7hOL5qElaS7SsZAHlxkSNuCQ6agfoLpo+G
 9nDgDAc8dTXEUFvJMYctYGttEbJDnnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-g-gR9xDKMaGwDHjBm6lVOw-1; Thu,
 03 Apr 2025 13:00:04 -0400
X-MC-Unique: g-gR9xDKMaGwDHjBm6lVOw-1
X-Mimecast-MFC-AGG-ID: g-gR9xDKMaGwDHjBm6lVOw_1743699598
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFB131801A06; Thu,  3 Apr 2025 16:59:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE00C1801766; Thu,  3 Apr 2025 16:59:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Gagandeep Singh <g.singh@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Min Zhou <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, Gaetan Rivet <grive@u256.net>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: [PATCH v7 5/8] build: mark exported symbols
Date: Thu,  3 Apr 2025 18:58:34 +0200
Message-ID: <20250403165845.1315380-6-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXRUNKpdqBvZnrtc9wZ8lFm-ny_kFHzDnKJ_R-MB0m8_1743699598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Apr 2025 20:11:11 +0200
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

Annotate symbols with newly introduced export macros.

For code not compiled via drivers/meson.build (think base drivers code),
the exported symbols are added in some new XX_base_symbols.c file added
to the sources variable so they get caught by drivers/meson.build.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v6:
- annotated net/dpaa2 symbols directly in base driver code,
- renamed special case base symbol files and added comment,

Changes since v5:
- fixed Windows symbol exports for net/mlx5,                                                        

Changes since RFC v4:
- rebased and fixed mlx5 new export,
- moved base driver exports in a separate file,
- added eal_symbol_exports.h inclusion,

Changes since RFC v3:
- marked exported symbols directly in AVX sources (net/idpf),

---
 drivers/baseband/acc/rte_acc100_pmd.c         |   2 +
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   2 +
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |   2 +
 drivers/bus/auxiliary/auxiliary_common.c      |   3 +
 drivers/bus/cdx/cdx.c                         |   5 +
 drivers/bus/cdx/cdx_vfio.c                    |   5 +
 drivers/bus/dpaa/dpaa_bus.c                   |  10 +
 drivers/bus/dpaa/dpaa_bus_base_symbols.c      | 100 ++++
 drivers/bus/dpaa/meson.build                  |   1 +
 drivers/bus/fslmc/fslmc_bus.c                 |   5 +
 drivers/bus/fslmc/fslmc_vfio.c                |  13 +
 drivers/bus/fslmc/mc/dpbp.c                   |   8 +
 drivers/bus/fslmc/mc/dpci.c                   |   5 +
 drivers/bus/fslmc/mc/dpcon.c                  |   8 +
 drivers/bus/fslmc/mc/dpdmai.c                 |  10 +
 drivers/bus/fslmc/mc/dpio.c                   |  15 +
 drivers/bus/fslmc/mc/dpmng.c                  |   4 +
 drivers/bus/fslmc/mc/mc_sys.c                 |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |   4 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |   3 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  12 +
 drivers/bus/fslmc/qbman/qbman_debug.c         |   4 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |  43 ++
 drivers/bus/ifpga/ifpga_bus.c                 |   4 +
 drivers/bus/pci/bsd/pci.c                     |  11 +
 drivers/bus/pci/linux/pci.c                   |  11 +
 drivers/bus/pci/pci_common.c                  |  11 +
 drivers/bus/pci/windows/pci.c                 |  11 +
 drivers/bus/platform/platform.c               |   3 +
 drivers/bus/uacce/uacce.c                     |  10 +
 drivers/bus/vdev/vdev.c                       |   7 +
 drivers/bus/vmbus/linux/vmbus_bus.c           |   7 +
 drivers/bus/vmbus/vmbus_channel.c             |  14 +
 drivers/bus/vmbus/vmbus_common.c              |   4 +
 drivers/common/cnxk/cnxk_security.c           |  13 +
 drivers/common/cnxk/cnxk_utils.c              |   2 +
 drivers/common/cnxk/meson.build               |   1 +
 drivers/common/cnxk/roc_platform.c            |  19 +
 .../common/cnxk/roc_platform_base_symbols.c   | 546 ++++++++++++++++++
 drivers/common/cpt/cpt_fpm_tables.c           |   3 +
 drivers/common/cpt/cpt_pmd_ops_helper.c       |   4 +
 drivers/common/dpaax/caamflib.c               |   3 +
 drivers/common/dpaax/dpaa_of.c                |  13 +
 drivers/common/dpaax/dpaax_iova_table.c       |   7 +
 drivers/common/ionic/ionic_common_uio.c       |   5 +
 .../common/mlx5/linux/mlx5_common_auxiliary.c |   2 +
 drivers/common/mlx5/linux/mlx5_common_os.c    |  11 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |   4 +
 drivers/common/mlx5/linux/mlx5_glue.c         |   3 +
 drivers/common/mlx5/linux/mlx5_nl.c           |  22 +
 drivers/common/mlx5/mlx5_common.c             |  10 +
 drivers/common/mlx5/mlx5_common_devx.c        |  10 +
 drivers/common/mlx5/mlx5_common_mp.c          |   9 +
 drivers/common/mlx5/mlx5_common_mr.c          |  12 +
 drivers/common/mlx5/mlx5_common_pci.c         |   3 +
 drivers/common/mlx5/mlx5_common_utils.c       |  12 +
 drivers/common/mlx5/mlx5_devx_cmds.c          |  52 ++
 drivers/common/mlx5/mlx5_malloc.c             |   5 +
 drivers/common/mlx5/windows/mlx5_common_os.c  |   7 +
 drivers/common/mlx5/windows/mlx5_glue.c       |   4 +-
 drivers/common/mvep/mvep_common.c             |   3 +
 drivers/common/nfp/nfp_common.c               |   9 +
 drivers/common/nfp/nfp_common_pci.c           |   2 +
 drivers/common/nfp/nfp_dev.c                  |   2 +
 drivers/common/nitrox/nitrox_device.c         |   2 +
 drivers/common/nitrox/nitrox_logs.c           |   2 +
 drivers/common/nitrox/nitrox_qp.c             |   3 +
 drivers/common/octeontx/octeontx_mbox.c       |   7 +
 drivers/common/sfc_efx/meson.build            |   1 +
 drivers/common/sfc_efx/sfc_base_symbols.c     | 276 +++++++++
 drivers/common/sfc_efx/sfc_efx.c              |   3 +
 drivers/common/sfc_efx/sfc_efx_mcdi.c         |   3 +
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |   8 +
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c      |   3 +
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |   8 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |   3 +
 drivers/crypto/dpaa_sec/dpaa_sec.c            |   3 +
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |   3 +
 .../scheduler/rte_cryptodev_scheduler.c       |  11 +
 drivers/dma/cnxk/cnxk_dmadev_fp.c             |   5 +
 drivers/event/cnxk/cnxk_worker.c              |   3 +
 drivers/event/dlb2/rte_pmd_dlb2.c             |   2 +
 drivers/mempool/cnxk/cn10k_hwpool_ops.c       |   4 +
 drivers/mempool/dpaa/dpaa_mempool.c           |   3 +
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   6 +
 drivers/net/atlantic/rte_pmd_atlantic.c       |   7 +
 drivers/net/bnxt/rte_pmd_bnxt.c               |  17 +
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  13 +
 drivers/net/bonding/rte_eth_bond_api.c        |  16 +
 drivers/net/cnxk/cnxk_ethdev.c                |   4 +
 drivers/net/cnxk/cnxk_ethdev_sec.c            |  10 +
 drivers/net/dpaa/dpaa_ethdev.c                |   4 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |   2 +
 drivers/net/dpaa2/base/dpaa2_tlu_hash.c       |   3 +
 drivers/net/dpaa2/dpaa2_ethdev.c              |   8 +
 drivers/net/dpaa2/dpaa2_mux.c                 |   4 +
 drivers/net/dpaa2/dpaa2_rxtx.c                |   2 +
 drivers/net/intel/i40e/rte_pmd_i40e.c         |  40 ++
 drivers/net/intel/iavf/iavf_base_symbols.c    |  14 +
 drivers/net/intel/iavf/iavf_rxtx.c            |   9 +
 drivers/net/intel/iavf/meson.build            |   1 +
 drivers/net/intel/ice/ice_diagnose.c          |   4 +
 drivers/net/intel/idpf/idpf_common_device.c   |  11 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  25 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |   3 +
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |   6 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  31 +
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |   2 +
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  38 ++
 drivers/net/mlx5/mlx5.c                       |   2 +
 drivers/net/mlx5/mlx5_flow.c                  |   5 +
 drivers/net/mlx5/mlx5_rx.c                    |   3 +
 drivers/net/mlx5/mlx5_rxq.c                   |   3 +
 drivers/net/mlx5/mlx5_tx.c                    |   2 +
 drivers/net/mlx5/mlx5_txq.c                   |   4 +
 drivers/net/octeontx/octeontx_ethdev.c        |   2 +
 drivers/net/ring/rte_eth_ring.c               |   3 +
 drivers/net/softnic/rte_eth_softnic.c         |   2 +
 drivers/net/softnic/rte_eth_softnic_thread.c  |   2 +
 drivers/net/vhost/rte_eth_vhost.c             |   3 +
 drivers/power/kvm_vm/guest_channel.c          |   3 +
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |  11 +
 drivers/raw/ifpga/rte_pmd_ifpga.c             |  12 +
 lib/acl/acl_bld.c                             |   2 +
 lib/acl/acl_run_scalar.c                      |   3 +
 lib/acl/rte_acl.c                             |  12 +
 lib/argparse/rte_argparse.c                   |   3 +
 lib/bbdev/bbdev_trace_points.c                |   3 +
 lib/bbdev/rte_bbdev.c                         |  32 +
 lib/bitratestats/rte_bitrate.c                |   5 +
 lib/bpf/bpf.c                                 |   3 +
 lib/bpf/bpf_convert.c                         |   2 +
 lib/bpf/bpf_dump.c                            |   2 +
 lib/bpf/bpf_exec.c                            |   3 +
 lib/bpf/bpf_load.c                            |   2 +
 lib/bpf/bpf_load_elf.c                        |   2 +
 lib/bpf/bpf_pkt.c                             |   5 +
 lib/bpf/bpf_stub.c                            |   3 +
 lib/cfgfile/rte_cfgfile.c                     |  18 +
 lib/cmdline/cmdline.c                         |  10 +
 lib/cmdline/cmdline_cirbuf.c                  |  21 +
 lib/cmdline/cmdline_parse.c                   |   5 +
 lib/cmdline/cmdline_parse_bool.c              |   2 +
 lib/cmdline/cmdline_parse_etheraddr.c         |   4 +
 lib/cmdline/cmdline_parse_ipaddr.c            |   4 +
 lib/cmdline/cmdline_parse_num.c               |   4 +
 lib/cmdline/cmdline_parse_portlist.c          |   4 +
 lib/cmdline/cmdline_parse_string.c            |   6 +
 lib/cmdline/cmdline_rdline.c                  |  17 +
 lib/cmdline/cmdline_socket.c                  |   5 +
 lib/cmdline/cmdline_vt100.c                   |   4 +
 lib/compressdev/rte_comp.c                    |   7 +
 lib/compressdev/rte_compressdev.c             |  26 +
 lib/compressdev/rte_compressdev_pmd.c         |   4 +
 lib/cryptodev/cryptodev_pmd.c                 |   8 +
 lib/cryptodev/cryptodev_trace_points.c        |   4 +
 lib/cryptodev/rte_cryptodev.c                 |  84 +++
 lib/dispatcher/rte_dispatcher.c               |  14 +
 lib/distributor/rte_distributor.c             |  10 +
 lib/dmadev/rte_dmadev.c                       |  20 +
 lib/dmadev/rte_dmadev_trace_points.c          |   8 +
 lib/eal/arm/rte_cpuflags.c                    |   4 +
 lib/eal/arm/rte_hypervisor.c                  |   2 +
 lib/eal/arm/rte_power_intrinsics.c            |   5 +
 lib/eal/common/eal_common_bus.c               |  11 +
 lib/eal/common/eal_common_class.c             |   5 +
 lib/eal/common/eal_common_config.c            |   8 +
 lib/eal/common/eal_common_cpuflags.c          |   2 +
 lib/eal/common/eal_common_debug.c             |   3 +
 lib/eal/common/eal_common_dev.c               |  20 +
 lib/eal/common/eal_common_devargs.c           |  10 +
 lib/eal/common/eal_common_errno.c             |   3 +
 lib/eal/common/eal_common_fbarray.c           |  27 +
 lib/eal/common/eal_common_hexdump.c           |   3 +
 lib/eal/common/eal_common_hypervisor.c        |   2 +
 lib/eal/common/eal_common_interrupts.c        |  28 +
 lib/eal/common/eal_common_launch.c            |   6 +
 lib/eal/common/eal_common_lcore.c             |  18 +
 lib/eal/common/eal_common_lcore_var.c         |   2 +
 lib/eal/common/eal_common_mcfg.c              |  21 +
 lib/eal/common/eal_common_memory.c            |  30 +
 lib/eal/common/eal_common_memzone.c           |  10 +
 lib/eal/common/eal_common_options.c           |   5 +
 lib/eal/common/eal_common_proc.c              |   9 +
 lib/eal/common/eal_common_string_fns.c        |   4 +
 lib/eal/common/eal_common_tailqs.c            |   4 +
 lib/eal/common/eal_common_thread.c            |  15 +
 lib/eal/common/eal_common_timer.c             |   5 +
 lib/eal/common/eal_common_trace.c             |  16 +
 lib/eal/common/eal_common_trace_ctf.c         |   2 +
 lib/eal/common/eal_common_trace_points.c      |  19 +
 lib/eal/common/eal_common_trace_utils.c       |   2 +
 lib/eal/common/eal_common_uuid.c              |   5 +
 lib/eal/common/rte_bitset.c                   |   2 +
 lib/eal/common/rte_keepalive.c                |   7 +
 lib/eal/common/rte_malloc.c                   |  23 +
 lib/eal/common/rte_random.c                   |   5 +
 lib/eal/common/rte_reciprocal.c               |   3 +
 lib/eal/common/rte_service.c                  |  32 +
 lib/eal/common/rte_version.c                  |   8 +
 lib/eal/freebsd/eal.c                         |  23 +
 lib/eal/freebsd/eal_alarm.c                   |   3 +
 lib/eal/freebsd/eal_dev.c                     |   5 +
 lib/eal/freebsd/eal_interrupts.c              |  20 +
 lib/eal/freebsd/eal_memory.c                  |   4 +
 lib/eal/freebsd/eal_thread.c                  |   3 +
 lib/eal/freebsd/eal_timer.c                   |   2 +
 lib/eal/linux/eal.c                           |   8 +
 lib/eal/linux/eal_alarm.c                     |   3 +
 lib/eal/linux/eal_dev.c                       |   5 +
 lib/eal/linux/eal_interrupts.c                |  20 +
 lib/eal/linux/eal_memory.c                    |   4 +
 lib/eal/linux/eal_thread.c                    |   3 +
 lib/eal/linux/eal_timer.c                     |   5 +
 lib/eal/linux/eal_vfio.c                      |  17 +
 lib/eal/loongarch/rte_cpuflags.c              |   4 +
 lib/eal/loongarch/rte_hypervisor.c            |   2 +
 lib/eal/loongarch/rte_power_intrinsics.c      |   5 +
 lib/eal/ppc/rte_cpuflags.c                    |   4 +
 lib/eal/ppc/rte_hypervisor.c                  |   2 +
 lib/eal/ppc/rte_power_intrinsics.c            |   5 +
 lib/eal/riscv/rte_cpuflags.c                  |   4 +
 lib/eal/riscv/rte_hypervisor.c                |   2 +
 lib/eal/riscv/rte_power_intrinsics.c          |   5 +
 lib/eal/unix/eal_debug.c                      |   3 +
 lib/eal/unix/eal_filesystem.c                 |   2 +
 lib/eal/unix/eal_firmware.c                   |   2 +
 lib/eal/unix/eal_unix_memory.c                |   5 +
 lib/eal/unix/eal_unix_timer.c                 |   2 +
 lib/eal/unix/rte_thread.c                     |  14 +
 lib/eal/windows/eal.c                         |  12 +
 lib/eal/windows/eal_alarm.c                   |   3 +
 lib/eal/windows/eal_debug.c                   |   2 +
 lib/eal/windows/eal_dev.c                     |   5 +
 lib/eal/windows/eal_interrupts.c              |  20 +
 lib/eal/windows/eal_memory.c                  |   8 +
 lib/eal/windows/eal_mp.c                      |   7 +
 lib/eal/windows/eal_thread.c                  |   2 +
 lib/eal/windows/eal_timer.c                   |   2 +
 lib/eal/windows/rte_thread.c                  |  15 +
 lib/eal/x86/rte_cpuflags.c                    |   4 +
 lib/eal/x86/rte_hypervisor.c                  |   2 +
 lib/eal/x86/rte_power_intrinsics.c            |   5 +
 lib/eal/x86/rte_spinlock.c                    |   2 +
 lib/efd/rte_efd.c                             |   8 +
 lib/ethdev/ethdev_driver.c                    |  25 +
 lib/ethdev/ethdev_linux_ethtool.c             |   4 +
 lib/ethdev/ethdev_private.c                   |   3 +
 lib/ethdev/ethdev_trace_points.c              |   7 +
 lib/ethdev/rte_ethdev.c                       | 169 ++++++
 lib/ethdev/rte_ethdev_cman.c                  |   5 +
 lib/ethdev/rte_flow.c                         |  65 +++
 lib/ethdev/rte_mtr.c                          |  22 +
 lib/ethdev/rte_tm.c                           |  32 +
 lib/eventdev/eventdev_private.c               |   3 +
 lib/eventdev/eventdev_trace_points.c          |  12 +
 lib/eventdev/rte_event_crypto_adapter.c       |  16 +
 lib/eventdev/rte_event_dma_adapter.c          |  16 +
 lib/eventdev/rte_event_eth_rx_adapter.c       |  24 +
 lib/eventdev/rte_event_eth_tx_adapter.c       |  18 +
 lib/eventdev/rte_event_ring.c                 |   5 +
 lib/eventdev/rte_event_timer_adapter.c        |  12 +
 lib/eventdev/rte_eventdev.c                   |  47 ++
 lib/fib/rte_fib.c                             |  11 +
 lib/fib/rte_fib6.c                            |  10 +
 lib/gpudev/gpudev.c                           |  33 ++
 lib/graph/graph.c                             |  17 +
 lib/graph/graph_debug.c                       |   3 +
 lib/graph/graph_stats.c                       |   5 +
 lib/graph/node.c                              |  12 +
 lib/graph/rte_graph_model_mcore_dispatch.c    |   4 +
 lib/graph/rte_graph_worker.c                  |   4 +
 lib/gro/rte_gro.c                             |   7 +
 lib/gso/rte_gso.c                             |   2 +
 lib/hash/rte_cuckoo_hash.c                    |  28 +
 lib/hash/rte_fbk_hash.c                       |   4 +
 lib/hash/rte_hash_crc.c                       |   3 +
 lib/hash/rte_thash.c                          |  13 +
 lib/hash/rte_thash_gf2_poly_math.c            |   2 +
 lib/hash/rte_thash_gfni.c                     |   3 +
 lib/ip_frag/rte_ip_frag_common.c              |   6 +
 lib/ip_frag/rte_ipv4_fragmentation.c          |   3 +
 lib/ip_frag/rte_ipv4_reassembly.c             |   2 +
 lib/ip_frag/rte_ipv6_fragmentation.c          |   2 +
 lib/ip_frag/rte_ipv6_reassembly.c             |   2 +
 lib/ipsec/ipsec_sad.c                         |   7 +
 lib/ipsec/ipsec_telemetry.c                   |   3 +
 lib/ipsec/sa.c                                |   5 +
 lib/ipsec/ses.c                               |   2 +
 lib/jobstats/rte_jobstats.c                   |  15 +
 lib/kvargs/rte_kvargs.c                       |   9 +
 lib/latencystats/rte_latencystats.c           |   6 +
 lib/log/log.c                                 |  23 +
 lib/log/log_color.c                           |   2 +
 lib/log/log_syslog.c                          |   2 +
 lib/log/log_timestamp.c                       |   2 +
 lib/lpm/rte_lpm.c                             |   9 +
 lib/lpm/rte_lpm6.c                            |  11 +
 lib/mbuf/rte_mbuf.c                           |  18 +
 lib/mbuf/rte_mbuf_dyn.c                       |  10 +
 lib/mbuf/rte_mbuf_pool_ops.c                  |   6 +
 lib/mbuf/rte_mbuf_ptype.c                     |   9 +
 lib/member/rte_member.c                       |  14 +
 lib/mempool/mempool_trace_points.c            |  11 +
 lib/mempool/rte_mempool.c                     |  28 +
 lib/mempool/rte_mempool_ops.c                 |   5 +
 lib/mempool/rte_mempool_ops_default.c         |   5 +
 lib/meter/rte_meter.c                         |   7 +
 lib/metrics/rte_metrics.c                     |   9 +
 lib/metrics/rte_metrics_telemetry.c           |  12 +
 lib/mldev/mldev_utils.c                       |   3 +
 lib/mldev/mldev_utils_neon.c                  |  20 +
 lib/mldev/mldev_utils_neon_bfloat16.c         |   4 +
 lib/mldev/mldev_utils_scalar.c                |  20 +
 lib/mldev/mldev_utils_scalar_bfloat16.c       |   4 +
 lib/mldev/rte_mldev.c                         |  38 ++
 lib/mldev/rte_mldev_pmd.c                     |   3 +
 lib/net/rte_arp.c                             |   2 +
 lib/net/rte_ether.c                           |   4 +
 lib/net/rte_net.c                             |   3 +
 lib/net/rte_net_crc.c                         |   2 +
 lib/node/ethdev_ctrl.c                        |   3 +
 lib/node/ip4_lookup.c                         |   2 +
 lib/node/ip4_reassembly.c                     |   2 +
 lib/node/ip4_rewrite.c                        |   2 +
 lib/node/ip6_lookup.c                         |   2 +
 lib/node/ip6_rewrite.c                        |   2 +
 lib/node/udp4_input.c                         |   3 +
 lib/pcapng/rte_pcapng.c                       |   8 +
 lib/pci/rte_pci.c                             |   4 +
 lib/pdcp/rte_pdcp.c                           |   6 +
 lib/pdump/rte_pdump.c                         |  10 +
 lib/pipeline/rte_pipeline.c                   |  24 +
 lib/pipeline/rte_port_in_action.c             |   9 +
 lib/pipeline/rte_swx_ctl.c                    |  18 +
 lib/pipeline/rte_swx_ipsec.c                  |   8 +
 lib/pipeline/rte_swx_pipeline.c               |  74 +++
 lib/pipeline/rte_table_action.c               |  17 +
 lib/port/rte_port_ethdev.c                    |   4 +
 lib/port/rte_port_eventdev.c                  |   4 +
 lib/port/rte_port_fd.c                        |   4 +
 lib/port/rte_port_frag.c                      |   3 +
 lib/port/rte_port_ras.c                       |   3 +
 lib/port/rte_port_ring.c                      |   7 +
 lib/port/rte_port_sched.c                     |   3 +
 lib/port/rte_port_source_sink.c               |   3 +
 lib/port/rte_port_sym_crypto.c                |   4 +
 lib/port/rte_swx_port_ethdev.c                |   3 +
 lib/port/rte_swx_port_fd.c                    |   3 +
 lib/port/rte_swx_port_ring.c                  |   3 +
 lib/port/rte_swx_port_source_sink.c           |   4 +
 lib/power/power_common.c                      |   9 +
 lib/power/rte_power_cpufreq.c                 |  19 +
 lib/power/rte_power_pmd_mgmt.c                |  11 +
 lib/power/rte_power_qos.c                     |   3 +
 lib/power/rte_power_uncore.c                  |  15 +
 lib/rawdev/rte_rawdev.c                       |  31 +
 lib/rcu/rte_rcu_qsbr.c                        |  12 +
 lib/regexdev/rte_regexdev.c                   |  27 +
 lib/reorder/rte_reorder.c                     |  12 +
 lib/rib/rte_rib.c                             |  15 +
 lib/rib/rte_rib6.c                            |  15 +
 lib/ring/rte_ring.c                           |  12 +
 lib/ring/rte_soring.c                         |   4 +
 lib/ring/soring.c                             |  18 +
 lib/sched/rte_approx.c                        |   2 +
 lib/sched/rte_pie.c                           |   3 +
 lib/sched/rte_red.c                           |   7 +
 lib/sched/rte_sched.c                         |  16 +
 lib/security/rte_security.c                   |  21 +
 lib/stack/rte_stack.c                         |   4 +
 lib/table/rte_swx_table_em.c                  |   3 +
 lib/table/rte_swx_table_learner.c             |  11 +
 lib/table/rte_swx_table_selector.c            |   7 +
 lib/table/rte_swx_table_wm.c                  |   2 +
 lib/table/rte_table_acl.c                     |   2 +
 lib/table/rte_table_array.c                   |   2 +
 lib/table/rte_table_hash_cuckoo.c             |   2 +
 lib/table/rte_table_hash_ext.c                |   2 +
 lib/table/rte_table_hash_key16.c              |   3 +
 lib/table/rte_table_hash_key32.c              |   3 +
 lib/table/rte_table_hash_key8.c               |   3 +
 lib/table/rte_table_hash_lru.c                |   2 +
 lib/table/rte_table_lpm.c                     |   2 +
 lib/table/rte_table_lpm_ipv6.c                |   2 +
 lib/table/rte_table_stub.c                    |   2 +
 lib/telemetry/telemetry.c                     |   4 +
 lib/telemetry/telemetry_data.c                |  18 +
 lib/telemetry/telemetry_legacy.c              |   2 +
 lib/timer/rte_timer.c                         |  19 +
 lib/vhost/socket.c                            |  17 +
 lib/vhost/vdpa.c                              |  12 +
 lib/vhost/vhost.c                             |  42 ++
 lib/vhost/vhost_crypto.c                      |   7 +
 lib/vhost/vhost_user.c                        |   3 +
 lib/vhost/virtio_net.c                        |   8 +
 396 files changed, 4557 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/dpaa/dpaa_bus_base_symbols.c
 create mode 100644 drivers/common/cnxk/roc_platform_base_symbols.c
 create mode 100644 drivers/common/sfc_efx/sfc_base_symbols.c
 create mode 100644 drivers/net/intel/iavf/iavf_base_symbols.c

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index d33e42c807..b7f02f56e1 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -4,6 +4,7 @@
 
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -4635,6 +4636,7 @@ acc100_configure(const char *dev_name, struct rte_acc_conf *conf)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acc_configure, 22.11)
 int
 rte_acc_configure(const char *dev_name, struct rte_acc_conf *conf)
 {
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index 65b7e118cd..82cf98da5d 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -4,6 +4,7 @@
 
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -3366,6 +3367,7 @@ static int agx100_configure(const char *dev_name, const struct rte_fpga_5gnr_fec
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_5gnr_fec_configure, 20.11)
 int rte_fpga_5gnr_fec_configure(const char *dev_name, const struct rte_fpga_5gnr_fec_conf *conf)
 {
 	struct rte_bbdev *bbdev = rte_bbdev_get_named_dev(dev_name);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index 04c1f95180..4723a51dcf 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -4,6 +4,7 @@
 
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -2452,6 +2453,7 @@ set_default_fpga_conf(struct rte_fpga_lte_fec_conf *def_conf)
 }
 
 /* Initial configuration of FPGA LTE FEC device */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_lte_fec_configure, 20.11)
 int
 rte_fpga_lte_fec_configure(const char *dev_name,
 		const struct rte_fpga_lte_fec_conf *conf)
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index b444eb43ef..5c6c6b0ef2 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/queue.h>
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
 #include <rte_log.h>
@@ -258,6 +259,7 @@ auxiliary_parse(const char *name, void *addr)
 }
 
 /* Register a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_register)
 void
 rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 {
@@ -265,6 +267,7 @@ rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 }
 
 /* Unregister a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_unregister)
 void
 rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 {
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 62b108e082..729d54337c 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -75,6 +75,7 @@
 #include <rte_malloc.h>
 #include <rte_vfio.h>
 
+#include <eal_export.h>
 #include <eal_filesystem.h>
 
 #include "bus_cdx_driver.h"
@@ -139,11 +140,13 @@ cdx_get_kernel_driver_by_path(const char *filename, char *driver_name,
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_map_device)
 int rte_cdx_map_device(struct rte_cdx_device *dev)
 {
 	return cdx_vfio_map_resource(dev);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unmap_device)
 void rte_cdx_unmap_device(struct rte_cdx_device *dev)
 {
 	cdx_vfio_unmap_resource(dev);
@@ -478,6 +481,7 @@ cdx_parse(const char *name, void *addr)
 }
 
 /* register a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_register)
 void
 rte_cdx_register(struct rte_cdx_driver *driver)
 {
@@ -486,6 +490,7 @@ rte_cdx_register(struct rte_cdx_driver *driver)
 }
 
 /* unregister a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unregister)
 void
 rte_cdx_unregister(struct rte_cdx_driver *driver)
 {
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 664f267471..37e0c424d4 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -17,6 +17,7 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <eal_export.h>
 #include <rte_eal_paging.h>
 #include <rte_malloc.h>
 #include <rte_vfio.h>
@@ -550,6 +551,7 @@ cdx_vfio_map_resource(struct rte_cdx_device *dev)
 		return cdx_vfio_map_resource_secondary(dev);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_enable)
 int
 rte_cdx_vfio_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -584,6 +586,7 @@ rte_cdx_vfio_intr_enable(const struct rte_intr_handle *intr_handle)
 }
 
 /* disable MSI interrupts */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_disable)
 int
 rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -611,6 +614,7 @@ rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 }
 
 /* Enable Bus Mastering */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable)
 int
 rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 {
@@ -656,6 +660,7 @@ rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 }
 
 /* Disable Bus Mastering */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_disable)
 int
 rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
 {
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 9ffbe07c93..5420733019 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/eventfd.h>
 
+#include <eal_export.h>
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <rte_interrupts.h>
@@ -59,15 +60,19 @@ struct netcfg_info *dpaa_netcfg;
 /* define a variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa_portal_key;
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_svr_family)
 unsigned int dpaa_svr_family;
 
 #define FSL_DPAA_BUS_NAME	dpaa_bus
 
+RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io)
 RTE_DEFINE_PER_LCORE(struct dpaa_portal *, dpaa_io);
 
 #define DPAA_SEQN_DYNFIELD_NAME "dpaa_seqn_dynfield"
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_seqn_dynfield_offset)
 int dpaa_seqn_dynfield_offset = -1;
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_eth_port_cfg)
 struct fm_eth_port_cfg *
 dpaa_get_eth_port_cfg(int dev_id)
 {
@@ -315,6 +320,7 @@ dpaa_clean_device_list(void)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_init)
 int rte_dpaa_portal_init(void *arg)
 {
 	static const struct rte_mbuf_dynfield dpaa_seqn_dynfield_desc = {
@@ -393,6 +399,7 @@ int rte_dpaa_portal_init(void *arg)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_init)
 int
 rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 {
@@ -421,6 +428,7 @@ rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_close)
 int rte_dpaa_portal_fq_close(struct qman_fq *fq)
 {
 	return fsl_qman_fq_portal_destroy(fq->qp);
@@ -548,6 +556,7 @@ rte_dpaa_bus_scan(void)
 }
 
 /* register a dpaa bus based dpaa driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_register)
 void
 rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 {
@@ -559,6 +568,7 @@ rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 }
 
 /* un-register a dpaa bus based dpaa driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_unregister)
 void
 rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 {
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
new file mode 100644
index 0000000000..522cdca27e
--- /dev/null
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#include <eal_export.h>
+
+/* Symbols from the base driver are exported separately below. */
+RTE_EXPORT_INTERNAL_SYMBOL(fman_ip_rev)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_hi)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_lo)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_mcast_filter_table)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_reset_mcast_filter_table)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_clear_mac_addr)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_add_mac_addr)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get_all)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_get_all)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_enable_rx)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_disable_rx)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_rx_status)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_bp)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_threshold)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_threshold)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_quanta)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_quanta)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fdoff)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_err_fqid)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_ic_params)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fdoff)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_maxfrm)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_maxfrm)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_sg_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_sg)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_discard_rx_errors)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_receive_rx_errors)
+RTE_EXPORT_INTERNAL_SYMBOL(netcfg_acquire)
+RTE_EXPORT_INTERNAL_SYMBOL(netcfg_release)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_new_pool)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_free_pool)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_get_params)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_release)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
+RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_link_status)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_status)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_speed)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_restart_link_autoneg)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_set_fq_lookup_table)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_register_cb)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_poll_free)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_add)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_add)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_poll_rx)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_clear_irq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dqrr_consume)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_static_dequeue_add)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dca_index)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_create_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_fqid)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_state)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_init_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_retire_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_oos_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_np)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_frm_cnt)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_set_vdq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_volatile_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_modify_cgr)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_create_cgr)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_delete_cgr)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_caam)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_irq)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_thread_irq)
+RTE_EXPORT_INTERNAL_SYMBOL(fsl_qman_fq_portal_create)
diff --git a/drivers/bus/dpaa/meson.build b/drivers/bus/dpaa/meson.build
index 5506f2bffc..d1f03bb093 100644
--- a/drivers/bus/dpaa/meson.build
+++ b/drivers/bus/dpaa/meson.build
@@ -19,6 +19,7 @@ sources = files(
         'base/qbman/qman.c',
         'base/qbman/qman_driver.c',
         'dpaa_bus.c',
+        'dpaa_bus_base_symbols.c',
 )
 
 if cc.has_argument('-Wno-cast-qual')
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 68ad2b801e..ebc0c1fb4f 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -9,6 +9,7 @@
 #include <stdalign.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <bus_driver.h>
 #include <rte_malloc.h>
@@ -29,8 +30,10 @@
 struct rte_fslmc_bus rte_fslmc_bus;
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
 int dpaa2_seqn_dynfield_offset = -1;
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_get_device_count)
 uint32_t
 rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type)
 {
@@ -525,6 +528,7 @@ rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 }
 
 /*register a fslmc bus based dpaa2 driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_register)
 void
 rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 {
@@ -534,6 +538,7 @@ rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 }
 
 /*un-register a fslmc bus based dpaa2 driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_unregister)
 void
 rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver)
 {
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 7a584b9280..68439cbd8c 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <ctype.h>
 
+#include <eal_export.h>
 #include <eal_filesystem.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
@@ -83,6 +84,7 @@ enum {
 	FSLMC_VFIO_SOCKET_REQ_MEM
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_get_mcp_ptr)
 void *
 dpaa2_get_mcp_ptr(int portal_idx)
 {
@@ -154,6 +156,7 @@ fslmc_io_virt2phy(const void *virtaddr)
 }
 
 /*register a fslmc bus based dpaa2 driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_object_register)
 void
 rte_fslmc_object_register(struct rte_dpaa2_object *object)
 {
@@ -984,6 +987,7 @@ fslmc_unmap_dma(uint64_t vaddr, uint64_t iovaddr, size_t len)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_vaddr_to_iova)
 uint64_t
 rte_fslmc_cold_mem_vaddr_to_iova(void *vaddr,
 	uint64_t size)
@@ -1002,6 +1006,7 @@ rte_fslmc_cold_mem_vaddr_to_iova(void *vaddr,
 	return RTE_BAD_IOVA;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_iova_to_vaddr)
 void *
 rte_fslmc_cold_mem_iova_to_vaddr(uint64_t iova,
 	uint64_t size)
@@ -1018,6 +1023,7 @@ rte_fslmc_cold_mem_iova_to_vaddr(uint64_t iova,
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_vaddr_to_iova)
 __rte_hot uint64_t
 rte_fslmc_mem_vaddr_to_iova(void *vaddr)
 {
@@ -1027,6 +1033,7 @@ rte_fslmc_mem_vaddr_to_iova(void *vaddr)
 	return rte_fslmc_cold_mem_vaddr_to_iova(vaddr, 0);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_iova_to_vaddr)
 __rte_hot void *
 rte_fslmc_mem_iova_to_vaddr(uint64_t iova)
 {
@@ -1036,6 +1043,7 @@ rte_fslmc_mem_iova_to_vaddr(uint64_t iova)
 	return rte_fslmc_cold_mem_iova_to_vaddr(iova, 0);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_vaddr_to_iova)
 uint64_t
 rte_fslmc_io_vaddr_to_iova(void *vaddr)
 {
@@ -1051,6 +1059,7 @@ rte_fslmc_io_vaddr_to_iova(void *vaddr)
 	return RTE_BAD_IOVA;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_iova_to_vaddr)
 void *
 rte_fslmc_io_iova_to_vaddr(uint64_t iova)
 {
@@ -1141,12 +1150,14 @@ fslmc_dmamap_seg(const struct rte_memseg_list *msl __rte_unused,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fslmc_vfio_mem_dmamap)
 int
 rte_fslmc_vfio_mem_dmamap(uint64_t vaddr, uint64_t iova, uint64_t size)
 {
 	return fslmc_map_dma(vaddr, iova, size);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_vfio_mem_dmaunmap)
 int
 rte_fslmc_vfio_mem_dmaunmap(uint64_t iova, uint64_t size)
 {
@@ -1264,6 +1275,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 
 #define IRQ_SET_BUF_LEN  (sizeof(struct vfio_irq_set) + sizeof(int))
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_enable)
 int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index)
 {
 	int len, ret;
@@ -1295,6 +1307,7 @@ int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_disable)
 int rte_dpaa2_intr_disable(struct rte_intr_handle *intr_handle, int index)
 {
 	struct vfio_irq_set *irq_set;
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index d9103409cf..08f24d33e8 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -9,6 +9,8 @@
 #include <fsl_dpbp.h>
 #include <fsl_dpbp_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * dpbp_open() - Open a control session for the specified object.
  * @mc_io:	Pointer to MC portal's I/O object
@@ -26,6 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_open)
 int dpbp_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
 	      int dpbp_id,
@@ -157,6 +160,7 @@ int dpbp_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_enable)
 int dpbp_enable(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -179,6 +183,7 @@ int dpbp_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_disable)
 int dpbp_disable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -235,6 +240,7 @@ int dpbp_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_reset)
 int dpbp_reset(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -258,6 +264,7 @@ int dpbp_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_attributes)
 int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -329,6 +336,7 @@ int dpbp_get_api_version(struct fsl_mc_io *mc_io,
  * Return:  '0' on Success; Error code otherwise.
  */
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_num_free_bufs)
 int dpbp_get_num_free_bufs(struct fsl_mc_io *mc_io,
 			   uint32_t cmd_flags,
 			   uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpci.c b/drivers/bus/fslmc/mc/dpci.c
index 7e31327afa..9df3827f92 100644
--- a/drivers/bus/fslmc/mc/dpci.c
+++ b/drivers/bus/fslmc/mc/dpci.c
@@ -9,6 +9,8 @@
 #include <fsl_dpci.h>
 #include <fsl_dpci_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * dpci_open() - Open a control session for the specified object
  * @mc_io:	Pointer to MC portal's I/O object
@@ -315,6 +317,7 @@ int dpci_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_rx_queue)
 int dpci_set_rx_queue(struct fsl_mc_io *mc_io,
 		      uint32_t cmd_flags,
 		      uint16_t token,
@@ -477,6 +480,7 @@ int dpci_get_api_version(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_opr)
 int dpci_set_opr(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token,
@@ -515,6 +519,7 @@ int dpci_set_opr(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_get_opr)
 int dpci_get_opr(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpcon.c b/drivers/bus/fslmc/mc/dpcon.c
index 2c46638dcb..b9f2f50e12 100644
--- a/drivers/bus/fslmc/mc/dpcon.c
+++ b/drivers/bus/fslmc/mc/dpcon.c
@@ -9,6 +9,8 @@
 #include <fsl_dpcon.h>
 #include <fsl_dpcon_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * dpcon_open() - Open a control session for the specified object
  * @mc_io:	Pointer to MC portal's I/O object
@@ -26,6 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_open)
 int dpcon_open(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       int dpcon_id,
@@ -64,6 +67,7 @@ int dpcon_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_close)
 int dpcon_close(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -164,6 +168,7 @@ int dpcon_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_enable)
 int dpcon_enable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -187,6 +192,7 @@ int dpcon_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_disable)
 int dpcon_disable(struct fsl_mc_io *mc_io,
 		  uint32_t cmd_flags,
 		  uint16_t token)
@@ -245,6 +251,7 @@ int dpcon_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_reset)
 int dpcon_reset(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -268,6 +275,7 @@ int dpcon_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_get_attributes)
 int dpcon_get_attributes(struct fsl_mc_io *mc_io,
 			 uint32_t cmd_flags,
 			 uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpdmai.c b/drivers/bus/fslmc/mc/dpdmai.c
index 9c2f3bf9d5..97e90b09f1 100644
--- a/drivers/bus/fslmc/mc/dpdmai.c
+++ b/drivers/bus/fslmc/mc/dpdmai.c
@@ -7,6 +7,8 @@
 #include <fsl_dpdmai.h>
 #include <fsl_dpdmai_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * dpdmai_open() - Open a control session for the specified object
  * @mc_io:	Pointer to MC portal's I/O object
@@ -24,6 +26,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_open)
 int dpdmai_open(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		int dpdmai_id,
@@ -62,6 +65,7 @@ int dpdmai_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_close)
 int dpdmai_close(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -171,6 +175,7 @@ int dpdmai_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_enable)
 int dpdmai_enable(struct fsl_mc_io *mc_io,
 		  uint32_t cmd_flags,
 		  uint16_t token)
@@ -194,6 +199,7 @@ int dpdmai_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_disable)
 int dpdmai_disable(struct fsl_mc_io *mc_io,
 		   uint32_t cmd_flags,
 		   uint16_t token)
@@ -276,6 +282,7 @@ int dpdmai_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_attributes)
 int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
 			  uint32_t cmd_flags,
 			  uint16_t token,
@@ -320,6 +327,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_set_rx_queue)
 int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -362,6 +370,7 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_rx_queue)
 int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -412,6 +421,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_tx_queue)
 int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpio.c b/drivers/bus/fslmc/mc/dpio.c
index 97c08fa713..8cdf8f432a 100644
--- a/drivers/bus/fslmc/mc/dpio.c
+++ b/drivers/bus/fslmc/mc/dpio.c
@@ -9,6 +9,8 @@
 #include <fsl_dpio.h>
 #include <fsl_dpio_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * dpio_open() - Open a control session for the specified object
  * @mc_io:	Pointer to MC portal's I/O object
@@ -26,6 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_open)
 int dpio_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
 	      int dpio_id,
@@ -61,6 +64,7 @@ int dpio_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_close)
 int dpio_close(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -173,6 +177,7 @@ int dpio_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_enable)
 int dpio_enable(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -196,6 +201,7 @@ int dpio_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_disable)
 int dpio_disable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -253,6 +259,7 @@ int dpio_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_reset)
 int dpio_reset(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -277,6 +284,7 @@ int dpio_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_attributes)
 int dpio_get_attributes(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -322,6 +330,7 @@ int dpio_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination)
 int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -350,6 +359,7 @@ int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination)
 int dpio_get_stashing_destination(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -386,6 +396,7 @@ int dpio_get_stashing_destination(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_by_core_id)
 int dpio_set_stashing_destination_by_core_id(struct fsl_mc_io *mc_io,
 					uint32_t cmd_flags,
 					uint16_t token,
@@ -414,6 +425,7 @@ int dpio_set_stashing_destination_by_core_id(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_source)
 int dpio_set_stashing_destination_source(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -442,6 +454,7 @@ int dpio_set_stashing_destination_source(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination_source)
 int dpio_get_stashing_destination_source(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -478,6 +491,7 @@ int dpio_get_stashing_destination_source(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_add_static_dequeue_channel)
 int dpio_add_static_dequeue_channel(struct fsl_mc_io *mc_io,
 				    uint32_t cmd_flags,
 				    uint16_t token,
@@ -517,6 +531,7 @@ int dpio_add_static_dequeue_channel(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_remove_static_dequeue_channel)
 int dpio_remove_static_dequeue_channel(struct fsl_mc_io *mc_io,
 				       uint32_t cmd_flags,
 				       uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpmng.c b/drivers/bus/fslmc/mc/dpmng.c
index 277080876d..47c85cd80d 100644
--- a/drivers/bus/fslmc/mc/dpmng.c
+++ b/drivers/bus/fslmc/mc/dpmng.c
@@ -9,6 +9,8 @@
 #include <fsl_dpmng.h>
 #include <fsl_dpmng_cmd.h>
 
+#include <eal_export.h>
+
 /**
  * mc_get_version() - Retrieves the Management Complex firmware
  *			version information
@@ -18,6 +20,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mc_get_version)
 int mc_get_version(struct fsl_mc_io *mc_io,
 		   uint32_t cmd_flags,
 		   struct mc_version *mc_ver_info)
@@ -57,6 +60,7 @@ int mc_get_version(struct fsl_mc_io *mc_io,
  *
  * Return:     '0' on Success; Error code otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mc_get_soc_version)
 int mc_get_soc_version(struct fsl_mc_io *mc_io,
 		       uint32_t cmd_flags,
 		       struct mc_soc_version *mc_platform_info)
diff --git a/drivers/bus/fslmc/mc/mc_sys.c b/drivers/bus/fslmc/mc/mc_sys.c
index 76fdcd5c8a..ef4c8dd3b8 100644
--- a/drivers/bus/fslmc/mc/mc_sys.c
+++ b/drivers/bus/fslmc/mc/mc_sys.c
@@ -7,6 +7,7 @@
 #include <fsl_mc_sys.h>
 #include <fsl_mc_cmd.h>
 
+#include <eal_export.h>
 #include <rte_spinlock.h>
 #include <rte_cycles.h>
 
@@ -52,6 +53,7 @@ static int mc_status_to_error(enum mc_cmd_status status)
 	return -EINVAL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mc_send_command)
 int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd)
 {
 	enum mc_cmd_status status;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 0ca3b2b2e4..925e83e97d 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -13,6 +13,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_string_fns.h>
@@ -95,6 +96,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dpbp_dev)
 struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 {
 	struct dpaa2_dpbp_dev *dpbp_dev = NULL;
@@ -108,6 +110,7 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 	return dpbp_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dpbp_dev)
 void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
 {
 	struct dpaa2_dpbp_dev *dpbp_dev = NULL;
@@ -121,6 +124,7 @@ void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpbp_supported)
 int dpaa2_dpbp_supported(void)
 {
 	if (TAILQ_EMPTY(&dpbp_dev_list))
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index 0ea859f887..b546da82f6 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_string_fns.h>
@@ -151,6 +152,7 @@ rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpci_dev)
 struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
@@ -164,6 +166,7 @@ struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 	return dpci_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dpci_dev)
 void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2dfcf7a498..bad25a0ec2 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <sys/syscall.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
@@ -40,9 +41,12 @@
 
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal)
 struct dpaa2_io_portal_t dpaa2_io_portal[RTE_MAX_LCORE];
+RTE_EXPORT_INTERNAL_SYMBOL(per_lcore__dpaa2_io)
 RTE_DEFINE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_global_active_dqs_list)
 struct swp_active_dqs rte_global_active_dqs_list[NUM_MAX_SWP];
 
 TAILQ_HEAD(dpio_dev_list, dpaa2_dpio_dev);
@@ -51,11 +55,14 @@ static struct dpio_dev_list dpio_dev_list
 static uint32_t io_space_count;
 
 /* Variable to store DPAA2 platform type */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_svr_family)
 uint32_t dpaa2_svr_family;
 
 /* Variable to store DPAA2 DQRR size */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dqrr_size)
 uint8_t dpaa2_dqrr_size;
 /* Variable to store DPAA2 EQCR size */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eqcr_size)
 uint8_t dpaa2_eqcr_size;
 
 /* Variable to hold the portal_key, once created.*/
@@ -325,6 +332,7 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 	return dpio_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_swp)
 int
 dpaa2_affine_qbman_swp(void)
 {
@@ -346,6 +354,7 @@ dpaa2_affine_qbman_swp(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_ethrx_swp)
 int
 dpaa2_affine_qbman_ethrx_swp(void)
 {
@@ -606,6 +615,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dq_storage)
 void
 dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage)
 {
@@ -617,6 +627,7 @@ dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dq_storage)
 int
 dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 {
@@ -639,6 +650,7 @@ dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_eq_descriptors)
 uint32_t
 dpaa2_free_eq_descriptors(void)
 {
diff --git a/drivers/bus/fslmc/qbman/qbman_debug.c b/drivers/bus/fslmc/qbman/qbman_debug.c
index 0e471ec3fd..f13168dce3 100644
--- a/drivers/bus/fslmc/qbman/qbman_debug.c
+++ b/drivers/bus/fslmc/qbman/qbman_debug.c
@@ -7,6 +7,8 @@
 #include <fsl_qbman_debug.h>
 #include "qbman_portal.h"
 
+#include <eal_export.h>
+
 /* QBMan portal management command code */
 #define QBMAN_BP_QUERY            0x32
 #define QBMAN_FQ_QUERY            0x44
@@ -325,6 +327,7 @@ uint16_t qbman_fq_attr_get_opridsz(struct qbman_fq_query_rslt *r)
 	return r->opridsz;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_query_state)
 int qbman_fq_query_state(struct qbman_swp *s, uint32_t fqid,
 			 struct qbman_fq_query_np_rslt *r)
 {
@@ -382,6 +385,7 @@ int qbman_fq_state_overflow_error(const struct qbman_fq_query_np_rslt *r)
 	return (int)((r->st1 & 0x40) >> 6);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_state_frame_count)
 uint32_t qbman_fq_state_frame_count(const struct qbman_fq_query_np_rslt *r)
 {
 	return (r->frm_cnt & 0x00FFFFFF);
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 5d0cedc136..84853924e7 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -8,6 +8,8 @@
 #include "qbman_sys.h"
 #include "qbman_portal.h"
 
+#include <eal_export.h>
+
 /* QBMan portal management command codes */
 #define QBMAN_MC_ACQUIRE       0x30
 #define QBMAN_WQCHAN_CONFIGURE 0x46
@@ -405,6 +407,7 @@ uint32_t qbman_swp_interrupt_read_status(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_ISR);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_clear_status)
 void qbman_swp_interrupt_clear_status(struct qbman_swp *p, uint32_t mask)
 {
 	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_ISR, mask);
@@ -606,11 +609,13 @@ enum qb_enqueue_commands {
 #define QB_ENQUEUE_CMD_NLIS_SHIFT            14
 #define QB_ENQUEUE_CMD_IS_NESN_SHIFT         15
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_clear)
 void qbman_eq_desc_clear(struct qbman_eq_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_no_orp)
 void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
 {
 	d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT);
@@ -620,6 +625,7 @@ void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
 		d->eq.verb |= enqueue_rejects_to_fq;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_orp)
 void qbman_eq_desc_set_orp(struct qbman_eq_desc *d, int respond_success,
 			   uint16_t opr_id, uint16_t seqnum, int incomplete)
 {
@@ -659,6 +665,7 @@ void qbman_eq_desc_set_orp_nesn(struct qbman_eq_desc *d, uint16_t opr_id,
 	d->eq.seqnum |= 1 << QB_ENQUEUE_CMD_IS_NESN_SHIFT;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_response)
 void qbman_eq_desc_set_response(struct qbman_eq_desc *d,
 				dma_addr_t storage_phys,
 				int stash)
@@ -667,17 +674,20 @@ void qbman_eq_desc_set_response(struct qbman_eq_desc *d,
 	d->eq.wae = stash;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_token)
 void qbman_eq_desc_set_token(struct qbman_eq_desc *d, uint8_t token)
 {
 	d->eq.rspid = token;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_fq)
 void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, uint32_t fqid)
 {
 	d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT);
 	d->eq.tgtid = fqid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_qd)
 void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, uint32_t qdid,
 			  uint16_t qd_bin, uint8_t qd_prio)
 {
@@ -695,6 +705,7 @@ void qbman_eq_desc_set_eqdi(struct qbman_eq_desc *d, int enable)
 		d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_IRQ_ON_DISPATCH_SHIFT);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_dca)
 void qbman_eq_desc_set_dca(struct qbman_eq_desc *d, int enable,
 			   uint8_t dqrr_idx, int park)
 {
@@ -1216,6 +1227,7 @@ static int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
 	return num_enqueued;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple)
 int qbman_swp_enqueue_multiple(struct qbman_swp *s,
 				      const struct qbman_eq_desc *d,
 				      const struct qbman_fd *fd,
@@ -1490,6 +1502,7 @@ static int qbman_swp_enqueue_multiple_fd_mem_back(struct qbman_swp *s,
 	return num_enqueued;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_fd)
 int qbman_swp_enqueue_multiple_fd(struct qbman_swp *s,
 					 const struct qbman_eq_desc *d,
 					 struct qbman_fd **fd,
@@ -1745,6 +1758,7 @@ static int qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
 
 	return num_enqueued;
 }
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_desc)
 int qbman_swp_enqueue_multiple_desc(struct qbman_swp *s,
 					   const struct qbman_eq_desc *d,
 					   const struct qbman_fd *fd,
@@ -1771,6 +1785,7 @@ void qbman_swp_push_get(struct qbman_swp *s, uint8_t channel_idx, int *enabled)
 	*enabled = src | (1 << channel_idx);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_push_set)
 void qbman_swp_push_set(struct qbman_swp *s, uint8_t channel_idx, int enable)
 {
 	uint16_t dqsrc;
@@ -1808,11 +1823,13 @@ enum qb_pull_dt_e {
 	qb_pull_dt_framequeue
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_clear)
 void qbman_pull_desc_clear(struct qbman_pull_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_storage)
 void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
 				 struct qbman_result *storage,
 				 dma_addr_t storage_phys,
@@ -1833,6 +1850,7 @@ void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
 	d->pull.rsp_addr = storage_phys;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_numframes)
 void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d,
 				   uint8_t numframes)
 {
@@ -1844,6 +1862,7 @@ void qbman_pull_desc_set_token(struct qbman_pull_desc *d, uint8_t token)
 	d->pull.tok = token;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_fq)
 void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, uint32_t fqid)
 {
 	d->pull.verb |= 1 << QB_VDQCR_VERB_DCT_SHIFT;
@@ -1959,6 +1978,7 @@ static int qbman_swp_pull_mem_back(struct qbman_swp *s,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_pull)
 int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 {
 	if (!s->stash_off)
@@ -1986,6 +2006,7 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 
 #include <rte_prefetch.h>
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_prefetch_dqrr_next)
 void qbman_swp_prefetch_dqrr_next(struct qbman_swp *s)
 {
 	const struct qbman_result *p;
@@ -1999,6 +2020,7 @@ void qbman_swp_prefetch_dqrr_next(struct qbman_swp *s)
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_next)
 const struct qbman_result *qbman_swp_dqrr_next(struct qbman_swp *s)
 {
 	if (!s->stash_off)
@@ -2202,6 +2224,7 @@ const struct qbman_result *qbman_swp_dqrr_next_mem_back(struct qbman_swp *s)
 }
 
 /* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_consume)
 void qbman_swp_dqrr_consume(struct qbman_swp *s,
 			    const struct qbman_result *dq)
 {
@@ -2210,6 +2233,7 @@ void qbman_swp_dqrr_consume(struct qbman_swp *s,
 }
 
 /* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_idx_consume)
 void qbman_swp_dqrr_idx_consume(struct qbman_swp *s,
 			    uint8_t dqrr_index)
 {
@@ -2220,6 +2244,7 @@ void qbman_swp_dqrr_idx_consume(struct qbman_swp *s,
 /* Polling user-provided storage */
 /*********************************/
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_has_new_result)
 int qbman_result_has_new_result(struct qbman_swp *s,
 				struct qbman_result *dq)
 {
@@ -2248,6 +2273,7 @@ int qbman_result_has_new_result(struct qbman_swp *s,
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_new_result)
 int qbman_check_new_result(struct qbman_result *dq)
 {
 	if (dq->dq.tok == 0)
@@ -2263,6 +2289,7 @@ int qbman_check_new_result(struct qbman_result *dq)
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_command_complete)
 int qbman_check_command_complete(struct qbman_result *dq)
 {
 	struct qbman_swp *s;
@@ -2350,16 +2377,19 @@ int qbman_result_is_FQPN(const struct qbman_result *dq)
 
 /* These APIs assume qbman_result_is_DQ() is TRUE */
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_flags)
 uint8_t qbman_result_DQ_flags(const struct qbman_result *dq)
 {
 	return dq->dq.stat;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_seqnum)
 uint16_t qbman_result_DQ_seqnum(const struct qbman_result *dq)
 {
 	return dq->dq.seqnum;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_odpid)
 uint16_t qbman_result_DQ_odpid(const struct qbman_result *dq)
 {
 	return dq->dq.oprid;
@@ -2380,11 +2410,13 @@ uint32_t qbman_result_DQ_frame_count(const struct qbman_result *dq)
 	return dq->dq.fq_frm_cnt;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fqd_ctx)
 uint64_t qbman_result_DQ_fqd_ctx(const struct qbman_result *dq)
 {
 	return dq->dq.fqd_ctx;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fd)
 const struct qbman_fd *qbman_result_DQ_fd(const struct qbman_result *dq)
 {
 	return (const struct qbman_fd *)&dq->dq.fd[0];
@@ -2393,6 +2425,7 @@ const struct qbman_fd *qbman_result_DQ_fd(const struct qbman_result *dq)
 /**************************************/
 /* Parsing state-change notifications */
 /**************************************/
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_SCN_state)
 uint8_t qbman_result_SCN_state(const struct qbman_result *scn)
 {
 	return scn->scn.state;
@@ -2452,21 +2485,25 @@ uint64_t qbman_result_cgcu_icnt(const struct qbman_result *scn)
 /********************/
 /* Parsing EQ RESP  */
 /********************/
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_fd)
 struct qbman_fd *qbman_result_eqresp_fd(struct qbman_result *eqresp)
 {
 	return (struct qbman_fd *)&eqresp->eq_resp.fd[0];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_set_rspid)
 void qbman_result_eqresp_set_rspid(struct qbman_result *eqresp, uint8_t val)
 {
 	eqresp->eq_resp.rspid = val;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rspid)
 uint8_t qbman_result_eqresp_rspid(struct qbman_result *eqresp)
 {
 	return eqresp->eq_resp.rspid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rc)
 uint8_t qbman_result_eqresp_rc(struct qbman_result *eqresp)
 {
 	if (eqresp->eq_resp.rc == 0xE)
@@ -2481,12 +2518,14 @@ uint8_t qbman_result_eqresp_rc(struct qbman_result *eqresp)
 #define QB_BR_RC_VALID_SHIFT  5
 #define QB_BR_RCDI_SHIFT      6
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_clear)
 void qbman_release_desc_clear(struct qbman_release_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 	d->br.verb = 1 << QB_BR_RC_VALID_SHIFT;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_set_bpid)
 void qbman_release_desc_set_bpid(struct qbman_release_desc *d, uint16_t bpid)
 {
 	d->br.bpid = bpid;
@@ -2601,6 +2640,7 @@ static int qbman_swp_release_mem_back(struct qbman_swp *s,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_release)
 int qbman_swp_release(struct qbman_swp *s,
 			     const struct qbman_release_desc *d,
 			     const uint64_t *buffers,
@@ -2727,6 +2767,7 @@ static int qbman_swp_acquire_cinh_direct(struct qbman_swp *s, uint16_t bpid,
 	return num;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_acquire)
 int qbman_swp_acquire(struct qbman_swp *s, uint16_t bpid, uint64_t *buffers,
 		      unsigned int num_buffers)
 {
@@ -2910,11 +2951,13 @@ int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s, uint16_t channelid,
 				  1, ctx);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_idx)
 uint8_t qbman_get_dqrr_idx(const struct qbman_result *dqrr)
 {
 	return QBMAN_IDX_FROM_DQRR(dqrr);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_from_idx)
 struct qbman_result *qbman_get_dqrr_from_idx(struct qbman_swp *s, uint8_t idx)
 {
 	struct qbman_result *dq;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 11b31eee4f..ca9e49f548 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -13,6 +13,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <bus_driver.h>
 #include <rte_per_lcore.h>
@@ -44,6 +45,7 @@ static TAILQ_HEAD(, rte_afu_driver) ifpga_afu_drv_list =
 
 
 /* register a ifpga bus based driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_register)
 void rte_ifpga_driver_register(struct rte_afu_driver *driver)
 {
 	RTE_VERIFY(driver);
@@ -52,6 +54,7 @@ void rte_ifpga_driver_register(struct rte_afu_driver *driver)
 }
 
 /* un-register a fpga bus based driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_unregister)
 void rte_ifpga_driver_unregister(struct rte_afu_driver *driver)
 {
 	TAILQ_REMOVE(&ifpga_afu_drv_list, driver, next);
@@ -71,6 +74,7 @@ ifpga_find_afu_dev(const struct rte_rawdev *rdev,
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_find_afu_by_name)
 struct rte_afu_device *
 rte_ifpga_find_afu_by_name(const char *name)
 {
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 2f88252418..5e2e09d5a4 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -39,6 +39,7 @@
 #include <rte_debug.h>
 #include <rte_devargs.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 #include "private.h"
 
@@ -48,6 +49,7 @@
  */
 
 /* Map pci device */
+RTE_EXPORT_SYMBOL(rte_pci_map_device)
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -69,6 +71,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
 void
 rte_pci_unmap_device(struct rte_pci_device *dev)
 {
@@ -395,6 +398,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv __rte_unused,
 }
 
 /* Read PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_read_config)
 int rte_pci_read_config(const struct rte_pci_device *dev,
 		void *buf, size_t len, off_t offset)
 {
@@ -441,6 +445,7 @@ int rte_pci_read_config(const struct rte_pci_device *dev,
 }
 
 /* Write PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_write_config)
 int rte_pci_write_config(const struct rte_pci_device *dev,
 		const void *buf, size_t len, off_t offset)
 {
@@ -484,6 +489,7 @@ int rte_pci_write_config(const struct rte_pci_device *dev,
 }
 
 /* Read PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
 int rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 		      void *buf, size_t len, off_t offset)
 {
@@ -495,6 +501,7 @@ int rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 }
 
 /* Write PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
 int rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 		       const void *buf, size_t len, off_t offset)
 {
@@ -505,6 +512,7 @@ int rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 	return len;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
 int
 rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 		struct rte_pci_ioport *p)
@@ -566,6 +574,7 @@ pci_uio_ioport_read(struct rte_pci_ioport *p,
 #endif
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p,
 		void *data, size_t len, off_t offset)
@@ -608,6 +617,7 @@ pci_uio_ioport_write(struct rte_pci_ioport *p,
 #endif
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset)
@@ -621,6 +631,7 @@ rte_pci_ioport_write(struct rte_pci_ioport *p,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 {
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9056035b33..c20d159218 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -13,6 +13,7 @@
 #include <rte_memcpy.h>
 #include <rte_vfio.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 
 #include "private.h"
@@ -54,6 +55,7 @@ pci_get_kernel_driver_by_path(const char *filename, char *dri_name,
 }
 
 /* Map pci device */
+RTE_EXPORT_SYMBOL(rte_pci_map_device)
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -84,6 +86,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
 void
 rte_pci_unmap_device(struct rte_pci_device *dev)
 {
@@ -627,6 +630,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 }
 
 /* Read PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_read_config)
 int rte_pci_read_config(const struct rte_pci_device *device,
 		void *buf, size_t len, off_t offset)
 {
@@ -650,6 +654,7 @@ int rte_pci_read_config(const struct rte_pci_device *device,
 }
 
 /* Write PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_write_config)
 int rte_pci_write_config(const struct rte_pci_device *device,
 		const void *buf, size_t len, off_t offset)
 {
@@ -673,6 +678,7 @@ int rte_pci_write_config(const struct rte_pci_device *device,
 }
 
 /* Read PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
 int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
 		void *buf, size_t len, off_t offset)
 {
@@ -695,6 +701,7 @@ int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
 }
 
 /* Write PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
 int rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
 		const void *buf, size_t len, off_t offset)
 {
@@ -716,6 +723,7 @@ int rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
 int
 rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 		struct rte_pci_ioport *p)
@@ -743,6 +751,7 @@ rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p,
 		void *data, size_t len, off_t offset)
@@ -762,6 +771,7 @@ rte_pci_ioport_read(struct rte_pci_ioport *p,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset)
@@ -781,6 +791,7 @@ rte_pci_ioport_write(struct rte_pci_ioport *p,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 {
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 70faae4e44..5df4086f31 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/queue.h>
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
 #include <rte_log.h>
@@ -32,6 +33,7 @@
 
 #define SYSFS_PCI_DEVICES "/sys/bus/pci/devices"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_get_sysfs_path)
 const char *rte_pci_get_sysfs_path(void)
 {
 	const char *path = NULL;
@@ -476,6 +478,7 @@ pci_dump_one_device(FILE *f, struct rte_pci_device *dev)
 }
 
 /* dump devices on the bus */
+RTE_EXPORT_SYMBOL(rte_pci_dump)
 void
 rte_pci_dump(FILE *f)
 {
@@ -500,6 +503,7 @@ pci_parse(const char *name, void *addr)
 }
 
 /* register a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register)
 void
 rte_pci_register(struct rte_pci_driver *driver)
 {
@@ -507,6 +511,7 @@ rte_pci_register(struct rte_pci_driver *driver)
 }
 
 /* unregister a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_unregister)
 void
 rte_pci_unregister(struct rte_pci_driver *driver)
 {
@@ -794,6 +799,7 @@ rte_pci_get_iommu_class(void)
 	return iova_mode;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_has_capability_list, 23.11)
 bool
 rte_pci_has_capability_list(const struct rte_pci_device *dev)
 {
@@ -805,12 +811,14 @@ rte_pci_has_capability_list(const struct rte_pci_device *dev)
 	return (status & RTE_PCI_STATUS_CAP_LIST) != 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_capability, 23.11)
 off_t
 rte_pci_find_capability(const struct rte_pci_device *dev, uint8_t cap)
 {
 	return rte_pci_find_next_capability(dev, cap, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_next_capability, 23.11)
 off_t
 rte_pci_find_next_capability(const struct rte_pci_device *dev, uint8_t cap,
 	off_t offset)
@@ -848,6 +856,7 @@ rte_pci_find_next_capability(const struct rte_pci_device *dev, uint8_t cap,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_ext_capability, 20.11)
 off_t
 rte_pci_find_ext_capability(const struct rte_pci_device *dev, uint32_t cap)
 {
@@ -890,6 +899,7 @@ rte_pci_find_ext_capability(const struct rte_pci_device *dev, uint32_t cap)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_set_bus_master, 21.08)
 int
 rte_pci_set_bus_master(const struct rte_pci_device *dev, bool enable)
 {
@@ -918,6 +928,7 @@ rte_pci_set_bus_master(const struct rte_pci_device *dev, bool enable)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_pasid_set_state)
 int
 rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 		off_t offset, bool enable)
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 36e6f89093..e7e449306e 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -4,6 +4,7 @@
 
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_windows.h>
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -36,6 +37,7 @@ DEFINE_DEVPROPKEY(DEVPKEY_Device_Numa_Node, 0x540b947e, 0x8b40, 0x45bc,
  */
 
 /* Map pci device */
+RTE_EXPORT_SYMBOL(rte_pci_map_device)
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -50,6 +52,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
 void
 rte_pci_unmap_device(struct rte_pci_device *dev __rte_unused)
 {
@@ -61,6 +64,7 @@ rte_pci_unmap_device(struct rte_pci_device *dev __rte_unused)
 }
 
 /* Read PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_read_config)
 int
 rte_pci_read_config(const struct rte_pci_device *dev __rte_unused,
 	void *buf __rte_unused, size_t len __rte_unused,
@@ -75,6 +79,7 @@ rte_pci_read_config(const struct rte_pci_device *dev __rte_unused,
 }
 
 /* Write PCI config space. */
+RTE_EXPORT_SYMBOL(rte_pci_write_config)
 int
 rte_pci_write_config(const struct rte_pci_device *dev __rte_unused,
 	const void *buf __rte_unused, size_t len __rte_unused,
@@ -89,6 +94,7 @@ rte_pci_write_config(const struct rte_pci_device *dev __rte_unused,
 }
 
 /* Read PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
 int
 rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 		      void *buf, size_t len, off_t offset)
@@ -101,6 +107,7 @@ rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 }
 
 /* Write PCI MMIO space. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
 int
 rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 		       const void *buf, size_t len, off_t offset)
@@ -124,6 +131,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv __rte_unused,
 	return RTE_IOVA_DC;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
 int
 rte_pci_ioport_map(struct rte_pci_device *dev __rte_unused,
 	int bar __rte_unused, struct rte_pci_ioport *p __rte_unused)
@@ -137,6 +145,7 @@ rte_pci_ioport_map(struct rte_pci_device *dev __rte_unused,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p __rte_unused,
 	void *data __rte_unused, size_t len __rte_unused,
@@ -149,6 +158,7 @@ rte_pci_ioport_read(struct rte_pci_ioport *p __rte_unused,
 	 */
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p __rte_unused)
 {
@@ -171,6 +181,7 @@ pci_device_iommu_support_va(const struct rte_pci_device *dev __rte_unused)
 	return false;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p __rte_unused,
 		const void *data __rte_unused, size_t len __rte_unused,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 11892caa24..0f50027236 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -13,6 +13,7 @@
 
 #include <bus_driver.h>
 #include <bus_platform_driver.h>
+#include <eal_export.h>
 #include <eal_filesystem.h>
 #include <rte_bus.h>
 #include <rte_devargs.h>
@@ -28,12 +29,14 @@
 
 #define PLATFORM_BUS_DEVICES_PATH "/sys/bus/platform/devices"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
 void
 rte_platform_register(struct rte_platform_driver *pdrv)
 {
 	TAILQ_INSERT_TAIL(&platform_bus.driver_list, pdrv, next);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_unregister)
 void
 rte_platform_unregister(struct rte_platform_driver *pdrv)
 {
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..9b8ac23952 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -13,6 +13,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
+#include <eal_export.h>
 #include <rte_bitops.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
@@ -582,6 +583,7 @@ uacce_dev_iterate(const void *start, const char *str,
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_avail_queues)
 int
 rte_uacce_avail_queues(struct rte_uacce_device *dev)
 {
@@ -595,6 +597,7 @@ rte_uacce_avail_queues(struct rte_uacce_device *dev)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_alloc)
 int
 rte_uacce_queue_alloc(struct rte_uacce_device *dev, struct rte_uacce_qcontex *qctx)
 {
@@ -609,6 +612,7 @@ rte_uacce_queue_alloc(struct rte_uacce_device *dev, struct rte_uacce_qcontex *qc
 	return -EIO;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_free)
 void
 rte_uacce_queue_free(struct rte_uacce_qcontex *qctx)
 {
@@ -618,6 +622,7 @@ rte_uacce_queue_free(struct rte_uacce_qcontex *qctx)
 	qctx->fd = -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_start)
 int
 rte_uacce_queue_start(struct rte_uacce_qcontex *qctx)
 {
@@ -625,6 +630,7 @@ rte_uacce_queue_start(struct rte_uacce_qcontex *qctx)
 	return ioctl(qctx->fd, UACCE_CMD_START_Q);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_ioctl)
 int
 rte_uacce_queue_ioctl(struct rte_uacce_qcontex *qctx, unsigned long cmd, void *arg)
 {
@@ -634,6 +640,7 @@ rte_uacce_queue_ioctl(struct rte_uacce_qcontex *qctx, unsigned long cmd, void *a
 	return ioctl(qctx->fd, cmd, arg);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_mmap)
 void *
 rte_uacce_queue_mmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 {
@@ -659,6 +666,7 @@ rte_uacce_queue_mmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 	return addr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_unmap)
 void
 rte_uacce_queue_unmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 {
@@ -668,6 +676,7 @@ rte_uacce_queue_unmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_register)
 void
 rte_uacce_register(struct rte_uacce_driver *driver)
 {
@@ -675,6 +684,7 @@ rte_uacce_register(struct rte_uacce_driver *driver)
 	driver->bus = &uacce_bus;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_unregister)
 void
 rte_uacce_unregister(struct rte_uacce_driver *driver)
 {
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index ec7abe7cda..beee8c4033 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -10,6 +10,7 @@
 #include <stdbool.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <dev_driver.h>
 #include <bus_driver.h>
@@ -51,6 +52,7 @@ static struct vdev_custom_scans vdev_custom_scans =
 static rte_spinlock_t vdev_custom_scan_lock = RTE_SPINLOCK_INITIALIZER;
 
 /* register a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_register)
 void
 rte_vdev_register(struct rte_vdev_driver *driver)
 {
@@ -58,12 +60,14 @@ rte_vdev_register(struct rte_vdev_driver *driver)
 }
 
 /* unregister a driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_unregister)
 void
 rte_vdev_unregister(struct rte_vdev_driver *driver)
 {
 	TAILQ_REMOVE(&vdev_driver_list, driver, next);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdev_add_custom_scan)
 int
 rte_vdev_add_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 {
@@ -92,6 +96,7 @@ rte_vdev_add_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 	return (custom_scan == NULL) ? -1 : 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vdev_remove_custom_scan)
 int
 rte_vdev_remove_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 {
@@ -316,6 +321,7 @@ insert_vdev(const char *name, const char *args,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vdev_init)
 int
 rte_vdev_init(const char *name, const char *args)
 {
@@ -355,6 +361,7 @@ vdev_remove_driver(struct rte_vdev_device *dev)
 	return driver->remove(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdev_uninit)
 int
 rte_vdev_uninit(const char *name)
 {
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 01d8111b85..ed18d4da96 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -19,6 +19,7 @@
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 #include "private.h"
 
@@ -164,6 +165,7 @@ static const char *map_names[VMBUS_MAX_RESOURCE] = {
 
 
 /* map the resources of a vmbus device in virtual memory */
+RTE_EXPORT_SYMBOL(rte_vmbus_map_device)
 int
 rte_vmbus_map_device(struct rte_vmbus_device *dev)
 {
@@ -222,6 +224,7 @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
 	return vmbus_uio_map_resource(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_unmap_device)
 void
 rte_vmbus_unmap_device(struct rte_vmbus_device *dev)
 {
@@ -338,6 +341,7 @@ vmbus_scan_one(const char *name)
 /*
  * Scan the content of the vmbus, and the devices in the devices list
  */
+RTE_EXPORT_SYMBOL(rte_vmbus_scan)
 int
 rte_vmbus_scan(void)
 {
@@ -369,16 +373,19 @@ rte_vmbus_scan(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask)
 void rte_vmbus_irq_mask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 1);
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask)
 void rte_vmbus_irq_unmask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_read)
 int rte_vmbus_irq_read(struct rte_vmbus_device *device)
 {
 	return vmbus_uio_irq_read(device);
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 925c2aa081..a876c909dd 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <sys/uio.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_tailq.h>
 #include <rte_log.h>
@@ -47,6 +48,7 @@ vmbus_set_event(const struct vmbus_channel *chan)
 /*
  * Set the wait between when hypervisor examines the trigger.
  */
+RTE_EXPORT_SYMBOL(rte_vmbus_set_latency)
 void
 rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 		      const struct vmbus_channel *chan,
@@ -76,6 +78,7 @@ rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
  * Since this in userspace, rely on the monitor page.
  * Can't do a hypercall from userspace.
  */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_tx)
 void
 rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
 {
@@ -93,6 +96,7 @@ rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
 
 
 /* Do a simple send directly using transmit ring. */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_send)
 int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
 			void *data, uint32_t dlen,
 			uint64_t xactid, uint32_t flags, bool *need_sig)
@@ -136,6 +140,7 @@ int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
 }
 
 /* Do a scatter/gather send where the descriptor points to data. */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist)
 int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
 			       struct vmbus_gpa sg[], uint32_t sglen,
 			       void *data, uint32_t dlen,
@@ -179,6 +184,7 @@ int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
 	return error;
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty)
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
@@ -188,6 +194,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 }
 
 /* Signal host after reading N bytes */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read)
 void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
 {
 	struct vmbus_br *rbr = &chan->rxbr;
@@ -218,6 +225,7 @@ void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
 	vmbus_set_event(chan);
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv)
 int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
 			uint64_t *request_id)
 {
@@ -265,6 +273,7 @@ int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
 }
 
 /* TODO: replace this with inplace ring buffer (no copy) */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw)
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len)
 {
@@ -335,6 +344,7 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 }
 
 /* Setup the primary channel */
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_open)
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **new_chan)
 {
@@ -355,6 +365,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 	return err;
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_max_channels)
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 {
 	if (vmbus_uio_subchannels_supported(device, device->primary))
@@ -364,6 +375,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 }
 
 /* Setup secondary channel */
+RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open)
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan)
 {
@@ -379,11 +391,13 @@ int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_sub_channel_index)
 uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan)
 {
 	return chan->subchannel_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_close)
 void rte_vmbus_chan_close(struct vmbus_channel *chan)
 {
 	const struct rte_vmbus_device *device = chan->device;
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 8a965d10d9..ac04ee11f8 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -10,6 +10,7 @@
 #include <sys/queue.h>
 #include <sys/mman.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_eal.h>
 #include <rte_tailq.h>
@@ -191,6 +192,7 @@ vmbus_ignore_device(struct rte_vmbus_device *dev)
  * all registered drivers that have a matching entry in its id_table
  * for discovered devices.
  */
+RTE_EXPORT_SYMBOL(rte_vmbus_probe)
 int
 rte_vmbus_probe(void)
 {
@@ -279,6 +281,7 @@ vmbus_devargs_lookup(struct rte_vmbus_device *dev)
 }
 
 /* register vmbus driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_register)
 void
 rte_vmbus_register(struct rte_vmbus_driver *driver)
 {
@@ -289,6 +292,7 @@ rte_vmbus_register(struct rte_vmbus_driver *driver)
 }
 
 /* unregister vmbus driver */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unregister)
 void
 rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 {
diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index a3c06c1e88..ea3b87e65c 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_udp.h>
 
 #include "roc_api.h"
@@ -301,6 +302,7 @@ ot_ipsec_inb_tunnel_hdr_fill(struct roc_ot_ipsec_inb_sa *sa,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_fill)
 int
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -410,6 +412,7 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_fill)
 int
 cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -574,18 +577,21 @@ cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_valid)
 bool
 cnxk_ot_ipsec_inb_sa_valid(struct roc_ot_ipsec_inb_sa *sa)
 {
 	return !!sa->w2.s.valid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_valid)
 bool
 cnxk_ot_ipsec_outb_sa_valid(struct roc_ot_ipsec_outb_sa *sa)
 {
 	return !!sa->w2.s.valid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_ivlen_get)
 uint8_t
 cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
 		     enum rte_crypto_auth_algorithm a_algo,
@@ -622,6 +628,7 @@ cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
 	return ivlen;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_icvlen_get)
 uint8_t
 cnxk_ipsec_icvlen_get(enum rte_crypto_cipher_algorithm c_algo,
 		      enum rte_crypto_auth_algorithm a_algo,
@@ -668,6 +675,7 @@ cnxk_ipsec_icvlen_get(enum rte_crypto_cipher_algorithm c_algo,
 	return icv;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_roundup_byte)
 uint8_t
 cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 			     enum rte_crypto_aead_algorithm aead_algo)
@@ -698,6 +706,7 @@ cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 	return roundup_byte;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_rlens_get)
 int
 cnxk_ipsec_outb_rlens_get(struct cnxk_ipsec_outb_rlens *rlens,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -970,6 +979,7 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_outb_sa_create)
 int
 cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipsec,
 			     struct rte_crypto_sym_xform *crypto_xform,
@@ -1115,6 +1125,7 @@ cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipsec,
 	return ctx_len;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_inb_sa_create)
 int
 cnxk_on_ipsec_inb_sa_create(struct rte_security_ipsec_xform *ipsec,
 			    struct rte_crypto_sym_xform *crypto_xform,
@@ -1465,6 +1476,7 @@ ow_ipsec_inb_tunnel_hdr_fill(struct roc_ow_ipsec_inb_sa *sa,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_fill)
 int
 cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -1571,6 +1583,7 @@ cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_fill)
 int
 cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
diff --git a/drivers/common/cnxk/cnxk_utils.c b/drivers/common/cnxk/cnxk_utils.c
index 4e56adc659..8ca4664d25 100644
--- a/drivers/common/cnxk/cnxk_utils.c
+++ b/drivers/common/cnxk/cnxk_utils.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2021 Marvell.
  */
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_tm_driver.h>
 
@@ -9,6 +10,7 @@
 
 #include "cnxk_utils.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_err_to_rte_err)
 int
 roc_nix_tm_err_to_rte_err(int errorcode)
 {
diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 59f4eacf84..daffc15afd 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -64,6 +64,7 @@ sources = files(
         'roc_npc_parse.c',
         'roc_npc_utils.c',
         'roc_platform.c',
+        'roc_platform_base_symbols.c',
         'roc_se.c',
         'roc_sso.c',
         'roc_sso_debug.c',
diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 401f737ad4..88f229163a 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_log.h>
 
 #include "roc_api.h"
@@ -242,6 +243,7 @@ plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
 static int plt_init_cb_num;
 static roc_plt_init_cb_t plt_init_cbs[PLT_INIT_CB_MAX];
 
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init_cb_register)
 int
 roc_plt_init_cb_register(roc_plt_init_cb_t cb)
 {
@@ -252,6 +254,7 @@ roc_plt_init_cb_register(roc_plt_init_cb_t cb)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_control_lmt_id_get)
 uint16_t
 roc_plt_control_lmt_id_get(void)
 {
@@ -263,6 +266,7 @@ roc_plt_control_lmt_id_get(void)
 		return ROC_NUM_LMT_LINES - 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_lmt_validate)
 uint16_t
 roc_plt_lmt_validate(void)
 {
@@ -277,6 +281,7 @@ roc_plt_lmt_validate(void)
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init)
 int
 roc_plt_init(void)
 {
@@ -316,17 +321,31 @@ roc_plt_init(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_base)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_base, base, INFO);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_mbox)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_mbox, mbox, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_cpt)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_cpt, crypto, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ml)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_ml, ml, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npa)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_npa, mempool, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_nix)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_nix, nix, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npc)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_npc, flow, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_sso)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_sso, event, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tim)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_tim, timer, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tm)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_tm, tm, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_dpi)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_dpi, dpi, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_rep)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_rep, rep, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_esw)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_esw, esw, NOTICE);
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ree)
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_ree, ree, NOTICE);
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
new file mode 100644
index 0000000000..5d99129987
--- /dev/null
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -0,0 +1,546 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#include <eal_export.h>
+
+/* Symbols from the base driver are exported separately below. */
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_put)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_put)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_xcbc_key_derive)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_hash_key_derive)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_npa_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_sso_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_start_rxtx)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_stop_rxtx)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_state)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_get_linkinfo)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_mode)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_supported_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_change)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_tx_control)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_misc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_handler)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_available)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_max_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_rxc_time_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_flush)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_reload)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_eng_grp_add)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lmtline_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_ctx_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_parse_hdr_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_afs_print)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lfs_print)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_wait_queue_idle)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure_v2)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_tx_rule)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_delete_rule)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_rx_rule)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_rss_action_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_vlan_tpid_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_repte_stats)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_is_repte_pfs_vf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_md5_gen)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha1_gen)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha256_gen)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha512_gen)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_lmt_base_addr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_num_lmtlines_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_ring_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_list_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_nix_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_meta_aura_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_dev_pffunc_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_inb_sa_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_outb_sa_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_inb_sa_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_reass_inb_sa_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_outb_sa_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_is_supported)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_hw_info_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_active_lmac_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_lmac_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_threshold_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_custom_tag_cfg_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_intr_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_recovery)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_port_map_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sc_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_stats_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read64)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write64)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read32)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write32)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_save)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_ap2mlip)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_mlip2ap)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_pa_to_offset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_offset_to_pa)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_write_job)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_valid_bit_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_done_bit_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_queue_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_lf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_sl)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_on)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_off)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_on)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_off)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_sso_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_model)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_lbk)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_esw)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_base_chan)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_rx_chan_cnt)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vwqe_interval)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_sdp)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_pf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_vf_or_sdp)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf_func)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_inl_ipsec_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cpt_ctx_cache_sync)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_pkt_len)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_rep_count)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_level_to_idx)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_to_idx)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_timeunit_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_count_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free_all)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_pre_color_tbl_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_connect)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_get_reg_count)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_reg_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_queues_ctx_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cqe_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_desc_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_npa_bp_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_count_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_bpid_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_aura_check)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_lf_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_inj_lf_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sa_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_rx_inject_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_spi_range)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_sz)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_reassembly_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_probed)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_multi_channel)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_put)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_rq_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_soft_exp_poll_switch)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_is_with_inl_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sso_pffunc_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_tag_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_sa_sync)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ctx_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cpt_lf_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ts_pkind_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_unlock)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_pool_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_eng_caps_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_meta_pool_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_xaq_realloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_qptr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_release)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_err_intr_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ras_intr_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_queue_irqs)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_queue_irqs)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_cq_irqs)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_cq_irqs)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_rxtx_start_stop)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_event_start_stop)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_loopback_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_entries_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_add)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_del)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_promisc_mode_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_state_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_mtu_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_rx_len_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_promisc_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_rx_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mcast_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_custom_fmt_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_switch_hdr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_eeprom_info_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_drop_re_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_rx_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_tx_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_clock_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_sync_time_adjust)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_is_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_is_sso_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_modify)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_cman_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_head_tail_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_head_tail_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_default_fill)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_flowkey_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_default_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_num_xstats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_names_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_flush_spin)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prepare_rate_limited_tree)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_prepare_tree)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_format_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_aura_fc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_free_resources)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_add)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_delete)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_add)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_pkt_mode_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_name_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_delete)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_smq_flush)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_xmit_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_suspend_resume)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prealloc_res)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_shaper_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_parent_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_rlimit_sq)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rlimit_sq)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_count)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_max)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_root_has_sp)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_egress_link_cfg_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_leaf_cnt)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_lvl)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_next)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_next)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_is_user_hierarchy_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_tree_type_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_max_prio)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_is_leaf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_default_red_algo)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_cnt_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_have_link_access)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_alloc_and_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_strip_vtag_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_insert_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_tpid_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_lf_init_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_range_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_pc_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_drop_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_limit_modify)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_range_update_check)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_zero_aura_handle)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_bp_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_lock)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_unlock)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_ctx_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_mask)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_limit_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_sub_return)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_sub_return)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_read_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_clear_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_free_mcam_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_read_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_get_stats)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_clear_counter)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_move)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_all_resources)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entries)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_enable_all_entries)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_ena_dis_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_write_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_low_priority_mcam)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_profile_name_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_capa_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_validate_portid_action)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_parse)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_sdp_channel_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_merge_base_steering_rule)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_aged_flow_ctx_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_mcam_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_detach)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_msix_offsets_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_config_lf)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_read)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_write)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_len_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_prog)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_qp_get_base)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_check)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_process)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_hmac_opad_ipad_gen)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_auth_key_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ciph_key_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ctx_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_ns_to_gw)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_link)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_unlink)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_gwc_invalidate)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_release)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_from_tag)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stats_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_hws_link_status)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_qos_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_init_xaq_aura)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_free_xaq_aura)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_alloc_xaq)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_release_xaq)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_set_priority)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stash_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_base_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config_hwwqe)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_interval)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_error_msg_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_clk_freq_get)
diff --git a/drivers/common/cpt/cpt_fpm_tables.c b/drivers/common/cpt/cpt_fpm_tables.c
index 15b665db01..0cb14733d9 100644
--- a/drivers/common/cpt/cpt_fpm_tables.c
+++ b/drivers/common/cpt/cpt_fpm_tables.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2019 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 
@@ -1081,6 +1082,7 @@ static rte_spinlock_t lock = RTE_SPINLOCK_INITIALIZER;
 static uint8_t *fpm_table;
 static int nb_devs;
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_init)
 int cpt_fpm_init(uint64_t *fpm_table_iova)
 {
 	int i, len = 0;
@@ -1125,6 +1127,7 @@ int cpt_fpm_init(uint64_t *fpm_table_iova)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_clear)
 void cpt_fpm_clear(void)
 {
 	rte_spinlock_lock(&lock);
diff --git a/drivers/common/cpt/cpt_pmd_ops_helper.c b/drivers/common/cpt/cpt_pmd_ops_helper.c
index 2cddddf4ce..c7e6f37026 100644
--- a/drivers/common/cpt/cpt_pmd_ops_helper.c
+++ b/drivers/common/cpt/cpt_pmd_ops_helper.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018 Cavium, Inc
  */
 
+#include <eal_export.h>
 #include <rte_common.h>
 
 #include "cpt_common.h"
@@ -14,6 +15,7 @@
 #define CPT_MAX_ASYM_OP_NUM_PARAMS 5
 #define CPT_MAX_ASYM_OP_MOD_LEN 1024
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_direct_mode)
 int32_t
 cpt_pmd_ops_helper_get_mlen_direct_mode(void)
 {
@@ -28,6 +30,7 @@ cpt_pmd_ops_helper_get_mlen_direct_mode(void)
 	return len;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_sg_mode)
 int
 cpt_pmd_ops_helper_get_mlen_sg_mode(void)
 {
@@ -43,6 +46,7 @@ cpt_pmd_ops_helper_get_mlen_sg_mode(void)
 	return len;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_asym_get_mlen)
 int
 cpt_pmd_ops_helper_asym_get_mlen(void)
 {
diff --git a/drivers/common/dpaax/caamflib.c b/drivers/common/dpaax/caamflib.c
index 55e20281ca..82a7413b5f 100644
--- a/drivers/common/dpaax/caamflib.c
+++ b/drivers/common/dpaax/caamflib.c
@@ -6,6 +6,8 @@
 
 #include <rta.h>
 
+#include <eal_export.h>
+
 /*
  * SEC HW block revision.
  *
@@ -13,4 +15,5 @@
  * - SEC HW block revision format is "v"
  * - SEC revision format is "x.y"
  */
+RTE_EXPORT_INTERNAL_SYMBOL(rta_sec_era)
 enum rta_sec_era rta_sec_era;
diff --git a/drivers/common/dpaax/dpaa_of.c b/drivers/common/dpaax/dpaa_of.c
index bb2c8fc66b..23035f530d 100644
--- a/drivers/common/dpaax/dpaa_of.c
+++ b/drivers/common/dpaax/dpaa_of.c
@@ -7,6 +7,7 @@
 
 #include <dpaa_of.h>
 #include <assert.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <dpaax_logs.h>
 
@@ -213,6 +214,7 @@ linear_dir(struct dt_dir *d)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_init_path)
 int
 of_init_path(const char *dt_path)
 {
@@ -297,6 +299,7 @@ check_compatible(const struct dt_file *f, const char *compatible)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_find_compatible_node)
 const struct device_node *
 of_find_compatible_node(const struct device_node *from,
 			const char *type __rte_unused,
@@ -322,6 +325,7 @@ of_find_compatible_node(const struct device_node *from,
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_property)
 const void *
 of_get_property(const struct device_node *from, const char *name,
 		size_t *lenp)
@@ -341,6 +345,7 @@ of_get_property(const struct device_node *from, const char *name,
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_available)
 bool
 of_device_is_available(const struct device_node *dev_node)
 {
@@ -357,6 +362,7 @@ of_device_is_available(const struct device_node *dev_node)
 	return false;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_find_node_by_phandle)
 const struct device_node *
 of_find_node_by_phandle(uint64_t ph)
 {
@@ -370,6 +376,7 @@ of_find_node_by_phandle(uint64_t ph)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_parent)
 const struct device_node *
 of_get_parent(const struct device_node *dev_node)
 {
@@ -385,6 +392,7 @@ of_get_parent(const struct device_node *dev_node)
 	return &d->parent->node.node;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_next_child)
 const struct device_node *
 of_get_next_child(const struct device_node *dev_node,
 		  const struct device_node *prev)
@@ -414,6 +422,7 @@ of_get_next_child(const struct device_node *dev_node,
 	return &c->node.node;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_n_addr_cells)
 uint32_t
 of_n_addr_cells(const struct device_node *dev_node)
 {
@@ -458,6 +467,7 @@ of_n_size_cells(const struct device_node *dev_node)
 	return OF_DEFAULT_NS;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_address)
 const uint32_t *
 of_get_address(const struct device_node *dev_node, size_t idx,
 	       uint64_t *size, uint32_t *flags __rte_unused)
@@ -487,6 +497,7 @@ of_get_address(const struct device_node *dev_node, size_t idx,
 	return (const uint32_t *)buf;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_translate_address)
 uint64_t
 of_translate_address(const struct device_node *dev_node,
 		     const uint32_t *addr)
@@ -533,6 +544,7 @@ of_translate_address(const struct device_node *dev_node,
 	return phys_addr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_compatible)
 bool
 of_device_is_compatible(const struct device_node *dev_node,
 			const char *compatible)
@@ -573,6 +585,7 @@ static const void *of_get_mac_addr(const struct device_node *np,
  * this case, the real MAC is in 'local-mac-address', and 'mac-address' exists
  * but is all zeros.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_mac_address)
 const void *of_get_mac_address(const struct device_node *np)
 {
 	const void *addr;
diff --git a/drivers/common/dpaax/dpaax_iova_table.c b/drivers/common/dpaax/dpaax_iova_table.c
index 860e702333..1220d9654b 100644
--- a/drivers/common/dpaax/dpaax_iova_table.c
+++ b/drivers/common/dpaax/dpaax_iova_table.c
@@ -2,12 +2,14 @@
  * Copyright 2018-2023 NXP
  */
 
+#include <eal_export.h>
 #include <rte_memory.h>
 
 #include "dpaax_iova_table.h"
 #include "dpaax_logs.h"
 
 /* Global table reference */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_p)
 struct dpaax_iova_table *dpaax_iova_table_p;
 
 static int dpaax_handle_memevents(void);
@@ -153,6 +155,7 @@ read_memory_node(unsigned int *count)
 	return nodes;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_populate)
 int
 dpaax_iova_table_populate(void)
 {
@@ -254,6 +257,7 @@ dpaax_iova_table_populate(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_depopulate)
 void
 dpaax_iova_table_depopulate(void)
 {
@@ -263,6 +267,7 @@ dpaax_iova_table_depopulate(void)
 	DPAAX_DEBUG("IOVA Table cleaned");
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_update)
 int
 dpaax_iova_table_update(phys_addr_t paddr, void *vaddr, size_t length)
 {
@@ -349,6 +354,7 @@ dpaax_iova_table_update(phys_addr_t paddr, void *vaddr, size_t length)
  * Dump the table, with its entries, on screen. Only works in Debug Mode
  * Not for weak hearted - the tables can get quite large
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_dump)
 void
 dpaax_iova_table_dump(void)
 {
@@ -461,4 +467,5 @@ dpaax_handle_memevents(void)
 					       dpaax_memevent_cb, NULL);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_logger)
 RTE_LOG_REGISTER_DEFAULT(dpaax_logger, ERR);
diff --git a/drivers/common/ionic/ionic_common_uio.c b/drivers/common/ionic/ionic_common_uio.c
index c647b22eaf..aaefab918c 100644
--- a/drivers/common/ionic/ionic_common_uio.c
+++ b/drivers/common/ionic/ionic_common_uio.c
@@ -15,6 +15,7 @@
 #include <fcntl.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_string_fns.h>
@@ -103,6 +104,7 @@ uio_get_idx_for_devname(struct uio_name *name_cache, char *devname)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mnet_devices)
 void
 ionic_uio_scan_mnet_devices(void)
 {
@@ -146,6 +148,7 @@ ionic_uio_scan_mnet_devices(void)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mcrypt_devices)
 void
 ionic_uio_scan_mcrypt_devices(void)
 {
@@ -301,6 +304,7 @@ uio_get_map_res_addr(int uio_idx, int size, int res_idx)
 	return addr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_get_rsrc)
 void
 ionic_uio_get_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 {
@@ -319,6 +323,7 @@ ionic_uio_get_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 	bar->vaddr = ((char *)bar->vaddr) + offs;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_rel_rsrc)
 void
 ionic_uio_rel_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 {
diff --git a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
index 33479ffd68..b4ea604820 100644
--- a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
+++ b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
@@ -10,6 +10,7 @@
 #include <rte_errno.h>
 #include <bus_auxiliary_driver.h>
 #include <rte_common.h>
+#include <eal_export.h>
 #include "eal_filesystem.h"
 
 #include "mlx5_common_utils.h"
@@ -18,6 +19,7 @@
 #define AUXILIARY_SYSFS_PATH "/sys/bus/auxiliary/devices"
 #define MLX5_AUXILIARY_PREFIX "mlx5_core.sf."
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_auxiliary_get_child_name)
 int
 mlx5_auxiliary_get_child_name(const char *dev, const char *node,
 			      char *child, size_t size)
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2f5032f0da..2867e21618 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -13,6 +13,7 @@
 #include <net/if.h>
 #include <fcntl.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
 #include <bus_pci_driver.h>
@@ -27,9 +28,11 @@
 #include "mlx5_glue.h"
 
 #ifdef MLX5_GLUE
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
 const struct mlx5_glue *mlx5_glue;
 #endif
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_pci_addr)
 int
 mlx5_get_pci_addr(const char *dev_path, struct rte_pci_addr *pci_addr)
 {
@@ -89,6 +92,7 @@ mlx5_get_pci_addr(const char *dev_path, struct rte_pci_addr *pci_addr)
  * @return
  *   port_name field set according to recognized name format.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_translate_port_name)
 void
 mlx5_translate_port_name(const char *port_name_in,
 			 struct mlx5_switch_info *port_info_out)
@@ -155,6 +159,7 @@ mlx5_translate_port_name(const char *port_name_in,
 	port_info_out->name_type = MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_ifname_sysfs)
 int
 mlx5_get_ifname_sysfs(const char *ibdev_path, char *ifname)
 {
@@ -888,6 +893,7 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
  * @return
  *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx)
 void *
 mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 {
@@ -925,6 +931,7 @@ mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 	return (void *)ctx;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_device_guid)
 int
 mlx5_get_device_guid(const struct rte_pci_addr *dev, uint8_t *guid, size_t len)
 {
@@ -970,6 +977,7 @@ mlx5_get_device_guid(const struct rte_pci_addr *dev, uint8_t *guid, size_t len)
  * indirect mkey created by the DevX API.
  * This mkey should be used for DevX commands requesting mkey as a parameter.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create)
 int
 mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 			    size_t length, struct mlx5_pmd_wrapped_mr *pmd_mr)
@@ -1009,6 +1017,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy)
 void
 mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *pmd_mr)
 {
@@ -1040,6 +1049,7 @@ mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *pmd_mr)
  *  - Interrupt handle on success.
  *  - NULL on failure, with rte_errno set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_create)
 struct rte_intr_handle *
 mlx5_os_interrupt_handler_create(int mode, bool set_fd_nonblock, int fd,
 				 rte_intr_callback_fn cb, void *cb_arg)
@@ -1141,6 +1151,7 @@ mlx5_intr_callback_unregister(const struct rte_intr_handle *handle,
  *   Callback argument for cb.
  *
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_destroy)
 void
 mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 				  rte_intr_callback_fn cb, void *cb_arg)
diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index cf2f7ecbf3..98260df470 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -10,6 +10,7 @@
 #include <sys/mman.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_eal_paging.h>
 
@@ -105,6 +106,7 @@ mlx5_set_context_attr(struct rte_device *dev, struct ibv_context *ctx)
  * @return
  *   0 on successful registration, -1 otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_mr)
 int
 mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 			 struct mlx5_pmd_mr *pmd_mr)
@@ -134,6 +136,7 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
  *   pmd_mr struct set with lkey, address, length and pointer to mr object
  *
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_dereg_mr)
 void
 mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 {
@@ -151,6 +154,7 @@ mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
 mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 {
diff --git a/drivers/common/mlx5/linux/mlx5_glue.c b/drivers/common/mlx5/linux/mlx5_glue.c
index 99761ea0b2..a91eaa429d 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.c
+++ b/drivers/common/mlx5/linux/mlx5_glue.c
@@ -16,6 +16,8 @@
 
 #include "mlx5_glue.h"
 
+#include <eal_export.h>
+
 static int
 mlx5_glue_fork_init(void)
 {
@@ -1578,6 +1580,7 @@ mlx5_glue_dv_destroy_steering_anchor(struct mlx5dv_steering_anchor *sa)
 #endif
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
 alignas(RTE_CACHE_LINE_SIZE)
 const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue) {
 	.version = MLX5_GLUE_VERSION,
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 12f1a620f3..86166e92d0 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -17,6 +17,7 @@
 #include <sys/socket.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 
 #include "mlx5_nl.h"
@@ -195,6 +196,7 @@ RTE_ATOMIC(uint32_t) atomic_sn;
  *   A file descriptor on success, a negative errno value otherwise and
  *   rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_init)
 int
 mlx5_nl_init(int protocol, int groups)
 {
@@ -641,6 +643,7 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  * @return
  *    0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vf_mac_addr_modify)
 int
 mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 			   struct rte_ether_addr *mac, int vf_index)
@@ -728,6 +731,7 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_add)
 int
 mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
 		     uint64_t *mac_own, struct rte_ether_addr *mac,
@@ -765,6 +769,7 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_remove)
 int
 mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
 			struct rte_ether_addr *mac, uint32_t index)
@@ -789,6 +794,7 @@ mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
  * @param n
  *   @p mac_addrs array size.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_sync)
 void
 mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 		      struct rte_ether_addr *mac_addrs, int n)
@@ -845,6 +851,7 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
  * @param mac_own
  *   BITFIELD_DECLARE array to store the mac.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_flush)
 void
 mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
 		       struct rte_ether_addr *mac_addrs, int n,
@@ -923,6 +930,7 @@ mlx5_nl_device_flags(int nlsk_fd, unsigned int iface_idx, uint32_t flags,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_promisc)
 int
 mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable)
 {
@@ -949,6 +957,7 @@ mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_allmulti)
 int
 mlx5_nl_allmulti(int nlsk_fd, unsigned int iface_idx, int enable)
 {
@@ -1138,6 +1147,7 @@ mlx5_nl_port_info(int nl, uint32_t pindex, struct mlx5_nl_port_info *data)
  *   A valid (nonzero) interface index on success, 0 otherwise and rte_errno
  *   is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_ifindex)
 unsigned int
 mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info *dev_info)
 {
@@ -1194,6 +1204,7 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
  *   Port state (ibv_port_state) on success, negative on error
  *   and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_port_state)
 int
 mlx5_nl_port_state(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info *dev_info)
 {
@@ -1229,6 +1240,7 @@ mlx5_nl_port_state(int nl, const char *name, uint32_t pindex, struct mlx5_dev_in
  *   A valid (nonzero) number of ports on success, 0 otherwise
  *   and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_portnum)
 unsigned int
 mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 {
@@ -1435,6 +1447,7 @@ mlx5_nl_switch_info_cb(struct nlmsghdr *nh, void *arg)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_switch_info)
 int
 mlx5_nl_switch_info(int nl, unsigned int ifindex,
 		    struct mlx5_switch_info *info)
@@ -1485,6 +1498,7 @@ mlx5_nl_switch_info(int nl, unsigned int ifindex,
  * @param[in] ifindex
  *   Interface index of network device to delete.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_delete)
 void
 mlx5_nl_vlan_vmwa_delete(struct mlx5_nl_vlan_vmwa_context *vmwa,
 		      uint32_t ifindex)
@@ -1562,6 +1576,7 @@ nl_attr_nest_end(struct nlmsghdr *nlh, struct nlattr *nest)
  * @param[in] tag
  *   VLAN tag for VLAN network device to create.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_create)
 uint32_t
 mlx5_nl_vlan_vmwa_create(struct mlx5_nl_vlan_vmwa_context *vmwa,
 			 uint32_t ifindex, uint16_t tag)
@@ -1714,6 +1729,7 @@ mlx5_nl_generic_family_id_get(int nlsk_fd, const char *name)
  *   otherwise and rte_errno is set.
  */
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_family_id_get)
 int
 mlx5_nl_devlink_family_id_get(int nlsk_fd)
 {
@@ -1940,6 +1956,7 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
  * @return
  *  0 on success, negative on failure.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_parse_link_status_update)
 int
 mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex)
 {
@@ -1971,6 +1988,7 @@ mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex)
  *  0 on success, including the case when there are no events.
  *  Negative on failure and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_read_events)
 int
 mlx5_nl_read_events(int nlsk_fd, mlx5_nl_event_cb *cb, void *cb_arg)
 {
@@ -2058,6 +2076,7 @@ mlx5_nl_esw_multiport_cb(struct nlmsghdr *nh, void *arg)
 
 #define NL_ESW_MULTIPORT_PARAM "esw_multiport"
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_esw_multiport_get)
 int
 mlx5_nl_devlink_esw_multiport_get(int nlsk_fd, int family_id, const char *pci_addr, int *enable)
 {
@@ -2096,12 +2115,14 @@ mlx5_nl_devlink_esw_multiport_get(int nlsk_fd, int family_id, const char *pci_ad
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_init)
 int
 mlx5_nl_rdma_monitor_init(void)
 {
 	return mlx5_nl_init(NETLINK_RDMA, RDMA_NL_GROUP_NOTIFICATION);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_info_get)
 void
 mlx5_nl_rdma_monitor_info_get(struct nlmsghdr *hdr, struct mlx5_nl_port_info *data)
 {
@@ -2196,6 +2217,7 @@ mlx5_nl_rdma_monitor_cap_get_cb(struct nlmsghdr *hdr, void *arg)
  * @return
  *   0 on success, negative on error and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_cap_get)
 int
 mlx5_nl_rdma_monitor_cap_get(int nl, uint8_t *cap)
 {
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 9abae4a374..4f25127582 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <pthread.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_mempool.h>
 #include <rte_class.h>
@@ -20,6 +21,7 @@
 #include "mlx5_common_defs.h"
 #include "mlx5_common_private.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(haswell_broadwell_cpu)
 uint8_t haswell_broadwell_cpu;
 
 /* Driver type key for new device global syntax. */
@@ -127,6 +129,7 @@ driver_get(uint32_t class)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_kvargs_process)
 int
 mlx5_kvargs_process(struct mlx5_kvargs_ctrl *mkvlist, const char *const keys[],
 		    arg_handler_t handler, void *opaque_arg)
@@ -463,6 +466,7 @@ to_mlx5_device(const struct rte_device *rte_dev)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_to_pci_str)
 int
 mlx5_dev_to_pci_str(const struct rte_device *dev, char *addr, size_t size)
 {
@@ -512,6 +516,7 @@ mlx5_dev_mempool_register(struct mlx5_common_device *cdev,
  * @param mp
  *   Mempool being unregistered.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_unregister)
 void
 mlx5_dev_mempool_unregister(struct mlx5_common_device *cdev,
 			    struct rte_mempool *mp)
@@ -591,6 +596,7 @@ mlx5_dev_mempool_event_cb(enum rte_mempool_event event, struct rte_mempool *mp,
  * Callbacks addresses are local in each process.
  * Therefore, each process can register private callbacks.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_subscribe)
 int
 mlx5_dev_mempool_subscribe(struct mlx5_common_device *cdev)
 {
@@ -1220,6 +1226,7 @@ mlx5_common_dev_dma_unmap(struct rte_device *rte_dev, void *addr,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_class_driver_register)
 void
 mlx5_class_driver_register(struct mlx5_class_driver *driver)
 {
@@ -1242,6 +1249,7 @@ static bool mlx5_common_initialized;
  * for multiple PMDs. Each mlx5 PMD that depends on mlx5_common module,
  * must invoke in its constructor.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_init)
 void
 mlx5_common_init(void)
 {
@@ -1400,6 +1408,7 @@ mlx5_devx_alloc_uar(struct mlx5_common_device *cdev)
 	return uar;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_release)
 void
 mlx5_devx_uar_release(struct mlx5_uar *uar)
 {
@@ -1408,6 +1417,7 @@ mlx5_devx_uar_release(struct mlx5_uar *uar)
 	memset(uar, 0, sizeof(*uar));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_prepare)
 int
 mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 {
diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index 431d8361ce..cd1292b92b 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -3,6 +3,7 @@
  */
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_common.h>
 #include <rte_eal_paging.h>
@@ -23,6 +24,7 @@
  * @param[in] cq
  *   DevX CQ to destroy.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_destroy)
 void
 mlx5_devx_cq_destroy(struct mlx5_devx_cq *cq)
 {
@@ -77,6 +79,7 @@ mlx5_cq_init(struct mlx5_devx_cq *cq_obj, uint16_t cq_size)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_create)
 int
 mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 		    struct mlx5_devx_cq_attr *attr, int socket)
@@ -162,6 +165,7 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
  * @param[in] sq
  *   DevX SQ to destroy.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_destroy)
 void
 mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
 {
@@ -204,6 +208,7 @@ mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_create)
 int
 mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 		    struct mlx5_devx_create_sq_attr *attr, int socket)
@@ -312,6 +317,7 @@ mlx5_devx_rmp_destroy(struct mlx5_devx_rmp *rmp)
  * @param[in] qp
  *   DevX QP to destroy.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_destroy)
 void
 mlx5_devx_qp_destroy(struct mlx5_devx_qp *qp)
 {
@@ -350,6 +356,7 @@ mlx5_devx_qp_destroy(struct mlx5_devx_qp *qp)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_create)
 int
 mlx5_devx_qp_create(void *ctx, struct mlx5_devx_qp *qp_obj, uint32_t queue_size,
 		    struct mlx5_devx_qp_attr *attr, int socket)
@@ -420,6 +427,7 @@ mlx5_devx_qp_create(void *ctx, struct mlx5_devx_qp *qp_obj, uint32_t queue_size,
  * @param[in] rq
  *   DevX RQ to destroy.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_destroy)
 void
 mlx5_devx_rq_destroy(struct mlx5_devx_rq *rq)
 {
@@ -695,6 +703,7 @@ mlx5_devx_rq_shared_create(void *ctx, struct mlx5_devx_rq *rq_obj,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_create)
 int
 mlx5_devx_rq_create(void *ctx, struct mlx5_devx_rq *rq_obj,
 		    uint32_t wqe_size, uint16_t log_wqbb_n,
@@ -718,6 +727,7 @@ mlx5_devx_rq_create(void *ctx, struct mlx5_devx_rq *rq_obj,
  * @return
  *	 0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp2rts)
 int
 mlx5_devx_qp2rts(struct mlx5_devx_qp *qp, uint32_t remote_qp_id)
 {
diff --git a/drivers/common/mlx5/mlx5_common_mp.c b/drivers/common/mlx5/mlx5_common_mp.c
index a7a671b7c5..1ff268f348 100644
--- a/drivers/common/mlx5/mlx5_common_mp.c
+++ b/drivers/common/mlx5/mlx5_common_mp.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <time.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_errno.h>
 
@@ -24,6 +25,7 @@
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mr_create)
 int
 mlx5_mp_req_mr_create(struct mlx5_common_device *cdev, uintptr_t addr)
 {
@@ -63,6 +65,7 @@ mlx5_mp_req_mr_create(struct mlx5_common_device *cdev, uintptr_t addr)
  * @param reg
  *   True to register the mempool, False to unregister.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mempool_reg)
 int
 mlx5_mp_req_mempool_reg(struct mlx5_common_device *cdev,
 			struct rte_mempool *mempool, bool reg,
@@ -113,6 +116,7 @@ mlx5_mp_req_mempool_reg(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_queue_state_modify)
 int
 mlx5_mp_req_queue_state_modify(struct mlx5_mp_id *mp_id,
 			       struct mlx5_mp_arg_queue_state_modify *sm)
@@ -151,6 +155,7 @@ mlx5_mp_req_queue_state_modify(struct mlx5_mp_id *mp_id,
  * @return
  *   fd on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_verbs_cmd_fd)
 int
 mlx5_mp_req_verbs_cmd_fd(struct mlx5_mp_id *mp_id)
 {
@@ -192,6 +197,7 @@ mlx5_mp_req_verbs_cmd_fd(struct mlx5_mp_id *mp_id)
 /**
  * Initialize by primary process.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_primary)
 int
 mlx5_mp_init_primary(const char *name, const rte_mp_t primary_action)
 {
@@ -209,6 +215,7 @@ mlx5_mp_init_primary(const char *name, const rte_mp_t primary_action)
 /**
  * Un-initialize by primary process.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_primary)
 void
 mlx5_mp_uninit_primary(const char *name)
 {
@@ -219,6 +226,7 @@ mlx5_mp_uninit_primary(const char *name)
 /**
  * Initialize by secondary process.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_secondary)
 int
 mlx5_mp_init_secondary(const char *name, const rte_mp_t secondary_action)
 {
@@ -229,6 +237,7 @@ mlx5_mp_init_secondary(const char *name, const rte_mp_t secondary_action)
 /**
  * Un-initialize by secondary process.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_secondary)
 void
 mlx5_mp_uninit_secondary(const char *name)
 {
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 50922ad398..c41ffff2d5 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -4,6 +4,7 @@
  */
 #include <stddef.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
@@ -51,6 +52,7 @@ struct mlx5_mempool_reg {
 	bool is_extmem;
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mprq_buf_free_cb)
 void
 mlx5_mprq_buf_free_cb(void *addr __rte_unused, void *opaque)
 {
@@ -249,6 +251,7 @@ mlx5_mr_btree_init(struct mlx5_mr_btree *bt, int n, int socket)
  * @param bt
  *   Pointer to B-tree structure.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_btree_free)
 void
 mlx5_mr_btree_free(struct mlx5_mr_btree *bt)
 {
@@ -299,6 +302,7 @@ mlx5_mr_btree_dump(struct mlx5_mr_btree *bt __rte_unused)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_ctrl_init)
 int
 mlx5_mr_ctrl_init(struct mlx5_mr_ctrl *mr_ctrl, uint32_t *dev_gen_ptr,
 		  int socket)
@@ -965,6 +969,7 @@ mlx5_mr_create_primary(void *pd,
  * @return
  *   Searched LKey on success, UINT32_MAX on failure and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_create)
 uint32_t
 mlx5_mr_create(struct mlx5_common_device *cdev,
 	       struct mlx5_mr_share_cache *share_cache,
@@ -1059,6 +1064,7 @@ mr_lookup_caches(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *   Searched LKey on success, UINT32_MAX on no match.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_addr2mr_bh)
 uint32_t
 mlx5_mr_addr2mr_bh(struct mlx5_mr_ctrl *mr_ctrl, uintptr_t addr)
 {
@@ -1149,6 +1155,7 @@ mlx5_mr_create_cache(struct mlx5_mr_share_cache *share_cache, int socket)
  * @param mr_ctrl
  *   Pointer to per-queue MR local cache.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_flush_local_cache)
 void
 mlx5_mr_flush_local_cache(struct mlx5_mr_ctrl *mr_ctrl)
 {
@@ -1803,6 +1810,7 @@ mlx5_mr_mempool_register_secondary(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, (-1) on failure and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_register)
 int
 mlx5_mr_mempool_register(struct mlx5_common_device *cdev,
 			 struct rte_mempool *mp, bool is_extmem)
@@ -1868,6 +1876,7 @@ mlx5_mr_mempool_unregister_secondary(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, (-1) on failure and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_unregister)
 int
 mlx5_mr_mempool_unregister(struct mlx5_common_device *cdev,
 			   struct rte_mempool *mp)
@@ -1979,6 +1988,7 @@ mlx5_lookup_mempool_regs(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *  0 on success, (-1) on failure and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_populate_cache)
 int
 mlx5_mr_mempool_populate_cache(struct mlx5_mr_ctrl *mr_ctrl,
 			       struct rte_mempool *mp)
@@ -2038,6 +2048,7 @@ mlx5_mr_mempool_populate_cache(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *   MR lkey on success, UINT32_MAX on failure.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool2mr_bh)
 uint32_t
 mlx5_mr_mempool2mr_bh(struct mlx5_mr_ctrl *mr_ctrl,
 		      struct rte_mempool *mp, uintptr_t addr)
@@ -2064,6 +2075,7 @@ mlx5_mr_mempool2mr_bh(struct mlx5_mr_ctrl *mr_ctrl,
 	return lkey;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mb2mr_bh)
 uint32_t
 mlx5_mr_mb2mr_bh(struct mlx5_mr_ctrl *mr_ctrl, struct rte_mbuf *mb)
 {
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 04aad0963c..819b799bb8 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_devargs.h>
 #include <rte_errno.h>
@@ -102,12 +103,14 @@ pci_ids_table_update(const struct rte_pci_id *driver_id_table)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_pci)
 bool
 mlx5_dev_is_pci(const struct rte_device *dev)
 {
 	return strcmp(dev->bus->name, "pci") == 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_vf_pci)
 bool
 mlx5_dev_is_vf_pci(const struct rte_pci_device *pci_dev)
 {
diff --git a/drivers/common/mlx5/mlx5_common_utils.c b/drivers/common/mlx5/mlx5_common_utils.c
index 4b95d35d35..14056cebcb 100644
--- a/drivers/common/mlx5/mlx5_common_utils.c
+++ b/drivers/common/mlx5/mlx5_common_utils.c
@@ -2,6 +2,7 @@
  * Copyright 2019 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_hash_crc.h>
 #include <rte_errno.h>
@@ -26,6 +27,7 @@ mlx5_list_init(struct mlx5_list_inconst *l_inconst,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_create)
 struct mlx5_list *
 mlx5_list_create(const char *name, void *ctx, bool lcores_share,
 		 mlx5_list_create_cb cb_create,
@@ -120,6 +122,7 @@ _mlx5_list_lookup(struct mlx5_list_inconst *l_inconst,
 	return entry;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_lookup)
 struct mlx5_list_entry *
 mlx5_list_lookup(struct mlx5_list *list, void *ctx)
 {
@@ -260,6 +263,7 @@ _mlx5_list_register(struct mlx5_list_inconst *l_inconst,
 	return local_entry;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_register)
 struct mlx5_list_entry *
 mlx5_list_register(struct mlx5_list *list, void *ctx)
 {
@@ -319,6 +323,7 @@ _mlx5_list_unregister(struct mlx5_list_inconst *l_inconst,
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_unregister)
 int
 mlx5_list_unregister(struct mlx5_list *list,
 		      struct mlx5_list_entry *entry)
@@ -366,6 +371,7 @@ mlx5_list_uninit(struct mlx5_list_inconst *l_inconst,
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_destroy)
 void
 mlx5_list_destroy(struct mlx5_list *list)
 {
@@ -373,6 +379,7 @@ mlx5_list_destroy(struct mlx5_list *list)
 	mlx5_free(list);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_get_entry_num)
 uint32_t
 mlx5_list_get_entry_num(struct mlx5_list *list)
 {
@@ -382,6 +389,7 @@ mlx5_list_get_entry_num(struct mlx5_list *list)
 
 /********************* Hash List **********************/
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_create)
 struct mlx5_hlist *
 mlx5_hlist_create(const char *name, uint32_t size, bool direct_key,
 		  bool lcores_share, void *ctx, mlx5_list_create_cb cb_create,
@@ -447,6 +455,7 @@ mlx5_hlist_create(const char *name, uint32_t size, bool direct_key,
 }
 
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_lookup)
 struct mlx5_list_entry *
 mlx5_hlist_lookup(struct mlx5_hlist *h, uint64_t key, void *ctx)
 {
@@ -459,6 +468,7 @@ mlx5_hlist_lookup(struct mlx5_hlist *h, uint64_t key, void *ctx)
 	return _mlx5_list_lookup(&h->buckets[idx].l, &h->l_const, ctx);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_register)
 struct mlx5_list_entry*
 mlx5_hlist_register(struct mlx5_hlist *h, uint64_t key, void *ctx)
 {
@@ -487,6 +497,7 @@ mlx5_hlist_register(struct mlx5_hlist *h, uint64_t key, void *ctx)
 	return entry;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_unregister)
 int
 mlx5_hlist_unregister(struct mlx5_hlist *h, struct mlx5_list_entry *entry)
 {
@@ -505,6 +516,7 @@ mlx5_hlist_unregister(struct mlx5_hlist *h, struct mlx5_list_entry *entry)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_destroy)
 void
 mlx5_hlist_destroy(struct mlx5_hlist *h)
 {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 440820fd4f..39a4298b58 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -4,6 +4,7 @@
 
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_eal_paging.h>
@@ -86,6 +87,7 @@ mlx5_devx_get_hca_cap(void *ctx, uint32_t *in, uint32_t *out,
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_read)
 int
 mlx5_devx_cmd_register_read(void *ctx, uint16_t reg_id, uint32_t arg,
 			    uint32_t *data, uint32_t dw_cnt)
@@ -136,6 +138,7 @@ mlx5_devx_cmd_register_read(void *ctx, uint16_t reg_id, uint32_t arg,
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_write)
 int
 mlx5_devx_cmd_register_write(void *ctx, uint16_t reg_id, uint32_t arg,
 			     uint32_t *data, uint32_t dw_cnt)
@@ -176,6 +179,7 @@ mlx5_devx_cmd_register_write(void *ctx, uint16_t reg_id, uint32_t arg,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc_general)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_flow_counter_alloc_general(void *ctx,
 		struct mlx5_devx_counter_attr *attr)
@@ -225,6 +229,7 @@ mlx5_devx_cmd_flow_counter_alloc_general(void *ctx,
  *   Pointer to counter object on success, a negative value otherwise and
  *   rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_flow_counter_alloc(void *ctx, uint32_t bulk_n_128)
 {
@@ -276,6 +281,7 @@ mlx5_devx_cmd_flow_counter_alloc(void *ctx, uint32_t bulk_n_128)
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_query)
 int
 mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
 				 int clear, uint32_t n_counters,
@@ -337,6 +343,7 @@ mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
  *   Pointer to Devx mkey on success, a negative value otherwise and rte_errno
  *   is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_mkey_create)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_mkey_create(void *ctx,
 			  struct mlx5_devx_mkey_attr *attr)
@@ -440,6 +447,7 @@ mlx5_devx_cmd_mkey_create(void *ctx,
  * @return
  *   0 on success, non-zero value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_get_out_command_status)
 int
 mlx5_devx_get_out_command_status(void *out)
 {
@@ -466,6 +474,7 @@ mlx5_devx_get_out_command_status(void *out)
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_destroy)
 int
 mlx5_devx_cmd_destroy(struct mlx5_devx_obj *obj)
 {
@@ -625,6 +634,7 @@ mlx5_devx_cmd_query_hca_vdpa_attr(void *ctx,
  * @return
  *   0 on success, a negative errno otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_match_sample_info_query)
 int
 mlx5_devx_cmd_match_sample_info_query(void *ctx, uint32_t sample_field_id,
 				      struct mlx5_devx_match_sample_info_query_attr *attr)
@@ -662,6 +672,7 @@ mlx5_devx_cmd_match_sample_info_query(void *ctx, uint32_t sample_field_id,
 #endif
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_parse_samples)
 int
 mlx5_devx_cmd_query_parse_samples(struct mlx5_devx_obj *flex_obj,
 				  uint32_t *ids,
@@ -716,6 +727,7 @@ mlx5_devx_cmd_query_parse_samples(struct mlx5_devx_obj *flex_obj,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flex_parser)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flex_parser(void *ctx,
 				 struct mlx5_devx_graph_node_attr *data)
@@ -916,6 +928,7 @@ mlx5_devx_query_pkt_integrity_match(void *hcattr)
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_hca_attr)
 int
 mlx5_devx_cmd_query_hca_attr(void *ctx,
 			     struct mlx5_hca_attr *attr)
@@ -1425,6 +1438,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_qp_query_tis_td)
 int
 mlx5_devx_cmd_qp_query_tis_td(void *qp, uint32_t tis_num,
 			      uint32_t *tis_td)
@@ -1511,6 +1525,7 @@ devx_cmd_fill_wq_data(void *wq_ctx, struct mlx5_devx_wq_attr *wq_attr)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rq)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rq(void *ctx,
 			struct mlx5_devx_create_rq_attr *rq_attr,
@@ -1569,6 +1584,7 @@ mlx5_devx_cmd_create_rq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rq)
 int
 mlx5_devx_cmd_modify_rq(struct mlx5_devx_obj *rq,
 			struct mlx5_devx_modify_rq_attr *rq_attr)
@@ -1622,6 +1638,7 @@ mlx5_devx_cmd_modify_rq(struct mlx5_devx_obj *rq,
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_rq)
 int
 mlx5_devx_cmd_query_rq(struct mlx5_devx_obj *rq_obj, void *out, size_t outlen)
 {
@@ -1651,6 +1668,7 @@ mlx5_devx_cmd_query_rq(struct mlx5_devx_obj *rq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rmp)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rmp(void *ctx,
 			 struct mlx5_devx_create_rmp_attr *rmp_attr,
@@ -1698,6 +1716,7 @@ mlx5_devx_cmd_create_rmp(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tir)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_tir(void *ctx,
 			 struct mlx5_devx_tir_attr *tir_attr)
@@ -1766,6 +1785,7 @@ mlx5_devx_cmd_create_tir(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_tir)
 int
 mlx5_devx_cmd_modify_tir(struct mlx5_devx_obj *tir,
 			 struct mlx5_devx_modify_tir_attr *modify_tir_attr)
@@ -1850,6 +1870,7 @@ mlx5_devx_cmd_modify_tir(struct mlx5_devx_obj *tir,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rqt)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rqt(void *ctx,
 			 struct mlx5_devx_rqt_attr *rqt_attr)
@@ -1904,6 +1925,7 @@ mlx5_devx_cmd_create_rqt(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rqt)
 int
 mlx5_devx_cmd_modify_rqt(struct mlx5_devx_obj *rqt,
 			 struct mlx5_devx_rqt_attr *rqt_attr)
@@ -1952,6 +1974,7 @@ mlx5_devx_cmd_modify_rqt(struct mlx5_devx_obj *rqt,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  **/
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_sq)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_sq(void *ctx,
 			struct mlx5_devx_create_sq_attr *sq_attr)
@@ -2018,6 +2041,7 @@ mlx5_devx_cmd_create_sq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_sq)
 int
 mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
 			struct mlx5_devx_modify_sq_attr *sq_attr)
@@ -2057,6 +2081,7 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_sq)
 int
 mlx5_devx_cmd_query_sq(struct mlx5_devx_obj *sq_obj, void *out, size_t outlen)
 {
@@ -2084,6 +2109,7 @@ mlx5_devx_cmd_query_sq(struct mlx5_devx_obj *sq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tis)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_tis(void *ctx,
 			 struct mlx5_devx_tis_attr *tis_attr)
@@ -2127,6 +2153,7 @@ mlx5_devx_cmd_create_tis(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_td)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_td(void *ctx)
 {
@@ -2169,6 +2196,7 @@ mlx5_devx_cmd_create_td(void *ctx)
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_dump)
 int
 mlx5_devx_cmd_flow_dump(void *fdb_domain __rte_unused,
 			void *rx_domain __rte_unused,
@@ -2194,6 +2222,7 @@ mlx5_devx_cmd_flow_dump(void *fdb_domain __rte_unused,
 	return -ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_single_dump)
 int
 mlx5_devx_cmd_flow_single_dump(void *rule_info __rte_unused,
 			FILE *file __rte_unused)
@@ -2219,6 +2248,7 @@ mlx5_devx_cmd_flow_single_dump(void *rule_info __rte_unused,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_cq)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_cq(void *ctx, struct mlx5_devx_cq_attr *attr)
 {
@@ -2287,6 +2317,7 @@ mlx5_devx_cmd_create_cq(void *ctx, struct mlx5_devx_cq_attr *attr)
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_cq)
 int
 mlx5_devx_cmd_query_cq(struct mlx5_devx_obj *cq_obj, void *out, size_t outlen)
 {
@@ -2314,6 +2345,7 @@ mlx5_devx_cmd_query_cq(struct mlx5_devx_obj *cq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtq)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_virtq(void *ctx,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2390,6 +2422,7 @@ mlx5_devx_cmd_create_virtq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_virtq)
 int
 mlx5_devx_cmd_modify_virtq(struct mlx5_devx_obj *virtq_obj,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2488,6 +2521,7 @@ mlx5_devx_cmd_modify_virtq(struct mlx5_devx_obj *virtq_obj,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtq)
 int
 mlx5_devx_cmd_query_virtq(struct mlx5_devx_obj *virtq_obj,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2530,6 +2564,7 @@ mlx5_devx_cmd_query_virtq(struct mlx5_devx_obj *virtq_obj,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_qp)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_qp(void *ctx,
 			struct mlx5_devx_qp_attr *attr)
@@ -2632,6 +2667,7 @@ mlx5_devx_cmd_create_qp(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_qp_state)
 int
 mlx5_devx_cmd_modify_qp_state(struct mlx5_devx_obj *qp, uint32_t qp_st_mod_op,
 			      uint32_t remote_qp_id)
@@ -2709,6 +2745,7 @@ mlx5_devx_cmd_modify_qp_state(struct mlx5_devx_obj *qp, uint32_t qp_st_mod_op,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtio_q_counters)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_virtio_q_counters(void *ctx)
 {
@@ -2740,6 +2777,7 @@ mlx5_devx_cmd_create_virtio_q_counters(void *ctx)
 	return couners_obj;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtio_q_counters)
 int
 mlx5_devx_cmd_query_virtio_q_counters(struct mlx5_devx_obj *couners_obj,
 				   struct mlx5_devx_virtio_q_couners_attr *attr)
@@ -2789,6 +2827,7 @@ mlx5_devx_cmd_query_virtio_q_counters(struct mlx5_devx_obj *couners_obj,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_hit_aso_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flow_hit_aso_obj(void *ctx, uint32_t pd)
 {
@@ -2831,6 +2870,7 @@ mlx5_devx_cmd_create_flow_hit_aso_obj(void *ctx, uint32_t pd)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_alloc_pd)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_alloc_pd(void *ctx)
 {
@@ -2871,6 +2911,7 @@ mlx5_devx_cmd_alloc_pd(void *ctx)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_meter_aso_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flow_meter_aso_obj(void *ctx, uint32_t pd,
 						uint32_t log_obj_size)
@@ -2924,6 +2965,7 @@ mlx5_devx_cmd_create_flow_meter_aso_obj(void *ctx, uint32_t pd,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_conn_track_offload_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_conn_track_offload_obj(void *ctx, uint32_t pd,
 					    uint32_t log_obj_size)
@@ -2970,6 +3012,7 @@ mlx5_devx_cmd_create_conn_track_offload_obj(void *ctx, uint32_t pd,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_geneve_tlv_option)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_geneve_tlv_option(void *ctx,
 				  struct mlx5_devx_geneve_tlv_option_attr *attr)
@@ -3032,6 +3075,7 @@ mlx5_devx_cmd_create_geneve_tlv_option(void *ctx,
  * @return
  *   0 on success, a negative errno otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_geneve_tlv_option)
 int
 mlx5_devx_cmd_query_geneve_tlv_option(void *ctx,
 				      struct mlx5_devx_obj *geneve_tlv_opt_obj,
@@ -3069,6 +3113,7 @@ mlx5_devx_cmd_query_geneve_tlv_option(void *ctx,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_wq_query)
 int
 mlx5_devx_cmd_wq_query(void *wq, uint32_t *counter_set_id)
 {
@@ -3109,6 +3154,7 @@ mlx5_devx_cmd_wq_query(void *wq, uint32_t *counter_set_id)
  *   Pointer to counter object on success, a NULL value otherwise and
  *   rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_alloc)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_queue_counter_alloc(void *ctx, int *syndrome)
 {
@@ -3150,6 +3196,7 @@ mlx5_devx_cmd_queue_counter_alloc(void *ctx, int *syndrome)
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_query)
 int
 mlx5_devx_cmd_queue_counter_query(struct mlx5_devx_obj *dcs, int clear,
 				  uint32_t *out_of_buffers)
@@ -3185,6 +3232,7 @@ mlx5_devx_cmd_queue_counter_query(struct mlx5_devx_obj *dcs, int clear,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_dek_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_dek_obj(void *ctx, struct mlx5_devx_dek_attr *attr)
 {
@@ -3235,6 +3283,7 @@ mlx5_devx_cmd_create_dek_obj(void *ctx, struct mlx5_devx_dek_attr *attr)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_import_kek_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_import_kek_obj(void *ctx,
 				    struct mlx5_devx_import_kek_attr *attr)
@@ -3282,6 +3331,7 @@ mlx5_devx_cmd_create_import_kek_obj(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_credential_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_credential_obj(void *ctx,
 				    struct mlx5_devx_credential_attr *attr)
@@ -3330,6 +3380,7 @@ mlx5_devx_cmd_create_credential_obj(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_crypto_login_obj)
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_crypto_login_obj(void *ctx,
 				      struct mlx5_devx_crypto_login_attr *attr)
@@ -3381,6 +3432,7 @@ mlx5_devx_cmd_create_crypto_login_obj(void *ctx,
  * @return
  *   0 on success, a negative value otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_lag)
 int
 mlx5_devx_cmd_query_lag(void *ctx,
 			struct mlx5_devx_lag_context *lag_ctx)
diff --git a/drivers/common/mlx5/mlx5_malloc.c b/drivers/common/mlx5/mlx5_malloc.c
index ef6dabedbd..d56b4fb5a8 100644
--- a/drivers/common/mlx5/mlx5_malloc.c
+++ b/drivers/common/mlx5/mlx5_malloc.c
@@ -3,6 +3,7 @@
  */
 
 #include <errno.h>
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <malloc.h>
 #include <stdbool.h>
@@ -161,6 +162,7 @@ mlx5_alloc_align(size_t size, unsigned int align, unsigned int zero)
 	return buf;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_malloc)
 void *
 mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 {
@@ -205,6 +207,7 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 	return addr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_realloc)
 void *
 mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	     int socket)
@@ -252,6 +255,7 @@ mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	return new_addr;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_free)
 void
 mlx5_free(void *addr)
 {
@@ -272,6 +276,7 @@ mlx5_free(void *addr)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_memory_stat_dump)
 void
 mlx5_memory_stat_dump(void)
 {
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 68f1981193..7fac361460 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_mempool.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
@@ -281,6 +282,7 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
  * @return
  *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx)
 void *
 mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 {
@@ -312,6 +314,7 @@ mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
  * @return
  *   umem on successful registration, NULL and errno otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_reg)
 void *
 mlx5_os_umem_reg(void *ctx, void *addr, size_t size, uint32_t access)
 {
@@ -342,6 +345,7 @@ mlx5_os_umem_reg(void *ctx, void *addr, size_t size, uint32_t access)
  * @return
  *   0 on successful release, negative number otherwise
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_dereg)
 int
 mlx5_os_umem_dereg(void *pumem)
 {
@@ -442,6 +446,7 @@ mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *   Pointer to dereg_mr func
  *
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
 mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 {
@@ -453,6 +458,7 @@ mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
  * In Windows, no need to wrap the MR, no known issue for it in kernel.
  * Use the regular function to create direct MR.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create)
 int
 mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 			    size_t length, struct mlx5_pmd_wrapped_mr *wpmd_mr)
@@ -472,6 +478,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy)
 void
 mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *wpmd_mr)
 {
diff --git a/drivers/common/mlx5/windows/mlx5_glue.c b/drivers/common/mlx5/windows/mlx5_glue.c
index 6935811bf4..066e2fdce3 100644
--- a/drivers/common/mlx5/windows/mlx5_glue.c
+++ b/drivers/common/mlx5/windows/mlx5_glue.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 
 #include "mlx5_glue.h"
@@ -409,8 +410,7 @@ mlx5_glue_devx_set_mtu(void *ctx, uint32_t mtu)
 
 }
 
-
-
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
 alignas(RTE_CACHE_LINE_SIZE)
 const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue){
 	.version = MLX5_GLUE_VERSION,
diff --git a/drivers/common/mvep/mvep_common.c b/drivers/common/mvep/mvep_common.c
index 67fa65b574..2035300cce 100644
--- a/drivers/common/mvep/mvep_common.c
+++ b/drivers/common/mvep/mvep_common.c
@@ -2,6 +2,7 @@
  *  Copyright(c) 2018 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_common.h>
 
 #include <env/mv_autogen_comp_flags.h>
@@ -18,6 +19,7 @@ struct mvep {
 
 static struct mvep mvep;
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_init)
 int rte_mvep_init(enum mvep_module_type module __rte_unused,
 		  struct rte_kvargs *kvlist __rte_unused)
 {
@@ -34,6 +36,7 @@ int rte_mvep_init(enum mvep_module_type module __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_deinit)
 int rte_mvep_deinit(enum mvep_module_type module __rte_unused)
 {
 	mvep.ref_count--;
diff --git a/drivers/common/nfp/nfp_common.c b/drivers/common/nfp/nfp_common.c
index 0df8332dfb..475f64daab 100644
--- a/drivers/common/nfp/nfp_common.c
+++ b/drivers/common/nfp/nfp_common.c
@@ -7,12 +7,15 @@
 
 #include "nfp_common_log.h"
 
+#include <eal_export.h>
+
 /*
  * This is used by the reconfig protocol. It sets the maximum time waiting in
  * milliseconds before a reconfig timeout happens.
  */
 #define NFP_NET_POLL_TIMEOUT    5000
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig_real)
 int
 nfp_reconfig_real(struct nfp_hw *hw,
 		uint32_t update)
@@ -77,6 +80,7 @@ nfp_reconfig_real(struct nfp_hw *hw,
  *   - (0) if OK to reconfigure the device.
  *   - (-EIO) if I/O err and fail to reconfigure the device.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig)
 int
 nfp_reconfig(struct nfp_hw *hw,
 		uint32_t ctrl,
@@ -121,6 +125,7 @@ nfp_reconfig(struct nfp_hw *hw,
  *   - (0) if OK to reconfigure the device.
  *   - (-EIO) if I/O err and fail to reconfigure the device.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_ext_reconfig)
 int
 nfp_ext_reconfig(struct nfp_hw *hw,
 		uint32_t ctrl_ext,
@@ -148,6 +153,7 @@ nfp_ext_reconfig(struct nfp_hw *hw,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_read_mac)
 void
 nfp_read_mac(struct nfp_hw *hw)
 {
@@ -160,6 +166,7 @@ nfp_read_mac(struct nfp_hw *hw)
 	memcpy(&hw->mac_addr.addr_bytes[4], &tmp, 2);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_write_mac)
 void
 nfp_write_mac(struct nfp_hw *hw,
 		uint8_t *mac)
@@ -176,6 +183,7 @@ nfp_write_mac(struct nfp_hw *hw,
 			hw->ctrl_bar + NFP_NET_CFG_MACADDR + 6);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_enable_queues)
 void
 nfp_enable_queues(struct nfp_hw *hw,
 		uint16_t nb_rx_queues,
@@ -199,6 +207,7 @@ nfp_enable_queues(struct nfp_hw *hw,
 	nn_cfg_writeq(hw, NFP_NET_CFG_RXRS_ENABLE, enabled_queues);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_disable_queues)
 void
 nfp_disable_queues(struct nfp_hw *hw)
 {
diff --git a/drivers/common/nfp/nfp_common_pci.c b/drivers/common/nfp/nfp_common_pci.c
index 856f3917a2..4a2fb5e82d 100644
--- a/drivers/common/nfp/nfp_common_pci.c
+++ b/drivers/common/nfp/nfp_common_pci.c
@@ -7,6 +7,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_class.h>
 #include <rte_devargs.h>
 #include <rte_kvargs.h>
@@ -257,6 +258,7 @@ nfp_common_init(void)
 	nfp_common_initialized = true;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_class_driver_register)
 void
 nfp_class_driver_register(struct nfp_class_driver *driver)
 {
diff --git a/drivers/common/nfp/nfp_dev.c b/drivers/common/nfp/nfp_dev.c
index f29b7e0711..486ed2cdfe 100644
--- a/drivers/common/nfp/nfp_dev.c
+++ b/drivers/common/nfp/nfp_dev.c
@@ -6,6 +6,7 @@
 #include "nfp_dev.h"
 
 #include <nfp_platform.h>
+#include <eal_export.h>
 #include <rte_bitops.h>
 
 /*
@@ -49,6 +50,7 @@ const struct nfp_dev_info nfp_dev_info[NFP_DEV_CNT] = {
 	},
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_dev_info_get)
 const struct nfp_dev_info *
 nfp_dev_info_get(uint16_t device_id)
 {
diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 6cd57faaa4..74c7a859a4 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2019 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 
 #include "nitrox_device.h"
@@ -64,6 +65,7 @@ ndev_release(struct nitrox_device *ndev)
 TAILQ_HEAD(ndrv_list, nitrox_driver);
 static struct ndrv_list ndrv_list = TAILQ_HEAD_INITIALIZER(ndrv_list);
 
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_register_driver)
 void
 nitrox_register_driver(struct nitrox_driver *ndrv)
 {
diff --git a/drivers/common/nitrox/nitrox_logs.c b/drivers/common/nitrox/nitrox_logs.c
index 0e0a94648c..e4ebb39ff1 100644
--- a/drivers/common/nitrox/nitrox_logs.c
+++ b/drivers/common/nitrox/nitrox_logs.c
@@ -2,6 +2,8 @@
  * Copyright(C) 2019 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_log.h>
 
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_logtype)
 RTE_LOG_REGISTER_DEFAULT(nitrox_logtype, NOTICE);
diff --git a/drivers/common/nitrox/nitrox_qp.c b/drivers/common/nitrox/nitrox_qp.c
index d6a5ddd641..8f481e6876 100644
--- a/drivers/common/nitrox/nitrox_qp.c
+++ b/drivers/common/nitrox/nitrox_qp.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2019 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_memzone.h>
 #include <rte_malloc.h>
 
@@ -103,6 +104,7 @@ nitrox_release_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr)
 	return rte_memzone_free(qp->cmdq.mz);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_setup)
 int
 nitrox_qp_setup(struct nitrox_qp *qp, uint8_t *bar_addr, const char *dev_name,
 		uint32_t nb_descriptors, uint8_t instr_size, int socket_id)
@@ -145,6 +147,7 @@ nitrox_release_ridq(struct nitrox_qp *qp)
 	rte_free(qp->ridq);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_release)
 int
 nitrox_qp_release(struct nitrox_qp *qp, uint8_t *bar_addr)
 {
diff --git a/drivers/common/octeontx/octeontx_mbox.c b/drivers/common/octeontx/octeontx_mbox.c
index f98942c79c..9e0bbf453f 100644
--- a/drivers/common/octeontx/octeontx_mbox.c
+++ b/drivers/common/octeontx/octeontx_mbox.c
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
@@ -69,6 +70,7 @@ struct mbox_intf_ver {
 	uint32_t minor:10;
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_logtype_mbox)
 RTE_LOG_REGISTER(octeontx_logtype_mbox, pmd.octeontx.mbox, NOTICE);
 
 static inline void
@@ -192,6 +194,7 @@ mbox_send(struct mbox *m, struct octeontx_mbox_hdr *hdr, const void *txmsg,
 	return res;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_ram_mbox_base)
 int
 octeontx_mbox_set_ram_mbox_base(uint8_t *ram_mbox_base, uint16_t domain)
 {
@@ -216,6 +219,7 @@ octeontx_mbox_set_ram_mbox_base(uint8_t *ram_mbox_base, uint16_t domain)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_reg)
 int
 octeontx_mbox_set_reg(uint8_t *reg, uint16_t domain)
 {
@@ -240,6 +244,7 @@ octeontx_mbox_set_reg(uint8_t *reg, uint16_t domain)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_send)
 int
 octeontx_mbox_send(struct octeontx_mbox_hdr *hdr, void *txdata,
 				 uint16_t txlen, void *rxdata, uint16_t rxlen)
@@ -304,6 +309,7 @@ octeontx_check_mbox_version(struct mbox_intf_ver *app_intf_ver,
 	return result;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_init)
 int
 octeontx_mbox_init(void)
 {
@@ -343,6 +349,7 @@ octeontx_mbox_init(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_get_global_domain)
 uint16_t
 octeontx_get_global_domain(void)
 {
diff --git a/drivers/common/sfc_efx/meson.build b/drivers/common/sfc_efx/meson.build
index 0cf0a23bf8..74b4a2fd93 100644
--- a/drivers/common/sfc_efx/meson.build
+++ b/drivers/common/sfc_efx/meson.build
@@ -41,6 +41,7 @@ deps += ['bus_pci']
 sources = files(
         'sfc_efx.c',
         'sfc_efx_mcdi.c',
+        'sfc_base_symbols.c',
 )
 
 includes += include_directories('base')
diff --git a/drivers/common/sfc_efx/sfc_base_symbols.c b/drivers/common/sfc_efx/sfc_base_symbols.c
new file mode 100644
index 0000000000..ae6605632d
--- /dev/null
+++ b/drivers/common/sfc_efx/sfc_base_symbols.c
@@ -0,0 +1,276 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#include <eal_export.h>
+
+/* Symbols from the base driver are exported separately below. */
+RTE_EXPORT_INTERNAL_SYMBOL(efx_crc32_calculate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_size)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_nbufs)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_irq)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qdestroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qprime)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpending)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_check_init_done)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpoll)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpost)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_usecs_to_ticks)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qmoderate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_mac_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_vlan_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_stats)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_insert)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_restore)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_supported_filters)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_rx)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_tx)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_local)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_full)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_eth_local)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ether_type)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_uc_def)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_mc_def)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_encap_type)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_vxlan)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_geneve)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_nvgre)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_rss_context)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_dwords)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable_unlocked)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_trigger)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_line)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_message)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fatal)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_get_all_ucast_mcast)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_drain)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_up)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_multicast_list_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_include_fcs_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stat_name)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_get_mask)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_upload)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_periodic)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_update)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_get_limits)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_invalid)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_phy_port)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_function)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_mh_function)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_id_by_selector)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_recirc_id_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_ct_mark_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_id)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_bit_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_mport_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_clone)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_equal)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_is_valid)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decap)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_pop)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_dst_mac)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_src_mac)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decr_ip_ttl)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_nat)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_push)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_encap)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_count)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_flag)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_deliver)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_drop)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_specs_equal)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_class_cmp)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_recirc_id_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_do_ct_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_insert)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_outer_rule_id_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_dst_mac_id)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_src_mac_id)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_update)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_eh_id)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_get_nb_count)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_counter_id)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_clear_fw_rsrc_ids)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc_type)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free_type)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_start)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_stop)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_give_credits)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_insert)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_mport_alloc_alias)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_read_mport_journal)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_replay)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_new_epoch)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_start)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_poll)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_abort)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_client_handle)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_own_client_handle)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_timeout)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_proxy_handle)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_reboot)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_name)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_family)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_family_probe_bar)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_probe)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_limits)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_version)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_bar_region)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_vi_pool)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_unprobe)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_cfg_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_version)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_board_info)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_hw_unavailable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_hw_unavailable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_mask)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_calculate_pcie_link_bandwidth)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_subvariant)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_fw_subvariant)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_check_pcie_link_speed)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_config_add)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_reconfigure)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_verify)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lp_cap_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_oui_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_media_type_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_module_get_info)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_fec_type_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_link_state_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_poll)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_loopback_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_type_name)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_vlan_strip_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_hash_flags_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_hash_default_support_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_default_support_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc_v2)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_free)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_key_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_tbl_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpost)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpush)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qflush)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_size)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_nbufs)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qenable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate_es_super_buffer)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qdestroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_pkt_length_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_hash_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_get_layout)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_layout_check)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_list)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_supported_num_get)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_is_supported)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_describe)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_insert)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_delete)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_add)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_reconfigure)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_size)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_nbufs)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qcreate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdestroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpost)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpush)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpace)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qflush)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qenable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_write)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_post)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_post)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_dma_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso2_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_vlantci_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_checksum_create)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_init)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qcreate)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstart)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstop)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qdestroy)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_doorbell_offset)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_features)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_verify_features)
diff --git a/drivers/common/sfc_efx/sfc_efx.c b/drivers/common/sfc_efx/sfc_efx.c
index 458efacba5..60f20ef262 100644
--- a/drivers/common/sfc_efx/sfc_efx.c
+++ b/drivers/common/sfc_efx/sfc_efx.c
@@ -8,6 +8,7 @@
  */
 
 #include <string.h>
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_kvargs.h>
 #include <rte_devargs.h>
@@ -35,6 +36,7 @@ sfc_efx_kvarg_dev_class_handler(__rte_unused const char *key,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_dev_class_get)
 enum sfc_efx_dev_class
 sfc_efx_dev_class_get(struct rte_devargs *devargs)
 {
@@ -93,6 +95,7 @@ sfc_efx_pci_config_readd(efsys_pci_config_t *configp, uint32_t offset,
 	return (rc < 0 || rc != sizeof(*edp)) ? EIO : 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_family)
 int
 sfc_efx_family(struct rte_pci_device *pci_dev,
 	       efx_bar_region_t *mem_ebrp, efx_family_t *family)
diff --git a/drivers/common/sfc_efx/sfc_efx_mcdi.c b/drivers/common/sfc_efx/sfc_efx_mcdi.c
index 0d17616589..1fe3515d2d 100644
--- a/drivers/common/sfc_efx/sfc_efx_mcdi.c
+++ b/drivers/common/sfc_efx/sfc_efx_mcdi.c
@@ -7,6 +7,7 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
+#include <eal_export.h>
 #include <rte_cycles.h>
 
 #include "efx.h"
@@ -264,6 +265,7 @@ sfc_efx_mcdi_ev_proxy_response(void *arg, uint32_t handle, efx_rc_t result)
 	mcdi->proxy_result = result;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_init)
 int
 sfc_efx_mcdi_init(struct sfc_efx_mcdi *mcdi,
 		  uint32_t logtype, const char *log_prefix, efx_nic_t *nic,
@@ -320,6 +322,7 @@ sfc_efx_mcdi_init(struct sfc_efx_mcdi *mcdi,
 	return rc;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_fini)
 void
 sfc_efx_mcdi_fini(struct sfc_efx_mcdi *mcdi)
 {
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index dbebc5aef1..851e6f0a88 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -3,6 +3,7 @@
  */
 
 #include <cryptodev_pmd.h>
+#include <eal_export.h>
 #include <rte_cryptodev.h>
 #include <rte_event_crypto_adapter.h>
 #include <rte_hexdump.h>
@@ -892,12 +893,14 @@ cn10k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_ev
 	return count;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver1_crypto_adapter_enqueue)
 uint16_t __rte_hot
 cn10k_cpt_sg_ver1_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
 	return cn10k_cpt_crypto_adapter_enqueue(ws, ev, nb_events, false);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver2_crypto_adapter_enqueue)
 uint16_t __rte_hot
 cn10k_cpt_sg_ver2_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -1225,6 +1228,7 @@ cn10k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_dequeue)
 uintptr_t
 cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 {
@@ -1248,6 +1252,7 @@ cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	return (uintptr_t)cop;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_vector_dequeue)
 uintptr_t
 cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 {
@@ -1349,6 +1354,7 @@ cn10k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 }
 
 #if defined(RTE_ARCH_ARM64)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject)
 uint16_t __rte_hot
 cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1492,6 +1498,7 @@ cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 	return count + i;
 }
 #else
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject)
 uint16_t __rte_hot
 cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1968,6 +1975,7 @@ cn10k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_rx_inject_configure)
 int
 cn10k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
 {
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index 2b1bd70c6d..ee35ed1eba 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_cryptodev.h>
 #include <cryptodev_pmd.h>
 #include <rte_event_crypto_adapter.h>
@@ -340,6 +341,7 @@ cn9k_ca_meta_info_extract(struct rte_crypto_op *op,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_enqueue)
 uint16_t
 cn9k_cpt_crypto_adapter_enqueue(uintptr_t base, struct rte_crypto_op *op)
 {
@@ -592,6 +594,7 @@ cn9k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_dequeue)
 uintptr_t
 cn9k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index a82db13a8e..c3a0a58c8f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_atomic.h>
 #include <rte_cryptodev.h>
 #include <cryptodev_pmd.h>
@@ -969,6 +970,7 @@ cnxk_cpt_queue_pair_event_error_query(struct rte_cryptodev *dev, uint16_t qp_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qptr_get, 24.03)
 struct rte_pmd_cnxk_crypto_qptr *
 rte_pmd_cnxk_crypto_qptr_get(uint8_t dev_id, uint16_t qp_id)
 {
@@ -1031,6 +1033,7 @@ cnxk_crypto_cn9k_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint1
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_submit, 24.03)
 void
 rte_pmd_cnxk_crypto_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint16_t nb_inst)
 {
@@ -1042,6 +1045,7 @@ rte_pmd_cnxk_crypto_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, ui
 	plt_err("Invalid cnxk model");
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_flush, 24.07)
 int
 rte_pmd_cnxk_crypto_cptr_flush(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			       struct rte_pmd_cnxk_crypto_cptr *cptr, bool invalidate)
@@ -1066,6 +1070,7 @@ rte_pmd_cnxk_crypto_cptr_flush(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return roc_cpt_lf_ctx_flush(&qp->lf, cptr, invalidate);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_get, 24.07)
 struct rte_pmd_cnxk_crypto_cptr *
 rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 {
@@ -1113,6 +1118,7 @@ rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_read, 24.07)
 int
 rte_pmd_cnxk_crypto_cptr_read(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			      struct rte_pmd_cnxk_crypto_cptr *cptr, void *data, uint32_t len)
@@ -1146,6 +1152,7 @@ rte_pmd_cnxk_crypto_cptr_read(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_write, 24.07)
 int
 rte_pmd_cnxk_crypto_cptr_write(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			       struct rte_pmd_cnxk_crypto_cptr *cptr, void *data, uint32_t len)
@@ -1183,6 +1190,7 @@ rte_pmd_cnxk_crypto_cptr_write(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qp_stats_get, 24.07)
 int
 rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 				 struct rte_pmd_cnxk_crypto_qp_stats *stats)
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 7ad8fd47dd..0ccadecff4 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -9,6 +9,7 @@
 #include <net/if.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_ip.h>
 #include <rte_udp.h>
 #include <rte_mbuf.h>
@@ -4090,6 +4091,7 @@ dpaa2_sec_process_ordered_event(struct qbman_swp *swp,
 	ev->event_ptr = crypto_op;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_attach)
 int
 dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 		int qp_id,
@@ -4170,6 +4172,7 @@ dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_detach)
 int
 dpaa2_sec_eventq_detach(const struct rte_cryptodev *dev,
 			int qp_id)
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index e117cd77a6..bcea4ff3ab 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -10,6 +10,7 @@
 #include <sched.h>
 #include <net/if.h>
 
+#include <eal_export.h>
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <cryptodev_pmd.h>
@@ -3510,6 +3511,7 @@ dpaa_sec_process_atomic_event(void *event,
 	return qman_cb_dqrr_defer;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_attach)
 int
 dpaa_sec_eventq_attach(const struct rte_cryptodev *dev,
 		int qp_id,
@@ -3554,6 +3556,7 @@ dpaa_sec_eventq_attach(const struct rte_cryptodev *dev,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_detach)
 int
 dpaa_sec_eventq_detach(const struct rte_cryptodev *dev,
 			int qp_id)
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index 9a758cd297..88657f49cc 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018 Cavium, Inc
  */
 
+#include <eal_export.h>
 #include <rte_alarm.h>
 #include <bus_pci_driver.h>
 #include <rte_cryptodev.h>
@@ -656,6 +657,7 @@ submit_request_to_sso(struct ssows *ws, uintptr_t req,
 	ssovf_store_pair(add_work, req, ws->grps[rsp_info->queue_id]);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_enqueue)
 uint16_t __rte_hot
 otx_crypto_adapter_enqueue(void *port, struct rte_crypto_op *op)
 {
@@ -946,6 +948,7 @@ otx_cpt_dequeue_sym(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	return otx_cpt_pkt_dequeue(qptr, ops, nb_ops, OP_TYPE_SYM);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_dequeue)
 uintptr_t __rte_hot
 otx_crypto_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 6013f66aa5..1ca8443431 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2017 Intel Corporation
  */
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_reorder.h>
 #include <rte_cryptodev.h>
@@ -357,6 +358,7 @@ update_max_nb_qp(struct scheduler_ctx *sched_ctx)
 }
 
 /** Attach a device to the scheduler. */
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_attach)
 int
 rte_cryptodev_scheduler_worker_attach(uint8_t scheduler_id, uint8_t worker_id)
 {
@@ -419,6 +421,7 @@ rte_cryptodev_scheduler_worker_attach(uint8_t scheduler_id, uint8_t worker_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_detach)
 int
 rte_cryptodev_scheduler_worker_detach(uint8_t scheduler_id, uint8_t worker_id)
 {
@@ -477,6 +480,7 @@ rte_cryptodev_scheduler_worker_detach(uint8_t scheduler_id, uint8_t worker_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_set)
 int
 rte_cryptodev_scheduler_mode_set(uint8_t scheduler_id,
 		enum rte_cryptodev_scheduler_mode mode)
@@ -541,6 +545,7 @@ rte_cryptodev_scheduler_mode_set(uint8_t scheduler_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_get)
 enum rte_cryptodev_scheduler_mode
 rte_cryptodev_scheduler_mode_get(uint8_t scheduler_id)
 {
@@ -562,6 +567,7 @@ rte_cryptodev_scheduler_mode_get(uint8_t scheduler_id)
 	return sched_ctx->mode;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_set)
 int
 rte_cryptodev_scheduler_ordering_set(uint8_t scheduler_id,
 		uint32_t enable_reorder)
@@ -591,6 +597,7 @@ rte_cryptodev_scheduler_ordering_set(uint8_t scheduler_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_get)
 int
 rte_cryptodev_scheduler_ordering_get(uint8_t scheduler_id)
 {
@@ -612,6 +619,7 @@ rte_cryptodev_scheduler_ordering_get(uint8_t scheduler_id)
 	return (int)sched_ctx->reordering_enabled;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_load_user_scheduler)
 int
 rte_cryptodev_scheduler_load_user_scheduler(uint8_t scheduler_id,
 		struct rte_cryptodev_scheduler *scheduler) {
@@ -684,6 +692,7 @@ rte_cryptodev_scheduler_load_user_scheduler(uint8_t scheduler_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_workers_get)
 int
 rte_cryptodev_scheduler_workers_get(uint8_t scheduler_id, uint8_t *workers)
 {
@@ -715,6 +724,7 @@ rte_cryptodev_scheduler_workers_get(uint8_t scheduler_id, uint8_t *workers)
 	return (int)nb_workers;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_set)
 int
 rte_cryptodev_scheduler_option_set(uint8_t scheduler_id,
 		enum rte_cryptodev_schedule_option_type option_type,
@@ -747,6 +757,7 @@ rte_cryptodev_scheduler_option_set(uint8_t scheduler_id,
 	return sched_ctx->ops.option_set(dev, option_type, option);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_get)
 int
 rte_cryptodev_scheduler_option_get(uint8_t scheduler_id,
 		enum rte_cryptodev_schedule_option_type option_type,
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index 36fc40c7e0..dea73c5b41 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2021 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_vect.h>
 
 #include "cnxk_dmadev.h"
@@ -445,6 +446,7 @@ cnxk_dma_adapter_format_event(uint64_t event)
 	return w0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_dma_adapter_enqueue)
 uint16_t
 cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -504,6 +506,7 @@ cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 	return count;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_dual_enqueue)
 uint16_t
 cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -574,6 +577,7 @@ cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_event
 	return count;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_enqueue)
 uint16_t
 cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -641,6 +645,7 @@ cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 	return count;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_dma_adapter_dequeue)
 uintptr_t
 cnxk_dma_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/event/cnxk/cnxk_worker.c b/drivers/event/cnxk/cnxk_worker.c
index a07c9185d9..5e5beb6aac 100644
--- a/drivers/event/cnxk/cnxk_worker.c
+++ b/drivers/event/cnxk/cnxk_worker.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2023 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_pmd_cnxk_eventdev.h>
 #include <rte_eventdev.h>
@@ -12,6 +13,7 @@ struct pwords {
 	uint64_t u[5];
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_wait_head, 23.11)
 void
 rte_pmd_cnxk_eventdev_wait_head(uint8_t dev, uint8_t port)
 {
@@ -28,6 +30,7 @@ rte_pmd_cnxk_eventdev_wait_head(uint8_t dev, uint8_t port)
 }
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_is_head, 23.11)
 uint8_t
 rte_pmd_cnxk_eventdev_is_head(uint8_t dev, uint8_t port)
 {
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.c b/drivers/event/dlb2/rte_pmd_dlb2.c
index 43990e46ac..08f4d5f3d1 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.c
+++ b/drivers/event/dlb2/rte_pmd_dlb2.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_eventdev.h>
 #include <eventdev_pmd.h>
 
@@ -9,6 +10,7 @@
 #include "dlb2_priv.h"
 #include "dlb2_inline_fns.h"
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_token_pop_mode, 20.11)
 int
 rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 				uint8_t port_id,
diff --git a/drivers/mempool/cnxk/cn10k_hwpool_ops.c b/drivers/mempool/cnxk/cn10k_hwpool_ops.c
index b234481ec1..e83e872f40 100644
--- a/drivers/mempool/cnxk/cn10k_hwpool_ops.c
+++ b/drivers/mempool/cnxk/cn10k_hwpool_ops.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2023 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_mempool.h>
 #include <rte_pmd_cnxk_mempool.h>
 
@@ -200,6 +201,7 @@ cn10k_hwpool_populate(struct rte_mempool *hp, unsigned int max_objs,
 	return hp->size;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_mbuf_exchange, 23.07)
 int
 rte_pmd_cnxk_mempool_mbuf_exchange(struct rte_mbuf *m1, struct rte_mbuf *m2)
 {
@@ -227,12 +229,14 @@ rte_pmd_cnxk_mempool_mbuf_exchange(struct rte_mbuf *m1, struct rte_mbuf *m2)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_is_hwpool, 23.07)
 int
 rte_pmd_cnxk_mempool_is_hwpool(struct rte_mempool *mp)
 {
 	return !!(CNXK_MEMPOOL_FLAGS(mp) & CNXK_MEMPOOL_F_IS_HWPOOL);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_range_check_disable, 23.07)
 int
 rte_pmd_cnxk_mempool_range_check_disable(struct rte_mempool *mp)
 {
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 74bfcab509..7dacaa9513 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 
+#include <eal_export.h>
 #include <rte_byteorder.h>
 #include <rte_common.h>
 #include <rte_log.h>
@@ -32,9 +33,11 @@
  * is to optimize the PA_to_VA searches until a better mechanism (algo) is
  * available.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_memsegs)
 struct dpaa_memseg_list rte_dpaa_memsegs
 	= TAILQ_HEAD_INITIALIZER(rte_dpaa_memsegs);
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_bpid_info)
 struct dpaa_bp_info *rte_dpaa_bpid_info;
 
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_mempool, NOTICE);
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index c054988513..09729d2828 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -13,6 +13,7 @@
 #include <fcntl.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
@@ -33,6 +34,7 @@
 
 #include <dpaax_iova_table.h>
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
@@ -278,6 +280,7 @@ rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info_init)
 int rte_dpaa2_bpid_info_init(struct rte_mempool *mp)
 {
 	struct dpaa2_bp_info *bp_info = mempool_to_bpinfo(mp);
@@ -301,6 +304,7 @@ int rte_dpaa2_bpid_info_init(struct rte_mempool *mp)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_pool_bpid)
 uint16_t
 rte_dpaa2_mbuf_pool_bpid(struct rte_mempool *mp)
 {
@@ -315,6 +319,7 @@ rte_dpaa2_mbuf_pool_bpid(struct rte_mempool *mp)
 	return bp_info->bpid;
 }
 
+RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_from_buf_addr)
 struct rte_mbuf *
 rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr)
 {
@@ -330,6 +335,7 @@ rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr)
 			bp_info->meta_data_size);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mbuf_alloc_bulk)
 int
 rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 			  void **obj_table, unsigned int count)
diff --git a/drivers/net/atlantic/rte_pmd_atlantic.c b/drivers/net/atlantic/rte_pmd_atlantic.c
index 00fc2872e5..b5b6ab7d4b 100644
--- a/drivers/net/atlantic/rte_pmd_atlantic.c
+++ b/drivers/net/atlantic/rte_pmd_atlantic.c
@@ -4,10 +4,12 @@
 
 #include <ethdev_driver.h>
 
+#include <eal_export.h>
 #include "rte_pmd_atlantic.h"
 #include "atl_ethdev.h"
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_enable, 19.05)
 int
 rte_pmd_atl_macsec_enable(uint16_t port,
 			  uint8_t encr, uint8_t repl_prot)
@@ -24,6 +26,7 @@ rte_pmd_atl_macsec_enable(uint16_t port,
 	return atl_macsec_enable(dev, encr, repl_prot);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_disable, 19.05)
 int
 rte_pmd_atl_macsec_disable(uint16_t port)
 {
@@ -39,6 +42,7 @@ rte_pmd_atl_macsec_disable(uint16_t port)
 	return atl_macsec_disable(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_txsc, 19.05)
 int
 rte_pmd_atl_macsec_config_txsc(uint16_t port, uint8_t *mac)
 {
@@ -54,6 +58,7 @@ rte_pmd_atl_macsec_config_txsc(uint16_t port, uint8_t *mac)
 	return atl_macsec_config_txsc(dev, mac);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_rxsc, 19.05)
 int
 rte_pmd_atl_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 {
@@ -69,6 +74,7 @@ rte_pmd_atl_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 	return atl_macsec_config_rxsc(dev, mac, pi);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_txsa, 19.05)
 int
 rte_pmd_atl_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -85,6 +91,7 @@ rte_pmd_atl_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 	return atl_macsec_select_txsa(dev, idx, an, pn, key);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_rxsa, 19.05)
 int
 rte_pmd_atl_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
diff --git a/drivers/net/bnxt/rte_pmd_bnxt.c b/drivers/net/bnxt/rte_pmd_bnxt.c
index e9b5739050..4974e390e7 100644
--- a/drivers/net/bnxt/rte_pmd_bnxt.c
+++ b/drivers/net/bnxt/rte_pmd_bnxt.c
@@ -9,6 +9,7 @@
 
 #include <dev_driver.h>
 #include <ethdev_driver.h>
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_byteorder.h>
@@ -39,6 +40,7 @@ int bnxt_rcv_msg_from_vf(struct bnxt *bp, uint16_t vf_id, void *msg)
 		true : false;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_tx_loopback)
 int rte_pmd_bnxt_set_tx_loopback(uint16_t port, uint8_t on)
 {
 	struct rte_eth_dev *eth_dev;
@@ -80,6 +82,7 @@ rte_pmd_bnxt_set_all_queues_drop_en_cb(struct bnxt_vnic_info *vnic, void *onptr)
 	vnic->bd_stall = !(*on);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_all_queues_drop_en)
 int rte_pmd_bnxt_set_all_queues_drop_en(uint16_t port, uint8_t on)
 {
 	struct rte_eth_dev *eth_dev;
@@ -131,6 +134,7 @@ int rte_pmd_bnxt_set_all_queues_drop_en(uint16_t port, uint8_t on)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_addr)
 int rte_pmd_bnxt_set_vf_mac_addr(uint16_t port, uint16_t vf,
 				struct rte_ether_addr *mac_addr)
 {
@@ -171,6 +175,7 @@ int rte_pmd_bnxt_set_vf_mac_addr(uint16_t port, uint16_t vf,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rate_limit)
 int rte_pmd_bnxt_set_vf_rate_limit(uint16_t port, uint16_t vf,
 				uint32_t tx_rate, uint64_t q_msk)
 {
@@ -228,6 +233,7 @@ int rte_pmd_bnxt_set_vf_rate_limit(uint16_t port, uint16_t vf,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_anti_spoof)
 int rte_pmd_bnxt_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
@@ -288,6 +294,7 @@ int rte_pmd_bnxt_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_anti_spoof)
 int rte_pmd_bnxt_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
@@ -347,6 +354,7 @@ rte_pmd_bnxt_set_vf_vlan_stripq_cb(struct bnxt_vnic_info *vnic, void *onptr)
 	vnic->vlan_strip = *on;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_stripq)
 int
 rte_pmd_bnxt_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -390,6 +398,7 @@ rte_pmd_bnxt_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rxmode)
 int rte_pmd_bnxt_set_vf_rxmode(uint16_t port, uint16_t vf,
 				uint16_t rx_mask, uint8_t on)
 {
@@ -488,6 +497,7 @@ static int bnxt_set_vf_table(struct bnxt *bp, uint16_t vf)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_filter)
 int rte_pmd_bnxt_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 				    uint64_t vf_mask, uint8_t vlan_on)
 {
@@ -583,6 +593,7 @@ int rte_pmd_bnxt_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_stats)
 int rte_pmd_bnxt_get_vf_stats(uint16_t port,
 			      uint16_t vf_id,
 			      struct rte_eth_stats *stats)
@@ -620,6 +631,7 @@ int rte_pmd_bnxt_get_vf_stats(uint16_t port,
 				     NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_reset_vf_stats)
 int rte_pmd_bnxt_reset_vf_stats(uint16_t port,
 				uint16_t vf_id)
 {
@@ -655,6 +667,7 @@ int rte_pmd_bnxt_reset_vf_stats(uint16_t port,
 	return bnxt_hwrm_func_clr_stats(bp, bp->pf->first_vf_id + vf_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_rx_status)
 int rte_pmd_bnxt_get_vf_rx_status(uint16_t port, uint16_t vf_id)
 {
 	struct rte_eth_dev *dev;
@@ -689,6 +702,7 @@ int rte_pmd_bnxt_get_vf_rx_status(uint16_t port, uint16_t vf_id)
 	return bnxt_vf_vnic_count(bp, vf_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_tx_drop_count)
 int rte_pmd_bnxt_get_vf_tx_drop_count(uint16_t port, uint16_t vf_id,
 				      uint64_t *count)
 {
@@ -725,6 +739,7 @@ int rte_pmd_bnxt_get_vf_tx_drop_count(uint16_t port, uint16_t vf_id,
 					     count);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_mac_addr_add)
 int rte_pmd_bnxt_mac_addr_add(uint16_t port, struct rte_ether_addr *addr,
 				uint32_t vf_id)
 {
@@ -808,6 +823,7 @@ int rte_pmd_bnxt_mac_addr_add(uint16_t port, struct rte_ether_addr *addr,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_insert)
 int
 rte_pmd_bnxt_set_vf_vlan_insert(uint16_t port, uint16_t vf,
 		uint16_t vlan_id)
@@ -853,6 +869,7 @@ rte_pmd_bnxt_set_vf_vlan_insert(uint16_t port, uint16_t vf,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_persist_stats)
 int rte_pmd_bnxt_set_vf_persist_stats(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index 7f885ab521..1677615435 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_alarm.h>
 #include <rte_malloc.h>
 #include <rte_errno.h>
@@ -1403,6 +1404,7 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 	rte_pktmbuf_free(pkt);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_conf_get)
 int
 rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 		struct rte_eth_bond_8023ad_conf *conf)
@@ -1420,6 +1422,7 @@ rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_set)
 int
 rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 		enum rte_bond_8023ad_agg_selection agg_selection)
@@ -1444,6 +1447,7 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_get)
 int rte_eth_bond_8023ad_agg_selection_get(uint16_t port_id)
 {
 	struct rte_eth_dev *bond_dev;
@@ -1491,6 +1495,7 @@ bond_8023ad_setup_validate(uint16_t port_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_setup)
 int
 rte_eth_bond_8023ad_setup(uint16_t port_id,
 		struct rte_eth_bond_8023ad_conf *conf)
@@ -1512,6 +1517,7 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 
 
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_member_info)
 int
 rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 		struct rte_eth_bond_8023ad_member_info *info)
@@ -1573,6 +1579,7 @@ bond_8023ad_ext_validate(uint16_t port_id, uint16_t member_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect)
 int
 rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 				int enabled)
@@ -1594,6 +1601,7 @@ rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib)
 int
 rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 				int enabled)
@@ -1615,6 +1623,7 @@ rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib_get)
 int
 rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 {
@@ -1629,6 +1638,7 @@ rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 	return ACTOR_STATE(port, DISTRIBUTING);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect_get)
 int
 rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 {
@@ -1643,6 +1653,7 @@ rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 	return ACTOR_STATE(port, COLLECTING);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_slowtx)
 int
 rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 		struct rte_mbuf *lacp_pkt)
@@ -1704,6 +1715,7 @@ bond_mode_8023ad_ext_periodic_cb(void *arg)
 			bond_mode_8023ad_ext_periodic_cb, arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
 int
 rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
@@ -1730,6 +1742,7 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	return retval;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable)
 int
 rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index ffc1322047..9e5df67c18 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -4,6 +4,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <ethdev_driver.h>
@@ -149,6 +150,7 @@ deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_create)
 int
 rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 {
@@ -187,6 +189,7 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	return bond_dev->data->port_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_free)
 int
 rte_eth_bond_free(const char *name)
 {
@@ -631,6 +634,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_member_add)
 int
 rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -769,6 +773,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_member_remove)
 int
 rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -791,6 +796,7 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	return retval;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_mode_set)
 int
 rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
@@ -808,6 +814,7 @@ rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 	return bond_ethdev_mode_set(bonding_eth_dev, mode);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_mode_get)
 int
 rte_eth_bond_mode_get(uint16_t bonding_port_id)
 {
@@ -821,6 +828,7 @@ rte_eth_bond_mode_get(uint16_t bonding_port_id)
 	return internals->mode;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_primary_set)
 int
 rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -842,6 +850,7 @@ rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_primary_get)
 int
 rte_eth_bond_primary_get(uint16_t bonding_port_id)
 {
@@ -858,6 +867,7 @@ rte_eth_bond_primary_get(uint16_t bonding_port_id)
 	return internals->current_primary_port;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_members_get)
 int
 rte_eth_bond_members_get(uint16_t bonding_port_id, uint16_t members[],
 			uint16_t len)
@@ -882,6 +892,7 @@ rte_eth_bond_members_get(uint16_t bonding_port_id, uint16_t members[],
 	return internals->member_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_active_members_get)
 int
 rte_eth_bond_active_members_get(uint16_t bonding_port_id, uint16_t members[],
 		uint16_t len)
@@ -905,6 +916,7 @@ rte_eth_bond_active_members_get(uint16_t bonding_port_id, uint16_t members[],
 	return internals->active_member_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_set)
 int
 rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 		struct rte_ether_addr *mac_addr)
@@ -931,6 +943,7 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_reset)
 int
 rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 {
@@ -972,6 +985,7 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_set)
 int
 rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
@@ -1002,6 +1016,7 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_get)
 int
 rte_eth_bond_xmit_policy_get(uint16_t bonding_port_id)
 {
@@ -1015,6 +1030,7 @@ rte_eth_bond_xmit_policy_get(uint16_t bonding_port_id)
 	return internals->balance_xmit_policy;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_bond_link_monitoring_set)
 int
 rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 289ae96afa..026c61f2c7 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -3,6 +3,7 @@
  */
 #include <cnxk_ethdev.h>
 
+#include <eal_export.h>
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
 
@@ -12,6 +13,7 @@ cnxk_ethdev_rx_offload_cb_t cnxk_ethdev_rx_offload_cb;
 
 #define NIX_TM_DFLT_RR_WT 71
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_model_str_get, 23.11)
 const char *
 rte_pmd_cnxk_model_str_get(void)
 {
@@ -87,12 +89,14 @@ nix_inl_cq_sz_clamp_up(struct roc_nix *nix, struct rte_mempool *mp,
 	return nb_desc;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ethdev_rx_offload_cb_register)
 void
 cnxk_ethdev_rx_offload_cb_register(cnxk_ethdev_rx_offload_cb_t cb)
 {
 	cnxk_ethdev_rx_offload_cb = cb;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_nix_inb_mode_set)
 int
 cnxk_nix_inb_mode_set(struct cnxk_eth_dev *dev, bool use_inl_dev)
 {
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 6f0340ec0f..614997bd3d 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_pmd_cnxk.h>
 
 #include <cnxk_ethdev.h>
@@ -305,18 +306,21 @@ cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_submit, 23.11)
 uint16_t
 rte_pmd_cnxk_inl_dev_submit(struct rte_pmd_cnxk_inl_dev_q *qptr, void *inst, uint16_t nb_inst)
 {
 	return cnxk_pmd_ops.inl_dev_submit((struct roc_nix_inl_dev_q *)qptr, inst, nb_inst);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_qptr_get, 23.11)
 struct rte_pmd_cnxk_inl_dev_q *
 rte_pmd_cnxk_inl_dev_qptr_get(void)
 {
 	return roc_nix_inl_dev_qptr_get(0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_cpt_q_stats_get, 23.11)
 int
 rte_pmd_cnxk_cpt_q_stats_get(uint16_t portid, enum rte_pmd_cnxk_cpt_q_stats_type type,
 			     struct rte_pmd_cnxk_cpt_q_stats *stats, uint16_t idx)
@@ -328,6 +332,7 @@ rte_pmd_cnxk_cpt_q_stats_get(uint16_t portid, enum rte_pmd_cnxk_cpt_q_stats_type
 					    (struct roc_nix_cpt_lf_stats *)stats, idx);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_session_base_get, 23.11)
 union rte_pmd_cnxk_ipsec_hw_sa *
 rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb)
 {
@@ -343,6 +348,7 @@ rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb)
 	return (union rte_pmd_cnxk_ipsec_hw_sa *)sa_base;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_sa_flush, 23.11)
 int
 rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, bool inb)
 {
@@ -352,6 +358,7 @@ rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, boo
 	return roc_nix_inl_sa_sync(&dev->nix, sess, inb, ROC_NIX_INL_SA_OP_FLUSH);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_read, 22.07)
 int
 rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw_sa *data,
 			uint32_t len, bool inb)
@@ -377,6 +384,7 @@ rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_write, 22.07)
 int
 rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw_sa *data,
 			 uint32_t len, bool inb)
@@ -400,6 +408,7 @@ rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_h
 	return roc_nix_inl_ctx_write(&dev->nix, data, sa, inb, len);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_ipsec_res, 23.11)
 union rte_pmd_cnxk_cpt_res_s *
 rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf)
 {
@@ -418,6 +427,7 @@ rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf)
 	return (void *)(wqe + 64 + desc_size);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_inline_inb_cfg_set, 23.11)
 void
 rte_pmd_cnxk_hw_inline_inb_cfg_set(uint16_t portid, struct rte_pmd_cnxk_ipsec_inb_cfg *cfg)
 {
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index ce4bbbb8f0..00b57cb715 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -16,6 +16,7 @@
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_byteorder.h>
 #include <rte_common.h>
@@ -1294,6 +1295,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_attach)
 int
 dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
@@ -1359,6 +1361,7 @@ dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_detach)
 int
 dpaa_eth_eventq_detach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id)
@@ -1800,6 +1803,7 @@ is_dpaa_supported(struct rte_eth_dev *dev)
 	return is_device_supported(dev, &rte_dpaa_pmd);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa_set_tx_loopback)
 int
 rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on)
 {
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 20b37a97bb..8d00a86032 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <net/if.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
@@ -28,6 +29,7 @@ dpaa2_distset_to_dpkg_profile_cfg(
 		uint64_t req_dist_set,
 		struct dpkg_profile_cfg *kg_cfg);
 
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_set_custom_hash)
 int
 rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
 	uint16_t offset, uint8_t size)
diff --git a/drivers/net/dpaa2/base/dpaa2_tlu_hash.c b/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
index 9eb127c07c..8c685120bd 100644
--- a/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
+++ b/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
@@ -4,6 +4,8 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include <unistd.h>
+
+#include <eal_export.h>
 #include <rte_pmd_dpaa2.h>
 
 static unsigned int sbox(unsigned int x)
@@ -142,6 +144,7 @@ static void hash_init(void)
 		}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_tlu_hash, 21.11)
 uint32_t rte_pmd_dpaa2_get_tlu_hash(uint8_t *data, int size)
 {
 	static int init;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 8624bba0ce..c53c2d0549 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <net/if.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
@@ -2239,6 +2240,7 @@ dpaa2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_attach)
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
 		struct dpaa2_dpcon_dev *dpcon,
@@ -2325,6 +2327,7 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach)
 int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id)
 {
@@ -2410,6 +2413,7 @@ dpaa2_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *ops)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_thread_init, 21.08)
 void
 rte_pmd_dpaa2_thread_init(void)
 {
@@ -2850,6 +2854,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_is_dpaa2, 24.11)
 int
 rte_pmd_dpaa2_dev_is_dpaa2(uint32_t eth_id)
 {
@@ -2865,6 +2870,7 @@ rte_pmd_dpaa2_dev_is_dpaa2(uint32_t eth_id)
 	return dev->device->driver == &rte_dpaa2_pmd.driver;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_ep_name, 24.11)
 const char *
 rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 {
@@ -2890,6 +2896,7 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 }
 
 #if defined(RTE_LIBRTE_IEEE1588)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_one_step_ts, 24.11)
 int
 rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query)
 {
@@ -2918,6 +2925,7 @@ rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query)
 	return priv->ptp_correction_offset;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_set_one_step_ts, 24.11)
 int
 rte_pmd_dpaa2_set_one_step_ts(uint16_t port_id, uint16_t offset, uint8_t ch_update)
 {
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 2f124313fa..a4ac566e26 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
@@ -54,6 +55,7 @@ static struct dpaa2_dpdmux_dev *get_dpdmux_from_id(uint32_t dpdmux_id)
 	return dpdmux_dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_mux_flow_create)
 int
 rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 	struct rte_flow_item pattern[],
@@ -364,6 +366,7 @@ rte_pmd_dpaa2_mux_flow_l2(uint32_t dpdmux_id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_rx_frame_len, 21.05)
 int
 rte_pmd_dpaa2_mux_rx_frame_len(uint32_t dpdmux_id, uint16_t max_rx_frame_len)
 {
@@ -391,6 +394,7 @@ rte_pmd_dpaa2_mux_rx_frame_len(uint32_t dpdmux_id, uint16_t max_rx_frame_len)
 }
 
 /* dump the status of the dpaa2_mux counters on the console */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_dump_counter, 24.11)
 void
 rte_pmd_dpaa2_mux_dump_counter(FILE *f, uint32_t dpdmux_id, int num_if)
 {
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index cad15d8f75..67d065bb7c 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -8,6 +8,7 @@
 #include <time.h>
 #include <net/if.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
@@ -1580,6 +1581,7 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered)
 uint16_t
 dpaa2_dev_tx_multi_txq_ordered(void **queue,
 		struct rte_mbuf **bufs, uint16_t nb_pkts)
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 9d39984ea1..ff99cc4de3 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
@@ -13,6 +14,7 @@
 #include "i40e_rxtx.h"
 #include "rte_pmd_i40e.h"
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ping_vfs)
 int
 rte_pmd_i40e_ping_vfs(uint16_t port, uint16_t vf)
 {
@@ -38,6 +40,7 @@ rte_pmd_i40e_ping_vfs(uint16_t port, uint16_t vf)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_anti_spoof)
 int
 rte_pmd_i40e_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -142,6 +145,7 @@ i40e_add_rm_all_vlan_filter(struct i40e_vsi *vsi, uint8_t add)
 	return I40E_SUCCESS;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_anti_spoof)
 int
 rte_pmd_i40e_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -402,6 +406,7 @@ i40e_vsi_set_tx_loopback(struct i40e_vsi *vsi, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tx_loopback)
 int
 rte_pmd_i40e_set_tx_loopback(uint16_t port, uint8_t on)
 {
@@ -445,6 +450,7 @@ rte_pmd_i40e_set_tx_loopback(uint16_t port, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_unicast_promisc)
 int
 rte_pmd_i40e_set_vf_unicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -486,6 +492,7 @@ rte_pmd_i40e_set_vf_unicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_multicast_promisc)
 int
 rte_pmd_i40e_set_vf_multicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -527,6 +534,7 @@ rte_pmd_i40e_set_vf_multicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_addr)
 int
 rte_pmd_i40e_set_vf_mac_addr(uint16_t port, uint16_t vf_id,
 			     struct rte_ether_addr *mac_addr)
@@ -617,6 +625,7 @@ rte_pmd_i40e_remove_vf_mac_addr(uint16_t port, uint16_t vf_id,
 }
 
 /* Set vlan strip on/off for specific VF from host */
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_stripq)
 int
 rte_pmd_i40e_set_vf_vlan_stripq(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -653,6 +662,7 @@ rte_pmd_i40e_set_vf_vlan_stripq(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_insert)
 int rte_pmd_i40e_set_vf_vlan_insert(uint16_t port, uint16_t vf_id,
 				    uint16_t vlan_id)
 {
@@ -718,6 +728,7 @@ int rte_pmd_i40e_set_vf_vlan_insert(uint16_t port, uint16_t vf_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_broadcast)
 int rte_pmd_i40e_set_vf_broadcast(uint16_t port, uint16_t vf_id,
 				  uint8_t on)
 {
@@ -784,6 +795,7 @@ int rte_pmd_i40e_set_vf_broadcast(uint16_t port, uint16_t vf_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_tag)
 int rte_pmd_i40e_set_vf_vlan_tag(uint16_t port, uint16_t vf_id, uint8_t on)
 {
 	struct rte_eth_dev *dev;
@@ -878,6 +890,7 @@ i40e_vlan_filter_count(struct i40e_vsi *vsi)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_filter)
 int rte_pmd_i40e_set_vf_vlan_filter(uint16_t port, uint16_t vlan_id,
 				    uint64_t vf_mask, uint8_t on)
 {
@@ -960,6 +973,7 @@ int rte_pmd_i40e_set_vf_vlan_filter(uint16_t port, uint16_t vlan_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_vf_stats)
 int
 rte_pmd_i40e_get_vf_stats(uint16_t port,
 			  uint16_t vf_id,
@@ -1005,6 +1019,7 @@ rte_pmd_i40e_get_vf_stats(uint16_t port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_reset_vf_stats)
 int
 rte_pmd_i40e_reset_vf_stats(uint16_t port,
 			    uint16_t vf_id)
@@ -1039,6 +1054,7 @@ rte_pmd_i40e_reset_vf_stats(uint16_t port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_max_bw)
 int
 rte_pmd_i40e_set_vf_max_bw(uint16_t port, uint16_t vf_id, uint32_t bw)
 {
@@ -1128,6 +1144,7 @@ rte_pmd_i40e_set_vf_max_bw(uint16_t port, uint16_t vf_id, uint32_t bw)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_bw_alloc)
 int
 rte_pmd_i40e_set_vf_tc_bw_alloc(uint16_t port, uint16_t vf_id,
 				uint8_t tc_num, uint8_t *bw_weight)
@@ -1242,6 +1259,7 @@ rte_pmd_i40e_set_vf_tc_bw_alloc(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_max_bw)
 int
 rte_pmd_i40e_set_vf_tc_max_bw(uint16_t port, uint16_t vf_id,
 			      uint8_t tc_no, uint32_t bw)
@@ -1360,6 +1378,7 @@ rte_pmd_i40e_set_vf_tc_max_bw(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tc_strict_prio)
 int
 rte_pmd_i40e_set_tc_strict_prio(uint16_t port, uint8_t tc_map)
 {
@@ -1605,6 +1624,7 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_process_ddp_package)
 int
 rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 				 uint32_t size,
@@ -1789,6 +1809,7 @@ i40e_get_tlv_section_size(struct i40e_profile_section_header *sec)
 	return nb_tlv;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_info)
 int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 	uint8_t *info_buff, uint32_t info_size,
 	enum rte_pmd_i40e_package_info type)
@@ -2097,6 +2118,7 @@ int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_list)
 int
 rte_pmd_i40e_get_ddp_list(uint16_t port, uint8_t *buff, uint32_t size)
 {
@@ -2228,6 +2250,7 @@ static int check_invalid_ptype_mapping(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_update)
 int
 rte_pmd_i40e_ptype_mapping_update(
 			uint16_t port,
@@ -2266,6 +2289,7 @@ rte_pmd_i40e_ptype_mapping_update(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_reset)
 int rte_pmd_i40e_ptype_mapping_reset(uint16_t port)
 {
 	struct rte_eth_dev *dev;
@@ -2282,6 +2306,7 @@ int rte_pmd_i40e_ptype_mapping_reset(uint16_t port)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_get)
 int rte_pmd_i40e_ptype_mapping_get(
 			uint16_t port,
 			struct rte_pmd_i40e_ptype_mapping *mapping_items,
@@ -2317,6 +2342,7 @@ int rte_pmd_i40e_ptype_mapping_get(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_replace)
 int rte_pmd_i40e_ptype_mapping_replace(uint16_t port,
 				       uint32_t target,
 				       uint8_t mask,
@@ -2355,6 +2381,7 @@ int rte_pmd_i40e_ptype_mapping_replace(uint16_t port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_add_vf_mac_addr)
 int
 rte_pmd_i40e_add_vf_mac_addr(uint16_t port, uint16_t vf_id,
 			     struct rte_ether_addr *mac_addr)
@@ -2402,6 +2429,7 @@ rte_pmd_i40e_add_vf_mac_addr(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_reset)
 int rte_pmd_i40e_flow_type_mapping_reset(uint16_t port)
 {
 	struct rte_eth_dev *dev;
@@ -2418,6 +2446,7 @@ int rte_pmd_i40e_flow_type_mapping_reset(uint16_t port)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_get)
 int rte_pmd_i40e_flow_type_mapping_get(
 			uint16_t port,
 			struct rte_pmd_i40e_flow_type_mapping *mapping_items)
@@ -2443,6 +2472,7 @@ int rte_pmd_i40e_flow_type_mapping_get(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_update)
 int
 rte_pmd_i40e_flow_type_mapping_update(
 			uint16_t port,
@@ -2496,6 +2526,7 @@ rte_pmd_i40e_flow_type_mapping_update(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_query_vfid_by_mac)
 int
 rte_pmd_i40e_query_vfid_by_mac(uint16_t port,
 			const struct rte_ether_addr *vf_mac)
@@ -2967,6 +2998,7 @@ i40e_queue_region_get_all_info(struct i40e_pf *pf,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_rss_queue_region_conf)
 int rte_pmd_i40e_rss_queue_region_conf(uint16_t port_id,
 		enum rte_pmd_i40e_queue_region_op op_type, void *arg)
 {
@@ -3032,6 +3064,7 @@ int rte_pmd_i40e_rss_queue_region_conf(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_add_del_packet_template)
 int rte_pmd_i40e_flow_add_del_packet_template(
 			uint16_t port,
 			const struct rte_pmd_i40e_pkt_template_conf *conf,
@@ -3065,6 +3098,7 @@ int rte_pmd_i40e_flow_add_del_packet_template(
 	return i40e_flow_add_del_fdir_filter(dev, &filter_conf, add);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_get)
 int
 rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
 		       struct rte_pmd_i40e_inset *inset,
@@ -3137,6 +3171,7 @@ rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_set)
 int
 rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 		       struct rte_pmd_i40e_inset *inset,
@@ -3211,6 +3246,7 @@ rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_info, 20.08)
 int
 rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 {
@@ -3227,6 +3263,7 @@ rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_stats, 20.08)
 int
 rte_pmd_i40e_get_fdir_stats(uint16_t port, struct rte_eth_fdir_stats *fdir_stat)
 {
@@ -3243,6 +3280,7 @@ rte_pmd_i40e_get_fdir_stats(uint16_t port, struct rte_eth_fdir_stats *fdir_stat)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_gre_key_len, 20.08)
 int
 rte_pmd_i40e_set_gre_key_len(uint16_t port, uint8_t len)
 {
@@ -3262,6 +3300,7 @@ rte_pmd_i40e_set_gre_key_len(uint16_t port, uint8_t len)
 	return i40e_dev_set_gre_key_len(hw, len);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_switch_dev, 19.11)
 int
 rte_pmd_i40e_set_switch_dev(uint16_t port_id, struct rte_eth_dev *switch_dev)
 {
@@ -3283,6 +3322,7 @@ rte_pmd_i40e_set_switch_dev(uint16_t port_id, struct rte_eth_dev *switch_dev)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_pf_src_prune, 23.07)
 int
 rte_pmd_i40e_set_pf_src_prune(uint16_t port, uint8_t on)
 {
diff --git a/drivers/net/intel/iavf/iavf_base_symbols.c b/drivers/net/intel/iavf/iavf_base_symbols.c
new file mode 100644
index 0000000000..2111b14aa8
--- /dev/null
+++ b/drivers/net/intel/iavf/iavf_base_symbols.c
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#include <eal_export.h>
+
+/* Symbols from the base driver are exported separately below. */
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_init_adminq)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_shutdown_adminq)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_clean_arq_element)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_set_mac_type)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_aq_send_msg_to_pf)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_parse_hw_config)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_reset)
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a999073691..533e0c78a2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_mbuf.h>
@@ -74,15 +75,23 @@ struct offload_info {
 };
 
 /* Offset of mbuf dynamic field for protocol extraction's metadata */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynfield_proto_xtr_metadata_offs, 20.11)
 int rte_pmd_ifd_dynfield_proto_xtr_metadata_offs = -1;
 
 /* Mask of mbuf dynamic flags for protocol extraction's type */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_vlan_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_vlan_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_tcp_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask, 20.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask, 21.11)
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 
 uint8_t
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 7e03881529..8cbb006201 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -14,6 +14,7 @@ sources = files(
         'base/iavf_common.c',
         'base/iavf_impl.c',
 
+        'iavf_base_symbols.c',
         'iavf_ethdev.c',
         'iavf_rxtx.c',
         'iavf_vchnl.c',
diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index a50068441a..298d1eda5c 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -6,6 +6,7 @@
 #include <unistd.h>
 #include <sys/stat.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
@@ -409,6 +410,7 @@ ice_dump_pkg(struct rte_eth_dev *dev, uint8_t **buff, uint32_t *size)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_package, 19.11)
 int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size)
 {
 	struct rte_eth_dev *dev;
@@ -497,6 +499,7 @@ ice_dump_switch(struct rte_eth_dev *dev, uint8_t **buff2, uint32_t *size)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_switch, 22.11)
 int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size)
 {
 	struct rte_eth_dev *dev;
@@ -798,6 +801,7 @@ query_node_recursive(struct ice_hw *hw, struct rte_eth_dev_data *ethdata,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_txsched, 24.03)
 int
 rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index e9fa024850..ff1fbcd2b4 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2023 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include "idpf_common_device.h"
 #include "idpf_common_virtchnl.h"
@@ -381,6 +382,7 @@ idpf_get_pkt_type(struct idpf_adapter *adapter)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_init)
 int
 idpf_adapter_init(struct idpf_adapter *adapter)
 {
@@ -441,6 +443,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
 int
 idpf_adapter_deinit(struct idpf_adapter *adapter)
 {
@@ -453,6 +456,7 @@ idpf_adapter_deinit(struct idpf_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_init)
 int
 idpf_vport_init(struct idpf_vport *vport,
 		struct virtchnl2_create_vport *create_vport_info,
@@ -566,6 +570,7 @@ idpf_vport_init(struct idpf_vport *vport,
 err_create_vport:
 	return ret;
 }
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_deinit)
 int
 idpf_vport_deinit(struct idpf_vport *vport)
 {
@@ -583,6 +588,7 @@ idpf_vport_deinit(struct idpf_vport *vport)
 
 	return 0;
 }
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_rss_config)
 int
 idpf_vport_rss_config(struct idpf_vport *vport)
 {
@@ -609,6 +615,7 @@ idpf_vport_rss_config(struct idpf_vport *vport)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config)
 int
 idpf_vport_irq_map_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 {
@@ -684,6 +691,7 @@ idpf_vport_irq_map_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config_by_qids)
 int
 idpf_vport_irq_map_config_by_qids(struct idpf_vport *vport, uint32_t *qids, uint16_t nb_rx_queues)
 {
@@ -759,6 +767,7 @@ idpf_vport_irq_map_config_by_qids(struct idpf_vport *vport, uint32_t *qids, uint
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_unmap_config)
 int
 idpf_vport_irq_unmap_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 {
@@ -770,6 +779,7 @@ idpf_vport_irq_unmap_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_info_init)
 int
 idpf_vport_info_init(struct idpf_vport *vport,
 			    struct virtchnl2_create_vport *vport_info)
@@ -806,6 +816,7 @@ idpf_vport_info_init(struct idpf_vport *vport,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_stats_update)
 void
 idpf_vport_stats_update(struct virtchnl2_vport_stats *oes, struct virtchnl2_vport_stats *nes)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 7171e27b8d..0e785daff4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2023 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_errno.h>
 
@@ -10,6 +11,7 @@
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_thresh_check)
 int
 idpf_qc_rx_thresh_check(uint16_t nb_desc, uint16_t thresh)
 {
@@ -25,6 +27,7 @@ idpf_qc_rx_thresh_check(uint16_t nb_desc, uint16_t thresh)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_thresh_check)
 int
 idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 			uint16_t tx_free_thresh)
@@ -73,6 +76,7 @@ idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rxq_mbufs_release)
 void
 idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 {
@@ -89,6 +93,7 @@ idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_txq_mbufs_release)
 void
 idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq)
 {
@@ -114,6 +119,7 @@ idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_descq_reset)
 void
 idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq)
 {
@@ -133,6 +139,7 @@ idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq)
 	rxq->expected_gen_id = 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_bufq_reset)
 void
 idpf_qc_split_rx_bufq_reset(struct idpf_rx_queue *rxq)
 {
@@ -168,6 +175,7 @@ idpf_qc_split_rx_bufq_reset(struct idpf_rx_queue *rxq)
 	rxq->bufq2 = NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_queue_reset)
 void
 idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq)
 {
@@ -176,6 +184,7 @@ idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq)
 	idpf_qc_split_rx_bufq_reset(rxq->bufq2);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rx_queue_reset)
 void
 idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 {
@@ -207,6 +216,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 	rxq->rxrearm_nb = 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset)
 void
 idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 {
@@ -245,6 +255,7 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 	txq->next_rs = txq->rs_thresh - 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
 void
 idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
 {
@@ -263,6 +274,7 @@ idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
 	cq->expected_gen_id = 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
 void
 idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 {
@@ -300,6 +312,7 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 	txq->next_rs = txq->rs_thresh - 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_queue_release)
 void
 idpf_qc_rx_queue_release(void *rxq)
 {
@@ -330,6 +343,7 @@ idpf_qc_rx_queue_release(void *rxq)
 	rte_free(q);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_queue_release)
 void
 idpf_qc_tx_queue_release(void *txq)
 {
@@ -349,6 +363,7 @@ idpf_qc_tx_queue_release(void *txq)
 	rte_free(q);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_ts_mbuf_register)
 int
 idpf_qc_ts_mbuf_register(struct idpf_rx_queue *rxq)
 {
@@ -366,6 +381,7 @@ idpf_qc_ts_mbuf_register(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rxq_mbufs_alloc)
 int
 idpf_qc_single_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 {
@@ -401,6 +417,7 @@ idpf_qc_single_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rxq_mbufs_alloc)
 int
 idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 {
@@ -624,6 +641,7 @@ idpf_split_rx_bufq_refill(struct idpf_rx_queue *rx_bufq)
 	rx_bufq->rx_tail = next_avail;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts)
 uint16_t
 idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
@@ -856,6 +874,7 @@ idpf_set_splitq_tso_ctx(struct rte_mbuf *mbuf,
 				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts)
 uint16_t
 idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 uint16_t nb_pkts)
@@ -1047,6 +1066,7 @@ idpf_singleq_rx_rss_offload(struct rte_mbuf *mb,
 
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts)
 uint16_t
 idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts)
@@ -1165,6 +1185,7 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return nb_rx;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_scatter_pkts)
 uint16_t
 idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
@@ -1342,6 +1363,7 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 }
 
 /* TX function */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts)
 uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
@@ -1509,6 +1531,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 /* TX prep functions */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_prep_pkts)
 uint16_t
 idpf_dp_prep_pkts(__rte_unused void *tx_queue, struct rte_mbuf **tx_pkts,
 		  uint16_t nb_pkts)
@@ -1610,6 +1633,7 @@ idpf_rxq_vec_setup_default(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_singleq_rx_vec_setup)
 int __rte_cold
 idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
@@ -1617,6 +1641,7 @@ idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 	return idpf_rxq_vec_setup_default(rxq);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_splitq_rx_vec_setup)
 int __rte_cold
 idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 43a95466ae..79b8d80ea9 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2023 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_vect.h>
 
 #include "idpf_common_rxtx.h"
@@ -473,6 +474,7 @@ _idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx2)
 uint16_t
 idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
@@ -682,6 +684,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	return nb_pkts;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx2)
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index b630d1fcd9..1299346cbc 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2023 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_vect.h>
 #include "idpf_common_device.h"
 #include "idpf_common_rxtx.h"
@@ -530,6 +531,7 @@ _idpf_singleq_recv_raw_pkts_avx512(struct idpf_rx_queue *rxq,
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx512)
 uint16_t
 idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				 uint16_t nb_pkts)
@@ -987,6 +989,7 @@ _idpf_splitq_recv_raw_pkts_avx512(struct idpf_rx_queue *rxq,
 }
 
 /* only bufq2 can receive pkts */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx512)
 uint16_t
 idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
@@ -1281,6 +1284,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx512)
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts)
@@ -1584,6 +1588,7 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx512)
 uint16_t
 idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts)
@@ -1619,6 +1624,7 @@ static const struct idpf_txq_ops avx512_tx_vec_ops = {
 	.release_mbufs = idpf_tx_release_mbufs_avx512,
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
 int __rte_cold
 idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index 0ae1d55d79..c152a11811 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -5,6 +5,8 @@
 #include "idpf_common_virtchnl.h"
 #include "idpf_common_logs.h"
 
+#include <eal_export.h>
+
 static int
 idpf_vc_clean(struct idpf_adapter *adapter)
 {
@@ -158,6 +160,7 @@ idpf_read_msg_from_cp(struct idpf_adapter *adapter, uint16_t buf_len,
 #define MAX_TRY_TIMES 200
 #define ASQ_DELAY_MS  10
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_one_msg_read)
 int
 idpf_vc_one_msg_read(struct idpf_adapter *adapter, uint32_t ops, uint16_t buf_len,
 		     uint8_t *buf)
@@ -182,6 +185,7 @@ idpf_vc_one_msg_read(struct idpf_adapter *adapter, uint32_t ops, uint16_t buf_le
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_cmd_execute)
 int
 idpf_vc_cmd_execute(struct idpf_adapter *adapter, struct idpf_cmd_info *args)
 {
@@ -231,6 +235,7 @@ idpf_vc_cmd_execute(struct idpf_adapter *adapter, struct idpf_cmd_info *args)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_api_version_check)
 int
 idpf_vc_api_version_check(struct idpf_adapter *adapter)
 {
@@ -271,6 +276,7 @@ idpf_vc_api_version_check(struct idpf_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_caps_get)
 int
 idpf_vc_caps_get(struct idpf_adapter *adapter)
 {
@@ -295,6 +301,7 @@ idpf_vc_caps_get(struct idpf_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_create)
 int
 idpf_vc_vport_create(struct idpf_vport *vport,
 		     struct virtchnl2_create_vport *create_vport_info)
@@ -331,6 +338,7 @@ idpf_vc_vport_create(struct idpf_vport *vport,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_destroy)
 int
 idpf_vc_vport_destroy(struct idpf_vport *vport)
 {
@@ -355,6 +363,7 @@ idpf_vc_vport_destroy(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_add)
 int
 idpf_vc_queue_grps_add(struct idpf_vport *vport,
 		       struct virtchnl2_add_queue_groups *p2p_queue_grps_info,
@@ -387,6 +396,7 @@ idpf_vc_queue_grps_add(struct idpf_vport *vport,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_del)
 int idpf_vc_queue_grps_del(struct idpf_vport *vport,
 			  uint16_t num_q_grps,
 			  struct virtchnl2_queue_group_id *qg_ids)
@@ -421,6 +431,7 @@ int idpf_vc_queue_grps_del(struct idpf_vport *vport,
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_set)
 int
 idpf_vc_rss_key_set(struct idpf_vport *vport)
 {
@@ -455,6 +466,7 @@ idpf_vc_rss_key_set(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_get)
 int idpf_vc_rss_key_get(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
@@ -497,6 +509,7 @@ int idpf_vc_rss_key_get(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_set)
 int
 idpf_vc_rss_lut_set(struct idpf_vport *vport)
 {
@@ -531,6 +544,7 @@ idpf_vc_rss_lut_set(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_get)
 int
 idpf_vc_rss_lut_get(struct idpf_vport *vport)
 {
@@ -573,6 +587,7 @@ idpf_vc_rss_lut_get(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_get)
 int
 idpf_vc_rss_hash_get(struct idpf_vport *vport)
 {
@@ -605,6 +620,7 @@ idpf_vc_rss_hash_get(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_set)
 int
 idpf_vc_rss_hash_set(struct idpf_vport *vport)
 {
@@ -631,6 +647,7 @@ idpf_vc_rss_hash_set(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_irq_map_unmap_config)
 int
 idpf_vc_irq_map_unmap_config(struct idpf_vport *vport, uint16_t nb_rxq, bool map)
 {
@@ -672,6 +689,7 @@ idpf_vc_irq_map_unmap_config(struct idpf_vport *vport, uint16_t nb_rxq, bool map
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_alloc)
 int
 idpf_vc_vectors_alloc(struct idpf_vport *vport, uint16_t num_vectors)
 {
@@ -702,6 +720,7 @@ idpf_vc_vectors_alloc(struct idpf_vport *vport, uint16_t num_vectors)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_dealloc)
 int
 idpf_vc_vectors_dealloc(struct idpf_vport *vport)
 {
@@ -729,6 +748,7 @@ idpf_vc_vectors_dealloc(struct idpf_vport *vport)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ena_dis_one_queue)
 int
 idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 			  uint32_t type, bool on)
@@ -767,6 +787,7 @@ idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_switch)
 int
 idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
 		     bool rx, bool on, uint32_t type)
@@ -807,6 +828,7 @@ idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
 }
 
 #define IDPF_RXTX_QUEUE_CHUNKS_NUM	2
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queues_ena_dis)
 int
 idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 {
@@ -875,6 +897,7 @@ idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_ena_dis)
 int
 idpf_vc_vport_ena_dis(struct idpf_vport *vport, bool enable)
 {
@@ -900,6 +923,7 @@ idpf_vc_vport_ena_dis(struct idpf_vport *vport, bool enable)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ptype_info_query)
 int
 idpf_vc_ptype_info_query(struct idpf_adapter *adapter,
 			 struct virtchnl2_get_ptype_info *req_ptype_info,
@@ -922,6 +946,7 @@ idpf_vc_ptype_info_query(struct idpf_adapter *adapter,
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_stats_query)
 int
 idpf_vc_stats_query(struct idpf_vport *vport,
 		struct virtchnl2_vport_stats **pstats)
@@ -949,6 +974,7 @@ idpf_vc_stats_query(struct idpf_vport *vport,
 }
 
 #define IDPF_RX_BUF_STRIDE		64
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config)
 int
 idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 {
@@ -1038,6 +1064,7 @@ idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config_by_info)
 int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_info *rxq_info,
 			       uint16_t num_qs)
 {
@@ -1073,6 +1100,7 @@ int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_in
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config)
 int
 idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 {
@@ -1144,6 +1172,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config_by_info)
 int
 idpf_vc_txq_config_by_info(struct idpf_vport *vport, struct virtchnl2_txq_info *txq_info,
 		       uint16_t num_qs)
@@ -1179,6 +1208,7 @@ idpf_vc_txq_config_by_info(struct idpf_vport *vport, struct virtchnl2_txq_info *
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_recv)
 int
 idpf_vc_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 		  struct idpf_ctlq_msg *q_msg)
@@ -1186,6 +1216,7 @@ idpf_vc_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	return idpf_ctlq_recv(cq, num_q_msg, q_msg);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_post_rx_buffs)
 int
 idpf_vc_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 			   u16 *buff_count, struct idpf_dma_mem **buffs)
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index c8f06a06cb..2ee87c94c2 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
 #include <bus_pci_driver.h>
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_pci.h>
 #include <rte_malloc.h>
@@ -34,6 +35,7 @@ static const struct rte_afu_uuid afu_uuid_ipn3ke_map[] = {
 	{ 0, 0 /* sentinel */ },
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(ipn3ke_bridge_func)
 struct ipn3ke_pub_func ipn3ke_bridge_func;
 
 static int
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index 5a7d66d9b9..c2300a8955 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -7,8 +7,10 @@
 #include "base/ixgbe_api.h"
 #include "base/ixgbe_x550.h"
 #include "ixgbe_ethdev.h"
+#include <eal_export.h>
 #include "rte_pmd_ixgbe.h"
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_addr)
 int
 rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 			      struct rte_ether_addr *mac_addr)
@@ -45,6 +47,7 @@ rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_ping_vf)
 int
 rte_pmd_ixgbe_ping_vf(uint16_t port, uint16_t vf)
 {
@@ -77,6 +80,7 @@ rte_pmd_ixgbe_ping_vf(uint16_t port, uint16_t vf)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_anti_spoof)
 int
 rte_pmd_ixgbe_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -107,6 +111,7 @@ rte_pmd_ixgbe_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_anti_spoof)
 int
 rte_pmd_ixgbe_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -136,6 +141,7 @@ rte_pmd_ixgbe_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_insert)
 int
 rte_pmd_ixgbe_set_vf_vlan_insert(uint16_t port, uint16_t vf, uint16_t vlan_id)
 {
@@ -172,6 +178,7 @@ rte_pmd_ixgbe_set_vf_vlan_insert(uint16_t port, uint16_t vf, uint16_t vlan_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tx_loopback)
 int
 rte_pmd_ixgbe_set_tx_loopback(uint16_t port, uint8_t on)
 {
@@ -202,6 +209,7 @@ rte_pmd_ixgbe_set_tx_loopback(uint16_t port, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_all_queues_drop_en)
 int
 rte_pmd_ixgbe_set_all_queues_drop_en(uint16_t port, uint8_t on)
 {
@@ -232,6 +240,7 @@ rte_pmd_ixgbe_set_all_queues_drop_en(uint16_t port, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_split_drop_en)
 int
 rte_pmd_ixgbe_set_vf_split_drop_en(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -267,6 +276,7 @@ rte_pmd_ixgbe_set_vf_split_drop_en(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_stripq)
 int
 rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -314,6 +324,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rxmode)
 int
 rte_pmd_ixgbe_set_vf_rxmode(uint16_t port, uint16_t vf,
 			    uint16_t rx_mask, uint8_t on)
@@ -361,6 +372,7 @@ rte_pmd_ixgbe_set_vf_rxmode(uint16_t port, uint16_t vf,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rx)
 int
 rte_pmd_ixgbe_set_vf_rx(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -411,6 +423,7 @@ rte_pmd_ixgbe_set_vf_rx(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_tx)
 int
 rte_pmd_ixgbe_set_vf_tx(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -461,6 +474,7 @@ rte_pmd_ixgbe_set_vf_tx(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_filter)
 int
 rte_pmd_ixgbe_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 				 uint64_t vf_mask, uint8_t vlan_on)
@@ -496,6 +510,7 @@ rte_pmd_ixgbe_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rate_limit)
 int
 rte_pmd_ixgbe_set_vf_rate_limit(uint16_t port, uint16_t vf,
 				uint32_t tx_rate, uint64_t q_msk)
@@ -512,6 +527,7 @@ rte_pmd_ixgbe_set_vf_rate_limit(uint16_t port, uint16_t vf,
 	return ixgbe_set_vf_rate_limit(dev, vf, tx_rate, q_msk);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_enable)
 int
 rte_pmd_ixgbe_macsec_enable(uint16_t port, uint8_t en, uint8_t rp)
 {
@@ -536,6 +552,7 @@ rte_pmd_ixgbe_macsec_enable(uint16_t port, uint8_t en, uint8_t rp)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_disable)
 int
 rte_pmd_ixgbe_macsec_disable(uint16_t port)
 {
@@ -555,6 +572,7 @@ rte_pmd_ixgbe_macsec_disable(uint16_t port)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_txsc)
 int
 rte_pmd_ixgbe_macsec_config_txsc(uint16_t port, uint8_t *mac)
 {
@@ -580,6 +598,7 @@ rte_pmd_ixgbe_macsec_config_txsc(uint16_t port, uint8_t *mac)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_rxsc)
 int
 rte_pmd_ixgbe_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 {
@@ -606,6 +625,7 @@ rte_pmd_ixgbe_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_txsa)
 int
 rte_pmd_ixgbe_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -662,6 +682,7 @@ rte_pmd_ixgbe_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_rxsa)
 int
 rte_pmd_ixgbe_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -705,6 +726,7 @@ rte_pmd_ixgbe_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tc_bw_alloc)
 int
 rte_pmd_ixgbe_set_tc_bw_alloc(uint16_t port,
 			      uint8_t tc_num,
@@ -778,6 +800,7 @@ rte_pmd_ixgbe_set_tc_bw_alloc(uint16_t port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_upd_fctrl_sbp)
 int
 rte_pmd_ixgbe_upd_fctrl_sbp(uint16_t port, int enable)
 {
@@ -807,6 +830,7 @@ rte_pmd_ixgbe_upd_fctrl_sbp(uint16_t port, int enable)
 }
 
 #ifdef RTE_LIBRTE_IXGBE_BYPASS
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_init)
 int
 rte_pmd_ixgbe_bypass_init(uint16_t port_id)
 {
@@ -822,6 +846,7 @@ rte_pmd_ixgbe_bypass_init(uint16_t port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_show)
 int
 rte_pmd_ixgbe_bypass_state_show(uint16_t port_id, uint32_t *state)
 {
@@ -836,6 +861,7 @@ rte_pmd_ixgbe_bypass_state_show(uint16_t port_id, uint32_t *state)
 	return ixgbe_bypass_state_show(dev, state);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_set)
 int
 rte_pmd_ixgbe_bypass_state_set(uint16_t port_id, uint32_t *new_state)
 {
@@ -850,6 +876,7 @@ rte_pmd_ixgbe_bypass_state_set(uint16_t port_id, uint32_t *new_state)
 	return ixgbe_bypass_state_store(dev, new_state);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_show)
 int
 rte_pmd_ixgbe_bypass_event_show(uint16_t port_id,
 				uint32_t event,
@@ -866,6 +893,7 @@ rte_pmd_ixgbe_bypass_event_show(uint16_t port_id,
 	return ixgbe_bypass_event_show(dev, event, state);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_store)
 int
 rte_pmd_ixgbe_bypass_event_store(uint16_t port_id,
 				 uint32_t event,
@@ -882,6 +910,7 @@ rte_pmd_ixgbe_bypass_event_store(uint16_t port_id,
 	return ixgbe_bypass_event_store(dev, event, state);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_store)
 int
 rte_pmd_ixgbe_bypass_wd_timeout_store(uint16_t port_id, uint32_t timeout)
 {
@@ -896,6 +925,7 @@ rte_pmd_ixgbe_bypass_wd_timeout_store(uint16_t port_id, uint32_t timeout)
 	return ixgbe_bypass_wd_timeout_store(dev, timeout);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_ver_show)
 int
 rte_pmd_ixgbe_bypass_ver_show(uint16_t port_id, uint32_t *ver)
 {
@@ -910,6 +940,7 @@ rte_pmd_ixgbe_bypass_ver_show(uint16_t port_id, uint32_t *ver)
 	return ixgbe_bypass_ver_show(dev, ver);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_show)
 int
 rte_pmd_ixgbe_bypass_wd_timeout_show(uint16_t port_id, uint32_t *wd_timeout)
 {
@@ -924,6 +955,7 @@ rte_pmd_ixgbe_bypass_wd_timeout_show(uint16_t port_id, uint32_t *wd_timeout)
 	return ixgbe_bypass_wd_timeout_show(dev, wd_timeout);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_reset)
 int
 rte_pmd_ixgbe_bypass_wd_reset(uint16_t port_id)
 {
@@ -992,6 +1024,7 @@ STATIC void rte_pmd_ixgbe_release_swfw(struct ixgbe_hw *hw, u32 mask)
 	ixgbe_release_swfw_semaphore(hw, mask);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_lock)
 int
 rte_pmd_ixgbe_mdio_lock(uint16_t port)
 {
@@ -1019,6 +1052,7 @@ rte_pmd_ixgbe_mdio_lock(uint16_t port)
 	return IXGBE_SUCCESS;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlock)
 int
 rte_pmd_ixgbe_mdio_unlock(uint16_t port)
 {
@@ -1046,6 +1080,7 @@ rte_pmd_ixgbe_mdio_unlock(uint16_t port)
 	return IXGBE_SUCCESS;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_read)
 int
 rte_pmd_ixgbe_mdio_unlocked_read(uint16_t port, uint32_t reg_addr,
 				 uint32_t dev_type, uint16_t *phy_data)
@@ -1093,6 +1128,7 @@ rte_pmd_ixgbe_mdio_unlocked_read(uint16_t port, uint32_t reg_addr,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_write)
 int
 rte_pmd_ixgbe_mdio_unlocked_write(uint16_t port, uint32_t reg_addr,
 				  uint32_t dev_type, uint16_t phy_data)
@@ -1140,6 +1176,7 @@ rte_pmd_ixgbe_mdio_unlocked_write(uint16_t port, uint32_t reg_addr,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_info, 20.08)
 int
 rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 {
@@ -1156,6 +1193,7 @@ rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_stats, 20.08)
 int
 rte_pmd_ixgbe_get_fdir_stats(uint16_t port,
 			     struct rte_eth_fdir_stats *fdir_stats)
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 646da8e846..b4bd43aae2 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <fcntl.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <ethdev_driver.h>
 #include <rte_pci.h>
@@ -3341,6 +3342,7 @@ mlx5_set_metadata_mask(struct rte_eth_dev *dev)
 	DRV_LOG(DEBUG, "metadata reg_c0 mask %08X", sh->dv_regc0_mask);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_get_dyn_flag_names, 20.02)
 int
 rte_pmd_mlx5_get_dyn_flag_names(char *names[], unsigned int n)
 {
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index e2f4bd8cef..cb91f4dfbe 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -7884,6 +7885,7 @@ mlx5_flow_cache_flow_toggle(struct rte_eth_dev *dev, bool orig_prio)
  * @return
  *   Negative value on error, positive on success.
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_flow_engine_set_mode, 23.03)
 int
 rte_pmd_mlx5_flow_engine_set_mode(enum rte_pmd_mlx5_flow_engine_mode mode, uint32_t flags)
 {
@@ -10989,6 +10991,7 @@ mlx5_action_handle_detach(struct rte_eth_dev *dev)
 	(MLX5DV_DR_DOMAIN_SYNC_FLAGS_SW | MLX5DV_DR_DOMAIN_SYNC_FLAGS_HW)
 #endif
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_sync_flow, 20.11)
 int rte_pmd_mlx5_sync_flow(uint16_t port_id, uint32_t domains)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
@@ -12265,6 +12268,7 @@ mlx5_flow_discover_ipv6_tc_support(struct rte_eth_dev *dev)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_create_geneve_tlv_parser, 24.03)
 void *
 rte_pmd_mlx5_create_geneve_tlv_parser(uint16_t port_id,
 				      const struct rte_pmd_mlx5_geneve_tlv tlv_list[],
@@ -12282,6 +12286,7 @@ rte_pmd_mlx5_create_geneve_tlv_parser(uint16_t port_id,
 #endif
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_destroy_geneve_tlv_parser, 24.03)
 int
 rte_pmd_mlx5_destroy_geneve_tlv_parser(void *handle)
 {
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5e58eb8bc9..b0b0ce250e 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
 #include <rte_prefetch.h>
@@ -1559,6 +1560,7 @@ mlxreg_host_shaper_config(struct rte_eth_dev *dev,
 #endif
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_host_shaper_config, 22.07)
 int rte_pmd_mlx5_host_shaper_config(int port_id, uint8_t rate,
 				    uint32_t flags)
 {
@@ -1600,6 +1602,7 @@ int rte_pmd_mlx5_host_shaper_config(int port_id, uint8_t rate,
  * @return
  *   0 for Success, non-zero value depending on failure type
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_rxq_dump_contexts, 24.07)
 int rte_pmd_mlx5_rxq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename)
 {
 	struct rte_eth_dev *dev;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 5cf7d4971b..ab29b43875 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -10,6 +10,7 @@
 #include <fcntl.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <ethdev_driver.h>
@@ -3285,6 +3286,7 @@ mlx5_external_rx_queue_get_validate(uint16_t port_id, uint16_t dpdk_idx)
 	return &priv->ext_rxqs[dpdk_idx - RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN];
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_map, 22.03)
 int
 rte_pmd_mlx5_external_rx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 				      uint32_t hw_idx)
@@ -3318,6 +3320,7 @@ rte_pmd_mlx5_external_rx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_unmap, 22.03)
 int
 rte_pmd_mlx5_external_rx_queue_id_unmap(uint16_t port_id, uint16_t dpdk_idx)
 {
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index 4286876e12..39afca3d64 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
 #include <rte_prefetch.h>
@@ -776,6 +777,7 @@ mlx5_tx_burst_mode_get(struct rte_eth_dev *dev,
  *   0 for success, non-zero value depending on failure.
  *
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_txq_dump_contexts, 24.07)
 int rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename)
 {
 	struct rte_eth_dev *dev;
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index 3e93517323..3b3f775ba7 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <ethdev_driver.h>
@@ -1342,6 +1343,7 @@ mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq)
 	return txq->is_hairpin ? txq->obj->sq->id : txq->obj->sq_obj.sq->id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_sq_enable, 22.07)
 int
 rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 {
@@ -1523,6 +1525,7 @@ mlx5_external_tx_queue_get_validate(uint16_t port_id, uint16_t dpdk_idx)
 	return &priv->ext_txqs[dpdk_idx - MLX5_EXTERNAL_TX_QUEUE_ID_MIN];
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_map, 24.07)
 int
 rte_pmd_mlx5_external_tx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 				      uint32_t hw_idx)
@@ -1556,6 +1559,7 @@ rte_pmd_mlx5_external_tx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_unmap, 24.07)
 int
 rte_pmd_mlx5_external_tx_queue_id_unmap(uint16_t port_id, uint16_t dpdk_idx)
 {
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index 3b8d717797..9451431144 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 
 #include <eventdev_pmd.h>
+#include <eal_export.h>
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
 #include <bus_vdev_driver.h>
@@ -44,6 +45,7 @@ struct octeontx_vdev_init_params {
 	uint8_t	nr_port;
 };
 
+RTE_EXPORT_SYMBOL(rte_octeontx_pchan_map)
 uint16_t
 rte_octeontx_pchan_map[OCTEONTX_MAX_BGX_PORTS][OCTEONTX_MAX_LMAC_PER_BGX];
 
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 146bdc8e02..b1085bf390 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include "rte_eth_ring.h"
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
@@ -456,6 +457,7 @@ do_eth_dev_ring_create(const char *name,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_from_rings)
 int
 rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 		const unsigned int nb_rx_queues,
@@ -514,6 +516,7 @@ rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 	return port_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_from_ring)
 int
 rte_eth_from_ring(struct rte_ring *r)
 {
diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 2147ea35f6..91a1c3a98e 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -8,6 +8,7 @@
 
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
@@ -516,6 +517,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_softnic,
 	PMD_PARAM_CPU_ID "=<uint32> "
 );
 
+RTE_EXPORT_SYMBOL(rte_pmd_softnic_manage)
 int
 rte_pmd_softnic_manage(uint16_t port_id)
 {
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index 888af6caf4..f72c836199 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_lcore.h>
@@ -554,6 +555,7 @@ rte_pmd_softnic_run_internal(void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_softnic_run)
 int
 rte_pmd_softnic_run(uint16_t port_id)
 {
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 87c05caccd..44bf2e3241 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -8,6 +8,7 @@
 #include <stdbool.h>
 #include <sys/epoll.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
@@ -1045,6 +1046,7 @@ vhost_driver_setup(struct rte_eth_dev *eth_dev)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_vhost_get_queue_event)
 int
 rte_eth_vhost_get_queue_event(uint16_t port_id,
 		struct rte_eth_vhost_queue_event *event)
@@ -1082,6 +1084,7 @@ rte_eth_vhost_get_queue_event(uint16_t port_id,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_vhost_get_vid_from_port_id)
 int
 rte_eth_vhost_get_vid_from_port_id(uint16_t port_id)
 {
diff --git a/drivers/power/kvm_vm/guest_channel.c b/drivers/power/kvm_vm/guest_channel.c
index 35cd4cfe6f..42bfcedb56 100644
--- a/drivers/power/kvm_vm/guest_channel.c
+++ b/drivers/power/kvm_vm/guest_channel.c
@@ -12,6 +12,7 @@
 #include <poll.h>
 
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_power_guest_channel.h>
 
@@ -151,6 +152,7 @@ guest_channel_send_msg(struct rte_power_channel_packet *pkt,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_guest_channel_send_msg)
 int rte_power_guest_channel_send_msg(struct rte_power_channel_packet *pkt,
 			unsigned int lcore_id)
 {
@@ -212,6 +214,7 @@ int power_guest_channel_read_msg(void *pkt,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_guest_channel_receive_msg)
 int rte_power_guest_channel_receive_msg(void *pkt,
 		size_t pkt_len,
 		unsigned int lcore_id)
diff --git a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
index 54c58a8552..60c2080740 100644
--- a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
+++ b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
@@ -3,6 +3,7 @@
  */
 
 #include <bus_pci_driver.h>
+#include <eal_export.h>
 #include <rte_common.h>
 #include <dev_driver.h>
 #include <rte_eal.h>
@@ -16,6 +17,7 @@
 #include "cnxk_rvu_lf.h"
 #include "cnxk_rvu_lf_driver.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_id_range_set)
 int
 rte_pmd_rvu_lf_msg_id_range_set(uint8_t dev_id, uint16_t from, uint16_t to)
 {
@@ -30,6 +32,7 @@ rte_pmd_rvu_lf_msg_id_range_set(uint8_t dev_id, uint16_t from, uint16_t to)
 	return roc_rvu_lf_msg_id_range_set(roc_rvu_lf, from, to);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_process)
 int
 rte_pmd_rvu_lf_msg_process(uint8_t dev_id, uint16_t vf, uint16_t msg_id,
 			void *req, uint16_t req_len, void *rsp, uint16_t rsp_len)
@@ -45,6 +48,7 @@ rte_pmd_rvu_lf_msg_process(uint8_t dev_id, uint16_t vf, uint16_t msg_id,
 	return roc_rvu_lf_msg_process(roc_rvu_lf, vf, msg_id, req, req_len, rsp, rsp_len);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_register)
 int
 rte_pmd_rvu_lf_msg_handler_register(uint8_t dev_id, rte_pmd_rvu_lf_msg_handler_cb_fn cb)
 {
@@ -59,6 +63,7 @@ rte_pmd_rvu_lf_msg_handler_register(uint8_t dev_id, rte_pmd_rvu_lf_msg_handler_c
 	return roc_rvu_lf_msg_handler_register(roc_rvu_lf, (roc_rvu_lf_msg_handler_cb_fn)cb);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_unregister)
 int
 rte_pmd_rvu_lf_msg_handler_unregister(uint8_t dev_id)
 {
@@ -73,6 +78,7 @@ rte_pmd_rvu_lf_msg_handler_unregister(uint8_t dev_id)
 	return roc_rvu_lf_msg_handler_unregister(roc_rvu_lf);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_register)
 int
 rte_pmd_rvu_lf_irq_register(uint8_t dev_id, unsigned int irq,
 			    rte_pmd_rvu_lf_intr_callback_fn cb, void *data)
@@ -88,6 +94,7 @@ rte_pmd_rvu_lf_irq_register(uint8_t dev_id, unsigned int irq,
 	return roc_rvu_lf_irq_register(roc_rvu_lf, irq, (roc_rvu_lf_intr_cb_fn)cb, data);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_unregister)
 int
 rte_pmd_rvu_lf_irq_unregister(uint8_t dev_id, unsigned int irq,
 			      rte_pmd_rvu_lf_intr_callback_fn cb, void *data)
@@ -103,6 +110,7 @@ rte_pmd_rvu_lf_irq_unregister(uint8_t dev_id, unsigned int irq,
 	return roc_rvu_lf_irq_unregister(roc_rvu_lf, irq, (roc_rvu_lf_intr_cb_fn)cb, data);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_bar_get)
 int
 rte_pmd_rvu_lf_bar_get(uint8_t dev_id, uint8_t bar_num, size_t *va, size_t *mask)
 {
@@ -127,18 +135,21 @@ rte_pmd_rvu_lf_bar_get(uint8_t dev_id, uint8_t bar_num, size_t *va, size_t *mask
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_npa_pf_func_get)
 uint16_t
 rte_pmd_rvu_lf_npa_pf_func_get(void)
 {
 	return roc_npa_pf_func_get();
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_sso_pf_func_get)
 uint16_t
 rte_pmd_rvu_lf_sso_pf_func_get(void)
 {
 	return roc_sso_pf_func_get();
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_pf_func_get)
 uint16_t
 rte_pmd_rvu_lf_pf_func_get(uint8_t dev_id)
 {
diff --git a/drivers/raw/ifpga/rte_pmd_ifpga.c b/drivers/raw/ifpga/rte_pmd_ifpga.c
index a47d5a0350..620b35624b 100644
--- a/drivers/raw/ifpga/rte_pmd_ifpga.c
+++ b/drivers/raw/ifpga/rte_pmd_ifpga.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2021 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_rawdev.h>
@@ -12,6 +13,7 @@
 #include "base/ifpga_sec_mgr.h"
 
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_dev_id)
 int
 rte_pmd_ifpga_get_dev_id(const char *pci_addr, uint16_t *dev_id)
 {
@@ -100,6 +102,7 @@ get_share_data(struct opae_adapter *adapter)
 	return sd;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_rsu_status)
 int
 rte_pmd_ifpga_get_rsu_status(uint16_t dev_id, uint32_t *stat, uint32_t *prog)
 {
@@ -122,6 +125,7 @@ rte_pmd_ifpga_get_rsu_status(uint16_t dev_id, uint32_t *stat, uint32_t *prog)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_set_rsu_status)
 int
 rte_pmd_ifpga_set_rsu_status(uint16_t dev_id, uint32_t stat, uint32_t prog)
 {
@@ -263,6 +267,7 @@ get_port_property(struct opae_adapter *adapter, uint16_t port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_property)
 int
 rte_pmd_ifpga_get_property(uint16_t dev_id, rte_pmd_ifpga_prop *prop)
 {
@@ -299,6 +304,7 @@ rte_pmd_ifpga_get_property(uint16_t dev_id, rte_pmd_ifpga_prop *prop)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_phy_info)
 int
 rte_pmd_ifpga_get_phy_info(uint16_t dev_id, rte_pmd_ifpga_phy_info *info)
 {
@@ -339,6 +345,7 @@ rte_pmd_ifpga_get_phy_info(uint16_t dev_id, rte_pmd_ifpga_phy_info *info)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_update_flash)
 int
 rte_pmd_ifpga_update_flash(uint16_t dev_id, const char *image,
 	uint64_t *status)
@@ -352,6 +359,7 @@ rte_pmd_ifpga_update_flash(uint16_t dev_id, const char *image,
 	return opae_mgr_update_flash(adapter->mgr, image, status);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_stop_update)
 int
 rte_pmd_ifpga_stop_update(uint16_t dev_id, int force)
 {
@@ -364,6 +372,7 @@ rte_pmd_ifpga_stop_update(uint16_t dev_id, int force)
 	return opae_mgr_stop_flash_update(adapter->mgr, force);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reboot_try)
 int
 rte_pmd_ifpga_reboot_try(uint16_t dev_id)
 {
@@ -390,6 +399,7 @@ rte_pmd_ifpga_reboot_try(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reload)
 int
 rte_pmd_ifpga_reload(uint16_t dev_id, int type, int page)
 {
@@ -402,6 +412,7 @@ rte_pmd_ifpga_reload(uint16_t dev_id, int type, int page)
 	return opae_mgr_reload(adapter->mgr, type, page);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_partial_reconfigure)
 int
 rte_pmd_ifpga_partial_reconfigure(uint16_t dev_id, int port, const char *file)
 {
@@ -416,6 +427,7 @@ rte_pmd_ifpga_partial_reconfigure(uint16_t dev_id, int port, const char *file)
 	return ifpga_rawdev_partial_reconfigure(dev, port, file);
 }
 
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_cleanup)
 void
 rte_pmd_ifpga_cleanup(void)
 {
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 56e3b31ed6..7056b1c117 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_acl.h>
 #include <rte_log.h>
 
@@ -1621,6 +1622,7 @@ get_first_load_size(const struct rte_acl_config *cfg)
 	return (ofs < max_ofs) ? sizeof(uint32_t) : sizeof(uint8_t);
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_build)
 int
 rte_acl_build(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 {
diff --git a/lib/acl/acl_run_scalar.c b/lib/acl/acl_run_scalar.c
index 3d61e79409..8ffb40776c 100644
--- a/lib/acl/acl_run_scalar.c
+++ b/lib/acl/acl_run_scalar.c
@@ -4,6 +4,8 @@
 
 #include "acl_run.h"
 
+#include <eal_export.h>
+
 /*
  * Resolve priority for multiple results (scalar version).
  * This consists comparing the priority of the current traversal with the
@@ -106,6 +108,7 @@ scalar_transition(const uint64_t *trans_table, uint64_t transition,
 	return transition;
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_classify_scalar)
 int
 rte_acl_classify_scalar(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories)
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 245b9b6d7a..8c0ca29618 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_string_fns.h>
 #include <rte_acl.h>
@@ -263,6 +264,7 @@ acl_get_best_alg(void)
 	return alg[i];
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
 extern int
 rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
 {
@@ -285,6 +287,7 @@ rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_classify_alg)
 int
 rte_acl_classify_alg(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories,
@@ -297,6 +300,7 @@ rte_acl_classify_alg(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	return classify_fns[alg](ctx, data, results, num, categories);
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_classify)
 int
 rte_acl_classify(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories)
@@ -305,6 +309,7 @@ rte_acl_classify(const struct rte_acl_ctx *ctx, const uint8_t **data,
 		ctx->alg);
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_find_existing)
 struct rte_acl_ctx *
 rte_acl_find_existing(const char *name)
 {
@@ -329,6 +334,7 @@ rte_acl_find_existing(const char *name)
 	return ctx;
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_free)
 void
 rte_acl_free(struct rte_acl_ctx *ctx)
 {
@@ -361,6 +367,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_create)
 struct rte_acl_ctx *
 rte_acl_create(const struct rte_acl_param *param)
 {
@@ -457,6 +464,7 @@ acl_check_rule(const struct rte_acl_rule_data *rd)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_acl_add_rules)
 int
 rte_acl_add_rules(struct rte_acl_ctx *ctx, const struct rte_acl_rule *rules,
 	uint32_t num)
@@ -486,6 +494,7 @@ rte_acl_add_rules(struct rte_acl_ctx *ctx, const struct rte_acl_rule *rules,
  * Reset all rules.
  * Note that RT structures are not affected.
  */
+RTE_EXPORT_SYMBOL(rte_acl_reset_rules)
 void
 rte_acl_reset_rules(struct rte_acl_ctx *ctx)
 {
@@ -496,6 +505,7 @@ rte_acl_reset_rules(struct rte_acl_ctx *ctx)
 /*
  * Reset all rules and destroys RT structures.
  */
+RTE_EXPORT_SYMBOL(rte_acl_reset)
 void
 rte_acl_reset(struct rte_acl_ctx *ctx)
 {
@@ -508,6 +518,7 @@ rte_acl_reset(struct rte_acl_ctx *ctx)
 /*
  * Dump ACL context to the stdout.
  */
+RTE_EXPORT_SYMBOL(rte_acl_dump)
 void
 rte_acl_dump(const struct rte_acl_ctx *ctx)
 {
@@ -527,6 +538,7 @@ rte_acl_dump(const struct rte_acl_ctx *ctx)
 /*
  * Dump all ACL contexts to the stdout.
  */
+RTE_EXPORT_SYMBOL(rte_acl_list_dump)
 void
 rte_acl_list_dump(void)
 {
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index e7007afc6a..18290e0c38 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 
 #include "rte_argparse.h"
@@ -737,6 +738,7 @@ show_args_help(const struct rte_argparse *obj)
 		printf("\n");
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
 int
 rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 {
@@ -764,6 +766,7 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse_type, 24.03)
 int
 rte_argparse_parse_type(const char *str, uint64_t val_type, void *val)
 {
diff --git a/lib/bbdev/bbdev_trace_points.c b/lib/bbdev/bbdev_trace_points.c
index 6f90e2aa65..942c7be819 100644
--- a/lib/bbdev/bbdev_trace_points.c
+++ b/lib/bbdev/bbdev_trace_points.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2025 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include "bbdev_trace.h"
@@ -21,7 +22,9 @@ RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_start,
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_stop,
 	lib.bbdev.queue.stop)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_enqueue, 25.03)
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_enqueue,
 	lib.bbdev.enq)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_dequeue, 25.03)
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_dequeue,
 	lib.bbdev.deq)
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index f341e6f3b9..6ca91c7cf1 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -92,6 +93,7 @@ static rte_spinlock_t rte_bbdev_cb_lock = RTE_SPINLOCK_INITIALIZER;
  * Global array of all devices. This is not static because it's used by the
  * inline enqueue and dequeue functions
  */
+RTE_EXPORT_SYMBOL(rte_bbdev_devices)
 struct rte_bbdev rte_bbdev_devices[RTE_BBDEV_MAX_DEVS];
 
 /* Global array with rte_bbdev_data structures */
@@ -173,6 +175,7 @@ find_free_dev_id(void)
 	return RTE_BBDEV_MAX_DEVS;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_allocate)
 struct rte_bbdev *
 rte_bbdev_allocate(const char *name)
 {
@@ -232,6 +235,7 @@ rte_bbdev_allocate(const char *name)
 	return bbdev;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_release)
 int
 rte_bbdev_release(struct rte_bbdev *bbdev)
 {
@@ -267,6 +271,7 @@ rte_bbdev_release(struct rte_bbdev *bbdev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_get_named_dev)
 struct rte_bbdev *
 rte_bbdev_get_named_dev(const char *name)
 {
@@ -287,12 +292,14 @@ rte_bbdev_get_named_dev(const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_count)
 uint16_t
 rte_bbdev_count(void)
 {
 	return num_devs;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_is_valid)
 bool
 rte_bbdev_is_valid(uint16_t dev_id)
 {
@@ -302,6 +309,7 @@ rte_bbdev_is_valid(uint16_t dev_id)
 	return false;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_find_next)
 uint16_t
 rte_bbdev_find_next(uint16_t dev_id)
 {
@@ -312,6 +320,7 @@ rte_bbdev_find_next(uint16_t dev_id)
 	return dev_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_setup_queues)
 int
 rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 {
@@ -404,6 +413,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_intr_enable)
 int
 rte_bbdev_intr_enable(uint16_t dev_id)
 {
@@ -436,6 +446,7 @@ rte_bbdev_intr_enable(uint16_t dev_id)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_configure)
 int
 rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 		const struct rte_bbdev_queue_conf *conf)
@@ -556,6 +567,7 @@ rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_start)
 int
 rte_bbdev_start(uint16_t dev_id)
 {
@@ -590,6 +602,7 @@ rte_bbdev_start(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_stop)
 int
 rte_bbdev_stop(uint16_t dev_id)
 {
@@ -613,6 +626,7 @@ rte_bbdev_stop(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_close)
 int
 rte_bbdev_close(uint16_t dev_id)
 {
@@ -660,6 +674,7 @@ rte_bbdev_close(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_start)
 int
 rte_bbdev_queue_start(uint16_t dev_id, uint16_t queue_id)
 {
@@ -692,6 +707,7 @@ rte_bbdev_queue_start(uint16_t dev_id, uint16_t queue_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_stop)
 int
 rte_bbdev_queue_stop(uint16_t dev_id, uint16_t queue_id)
 {
@@ -756,6 +772,7 @@ reset_stats_in_queues(struct rte_bbdev *dev)
 	rte_bbdev_log_debug("Reset stats on %u", dev->data->dev_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_stats_get)
 int
 rte_bbdev_stats_get(uint16_t dev_id, struct rte_bbdev_stats *stats)
 {
@@ -779,6 +796,7 @@ rte_bbdev_stats_get(uint16_t dev_id, struct rte_bbdev_stats *stats)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_stats_reset)
 int
 rte_bbdev_stats_reset(uint16_t dev_id)
 {
@@ -796,6 +814,7 @@ rte_bbdev_stats_reset(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_info_get)
 int
 rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
 {
@@ -824,6 +843,7 @@ rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_info_get)
 int
 rte_bbdev_queue_info_get(uint16_t dev_id, uint16_t queue_id,
 		struct rte_bbdev_queue_info *queue_info)
@@ -910,6 +930,7 @@ bbdev_op_init(struct rte_mempool *mempool, void *arg, void *element,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_op_pool_create)
 struct rte_mempool *
 rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 		unsigned int num_elements, unsigned int cache_size,
@@ -957,6 +978,7 @@ rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 	return mp;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_callback_register)
 int
 rte_bbdev_callback_register(uint16_t dev_id, enum rte_bbdev_event_type event,
 		rte_bbdev_cb_fn cb_fn, void *cb_arg)
@@ -1002,6 +1024,7 @@ rte_bbdev_callback_register(uint16_t dev_id, enum rte_bbdev_event_type event,
 	return (user_cb == NULL) ? -ENOMEM : 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_callback_unregister)
 int
 rte_bbdev_callback_unregister(uint16_t dev_id, enum rte_bbdev_event_type event,
 		rte_bbdev_cb_fn cb_fn, void *cb_arg)
@@ -1047,6 +1070,7 @@ rte_bbdev_callback_unregister(uint16_t dev_id, enum rte_bbdev_event_type event,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_pmd_callback_process)
 void
 rte_bbdev_pmd_callback_process(struct rte_bbdev *dev,
 	enum rte_bbdev_event_type event, void *ret_param)
@@ -1089,6 +1113,7 @@ rte_bbdev_pmd_callback_process(struct rte_bbdev *dev,
 	rte_spinlock_unlock(&rte_bbdev_cb_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_enable)
 int
 rte_bbdev_queue_intr_enable(uint16_t dev_id, uint16_t queue_id)
 {
@@ -1100,6 +1125,7 @@ rte_bbdev_queue_intr_enable(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_intr_enable(dev, queue_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_disable)
 int
 rte_bbdev_queue_intr_disable(uint16_t dev_id, uint16_t queue_id)
 {
@@ -1111,6 +1137,7 @@ rte_bbdev_queue_intr_disable(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_intr_disable(dev, queue_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_queue_intr_ctl)
 int
 rte_bbdev_queue_intr_ctl(uint16_t dev_id, uint16_t queue_id, int epfd, int op,
 		void *data)
@@ -1148,6 +1175,7 @@ rte_bbdev_queue_intr_ctl(uint16_t dev_id, uint16_t queue_id, int epfd, int op,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_bbdev_op_type_str)
 const char *
 rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type)
 {
@@ -1168,6 +1196,7 @@ rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_device_status_str)
 const char *
 rte_bbdev_device_status_str(enum rte_bbdev_device_status status)
 {
@@ -1191,6 +1220,7 @@ rte_bbdev_device_status_str(enum rte_bbdev_device_status status)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_bbdev_enqueue_status_str)
 const char *
 rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status)
 {
@@ -1210,6 +1240,7 @@ rte_bbdev_enqueue_status_str(enum rte_bbdev_enqueue_status status)
 }
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_queue_ops_dump, 24.11)
 int
 rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 {
@@ -1249,6 +1280,7 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 	return dev->dev_ops->queue_ops_dump(dev, queue_id, f);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_param_string, 24.11)
 char *
 rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, char *str, uint32_t len)
 {
diff --git a/lib/bitratestats/rte_bitrate.c b/lib/bitratestats/rte_bitrate.c
index 1664e4863b..592e478e06 100644
--- a/lib/bitratestats/rte_bitrate.c
+++ b/lib/bitratestats/rte_bitrate.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2017 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
@@ -28,6 +29,7 @@ struct rte_stats_bitrates {
 	uint16_t id_stats_set;
 };
 
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_create)
 struct rte_stats_bitrates *
 rte_stats_bitrate_create(void)
 {
@@ -35,12 +37,14 @@ rte_stats_bitrate_create(void)
 		RTE_CACHE_LINE_SIZE);
 }
 
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_free)
 void
 rte_stats_bitrate_free(struct rte_stats_bitrates *bitrate_data)
 {
 	rte_free(bitrate_data);
 }
 
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_reg)
 int
 rte_stats_bitrate_reg(struct rte_stats_bitrates *bitrate_data)
 {
@@ -62,6 +66,7 @@ rte_stats_bitrate_reg(struct rte_stats_bitrates *bitrate_data)
 	return return_value;
 }
 
+RTE_EXPORT_SYMBOL(rte_stats_bitrate_calc)
 int
 rte_stats_bitrate_calc(struct rte_stats_bitrates *bitrate_data,
 			uint16_t port_id)
diff --git a/lib/bpf/bpf.c b/lib/bpf/bpf.c
index bbe75c8bfe..5239b3e11e 100644
--- a/lib/bpf/bpf.c
+++ b/lib/bpf/bpf.c
@@ -6,10 +6,12 @@
 #include <errno.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 
 #include "bpf_impl.h"
 
+RTE_EXPORT_SYMBOL(rte_bpf_destroy)
 void
 rte_bpf_destroy(struct rte_bpf *bpf)
 {
@@ -20,6 +22,7 @@ rte_bpf_destroy(struct rte_bpf *bpf)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_get_jit)
 int
 rte_bpf_get_jit(const struct rte_bpf *bpf, struct rte_bpf_jit *jit)
 {
diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index e7e298c9cb..86e703299d 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_bpf.h>
 #include <rte_log.h>
@@ -517,6 +518,7 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_convert)
 struct rte_bpf_prm *
 rte_bpf_convert(const struct bpf_program *prog)
 {
diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index b86977b96d..6ee0e32b43 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include "rte_bpf.h"
 
 #define BPF_OP_INDEX(x) (BPF_OP(x) >> 4)
@@ -43,6 +44,7 @@ static const char *const jump_tbl[16] = {
 	[EBPF_CALL >> 4] = "call", [EBPF_EXIT >> 4] = "exit",
 };
 
+RTE_EXPORT_SYMBOL(rte_bpf_dump)
 void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 {
 	uint32_t i;
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 5d597ec170..4b5ea9f1a4 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_debug.h>
@@ -475,6 +476,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_exec_burst)
 uint32_t
 rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	uint32_t num)
@@ -494,6 +496,7 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_exec)
 uint64_t
 rte_bpf_exec(const struct rte_bpf *bpf, void *ctx)
 {
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index de43347405..556e613762 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_errno.h>
 
@@ -79,6 +80,7 @@ bpf_check_xsym(const struct rte_bpf_xsym *xsym)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_load)
 struct rte_bpf *
 rte_bpf_load(const struct rte_bpf_prm *prm)
 {
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index e0abd3c856..1d30ba17e2 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -17,6 +17,7 @@
 
 #include <libelf.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_debug.h>
@@ -294,6 +295,7 @@ bpf_load_elf(const struct rte_bpf_prm *prm, int32_t fd, const char *section)
 	return bpf;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 	const char *sname)
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index aaca935f2d..01f813c56b 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -9,6 +9,7 @@
 
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -465,6 +466,7 @@ bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_unload)
 void
 rte_bpf_eth_rx_unload(uint16_t port, uint16_t queue)
 {
@@ -476,6 +478,7 @@ rte_bpf_eth_rx_unload(uint16_t port, uint16_t queue)
 	rte_spinlock_unlock(&cbh->lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_unload)
 void
 rte_bpf_eth_tx_unload(uint16_t port, uint16_t queue)
 {
@@ -557,6 +560,7 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_eth_rx_elf_load)
 int
 rte_bpf_eth_rx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
@@ -573,6 +577,7 @@ rte_bpf_eth_rx_elf_load(uint16_t port, uint16_t queue,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_bpf_eth_tx_elf_load)
 int
 rte_bpf_eth_tx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
diff --git a/lib/bpf/bpf_stub.c b/lib/bpf/bpf_stub.c
index 1babb16bde..dea0d703ca 100644
--- a/lib/bpf/bpf_stub.c
+++ b/lib/bpf/bpf_stub.c
@@ -3,6 +3,7 @@
  */
 
 #include "bpf_impl.h"
+#include <eal_export.h>
 #include <rte_errno.h>
 
 /**
@@ -10,6 +11,7 @@
  */
 
 #ifndef RTE_LIBRTE_BPF_ELF
+RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 	const char *sname)
@@ -27,6 +29,7 @@ rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 #endif
 
 #ifndef RTE_HAS_LIBPCAP
+RTE_EXPORT_SYMBOL(rte_bpf_convert)
 struct rte_bpf_prm *
 rte_bpf_convert(const struct bpf_program *prog)
 {
diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 13ba3957bc..8bbdcf146e 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <errno.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_log.h>
@@ -158,6 +159,7 @@ rte_cfgfile_check_params(const struct rte_cfgfile_parameters *params)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_load)
 struct rte_cfgfile *
 rte_cfgfile_load(const char *filename, int flags)
 {
@@ -165,6 +167,7 @@ rte_cfgfile_load(const char *filename, int flags)
 					    &default_cfgfile_params);
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_load_with_params)
 struct rte_cfgfile *
 rte_cfgfile_load_with_params(const char *filename, int flags,
 			     const struct rte_cfgfile_parameters *params)
@@ -269,6 +272,7 @@ rte_cfgfile_load_with_params(const char *filename, int flags,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_create)
 struct rte_cfgfile *
 rte_cfgfile_create(int flags)
 {
@@ -325,6 +329,7 @@ rte_cfgfile_create(int flags)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_add_section)
 int
 rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
@@ -366,6 +371,7 @@ rte_cfgfile_add_section(struct rte_cfgfile *cfg, const char *sectionname)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_add_entry)
 int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 		const char *sectionname, const char *entryname,
 		const char *entryvalue)
@@ -390,6 +396,7 @@ int rte_cfgfile_add_entry(struct rte_cfgfile *cfg,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_set_entry)
 int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname, const char *entryvalue)
 {
@@ -418,6 +425,7 @@ int rte_cfgfile_set_entry(struct rte_cfgfile *cfg, const char *sectionname,
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_save)
 int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 {
 	int i, j;
@@ -442,6 +450,7 @@ int rte_cfgfile_save(struct rte_cfgfile *cfg, const char *filename)
 	return fclose(f);
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_close)
 int rte_cfgfile_close(struct rte_cfgfile *cfg)
 {
 	int i;
@@ -465,6 +474,7 @@ int rte_cfgfile_close(struct rte_cfgfile *cfg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections)
 int
 rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
 size_t length)
@@ -478,6 +488,7 @@ size_t length)
 	return num_sections;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_sections)
 int
 rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 	int max_sections)
@@ -490,12 +501,14 @@ rte_cfgfile_sections(struct rte_cfgfile *cfg, char *sections[],
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_has_section)
 int
 rte_cfgfile_has_section(struct rte_cfgfile *cfg, const char *sectionname)
 {
 	return _get_section(cfg, sectionname) != NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries)
 int
 rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	const char *sectionname)
@@ -506,6 +519,7 @@ rte_cfgfile_section_num_entries(struct rte_cfgfile *cfg,
 	return s->num_entries;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_num_entries_by_index)
 int
 rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	char *sectionname, int index)
@@ -518,6 +532,7 @@ rte_cfgfile_section_num_entries_by_index(struct rte_cfgfile *cfg,
 	strlcpy(sectionname, sect->name, CFG_NAME_LEN);
 	return sect->num_entries;
 }
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries)
 int
 rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 		struct rte_cfgfile_entry *entries, int max_entries)
@@ -531,6 +546,7 @@ rte_cfgfile_section_entries(struct rte_cfgfile *cfg, const char *sectionname,
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_section_entries_by_index)
 int
 rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 		char *sectionname,
@@ -548,6 +564,7 @@ rte_cfgfile_section_entries_by_index(struct rte_cfgfile *cfg, int index,
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_get_entry)
 const char *
 rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
@@ -563,6 +580,7 @@ rte_cfgfile_get_entry(struct rte_cfgfile *cfg, const char *sectionname,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cfgfile_has_entry)
 int
 rte_cfgfile_has_entry(struct rte_cfgfile *cfg, const char *sectionname,
 		const char *entryname)
diff --git a/lib/cmdline/cmdline.c b/lib/cmdline/cmdline.c
index 08721ee919..d1003f0b8e 100644
--- a/lib/cmdline/cmdline.c
+++ b/lib/cmdline/cmdline.c
@@ -11,6 +11,7 @@
 #include <stdarg.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "cmdline_private.h"
@@ -39,6 +40,7 @@ cmdline_complete_buffer(struct rdline *rdl, const char *buf,
 	return cmdline_complete(cl, buf, state, dstbuf, dstsize);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_write_char)
 int
 cmdline_write_char(struct rdline *rdl, char c)
 {
@@ -57,6 +59,7 @@ cmdline_write_char(struct rdline *rdl, char c)
 }
 
 
+RTE_EXPORT_SYMBOL(cmdline_set_prompt)
 void
 cmdline_set_prompt(struct cmdline *cl, const char *prompt)
 {
@@ -65,6 +68,7 @@ cmdline_set_prompt(struct cmdline *cl, const char *prompt)
 	strlcpy(cl->prompt, prompt, sizeof(cl->prompt));
 }
 
+RTE_EXPORT_SYMBOL(cmdline_new)
 struct cmdline *
 cmdline_new(cmdline_parse_ctx_t *ctx, const char *prompt, int s_in, int s_out)
 {
@@ -95,12 +99,14 @@ cmdline_new(cmdline_parse_ctx_t *ctx, const char *prompt, int s_in, int s_out)
 	return cl;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_get_rdline)
 struct rdline*
 cmdline_get_rdline(struct cmdline *cl)
 {
 	return &cl->rdl;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_free)
 void
 cmdline_free(struct cmdline *cl)
 {
@@ -116,6 +122,7 @@ cmdline_free(struct cmdline *cl)
 	free(cl);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_printf)
 void
 cmdline_printf(const struct cmdline *cl, const char *fmt, ...)
 {
@@ -131,6 +138,7 @@ cmdline_printf(const struct cmdline *cl, const char *fmt, ...)
 	va_end(ap);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_in)
 int
 cmdline_in(struct cmdline *cl, const char *buf, int size)
 {
@@ -168,6 +176,7 @@ cmdline_in(struct cmdline *cl, const char *buf, int size)
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_quit)
 void
 cmdline_quit(struct cmdline *cl)
 {
@@ -177,6 +186,7 @@ cmdline_quit(struct cmdline *cl)
 	rdline_quit(&cl->rdl);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_interact)
 void
 cmdline_interact(struct cmdline *cl)
 {
diff --git a/lib/cmdline/cmdline_cirbuf.c b/lib/cmdline/cmdline_cirbuf.c
index 829a8af563..07d9fc6b90 100644
--- a/lib/cmdline/cmdline_cirbuf.c
+++ b/lib/cmdline/cmdline_cirbuf.c
@@ -10,7 +10,10 @@
 
 #include "cmdline_cirbuf.h"
 
+#include <eal_export.h>
 
+
+RTE_EXPORT_SYMBOL(cirbuf_init)
 int
 cirbuf_init(struct cirbuf *cbuf, char *buf, unsigned int start, unsigned int maxlen)
 {
@@ -26,6 +29,7 @@ cirbuf_init(struct cirbuf *cbuf, char *buf, unsigned int start, unsigned int max
 
 /* multiple add */
 
+RTE_EXPORT_SYMBOL(cirbuf_add_buf_head)
 int
 cirbuf_add_buf_head(struct cirbuf *cbuf, const char *c, unsigned int n)
 {
@@ -57,6 +61,7 @@ cirbuf_add_buf_head(struct cirbuf *cbuf, const char *c, unsigned int n)
 
 /* multiple add */
 
+RTE_EXPORT_SYMBOL(cirbuf_add_buf_tail)
 int
 cirbuf_add_buf_tail(struct cirbuf *cbuf, const char *c, unsigned int n)
 {
@@ -100,6 +105,7 @@ __cirbuf_add_head(struct cirbuf * cbuf, char c)
 	cbuf->len ++;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_add_head_safe)
 int
 cirbuf_add_head_safe(struct cirbuf * cbuf, char c)
 {
@@ -110,6 +116,7 @@ cirbuf_add_head_safe(struct cirbuf * cbuf, char c)
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_add_head)
 void
 cirbuf_add_head(struct cirbuf * cbuf, char c)
 {
@@ -129,6 +136,7 @@ __cirbuf_add_tail(struct cirbuf * cbuf, char c)
 	cbuf->len ++;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_add_tail_safe)
 int
 cirbuf_add_tail_safe(struct cirbuf * cbuf, char c)
 {
@@ -139,6 +147,7 @@ cirbuf_add_tail_safe(struct cirbuf * cbuf, char c)
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_add_tail)
 void
 cirbuf_add_tail(struct cirbuf * cbuf, char c)
 {
@@ -181,6 +190,7 @@ __cirbuf_shift_right(struct cirbuf *cbuf)
 }
 
 /* XXX we could do a better algorithm here... */
+RTE_EXPORT_SYMBOL(cirbuf_align_left)
 int
 cirbuf_align_left(struct cirbuf * cbuf)
 {
@@ -202,6 +212,7 @@ cirbuf_align_left(struct cirbuf * cbuf)
 }
 
 /* XXX we could do a better algorithm here... */
+RTE_EXPORT_SYMBOL(cirbuf_align_right)
 int
 cirbuf_align_right(struct cirbuf * cbuf)
 {
@@ -224,6 +235,7 @@ cirbuf_align_right(struct cirbuf * cbuf)
 
 /* buffer del */
 
+RTE_EXPORT_SYMBOL(cirbuf_del_buf_head)
 int
 cirbuf_del_buf_head(struct cirbuf *cbuf, unsigned int size)
 {
@@ -244,6 +256,7 @@ cirbuf_del_buf_head(struct cirbuf *cbuf, unsigned int size)
 
 /* buffer del */
 
+RTE_EXPORT_SYMBOL(cirbuf_del_buf_tail)
 int
 cirbuf_del_buf_tail(struct cirbuf *cbuf, unsigned int size)
 {
@@ -274,6 +287,7 @@ __cirbuf_del_head(struct cirbuf * cbuf)
 	}
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_del_head_safe)
 int
 cirbuf_del_head_safe(struct cirbuf * cbuf)
 {
@@ -284,6 +298,7 @@ cirbuf_del_head_safe(struct cirbuf * cbuf)
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_del_head)
 void
 cirbuf_del_head(struct cirbuf * cbuf)
 {
@@ -302,6 +317,7 @@ __cirbuf_del_tail(struct cirbuf * cbuf)
 	}
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_del_tail_safe)
 int
 cirbuf_del_tail_safe(struct cirbuf * cbuf)
 {
@@ -312,6 +328,7 @@ cirbuf_del_tail_safe(struct cirbuf * cbuf)
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(cirbuf_del_tail)
 void
 cirbuf_del_tail(struct cirbuf * cbuf)
 {
@@ -320,6 +337,7 @@ cirbuf_del_tail(struct cirbuf * cbuf)
 
 /* convert to buffer */
 
+RTE_EXPORT_SYMBOL(cirbuf_get_buf_head)
 int
 cirbuf_get_buf_head(struct cirbuf *cbuf, char *c, unsigned int size)
 {
@@ -358,6 +376,7 @@ cirbuf_get_buf_head(struct cirbuf *cbuf, char *c, unsigned int size)
 
 /* convert to buffer */
 
+RTE_EXPORT_SYMBOL(cirbuf_get_buf_tail)
 int
 cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c, unsigned int size)
 {
@@ -397,6 +416,7 @@ cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c, unsigned int size)
 
 /* get head or get tail */
 
+RTE_EXPORT_SYMBOL(cirbuf_get_head)
 char
 cirbuf_get_head(struct cirbuf * cbuf)
 {
@@ -405,6 +425,7 @@ cirbuf_get_head(struct cirbuf * cbuf)
 
 /* get head or get tail */
 
+RTE_EXPORT_SYMBOL(cirbuf_get_tail)
 char
 cirbuf_get_tail(struct cirbuf * cbuf)
 {
diff --git a/lib/cmdline/cmdline_parse.c b/lib/cmdline/cmdline_parse.c
index 76a212d001..201fddb8c3 100644
--- a/lib/cmdline/cmdline_parse.c
+++ b/lib/cmdline/cmdline_parse.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "cmdline_private.h"
@@ -49,6 +50,7 @@ iscomment(char c)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_isendoftoken)
 int
 cmdline_isendoftoken(char c)
 {
@@ -296,18 +298,21 @@ __cmdline_parse(struct cmdline *cl, const char *buf, bool call_fn)
 	return linelen;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_parse)
 int
 cmdline_parse(struct cmdline *cl, const char *buf)
 {
 	return __cmdline_parse(cl, buf, true);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_parse_check)
 int
 cmdline_parse_check(struct cmdline *cl, const char *buf)
 {
 	return __cmdline_parse(cl, buf, false);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_complete)
 int
 cmdline_complete(struct cmdline *cl, const char *buf, int *state,
 		 char *dst, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
index aa7bf88d5a..e03cc3d545 100644
--- a/lib/cmdline/cmdline_parse_bool.c
+++ b/lib/cmdline/cmdline_parse_bool.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <string.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <stdlib.h>
 
@@ -13,6 +14,7 @@
 #include "cmdline_parse_bool.h"
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03)
 struct cmdline_token_ops cmdline_token_bool_ops = {
 	.parse = cmdline_parse_bool,
 	.complete_get_nb = NULL,
diff --git a/lib/cmdline/cmdline_parse_etheraddr.c b/lib/cmdline/cmdline_parse_etheraddr.c
index 433b828a72..7358572ba1 100644
--- a/lib/cmdline/cmdline_parse_etheraddr.c
+++ b/lib/cmdline/cmdline_parse_etheraddr.c
@@ -7,12 +7,14 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_ether.h>
 
 #include "cmdline_parse.h"
 #include "cmdline_parse_etheraddr.h"
 
+RTE_EXPORT_SYMBOL(cmdline_token_etheraddr_ops)
 struct cmdline_token_ops cmdline_token_etheraddr_ops = {
 	.parse = cmdline_parse_etheraddr,
 	.complete_get_nb = NULL,
@@ -20,6 +22,7 @@ struct cmdline_token_ops cmdline_token_etheraddr_ops = {
 	.get_help = cmdline_get_help_etheraddr,
 };
 
+RTE_EXPORT_SYMBOL(cmdline_parse_etheraddr)
 int
 cmdline_parse_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 	const char *buf, void *res, unsigned ressize)
@@ -51,6 +54,7 @@ cmdline_parse_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 	return token_len;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_get_help_etheraddr)
 int
 cmdline_get_help_etheraddr(__rte_unused cmdline_parse_token_hdr_t *tk,
 			       char *dstbuf, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_ipaddr.c b/lib/cmdline/cmdline_parse_ipaddr.c
index 5e278c963f..55522016c8 100644
--- a/lib/cmdline/cmdline_parse_ipaddr.c
+++ b/lib/cmdline/cmdline_parse_ipaddr.c
@@ -9,11 +9,13 @@
 #include <string.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "cmdline_parse.h"
 #include "cmdline_parse_ipaddr.h"
 
+RTE_EXPORT_SYMBOL(cmdline_token_ipaddr_ops)
 struct cmdline_token_ops cmdline_token_ipaddr_ops = {
 	.parse = cmdline_parse_ipaddr,
 	.complete_get_nb = NULL,
@@ -24,6 +26,7 @@ struct cmdline_token_ops cmdline_token_ipaddr_ops = {
 #define PREFIXMAX 128
 #define V4PREFIXMAX 32
 
+RTE_EXPORT_SYMBOL(cmdline_parse_ipaddr)
 int
 cmdline_parse_ipaddr(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	unsigned ressize)
@@ -90,6 +93,7 @@ cmdline_parse_ipaddr(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 
 }
 
+RTE_EXPORT_SYMBOL(cmdline_get_help_ipaddr)
 int cmdline_get_help_ipaddr(cmdline_parse_token_hdr_t *tk, char *dstbuf,
 			    unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index 6dc325e6da..f21796bedb 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -8,6 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <string.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <stdlib.h>
 
@@ -20,6 +21,7 @@
 #define debug_printf(...) do {} while (0)
 #endif
 
+RTE_EXPORT_SYMBOL(cmdline_token_num_ops)
 struct cmdline_token_ops cmdline_token_num_ops = {
 	.parse = cmdline_parse_num,
 	.complete_get_nb = NULL,
@@ -92,6 +94,7 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
 }
 
 /* parse an int */
+RTE_EXPORT_SYMBOL(cmdline_parse_num)
 int
 cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 	unsigned ressize)
@@ -313,6 +316,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 
 
 /* parse an int */
+RTE_EXPORT_SYMBOL(cmdline_get_help_num)
 int
 cmdline_get_help_num(cmdline_parse_token_hdr_t *tk, char *dstbuf, unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index 2e2294553a..ef6ce223b5 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -9,10 +9,12 @@
 #include <string.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include "cmdline_parse.h"
 #include "cmdline_parse_portlist.h"
 
+RTE_EXPORT_SYMBOL(cmdline_token_portlist_ops)
 struct cmdline_token_ops cmdline_token_portlist_ops = {
 	.parse = cmdline_parse_portlist,
 	.complete_get_nb = NULL,
@@ -68,6 +70,7 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_parse_portlist)
 int
 cmdline_parse_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 	const char *buf, void *res, unsigned ressize)
@@ -104,6 +107,7 @@ cmdline_parse_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 	return token_len;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_get_help_portlist)
 int
 cmdline_get_help_portlist(__rte_unused cmdline_parse_token_hdr_t *tk,
 		char *dstbuf, unsigned int size)
diff --git a/lib/cmdline/cmdline_parse_string.c b/lib/cmdline/cmdline_parse_string.c
index d756638905..731947159f 100644
--- a/lib/cmdline/cmdline_parse_string.c
+++ b/lib/cmdline/cmdline_parse_string.c
@@ -6,11 +6,13 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "cmdline_parse.h"
 #include "cmdline_parse_string.h"
 
+RTE_EXPORT_SYMBOL(cmdline_token_string_ops)
 struct cmdline_token_ops cmdline_token_string_ops = {
 	.parse = cmdline_parse_string,
 	.complete_get_nb = cmdline_complete_get_nb_string,
@@ -47,6 +49,7 @@ get_next_token(const char *s)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_parse_string)
 int
 cmdline_parse_string(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	unsigned ressize)
@@ -132,6 +135,7 @@ cmdline_parse_string(cmdline_parse_token_hdr_t *tk, const char *buf, void *res,
 	return token_len;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_complete_get_nb_string)
 int cmdline_complete_get_nb_string(cmdline_parse_token_hdr_t *tk)
 {
 	struct cmdline_token_string *tk2;
@@ -155,6 +159,7 @@ int cmdline_complete_get_nb_string(cmdline_parse_token_hdr_t *tk)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_complete_get_elt_string)
 int cmdline_complete_get_elt_string(cmdline_parse_token_hdr_t *tk, int idx,
 				    char *dstbuf, unsigned int size)
 {
@@ -187,6 +192,7 @@ int cmdline_complete_get_elt_string(cmdline_parse_token_hdr_t *tk, int idx,
 }
 
 
+RTE_EXPORT_SYMBOL(cmdline_get_help_string)
 int cmdline_get_help_string(cmdline_parse_token_hdr_t *tk, char *dstbuf,
 			    unsigned int size)
 {
diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 5cf723a012..3b8d435e98 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -14,6 +14,8 @@
 #include "cmdline_private.h"
 #include "cmdline_rdline.h"
 
+#include <eal_export.h>
+
 static void rdline_puts(struct rdline *rdl, const char *buf);
 static void rdline_miniprintf(struct rdline *rdl,
 			      const char *buf, unsigned int val);
@@ -52,6 +54,7 @@ rdline_init(struct rdline *rdl,
 	return cirbuf_init(&rdl->history, rdl->history_buf, 0, RDLINE_HISTORY_BUF_SIZE);
 }
 
+RTE_EXPORT_SYMBOL(rdline_new)
 struct rdline *
 rdline_new(rdline_write_char_t *write_char,
 	   rdline_validate_t *validate,
@@ -68,12 +71,14 @@ rdline_new(rdline_write_char_t *write_char,
 	return rdl;
 }
 
+RTE_EXPORT_SYMBOL(rdline_free)
 void
 rdline_free(struct rdline *rdl)
 {
 	free(rdl);
 }
 
+RTE_EXPORT_SYMBOL(rdline_newline)
 void
 rdline_newline(struct rdline *rdl, const char *prompt)
 {
@@ -98,6 +103,7 @@ rdline_newline(struct rdline *rdl, const char *prompt)
 	rdl->history_cur_line = -1;
 }
 
+RTE_EXPORT_SYMBOL(rdline_stop)
 void
 rdline_stop(struct rdline *rdl)
 {
@@ -106,6 +112,7 @@ rdline_stop(struct rdline *rdl)
 	rdl->status = RDLINE_INIT;
 }
 
+RTE_EXPORT_SYMBOL(rdline_quit)
 void
 rdline_quit(struct rdline *rdl)
 {
@@ -114,6 +121,7 @@ rdline_quit(struct rdline *rdl)
 	rdl->status = RDLINE_EXITED;
 }
 
+RTE_EXPORT_SYMBOL(rdline_restart)
 void
 rdline_restart(struct rdline *rdl)
 {
@@ -122,6 +130,7 @@ rdline_restart(struct rdline *rdl)
 	rdl->status = RDLINE_RUNNING;
 }
 
+RTE_EXPORT_SYMBOL(rdline_reset)
 void
 rdline_reset(struct rdline *rdl)
 {
@@ -136,6 +145,7 @@ rdline_reset(struct rdline *rdl)
 	rdl->history_cur_line = -1;
 }
 
+RTE_EXPORT_SYMBOL(rdline_get_buffer)
 const char *
 rdline_get_buffer(struct rdline *rdl)
 {
@@ -172,6 +182,7 @@ display_right_buffer(struct rdline *rdl, int force)
 				  CIRBUF_GET_LEN(&rdl->right));
 }
 
+RTE_EXPORT_SYMBOL(rdline_redisplay)
 void
 rdline_redisplay(struct rdline *rdl)
 {
@@ -190,6 +201,7 @@ rdline_redisplay(struct rdline *rdl)
 	display_right_buffer(rdl, 1);
 }
 
+RTE_EXPORT_SYMBOL(rdline_char_in)
 int
 rdline_char_in(struct rdline *rdl, char c)
 {
@@ -561,6 +573,7 @@ rdline_get_history_size(struct rdline * rdl)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rdline_get_history_item)
 char *
 rdline_get_history_item(struct rdline * rdl, unsigned int idx)
 {
@@ -587,18 +600,21 @@ rdline_get_history_item(struct rdline * rdl, unsigned int idx)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rdline_get_history_buffer_size)
 size_t
 rdline_get_history_buffer_size(struct rdline *rdl)
 {
 	return sizeof(rdl->history_buf);
 }
 
+RTE_EXPORT_SYMBOL(rdline_get_opaque)
 void *
 rdline_get_opaque(struct rdline *rdl)
 {
 	return rdl != NULL ? rdl->opaque : NULL;
 }
 
+RTE_EXPORT_SYMBOL(rdline_add_history)
 int
 rdline_add_history(struct rdline * rdl, const char * buf)
 {
@@ -628,6 +644,7 @@ rdline_add_history(struct rdline * rdl, const char * buf)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rdline_clear_history)
 void
 rdline_clear_history(struct rdline * rdl)
 {
diff --git a/lib/cmdline/cmdline_socket.c b/lib/cmdline/cmdline_socket.c
index 78fb67c474..f3d62acdae 100644
--- a/lib/cmdline/cmdline_socket.c
+++ b/lib/cmdline/cmdline_socket.c
@@ -12,6 +12,9 @@
 #include "cmdline_private.h"
 #include "cmdline_socket.h"
 
+#include <eal_export.h>
+
+RTE_EXPORT_SYMBOL(cmdline_file_new)
 struct cmdline *
 cmdline_file_new(cmdline_parse_ctx_t *ctx, const char *prompt, const char *path)
 {
@@ -29,6 +32,7 @@ cmdline_file_new(cmdline_parse_ctx_t *ctx, const char *prompt, const char *path)
 	return cmdline_new(ctx, prompt, fd, -1);
 }
 
+RTE_EXPORT_SYMBOL(cmdline_stdin_new)
 struct cmdline *
 cmdline_stdin_new(cmdline_parse_ctx_t *ctx, const char *prompt)
 {
@@ -42,6 +46,7 @@ cmdline_stdin_new(cmdline_parse_ctx_t *ctx, const char *prompt)
 	return cl;
 }
 
+RTE_EXPORT_SYMBOL(cmdline_stdin_exit)
 void
 cmdline_stdin_exit(struct cmdline *cl)
 {
diff --git a/lib/cmdline/cmdline_vt100.c b/lib/cmdline/cmdline_vt100.c
index 4c9a46c953..272088a0c6 100644
--- a/lib/cmdline/cmdline_vt100.c
+++ b/lib/cmdline/cmdline_vt100.c
@@ -10,6 +10,8 @@
 
 #include "cmdline_vt100.h"
 
+#include <eal_export.h>
+
 const char *cmdline_vt100_commands[] = {
 	vt100_up_arr,
 	vt100_down_arr,
@@ -40,6 +42,7 @@ const char *cmdline_vt100_commands[] = {
 	vt100_bs,
 };
 
+RTE_EXPORT_SYMBOL(vt100_init)
 void
 vt100_init(struct cmdline_vt100 *vt)
 {
@@ -69,6 +72,7 @@ match_command(char *buf, unsigned int size)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(vt100_parser)
 int
 vt100_parser(struct cmdline_vt100 *vt, char ch)
 {
diff --git a/lib/compressdev/rte_comp.c b/lib/compressdev/rte_comp.c
index f060c68557..662691796a 100644
--- a/lib/compressdev/rte_comp.c
+++ b/lib/compressdev/rte_comp.c
@@ -2,9 +2,11 @@
  * Copyright(c) 2017-2018 Intel Corporation
  */
 
+#include <eal_export.h>
 #include "rte_comp.h"
 #include "rte_compressdev_internal.h"
 
+RTE_EXPORT_SYMBOL(rte_comp_get_feature_name)
 const char *
 rte_comp_get_feature_name(uint64_t flag)
 {
@@ -123,6 +125,7 @@ rte_comp_op_init(struct rte_mempool *mempool,
 	op->mempool = mempool;
 }
 
+RTE_EXPORT_SYMBOL(rte_comp_op_pool_create)
 struct rte_mempool *
 rte_comp_op_pool_create(const char *name,
 		unsigned int nb_elts, unsigned int cache_size,
@@ -178,6 +181,7 @@ rte_comp_op_pool_create(const char *name,
 	return mp;
 }
 
+RTE_EXPORT_SYMBOL(rte_comp_op_alloc)
 struct rte_comp_op *
 rte_comp_op_alloc(struct rte_mempool *mempool)
 {
@@ -193,6 +197,7 @@ rte_comp_op_alloc(struct rte_mempool *mempool)
 	return op;
 }
 
+RTE_EXPORT_SYMBOL(rte_comp_op_bulk_alloc)
 int
 rte_comp_op_bulk_alloc(struct rte_mempool *mempool,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -218,6 +223,7 @@ rte_comp_op_bulk_alloc(struct rte_mempool *mempool,
  * @param op
  *   Compress operation
  */
+RTE_EXPORT_SYMBOL(rte_comp_op_free)
 void
 rte_comp_op_free(struct rte_comp_op *op)
 {
@@ -225,6 +231,7 @@ rte_comp_op_free(struct rte_comp_op *op)
 		rte_mempool_put(op->mempool, op);
 }
 
+RTE_EXPORT_SYMBOL(rte_comp_op_bulk_free)
 void
 rte_comp_op_bulk_free(struct rte_comp_op **ops, uint16_t nb_ops)
 {
diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index 5bc7ea5250..33de3f511b 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
 #include <dev_driver.h>
@@ -28,6 +29,7 @@ static struct rte_compressdev_global compressdev_globals = {
 		.max_devs		= RTE_COMPRESS_MAX_DEVS
 };
 
+RTE_EXPORT_SYMBOL(rte_compressdev_capability_get)
 const struct rte_compressdev_capabilities *
 rte_compressdev_capability_get(uint8_t dev_id,
 			enum rte_comp_algorithm algo)
@@ -51,6 +53,7 @@ rte_compressdev_capability_get(uint8_t dev_id,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_get_feature_name)
 const char *
 rte_compressdev_get_feature_name(uint64_t flag)
 {
@@ -80,6 +83,7 @@ rte_compressdev_get_dev(uint8_t dev_id)
 	return &compressdev_globals.devs[dev_id];
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_get_named_dev)
 struct rte_compressdev *
 rte_compressdev_pmd_get_named_dev(const char *name)
 {
@@ -116,6 +120,7 @@ rte_compressdev_is_valid_dev(uint8_t dev_id)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_compressdev_get_dev_id)
 int
 rte_compressdev_get_dev_id(const char *name)
 {
@@ -134,12 +139,14 @@ rte_compressdev_get_dev_id(const char *name)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_count)
 uint8_t
 rte_compressdev_count(void)
 {
 	return compressdev_globals.nb_devs;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_devices_get)
 uint8_t
 rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 	uint8_t nb_devices)
@@ -165,6 +172,7 @@ rte_compressdev_devices_get(const char *driver_name, uint8_t *devices,
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_socket_id)
 int
 rte_compressdev_socket_id(uint8_t dev_id)
 {
@@ -222,6 +230,7 @@ rte_compressdev_find_free_device_index(void)
 	return RTE_COMPRESS_MAX_DEVS;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_allocate)
 struct rte_compressdev *
 rte_compressdev_pmd_allocate(const char *name, int socket_id)
 {
@@ -268,6 +277,7 @@ rte_compressdev_pmd_allocate(const char *name, int socket_id)
 	return compressdev;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_release_device)
 int
 rte_compressdev_pmd_release_device(struct rte_compressdev *compressdev)
 {
@@ -288,6 +298,7 @@ rte_compressdev_pmd_release_device(struct rte_compressdev *compressdev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_count)
 uint16_t
 rte_compressdev_queue_pair_count(uint8_t dev_id)
 {
@@ -413,6 +424,7 @@ rte_compressdev_queue_pairs_release(struct rte_compressdev *dev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_configure)
 int
 rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 {
@@ -448,6 +460,7 @@ rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_start)
 int
 rte_compressdev_start(uint8_t dev_id)
 {
@@ -481,6 +494,7 @@ rte_compressdev_start(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_stop)
 void
 rte_compressdev_stop(uint8_t dev_id)
 {
@@ -506,6 +520,7 @@ rte_compressdev_stop(uint8_t dev_id)
 	dev->data->dev_started = 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_close)
 int
 rte_compressdev_close(uint8_t dev_id)
 {
@@ -542,6 +557,7 @@ rte_compressdev_close(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_queue_pair_setup)
 int
 rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		uint32_t max_inflight_ops, int socket_id)
@@ -577,6 +593,7 @@ rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, max_inflight_ops, socket_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_dequeue_burst)
 uint16_t
 rte_compressdev_dequeue_burst(uint8_t dev_id, uint16_t qp_id,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -586,6 +603,7 @@ rte_compressdev_dequeue_burst(uint8_t dev_id, uint16_t qp_id,
 	return dev->dequeue_burst(dev->data->queue_pairs[qp_id], ops, nb_ops);
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_enqueue_burst)
 uint16_t
 rte_compressdev_enqueue_burst(uint8_t dev_id, uint16_t qp_id,
 		struct rte_comp_op **ops, uint16_t nb_ops)
@@ -595,6 +613,7 @@ rte_compressdev_enqueue_burst(uint8_t dev_id, uint16_t qp_id,
 	return dev->enqueue_burst(dev->data->queue_pairs[qp_id], ops, nb_ops);
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_stats_get)
 int
 rte_compressdev_stats_get(uint8_t dev_id, struct rte_compressdev_stats *stats)
 {
@@ -619,6 +638,7 @@ rte_compressdev_stats_get(uint8_t dev_id, struct rte_compressdev_stats *stats)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_stats_reset)
 void
 rte_compressdev_stats_reset(uint8_t dev_id)
 {
@@ -637,6 +657,7 @@ rte_compressdev_stats_reset(uint8_t dev_id)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_compressdev_info_get)
 void
 rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 {
@@ -658,6 +679,7 @@ rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 	dev_info->driver_name = dev->device->driver->name;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_create)
 int
 rte_compressdev_private_xform_create(uint8_t dev_id,
 		const struct rte_comp_xform *xform,
@@ -684,6 +706,7 @@ rte_compressdev_private_xform_create(uint8_t dev_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_private_xform_free)
 int
 rte_compressdev_private_xform_free(uint8_t dev_id, void *priv_xform)
 {
@@ -708,6 +731,7 @@ rte_compressdev_private_xform_free(uint8_t dev_id, void *priv_xform)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_stream_create)
 int
 rte_compressdev_stream_create(uint8_t dev_id,
 		const struct rte_comp_xform *xform,
@@ -735,6 +759,7 @@ rte_compressdev_stream_create(uint8_t dev_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_compressdev_stream_free)
 int
 rte_compressdev_stream_free(uint8_t dev_id, void *stream)
 {
@@ -759,6 +784,7 @@ rte_compressdev_stream_free(uint8_t dev_id, void *stream)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_name_get)
 const char *
 rte_compressdev_name_get(uint8_t dev_id)
 {
diff --git a/lib/compressdev/rte_compressdev_pmd.c b/lib/compressdev/rte_compressdev_pmd.c
index 762b44f03e..7e11ad7148 100644
--- a/lib/compressdev/rte_compressdev_pmd.c
+++ b/lib/compressdev/rte_compressdev_pmd.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
 #include <rte_kvargs.h>
@@ -55,6 +56,7 @@ rte_compressdev_pmd_parse_uint_arg(const char *key __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_parse_input_args)
 int
 rte_compressdev_pmd_parse_input_args(
 		struct rte_compressdev_pmd_init_params *params,
@@ -91,6 +93,7 @@ rte_compressdev_pmd_parse_input_args(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_create)
 struct rte_compressdev *
 rte_compressdev_pmd_create(const char *name,
 		struct rte_device *device,
@@ -140,6 +143,7 @@ rte_compressdev_pmd_create(const char *name,
 	return compressdev;
 }
 
+RTE_EXPORT_SYMBOL(rte_compressdev_pmd_destroy)
 int
 rte_compressdev_pmd_destroy(struct rte_compressdev *compressdev)
 {
diff --git a/lib/cryptodev/cryptodev_pmd.c b/lib/cryptodev/cryptodev_pmd.c
index 87ced122b4..d79d561bf6 100644
--- a/lib/cryptodev/cryptodev_pmd.c
+++ b/lib/cryptodev/cryptodev_pmd.c
@@ -6,6 +6,7 @@
 #include <sys/queue.h>
 
 #include <dev_driver.h>
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
@@ -55,6 +56,7 @@ rte_cryptodev_pmd_parse_uint_arg(const char *key __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_parse_input_args)
 int
 rte_cryptodev_pmd_parse_input_args(
 		struct rte_cryptodev_pmd_init_params *params,
@@ -98,6 +100,7 @@ rte_cryptodev_pmd_parse_input_args(
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create)
 struct rte_cryptodev *
 rte_cryptodev_pmd_create(const char *name,
 		struct rte_device *device,
@@ -148,6 +151,7 @@ rte_cryptodev_pmd_create(const char *name,
 	return cryptodev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_destroy)
 int
 rte_cryptodev_pmd_destroy(struct rte_cryptodev *cryptodev)
 {
@@ -171,6 +175,7 @@ rte_cryptodev_pmd_destroy(struct rte_cryptodev *cryptodev)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_probing_finish)
 void
 rte_cryptodev_pmd_probing_finish(struct rte_cryptodev *cryptodev)
 {
@@ -209,6 +214,7 @@ dummy_crypto_dequeue_burst(__rte_unused void *qp,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_reset)
 void
 cryptodev_fp_ops_reset(struct rte_crypto_fp_ops *fp_ops)
 {
@@ -227,6 +233,7 @@ cryptodev_fp_ops_reset(struct rte_crypto_fp_ops *fp_ops)
 	*fp_ops = dummy;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(cryptodev_fp_ops_set)
 void
 cryptodev_fp_ops_set(struct rte_crypto_fp_ops *fp_ops,
 		     const struct rte_cryptodev *dev)
@@ -239,6 +246,7 @@ cryptodev_fp_ops_set(struct rte_crypto_fp_ops *fp_ops,
 	fp_ops->qp_depth_used = dev->qp_depth_used;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_session_event_mdata_get)
 void *
 rte_cryptodev_session_event_mdata_get(struct rte_crypto_op *op)
 {
diff --git a/lib/cryptodev/cryptodev_trace_points.c b/lib/cryptodev/cryptodev_trace_points.c
index 6f37780595..69737adcbe 100644
--- a/lib/cryptodev/cryptodev_trace_points.c
+++ b/lib/cryptodev/cryptodev_trace_points.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include "cryptodev_trace.h"
@@ -42,9 +43,11 @@ RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_sym_session_free,
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_asym_session_free,
 	lib.cryptodev.asym.free)
 
+RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_enqueue_burst)
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_enqueue_burst,
 	lib.cryptodev.enq.burst)
 
+RTE_EXPORT_SYMBOL(__rte_cryptodev_trace_dequeue_burst)
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_dequeue_burst,
 	lib.cryptodev.deq.burst)
 
@@ -198,5 +201,6 @@ RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_op_pool_create,
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_count,
 	lib.cryptodev.count)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_cryptodev_trace_qp_depth_used, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_cryptodev_trace_qp_depth_used,
 	lib.cryptodev.qp_depth_used)
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 57b0e4ce14..bb7bab4dd5 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -11,6 +11,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <dev_driver.h>
@@ -35,6 +36,7 @@ static uint8_t nb_drivers;
 
 static struct rte_cryptodev rte_crypto_devices[RTE_CRYPTO_MAX_DEVS];
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodevs)
 struct rte_cryptodev *rte_cryptodevs = rte_crypto_devices;
 
 static struct rte_cryptodev_global cryptodev_globals = {
@@ -44,11 +46,13 @@ static struct rte_cryptodev_global cryptodev_globals = {
 };
 
 /* Public fastpath APIs. */
+RTE_EXPORT_SYMBOL(rte_crypto_fp_ops)
 struct rte_crypto_fp_ops rte_crypto_fp_ops[RTE_CRYPTO_MAX_DEVS];
 
 /* spinlock for crypto device callbacks */
 static rte_spinlock_t rte_cryptodev_cb_lock = RTE_SPINLOCK_INITIALIZER;
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_cryptodev_logtype, INFO);
 
 /**
@@ -105,6 +109,7 @@ crypto_cipher_algorithm_strings[] = {
  * The crypto cipher operation strings identifiers.
  * It could be used in application command line.
  */
+RTE_EXPORT_SYMBOL(rte_crypto_cipher_operation_strings)
 const char *
 rte_crypto_cipher_operation_strings[] = {
 		[RTE_CRYPTO_CIPHER_OP_ENCRYPT]	= "encrypt",
@@ -177,6 +182,7 @@ crypto_aead_algorithm_strings[] = {
  * The crypto AEAD operation strings identifiers.
  * It could be used in application command line.
  */
+RTE_EXPORT_SYMBOL(rte_crypto_aead_operation_strings)
 const char *
 rte_crypto_aead_operation_strings[] = {
 	[RTE_CRYPTO_AEAD_OP_ENCRYPT]	= "encrypt",
@@ -204,6 +210,7 @@ crypto_asym_xform_strings[] = {
 /**
  * Asymmetric crypto operation strings identifiers.
  */
+RTE_EXPORT_SYMBOL(rte_crypto_asym_op_strings)
 const char *rte_crypto_asym_op_strings[] = {
 	[RTE_CRYPTO_ASYM_OP_ENCRYPT]	= "encrypt",
 	[RTE_CRYPTO_ASYM_OP_DECRYPT]	= "decrypt",
@@ -214,6 +221,7 @@ const char *rte_crypto_asym_op_strings[] = {
 /**
  * Asymmetric crypto key exchange operation strings identifiers.
  */
+RTE_EXPORT_SYMBOL(rte_crypto_asym_ke_strings)
 const char *rte_crypto_asym_ke_strings[] = {
 	[RTE_CRYPTO_ASYM_KE_PRIV_KEY_GENERATE] = "priv_key_generate",
 	[RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE] = "pub_key_generate",
@@ -238,6 +246,7 @@ struct rte_cryptodev_asym_session_pool_private_data {
 	/**< Session user data will be placed after sess_private_data */
 };
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_cipher_algo_enum)
 int
 rte_cryptodev_get_cipher_algo_enum(enum rte_crypto_cipher_algorithm *algo_enum,
 		const char *algo_string)
@@ -258,6 +267,7 @@ rte_cryptodev_get_cipher_algo_enum(enum rte_crypto_cipher_algorithm *algo_enum,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_auth_algo_enum)
 int
 rte_cryptodev_get_auth_algo_enum(enum rte_crypto_auth_algorithm *algo_enum,
 		const char *algo_string)
@@ -278,6 +288,7 @@ rte_cryptodev_get_auth_algo_enum(enum rte_crypto_auth_algorithm *algo_enum,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_aead_algo_enum)
 int
 rte_cryptodev_get_aead_algo_enum(enum rte_crypto_aead_algorithm *algo_enum,
 		const char *algo_string)
@@ -298,6 +309,7 @@ rte_cryptodev_get_aead_algo_enum(enum rte_crypto_aead_algorithm *algo_enum,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_xform_enum)
 int
 rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
 		const char *xform_string)
@@ -319,6 +331,7 @@ rte_cryptodev_asym_get_xform_enum(enum rte_crypto_asym_xform_type *xform_enum,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_cipher_algo_string, 23.03)
 const char *
 rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 {
@@ -332,6 +345,7 @@ rte_cryptodev_get_cipher_algo_string(enum rte_crypto_cipher_algorithm algo_enum)
 	return alg_str;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_auth_algo_string, 23.03)
 const char *
 rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 {
@@ -345,6 +359,7 @@ rte_cryptodev_get_auth_algo_string(enum rte_crypto_auth_algorithm algo_enum)
 	return alg_str;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_get_aead_algo_string, 23.03)
 const char *
 rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 {
@@ -358,6 +373,7 @@ rte_cryptodev_get_aead_algo_string(enum rte_crypto_aead_algorithm algo_enum)
 	return alg_str;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_get_xform_string, 23.03)
 const char *
 rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum)
 {
@@ -375,12 +391,14 @@ rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum)
  * The crypto auth operation strings identifiers.
  * It could be used in application command line.
  */
+RTE_EXPORT_SYMBOL(rte_crypto_auth_operation_strings)
 const char *
 rte_crypto_auth_operation_strings[] = {
 		[RTE_CRYPTO_AUTH_OP_VERIFY]	= "verify",
 		[RTE_CRYPTO_AUTH_OP_GENERATE]	= "generate"
 };
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_get)
 const struct rte_cryptodev_symmetric_capability *
 rte_cryptodev_sym_capability_get(uint8_t dev_id,
 		const struct rte_cryptodev_sym_capability_idx *idx)
@@ -450,6 +468,7 @@ param_range_check(uint16_t size, const struct rte_crypto_param_range *range)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_capability_get)
 const struct rte_cryptodev_asymmetric_xform_capability *
 rte_cryptodev_asym_capability_get(uint8_t dev_id,
 		const struct rte_cryptodev_asym_capability_idx *idx)
@@ -479,6 +498,7 @@ rte_cryptodev_asym_capability_get(uint8_t dev_id,
 	return asym_cap;
 };
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_cipher)
 int
 rte_cryptodev_sym_capability_check_cipher(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -501,6 +521,7 @@ rte_cryptodev_sym_capability_check_cipher(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_auth)
 int
 rte_cryptodev_sym_capability_check_auth(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -529,6 +550,7 @@ rte_cryptodev_sym_capability_check_auth(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_capability_check_aead)
 int
 rte_cryptodev_sym_capability_check_aead(
 		const struct rte_cryptodev_symmetric_capability *capability,
@@ -563,6 +585,7 @@ rte_cryptodev_sym_capability_check_aead(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_optype)
 int
 rte_cryptodev_asym_xform_capability_check_optype(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -579,6 +602,7 @@ rte_cryptodev_asym_xform_capability_check_optype(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_modlen)
 int
 rte_cryptodev_asym_xform_capability_check_modlen(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -614,6 +638,7 @@ rte_cryptodev_asym_xform_capability_check_modlen(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_xform_capability_check_hash)
 bool
 rte_cryptodev_asym_xform_capability_check_hash(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -630,6 +655,7 @@ rte_cryptodev_asym_xform_capability_check_hash(
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_asym_xform_capability_check_opcap, 24.11)
 int
 rte_cryptodev_asym_xform_capability_check_opcap(
 	const struct rte_cryptodev_asymmetric_xform_capability *capability,
@@ -763,6 +789,7 @@ cryptodev_cb_init(struct rte_cryptodev *dev)
 	return -ENOMEM;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_feature_name)
 const char *
 rte_cryptodev_get_feature_name(uint64_t flag)
 {
@@ -826,12 +853,14 @@ rte_cryptodev_get_feature_name(uint64_t flag)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_dev)
 struct rte_cryptodev *
 rte_cryptodev_pmd_get_dev(uint8_t dev_id)
 {
 	return &cryptodev_globals.devs[dev_id];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_get_named_dev)
 struct rte_cryptodev *
 rte_cryptodev_pmd_get_named_dev(const char *name)
 {
@@ -862,6 +891,7 @@ rte_cryptodev_is_valid_device_data(uint8_t dev_id)
 	return 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_is_valid_dev)
 unsigned int
 rte_cryptodev_is_valid_dev(uint8_t dev_id)
 {
@@ -883,6 +913,7 @@ rte_cryptodev_is_valid_dev(uint8_t dev_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_dev_id)
 int
 rte_cryptodev_get_dev_id(const char *name)
 {
@@ -909,6 +940,7 @@ rte_cryptodev_get_dev_id(const char *name)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_count)
 uint8_t
 rte_cryptodev_count(void)
 {
@@ -917,6 +949,7 @@ rte_cryptodev_count(void)
 	return cryptodev_globals.nb_devs;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_device_count_by_driver)
 uint8_t
 rte_cryptodev_device_count_by_driver(uint8_t driver_id)
 {
@@ -933,6 +966,7 @@ rte_cryptodev_device_count_by_driver(uint8_t driver_id)
 	return dev_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_devices_get)
 uint8_t
 rte_cryptodev_devices_get(const char *driver_name, uint8_t *devices,
 	uint8_t nb_devices)
@@ -961,6 +995,7 @@ rte_cryptodev_devices_get(const char *driver_name, uint8_t *devices,
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_sec_ctx)
 void *
 rte_cryptodev_get_sec_ctx(uint8_t dev_id)
 {
@@ -976,6 +1011,7 @@ rte_cryptodev_get_sec_ctx(uint8_t dev_id)
 	return sec_ctx;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_socket_id)
 int
 rte_cryptodev_socket_id(uint8_t dev_id)
 {
@@ -1070,6 +1106,7 @@ rte_cryptodev_find_free_device_index(void)
 	return RTE_CRYPTO_MAX_DEVS;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
 struct rte_cryptodev *
 rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 {
@@ -1129,6 +1166,7 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 	return cryptodev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_release_device)
 int
 rte_cryptodev_pmd_release_device(struct rte_cryptodev *cryptodev)
 {
@@ -1158,6 +1196,7 @@ rte_cryptodev_pmd_release_device(struct rte_cryptodev *cryptodev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_count)
 uint16_t
 rte_cryptodev_queue_pair_count(uint8_t dev_id)
 {
@@ -1240,6 +1279,7 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_reset, 24.11)
 int
 rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
@@ -1264,6 +1304,7 @@ rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_reset(dev, queue_pair_id, qp_conf, socket_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_configure)
 int
 rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 {
@@ -1311,6 +1352,7 @@ rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_start)
 int
 rte_cryptodev_start(uint8_t dev_id)
 {
@@ -1348,6 +1390,7 @@ rte_cryptodev_start(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_stop)
 void
 rte_cryptodev_stop(uint8_t dev_id)
 {
@@ -1377,6 +1420,7 @@ rte_cryptodev_stop(uint8_t dev_id)
 	dev->data->dev_started = 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_close)
 int
 rte_cryptodev_close(uint8_t dev_id)
 {
@@ -1419,6 +1463,7 @@ rte_cryptodev_close(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_qp_status)
 int
 rte_cryptodev_get_qp_status(uint8_t dev_id, uint16_t queue_pair_id)
 {
@@ -1473,6 +1518,7 @@ rte_cryptodev_sym_is_valid_session_pool(struct rte_mempool *mp,
 	return 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_queue_pair_setup)
 int
 rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		const struct rte_cryptodev_qp_conf *qp_conf, int socket_id)
@@ -1526,6 +1572,7 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_add_enq_callback)
 struct rte_cryptodev_cb *
 rte_cryptodev_add_enq_callback(uint8_t dev_id,
 			       uint16_t qp_id,
@@ -1596,6 +1643,7 @@ rte_cryptodev_add_enq_callback(uint8_t dev_id,
 	return cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_remove_enq_callback)
 int
 rte_cryptodev_remove_enq_callback(uint8_t dev_id,
 				  uint16_t qp_id,
@@ -1672,6 +1720,7 @@ rte_cryptodev_remove_enq_callback(uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_add_deq_callback)
 struct rte_cryptodev_cb *
 rte_cryptodev_add_deq_callback(uint8_t dev_id,
 			       uint16_t qp_id,
@@ -1743,6 +1792,7 @@ rte_cryptodev_add_deq_callback(uint8_t dev_id,
 	return cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_remove_deq_callback)
 int
 rte_cryptodev_remove_deq_callback(uint8_t dev_id,
 				  uint16_t qp_id,
@@ -1819,6 +1869,7 @@ rte_cryptodev_remove_deq_callback(uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_stats_get)
 int
 rte_cryptodev_stats_get(uint8_t dev_id, struct rte_cryptodev_stats *stats)
 {
@@ -1845,6 +1896,7 @@ rte_cryptodev_stats_get(uint8_t dev_id, struct rte_cryptodev_stats *stats)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_stats_reset)
 void
 rte_cryptodev_stats_reset(uint8_t dev_id)
 {
@@ -1864,6 +1916,7 @@ rte_cryptodev_stats_reset(uint8_t dev_id)
 	dev->dev_ops->stats_reset(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_info_get)
 void
 rte_cryptodev_info_get(uint8_t dev_id, struct rte_cryptodev_info *dev_info)
 {
@@ -1889,6 +1942,7 @@ rte_cryptodev_info_get(uint8_t dev_id, struct rte_cryptodev_info *dev_info)
 
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_callback_register)
 int
 rte_cryptodev_callback_register(uint8_t dev_id,
 			enum rte_cryptodev_event_type event,
@@ -1934,6 +1988,7 @@ rte_cryptodev_callback_register(uint8_t dev_id,
 	return (user_cb == NULL) ? -ENOMEM : 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_callback_unregister)
 int
 rte_cryptodev_callback_unregister(uint8_t dev_id,
 			enum rte_cryptodev_event_type event,
@@ -1982,6 +2037,7 @@ rte_cryptodev_callback_unregister(uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_callback_process)
 void
 rte_cryptodev_pmd_callback_process(struct rte_cryptodev *dev,
 	enum rte_cryptodev_event_type event)
@@ -2004,6 +2060,7 @@ rte_cryptodev_pmd_callback_process(struct rte_cryptodev *dev,
 	rte_spinlock_unlock(&rte_cryptodev_cb_lock);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cryptodev_queue_pair_event_error_query, 23.03)
 int
 rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id)
 {
@@ -2023,6 +2080,7 @@ rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id)
 	return dev->dev_ops->queue_pair_event_error_query(dev, qp_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_pool_create)
 struct rte_mempool *
 rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t elt_size, uint32_t cache_size, uint16_t user_data_size,
@@ -2061,6 +2119,7 @@ rte_cryptodev_sym_session_pool_create(const char *name, uint32_t nb_elts,
 	return mp;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_pool_create)
 struct rte_mempool *
 rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
 	uint32_t cache_size, uint16_t user_data_size, int socket_id)
@@ -2111,6 +2170,7 @@ rte_cryptodev_asym_session_pool_create(const char *name, uint32_t nb_elts,
 	return mp;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_create)
 void *
 rte_cryptodev_sym_session_create(uint8_t dev_id,
 		struct rte_crypto_sym_xform *xforms,
@@ -2178,6 +2238,7 @@ rte_cryptodev_sym_session_create(uint8_t dev_id,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_create)
 int
 rte_cryptodev_asym_session_create(uint8_t dev_id,
 		struct rte_crypto_asym_xform *xforms, struct rte_mempool *mp,
@@ -2254,6 +2315,7 @@ rte_cryptodev_asym_session_create(uint8_t dev_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_free)
 int
 rte_cryptodev_sym_session_free(uint8_t dev_id, void *_sess)
 {
@@ -2300,6 +2362,7 @@ rte_cryptodev_sym_session_free(uint8_t dev_id, void *_sess)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_free)
 int
 rte_cryptodev_asym_session_free(uint8_t dev_id, void *sess)
 {
@@ -2331,12 +2394,14 @@ rte_cryptodev_asym_session_free(uint8_t dev_id, void *sess)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_header_session_size)
 unsigned int
 rte_cryptodev_asym_get_header_session_size(void)
 {
 	return sizeof(struct rte_cryptodev_asym_session);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_get_private_session_size)
 unsigned int
 rte_cryptodev_sym_get_private_session_size(uint8_t dev_id)
 {
@@ -2359,6 +2424,7 @@ rte_cryptodev_sym_get_private_session_size(uint8_t dev_id)
 	return priv_sess_size;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_get_private_session_size)
 unsigned int
 rte_cryptodev_asym_get_private_session_size(uint8_t dev_id)
 {
@@ -2381,6 +2447,7 @@ rte_cryptodev_asym_get_private_session_size(uint8_t dev_id)
 	return priv_sess_size;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_set_user_data)
 int
 rte_cryptodev_sym_session_set_user_data(void *_sess, void *data,
 		uint16_t size)
@@ -2400,6 +2467,7 @@ rte_cryptodev_sym_session_set_user_data(void *_sess, void *data,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_session_get_user_data)
 void *
 rte_cryptodev_sym_session_get_user_data(void *_sess)
 {
@@ -2416,6 +2484,7 @@ rte_cryptodev_sym_session_get_user_data(void *_sess)
 	return data;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_set_user_data)
 int
 rte_cryptodev_asym_session_set_user_data(void *session, void *data, uint16_t size)
 {
@@ -2435,6 +2504,7 @@ rte_cryptodev_asym_session_set_user_data(void *session, void *data, uint16_t siz
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_asym_session_get_user_data)
 void *
 rte_cryptodev_asym_session_get_user_data(void *session)
 {
@@ -2459,6 +2529,7 @@ sym_crypto_fill_status(struct rte_crypto_sym_vec *vec, int32_t errnum)
 		vec->status[i] = errnum;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_sym_cpu_crypto_process)
 uint32_t
 rte_cryptodev_sym_cpu_crypto_process(uint8_t dev_id,
 	void *_sess, union rte_crypto_sym_ofs ofs,
@@ -2485,6 +2556,7 @@ rte_cryptodev_sym_cpu_crypto_process(uint8_t dev_id,
 	return dev->dev_ops->sym_cpu_process(dev, sess, ofs, vec);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_get_raw_dp_ctx_size)
 int
 rte_cryptodev_get_raw_dp_ctx_size(uint8_t dev_id)
 {
@@ -2511,6 +2583,7 @@ rte_cryptodev_get_raw_dp_ctx_size(uint8_t dev_id)
 	return RTE_ALIGN_CEIL((size + priv_size), 8);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_configure_raw_dp_ctx)
 int
 rte_cryptodev_configure_raw_dp_ctx(uint8_t dev_id, uint16_t qp_id,
 	struct rte_crypto_raw_dp_ctx *ctx,
@@ -2534,6 +2607,7 @@ rte_cryptodev_configure_raw_dp_ctx(uint8_t dev_id, uint16_t qp_id,
 			sess_type, session_ctx, is_update);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_session_event_mdata_set)
 int
 rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 	enum rte_crypto_op_type op_type,
@@ -2577,6 +2651,7 @@ rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 		return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_burst)
 uint32_t
 rte_cryptodev_raw_enqueue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 	struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs ofs,
@@ -2586,6 +2661,7 @@ rte_cryptodev_raw_enqueue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 			ofs, user_data, enqueue_status);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_enqueue_done)
 int
 rte_cryptodev_raw_enqueue_done(struct rte_crypto_raw_dp_ctx *ctx,
 		uint32_t n)
@@ -2593,6 +2669,7 @@ rte_cryptodev_raw_enqueue_done(struct rte_crypto_raw_dp_ctx *ctx,
 	return ctx->enqueue_done(ctx->qp_data, ctx->drv_ctx_data, n);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_burst)
 uint32_t
 rte_cryptodev_raw_dequeue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 	rte_cryptodev_raw_get_dequeue_count_t get_dequeue_count,
@@ -2606,6 +2683,7 @@ rte_cryptodev_raw_dequeue_burst(struct rte_crypto_raw_dp_ctx *ctx,
 		out_user_data, is_user_data_array, n_success_jobs, status);
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_raw_dequeue_done)
 int
 rte_cryptodev_raw_dequeue_done(struct rte_crypto_raw_dp_ctx *ctx,
 		uint32_t n)
@@ -2632,6 +2710,7 @@ rte_crypto_op_init(struct rte_mempool *mempool,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_crypto_op_pool_create)
 struct rte_mempool *
 rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 		unsigned nb_elts, unsigned cache_size, uint16_t priv_size,
@@ -2701,6 +2780,7 @@ rte_crypto_op_pool_create(const char *name, enum rte_crypto_op_type type,
 	return mp;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_create_dev_name)
 int
 rte_cryptodev_pmd_create_dev_name(char *name, const char *dev_name_prefix)
 {
@@ -2730,6 +2810,7 @@ TAILQ_HEAD(cryptodev_driver_list, cryptodev_driver);
 static struct cryptodev_driver_list cryptodev_driver_list =
 	TAILQ_HEAD_INITIALIZER(cryptodev_driver_list);
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_driver_id_get)
 int
 rte_cryptodev_driver_id_get(const char *name)
 {
@@ -2755,6 +2836,7 @@ rte_cryptodev_driver_id_get(const char *name)
 	return driver_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_name_get)
 const char *
 rte_cryptodev_name_get(uint8_t dev_id)
 {
@@ -2774,6 +2856,7 @@ rte_cryptodev_name_get(uint8_t dev_id)
 	return dev->data->name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cryptodev_driver_name_get)
 const char *
 rte_cryptodev_driver_name_get(uint8_t driver_id)
 {
@@ -2789,6 +2872,7 @@ rte_cryptodev_driver_name_get(uint8_t driver_id)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_allocate_driver)
 uint8_t
 rte_cryptodev_allocate_driver(struct cryptodev_driver *crypto_drv,
 		const struct rte_driver *drv)
diff --git a/lib/dispatcher/rte_dispatcher.c b/lib/dispatcher/rte_dispatcher.c
index 79349172bc..a35967f7b7 100644
--- a/lib/dispatcher/rte_dispatcher.c
+++ b/lib/dispatcher/rte_dispatcher.c
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_branch_prediction.h>
 #include <rte_common.h>
 #include <rte_lcore.h>
@@ -266,6 +267,7 @@ evd_service_unregister(struct rte_dispatcher *dispatcher)
 	return rc;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_create, 23.11)
 struct rte_dispatcher *
 rte_dispatcher_create(uint8_t event_dev_id)
 {
@@ -300,6 +302,7 @@ rte_dispatcher_create(uint8_t event_dev_id)
 	return dispatcher;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_free, 23.11)
 int
 rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 {
@@ -317,6 +320,7 @@ rte_dispatcher_free(struct rte_dispatcher *dispatcher)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_service_id_get, 23.11)
 uint32_t
 rte_dispatcher_service_id_get(const struct rte_dispatcher *dispatcher)
 {
@@ -340,6 +344,7 @@ lcore_port_index(struct rte_dispatcher_lcore *lcore,
 	return -1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_bind_port_to_lcore, 23.11)
 int
 rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, uint16_t batch_size, uint64_t timeout,
@@ -369,6 +374,7 @@ rte_dispatcher_bind_port_to_lcore(struct rte_dispatcher *dispatcher,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unbind_port_from_lcore, 23.11)
 int
 rte_dispatcher_unbind_port_from_lcore(struct rte_dispatcher *dispatcher,
 	uint8_t event_port_id, unsigned int lcore_id)
@@ -451,6 +457,7 @@ evd_install_handler(struct rte_dispatcher *dispatcher,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_register, 23.11)
 int
 rte_dispatcher_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_match_t match_fun, void *match_data,
@@ -522,6 +529,7 @@ evd_uninstall_handler(struct rte_dispatcher *dispatcher, int handler_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_unregister, 23.11)
 int
 rte_dispatcher_unregister(struct rte_dispatcher *dispatcher, int handler_id)
 {
@@ -575,6 +583,7 @@ evd_alloc_finalizer(struct rte_dispatcher *dispatcher)
 	return finalizer;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_register, 23.11)
 int
 rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	rte_dispatcher_finalize_t finalize_fun, void *finalize_data)
@@ -592,6 +601,7 @@ rte_dispatcher_finalize_register(struct rte_dispatcher *dispatcher,
 	return finalizer->id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_finalize_unregister, 23.11)
 int
 rte_dispatcher_finalize_unregister(struct rte_dispatcher *dispatcher,
 	int finalizer_id)
@@ -643,12 +653,14 @@ evd_set_service_runstate(struct rte_dispatcher *dispatcher, int state)
 	RTE_VERIFY(rc == 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_start, 23.11)
 void
 rte_dispatcher_start(struct rte_dispatcher *dispatcher)
 {
 	evd_set_service_runstate(dispatcher, 1);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stop, 23.11)
 void
 rte_dispatcher_stop(struct rte_dispatcher *dispatcher)
 {
@@ -665,6 +677,7 @@ evd_aggregate_stats(struct rte_dispatcher_stats *result,
 	result->ev_drop_count += part->ev_drop_count;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_get, 23.11)
 void
 rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	struct rte_dispatcher_stats *stats)
@@ -681,6 +694,7 @@ rte_dispatcher_stats_get(const struct rte_dispatcher *dispatcher,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dispatcher_stats_reset, 23.11)
 void
 rte_dispatcher_stats_reset(struct rte_dispatcher *dispatcher)
 {
diff --git a/lib/distributor/rte_distributor.c b/lib/distributor/rte_distributor.c
index e58727cdc2..dde7ce2677 100644
--- a/lib/distributor/rte_distributor.c
+++ b/lib/distributor/rte_distributor.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <sys/queue.h>
 #include <string.h>
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_cycles.h>
 #include <rte_memzone.h>
@@ -31,6 +32,7 @@ EAL_REGISTER_TAILQ(rte_dist_burst_tailq)
 
 /**** Burst Packet APIs called by workers ****/
 
+RTE_EXPORT_SYMBOL(rte_distributor_request_pkt)
 void
 rte_distributor_request_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **oldpkt,
@@ -83,6 +85,7 @@ rte_distributor_request_pkt(struct rte_distributor *d,
 			rte_memory_order_release);
 }
 
+RTE_EXPORT_SYMBOL(rte_distributor_poll_pkt)
 int
 rte_distributor_poll_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **pkts)
@@ -127,6 +130,7 @@ rte_distributor_poll_pkt(struct rte_distributor *d,
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_distributor_get_pkt)
 int
 rte_distributor_get_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **pkts,
@@ -157,6 +161,7 @@ rte_distributor_get_pkt(struct rte_distributor *d,
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_distributor_return_pkt)
 int
 rte_distributor_return_pkt(struct rte_distributor *d,
 		unsigned int worker_id, struct rte_mbuf **oldpkt, int num)
@@ -439,6 +444,7 @@ release(struct rte_distributor *d, unsigned int wkr)
 
 
 /* process a set of packets to distribute them to workers */
+RTE_EXPORT_SYMBOL(rte_distributor_process)
 int
 rte_distributor_process(struct rte_distributor *d,
 		struct rte_mbuf **mbufs, unsigned int num_mbufs)
@@ -609,6 +615,7 @@ rte_distributor_process(struct rte_distributor *d,
 }
 
 /* return to the caller, packets returned from workers */
+RTE_EXPORT_SYMBOL(rte_distributor_returned_pkts)
 int
 rte_distributor_returned_pkts(struct rte_distributor *d,
 		struct rte_mbuf **mbufs, unsigned int max_mbufs)
@@ -655,6 +662,7 @@ total_outstanding(const struct rte_distributor *d)
  * Flush the distributor, so that there are no outstanding packets in flight or
  * queued up.
  */
+RTE_EXPORT_SYMBOL(rte_distributor_flush)
 int
 rte_distributor_flush(struct rte_distributor *d)
 {
@@ -687,6 +695,7 @@ rte_distributor_flush(struct rte_distributor *d)
 }
 
 /* clears the internal returns array in the distributor */
+RTE_EXPORT_SYMBOL(rte_distributor_clear_returns)
 void
 rte_distributor_clear_returns(struct rte_distributor *d)
 {
@@ -708,6 +717,7 @@ rte_distributor_clear_returns(struct rte_distributor *d)
 }
 
 /* creates a distributor instance */
+RTE_EXPORT_SYMBOL(rte_distributor_create)
 struct rte_distributor *
 rte_distributor_create(const char *name,
 		unsigned int socket_id,
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 4a075ee1c6..17ee0808a9 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
@@ -21,6 +22,7 @@
 
 static int16_t dma_devices_max;
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_fp_objs)
 struct rte_dma_fp_object *rte_dma_fp_objs;
 static struct rte_dma_dev *rte_dma_devices;
 static struct {
@@ -37,6 +39,7 @@ RTE_LOG_REGISTER_DEFAULT(rte_dma_logtype, INFO);
 #define RTE_DMA_LOG(level, ...) \
 	RTE_LOG_LINE(level, DMADEV, "" __VA_ARGS__)
 
+RTE_EXPORT_SYMBOL(rte_dma_dev_max)
 int
 rte_dma_dev_max(size_t dev_max)
 {
@@ -54,6 +57,7 @@ rte_dma_dev_max(size_t dev_max)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_next_dev)
 int16_t
 rte_dma_next_dev(int16_t start_dev_id)
 {
@@ -348,6 +352,7 @@ dma_release(struct rte_dma_dev *dev)
 	memset(dev, 0, sizeof(struct rte_dma_dev));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_allocate)
 struct rte_dma_dev *
 rte_dma_pmd_allocate(const char *name, int numa_node, size_t private_data_size)
 {
@@ -365,6 +370,7 @@ rte_dma_pmd_allocate(const char *name, int numa_node, size_t private_data_size)
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_release)
 int
 rte_dma_pmd_release(const char *name)
 {
@@ -384,6 +390,7 @@ rte_dma_pmd_release(const char *name)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_get_dev_id_by_name)
 int
 rte_dma_get_dev_id_by_name(const char *name)
 {
@@ -399,6 +406,7 @@ rte_dma_get_dev_id_by_name(const char *name)
 	return dev->data->dev_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_is_valid)
 bool
 rte_dma_is_valid(int16_t dev_id)
 {
@@ -407,6 +415,7 @@ rte_dma_is_valid(int16_t dev_id)
 		rte_dma_devices[dev_id].state != RTE_DMA_DEV_UNUSED;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_pmd_get_dev_by_id)
 struct rte_dma_dev *
 rte_dma_pmd_get_dev_by_id(int16_t dev_id)
 {
@@ -416,6 +425,7 @@ rte_dma_pmd_get_dev_by_id(int16_t dev_id)
 	return &rte_dma_devices[dev_id];
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_count_avail)
 uint16_t
 rte_dma_count_avail(void)
 {
@@ -433,6 +443,7 @@ rte_dma_count_avail(void)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_info_get)
 int
 rte_dma_info_get(int16_t dev_id, struct rte_dma_info *dev_info)
 {
@@ -464,6 +475,7 @@ rte_dma_info_get(int16_t dev_id, struct rte_dma_info *dev_info)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_configure)
 int
 rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 {
@@ -521,6 +533,7 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_start)
 int
 rte_dma_start(int16_t dev_id)
 {
@@ -554,6 +567,7 @@ rte_dma_start(int16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_stop)
 int
 rte_dma_stop(int16_t dev_id)
 {
@@ -582,6 +596,7 @@ rte_dma_stop(int16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_close)
 int
 rte_dma_close(int16_t dev_id)
 {
@@ -610,6 +625,7 @@ rte_dma_close(int16_t dev_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_vchan_setup)
 int
 rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		    const struct rte_dma_vchan_conf *conf)
@@ -704,6 +720,7 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_stats_get)
 int
 rte_dma_stats_get(int16_t dev_id, uint16_t vchan, struct rte_dma_stats *stats)
 {
@@ -726,6 +743,7 @@ rte_dma_stats_get(int16_t dev_id, uint16_t vchan, struct rte_dma_stats *stats)
 	return dev->dev_ops->stats_get(dev, vchan, stats, sizeof(struct rte_dma_stats));
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_stats_reset)
 int
 rte_dma_stats_reset(int16_t dev_id, uint16_t vchan)
 {
@@ -751,6 +769,7 @@ rte_dma_stats_reset(int16_t dev_id, uint16_t vchan)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_vchan_status)
 int
 rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *status)
 {
@@ -818,6 +837,7 @@ dma_dump_capability(FILE *f, uint64_t dev_capa)
 	(void)fprintf(f, "\n");
 }
 
+RTE_EXPORT_SYMBOL(rte_dma_dump)
 int
 rte_dma_dump(int16_t dev_id, FILE *f)
 {
diff --git a/lib/dmadev/rte_dmadev_trace_points.c b/lib/dmadev/rte_dmadev_trace_points.c
index 4c74356346..1c8998fb98 100644
--- a/lib/dmadev/rte_dmadev_trace_points.c
+++ b/lib/dmadev/rte_dmadev_trace_points.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2023 HiSilicon Limited
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include "rte_dmadev_trace.h"
@@ -36,23 +37,30 @@ RTE_TRACE_POINT_REGISTER(rte_dma_trace_vchan_status,
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_dump,
 	lib.dmadev.dump)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_copy,
 	lib.dmadev.copy)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_copy_sg, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_copy_sg,
 	lib.dmadev.copy_sg)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_fill, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_fill,
 	lib.dmadev.fill)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_submit, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_submit,
 	lib.dmadev.submit)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed,
 	lib.dmadev.completed)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_completed_status, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed_status,
 	lib.dmadev.completed_status)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_burst_capacity, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_burst_capacity,
 	lib.dmadev.burst_capacity)
diff --git a/lib/eal/arm/rte_cpuflags.c b/lib/eal/arm/rte_cpuflags.c
index 88e10c6da0..32243f293a 100644
--- a/lib/eal/arm/rte_cpuflags.c
+++ b/lib/eal/arm/rte_cpuflags.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2015 RehiveTech. All rights reserved.
  */
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
 #include <elf.h>
@@ -135,6 +136,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -152,6 +154,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -160,6 +163,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/arm/rte_hypervisor.c b/lib/eal/arm/rte_hypervisor.c
index 08a1c97d10..51b224fb94 100644
--- a/lib/eal/arm/rte_hypervisor.c
+++ b/lib/eal/arm/rte_hypervisor.c
@@ -2,8 +2,10 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get)
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/arm/rte_power_intrinsics.c b/lib/eal/arm/rte_power_intrinsics.c
index 6475bbca04..4826b370ea 100644
--- a/lib/eal/arm/rte_power_intrinsics.c
+++ b/lib/eal/arm/rte_power_intrinsics.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 #include "rte_power_intrinsics.h"
 
@@ -26,6 +27,7 @@ RTE_INIT(rte_power_intrinsics_init)
  * This function uses WFE/WFET instruction to make lcore suspend
  * execution on ARM.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor)
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -78,6 +80,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on ARM.
  */
+RTE_EXPORT_SYMBOL(rte_power_pause)
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -91,6 +94,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
  * on ARM.
  * Note that lcore_id is not used here.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -104,6 +108,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 #endif /* RTE_ARCH_64 */
 }
 
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 7cbd09c421..0a2311a342 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -11,17 +11,20 @@
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 static struct rte_bus_list rte_bus_list =
 	TAILQ_HEAD_INITIALIZER(rte_bus_list);
 
+RTE_EXPORT_SYMBOL(rte_bus_name)
 const char *
 rte_bus_name(const struct rte_bus *bus)
 {
 	return bus->name;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_register)
 void
 rte_bus_register(struct rte_bus *bus)
 {
@@ -38,6 +41,7 @@ rte_bus_register(struct rte_bus *bus)
 	EAL_LOG(DEBUG, "Registered [%s] bus.", rte_bus_name(bus));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_unregister)
 void
 rte_bus_unregister(struct rte_bus *bus)
 {
@@ -46,6 +50,7 @@ rte_bus_unregister(struct rte_bus *bus)
 }
 
 /* Scan all the buses for registered devices */
+RTE_EXPORT_SYMBOL(rte_bus_scan)
 int
 rte_bus_scan(void)
 {
@@ -63,6 +68,7 @@ rte_bus_scan(void)
 }
 
 /* Probe all devices of all buses */
+RTE_EXPORT_SYMBOL(rte_bus_probe)
 int
 rte_bus_probe(void)
 {
@@ -124,6 +130,7 @@ bus_dump_one(FILE *f, struct rte_bus *bus)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_bus_dump)
 void
 rte_bus_dump(FILE *f)
 {
@@ -140,6 +147,7 @@ rte_bus_dump(FILE *f)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_bus_find)
 struct rte_bus *
 rte_bus_find(const struct rte_bus *start, rte_bus_cmp_t cmp,
 	     const void *data)
@@ -175,6 +183,7 @@ bus_find_device(const struct rte_bus *bus, const void *_dev)
 	return dev == NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_bus_find_by_device)
 struct rte_bus *
 rte_bus_find_by_device(const struct rte_device *dev)
 {
@@ -189,6 +198,7 @@ cmp_bus_name(const struct rte_bus *bus, const void *_name)
 	return strcmp(rte_bus_name(bus), name);
 }
 
+RTE_EXPORT_SYMBOL(rte_bus_find_by_name)
 struct rte_bus *
 rte_bus_find_by_name(const char *busname)
 {
@@ -220,6 +230,7 @@ rte_bus_find_by_device_name(const char *str)
 /*
  * Get iommu class of devices on the bus.
  */
+RTE_EXPORT_SYMBOL(rte_bus_get_iommu_class)
 enum rte_iova_mode
 rte_bus_get_iommu_class(void)
 {
diff --git a/lib/eal/common/eal_common_class.c b/lib/eal/common/eal_common_class.c
index 4938ec6707..0f10c6894b 100644
--- a/lib/eal/common/eal_common_class.c
+++ b/lib/eal/common/eal_common_class.c
@@ -9,11 +9,13 @@
 #include <rte_class.h>
 #include <rte_debug.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 static struct rte_class_list rte_class_list =
 	TAILQ_HEAD_INITIALIZER(rte_class_list);
 
+RTE_EXPORT_SYMBOL(rte_class_register)
 void
 rte_class_register(struct rte_class *class)
 {
@@ -24,6 +26,7 @@ rte_class_register(struct rte_class *class)
 	EAL_LOG(DEBUG, "Registered [%s] device class.", class->name);
 }
 
+RTE_EXPORT_SYMBOL(rte_class_unregister)
 void
 rte_class_unregister(struct rte_class *class)
 {
@@ -31,6 +34,7 @@ rte_class_unregister(struct rte_class *class)
 	EAL_LOG(DEBUG, "Unregistered [%s] device class.", class->name);
 }
 
+RTE_EXPORT_SYMBOL(rte_class_find)
 struct rte_class *
 rte_class_find(const struct rte_class *start, rte_class_cmp_t cmp,
 	       const void *data)
@@ -57,6 +61,7 @@ cmp_class_name(const struct rte_class *class, const void *_name)
 	return strcmp(class->name, name);
 }
 
+RTE_EXPORT_SYMBOL(rte_class_find_by_name)
 struct rte_class *
 rte_class_find_by_name(const char *name)
 {
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index d3494d6e21..7fc7611a07 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -4,6 +4,7 @@
 
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_memcfg.h"
 
@@ -28,6 +29,7 @@ static char runtime_dir[PATH_MAX];
 /* internal configuration */
 static struct internal_config internal_config;
 
+RTE_EXPORT_SYMBOL(rte_eal_get_runtime_dir)
 const char *
 rte_eal_get_runtime_dir(void)
 {
@@ -59,6 +61,7 @@ eal_get_internal_configuration(void)
 	return &internal_config;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_iova_mode)
 enum rte_iova_mode
 rte_eal_iova_mode(void)
 {
@@ -66,6 +69,7 @@ rte_eal_iova_mode(void)
 }
 
 /* Get the EAL base address */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_get_baseaddr)
 uint64_t
 rte_eal_get_baseaddr(void)
 {
@@ -74,6 +78,7 @@ rte_eal_get_baseaddr(void)
 		       eal_get_baseaddr();
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_process_type)
 enum rte_proc_type_t
 rte_eal_process_type(void)
 {
@@ -81,6 +86,7 @@ rte_eal_process_type(void)
 }
 
 /* Return user provided mbuf pool ops name */
+RTE_EXPORT_SYMBOL(rte_eal_mbuf_user_pool_ops)
 const char *
 rte_eal_mbuf_user_pool_ops(void)
 {
@@ -88,12 +94,14 @@ rte_eal_mbuf_user_pool_ops(void)
 }
 
 /* return non-zero if hugepages are enabled. */
+RTE_EXPORT_SYMBOL(rte_eal_has_hugepages)
 int
 rte_eal_has_hugepages(void)
 {
 	return !internal_config.no_hugetlbfs;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_has_pci)
 int
 rte_eal_has_pci(void)
 {
diff --git a/lib/eal/common/eal_common_cpuflags.c b/lib/eal/common/eal_common_cpuflags.c
index dc5f75d053..cbd49a151b 100644
--- a/lib/eal/common/eal_common_cpuflags.c
+++ b/lib/eal/common/eal_common_cpuflags.c
@@ -4,9 +4,11 @@
 
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cpuflags.h>
 
+RTE_EXPORT_SYMBOL(rte_cpu_is_supported)
 int
 rte_cpu_is_supported(void)
 {
diff --git a/lib/eal/common/eal_common_debug.c b/lib/eal/common/eal_common_debug.c
index bcfcd6df6f..7a42546da2 100644
--- a/lib/eal/common/eal_common_debug.c
+++ b/lib/eal/common/eal_common_debug.c
@@ -11,8 +11,10 @@
 #include <rte_debug.h>
 #include <rte_errno.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
+RTE_EXPORT_SYMBOL(__rte_panic)
 void
 __rte_panic(const char *funcname, const char *format, ...)
 {
@@ -30,6 +32,7 @@ __rte_panic(const char *funcname, const char *format, ...)
  * Like rte_panic this terminates the application. However, no traceback is
  * provided and no core-dump is generated.
  */
+RTE_EXPORT_SYMBOL(rte_exit)
 void
 rte_exit(int exit_code, const char *format, ...)
 {
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 70aa04dcd9..7185de0cb9 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -17,45 +17,53 @@
 #include <rte_spinlock.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "hotplug_mp.h"
 
+RTE_EXPORT_SYMBOL(rte_driver_name)
 const char *
 rte_driver_name(const struct rte_driver *driver)
 {
 	return driver->name;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_bus)
 const struct rte_bus *
 rte_dev_bus(const struct rte_device *dev)
 {
 	return dev->bus;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_bus_info)
 const char *
 rte_dev_bus_info(const struct rte_device *dev)
 {
 	return dev->bus_info;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_devargs)
 const struct rte_devargs *
 rte_dev_devargs(const struct rte_device *dev)
 {
 	return dev->devargs;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_driver)
 const struct rte_driver *
 rte_dev_driver(const struct rte_device *dev)
 {
 	return dev->driver;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_name)
 const char *
 rte_dev_name(const struct rte_device *dev)
 {
 	return dev->name;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_numa_node)
 int
 rte_dev_numa_node(const struct rte_device *dev)
 {
@@ -114,6 +122,7 @@ static int cmp_dev_name(const struct rte_device *dev, const void *_name)
 	return strcmp(dev->name, name);
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_is_probed)
 int
 rte_dev_is_probed(const struct rte_device *dev)
 {
@@ -146,6 +155,7 @@ build_devargs(const char *busname, const char *devname,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_hotplug_add)
 int
 rte_eal_hotplug_add(const char *busname, const char *devname,
 		    const char *drvargs)
@@ -230,6 +240,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_probe)
 int
 rte_dev_probe(const char *devargs)
 {
@@ -323,6 +334,7 @@ rte_dev_probe(const char *devargs)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_hotplug_remove)
 int
 rte_eal_hotplug_remove(const char *busname, const char *devname)
 {
@@ -366,6 +378,7 @@ local_dev_remove(struct rte_device *dev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_remove)
 int
 rte_dev_remove(struct rte_device *dev)
 {
@@ -463,6 +476,7 @@ rte_dev_remove(struct rte_device *dev)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_register)
 int
 rte_dev_event_callback_register(const char *device_name,
 				rte_dev_event_cb_fn cb_fn,
@@ -531,6 +545,7 @@ rte_dev_event_callback_register(const char *device_name,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_unregister)
 int
 rte_dev_event_callback_unregister(const char *device_name,
 				  rte_dev_event_cb_fn cb_fn,
@@ -584,6 +599,7 @@ rte_dev_event_callback_unregister(const char *device_name,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_callback_process)
 void
 rte_dev_event_callback_process(const char *device_name,
 			       enum rte_dev_event_type event)
@@ -610,6 +626,7 @@ rte_dev_event_callback_process(const char *device_name,
 	rte_spinlock_unlock(&dev_event_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_iterator_init)
 int
 rte_dev_iterator_init(struct rte_dev_iterator *it,
 		      const char *dev_str)
@@ -762,6 +779,7 @@ bus_next_dev_cmp(const struct rte_bus *bus,
 	it->device = dev;
 	return dev == NULL;
 }
+RTE_EXPORT_SYMBOL(rte_dev_iterator_next)
 struct rte_device *
 rte_dev_iterator_next(struct rte_dev_iterator *it)
 {
@@ -806,6 +824,7 @@ rte_dev_iterator_next(struct rte_dev_iterator *it)
 	return it->device;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_dma_map)
 int
 rte_dev_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
 		size_t len)
@@ -823,6 +842,7 @@ rte_dev_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
 	return dev->bus->dma_map(dev, addr, iova, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_dma_unmap)
 int
 rte_dev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 		  size_t len)
diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index dd857fc839..c523429d67 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -20,6 +20,7 @@
 #include <rte_log.h>
 #include <rte_tailq.h>
 #include <rte_string_fns.h>
+#include <eal_export.h>
 #include "eal_private.h"
 
 /** user device double-linked queue type definition */
@@ -180,6 +181,7 @@ bus_name_cmp(const struct rte_bus *bus, const void *name)
 	return strncmp(bus->name, name, strlen(bus->name));
 }
 
+RTE_EXPORT_SYMBOL(rte_devargs_parse)
 int
 rte_devargs_parse(struct rte_devargs *da, const char *dev)
 {
@@ -246,6 +248,7 @@ rte_devargs_parse(struct rte_devargs *da, const char *dev)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_devargs_parsef)
 int
 rte_devargs_parsef(struct rte_devargs *da, const char *format, ...)
 {
@@ -280,6 +283,7 @@ rte_devargs_parsef(struct rte_devargs *da, const char *format, ...)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_devargs_reset)
 void
 rte_devargs_reset(struct rte_devargs *da)
 {
@@ -289,6 +293,7 @@ rte_devargs_reset(struct rte_devargs *da)
 	da->data = NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_devargs_insert)
 int
 rte_devargs_insert(struct rte_devargs **da)
 {
@@ -320,6 +325,7 @@ rte_devargs_insert(struct rte_devargs **da)
 }
 
 /* store in allowed list parameter for later parsing */
+RTE_EXPORT_SYMBOL(rte_devargs_add)
 int
 rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 {
@@ -356,6 +362,7 @@ rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_devargs_remove)
 int
 rte_devargs_remove(struct rte_devargs *devargs)
 {
@@ -378,6 +385,7 @@ rte_devargs_remove(struct rte_devargs *devargs)
 }
 
 /* count the number of devices of a specified type */
+RTE_EXPORT_SYMBOL(rte_devargs_type_count)
 unsigned int
 rte_devargs_type_count(enum rte_devtype devtype)
 {
@@ -393,6 +401,7 @@ rte_devargs_type_count(enum rte_devtype devtype)
 }
 
 /* dump the user devices on the console */
+RTE_EXPORT_SYMBOL(rte_devargs_dump)
 void
 rte_devargs_dump(FILE *f)
 {
@@ -407,6 +416,7 @@ rte_devargs_dump(FILE *f)
 }
 
 /* bus-aware rte_devargs iterator. */
+RTE_EXPORT_SYMBOL(rte_devargs_next)
 struct rte_devargs *
 rte_devargs_next(const char *busname, const struct rte_devargs *start)
 {
diff --git a/lib/eal/common/eal_common_errno.c b/lib/eal/common/eal_common_errno.c
index fff8c1ffe4..3f933c3f7b 100644
--- a/lib/eal/common/eal_common_errno.c
+++ b/lib/eal/common/eal_common_errno.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_per_lcore.h>
 #include <rte_errno.h>
 
@@ -16,8 +17,10 @@
 #define strerror_r(errnum, buf, buflen) strerror_s(buf, buflen, errnum)
 #endif
 
+RTE_EXPORT_SYMBOL(per_lcore__rte_errno)
 RTE_DEFINE_PER_LCORE(int, _rte_errno);
 
+RTE_EXPORT_SYMBOL(rte_strerror)
 const char *
 rte_strerror(int errnum)
 {
diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 22b43073c6..b5e7bf498c 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -15,6 +15,7 @@
 #include <rte_log.h>
 #include <rte_spinlock.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 #include "eal_private.h"
 
@@ -715,6 +716,7 @@ fully_validate(const char *name, unsigned int elt_sz, unsigned int len)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_init)
 int
 rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 		unsigned int elt_sz)
@@ -841,6 +843,7 @@ rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_attach)
 int
 rte_fbarray_attach(struct rte_fbarray *arr)
 {
@@ -929,6 +932,7 @@ rte_fbarray_attach(struct rte_fbarray *arr)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_detach)
 int
 rte_fbarray_detach(struct rte_fbarray *arr)
 {
@@ -982,6 +986,7 @@ rte_fbarray_detach(struct rte_fbarray *arr)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_destroy)
 int
 rte_fbarray_destroy(struct rte_fbarray *arr)
 {
@@ -1068,6 +1073,7 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_get)
 void *
 rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 {
@@ -1087,18 +1093,21 @@ rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_set_used)
 int
 rte_fbarray_set_used(struct rte_fbarray *arr, unsigned int idx)
 {
 	return set_used(arr, idx, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_set_free)
 int
 rte_fbarray_set_free(struct rte_fbarray *arr, unsigned int idx)
 {
 	return set_used(arr, idx, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_is_used)
 int
 rte_fbarray_is_used(struct rte_fbarray *arr, unsigned int idx)
 {
@@ -1168,24 +1177,28 @@ fbarray_find(struct rte_fbarray *arr, unsigned int start, bool next, bool used)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_free)
 int
 rte_fbarray_find_next_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, true, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_used)
 int
 rte_fbarray_find_next_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, true, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_free)
 int
 rte_fbarray_find_prev_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find(arr, start, false, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_used)
 int
 rte_fbarray_find_prev_used(struct rte_fbarray *arr, unsigned int start)
 {
@@ -1244,6 +1257,7 @@ fbarray_find_n(struct rte_fbarray *arr, unsigned int start, unsigned int n,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_free)
 int
 rte_fbarray_find_next_n_free(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1251,6 +1265,7 @@ rte_fbarray_find_next_n_free(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, true, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_next_n_used)
 int
 rte_fbarray_find_next_n_used(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1258,6 +1273,7 @@ rte_fbarray_find_next_n_used(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, true, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_free)
 int
 rte_fbarray_find_prev_n_free(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1265,6 +1281,7 @@ rte_fbarray_find_prev_n_free(struct rte_fbarray *arr, unsigned int start,
 	return fbarray_find_n(arr, start, n, false, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_prev_n_used)
 int
 rte_fbarray_find_prev_n_used(struct rte_fbarray *arr, unsigned int start,
 		unsigned int n)
@@ -1408,24 +1425,28 @@ fbarray_find_biggest(struct rte_fbarray *arr, unsigned int start, bool used,
 	return biggest_idx;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_free)
 int
 rte_fbarray_find_biggest_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, false, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_biggest_used)
 int
 rte_fbarray_find_biggest_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, true, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_free)
 int
 rte_fbarray_find_rev_biggest_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_biggest(arr, start, false, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_biggest_used)
 int
 rte_fbarray_find_rev_biggest_used(struct rte_fbarray *arr, unsigned int start)
 {
@@ -1433,30 +1454,35 @@ rte_fbarray_find_rev_biggest_used(struct rte_fbarray *arr, unsigned int start)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_free)
 int
 rte_fbarray_find_contig_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, true, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_contig_used)
 int
 rte_fbarray_find_contig_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, true, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_free)
 int
 rte_fbarray_find_rev_contig_free(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, false, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_rev_contig_used)
 int
 rte_fbarray_find_rev_contig_used(struct rte_fbarray *arr, unsigned int start)
 {
 	return fbarray_find_contig(arr, start, false, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_find_idx)
 int
 rte_fbarray_find_idx(const struct rte_fbarray *arr, const void *elt)
 {
@@ -1483,6 +1509,7 @@ rte_fbarray_find_idx(const struct rte_fbarray *arr, const void *elt)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_fbarray_dump_metadata)
 void
 rte_fbarray_dump_metadata(struct rte_fbarray *arr, FILE *f)
 {
diff --git a/lib/eal/common/eal_common_hexdump.c b/lib/eal/common/eal_common_hexdump.c
index 6fd6e21e1e..28159f298a 100644
--- a/lib/eal/common/eal_common_hexdump.c
+++ b/lib/eal/common/eal_common_hexdump.c
@@ -2,11 +2,13 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 #include <stdio.h>
+#include <eal_export.h>
 #include <rte_hexdump.h>
 #include <rte_string_fns.h>
 
 #define LINE_LEN 128
 
+RTE_EXPORT_SYMBOL(rte_hexdump)
 void
 rte_hexdump(FILE *f, const char *title, const void *buf, unsigned int len)
 {
@@ -45,6 +47,7 @@ rte_hexdump(FILE *f, const char *title, const void *buf, unsigned int len)
 	fflush(f);
 }
 
+RTE_EXPORT_SYMBOL(rte_memdump)
 void
 rte_memdump(FILE *f, const char *title, const void *buf, unsigned int len)
 {
diff --git a/lib/eal/common/eal_common_hypervisor.c b/lib/eal/common/eal_common_hypervisor.c
index 5388b81a51..7158fd25de 100644
--- a/lib/eal/common/eal_common_hypervisor.c
+++ b/lib/eal/common/eal_common_hypervisor.c
@@ -2,8 +2,10 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get_name)
 const char *
 rte_hypervisor_get_name(enum rte_hypervisor id)
 {
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index b4d7b18fae..b42fa862f3 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -10,6 +10,7 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 
+#include <eal_export.h>
 #include "eal_interrupts.h"
 #include "eal_private.h"
 
@@ -29,6 +30,7 @@
 #define RTE_INTR_INSTANCE_USES_RTE_MEMORY(flags) \
 	(!!(flags & RTE_INTR_INSTANCE_F_SHARED))
 
+RTE_EXPORT_SYMBOL(rte_intr_instance_alloc)
 struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 {
 	struct rte_intr_handle *intr_handle;
@@ -96,6 +98,7 @@ struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_dup)
 struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 {
 	struct rte_intr_handle *intr_handle;
@@ -121,6 +124,7 @@ struct rte_intr_handle *rte_intr_instance_dup(const struct rte_intr_handle *src)
 	return intr_handle;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_event_list_update)
 int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 {
 	struct rte_epoll_event *tmp_elist;
@@ -171,6 +175,7 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_instance_free)
 void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 {
 	if (intr_handle == NULL)
@@ -186,6 +191,7 @@ void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_fd_set)
 int rte_intr_fd_set(struct rte_intr_handle *intr_handle, int fd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -197,6 +203,7 @@ int rte_intr_fd_set(struct rte_intr_handle *intr_handle, int fd)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_fd_get)
 int rte_intr_fd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -206,6 +213,7 @@ int rte_intr_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_type_set)
 int rte_intr_type_set(struct rte_intr_handle *intr_handle,
 	enum rte_intr_handle_type type)
 {
@@ -218,6 +226,7 @@ int rte_intr_type_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_type_get)
 enum rte_intr_handle_type rte_intr_type_get(
 	const struct rte_intr_handle *intr_handle)
 {
@@ -228,6 +237,7 @@ enum rte_intr_handle_type rte_intr_type_get(
 	return RTE_INTR_HANDLE_UNKNOWN;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_set)
 int rte_intr_dev_fd_set(struct rte_intr_handle *intr_handle, int fd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -239,6 +249,7 @@ int rte_intr_dev_fd_set(struct rte_intr_handle *intr_handle, int fd)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_get)
 int rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -248,6 +259,7 @@ int rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_set)
 int rte_intr_max_intr_set(struct rte_intr_handle *intr_handle,
 				 int max_intr)
 {
@@ -268,6 +280,7 @@ int rte_intr_max_intr_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_get)
 int rte_intr_max_intr_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -277,6 +290,7 @@ int rte_intr_max_intr_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_set)
 int rte_intr_nb_efd_set(struct rte_intr_handle *intr_handle, int nb_efd)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -288,6 +302,7 @@ int rte_intr_nb_efd_set(struct rte_intr_handle *intr_handle, int nb_efd)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_efd_get)
 int rte_intr_nb_efd_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -297,6 +312,7 @@ int rte_intr_nb_efd_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_nb_intr_get)
 int rte_intr_nb_intr_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -306,6 +322,7 @@ int rte_intr_nb_intr_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_set)
 int rte_intr_efd_counter_size_set(struct rte_intr_handle *intr_handle,
 	uint8_t efd_counter_size)
 {
@@ -318,6 +335,7 @@ int rte_intr_efd_counter_size_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_counter_size_get)
 int rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -327,6 +345,7 @@ int rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle)
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_get)
 int rte_intr_efds_index_get(const struct rte_intr_handle *intr_handle,
 	int index)
 {
@@ -344,6 +363,7 @@ int rte_intr_efds_index_get(const struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efds_index_set)
 int rte_intr_efds_index_set(struct rte_intr_handle *intr_handle,
 	int index, int fd)
 {
@@ -363,6 +383,7 @@ int rte_intr_efds_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_get)
 struct rte_epoll_event *rte_intr_elist_index_get(
 	struct rte_intr_handle *intr_handle, int index)
 {
@@ -380,6 +401,7 @@ struct rte_epoll_event *rte_intr_elist_index_get(
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_elist_index_set)
 int rte_intr_elist_index_set(struct rte_intr_handle *intr_handle,
 	int index, struct rte_epoll_event elist)
 {
@@ -399,6 +421,7 @@ int rte_intr_elist_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_alloc)
 int rte_intr_vec_list_alloc(struct rte_intr_handle *intr_handle,
 	const char *name, int size)
 {
@@ -432,6 +455,7 @@ int rte_intr_vec_list_alloc(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_get)
 int rte_intr_vec_list_index_get(const struct rte_intr_handle *intr_handle,
 				int index)
 {
@@ -449,6 +473,7 @@ int rte_intr_vec_list_index_get(const struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_index_set)
 int rte_intr_vec_list_index_set(struct rte_intr_handle *intr_handle,
 				int index, int vec)
 {
@@ -468,6 +493,7 @@ int rte_intr_vec_list_index_set(struct rte_intr_handle *intr_handle,
 	return -rte_errno;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_vec_list_free)
 void rte_intr_vec_list_free(struct rte_intr_handle *intr_handle)
 {
 	if (intr_handle == NULL)
@@ -480,6 +506,7 @@ void rte_intr_vec_list_free(struct rte_intr_handle *intr_handle)
 	intr_handle->vec_list_size = 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_get)
 void *rte_intr_instance_windows_handle_get(struct rte_intr_handle *intr_handle)
 {
 	CHECK_VALID_INTR_HANDLE(intr_handle);
@@ -489,6 +516,7 @@ void *rte_intr_instance_windows_handle_get(struct rte_intr_handle *intr_handle)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_instance_windows_handle_set)
 int rte_intr_instance_windows_handle_set(struct rte_intr_handle *intr_handle,
 	void *windows_handle)
 {
diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index 5320c3bd3c..a7deac6ecd 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_launch.h>
 #include <rte_pause.h>
@@ -15,6 +16,7 @@
 /*
  * Wait until a lcore finished its job.
  */
+RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
 int
 rte_eal_wait_lcore(unsigned worker_id)
 {
@@ -30,6 +32,7 @@ rte_eal_wait_lcore(unsigned worker_id)
  * function f with argument arg. Once the execution is done, the
  * remote lcore switches to WAIT state.
  */
+RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
 int
 rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
@@ -61,6 +64,7 @@ rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
  * rte_eal_remote_launch() for all of them. If call_main is true
  * (set to CALL_MAIN), also call the function on the main lcore.
  */
+RTE_EXPORT_SYMBOL(rte_eal_mp_remote_launch)
 int
 rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 			 enum rte_rmt_call_main_t call_main)
@@ -90,6 +94,7 @@ rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 /*
  * Return the state of the lcore identified by worker_id.
  */
+RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
 enum rte_lcore_state_t
 rte_eal_get_lcore_state(unsigned lcore_id)
 {
@@ -100,6 +105,7 @@ rte_eal_get_lcore_state(unsigned lcore_id)
  * Do a rte_eal_wait_lcore() for every lcore. The return values are
  * ignored.
  */
+RTE_EXPORT_SYMBOL(rte_eal_mp_wait_lcore)
 void
 rte_eal_mp_wait_lcore(void)
 {
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 820a6534b1..294267177d 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -15,19 +15,23 @@
 #include <rte_telemetry.h>
 #endif
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_thread.h"
 
+RTE_EXPORT_SYMBOL(rte_get_main_lcore)
 unsigned int rte_get_main_lcore(void)
 {
 	return rte_eal_get_configuration()->main_lcore;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_count)
 unsigned int rte_lcore_count(void)
 {
 	return rte_eal_get_configuration()->lcore_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_index)
 int rte_lcore_index(int lcore_id)
 {
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -43,6 +47,7 @@ int rte_lcore_index(int lcore_id)
 	return lcore_config[lcore_id].core_index;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -58,11 +63,13 @@ int rte_lcore_to_cpu_id(int lcore_id)
 	return lcore_config[lcore_id].core_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_cpuset)
 rte_cpuset_t rte_lcore_cpuset(unsigned int lcore_id)
 {
 	return lcore_config[lcore_id].cpuset;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_lcore_role)
 enum rte_lcore_role_t
 rte_eal_lcore_role(unsigned int lcore_id)
 {
@@ -73,6 +80,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 	return cfg->lcore_role[lcore_id];
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_has_role)
 int
 rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 {
@@ -84,6 +92,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	return cfg->lcore_role[lcore_id] == role;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
 int rte_lcore_is_enabled(unsigned int lcore_id)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
@@ -93,6 +102,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 	return cfg->lcore_role[lcore_id] == ROLE_RTE;
 }
 
+RTE_EXPORT_SYMBOL(rte_get_next_lcore)
 unsigned int rte_get_next_lcore(unsigned int i, int skip_main, int wrap)
 {
 	i++;
@@ -112,6 +122,7 @@ unsigned int rte_get_next_lcore(unsigned int i, int skip_main, int wrap)
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
@@ -220,6 +231,7 @@ rte_eal_cpu_init(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_socket_count)
 unsigned int
 rte_socket_count(void)
 {
@@ -227,6 +239,7 @@ rte_socket_count(void)
 	return config->numa_node_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
 int
 rte_socket_id_by_idx(unsigned int idx)
 {
@@ -276,6 +289,7 @@ free_callback(struct lcore_callback *callback)
 	free(callback);
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_callback_register)
 void *
 rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	rte_lcore_uninit_cb uninit, void *arg)
@@ -326,6 +340,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	return callback;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_callback_unregister)
 void
 rte_lcore_callback_unregister(void *handle)
 {
@@ -411,6 +426,7 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	rte_rwlock_write_unlock(&lcore_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_iterate)
 int
 rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 {
@@ -447,6 +463,7 @@ lcore_role_str(enum rte_lcore_role_t role)
 
 static rte_lcore_usage_cb lcore_usage_cb;
 
+RTE_EXPORT_SYMBOL(rte_lcore_register_usage_cb)
 void
 rte_lcore_register_usage_cb(rte_lcore_usage_cb cb)
 {
@@ -493,6 +510,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_dump)
 void
 rte_lcore_dump(FILE *f)
 {
diff --git a/lib/eal/common/eal_common_lcore_var.c b/lib/eal/common/eal_common_lcore_var.c
index a1b2458839..8a7920ed0f 100644
--- a/lib/eal/common/eal_common_lcore_var.c
+++ b/lib/eal/common/eal_common_lcore_var.c
@@ -15,6 +15,7 @@
 
 #include <rte_lcore_var.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_lcore_var.h"
 
@@ -75,6 +76,7 @@ lcore_var_alloc(size_t size, size_t align)
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_lcore_var_alloc, 24.11)
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
 {
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index dabb80eaf5..84ee3f3959 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -5,6 +5,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_version.h>
 
+#include <eal_export.h>
 #include "eal_internal_cfg.h"
 #include "eal_memcfg.h"
 #include "eal_private.h"
@@ -69,120 +70,140 @@ eal_mcfg_update_from_internal(void)
 	mcfg->version = RTE_VERSION;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mem_get_lock)
 rte_rwlock_t *
 rte_mcfg_mem_get_lock(void)
 {
 	return &rte_eal_get_configuration()->mem_config->memory_hotplug_lock;
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_lock)
 void
 rte_mcfg_mem_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_mem_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_unlock)
 void
 rte_mcfg_mem_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_mem_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_lock)
 void
 rte_mcfg_mem_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_mem_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mem_write_unlock)
 void
 rte_mcfg_mem_write_unlock(void)
 {
 	rte_rwlock_write_unlock(rte_mcfg_mem_get_lock());
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_tailq_get_lock)
 rte_rwlock_t *
 rte_mcfg_tailq_get_lock(void)
 {
 	return &rte_eal_get_configuration()->mem_config->qlock;
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_lock)
 void
 rte_mcfg_tailq_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_tailq_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_unlock)
 void
 rte_mcfg_tailq_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_tailq_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_lock)
 void
 rte_mcfg_tailq_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_tailq_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_tailq_write_unlock)
 void
 rte_mcfg_tailq_write_unlock(void)
 {
 	rte_rwlock_write_unlock(rte_mcfg_tailq_get_lock());
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mempool_get_lock)
 rte_rwlock_t *
 rte_mcfg_mempool_get_lock(void)
 {
 	return &rte_eal_get_configuration()->mem_config->mplock;
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_lock)
 void
 rte_mcfg_mempool_read_lock(void)
 {
 	rte_rwlock_read_lock(rte_mcfg_mempool_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_unlock)
 void
 rte_mcfg_mempool_read_unlock(void)
 {
 	rte_rwlock_read_unlock(rte_mcfg_mempool_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_lock)
 void
 rte_mcfg_mempool_write_lock(void)
 {
 	rte_rwlock_write_lock(rte_mcfg_mempool_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_mempool_write_unlock)
 void
 rte_mcfg_mempool_write_unlock(void)
 {
 	rte_rwlock_write_unlock(rte_mcfg_mempool_get_lock());
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_timer_get_lock)
 rte_spinlock_t *
 rte_mcfg_timer_get_lock(void)
 {
 	return &rte_eal_get_configuration()->mem_config->tlock;
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_timer_lock)
 void
 rte_mcfg_timer_lock(void)
 {
 	rte_spinlock_lock(rte_mcfg_timer_get_lock());
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_timer_unlock)
 void
 rte_mcfg_timer_unlock(void)
 {
 	rte_spinlock_unlock(rte_mcfg_timer_get_lock());
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_ethdev_get_lock)
 rte_spinlock_t *
 rte_mcfg_ethdev_get_lock(void)
 {
 	return &rte_eal_get_configuration()->mem_config->ethdev_lock;
 }
 
+RTE_EXPORT_SYMBOL(rte_mcfg_get_single_file_segments)
 bool
 rte_mcfg_get_single_file_segments(void)
 {
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index a185e0b580..a2f64408f4 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -21,6 +21,7 @@
 #include <rte_telemetry.h>
 #endif
 
+#include <eal_export.h>
 #include "eal_memalloc.h"
 #include "eal_private.h"
 #include "eal_internal_cfg.h"
@@ -336,6 +337,7 @@ virt2memseg_list(const void *addr)
 	return msl;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_virt2memseg_list)
 struct rte_memseg_list *
 rte_mem_virt2memseg_list(const void *addr)
 {
@@ -373,6 +375,7 @@ find_virt_legacy(const struct rte_memseg_list *msl __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_iova2virt)
 void *
 rte_mem_iova2virt(rte_iova_t iova)
 {
@@ -394,6 +397,7 @@ rte_mem_iova2virt(rte_iova_t iova)
 	return vi.virt;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_virt2memseg)
 struct rte_memseg *
 rte_mem_virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 {
@@ -415,6 +419,7 @@ physmem_size(const struct rte_memseg_list *msl, void *arg)
 }
 
 /* get the total size of memory */
+RTE_EXPORT_SYMBOL(rte_eal_get_physmem_size)
 uint64_t
 rte_eal_get_physmem_size(void)
 {
@@ -463,6 +468,7 @@ dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
  * Defining here because declared in rte_memory.h, but the actual implementation
  * is in eal_common_memalloc.c, like all other memalloc internals.
  */
+RTE_EXPORT_SYMBOL(rte_mem_event_callback_register)
 int
 rte_mem_event_callback_register(const char *name, rte_mem_event_callback_t clb,
 		void *arg)
@@ -479,6 +485,7 @@ rte_mem_event_callback_register(const char *name, rte_mem_event_callback_t clb,
 	return eal_memalloc_mem_event_callback_register(name, clb, arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_event_callback_unregister)
 int
 rte_mem_event_callback_unregister(const char *name, void *arg)
 {
@@ -494,6 +501,7 @@ rte_mem_event_callback_unregister(const char *name, void *arg)
 	return eal_memalloc_mem_event_callback_unregister(name, arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_register)
 int
 rte_mem_alloc_validator_register(const char *name,
 		rte_mem_alloc_validator_t clb, int socket_id, size_t limit)
@@ -511,6 +519,7 @@ rte_mem_alloc_validator_register(const char *name,
 			limit);
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_unregister)
 int
 rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 {
@@ -527,6 +536,7 @@ rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 }
 
 /* Dump the physical memory layout on console */
+RTE_EXPORT_SYMBOL(rte_dump_physmem_layout)
 void
 rte_dump_physmem_layout(FILE *f)
 {
@@ -598,12 +608,14 @@ check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask)
 int
 rte_mem_check_dma_mask(uint8_t maskbits)
 {
 	return check_dma_mask(maskbits, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_check_dma_mask_thread_unsafe)
 int
 rte_mem_check_dma_mask_thread_unsafe(uint8_t maskbits)
 {
@@ -617,6 +629,7 @@ rte_mem_check_dma_mask_thread_unsafe(uint8_t maskbits)
  * initialization. PMDs should use rte_mem_check_dma_mask if addressing
  * limitations by the device.
  */
+RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask)
 void
 rte_mem_set_dma_mask(uint8_t maskbits)
 {
@@ -627,12 +640,14 @@ rte_mem_set_dma_mask(uint8_t maskbits)
 }
 
 /* return the number of memory channels */
+RTE_EXPORT_SYMBOL(rte_memory_get_nchannel)
 unsigned rte_memory_get_nchannel(void)
 {
 	return rte_eal_get_configuration()->mem_config->nchannel;
 }
 
 /* return the number of memory rank */
+RTE_EXPORT_SYMBOL(rte_memory_get_nrank)
 unsigned rte_memory_get_nrank(void)
 {
 	return rte_eal_get_configuration()->mem_config->nrank;
@@ -656,6 +671,7 @@ rte_eal_memdevice_init(void)
 }
 
 /* Lock page in physical memory and prevent from swapping. */
+RTE_EXPORT_SYMBOL(rte_mem_lock_page)
 int
 rte_mem_lock_page(const void *virt)
 {
@@ -665,6 +681,7 @@ rte_mem_lock_page(const void *virt)
 	return rte_mem_lock((void *)aligned, page_size);
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
 int
 rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 {
@@ -704,6 +721,7 @@ rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_contig_walk)
 int
 rte_memseg_contig_walk(rte_memseg_contig_walk_t func, void *arg)
 {
@@ -717,6 +735,7 @@ rte_memseg_contig_walk(rte_memseg_contig_walk_t func, void *arg)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe)
 int
 rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 {
@@ -745,6 +764,7 @@ rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_walk)
 int
 rte_memseg_walk(rte_memseg_walk_t func, void *arg)
 {
@@ -758,6 +778,7 @@ rte_memseg_walk(rte_memseg_walk_t func, void *arg)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe)
 int
 rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 {
@@ -777,6 +798,7 @@ rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_list_walk)
 int
 rte_memseg_list_walk(rte_memseg_list_walk_t func, void *arg)
 {
@@ -790,6 +812,7 @@ rte_memseg_list_walk(rte_memseg_list_walk_t func, void *arg)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe)
 int
 rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 {
@@ -832,6 +855,7 @@ rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd)
 int
 rte_memseg_get_fd(const struct rte_memseg *ms)
 {
@@ -844,6 +868,7 @@ rte_memseg_get_fd(const struct rte_memseg *ms)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset_thread_unsafe)
 int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset)
@@ -887,6 +912,7 @@ rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_memseg_get_fd_offset)
 int
 rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 {
@@ -899,6 +925,7 @@ rte_memseg_get_fd_offset(const struct rte_memseg *ms, size_t *offset)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_register)
 int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
@@ -948,6 +975,7 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_unregister)
 int
 rte_extmem_unregister(void *va_addr, size_t len)
 {
@@ -1003,12 +1031,14 @@ sync_memory(void *va_addr, size_t len, bool attach)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_attach)
 int
 rte_extmem_attach(void *va_addr, size_t len)
 {
 	return sync_memory(va_addr, len, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_extmem_detach)
 int
 rte_extmem_detach(void *va_addr, size_t len)
 {
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index e7002f8447..db43af13a8 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -25,6 +26,7 @@
 /* Default count used until rte_memzone_max_set() is called */
 #define DEFAULT_MAX_MEMZONE_COUNT 2560
 
+RTE_EXPORT_SYMBOL(rte_memzone_max_set)
 int
 rte_memzone_max_set(size_t max)
 {
@@ -46,6 +48,7 @@ rte_memzone_max_set(size_t max)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_memzone_max_get)
 size_t
 rte_memzone_max_get(void)
 {
@@ -263,6 +266,7 @@ rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
  * specified alignment and boundary). If the allocation cannot be done,
  * return NULL.
  */
+RTE_EXPORT_SYMBOL(rte_memzone_reserve_bounded)
 const struct rte_memzone *
 rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
 			    unsigned flags, unsigned align, unsigned bound)
@@ -275,6 +279,7 @@ rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
  * Return a pointer to a correctly filled memzone descriptor (with a
  * specified alignment). If the allocation cannot be done, return NULL.
  */
+RTE_EXPORT_SYMBOL(rte_memzone_reserve_aligned)
 const struct rte_memzone *
 rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
 			    unsigned flags, unsigned align)
@@ -287,6 +292,7 @@ rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
  * Return a pointer to a correctly filled memzone descriptor. If the
  * allocation cannot be done, return NULL.
  */
+RTE_EXPORT_SYMBOL(rte_memzone_reserve)
 const struct rte_memzone *
 rte_memzone_reserve(const char *name, size_t len, int socket_id,
 		    unsigned flags)
@@ -295,6 +301,7 @@ rte_memzone_reserve(const char *name, size_t len, int socket_id,
 					       flags, RTE_CACHE_LINE_SIZE, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_memzone_free)
 int
 rte_memzone_free(const struct rte_memzone *mz)
 {
@@ -341,6 +348,7 @@ rte_memzone_free(const struct rte_memzone *mz)
 /*
  * Lookup for the memzone identified by the given name
  */
+RTE_EXPORT_SYMBOL(rte_memzone_lookup)
 const struct rte_memzone *
 rte_memzone_lookup(const char *name)
 {
@@ -417,6 +425,7 @@ dump_memzone(const struct rte_memzone *mz, void *arg)
 }
 
 /* Dump all reserved memory zones on console */
+RTE_EXPORT_SYMBOL(rte_memzone_dump)
 void
 rte_memzone_dump(FILE *f)
 {
@@ -458,6 +467,7 @@ rte_eal_memzone_init(void)
 }
 
 /* Walk all reserved memory zones */
+RTE_EXPORT_SYMBOL(rte_memzone_walk)
 void rte_memzone_walk(void (*func)(const struct rte_memzone *, void *),
 		      void *arg)
 {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 79db9a47dd..b6fff7ec05 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -33,6 +33,7 @@
 #endif
 #include <rte_vect.h>
 
+#include <eal_export.h>
 #include "eal_internal_cfg.h"
 #include "eal_options.h"
 #include "eal_filesystem.h"
@@ -164,6 +165,7 @@ eal_get_application_usage_hook(void)
 }
 
 /* Set a per-application usage message */
+RTE_EXPORT_SYMBOL(rte_set_application_usage_hook)
 rte_usage_hook_t
 rte_set_application_usage_hook(rte_usage_hook_t usage_func)
 {
@@ -760,6 +762,7 @@ check_core_list(int *lcores, unsigned int count)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_parse_coremask)
 int
 rte_eal_parse_coremask(const char *coremask, int *cores)
 {
@@ -2171,6 +2174,7 @@ eal_check_common_options(struct internal_config *internal_cfg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
 {
@@ -2179,6 +2183,7 @@ rte_vect_get_max_simd_bitwidth(void)
 	return internal_conf->max_simd_bitwidth.bitwidth;
 }
 
+RTE_EXPORT_SYMBOL(rte_vect_set_max_simd_bitwidth)
 int
 rte_vect_set_max_simd_bitwidth(uint16_t bitwidth)
 {
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 201973c5db..0dea787e38 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -28,6 +28,7 @@
 #include <rte_log.h>
 #include <rte_thread.h>
 
+#include <eal_export.h>
 #include "eal_memcfg.h"
 #include "eal_private.h"
 #include "eal_filesystem.h"
@@ -142,6 +143,7 @@ create_socket_path(const char *name, char *buf, int len)
 		strlcpy(buf, prefix, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_primary_proc_alive)
 int
 rte_eal_primary_proc_alive(const char *config_file_path)
 {
@@ -197,6 +199,7 @@ validate_action_name(const char *name)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_action_register)
 int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
@@ -233,6 +236,7 @@ rte_mp_action_register(const char *name, rte_mp_t action)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_action_unregister)
 void
 rte_mp_action_unregister(const char *name)
 {
@@ -836,6 +840,7 @@ check_input(const struct rte_mp_msg *msg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
@@ -989,6 +994,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_request_sync)
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 		const struct timespec *ts)
@@ -1086,6 +1092,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_request_async)
 int
 rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		rte_mp_async_reply_t clb)
@@ -1238,6 +1245,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_reply)
 int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
@@ -1290,6 +1298,7 @@ set_mp_status(enum mp_status status)
 	return rte_atomic_load_explicit(&mcfg->mp_status, rte_memory_order_relaxed) == desired;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_disable)
 bool
 rte_mp_disable(void)
 {
diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 9ca2045b18..020603fe8b 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -7,10 +7,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
 /* split string into tokens */
+RTE_EXPORT_SYMBOL(rte_strsplit)
 int
 rte_strsplit(char *string, int stringlen,
 	     char **tokens, int maxtokens, char delim)
@@ -45,6 +47,7 @@ rte_strsplit(char *string, int stringlen,
  * Return negative value and NUL-terminate if dst is too short,
  * Otherwise return number of bytes copied.
  */
+RTE_EXPORT_SYMBOL(rte_strscpy)
 ssize_t
 rte_strscpy(char *dst, const char *src, size_t dsize)
 {
@@ -67,6 +70,7 @@ rte_strscpy(char *dst, const char *src, size_t dsize)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_str_to_size)
 uint64_t
 rte_str_to_size(const char *str)
 {
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 56bb2bd91c..47080d75ac 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -11,6 +11,7 @@
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_memcfg.h"
 
@@ -22,6 +23,7 @@ static struct rte_tailq_elem_head rte_tailq_elem_head =
 /* number of tailqs registered, -1 before call to rte_eal_tailqs_init */
 static int rte_tailqs_count = -1;
 
+RTE_EXPORT_SYMBOL(rte_eal_tailq_lookup)
 struct rte_tailq_head *
 rte_eal_tailq_lookup(const char *name)
 {
@@ -40,6 +42,7 @@ rte_eal_tailq_lookup(const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_dump_tailq)
 void
 rte_dump_tailq(FILE *f)
 {
@@ -105,6 +108,7 @@ rte_eal_tailq_update(struct rte_tailq_elem *t)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_tailq_register)
 int
 rte_eal_tailq_register(struct rte_tailq_elem *t)
 {
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index a53bc639ae..88b59ce0d9 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -10,6 +10,7 @@
 #include <assert.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
@@ -22,12 +23,15 @@
 #include "eal_thread.h"
 #include "eal_trace.h"
 
+RTE_EXPORT_SYMBOL(per_lcore__lcore_id)
 RTE_DEFINE_PER_LCORE(unsigned int, _lcore_id) = LCORE_ID_ANY;
+RTE_EXPORT_SYMBOL(per_lcore__thread_id)
 RTE_DEFINE_PER_LCORE(int, _thread_id) = -1;
 static RTE_DEFINE_PER_LCORE(unsigned int, _socket_id) =
 	(unsigned int)SOCKET_ID_ANY;
 static RTE_DEFINE_PER_LCORE(rte_cpuset_t, _cpuset);
 
+RTE_EXPORT_SYMBOL(rte_socket_id)
 unsigned rte_socket_id(void)
 {
 	return RTE_PER_LCORE(_socket_id);
@@ -82,6 +86,7 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity)
 int
 rte_thread_set_affinity(rte_cpuset_t *cpusetp)
 {
@@ -94,6 +99,7 @@ rte_thread_set_affinity(rte_cpuset_t *cpusetp)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity)
 void
 rte_thread_get_affinity(rte_cpuset_t *cpusetp)
 {
@@ -282,6 +288,7 @@ static uint32_t control_thread_start(void *arg)
 	return start_routine(start_arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_create_control)
 int
 rte_thread_create_control(rte_thread_t *thread, const char *name,
 		rte_thread_func start_routine, void *arg)
@@ -341,6 +348,7 @@ add_internal_prefix(char *prefixed_name, const char *name, size_t size)
 	strlcpy(prefixed_name + prefixlen, name, size - prefixlen);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_create_internal_control)
 int
 rte_thread_create_internal_control(rte_thread_t *id, const char *name,
 		rte_thread_func func, void *arg)
@@ -351,6 +359,7 @@ rte_thread_create_internal_control(rte_thread_t *id, const char *name,
 	return rte_thread_create_control(id, prefixed_name, func, arg);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_set_prefixed_name)
 void
 rte_thread_set_prefixed_name(rte_thread_t id, const char *name)
 {
@@ -360,6 +369,7 @@ rte_thread_set_prefixed_name(rte_thread_t id, const char *name)
 	rte_thread_set_name(id, prefixed_name);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_register)
 int
 rte_thread_register(void)
 {
@@ -392,6 +402,7 @@ rte_thread_register(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_unregister)
 void
 rte_thread_unregister(void)
 {
@@ -405,6 +416,7 @@ rte_thread_unregister(void)
 			lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_attr_init)
 int
 rte_thread_attr_init(rte_thread_attr_t *attr)
 {
@@ -417,6 +429,7 @@ rte_thread_attr_init(rte_thread_attr_t *attr)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_attr_set_priority)
 int
 rte_thread_attr_set_priority(rte_thread_attr_t *thread_attr,
 		enum rte_thread_priority priority)
@@ -429,6 +442,7 @@ rte_thread_attr_set_priority(rte_thread_attr_t *thread_attr,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_attr_set_affinity)
 int
 rte_thread_attr_set_affinity(rte_thread_attr_t *thread_attr,
 		rte_cpuset_t *cpuset)
@@ -444,6 +458,7 @@ rte_thread_attr_set_affinity(rte_thread_attr_t *thread_attr,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_attr_get_affinity)
 int
 rte_thread_attr_get_affinity(rte_thread_attr_t *thread_attr,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index e00be0a5c8..bbf8b8b11b 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -11,6 +11,7 @@
 #include <rte_pause.h>
 #include <rte_eal.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_memcfg.h"
 
@@ -18,8 +19,10 @@
 static uint64_t eal_tsc_resolution_hz;
 
 /* Pointer to user delay function */
+RTE_EXPORT_SYMBOL(rte_delay_us)
 void (*rte_delay_us)(unsigned int) = NULL;
 
+RTE_EXPORT_SYMBOL(rte_delay_us_block)
 void
 rte_delay_us_block(unsigned int us)
 {
@@ -29,6 +32,7 @@ rte_delay_us_block(unsigned int us)
 		rte_pause();
 }
 
+RTE_EXPORT_SYMBOL(rte_get_tsc_hz)
 uint64_t
 rte_get_tsc_hz(void)
 {
@@ -75,6 +79,7 @@ set_tsc_freq(void)
 	mcfg->tsc_hz = freq;
 }
 
+RTE_EXPORT_SYMBOL(rte_delay_us_callback_register)
 void rte_delay_us_callback_register(void (*userfunc)(unsigned int))
 {
 	rte_delay_us = userfunc;
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index 918f49bf4f..be1f78a68d 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -14,9 +14,12 @@
 #include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_trace.h"
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05)
 RTE_DEFINE_PER_LCORE(volatile int, trace_point_sz);
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05)
 RTE_DEFINE_PER_LCORE(void *, trace_mem);
 static RTE_DEFINE_PER_LCORE(char *, ctf_field);
 
@@ -94,6 +97,7 @@ eal_trace_fini(void)
 	eal_trace_args_free();
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_is_enabled, 20.05)
 bool
 rte_trace_is_enabled(void)
 {
@@ -111,6 +115,7 @@ trace_mode_set(rte_trace_point_t *t, enum rte_trace_mode mode)
 			rte_memory_order_release);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_set, 20.05)
 void
 rte_trace_mode_set(enum rte_trace_mode mode)
 {
@@ -122,6 +127,7 @@ rte_trace_mode_set(enum rte_trace_mode mode)
 	trace.mode = mode;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_mode_get, 20.05)
 enum
 rte_trace_mode rte_trace_mode_get(void)
 {
@@ -134,6 +140,7 @@ trace_point_is_invalid(rte_trace_point_t *t)
 	return (t == NULL) || (trace_id_get(t) >= trace.nb_trace_points);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_is_enabled, 20.05)
 bool
 rte_trace_point_is_enabled(rte_trace_point_t *t)
 {
@@ -146,6 +153,7 @@ rte_trace_point_is_enabled(rte_trace_point_t *t)
 	return (val & __RTE_TRACE_FIELD_ENABLE_MASK) != 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_enable, 20.05)
 int
 rte_trace_point_enable(rte_trace_point_t *t)
 {
@@ -161,6 +169,7 @@ rte_trace_point_enable(rte_trace_point_t *t)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_disable, 20.05)
 int
 rte_trace_point_disable(rte_trace_point_t *t)
 {
@@ -176,6 +185,7 @@ rte_trace_point_disable(rte_trace_point_t *t)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_pattern, 20.05)
 int
 rte_trace_pattern(const char *pattern, bool enable)
 {
@@ -200,6 +210,7 @@ rte_trace_pattern(const char *pattern, bool enable)
 	return rc | found;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_regexp, 20.05)
 int
 rte_trace_regexp(const char *regex, bool enable)
 {
@@ -229,6 +240,7 @@ rte_trace_regexp(const char *regex, bool enable)
 	return rc | found;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_point_lookup, 20.05)
 rte_trace_point_t *
 rte_trace_point_lookup(const char *name)
 {
@@ -279,6 +291,7 @@ trace_lcore_mem_dump(FILE *f)
 	rte_spinlock_unlock(&trace->lock);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_dump, 20.05)
 void
 rte_trace_dump(FILE *f)
 {
@@ -314,6 +327,7 @@ thread_get_name(rte_thread_t id, char *name, size_t len)
 	RTE_SET_USED(len);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05)
 void
 __rte_trace_mem_per_thread_alloc(void)
 {
@@ -435,6 +449,7 @@ trace_mem_free(void)
 	rte_spinlock_unlock(&trace->lock);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05)
 void
 __rte_trace_point_emit_field(size_t sz, const char *in, const char *datatype)
 {
@@ -461,6 +476,7 @@ __rte_trace_point_emit_field(size_t sz, const char *in, const char *datatype)
 	RTE_PER_LCORE(ctf_field) = field;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05)
 int
 __rte_trace_point_register(rte_trace_point_t *handle, const char *name,
 		void (*register_fn)(void))
diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
index 04c4f71462..f089da22df 100644
--- a/lib/eal/common/eal_common_trace_ctf.c
+++ b/lib/eal/common/eal_common_trace_ctf.c
@@ -12,6 +12,7 @@
 #include <rte_trace.h>
 #include <rte_version.h>
 
+#include <eal_export.h>
 #include "eal_trace.h"
 
 __rte_format_printf(2, 0)
@@ -351,6 +352,7 @@ meta_fixup(struct trace *trace, char *meta)
 	meta_fix_freq_offset(trace, meta);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_metadata_dump, 20.05)
 int
 rte_trace_metadata_dump(FILE *f)
 {
diff --git a/lib/eal/common/eal_common_trace_points.c b/lib/eal/common/eal_common_trace_points.c
index 0f1240ea3a..0903f3c639 100644
--- a/lib/eal/common/eal_common_trace_points.c
+++ b/lib/eal/common/eal_common_trace_points.c
@@ -6,42 +6,61 @@
 
 #include <rte_eal_trace.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_void, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_void,
 	lib.eal.generic.void)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u64, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u64,
 	lib.eal.generic.u64)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u32, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u32,
 	lib.eal.generic.u32)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u16, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u16,
 	lib.eal.generic.u16)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_u8, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_u8,
 	lib.eal.generic.u8)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i64, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i64,
 	lib.eal.generic.i64)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i32, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i32,
 	lib.eal.generic.i32)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i16, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i16,
 	lib.eal.generic.i16)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_i8, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_i8,
 	lib.eal.generic.i8)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_int, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_int,
 	lib.eal.generic.int)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_long, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_long,
 	lib.eal.generic.long)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_float, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_float,
 	lib.eal.generic.float)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_double, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_double,
 	lib.eal.generic.double)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_ptr, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_ptr,
 	lib.eal.generic.ptr)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_str, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_str,
 	lib.eal.generic.string)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_size_t, 20.11)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_size_t,
 	lib.eal.generic.size_t)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_func, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_func,
 	lib.eal.generic.func)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eal_trace_generic_blob, 23.03)
 RTE_TRACE_POINT_REGISTER(rte_eal_trace_generic_blob,
 	lib.eal.generic.blob)
 
diff --git a/lib/eal/common/eal_common_trace_utils.c b/lib/eal/common/eal_common_trace_utils.c
index 7282715b11..e1996433b7 100644
--- a/lib/eal/common/eal_common_trace_utils.c
+++ b/lib/eal/common/eal_common_trace_utils.c
@@ -11,6 +11,7 @@
 #include <rte_errno.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 #include "eal_private.h"
 #include "eal_trace.h"
@@ -409,6 +410,7 @@ trace_mem_save(struct trace *trace, struct __rte_trace_header *hdr,
 	return rc;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_save, 20.05)
 int
 rte_trace_save(void)
 {
diff --git a/lib/eal/common/eal_common_uuid.c b/lib/eal/common/eal_common_uuid.c
index 0a80bfbb38..0e0924d08d 100644
--- a/lib/eal/common/eal_common_uuid.c
+++ b/lib/eal/common/eal_common_uuid.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <ctype.h>
 
+#include <eal_export.h>
 #include <rte_uuid.h>
 
 /* UUID packed form */
@@ -77,6 +78,7 @@ static void uuid_unpack(const rte_uuid_t in, struct uuid *uu)
 	memcpy(uu->node, ptr, 6);
 }
 
+RTE_EXPORT_SYMBOL(rte_uuid_is_null)
 bool rte_uuid_is_null(const rte_uuid_t uu)
 {
 	const uint8_t *cp = uu;
@@ -91,6 +93,7 @@ bool rte_uuid_is_null(const rte_uuid_t uu)
 /*
  * rte_uuid_compare() - compare two UUIDs.
  */
+RTE_EXPORT_SYMBOL(rte_uuid_compare)
 int rte_uuid_compare(const rte_uuid_t uu1, const rte_uuid_t uu2)
 {
 	struct uuid	uuid1, uuid2;
@@ -110,6 +113,7 @@ int rte_uuid_compare(const rte_uuid_t uu1, const rte_uuid_t uu2)
 	return memcmp(uuid1.node, uuid2.node, 6);
 }
 
+RTE_EXPORT_SYMBOL(rte_uuid_parse)
 int rte_uuid_parse(const char *in, rte_uuid_t uu)
 {
 	struct uuid	uuid;
@@ -152,6 +156,7 @@ int rte_uuid_parse(const char *in, rte_uuid_t uu)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_uuid_unparse)
 void rte_uuid_unparse(const rte_uuid_t uu, char *out, size_t len)
 {
 	struct uuid uuid;
diff --git a/lib/eal/common/rte_bitset.c b/lib/eal/common/rte_bitset.c
index e25008519e..78001b1ee8 100644
--- a/lib/eal/common/rte_bitset.c
+++ b/lib/eal/common/rte_bitset.c
@@ -7,8 +7,10 @@
 #include <stdint.h>
 #include <sys/types.h>
 
+#include <eal_export.h>
 #include "rte_bitset.h"
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bitset_to_str, 24.11)
 ssize_t
 rte_bitset_to_str(const uint64_t *bitset, size_t num_bits, char *buf, size_t capacity)
 {
diff --git a/lib/eal/common/rte_keepalive.c b/lib/eal/common/rte_keepalive.c
index 473d30dd13..08a4d595da 100644
--- a/lib/eal/common/rte_keepalive.c
+++ b/lib/eal/common/rte_keepalive.c
@@ -12,6 +12,7 @@
 #include <rte_keepalive.h>
 #include <rte_malloc.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 struct rte_keepalive {
@@ -63,6 +64,7 @@ print_trace(const char *msg, struct rte_keepalive *keepcfg, int idx_core)
 	      );
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_dispatch_pings)
 void
 rte_keepalive_dispatch_pings(__rte_unused void *ptr_timer,
 	void *ptr_data)
@@ -117,6 +119,7 @@ rte_keepalive_dispatch_pings(__rte_unused void *ptr_timer,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_create)
 struct rte_keepalive *
 rte_keepalive_create(rte_keepalive_failure_callback_t callback,
 	void *data)
@@ -135,6 +138,7 @@ rte_keepalive_create(rte_keepalive_failure_callback_t callback,
 	return keepcfg;
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_register_relay_callback)
 void rte_keepalive_register_relay_callback(struct rte_keepalive *keepcfg,
 	rte_keepalive_relay_callback_t callback,
 	void *data)
@@ -143,6 +147,7 @@ void rte_keepalive_register_relay_callback(struct rte_keepalive *keepcfg,
 	keepcfg->relay_callback_data = data;
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_register_core)
 void
 rte_keepalive_register_core(struct rte_keepalive *keepcfg, const int id_core)
 {
@@ -152,12 +157,14 @@ rte_keepalive_register_core(struct rte_keepalive *keepcfg, const int id_core)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_mark_alive)
 void
 rte_keepalive_mark_alive(struct rte_keepalive *keepcfg)
 {
 	keepcfg->live_data[rte_lcore_id()].core_state = RTE_KA_STATE_ALIVE;
 }
 
+RTE_EXPORT_SYMBOL(rte_keepalive_mark_sleep)
 void
 rte_keepalive_mark_sleep(struct rte_keepalive *keepcfg)
 {
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3eed4d4be6..b6ee3b3329 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -16,6 +16,7 @@
 #include <rte_common.h>
 #include <rte_spinlock.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 
 #include <rte_malloc.h>
@@ -38,6 +39,7 @@ mem_free(void *addr, const bool trace_ena)
 		EAL_LOG(ERR, "Error: Invalid memory");
 }
 
+RTE_EXPORT_SYMBOL(rte_free)
 void
 rte_free(void *addr)
 {
@@ -80,6 +82,7 @@ malloc_socket(const char *type, size_t size, unsigned int align,
 /*
  * Allocate memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_malloc_socket)
 void *
 rte_malloc_socket(const char *type, size_t size, unsigned int align,
 		int socket_arg)
@@ -96,6 +99,7 @@ eal_malloc_no_trace(const char *type, size_t size, unsigned int align)
 /*
  * Allocate memory on default heap.
  */
+RTE_EXPORT_SYMBOL(rte_malloc)
 void *
 rte_malloc(const char *type, size_t size, unsigned align)
 {
@@ -105,6 +109,7 @@ rte_malloc(const char *type, size_t size, unsigned align)
 /*
  * Allocate zero'd memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_zmalloc_socket)
 void *
 rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
 {
@@ -134,6 +139,7 @@ rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
 /*
  * Allocate zero'd memory on default heap.
  */
+RTE_EXPORT_SYMBOL(rte_zmalloc)
 void *
 rte_zmalloc(const char *type, size_t size, unsigned align)
 {
@@ -143,6 +149,7 @@ rte_zmalloc(const char *type, size_t size, unsigned align)
 /*
  * Allocate zero'd memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_calloc_socket)
 void *
 rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int socket)
 {
@@ -152,6 +159,7 @@ rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int
 /*
  * Allocate zero'd memory on default heap.
  */
+RTE_EXPORT_SYMBOL(rte_calloc)
 void *
 rte_calloc(const char *type, size_t num, size_t size, unsigned align)
 {
@@ -161,6 +169,7 @@ rte_calloc(const char *type, size_t num, size_t size, unsigned align)
 /*
  * Resize allocated memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_realloc_socket)
 void *
 rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 {
@@ -212,12 +221,14 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 /*
  * Resize allocated memory.
  */
+RTE_EXPORT_SYMBOL(rte_realloc)
 void *
 rte_realloc(void *ptr, size_t size, unsigned int align)
 {
 	return rte_realloc_socket(ptr, size, align, SOCKET_ID_ANY);
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_validate)
 int
 rte_malloc_validate(const void *ptr, size_t *size)
 {
@@ -232,6 +243,7 @@ rte_malloc_validate(const void *ptr, size_t *size)
 /*
  * Function to retrieve data for heap on given socket
  */
+RTE_EXPORT_SYMBOL(rte_malloc_get_socket_stats)
 int
 rte_malloc_get_socket_stats(int socket,
 		struct rte_malloc_socket_stats *socket_stats)
@@ -250,6 +262,7 @@ rte_malloc_get_socket_stats(int socket,
 /*
  * Function to dump contents of all heaps
  */
+RTE_EXPORT_SYMBOL(rte_malloc_dump_heaps)
 void
 rte_malloc_dump_heaps(FILE *f)
 {
@@ -262,6 +275,7 @@ rte_malloc_dump_heaps(FILE *f)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket)
 int
 rte_malloc_heap_get_socket(const char *name)
 {
@@ -298,6 +312,7 @@ rte_malloc_heap_get_socket(const char *name)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external)
 int
 rte_malloc_heap_socket_is_external(int socket_id)
 {
@@ -326,6 +341,7 @@ rte_malloc_heap_socket_is_external(int socket_id)
 /*
  * Print stats on memory type. If type is NULL, info on all types is printed
  */
+RTE_EXPORT_SYMBOL(rte_malloc_dump_stats)
 void
 rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 {
@@ -355,6 +371,7 @@ rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 /*
  * Return the IO address of a virtual address obtained through rte_malloc
  */
+RTE_EXPORT_SYMBOL(rte_malloc_virt2iova)
 rte_iova_t
 rte_malloc_virt2iova(const void *addr)
 {
@@ -392,6 +409,7 @@ find_named_heap(const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_add)
 int
 rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 		rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
@@ -447,6 +465,7 @@ rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_remove)
 int
 rte_malloc_heap_memory_remove(const char *heap_name, void *va_addr, size_t len)
 {
@@ -562,18 +581,21 @@ sync_memory(const char *heap_name, void *va_addr, size_t len, bool attach)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_attach)
 int
 rte_malloc_heap_memory_attach(const char *heap_name, void *va_addr, size_t len)
 {
 	return sync_memory(heap_name, va_addr, len, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_memory_detach)
 int
 rte_malloc_heap_memory_detach(const char *heap_name, void *va_addr, size_t len)
 {
 	return sync_memory(heap_name, va_addr, len, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_create)
 int
 rte_malloc_heap_create(const char *heap_name)
 {
@@ -625,6 +647,7 @@ rte_malloc_heap_create(const char *heap_name)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_destroy)
 int
 rte_malloc_heap_destroy(const char *heap_name)
 {
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 9354358818..576a32a46c 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -16,6 +16,7 @@
 #include <rte_lcore_var.h>
 #include <rte_random.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 struct __rte_cache_aligned rte_rand_state {
@@ -82,6 +83,7 @@ __rte_srand_lfsr258(uint64_t seed, struct rte_rand_state *state)
 	state->z5 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 8388608UL);
 }
 
+RTE_EXPORT_SYMBOL(rte_srand)
 void
 rte_srand(uint64_t seed)
 {
@@ -142,6 +144,7 @@ struct rte_rand_state *__rte_rand_get_state(void)
 	return RTE_LCORE_VAR(rand_state);
 }
 
+RTE_EXPORT_SYMBOL(rte_rand)
 uint64_t
 rte_rand(void)
 {
@@ -152,6 +155,7 @@ rte_rand(void)
 	return __rte_rand_lfsr258(state);
 }
 
+RTE_EXPORT_SYMBOL(rte_rand_max)
 uint64_t
 rte_rand_max(uint64_t upper_bound)
 {
@@ -191,6 +195,7 @@ rte_rand_max(uint64_t upper_bound)
 	return res;
 }
 
+RTE_EXPORT_SYMBOL(rte_drand)
 double
 rte_drand(void)
 {
diff --git a/lib/eal/common/rte_reciprocal.c b/lib/eal/common/rte_reciprocal.c
index 87c67e6d49..99c54df141 100644
--- a/lib/eal/common/rte_reciprocal.c
+++ b/lib/eal/common/rte_reciprocal.c
@@ -7,11 +7,13 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_bitops.h>
 
 #include "rte_reciprocal.h"
 
+RTE_EXPORT_SYMBOL(rte_reciprocal_value)
 struct rte_reciprocal rte_reciprocal_value(uint32_t d)
 {
 	struct rte_reciprocal R;
@@ -99,6 +101,7 @@ divide_128_div_64_to_64(uint64_t u1, uint64_t u0, uint64_t v, uint64_t *r)
 	return q1*b + q0;
 }
 
+RTE_EXPORT_SYMBOL(rte_reciprocal_value_u64)
 struct rte_reciprocal_u64
 rte_reciprocal_value_u64(uint64_t d)
 {
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index 1821746337..d2ac9d3f14 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -9,6 +9,7 @@
 #include <rte_service.h>
 #include <rte_service_component.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_lcore.h>
 #include <rte_lcore_var.h>
@@ -120,6 +121,7 @@ rte_service_init(void)
 	return -ENOMEM;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_finalize)
 void
 rte_service_finalize(void)
 {
@@ -174,6 +176,7 @@ service_mt_safe(struct rte_service_spec_impl *s)
 	return !!(s->spec.capabilities & RTE_SERVICE_CAP_MT_SAFE);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_set_stats_enable)
 int32_t
 rte_service_set_stats_enable(uint32_t id, int32_t enabled)
 {
@@ -188,6 +191,7 @@ rte_service_set_stats_enable(uint32_t id, int32_t enabled)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_set_runstate_mapped_check)
 int32_t
 rte_service_set_runstate_mapped_check(uint32_t id, int32_t enabled)
 {
@@ -202,12 +206,14 @@ rte_service_set_runstate_mapped_check(uint32_t id, int32_t enabled)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_get_count)
 uint32_t
 rte_service_get_count(void)
 {
 	return rte_service_count;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_get_by_name)
 int32_t
 rte_service_get_by_name(const char *name, uint32_t *service_id)
 {
@@ -226,6 +232,7 @@ rte_service_get_by_name(const char *name, uint32_t *service_id)
 	return -ENODEV;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_get_name)
 const char *
 rte_service_get_name(uint32_t id)
 {
@@ -234,6 +241,7 @@ rte_service_get_name(uint32_t id)
 	return s->spec.name;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_probe_capability)
 int32_t
 rte_service_probe_capability(uint32_t id, uint32_t capability)
 {
@@ -242,6 +250,7 @@ rte_service_probe_capability(uint32_t id, uint32_t capability)
 	return !!(s->spec.capabilities & capability);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_component_register)
 int32_t
 rte_service_component_register(const struct rte_service_spec *spec,
 			       uint32_t *id_ptr)
@@ -276,6 +285,7 @@ rte_service_component_register(const struct rte_service_spec *spec,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_component_unregister)
 int32_t
 rte_service_component_unregister(uint32_t id)
 {
@@ -297,6 +307,7 @@ rte_service_component_unregister(uint32_t id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_component_runstate_set)
 int32_t
 rte_service_component_runstate_set(uint32_t id, uint32_t runstate)
 {
@@ -317,6 +328,7 @@ rte_service_component_runstate_set(uint32_t id, uint32_t runstate)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_runstate_set)
 int32_t
 rte_service_runstate_set(uint32_t id, uint32_t runstate)
 {
@@ -338,6 +350,7 @@ rte_service_runstate_set(uint32_t id, uint32_t runstate)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_runstate_get)
 int32_t
 rte_service_runstate_get(uint32_t id)
 {
@@ -448,6 +461,7 @@ service_run(uint32_t i, struct core_state *cs, const uint64_t *mapped_services,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_may_be_active)
 int32_t
 rte_service_may_be_active(uint32_t id)
 {
@@ -469,6 +483,7 @@ rte_service_may_be_active(uint32_t id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_run_iter_on_app_lcore)
 int32_t
 rte_service_run_iter_on_app_lcore(uint32_t id, uint32_t serialize_mt_unsafe)
 {
@@ -528,6 +543,7 @@ service_runner_func(void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_may_be_active)
 int32_t
 rte_service_lcore_may_be_active(uint32_t lcore)
 {
@@ -543,6 +559,7 @@ rte_service_lcore_may_be_active(uint32_t lcore)
 			       rte_memory_order_acquire);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_count)
 int32_t
 rte_service_lcore_count(void)
 {
@@ -556,6 +573,7 @@ rte_service_lcore_count(void)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_list)
 int32_t
 rte_service_lcore_list(uint32_t array[], uint32_t n)
 {
@@ -580,6 +598,7 @@ rte_service_lcore_list(uint32_t array[], uint32_t n)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_count_services)
 int32_t
 rte_service_lcore_count_services(uint32_t lcore)
 {
@@ -593,6 +612,7 @@ rte_service_lcore_count_services(uint32_t lcore)
 	return rte_bitset_count_set(cs->mapped_services, RTE_SERVICE_NUM_MAX);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_start_with_defaults)
 int32_t
 rte_service_start_with_defaults(void)
 {
@@ -666,6 +686,7 @@ service_update(uint32_t sid, uint32_t lcore, uint32_t *set, uint32_t *enabled)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_map_lcore_set)
 int32_t
 rte_service_map_lcore_set(uint32_t id, uint32_t lcore, uint32_t enabled)
 {
@@ -674,6 +695,7 @@ rte_service_map_lcore_set(uint32_t id, uint32_t lcore, uint32_t enabled)
 	return service_update(id, lcore, &on, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_map_lcore_get)
 int32_t
 rte_service_map_lcore_get(uint32_t id, uint32_t lcore)
 {
@@ -701,6 +723,7 @@ set_lcore_state(uint32_t lcore, int32_t state)
 	rte_eal_trace_service_lcore_state_change(lcore, state);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_reset_all)
 int32_t
 rte_service_lcore_reset_all(void)
 {
@@ -727,6 +750,7 @@ rte_service_lcore_reset_all(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_add)
 int32_t
 rte_service_lcore_add(uint32_t lcore)
 {
@@ -750,6 +774,7 @@ rte_service_lcore_add(uint32_t lcore)
 	return rte_eal_wait_lcore(lcore);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_del)
 int32_t
 rte_service_lcore_del(uint32_t lcore)
 {
@@ -774,6 +799,7 @@ rte_service_lcore_del(uint32_t lcore)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_start)
 int32_t
 rte_service_lcore_start(uint32_t lcore)
 {
@@ -807,6 +833,7 @@ rte_service_lcore_start(uint32_t lcore)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_stop)
 int32_t
 rte_service_lcore_stop(uint32_t lcore)
 {
@@ -947,6 +974,7 @@ attr_get_service_cycles(uint32_t service_id)
 	return attr_get(service_id, lcore_attr_get_service_cycles);
 }
 
+RTE_EXPORT_SYMBOL(rte_service_attr_get)
 int32_t
 rte_service_attr_get(uint32_t id, uint32_t attr_id, uint64_t *attr_value)
 {
@@ -974,6 +1002,7 @@ rte_service_attr_get(uint32_t id, uint32_t attr_id, uint64_t *attr_value)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_attr_get)
 int32_t
 rte_service_lcore_attr_get(uint32_t lcore, uint32_t attr_id,
 			   uint64_t *attr_value)
@@ -998,6 +1027,7 @@ rte_service_lcore_attr_get(uint32_t lcore, uint32_t attr_id,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_service_attr_reset_all)
 int32_t
 rte_service_attr_reset_all(uint32_t id)
 {
@@ -1016,6 +1046,7 @@ rte_service_attr_reset_all(uint32_t id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_service_lcore_attr_reset_all)
 int32_t
 rte_service_lcore_attr_reset_all(uint32_t lcore)
 {
@@ -1069,6 +1100,7 @@ service_dump_calls_per_lcore(FILE *f, uint32_t lcore)
 	fprintf(f, "\n");
 }
 
+RTE_EXPORT_SYMBOL(rte_service_dump)
 int32_t
 rte_service_dump(FILE *f, uint32_t id)
 {
diff --git a/lib/eal/common/rte_version.c b/lib/eal/common/rte_version.c
index 4ae5d66c89..627b89d4a8 100644
--- a/lib/eal/common/rte_version.c
+++ b/lib/eal/common/rte_version.c
@@ -2,26 +2,34 @@
  * Copyright(c) 2021 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_version.h>
 
+RTE_EXPORT_SYMBOL(rte_version_prefix)
 const char *
 rte_version_prefix(void) { return RTE_VER_PREFIX; }
 
+RTE_EXPORT_SYMBOL(rte_version_year)
 unsigned int
 rte_version_year(void) { return RTE_VER_YEAR; }
 
+RTE_EXPORT_SYMBOL(rte_version_month)
 unsigned int
 rte_version_month(void) { return RTE_VER_MONTH; }
 
+RTE_EXPORT_SYMBOL(rte_version_minor)
 unsigned int
 rte_version_minor(void) { return RTE_VER_MINOR; }
 
+RTE_EXPORT_SYMBOL(rte_version_suffix)
 const char *
 rte_version_suffix(void) { return RTE_VER_SUFFIX; }
 
+RTE_EXPORT_SYMBOL(rte_version_release)
 unsigned int
 rte_version_release(void) { return RTE_VER_RELEASE; }
 
+RTE_EXPORT_SYMBOL(rte_version)
 const char *
 rte_version(void)
 {
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index d07cff8651..d6fffa2170 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -44,6 +44,7 @@
 #include <malloc_heap.h>
 #include <telemetry_internal.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_thread.h"
 #include "eal_lcore_var.h"
@@ -72,6 +73,7 @@ static struct flock wr_lock = {
 struct lcore_config lcore_config[RTE_MAX_LCORE];
 
 /* used by rte_rdtsc() */
+RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
 int rte_cycles_vmware_tsc_map;
 
 
@@ -514,6 +516,7 @@ sync_func(__rte_unused void *arg)
 	return 0;
 }
 /* Abstraction for port I/0 privilege */
+RTE_EXPORT_SYMBOL(rte_eal_iopl_init)
 int
 rte_eal_iopl_init(void)
 {
@@ -534,6 +537,7 @@ static void rte_eal_init_alert(const char *msg)
 }
 
 /* Launch threads, called at application init(). */
+RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -883,6 +887,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
 {
@@ -911,6 +916,7 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
 int rte_eal_create_uio_dev(void)
 {
 	const struct internal_config *internal_conf =
@@ -918,17 +924,20 @@ int rte_eal_create_uio_dev(void)
 	return internal_conf->create_uio_dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
 enum rte_intr_mode
 rte_eal_vfio_intr_mode(void)
 {
 	return RTE_INTR_MODE_NONE;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token)
 void
 rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
 int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 		      __rte_unused const char *dev_addr,
 		      __rte_unused int *vfio_dev_fd,
@@ -938,6 +947,7 @@ int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_release_device)
 int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 			__rte_unused const char *dev_addr,
 			__rte_unused int fd)
@@ -946,28 +956,33 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_enable)
 int rte_vfio_enable(__rte_unused const char *modname)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
 int rte_vfio_is_enabled(__rte_unused const char *modname)
 {
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
 int rte_vfio_noiommu_is_enabled(void)
 {
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
 int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 		       __rte_unused const char *dev_addr,
@@ -977,6 +992,7 @@ rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
 int
 rte_vfio_get_container_fd(void)
 {
@@ -984,6 +1000,7 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
 int
 rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 {
@@ -991,6 +1008,7 @@ rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
@@ -998,6 +1016,7 @@ rte_vfio_container_create(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
 int
 rte_vfio_container_destroy(__rte_unused int container_fd)
 {
@@ -1005,6 +1024,7 @@ rte_vfio_container_destroy(__rte_unused int container_fd)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -1013,6 +1033,7 @@ rte_vfio_container_group_bind(__rte_unused int container_fd,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -1021,6 +1042,7 @@ rte_vfio_container_group_unbind(__rte_unused int container_fd,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -1031,6 +1053,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index 3680f5caba..28f285fdef 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -12,6 +12,7 @@
 #include <time.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_alarm.h>
 #include <rte_cycles.h>
@@ -200,6 +201,7 @@ eal_alarm_callback(void *arg __rte_unused)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -252,6 +254,7 @@ rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/freebsd/eal_dev.c b/lib/eal/freebsd/eal_dev.c
index d8659cc7fc..737d1040ea 100644
--- a/lib/eal/freebsd/eal_dev.c
+++ b/lib/eal/freebsd/eal_dev.c
@@ -5,8 +5,10 @@
 #include <rte_log.h>
 #include <rte_dev.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
 int
 rte_dev_event_monitor_start(void)
 {
@@ -14,6 +16,7 @@ rte_dev_event_monitor_start(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -21,6 +24,7 @@ rte_dev_event_monitor_stop(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -28,6 +32,7 @@ rte_dev_hotplug_handle_enable(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 23747babc2..5c3ab6699e 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -8,6 +8,7 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
@@ -80,6 +81,7 @@ intr_source_to_kevent(const struct rte_intr_handle *ih, struct kevent *ke)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_register)
 int
 rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb, void *cb_arg)
@@ -211,6 +213,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
 int
 rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 				rte_intr_callback_fn cb_fn, void *cb_arg,
@@ -267,6 +270,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
 int
 rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -354,6 +358,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
 int
 rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 		rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -366,6 +371,7 @@ rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_enable)
 int
 rte_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -407,6 +413,7 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_disable)
 int
 rte_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -447,6 +454,7 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_ack)
 int
 rte_intr_ack(const struct rte_intr_handle *intr_handle)
 {
@@ -648,6 +656,7 @@ rte_eal_intr_init(void)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
 int
 rte_intr_rx_ctl(struct rte_intr_handle *intr_handle,
 		int epfd, int op, unsigned int vec, void *data)
@@ -661,6 +670,7 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -670,12 +680,14 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
@@ -683,6 +695,7 @@ rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -690,6 +703,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
@@ -697,6 +711,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait)
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 		int maxevents, int timeout)
@@ -709,6 +724,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -721,6 +737,7 @@ rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_ctl)
 int
 rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 {
@@ -732,18 +749,21 @@ rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
 int
 rte_intr_tls_epfd(void)
 {
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_is_intr)
 int rte_thread_is_intr(void)
 {
 	return rte_thread_equal(intr_thread, rte_thread_self());
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index a6f3ba226e..3b72e13506 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -15,6 +15,7 @@
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_internal_cfg.h"
 #include "eal_filesystem.h"
@@ -36,6 +37,7 @@ uint64_t eal_get_baseaddr(void)
 /*
  * Get physical address of any mapped virtual address in the current process.
  */
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
 phys_addr_t
 rte_mem_virt2phy(const void *virtaddr)
 {
@@ -44,6 +46,7 @@ rte_mem_virt2phy(const void *virtaddr)
 	(void)virtaddr;
 	return RTE_BAD_IOVA;
 }
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
 rte_iova_t
 rte_mem_virt2iova(const void *virtaddr)
 {
@@ -295,6 +298,7 @@ rte_eal_hugepage_attach(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
 int
 rte_eal_using_phys_addrs(void)
 {
diff --git a/lib/eal/freebsd/eal_thread.c b/lib/eal/freebsd/eal_thread.c
index 77b7621908..7ed76ed796 100644
--- a/lib/eal/freebsd/eal_thread.c
+++ b/lib/eal/freebsd/eal_thread.c
@@ -21,10 +21,12 @@
 #include <rte_eal.h>
 #include <rte_lcore.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_thread.h"
 
 /* require calling thread tid by gettid() */
+RTE_EXPORT_SYMBOL(rte_sys_gettid)
 int rte_sys_gettid(void)
 {
 	long lwpid;
@@ -32,6 +34,7 @@ int rte_sys_gettid(void)
 	return (int)lwpid;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_name)
 void rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
 	char truncated[RTE_THREAD_NAME_SIZE];
diff --git a/lib/eal/freebsd/eal_timer.c b/lib/eal/freebsd/eal_timer.c
index 4eba66eadb..d21ffa2694 100644
--- a/lib/eal/freebsd/eal_timer.c
+++ b/lib/eal/freebsd/eal_timer.c
@@ -16,6 +16,7 @@
 #include <rte_eal.h>
 #include <rte_debug.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_internal_cfg.h"
 
@@ -23,6 +24,7 @@
 #warning HPET is not supported in FreeBSD
 #endif
 
+RTE_EXPORT_SYMBOL(eal_timer_source)
 enum timer_source eal_timer_source = EAL_TIMER_TSC;
 
 uint64_t
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b1e63e37fc..20f777b8b0 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -43,6 +43,7 @@
 #include <rte_vfio.h>
 
 #include <telemetry_internal.h>
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_thread.h"
 #include "eal_lcore_var.h"
@@ -77,6 +78,7 @@ static struct flock wr_lock = {
 struct lcore_config lcore_config[RTE_MAX_LCORE];
 
 /* used by rte_rdtsc() */
+RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
 int rte_cycles_vmware_tsc_map;
 
 
@@ -819,6 +821,7 @@ sync_func(__rte_unused void *arg)
  * iopl() call is mostly for the i386 architecture. For other architectures,
  * return -1 to indicate IO privilege can't be changed in this way.
  */
+RTE_EXPORT_SYMBOL(rte_eal_iopl_init)
 int
 rte_eal_iopl_init(void)
 {
@@ -914,6 +917,7 @@ eal_worker_thread_create(unsigned int lcore_id)
 }
 
 /* Launch threads, called at application init(). */
+RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -1294,6 +1298,7 @@ mark_freeable(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
 {
@@ -1336,6 +1341,7 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
 int rte_eal_create_uio_dev(void)
 {
 	const struct internal_config *internal_conf =
@@ -1344,6 +1350,7 @@ int rte_eal_create_uio_dev(void)
 	return internal_conf->create_uio_dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
 enum rte_intr_mode
 rte_eal_vfio_intr_mode(void)
 {
@@ -1353,6 +1360,7 @@ rte_eal_vfio_intr_mode(void)
 	return internal_conf->vfio_intr_mode;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token)
 void
 rte_eal_vfio_get_vf_token(rte_uuid_t vf_token)
 {
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index 9fe14ade63..b216a007a3 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -10,6 +10,7 @@
 #include <sys/time.h>
 #include <sys/timerfd.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_interrupts.h>
 #include <rte_alarm.h>
@@ -127,6 +128,7 @@ eal_alarm_callback(void *arg __rte_unused)
 	rte_spinlock_unlock(&alarm_list_lk);
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -191,6 +193,7 @@ rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index be97f56424..33b78464d5 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -18,6 +18,7 @@
 #include <rte_spinlock.h>
 #include <rte_errno.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 static struct rte_intr_handle *intr_handle;
@@ -303,6 +304,7 @@ dev_uev_handler(__rte_unused void *param)
 	free(uevent.devname);
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
 int
 rte_dev_event_monitor_start(void)
 {
@@ -353,6 +355,7 @@ rte_dev_event_monitor_start(void)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -421,6 +424,7 @@ dev_sigbus_handler_unregister(void)
 	return rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -436,6 +440,7 @@ rte_dev_hotplug_handle_enable(void)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 23039964fc..4ec78de82c 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -15,6 +15,7 @@
 #include <assert.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_common.h>
 #include <rte_interrupts.h>
@@ -482,6 +483,7 @@ uio_intr_enable(const struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_register)
 int
 rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb, void *cb_arg)
@@ -566,6 +568,7 @@ rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
 int
 rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 				rte_intr_callback_fn cb_fn, void *cb_arg,
@@ -617,6 +620,7 @@ rte_intr_callback_unregister_pending(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
 int
 rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -683,6 +687,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
 int
 rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 			rte_intr_callback_fn cb_fn, void *cb_arg)
@@ -695,6 +700,7 @@ rte_intr_callback_unregister_sync(const struct rte_intr_handle *intr_handle,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_enable)
 int
 rte_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -775,6 +781,7 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
  * auto-masked. In fact, for interrupt handle types VFIO_MSIX and VFIO_MSI,
  * this function is no-op.
  */
+RTE_EXPORT_SYMBOL(rte_intr_ack)
 int
 rte_intr_ack(const struct rte_intr_handle *intr_handle)
 {
@@ -827,6 +834,7 @@ rte_intr_ack(const struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_disable)
 int
 rte_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -1305,6 +1313,7 @@ eal_init_tls_epfd(void)
 	return pfd;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
 int
 rte_intr_tls_epfd(void)
 {
@@ -1377,6 +1386,7 @@ eal_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait)
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	       int maxevents, int timeout)
@@ -1384,6 +1394,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return eal_epoll_wait(epfd, events, maxevents, timeout, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -1408,6 +1419,7 @@ eal_epoll_data_safe_free(struct rte_epoll_event *ev)
 	ev->epfd = -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_ctl)
 int
 rte_epoll_ctl(int epfd, int op, int fd,
 	      struct rte_epoll_event *event)
@@ -1449,6 +1461,7 @@ rte_epoll_ctl(int epfd, int op, int fd,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
 int
 rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 		int op, unsigned int vec, void *data)
@@ -1514,6 +1527,7 @@ rte_intr_rx_ctl(struct rte_intr_handle *intr_handle, int epfd,
 	return rc;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
@@ -1532,6 +1546,7 @@ rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -1579,6 +1594,7 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
@@ -1593,12 +1609,14 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 	rte_intr_max_intr_set(intr_handle, 0);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
 	return !(!rte_intr_nb_efd_get(intr_handle));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -1609,6 +1627,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 				rte_intr_nb_efd_get(intr_handle));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
@@ -1621,6 +1640,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_is_intr)
 int rte_thread_is_intr(void)
 {
 	return rte_thread_equal(intr_thread, rte_thread_self());
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 9dda60c0e1..8c896379fe 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -34,6 +34,7 @@
 #include <rte_lcore.h>
 #include <rte_common.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_memalloc.h"
 #include "eal_memcfg.h"
@@ -87,6 +88,7 @@ uint64_t eal_get_baseaddr(void)
 /*
  * Get physical address of any mapped virtual address in the current process.
  */
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
 phys_addr_t
 rte_mem_virt2phy(const void *virtaddr)
 {
@@ -144,6 +146,7 @@ rte_mem_virt2phy(const void *virtaddr)
 	return physaddr;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
 rte_iova_t
 rte_mem_virt2iova(const void *virtaddr)
 {
@@ -1673,6 +1676,7 @@ rte_eal_hugepage_attach(void)
 			eal_hugepage_attach();
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
 int
 rte_eal_using_phys_addrs(void)
 {
diff --git a/lib/eal/linux/eal_thread.c b/lib/eal/linux/eal_thread.c
index 7051840cdf..c0056f825d 100644
--- a/lib/eal/linux/eal_thread.c
+++ b/lib/eal/linux/eal_thread.c
@@ -13,14 +13,17 @@
 #include <rte_log.h>
 #include <rte_string_fns.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 /* require calling thread tid by gettid() */
+RTE_EXPORT_SYMBOL(rte_sys_gettid)
 int rte_sys_gettid(void)
 {
 	return (int)syscall(SYS_gettid);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_name)
 void rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
 	int ret = ENOSYS;
diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 489732c116..0e670a0af6 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -16,8 +16,10 @@
 #include <rte_cycles.h>
 #include <rte_thread.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
+RTE_EXPORT_SYMBOL(eal_timer_source)
 enum timer_source eal_timer_source = EAL_TIMER_HPET;
 
 #ifdef RTE_LIBEAL_USE_HPET
@@ -93,6 +95,7 @@ hpet_msb_inc(__rte_unused void *arg)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_get_hpet_hz)
 uint64_t
 rte_get_hpet_hz(void)
 {
@@ -105,6 +108,7 @@ rte_get_hpet_hz(void)
 	return eal_hpet_resolution_hz;
 }
 
+RTE_EXPORT_SYMBOL(rte_get_hpet_cycles)
 uint64_t
 rte_get_hpet_cycles(void)
 {
@@ -131,6 +135,7 @@ rte_get_hpet_cycles(void)
  * Open and mmap /dev/hpet (high precision event timer) that will
  * provide our time reference.
  */
+RTE_EXPORT_SYMBOL(rte_eal_hpet_init)
 int
 rte_eal_hpet_init(int make_default)
 {
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 7132e24cba..2f5f221a0d 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -14,6 +14,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_vfio.h>
 
+#include <eal_export.h>
 #include "eal_filesystem.h"
 #include "eal_memcfg.h"
 #include "eal_vfio.h"
@@ -515,6 +516,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
 int
 rte_vfio_get_group_fd(int iommu_group_num)
 {
@@ -713,6 +715,7 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
 int
 rte_vfio_clear_group(int vfio_group_fd)
 {
@@ -736,6 +739,7 @@ rte_vfio_clear_group(int vfio_group_fd)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
 int
 rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
@@ -989,6 +993,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_release_device)
 int
 rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		    int vfio_dev_fd)
@@ -1077,6 +1082,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_enable)
 int
 rte_vfio_enable(const char *modname)
 {
@@ -1143,6 +1149,7 @@ rte_vfio_enable(const char *modname)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
 int
 rte_vfio_is_enabled(const char *modname)
 {
@@ -1225,6 +1232,7 @@ vfio_set_iommu_type(int vfio_container_fd)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 24.03)
 int
 rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
@@ -1284,6 +1292,7 @@ vfio_has_supported_extensions(int vfio_container_fd)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
 int
 rte_vfio_get_container_fd(void)
 {
@@ -1355,6 +1364,7 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(const char *sysfs_base,
 		const char *dev_addr, int *iommu_group_num)
@@ -2024,6 +2034,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
 int
 rte_vfio_noiommu_is_enabled(void)
 {
@@ -2056,6 +2067,7 @@ rte_vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
@@ -2081,6 +2093,7 @@ rte_vfio_container_create(void)
 	return vfio_cfgs[i].vfio_container_fd;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
 int
 rte_vfio_container_destroy(int container_fd)
 {
@@ -2106,6 +2119,7 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
@@ -2120,6 +2134,7 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
@@ -2160,6 +2175,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
@@ -2180,6 +2196,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_map(vfio_cfg, vaddr, iova, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
diff --git a/lib/eal/loongarch/rte_cpuflags.c b/lib/eal/loongarch/rte_cpuflags.c
index db9e28ef20..19fbf37e3e 100644
--- a/lib/eal/loongarch/rte_cpuflags.c
+++ b/lib/eal/loongarch/rte_cpuflags.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2022 Loongson Technology Corporation Limited
  */
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
 #include <elf.h>
@@ -61,6 +62,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -78,6 +80,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -86,6 +89,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/loongarch/rte_hypervisor.c b/lib/eal/loongarch/rte_hypervisor.c
index d044906f71..7dd70fe90c 100644
--- a/lib/eal/loongarch/rte_hypervisor.c
+++ b/lib/eal/loongarch/rte_hypervisor.c
@@ -2,8 +2,10 @@
  * Copyright(c) 2022 Loongson Technology Corporation Limited
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get)
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/loongarch/rte_power_intrinsics.c b/lib/eal/loongarch/rte_power_intrinsics.c
index a8969c260e..e1a2b2d7ed 100644
--- a/lib/eal/loongarch/rte_power_intrinsics.c
+++ b/lib/eal/loongarch/rte_power_intrinsics.c
@@ -4,11 +4,13 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include "rte_power_intrinsics.h"
 
 /**
  * This function is not supported on LOONGARCH.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor)
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -22,6 +24,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on LOONGARCH.
  */
+RTE_EXPORT_SYMBOL(rte_power_pause)
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -33,6 +36,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on LOONGARCH.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -41,6 +45,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/ppc/rte_cpuflags.c b/lib/eal/ppc/rte_cpuflags.c
index d276c2cf88..a78a7d1b53 100644
--- a/lib/eal/ppc/rte_cpuflags.c
+++ b/lib/eal/ppc/rte_cpuflags.c
@@ -3,6 +3,7 @@
  * Copyright (C) IBM Corporation 2014.
  */
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
 #include <elf.h>
@@ -85,6 +86,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -102,6 +104,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -110,6 +113,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/ppc/rte_hypervisor.c b/lib/eal/ppc/rte_hypervisor.c
index 08a1c97d10..51b224fb94 100644
--- a/lib/eal/ppc/rte_hypervisor.c
+++ b/lib/eal/ppc/rte_hypervisor.c
@@ -2,8 +2,10 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get)
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/ppc/rte_power_intrinsics.c b/lib/eal/ppc/rte_power_intrinsics.c
index d6bdc58911..d9d8eb8d51 100644
--- a/lib/eal/ppc/rte_power_intrinsics.c
+++ b/lib/eal/ppc/rte_power_intrinsics.c
@@ -4,11 +4,13 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include "rte_power_intrinsics.h"
 
 /**
  * This function is not supported on PPC64.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor)
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -22,6 +24,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on PPC64.
  */
+RTE_EXPORT_SYMBOL(rte_power_pause)
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -33,6 +36,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on PPC64.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -41,6 +45,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/riscv/rte_cpuflags.c b/lib/eal/riscv/rte_cpuflags.c
index eb4105c18b..4dec491b0d 100644
--- a/lib/eal/riscv/rte_cpuflags.c
+++ b/lib/eal/riscv/rte_cpuflags.c
@@ -4,6 +4,7 @@
  * Copyright(c) 2022 Semihalf
  */
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
 #include <elf.h>
@@ -90,6 +91,7 @@ rte_cpu_get_features(hwcap_registers_t out)
 /*
  * Checks if a particular flag is available on current machine.
  */
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -107,6 +109,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return (regs[feat->reg] >> feat->bit) & 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -115,6 +118,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/riscv/rte_hypervisor.c b/lib/eal/riscv/rte_hypervisor.c
index 92b5435993..73020f7753 100644
--- a/lib/eal/riscv/rte_hypervisor.c
+++ b/lib/eal/riscv/rte_hypervisor.c
@@ -4,8 +4,10 @@
  * Copyright(c) 2022 Semihalf
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get)
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/riscv/rte_power_intrinsics.c b/lib/eal/riscv/rte_power_intrinsics.c
index 1c86573c19..11eff53ff2 100644
--- a/lib/eal/riscv/rte_power_intrinsics.c
+++ b/lib/eal/riscv/rte_power_intrinsics.c
@@ -6,11 +6,13 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include "rte_power_intrinsics.h"
 
 /**
  * This function is not supported on RISC-V 64
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor)
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		  const uint64_t tsc_timestamp)
@@ -24,6 +26,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 /**
  * This function is not supported on RISC-V 64
  */
+RTE_EXPORT_SYMBOL(rte_power_pause)
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -35,6 +38,7 @@ rte_power_pause(const uint64_t tsc_timestamp)
 /**
  * This function is not supported on RISC-V 64
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -46,6 +50,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 /**
  * This function is not supported on RISC-V 64
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 			const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/unix/eal_debug.c b/lib/eal/unix/eal_debug.c
index 69ba3758c2..e3689531e4 100644
--- a/lib/eal/unix/eal_debug.c
+++ b/lib/eal/unix/eal_debug.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_debug.h>
 
 #ifdef RTE_BACKTRACE
@@ -46,6 +47,7 @@ static char *safe_itoa(long val, char *buf, size_t len, unsigned int radix)
  * Most of libc is therefore not safe, include RTE_LOG (calls syslog);
  * backtrace_symbols (calls malloc), etc.
  */
+RTE_EXPORT_SYMBOL(rte_dump_stack)
 void rte_dump_stack(void)
 {
 	void *func[BACKTRACE_SIZE];
@@ -122,6 +124,7 @@ void rte_dump_stack(void)
 #else /* !RTE_BACKTRACE */
 
 /* stub if not enabled */
+RTE_EXPORT_SYMBOL(rte_dump_stack)
 void rte_dump_stack(void) { }
 
 #endif /* RTE_BACKTRACE */
diff --git a/lib/eal/unix/eal_filesystem.c b/lib/eal/unix/eal_filesystem.c
index 6cd5f1492c..6b8451cd3e 100644
--- a/lib/eal/unix/eal_filesystem.c
+++ b/lib/eal/unix/eal_filesystem.c
@@ -14,6 +14,7 @@
 
 #include <rte_log.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 #include "eal_filesystem.h"
 
@@ -77,6 +78,7 @@ int eal_create_runtime_dir(void)
 }
 
 /* parse a sysfs (or other) file containing one integer value */
+RTE_EXPORT_SYMBOL(eal_parse_sysfs_value)
 int eal_parse_sysfs_value(const char *filename, unsigned long *val)
 {
 	FILE *f;
diff --git a/lib/eal/unix/eal_firmware.c b/lib/eal/unix/eal_firmware.c
index 0d69b1e3f0..f2c16fb8a7 100644
--- a/lib/eal/unix/eal_firmware.c
+++ b/lib/eal/unix/eal_firmware.c
@@ -13,6 +13,7 @@
 #include <rte_common.h>
 #include <rte_log.h>
 
+#include <eal_export.h>
 #include "eal_firmware.h"
 #include "eal_private.h"
 
@@ -146,6 +147,7 @@ firmware_read(const char *name, void **buf, size_t *bufsz)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
 int
 rte_firmware_read(const char *name, void **buf, size_t *bufsz)
 {
diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index 97969a401b..c540f1e838 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -11,6 +11,7 @@
 #include <rte_errno.h>
 #include <rte_log.h>
 
+#include <eal_export.h>
 #include "eal_private.h"
 
 #ifdef RTE_EXEC_ENV_LINUX
@@ -105,6 +106,7 @@ mem_rte_to_sys_prot(int prot)
 	return sys_prot;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map)
 void *
 rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	int fd, uint64_t offset)
@@ -126,12 +128,14 @@ rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	return mem_map(requested_addr, size, sys_prot, sys_flags, fd, offset);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap)
 int
 rte_mem_unmap(void *virt, size_t size)
 {
 	return mem_unmap(virt, size);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size)
 size_t
 rte_mem_page_size(void)
 {
@@ -143,6 +147,7 @@ rte_mem_page_size(void)
 	return page_size;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock)
 int
 rte_mem_lock(const void *virt, size_t size)
 {
diff --git a/lib/eal/unix/eal_unix_timer.c b/lib/eal/unix/eal_unix_timer.c
index e71602b3a1..3dbcf61e90 100644
--- a/lib/eal/unix/eal_unix_timer.c
+++ b/lib/eal/unix/eal_unix_timer.c
@@ -5,8 +5,10 @@
 #include <errno.h>
 #include <time.h>
 
+#include <eal_export.h>
 #include <rte_cycles.h>
 
+RTE_EXPORT_SYMBOL(rte_delay_us_sleep)
 void
 rte_delay_us_sleep(unsigned int us)
 {
diff --git a/lib/eal/unix/rte_thread.c b/lib/eal/unix/rte_thread.c
index ea629c2065..950c0848ba 100644
--- a/lib/eal/unix/rte_thread.c
+++ b/lib/eal/unix/rte_thread.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_thread.h>
@@ -118,6 +119,7 @@ thread_start_wrapper(void *arg)
 }
 #endif
 
+RTE_EXPORT_SYMBOL(rte_thread_create)
 int
 rte_thread_create(rte_thread_t *thread_id,
 		const rte_thread_attr_t *thread_attr,
@@ -226,6 +228,7 @@ rte_thread_create(rte_thread_t *thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_join)
 int
 rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 {
@@ -248,18 +251,21 @@ rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_detach)
 int
 rte_thread_detach(rte_thread_t thread_id)
 {
 	return pthread_detach((pthread_t)thread_id.opaque_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_equal)
 int
 rte_thread_equal(rte_thread_t t1, rte_thread_t t2)
 {
 	return pthread_equal((pthread_t)t1.opaque_id, (pthread_t)t2.opaque_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_self)
 rte_thread_t
 rte_thread_self(void)
 {
@@ -272,6 +278,7 @@ rte_thread_self(void)
 	return thread_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_get_priority)
 int
 rte_thread_get_priority(rte_thread_t thread_id,
 	enum rte_thread_priority *priority)
@@ -294,6 +301,7 @@ rte_thread_get_priority(rte_thread_t thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_priority)
 int
 rte_thread_set_priority(rte_thread_t thread_id,
 	enum rte_thread_priority priority)
@@ -315,6 +323,7 @@ rte_thread_set_priority(rte_thread_t thread_id,
 		&param);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_key_create)
 int
 rte_thread_key_create(rte_thread_key *key, void (*destructor)(void *))
 {
@@ -337,6 +346,7 @@ rte_thread_key_create(rte_thread_key *key, void (*destructor)(void *))
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_key_delete)
 int
 rte_thread_key_delete(rte_thread_key key)
 {
@@ -359,6 +369,7 @@ rte_thread_key_delete(rte_thread_key key)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_value_set)
 int
 rte_thread_value_set(rte_thread_key key, const void *value)
 {
@@ -379,6 +390,7 @@ rte_thread_value_set(rte_thread_key key, const void *value)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_value_get)
 void *
 rte_thread_value_get(rte_thread_key key)
 {
@@ -390,6 +402,7 @@ rte_thread_value_get(rte_thread_key key)
 	return pthread_getspecific(key->thread_index);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id)
 int
 rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		const rte_cpuset_t *cpuset)
@@ -398,6 +411,7 @@ rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		sizeof(*cpuset), cpuset);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id)
 int
 rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 5c7526f922..cca0a0b1a3 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -9,6 +9,7 @@
 #include <share.h>
 #include <sys/stat.h>
 
+#include <eal_export.h>
 #include <rte_debug.h>
 #include <rte_bus.h>
 #include <rte_eal.h>
@@ -74,6 +75,7 @@ eal_proc_type_detect(void)
 	return ptype;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_disable)
 bool
 rte_mp_disable(void)
 {
@@ -189,9 +191,12 @@ rte_eal_init_alert(const char *msg)
  * until eal_common_trace.c can be compiled.
  */
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_point_sz, 20.05)
 RTE_DEFINE_PER_LCORE(volatile int, trace_point_sz);
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(per_lcore_trace_mem, 20.05)
 RTE_DEFINE_PER_LCORE(void *, trace_mem);
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05)
 void
 __rte_trace_mem_per_thread_alloc(void)
 {
@@ -202,6 +207,7 @@ trace_mem_per_thread_free(void)
 {
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05)
 void
 __rte_trace_point_emit_field(size_t sz, const char *field,
 	const char *type)
@@ -211,6 +217,7 @@ __rte_trace_point_emit_field(size_t sz, const char *field,
 	RTE_SET_USED(type);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_register, 20.05)
 int
 __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 	void (*register_fn)(void))
@@ -221,6 +228,7 @@ __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
 {
@@ -238,6 +246,7 @@ rte_eal_cleanup(void)
 }
 
 /* Launch threads, called at application init(). */
+RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
@@ -511,6 +520,7 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -521,6 +531,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -531,6 +542,7 @@ rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
 int
 rte_firmware_read(__rte_unused const char *name,
 			__rte_unused void **buf,
diff --git a/lib/eal/windows/eal_alarm.c b/lib/eal/windows/eal_alarm.c
index 5cd7b254a1..0b11d331dc 100644
--- a/lib/eal/windows/eal_alarm.c
+++ b/lib/eal/windows/eal_alarm.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_alarm.h>
 #include <rte_spinlock.h>
 
@@ -83,6 +84,7 @@ alarm_task_exec(void *arg)
 	task->ret = alarm_set(task->entry, task->deadline);
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_set)
 int
 rte_eal_alarm_set(uint64_t us, rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
@@ -184,6 +186,7 @@ alarm_matches(const struct alarm_entry *ap,
 	return (ap->cb_fn == cb_fn) && (any_arg || ap->cb_arg == cb_arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
diff --git a/lib/eal/windows/eal_debug.c b/lib/eal/windows/eal_debug.c
index 4a6303a2a9..a4549e1179 100644
--- a/lib/eal/windows/eal_debug.c
+++ b/lib/eal/windows/eal_debug.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdarg.h>
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_windows.h>
@@ -14,6 +15,7 @@
 #define BACKTRACE_SIZE 256
 
 /* dump the stack of the calling core */
+RTE_EXPORT_SYMBOL(rte_dump_stack)
 void
 rte_dump_stack(void)
 {
diff --git a/lib/eal/windows/eal_dev.c b/lib/eal/windows/eal_dev.c
index e0b8c54dc5..9c7463edf2 100644
--- a/lib/eal/windows/eal_dev.c
+++ b/lib/eal/windows/eal_dev.c
@@ -2,10 +2,12 @@
  * Copyright(c) 2021 Microsoft Corporation
  */
 
+#include <eal_export.h>
 #include <rte_dev.h>
 
 #include "eal_private.h"
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_start)
 int
 rte_dev_event_monitor_start(void)
 {
@@ -13,6 +15,7 @@ rte_dev_event_monitor_start(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_event_monitor_stop)
 int
 rte_dev_event_monitor_stop(void)
 {
@@ -20,6 +23,7 @@ rte_dev_event_monitor_stop(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_enable)
 int
 rte_dev_hotplug_handle_enable(void)
 {
@@ -27,6 +31,7 @@ rte_dev_hotplug_handle_enable(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_dev_hotplug_handle_disable)
 int
 rte_dev_hotplug_handle_disable(void)
 {
diff --git a/lib/eal/windows/eal_interrupts.c b/lib/eal/windows/eal_interrupts.c
index c97118d231..5ff30c7631 100644
--- a/lib/eal/windows/eal_interrupts.c
+++ b/lib/eal/windows/eal_interrupts.c
@@ -2,6 +2,7 @@
  * Copyright 2020 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include <rte_interrupts.h>
 
 #include "eal_private.h"
@@ -108,12 +109,14 @@ rte_eal_intr_init(void)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_is_intr)
 int
 rte_thread_is_intr(void)
 {
 	return rte_thread_equal(intr_thread, rte_thread_self());
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_rx_ctl)
 int
 rte_intr_rx_ctl(__rte_unused struct rte_intr_handle *intr_handle,
 		__rte_unused int epfd, __rte_unused int op,
@@ -147,6 +150,7 @@ eal_intr_thread_cancel(void)
 	WaitForSingleObject(intr_thread_handle, INFINITE);
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_register)
 int
 rte_intr_callback_register(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -155,6 +159,7 @@ rte_intr_callback_register(
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_pending)
 int
 rte_intr_callback_unregister_pending(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -164,6 +169,7 @@ rte_intr_callback_unregister_pending(
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister)
 int
 rte_intr_callback_unregister(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -172,6 +178,7 @@ rte_intr_callback_unregister(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_callback_unregister_sync)
 int
 rte_intr_callback_unregister_sync(
 	__rte_unused const struct rte_intr_handle *intr_handle,
@@ -180,24 +187,28 @@ rte_intr_callback_unregister_sync(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_enable)
 int
 rte_intr_enable(__rte_unused const struct rte_intr_handle *intr_handle)
 {
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_ack)
 int
 rte_intr_ack(__rte_unused const struct rte_intr_handle *intr_handle)
 {
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_intr_disable)
 int
 rte_intr_disable(__rte_unused const struct rte_intr_handle *intr_handle)
 {
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
@@ -207,12 +218,14 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dp_is_en)
 int
 rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 {
@@ -221,6 +234,7 @@ rte_intr_dp_is_en(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_allow_others)
 int
 rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 {
@@ -229,6 +243,7 @@ rte_intr_allow_others(struct rte_intr_handle *intr_handle)
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_cap_multiple)
 int
 rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 {
@@ -237,6 +252,7 @@ rte_intr_cap_multiple(struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait)
 int
 rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 		int maxevents, int timeout)
@@ -249,6 +265,7 @@ rte_epoll_wait(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_wait_interruptible)
 int
 rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 			     int maxevents, int timeout)
@@ -261,6 +278,7 @@ rte_epoll_wait_interruptible(int epfd, struct rte_epoll_event *events,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_epoll_ctl)
 int
 rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 {
@@ -272,12 +290,14 @@ rte_epoll_ctl(int epfd, int op, int fd, struct rte_epoll_event *event)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_tls_epfd)
 int
 rte_intr_tls_epfd(void)
 {
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_free_epoll_fd)
 void
 rte_intr_free_epoll_fd(struct rte_intr_handle *intr_handle)
 {
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 8de92d4089..9f85191016 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -5,6 +5,7 @@
 #include <inttypes.h>
 #include <io.h>
 
+#include <eal_export.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
 
@@ -212,6 +213,7 @@ eal_mem_virt2iova_cleanup(void)
 		CloseHandle(virt2phys_device);
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
 phys_addr_t
 rte_mem_virt2phy(const void *virt)
 {
@@ -232,6 +234,7 @@ rte_mem_virt2phy(const void *virt)
 	return phys.QuadPart;
 }
 
+RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
 rte_iova_t
 rte_mem_virt2iova(const void *virt)
 {
@@ -247,6 +250,7 @@ rte_mem_virt2iova(const void *virt)
 }
 
 /* Always using physical addresses under Windows if they can be obtained. */
+RTE_EXPORT_SYMBOL(rte_eal_using_phys_addrs)
 int
 rte_eal_using_phys_addrs(void)
 {
@@ -518,6 +522,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_map)
 void *
 rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	int fd, uint64_t offset)
@@ -601,6 +606,7 @@ rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 	return virt;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_unmap)
 int
 rte_mem_unmap(void *virt, size_t size)
 {
@@ -624,6 +630,7 @@ eal_get_baseaddr(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_page_size)
 size_t
 rte_mem_page_size(void)
 {
@@ -635,6 +642,7 @@ rte_mem_page_size(void)
 	return info.dwPageSize;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mem_lock)
 int
 rte_mem_lock(const void *virt, size_t size)
 {
diff --git a/lib/eal/windows/eal_mp.c b/lib/eal/windows/eal_mp.c
index 76413f49a3..6703355318 100644
--- a/lib/eal/windows/eal_mp.c
+++ b/lib/eal/windows/eal_mp.c
@@ -10,6 +10,7 @@
  * must document what requires success emulation.
  */
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_errno.h>
 
@@ -24,6 +25,7 @@ rte_mp_channel_cleanup(void)
 	EAL_LOG_NOT_IMPLEMENTED();
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_action_register)
 int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
@@ -33,6 +35,7 @@ rte_mp_action_register(const char *name, rte_mp_t action)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_action_unregister)
 void
 rte_mp_action_unregister(const char *name)
 {
@@ -40,6 +43,7 @@ rte_mp_action_unregister(const char *name)
 	EAL_LOG_NOT_IMPLEMENTED();
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
@@ -48,6 +52,7 @@ rte_mp_sendmsg(struct rte_mp_msg *msg)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_request_sync)
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	const struct timespec *ts)
@@ -59,6 +64,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_request_async)
 int
 rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		rte_mp_async_reply_t clb)
@@ -70,6 +76,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_mp_reply)
 int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
diff --git a/lib/eal/windows/eal_thread.c b/lib/eal/windows/eal_thread.c
index 9e3df200b9..3eeb94a589 100644
--- a/lib/eal/windows/eal_thread.c
+++ b/lib/eal/windows/eal_thread.c
@@ -4,6 +4,7 @@
 
 #include <io.h>
 
+#include <eal_export.h>
 #include <rte_atomic.h>
 #include <rte_debug.h>
 #include <rte_launch.h>
@@ -71,6 +72,7 @@ eal_thread_ack_command(void)
 }
 
 /* get current thread ID */
+RTE_EXPORT_SYMBOL(rte_sys_gettid)
 int
 rte_sys_gettid(void)
 {
diff --git a/lib/eal/windows/eal_timer.c b/lib/eal/windows/eal_timer.c
index 020035c4cc..33cbac6a03 100644
--- a/lib/eal/windows/eal_timer.c
+++ b/lib/eal/windows/eal_timer.c
@@ -4,6 +4,7 @@
 
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_windows.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
@@ -14,6 +15,7 @@
 #define US_PER_SEC 1E6
 #define CYC_PER_100KHZ 1E5
 
+RTE_EXPORT_SYMBOL(rte_delay_us_sleep)
 void
 rte_delay_us_sleep(unsigned int us)
 {
diff --git a/lib/eal/windows/rte_thread.c b/lib/eal/windows/rte_thread.c
index 6f991dfa5d..85e5a57346 100644
--- a/lib/eal/windows/rte_thread.c
+++ b/lib/eal/windows/rte_thread.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <wchar.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_common.h>
 #include <rte_errno.h>
@@ -181,6 +182,7 @@ thread_func_wrapper(void *arg)
 	return (DWORD)ctx.thread_func(ctx.routine_args);
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_create)
 int
 rte_thread_create(rte_thread_t *thread_id,
 		  const rte_thread_attr_t *thread_attr,
@@ -258,6 +260,7 @@ rte_thread_create(rte_thread_t *thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_join)
 int
 rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 {
@@ -298,6 +301,7 @@ rte_thread_join(rte_thread_t thread_id, uint32_t *value_ptr)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_detach)
 int
 rte_thread_detach(rte_thread_t thread_id)
 {
@@ -307,12 +311,14 @@ rte_thread_detach(rte_thread_t thread_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_equal)
 int
 rte_thread_equal(rte_thread_t t1, rte_thread_t t2)
 {
 	return t1.opaque_id == t2.opaque_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_self)
 rte_thread_t
 rte_thread_self(void)
 {
@@ -323,6 +329,7 @@ rte_thread_self(void)
 	return thread_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_name)
 void
 rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 {
@@ -364,6 +371,7 @@ rte_thread_set_name(rte_thread_t thread_id, const char *thread_name)
 		EAL_LOG(DEBUG, "Failed to set thread name");
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_get_priority)
 int
 rte_thread_get_priority(rte_thread_t thread_id,
 	enum rte_thread_priority *priority)
@@ -403,6 +411,7 @@ rte_thread_get_priority(rte_thread_t thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_priority)
 int
 rte_thread_set_priority(rte_thread_t thread_id,
 			enum rte_thread_priority priority)
@@ -441,6 +450,7 @@ rte_thread_set_priority(rte_thread_t thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_key_create)
 int
 rte_thread_key_create(rte_thread_key *key,
 		__rte_unused void (*destructor)(void *))
@@ -461,6 +471,7 @@ rte_thread_key_create(rte_thread_key *key,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_key_delete)
 int
 rte_thread_key_delete(rte_thread_key key)
 {
@@ -479,6 +490,7 @@ rte_thread_key_delete(rte_thread_key key)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_value_set)
 int
 rte_thread_value_set(rte_thread_key key, const void *value)
 {
@@ -499,6 +511,7 @@ rte_thread_value_set(rte_thread_key key, const void *value)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_value_get)
 void *
 rte_thread_value_get(rte_thread_key key)
 {
@@ -518,6 +531,7 @@ rte_thread_value_get(rte_thread_key key)
 	return output;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_set_affinity_by_id)
 int
 rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 		const rte_cpuset_t *cpuset)
@@ -558,6 +572,7 @@ rte_thread_set_affinity_by_id(rte_thread_t thread_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_thread_get_affinity_by_id)
 int
 rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 		rte_cpuset_t *cpuset)
diff --git a/lib/eal/x86/rte_cpuflags.c b/lib/eal/x86/rte_cpuflags.c
index 90389c66fc..5d1f352e04 100644
--- a/lib/eal/x86/rte_cpuflags.c
+++ b/lib/eal/x86/rte_cpuflags.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
 #include <stdio.h>
@@ -148,6 +149,7 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(INVTSC, 0x80000007, 0, RTE_REG_EDX,  8)
 };
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 {
@@ -190,6 +192,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	return feat->value;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
 const char *
 rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 {
@@ -198,6 +201,7 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature)
 	return rte_cpu_feature_table[feature].name;
 }
 
+RTE_EXPORT_SYMBOL(rte_cpu_get_intrinsics_support)
 void
 rte_cpu_get_intrinsics_support(struct rte_cpu_intrinsics *intrinsics)
 {
diff --git a/lib/eal/x86/rte_hypervisor.c b/lib/eal/x86/rte_hypervisor.c
index 04fe76751a..0c649c1d41 100644
--- a/lib/eal/x86/rte_hypervisor.c
+++ b/lib/eal/x86/rte_hypervisor.c
@@ -2,6 +2,7 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
+#include <eal_export.h>
 #include "rte_hypervisor.h"
 
 #include <stdint.h>
@@ -13,6 +14,7 @@
 /* See http://lwn.net/Articles/301888/ */
 #define HYPERVISOR_INFO_LEAF 0x40000000
 
+RTE_EXPORT_SYMBOL(rte_hypervisor_get)
 enum rte_hypervisor
 rte_hypervisor_get(void)
 {
diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
index f7d558153e..1cb2e908c0 100644
--- a/lib/eal/x86/rte_power_intrinsics.c
+++ b/lib/eal/x86/rte_power_intrinsics.c
@@ -4,6 +4,7 @@
 
 #include <stdalign.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_lcore.h>
 #include <rte_lcore_var.h>
@@ -158,6 +159,7 @@ __check_val_size(const uint8_t sz)
  * For more information about usage of these instructions, please refer to
  * Intel(R) 64 and IA-32 Architectures Software Developer's Manual.
  */
+RTE_EXPORT_SYMBOL(rte_power_monitor)
 int
 rte_power_monitor(const struct rte_power_monitor_cond *pmc,
 		const uint64_t tsc_timestamp)
@@ -219,6 +221,7 @@ rte_power_monitor(const struct rte_power_monitor_cond *pmc,
  * information about usage of this instruction, please refer to Intel(R) 64 and
  * IA-32 Architectures Software Developer's Manual.
  */
+RTE_EXPORT_SYMBOL(rte_power_pause)
 int
 rte_power_pause(const uint64_t tsc_timestamp)
 {
@@ -263,6 +266,7 @@ RTE_INIT(rte_power_intrinsics_init) {
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_power_monitor_wakeup)
 int
 rte_power_monitor_wakeup(const unsigned int lcore_id)
 {
@@ -312,6 +316,7 @@ rte_power_monitor_wakeup(const unsigned int lcore_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_monitor_multi)
 int
 rte_power_monitor_multi(const struct rte_power_monitor_cond pmc[],
 		const uint32_t num, const uint64_t tsc_timestamp)
diff --git a/lib/eal/x86/rte_spinlock.c b/lib/eal/x86/rte_spinlock.c
index 34890ea87c..da783919e5 100644
--- a/lib/eal/x86/rte_spinlock.c
+++ b/lib/eal/x86/rte_spinlock.c
@@ -4,8 +4,10 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include "rte_cpuflags.h"
 
+RTE_EXPORT_SYMBOL(rte_rtm_supported)
 uint8_t rte_rtm_supported; /* cache the flag to avoid the overhead
 			      of the rte_cpu_get_flag_enabled function */
 
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 3cbb3c2719..b0e44e5c51 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_cpuflags.h>
 #include <rte_string_fns.h>
 #include <rte_log.h>
@@ -496,6 +497,7 @@ efd_search_hash(struct rte_efd_table * const table,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_create)
 struct rte_efd_table *
 rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 		uint64_t online_cpu_socket_bitmask, uint8_t offline_cpu_socket)
@@ -720,6 +722,7 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_find_existing)
 struct rte_efd_table *
 rte_efd_find_existing(const char *name)
 {
@@ -746,6 +749,7 @@ rte_efd_find_existing(const char *name)
 	return table;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_free)
 void
 rte_efd_free(struct rte_efd_table *table)
 {
@@ -1162,6 +1166,7 @@ efd_compute_update(struct rte_efd_table * const table,
 	return RTE_EFD_UPDATE_FAILED;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_update)
 int
 rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
 		const void *key, const efd_value_t value)
@@ -1185,6 +1190,7 @@ rte_efd_update(struct rte_efd_table * const table, const unsigned int socket_id,
 	return status;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_delete)
 int
 rte_efd_delete(struct rte_efd_table * const table, const unsigned int socket_id,
 		const void *key, efd_value_t * const prev_value)
@@ -1301,6 +1307,7 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
 	return value;
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_lookup)
 efd_value_t
 rte_efd_lookup(const struct rte_efd_table * const table,
 		const unsigned int socket_id, const void *key)
@@ -1322,6 +1329,7 @@ rte_efd_lookup(const struct rte_efd_table * const table,
 			table->lookup_fn);
 }
 
+RTE_EXPORT_SYMBOL(rte_efd_lookup_bulk)
 void rte_efd_lookup_bulk(const struct rte_efd_table * const table,
 		const unsigned int socket_id, const int num_keys,
 		const void **key_list, efd_value_t * const value_list)
diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index e1976db05f..ec0c1e1176 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 
+#include <eal_export.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
 
@@ -74,6 +75,7 @@ eth_dev_get(uint16_t port_id)
 	return eth_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
 struct rte_eth_dev *
 rte_eth_dev_allocate(const char *name)
 {
@@ -128,6 +130,7 @@ rte_eth_dev_allocate(const char *name)
 	return eth_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocated)
 struct rte_eth_dev *
 rte_eth_dev_allocated(const char *name)
 {
@@ -150,6 +153,7 @@ rte_eth_dev_allocated(const char *name)
  * makes sure that the same device would have the same port ID both
  * in the primary and secondary process.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_attach_secondary)
 struct rte_eth_dev *
 rte_eth_dev_attach_secondary(const char *name)
 {
@@ -180,6 +184,7 @@ rte_eth_dev_attach_secondary(const char *name)
 	return eth_dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_callback_process)
 int
 rte_eth_dev_callback_process(struct rte_eth_dev *dev,
 	enum rte_eth_event_type event, void *ret_param)
@@ -207,6 +212,7 @@ rte_eth_dev_callback_process(struct rte_eth_dev *dev,
 	return rc;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_probing_finish)
 void
 rte_eth_dev_probing_finish(struct rte_eth_dev *dev)
 {
@@ -226,6 +232,7 @@ rte_eth_dev_probing_finish(struct rte_eth_dev *dev)
 	dev->state = RTE_ETH_DEV_ATTACHED;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_release_port)
 int
 rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 {
@@ -284,6 +291,7 @@ rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_create)
 int
 rte_eth_dev_create(struct rte_device *device, const char *name,
 	size_t priv_data_size,
@@ -359,6 +367,7 @@ rte_eth_dev_create(struct rte_device *device, const char *name,
 	return retval;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_destroy)
 int
 rte_eth_dev_destroy(struct rte_eth_dev *ethdev,
 	ethdev_uninit_t ethdev_uninit)
@@ -379,6 +388,7 @@ rte_eth_dev_destroy(struct rte_eth_dev *ethdev,
 	return rte_eth_dev_release_port(ethdev);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_get_by_name)
 struct rte_eth_dev *
 rte_eth_dev_get_by_name(const char *name)
 {
@@ -390,6 +400,7 @@ rte_eth_dev_get_by_name(const char *name)
 	return &rte_eth_devices[pid];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_rx_hairpin_queue)
 int
 rte_eth_dev_is_rx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
@@ -398,6 +409,7 @@ rte_eth_dev_is_rx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_is_tx_hairpin_queue)
 int
 rte_eth_dev_is_tx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 {
@@ -406,6 +418,7 @@ rte_eth_dev_is_tx_hairpin_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_internal_reset)
 void
 rte_eth_dev_internal_reset(struct rte_eth_dev *dev)
 {
@@ -616,6 +629,7 @@ eth_dev_tokenise_representor_list(char *p_val, struct rte_eth_devargs *eth_devar
 	return result;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devargs_parse)
 int
 rte_eth_devargs_parse(const char *dargs, struct rte_eth_devargs *eth_devargs,
 		      unsigned int nb_da)
@@ -678,6 +692,7 @@ eth_dev_dma_mzone_name(char *name, size_t len, uint16_t port_id, uint16_t queue_
 			port_id, queue_id, ring_name);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_free)
 int
 rte_eth_dma_zone_free(const struct rte_eth_dev *dev, const char *ring_name,
 		uint16_t queue_id)
@@ -702,6 +717,7 @@ rte_eth_dma_zone_free(const struct rte_eth_dev *dev, const char *ring_name,
 	return rc;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dma_zone_reserve)
 const struct rte_memzone *
 rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 			 uint16_t queue_id, size_t size, unsigned int align,
@@ -737,6 +753,7 @@ rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 			RTE_MEMZONE_IOVA_CONTIG, align);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_bind)
 int
 rte_eth_hairpin_queue_peer_bind(uint16_t cur_port, uint16_t cur_queue,
 				struct rte_hairpin_peer_info *peer_info,
@@ -755,6 +772,7 @@ rte_eth_hairpin_queue_peer_bind(uint16_t cur_port, uint16_t cur_queue,
 	return dev->dev_ops->hairpin_queue_peer_bind(dev, cur_queue, peer_info, direction);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_unbind)
 int
 rte_eth_hairpin_queue_peer_unbind(uint16_t cur_port, uint16_t cur_queue,
 				  uint32_t direction)
@@ -769,6 +787,7 @@ rte_eth_hairpin_queue_peer_unbind(uint16_t cur_port, uint16_t cur_queue,
 	return dev->dev_ops->hairpin_queue_peer_unbind(dev, cur_queue, direction);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_hairpin_queue_peer_update)
 int
 rte_eth_hairpin_queue_peer_update(uint16_t peer_port, uint16_t peer_queue,
 				  struct rte_hairpin_peer_info *cur_info,
@@ -790,6 +809,7 @@ rte_eth_hairpin_queue_peer_update(uint16_t peer_port, uint16_t peer_queue,
 						       cur_info, peer_info, direction);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_ip_reassembly_dynfield_register)
 int
 rte_eth_ip_reassembly_dynfield_register(int *field_offset, int *flag_offset)
 {
@@ -818,6 +838,7 @@ rte_eth_ip_reassembly_dynfield_register(int *field_offset, int *flag_offset)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_pkt_burst_dummy)
 uint16_t
 rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 		struct rte_mbuf **pkts __rte_unused,
@@ -826,6 +847,7 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
 int
 rte_eth_representor_id_get(uint16_t port_id,
 			   enum rte_eth_representor_type type,
@@ -921,6 +943,7 @@ rte_eth_representor_id_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_alloc)
 int
 rte_eth_switch_domain_alloc(uint16_t *domain_id)
 {
@@ -941,6 +964,7 @@ rte_eth_switch_domain_alloc(uint16_t *domain_id)
 	return -ENOSPC;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_switch_domain_free)
 int
 rte_eth_switch_domain_free(uint16_t domain_id)
 {
@@ -957,6 +981,7 @@ rte_eth_switch_domain_free(uint16_t domain_id)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_get_restore_flags)
 uint64_t
 rte_eth_get_restore_flags(struct rte_eth_dev *dev, enum rte_eth_dev_operation op)
 {
diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index e792204b01..ec42d3054a 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2024 NVIDIA Corporation & Affiliates
  */
 
+#include <eal_export.h>
 #include <rte_bitops.h>
 
 #include "rte_ethdev.h"
@@ -111,6 +112,7 @@ static const uint32_t link_modes[] = {
 	[101] =      11, /* ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT */
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_ethtool)
 uint32_t
 rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
 {
@@ -134,6 +136,7 @@ rte_eth_link_speed_ethtool(enum ethtool_link_mode_bit_indices bit)
 	return rte_eth_speed_bitflag(speed, duplex);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_glink)
 uint32_t
 rte_eth_link_speed_glink(const uint32_t *bitmap, int8_t nwords)
 {
@@ -154,6 +157,7 @@ rte_eth_link_speed_glink(const uint32_t *bitmap, int8_t nwords)
 	return ethdev_bitmap;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_link_speed_gset)
 uint32_t
 rte_eth_link_speed_gset(uint32_t legacy_bitmap)
 {
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index cc7fd97d4a..b96d992ea1 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018 Gaëtan Rivet
  */
 
+#include <eal_export.h>
 #include <rte_debug.h>
 
 #include "rte_ethdev.h"
@@ -285,6 +286,7 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
 	fpo->txq.clbk = (void * __rte_atomic *)(uintptr_t)dev->pre_tx_burst_cbs;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_call_rx_callbacks)
 uint16_t
 rte_eth_call_rx_callbacks(uint16_t port_id, uint16_t queue_id,
 	struct rte_mbuf **rx_pkts, uint16_t nb_rx, uint16_t nb_pkts,
@@ -308,6 +310,7 @@ rte_eth_call_rx_callbacks(uint16_t port_id, uint16_t queue_id,
 	return nb_rx;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_call_tx_callbacks)
 uint16_t
 rte_eth_call_tx_callbacks(uint16_t port_id, uint16_t queue_id,
 	struct rte_mbuf **tx_pkts, uint16_t nb_pkts, void *opaque)
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index cb99cf91fc..071c508327 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include <ethdev_trace.h>
@@ -25,24 +26,30 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_stop,
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_close,
 	lib.ethdev.close)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_empty, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_rx_burst_empty,
 	lib.ethdev.rx.burst.empty)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_rx_burst_nonempty, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_rx_burst_nonempty,
 	lib.ethdev.rx.burst.nonempty)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_ethdev_trace_tx_burst, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_tx_burst,
 	lib.ethdev.tx.burst)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_empty, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_rx_callbacks_empty,
 	lib.ethdev.call_rx_callbacks.empty)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_call_rx_callbacks_nonempty, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_rx_callbacks_nonempty,
 	lib.ethdev.call_rx_callbacks.nonempty)
 
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_call_tx_callbacks,
 	lib.ethdev.call_tx_callbacks)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eth_trace_tx_queue_count, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_tx_queue_count,
 	lib.ethdev.tx_queue_count)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 85798d0ebc..d4197322a0 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -12,6 +12,7 @@
 #include <sys/queue.h>
 
 #include <bus_driver.h>
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
@@ -38,9 +39,11 @@
 
 #define ETH_XSTATS_ITER_NUM	0x100
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_devices)
 struct rte_eth_dev rte_eth_devices[RTE_MAX_ETHPORTS];
 
 /* public fast-path API */
+RTE_EXPORT_SYMBOL(rte_eth_fp_ops)
 struct rte_eth_fp_ops rte_eth_fp_ops[RTE_MAX_ETHPORTS];
 
 /* spinlock for add/remove Rx callbacks */
@@ -173,6 +176,7 @@ static const struct {
 	{RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ_SORT, "symmetric_toeplitz_sort"},
 };
 
+RTE_EXPORT_SYMBOL(rte_eth_iterator_init)
 int
 rte_eth_iterator_init(struct rte_dev_iterator *iter, const char *devargs_str)
 {
@@ -289,6 +293,7 @@ rte_eth_iterator_init(struct rte_dev_iterator *iter, const char *devargs_str)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_iterator_next)
 uint16_t
 rte_eth_iterator_next(struct rte_dev_iterator *iter)
 {
@@ -329,6 +334,7 @@ rte_eth_iterator_next(struct rte_dev_iterator *iter)
 	return RTE_MAX_ETHPORTS;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_iterator_cleanup)
 void
 rte_eth_iterator_cleanup(struct rte_dev_iterator *iter)
 {
@@ -347,6 +353,7 @@ rte_eth_iterator_cleanup(struct rte_dev_iterator *iter)
 	memset(iter, 0, sizeof(*iter));
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_find_next)
 uint16_t
 rte_eth_find_next(uint16_t port_id)
 {
@@ -371,6 +378,7 @@ rte_eth_find_next(uint16_t port_id)
 	     port_id < RTE_MAX_ETHPORTS; \
 	     port_id = rte_eth_find_next(port_id + 1))
 
+RTE_EXPORT_SYMBOL(rte_eth_find_next_of)
 uint16_t
 rte_eth_find_next_of(uint16_t port_id, const struct rte_device *parent)
 {
@@ -384,6 +392,7 @@ rte_eth_find_next_of(uint16_t port_id, const struct rte_device *parent)
 	return port_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_find_next_sibling)
 uint16_t
 rte_eth_find_next_sibling(uint16_t port_id, uint16_t ref_port_id)
 {
@@ -404,6 +413,7 @@ eth_dev_is_allocated(const struct rte_eth_dev *ethdev)
 	return ethdev->data != NULL && ethdev->data->name[0] != '\0';
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_is_valid_port)
 int
 rte_eth_dev_is_valid_port(uint16_t port_id)
 {
@@ -430,6 +440,7 @@ eth_is_valid_owner_id(uint64_t owner_id)
 	return 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_find_next_owned_by)
 uint64_t
 rte_eth_find_next_owned_by(uint16_t port_id, const uint64_t owner_id)
 {
@@ -443,6 +454,7 @@ rte_eth_find_next_owned_by(uint16_t port_id, const uint64_t owner_id)
 	return port_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_new)
 int
 rte_eth_dev_owner_new(uint64_t *owner_id)
 {
@@ -518,6 +530,7 @@ eth_dev_owner_set(const uint16_t port_id, const uint64_t old_owner_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_set)
 int
 rte_eth_dev_owner_set(const uint16_t port_id,
 		      const struct rte_eth_dev_owner *owner)
@@ -538,6 +551,7 @@ rte_eth_dev_owner_set(const uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_unset)
 int
 rte_eth_dev_owner_unset(const uint16_t port_id, const uint64_t owner_id)
 {
@@ -559,6 +573,7 @@ rte_eth_dev_owner_unset(const uint16_t port_id, const uint64_t owner_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_delete)
 int
 rte_eth_dev_owner_delete(const uint64_t owner_id)
 {
@@ -596,6 +611,7 @@ rte_eth_dev_owner_delete(const uint64_t owner_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_owner_get)
 int
 rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 {
@@ -634,6 +650,7 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_socket_id)
 int
 rte_eth_dev_socket_id(uint16_t port_id)
 {
@@ -659,6 +676,7 @@ rte_eth_dev_socket_id(uint16_t port_id)
 	return socket_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_sec_ctx)
 void *
 rte_eth_dev_get_sec_ctx(uint16_t port_id)
 {
@@ -672,6 +690,7 @@ rte_eth_dev_get_sec_ctx(uint16_t port_id)
 	return ctx;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_avail)
 uint16_t
 rte_eth_dev_count_avail(void)
 {
@@ -688,6 +707,7 @@ rte_eth_dev_count_avail(void)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_count_total)
 uint16_t
 rte_eth_dev_count_total(void)
 {
@@ -701,6 +721,7 @@ rte_eth_dev_count_total(void)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
 int
 rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
 {
@@ -727,6 +748,7 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_port_by_name)
 int
 rte_eth_dev_get_port_by_name(const char *name, uint16_t *port_id)
 {
@@ -817,6 +839,7 @@ eth_dev_validate_tx_queue(const struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_queue_is_valid, 23.07)
 int
 rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -828,6 +851,7 @@ rte_eth_rx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 	return eth_dev_validate_rx_queue(dev, queue_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_queue_is_valid, 23.07)
 int
 rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 {
@@ -839,6 +863,7 @@ rte_eth_tx_queue_is_valid(uint16_t port_id, uint16_t queue_id)
 	return eth_dev_validate_tx_queue(dev, queue_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_start)
 int
 rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
 {
@@ -883,6 +908,7 @@ rte_eth_dev_rx_queue_start(uint16_t port_id, uint16_t rx_queue_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_queue_stop)
 int
 rte_eth_dev_rx_queue_stop(uint16_t port_id, uint16_t rx_queue_id)
 {
@@ -920,6 +946,7 @@ rte_eth_dev_rx_queue_stop(uint16_t port_id, uint16_t rx_queue_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_start)
 int
 rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
 {
@@ -964,6 +991,7 @@ rte_eth_dev_tx_queue_start(uint16_t port_id, uint16_t tx_queue_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_queue_stop)
 int
 rte_eth_dev_tx_queue_stop(uint16_t port_id, uint16_t tx_queue_id)
 {
@@ -1001,6 +1029,7 @@ rte_eth_dev_tx_queue_stop(uint16_t port_id, uint16_t tx_queue_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_speed_bitflag)
 uint32_t
 rte_eth_speed_bitflag(uint32_t speed, int duplex)
 {
@@ -1058,6 +1087,7 @@ rte_eth_speed_bitflag(uint32_t speed, int duplex)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_offload_name)
 const char *
 rte_eth_dev_rx_offload_name(uint64_t offload)
 {
@@ -1076,6 +1106,7 @@ rte_eth_dev_rx_offload_name(uint64_t offload)
 	return name;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_tx_offload_name)
 const char *
 rte_eth_dev_tx_offload_name(uint64_t offload)
 {
@@ -1137,6 +1168,7 @@ eth_dev_offload_names(uint64_t bitmask, char *buf, size_t size,
 	return buf;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_capability_name, 21.11)
 const char *
 rte_eth_dev_capability_name(uint64_t capability)
 {
@@ -1286,6 +1318,7 @@ eth_dev_validate_mtu(uint16_t port_id, struct rte_eth_dev_info *dev_info,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_configure)
 int
 rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		      const struct rte_eth_conf *dev_conf)
@@ -1749,6 +1782,7 @@ eth_dev_config_restore(struct rte_eth_dev *dev,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_start)
 int
 rte_eth_dev_start(uint16_t port_id)
 {
@@ -1823,6 +1857,7 @@ rte_eth_dev_start(uint16_t port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_stop)
 int
 rte_eth_dev_stop(uint16_t port_id)
 {
@@ -1853,6 +1888,7 @@ rte_eth_dev_stop(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_up)
 int
 rte_eth_dev_set_link_up(uint16_t port_id)
 {
@@ -1871,6 +1907,7 @@ rte_eth_dev_set_link_up(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_link_down)
 int
 rte_eth_dev_set_link_down(uint16_t port_id)
 {
@@ -1889,6 +1926,7 @@ rte_eth_dev_set_link_down(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get, 24.11)
 int
 rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 {
@@ -1902,6 +1940,7 @@ rte_eth_speed_lanes_get(uint16_t port_id, uint32_t *lane)
 	return eth_err(port_id, dev->dev_ops->speed_lanes_get(dev, lane));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_get_capability, 24.11)
 int
 rte_eth_speed_lanes_get_capability(uint16_t port_id,
 				   struct rte_eth_speed_lanes_capa *speed_lanes_capa,
@@ -1928,6 +1967,7 @@ rte_eth_speed_lanes_get_capability(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_speed_lanes_set, 24.11)
 int
 rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 {
@@ -1941,6 +1981,7 @@ rte_eth_speed_lanes_set(uint16_t port_id, uint32_t speed_lanes_capa)
 	return eth_err(port_id, dev->dev_ops->speed_lanes_set(dev, speed_lanes_capa));
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_close)
 int
 rte_eth_dev_close(uint16_t port_id)
 {
@@ -1975,6 +2016,7 @@ rte_eth_dev_close(uint16_t port_id)
 	return firsterr;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_reset)
 int
 rte_eth_dev_reset(uint16_t port_id)
 {
@@ -2000,6 +2042,7 @@ rte_eth_dev_reset(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_is_removed)
 int
 rte_eth_dev_is_removed(uint16_t port_id)
 {
@@ -2227,6 +2270,7 @@ rte_eth_rx_queue_check_mempools(struct rte_mempool **rx_mempools,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_rx_queue_setup)
 int
 rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		       uint16_t nb_rx_desc, unsigned int socket_id,
@@ -2452,6 +2496,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return eth_err(port_id, ret);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_hairpin_queue_setup, 19.11)
 int
 rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			       uint16_t nb_rx_desc,
@@ -2557,6 +2602,7 @@ rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_queue_setup)
 int
 rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       uint16_t nb_tx_desc, unsigned int socket_id,
@@ -2668,6 +2714,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_hairpin_queue_setup, 19.11)
 int
 rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 			       uint16_t nb_tx_desc,
@@ -2767,6 +2814,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_bind, 20.11)
 int
 rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2794,6 +2842,7 @@ rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_unbind, 20.11)
 int
 rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2821,6 +2870,7 @@ rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_get_peer_ports, 20.11)
 int
 rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 			       size_t len, uint32_t direction)
@@ -2859,6 +2909,7 @@ rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_drop_callback)
 void
 rte_eth_tx_buffer_drop_callback(struct rte_mbuf **pkts, uint16_t unsent,
 		void *userdata __rte_unused)
@@ -2868,6 +2919,7 @@ rte_eth_tx_buffer_drop_callback(struct rte_mbuf **pkts, uint16_t unsent,
 	rte_eth_trace_tx_buffer_drop_callback((void **)pkts, unsent);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_count_callback)
 void
 rte_eth_tx_buffer_count_callback(struct rte_mbuf **pkts, uint16_t unsent,
 		void *userdata)
@@ -2880,6 +2932,7 @@ rte_eth_tx_buffer_count_callback(struct rte_mbuf **pkts, uint16_t unsent,
 	rte_eth_trace_tx_buffer_count_callback((void **)pkts, unsent, *count);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_set_err_callback)
 int
 rte_eth_tx_buffer_set_err_callback(struct rte_eth_dev_tx_buffer *buffer,
 		buffer_tx_error_fn cbfn, void *userdata)
@@ -2898,6 +2951,7 @@ rte_eth_tx_buffer_set_err_callback(struct rte_eth_dev_tx_buffer *buffer,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_buffer_init)
 int
 rte_eth_tx_buffer_init(struct rte_eth_dev_tx_buffer *buffer, uint16_t size)
 {
@@ -2919,6 +2973,7 @@ rte_eth_tx_buffer_init(struct rte_eth_dev_tx_buffer *buffer, uint16_t size)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_done_cleanup)
 int
 rte_eth_tx_done_cleanup(uint16_t port_id, uint16_t queue_id, uint32_t free_cnt)
 {
@@ -2946,6 +3001,7 @@ rte_eth_tx_done_cleanup(uint16_t port_id, uint16_t queue_id, uint32_t free_cnt)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_enable)
 int
 rte_eth_promiscuous_enable(uint16_t port_id)
 {
@@ -2972,6 +3028,7 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_disable)
 int
 rte_eth_promiscuous_disable(uint16_t port_id)
 {
@@ -3000,6 +3057,7 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_promiscuous_get)
 int
 rte_eth_promiscuous_get(uint16_t port_id)
 {
@@ -3013,6 +3071,7 @@ rte_eth_promiscuous_get(uint16_t port_id)
 	return dev->data->promiscuous;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_enable)
 int
 rte_eth_allmulticast_enable(uint16_t port_id)
 {
@@ -3038,6 +3097,7 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_disable)
 int
 rte_eth_allmulticast_disable(uint16_t port_id)
 {
@@ -3065,6 +3125,7 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_allmulticast_get)
 int
 rte_eth_allmulticast_get(uint16_t port_id)
 {
@@ -3078,6 +3139,7 @@ rte_eth_allmulticast_get(uint16_t port_id)
 	return dev->data->all_multicast;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_link_get)
 int
 rte_eth_link_get(uint16_t port_id, struct rte_eth_link *eth_link)
 {
@@ -3106,6 +3168,7 @@ rte_eth_link_get(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_link_get_nowait)
 int
 rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 {
@@ -3134,6 +3197,7 @@ rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_speed_to_str, 20.11)
 const char *
 rte_eth_link_speed_to_str(uint32_t link_speed)
 {
@@ -3197,6 +3261,7 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_to_str, 20.11)
 int
 rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 {
@@ -3233,6 +3298,7 @@ rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_stats_get)
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 {
@@ -3260,6 +3326,7 @@ rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_stats_reset)
 int
 rte_eth_stats_reset(uint16_t port_id)
 {
@@ -3321,6 +3388,7 @@ eth_dev_get_xstats_count(uint16_t port_id)
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_id_by_name)
 int
 rte_eth_xstats_get_id_by_name(uint16_t port_id, const char *xstat_name,
 		uint64_t *id)
@@ -3456,6 +3524,7 @@ eth_xstats_get_by_name_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 
 
 /* retrieve ethdev extended statistics names */
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names_by_id)
 int
 rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	struct rte_eth_xstat_name *xstats_names, unsigned int size,
@@ -3548,6 +3617,7 @@ rte_eth_xstats_get_names_by_id(uint16_t port_id,
 	return size;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_names)
 int
 rte_eth_xstats_get_names(uint16_t port_id,
 	struct rte_eth_xstat_name *xstats_names,
@@ -3674,6 +3744,7 @@ eth_xtats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 }
 
 /* retrieve ethdev extended statistics */
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get_by_id)
 int
 rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 			 uint64_t *values, unsigned int size)
@@ -3760,6 +3831,7 @@ rte_eth_xstats_get_by_id(uint16_t port_id, const uint64_t *ids,
 	return (i == size) ? (int32_t)size : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_xstats_get)
 int
 rte_eth_xstats_get(uint16_t port_id, struct rte_eth_xstat *xstats,
 	unsigned int n)
@@ -3811,6 +3883,7 @@ rte_eth_xstats_get(uint16_t port_id, struct rte_eth_xstat *xstats,
 }
 
 /* reset ethdev extended statistics */
+RTE_EXPORT_SYMBOL(rte_eth_xstats_reset)
 int
 rte_eth_xstats_reset(uint16_t port_id)
 {
@@ -3832,6 +3905,7 @@ rte_eth_xstats_reset(uint16_t port_id)
 	return rte_eth_stats_reset(port_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_set_counter, 25.03)
 int
 rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 {
@@ -3861,6 +3935,7 @@ rte_eth_xstats_set_counter(uint16_t port_id, uint64_t id, int on_off)
 }
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_xstats_query_state, 25.03)
 int
 rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
 {
@@ -3904,6 +3979,7 @@ eth_dev_set_queue_stats_mapping(uint16_t port_id, uint16_t queue_id,
 	return dev->dev_ops->queue_stats_mapping_set(dev, queue_id, stat_idx, is_rx);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_tx_queue_stats_mapping)
 int
 rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id, uint16_t tx_queue_id,
 		uint8_t stat_idx)
@@ -3920,6 +3996,7 @@ rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_rx_queue_stats_mapping)
 int
 rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id, uint16_t rx_queue_id,
 		uint8_t stat_idx)
@@ -3936,6 +4013,7 @@ rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id, uint16_t rx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_fw_version_get)
 int
 rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
 {
@@ -3961,6 +4039,7 @@ rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_info_get)
 int
 rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 {
@@ -4025,6 +4104,7 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_conf_get, 21.11)
 int
 rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 {
@@ -4047,6 +4127,7 @@ rte_eth_dev_conf_get(uint16_t port_id, struct rte_eth_conf *dev_conf)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_supported_ptypes)
 int
 rte_eth_dev_get_supported_ptypes(uint16_t port_id, uint32_t ptype_mask,
 				 uint32_t *ptypes, int num)
@@ -4088,6 +4169,7 @@ rte_eth_dev_get_supported_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return j;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_ptypes)
 int
 rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 				 uint32_t *set_ptypes, unsigned int num)
@@ -4183,6 +4265,7 @@ rte_eth_dev_set_ptypes(uint16_t port_id, uint32_t ptype_mask,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_macaddrs_get, 21.11)
 int
 rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	unsigned int num)
@@ -4210,6 +4293,7 @@ rte_eth_macaddrs_get(uint16_t port_id, struct rte_ether_addr *ma,
 	return num;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_macaddr_get)
 int
 rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 {
@@ -4232,6 +4316,7 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_mtu)
 int
 rte_eth_dev_get_mtu(uint16_t port_id, uint16_t *mtu)
 {
@@ -4253,6 +4338,7 @@ rte_eth_dev_get_mtu(uint16_t port_id, uint16_t *mtu)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_mtu)
 int
 rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 {
@@ -4299,6 +4385,7 @@ rte_eth_dev_set_mtu(uint16_t port_id, uint16_t mtu)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_vlan_filter)
 int
 rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 {
@@ -4346,6 +4433,7 @@ rte_eth_dev_vlan_filter(uint16_t port_id, uint16_t vlan_id, int on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_strip_on_queue)
 int
 rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
 				    int on)
@@ -4369,6 +4457,7 @@ rte_eth_dev_set_vlan_strip_on_queue(uint16_t port_id, uint16_t rx_queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_ether_type)
 int
 rte_eth_dev_set_vlan_ether_type(uint16_t port_id,
 				enum rte_vlan_type vlan_type,
@@ -4389,6 +4478,7 @@ rte_eth_dev_set_vlan_ether_type(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_offload)
 int
 rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 {
@@ -4485,6 +4575,7 @@ rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_vlan_offload)
 int
 rte_eth_dev_get_vlan_offload(uint16_t port_id)
 {
@@ -4513,6 +4604,7 @@ rte_eth_dev_get_vlan_offload(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_vlan_pvid)
 int
 rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on)
 {
@@ -4531,6 +4623,7 @@ rte_eth_dev_set_vlan_pvid(uint16_t port_id, uint16_t pvid, int on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_get)
 int
 rte_eth_dev_flow_ctrl_get(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 {
@@ -4557,6 +4650,7 @@ rte_eth_dev_flow_ctrl_get(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_flow_ctrl_set)
 int
 rte_eth_dev_flow_ctrl_set(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 {
@@ -4587,6 +4681,7 @@ rte_eth_dev_flow_ctrl_set(uint16_t port_id, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_priority_flow_ctrl_set)
 int
 rte_eth_dev_priority_flow_ctrl_set(uint16_t port_id,
 				   struct rte_eth_pfc_conf *pfc_conf)
@@ -4669,6 +4764,7 @@ validate_tx_pause_config(struct rte_eth_dev_info *dev_info, uint8_t tc_max,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_info_get, 22.03)
 int
 rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 		struct rte_eth_pfc_queue_info *pfc_queue_info)
@@ -4696,6 +4792,7 @@ rte_eth_dev_priority_flow_ctrl_queue_info_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priority_flow_ctrl_queue_configure, 22.03)
 int
 rte_eth_dev_priority_flow_ctrl_queue_configure(uint16_t port_id,
 		struct rte_eth_pfc_queue_conf *pfc_queue_conf)
@@ -4814,6 +4911,7 @@ eth_check_reta_entry(struct rte_eth_rss_reta_entry64 *reta_conf,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_update)
 int
 rte_eth_dev_rss_reta_update(uint16_t port_id,
 			    struct rte_eth_rss_reta_entry64 *reta_conf,
@@ -4866,6 +4964,7 @@ rte_eth_dev_rss_reta_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_reta_query)
 int
 rte_eth_dev_rss_reta_query(uint16_t port_id,
 			   struct rte_eth_rss_reta_entry64 *reta_conf,
@@ -4898,6 +4997,7 @@ rte_eth_dev_rss_reta_query(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_update)
 int
 rte_eth_dev_rss_hash_update(uint16_t port_id,
 			    struct rte_eth_rss_conf *rss_conf)
@@ -4964,6 +5064,7 @@ rte_eth_dev_rss_hash_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rss_hash_conf_get)
 int
 rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 			      struct rte_eth_rss_conf *rss_conf)
@@ -5005,6 +5106,7 @@ rte_eth_dev_rss_hash_conf_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_rss_algo_name, 23.11)
 const char *
 rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 {
@@ -5019,6 +5121,7 @@ rte_eth_dev_rss_algo_name(enum rte_eth_hash_function rss_algo)
 	return name;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_find_rss_algo, 24.03)
 int
 rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 {
@@ -5034,6 +5137,7 @@ rte_eth_find_rss_algo(const char *name, uint32_t *algo)
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_add)
 int
 rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
 				struct rte_eth_udp_tunnel *udp_tunnel)
@@ -5065,6 +5169,7 @@ rte_eth_dev_udp_tunnel_port_add(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_udp_tunnel_port_delete)
 int
 rte_eth_dev_udp_tunnel_port_delete(uint16_t port_id,
 				   struct rte_eth_udp_tunnel *udp_tunnel)
@@ -5096,6 +5201,7 @@ rte_eth_dev_udp_tunnel_port_delete(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_led_on)
 int
 rte_eth_led_on(uint16_t port_id)
 {
@@ -5114,6 +5220,7 @@ rte_eth_led_on(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_led_off)
 int
 rte_eth_led_off(uint16_t port_id)
 {
@@ -5132,6 +5239,7 @@ rte_eth_led_off(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get_capability, 20.11)
 int
 rte_eth_fec_get_capability(uint16_t port_id,
 			   struct rte_eth_fec_capa *speed_fec_capa,
@@ -5159,6 +5267,7 @@ rte_eth_fec_get_capability(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_get, 20.11)
 int
 rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 {
@@ -5184,6 +5293,7 @@ rte_eth_fec_get(uint16_t port_id, uint32_t *fec_capa)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_fec_set, 20.11)
 int
 rte_eth_fec_set(uint16_t port_id, uint32_t fec_capa)
 {
@@ -5233,6 +5343,7 @@ eth_dev_get_mac_addr_index(uint16_t port_id, const struct rte_ether_addr *addr)
 
 static const struct rte_ether_addr null_mac_addr;
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_add)
 int
 rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 			uint32_t pool)
@@ -5299,6 +5410,7 @@ rte_eth_dev_mac_addr_add(uint16_t port_id, struct rte_ether_addr *addr,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_mac_addr_remove)
 int
 rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 {
@@ -5341,6 +5453,7 @@ rte_eth_dev_mac_addr_remove(uint16_t port_id, struct rte_ether_addr *addr)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_default_mac_addr_set)
 int
 rte_eth_dev_default_mac_addr_set(uint16_t port_id, struct rte_ether_addr *addr)
 {
@@ -5414,6 +5527,7 @@ eth_dev_get_hash_mac_addr_index(uint16_t port_id,
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_uc_hash_table_set)
 int
 rte_eth_dev_uc_hash_table_set(uint16_t port_id, struct rte_ether_addr *addr,
 				uint8_t on)
@@ -5479,6 +5593,7 @@ rte_eth_dev_uc_hash_table_set(uint16_t port_id, struct rte_ether_addr *addr,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_uc_all_hash_table_set)
 int
 rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on)
 {
@@ -5497,6 +5612,7 @@ rte_eth_dev_uc_all_hash_table_set(uint16_t port_id, uint8_t on)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_set_queue_rate_limit)
 int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 					uint32_t tx_rate)
 {
@@ -5537,6 +5653,7 @@ int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_set, 22.07)
 int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 			       uint8_t avail_thresh)
 {
@@ -5569,6 +5686,7 @@ int rte_eth_rx_avail_thresh_set(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_avail_thresh_query, 22.07)
 int rte_eth_rx_avail_thresh_query(uint16_t port_id, uint16_t *queue_id,
 				 uint8_t *avail_thresh)
 {
@@ -5609,6 +5727,7 @@ RTE_INIT(eth_dev_init_cb_lists)
 		TAILQ_INIT(&rte_eth_devices[i].link_intr_cbs);
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_callback_register)
 int
 rte_eth_dev_callback_register(uint16_t port_id,
 			enum rte_eth_event_type event,
@@ -5678,6 +5797,7 @@ rte_eth_dev_callback_register(uint16_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_callback_unregister)
 int
 rte_eth_dev_callback_unregister(uint16_t port_id,
 			enum rte_eth_event_type event,
@@ -5743,6 +5863,7 @@ rte_eth_dev_callback_unregister(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl)
 int
 rte_eth_dev_rx_intr_ctl(uint16_t port_id, int epfd, int op, void *data)
 {
@@ -5782,6 +5903,7 @@ rte_eth_dev_rx_intr_ctl(uint16_t port_id, int epfd, int op, void *data)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q_get_fd)
 int
 rte_eth_dev_rx_intr_ctl_q_get_fd(uint16_t port_id, uint16_t queue_id)
 {
@@ -5820,6 +5942,7 @@ rte_eth_dev_rx_intr_ctl_q_get_fd(uint16_t port_id, uint16_t queue_id)
 	return fd;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_ctl_q)
 int
 rte_eth_dev_rx_intr_ctl_q(uint16_t port_id, uint16_t queue_id,
 			  int epfd, int op, void *data)
@@ -5863,6 +5986,7 @@ rte_eth_dev_rx_intr_ctl_q(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_enable)
 int
 rte_eth_dev_rx_intr_enable(uint16_t port_id,
 			   uint16_t queue_id)
@@ -5886,6 +6010,7 @@ rte_eth_dev_rx_intr_enable(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_rx_intr_disable)
 int
 rte_eth_dev_rx_intr_disable(uint16_t port_id,
 			    uint16_t queue_id)
@@ -5910,6 +6035,7 @@ rte_eth_dev_rx_intr_disable(uint16_t port_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_eth_add_rx_callback)
 const struct rte_eth_rxtx_callback *
 rte_eth_add_rx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_rx_callback_fn fn, void *user_param)
@@ -5969,6 +6095,7 @@ rte_eth_add_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_add_first_rx_callback)
 const struct rte_eth_rxtx_callback *
 rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_rx_callback_fn fn, void *user_param)
@@ -6011,6 +6138,7 @@ rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_add_tx_callback)
 const struct rte_eth_rxtx_callback *
 rte_eth_add_tx_callback(uint16_t port_id, uint16_t queue_id,
 		rte_tx_callback_fn fn, void *user_param)
@@ -6072,6 +6200,7 @@ rte_eth_add_tx_callback(uint16_t port_id, uint16_t queue_id,
 	return cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_remove_rx_callback)
 int
 rte_eth_remove_rx_callback(uint16_t port_id, uint16_t queue_id,
 		const struct rte_eth_rxtx_callback *user_cb)
@@ -6108,6 +6237,7 @@ rte_eth_remove_rx_callback(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_remove_tx_callback)
 int
 rte_eth_remove_tx_callback(uint16_t port_id, uint16_t queue_id,
 		const struct rte_eth_rxtx_callback *user_cb)
@@ -6144,6 +6274,7 @@ rte_eth_remove_tx_callback(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_rx_queue_info_get)
 int
 rte_eth_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
@@ -6192,6 +6323,7 @@ rte_eth_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_queue_info_get)
 int
 rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	struct rte_eth_txq_info *qinfo)
@@ -6240,6 +6372,7 @@ rte_eth_tx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_recycle_rx_queue_info_get, 23.11)
 int
 rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
@@ -6262,6 +6395,7 @@ rte_eth_recycle_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_rx_burst_mode_get)
 int
 rte_eth_rx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 			  struct rte_eth_burst_mode *mode)
@@ -6295,6 +6429,7 @@ rte_eth_rx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_tx_burst_mode_get)
 int
 rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 			  struct rte_eth_burst_mode *mode)
@@ -6328,6 +6463,7 @@ rte_eth_tx_burst_mode_get(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_get_monitor_addr, 21.02)
 int
 rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 		struct rte_power_monitor_cond *pmc)
@@ -6360,6 +6496,7 @@ rte_eth_get_monitor_addr(uint16_t port_id, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_mc_addr_list)
 int
 rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 			     struct rte_ether_addr *mc_addr_set,
@@ -6382,6 +6519,7 @@ rte_eth_dev_set_mc_addr_list(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_enable)
 int
 rte_eth_timesync_enable(uint16_t port_id)
 {
@@ -6400,6 +6538,7 @@ rte_eth_timesync_enable(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_disable)
 int
 rte_eth_timesync_disable(uint16_t port_id)
 {
@@ -6418,6 +6557,7 @@ rte_eth_timesync_disable(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_rx_timestamp)
 int
 rte_eth_timesync_read_rx_timestamp(uint16_t port_id, struct timespec *timestamp,
 				   uint32_t flags)
@@ -6446,6 +6586,7 @@ rte_eth_timesync_read_rx_timestamp(uint16_t port_id, struct timespec *timestamp,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_tx_timestamp)
 int
 rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 				   struct timespec *timestamp)
@@ -6474,6 +6615,7 @@ rte_eth_timesync_read_tx_timestamp(uint16_t port_id,
 
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_adjust_time)
 int
 rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 {
@@ -6492,6 +6634,7 @@ rte_eth_timesync_adjust_time(uint16_t port_id, int64_t delta)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_adjust_freq, 24.11)
 int
 rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 {
@@ -6510,6 +6653,7 @@ rte_eth_timesync_adjust_freq(uint16_t port_id, int64_t ppm)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_read_time)
 int
 rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 {
@@ -6535,6 +6679,7 @@ rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_timesync_write_time)
 int
 rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 {
@@ -6560,6 +6705,7 @@ rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_read_clock, 19.08)
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 {
@@ -6584,6 +6730,7 @@ rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_reg_info)
 int
 rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -6614,6 +6761,7 @@ rte_eth_dev_get_reg_info(uint16_t port_id, struct rte_dev_reg_info *info)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_reg_info_ext, 24.11)
 int
 rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 {
@@ -6649,6 +6797,7 @@ rte_eth_dev_get_reg_info_ext(uint16_t port_id, struct rte_dev_reg_info *info)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom_length)
 int
 rte_eth_dev_get_eeprom_length(uint16_t port_id)
 {
@@ -6667,6 +6816,7 @@ rte_eth_dev_get_eeprom_length(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_eeprom)
 int
 rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 {
@@ -6692,6 +6842,7 @@ rte_eth_dev_get_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_set_eeprom)
 int
 rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 {
@@ -6717,6 +6868,7 @@ rte_eth_dev_set_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_info, 18.05)
 int
 rte_eth_dev_get_module_info(uint16_t port_id,
 			    struct rte_eth_dev_module_info *modinfo)
@@ -6743,6 +6895,7 @@ rte_eth_dev_get_module_info(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_get_module_eeprom, 18.05)
 int
 rte_eth_dev_get_module_eeprom(uint16_t port_id,
 			      struct rte_dev_eeprom_info *info)
@@ -6783,6 +6936,7 @@ rte_eth_dev_get_module_eeprom(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info)
 int
 rte_eth_dev_get_dcb_info(uint16_t port_id,
 			     struct rte_eth_dcb_info *dcb_info)
@@ -6830,6 +6984,7 @@ eth_dev_adjust_nb_desc(uint16_t *nb_desc,
 	*nb_desc = (uint16_t)nb_desc_32;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_adjust_nb_rx_tx_desc)
 int
 rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 				 uint16_t *nb_rx_desc,
@@ -6855,6 +7010,7 @@ rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_hairpin_capability_get, 19.11)
 int
 rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				   struct rte_eth_hairpin_cap *cap)
@@ -6882,6 +7038,7 @@ rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_pool_ops_supported)
 int
 rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 {
@@ -6908,6 +7065,7 @@ rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_representor_info_get, 21.05)
 int
 rte_eth_representor_info_get(uint16_t port_id,
 			     struct rte_eth_representor_info *info)
@@ -6927,6 +7085,7 @@ rte_eth_representor_info_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_rx_metadata_negotiate)
 int
 rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 {
@@ -6962,6 +7121,7 @@ rte_eth_rx_metadata_negotiate(uint16_t port_id, uint64_t *features)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_capability_get, 22.03)
 int
 rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *reassembly_capa)
@@ -6997,6 +7157,7 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_get, 22.03)
 int
 rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 		struct rte_eth_ip_reassembly_params *conf)
@@ -7030,6 +7191,7 @@ rte_eth_ip_reassembly_conf_get(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_ip_reassembly_conf_set, 22.03)
 int
 rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 		const struct rte_eth_ip_reassembly_params *conf)
@@ -7070,6 +7232,7 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 {
@@ -7088,6 +7251,7 @@ rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
 	return eth_err(port_id, dev->dev_ops->eth_dev_priv_dump(dev, file));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_descriptor_dump, 22.11)
 int
 rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7114,6 +7278,7 @@ rte_eth_rx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_rx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_descriptor_dump, 22.11)
 int
 rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 			   uint16_t offset, uint16_t num, FILE *file)
@@ -7140,6 +7305,7 @@ rte_eth_tx_descriptor_dump(uint16_t port_id, uint16_t queue_id,
 		       dev->dev_ops->eth_tx_descriptor_dump(dev, queue_id, offset, num, file));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_buffer_split_get_supported_hdr_ptypes, 22.11)
 int
 rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 {
@@ -7179,6 +7345,7 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 	return j;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03)
 int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 {
 	struct rte_eth_dev *dev;
@@ -7196,6 +7363,7 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_map_aggr_tx_affinity, 23.03)
 int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 				     uint8_t affinity)
 {
@@ -7251,4 +7419,5 @@ int rte_eth_dev_map_aggr_tx_affinity(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_eth_dev_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_eth_dev_logtype, INFO);
diff --git a/lib/ethdev/rte_ethdev_cman.c b/lib/ethdev/rte_ethdev_cman.c
index 73262ffc5f..a8460e6977 100644
--- a/lib/ethdev/rte_ethdev_cman.c
+++ b/lib/ethdev/rte_ethdev_cman.c
@@ -4,6 +4,7 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include "rte_ethdev.h"
 #include "ethdev_driver.h"
@@ -11,6 +12,7 @@
 #include "ethdev_trace.h"
 
 /* Get congestion management information for a port */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_info_get, 22.11)
 int
 rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 {
@@ -39,6 +41,7 @@ rte_eth_cman_info_get(uint16_t port_id, struct rte_eth_cman_info *info)
 }
 
 /* Initialize congestion management structure with default values */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_init, 22.11)
 int
 rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 {
@@ -67,6 +70,7 @@ rte_eth_cman_config_init(uint16_t port_id, struct rte_eth_cman_config *config)
 }
 
 /* Configure congestion management on a port */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_set, 22.11)
 int
 rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *config)
 {
@@ -94,6 +98,7 @@ rte_eth_cman_config_set(uint16_t port_id, const struct rte_eth_cman_config *conf
 }
 
 /* Retrieve congestion management configuration of a port */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cman_config_get, 22.11)
 int
 rte_eth_cman_config_get(uint16_t port_id, struct rte_eth_cman_config *config)
 {
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 4a7735b5ab..9f8d8f3dc2 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -9,6 +9,7 @@
 #include <stdint.h>
 #include <pthread.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_branch_prediction.h>
@@ -22,9 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -278,6 +281,7 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_register, 19.11)
 int
 rte_flow_dynf_metadata_register(void)
 {
@@ -366,6 +370,7 @@ rte_flow_ops_get(uint16_t port_id, struct rte_flow_error *error)
 }
 
 /* Check whether a flow rule can be created on a given port. */
+RTE_EXPORT_SYMBOL(rte_flow_validate)
 int
 rte_flow_validate(uint16_t port_id,
 		  const struct rte_flow_attr *attr,
@@ -402,6 +407,7 @@ rte_flow_validate(uint16_t port_id,
 }
 
 /* Create a flow rule on a given port. */
+RTE_EXPORT_SYMBOL(rte_flow_create)
 struct rte_flow *
 rte_flow_create(uint16_t port_id,
 		const struct rte_flow_attr *attr,
@@ -432,6 +438,7 @@ rte_flow_create(uint16_t port_id,
 }
 
 /* Destroy a flow rule on a given port. */
+RTE_EXPORT_SYMBOL(rte_flow_destroy)
 int
 rte_flow_destroy(uint16_t port_id,
 		 struct rte_flow *flow,
@@ -458,6 +465,7 @@ rte_flow_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOSYS));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_update, 23.07)
 int
 rte_flow_actions_update(uint16_t port_id,
 			struct rte_flow *flow,
@@ -485,6 +493,7 @@ rte_flow_actions_update(uint16_t port_id,
 }
 
 /* Destroy all flow rules associated with a port. */
+RTE_EXPORT_SYMBOL(rte_flow_flush)
 int
 rte_flow_flush(uint16_t port_id,
 	       struct rte_flow_error *error)
@@ -511,6 +520,7 @@ rte_flow_flush(uint16_t port_id,
 }
 
 /* Query an existing flow rule. */
+RTE_EXPORT_SYMBOL(rte_flow_query)
 int
 rte_flow_query(uint16_t port_id,
 	       struct rte_flow *flow,
@@ -540,6 +550,7 @@ rte_flow_query(uint16_t port_id,
 }
 
 /* Restrict ingress traffic to the defined flow rules. */
+RTE_EXPORT_SYMBOL(rte_flow_isolate)
 int
 rte_flow_isolate(uint16_t port_id,
 		 int set,
@@ -567,6 +578,7 @@ rte_flow_isolate(uint16_t port_id,
 }
 
 /* Initialize flow error structure. */
+RTE_EXPORT_SYMBOL(rte_flow_error_set)
 int
 rte_flow_error_set(struct rte_flow_error *error,
 		   int code,
@@ -1102,6 +1114,7 @@ rte_flow_conv_name(int is_action,
 }
 
 /** Helper function to convert flow API objects. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_conv, 18.11)
 int
 rte_flow_conv(enum rte_flow_conv_op op,
 	      void *dst,
@@ -1173,6 +1186,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 }
 
 /** Store a full rte_flow description. */
+RTE_EXPORT_SYMBOL(rte_flow_copy)
 size_t
 rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	      const struct rte_flow_attr *attr,
@@ -1227,6 +1241,7 @@ rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dev_dump, 20.02)
 int
 rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 			FILE *file, struct rte_flow_error *error)
@@ -1248,6 +1263,7 @@ rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 				  NULL, rte_strerror(ENOSYS));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_aged_flows, 20.05)
 int
 rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 		    uint32_t nb_contexts, struct rte_flow_error *error)
@@ -1273,6 +1289,7 @@ rte_flow_get_aged_flows(uint16_t port_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_q_aged_flows, 22.11)
 int
 rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 			  uint32_t nb_contexts, struct rte_flow_error *error)
@@ -1300,6 +1317,7 @@ rte_flow_get_q_aged_flows(uint16_t port_id, uint32_t queue_id, void **contexts,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_create, 21.05)
 struct rte_flow_action_handle *
 rte_flow_action_handle_create(uint16_t port_id,
 			      const struct rte_flow_indir_action_conf *conf,
@@ -1327,6 +1345,7 @@ rte_flow_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_destroy, 21.05)
 int
 rte_flow_action_handle_destroy(uint16_t port_id,
 			       struct rte_flow_action_handle *handle,
@@ -1350,6 +1369,7 @@ rte_flow_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_update, 21.05)
 int
 rte_flow_action_handle_update(uint16_t port_id,
 			      struct rte_flow_action_handle *handle,
@@ -1374,6 +1394,7 @@ rte_flow_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query, 21.05)
 int
 rte_flow_action_handle_query(uint16_t port_id,
 			     const struct rte_flow_action_handle *handle,
@@ -1398,6 +1419,7 @@ rte_flow_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_decap_set, 20.11)
 int
 rte_flow_tunnel_decap_set(uint16_t port_id,
 			  struct rte_flow_tunnel *tunnel,
@@ -1427,6 +1449,7 @@ rte_flow_tunnel_decap_set(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_match, 20.11)
 int
 rte_flow_tunnel_match(uint16_t port_id,
 		      struct rte_flow_tunnel *tunnel,
@@ -1456,6 +1479,7 @@ rte_flow_tunnel_match(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_get_restore_info, 20.11)
 int
 rte_flow_get_restore_info(uint16_t port_id,
 			  struct rte_mbuf *m,
@@ -1490,6 +1514,7 @@ static struct {
 	.desc = { .name = "RTE_MBUF_F_RX_RESTORE_INFO", },
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_restore_info_dynflag, 23.07)
 uint64_t
 rte_flow_restore_info_dynflag(void)
 {
@@ -1510,6 +1535,7 @@ rte_flow_restore_info_dynflag_register(void)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_action_decap_release, 20.11)
 int
 rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				     struct rte_flow_action *actions,
@@ -1539,6 +1565,7 @@ rte_flow_tunnel_action_decap_release(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_tunnel_item_release, 20.11)
 int
 rte_flow_tunnel_item_release(uint16_t port_id,
 			     struct rte_flow_item *items,
@@ -1566,6 +1593,7 @@ rte_flow_tunnel_item_release(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_SYMBOL(rte_flow_pick_transfer_proxy)
 int
 rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 			     struct rte_flow_error *error)
@@ -1593,6 +1621,7 @@ rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_create, 21.11)
 struct rte_flow_item_flex_handle *
 rte_flow_flex_item_create(uint16_t port_id,
 			  const struct rte_flow_item_flex_conf *conf,
@@ -1619,6 +1648,7 @@ rte_flow_flex_item_create(uint16_t port_id,
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_release, 21.11)
 int
 rte_flow_flex_item_release(uint16_t port_id,
 			   const struct rte_flow_item_flex_handle *handle,
@@ -1640,6 +1670,7 @@ rte_flow_flex_item_release(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_info_get, 22.03)
 int
 rte_flow_info_get(uint16_t port_id,
 		  struct rte_flow_port_info *port_info,
@@ -1676,6 +1707,7 @@ rte_flow_info_get(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_configure, 22.03)
 int
 rte_flow_configure(uint16_t port_id,
 		   const struct rte_flow_port_attr *port_attr,
@@ -1730,6 +1762,7 @@ rte_flow_configure(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_create, 22.03)
 struct rte_flow_pattern_template *
 rte_flow_pattern_template_create(uint16_t port_id,
 		const struct rte_flow_pattern_template_attr *template_attr,
@@ -1786,6 +1819,7 @@ rte_flow_pattern_template_create(uint16_t port_id,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_destroy, 22.03)
 int
 rte_flow_pattern_template_destroy(uint16_t port_id,
 		struct rte_flow_pattern_template *pattern_template,
@@ -1816,6 +1850,7 @@ rte_flow_pattern_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_create, 22.03)
 struct rte_flow_actions_template *
 rte_flow_actions_template_create(uint16_t port_id,
 			const struct rte_flow_actions_template_attr *template_attr,
@@ -1882,6 +1917,7 @@ rte_flow_actions_template_create(uint16_t port_id,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_actions_template_destroy, 22.03)
 int
 rte_flow_actions_template_destroy(uint16_t port_id,
 			struct rte_flow_actions_template *actions_template,
@@ -1912,6 +1948,7 @@ rte_flow_actions_template_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_create, 22.03)
 struct rte_flow_template_table *
 rte_flow_template_table_create(uint16_t port_id,
 			const struct rte_flow_template_table_attr *table_attr,
@@ -1985,6 +2022,7 @@ rte_flow_template_table_create(uint16_t port_id,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_destroy, 22.03)
 int
 rte_flow_template_table_destroy(uint16_t port_id,
 				struct rte_flow_template_table *template_table,
@@ -2015,6 +2053,7 @@ rte_flow_template_table_destroy(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_group_set_miss_actions, 23.11)
 int
 rte_flow_group_set_miss_actions(uint16_t port_id,
 				uint32_t group_id,
@@ -2037,6 +2076,7 @@ rte_flow_group_set_miss_actions(uint16_t port_id,
 				  NULL, rte_strerror(ENOTSUP));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create, 22.03)
 struct rte_flow *
 rte_flow_async_create(uint16_t port_id,
 		      uint32_t queue_id,
@@ -2078,6 +2118,7 @@ rte_flow_async_create(uint16_t port_id,
 	return flow;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index, 23.03)
 struct rte_flow *
 rte_flow_async_create_by_index(uint16_t port_id,
 			       uint32_t queue_id,
@@ -2116,6 +2157,7 @@ rte_flow_async_create_by_index(uint16_t port_id,
 	return flow;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_create_by_index_with_pattern, 24.11)
 struct rte_flow *
 rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 					    uint32_t queue_id,
@@ -2160,6 +2202,7 @@ rte_flow_async_create_by_index_with_pattern(uint16_t port_id,
 	return flow;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_destroy, 22.03)
 int
 rte_flow_async_destroy(uint16_t port_id,
 		       uint32_t queue_id,
@@ -2190,6 +2233,7 @@ rte_flow_async_destroy(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_actions_update, 23.07)
 int
 rte_flow_async_actions_update(uint16_t port_id,
 			      uint32_t queue_id,
@@ -2224,6 +2268,7 @@ rte_flow_async_actions_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_push, 22.03)
 int
 rte_flow_push(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2248,6 +2293,7 @@ rte_flow_push(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pull, 22.03)
 int
 rte_flow_pull(uint16_t port_id,
 	      uint32_t queue_id,
@@ -2274,6 +2320,7 @@ rte_flow_pull(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_create, 22.03)
 struct rte_flow_action_handle *
 rte_flow_async_action_handle_create(uint16_t port_id,
 		uint32_t queue_id,
@@ -2310,6 +2357,7 @@ rte_flow_async_action_handle_create(uint16_t port_id,
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_destroy, 22.03)
 int
 rte_flow_async_action_handle_destroy(uint16_t port_id,
 		uint32_t queue_id,
@@ -2339,6 +2387,7 @@ rte_flow_async_action_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_update, 22.03)
 int
 rte_flow_async_action_handle_update(uint16_t port_id,
 		uint32_t queue_id,
@@ -2370,6 +2419,7 @@ rte_flow_async_action_handle_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query, 22.11)
 int
 rte_flow_async_action_handle_query(uint16_t port_id,
 		uint32_t queue_id,
@@ -2401,6 +2451,7 @@ rte_flow_async_action_handle_query(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_handle_query_update, 23.03)
 int
 rte_flow_action_handle_query_update(uint16_t port_id,
 				    struct rte_flow_action_handle *handle,
@@ -2426,6 +2477,7 @@ rte_flow_action_handle_query_update(uint16_t port_id,
 	return flow_err(port_id, ret, error);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_handle_query_update, 23.03)
 int
 rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 					  const struct rte_flow_op_attr *attr,
@@ -2452,6 +2504,7 @@ rte_flow_async_action_handle_query_update(uint16_t port_id, uint32_t queue_id,
 								  user_data, error);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_create, 23.07)
 struct rte_flow_action_list_handle *
 rte_flow_action_list_handle_create(uint16_t port_id,
 				   const
@@ -2479,6 +2532,7 @@ rte_flow_action_list_handle_create(uint16_t port_id,
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_destroy, 23.07)
 int
 rte_flow_action_list_handle_destroy(uint16_t port_id,
 				    struct rte_flow_action_list_handle *handle,
@@ -2501,6 +2555,7 @@ rte_flow_action_list_handle_destroy(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_create, 23.07)
 struct rte_flow_action_list_handle *
 rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 					 const struct rte_flow_op_attr *attr,
@@ -2537,6 +2592,7 @@ rte_flow_async_action_list_handle_create(uint16_t port_id, uint32_t queue_id,
 	return handle;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_destroy, 23.07)
 int
 rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 				 const struct rte_flow_op_attr *op_attr,
@@ -2564,6 +2620,7 @@ rte_flow_async_action_list_handle_destroy(uint16_t port_id, uint32_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_action_list_handle_query_update, 23.07)
 int
 rte_flow_action_list_handle_query_update(uint16_t port_id,
 			 const struct rte_flow_action_list_handle *handle,
@@ -2590,6 +2647,7 @@ rte_flow_action_list_handle_query_update(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_action_list_handle_query_update, 23.07)
 int
 rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_id,
 			 const struct rte_flow_op_attr *attr,
@@ -2624,6 +2682,7 @@ rte_flow_async_action_list_handle_query_update(uint16_t port_id, uint32_t queue_
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_table_hash, 23.11)
 int
 rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table *table,
 			 const struct rte_flow_item pattern[], uint8_t pattern_template_index,
@@ -2645,6 +2704,7 @@ rte_flow_calc_table_hash(uint16_t port_id, const struct rte_flow_template_table
 	return flow_err(port_id, ret, error);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_calc_encap_hash, 24.03)
 int
 rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 			 enum rte_flow_encap_hash_field dest_field, uint8_t hash_len,
@@ -2674,6 +2734,7 @@ rte_flow_calc_encap_hash(uint16_t port_id, const struct rte_flow_item pattern[],
 	return flow_err(port_id, ret, error);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resizable, 24.03)
 bool
 rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 				  const struct rte_flow_template_table_attr *tbl_attr)
@@ -2682,6 +2743,7 @@ rte_flow_template_table_resizable(__rte_unused uint16_t port_id,
 		RTE_FLOW_TABLE_SPECIALIZE_RESIZABLE) != 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize, 24.03)
 int
 rte_flow_template_table_resize(uint16_t port_id,
 			       struct rte_flow_template_table *table,
@@ -2705,6 +2767,7 @@ rte_flow_template_table_resize(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_async_update_resized, 24.03)
 int
 rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 			      const struct rte_flow_op_attr *attr,
@@ -2729,6 +2792,7 @@ rte_flow_async_update_resized(uint16_t port_id, uint32_t queue,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_template_table_resize_complete, 24.03)
 int
 rte_flow_template_table_resize_complete(uint16_t port_id,
 					struct rte_flow_template_table *table,
@@ -2964,6 +3028,7 @@ rte_flow_dummy_async_action_list_handle_query_update(
 				  rte_strerror(ENOSYS));
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_flow_fp_default_ops)
 struct rte_flow_fp_ops rte_flow_fp_default_ops = {
 	.async_create = rte_flow_dummy_async_create,
 	.async_create_by_index = rte_flow_dummy_async_create_by_index,
diff --git a/lib/ethdev/rte_mtr.c b/lib/ethdev/rte_mtr.c
index 900837bc09..c6f0698ed3 100644
--- a/lib/ethdev/rte_mtr.c
+++ b/lib/ethdev/rte_mtr.c
@@ -4,6 +4,7 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include "ethdev_trace.h"
 #include "rte_ethdev.h"
@@ -77,6 +78,7 @@ __extension__ ({					\
 })
 
 /* MTR capabilities get */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_capabilities_get, 17.11)
 int
 rte_mtr_capabilities_get(uint16_t port_id,
 	struct rte_mtr_capabilities *cap,
@@ -93,6 +95,7 @@ rte_mtr_capabilities_get(uint16_t port_id,
 }
 
 /* MTR meter profile add */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_add, 17.11)
 int
 rte_mtr_meter_profile_add(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -111,6 +114,7 @@ rte_mtr_meter_profile_add(uint16_t port_id,
 }
 
 /** MTR meter profile delete */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_delete, 17.11)
 int
 rte_mtr_meter_profile_delete(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -127,6 +131,7 @@ rte_mtr_meter_profile_delete(uint16_t port_id,
 }
 
 /** MTR meter profile get */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_get, 22.11)
 struct rte_flow_meter_profile *
 rte_mtr_meter_profile_get(uint16_t port_id,
 	uint32_t meter_profile_id,
@@ -143,6 +148,7 @@ rte_mtr_meter_profile_get(uint16_t port_id,
 }
 
 /* MTR meter policy validate */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_validate, 21.05)
 int
 rte_mtr_meter_policy_validate(uint16_t port_id,
 	struct rte_mtr_meter_policy_params *policy,
@@ -159,6 +165,7 @@ rte_mtr_meter_policy_validate(uint16_t port_id,
 }
 
 /* MTR meter policy add */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_add, 21.05)
 int
 rte_mtr_meter_policy_add(uint16_t port_id,
 	uint32_t policy_id,
@@ -176,6 +183,7 @@ rte_mtr_meter_policy_add(uint16_t port_id,
 }
 
 /** MTR meter policy delete */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_delete, 21.05)
 int
 rte_mtr_meter_policy_delete(uint16_t port_id,
 	uint32_t policy_id,
@@ -192,6 +200,7 @@ rte_mtr_meter_policy_delete(uint16_t port_id,
 }
 
 /** MTR meter policy get */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_get, 22.11)
 struct rte_flow_meter_policy *
 rte_mtr_meter_policy_get(uint16_t port_id,
 	uint32_t policy_id,
@@ -208,6 +217,7 @@ rte_mtr_meter_policy_get(uint16_t port_id,
 }
 
 /** MTR object create */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_create, 17.11)
 int
 rte_mtr_create(uint16_t port_id,
 	uint32_t mtr_id,
@@ -226,6 +236,7 @@ rte_mtr_create(uint16_t port_id,
 }
 
 /** MTR object destroy */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_destroy, 17.11)
 int
 rte_mtr_destroy(uint16_t port_id,
 	uint32_t mtr_id,
@@ -242,6 +253,7 @@ rte_mtr_destroy(uint16_t port_id,
 }
 
 /** MTR object meter enable */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_enable, 17.11)
 int
 rte_mtr_meter_enable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -258,6 +270,7 @@ rte_mtr_meter_enable(uint16_t port_id,
 }
 
 /** MTR object meter disable */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_disable, 17.11)
 int
 rte_mtr_meter_disable(uint16_t port_id,
 	uint32_t mtr_id,
@@ -274,6 +287,7 @@ rte_mtr_meter_disable(uint16_t port_id,
 }
 
 /** MTR object meter profile update */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_profile_update, 17.11)
 int
 rte_mtr_meter_profile_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -291,6 +305,7 @@ rte_mtr_meter_profile_update(uint16_t port_id,
 }
 
 /** MTR object meter policy update */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_policy_update, 21.05)
 int
 rte_mtr_meter_policy_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -308,6 +323,7 @@ rte_mtr_meter_policy_update(uint16_t port_id,
 }
 
 /** MTR object meter DSCP table update */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_dscp_table_update, 17.11)
 int
 rte_mtr_meter_dscp_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -325,6 +341,7 @@ rte_mtr_meter_dscp_table_update(uint16_t port_id,
 }
 
 /** MTR object meter VLAN table update */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_meter_vlan_table_update, 22.07)
 int
 rte_mtr_meter_vlan_table_update(uint16_t port_id,
 	uint32_t mtr_id, enum rte_mtr_color_in_protocol proto,
@@ -342,6 +359,7 @@ rte_mtr_meter_vlan_table_update(uint16_t port_id,
 }
 
 /** Set the input color protocol on MTR object */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_set, 22.07)
 int
 rte_mtr_color_in_protocol_set(uint16_t port_id,
 	uint32_t mtr_id,
@@ -360,6 +378,7 @@ rte_mtr_color_in_protocol_set(uint16_t port_id,
 }
 
 /** Get input color protocols of MTR object */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_get, 22.07)
 int
 rte_mtr_color_in_protocol_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -377,6 +396,7 @@ rte_mtr_color_in_protocol_get(uint16_t port_id,
 }
 
 /** Get input color protocol priority of MTR object */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_color_in_protocol_priority_get, 22.07)
 int
 rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 	uint32_t mtr_id,
@@ -395,6 +415,7 @@ rte_mtr_color_in_protocol_priority_get(uint16_t port_id,
 }
 
 /** MTR object enabled stats update */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_update, 17.11)
 int
 rte_mtr_stats_update(uint16_t port_id,
 	uint32_t mtr_id,
@@ -412,6 +433,7 @@ rte_mtr_stats_update(uint16_t port_id,
 }
 
 /** MTR object stats read */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mtr_stats_read, 17.11)
 int
 rte_mtr_stats_read(uint16_t port_id,
 	uint32_t mtr_id,
diff --git a/lib/ethdev/rte_tm.c b/lib/ethdev/rte_tm.c
index 347dbb81f9..66b8934c3b 100644
--- a/lib/ethdev/rte_tm.c
+++ b/lib/ethdev/rte_tm.c
@@ -4,6 +4,7 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include "ethdev_trace.h"
 #include "rte_ethdev.h"
@@ -58,6 +59,7 @@ __extension__ ({					\
 })
 
 /* Get number of leaf nodes */
+RTE_EXPORT_SYMBOL(rte_tm_get_number_of_leaf_nodes)
 int
 rte_tm_get_number_of_leaf_nodes(uint16_t port_id,
 	uint32_t *n_leaf_nodes,
@@ -87,6 +89,7 @@ rte_tm_get_number_of_leaf_nodes(uint16_t port_id,
 }
 
 /* Check node type (leaf or non-leaf) */
+RTE_EXPORT_SYMBOL(rte_tm_node_type_get)
 int
 rte_tm_node_type_get(uint16_t port_id,
 	uint32_t node_id,
@@ -104,6 +107,7 @@ rte_tm_node_type_get(uint16_t port_id,
 }
 
 /* Get capabilities */
+RTE_EXPORT_SYMBOL(rte_tm_capabilities_get)
 int rte_tm_capabilities_get(uint16_t port_id,
 	struct rte_tm_capabilities *cap,
 	struct rte_tm_error *error)
@@ -119,6 +123,7 @@ int rte_tm_capabilities_get(uint16_t port_id,
 }
 
 /* Get level capabilities */
+RTE_EXPORT_SYMBOL(rte_tm_level_capabilities_get)
 int rte_tm_level_capabilities_get(uint16_t port_id,
 	uint32_t level_id,
 	struct rte_tm_level_capabilities *cap,
@@ -135,6 +140,7 @@ int rte_tm_level_capabilities_get(uint16_t port_id,
 }
 
 /* Get node capabilities */
+RTE_EXPORT_SYMBOL(rte_tm_node_capabilities_get)
 int rte_tm_node_capabilities_get(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_node_capabilities *cap,
@@ -151,6 +157,7 @@ int rte_tm_node_capabilities_get(uint16_t port_id,
 }
 
 /* Add WRED profile */
+RTE_EXPORT_SYMBOL(rte_tm_wred_profile_add)
 int rte_tm_wred_profile_add(uint16_t port_id,
 	uint32_t wred_profile_id,
 	const struct rte_tm_wred_params *profile,
@@ -167,6 +174,7 @@ int rte_tm_wred_profile_add(uint16_t port_id,
 }
 
 /* Delete WRED profile */
+RTE_EXPORT_SYMBOL(rte_tm_wred_profile_delete)
 int rte_tm_wred_profile_delete(uint16_t port_id,
 	uint32_t wred_profile_id,
 	struct rte_tm_error *error)
@@ -182,6 +190,7 @@ int rte_tm_wred_profile_delete(uint16_t port_id,
 }
 
 /* Add/update shared WRED context */
+RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_add_update)
 int rte_tm_shared_wred_context_add_update(uint16_t port_id,
 	uint32_t shared_wred_context_id,
 	uint32_t wred_profile_id,
@@ -200,6 +209,7 @@ int rte_tm_shared_wred_context_add_update(uint16_t port_id,
 }
 
 /* Delete shared WRED context */
+RTE_EXPORT_SYMBOL(rte_tm_shared_wred_context_delete)
 int rte_tm_shared_wred_context_delete(uint16_t port_id,
 	uint32_t shared_wred_context_id,
 	struct rte_tm_error *error)
@@ -216,6 +226,7 @@ int rte_tm_shared_wred_context_delete(uint16_t port_id,
 }
 
 /* Add shaper profile */
+RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_add)
 int rte_tm_shaper_profile_add(uint16_t port_id,
 	uint32_t shaper_profile_id,
 	const struct rte_tm_shaper_params *profile,
@@ -233,6 +244,7 @@ int rte_tm_shaper_profile_add(uint16_t port_id,
 }
 
 /* Delete WRED profile */
+RTE_EXPORT_SYMBOL(rte_tm_shaper_profile_delete)
 int rte_tm_shaper_profile_delete(uint16_t port_id,
 	uint32_t shaper_profile_id,
 	struct rte_tm_error *error)
@@ -248,6 +260,7 @@ int rte_tm_shaper_profile_delete(uint16_t port_id,
 }
 
 /* Add shared shaper */
+RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_add_update)
 int rte_tm_shared_shaper_add_update(uint16_t port_id,
 	uint32_t shared_shaper_id,
 	uint32_t shaper_profile_id,
@@ -265,6 +278,7 @@ int rte_tm_shared_shaper_add_update(uint16_t port_id,
 }
 
 /* Delete shared shaper */
+RTE_EXPORT_SYMBOL(rte_tm_shared_shaper_delete)
 int rte_tm_shared_shaper_delete(uint16_t port_id,
 	uint32_t shared_shaper_id,
 	struct rte_tm_error *error)
@@ -280,6 +294,7 @@ int rte_tm_shared_shaper_delete(uint16_t port_id,
 }
 
 /* Add node to port traffic manager hierarchy */
+RTE_EXPORT_SYMBOL(rte_tm_node_add)
 int rte_tm_node_add(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t parent_node_id,
@@ -301,6 +316,7 @@ int rte_tm_node_add(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tm_node_query, 24.11)
 int rte_tm_node_query(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t *parent_node_id,
@@ -324,6 +340,7 @@ int rte_tm_node_query(uint16_t port_id,
 }
 
 /* Delete node from traffic manager hierarchy */
+RTE_EXPORT_SYMBOL(rte_tm_node_delete)
 int rte_tm_node_delete(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -339,6 +356,7 @@ int rte_tm_node_delete(uint16_t port_id,
 }
 
 /* Suspend node */
+RTE_EXPORT_SYMBOL(rte_tm_node_suspend)
 int rte_tm_node_suspend(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -354,6 +372,7 @@ int rte_tm_node_suspend(uint16_t port_id,
 }
 
 /* Resume node */
+RTE_EXPORT_SYMBOL(rte_tm_node_resume)
 int rte_tm_node_resume(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_error *error)
@@ -369,6 +388,7 @@ int rte_tm_node_resume(uint16_t port_id,
 }
 
 /* Commit the initial port traffic manager hierarchy */
+RTE_EXPORT_SYMBOL(rte_tm_hierarchy_commit)
 int rte_tm_hierarchy_commit(uint16_t port_id,
 	int clear_on_fail,
 	struct rte_tm_error *error)
@@ -384,6 +404,7 @@ int rte_tm_hierarchy_commit(uint16_t port_id,
 }
 
 /* Update node parent  */
+RTE_EXPORT_SYMBOL(rte_tm_node_parent_update)
 int rte_tm_node_parent_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t parent_node_id,
@@ -403,6 +424,7 @@ int rte_tm_node_parent_update(uint16_t port_id,
 }
 
 /* Update node private shaper */
+RTE_EXPORT_SYMBOL(rte_tm_node_shaper_update)
 int rte_tm_node_shaper_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shaper_profile_id,
@@ -420,6 +442,7 @@ int rte_tm_node_shaper_update(uint16_t port_id,
 }
 
 /* Update node shared shapers */
+RTE_EXPORT_SYMBOL(rte_tm_node_shared_shaper_update)
 int rte_tm_node_shared_shaper_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shared_shaper_id,
@@ -438,6 +461,7 @@ int rte_tm_node_shared_shaper_update(uint16_t port_id,
 }
 
 /* Update node stats */
+RTE_EXPORT_SYMBOL(rte_tm_node_stats_update)
 int rte_tm_node_stats_update(uint16_t port_id,
 	uint32_t node_id,
 	uint64_t stats_mask,
@@ -454,6 +478,7 @@ int rte_tm_node_stats_update(uint16_t port_id,
 }
 
 /* Update WFQ weight mode */
+RTE_EXPORT_SYMBOL(rte_tm_node_wfq_weight_mode_update)
 int rte_tm_node_wfq_weight_mode_update(uint16_t port_id,
 	uint32_t node_id,
 	int *wfq_weight_mode,
@@ -473,6 +498,7 @@ int rte_tm_node_wfq_weight_mode_update(uint16_t port_id,
 }
 
 /* Update node congestion management mode */
+RTE_EXPORT_SYMBOL(rte_tm_node_cman_update)
 int rte_tm_node_cman_update(uint16_t port_id,
 	uint32_t node_id,
 	enum rte_tm_cman_mode cman,
@@ -489,6 +515,7 @@ int rte_tm_node_cman_update(uint16_t port_id,
 }
 
 /* Update node private WRED context */
+RTE_EXPORT_SYMBOL(rte_tm_node_wred_context_update)
 int rte_tm_node_wred_context_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t wred_profile_id,
@@ -506,6 +533,7 @@ int rte_tm_node_wred_context_update(uint16_t port_id,
 }
 
 /* Update node shared WRED context */
+RTE_EXPORT_SYMBOL(rte_tm_node_shared_wred_context_update)
 int rte_tm_node_shared_wred_context_update(uint16_t port_id,
 	uint32_t node_id,
 	uint32_t shared_wred_context_id,
@@ -525,6 +553,7 @@ int rte_tm_node_shared_wred_context_update(uint16_t port_id,
 }
 
 /* Read and/or clear stats counters for specific node */
+RTE_EXPORT_SYMBOL(rte_tm_node_stats_read)
 int rte_tm_node_stats_read(uint16_t port_id,
 	uint32_t node_id,
 	struct rte_tm_node_stats *stats,
@@ -544,6 +573,7 @@ int rte_tm_node_stats_read(uint16_t port_id,
 }
 
 /* Packet marking - VLAN DEI */
+RTE_EXPORT_SYMBOL(rte_tm_mark_vlan_dei)
 int rte_tm_mark_vlan_dei(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
@@ -562,6 +592,7 @@ int rte_tm_mark_vlan_dei(uint16_t port_id,
 }
 
 /* Packet marking - IPv4/IPv6 ECN */
+RTE_EXPORT_SYMBOL(rte_tm_mark_ip_ecn)
 int rte_tm_mark_ip_ecn(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
@@ -580,6 +611,7 @@ int rte_tm_mark_ip_ecn(uint16_t port_id,
 }
 
 /* Packet marking - IPv4/IPv6 DSCP */
+RTE_EXPORT_SYMBOL(rte_tm_mark_ip_dscp)
 int rte_tm_mark_ip_dscp(uint16_t port_id,
 	int mark_green,
 	int mark_yellow,
diff --git a/lib/eventdev/eventdev_private.c b/lib/eventdev/eventdev_private.c
index 6df129fc2d..dffd2c71d0 100644
--- a/lib/eventdev/eventdev_private.c
+++ b/lib/eventdev/eventdev_private.c
@@ -3,6 +3,7 @@
  */
 
 #include "eventdev_pmd.h"
+#include <eal_export.h>
 #include "rte_eventdev.h"
 
 static uint16_t
@@ -106,6 +107,7 @@ dummy_event_port_preschedule_hint(__rte_unused void *port,
 {
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_reset)
 void
 event_dev_fp_ops_reset(struct rte_event_fp_ops *fp_op)
 {
@@ -129,6 +131,7 @@ event_dev_fp_ops_reset(struct rte_event_fp_ops *fp_op)
 	*fp_op = dummy;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_fp_ops_set)
 void
 event_dev_fp_ops_set(struct rte_event_fp_ops *fp_op,
 		     const struct rte_eventdev *dev)
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index 8caf6353a1..ade6723b7b 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include "eventdev_trace.h"
@@ -37,21 +38,27 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_stop,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_close,
 	lib.eventdev.close)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_enq_burst)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_enq_burst,
 	lib.eventdev.enq.burst)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_deq_burst)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_deq_burst,
 	lib.eventdev.deq.burst)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_maintain)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_maintain,
 	lib.eventdev.maintain)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_profile_switch, 23.11)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_profile_switch,
 	lib.eventdev.port.profile.switch)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule_modify, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_preschedule_modify,
 	lib.eventdev.port.preschedule.modify)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_preschedule, 24.11)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_preschedule,
 	lib.eventdev.port.preschedule)
 
@@ -96,6 +103,7 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_start,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_stop,
 	lib.eventdev.tx.adapter.stop)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_eth_tx_adapter_enqueue)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_tx_adapter_enqueue,
 	lib.eventdev.tx.adapter.enq)
 
@@ -112,12 +120,15 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_adapter_stop,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_adapter_free,
 	lib.eventdev.timer.free)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_burst)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_arm_burst,
 	lib.eventdev.timer.burst)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_arm_tmo_tick_burst)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_arm_tmo_tick_burst,
 	lib.eventdev.timer.tick.burst)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_timer_cancel_burst)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_timer_cancel_burst,
 	lib.eventdev.timer.cancel)
 
@@ -140,6 +151,7 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_start,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_stop,
 	lib.eventdev.crypto.stop)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_trace_crypto_adapter_enqueue)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_crypto_adapter_enqueue,
 	lib.eventdev.crypto.enq)
 
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index fc43e056d7..b827a0ffd6 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdbool.h>
+#include <eal_export.h>
 #include <rte_common.h>
 #include <dev_driver.h>
 #include <rte_errno.h>
@@ -362,6 +363,7 @@ eca_default_config_cb(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create_ext)
 int
 rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_crypto_adapter_conf_cb conf_cb,
@@ -437,6 +439,7 @@ rte_event_crypto_adapter_create_ext(uint8_t id, uint8_t dev_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_create)
 int
 rte_event_crypto_adapter_create(uint8_t id, uint8_t dev_id,
 				struct rte_event_port_conf *port_config,
@@ -465,6 +468,7 @@ rte_event_crypto_adapter_create(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_free)
 int
 rte_event_crypto_adapter_free(uint8_t id)
 {
@@ -1036,6 +1040,7 @@ eca_add_queue_pair(struct event_crypto_adapter *adapter, uint8_t cdev_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_add)
 int
 rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 			uint8_t cdev_id,
@@ -1190,6 +1195,7 @@ rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_queue_pair_del)
 int
 rte_event_crypto_adapter_queue_pair_del(uint8_t id, uint8_t cdev_id,
 					int32_t queue_pair_id)
@@ -1315,6 +1321,7 @@ eca_adapter_ctrl(uint8_t id, int start)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_start)
 int
 rte_event_crypto_adapter_start(uint8_t id)
 {
@@ -1329,6 +1336,7 @@ rte_event_crypto_adapter_start(uint8_t id)
 	return eca_adapter_ctrl(id, 1);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stop)
 int
 rte_event_crypto_adapter_stop(uint8_t id)
 {
@@ -1336,6 +1344,7 @@ rte_event_crypto_adapter_stop(uint8_t id)
 	return eca_adapter_ctrl(id, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_get)
 int
 rte_event_crypto_adapter_stats_get(uint8_t id,
 				struct rte_event_crypto_adapter_stats *stats)
@@ -1388,6 +1397,7 @@ rte_event_crypto_adapter_stats_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_stats_reset)
 int
 rte_event_crypto_adapter_stats_reset(uint8_t id)
 {
@@ -1420,6 +1430,7 @@ rte_event_crypto_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_init, 23.03)
 int
 rte_event_crypto_adapter_runtime_params_init(
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1458,6 +1469,7 @@ crypto_adapter_cap_check(struct event_crypto_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_set, 23.03)
 int
 rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1490,6 +1502,7 @@ rte_event_crypto_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_crypto_adapter_runtime_params_get, 23.03)
 int
 rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_crypto_adapter_runtime_params *params)
@@ -1521,6 +1534,7 @@ rte_event_crypto_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_service_id_get)
 int
 rte_event_crypto_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1540,6 +1554,7 @@ rte_event_crypto_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return adapter->service_inited ? 0 : -ESRCH;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_event_port_get)
 int
 rte_event_crypto_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -1558,6 +1573,7 @@ rte_event_crypto_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_vector_limits_get)
 int
 rte_event_crypto_adapter_vector_limits_get(
 	uint8_t dev_id, uint16_t cdev_id,
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index d9a02a30f2..9ac6a4a205 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -3,6 +3,7 @@
  */
 
 #include <eventdev_pmd.h>
+#include <eal_export.h>
 #include <rte_service_component.h>
 
 #include "rte_event_dma_adapter.h"
@@ -340,6 +341,7 @@ edma_default_config_cb(uint8_t id, uint8_t evdev_id, struct rte_event_dma_adapte
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create_ext, 23.11)
 int
 rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 				 rte_event_dma_adapter_conf_cb conf_cb,
@@ -433,6 +435,7 @@ rte_event_dma_adapter_create_ext(uint8_t id, uint8_t evdev_id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_create, 23.11)
 int
 rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port_conf *port_config,
 			    enum rte_event_dma_adapter_mode mode)
@@ -457,6 +460,7 @@ rte_event_dma_adapter_create(uint8_t id, uint8_t evdev_id, struct rte_event_port
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_free, 23.11)
 int
 rte_event_dma_adapter_free(uint8_t id)
 {
@@ -477,6 +481,7 @@ rte_event_dma_adapter_free(uint8_t id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_event_port_get, 23.11)
 int
 rte_event_dma_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -983,6 +988,7 @@ edma_add_vchan(struct event_dma_adapter *adapter, int16_t dma_dev_id, uint16_t v
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_add, 23.11)
 int
 rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 				const struct rte_event *event)
@@ -1097,6 +1103,7 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_vchan_del, 23.11)
 int
 rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 {
@@ -1163,6 +1170,7 @@ rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_service_id_get, 23.11)
 int
 rte_event_dma_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1222,6 +1230,7 @@ edma_adapter_ctrl(uint8_t id, int start)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_start, 23.11)
 int
 rte_event_dma_adapter_start(uint8_t id)
 {
@@ -1236,6 +1245,7 @@ rte_event_dma_adapter_start(uint8_t id)
 	return edma_adapter_ctrl(id, 1);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stop, 23.11)
 int
 rte_event_dma_adapter_stop(uint8_t id)
 {
@@ -1244,6 +1254,7 @@ rte_event_dma_adapter_stop(uint8_t id)
 
 #define DEFAULT_MAX_NB 128
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_init, 23.11)
 int
 rte_event_dma_adapter_runtime_params_init(struct rte_event_dma_adapter_runtime_params *params)
 {
@@ -1279,6 +1290,7 @@ dma_adapter_cap_check(struct event_dma_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_set, 23.11)
 int
 rte_event_dma_adapter_runtime_params_set(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1308,6 +1320,7 @@ rte_event_dma_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_runtime_params_get, 23.11)
 int
 rte_event_dma_adapter_runtime_params_get(uint8_t id,
 					 struct rte_event_dma_adapter_runtime_params *params)
@@ -1335,6 +1348,7 @@ rte_event_dma_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_get, 23.11)
 int
 rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *stats)
 {
@@ -1380,6 +1394,7 @@ rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_stats_reset, 23.11)
 int
 rte_event_dma_adapter_stats_reset(uint8_t id)
 {
@@ -1412,6 +1427,7 @@ rte_event_dma_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_enqueue, 23.11)
 uint16_t
 rte_event_dma_adapter_enqueue(uint8_t dev_id, uint8_t port_id, struct rte_event ev[],
 			      uint16_t nb_events)
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index ad832413d6..994f256322 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -10,6 +10,7 @@
 #endif
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_cycles.h>
 #include <rte_thread.h>
 #include <rte_common.h>
@@ -2518,6 +2519,7 @@ rxa_config_params_validate(struct rte_event_eth_rx_adapter_params *rxa_params,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_ext)
 int
 rte_event_eth_rx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -2532,6 +2534,7 @@ rte_event_eth_rx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 	return rxa_create(id, dev_id, &rxa_params, conf_cb, conf_arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create_with_params)
 int
 rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
 			struct rte_event_port_conf *port_config,
@@ -2564,6 +2567,7 @@ rte_event_eth_rx_adapter_create_with_params(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_create_ext_with_params, 23.11)
 int
 rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 			rte_event_eth_rx_adapter_conf_cb conf_cb,
@@ -2580,6 +2584,7 @@ rte_event_eth_rx_adapter_create_ext_with_params(uint8_t id, uint8_t dev_id,
 	return rxa_create(id, dev_id, &temp_params, conf_cb, conf_arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_create)
 int
 rte_event_eth_rx_adapter_create(uint8_t id, uint8_t dev_id,
 		struct rte_event_port_conf *port_config)
@@ -2605,6 +2610,7 @@ rte_event_eth_rx_adapter_create(uint8_t id, uint8_t dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_free)
 int
 rte_event_eth_rx_adapter_free(uint8_t id)
 {
@@ -2637,6 +2643,7 @@ rte_event_eth_rx_adapter_free(uint8_t id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_add)
 int
 rte_event_eth_rx_adapter_queue_add(uint8_t id,
 		uint16_t eth_dev_id,
@@ -2790,6 +2797,7 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_queues_add, 25.03)
 int
 rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32_t rx_queue_id[],
 				    const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
@@ -2961,6 +2969,7 @@ rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limits)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_del)
 int
 rte_event_eth_rx_adapter_queue_del(uint8_t id, uint16_t eth_dev_id,
 				int32_t rx_queue_id)
@@ -3089,6 +3098,7 @@ rte_event_eth_rx_adapter_queue_del(uint8_t id, uint16_t eth_dev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_vector_limits_get)
 int
 rte_event_eth_rx_adapter_vector_limits_get(
 	uint8_t dev_id, uint16_t eth_port_id,
@@ -3130,6 +3140,7 @@ rte_event_eth_rx_adapter_vector_limits_get(
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_start)
 int
 rte_event_eth_rx_adapter_start(uint8_t id)
 {
@@ -3137,6 +3148,7 @@ rte_event_eth_rx_adapter_start(uint8_t id)
 	return rxa_ctrl(id, 1);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stop)
 int
 rte_event_eth_rx_adapter_stop(uint8_t id)
 {
@@ -3153,6 +3165,7 @@ rxa_queue_stats_reset(struct eth_rx_queue_info *queue_info)
 	memset(q_stats, 0, sizeof(*q_stats));
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_get)
 int
 rte_event_eth_rx_adapter_stats_get(uint8_t id,
 			       struct rte_event_eth_rx_adapter_stats *stats)
@@ -3227,6 +3240,7 @@ rte_event_eth_rx_adapter_stats_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_get)
 int
 rte_event_eth_rx_adapter_queue_stats_get(uint8_t id,
 		uint16_t eth_dev_id,
@@ -3291,6 +3305,7 @@ rte_event_eth_rx_adapter_queue_stats_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_stats_reset)
 int
 rte_event_eth_rx_adapter_stats_reset(uint8_t id)
 {
@@ -3338,6 +3353,7 @@ rte_event_eth_rx_adapter_stats_reset(uint8_t id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_stats_reset)
 int
 rte_event_eth_rx_adapter_queue_stats_reset(uint8_t id,
 		uint16_t eth_dev_id,
@@ -3392,6 +3408,7 @@ rte_event_eth_rx_adapter_queue_stats_reset(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_service_id_get)
 int
 rte_event_eth_rx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -3414,6 +3431,7 @@ rte_event_eth_rx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return rx_adapter->service_inited ? 0 : -ESRCH;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_event_port_get)
 int
 rte_event_eth_rx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -3436,6 +3454,7 @@ rte_event_eth_rx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return rx_adapter->service_inited ? 0 : -ESRCH;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_cb_register)
 int
 rte_event_eth_rx_adapter_cb_register(uint8_t id,
 					uint16_t eth_dev_id,
@@ -3484,6 +3503,7 @@ rte_event_eth_rx_adapter_cb_register(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_queue_conf_get)
 int
 rte_event_eth_rx_adapter_queue_conf_get(uint8_t id,
 			uint16_t eth_dev_id,
@@ -3585,6 +3605,7 @@ rxa_is_queue_added(struct event_eth_rx_adapter *rx_adapter,
 #define rxa_dev_instance_get(rx_adapter) \
 		rxa_evdev((rx_adapter))->dev_ops->eth_rx_adapter_instance_get
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_instance_get)
 int
 rte_event_eth_rx_adapter_instance_get(uint16_t eth_dev_id,
 				      uint16_t rx_queue_id,
@@ -3663,6 +3684,7 @@ rxa_caps_check(struct event_eth_rx_adapter *rxa)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_init, 23.03)
 int
 rte_event_eth_rx_adapter_runtime_params_init(
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3676,6 +3698,7 @@ rte_event_eth_rx_adapter_runtime_params_init(
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_set, 23.03)
 int
 rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
@@ -3704,6 +3727,7 @@ rte_event_eth_rx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_rx_adapter_runtime_params_get, 23.03)
 int
 rte_event_eth_rx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_rx_adapter_runtime_params *params)
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 67fff8b7d6..83b6af0955 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2018 Intel Corporation.
  */
+#include <eal_export.h>
 #include <rte_spinlock.h>
 #include <rte_service_component.h>
 #include <ethdev_driver.h>
@@ -1038,6 +1039,7 @@ txa_service_stop(uint8_t id)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create)
 int
 rte_event_eth_tx_adapter_create(uint8_t id, uint8_t dev_id,
 				struct rte_event_port_conf *port_conf)
@@ -1082,6 +1084,7 @@ rte_event_eth_tx_adapter_create(uint8_t id, uint8_t dev_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_create_ext)
 int
 rte_event_eth_tx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 				rte_event_eth_tx_adapter_conf_cb conf_cb,
@@ -1126,6 +1129,7 @@ rte_event_eth_tx_adapter_create_ext(uint8_t id, uint8_t dev_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_event_port_get)
 int
 rte_event_eth_tx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 {
@@ -1136,6 +1140,7 @@ rte_event_eth_tx_adapter_event_port_get(uint8_t id, uint8_t *event_port_id)
 	return txa_service_event_port_get(id, event_port_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_free)
 int
 rte_event_eth_tx_adapter_free(uint8_t id)
 {
@@ -1155,6 +1160,7 @@ rte_event_eth_tx_adapter_free(uint8_t id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_add)
 int
 rte_event_eth_tx_adapter_queue_add(uint8_t id,
 				uint16_t eth_dev_id,
@@ -1188,6 +1194,7 @@ rte_event_eth_tx_adapter_queue_add(uint8_t id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_del)
 int
 rte_event_eth_tx_adapter_queue_del(uint8_t id,
 				uint16_t eth_dev_id,
@@ -1220,6 +1227,7 @@ rte_event_eth_tx_adapter_queue_del(uint8_t id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_service_id_get)
 int
 rte_event_eth_tx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 {
@@ -1228,6 +1236,7 @@ rte_event_eth_tx_adapter_service_id_get(uint8_t id, uint32_t *service_id)
 	return txa_service_id_get(id, service_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_start)
 int
 rte_event_eth_tx_adapter_start(uint8_t id)
 {
@@ -1242,6 +1251,7 @@ rte_event_eth_tx_adapter_start(uint8_t id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_get)
 int
 rte_event_eth_tx_adapter_stats_get(uint8_t id,
 				struct rte_event_eth_tx_adapter_stats *stats)
@@ -1278,6 +1288,7 @@ rte_event_eth_tx_adapter_stats_get(uint8_t id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stats_reset)
 int
 rte_event_eth_tx_adapter_stats_reset(uint8_t id)
 {
@@ -1295,6 +1306,7 @@ rte_event_eth_tx_adapter_stats_reset(uint8_t id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_init, 23.03)
 int
 rte_event_eth_tx_adapter_runtime_params_init(
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1321,6 +1333,7 @@ txa_caps_check(struct txa_service_data *txa)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_set, 23.03)
 int
 rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1352,6 +1365,7 @@ rte_event_eth_tx_adapter_runtime_params_set(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_eth_tx_adapter_runtime_params_get, 23.03)
 int
 rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 		struct rte_event_eth_tx_adapter_runtime_params *txa_params)
@@ -1383,6 +1397,7 @@ rte_event_eth_tx_adapter_runtime_params_get(uint8_t id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_stop)
 int
 rte_event_eth_tx_adapter_stop(uint8_t id)
 {
@@ -1397,6 +1412,7 @@ rte_event_eth_tx_adapter_stop(uint8_t id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_instance_get)
 int
 rte_event_eth_tx_adapter_instance_get(uint16_t eth_dev_id,
 				      uint16_t tx_queue_id,
@@ -1530,6 +1546,7 @@ txa_queue_start_state_set(uint16_t eth_dev_id, uint16_t tx_queue_id,
 					    start_state, txa);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_start)
 int
 rte_event_eth_tx_adapter_queue_start(uint16_t eth_dev_id, uint16_t tx_queue_id)
 {
@@ -1538,6 +1555,7 @@ rte_event_eth_tx_adapter_queue_start(uint16_t eth_dev_id, uint16_t tx_queue_id)
 	return txa_queue_start_state_set(eth_dev_id, tx_queue_id, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_queue_stop)
 int
 rte_event_eth_tx_adapter_queue_stop(uint16_t eth_dev_id, uint16_t tx_queue_id)
 {
diff --git a/lib/eventdev/rte_event_ring.c b/lib/eventdev/rte_event_ring.c
index b965970cf9..5718985486 100644
--- a/lib/eventdev/rte_event_ring.c
+++ b/lib/eventdev/rte_event_ring.c
@@ -4,9 +4,11 @@
  */
 
 
+#include <eal_export.h>
 #include "rte_event_ring.h"
 #include "eventdev_trace.h"
 
+RTE_EXPORT_SYMBOL(rte_event_ring_init)
 int
 rte_event_ring_init(struct rte_event_ring *r, const char *name,
 	unsigned int count, unsigned int flags)
@@ -22,6 +24,7 @@ rte_event_ring_init(struct rte_event_ring *r, const char *name,
 }
 
 /* create the ring */
+RTE_EXPORT_SYMBOL(rte_event_ring_create)
 struct rte_event_ring *
 rte_event_ring_create(const char *name, unsigned int count, int socket_id,
 		unsigned int flags)
@@ -34,6 +37,7 @@ rte_event_ring_create(const char *name, unsigned int count, int socket_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_event_ring_lookup)
 struct rte_event_ring *
 rte_event_ring_lookup(const char *name)
 {
@@ -43,6 +47,7 @@ rte_event_ring_lookup(const char *name)
 }
 
 /* free the ring */
+RTE_EXPORT_SYMBOL(rte_event_ring_free)
 void
 rte_event_ring_free(struct rte_event_ring *r)
 {
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index 5886965d14..b524dc3e55 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <math.h>
 
+#include <eal_export.h>
 #include <rte_memzone.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -132,6 +133,7 @@ default_port_conf_cb(uint16_t id, uint8_t event_dev_id, uint8_t *event_port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create)
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_create(const struct rte_event_timer_adapter_conf *conf)
 {
@@ -139,6 +141,7 @@ rte_event_timer_adapter_create(const struct rte_event_timer_adapter_conf *conf)
 						  NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_create_ext)
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_create_ext(
 		const struct rte_event_timer_adapter_conf *conf,
@@ -264,6 +267,7 @@ rte_event_timer_adapter_create_ext(
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_get_info)
 int
 rte_event_timer_adapter_get_info(const struct rte_event_timer_adapter *adapter,
 		struct rte_event_timer_adapter_info *adapter_info)
@@ -284,6 +288,7 @@ rte_event_timer_adapter_get_info(const struct rte_event_timer_adapter *adapter,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_start)
 int
 rte_event_timer_adapter_start(const struct rte_event_timer_adapter *adapter)
 {
@@ -307,6 +312,7 @@ rte_event_timer_adapter_start(const struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stop)
 int
 rte_event_timer_adapter_stop(const struct rte_event_timer_adapter *adapter)
 {
@@ -330,6 +336,7 @@ rte_event_timer_adapter_stop(const struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_lookup)
 struct rte_event_timer_adapter *
 rte_event_timer_adapter_lookup(uint16_t adapter_id)
 {
@@ -397,6 +404,7 @@ rte_event_timer_adapter_lookup(uint16_t adapter_id)
 	return adapter;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_free)
 int
 rte_event_timer_adapter_free(struct rte_event_timer_adapter *adapter)
 {
@@ -438,6 +446,7 @@ rte_event_timer_adapter_free(struct rte_event_timer_adapter *adapter)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_service_id_get)
 int
 rte_event_timer_adapter_service_id_get(struct rte_event_timer_adapter *adapter,
 				       uint32_t *service_id)
@@ -455,6 +464,7 @@ rte_event_timer_adapter_service_id_get(struct rte_event_timer_adapter *adapter,
 	return adapter->data->service_inited ? 0 : -ESRCH;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_get)
 int
 rte_event_timer_adapter_stats_get(struct rte_event_timer_adapter *adapter,
 				  struct rte_event_timer_adapter_stats *stats)
@@ -469,6 +479,7 @@ rte_event_timer_adapter_stats_get(struct rte_event_timer_adapter *adapter,
 	return adapter->ops->stats_get(adapter, stats);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_stats_reset)
 int
 rte_event_timer_adapter_stats_reset(struct rte_event_timer_adapter *adapter)
 {
@@ -479,6 +490,7 @@ rte_event_timer_adapter_stats_reset(struct rte_event_timer_adapter *adapter)
 	return adapter->ops->stats_reset(adapter);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_timer_remaining_ticks_get, 23.03)
 int
 rte_event_timer_remaining_ticks_get(
 			const struct rte_event_timer_adapter *adapter,
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 43cd95d765..b66cbb4676 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -11,6 +11,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -29,10 +30,12 @@
 #include "eventdev_pmd.h"
 #include "eventdev_trace.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_event_logtype, INFO);
 
 static struct rte_eventdev rte_event_devices[RTE_EVENT_MAX_DEVS];
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eventdevs)
 struct rte_eventdev *rte_eventdevs = rte_event_devices;
 
 static struct rte_eventdev_global eventdev_globals = {
@@ -40,16 +43,19 @@ static struct rte_eventdev_global eventdev_globals = {
 };
 
 /* Public fastpath APIs. */
+RTE_EXPORT_SYMBOL(rte_event_fp_ops)
 struct rte_event_fp_ops rte_event_fp_ops[RTE_EVENT_MAX_DEVS];
 
 /* Event dev north bound API implementation */
 
+RTE_EXPORT_SYMBOL(rte_event_dev_count)
 uint8_t
 rte_event_dev_count(void)
 {
 	return eventdev_globals.nb_devs;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_get_dev_id)
 int
 rte_event_dev_get_dev_id(const char *name)
 {
@@ -74,6 +80,7 @@ rte_event_dev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_socket_id)
 int
 rte_event_dev_socket_id(uint8_t dev_id)
 {
@@ -87,6 +94,7 @@ rte_event_dev_socket_id(uint8_t dev_id)
 	return dev->data->socket_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_info_get)
 int
 rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 {
@@ -115,6 +123,7 @@ rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_rx_adapter_caps_get)
 int
 rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps)
@@ -141,6 +150,7 @@ rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		: 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_timer_adapter_caps_get)
 int
 rte_event_timer_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 {
@@ -166,6 +176,7 @@ rte_event_timer_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 		: 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_crypto_adapter_caps_get)
 int
 rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
 				  uint32_t *caps)
@@ -194,6 +205,7 @@ rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
 		dev->dev_ops->crypto_adapter_caps_get(dev, cdev, caps) : 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_eth_tx_adapter_caps_get)
 int
 rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps)
@@ -222,6 +234,7 @@ rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		: 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_dma_adapter_caps_get, 23.11)
 int
 rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *caps)
 {
@@ -337,6 +350,7 @@ event_dev_port_config(struct rte_eventdev *dev, uint8_t nb_ports)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_configure)
 int
 rte_event_dev_configure(uint8_t dev_id,
 			const struct rte_event_dev_config *dev_conf)
@@ -539,6 +553,7 @@ is_valid_queue(struct rte_eventdev *dev, uint8_t queue_id)
 		return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_queue_default_conf_get)
 int
 rte_event_queue_default_conf_get(uint8_t dev_id, uint8_t queue_id,
 				 struct rte_event_queue_conf *queue_conf)
@@ -599,6 +614,7 @@ is_valid_ordered_queue_conf(const struct rte_event_queue_conf *queue_conf)
 }
 
 
+RTE_EXPORT_SYMBOL(rte_event_queue_setup)
 int
 rte_event_queue_setup(uint8_t dev_id, uint8_t queue_id,
 		      const struct rte_event_queue_conf *queue_conf)
@@ -670,6 +686,7 @@ is_valid_port(struct rte_eventdev *dev, uint8_t port_id)
 		return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_default_conf_get)
 int
 rte_event_port_default_conf_get(uint8_t dev_id, uint8_t port_id,
 				 struct rte_event_port_conf *port_conf)
@@ -697,6 +714,7 @@ rte_event_port_default_conf_get(uint8_t dev_id, uint8_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_setup)
 int
 rte_event_port_setup(uint8_t dev_id, uint8_t port_id,
 		     const struct rte_event_port_conf *port_conf)
@@ -787,6 +805,7 @@ rte_event_port_setup(uint8_t dev_id, uint8_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_quiesce)
 void
 rte_event_port_quiesce(uint8_t dev_id, uint8_t port_id,
 		       rte_eventdev_port_flush_t release_cb, void *args)
@@ -807,6 +826,7 @@ rte_event_port_quiesce(uint8_t dev_id, uint8_t port_id,
 		dev->dev_ops->port_quiesce(dev, dev->data->ports[port_id], release_cb, args);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_attr_get)
 int
 rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 		       uint32_t *attr_value)
@@ -837,6 +857,7 @@ rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_attr_get)
 int
 rte_event_port_attr_get(uint8_t dev_id, uint8_t port_id, uint32_t attr_id,
 			uint32_t *attr_value)
@@ -888,6 +909,7 @@ rte_event_port_attr_get(uint8_t dev_id, uint8_t port_id, uint32_t attr_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_queue_attr_get)
 int
 rte_event_queue_attr_get(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 			uint32_t *attr_value)
@@ -947,6 +969,7 @@ rte_event_queue_attr_get(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_queue_attr_set)
 int
 rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 			 uint64_t attr_value)
@@ -975,6 +998,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 	return dev->dev_ops->queue_attr_set(dev, queue_id, attr_id, attr_value);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_link)
 int
 rte_event_port_link(uint8_t dev_id, uint8_t port_id,
 		    const uint8_t queues[], const uint8_t priorities[],
@@ -983,6 +1007,7 @@ rte_event_port_link(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_links_set(dev_id, port_id, queues, priorities, nb_links, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_set, 23.11)
 int
 rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t queues[],
 				 const uint8_t priorities[], uint16_t nb_links, uint8_t profile_id)
@@ -1065,6 +1090,7 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_unlink)
 int
 rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
 		      uint8_t queues[], uint16_t nb_unlinks)
@@ -1072,6 +1098,7 @@ rte_event_port_unlink(uint8_t dev_id, uint8_t port_id,
 	return rte_event_port_profile_unlink(dev_id, port_id, queues, nb_unlinks, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_unlink, 23.11)
 int
 rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 			      uint16_t nb_unlinks, uint8_t profile_id)
@@ -1158,6 +1185,7 @@ rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_unlinks_in_progress)
 int
 rte_event_port_unlinks_in_progress(uint8_t dev_id, uint8_t port_id)
 {
@@ -1182,6 +1210,7 @@ rte_event_port_unlinks_in_progress(uint8_t dev_id, uint8_t port_id)
 	return dev->dev_ops->port_unlinks_in_progress(dev, dev->data->ports[port_id]);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_port_links_get)
 int
 rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
 			 uint8_t queues[], uint8_t priorities[])
@@ -1214,6 +1243,7 @@ rte_event_port_links_get(uint8_t dev_id, uint8_t port_id,
 	return count;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_port_profile_links_get, 23.11)
 int
 rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 				 uint8_t priorities[], uint8_t profile_id)
@@ -1257,6 +1287,7 @@ rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dequeue_timeout_ticks)
 int
 rte_event_dequeue_timeout_ticks(uint8_t dev_id, uint64_t ns,
 				 uint64_t *timeout_ticks)
@@ -1276,6 +1307,7 @@ rte_event_dequeue_timeout_ticks(uint8_t dev_id, uint64_t ns,
 	return dev->dev_ops->timeout_ticks(dev, ns, timeout_ticks);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_service_id_get)
 int
 rte_event_dev_service_id_get(uint8_t dev_id, uint32_t *service_id)
 {
@@ -1295,6 +1327,7 @@ rte_event_dev_service_id_get(uint8_t dev_id, uint32_t *service_id)
 	return dev->data->service_inited ? 0 : -ESRCH;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_dump)
 int
 rte_event_dev_dump(uint8_t dev_id, FILE *f)
 {
@@ -1322,6 +1355,7 @@ xstats_get_count(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_names_get)
 int
 rte_event_dev_xstats_names_get(uint8_t dev_id,
 		enum rte_event_dev_xstats_mode mode, uint8_t queue_port_id,
@@ -1346,6 +1380,7 @@ rte_event_dev_xstats_names_get(uint8_t dev_id,
 }
 
 /* retrieve eventdev extended statistics */
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_get)
 int
 rte_event_dev_xstats_get(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 		uint8_t queue_port_id, const uint64_t ids[],
@@ -1361,6 +1396,7 @@ rte_event_dev_xstats_get(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_by_name_get)
 uint64_t
 rte_event_dev_xstats_by_name_get(uint8_t dev_id, const char *name,
 		uint64_t *id)
@@ -1380,6 +1416,7 @@ rte_event_dev_xstats_by_name_get(uint8_t dev_id, const char *name,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_xstats_reset)
 int rte_event_dev_xstats_reset(uint8_t dev_id,
 		enum rte_event_dev_xstats_mode mode, int16_t queue_port_id,
 		const uint64_t ids[], uint32_t nb_ids)
@@ -1392,8 +1429,10 @@ int rte_event_dev_xstats_reset(uint8_t dev_id,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_selftest_seqn_dynfield_offset)
 int rte_event_pmd_selftest_seqn_dynfield_offset = -1;
 
+RTE_EXPORT_SYMBOL(rte_event_dev_selftest)
 int rte_event_dev_selftest(uint8_t dev_id)
 {
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
@@ -1414,6 +1453,7 @@ int rte_event_dev_selftest(uint8_t dev_id)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_vector_pool_create)
 struct rte_mempool *
 rte_event_vector_pool_create(const char *name, unsigned int n,
 			     unsigned int cache_size, uint16_t nb_elem,
@@ -1459,6 +1499,7 @@ rte_event_vector_pool_create(const char *name, unsigned int n,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_start)
 int
 rte_event_dev_start(uint8_t dev_id)
 {
@@ -1490,6 +1531,7 @@ rte_event_dev_start(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_stop_flush_callback_register)
 int
 rte_event_dev_stop_flush_callback_register(uint8_t dev_id,
 					   rte_eventdev_stop_flush_t callback,
@@ -1510,6 +1552,7 @@ rte_event_dev_stop_flush_callback_register(uint8_t dev_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_stop)
 void
 rte_event_dev_stop(uint8_t dev_id)
 {
@@ -1534,6 +1577,7 @@ rte_event_dev_stop(uint8_t dev_id)
 	event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_event_dev_close)
 int
 rte_event_dev_close(uint8_t dev_id)
 {
@@ -1604,6 +1648,7 @@ eventdev_find_free_device_index(void)
 	return RTE_EVENT_MAX_DEVS;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_allocate)
 struct rte_eventdev *
 rte_event_pmd_allocate(const char *name, int socket_id)
 {
@@ -1652,6 +1697,7 @@ rte_event_pmd_allocate(const char *name, int socket_id)
 	return eventdev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_event_pmd_release)
 int
 rte_event_pmd_release(struct rte_eventdev *eventdev)
 {
@@ -1688,6 +1734,7 @@ rte_event_pmd_release(struct rte_eventdev *eventdev)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(event_dev_probing_finish)
 void
 event_dev_probing_finish(struct rte_eventdev *eventdev)
 {
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 49211fe3fa..2c05d46500 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -120,6 +121,7 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_add)
 int
 rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 {
@@ -129,6 +131,7 @@ rte_fib_add(struct rte_fib *fib, uint32_t ip, uint8_t depth, uint64_t next_hop)
 	return fib->modify(fib, ip, depth, next_hop, RTE_FIB_ADD);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_delete)
 int
 rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 {
@@ -138,6 +141,7 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth)
 	return fib->modify(fib, ip, depth, 0, RTE_FIB_DEL);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_lookup_bulk)
 int
 rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	uint64_t *next_hops, int n)
@@ -149,6 +153,7 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_create)
 struct rte_fib *
 rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 {
@@ -245,6 +250,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_find_existing)
 struct rte_fib *
 rte_fib_find_existing(const char *name)
 {
@@ -283,6 +289,7 @@ free_dataplane(struct rte_fib *fib)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_free)
 void
 rte_fib_free(struct rte_fib *fib)
 {
@@ -312,18 +319,21 @@ rte_fib_free(struct rte_fib *fib)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_get_dp)
 void *
 rte_fib_get_dp(struct rte_fib *fib)
 {
 	return (fib == NULL) ? NULL : fib->dp;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_get_rib)
 struct rte_rib *
 rte_fib_get_rib(struct rte_fib *fib)
 {
 	return (fib == NULL) ? NULL : fib->rib;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib_select_lookup)
 int
 rte_fib_select_lookup(struct rte_fib *fib,
 	enum rte_fib_lookup_type type)
@@ -343,6 +353,7 @@ rte_fib_select_lookup(struct rte_fib *fib,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_rcu_qsbr_add, 24.11)
 int
 rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 {
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 9c7d4fde43..00647bdfa4 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -7,6 +7,7 @@
 #include <string.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_tailq.h>
 #include <rte_errno.h>
@@ -118,6 +119,7 @@ init_dataplane(struct rte_fib6 *fib, __rte_unused int socket_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_add)
 int
 rte_fib6_add(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop)
@@ -128,6 +130,7 @@ rte_fib6_add(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	return fib->modify(fib, ip, depth, next_hop, RTE_FIB6_ADD);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_delete)
 int
 rte_fib6_delete(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth)
@@ -138,6 +141,7 @@ rte_fib6_delete(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	return fib->modify(fib, ip, depth, 0, RTE_FIB6_DEL);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_lookup_bulk)
 int
 rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	const struct rte_ipv6_addr *ips,
@@ -149,6 +153,7 @@ rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_create)
 struct rte_fib6 *
 rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 {
@@ -243,6 +248,7 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_find_existing)
 struct rte_fib6 *
 rte_fib6_find_existing(const char *name)
 {
@@ -281,6 +287,7 @@ free_dataplane(struct rte_fib6 *fib)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_free)
 void
 rte_fib6_free(struct rte_fib6 *fib)
 {
@@ -310,18 +317,21 @@ rte_fib6_free(struct rte_fib6 *fib)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_get_dp)
 void *
 rte_fib6_get_dp(struct rte_fib6 *fib)
 {
 	return (fib == NULL) ? NULL : fib->dp;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_get_rib)
 struct rte_rib6 *
 rte_fib6_get_rib(struct rte_fib6 *fib)
 {
 	return (fib == NULL) ? NULL : fib->rib;
 }
 
+RTE_EXPORT_SYMBOL(rte_fib6_select_lookup)
 int
 rte_fib6_select_lookup(struct rte_fib6 *fib,
 	enum rte_fib6_lookup_type type)
diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 1c2011b856..0473d9ffb3 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_tailq.h>
 #include <rte_string_fns.h>
@@ -49,6 +50,7 @@ struct rte_gpu_callback {
 static rte_rwlock_t gpu_callback_lock = RTE_RWLOCK_INITIALIZER;
 static void gpu_free_callbacks(struct rte_gpu *dev);
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_init, 21.11)
 int
 rte_gpu_init(size_t dev_max)
 {
@@ -76,12 +78,14 @@ rte_gpu_init(size_t dev_max)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_count_avail, 21.11)
 uint16_t
 rte_gpu_count_avail(void)
 {
 	return gpu_count;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_is_valid, 21.11)
 bool
 rte_gpu_is_valid(int16_t dev_id)
 {
@@ -99,6 +103,7 @@ gpu_match_parent(int16_t dev_id, int16_t parent)
 	return gpus[dev_id].mpshared->info.parent == parent;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_find_next, 21.11)
 int16_t
 rte_gpu_find_next(int16_t dev_id, int16_t parent)
 {
@@ -134,6 +139,7 @@ gpu_get_by_id(int16_t dev_id)
 	return &gpus[dev_id];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_get_by_name)
 struct rte_gpu *
 rte_gpu_get_by_name(const char *name)
 {
@@ -176,6 +182,7 @@ gpu_shared_mem_init(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_allocate)
 struct rte_gpu *
 rte_gpu_allocate(const char *name)
 {
@@ -237,6 +244,7 @@ rte_gpu_allocate(const char *name)
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_attach)
 struct rte_gpu *
 rte_gpu_attach(const char *name)
 {
@@ -286,6 +294,7 @@ rte_gpu_attach(const char *name)
 	return dev;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_add_child, 21.11)
 int16_t
 rte_gpu_add_child(const char *name, int16_t parent, uint64_t child_context)
 {
@@ -308,6 +317,7 @@ rte_gpu_add_child(const char *name, int16_t parent, uint64_t child_context)
 	return dev->mpshared->info.dev_id;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_complete_new)
 void
 rte_gpu_complete_new(struct rte_gpu *dev)
 {
@@ -318,6 +328,7 @@ rte_gpu_complete_new(struct rte_gpu *dev)
 	rte_gpu_notify(dev, RTE_GPU_EVENT_NEW);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_release)
 int
 rte_gpu_release(struct rte_gpu *dev)
 {
@@ -347,6 +358,7 @@ rte_gpu_release(struct rte_gpu *dev)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_close, 21.11)
 int
 rte_gpu_close(int16_t dev_id)
 {
@@ -373,6 +385,7 @@ rte_gpu_close(int16_t dev_id)
 	return firsterr;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_register, 21.11)
 int
 rte_gpu_callback_register(int16_t dev_id, enum rte_gpu_event event,
 		rte_gpu_callback_t *function, void *user_data)
@@ -432,6 +445,7 @@ rte_gpu_callback_register(int16_t dev_id, enum rte_gpu_event event,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_callback_unregister, 21.11)
 int
 rte_gpu_callback_unregister(int16_t dev_id, enum rte_gpu_event event,
 		rte_gpu_callback_t *function, void *user_data)
@@ -491,6 +505,7 @@ gpu_free_callbacks(struct rte_gpu *dev)
 	rte_rwlock_write_unlock(&gpu_callback_lock);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_gpu_notify)
 void
 rte_gpu_notify(struct rte_gpu *dev, enum rte_gpu_event event)
 {
@@ -507,6 +522,7 @@ rte_gpu_notify(struct rte_gpu *dev, enum rte_gpu_event event)
 	rte_rwlock_read_unlock(&gpu_callback_lock);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_info_get, 21.11)
 int
 rte_gpu_info_get(int16_t dev_id, struct rte_gpu_info *info)
 {
@@ -531,6 +547,7 @@ rte_gpu_info_get(int16_t dev_id, struct rte_gpu_info *info)
 	return GPU_DRV_RET(dev->ops.dev_info_get(dev, info));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_alloc, 21.11)
 void *
 rte_gpu_mem_alloc(int16_t dev_id, size_t size, unsigned int align)
 {
@@ -575,6 +592,7 @@ rte_gpu_mem_alloc(int16_t dev_id, size_t size, unsigned int align)
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_free, 21.11)
 int
 rte_gpu_mem_free(int16_t dev_id, void *ptr)
 {
@@ -598,6 +616,7 @@ rte_gpu_mem_free(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_free(dev, ptr));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_register, 21.11)
 int
 rte_gpu_mem_register(int16_t dev_id, size_t size, void *ptr)
 {
@@ -622,6 +641,7 @@ rte_gpu_mem_register(int16_t dev_id, size_t size, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_register(dev, size, ptr));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_unregister, 21.11)
 int
 rte_gpu_mem_unregister(int16_t dev_id, void *ptr)
 {
@@ -645,6 +665,7 @@ rte_gpu_mem_unregister(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_unregister(dev, ptr));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_map, 21.11)
 void *
 rte_gpu_mem_cpu_map(int16_t dev_id, size_t size, void *ptr)
 {
@@ -683,6 +704,7 @@ rte_gpu_mem_cpu_map(int16_t dev_id, size_t size, void *ptr)
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_mem_cpu_unmap, 21.11)
 int
 rte_gpu_mem_cpu_unmap(int16_t dev_id, void *ptr)
 {
@@ -706,6 +728,7 @@ rte_gpu_mem_cpu_unmap(int16_t dev_id, void *ptr)
 	return GPU_DRV_RET(dev->ops.mem_cpu_unmap(dev, ptr));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_wmb, 21.11)
 int
 rte_gpu_wmb(int16_t dev_id)
 {
@@ -725,6 +748,7 @@ rte_gpu_wmb(int16_t dev_id)
 	return GPU_DRV_RET(dev->ops.wmb(dev));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_flag, 21.11)
 int
 rte_gpu_comm_create_flag(uint16_t dev_id, struct rte_gpu_comm_flag *devflag,
 		enum rte_gpu_comm_flag_type mtype)
@@ -761,6 +785,7 @@ rte_gpu_comm_create_flag(uint16_t dev_id, struct rte_gpu_comm_flag *devflag,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_flag, 21.11)
 int
 rte_gpu_comm_destroy_flag(struct rte_gpu_comm_flag *devflag)
 {
@@ -782,6 +807,7 @@ rte_gpu_comm_destroy_flag(struct rte_gpu_comm_flag *devflag)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_flag, 21.11)
 int
 rte_gpu_comm_set_flag(struct rte_gpu_comm_flag *devflag, uint32_t val)
 {
@@ -800,6 +826,7 @@ rte_gpu_comm_set_flag(struct rte_gpu_comm_flag *devflag, uint32_t val)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_flag_value, 21.11)
 int
 rte_gpu_comm_get_flag_value(struct rte_gpu_comm_flag *devflag, uint32_t *val)
 {
@@ -817,6 +844,7 @@ rte_gpu_comm_get_flag_value(struct rte_gpu_comm_flag *devflag, uint32_t *val)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_create_list, 21.11)
 struct rte_gpu_comm_list *
 rte_gpu_comm_create_list(uint16_t dev_id,
 		uint32_t num_comm_items)
@@ -940,6 +968,7 @@ rte_gpu_comm_create_list(uint16_t dev_id,
 	return comm_list;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_destroy_list, 21.11)
 int
 rte_gpu_comm_destroy_list(struct rte_gpu_comm_list *comm_list,
 		uint32_t num_comm_items)
@@ -985,6 +1014,7 @@ rte_gpu_comm_destroy_list(struct rte_gpu_comm_list *comm_list,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_populate_list_pkts, 21.11)
 int
 rte_gpu_comm_populate_list_pkts(struct rte_gpu_comm_list *comm_list_item,
 		struct rte_mbuf **mbufs, uint32_t num_mbufs)
@@ -1023,6 +1053,7 @@ rte_gpu_comm_populate_list_pkts(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_set_status, 21.11)
 int
 rte_gpu_comm_set_status(struct rte_gpu_comm_list *comm_list_item,
 		enum rte_gpu_comm_list_status status)
@@ -1037,6 +1068,7 @@ rte_gpu_comm_set_status(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_get_status, 21.11)
 int
 rte_gpu_comm_get_status(struct rte_gpu_comm_list *comm_list_item,
 		enum rte_gpu_comm_list_status *status)
@@ -1051,6 +1083,7 @@ rte_gpu_comm_get_status(struct rte_gpu_comm_list *comm_list_item,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_gpu_comm_cleanup_list, 21.11)
 int
 rte_gpu_comm_cleanup_list(struct rte_gpu_comm_list *comm_list_item)
 {
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index dff8e690a8..fe12bd3753 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_debug.h>
 #include <rte_errno.h>
@@ -317,6 +318,7 @@ graph_src_node_avail(struct graph *graph)
 	return false;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_bind)
 int
 rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 {
@@ -348,6 +350,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_core_unbind)
 void
 rte_graph_model_mcore_dispatch_core_unbind(rte_graph_t id)
 {
@@ -366,6 +369,7 @@ rte_graph_model_mcore_dispatch_core_unbind(rte_graph_t id)
 	return;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_lookup)
 struct rte_graph *
 rte_graph_lookup(const char *name)
 {
@@ -379,6 +383,7 @@ rte_graph_lookup(const char *name)
 	return graph_mem_fixup_secondary(rc);
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_create)
 rte_graph_t
 rte_graph_create(const char *name, struct rte_graph_param *prm)
 {
@@ -483,6 +488,7 @@ rte_graph_create(const char *name, struct rte_graph_param *prm)
 	return RTE_GRAPH_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_destroy)
 int
 rte_graph_destroy(rte_graph_t id)
 {
@@ -598,6 +604,7 @@ graph_clone(struct graph *parent_graph, const char *name, struct rte_graph_param
 	return RTE_GRAPH_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_clone)
 rte_graph_t
 rte_graph_clone(rte_graph_t id, const char *name, struct rte_graph_param *prm)
 {
@@ -613,6 +620,7 @@ rte_graph_clone(rte_graph_t id, const char *name, struct rte_graph_param *prm)
 	return RTE_GRAPH_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_from_name)
 rte_graph_t
 rte_graph_from_name(const char *name)
 {
@@ -625,6 +633,7 @@ rte_graph_from_name(const char *name)
 	return RTE_GRAPH_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_id_to_name)
 char *
 rte_graph_id_to_name(rte_graph_t id)
 {
@@ -640,6 +649,7 @@ rte_graph_id_to_name(rte_graph_t id)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_node_get)
 struct rte_node *
 rte_graph_node_get(rte_graph_t gid, uint32_t nid)
 {
@@ -663,6 +673,7 @@ rte_graph_node_get(rte_graph_t gid, uint32_t nid)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_node_get_by_name)
 struct rte_node *
 rte_graph_node_get_by_name(const char *graph_name, const char *node_name)
 {
@@ -685,6 +696,7 @@ rte_graph_node_get_by_name(const char *graph_name, const char *node_name)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(__rte_node_stream_alloc)
 void __rte_noinline
 __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 {
@@ -700,6 +712,7 @@ __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 	node->realloc_count++;
 }
 
+RTE_EXPORT_SYMBOL(__rte_node_stream_alloc_size)
 void __rte_noinline
 __rte_node_stream_alloc_size(struct rte_graph *graph, struct rte_node *node,
 			     uint16_t req_size)
@@ -773,6 +786,7 @@ graph_to_dot(FILE *f, struct graph *graph)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_export)
 int
 rte_graph_export(const char *name, FILE *f)
 {
@@ -810,18 +824,21 @@ graph_scan_dump(FILE *f, rte_graph_t id, bool all)
 	return;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_dump)
 void
 rte_graph_dump(FILE *f, rte_graph_t id)
 {
 	graph_scan_dump(f, id, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_list_dump)
 void
 rte_graph_list_dump(FILE *f)
 {
 	graph_scan_dump(f, 0, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_max_count)
 rte_graph_t
 rte_graph_max_count(void)
 {
diff --git a/lib/graph/graph_debug.c b/lib/graph/graph_debug.c
index 37088ce2cf..e3b8cccdc1 100644
--- a/lib/graph/graph_debug.c
+++ b/lib/graph/graph_debug.c
@@ -5,6 +5,8 @@
 
 #include "graph_private.h"
 
+#include <eal_export.h>
+
 void
 graph_dump(FILE *f, struct graph *g)
 {
@@ -50,6 +52,7 @@ node_dump(FILE *f, struct node *n)
 		fprintf(f, "     edge[%d] <%s>\n", i, n->next_nodes[i]);
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_obj_dump)
 void
 rte_graph_obj_dump(FILE *f, struct rte_graph *g, bool all)
 {
diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index 0bbbd9fb7c..eac73cbf71 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -375,6 +376,7 @@ expand_pattern_to_cluster(struct cluster *cluster, const char *pattern)
 	return -rte_errno;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_create)
 struct rte_graph_cluster_stats *
 rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 {
@@ -438,6 +440,7 @@ rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_destroy)
 void
 rte_graph_cluster_stats_destroy(struct rte_graph_cluster_stats *stat)
 {
@@ -512,6 +515,7 @@ cluster_node_store_prev_stats(struct cluster_node *cluster)
 	stat->prev_cycles = stat->cycles;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_get)
 void
 rte_graph_cluster_stats_get(struct rte_graph_cluster_stats *stat, bool skip_cb)
 {
@@ -533,6 +537,7 @@ rte_graph_cluster_stats_get(struct rte_graph_cluster_stats *stat, bool skip_cb)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_cluster_stats_reset)
 void
 rte_graph_cluster_stats_reset(struct rte_graph_cluster_stats *stat)
 {
diff --git a/lib/graph/node.c b/lib/graph/node.c
index 63db629da8..101981ec24 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_debug.h>
 #include <rte_errno.h>
@@ -54,6 +55,7 @@ node_has_duplicate_entry(const char *name)
 }
 
 /* Public functions */
+RTE_EXPORT_SYMBOL(__rte_node_register)
 rte_node_t
 __rte_node_register(const struct rte_node_register *reg)
 {
@@ -189,6 +191,7 @@ node_clone(struct node *node, const char *name)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_clone)
 rte_node_t
 rte_node_clone(rte_node_t id, const char *name)
 {
@@ -203,6 +206,7 @@ rte_node_clone(rte_node_t id, const char *name)
 	return RTE_NODE_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_from_name)
 rte_node_t
 rte_node_from_name(const char *name)
 {
@@ -215,6 +219,7 @@ rte_node_from_name(const char *name)
 	return RTE_NODE_ID_INVALID;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_id_to_name)
 char *
 rte_node_id_to_name(rte_node_t id)
 {
@@ -229,6 +234,7 @@ rte_node_id_to_name(rte_node_t id)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_edge_count)
 rte_edge_t
 rte_node_edge_count(rte_node_t id)
 {
@@ -297,6 +303,7 @@ edge_update(struct node *node, struct node *prev, rte_edge_t from,
 	return count;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_edge_shrink)
 rte_edge_t
 rte_node_edge_shrink(rte_node_t id, rte_edge_t size)
 {
@@ -323,6 +330,7 @@ rte_node_edge_shrink(rte_node_t id, rte_edge_t size)
 	return rc;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_edge_update)
 rte_edge_t
 rte_node_edge_update(rte_node_t id, rte_edge_t from, const char **next_nodes,
 		     uint16_t nb_edges)
@@ -358,6 +366,7 @@ node_copy_edges(struct node *node, char *next_nodes[])
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_edge_get)
 rte_node_t
 rte_node_edge_get(rte_node_t id, char *next_nodes[])
 {
@@ -402,18 +411,21 @@ node_scan_dump(FILE *f, rte_node_t id, bool all)
 	return;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_dump)
 void
 rte_node_dump(FILE *f, rte_node_t id)
 {
 	node_scan_dump(f, id, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_node_list_dump)
 void
 rte_node_list_dump(FILE *f)
 {
 	node_scan_dump(f, 0, true);
 }
 
+RTE_EXPORT_SYMBOL(rte_node_max_count)
 rte_node_t
 rte_node_max_count(void)
 {
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.c b/lib/graph/rte_graph_model_mcore_dispatch.c
index a590fc9497..799b14e1eb 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.c
+++ b/lib/graph/rte_graph_model_mcore_dispatch.c
@@ -3,6 +3,7 @@
  */
 
 #include "graph_private.h"
+#include <eal_export.h>
 #include "rte_graph_model_mcore_dispatch.h"
 
 int
@@ -113,6 +114,7 @@ __graph_sched_node_enqueue(struct rte_node *node, struct rte_graph *graph)
 	return false;
 }
 
+RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_node_enqueue)
 bool __rte_noinline
 __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
 					      struct rte_graph_rq_head *rq)
@@ -127,6 +129,7 @@ __rte_graph_mcore_dispatch_sched_node_enqueue(struct rte_node *node,
 	return graph != NULL ? __graph_sched_node_enqueue(node, graph) : false;
 }
 
+RTE_EXPORT_SYMBOL(__rte_graph_mcore_dispatch_sched_wq_process)
 void
 __rte_graph_mcore_dispatch_sched_wq_process(struct rte_graph *graph)
 {
@@ -166,6 +169,7 @@ __rte_graph_mcore_dispatch_sched_wq_process(struct rte_graph *graph)
 	rte_mempool_put_bulk(mp, (void **)wq_nodes, n);
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_model_mcore_dispatch_node_lcore_affinity_set)
 int
 rte_graph_model_mcore_dispatch_node_lcore_affinity_set(const char *name, unsigned int lcore_id)
 {
diff --git a/lib/graph/rte_graph_worker.c b/lib/graph/rte_graph_worker.c
index 7e2a918fae..71f8fb44ca 100644
--- a/lib/graph/rte_graph_worker.c
+++ b/lib/graph/rte_graph_worker.c
@@ -2,9 +2,11 @@
  * Copyright(C) 2023 Intel Corporation
  */
 
+#include <eal_export.h>
 #include "rte_graph_worker_common.h"
 #include "graph_private.h"
 
+RTE_EXPORT_SYMBOL(rte_graph_model_is_valid)
 bool
 rte_graph_model_is_valid(uint8_t model)
 {
@@ -14,6 +16,7 @@ rte_graph_model_is_valid(uint8_t model)
 	return true;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_worker_model_set)
 int
 rte_graph_worker_model_set(uint8_t model)
 {
@@ -29,6 +32,7 @@ rte_graph_worker_model_set(uint8_t model)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_graph_worker_model_get)
 uint8_t
 rte_graph_worker_model_get(struct rte_graph *graph)
 {
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 6d5aadf32a..578cc9b801 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2017 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
@@ -88,6 +89,7 @@ struct gro_ctx {
 	void *tbls[RTE_GRO_TYPE_MAX_NUM];
 };
 
+RTE_EXPORT_SYMBOL(rte_gro_ctx_create)
 void *
 rte_gro_ctx_create(const struct rte_gro_param *param)
 {
@@ -129,6 +131,7 @@ rte_gro_ctx_create(const struct rte_gro_param *param)
 	return gro_ctx;
 }
 
+RTE_EXPORT_SYMBOL(rte_gro_ctx_destroy)
 void
 rte_gro_ctx_destroy(void *ctx)
 {
@@ -148,6 +151,7 @@ rte_gro_ctx_destroy(void *ctx)
 	rte_free(gro_ctx);
 }
 
+RTE_EXPORT_SYMBOL(rte_gro_reassemble_burst)
 uint16_t
 rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 		uint16_t nb_pkts,
@@ -348,6 +352,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 	return nb_after_gro;
 }
 
+RTE_EXPORT_SYMBOL(rte_gro_reassemble)
 uint16_t
 rte_gro_reassemble(struct rte_mbuf **pkts,
 		uint16_t nb_pkts,
@@ -416,6 +421,7 @@ rte_gro_reassemble(struct rte_mbuf **pkts,
 	return unprocess_num;
 }
 
+RTE_EXPORT_SYMBOL(rte_gro_timeout_flush)
 uint16_t
 rte_gro_timeout_flush(void *ctx,
 		uint64_t timeout_cycles,
@@ -474,6 +480,7 @@ rte_gro_timeout_flush(void *ctx,
 	return num;
 }
 
+RTE_EXPORT_SYMBOL(rte_gro_get_pkt_count)
 uint64_t
 rte_gro_get_pkt_count(void *ctx)
 {
diff --git a/lib/gso/rte_gso.c b/lib/gso/rte_gso.c
index e29c7d884a..cbf7365702 100644
--- a/lib/gso/rte_gso.c
+++ b/lib/gso/rte_gso.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_ethdev.h>
 
@@ -24,6 +25,7 @@
 		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO)) == 0) || \
 		(ctx)->gso_size < RTE_GSO_SEG_SIZE_MIN)
 
+RTE_EXPORT_SYMBOL(rte_gso_segment)
 int
 rte_gso_segment(struct rte_mbuf *pkt,
 		const struct rte_gso_ctx *gso_ctx,
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index e55e6e1c81..2c92c51624 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_prefetch.h>
@@ -76,6 +77,7 @@ struct __rte_hash_rcu_dq_entry {
 	uint32_t ext_bkt_idx;
 };
 
+RTE_EXPORT_SYMBOL(rte_hash_find_existing)
 struct rte_hash *
 rte_hash_find_existing(const char *name)
 {
@@ -108,6 +110,7 @@ rte_hash_get_last_bkt(struct rte_hash_bucket *lst_bkt)
 	return lst_bkt;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_set_cmp_func)
 void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
 {
 	h->cmp_jump_table_idx = KEY_CUSTOM;
@@ -153,6 +156,7 @@ get_alt_bucket_index(const struct rte_hash *h,
 	return (cur_bkt_idx ^ sig) & h->bucket_bitmask;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_create)
 struct rte_hash *
 rte_hash_create(const struct rte_hash_parameters *params)
 {
@@ -524,6 +528,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_free)
 void
 rte_hash_free(struct rte_hash *h)
 {
@@ -571,6 +576,7 @@ rte_hash_free(struct rte_hash *h)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_hash)
 hash_sig_t
 rte_hash_hash(const struct rte_hash *h, const void *key)
 {
@@ -578,6 +584,7 @@ rte_hash_hash(const struct rte_hash *h, const void *key)
 	return h->hash_func(key, h->key_len, h->hash_func_init_val);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_max_key_id)
 int32_t
 rte_hash_max_key_id(const struct rte_hash *h)
 {
@@ -593,6 +600,7 @@ rte_hash_max_key_id(const struct rte_hash *h)
 		return h->entries;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_count)
 int32_t
 rte_hash_count(const struct rte_hash *h)
 {
@@ -662,6 +670,7 @@ __hash_rw_reader_unlock(const struct rte_hash *h)
 		rte_rwlock_read_unlock(h->readwrite_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_reset)
 void
 rte_hash_reset(struct rte_hash *h)
 {
@@ -1245,6 +1254,7 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash)
 int32_t
 rte_hash_add_key_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1253,6 +1263,7 @@ rte_hash_add_key_with_hash(const struct rte_hash *h,
 	return __rte_hash_add_key_with_hash(h, key, sig, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_add_key)
 int32_t
 rte_hash_add_key(const struct rte_hash *h, const void *key)
 {
@@ -1260,6 +1271,7 @@ rte_hash_add_key(const struct rte_hash *h, const void *key)
 	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash_data)
 int
 rte_hash_add_key_with_hash_data(const struct rte_hash *h,
 			const void *key, hash_sig_t sig, void *data)
@@ -1274,6 +1286,7 @@ rte_hash_add_key_with_hash_data(const struct rte_hash *h,
 		return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_add_key_data)
 int
 rte_hash_add_key_data(const struct rte_hash *h, const void *key, void *data)
 {
@@ -1467,6 +1480,7 @@ __rte_hash_lookup_with_hash(const struct rte_hash *h, const void *key,
 		return __rte_hash_lookup_with_hash_l(h, key, sig, data);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash)
 int32_t
 rte_hash_lookup_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1475,6 +1489,7 @@ rte_hash_lookup_with_hash(const struct rte_hash *h,
 	return __rte_hash_lookup_with_hash(h, key, sig, NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup)
 int32_t
 rte_hash_lookup(const struct rte_hash *h, const void *key)
 {
@@ -1482,6 +1497,7 @@ rte_hash_lookup(const struct rte_hash *h, const void *key)
 	return __rte_hash_lookup_with_hash(h, key, rte_hash_hash(h, key), NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_data)
 int
 rte_hash_lookup_with_hash_data(const struct rte_hash *h,
 			const void *key, hash_sig_t sig, void **data)
@@ -1490,6 +1506,7 @@ rte_hash_lookup_with_hash_data(const struct rte_hash *h,
 	return __rte_hash_lookup_with_hash(h, key, sig, data);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_data)
 int
 rte_hash_lookup_data(const struct rte_hash *h, const void *key, void **data)
 {
@@ -1557,6 +1574,7 @@ __hash_rcu_qsbr_free_resource(void *p, void *e, unsigned int n)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_rcu_qsbr_add)
 int
 rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 {
@@ -1627,6 +1645,7 @@ rte_hash_rcu_qsbr_add(struct rte_hash *h, struct rte_hash_rcu_config *cfg)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_rcu_qsbr_dq_reclaim, 24.07)
 int rte_hash_rcu_qsbr_dq_reclaim(struct rte_hash *h, unsigned int *freed, unsigned int *pending,
 				 unsigned int *available)
 {
@@ -1851,6 +1870,7 @@ __rte_hash_del_key_with_hash(const struct rte_hash *h, const void *key,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_del_key_with_hash)
 int32_t
 rte_hash_del_key_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
@@ -1859,6 +1879,7 @@ rte_hash_del_key_with_hash(const struct rte_hash *h,
 	return __rte_hash_del_key_with_hash(h, key, sig);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_del_key)
 int32_t
 rte_hash_del_key(const struct rte_hash *h, const void *key)
 {
@@ -1866,6 +1887,7 @@ rte_hash_del_key(const struct rte_hash *h, const void *key)
 	return __rte_hash_del_key_with_hash(h, key, rte_hash_hash(h, key));
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_get_key_with_position)
 int
 rte_hash_get_key_with_position(const struct rte_hash *h, const int32_t position,
 			       void **key)
@@ -1886,6 +1908,7 @@ rte_hash_get_key_with_position(const struct rte_hash *h, const int32_t position,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_free_key_with_position)
 int
 rte_hash_free_key_with_position(const struct rte_hash *h,
 				const int32_t position)
@@ -2398,6 +2421,7 @@ __rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 					 hit_mask, data);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk)
 int
 rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 		      uint32_t num_keys, int32_t *positions)
@@ -2410,6 +2434,7 @@ rte_hash_lookup_bulk(const struct rte_hash *h, const void **keys,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_bulk_data)
 int
 rte_hash_lookup_bulk_data(const struct rte_hash *h, const void **keys,
 		      uint32_t num_keys, uint64_t *hit_mask, void *data[])
@@ -2510,6 +2535,7 @@ __rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 				num_keys, positions, hit_mask, data);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk)
 int
 rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 		hash_sig_t *sig, uint32_t num_keys, int32_t *positions)
@@ -2524,6 +2550,7 @@ rte_hash_lookup_with_hash_bulk(const struct rte_hash *h, const void **keys,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_lookup_with_hash_bulk_data)
 int
 rte_hash_lookup_with_hash_bulk_data(const struct rte_hash *h,
 		const void **keys, hash_sig_t *sig,
@@ -2543,6 +2570,7 @@ rte_hash_lookup_with_hash_bulk_data(const struct rte_hash *h,
 	return rte_popcount64(*hit_mask);
 }
 
+RTE_EXPORT_SYMBOL(rte_hash_iterate)
 int32_t
 rte_hash_iterate(const struct rte_hash *h, const void **key, void **data, uint32_t *next)
 {
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index dacb7e8b09..38b15a14d1 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_cpuflags.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
@@ -41,6 +42,7 @@ EAL_REGISTER_TAILQ(rte_fbk_hash_tailq)
  * @return
  *   pointer to hash table structure or NULL on error.
  */
+RTE_EXPORT_SYMBOL(rte_fbk_hash_find_existing)
 struct rte_fbk_hash_table *
 rte_fbk_hash_find_existing(const char *name)
 {
@@ -75,6 +77,7 @@ rte_fbk_hash_find_existing(const char *name)
  *   Pointer to hash table structure that is used in future hash table
  *   operations, or NULL on error.
  */
+RTE_EXPORT_SYMBOL(rte_fbk_hash_create)
 struct rte_fbk_hash_table *
 rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
 {
@@ -177,6 +180,7 @@ rte_fbk_hash_create(const struct rte_fbk_hash_params *params)
  * @param ht
  *   Hash table to deallocate.
  */
+RTE_EXPORT_SYMBOL(rte_fbk_hash_free)
 void
 rte_fbk_hash_free(struct rte_fbk_hash_table *ht)
 {
diff --git a/lib/hash/rte_hash_crc.c b/lib/hash/rte_hash_crc.c
index c037cdb0f0..9fe90d6425 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_cpuflags.h>
 #include <rte_log.h>
 
@@ -12,6 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_crc_logtype, crc, INFO);
 #define HASH_CRC_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH_CRC, "" __VA_ARGS__)
 
+RTE_EXPORT_SYMBOL(rte_hash_crc32_alg)
 uint8_t rte_hash_crc32_alg = CRC32_SW;
 
 /**
@@ -26,6 +28,7 @@ uint8_t rte_hash_crc32_alg = CRC32_SW;
  *   - (CRC32_ARM64) Use ARMv8 CRC intrinsic if available (default ARMv8)
  *
  */
+RTE_EXPORT_SYMBOL(rte_hash_crc_set_alg)
 void
 rte_hash_crc_set_alg(uint8_t alg)
 {
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 1f9700258d..6c662bf14f 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -5,6 +5,7 @@
 #include <stdalign.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_thash.h>
 #include <rte_tailq.h>
 #include <rte_random.h>
@@ -70,6 +71,7 @@ struct rte_thash_ctx {
 	uint8_t		hash_key[];
 };
 
+RTE_EXPORT_SYMBOL(rte_thash_gfni_supported)
 int
 rte_thash_gfni_supported(void)
 {
@@ -83,6 +85,7 @@ rte_thash_gfni_supported(void)
 	return 0;
 };
 
+RTE_EXPORT_SYMBOL(rte_thash_complete_matrix)
 void
 rte_thash_complete_matrix(uint64_t *matrixes, const uint8_t *rss_key, int size)
 {
@@ -203,6 +206,7 @@ free_lfsr(struct thash_lfsr *lfsr)
 		rte_free(lfsr);
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_init_ctx)
 struct rte_thash_ctx *
 rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	uint8_t *key, uint32_t flags)
@@ -293,6 +297,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_find_existing)
 struct rte_thash_ctx *
 rte_thash_find_existing(const char *name)
 {
@@ -319,6 +324,7 @@ rte_thash_find_existing(const char *name)
 	return ctx;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_free_ctx)
 void
 rte_thash_free_ctx(struct rte_thash_ctx *ctx)
 {
@@ -540,6 +546,7 @@ insert_after(struct rte_thash_ctx *ctx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_add_helper)
 int
 rte_thash_add_helper(struct rte_thash_ctx *ctx, const char *name, uint32_t len,
 	uint32_t offset)
@@ -630,6 +637,7 @@ rte_thash_add_helper(struct rte_thash_ctx *ctx, const char *name, uint32_t len,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_get_helper)
 struct rte_thash_subtuple_helper *
 rte_thash_get_helper(struct rte_thash_ctx *ctx, const char *name)
 {
@@ -646,6 +654,7 @@ rte_thash_get_helper(struct rte_thash_ctx *ctx, const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_get_complement)
 uint32_t
 rte_thash_get_complement(struct rte_thash_subtuple_helper *h,
 	uint32_t hash, uint32_t desired_hash)
@@ -653,12 +662,14 @@ rte_thash_get_complement(struct rte_thash_subtuple_helper *h,
 	return h->compl_table[(hash ^ desired_hash) & h->lsb_msk];
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_get_key)
 const uint8_t *
 rte_thash_get_key(struct rte_thash_ctx *ctx)
 {
 	return ctx->hash_key;
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_get_gfni_matrices)
 const uint64_t *
 rte_thash_get_gfni_matrices(struct rte_thash_ctx *ctx)
 {
@@ -754,6 +765,7 @@ write_unaligned_bits(uint8_t *ptr, int len, int offset, uint32_t val)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_thash_adjust_tuple)
 int
 rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	struct rte_thash_subtuple_helper *h,
@@ -823,6 +835,7 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_thash_gen_key, 24.11)
 int
 rte_thash_gen_key(uint8_t *key, size_t key_len, size_t reta_sz_log,
 	uint32_t entropy_start, size_t entropy_sz)
diff --git a/lib/hash/rte_thash_gf2_poly_math.c b/lib/hash/rte_thash_gf2_poly_math.c
index 858884b4d4..ddf4dd863b 100644
--- a/lib/hash/rte_thash_gf2_poly_math.c
+++ b/lib/hash/rte_thash_gf2_poly_math.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Intel Corporation
  */
+#include <eal_export.h>
 #include <rte_random.h>
 #include <rte_common.h>
 #include <rte_bitops.h>
@@ -241,6 +242,7 @@ thash_test_poly_order(uint32_t poly, int degree)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(thash_get_rand_poly)
 uint32_t
 thash_get_rand_poly(uint32_t poly_degree)
 {
diff --git a/lib/hash/rte_thash_gfni.c b/lib/hash/rte_thash_gfni.c
index c94640d30d..2003c7b3db 100644
--- a/lib/hash/rte_thash_gfni.c
+++ b/lib/hash/rte_thash_gfni.c
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_thash_gfni.h>
 
@@ -12,6 +13,7 @@ RTE_LOG_REGISTER_SUFFIX(hash_gfni_logtype, gfni, INFO);
 #define HASH_LOG(level, ...) \
 	RTE_LOG_LINE(level, HASH, "" __VA_ARGS__)
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_stub)
 uint32_t
 rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	const uint8_t *key __rte_unused, int len __rte_unused)
@@ -27,6 +29,7 @@ rte_thash_gfni_stub(const uint64_t *mtrx __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thash_gfni_bulk_stub)
 void
 rte_thash_gfni_bulk_stub(const uint64_t *mtrx __rte_unused,
 	int len __rte_unused, uint8_t *tuple[] __rte_unused,
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index 05f9e479c2..ee9aa93027 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -5,6 +5,7 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 
 RTE_LOG_REGISTER_DEFAULT(ipfrag_logtype, INFO);
@@ -14,6 +15,7 @@ RTE_LOG_REGISTER_DEFAULT(ipfrag_logtype, INFO);
 #define	IP_FRAG_HASH_FNUM	2
 
 /* free mbufs from death row */
+RTE_EXPORT_SYMBOL(rte_ip_frag_free_death_row)
 void
 rte_ip_frag_free_death_row(struct rte_ip_frag_death_row *dr,
 		uint32_t prefetch)
@@ -38,6 +40,7 @@ rte_ip_frag_free_death_row(struct rte_ip_frag_death_row *dr,
 }
 
 /* create fragmentation table */
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_create)
 struct rte_ip_frag_tbl *
 rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 	uint32_t max_entries, uint64_t max_cycles, int socket_id)
@@ -82,6 +85,7 @@ rte_ip_frag_table_create(uint32_t bucket_num, uint32_t bucket_entries,
 }
 
 /* delete fragmentation table */
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_destroy)
 void
 rte_ip_frag_table_destroy(struct rte_ip_frag_tbl *tbl)
 {
@@ -95,6 +99,7 @@ rte_ip_frag_table_destroy(struct rte_ip_frag_tbl *tbl)
 }
 
 /* dump frag table statistics to file */
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_statistics_dump)
 void
 rte_ip_frag_table_statistics_dump(FILE *f, const struct rte_ip_frag_tbl *tbl)
 {
@@ -124,6 +129,7 @@ rte_ip_frag_table_statistics_dump(FILE *f, const struct rte_ip_frag_tbl *tbl)
 }
 
 /* Delete expired fragments */
+RTE_EXPORT_SYMBOL(rte_ip_frag_table_del_expired_entries)
 void
 rte_ip_frag_table_del_expired_entries(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, uint64_t tms)
diff --git a/lib/ip_frag/rte_ipv4_fragmentation.c b/lib/ip_frag/rte_ipv4_fragmentation.c
index e04cf5738e..435a6e13bb 100644
--- a/lib/ip_frag/rte_ipv4_fragmentation.c
+++ b/lib/ip_frag/rte_ipv4_fragmentation.c
@@ -5,6 +5,7 @@
 #include <stddef.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_ether.h>
 
 #include "ip_frag_common.h"
@@ -104,6 +105,7 @@ static inline uint16_t __create_ipopt_frag_hdr(uint8_t *iph,
  *   in the pkts_out array.
  *   Otherwise - (-1) * <errno>.
  */
+RTE_EXPORT_SYMBOL(rte_ipv4_fragment_packet)
 int32_t
 rte_ipv4_fragment_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
@@ -286,6 +288,7 @@ rte_ipv4_fragment_packet(struct rte_mbuf *pkt_in,
  *   in the pkts_out array.
  *   Otherwise - (-1) * errno.
  */
+RTE_EXPORT_SYMBOL(rte_ipv4_fragment_copy_nonseg_packet)
 int32_t
 rte_ipv4_fragment_copy_nonseg_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_reassembly.c
index 5818f50f40..3c8ae113ba 100644
--- a/lib/ip_frag/rte_ipv4_reassembly.c
+++ b/lib/ip_frag/rte_ipv4_reassembly.c
@@ -4,6 +4,7 @@
 
 #include <stddef.h>
 
+#include <eal_export.h>
 #include <rte_debug.h>
 
 #include "ip_frag_common.h"
@@ -94,6 +95,7 @@ ipv4_frag_reassemble(struct ip_frag_pkt *fp)
  *   - an error occurred.
  *   - not all fragments of the packet are collected yet.
  */
+RTE_EXPORT_SYMBOL(rte_ipv4_frag_reassemble_packet)
 struct rte_mbuf *
 rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, struct rte_mbuf *mb, uint64_t tms,
diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index 56696f32f8..c81f2402e3 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -5,6 +5,7 @@
 #include <stddef.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
@@ -63,6 +64,7 @@ __free_fragments(struct rte_mbuf *mb[], uint32_t num)
  *   in the pkts_out array.
  *   Otherwise - (-1) * <errno>.
  */
+RTE_EXPORT_SYMBOL(rte_ipv6_fragment_packet)
 int32_t
 rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 	struct rte_mbuf **pkts_out,
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 9471ce5333..0e809a01e5 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -4,6 +4,7 @@
 
 #include <stddef.h>
 
+#include <eal_export.h>
 #include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
@@ -132,6 +133,7 @@ ipv6_frag_reassemble(struct ip_frag_pkt *fp)
  */
 #define MORE_FRAGS(x) (((x) & 0x100) >> 8)
 #define FRAG_OFFSET(x) (rte_cpu_to_be_16(x) >> 3)
+RTE_EXPORT_SYMBOL(rte_ipv6_frag_reassemble_packet)
 struct rte_mbuf *
 rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, struct rte_mbuf *mb, uint64_t tms,
diff --git a/lib/ipsec/ipsec_sad.c b/lib/ipsec/ipsec_sad.c
index 7e147e729c..15ea868f77 100644
--- a/lib/ipsec/ipsec_sad.c
+++ b/lib/ipsec/ipsec_sad.c
@@ -4,6 +4,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
 #include <rte_hash.h>
@@ -113,6 +114,7 @@ add_specific(struct rte_ipsec_sad *sad, const void *key,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_add)
 int
 rte_ipsec_sad_add(struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *key,
@@ -212,6 +214,7 @@ del_specific(struct rte_ipsec_sad *sad, const void *key, int key_type)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_del)
 int
 rte_ipsec_sad_del(struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *key,
@@ -251,6 +254,7 @@ rte_ipsec_sad_del(struct rte_ipsec_sad *sad,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_create)
 struct rte_ipsec_sad *
 rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 {
@@ -380,6 +384,7 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 	return sad;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_find_existing)
 struct rte_ipsec_sad *
 rte_ipsec_sad_find_existing(const char *name)
 {
@@ -414,6 +419,7 @@ rte_ipsec_sad_find_existing(const char *name)
 	return sad;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_destroy)
 void
 rte_ipsec_sad_destroy(struct rte_ipsec_sad *sad)
 {
@@ -536,6 +542,7 @@ __ipsec_sad_lookup(const struct rte_ipsec_sad *sad,
 	return found;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sad_lookup)
 int
 rte_ipsec_sad_lookup(const struct rte_ipsec_sad *sad,
 		const union rte_ipsec_sad_key *keys[], void *sa[], uint32_t n)
diff --git a/lib/ipsec/ipsec_telemetry.c b/lib/ipsec/ipsec_telemetry.c
index 68a91108dd..a9b6f05270 100644
--- a/lib/ipsec/ipsec_telemetry.c
+++ b/lib/ipsec/ipsec_telemetry.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdlib.h>
+#include <eal_export.h>
 #include <rte_ipsec.h>
 #include <rte_telemetry.h>
 #include <rte_malloc.h>
@@ -204,6 +205,7 @@ handle_telemetry_cmd_ipsec_sa_details(const char *cmd __rte_unused,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_add)
 int
 rte_ipsec_telemetry_sa_add(const struct rte_ipsec_sa *sa)
 {
@@ -216,6 +218,7 @@ rte_ipsec_telemetry_sa_add(const struct rte_ipsec_sa *sa)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_telemetry_sa_del)
 void
 rte_ipsec_telemetry_sa_del(const struct rte_ipsec_sa *sa)
 {
diff --git a/lib/ipsec/sa.c b/lib/ipsec/sa.c
index 741e079831..4f589f3f3f 100644
--- a/lib/ipsec/sa.c
+++ b/lib/ipsec/sa.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018-2020 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_ipsec.h>
 #include <rte_esp.h>
 #include <rte_ip.h>
@@ -84,6 +85,7 @@ fill_crypto_xform(struct crypto_xform *xform, uint64_t type,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_type)
 uint64_t
 rte_ipsec_sa_type(const struct rte_ipsec_sa *sa)
 {
@@ -156,6 +158,7 @@ ipsec_sa_size(uint64_t type, uint32_t *wnd_sz, uint32_t *nb_bucket)
 	return sz;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_fini)
 void
 rte_ipsec_sa_fini(struct rte_ipsec_sa *sa)
 {
@@ -525,6 +528,7 @@ fill_sa_replay(struct rte_ipsec_sa *sa, uint32_t wnd_sz, uint32_t nb_bucket,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_size)
 int
 rte_ipsec_sa_size(const struct rte_ipsec_sa_prm *prm)
 {
@@ -545,6 +549,7 @@ rte_ipsec_sa_size(const struct rte_ipsec_sa_prm *prm)
 	return ipsec_sa_size(type, &wsz, &nb);
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_sa_init)
 int
 rte_ipsec_sa_init(struct rte_ipsec_sa *sa, const struct rte_ipsec_sa_prm *prm,
 	uint32_t size)
diff --git a/lib/ipsec/ses.c b/lib/ipsec/ses.c
index d9ab1e6d2b..224e752d05 100644
--- a/lib/ipsec/ses.c
+++ b/lib/ipsec/ses.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2018-2020 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_ipsec.h>
 #include "sa.h"
 
@@ -28,6 +29,7 @@ session_check(struct rte_ipsec_session *ss)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ipsec_session_prepare)
 int
 rte_ipsec_session_prepare(struct rte_ipsec_session *ss)
 {
diff --git a/lib/jobstats/rte_jobstats.c b/lib/jobstats/rte_jobstats.c
index af565a14ea..20a4f1391a 100644
--- a/lib/jobstats/rte_jobstats.c
+++ b/lib/jobstats/rte_jobstats.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
@@ -63,6 +64,7 @@ default_update_function(struct rte_jobstats *job, int64_t result)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_context_init)
 int
 rte_jobstats_context_init(struct rte_jobstats_context *ctx)
 {
@@ -77,6 +79,7 @@ rte_jobstats_context_init(struct rte_jobstats_context *ctx)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_context_start)
 void
 rte_jobstats_context_start(struct rte_jobstats_context *ctx)
 {
@@ -89,6 +92,7 @@ rte_jobstats_context_start(struct rte_jobstats_context *ctx)
 	ctx->state_time = now;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_context_finish)
 void
 rte_jobstats_context_finish(struct rte_jobstats_context *ctx)
 {
@@ -102,6 +106,7 @@ rte_jobstats_context_finish(struct rte_jobstats_context *ctx)
 	ctx->state_time = now;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_context_reset)
 void
 rte_jobstats_context_reset(struct rte_jobstats_context *ctx)
 {
@@ -113,12 +118,14 @@ rte_jobstats_context_reset(struct rte_jobstats_context *ctx)
 	ctx->loop_cnt = 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_set_target)
 void
 rte_jobstats_set_target(struct rte_jobstats *job, int64_t target)
 {
 	job->target = target;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_start)
 int
 rte_jobstats_start(struct rte_jobstats_context *ctx, struct rte_jobstats *job)
 {
@@ -138,6 +145,7 @@ rte_jobstats_start(struct rte_jobstats_context *ctx, struct rte_jobstats *job)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_abort)
 int
 rte_jobstats_abort(struct rte_jobstats *job)
 {
@@ -158,6 +166,7 @@ rte_jobstats_abort(struct rte_jobstats *job)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_finish)
 int
 rte_jobstats_finish(struct rte_jobstats *job, int64_t job_value)
 {
@@ -194,6 +203,7 @@ rte_jobstats_finish(struct rte_jobstats *job, int64_t job_value)
 	return need_update;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_set_period)
 void
 rte_jobstats_set_period(struct rte_jobstats *job, uint64_t period,
 		uint8_t saturate)
@@ -208,6 +218,7 @@ rte_jobstats_set_period(struct rte_jobstats *job, uint64_t period,
 	job->period = period;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_set_min)
 void
 rte_jobstats_set_min(struct rte_jobstats *job, uint64_t period)
 {
@@ -216,6 +227,7 @@ rte_jobstats_set_min(struct rte_jobstats *job, uint64_t period)
 		job->period = period;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_set_max)
 void
 rte_jobstats_set_max(struct rte_jobstats *job, uint64_t period)
 {
@@ -224,6 +236,7 @@ rte_jobstats_set_max(struct rte_jobstats *job, uint64_t period)
 		job->period = period;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_init)
 int
 rte_jobstats_init(struct rte_jobstats *job, const char *name,
 		uint64_t min_period, uint64_t max_period, uint64_t initial_period,
@@ -244,6 +257,7 @@ rte_jobstats_init(struct rte_jobstats *job, const char *name,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_set_update_period_function)
 void
 rte_jobstats_set_update_period_function(struct rte_jobstats *job,
 		rte_job_update_period_cb_t update_period_cb)
@@ -254,6 +268,7 @@ rte_jobstats_set_update_period_function(struct rte_jobstats *job,
 	job->update_period_cb = update_period_cb;
 }
 
+RTE_EXPORT_SYMBOL(rte_jobstats_reset)
 void
 rte_jobstats_reset(struct rte_jobstats *job)
 {
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 1d355516bc..4e3198b33f 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_os_shim.h>
 
 #include "rte_kvargs.h"
@@ -151,6 +152,7 @@ check_for_valid_keys(struct rte_kvargs *kvlist,
  * E.g. given a list = { rx = 0, rx = 1, tx = 2 } the number of args for
  * arg "rx" will be 2.
  */
+RTE_EXPORT_SYMBOL(rte_kvargs_count)
 unsigned
 rte_kvargs_count(const struct rte_kvargs *kvlist, const char *key_match)
 {
@@ -193,6 +195,7 @@ kvargs_process_common(const struct rte_kvargs *kvlist, const char *key_match,
 /*
  * For each matching key in key=value, call the given handler function.
  */
+RTE_EXPORT_SYMBOL(rte_kvargs_process)
 int
 rte_kvargs_process(const struct rte_kvargs *kvlist, const char *key_match, arg_handler_t handler,
 		   void *opaque_arg)
@@ -203,6 +206,7 @@ rte_kvargs_process(const struct rte_kvargs *kvlist, const char *key_match, arg_h
 /*
  * For each matching key in key=value or only-key, call the given handler function.
  */
+RTE_EXPORT_SYMBOL(rte_kvargs_process_opt)
 int
 rte_kvargs_process_opt(const struct rte_kvargs *kvlist, const char *key_match,
 		       arg_handler_t handler, void *opaque_arg)
@@ -211,6 +215,7 @@ rte_kvargs_process_opt(const struct rte_kvargs *kvlist, const char *key_match,
 }
 
 /* free the rte_kvargs structure */
+RTE_EXPORT_SYMBOL(rte_kvargs_free)
 void
 rte_kvargs_free(struct rte_kvargs *kvlist)
 {
@@ -222,6 +227,7 @@ rte_kvargs_free(struct rte_kvargs *kvlist)
 }
 
 /* Lookup a value in an rte_kvargs list by its key and value. */
+RTE_EXPORT_SYMBOL(rte_kvargs_get_with_value)
 const char *
 rte_kvargs_get_with_value(const struct rte_kvargs *kvlist, const char *key,
 			  const char *value)
@@ -241,6 +247,7 @@ rte_kvargs_get_with_value(const struct rte_kvargs *kvlist, const char *key,
 }
 
 /* Lookup a value in an rte_kvargs list by its key. */
+RTE_EXPORT_SYMBOL(rte_kvargs_get)
 const char *
 rte_kvargs_get(const struct rte_kvargs *kvlist, const char *key)
 {
@@ -254,6 +261,7 @@ rte_kvargs_get(const struct rte_kvargs *kvlist, const char *key)
  * an allocated structure that contains a key/value list. Also
  * check if only valid keys were used.
  */
+RTE_EXPORT_SYMBOL(rte_kvargs_parse)
 struct rte_kvargs *
 rte_kvargs_parse(const char *args, const char * const valid_keys[])
 {
@@ -277,6 +285,7 @@ rte_kvargs_parse(const char *args, const char * const valid_keys[])
 	return kvlist;
 }
 
+RTE_EXPORT_SYMBOL(rte_kvargs_parse_delim)
 struct rte_kvargs *
 rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
 		       const char *valid_ends)
diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 6a261309f9..19a6f580cd 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -4,6 +4,7 @@
 
 #include <math.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_log.h>
@@ -78,6 +79,7 @@ static const struct latency_stats_nameoff lat_stats_strings[] = {
 #define NUM_LATENCY_STATS (sizeof(lat_stats_strings) / \
 				sizeof(lat_stats_strings[0]))
 
+RTE_EXPORT_SYMBOL(rte_latencystats_update)
 int32_t
 rte_latencystats_update(void)
 {
@@ -210,6 +212,7 @@ calc_latency(uint16_t pid __rte_unused,
 	return nb_pkts;
 }
 
+RTE_EXPORT_SYMBOL(rte_latencystats_init)
 int
 rte_latencystats_init(uint64_t app_samp_intvl,
 		rte_latency_stats_flow_type_fn user_cb)
@@ -295,6 +298,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_latencystats_uninit)
 int
 rte_latencystats_uninit(void)
 {
@@ -342,6 +346,7 @@ rte_latencystats_uninit(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_latencystats_get_names)
 int
 rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 {
@@ -357,6 +362,7 @@ rte_latencystats_get_names(struct rte_metric_name *names, uint16_t size)
 	return NUM_LATENCY_STATS;
 }
 
+RTE_EXPORT_SYMBOL(rte_latencystats_get)
 int
 rte_latencystats_get(struct rte_metric_value *values, uint16_t size)
 {
diff --git a/lib/log/log.c b/lib/log/log.c
index e1c18a8e53..8ad5250a13 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -14,6 +14,7 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_per_lcore.h>
@@ -78,6 +79,7 @@ struct log_cur_msg {
 static RTE_DEFINE_PER_LCORE(struct log_cur_msg, log_cur_msg);
 
 /* Change the stream that will be used by logging system */
+RTE_EXPORT_SYMBOL(rte_openlog_stream)
 int
 rte_openlog_stream(FILE *f)
 {
@@ -89,6 +91,7 @@ rte_openlog_stream(FILE *f)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_log_get_stream)
 FILE *
 rte_log_get_stream(void)
 {
@@ -98,6 +101,7 @@ rte_log_get_stream(void)
 }
 
 /* Set global log level */
+RTE_EXPORT_SYMBOL(rte_log_set_global_level)
 void
 rte_log_set_global_level(uint32_t level)
 {
@@ -105,12 +109,14 @@ rte_log_set_global_level(uint32_t level)
 }
 
 /* Get global log level */
+RTE_EXPORT_SYMBOL(rte_log_get_global_level)
 uint32_t
 rte_log_get_global_level(void)
 {
 	return rte_logs.level;
 }
 
+RTE_EXPORT_SYMBOL(rte_log_get_level)
 int
 rte_log_get_level(uint32_t type)
 {
@@ -120,6 +126,7 @@ rte_log_get_level(uint32_t type)
 	return rte_logs.dynamic_types[type].loglevel;
 }
 
+RTE_EXPORT_SYMBOL(rte_log_can_log)
 bool
 rte_log_can_log(uint32_t logtype, uint32_t level)
 {
@@ -153,6 +160,7 @@ logtype_set_level(uint32_t type, uint32_t level)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_log_set_level)
 int
 rte_log_set_level(uint32_t type, uint32_t level)
 {
@@ -167,6 +175,7 @@ rte_log_set_level(uint32_t type, uint32_t level)
 }
 
 /* set log level by regular expression */
+RTE_EXPORT_SYMBOL(rte_log_set_level_regexp)
 int
 rte_log_set_level_regexp(const char *regex, uint32_t level)
 {
@@ -225,6 +234,7 @@ log_save_level(uint32_t priority, const char *regex, const char *pattern)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_regexp)
 int
 eal_log_save_regexp(const char *regex, uint32_t level)
 {
@@ -232,6 +242,7 @@ eal_log_save_regexp(const char *regex, uint32_t level)
 }
 
 /* set log level based on globbing pattern */
+RTE_EXPORT_SYMBOL(rte_log_set_level_pattern)
 int
 rte_log_set_level_pattern(const char *pattern, uint32_t level)
 {
@@ -251,6 +262,7 @@ rte_log_set_level_pattern(const char *pattern, uint32_t level)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_save_pattern)
 int
 eal_log_save_pattern(const char *pattern, uint32_t level)
 {
@@ -258,12 +270,14 @@ eal_log_save_pattern(const char *pattern, uint32_t level)
 }
 
 /* get the current loglevel for the message being processed */
+RTE_EXPORT_SYMBOL(rte_log_cur_msg_loglevel)
 int rte_log_cur_msg_loglevel(void)
 {
 	return RTE_PER_LCORE(log_cur_msg).loglevel;
 }
 
 /* get the current logtype for the message being processed */
+RTE_EXPORT_SYMBOL(rte_log_cur_msg_logtype)
 int rte_log_cur_msg_logtype(void)
 {
 	return RTE_PER_LCORE(log_cur_msg).logtype;
@@ -315,6 +329,7 @@ log_register(const char *name, uint32_t level)
 }
 
 /* register an extended log type */
+RTE_EXPORT_SYMBOL(rte_log_register)
 int
 rte_log_register(const char *name)
 {
@@ -322,6 +337,7 @@ rte_log_register(const char *name)
 }
 
 /* Register an extended log type and try to pick its level from EAL options */
+RTE_EXPORT_SYMBOL(rte_log_register_type_and_pick_level)
 int
 rte_log_register_type_and_pick_level(const char *name, uint32_t level_def)
 {
@@ -384,6 +400,7 @@ RTE_INIT_PRIO(log_init, LOG)
 	rte_logs.dynamic_types_len = RTE_LOGTYPE_FIRST_EXT_ID;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_level2str)
 const char *
 eal_log_level2str(uint32_t level)
 {
@@ -417,6 +434,7 @@ log_type_compare(const void *a, const void *b)
 }
 
 /* Dump name of each logtype, one per line. */
+RTE_EXPORT_SYMBOL(rte_log_list_types)
 void
 rte_log_list_types(FILE *out, const char *prefix)
 {
@@ -446,6 +464,7 @@ rte_log_list_types(FILE *out, const char *prefix)
 }
 
 /* dump global level and registered log types */
+RTE_EXPORT_SYMBOL(rte_log_dump)
 void
 rte_log_dump(FILE *f)
 {
@@ -467,6 +486,7 @@ rte_log_dump(FILE *f)
  * Generates a log message The message will be sent in the stream
  * defined by the previous call to rte_openlog_stream().
  */
+RTE_EXPORT_SYMBOL(rte_vlog)
 int
 rte_vlog(uint32_t level, uint32_t logtype, const char *format, va_list ap)
 {
@@ -492,6 +512,7 @@ rte_vlog(uint32_t level, uint32_t logtype, const char *format, va_list ap)
  * defined by the previous call to rte_openlog_stream().
  * No need to check level here, done by rte_vlog().
  */
+RTE_EXPORT_SYMBOL(rte_log)
 int
 rte_log(uint32_t level, uint32_t logtype, const char *format, ...)
 {
@@ -507,6 +528,7 @@ rte_log(uint32_t level, uint32_t logtype, const char *format, ...)
 /*
  * Called by rte_eal_init
  */
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_init)
 void
 eal_log_init(const char *id)
 {
@@ -552,6 +574,7 @@ eal_log_init(const char *id)
 /*
  * Called by eal_cleanup
  */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_log_cleanup)
 void
 rte_eal_log_cleanup(void)
 {
diff --git a/lib/log/log_color.c b/lib/log/log_color.c
index 04eb5aa485..690a27f96e 100644
--- a/lib/log/log_color.c
+++ b/lib/log/log_color.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 
@@ -99,6 +100,7 @@ color_snprintf(char *buf, size_t len, enum log_field field,
  *   auto - enable if stderr is a terminal
  *   never - color output is disabled.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_color)
 int
 eal_log_color(const char *mode)
 {
diff --git a/lib/log/log_syslog.c b/lib/log/log_syslog.c
index 6b34831bf3..99d4132a55 100644
--- a/lib/log/log_syslog.c
+++ b/lib/log/log_syslog.c
@@ -8,6 +8,7 @@
 #include <sys/types.h>
 #include <syslog.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 
@@ -45,6 +46,7 @@ static const struct {
 	{ "local7", LOG_LOCAL7 },
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_syslog)
 int
 eal_log_syslog(const char *name)
 {
diff --git a/lib/log/log_timestamp.c b/lib/log/log_timestamp.c
index b4b0bca6a8..47b6f7cfc4 100644
--- a/lib/log/log_timestamp.c
+++ b/lib/log/log_timestamp.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <time.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_stdatomic.h>
 #include <rte_time.h>
@@ -40,6 +41,7 @@ static struct {
 } log_time;
 
 /* Set the log timestamp format */
+RTE_EXPORT_INTERNAL_SYMBOL(eal_log_timestamp)
 int
 eal_log_timestamp(const char *str)
 {
diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index a5c9e7c9fc..7058be6918 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
@@ -117,6 +118,7 @@ depth_to_range(uint8_t depth)
 /*
  * Find an existing lpm table and return a pointer to it.
  */
+RTE_EXPORT_SYMBOL(rte_lpm_find_existing)
 struct rte_lpm *
 rte_lpm_find_existing(const char *name)
 {
@@ -145,6 +147,7 @@ rte_lpm_find_existing(const char *name)
 /*
  * Allocates memory for LPM object
  */
+RTE_EXPORT_SYMBOL(rte_lpm_create)
 struct rte_lpm *
 rte_lpm_create(const char *name, int socket_id,
 		const struct rte_lpm_config *config)
@@ -251,6 +254,7 @@ rte_lpm_create(const char *name, int socket_id,
 /*
  * Deallocates memory for given LPM table.
  */
+RTE_EXPORT_SYMBOL(rte_lpm_free)
 void
 rte_lpm_free(struct rte_lpm *lpm)
 {
@@ -300,6 +304,7 @@ __lpm_rcu_qsbr_free_resource(void *p, void *data, unsigned int n)
 
 /* Associate QSBR variable with an LPM object.
  */
+RTE_EXPORT_SYMBOL(rte_lpm_rcu_qsbr_add)
 int
 rte_lpm_rcu_qsbr_add(struct rte_lpm *lpm, struct rte_lpm_rcu_config *cfg)
 {
@@ -798,6 +803,7 @@ add_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked, uint8_t depth,
 /*
  * Add a route
  */
+RTE_EXPORT_SYMBOL(rte_lpm_add)
 int
 rte_lpm_add(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 		uint32_t next_hop)
@@ -849,6 +855,7 @@ rte_lpm_add(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 /*
  * Look for a rule in the high-level rules table
  */
+RTE_EXPORT_SYMBOL(rte_lpm_is_rule_present)
 int
 rte_lpm_is_rule_present(struct rte_lpm *lpm, uint32_t ip, uint8_t depth,
 uint32_t *next_hop)
@@ -1142,6 +1149,7 @@ delete_depth_big(struct __rte_lpm *i_lpm, uint32_t ip_masked,
 /*
  * Deletes a rule
  */
+RTE_EXPORT_SYMBOL(rte_lpm_delete)
 int
 rte_lpm_delete(struct rte_lpm *lpm, uint32_t ip, uint8_t depth)
 {
@@ -1200,6 +1208,7 @@ rte_lpm_delete(struct rte_lpm *lpm, uint32_t ip, uint8_t depth)
 /*
  * Delete all rules from the LPM table.
  */
+RTE_EXPORT_SYMBOL(rte_lpm_delete_all)
 void
 rte_lpm_delete_all(struct rte_lpm *lpm)
 {
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index 8beb394c47..e23c886766 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
@@ -207,6 +208,7 @@ rebuild_lpm(struct rte_lpm6 *lpm)
 /*
  * Allocates memory for LPM object
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_create)
 struct rte_lpm6 *
 rte_lpm6_create(const char *name, int socket_id,
 		const struct rte_lpm6_config *config)
@@ -347,6 +349,7 @@ rte_lpm6_create(const char *name, int socket_id,
 /*
  * Find an existing lpm table and return a pointer to it.
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_find_existing)
 struct rte_lpm6 *
 rte_lpm6_find_existing(const char *name)
 {
@@ -375,6 +378,7 @@ rte_lpm6_find_existing(const char *name)
 /*
  * Deallocates memory for given LPM table.
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_free)
 void
 rte_lpm6_free(struct rte_lpm6 *lpm)
 {
@@ -819,6 +823,7 @@ simulate_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *masked_ip, uint8_
 /*
  * Add a route
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_add)
 int
 rte_lpm6_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
 	     uint32_t next_hop)
@@ -908,6 +913,7 @@ lookup_step(const struct rte_lpm6 *lpm, const struct rte_lpm6_tbl_entry *tbl,
 /*
  * Looks up an IP
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_lookup)
 int
 rte_lpm6_lookup(const struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip,
 		uint32_t *next_hop)
@@ -940,6 +946,7 @@ rte_lpm6_lookup(const struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip,
 /*
  * Looks up a group of IP addresses
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_lookup_bulk_func)
 int
 rte_lpm6_lookup_bulk_func(const struct rte_lpm6 *lpm,
 		struct rte_ipv6_addr *ips,
@@ -985,6 +992,7 @@ rte_lpm6_lookup_bulk_func(const struct rte_lpm6 *lpm,
 /*
  * Look for a rule in the high-level rules table
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_is_rule_present)
 int
 rte_lpm6_is_rule_present(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
 			 uint32_t *next_hop)
@@ -1034,6 +1042,7 @@ rule_delete(struct rte_lpm6 *lpm, struct rte_ipv6_addr *ip, uint8_t depth)
  * rather than doing incremental updates like
  * the regular delete function
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_delete_bulk_func)
 int
 rte_lpm6_delete_bulk_func(struct rte_lpm6 *lpm,
 		struct rte_ipv6_addr *ips, uint8_t *depths,
@@ -1073,6 +1082,7 @@ rte_lpm6_delete_bulk_func(struct rte_lpm6 *lpm,
 /*
  * Delete all rules from the LPM table.
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_delete_all)
 void
 rte_lpm6_delete_all(struct rte_lpm6 *lpm)
 {
@@ -1257,6 +1267,7 @@ remove_tbl(struct rte_lpm6 *lpm, struct rte_lpm_tbl8_hdr *tbl_hdr,
 /*
  * Deletes a rule
  */
+RTE_EXPORT_SYMBOL(rte_lpm6_delete)
 int
 rte_lpm6_delete(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth)
 {
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 559d5ad8a7..9e7731a8a2 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -9,6 +9,7 @@
 #include <inttypes.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_debug.h>
 #include <rte_common.h>
 #include <rte_log.h>
@@ -29,6 +30,7 @@ RTE_LOG_REGISTER_DEFAULT(mbuf_logtype, INFO);
  * rte_mempool_create(), or called directly if using
  * rte_mempool_create_empty()/rte_mempool_populate()
  */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_init)
 void
 rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
 {
@@ -69,6 +71,7 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
  * rte_mempool_obj_iter() or rte_mempool_create().
  * Set the fields of a packet mbuf to their default values.
  */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_init)
 void
 rte_pktmbuf_init(struct rte_mempool *mp,
 		 __rte_unused void *opaque_arg,
@@ -219,6 +222,7 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
 }
 
 /* Helper to create a mbuf pool with given mempool ops name*/
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_by_ops)
 struct rte_mempool *
 rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
@@ -271,6 +275,7 @@ rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 }
 
 /* helper to create a mbuf pool */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create)
 struct rte_mempool *
 rte_pktmbuf_pool_create(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
@@ -281,6 +286,7 @@ rte_pktmbuf_pool_create(const char *name, unsigned int n,
 }
 
 /* Helper to create a mbuf pool with pinned external data buffers. */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_extbuf)
 struct rte_mempool *
 rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size,
@@ -368,6 +374,7 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 }
 
 /* do some sanity checks on a mbuf: panic if it fails */
+RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check)
 void
 rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
 {
@@ -377,6 +384,7 @@ rte_mbuf_sanity_check(const struct rte_mbuf *m, int is_header)
 		rte_panic("%s\n", reason);
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_check)
 int rte_mbuf_check(const struct rte_mbuf *m, int is_header,
 		   const char **reason)
 {
@@ -486,6 +494,7 @@ __rte_pktmbuf_free_seg_via_array(struct rte_mbuf *m,
 #define RTE_PKTMBUF_FREE_PENDING_SZ 64
 
 /* Free a bulk of packet mbufs back into their original mempools. */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_free_bulk)
 void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 {
 	struct rte_mbuf *m, *m_next, *pending[RTE_PKTMBUF_FREE_PENDING_SZ];
@@ -512,6 +521,7 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 }
 
 /* Creates a shallow copy of mbuf */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_clone)
 struct rte_mbuf *
 rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_mempool *mp)
 {
@@ -551,6 +561,7 @@ rte_pktmbuf_clone(struct rte_mbuf *md, struct rte_mempool *mp)
 }
 
 /* convert multi-segment mbuf to single mbuf */
+RTE_EXPORT_SYMBOL(__rte_pktmbuf_linearize)
 int
 __rte_pktmbuf_linearize(struct rte_mbuf *mbuf)
 {
@@ -588,6 +599,7 @@ __rte_pktmbuf_linearize(struct rte_mbuf *mbuf)
 }
 
 /* Create a deep copy of mbuf */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_copy)
 struct rte_mbuf *
 rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 		 uint32_t off, uint32_t len)
@@ -665,6 +677,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 }
 
 /* dump a mbuf on console */
+RTE_EXPORT_SYMBOL(rte_pktmbuf_dump)
 void
 rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 {
@@ -707,6 +720,7 @@ rte_pktmbuf_dump(FILE *f, const struct rte_mbuf *m, unsigned dump_len)
 }
 
 /* read len data bytes in a mbuf at specified offset (internal) */
+RTE_EXPORT_SYMBOL(__rte_pktmbuf_read)
 const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
 	uint32_t len, void *buf)
 {
@@ -744,6 +758,7 @@ const void *__rte_pktmbuf_read(const struct rte_mbuf *m, uint32_t off,
  * Get the name of a RX offload flag. Must be kept synchronized with flag
  * definitions in rte_mbuf.h.
  */
+RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_name)
 const char *rte_get_rx_ol_flag_name(uint64_t mask)
 {
 	switch (mask) {
@@ -783,6 +798,7 @@ struct flag_mask {
 };
 
 /* write the list of rx ol flags in buffer buf */
+RTE_EXPORT_SYMBOL(rte_get_rx_ol_flag_list)
 int
 rte_get_rx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
 {
@@ -849,6 +865,7 @@ rte_get_rx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
  * Get the name of a TX offload flag. Must be kept synchronized with flag
  * definitions in rte_mbuf.h.
  */
+RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_name)
 const char *rte_get_tx_ol_flag_name(uint64_t mask)
 {
 	switch (mask) {
@@ -883,6 +900,7 @@ const char *rte_get_tx_ol_flag_name(uint64_t mask)
 }
 
 /* write the list of tx ol flags in buffer buf */
+RTE_EXPORT_SYMBOL(rte_get_tx_ol_flag_list)
 int
 rte_get_tx_ol_flag_list(uint64_t mask, char *buf, size_t buflen)
 {
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 1cfb329c3a..5987c9dee8 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <limits.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
@@ -189,6 +190,7 @@ __mbuf_dynfield_lookup(const char *name)
 	return mbuf_dynfield;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_lookup)
 int
 rte_mbuf_dynfield_lookup(const char *name, struct rte_mbuf_dynfield *params)
 {
@@ -325,6 +327,7 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 	return offset;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register_offset)
 int
 rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 				size_t req)
@@ -351,6 +354,7 @@ rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynfield_register)
 int
 rte_mbuf_dynfield_register(const struct rte_mbuf_dynfield *params)
 {
@@ -383,6 +387,7 @@ __mbuf_dynflag_lookup(const char *name)
 	return mbuf_dynflag;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_lookup)
 int
 rte_mbuf_dynflag_lookup(const char *name,
 			struct rte_mbuf_dynflag *params)
@@ -498,6 +503,7 @@ __rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 	return bitnum;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register_bitnum)
 int
 rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 				unsigned int req)
@@ -521,12 +527,14 @@ rte_mbuf_dynflag_register_bitnum(const struct rte_mbuf_dynflag *params,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dynflag_register)
 int
 rte_mbuf_dynflag_register(const struct rte_mbuf_dynflag *params)
 {
 	return rte_mbuf_dynflag_register_bitnum(params, UINT_MAX);
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_dump)
 void rte_mbuf_dyn_dump(FILE *out)
 {
 	struct mbuf_dynfield_list *mbuf_dynfield_list;
@@ -614,6 +622,7 @@ rte_mbuf_dyn_timestamp_register(int *field_offset, uint64_t *flag,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_rx_timestamp_register)
 int
 rte_mbuf_dyn_rx_timestamp_register(int *field_offset, uint64_t *rx_flag)
 {
@@ -621,6 +630,7 @@ rte_mbuf_dyn_rx_timestamp_register(int *field_offset, uint64_t *rx_flag)
 			"Rx", RTE_MBUF_DYNFLAG_RX_TIMESTAMP_NAME);
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_dyn_tx_timestamp_register)
 int
 rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag)
 {
diff --git a/lib/mbuf/rte_mbuf_pool_ops.c b/lib/mbuf/rte_mbuf_pool_ops.c
index 8e93c6acbd..219b364803 100644
--- a/lib/mbuf/rte_mbuf_pool_ops.c
+++ b/lib/mbuf/rte_mbuf_pool_ops.c
@@ -3,6 +3,7 @@
  */
 
 #include <string.h>
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_mbuf.h>
 #include <rte_errno.h>
@@ -10,6 +11,7 @@
 
 #include "mbuf_log.h"
 
+RTE_EXPORT_SYMBOL(rte_mbuf_set_platform_mempool_ops)
 int
 rte_mbuf_set_platform_mempool_ops(const char *ops_name)
 {
@@ -39,6 +41,7 @@ rte_mbuf_set_platform_mempool_ops(const char *ops_name)
 	return -EEXIST;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_platform_mempool_ops)
 const char *
 rte_mbuf_platform_mempool_ops(void)
 {
@@ -50,6 +53,7 @@ rte_mbuf_platform_mempool_ops(void)
 	return mz->addr;
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_set_user_mempool_ops)
 int
 rte_mbuf_set_user_mempool_ops(const char *ops_name)
 {
@@ -74,6 +78,7 @@ rte_mbuf_set_user_mempool_ops(const char *ops_name)
 
 }
 
+RTE_EXPORT_SYMBOL(rte_mbuf_user_mempool_ops)
 const char *
 rte_mbuf_user_mempool_ops(void)
 {
@@ -86,6 +91,7 @@ rte_mbuf_user_mempool_ops(void)
 }
 
 /* Return mbuf pool ops name */
+RTE_EXPORT_SYMBOL(rte_mbuf_best_mempool_ops)
 const char *
 rte_mbuf_best_mempool_ops(void)
 {
diff --git a/lib/mbuf/rte_mbuf_ptype.c b/lib/mbuf/rte_mbuf_ptype.c
index ab180b3dda..2c80294498 100644
--- a/lib/mbuf/rte_mbuf_ptype.c
+++ b/lib/mbuf/rte_mbuf_ptype.c
@@ -4,10 +4,12 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_ptype.h>
 
 /* get the name of the l2 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_l2_name)
 const char *rte_get_ptype_l2_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L2_MASK) {
@@ -26,6 +28,7 @@ const char *rte_get_ptype_l2_name(uint32_t ptype)
 }
 
 /* get the name of the l3 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_l3_name)
 const char *rte_get_ptype_l3_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L3_MASK) {
@@ -40,6 +43,7 @@ const char *rte_get_ptype_l3_name(uint32_t ptype)
 }
 
 /* get the name of the l4 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_l4_name)
 const char *rte_get_ptype_l4_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_L4_MASK) {
@@ -56,6 +60,7 @@ const char *rte_get_ptype_l4_name(uint32_t ptype)
 }
 
 /* get the name of the tunnel packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_tunnel_name)
 const char *rte_get_ptype_tunnel_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_TUNNEL_MASK) {
@@ -77,6 +82,7 @@ const char *rte_get_ptype_tunnel_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l2 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l2_name)
 const char *rte_get_ptype_inner_l2_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L2_MASK) {
@@ -88,6 +94,7 @@ const char *rte_get_ptype_inner_l2_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l3 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l3_name)
 const char *rte_get_ptype_inner_l3_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L3_MASK) {
@@ -104,6 +111,7 @@ const char *rte_get_ptype_inner_l3_name(uint32_t ptype)
 }
 
 /* get the name of the inner_l4 packet type */
+RTE_EXPORT_SYMBOL(rte_get_ptype_inner_l4_name)
 const char *rte_get_ptype_inner_l4_name(uint32_t ptype)
 {
 	switch (ptype & RTE_PTYPE_INNER_L4_MASK) {
@@ -119,6 +127,7 @@ const char *rte_get_ptype_inner_l4_name(uint32_t ptype)
 }
 
 /* write the packet type name into the buffer */
+RTE_EXPORT_SYMBOL(rte_get_ptype_name)
 int rte_get_ptype_name(uint32_t ptype, char *buf, size_t buflen)
 {
 	int ret;
diff --git a/lib/member/rte_member.c b/lib/member/rte_member.c
index 57eb7affab..5ff32f1e45 100644
--- a/lib/member/rte_member.c
+++ b/lib/member/rte_member.c
@@ -4,6 +4,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
@@ -23,6 +24,7 @@ static struct rte_tailq_elem rte_member_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_member_tailq)
 
+RTE_EXPORT_SYMBOL(rte_member_find_existing)
 struct rte_member_setsum *
 rte_member_find_existing(const char *name)
 {
@@ -47,6 +49,7 @@ rte_member_find_existing(const char *name)
 	return setsum;
 }
 
+RTE_EXPORT_SYMBOL(rte_member_free)
 void
 rte_member_free(struct rte_member_setsum *setsum)
 {
@@ -85,6 +88,7 @@ rte_member_free(struct rte_member_setsum *setsum)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_member_create)
 struct rte_member_setsum *
 rte_member_create(const struct rte_member_parameters *params)
 {
@@ -188,6 +192,7 @@ rte_member_create(const struct rte_member_parameters *params)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_member_add)
 int
 rte_member_add(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t set_id)
@@ -207,6 +212,7 @@ rte_member_add(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_add_byte_count)
 int
 rte_member_add_byte_count(const struct rte_member_setsum *setsum,
 			  const void *key, uint32_t byte_count)
@@ -222,6 +228,7 @@ rte_member_add_byte_count(const struct rte_member_setsum *setsum,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_lookup)
 int
 rte_member_lookup(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t *set_id)
@@ -241,6 +248,7 @@ rte_member_lookup(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_lookup_bulk)
 int
 rte_member_lookup_bulk(const struct rte_member_setsum *setsum,
 				const void **keys, uint32_t num_keys,
@@ -261,6 +269,7 @@ rte_member_lookup_bulk(const struct rte_member_setsum *setsum,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_lookup_multi)
 int
 rte_member_lookup_multi(const struct rte_member_setsum *setsum, const void *key,
 				uint32_t match_per_key, member_set_t *set_id)
@@ -280,6 +289,7 @@ rte_member_lookup_multi(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_lookup_multi_bulk)
 int
 rte_member_lookup_multi_bulk(const struct rte_member_setsum *setsum,
 			const void **keys, uint32_t num_keys,
@@ -302,6 +312,7 @@ rte_member_lookup_multi_bulk(const struct rte_member_setsum *setsum,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_query_count)
 int
 rte_member_query_count(const struct rte_member_setsum *setsum,
 		       const void *key, uint64_t *output)
@@ -317,6 +328,7 @@ rte_member_query_count(const struct rte_member_setsum *setsum,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_report_heavyhitter)
 int
 rte_member_report_heavyhitter(const struct rte_member_setsum *setsum,
 				void **key, uint64_t *count)
@@ -332,6 +344,7 @@ rte_member_report_heavyhitter(const struct rte_member_setsum *setsum,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_delete)
 int
 rte_member_delete(const struct rte_member_setsum *setsum, const void *key,
 			member_set_t set_id)
@@ -351,6 +364,7 @@ rte_member_delete(const struct rte_member_setsum *setsum, const void *key,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_member_reset)
 void
 rte_member_reset(const struct rte_member_setsum *setsum)
 {
diff --git a/lib/mempool/mempool_trace_points.c b/lib/mempool/mempool_trace_points.c
index 307018094d..ec465780f4 100644
--- a/lib/mempool/mempool_trace_points.c
+++ b/lib/mempool/mempool_trace_points.c
@@ -2,31 +2,40 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_trace_point_register.h>
 
 #include "mempool_trace.h"
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_bulk, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_dequeue_bulk,
 	lib.mempool.ops.deq.bulk)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_dequeue_contig_blocks, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_dequeue_contig_blocks,
 	lib.mempool.ops.deq.contig)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_ops_enqueue_bulk, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_ops_enqueue_bulk,
 	lib.mempool.ops.enq.bulk)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_put, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_generic_put,
 	lib.mempool.generic.put)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_put_bulk, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_put_bulk,
 	lib.mempool.put.bulk)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_generic_get, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_generic_get,
 	lib.mempool.generic.get)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_bulk, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_bulk,
 	lib.mempool.get.bulk)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_get_contig_blocks, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_contig_blocks,
 	lib.mempool.get.blocks)
 
@@ -57,12 +66,14 @@ RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_create,
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_free,
 	lib.mempool.cache.free)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_default_cache, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_default_cache,
 	lib.mempool.default.cache)
 
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_get_page_size,
 	lib.mempool.get.page.size)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_cache_flush, 20.05)
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_flush,
 	lib.mempool.cache.flush)
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1e4f24783c..1021ede0c2 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_debug.h>
@@ -31,6 +32,7 @@
 #include "mempool_trace.h"
 #include "rte_mempool.h"
 
+RTE_EXPORT_SYMBOL(rte_mempool_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_mempool_logtype, INFO);
 
 TAILQ_HEAD(rte_mempool_list, rte_tailq_entry);
@@ -179,6 +181,7 @@ mempool_add_elem(struct rte_mempool *mp, __rte_unused void *opaque,
 }
 
 /* call obj_cb() for each mempool element */
+RTE_EXPORT_SYMBOL(rte_mempool_obj_iter)
 uint32_t
 rte_mempool_obj_iter(struct rte_mempool *mp,
 	rte_mempool_obj_cb_t *obj_cb, void *obj_cb_arg)
@@ -197,6 +200,7 @@ rte_mempool_obj_iter(struct rte_mempool *mp,
 }
 
 /* call mem_cb() for each mempool memory chunk */
+RTE_EXPORT_SYMBOL(rte_mempool_mem_iter)
 uint32_t
 rte_mempool_mem_iter(struct rte_mempool *mp,
 	rte_mempool_mem_cb_t *mem_cb, void *mem_cb_arg)
@@ -213,6 +217,7 @@ rte_mempool_mem_iter(struct rte_mempool *mp,
 }
 
 /* get the header, trailer and total size of a mempool element. */
+RTE_EXPORT_SYMBOL(rte_mempool_calc_obj_size)
 uint32_t
 rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 	struct rte_mempool_objsz *sz)
@@ -313,6 +318,7 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
  * zone. Return the number of objects added, or a negative value
  * on error.
  */
+RTE_EXPORT_SYMBOL(rte_mempool_populate_iova)
 int
 rte_mempool_populate_iova(struct rte_mempool *mp, char *vaddr,
 	rte_iova_t iova, size_t len, rte_mempool_memchunk_free_cb_t *free_cb,
@@ -398,6 +404,7 @@ get_iova(void *addr)
 /* Populate the mempool with a virtual area. Return the number of
  * objects added, or a negative value on error.
  */
+RTE_EXPORT_SYMBOL(rte_mempool_populate_virt)
 int
 rte_mempool_populate_virt(struct rte_mempool *mp, char *addr,
 	size_t len, size_t pg_sz, rte_mempool_memchunk_free_cb_t *free_cb,
@@ -452,6 +459,7 @@ rte_mempool_populate_virt(struct rte_mempool *mp, char *addr,
 }
 
 /* Get the minimal page size used in a mempool before populating it. */
+RTE_EXPORT_SYMBOL(rte_mempool_get_page_size)
 int
 rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
 {
@@ -481,6 +489,7 @@ rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
  * and populate them. Return the number of objects added, or a negative
  * value on error.
  */
+RTE_EXPORT_SYMBOL(rte_mempool_populate_default)
 int
 rte_mempool_populate_default(struct rte_mempool *mp)
 {
@@ -659,6 +668,7 @@ rte_mempool_memchunk_anon_free(struct rte_mempool_memhdr *memhdr,
 }
 
 /* populate the mempool with an anonymous mapping */
+RTE_EXPORT_SYMBOL(rte_mempool_populate_anon)
 int
 rte_mempool_populate_anon(struct rte_mempool *mp)
 {
@@ -713,6 +723,7 @@ rte_mempool_populate_anon(struct rte_mempool *mp)
 }
 
 /* free a mempool */
+RTE_EXPORT_SYMBOL(rte_mempool_free)
 void
 rte_mempool_free(struct rte_mempool *mp)
 {
@@ -761,6 +772,7 @@ mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
  * returned to an underlying mempool. This structure is identical to the
  * local_cache[lcore_id] pointed to by the mempool structure.
  */
+RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
 rte_mempool_cache_create(uint32_t size, int socket_id)
 {
@@ -790,6 +802,7 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
  * remaining objects in the cache are flushed to the corresponding
  * mempool.
  */
+RTE_EXPORT_SYMBOL(rte_mempool_cache_free)
 void
 rte_mempool_cache_free(struct rte_mempool_cache *cache)
 {
@@ -798,6 +811,7 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache)
 }
 
 /* create an empty mempool */
+RTE_EXPORT_SYMBOL(rte_mempool_create_empty)
 struct rte_mempool *
 rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	unsigned cache_size, unsigned private_data_size,
@@ -966,6 +980,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 }
 
 /* create the mempool */
+RTE_EXPORT_SYMBOL(rte_mempool_create)
 struct rte_mempool *
 rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 	unsigned cache_size, unsigned private_data_size,
@@ -1002,6 +1017,7 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 }
 
 /* Return the number of entries in the mempool */
+RTE_EXPORT_SYMBOL(rte_mempool_avail_count)
 unsigned int
 rte_mempool_avail_count(const struct rte_mempool *mp)
 {
@@ -1026,6 +1042,7 @@ rte_mempool_avail_count(const struct rte_mempool *mp)
 }
 
 /* return the number of entries allocated from the mempool */
+RTE_EXPORT_SYMBOL(rte_mempool_in_use_count)
 unsigned int
 rte_mempool_in_use_count(const struct rte_mempool *mp)
 {
@@ -1057,6 +1074,7 @@ rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 }
 
 /* check and update cookies or panic (internal) */
+RTE_EXPORT_SYMBOL(rte_mempool_check_cookies)
 void rte_mempool_check_cookies(const struct rte_mempool *mp,
 	void * const *obj_table_const, unsigned n, int free)
 {
@@ -1125,6 +1143,7 @@ void rte_mempool_check_cookies(const struct rte_mempool *mp,
 #endif
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_contig_blocks_check_cookies)
 void
 rte_mempool_contig_blocks_check_cookies(const struct rte_mempool *mp,
 	void * const *first_obj_table_const, unsigned int n, int free)
@@ -1201,6 +1220,7 @@ mempool_audit_cache(const struct rte_mempool *mp)
 }
 
 /* check the consistency of mempool (size, cookies, ...) */
+RTE_EXPORT_SYMBOL(rte_mempool_audit)
 void
 rte_mempool_audit(struct rte_mempool *mp)
 {
@@ -1212,6 +1232,7 @@ rte_mempool_audit(struct rte_mempool *mp)
 }
 
 /* dump the status of the mempool on the console */
+RTE_EXPORT_SYMBOL(rte_mempool_dump)
 void
 rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 {
@@ -1316,6 +1337,7 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 }
 
 /* dump the status of all mempools on the console */
+RTE_EXPORT_SYMBOL(rte_mempool_list_dump)
 void
 rte_mempool_list_dump(FILE *f)
 {
@@ -1336,6 +1358,7 @@ rte_mempool_list_dump(FILE *f)
 }
 
 /* search a mempool from its name */
+RTE_EXPORT_SYMBOL(rte_mempool_lookup)
 struct rte_mempool *
 rte_mempool_lookup(const char *name)
 {
@@ -1363,6 +1386,7 @@ rte_mempool_lookup(const char *name)
 	return mp;
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_walk)
 void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 		      void *arg)
 {
@@ -1381,6 +1405,7 @@ void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 	rte_mcfg_mempool_read_unlock();
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_mem_range, 24.07)
 int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 		struct rte_mempool_mem_range_info *mem_range)
 {
@@ -1415,6 +1440,7 @@ int rte_mempool_get_mem_range(const struct rte_mempool *mp,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_get_obj_alignment, 24.07)
 size_t rte_mempool_get_obj_alignment(const struct rte_mempool *mp)
 {
 	if (mp == NULL)
@@ -1448,6 +1474,7 @@ mempool_event_callback_invoke(enum rte_mempool_event event,
 	rte_mcfg_tailq_read_unlock();
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_register)
 int
 rte_mempool_event_callback_register(rte_mempool_event_callback *func,
 				    void *user_data)
@@ -1486,6 +1513,7 @@ rte_mempool_event_callback_register(rte_mempool_event_callback *func,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mempool_event_callback_unregister)
 int
 rte_mempool_event_callback_unregister(rte_mempool_event_callback *func,
 				      void *user_data)
diff --git a/lib/mempool/rte_mempool_ops.c b/lib/mempool/rte_mempool_ops.c
index 1b33380259..066bec36fc 100644
--- a/lib/mempool/rte_mempool_ops.c
+++ b/lib/mempool/rte_mempool_ops.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_mempool.h>
 #include <rte_errno.h>
@@ -14,12 +15,14 @@
 #include "mempool_trace.h"
 
 /* indirect jump table to support external memory pools. */
+RTE_EXPORT_SYMBOL(rte_mempool_ops_table)
 struct rte_mempool_ops_table rte_mempool_ops_table = {
 	.sl =  RTE_SPINLOCK_INITIALIZER,
 	.num_ops = 0
 };
 
 /* add a new ops struct in rte_mempool_ops_table, return its index. */
+RTE_EXPORT_SYMBOL(rte_mempool_register_ops)
 int
 rte_mempool_register_ops(const struct rte_mempool_ops *h)
 {
@@ -146,6 +149,7 @@ rte_mempool_ops_populate(struct rte_mempool *mp, unsigned int max_objs,
 }
 
 /* wrapper to get additional mempool info */
+RTE_EXPORT_SYMBOL(rte_mempool_ops_get_info)
 int
 rte_mempool_ops_get_info(const struct rte_mempool *mp,
 			 struct rte_mempool_info *info)
@@ -161,6 +165,7 @@ rte_mempool_ops_get_info(const struct rte_mempool *mp,
 
 
 /* sets mempool ops previously registered by rte_mempool_register_ops. */
+RTE_EXPORT_SYMBOL(rte_mempool_set_ops_byname)
 int
 rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
 	void *pool_config)
diff --git a/lib/mempool/rte_mempool_ops_default.c b/lib/mempool/rte_mempool_ops_default.c
index 22fccf9d76..d27d6fc473 100644
--- a/lib/mempool/rte_mempool_ops_default.c
+++ b/lib/mempool/rte_mempool_ops_default.c
@@ -4,8 +4,10 @@
  * Copyright(c) 2018 Solarflare Communications Inc.
  */
 
+#include <eal_export.h>
 #include <rte_mempool.h>
 
+RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_helper)
 ssize_t
 rte_mempool_op_calc_mem_size_helper(const struct rte_mempool *mp,
 				uint32_t obj_num, uint32_t pg_shift,
@@ -65,6 +67,7 @@ rte_mempool_op_calc_mem_size_helper(const struct rte_mempool *mp,
 	return mem_size;
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_op_calc_mem_size_default)
 ssize_t
 rte_mempool_op_calc_mem_size_default(const struct rte_mempool *mp,
 				uint32_t obj_num, uint32_t pg_shift,
@@ -87,6 +90,7 @@ check_obj_bounds(char *obj, size_t pg_sz, size_t elt_sz)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_op_populate_helper)
 int
 rte_mempool_op_populate_helper(struct rte_mempool *mp, unsigned int flags,
 			unsigned int max_objs, void *vaddr, rte_iova_t iova,
@@ -134,6 +138,7 @@ rte_mempool_op_populate_helper(struct rte_mempool *mp, unsigned int flags,
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_mempool_op_populate_default)
 int
 rte_mempool_op_populate_default(struct rte_mempool *mp, unsigned int max_objs,
 				void *vaddr, rte_iova_t iova, size_t len,
diff --git a/lib/meter/rte_meter.c b/lib/meter/rte_meter.c
index 6545803d36..ec76bec4cb 100644
--- a/lib/meter/rte_meter.c
+++ b/lib/meter/rte_meter.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <math.h>
 
+#include <eal_export.h>
 #include <rte_cycles.h>
 
 #include "rte_meter.h"
@@ -36,6 +37,7 @@ rte_meter_get_tb_params(uint64_t hz, uint64_t rate, uint64_t *tb_period, uint64_
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_srtcm_profile_config)
 int
 rte_meter_srtcm_profile_config(struct rte_meter_srtcm_profile *p,
 	struct rte_meter_srtcm_params *params)
@@ -58,6 +60,7 @@ rte_meter_srtcm_profile_config(struct rte_meter_srtcm_profile *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_srtcm_config)
 int
 rte_meter_srtcm_config(struct rte_meter_srtcm *m,
 	struct rte_meter_srtcm_profile *p)
@@ -74,6 +77,7 @@ rte_meter_srtcm_config(struct rte_meter_srtcm *m,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_profile_config)
 int
 rte_meter_trtcm_profile_config(struct rte_meter_trtcm_profile *p,
 	struct rte_meter_trtcm_params *params)
@@ -101,6 +105,7 @@ rte_meter_trtcm_profile_config(struct rte_meter_trtcm_profile *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_config)
 int
 rte_meter_trtcm_config(struct rte_meter_trtcm *m,
 	struct rte_meter_trtcm_profile *p)
@@ -117,6 +122,7 @@ rte_meter_trtcm_config(struct rte_meter_trtcm *m,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_profile_config)
 int
 rte_meter_trtcm_rfc4115_profile_config(
 	struct rte_meter_trtcm_rfc4115_profile *p,
@@ -142,6 +148,7 @@ rte_meter_trtcm_rfc4115_profile_config(
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_meter_trtcm_rfc4115_config)
 int
 rte_meter_trtcm_rfc4115_config(
 	struct rte_meter_trtcm_rfc4115 *m,
diff --git a/lib/metrics/rte_metrics.c b/lib/metrics/rte_metrics.c
index 0ccdbabc04..4cd4623b7a 100644
--- a/lib/metrics/rte_metrics.c
+++ b/lib/metrics/rte_metrics.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_common.h>
 #include <rte_string_fns.h>
@@ -55,6 +56,7 @@ struct rte_metrics_data_s {
 	rte_spinlock_t lock;
 };
 
+RTE_EXPORT_SYMBOL(rte_metrics_init)
 int
 rte_metrics_init(int socket_id)
 {
@@ -80,6 +82,7 @@ rte_metrics_init(int socket_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_deinit)
 int
 rte_metrics_deinit(void)
 {
@@ -103,6 +106,7 @@ rte_metrics_deinit(void)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_reg_name)
 int
 rte_metrics_reg_name(const char *name)
 {
@@ -111,6 +115,7 @@ rte_metrics_reg_name(const char *name)
 	return rte_metrics_reg_names(list_names, 1);
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_reg_names)
 int
 rte_metrics_reg_names(const char * const *names, uint16_t cnt_names)
 {
@@ -157,12 +162,14 @@ rte_metrics_reg_names(const char * const *names, uint16_t cnt_names)
 	return idx_base;
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_update_value)
 int
 rte_metrics_update_value(int port_id, uint16_t key, const uint64_t value)
 {
 	return rte_metrics_update_values(port_id, key, &value, 1);
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_update_values)
 int
 rte_metrics_update_values(int port_id,
 	uint16_t key,
@@ -225,6 +232,7 @@ rte_metrics_update_values(int port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_get_names)
 int
 rte_metrics_get_names(struct rte_metric_name *names,
 	uint16_t capacity)
@@ -256,6 +264,7 @@ rte_metrics_get_names(struct rte_metric_name *names,
 	return return_value;
 }
 
+RTE_EXPORT_SYMBOL(rte_metrics_get_values)
 int
 rte_metrics_get_values(int port_id,
 	struct rte_metric_value *values,
diff --git a/lib/metrics/rte_metrics_telemetry.c b/lib/metrics/rte_metrics_telemetry.c
index dc43611d29..f9ec556595 100644
--- a/lib/metrics/rte_metrics_telemetry.c
+++ b/lib/metrics/rte_metrics_telemetry.c
@@ -3,6 +3,7 @@
  */
 
 #include <ethdev_driver.h>
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #ifdef RTE_LIB_TELEMETRY
 #include <telemetry_internal.h>
@@ -71,6 +72,7 @@ rte_metrics_tel_reg_port_ethdev_to_metrics(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
 int32_t
 rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 {
@@ -225,6 +227,7 @@ rte_metrics_tel_format_port(uint32_t pid, json_t *ports,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
 int32_t
 rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 		char **json_buffer)
@@ -278,6 +281,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
 int32_t
 rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 		int *reg_index, char **json_buffer)
@@ -308,6 +312,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
 int32_t
 rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 {
@@ -374,6 +379,7 @@ rte_metrics_tel_stat_names_to_ids(const char * const *stat_names,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
 int32_t
 rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 {
@@ -544,6 +550,7 @@ RTE_INIT(metrics_ctor)
 
 #else /* !RTE_HAS_JANSSON */
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
 int32_t
 rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 {
@@ -553,6 +560,7 @@ rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
 int32_t
 rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	char **json_buffer)
@@ -563,6 +571,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
 int32_t
 rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	int *reg_index, char **json_buffer)
@@ -574,6 +583,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
 int32_t
 rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 {
@@ -582,6 +592,7 @@ rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
 int32_t
 rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 {
@@ -591,6 +602,7 @@ rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
 	return -ENOTSUP;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_global_stats, 20.05)
 int32_t
 rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep)
 {
diff --git a/lib/mldev/mldev_utils.c b/lib/mldev/mldev_utils.c
index 13ac615e9f..b15f825158 100644
--- a/lib/mldev/mldev_utils.c
+++ b/lib/mldev/mldev_utils.c
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mldev.h>
 #include <rte_string_fns.h>
 
@@ -14,6 +15,7 @@
  * This file implements Machine Learning utility routines, except type conversion routines.
  */
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_size_get)
 int
 rte_ml_io_type_size_get(enum rte_ml_io_type type)
 {
@@ -49,6 +51,7 @@ rte_ml_io_type_size_get(enum rte_ml_io_type type)
 	}
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_io_type_to_str)
 void
 rte_ml_io_type_to_str(enum rte_ml_io_type type, char *str, int len)
 {
diff --git a/lib/mldev/mldev_utils_neon.c b/lib/mldev/mldev_utils_neon.c
index 8751a40863..0222bd7e15 100644
--- a/lib/mldev/mldev_utils_neon.c
+++ b/lib/mldev/mldev_utils_neon.c
@@ -10,6 +10,8 @@
 
 #include <arm_neon.h>
 
+#include <eal_export.h>
+
 /* Description:
  * This file implements vector versions of Machine Learning utility functions used to convert data
  * types from higher precision to lower precision and vice-versa, except bfloat16. Implementation
@@ -75,6 +77,7 @@ __float32_to_int8_neon_s8x1(const float *input, int8_t *output, float scale, int
 	*output = vqmovnh_s16(s16);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11)
 int
 rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -149,6 +152,7 @@ __int8_to_float32_neon_f32x1(const int8_t *input, float *output, float scale, in
 	*output = scale * (vcvts_f32_s32((int32_t)*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11)
 int
 rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -242,6 +246,7 @@ __float32_to_uint8_neon_u8x1(const float *input, uint8_t *output, float scale, u
 	*output = vqmovnh_u16(u16);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11)
 int
 rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -316,6 +321,7 @@ __uint8_to_float32_neon_f32x1(const uint8_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_u32((uint32_t)*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11)
 int
 rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -395,6 +401,7 @@ __float32_to_int16_neon_s16x1(const float *input, int16_t *output, float scale,
 	*output = vqmovns_s32(vget_lane_s32(s32x2, 0));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11)
 int
 rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -463,6 +470,7 @@ __int16_to_float32_neon_f32x1(const int16_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_s32((int32_t)*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11)
 int
 rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -539,6 +547,7 @@ __float32_to_uint16_neon_u16x1(const float *input, uint16_t *output, float scale
 	*output = vqmovns_u32(u32) + zero_point;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11)
 int
 rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint16_t zero_point)
@@ -609,6 +618,7 @@ __uint16_to_float32_neon_f32x1(const uint16_t *input, float *output, float scale
 	*output = scale * (vcvts_f32_u32((uint32_t)*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11)
 int
 rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint16_t zero_point)
@@ -687,6 +697,7 @@ __float32_to_int32_neon_s32x1(const float *input, int32_t *output, float scale,
 	vst1_lane_s32(output, s32x2, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11)
 int
 rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -751,6 +762,7 @@ __int32_to_float32_neon_f32x1(const int32_t *input, float *output, float scale,
 	*output = scale * (vcvts_f32_s32(*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11)
 int
 rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -818,6 +830,7 @@ __float32_to_uint32_neon_u32x1(const float *input, uint32_t *output, float scale
 	*output = vcvtas_u32_f32((*input) / scale + (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11)
 int
 rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint32_t zero_point)
@@ -884,6 +897,7 @@ __uint32_to_float32_neon_f32x1(const uint32_t *input, float *output, float scale
 	*output = scale * (vcvts_f32_u32(*input) - (float)zero_point);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11)
 int
 rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint32_t zero_point)
@@ -978,6 +992,7 @@ __float32_to_int64_neon_s64x1(const float *input, int64_t *output, float scale,
 	*output = s64;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11)
 int
 rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -1066,6 +1081,7 @@ __int64_to_float32_neon_f32x1(const int64_t *input, float *output, float scale,
 	vst1_lane_f32(output, f32x2, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11)
 int
 rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -1156,6 +1172,7 @@ __float32_to_uint64_neon_u64x1(const float *input, uint64_t *output, float scale
 	vst1q_lane_u64(output, u64x2, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11)
 int
 rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint64_t zero_point)
@@ -1246,6 +1263,7 @@ __uint64_to_float32_neon_f32x1(const uint64_t *input, float *output, float scale
 	vst1_lane_f32(output, f32x2, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11)
 int
 rte_ml_io_uint64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint64_t zero_point)
@@ -1314,6 +1332,7 @@ __float32_to_float16_neon_f16x1(const float32_t *input, float16_t *output)
 	vst1_lane_f16(output, f16x4, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11)
 int
 rte_ml_io_float32_to_float16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -1381,6 +1400,7 @@ __float16_to_float32_neon_f32x1(const float16_t *input, float32_t *output)
 	vst1q_lane_f32(output, f32x4, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11)
 int
 rte_ml_io_float16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_neon_bfloat16.c b/lib/mldev/mldev_utils_neon_bfloat16.c
index b8e6853266..65cd73f880 100644
--- a/lib/mldev/mldev_utils_neon_bfloat16.c
+++ b/lib/mldev/mldev_utils_neon_bfloat16.c
@@ -10,6 +10,8 @@
 
 #include <arm_neon.h>
 
+#include <eal_export.h>
+
 /* Description:
  * This file implements vector versions of Machine Learning utility functions used to convert data
  * types from bfloat16 to float and vice-versa. Implementation is based on Arm Neon intrinsics.
@@ -49,6 +51,7 @@ __float32_to_bfloat16_neon_f16x1(const float32_t *input, bfloat16_t *output)
 	vst1_lane_bf16(output, bf16x4, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11)
 int
 rte_ml_io_float32_to_bfloat16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -116,6 +119,7 @@ __bfloat16_to_float32_neon_f32x1(const bfloat16_t *input, float32_t *output)
 	vst1q_lane_f32(output, f32x4, 0);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11)
 int
 rte_ml_io_bfloat16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_scalar.c b/lib/mldev/mldev_utils_scalar.c
index e1fefdec3b..a3aac3f92e 100644
--- a/lib/mldev/mldev_utils_scalar.c
+++ b/lib/mldev/mldev_utils_scalar.c
@@ -4,11 +4,14 @@
 
 #include "mldev_utils_scalar.h"
 
+#include <eal_export.h>
+
 /* Description:
  * This file implements scalar versions of Machine Learning utility functions used to convert data
  * types from higher precision to lower precision and vice-versa, except bfloat16.
  */
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int8, 22.11)
 int
 rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -42,6 +45,7 @@ rte_ml_io_float32_to_int8(const void *input, void *output, uint64_t nb_elements,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int8_to_float32, 22.11)
 int
 rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			  int8_t zero_point)
@@ -66,6 +70,7 @@ rte_ml_io_int8_to_float32(const void *input, void *output, uint64_t nb_elements,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint8, 22.11)
 int
 rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -99,6 +104,7 @@ rte_ml_io_float32_to_uint8(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint8_to_float32, 22.11)
 int
 rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   uint8_t zero_point)
@@ -123,6 +129,7 @@ rte_ml_io_uint8_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int16, 22.11)
 int
 rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -156,6 +163,7 @@ rte_ml_io_float32_to_int16(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int16_to_float32, 22.11)
 int
 rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int16_t zero_point)
@@ -180,6 +188,7 @@ rte_ml_io_int16_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint16, 22.11)
 int
 rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint16_t zero_point)
@@ -213,6 +222,7 @@ rte_ml_io_float32_to_uint16(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint16_to_float32, 22.11)
 int
 rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint16_t zero_point)
@@ -237,6 +247,7 @@ rte_ml_io_uint16_to_float32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int32, 22.11)
 int
 rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -261,6 +272,7 @@ rte_ml_io_float32_to_int32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int32_to_float32, 22.11)
 int
 rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int32_t zero_point)
@@ -285,6 +297,7 @@ rte_ml_io_int32_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint32, 22.11)
 int
 rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint32_t zero_point)
@@ -315,6 +328,7 @@ rte_ml_io_float32_to_uint32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint32_to_float32, 22.11)
 int
 rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint32_t zero_point)
@@ -339,6 +353,7 @@ rte_ml_io_uint32_to_float32(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_int64, 22.11)
 int
 rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -363,6 +378,7 @@ rte_ml_io_float32_to_int64(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_int64_to_float32, 22.11)
 int
 rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			   int64_t zero_point)
@@ -387,6 +403,7 @@ rte_ml_io_int64_to_float32(const void *input, void *output, uint64_t nb_elements
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_uint64, 22.11)
 int
 rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint64_t zero_point)
@@ -417,6 +434,7 @@ rte_ml_io_float32_to_uint64(const void *input, void *output, uint64_t nb_element
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_uint64_to_float32, 22.11)
 int
 rte_ml_io_uint64_to_float32(const void *input, void *output, uint64_t nb_elements, float scale,
 			    uint64_t zero_point)
@@ -563,6 +581,7 @@ __float32_to_float16_scalar_rtn(float x)
 	return u16;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_float16, 22.11)
 int
 rte_ml_io_float32_to_float16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -647,6 +666,7 @@ __float16_to_float32_scalar_rtx(uint16_t f16)
 	return f32.f;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float16_to_float32, 22.11)
 int
 rte_ml_io_float16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/mldev_utils_scalar_bfloat16.c b/lib/mldev/mldev_utils_scalar_bfloat16.c
index 3f93272518..a098d31526 100644
--- a/lib/mldev/mldev_utils_scalar_bfloat16.c
+++ b/lib/mldev/mldev_utils_scalar_bfloat16.c
@@ -8,6 +8,8 @@
 
 #include "mldev_utils_scalar.h"
 
+#include <eal_export.h>
+
 /* Description:
  * This file implements scalar versions of Machine Learning utility functions used to convert data
  * types from bfloat16 to float32 and vice-versa.
@@ -91,6 +93,7 @@ __float32_to_bfloat16_scalar_rtn(float x)
 	return u16;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_float32_to_bfloat16, 22.11)
 int
 rte_ml_io_float32_to_bfloat16(const void *input, void *output, uint64_t nb_elements)
 {
@@ -173,6 +176,7 @@ __bfloat16_to_float32_scalar_rtx(uint16_t f16)
 	return f32.f;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_bfloat16_to_float32, 22.11)
 int
 rte_ml_io_bfloat16_to_float32(const void *input, void *output, uint64_t nb_elements)
 {
diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index a81ece07b6..b61e4be45c 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2022 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_mldev.h>
@@ -23,12 +24,14 @@ struct rte_ml_op_pool_private {
 	/*< Size of private user data with each operation. */
 };
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_dev)
 struct rte_ml_dev *
 rte_ml_dev_pmd_get_dev(int16_t dev_id)
 {
 	return &ml_dev_globals.devs[dev_id];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_named_dev)
 struct rte_ml_dev *
 rte_ml_dev_pmd_get_named_dev(const char *name)
 {
@@ -47,6 +50,7 @@ rte_ml_dev_pmd_get_named_dev(const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_allocate)
 struct rte_ml_dev *
 rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 {
@@ -120,6 +124,7 @@ rte_ml_dev_pmd_allocate(const char *name, uint8_t socket_id)
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_release)
 int
 rte_ml_dev_pmd_release(struct rte_ml_dev *dev)
 {
@@ -155,6 +160,7 @@ rte_ml_dev_pmd_release(struct rte_ml_dev *dev)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_init, 22.11)
 int
 rte_ml_dev_init(size_t dev_max)
 {
@@ -190,12 +196,14 @@ rte_ml_dev_init(size_t dev_max)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_count, 22.11)
 uint16_t
 rte_ml_dev_count(void)
 {
 	return ml_dev_globals.nb_devs;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_is_valid_dev, 22.11)
 int
 rte_ml_dev_is_valid_dev(int16_t dev_id)
 {
@@ -211,6 +219,7 @@ rte_ml_dev_is_valid_dev(int16_t dev_id)
 		return 1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_socket_id, 22.11)
 int
 rte_ml_dev_socket_id(int16_t dev_id)
 {
@@ -226,6 +235,7 @@ rte_ml_dev_socket_id(int16_t dev_id)
 	return dev->data->socket_id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_info_get, 22.11)
 int
 rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 {
@@ -249,6 +259,7 @@ rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 	return dev->dev_ops->dev_info_get(dev, dev_info);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_configure, 22.11)
 int
 rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 {
@@ -288,6 +299,7 @@ rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 	return dev->dev_ops->dev_configure(dev, config);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_close, 22.11)
 int
 rte_ml_dev_close(int16_t dev_id)
 {
@@ -311,6 +323,7 @@ rte_ml_dev_close(int16_t dev_id)
 	return dev->dev_ops->dev_close(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_start, 22.11)
 int
 rte_ml_dev_start(int16_t dev_id)
 {
@@ -338,6 +351,7 @@ rte_ml_dev_start(int16_t dev_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stop, 22.11)
 int
 rte_ml_dev_stop(int16_t dev_id)
 {
@@ -365,6 +379,7 @@ rte_ml_dev_stop(int16_t dev_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_count, 22.11)
 uint16_t
 rte_ml_dev_queue_pair_count(int16_t dev_id)
 {
@@ -380,6 +395,7 @@ rte_ml_dev_queue_pair_count(int16_t dev_id)
 	return dev->data->nb_queue_pairs;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_queue_pair_setup, 22.11)
 int
 rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 			    const struct rte_ml_dev_qp_conf *qp_conf, int socket_id)
@@ -413,6 +429,7 @@ rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->dev_queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_get, 22.11)
 int
 rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 {
@@ -436,6 +453,7 @@ rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 	return dev->dev_ops->dev_stats_get(dev, stats);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_stats_reset, 22.11)
 void
 rte_ml_dev_stats_reset(int16_t dev_id)
 {
@@ -453,6 +471,7 @@ rte_ml_dev_stats_reset(int16_t dev_id)
 	dev->dev_ops->dev_stats_reset(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_names_get, 22.11)
 int
 rte_ml_dev_xstats_names_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 			    struct rte_ml_dev_xstats_map *xstats_map, uint32_t size)
@@ -471,6 +490,7 @@ rte_ml_dev_xstats_names_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, in
 	return dev->dev_ops->dev_xstats_names_get(dev, mode, model_id, xstats_map, size);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_by_name_get, 22.11)
 int
 rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_id, uint64_t *value)
 {
@@ -498,6 +518,7 @@ rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_i
 	return dev->dev_ops->dev_xstats_by_name_get(dev, name, stat_id, value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_get, 22.11)
 int
 rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 		      const uint16_t stat_ids[], uint64_t values[], uint16_t nb_ids)
@@ -526,6 +547,7 @@ rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t
 	return dev->dev_ops->dev_xstats_get(dev, mode, model_id, stat_ids, values, nb_ids);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_xstats_reset, 22.11)
 int
 rte_ml_dev_xstats_reset(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t model_id,
 			const uint16_t stat_ids[], uint16_t nb_ids)
@@ -544,6 +566,7 @@ rte_ml_dev_xstats_reset(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_
 	return dev->dev_ops->dev_xstats_reset(dev, mode, model_id, stat_ids, nb_ids);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_dump, 22.11)
 int
 rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 {
@@ -566,6 +589,7 @@ rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 	return dev->dev_ops->dev_dump(dev, fd);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_selftest, 22.11)
 int
 rte_ml_dev_selftest(int16_t dev_id)
 {
@@ -583,6 +607,7 @@ rte_ml_dev_selftest(int16_t dev_id)
 	return dev->dev_ops->dev_selftest(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_load, 22.11)
 int
 rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *model_id)
 {
@@ -610,6 +635,7 @@ rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *
 	return dev->dev_ops->model_load(dev, params, model_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_unload, 22.11)
 int
 rte_ml_model_unload(int16_t dev_id, uint16_t model_id)
 {
@@ -627,6 +653,7 @@ rte_ml_model_unload(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_unload(dev, model_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_start, 22.11)
 int
 rte_ml_model_start(int16_t dev_id, uint16_t model_id)
 {
@@ -644,6 +671,7 @@ rte_ml_model_start(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_start(dev, model_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_stop, 22.11)
 int
 rte_ml_model_stop(int16_t dev_id, uint16_t model_id)
 {
@@ -661,6 +689,7 @@ rte_ml_model_stop(int16_t dev_id, uint16_t model_id)
 	return dev->dev_ops->model_stop(dev, model_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_info_get, 22.11)
 int
 rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_info *model_info)
 {
@@ -684,6 +713,7 @@ rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_inf
 	return dev->dev_ops->model_info_get(dev, model_id, model_info);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_model_params_update, 22.11)
 int
 rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 {
@@ -706,6 +736,7 @@ rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 	return dev->dev_ops->model_params_update(dev, model_id, buffer);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_quantize, 22.11)
 int
 rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **dbuffer,
 		   struct rte_ml_buff_seg **qbuffer)
@@ -734,6 +765,7 @@ rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **d
 	return dev->dev_ops->io_quantize(dev, model_id, dbuffer, qbuffer);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_io_dequantize, 22.11)
 int
 rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **qbuffer,
 		     struct rte_ml_buff_seg **dbuffer)
@@ -774,6 +806,7 @@ ml_op_init(struct rte_mempool *mempool, __rte_unused void *opaque_arg, void *_op
 	op->mempool = mempool;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_create, 22.11)
 struct rte_mempool *
 rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache_size,
 		      uint16_t user_size, int socket_id)
@@ -813,12 +846,14 @@ rte_ml_op_pool_create(const char *name, unsigned int nb_elts, unsigned int cache
 	return mp;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_pool_free, 22.11)
 void
 rte_ml_op_pool_free(struct rte_mempool *mempool)
 {
 	rte_mempool_free(mempool);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_enqueue_burst, 22.11)
 uint16_t
 rte_ml_enqueue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uint16_t nb_ops)
 {
@@ -855,6 +890,7 @@ rte_ml_enqueue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uin
 	return dev->enqueue_burst(dev, qp_id, ops, nb_ops);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dequeue_burst, 22.11)
 uint16_t
 rte_ml_dequeue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uint16_t nb_ops)
 {
@@ -891,6 +927,7 @@ rte_ml_dequeue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uin
 	return dev->dequeue_burst(dev, qp_id, ops, nb_ops);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_op_error_get, 22.11)
 int
 rte_ml_op_error_get(int16_t dev_id, struct rte_ml_op *op, struct rte_ml_op_error *error)
 {
@@ -922,4 +959,5 @@ rte_ml_op_error_get(int16_t dev_id, struct rte_ml_op *op, struct rte_ml_op_error
 	return dev->op_error_get(dev, op, error);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ml_dev_logtype, 22.11)
 RTE_LOG_REGISTER_DEFAULT(rte_ml_dev_logtype, INFO);
diff --git a/lib/mldev/rte_mldev_pmd.c b/lib/mldev/rte_mldev_pmd.c
index 3169e5d4fa..434360f2d3 100644
--- a/lib/mldev/rte_mldev_pmd.c
+++ b/lib/mldev/rte_mldev_pmd.c
@@ -3,11 +3,13 @@
  */
 
 #include <dev_driver.h>
+#include <eal_export.h>
 #include <rte_eal.h>
 #include <rte_malloc.h>
 
 #include "rte_mldev_pmd.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_create)
 struct rte_ml_dev *
 rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 		      struct rte_ml_dev_pmd_init_params *params)
@@ -42,6 +44,7 @@ rte_ml_dev_pmd_create(const char *name, struct rte_device *device,
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_destroy)
 int
 rte_ml_dev_pmd_destroy(struct rte_ml_dev *dev)
 {
diff --git a/lib/net/rte_arp.c b/lib/net/rte_arp.c
index 22af519586..3f8c69f69d 100644
--- a/lib/net/rte_arp.c
+++ b/lib/net/rte_arp.c
@@ -2,9 +2,11 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_arp.h>
 
 #define RARP_PKT_SIZE	64
+RTE_EXPORT_SYMBOL(rte_net_make_rarp_packet)
 struct rte_mbuf *
 rte_net_make_rarp_packet(struct rte_mempool *mpool,
 		const struct rte_ether_addr *mac)
diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index f59c20289d..6703145fc5 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -4,9 +4,11 @@
 
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_ether.h>
 #include <rte_errno.h>
 
+RTE_EXPORT_SYMBOL(rte_eth_random_addr)
 void
 rte_eth_random_addr(uint8_t *addr)
 {
@@ -18,6 +20,7 @@ rte_eth_random_addr(uint8_t *addr)
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
 
+RTE_EXPORT_SYMBOL(rte_ether_format_addr)
 void
 rte_ether_format_addr(char *buf, uint16_t size,
 		      const struct rte_ether_addr *eth_addr)
@@ -130,6 +133,7 @@ static unsigned int get_ether_sep(const char *s, char *sep)
  *  - Windows format six groups separated by hyphen
  *  - two groups hexadecimal digits
  */
+RTE_EXPORT_SYMBOL(rte_ether_unformat_addr)
 int
 rte_ether_unformat_addr(const char *s, struct rte_ether_addr *ea)
 {
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 0c32e78a13..be24690fdf 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -4,6 +4,7 @@
 
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_ptype.h>
 #include <rte_byteorder.h>
@@ -262,6 +263,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 }
 
 /* parse ipv6 extended headers, update offset and return next proto */
+RTE_EXPORT_SYMBOL(rte_net_skip_ip6_ext)
 int
 rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 	int *frag)
@@ -308,6 +310,7 @@ rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 }
 
 /* parse mbuf data to get packet type */
+RTE_EXPORT_SYMBOL(rte_net_get_ptype)
 uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	struct rte_net_hdr_lens *hdr_lens, uint32_t layers)
 {
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index b5a5dabd4f..a762c8eef0 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -5,6 +5,7 @@
 #include <stddef.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_cpuflags.h>
 #include <rte_common.h>
 #include <rte_net_crc.h>
@@ -419,6 +420,7 @@ MAP_STATIC_SYMBOL(struct rte_net_crc *rte_net_crc_set_alg(
 	enum rte_net_crc_alg alg, enum rte_net_crc_type type),
 	rte_net_crc_set_alg_v26);
 
+RTE_EXPORT_SYMBOL(rte_net_crc_free)
 void rte_net_crc_free(struct rte_net_crc *crc)
 {
 	rte_free(crc);
diff --git a/lib/node/ethdev_ctrl.c b/lib/node/ethdev_ctrl.c
index cd52e8be08..dca7e817f9 100644
--- a/lib/node/ethdev_ctrl.c
+++ b/lib/node/ethdev_ctrl.c
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_graph.h>
 
@@ -20,6 +21,7 @@ static struct ethdev_ctrl {
 	uint16_t nb_graphs;
 } ctrl;
 
+RTE_EXPORT_SYMBOL(rte_node_eth_config)
 int
 rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 		    uint16_t nb_graphs)
@@ -131,6 +133,7 @@ rte_node_eth_config(struct rte_node_ethdev_config *conf, uint16_t nb_confs,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ethdev_rx_next_update, 24.03)
 int
 rte_node_ethdev_rx_next_update(rte_node_t id, const char *edge_name)
 {
diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index 0b474cd2bc..604fcb267a 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -5,6 +5,7 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
@@ -119,6 +120,7 @@ ip4_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	return nb_objs;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_ip4_route_add)
 int
 rte_node_ip4_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
 		       enum rte_node_ip4_lookup_next next_node)
diff --git a/lib/node/ip4_reassembly.c b/lib/node/ip4_reassembly.c
index eb5f391114..493dafae9d 100644
--- a/lib/node/ip4_reassembly.c
+++ b/lib/node/ip4_reassembly.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <sys/socket.h>
 
+#include <eal_export.h>
 #include <rte_cycles.h>
 #include <rte_debug.h>
 #include <rte_ethdev.h>
@@ -127,6 +128,7 @@ ip4_reassembly_node_process(struct rte_graph *graph, struct rte_node *node, void
 	return idx;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_reassembly_configure, 23.11)
 int
 rte_node_ip4_reassembly_configure(struct rte_node_ip4_reassembly_cfg *cfg, uint16_t cnt)
 {
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index 34a920df5e..a9ab5eaa57 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
@@ -292,6 +293,7 @@ ip4_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_node_ip4_rewrite_add)
 int
 rte_node_ip4_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index f378d2d064..827fc2f379 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -5,6 +5,7 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
@@ -257,6 +258,7 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	return nb_objs;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_route_add, 23.07)
 int
 rte_node_ip6_route_add(const struct rte_ipv6_addr *ip, uint8_t depth, uint16_t next_hop,
 		       enum rte_node_ip6_lookup_next next_node)
diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index 198d8d8820..e157964c6a 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2023 Marvell.
  */
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
@@ -276,6 +277,7 @@ ip6_rewrite_set_next(uint16_t port_id, uint16_t next_index)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_rewrite_add, 23.07)
 int
 rte_node_ip6_rewrite_add(uint16_t next_hop, uint8_t *rewrite_data,
 			 uint8_t rewrite_len, uint16_t dst_port)
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index bbcb2c70e7..5a74e28c85 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -5,6 +5,7 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 
+#include <eal_export.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
@@ -55,6 +56,7 @@ static struct rte_hash_parameters udp4_params = {
 	.socket_id = 0,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_dst_port_add, 23.11)
 int
 rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 {
@@ -76,6 +78,7 @@ rte_node_udp4_dst_port_add(uint32_t dst_port, rte_edge_t next_node)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_udp4_usr_node_add, 23.11)
 int
 rte_node_udp4_usr_node_add(const char *usr_node)
 {
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b27cb..cacbefdc50 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -16,6 +16,7 @@
 #endif
 
 #include <bus_driver.h>
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <dev_driver.h>
@@ -199,6 +200,7 @@ pcapng_section_block(rte_pcapng_t *self,
 }
 
 /* Write an interface block for a DPDK port */
+RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 			 const char *ifname, const char *ifdescr,
@@ -320,6 +322,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
 /*
  * Write an Interface statistics block at the end of capture.
  */
+RTE_EXPORT_SYMBOL(rte_pcapng_write_stats)
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		       uint64_t ifrecv, uint64_t ifdrop,
@@ -385,6 +388,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	return write(self->outfd, buf, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
 uint32_t
 rte_pcapng_mbuf_size(uint32_t length)
 {
@@ -466,6 +470,7 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
  */
 
 /* Make a copy of original mbuf with pcapng header and options */
+RTE_EXPORT_SYMBOL(rte_pcapng_copy)
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *md,
@@ -607,6 +612,7 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 }
 
 /* Write pre-formatted packets to file. */
+RTE_EXPORT_SYMBOL(rte_pcapng_write_packets)
 ssize_t
 rte_pcapng_write_packets(rte_pcapng_t *self,
 			 struct rte_mbuf *pkts[], uint16_t nb_pkts)
@@ -676,6 +682,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 }
 
 /* Create new pcapng writer handle */
+RTE_EXPORT_SYMBOL(rte_pcapng_fdopen)
 rte_pcapng_t *
 rte_pcapng_fdopen(int fd,
 		  const char *osname, const char *hardware,
@@ -713,6 +720,7 @@ rte_pcapng_fdopen(int fd,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_pcapng_close)
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
diff --git a/lib/pci/rte_pci.c b/lib/pci/rte_pci.c
index 1c5ef951d3..e2f89a7f21 100644
--- a/lib/pci/rte_pci.c
+++ b/lib/pci/rte_pci.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_debug.h>
 
 #include "rte_pci.h"
@@ -92,6 +93,7 @@ pci_dbdf_parse(const char *input, struct rte_pci_addr *dev_addr)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_device_name)
 void
 rte_pci_device_name(const struct rte_pci_addr *addr,
 		char *output, size_t size)
@@ -102,6 +104,7 @@ rte_pci_device_name(const struct rte_pci_addr *addr,
 			    addr->devid, addr->function) >= 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_addr_cmp)
 int
 rte_pci_addr_cmp(const struct rte_pci_addr *addr,
 	     const struct rte_pci_addr *addr2)
@@ -124,6 +127,7 @@ rte_pci_addr_cmp(const struct rte_pci_addr *addr,
 		return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pci_addr_parse)
 int
 rte_pci_addr_parse(const char *str, struct rte_pci_addr *addr)
 {
diff --git a/lib/pdcp/rte_pdcp.c b/lib/pdcp/rte_pdcp.c
index 1c076fb448..d21df8ab43 100644
--- a/lib/pdcp/rte_pdcp.c
+++ b/lib/pdcp/rte_pdcp.c
@@ -4,6 +4,7 @@
 
 #include <stdalign.h>
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_pdcp.h>
 #include <rte_malloc.h>
@@ -97,6 +98,7 @@ pdcp_dl_establish(struct rte_pdcp_entity *entity, const struct rte_pdcp_entity_c
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_establish, 23.07)
 struct rte_pdcp_entity *
 rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf)
 {
@@ -197,6 +199,7 @@ pdcp_dl_release(struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 	return nb_out;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_release, 23.07)
 int
 rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *out_mb[])
 {
@@ -219,6 +222,7 @@ rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *ou
 	return nb_out;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_suspend, 23.07)
 int
 rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 			struct rte_mbuf *out_mb[])
@@ -246,6 +250,7 @@ rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 	return nb_out;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_control_pdu_create, 23.07)
 struct rte_mbuf *
 rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 			    enum rte_pdcp_ctrl_pdu_type type)
@@ -286,6 +291,7 @@ rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 	return m;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_t_reordering_expiry_handle, 23.07)
 uint16_t
 rte_pdcp_t_reordering_expiry_handle(const struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 {
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 0e6ffc167b..79b20ce59b 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_lcore.h>
@@ -417,6 +418,7 @@ pdump_server(const struct rte_mp_msg *mp_msg, const void *peer)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_init)
 int
 rte_pdump_init(void)
 {
@@ -439,6 +441,7 @@ rte_pdump_init(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_uninit)
 int
 rte_pdump_uninit(void)
 {
@@ -609,6 +612,7 @@ pdump_enable(uint16_t port, uint16_t queue,
 					    ENABLE, ring, mp, prm);
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_enable)
 int
 rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
 		 struct rte_ring *ring,
@@ -619,6 +623,7 @@ rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
 			    ring, mp, NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf)
 int
 rte_pdump_enable_bpf(uint16_t port, uint16_t queue,
 		     uint32_t flags, uint32_t snaplen,
@@ -653,6 +658,7 @@ pdump_enable_by_deviceid(const char *device_id, uint16_t queue,
 					    ENABLE, ring, mp, prm);
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_enable_by_deviceid)
 int
 rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
 			     uint32_t flags,
@@ -664,6 +670,7 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
 					ring, mp, NULL);
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_enable_bpf_by_deviceid)
 int
 rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
 				 uint32_t flags, uint32_t snaplen,
@@ -675,6 +682,7 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
 					ring, mp, prm);
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_disable)
 int
 rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags)
 {
@@ -694,6 +702,7 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_disable_by_deviceid)
 int
 rte_pdump_disable_by_deviceid(char *device_id, uint16_t queue,
 				uint32_t flags)
@@ -730,6 +739,7 @@ pdump_sum_stats(uint16_t port, uint16_t nq,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pdump_stats)
 int
 rte_pdump_stats(uint16_t port, struct rte_pdump_stats *stats)
 {
diff --git a/lib/pipeline/rte_pipeline.c b/lib/pipeline/rte_pipeline.c
index a09a89f746..072bd739a4 100644
--- a/lib/pipeline/rte_pipeline.c
+++ b/lib/pipeline/rte_pipeline.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
@@ -189,6 +190,7 @@ rte_pipeline_check_params(struct rte_pipeline_params *params)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_create)
 struct rte_pipeline *
 rte_pipeline_create(struct rte_pipeline_params *params)
 {
@@ -231,6 +233,7 @@ rte_pipeline_create(struct rte_pipeline_params *params)
 	return p;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_free)
 int
 rte_pipeline_free(struct rte_pipeline *p)
 {
@@ -324,6 +327,7 @@ rte_table_check_params(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_create)
 int
 rte_pipeline_table_create(struct rte_pipeline *p,
 		struct rte_pipeline_table_params *params,
@@ -395,6 +399,7 @@ rte_pipeline_table_free(struct rte_table *table)
 	rte_free(table->default_entry);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_add)
 int
 rte_pipeline_table_default_entry_add(struct rte_pipeline *p,
 	uint32_t table_id,
@@ -445,6 +450,7 @@ rte_pipeline_table_default_entry_add(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_default_entry_delete)
 int
 rte_pipeline_table_default_entry_delete(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -478,6 +484,7 @@ rte_pipeline_table_default_entry_delete(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add)
 int
 rte_pipeline_table_entry_add(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -539,6 +546,7 @@ rte_pipeline_table_entry_add(struct rte_pipeline *p,
 		key_found, (void **) entry_ptr);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete)
 int
 rte_pipeline_table_entry_delete(struct rte_pipeline *p,
 		uint32_t table_id,
@@ -578,6 +586,7 @@ rte_pipeline_table_entry_delete(struct rte_pipeline *p,
 	return (table->ops.f_delete)(table->h_table, key, key_found, entry);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_add_bulk)
 int rte_pipeline_table_entry_add_bulk(struct rte_pipeline *p,
 	uint32_t table_id,
 	void **keys,
@@ -644,6 +653,7 @@ int rte_pipeline_table_entry_add_bulk(struct rte_pipeline *p,
 		n_keys, key_found, (void **) entries_ptr);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_entry_delete_bulk)
 int rte_pipeline_table_entry_delete_bulk(struct rte_pipeline *p,
 	uint32_t table_id,
 	void **keys,
@@ -801,6 +811,7 @@ rte_pipeline_port_out_check_params(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_create)
 int
 rte_pipeline_port_in_create(struct rte_pipeline *p,
 		struct rte_pipeline_port_in_params *params,
@@ -851,6 +862,7 @@ rte_pipeline_port_in_free(struct rte_port_in *port)
 		port->ops.f_free(port->h_port);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_create)
 int
 rte_pipeline_port_out_create(struct rte_pipeline *p,
 		struct rte_pipeline_port_out_params *params,
@@ -898,6 +910,7 @@ rte_pipeline_port_out_free(struct rte_port_out *port)
 		port->ops.f_free(port->h_port);
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_connect_to_table)
 int
 rte_pipeline_port_in_connect_to_table(struct rte_pipeline *p,
 		uint32_t port_id,
@@ -932,6 +945,7 @@ rte_pipeline_port_in_connect_to_table(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_enable)
 int
 rte_pipeline_port_in_enable(struct rte_pipeline *p, uint32_t port_id)
 {
@@ -979,6 +993,7 @@ rte_pipeline_port_in_enable(struct rte_pipeline *p, uint32_t port_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_disable)
 int
 rte_pipeline_port_in_disable(struct rte_pipeline *p, uint32_t port_id)
 {
@@ -1034,6 +1049,7 @@ rte_pipeline_port_in_disable(struct rte_pipeline *p, uint32_t port_id)
 /*
  * Pipeline run-time
  */
+RTE_EXPORT_SYMBOL(rte_pipeline_check)
 int
 rte_pipeline_check(struct rte_pipeline *p)
 {
@@ -1307,6 +1323,7 @@ rte_pipeline_action_handler_drop(struct rte_pipeline *p, uint64_t pkts_mask)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_run)
 int
 rte_pipeline_run(struct rte_pipeline *p)
 {
@@ -1446,6 +1463,7 @@ rte_pipeline_run(struct rte_pipeline *p)
 	return (int) n_pkts;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_flush)
 int
 rte_pipeline_flush(struct rte_pipeline *p)
 {
@@ -1468,6 +1486,7 @@ rte_pipeline_flush(struct rte_pipeline *p)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_packet_insert)
 int
 rte_pipeline_port_out_packet_insert(struct rte_pipeline *p,
 	uint32_t port_id, struct rte_mbuf *pkt)
@@ -1479,6 +1498,7 @@ rte_pipeline_port_out_packet_insert(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_hijack)
 int rte_pipeline_ah_packet_hijack(struct rte_pipeline *p,
 	uint64_t pkts_mask)
 {
@@ -1488,6 +1508,7 @@ int rte_pipeline_ah_packet_hijack(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_ah_packet_drop)
 int rte_pipeline_ah_packet_drop(struct rte_pipeline *p,
 	uint64_t pkts_mask)
 {
@@ -1499,6 +1520,7 @@ int rte_pipeline_ah_packet_drop(struct rte_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_in_stats_read)
 int rte_pipeline_port_in_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	struct rte_pipeline_port_in_stats *stats, int clear)
 {
@@ -1536,6 +1558,7 @@ int rte_pipeline_port_in_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_port_out_stats_read)
 int rte_pipeline_port_out_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	struct rte_pipeline_port_out_stats *stats, int clear)
 {
@@ -1570,6 +1593,7 @@ int rte_pipeline_port_out_stats_read(struct rte_pipeline *p, uint32_t port_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pipeline_table_stats_read)
 int rte_pipeline_table_stats_read(struct rte_pipeline *p, uint32_t table_id,
 	struct rte_pipeline_table_stats *stats, int clear)
 {
diff --git a/lib/pipeline/rte_port_in_action.c b/lib/pipeline/rte_port_in_action.c
index 4127bd2cab..2378e64de9 100644
--- a/lib/pipeline/rte_port_in_action.c
+++ b/lib/pipeline/rte_port_in_action.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 
@@ -200,6 +201,7 @@ struct rte_port_in_action_profile {
 	int frozen;
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_create, 18.05)
 struct rte_port_in_action_profile *
 rte_port_in_action_profile_create(uint32_t socket_id)
 {
@@ -216,6 +218,7 @@ rte_port_in_action_profile_create(uint32_t socket_id)
 	return ap;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_action_register, 18.05)
 int
 rte_port_in_action_profile_action_register(struct rte_port_in_action_profile *profile,
 	enum rte_port_in_action_type type,
@@ -255,6 +258,7 @@ rte_port_in_action_profile_action_register(struct rte_port_in_action_profile *pr
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_freeze, 18.05)
 int
 rte_port_in_action_profile_freeze(struct rte_port_in_action_profile *profile)
 {
@@ -267,6 +271,7 @@ rte_port_in_action_profile_freeze(struct rte_port_in_action_profile *profile)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_profile_free, 18.05)
 int
 rte_port_in_action_profile_free(struct rte_port_in_action_profile *profile)
 {
@@ -315,6 +320,7 @@ action_data_init(struct rte_port_in_action *action,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_create, 18.05)
 struct rte_port_in_action *
 rte_port_in_action_create(struct rte_port_in_action_profile *profile,
 	uint32_t socket_id)
@@ -351,6 +357,7 @@ rte_port_in_action_create(struct rte_port_in_action_profile *profile,
 	return action;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_apply, 18.05)
 int
 rte_port_in_action_apply(struct rte_port_in_action *action,
 	enum rte_port_in_action_type type,
@@ -498,6 +505,7 @@ ah_selector(struct rte_port_in_action *action)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_params_get, 18.05)
 int
 rte_port_in_action_params_get(struct rte_port_in_action *action,
 	struct rte_pipeline_port_in_params *params)
@@ -518,6 +526,7 @@ rte_port_in_action_params_get(struct rte_port_in_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_in_action_free, 18.05)
 int
 rte_port_in_action_free(struct rte_port_in_action *action)
 {
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index 857770d297..7066450f57 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -8,6 +8,7 @@
 #include <sys/queue.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_byteorder.h>
 #include <rte_tailq.h>
@@ -1170,6 +1171,7 @@ static struct rte_tailq_elem rte_swx_ctl_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ctl_pipeline_tailq)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_find, 22.11)
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_find(const char *name)
 {
@@ -1249,6 +1251,7 @@ ctl_unregister(struct rte_swx_ctl_pipeline *ctl)
 	rte_mcfg_tailq_write_unlock();
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_free, 20.11)
 void
 rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -1271,6 +1274,7 @@ rte_swx_ctl_pipeline_free(struct rte_swx_ctl_pipeline *ctl)
 	free(ctl);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_create, 20.11)
 struct rte_swx_ctl_pipeline *
 rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 {
@@ -1549,6 +1553,7 @@ rte_swx_ctl_pipeline_create(struct rte_swx_pipeline *p)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_add, 20.11)
 int
 rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 				     const char *table_name,
@@ -1663,6 +1668,7 @@ rte_swx_ctl_pipeline_table_entry_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_delete, 20.11)
 int
 rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 					const char *table_name,
@@ -1753,6 +1759,7 @@ rte_swx_ctl_pipeline_table_entry_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_default_entry_add, 20.11)
 int
 rte_swx_ctl_pipeline_table_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					     const char *table_name,
@@ -2090,6 +2097,7 @@ table_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t table_id)
 	table_pending_default_free(table);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_add, 21.08)
 int
 rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 					const char *selector_name,
@@ -2117,6 +2125,7 @@ rte_swx_ctl_pipeline_selector_group_add(struct rte_swx_ctl_pipeline *ctl,
 	return -ENOSPC;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_delete, 21.08)
 int
 rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 					   const char *selector_name,
@@ -2168,6 +2177,7 @@ rte_swx_ctl_pipeline_selector_group_delete(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_add, 21.08)
 int
 rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *selector_name,
@@ -2227,6 +2237,7 @@ rte_swx_ctl_pipeline_selector_group_member_add(struct rte_swx_ctl_pipeline *ctl,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_group_member_delete, 21.08)
 int
 rte_swx_ctl_pipeline_selector_group_member_delete(struct rte_swx_ctl_pipeline *ctl,
 						  const char *selector_name,
@@ -2480,6 +2491,7 @@ learner_default_entry_duplicate(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_add, 21.11)
 int
 rte_swx_ctl_pipeline_learner_default_entry_add(struct rte_swx_ctl_pipeline *ctl,
 					       const char *learner_name,
@@ -2553,6 +2565,7 @@ learner_abort(struct rte_swx_ctl_pipeline *ctl, uint32_t learner_id)
 	learner_pending_default_free(l);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_commit, 20.11)
 int
 rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 {
@@ -2639,6 +2652,7 @@ rte_swx_ctl_pipeline_commit(struct rte_swx_ctl_pipeline *ctl, int abort_on_fail)
 	return status;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_abort, 20.11)
 void
 rte_swx_ctl_pipeline_abort(struct rte_swx_ctl_pipeline *ctl)
 {
@@ -2973,6 +2987,7 @@ token_is_comment(const char *token)
 
 #define RTE_SWX_CTL_ENTRY_TOKENS_MAX 256
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_entry_read, 20.11)
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 				      const char *table_name,
@@ -3172,6 +3187,7 @@ rte_swx_ctl_pipeline_table_entry_read(struct rte_swx_ctl_pipeline *ctl,
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_default_entry_read, 21.11)
 struct rte_swx_table_entry *
 rte_swx_ctl_pipeline_learner_default_entry_read(struct rte_swx_ctl_pipeline *ctl,
 						const char *learner_name,
@@ -3324,6 +3340,7 @@ table_entry_printf(FILE *f,
 	fprintf(f, "\n");
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_fprintf, 20.11)
 int
 rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 				   struct rte_swx_ctl_pipeline *ctl,
@@ -3374,6 +3391,7 @@ rte_swx_ctl_pipeline_table_fprintf(FILE *f,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_fprintf, 21.08)
 int
 rte_swx_ctl_pipeline_selector_fprintf(FILE *f,
 				      struct rte_swx_ctl_pipeline *ctl,
diff --git a/lib/pipeline/rte_swx_ipsec.c b/lib/pipeline/rte_swx_ipsec.c
index 17a9d2b98b..354754781d 100644
--- a/lib/pipeline/rte_swx_ipsec.c
+++ b/lib/pipeline/rte_swx_ipsec.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <arpa/inet.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_random.h>
 #include <rte_ip.h>
@@ -177,6 +178,7 @@ static struct rte_tailq_elem rte_swx_ipsec_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_ipsec_tailq)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_find, 23.03)
 struct rte_swx_ipsec *
 rte_swx_ipsec_find(const char *name)
 {
@@ -261,6 +263,7 @@ ipsec_unregister(struct rte_swx_ipsec *ipsec)
 static void
 ipsec_session_free(struct rte_swx_ipsec *ipsec, struct rte_ipsec_session *s);
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_free, 23.03)
 void
 rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 {
@@ -291,6 +294,7 @@ rte_swx_ipsec_free(struct rte_swx_ipsec *ipsec)
 	env_free(ipsec, ipsec->total_size);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_create, 23.03)
 int
 rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec_out,
 		     const char *name,
@@ -718,6 +722,7 @@ rte_swx_ipsec_post_crypto(struct rte_swx_ipsec *ipsec)
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_run, 23.03)
 void
 rte_swx_ipsec_run(struct rte_swx_ipsec *ipsec)
 {
@@ -1129,6 +1134,7 @@ do {                                   \
 	}                              \
 } while (0)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_read, 23.03)
 struct rte_swx_ipsec_sa_params *
 rte_swx_ipsec_sa_read(struct rte_swx_ipsec *ipsec __rte_unused,
 		      const char *string,
@@ -1762,6 +1768,7 @@ ipsec_session_free(struct rte_swx_ipsec *ipsec,
 	memset(s, 0, sizeof(*s));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_add, 23.03)
 int
 rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 		     struct rte_swx_ipsec_sa_params *sa_params,
@@ -1801,6 +1808,7 @@ rte_swx_ipsec_sa_add(struct rte_swx_ipsec *ipsec,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ipsec_sa_delete, 23.03)
 void
 rte_swx_ipsec_sa_delete(struct rte_swx_ipsec *ipsec,
 			uint32_t sa_id)
diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index 6ba86bee1f..2193bc4ebf 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <dlfcn.h>
 
+#include <eal_export.h>
 #include <rte_tailq.h>
 #include <rte_eal_memconfig.h>
 #include <rte_jhash.h>
@@ -121,6 +122,7 @@ struct_type_field_find(struct struct_type *st, const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_struct_type_register, 20.11)
 int
 rte_swx_pipeline_struct_type_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -252,6 +254,7 @@ port_in_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_type_register, 20.11)
 int
 rte_swx_pipeline_port_in_type_register(struct rte_swx_pipeline *p,
 				       const char *name,
@@ -295,6 +298,7 @@ port_in_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_in_config, 20.11)
 int
 rte_swx_pipeline_port_in_config(struct rte_swx_pipeline *p,
 				uint32_t port_id,
@@ -413,6 +417,7 @@ port_out_type_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_type_register, 20.11)
 int
 rte_swx_pipeline_port_out_type_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -458,6 +463,7 @@ port_out_find(struct rte_swx_pipeline *p, uint32_t port_id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_port_out_config, 20.11)
 int
 rte_swx_pipeline_port_out_config(struct rte_swx_pipeline *p,
 				 uint32_t port_id,
@@ -564,6 +570,7 @@ port_out_free(struct rte_swx_pipeline *p)
 /*
  * Packet mirroring.
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_mirroring_config, 20.11)
 int
 rte_swx_pipeline_mirroring_config(struct rte_swx_pipeline *p,
 				  struct rte_swx_pipeline_mirroring_params *params)
@@ -760,6 +767,7 @@ extern_obj_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_register, 20.11)
 int
 rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	const char *name,
@@ -800,6 +808,7 @@ rte_swx_pipeline_extern_type_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_type_member_func_register, 20.11)
 int
 rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	const char *extern_type_name,
@@ -837,6 +846,7 @@ rte_swx_pipeline_extern_type_member_func_register(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_object_config, 20.11)
 int
 rte_swx_pipeline_extern_object_config(struct rte_swx_pipeline *p,
 				      const char *extern_type_name,
@@ -1053,6 +1063,7 @@ extern_func_mailbox_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_extern_func_register, 20.11)
 int
 rte_swx_pipeline_extern_func_register(struct rte_swx_pipeline *p,
 				      const char *name,
@@ -1181,6 +1192,7 @@ hash_func_find(struct rte_swx_pipeline *p, const char *name)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_hash_func_register, 22.07)
 int
 rte_swx_pipeline_hash_func_register(struct rte_swx_pipeline *p,
 				    const char *name,
@@ -1281,6 +1293,7 @@ rss_find_by_id(struct rte_swx_pipeline *p, uint32_t rss_obj_id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_rss_config, 23.03)
 int
 rte_swx_pipeline_rss_config(struct rte_swx_pipeline *p, const char *name)
 {
@@ -1458,6 +1471,7 @@ header_field_parse(struct rte_swx_pipeline *p,
 	return f;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_header_register, 20.11)
 int
 rte_swx_pipeline_packet_header_register(struct rte_swx_pipeline *p,
 					const char *name,
@@ -1596,6 +1610,7 @@ metadata_field_parse(struct rte_swx_pipeline *p, const char *name)
 	return struct_type_field_find(p->metadata_st, &name[2]);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_packet_metadata_register, 20.11)
 int
 rte_swx_pipeline_packet_metadata_register(struct rte_swx_pipeline *p,
 					  const char *struct_type_name)
@@ -7855,6 +7870,7 @@ action_does_learning(struct action *a)
 	return 0; /* FALSE */
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_action_config, 20.11)
 int
 rte_swx_pipeline_action_config(struct rte_swx_pipeline *p,
 			       const char *name,
@@ -8219,6 +8235,7 @@ table_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_type_register, 20.11)
 int
 rte_swx_pipeline_table_type_register(struct rte_swx_pipeline *p,
 				     const char *name,
@@ -8388,6 +8405,7 @@ table_match_fields_check(struct rte_swx_pipeline *p,
 	return status;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_config, 20.11)
 int
 rte_swx_pipeline_table_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -8891,6 +8909,7 @@ selector_fields_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_selector_config, 21.08)
 int
 rte_swx_pipeline_selector_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -9363,6 +9382,7 @@ learner_action_learning_check(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_learner_config, 21.11)
 int
 rte_swx_pipeline_learner_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -9936,6 +9956,7 @@ regarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_regarray_config, 21.05)
 int
 rte_swx_pipeline_regarray_config(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -10074,6 +10095,7 @@ metarray_find_by_id(struct rte_swx_pipeline *p, uint32_t id)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_metarray_config, 21.05)
 int
 rte_swx_pipeline_metarray_config(struct rte_swx_pipeline *p,
 				 const char *name,
@@ -10224,6 +10246,7 @@ static struct rte_tailq_elem rte_swx_pipeline_tailq = {
 
 EAL_REGISTER_TAILQ(rte_swx_pipeline_tailq)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_find, 22.11)
 struct rte_swx_pipeline *
 rte_swx_pipeline_find(const char *name)
 {
@@ -10303,6 +10326,7 @@ pipeline_unregister(struct rte_swx_pipeline *p)
 	rte_mcfg_tailq_write_unlock();
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_free, 20.11)
 void
 rte_swx_pipeline_free(struct rte_swx_pipeline *p)
 {
@@ -10448,6 +10472,7 @@ hash_funcs_register(struct rte_swx_pipeline *p)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_config, 20.11)
 int
 rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_node)
 {
@@ -10524,6 +10549,7 @@ rte_swx_pipeline_config(struct rte_swx_pipeline **p, const char *name, int numa_
 	return status;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_instructions_config, 20.11)
 int
 rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 				     const char **instructions,
@@ -10546,6 +10572,7 @@ rte_swx_pipeline_instructions_config(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build, 20.11)
 int
 rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 {
@@ -10664,6 +10691,7 @@ rte_swx_pipeline_build(struct rte_swx_pipeline *p)
 	return status;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_run, 20.11)
 void
 rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 {
@@ -10673,6 +10701,7 @@ rte_swx_pipeline_run(struct rte_swx_pipeline *p, uint32_t n_instructions)
 		instr_exec(p);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_flush, 20.11)
 void
 rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 {
@@ -10689,6 +10718,7 @@ rte_swx_pipeline_flush(struct rte_swx_pipeline *p)
 /*
  * Control.
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_info_get, 20.11)
 int
 rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 			      struct rte_swx_ctl_pipeline_info *pipeline)
@@ -10722,6 +10752,7 @@ rte_swx_ctl_pipeline_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_numa_node_get, 20.11)
 int
 rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 {
@@ -10732,6 +10763,7 @@ rte_swx_ctl_pipeline_numa_node_get(struct rte_swx_pipeline *p, int *numa_node)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_info_get, 20.11)
 int
 rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 			    uint32_t action_id,
@@ -10751,6 +10783,7 @@ rte_swx_ctl_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_action_arg_info_get, 20.11)
 int
 rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 				uint32_t action_id,
@@ -10775,6 +10808,7 @@ rte_swx_ctl_action_arg_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_info_get, 20.11)
 int
 rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 			   uint32_t table_id,
@@ -10799,6 +10833,7 @@ rte_swx_ctl_table_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_match_field_info_get, 20.11)
 int
 rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10824,6 +10859,7 @@ rte_swx_ctl_table_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_action_info_get, 20.11)
 int
 rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	uint32_t table_id,
@@ -10847,6 +10883,7 @@ rte_swx_ctl_table_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_table_ops_get, 20.11)
 int
 rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 			  uint32_t table_id,
@@ -10873,6 +10910,7 @@ rte_swx_ctl_table_ops_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_info_get, 21.08)
 int
 rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 			      uint32_t selector_id,
@@ -10896,6 +10934,7 @@ rte_swx_ctl_selector_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_group_id_field_info_get, 21.08)
 int
 rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10918,6 +10957,7 @@ rte_swx_ctl_selector_group_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_field_info_get, 21.08)
 int
 rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10943,6 +10983,7 @@ rte_swx_ctl_selector_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_selector_member_id_field_info_get, 21.08)
 int
 rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	 uint32_t selector_id,
@@ -10965,6 +11006,7 @@ rte_swx_ctl_selector_member_id_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_info_get, 21.11)
 int
 rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 			     uint32_t learner_id,
@@ -10990,6 +11032,7 @@ rte_swx_ctl_learner_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_match_field_info_get, 21.11)
 int
 rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11015,6 +11058,7 @@ rte_swx_ctl_learner_match_field_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_learner_action_info_get, 21.11)
 int
 rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 				    uint32_t learner_id,
@@ -11041,6 +11085,7 @@ rte_swx_ctl_learner_action_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_get, 22.07)
 int
 rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11060,6 +11105,7 @@ rte_swx_ctl_pipeline_learner_timeout_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_timeout_set, 22.07)
 int
 rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 					 uint32_t learner_id,
@@ -11091,6 +11137,7 @@ rte_swx_ctl_pipeline_learner_timeout_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_get, 20.11)
 int
 rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state **table_state)
@@ -11102,6 +11149,7 @@ rte_swx_pipeline_table_state_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_table_state_set, 20.11)
 int
 rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 				 struct rte_swx_table_state *table_state)
@@ -11113,6 +11161,7 @@ rte_swx_pipeline_table_state_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_in_stats_read, 20.11)
 int
 rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 					uint32_t port_id,
@@ -11131,6 +11180,7 @@ rte_swx_ctl_pipeline_port_in_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_port_out_stats_read, 20.11)
 int
 rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 					 uint32_t port_id,
@@ -11149,6 +11199,7 @@ rte_swx_ctl_pipeline_port_out_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_table_stats_read, 21.05)
 int
 rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 				      const char *table_name,
@@ -11176,6 +11227,7 @@ rte_swx_ctl_pipeline_table_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_selector_stats_read, 21.08)
 int
 rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	const char *selector_name,
@@ -11195,6 +11247,7 @@ rte_swx_ctl_pipeline_selector_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_learner_stats_read, 21.11)
 int
 rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 					const char *learner_name,
@@ -11228,6 +11281,7 @@ rte_swx_ctl_pipeline_learner_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_regarray_info_get, 21.05)
 int
 rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t regarray_id,
@@ -11247,6 +11301,7 @@ rte_swx_ctl_regarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read, 21.05)
 int
 rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11268,6 +11323,7 @@ rte_swx_ctl_pipeline_regarray_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write, 21.05)
 int
 rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 				   const char *regarray_name,
@@ -11289,6 +11345,7 @@ rte_swx_ctl_pipeline_regarray_write(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_metarray_info_get, 21.05)
 int
 rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 			      uint32_t metarray_id,
@@ -11308,6 +11365,7 @@ rte_swx_ctl_metarray_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_add, 21.05)
 int
 rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 			      const char *name,
@@ -11340,6 +11398,7 @@ rte_swx_ctl_meter_profile_add(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_profile_delete, 21.05)
 int
 rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 				 const char *name)
@@ -11360,6 +11419,7 @@ rte_swx_ctl_meter_profile_delete(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset, 21.05)
 int
 rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 			const char *metarray_name,
@@ -11388,6 +11448,7 @@ rte_swx_ctl_meter_reset(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set, 21.05)
 int
 rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 		      const char *metarray_name,
@@ -11424,6 +11485,7 @@ rte_swx_ctl_meter_set(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read, 21.05)
 int
 rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 			     const char *metarray_name,
@@ -11452,6 +11514,7 @@ rte_swx_ctl_meter_stats_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_mirroring_session_set, 20.11)
 int
 rte_swx_ctl_pipeline_mirroring_session_set(struct rte_swx_pipeline *p,
 					   uint32_t session_id,
@@ -11658,6 +11721,7 @@ rte_swx_ctl_pipeline_table_entry_id_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_read_with_key, 22.11)
 int
 rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 					    const char *regarray_name,
@@ -11675,6 +11739,7 @@ rte_swx_ctl_pipeline_regarray_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_read(p, regarray_name, entry_id, value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_regarray_write_with_key, 22.11)
 int
 rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 					     const char *regarray_name,
@@ -11692,6 +11757,7 @@ rte_swx_ctl_pipeline_regarray_write_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_pipeline_regarray_write(p, regarray_name, entry_id, value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_reset_with_key, 22.11)
 int
 rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 				 const char *metarray_name,
@@ -11708,6 +11774,7 @@ rte_swx_ctl_meter_reset_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_reset(p, metarray_name, entry_id);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_set_with_key, 22.11)
 int
 rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 			       const char *metarray_name,
@@ -11725,6 +11792,7 @@ rte_swx_ctl_meter_set_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_set(p, metarray_name, entry_id, profile_name);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_meter_stats_read_with_key, 22.11)
 int
 rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 				      const char *metarray_name,
@@ -11742,6 +11810,7 @@ rte_swx_ctl_meter_stats_read_with_key(struct rte_swx_pipeline *p,
 	return rte_swx_ctl_meter_stats_read(p, metarray_name, entry_id, stats);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_rss_info_get, 23.03)
 int
 rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 			 uint32_t rss_obj_id,
@@ -11762,6 +11831,7 @@ rte_swx_ctl_rss_info_get(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_size_read, 23.03)
 int
 rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 				       const char *rss_name,
@@ -11786,6 +11856,7 @@ rte_swx_ctl_pipeline_rss_key_size_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_read, 23.03)
 int
 rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 				  const char *rss_name,
@@ -11810,6 +11881,7 @@ rte_swx_ctl_pipeline_rss_key_read(struct rte_swx_pipeline *p,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_ctl_pipeline_rss_key_write, 23.03)
 int
 rte_swx_ctl_pipeline_rss_key_write(struct rte_swx_pipeline *p,
 				   const char *rss_name,
@@ -14512,6 +14584,7 @@ pipeline_adjust(struct rte_swx_pipeline *p, struct instruction_group_list *igl)
 	instr_jmp_resolve(p->instructions, p->instruction_data, p->n_instructions);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_codegen, 22.11)
 int
 rte_swx_pipeline_codegen(FILE *spec_file,
 			 FILE *code_file,
@@ -14605,6 +14678,7 @@ rte_swx_pipeline_codegen(FILE *spec_file,
 	return status;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_pipeline_build_from_lib, 22.11)
 int
 rte_swx_pipeline_build_from_lib(struct rte_swx_pipeline **pipeline,
 				const char *name,
diff --git a/lib/pipeline/rte_table_action.c b/lib/pipeline/rte_table_action.c
index 3a408e81b8..c990d7eb56 100644
--- a/lib/pipeline/rte_table_action.c
+++ b/lib/pipeline/rte_table_action.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_byteorder.h>
 #include <rte_cycles.h>
@@ -2362,6 +2363,7 @@ struct rte_table_action_profile {
 	int frozen;
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_create, 18.05)
 struct rte_table_action_profile *
 rte_table_action_profile_create(struct rte_table_action_common_config *common)
 {
@@ -2383,6 +2385,7 @@ rte_table_action_profile_create(struct rte_table_action_common_config *common)
 }
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_action_register, 18.05)
 int
 rte_table_action_profile_action_register(struct rte_table_action_profile *profile,
 	enum rte_table_action_type type,
@@ -2446,6 +2449,7 @@ rte_table_action_profile_action_register(struct rte_table_action_profile *profil
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_freeze, 18.05)
 int
 rte_table_action_profile_freeze(struct rte_table_action_profile *profile)
 {
@@ -2459,6 +2463,7 @@ rte_table_action_profile_freeze(struct rte_table_action_profile *profile)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_profile_free, 18.05)
 int
 rte_table_action_profile_free(struct rte_table_action_profile *profile)
 {
@@ -2481,6 +2486,7 @@ struct rte_table_action {
 	struct meter_profile_data mp[METER_PROFILES_MAX];
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_create, 18.05)
 struct rte_table_action *
 rte_table_action_create(struct rte_table_action_profile *profile,
 	uint32_t socket_id)
@@ -2518,6 +2524,7 @@ action_data_get(void *data,
 	return &data_bytes[offset];
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_apply, 18.05)
 int
 rte_table_action_apply(struct rte_table_action *action,
 	void *data,
@@ -2599,6 +2606,7 @@ rte_table_action_apply(struct rte_table_action *action,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_dscp_table_update, 18.05)
 int
 rte_table_action_dscp_table_update(struct rte_table_action *action,
 	uint64_t dscp_mask,
@@ -2631,6 +2639,7 @@ rte_table_action_dscp_table_update(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_add, 18.05)
 int
 rte_table_action_meter_profile_add(struct rte_table_action *action,
 	uint32_t meter_profile_id,
@@ -2671,6 +2680,7 @@ rte_table_action_meter_profile_add(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_profile_delete, 18.05)
 int
 rte_table_action_meter_profile_delete(struct rte_table_action *action,
 	uint32_t meter_profile_id)
@@ -2694,6 +2704,7 @@ rte_table_action_meter_profile_delete(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_meter_read, 18.05)
 int
 rte_table_action_meter_read(struct rte_table_action *action,
 	void *data,
@@ -2756,6 +2767,7 @@ rte_table_action_meter_read(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_ttl_read, 18.05)
 int
 rte_table_action_ttl_read(struct rte_table_action *action,
 	void *data,
@@ -2784,6 +2796,7 @@ rte_table_action_ttl_read(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_stats_read, 18.05)
 int
 rte_table_action_stats_read(struct rte_table_action *action,
 	void *data,
@@ -2819,6 +2832,7 @@ rte_table_action_stats_read(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_time_read, 18.05)
 int
 rte_table_action_time_read(struct rte_table_action *action,
 	void *data,
@@ -2842,6 +2856,7 @@ rte_table_action_time_read(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_crypto_sym_session_get, 18.11)
 struct rte_cryptodev_sym_session *
 rte_table_action_crypto_sym_session_get(struct rte_table_action *action,
 	void *data)
@@ -3429,6 +3444,7 @@ ah_selector(struct rte_table_action *action)
 	return ah_default;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_table_params_get, 18.05)
 int
 rte_table_action_table_params_get(struct rte_table_action *action,
 	struct rte_pipeline_table_params *params)
@@ -3454,6 +3470,7 @@ rte_table_action_table_params_get(struct rte_table_action *action,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_table_action_free, 18.05)
 int
 rte_table_action_free(struct rte_table_action *action)
 {
diff --git a/lib/port/rte_port_ethdev.c b/lib/port/rte_port_ethdev.c
index d57f680e98..bdab2fbf6c 100644
--- a/lib/port/rte_port_ethdev.c
+++ b/lib/port/rte_port_ethdev.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
@@ -500,6 +501,7 @@ static int rte_port_ethdev_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_ethdev_reader_ops)
 struct rte_port_in_ops rte_port_ethdev_reader_ops = {
 	.f_create = rte_port_ethdev_reader_create,
 	.f_free = rte_port_ethdev_reader_free,
@@ -507,6 +509,7 @@ struct rte_port_in_ops rte_port_ethdev_reader_ops = {
 	.f_stats = rte_port_ethdev_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_ops)
 struct rte_port_out_ops rte_port_ethdev_writer_ops = {
 	.f_create = rte_port_ethdev_writer_create,
 	.f_free = rte_port_ethdev_writer_free,
@@ -516,6 +519,7 @@ struct rte_port_out_ops rte_port_ethdev_writer_ops = {
 	.f_stats = rte_port_ethdev_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ethdev_writer_nodrop_ops)
 struct rte_port_out_ops rte_port_ethdev_writer_nodrop_ops = {
 	.f_create = rte_port_ethdev_writer_nodrop_create,
 	.f_free = rte_port_ethdev_writer_nodrop_free,
diff --git a/lib/port/rte_port_eventdev.c b/lib/port/rte_port_eventdev.c
index 6acf22998d..c3a287b834 100644
--- a/lib/port/rte_port_eventdev.c
+++ b/lib/port/rte_port_eventdev.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 
@@ -560,6 +561,7 @@ static int rte_port_eventdev_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_reader_ops, 19.11)
 struct rte_port_in_ops rte_port_eventdev_reader_ops = {
 	.f_create = rte_port_eventdev_reader_create,
 	.f_free = rte_port_eventdev_reader_free,
@@ -567,6 +569,7 @@ struct rte_port_in_ops rte_port_eventdev_reader_ops = {
 	.f_stats = rte_port_eventdev_reader_stats_read,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_ops, 19.11)
 struct rte_port_out_ops rte_port_eventdev_writer_ops = {
 	.f_create = rte_port_eventdev_writer_create,
 	.f_free = rte_port_eventdev_writer_free,
@@ -576,6 +579,7 @@ struct rte_port_out_ops rte_port_eventdev_writer_ops = {
 	.f_stats = rte_port_eventdev_writer_stats_read,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_port_eventdev_writer_nodrop_ops, 19.11)
 struct rte_port_out_ops rte_port_eventdev_writer_nodrop_ops = {
 	.f_create = rte_port_eventdev_writer_nodrop_create,
 	.f_free = rte_port_eventdev_writer_nodrop_free,
diff --git a/lib/port/rte_port_fd.c b/lib/port/rte_port_fd.c
index 281cba20c2..dbc9efef1b 100644
--- a/lib/port/rte_port_fd.c
+++ b/lib/port/rte_port_fd.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 
@@ -494,6 +495,7 @@ static int rte_port_fd_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_fd_reader_ops)
 struct rte_port_in_ops rte_port_fd_reader_ops = {
 	.f_create = rte_port_fd_reader_create,
 	.f_free = rte_port_fd_reader_free,
@@ -501,6 +503,7 @@ struct rte_port_in_ops rte_port_fd_reader_ops = {
 	.f_stats = rte_port_fd_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_fd_writer_ops)
 struct rte_port_out_ops rte_port_fd_writer_ops = {
 	.f_create = rte_port_fd_writer_create,
 	.f_free = rte_port_fd_writer_free,
@@ -510,6 +513,7 @@ struct rte_port_out_ops rte_port_fd_writer_ops = {
 	.f_stats = rte_port_fd_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_fd_writer_nodrop_ops)
 struct rte_port_out_ops rte_port_fd_writer_nodrop_ops = {
 	.f_create = rte_port_fd_writer_nodrop_create,
 	.f_free = rte_port_fd_writer_nodrop_free,
diff --git a/lib/port/rte_port_frag.c b/lib/port/rte_port_frag.c
index 0940f945bd..9444f5939c 100644
--- a/lib/port/rte_port_frag.c
+++ b/lib/port/rte_port_frag.c
@@ -3,6 +3,7 @@
  */
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_ip_frag.h>
 
 #include "rte_port_frag.h"
@@ -262,6 +263,7 @@ rte_port_frag_reader_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv4_frag_ops)
 struct rte_port_in_ops rte_port_ring_reader_ipv4_frag_ops = {
 	.f_create = rte_port_ring_reader_ipv4_frag_create,
 	.f_free = rte_port_ring_reader_frag_free,
@@ -269,6 +271,7 @@ struct rte_port_in_ops rte_port_ring_reader_ipv4_frag_ops = {
 	.f_stats = rte_port_frag_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ipv6_frag_ops)
 struct rte_port_in_ops rte_port_ring_reader_ipv6_frag_ops = {
 	.f_create = rte_port_ring_reader_ipv6_frag_create,
 	.f_free = rte_port_ring_reader_frag_free,
diff --git a/lib/port/rte_port_ras.c b/lib/port/rte_port_ras.c
index 42cf1ddf45..58ab7a1c5b 100644
--- a/lib/port/rte_port_ras.c
+++ b/lib/port/rte_port_ras.c
@@ -3,6 +3,7 @@
  */
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_ip_frag.h>
 #include <rte_cycles.h>
 #include <rte_log.h>
@@ -314,6 +315,7 @@ rte_port_ras_writer_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv4_ras_ops)
 struct rte_port_out_ops rte_port_ring_writer_ipv4_ras_ops = {
 	.f_create = rte_port_ring_writer_ipv4_ras_create,
 	.f_free = rte_port_ring_writer_ras_free,
@@ -323,6 +325,7 @@ struct rte_port_out_ops rte_port_ring_writer_ipv4_ras_ops = {
 	.f_stats = rte_port_ras_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ipv6_ras_ops)
 struct rte_port_out_ops rte_port_ring_writer_ipv6_ras_ops = {
 	.f_create = rte_port_ring_writer_ipv6_ras_create,
 	.f_free = rte_port_ring_writer_ras_free,
diff --git a/lib/port/rte_port_ring.c b/lib/port/rte_port_ring.c
index 680d208f45..307a576d65 100644
--- a/lib/port/rte_port_ring.c
+++ b/lib/port/rte_port_ring.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_ring.h>
 #include <rte_malloc.h>
@@ -738,6 +739,7 @@ rte_port_ring_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_ring_reader_ops)
 struct rte_port_in_ops rte_port_ring_reader_ops = {
 	.f_create = rte_port_ring_reader_create,
 	.f_free = rte_port_ring_reader_free,
@@ -745,6 +747,7 @@ struct rte_port_in_ops rte_port_ring_reader_ops = {
 	.f_stats = rte_port_ring_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_ops)
 struct rte_port_out_ops rte_port_ring_writer_ops = {
 	.f_create = rte_port_ring_writer_create,
 	.f_free = rte_port_ring_writer_free,
@@ -754,6 +757,7 @@ struct rte_port_out_ops rte_port_ring_writer_ops = {
 	.f_stats = rte_port_ring_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_writer_nodrop_ops)
 struct rte_port_out_ops rte_port_ring_writer_nodrop_ops = {
 	.f_create = rte_port_ring_writer_nodrop_create,
 	.f_free = rte_port_ring_writer_nodrop_free,
@@ -763,6 +767,7 @@ struct rte_port_out_ops rte_port_ring_writer_nodrop_ops = {
 	.f_stats = rte_port_ring_writer_nodrop_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_reader_ops)
 struct rte_port_in_ops rte_port_ring_multi_reader_ops = {
 	.f_create = rte_port_ring_multi_reader_create,
 	.f_free = rte_port_ring_reader_free,
@@ -770,6 +775,7 @@ struct rte_port_in_ops rte_port_ring_multi_reader_ops = {
 	.f_stats = rte_port_ring_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_ops)
 struct rte_port_out_ops rte_port_ring_multi_writer_ops = {
 	.f_create = rte_port_ring_multi_writer_create,
 	.f_free = rte_port_ring_writer_free,
@@ -779,6 +785,7 @@ struct rte_port_out_ops rte_port_ring_multi_writer_ops = {
 	.f_stats = rte_port_ring_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_ring_multi_writer_nodrop_ops)
 struct rte_port_out_ops rte_port_ring_multi_writer_nodrop_ops = {
 	.f_create = rte_port_ring_multi_writer_nodrop_create,
 	.f_free = rte_port_ring_writer_nodrop_free,
diff --git a/lib/port/rte_port_sched.c b/lib/port/rte_port_sched.c
index da7a6240d7..3091078aa1 100644
--- a/lib/port/rte_port_sched.c
+++ b/lib/port/rte_port_sched.c
@@ -3,6 +3,7 @@
  */
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 
 #include "rte_port_sched.h"
@@ -278,6 +279,7 @@ rte_port_sched_writer_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_sched_reader_ops)
 struct rte_port_in_ops rte_port_sched_reader_ops = {
 	.f_create = rte_port_sched_reader_create,
 	.f_free = rte_port_sched_reader_free,
@@ -285,6 +287,7 @@ struct rte_port_in_ops rte_port_sched_reader_ops = {
 	.f_stats = rte_port_sched_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_sched_writer_ops)
 struct rte_port_out_ops rte_port_sched_writer_ops = {
 	.f_create = rte_port_sched_writer_create,
 	.f_free = rte_port_sched_writer_free,
diff --git a/lib/port/rte_port_source_sink.c b/lib/port/rte_port_source_sink.c
index a4486a7199..0557e12506 100644
--- a/lib/port/rte_port_source_sink.c
+++ b/lib/port/rte_port_source_sink.c
@@ -4,6 +4,7 @@
 #include <stdint.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
@@ -596,6 +597,7 @@ rte_port_sink_stats_read(void *port, struct rte_port_out_stats *stats,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_source_ops)
 struct rte_port_in_ops rte_port_source_ops = {
 	.f_create = rte_port_source_create,
 	.f_free = rte_port_source_free,
@@ -603,6 +605,7 @@ struct rte_port_in_ops rte_port_source_ops = {
 	.f_stats = rte_port_source_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_sink_ops)
 struct rte_port_out_ops rte_port_sink_ops = {
 	.f_create = rte_port_sink_create,
 	.f_free = rte_port_sink_free,
diff --git a/lib/port/rte_port_sym_crypto.c b/lib/port/rte_port_sym_crypto.c
index a68a2396a5..30c9d1283e 100644
--- a/lib/port/rte_port_sym_crypto.c
+++ b/lib/port/rte_port_sym_crypto.c
@@ -3,6 +3,7 @@
  */
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 
@@ -528,6 +529,7 @@ static int rte_port_sym_crypto_writer_nodrop_stats_read(void *port,
 /*
  * Summary of port operations
  */
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_reader_ops)
 struct rte_port_in_ops rte_port_sym_crypto_reader_ops = {
 	.f_create = rte_port_sym_crypto_reader_create,
 	.f_free = rte_port_sym_crypto_reader_free,
@@ -535,6 +537,7 @@ struct rte_port_in_ops rte_port_sym_crypto_reader_ops = {
 	.f_stats = rte_port_sym_crypto_reader_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_ops)
 struct rte_port_out_ops rte_port_sym_crypto_writer_ops = {
 	.f_create = rte_port_sym_crypto_writer_create,
 	.f_free = rte_port_sym_crypto_writer_free,
@@ -544,6 +547,7 @@ struct rte_port_out_ops rte_port_sym_crypto_writer_ops = {
 	.f_stats = rte_port_sym_crypto_writer_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_port_sym_crypto_writer_nodrop_ops)
 struct rte_port_out_ops rte_port_sym_crypto_writer_nodrop_ops = {
 	.f_create = rte_port_sym_crypto_writer_nodrop_create,
 	.f_free = rte_port_sym_crypto_writer_nodrop_free,
diff --git a/lib/port/rte_swx_port_ethdev.c b/lib/port/rte_swx_port_ethdev.c
index 7cb3c4dfb1..de6d0e5bb3 100644
--- a/lib/port/rte_swx_port_ethdev.c
+++ b/lib/port/rte_swx_port_ethdev.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_hexdump.h>
@@ -401,6 +402,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_reader_ops, 20.11)
 struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -408,6 +410,7 @@ struct rte_swx_port_in_ops rte_swx_port_ethdev_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ethdev_writer_ops, 20.11)
 struct rte_swx_port_out_ops rte_swx_port_ethdev_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_fd.c b/lib/port/rte_swx_port_fd.c
index 4bbad2eaa7..72783d2b0f 100644
--- a/lib/port/rte_swx_port_fd.c
+++ b/lib/port/rte_swx_port_fd.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_hexdump.h>
 
@@ -344,6 +345,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_reader_ops, 21.05)
 struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -351,6 +353,7 @@ struct rte_swx_port_in_ops rte_swx_port_fd_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_fd_writer_ops, 21.05)
 struct rte_swx_port_out_ops rte_swx_port_fd_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_ring.c b/lib/port/rte_swx_port_ring.c
index af541a2fa2..3ac652ac09 100644
--- a/lib/port/rte_swx_port_ring.c
+++ b/lib/port/rte_swx_port_ring.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_ring.h>
 #include <rte_hexdump.h>
@@ -406,6 +407,7 @@ writer_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_reader_ops, 21.05)
 struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.create = reader_create,
 	.free = reader_free,
@@ -413,6 +415,7 @@ struct rte_swx_port_in_ops rte_swx_port_ring_reader_ops = {
 	.stats_read = reader_stats_read,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_ring_writer_ops, 21.05)
 struct rte_swx_port_out_ops rte_swx_port_ring_writer_ops = {
 	.create = writer_create,
 	.free = writer_free,
diff --git a/lib/port/rte_swx_port_source_sink.c b/lib/port/rte_swx_port_source_sink.c
index 757a2c4a2e..af8b9ec68d 100644
--- a/lib/port/rte_swx_port_source_sink.c
+++ b/lib/port/rte_swx_port_source_sink.c
@@ -9,6 +9,7 @@
 #endif
 #include <sys/time.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_hexdump.h>
@@ -201,6 +202,7 @@ source_stats_read(void *port, struct rte_swx_port_in_stats *stats)
 	memcpy(stats, &p->stats, sizeof(p->stats));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = source_create,
 	.free = source_free,
@@ -210,6 +212,7 @@ struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 
 #else
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_source_ops, 20.11)
 struct rte_swx_port_in_ops rte_swx_port_source_ops = {
 	.create = NULL,
 	.free = NULL,
@@ -380,6 +383,7 @@ sink_stats_read(void *port, struct rte_swx_port_out_stats *stats)
 /*
  * Summary of port operations
  */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_port_sink_ops, 20.11)
 struct rte_swx_port_out_ops rte_swx_port_sink_ops = {
 	.create = sink_create,
 	.free = sink_free,
diff --git a/lib/power/power_common.c b/lib/power/power_common.c
index e482f71c64..2da034e9d0 100644
--- a/lib/power/power_common.c
+++ b/lib/power/power_common.c
@@ -7,12 +7,14 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
 #include <rte_lcore.h>
 
 #include "power_common.h"
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_logtype)
 RTE_LOG_REGISTER_DEFAULT(rte_power_logtype, INFO);
 
 #define POWER_SYSFILE_SCALING_DRIVER   \
@@ -21,6 +23,7 @@ RTE_LOG_REGISTER_DEFAULT(rte_power_logtype, INFO);
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_governor"
 #define POWER_CONVERT_TO_DECIMAL 10
 
+RTE_EXPORT_INTERNAL_SYMBOL(cpufreq_check_scaling_driver)
 int
 cpufreq_check_scaling_driver(const char *driver_name)
 {
@@ -66,6 +69,7 @@ cpufreq_check_scaling_driver(const char *driver_name)
 	return 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(open_core_sysfs_file)
 int
 open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 {
@@ -84,6 +88,7 @@ open_core_sysfs_file(FILE **f, const char *mode, const char *format, ...)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_u32)
 int
 read_core_sysfs_u32(FILE *f, uint32_t *val)
 {
@@ -109,6 +114,7 @@ read_core_sysfs_u32(FILE *f, uint32_t *val)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(read_core_sysfs_s)
 int
 read_core_sysfs_s(FILE *f, char *buf, unsigned int len)
 {
@@ -127,6 +133,7 @@ read_core_sysfs_s(FILE *f, char *buf, unsigned int len)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(write_core_sysfs_s)
 int
 write_core_sysfs_s(FILE *f, const char *str)
 {
@@ -153,6 +160,7 @@ write_core_sysfs_s(FILE *f, const char *str)
  * set it into 'performance' if it is not by writing the sys file. The original
  * governor will be saved for rolling back.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(power_set_governor)
 int
 power_set_governor(unsigned int lcore_id, const char *new_governor,
 		char *orig_governor, size_t orig_governor_len)
@@ -206,6 +214,7 @@ power_set_governor(unsigned int lcore_id, const char *new_governor,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(power_get_lcore_mapped_cpu_id)
 int power_get_lcore_mapped_cpu_id(uint32_t lcore_id, uint32_t *cpu_id)
 {
 	rte_cpuset_t lcore_cpus;
diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index 3576017239..d4db03a4e5 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <eal_export.h>
 #include <rte_spinlock.h>
 #include <rte_debug.h>
 
@@ -25,6 +26,7 @@ const char *power_env_str[] = {
 };
 
 /* register the ops struct in rte_power_cpufreq_ops, return 0 on success. */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_cpufreq_ops)
 int
 rte_power_register_cpufreq_ops(struct rte_power_cpufreq_ops *driver_ops)
 {
@@ -44,6 +46,7 @@ rte_power_register_cpufreq_ops(struct rte_power_cpufreq_ops *driver_ops)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_check_env_supported)
 int
 rte_power_check_env_supported(enum power_management_env env)
 {
@@ -60,6 +63,7 @@ rte_power_check_env_supported(enum power_management_env env)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_set_env)
 int
 rte_power_set_env(enum power_management_env env)
 {
@@ -89,6 +93,7 @@ rte_power_set_env(enum power_management_env env)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_unset_env)
 void
 rte_power_unset_env(void)
 {
@@ -98,11 +103,13 @@ rte_power_unset_env(void)
 	rte_spinlock_unlock(&global_env_cfg_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_get_env)
 enum power_management_env
 rte_power_get_env(void) {
 	return global_default_env;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_init)
 int
 rte_power_init(unsigned int lcore_id)
 {
@@ -136,6 +143,7 @@ rte_power_init(unsigned int lcore_id)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_exit)
 int
 rte_power_exit(unsigned int lcore_id)
 {
@@ -148,6 +156,7 @@ rte_power_exit(unsigned int lcore_id)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freqs)
 uint32_t
 rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 {
@@ -155,6 +164,7 @@ rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 	return global_cpufreq_ops->get_avail_freqs(lcore_id, freqs, n);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_get_freq)
 uint32_t
 rte_power_get_freq(unsigned int lcore_id)
 {
@@ -162,6 +172,7 @@ rte_power_get_freq(unsigned int lcore_id)
 	return global_cpufreq_ops->get_freq(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_set_freq)
 uint32_t
 rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 {
@@ -169,6 +180,7 @@ rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 	return global_cpufreq_ops->set_freq(lcore_id, index);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_up)
 int
 rte_power_freq_up(unsigned int lcore_id)
 {
@@ -176,6 +188,7 @@ rte_power_freq_up(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_up(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_down)
 int
 rte_power_freq_down(unsigned int lcore_id)
 {
@@ -183,6 +196,7 @@ rte_power_freq_down(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_down(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_max)
 int
 rte_power_freq_max(unsigned int lcore_id)
 {
@@ -190,6 +204,7 @@ rte_power_freq_max(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_max(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_min)
 int
 rte_power_freq_min(unsigned int lcore_id)
 {
@@ -197,6 +212,7 @@ rte_power_freq_min(unsigned int lcore_id)
 	return global_cpufreq_ops->freq_min(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_turbo_status)
 int
 rte_power_turbo_status(unsigned int lcore_id)
 {
@@ -204,6 +220,7 @@ rte_power_turbo_status(unsigned int lcore_id)
 	return global_cpufreq_ops->turbo_status(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_enable_turbo)
 int
 rte_power_freq_enable_turbo(unsigned int lcore_id)
 {
@@ -211,6 +228,7 @@ rte_power_freq_enable_turbo(unsigned int lcore_id)
 	return global_cpufreq_ops->enable_turbo(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_freq_disable_turbo)
 int
 rte_power_freq_disable_turbo(unsigned int lcore_id)
 {
@@ -218,6 +236,7 @@ rte_power_freq_disable_turbo(unsigned int lcore_id)
 	return global_cpufreq_ops->disable_turbo(lcore_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_get_capabilities)
 int
 rte_power_get_capabilities(unsigned int lcore_id,
 		struct rte_power_core_capabilities *caps)
diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index 8ec925bd65..6cacc562c2 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_lcore.h>
 #include <rte_lcore_var.h>
 #include <rte_cycles.h>
@@ -496,6 +497,7 @@ get_monitor_callback(void)
 		clb_multiwait : clb_umwait;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_enable)
 int
 rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 		uint16_t queue_id, enum rte_power_pmd_mgmt_type mode)
@@ -613,6 +615,7 @@ rte_power_ethdev_pmgmt_queue_enable(unsigned int lcore_id, uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_ethdev_pmgmt_queue_disable)
 int
 rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 		uint16_t port_id, uint16_t queue_id)
@@ -688,18 +691,21 @@ rte_power_ethdev_pmgmt_queue_disable(unsigned int lcore_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_emptypoll_max)
 void
 rte_power_pmd_mgmt_set_emptypoll_max(unsigned int max)
 {
 	emptypoll_max = max;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_emptypoll_max)
 unsigned int
 rte_power_pmd_mgmt_get_emptypoll_max(void)
 {
 	return emptypoll_max;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_pause_duration)
 int
 rte_power_pmd_mgmt_set_pause_duration(unsigned int duration)
 {
@@ -712,12 +718,14 @@ rte_power_pmd_mgmt_set_pause_duration(unsigned int duration)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_pause_duration)
 unsigned int
 rte_power_pmd_mgmt_get_pause_duration(void)
 {
 	return pause_duration;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_min)
 int
 rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 {
@@ -735,6 +743,7 @@ rte_power_pmd_mgmt_set_scaling_freq_min(unsigned int lcore, unsigned int min)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_set_scaling_freq_max)
 int
 rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 {
@@ -756,6 +765,7 @@ rte_power_pmd_mgmt_set_scaling_freq_max(unsigned int lcore, unsigned int max)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_min)
 int
 rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 {
@@ -770,6 +780,7 @@ rte_power_pmd_mgmt_get_scaling_freq_min(unsigned int lcore)
 	return scale_freq_min[lcore];
 }
 
+RTE_EXPORT_SYMBOL(rte_power_pmd_mgmt_get_scaling_freq_max)
 int
 rte_power_pmd_mgmt_get_scaling_freq_max(unsigned int lcore)
 {
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index 4dd0532b36..be230d1c50 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 
@@ -17,6 +18,7 @@
 
 #define PM_QOS_CPU_RESUME_LATENCY_BUF_LEN	32
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_set_cpu_resume_latency, 24.11)
 int
 rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 {
@@ -70,6 +72,7 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_qos_get_cpu_resume_latency, 24.11)
 int
 rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 {
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 741e067932..30cd374127 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2023 AMD Corporation
  */
 
+#include <eal_export.h>
 #include <rte_spinlock.h>
 #include <rte_debug.h>
 
@@ -24,6 +25,7 @@ const char *uncore_env_str[] = {
 };
 
 /* register the ops struct in rte_power_uncore_ops, return 0 on success. */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_power_register_uncore_ops)
 int
 rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 {
@@ -44,6 +46,7 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 {
@@ -83,6 +86,7 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_unset_uncore_env, 23.11)
 void
 rte_power_unset_uncore_env(void)
 {
@@ -91,12 +95,14 @@ rte_power_unset_uncore_env(void)
 	rte_spinlock_unlock(&global_env_cfg_lock);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_get_uncore_env, 23.11)
 enum rte_uncore_power_mgmt_env
 rte_power_get_uncore_env(void)
 {
 	return global_uncore_env;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_init)
 int
 rte_power_uncore_init(unsigned int pkg, unsigned int die)
 {
@@ -128,6 +134,7 @@ rte_power_uncore_init(unsigned int pkg, unsigned int die)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_exit)
 int
 rte_power_uncore_exit(unsigned int pkg, unsigned int die)
 {
@@ -141,6 +148,7 @@ rte_power_uncore_exit(unsigned int pkg, unsigned int die)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_power_get_uncore_freq)
 uint32_t
 rte_power_get_uncore_freq(unsigned int pkg, unsigned int die)
 {
@@ -148,6 +156,7 @@ rte_power_get_uncore_freq(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->get_freq(pkg, die);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_set_uncore_freq)
 int
 rte_power_set_uncore_freq(unsigned int pkg, unsigned int die, uint32_t index)
 {
@@ -155,6 +164,7 @@ rte_power_set_uncore_freq(unsigned int pkg, unsigned int die, uint32_t index)
 	return global_uncore_ops->set_freq(pkg, die, index);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_freq_max)
 int
 rte_power_uncore_freq_max(unsigned int pkg, unsigned int die)
 {
@@ -162,6 +172,7 @@ rte_power_uncore_freq_max(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->freq_max(pkg, die);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_freq_min)
 int
 rte_power_uncore_freq_min(unsigned int pkg, unsigned int die)
 {
@@ -169,6 +180,7 @@ rte_power_uncore_freq_min(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->freq_min(pkg, die);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_freqs, 23.11)
 int
 rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 			uint32_t *freqs, uint32_t num)
@@ -177,6 +189,7 @@ rte_power_uncore_freqs(unsigned int pkg, unsigned int die,
 	return global_uncore_ops->get_avail_freqs(pkg, die, freqs, num);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_freqs)
 int
 rte_power_uncore_get_num_freqs(unsigned int pkg, unsigned int die)
 {
@@ -184,6 +197,7 @@ rte_power_uncore_get_num_freqs(unsigned int pkg, unsigned int die)
 	return global_uncore_ops->get_num_freqs(pkg, die);
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_pkgs)
 unsigned int
 rte_power_uncore_get_num_pkgs(void)
 {
@@ -191,6 +205,7 @@ rte_power_uncore_get_num_pkgs(void)
 	return global_uncore_ops->get_num_pkgs();
 }
 
+RTE_EXPORT_SYMBOL(rte_power_uncore_get_num_dies)
 unsigned int
 rte_power_uncore_get_num_dies(unsigned int pkg)
 {
diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index 810e95a440..4da7956d5a 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -10,6 +10,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_log.h>
 #include <dev_driver.h>
@@ -22,6 +23,7 @@
 
 static struct rte_rawdev rte_rawdevices[RTE_RAWDEV_MAX_DEVS];
 
+RTE_EXPORT_SYMBOL(rte_rawdevs)
 struct rte_rawdev *rte_rawdevs = rte_rawdevices;
 
 static struct rte_rawdev_global rawdev_globals = {
@@ -29,12 +31,14 @@ static struct rte_rawdev_global rawdev_globals = {
 };
 
 /* Raw device, northbound API implementation */
+RTE_EXPORT_SYMBOL(rte_rawdev_count)
 uint8_t
 rte_rawdev_count(void)
 {
 	return rawdev_globals.nb_devs;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_get_dev_id)
 uint16_t
 rte_rawdev_get_dev_id(const char *name)
 {
@@ -52,6 +56,7 @@ rte_rawdev_get_dev_id(const char *name)
 	return -ENODEV;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_socket_id)
 int
 rte_rawdev_socket_id(uint16_t dev_id)
 {
@@ -63,6 +68,7 @@ rte_rawdev_socket_id(uint16_t dev_id)
 	return dev->socket_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_info_get)
 int
 rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 		size_t dev_private_size)
@@ -91,6 +97,7 @@ rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_configure)
 int
 rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 		size_t dev_private_size)
@@ -123,6 +130,7 @@ rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 	return diag;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_conf_get)
 int
 rte_rawdev_queue_conf_get(uint16_t dev_id,
 			  uint16_t queue_id,
@@ -139,6 +147,7 @@ rte_rawdev_queue_conf_get(uint16_t dev_id,
 	return dev->dev_ops->queue_def_conf(dev, queue_id, queue_conf, queue_conf_size);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_setup)
 int
 rte_rawdev_queue_setup(uint16_t dev_id,
 		       uint16_t queue_id,
@@ -155,6 +164,7 @@ rte_rawdev_queue_setup(uint16_t dev_id,
 	return dev->dev_ops->queue_setup(dev, queue_id, queue_conf, queue_conf_size);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_release)
 int
 rte_rawdev_queue_release(uint16_t dev_id, uint16_t queue_id)
 {
@@ -168,6 +178,7 @@ rte_rawdev_queue_release(uint16_t dev_id, uint16_t queue_id)
 	return dev->dev_ops->queue_release(dev, queue_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_queue_count)
 uint16_t
 rte_rawdev_queue_count(uint16_t dev_id)
 {
@@ -181,6 +192,7 @@ rte_rawdev_queue_count(uint16_t dev_id)
 	return dev->dev_ops->queue_count(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_get_attr)
 int
 rte_rawdev_get_attr(uint16_t dev_id,
 		    const char *attr_name,
@@ -196,6 +208,7 @@ rte_rawdev_get_attr(uint16_t dev_id,
 	return dev->dev_ops->attr_get(dev, attr_name, attr_value);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_set_attr)
 int
 rte_rawdev_set_attr(uint16_t dev_id,
 		    const char *attr_name,
@@ -211,6 +224,7 @@ rte_rawdev_set_attr(uint16_t dev_id,
 	return dev->dev_ops->attr_set(dev, attr_name, attr_value);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_enqueue_buffers)
 int
 rte_rawdev_enqueue_buffers(uint16_t dev_id,
 			   struct rte_rawdev_buf **buffers,
@@ -227,6 +241,7 @@ rte_rawdev_enqueue_buffers(uint16_t dev_id,
 	return dev->dev_ops->enqueue_bufs(dev, buffers, count, context);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_dequeue_buffers)
 int
 rte_rawdev_dequeue_buffers(uint16_t dev_id,
 			   struct rte_rawdev_buf **buffers,
@@ -243,6 +258,7 @@ rte_rawdev_dequeue_buffers(uint16_t dev_id,
 	return dev->dev_ops->dequeue_bufs(dev, buffers, count, context);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_dump)
 int
 rte_rawdev_dump(uint16_t dev_id, FILE *f)
 {
@@ -266,6 +282,7 @@ xstats_get_count(uint16_t dev_id)
 	return dev->dev_ops->xstats_get_names(dev, NULL, 0);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_names_get)
 int
 rte_rawdev_xstats_names_get(uint16_t dev_id,
 		struct rte_rawdev_xstats_name *xstats_names,
@@ -290,6 +307,7 @@ rte_rawdev_xstats_names_get(uint16_t dev_id,
 }
 
 /* retrieve rawdev extended statistics */
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_get)
 int
 rte_rawdev_xstats_get(uint16_t dev_id,
 		      const unsigned int ids[],
@@ -304,6 +322,7 @@ rte_rawdev_xstats_get(uint16_t dev_id,
 	return dev->dev_ops->xstats_get(dev, ids, values, n);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_by_name_get)
 uint64_t
 rte_rawdev_xstats_by_name_get(uint16_t dev_id,
 			      const char *name,
@@ -324,6 +343,7 @@ rte_rawdev_xstats_by_name_get(uint16_t dev_id,
 	return dev->dev_ops->xstats_get_by_name(dev, name, id);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_xstats_reset)
 int
 rte_rawdev_xstats_reset(uint16_t dev_id,
 			const uint32_t ids[], uint32_t nb_ids)
@@ -336,6 +356,7 @@ rte_rawdev_xstats_reset(uint16_t dev_id,
 	return dev->dev_ops->xstats_reset(dev, ids, nb_ids);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_status_get)
 int
 rte_rawdev_firmware_status_get(uint16_t dev_id, rte_rawdev_obj_t status_info)
 {
@@ -347,6 +368,7 @@ rte_rawdev_firmware_status_get(uint16_t dev_id, rte_rawdev_obj_t status_info)
 	return dev->dev_ops->firmware_status_get(dev, status_info);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_version_get)
 int
 rte_rawdev_firmware_version_get(uint16_t dev_id, rte_rawdev_obj_t version_info)
 {
@@ -358,6 +380,7 @@ rte_rawdev_firmware_version_get(uint16_t dev_id, rte_rawdev_obj_t version_info)
 	return dev->dev_ops->firmware_version_get(dev, version_info);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_load)
 int
 rte_rawdev_firmware_load(uint16_t dev_id, rte_rawdev_obj_t firmware_image)
 {
@@ -372,6 +395,7 @@ rte_rawdev_firmware_load(uint16_t dev_id, rte_rawdev_obj_t firmware_image)
 	return dev->dev_ops->firmware_load(dev, firmware_image);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_firmware_unload)
 int
 rte_rawdev_firmware_unload(uint16_t dev_id)
 {
@@ -383,6 +407,7 @@ rte_rawdev_firmware_unload(uint16_t dev_id)
 	return dev->dev_ops->firmware_unload(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_selftest)
 int
 rte_rawdev_selftest(uint16_t dev_id)
 {
@@ -394,6 +419,7 @@ rte_rawdev_selftest(uint16_t dev_id)
 	return dev->dev_ops->dev_selftest(dev_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_start)
 int
 rte_rawdev_start(uint16_t dev_id)
 {
@@ -422,6 +448,7 @@ rte_rawdev_start(uint16_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_stop)
 void
 rte_rawdev_stop(uint16_t dev_id)
 {
@@ -447,6 +474,7 @@ rte_rawdev_stop(uint16_t dev_id)
 	dev->started = 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_close)
 int
 rte_rawdev_close(uint16_t dev_id)
 {
@@ -467,6 +495,7 @@ rte_rawdev_close(uint16_t dev_id)
 	return dev->dev_ops->dev_close(dev);
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_reset)
 int
 rte_rawdev_reset(uint16_t dev_id)
 {
@@ -495,6 +524,7 @@ rte_rawdev_find_free_device_index(void)
 	return RTE_RAWDEV_MAX_DEVS;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_pmd_allocate)
 struct rte_rawdev *
 rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 {
@@ -536,6 +566,7 @@ rte_rawdev_pmd_allocate(const char *name, size_t dev_priv_size, int socket_id)
 	return rawdev;
 }
 
+RTE_EXPORT_SYMBOL(rte_rawdev_pmd_release)
 int
 rte_rawdev_pmd_release(struct rte_rawdev *rawdev)
 {
diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index dbf31501a6..5f5762cbd4 100644
--- a/lib/rcu/rte_rcu_qsbr.c
+++ b/lib/rcu/rte_rcu_qsbr.c
@@ -9,6 +9,7 @@
 #include <inttypes.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -23,6 +24,7 @@
 	RTE_LOG_LINE_PREFIX(level, RCU, "%s(): ", __func__, __VA_ARGS__)
 
 /* Get the memory size of QSBR variable */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_get_memsize)
 size_t
 rte_rcu_qsbr_get_memsize(uint32_t max_threads)
 {
@@ -47,6 +49,7 @@ rte_rcu_qsbr_get_memsize(uint32_t max_threads)
 }
 
 /* Initialize a quiescent state variable */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_init)
 int
 rte_rcu_qsbr_init(struct rte_rcu_qsbr *v, uint32_t max_threads)
 {
@@ -78,6 +81,7 @@ rte_rcu_qsbr_init(struct rte_rcu_qsbr *v, uint32_t max_threads)
 /* Register a reader thread to report its quiescent state
  * on a QS variable.
  */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_register)
 int
 rte_rcu_qsbr_thread_register(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -113,6 +117,7 @@ rte_rcu_qsbr_thread_register(struct rte_rcu_qsbr *v, unsigned int thread_id)
 /* Remove a reader thread, from the list of threads reporting their
  * quiescent state on a QS variable.
  */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_thread_unregister)
 int
 rte_rcu_qsbr_thread_unregister(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -149,6 +154,7 @@ rte_rcu_qsbr_thread_unregister(struct rte_rcu_qsbr *v, unsigned int thread_id)
 }
 
 /* Wait till the reader threads have entered quiescent state. */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_synchronize)
 void
 rte_rcu_qsbr_synchronize(struct rte_rcu_qsbr *v, unsigned int thread_id)
 {
@@ -169,6 +175,7 @@ rte_rcu_qsbr_synchronize(struct rte_rcu_qsbr *v, unsigned int thread_id)
 }
 
 /* Dump the details of a single quiescent state variable to a file. */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dump)
 int
 rte_rcu_qsbr_dump(FILE *f, struct rte_rcu_qsbr *v)
 {
@@ -235,6 +242,7 @@ rte_rcu_qsbr_dump(FILE *f, struct rte_rcu_qsbr *v)
 /* Create a queue used to store the data structure elements that can
  * be freed later. This queue is referred to as 'defer queue'.
  */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_create)
 struct rte_rcu_qsbr_dq *
 rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 {
@@ -311,6 +319,7 @@ rte_rcu_qsbr_dq_create(const struct rte_rcu_qsbr_dq_parameters *params)
 /* Enqueue one resource to the defer queue to free after the grace
  * period is over.
  */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_enqueue)
 int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 {
 	__rte_rcu_qsbr_dq_elem_t *dq_elem;
@@ -369,6 +378,7 @@ int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 }
 
 /* Reclaim resources from the defer queue. */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_reclaim)
 int
 rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 			unsigned int *freed, unsigned int *pending,
@@ -418,6 +428,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 }
 
 /* Delete a defer queue. */
+RTE_EXPORT_SYMBOL(rte_rcu_qsbr_dq_delete)
 int
 rte_rcu_qsbr_dq_delete(struct rte_rcu_qsbr_dq *dq)
 {
@@ -443,4 +454,5 @@ rte_rcu_qsbr_dq_delete(struct rte_rcu_qsbr_dq *dq)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rcu_log_type)
 RTE_LOG_REGISTER_DEFAULT(rte_rcu_log_type, ERR);
diff --git a/lib/regexdev/rte_regexdev.c b/lib/regexdev/rte_regexdev.c
index 431ed911a1..8ba797b278 100644
--- a/lib/regexdev/rte_regexdev.c
+++ b/lib/regexdev/rte_regexdev.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_memzone.h>
 #include <rte_string_fns.h>
 
@@ -13,12 +14,14 @@
 #include "rte_regexdev_driver.h"
 
 static const char *MZ_RTE_REGEXDEV_DATA = "rte_regexdev_data";
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regex_devices, 22.03)
 struct rte_regexdev rte_regex_devices[RTE_MAX_REGEXDEV_DEVS];
 /* Shared memory between primary and secondary processes. */
 static struct {
 	struct rte_regexdev_data data[RTE_MAX_REGEXDEV_DEVS];
 } *rte_regexdev_shared_data;
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_logtype, 22.03)
 RTE_LOG_REGISTER_DEFAULT(rte_regexdev_logtype, INFO);
 
 static uint16_t
@@ -89,6 +92,7 @@ regexdev_check_name(const char *name)
 
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_register)
 struct rte_regexdev *
 rte_regexdev_register(const char *name)
 {
@@ -126,12 +130,14 @@ rte_regexdev_register(const char *name)
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_unregister)
 void
 rte_regexdev_unregister(struct rte_regexdev *dev)
 {
 	dev->state = RTE_REGEXDEV_UNUSED;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_regexdev_get_device_by_name)
 struct rte_regexdev *
 rte_regexdev_get_device_by_name(const char *name)
 {
@@ -140,6 +146,7 @@ rte_regexdev_get_device_by_name(const char *name)
 	return regexdev_allocated(name);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_count, 20.08)
 uint8_t
 rte_regexdev_count(void)
 {
@@ -153,6 +160,7 @@ rte_regexdev_count(void)
 	return count;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_get_dev_id, 20.08)
 int
 rte_regexdev_get_dev_id(const char *name)
 {
@@ -171,6 +179,7 @@ rte_regexdev_get_dev_id(const char *name)
 	return id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_is_valid_dev, 22.03)
 int
 rte_regexdev_is_valid_dev(uint16_t dev_id)
 {
@@ -195,12 +204,14 @@ regexdev_info_get(uint8_t dev_id, struct rte_regexdev_info *dev_info)
 
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_info_get, 20.08)
 int
 rte_regexdev_info_get(uint8_t dev_id, struct rte_regexdev_info *dev_info)
 {
 	return regexdev_info_get(dev_id, dev_info);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_configure, 20.08)
 int
 rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 {
@@ -295,6 +306,7 @@ rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_queue_pair_setup, 20.08)
 int
 rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 			   const struct rte_regexdev_qp_conf *qp_conf)
@@ -327,6 +339,7 @@ rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 	return dev->dev_ops->dev_qp_setup(dev, queue_pair_id, qp_conf);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_start, 20.08)
 int
 rte_regexdev_start(uint8_t dev_id)
 {
@@ -343,6 +356,7 @@ rte_regexdev_start(uint8_t dev_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_stop, 20.08)
 int
 rte_regexdev_stop(uint8_t dev_id)
 {
@@ -357,6 +371,7 @@ rte_regexdev_stop(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_close, 20.08)
 int
 rte_regexdev_close(uint8_t dev_id)
 {
@@ -372,6 +387,7 @@ rte_regexdev_close(uint8_t dev_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_get, 20.08)
 int
 rte_regexdev_attr_get(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 		      void *attr_value)
@@ -390,6 +406,7 @@ rte_regexdev_attr_get(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 	return dev->dev_ops->dev_attr_get(dev, attr_id, attr_value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_attr_set, 20.08)
 int
 rte_regexdev_attr_set(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 		      const void *attr_value)
@@ -408,6 +425,7 @@ rte_regexdev_attr_set(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 	return dev->dev_ops->dev_attr_set(dev, attr_id, attr_value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_update, 20.08)
 int
 rte_regexdev_rule_db_update(uint8_t dev_id,
 			    const struct rte_regexdev_rule *rules,
@@ -427,6 +445,7 @@ rte_regexdev_rule_db_update(uint8_t dev_id,
 	return dev->dev_ops->dev_rule_db_update(dev, rules, nb_rules);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_compile_activate, 20.08)
 int
 rte_regexdev_rule_db_compile_activate(uint8_t dev_id)
 {
@@ -439,6 +458,7 @@ rte_regexdev_rule_db_compile_activate(uint8_t dev_id)
 	return dev->dev_ops->dev_rule_db_compile_activate(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_import, 20.08)
 int
 rte_regexdev_rule_db_import(uint8_t dev_id, const char *rule_db,
 			    uint32_t rule_db_len)
@@ -457,6 +477,7 @@ rte_regexdev_rule_db_import(uint8_t dev_id, const char *rule_db,
 	return dev->dev_ops->dev_db_import(dev, rule_db, rule_db_len);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_rule_db_export, 20.08)
 int
 rte_regexdev_rule_db_export(uint8_t dev_id, char *rule_db)
 {
@@ -469,6 +490,7 @@ rte_regexdev_rule_db_export(uint8_t dev_id, char *rule_db)
 	return dev->dev_ops->dev_db_export(dev, rule_db);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_names_get, 20.08)
 int
 rte_regexdev_xstats_names_get(uint8_t dev_id,
 			      struct rte_regexdev_xstats_map *xstats_map)
@@ -487,6 +509,7 @@ rte_regexdev_xstats_names_get(uint8_t dev_id,
 	return dev->dev_ops->dev_xstats_names_get(dev, xstats_map);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_get, 20.08)
 int
 rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 			uint64_t *values, uint16_t n)
@@ -508,6 +531,7 @@ rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 	return dev->dev_ops->dev_xstats_get(dev, ids, values, n);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_by_name_get, 20.08)
 int
 rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 				uint16_t *id, uint64_t *value)
@@ -533,6 +557,7 @@ rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 	return dev->dev_ops->dev_xstats_by_name_get(dev, name, id, value);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_xstats_reset, 20.08)
 int
 rte_regexdev_xstats_reset(uint8_t dev_id, const uint16_t *ids,
 			  uint16_t nb_ids)
@@ -550,6 +575,7 @@ rte_regexdev_xstats_reset(uint8_t dev_id, const uint16_t *ids,
 	return dev->dev_ops->dev_xstats_reset(dev, ids, nb_ids);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_selftest, 20.08)
 int
 rte_regexdev_selftest(uint8_t dev_id)
 {
@@ -562,6 +588,7 @@ rte_regexdev_selftest(uint8_t dev_id)
 	return dev->dev_ops->dev_selftest(dev);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_regexdev_dump, 20.08)
 int
 rte_regexdev_dump(uint8_t dev_id, FILE *f)
 {
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index ae97e1a34d..be06530860 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_log.h>
 #include <rte_mbuf.h>
@@ -34,6 +35,7 @@ EAL_REGISTER_TAILQ(rte_reorder_tailq)
 #define RTE_REORDER_NAMESIZE 32
 
 #define RTE_REORDER_SEQN_DYNFIELD_NAME "rte_reorder_seqn_dynfield"
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_seqn_dynfield_offset, 20.11)
 int rte_reorder_seqn_dynfield_offset = -1;
 
 /* A generic circular buffer */
@@ -59,12 +61,14 @@ struct __rte_cache_aligned rte_reorder_buffer {
 static void
 rte_reorder_free_mbufs(struct rte_reorder_buffer *b);
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_memory_footprint_get, 23.07)
 unsigned int
 rte_reorder_memory_footprint_get(unsigned int size)
 {
 	return sizeof(struct rte_reorder_buffer) + (2 * size * sizeof(struct rte_mbuf *));
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_init)
 struct rte_reorder_buffer *
 rte_reorder_init(struct rte_reorder_buffer *b, unsigned int bufsize,
 		const char *name, unsigned int size)
@@ -154,6 +158,7 @@ rte_reorder_entry_insert(struct rte_tailq_entry *new_te)
 	return te;
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_create)
 struct rte_reorder_buffer*
 rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
 {
@@ -210,6 +215,7 @@ rte_reorder_create(const char *name, unsigned socket_id, unsigned int size)
 	return b;
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_reset)
 void
 rte_reorder_reset(struct rte_reorder_buffer *b)
 {
@@ -233,6 +239,7 @@ rte_reorder_free_mbufs(struct rte_reorder_buffer *b)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_free)
 void
 rte_reorder_free(struct rte_reorder_buffer *b)
 {
@@ -267,6 +274,7 @@ rte_reorder_free(struct rte_reorder_buffer *b)
 	rte_free(te);
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_find_existing)
 struct rte_reorder_buffer *
 rte_reorder_find_existing(const char *name)
 {
@@ -348,6 +356,7 @@ rte_reorder_fill_overflow(struct rte_reorder_buffer *b, unsigned n)
 	return order_head_adv;
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_insert)
 int
 rte_reorder_insert(struct rte_reorder_buffer *b, struct rte_mbuf *mbuf)
 {
@@ -414,6 +423,7 @@ rte_reorder_insert(struct rte_reorder_buffer *b, struct rte_mbuf *mbuf)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_reorder_drain)
 unsigned int
 rte_reorder_drain(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		unsigned max_mbufs)
@@ -472,6 +482,7 @@ ready_buffer_seqn_find(const struct cir_buffer *ready_buf, const uint32_t seqn)
 	return low;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_drain_up_to_seqn, 23.03)
 unsigned int
 rte_reorder_drain_up_to_seqn(struct rte_reorder_buffer *b, struct rte_mbuf **mbufs,
 		const unsigned int max_mbufs, const rte_reorder_seqn_t seqn)
@@ -542,6 +553,7 @@ rte_reorder_is_empty(const struct rte_reorder_buffer *b)
 	return true;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_reorder_min_seqn_set, 23.03)
 unsigned int
 rte_reorder_min_seqn_set(struct rte_reorder_buffer *b, rte_reorder_seqn_t min_seqn)
 {
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index b95d329c8b..046db131ca 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
 #include <rte_malloc.h>
@@ -101,6 +102,7 @@ node_free(struct rte_rib *rib, struct rte_rib_node *ent)
 	rte_mempool_put(rib->node_pool, ent);
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_lookup)
 struct rte_rib_node *
 rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
 {
@@ -120,6 +122,7 @@ rte_rib_lookup(struct rte_rib *rib, uint32_t ip)
 	return prev;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_lookup_parent)
 struct rte_rib_node *
 rte_rib_lookup_parent(struct rte_rib_node *ent)
 {
@@ -151,6 +154,7 @@ __rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_lookup_exact)
 struct rte_rib_node *
 rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -168,6 +172,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
  *  for a given in args ip/depth prefix
  *  last = NULL means the first invocation
  */
+RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
 struct rte_rib_node *
 rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	uint8_t depth, struct rte_rib_node *last, int flag)
@@ -208,6 +213,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 	return prev;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_remove)
 void
 rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -240,6 +246,7 @@ rte_rib_remove(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_insert)
 struct rte_rib_node *
 rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 {
@@ -346,6 +353,7 @@ rte_rib_insert(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 	return new_node;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_get_ip)
 int
 rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
 {
@@ -357,6 +365,7 @@ rte_rib_get_ip(const struct rte_rib_node *node, uint32_t *ip)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_get_depth)
 int
 rte_rib_get_depth(const struct rte_rib_node *node, uint8_t *depth)
 {
@@ -368,12 +377,14 @@ rte_rib_get_depth(const struct rte_rib_node *node, uint8_t *depth)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_get_ext)
 void *
 rte_rib_get_ext(struct rte_rib_node *node)
 {
 	return (node == NULL) ? NULL : &node->ext[0];
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_get_nh)
 int
 rte_rib_get_nh(const struct rte_rib_node *node, uint64_t *nh)
 {
@@ -385,6 +396,7 @@ rte_rib_get_nh(const struct rte_rib_node *node, uint64_t *nh)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_set_nh)
 int
 rte_rib_set_nh(struct rte_rib_node *node, uint64_t nh)
 {
@@ -396,6 +408,7 @@ rte_rib_set_nh(struct rte_rib_node *node, uint64_t nh)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_create)
 struct rte_rib *
 rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 {
@@ -477,6 +490,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_find_existing)
 struct rte_rib *
 rte_rib_find_existing(const char *name)
 {
@@ -502,6 +516,7 @@ rte_rib_find_existing(const char *name)
 	return rib;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib_free)
 void
 rte_rib_free(struct rte_rib *rib)
 {
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 84c47fed6d..ded5fd044f 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -114,6 +115,7 @@ node_free(struct rte_rib6 *rib, struct rte_rib6_node *ent)
 	rte_mempool_put(rib->node_pool, ent);
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_lookup)
 struct rte_rib6_node *
 rte_rib6_lookup(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip)
@@ -135,6 +137,7 @@ rte_rib6_lookup(struct rte_rib6 *rib,
 	return prev;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_lookup_parent)
 struct rte_rib6_node *
 rte_rib6_lookup_parent(struct rte_rib6_node *ent)
 {
@@ -150,6 +153,7 @@ rte_rib6_lookup_parent(struct rte_rib6_node *ent)
 	return tmp;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_lookup_exact)
 struct rte_rib6_node *
 rte_rib6_lookup_exact(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -187,6 +191,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *  for a given in args ip/depth prefix
  *  last = NULL means the first invocation
  */
+RTE_EXPORT_SYMBOL(rte_rib6_get_nxt)
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
@@ -232,6 +237,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 	return prev;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_remove)
 void
 rte_rib6_remove(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -265,6 +271,7 @@ rte_rib6_remove(struct rte_rib6 *rib,
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_insert)
 struct rte_rib6_node *
 rte_rib6_insert(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip, uint8_t depth)
@@ -392,6 +399,7 @@ rte_rib6_insert(struct rte_rib6 *rib,
 	return new_node;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_get_ip)
 int
 rte_rib6_get_ip(const struct rte_rib6_node *node,
 		struct rte_ipv6_addr *ip)
@@ -404,6 +412,7 @@ rte_rib6_get_ip(const struct rte_rib6_node *node,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_get_depth)
 int
 rte_rib6_get_depth(const struct rte_rib6_node *node, uint8_t *depth)
 {
@@ -415,12 +424,14 @@ rte_rib6_get_depth(const struct rte_rib6_node *node, uint8_t *depth)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_get_ext)
 void *
 rte_rib6_get_ext(struct rte_rib6_node *node)
 {
 	return (node == NULL) ? NULL : &node->ext[0];
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_get_nh)
 int
 rte_rib6_get_nh(const struct rte_rib6_node *node, uint64_t *nh)
 {
@@ -432,6 +443,7 @@ rte_rib6_get_nh(const struct rte_rib6_node *node, uint64_t *nh)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_set_nh)
 int
 rte_rib6_set_nh(struct rte_rib6_node *node, uint64_t nh)
 {
@@ -443,6 +455,7 @@ rte_rib6_set_nh(struct rte_rib6_node *node, uint64_t nh)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_create)
 struct rte_rib6 *
 rte_rib6_create(const char *name, int socket_id,
 		const struct rte_rib6_conf *conf)
@@ -526,6 +539,7 @@ rte_rib6_create(const char *name, int socket_id,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_find_existing)
 struct rte_rib6 *
 rte_rib6_find_existing(const char *name)
 {
@@ -556,6 +570,7 @@ rte_rib6_find_existing(const char *name)
 	return rib;
 }
 
+RTE_EXPORT_SYMBOL(rte_rib6_free)
 void
 rte_rib6_free(struct rte_rib6 *rib)
 {
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index a7d9d6b037..edd63aa535 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_memzone.h>
@@ -52,6 +53,7 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
 #define HTD_MAX_DEF	8
 
 /* return the size of memory occupied by a ring */
+RTE_EXPORT_SYMBOL(rte_ring_get_memsize_elem)
 ssize_t
 rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 {
@@ -79,6 +81,7 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 }
 
 /* return the size of memory occupied by a ring */
+RTE_EXPORT_SYMBOL(rte_ring_get_memsize)
 ssize_t
 rte_ring_get_memsize(unsigned int count)
 {
@@ -118,6 +121,7 @@ reset_headtail(void *p)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_ring_reset)
 void
 rte_ring_reset(struct rte_ring *r)
 {
@@ -176,6 +180,7 @@ get_sync_type(uint32_t flags, enum rte_ring_sync_type *prod_st,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_ring_init)
 int
 rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 	unsigned int flags)
@@ -243,6 +248,7 @@ rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 }
 
 /* create the ring for a given element size */
+RTE_EXPORT_SYMBOL(rte_ring_create_elem)
 struct rte_ring *
 rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 		int socket_id, unsigned int flags)
@@ -312,6 +318,7 @@ rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 }
 
 /* create the ring */
+RTE_EXPORT_SYMBOL(rte_ring_create)
 struct rte_ring *
 rte_ring_create(const char *name, unsigned int count, int socket_id,
 		unsigned int flags)
@@ -321,6 +328,7 @@ rte_ring_create(const char *name, unsigned int count, int socket_id,
 }
 
 /* free the ring */
+RTE_EXPORT_SYMBOL(rte_ring_free)
 void
 rte_ring_free(struct rte_ring *r)
 {
@@ -414,6 +422,7 @@ ring_dump_hts_headtail(FILE *f, const char *prefix,
 	fprintf(f, "%stail=%"PRIu32"\n", prefix, hts->ht.pos.tail);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ring_headtail_dump, 25.03)
 void
 rte_ring_headtail_dump(FILE *f, const char *prefix,
 		const struct rte_ring_headtail *r)
@@ -442,6 +451,7 @@ rte_ring_headtail_dump(FILE *f, const char *prefix,
 }
 
 /* dump the status of the ring on the console */
+RTE_EXPORT_SYMBOL(rte_ring_dump)
 void
 rte_ring_dump(FILE *f, const struct rte_ring *r)
 {
@@ -460,6 +470,7 @@ rte_ring_dump(FILE *f, const struct rte_ring *r)
 }
 
 /* dump the status of all rings on the console */
+RTE_EXPORT_SYMBOL(rte_ring_list_dump)
 void
 rte_ring_list_dump(FILE *f)
 {
@@ -478,6 +489,7 @@ rte_ring_list_dump(FILE *f)
 }
 
 /* search a ring from its name */
+RTE_EXPORT_SYMBOL(rte_ring_lookup)
 struct rte_ring *
 rte_ring_lookup(const char *name)
 {
diff --git a/lib/ring/rte_soring.c b/lib/ring/rte_soring.c
index 8cee926b11..0d8abba69c 100644
--- a/lib/ring/rte_soring.c
+++ b/lib/ring/rte_soring.c
@@ -4,6 +4,7 @@
 
 #include <inttypes.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "soring.h"
@@ -91,6 +92,7 @@ soring_dump_stage_headtail(FILE *f, const char *prefix,
 	fprintf(f, "%shead=%"PRIu32"\n", prefix, st->sht.head);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dump, 25.03)
 void
 rte_soring_dump(FILE *f, const struct rte_soring *r)
 {
@@ -118,6 +120,7 @@ rte_soring_dump(FILE *f, const struct rte_soring *r)
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_get_memsize, 25.03)
 ssize_t
 rte_soring_get_memsize(const struct rte_soring_param *prm)
 {
@@ -151,6 +154,7 @@ soring_compilation_checks(void)
 		offsetof(struct soring_stage_headtail, unused));
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_init, 25.03)
 int
 rte_soring_init(struct rte_soring *r, const struct rte_soring_param *prm)
 {
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 4fec7efae7..797484d6bf 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -59,6 +59,8 @@
 
 #include "soring.h"
 
+#include <eal_export.h>
+
 /*
  * Inline functions (fastpath) start here.
  */
@@ -489,6 +491,7 @@ soring_release(struct rte_soring *r, const void *objs,
  * Public functions (data-path) start here.
  */
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_release, 25.03)
 void
 rte_soring_release(struct rte_soring *r, const void *objs,
 	uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -497,6 +500,7 @@ rte_soring_release(struct rte_soring *r, const void *objs,
 }
 
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_releasx, 25.03)
 void
 rte_soring_releasx(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken)
@@ -504,6 +508,7 @@ rte_soring_releasx(struct rte_soring *r, const void *objs,
 	soring_release(r, objs, meta, stage, n, ftoken);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk, 25.03)
 uint32_t
 rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -512,6 +517,7 @@ rte_soring_enqueue_bulk(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_bulk, 25.03)
 uint32_t
 rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -520,6 +526,7 @@ rte_soring_enqueux_bulk(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst, 25.03)
 uint32_t
 rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 	uint32_t *free_space)
@@ -528,6 +535,7 @@ rte_soring_enqueue_burst(struct rte_soring *r, const void *objs, uint32_t n,
 			free_space);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_burst, 25.03)
 uint32_t
 rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, uint32_t *free_space)
@@ -536,6 +544,7 @@ rte_soring_enqueux_burst(struct rte_soring *r, const void *objs,
 			free_space);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk, 25.03)
 uint32_t
 rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -544,6 +553,7 @@ rte_soring_dequeue_bulk(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk, 25.03)
 uint32_t
 rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -552,6 +562,7 @@ rte_soring_dequeux_bulk(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst, 25.03)
 uint32_t
 rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 	uint32_t *available)
@@ -560,6 +571,7 @@ rte_soring_dequeue_burst(struct rte_soring *r, void *objs, uint32_t num,
 			available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst, 25.03)
 uint32_t
 rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, uint32_t *available)
@@ -568,6 +580,7 @@ rte_soring_dequeux_burst(struct rte_soring *r, void *objs, void *meta,
 			available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_bulk, 25.03)
 uint32_t
 rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -576,6 +589,7 @@ rte_soring_acquire_bulk(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_bulk, 25.03)
 uint32_t
 rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -584,6 +598,7 @@ rte_soring_acquirx_bulk(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_FIXED, ftoken, available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquire_burst, 25.03)
 uint32_t
 rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -592,6 +607,7 @@ rte_soring_acquire_burst(struct rte_soring *r, void *objs,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_acquirx_burst, 25.03)
 uint32_t
 rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 	uint32_t stage, uint32_t num, uint32_t *ftoken, uint32_t *available)
@@ -600,6 +616,7 @@ rte_soring_acquirx_burst(struct rte_soring *r, void *objs, void *meta,
 			RTE_RING_QUEUE_VARIABLE, ftoken, available);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_count, 25.03)
 unsigned int
 rte_soring_count(const struct rte_soring *r)
 {
@@ -609,6 +626,7 @@ rte_soring_count(const struct rte_soring *r)
 	return (count > r->capacity) ? r->capacity : count;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_free_count, 25.03)
 unsigned int
 rte_soring_free_count(const struct rte_soring *r)
 {
diff --git a/lib/sched/rte_approx.c b/lib/sched/rte_approx.c
index edc8d9113b..86c7d1d3fb 100644
--- a/lib/sched/rte_approx.c
+++ b/lib/sched/rte_approx.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include "rte_approx.h"
 
 /*
@@ -139,6 +140,7 @@ find_best_rational_approximation(uint32_t alpha_num, uint32_t d_num, uint32_t de
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_approx)
 int rte_approx(double alpha, double d, uint32_t *p, uint32_t *q)
 {
 	uint32_t alpha_num, d_num, denum;
diff --git a/lib/sched/rte_pie.c b/lib/sched/rte_pie.c
index a9f650e60f..b5d8988894 100644
--- a/lib/sched/rte_pie.c
+++ b/lib/sched/rte_pie.c
@@ -6,9 +6,11 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include "rte_sched_log.h"
 #include "rte_pie.h"
 
+RTE_EXPORT_SYMBOL(rte_pie_rt_data_init)
 int
 rte_pie_rt_data_init(struct rte_pie *pie)
 {
@@ -22,6 +24,7 @@ rte_pie_rt_data_init(struct rte_pie *pie)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_pie_config_init)
 int
 rte_pie_config_init(struct rte_pie_config *pie_cfg,
 	const uint16_t qdelay_ref,
diff --git a/lib/sched/rte_red.c b/lib/sched/rte_red.c
index fa27a141ed..d7534d0bee 100644
--- a/lib/sched/rte_red.c
+++ b/lib/sched/rte_red.c
@@ -3,23 +3,28 @@
  */
 
 #include <math.h>
+#include <eal_export.h>
 #include "rte_red.h"
 #include <rte_random.h>
 #include <rte_common.h>
 
 static int rte_red_init_done = 0;     /**< Flag to indicate that global initialisation is done */
+RTE_EXPORT_SYMBOL(rte_red_rand_val)
 uint32_t rte_red_rand_val = 0;        /**< Random value cache */
+RTE_EXPORT_SYMBOL(rte_red_rand_seed)
 uint32_t rte_red_rand_seed = 0;       /**< Seed for random number generation */
 
 /**
  * table[i] = log2(1-Wq) * Scale * -1
  *       Wq = 1/(2^i)
  */
+RTE_EXPORT_SYMBOL(rte_red_log2_1_minus_Wq)
 uint16_t rte_red_log2_1_minus_Wq[RTE_RED_WQ_LOG2_NUM];
 
 /**
  * table[i] = 2^(i/16) * Scale
  */
+RTE_EXPORT_SYMBOL(rte_red_pow2_frac_inv)
 uint16_t rte_red_pow2_frac_inv[16];
 
 /**
@@ -64,6 +69,7 @@ __rte_red_init_tables(void)
 	}
 }
 
+RTE_EXPORT_SYMBOL(rte_red_rt_data_init)
 int
 rte_red_rt_data_init(struct rte_red *red)
 {
@@ -76,6 +82,7 @@ rte_red_rt_data_init(struct rte_red *red)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_red_config_init)
 int
 rte_red_config_init(struct rte_red_config *red_cfg,
 	const uint16_t wq_log2,
diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index d8ee4e7e91..c89ab9ca69 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
@@ -883,6 +884,7 @@ rte_sched_subport_check_params(struct rte_sched_subport_params *params,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_get_memory_footprint)
 uint32_t
 rte_sched_port_get_memory_footprint(struct rte_sched_port_params *port_params,
 	struct rte_sched_subport_params **subport_params)
@@ -926,6 +928,7 @@ rte_sched_port_get_memory_footprint(struct rte_sched_port_params *port_params,
 	return size0 + size1;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_config)
 struct rte_sched_port *
 rte_sched_port_config(struct rte_sched_port_params *params)
 {
@@ -1046,6 +1049,7 @@ rte_sched_subport_free(struct rte_sched_port *port,
 	rte_free(subport);
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_free)
 void
 rte_sched_port_free(struct rte_sched_port *port)
 {
@@ -1159,6 +1163,7 @@ rte_sched_cman_config(struct rte_sched_port *port,
 	return -EINVAL;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_subport_tc_ov_config)
 int
 rte_sched_subport_tc_ov_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1184,6 +1189,7 @@ rte_sched_subport_tc_ov_config(struct rte_sched_port *port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_subport_config)
 int
 rte_sched_subport_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1377,6 +1383,7 @@ rte_sched_subport_config(struct rte_sched_port *port,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_pipe_config)
 int
 rte_sched_pipe_config(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1501,6 +1508,7 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_subport_pipe_profile_add)
 int
 rte_sched_subport_pipe_profile_add(struct rte_sched_port *port,
 	uint32_t subport_id,
@@ -1566,6 +1574,7 @@ rte_sched_subport_pipe_profile_add(struct rte_sched_port *port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_subport_profile_add)
 int
 rte_sched_port_subport_profile_add(struct rte_sched_port *port,
 	struct rte_sched_subport_profile_params *params,
@@ -1647,6 +1656,7 @@ rte_sched_port_qindex(struct rte_sched_port *port,
 		(RTE_SCHED_QUEUES_PER_PIPE - 1));
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_write)
 void
 rte_sched_port_pkt_write(struct rte_sched_port *port,
 			 struct rte_mbuf *pkt,
@@ -1660,6 +1670,7 @@ rte_sched_port_pkt_write(struct rte_sched_port *port,
 	rte_mbuf_sched_set(pkt, queue_id, traffic_class, (uint8_t)color);
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_tree_path)
 void
 rte_sched_port_pkt_read_tree_path(struct rte_sched_port *port,
 				  const struct rte_mbuf *pkt,
@@ -1675,12 +1686,14 @@ rte_sched_port_pkt_read_tree_path(struct rte_sched_port *port,
 	*queue = rte_sched_port_tc_queue(port, queue_id);
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_pkt_read_color)
 enum rte_color
 rte_sched_port_pkt_read_color(const struct rte_mbuf *pkt)
 {
 	return (enum rte_color)rte_mbuf_sched_color_get(pkt);
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_subport_read_stats)
 int
 rte_sched_subport_read_stats(struct rte_sched_port *port,
 			     uint32_t subport_id,
@@ -1726,6 +1739,7 @@ rte_sched_subport_read_stats(struct rte_sched_port *port,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_queue_read_stats)
 int
 rte_sched_queue_read_stats(struct rte_sched_port *port,
 	uint32_t queue_id,
@@ -2041,6 +2055,7 @@ rte_sched_port_enqueue_qwa(struct rte_sched_port *port,
  * ----->|_______|----->|_______|----->|_______|----->|_______|----->
  *   p01            p11            p21            p31
  */
+RTE_EXPORT_SYMBOL(rte_sched_port_enqueue)
 int
 rte_sched_port_enqueue(struct rte_sched_port *port, struct rte_mbuf **pkts,
 		       uint32_t n_pkts)
@@ -2952,6 +2967,7 @@ rte_sched_port_exceptions(struct rte_sched_subport *subport, int second_pass)
 	return exceptions;
 }
 
+RTE_EXPORT_SYMBOL(rte_sched_port_dequeue)
 int
 rte_sched_port_dequeue(struct rte_sched_port *port, struct rte_mbuf **pkts, uint32_t n_pkts)
 {
diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index 1e980343fe..c47fe44da0 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -8,6 +8,7 @@
 #include <ctype.h>
 #include <stdlib.h>
 
+#include <eal_export.h>
 #include <rte_cryptodev.h>
 #include <dev_driver.h>
 #include <rte_telemetry.h>
@@ -30,9 +31,12 @@
 #define RTE_SECURITY_DYNFIELD_NAME "rte_security_dynfield_metadata"
 #define RTE_SECURITY_OOP_DYNFIELD_NAME "rte_security_oop_dynfield_metadata"
 
+RTE_EXPORT_SYMBOL(rte_security_dynfield_offset)
 int rte_security_dynfield_offset = -1;
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_oop_dynfield_offset, 23.11)
 int rte_security_oop_dynfield_offset = -1;
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_security_dynfield_register)
 int
 rte_security_dynfield_register(void)
 {
@@ -46,6 +50,7 @@ rte_security_dynfield_register(void)
 	return rte_security_dynfield_offset;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_security_oop_dynfield_register)
 int
 rte_security_oop_dynfield_register(void)
 {
@@ -60,6 +65,7 @@ rte_security_oop_dynfield_register(void)
 	return rte_security_oop_dynfield_offset;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_session_create)
 void *
 rte_security_session_create(void *ctx,
 			    struct rte_security_session_conf *conf,
@@ -94,6 +100,7 @@ rte_security_session_create(void *ctx,
 	return (void *)sess;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_session_update)
 int
 rte_security_session_update(void *ctx, void *sess, struct rte_security_session_conf *conf)
 {
@@ -107,6 +114,7 @@ rte_security_session_update(void *ctx, void *sess, struct rte_security_session_c
 	return instance->ops->session_update(instance->device, sess, conf);
 }
 
+RTE_EXPORT_SYMBOL(rte_security_session_get_size)
 unsigned int
 rte_security_session_get_size(void *ctx)
 {
@@ -118,6 +126,7 @@ rte_security_session_get_size(void *ctx)
 			instance->ops->session_get_size(instance->device));
 }
 
+RTE_EXPORT_SYMBOL(rte_security_session_stats_get)
 int
 rte_security_session_stats_get(void *ctx, void *sess, struct rte_security_stats *stats)
 {
@@ -131,6 +140,7 @@ rte_security_session_stats_get(void *ctx, void *sess, struct rte_security_stats
 	return instance->ops->session_stats_get(instance->device, sess, stats);
 }
 
+RTE_EXPORT_SYMBOL(rte_security_session_destroy)
 int
 rte_security_session_destroy(void *ctx, void *sess)
 {
@@ -153,6 +163,7 @@ rte_security_session_destroy(void *ctx, void *sess)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_create)
 int
 rte_security_macsec_sc_create(void *ctx, struct rte_security_macsec_sc *conf)
 {
@@ -169,6 +180,7 @@ rte_security_macsec_sc_create(void *ctx, struct rte_security_macsec_sc *conf)
 	return sc_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_create)
 int
 rte_security_macsec_sa_create(void *ctx, struct rte_security_macsec_sa *conf)
 {
@@ -185,6 +197,7 @@ rte_security_macsec_sa_create(void *ctx, struct rte_security_macsec_sa *conf)
 	return sa_id;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_destroy)
 int
 rte_security_macsec_sc_destroy(void *ctx, uint16_t sc_id,
 			       enum rte_security_macsec_direction dir)
@@ -204,6 +217,7 @@ rte_security_macsec_sc_destroy(void *ctx, uint16_t sc_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_destroy)
 int
 rte_security_macsec_sa_destroy(void *ctx, uint16_t sa_id,
 			       enum rte_security_macsec_direction dir)
@@ -223,6 +237,7 @@ rte_security_macsec_sa_destroy(void *ctx, uint16_t sa_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sc_stats_get)
 int
 rte_security_macsec_sc_stats_get(void *ctx, uint16_t sc_id,
 				 enum rte_security_macsec_direction dir,
@@ -236,6 +251,7 @@ rte_security_macsec_sc_stats_get(void *ctx, uint16_t sc_id,
 	return instance->ops->macsec_sc_stats_get(instance->device, sc_id, dir, stats);
 }
 
+RTE_EXPORT_SYMBOL(rte_security_macsec_sa_stats_get)
 int
 rte_security_macsec_sa_stats_get(void *ctx, uint16_t sa_id,
 				 enum rte_security_macsec_direction dir,
@@ -249,6 +265,7 @@ rte_security_macsec_sa_stats_get(void *ctx, uint16_t sa_id,
 	return instance->ops->macsec_sa_stats_get(instance->device, sa_id, dir, stats);
 }
 
+RTE_EXPORT_SYMBOL(__rte_security_set_pkt_metadata)
 int
 __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void *params)
 {
@@ -263,6 +280,7 @@ __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void
 	return instance->ops->set_pkt_metadata(instance->device, sess, m, params);
 }
 
+RTE_EXPORT_SYMBOL(rte_security_capabilities_get)
 const struct rte_security_capability *
 rte_security_capabilities_get(void *ctx)
 {
@@ -273,6 +291,7 @@ rte_security_capabilities_get(void *ctx)
 	return instance->ops->capabilities_get(instance->device);
 }
 
+RTE_EXPORT_SYMBOL(rte_security_capability_get)
 const struct rte_security_capability *
 rte_security_capability_get(void *ctx, struct rte_security_capability_idx *idx)
 {
@@ -325,6 +344,7 @@ rte_security_capability_get(void *ctx, struct rte_security_capability_idx *idx)
 	return NULL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_rx_inject_configure, 23.11)
 int
 rte_security_rx_inject_configure(void *ctx, uint16_t port_id, bool enable)
 {
@@ -337,6 +357,7 @@ rte_security_rx_inject_configure(void *ctx, uint16_t port_id, bool enable)
 	return instance->ops->rx_inject_configure(instance->device, port_id, enable);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_security_inb_pkt_rx_inject, 23.11)
 uint16_t
 rte_security_inb_pkt_rx_inject(void *ctx, struct rte_mbuf **pkts, void **sess,
 			       uint16_t nb_pkts)
diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index 7261281dc1..4c78fe4b4b 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <sys/queue.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_eal_memconfig.h>
 #include <rte_errno.h>
@@ -44,6 +45,7 @@ rte_stack_get_memsize(unsigned int count, uint32_t flags)
 		return rte_stack_std_get_memsize(count);
 }
 
+RTE_EXPORT_SYMBOL(rte_stack_create)
 struct rte_stack *
 rte_stack_create(const char *name, unsigned int count, int socket_id,
 		 uint32_t flags)
@@ -129,6 +131,7 @@ rte_stack_create(const char *name, unsigned int count, int socket_id,
 	return s;
 }
 
+RTE_EXPORT_SYMBOL(rte_stack_free)
 void
 rte_stack_free(struct rte_stack *s)
 {
@@ -161,6 +164,7 @@ rte_stack_free(struct rte_stack *s)
 	rte_memzone_free(s->memzone);
 }
 
+RTE_EXPORT_SYMBOL(rte_stack_lookup)
 struct rte_stack *
 rte_stack_lookup(const char *name)
 {
diff --git a/lib/table/rte_swx_table_em.c b/lib/table/rte_swx_table_em.c
index 2f042d74b3..4ec54cb635 100644
--- a/lib/table/rte_swx_table_em.c
+++ b/lib/table/rte_swx_table_em.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_prefetch.h>
 #include <rte_jhash.h>
@@ -647,6 +648,7 @@ table_footprint(struct rte_swx_table_params *params,
 	return memory_footprint;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_unoptimized_ops, 20.11)
 struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get_unoptimized,
@@ -657,6 +659,7 @@ struct rte_swx_table_ops rte_swx_table_exact_match_unoptimized_ops = {
 	.free = table_free,
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_exact_match_ops, 20.11)
 struct rte_swx_table_ops rte_swx_table_exact_match_ops = {
 	.footprint_get = table_footprint,
 	.mailbox_size_get = table_mailbox_size_get,
diff --git a/lib/table/rte_swx_table_learner.c b/lib/table/rte_swx_table_learner.c
index 55a3645e06..2d61bceeaf 100644
--- a/lib/table/rte_swx_table_learner.c
+++ b/lib/table/rte_swx_table_learner.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_prefetch.h>
@@ -272,6 +273,7 @@ table_entry_id_get(struct table *t, struct table_bucket *b, size_t bucket_key_po
 	return (bucket_id << TABLE_KEYS_PER_BUCKET_LOG2) + bucket_key_pos;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_footprint_get, 21.11)
 uint64_t
 rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 {
@@ -283,6 +285,7 @@ rte_swx_table_learner_footprint_get(struct rte_swx_table_learner_params *params)
 	return status ? 0 : p.total_size;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_create, 21.11)
 void *
 rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int numa_node)
 {
@@ -306,6 +309,7 @@ rte_swx_table_learner_create(struct rte_swx_table_learner_params *params, int nu
 	return t;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_free, 21.11)
 void
 rte_swx_table_learner_free(void *table)
 {
@@ -317,6 +321,7 @@ rte_swx_table_learner_free(void *table)
 	env_free(t, t->params.total_size);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_timeout_update, 22.07)
 int
 rte_swx_table_learner_timeout_update(void *table,
 				     uint32_t key_timeout_id,
@@ -354,12 +359,14 @@ struct mailbox {
 	int state;
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_mailbox_size_get, 21.11)
 uint64_t
 rte_swx_table_learner_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_lookup, 21.11)
 int
 rte_swx_table_learner_lookup(void *table,
 			     void *mailbox,
@@ -446,6 +453,7 @@ rte_swx_table_learner_lookup(void *table,
 	}
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm, 22.07)
 void
 rte_swx_table_learner_rearm(void *table,
 			    void *mailbox,
@@ -469,6 +477,7 @@ rte_swx_table_learner_rearm(void *table,
 	b->time[bucket_key_pos] = (input_time + key_timeout) >> 32;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_rearm_new, 22.07)
 void
 rte_swx_table_learner_rearm_new(void *table,
 				void *mailbox,
@@ -493,6 +502,7 @@ rte_swx_table_learner_rearm_new(void *table,
 	b->key_timeout_id[bucket_key_pos] = (uint8_t)key_timeout_id;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_add, 21.11)
 uint32_t
 rte_swx_table_learner_add(void *table,
 			  void *mailbox,
@@ -569,6 +579,7 @@ rte_swx_table_learner_add(void *table,
 	return 1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_learner_delete, 21.11)
 void
 rte_swx_table_learner_delete(void *table __rte_unused,
 			     void *mailbox)
diff --git a/lib/table/rte_swx_table_selector.c b/lib/table/rte_swx_table_selector.c
index 18e021fe6f..127c6c77f2 100644
--- a/lib/table/rte_swx_table_selector.c
+++ b/lib/table/rte_swx_table_selector.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 
 #include "rte_swx_table_selector.h"
@@ -170,6 +171,7 @@ struct table {
 	uint32_t n_members_per_group_max_log2;
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_footprint_get, 21.08)
 uint64_t
 rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_per_group_max)
 {
@@ -182,6 +184,7 @@ rte_swx_table_selector_footprint_get(uint32_t n_groups_max, uint32_t n_members_p
 	return sizeof(struct table) + group_table_size + members_size;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_free, 21.08)
 void
 rte_swx_table_selector_free(void *table)
 {
@@ -259,6 +262,7 @@ group_set(struct table *t,
 	  uint32_t group_id,
 	  struct rte_swx_table_selector_group *group);
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_create, 21.08)
 void *
 rte_swx_table_selector_create(struct rte_swx_table_selector_params *params,
 			      struct rte_swx_table_selector_group **groups,
@@ -528,6 +532,7 @@ group_set(struct table *t,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_group_set, 21.08)
 int
 rte_swx_table_selector_group_set(void *table,
 				 uint32_t group_id,
@@ -542,12 +547,14 @@ struct mailbox {
 
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_mailbox_size_get, 21.08)
 uint64_t
 rte_swx_table_selector_mailbox_size_get(void)
 {
 	return sizeof(struct mailbox);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_selector_select, 21.08)
 int
 rte_swx_table_selector_select(void *table,
 			      void *mailbox __rte_unused,
diff --git a/lib/table/rte_swx_table_wm.c b/lib/table/rte_swx_table_wm.c
index 58afb35d46..c57738dda3 100644
--- a/lib/table/rte_swx_table_wm.c
+++ b/lib/table/rte_swx_table_wm.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <stdio.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_acl.h>
@@ -457,6 +458,7 @@ table_lookup(void *table,
 	return 1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_swx_table_wildcard_match_ops, 21.05)
 struct rte_swx_table_ops rte_swx_table_wildcard_match_ops = {
 	.footprint_get = NULL,
 	.mailbox_size_get = table_mailbox_size_get,
diff --git a/lib/table/rte_table_acl.c b/lib/table/rte_table_acl.c
index 78779bbc4d..74fa0145d8 100644
--- a/lib/table/rte_table_acl.c
+++ b/lib/table/rte_table_acl.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -781,6 +782,7 @@ rte_table_acl_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_acl_ops)
 struct rte_table_ops rte_table_acl_ops = {
 	.f_create = rte_table_acl_create,
 	.f_free = rte_table_acl_free,
diff --git a/lib/table/rte_table_array.c b/lib/table/rte_table_array.c
index 84b5d67e90..55356e5999 100644
--- a/lib/table/rte_table_array.c
+++ b/lib/table/rte_table_array.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -196,6 +197,7 @@ rte_table_array_stats_read(void *table, struct rte_table_stats *stats, int clear
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_array_ops)
 struct rte_table_ops rte_table_array_ops = {
 	.f_create = rte_table_array_create,
 	.f_free = rte_table_array_free,
diff --git a/lib/table/rte_table_hash_cuckoo.c b/lib/table/rte_table_hash_cuckoo.c
index 388eae918c..a2b920fa92 100644
--- a/lib/table/rte_table_hash_cuckoo.c
+++ b/lib/table/rte_table_hash_cuckoo.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -313,6 +314,7 @@ rte_table_hash_cuckoo_stats_read(void *table, struct rte_table_stats *stats,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_cuckoo_ops)
 struct rte_table_ops rte_table_hash_cuckoo_ops = {
 	.f_create = rte_table_hash_cuckoo_create,
 	.f_free = rte_table_hash_cuckoo_free,
diff --git a/lib/table/rte_table_hash_ext.c b/lib/table/rte_table_hash_ext.c
index 91e5037b41..86e8eeb4c8 100644
--- a/lib/table/rte_table_hash_ext.c
+++ b/lib/table/rte_table_hash_ext.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -997,6 +998,7 @@ rte_table_hash_ext_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_ext_ops)
 struct rte_table_ops rte_table_hash_ext_ops	 = {
 	.f_create = rte_table_hash_ext_create,
 	.f_free = rte_table_hash_ext_free,
diff --git a/lib/table/rte_table_hash_key16.c b/lib/table/rte_table_hash_key16.c
index 67b77c16a0..da24a7985d 100644
--- a/lib/table/rte_table_hash_key16.c
+++ b/lib/table/rte_table_hash_key16.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -1166,6 +1167,7 @@ rte_table_hash_key16_stats_read(void *table, struct rte_table_stats *stats, int
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key16_lru_ops)
 struct rte_table_ops rte_table_hash_key16_lru_ops = {
 	.f_create = rte_table_hash_create_key16_lru,
 	.f_free = rte_table_hash_free_key16_lru,
@@ -1177,6 +1179,7 @@ struct rte_table_ops rte_table_hash_key16_lru_ops = {
 	.f_stats = rte_table_hash_key16_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key16_ext_ops)
 struct rte_table_ops rte_table_hash_key16_ext_ops = {
 	.f_create = rte_table_hash_create_key16_ext,
 	.f_free = rte_table_hash_free_key16_ext,
diff --git a/lib/table/rte_table_hash_key32.c b/lib/table/rte_table_hash_key32.c
index 1aa86c6a49..297931a2a5 100644
--- a/lib/table/rte_table_hash_key32.c
+++ b/lib/table/rte_table_hash_key32.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -1199,6 +1200,7 @@ rte_table_hash_key32_stats_read(void *table, struct rte_table_stats *stats, int
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key32_lru_ops)
 struct rte_table_ops rte_table_hash_key32_lru_ops = {
 	.f_create = rte_table_hash_create_key32_lru,
 	.f_free = rte_table_hash_free_key32_lru,
@@ -1210,6 +1212,7 @@ struct rte_table_ops rte_table_hash_key32_lru_ops = {
 	.f_stats = rte_table_hash_key32_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key32_ext_ops)
 struct rte_table_ops rte_table_hash_key32_ext_ops = {
 	.f_create = rte_table_hash_create_key32_ext,
 	.f_free = rte_table_hash_free_key32_ext,
diff --git a/lib/table/rte_table_hash_key8.c b/lib/table/rte_table_hash_key8.c
index c8d72b333d..746863082f 100644
--- a/lib/table/rte_table_hash_key8.c
+++ b/lib/table/rte_table_hash_key8.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -1133,6 +1134,7 @@ rte_table_hash_key8_stats_read(void *table, struct rte_table_stats *stats, int c
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key8_lru_ops)
 struct rte_table_ops rte_table_hash_key8_lru_ops = {
 	.f_create = rte_table_hash_create_key8_lru,
 	.f_free = rte_table_hash_free_key8_lru,
@@ -1144,6 +1146,7 @@ struct rte_table_ops rte_table_hash_key8_lru_ops = {
 	.f_stats = rte_table_hash_key8_stats_read,
 };
 
+RTE_EXPORT_SYMBOL(rte_table_hash_key8_ext_ops)
 struct rte_table_ops rte_table_hash_key8_ext_ops = {
 	.f_create = rte_table_hash_create_key8_ext,
 	.f_free = rte_table_hash_free_key8_ext,
diff --git a/lib/table/rte_table_hash_lru.c b/lib/table/rte_table_hash_lru.c
index 801e48f5ba..548f5eebf2 100644
--- a/lib/table/rte_table_hash_lru.c
+++ b/lib/table/rte_table_hash_lru.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -945,6 +946,7 @@ rte_table_hash_lru_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_hash_lru_ops)
 struct rte_table_ops rte_table_hash_lru_ops = {
 	.f_create = rte_table_hash_lru_create,
 	.f_free = rte_table_hash_lru_free,
diff --git a/lib/table/rte_table_lpm.c b/lib/table/rte_table_lpm.c
index 3e10c14d40..6fd0c30f85 100644
--- a/lib/table/rte_table_lpm.c
+++ b/lib/table/rte_table_lpm.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_byteorder.h>
@@ -355,6 +356,7 @@ rte_table_lpm_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_lpm_ops)
 struct rte_table_ops rte_table_lpm_ops = {
 	.f_create = rte_table_lpm_create,
 	.f_free = rte_table_lpm_free,
diff --git a/lib/table/rte_table_lpm_ipv6.c b/lib/table/rte_table_lpm_ipv6.c
index dea11130d3..9159784dfa 100644
--- a/lib/table/rte_table_lpm_ipv6.c
+++ b/lib/table/rte_table_lpm_ipv6.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -356,6 +357,7 @@ rte_table_lpm_ipv6_stats_read(void *table, struct rte_table_stats *stats, int cl
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_lpm_ipv6_ops)
 struct rte_table_ops rte_table_lpm_ipv6_ops = {
 	.f_create = rte_table_lpm_ipv6_create,
 	.f_free = rte_table_lpm_ipv6_free,
diff --git a/lib/table/rte_table_stub.c b/lib/table/rte_table_stub.c
index 7147f7146e..3d2ac55c49 100644
--- a/lib/table/rte_table_stub.c
+++ b/lib/table/rte_table_stub.c
@@ -4,6 +4,7 @@
 
 #include <string.h>
 
+#include <eal_export.h>
 #include <rte_malloc.h>
 
 #include "rte_table_stub.h"
@@ -81,6 +82,7 @@ rte_table_stub_stats_read(void *table, struct rte_table_stats *stats, int clear)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_table_stub_ops)
 struct rte_table_ops rte_table_stub_ops = {
 	.f_create = rte_table_stub_create,
 	.f_free = NULL,
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index 31a2c91c06..1cbbffbf3f 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -15,6 +15,7 @@
 
 /* we won't link against libbsd, so just always use DPDKs-specific strlcpy */
 #undef RTE_USE_LIBBSD
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_spinlock.h>
@@ -114,12 +115,14 @@ register_cmd(const char *cmd, const char *help,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd)
 int
 rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
 {
 	return register_cmd(cmd, help, fn, NULL, NULL);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11)
 int
 rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help)
 {
@@ -652,6 +655,7 @@ telemetry_v2_init(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_init)
 int32_t
 rte_telemetry_init(const char *runtime_dir, const char *rte_version, rte_cpuset_t *cpuset)
 {
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 3b1a2408df..c120600622 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -10,12 +10,14 @@
 #undef RTE_USE_LIBBSD
 #include <stdbool.h>
 
+#include <eal_export.h>
 #include <rte_string_fns.h>
 
 #include "telemetry_data.h"
 
 #define RTE_TEL_UINT_HEX_STR_BUF_LEN 64
 
+RTE_EXPORT_SYMBOL(rte_tel_data_start_array)
 int
 rte_tel_data_start_array(struct rte_tel_data *d, enum rte_tel_value_type type)
 {
@@ -30,6 +32,7 @@ rte_tel_data_start_array(struct rte_tel_data *d, enum rte_tel_value_type type)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_start_dict)
 int
 rte_tel_data_start_dict(struct rte_tel_data *d)
 {
@@ -38,6 +41,7 @@ rte_tel_data_start_dict(struct rte_tel_data *d)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_string)
 int
 rte_tel_data_string(struct rte_tel_data *d, const char *str)
 {
@@ -50,6 +54,7 @@ rte_tel_data_string(struct rte_tel_data *d, const char *str)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_string)
 int
 rte_tel_data_add_array_string(struct rte_tel_data *d, const char *str)
 {
@@ -62,6 +67,7 @@ rte_tel_data_add_array_string(struct rte_tel_data *d, const char *str)
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_int)
 int
 rte_tel_data_add_array_int(struct rte_tel_data *d, int64_t x)
 {
@@ -73,6 +79,7 @@ rte_tel_data_add_array_int(struct rte_tel_data *d, int64_t x)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_uint)
 int
 rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x)
 {
@@ -84,12 +91,14 @@ rte_tel_data_add_array_uint(struct rte_tel_data *d, uint64_t x)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_u64)
 int
 rte_tel_data_add_array_u64(struct rte_tel_data *d, uint64_t x)
 {
 	return rte_tel_data_add_array_uint(d, x);
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_array_container)
 int
 rte_tel_data_add_array_container(struct rte_tel_data *d,
 		struct rte_tel_data *val, int keep)
@@ -122,6 +131,7 @@ rte_tel_uint_to_hex_encoded_str(char *buf, size_t buf_len, uint64_t val,
 	return len < (int)buf_len ? 0 : -EINVAL;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_array_uint_hex, 23.03)
 int
 rte_tel_data_add_array_uint_hex(struct rte_tel_data *d, uint64_t val,
 				uint8_t display_bitwidth)
@@ -152,6 +162,7 @@ valid_name(const char *name)
 	return true;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_string)
 int
 rte_tel_data_add_dict_string(struct rte_tel_data *d, const char *name,
 		const char *val)
@@ -177,6 +188,7 @@ rte_tel_data_add_dict_string(struct rte_tel_data *d, const char *name,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_int)
 int
 rte_tel_data_add_dict_int(struct rte_tel_data *d, const char *name, int64_t val)
 {
@@ -196,6 +208,7 @@ rte_tel_data_add_dict_int(struct rte_tel_data *d, const char *name, int64_t val)
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_uint)
 int
 rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 		const char *name, uint64_t val)
@@ -216,12 +229,14 @@ rte_tel_data_add_dict_uint(struct rte_tel_data *d,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_u64)
 int
 rte_tel_data_add_dict_u64(struct rte_tel_data *d, const char *name, uint64_t val)
 {
 	return rte_tel_data_add_dict_uint(d, name, val);
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_add_dict_container)
 int
 rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
 		struct rte_tel_data *val, int keep)
@@ -247,6 +262,7 @@ rte_tel_data_add_dict_container(struct rte_tel_data *d, const char *name,
 	return bytes < RTE_TEL_MAX_STRING_LEN ? 0 : E2BIG;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_tel_data_add_dict_uint_hex, 23.03)
 int
 rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 			       uint64_t val, uint8_t display_bitwidth)
@@ -263,12 +279,14 @@ rte_tel_data_add_dict_uint_hex(struct rte_tel_data *d, const char *name,
 	return rte_tel_data_add_dict_string(d, name, hex_str);
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_alloc)
 struct rte_tel_data *
 rte_tel_data_alloc(void)
 {
 	return malloc(sizeof(struct rte_tel_data));
 }
 
+RTE_EXPORT_SYMBOL(rte_tel_data_free)
 void
 rte_tel_data_free(struct rte_tel_data *data)
 {
diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 578230732c..89ec750c09 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -12,6 +12,7 @@
 
 /* we won't link against libbsd, so just always use DPDKs-specific strlcpy */
 #undef RTE_USE_LIBBSD
+#include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
 #include <rte_spinlock.h>
@@ -52,6 +53,7 @@ struct json_command callbacks[TELEMETRY_LEGACY_MAX_CALLBACKS] = {
 int num_legacy_callbacks = 1;
 static rte_spinlock_t callback_sl = RTE_SPINLOCK_INITIALIZER;
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_telemetry_legacy_register)
 int
 rte_telemetry_legacy_register(const char *cmd,
 		enum rte_telemetry_legacy_data_req data_req,
diff --git a/lib/timer/rte_timer.c b/lib/timer/rte_timer.c
index bb8b6a651d..b349c2abbc 100644
--- a/lib/timer/rte_timer.c
+++ b/lib/timer/rte_timer.c
@@ -8,6 +8,7 @@
 #include <inttypes.h>
 #include <assert.h>
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_eal_memconfig.h>
@@ -84,6 +85,7 @@ timer_data_valid(uint32_t id)
 	timer_data = &rte_timer_data_arr[id];				\
 } while (0)
 
+RTE_EXPORT_SYMBOL(rte_timer_data_alloc)
 int
 rte_timer_data_alloc(uint32_t *id_ptr)
 {
@@ -108,6 +110,7 @@ rte_timer_data_alloc(uint32_t *id_ptr)
 	return -ENOSPC;
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_data_dealloc)
 int
 rte_timer_data_dealloc(uint32_t id)
 {
@@ -125,6 +128,7 @@ rte_timer_data_dealloc(uint32_t id)
  * secondary processes should be empty, the zeroth entry can be shared by
  * multiple processes.
  */
+RTE_EXPORT_SYMBOL(rte_timer_subsystem_init)
 int
 rte_timer_subsystem_init(void)
 {
@@ -184,6 +188,7 @@ rte_timer_subsystem_init(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_subsystem_finalize)
 void
 rte_timer_subsystem_finalize(void)
 {
@@ -203,6 +208,7 @@ rte_timer_subsystem_finalize(void)
 }
 
 /* Initialize the timer handle tim for use */
+RTE_EXPORT_SYMBOL(rte_timer_init)
 void
 rte_timer_init(struct rte_timer *tim)
 {
@@ -539,6 +545,7 @@ __rte_timer_reset(struct rte_timer *tim, uint64_t expire,
 }
 
 /* Reset and start the timer associated with the timer handle tim */
+RTE_EXPORT_SYMBOL(rte_timer_reset)
 int
 rte_timer_reset(struct rte_timer *tim, uint64_t ticks,
 		      enum rte_timer_type type, unsigned int tim_lcore,
@@ -548,6 +555,7 @@ rte_timer_reset(struct rte_timer *tim, uint64_t ticks,
 				   tim_lcore, fct, arg);
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_alt_reset)
 int
 rte_timer_alt_reset(uint32_t timer_data_id, struct rte_timer *tim,
 		    uint64_t ticks, enum rte_timer_type type,
@@ -569,6 +577,7 @@ rte_timer_alt_reset(uint32_t timer_data_id, struct rte_timer *tim,
 }
 
 /* loop until rte_timer_reset() succeed */
+RTE_EXPORT_SYMBOL(rte_timer_reset_sync)
 void
 rte_timer_reset_sync(struct rte_timer *tim, uint64_t ticks,
 		     enum rte_timer_type type, unsigned tim_lcore,
@@ -618,12 +627,14 @@ __rte_timer_stop(struct rte_timer *tim,
 }
 
 /* Stop the timer associated with the timer handle tim */
+RTE_EXPORT_SYMBOL(rte_timer_stop)
 int
 rte_timer_stop(struct rte_timer *tim)
 {
 	return rte_timer_alt_stop(default_data_id, tim);
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_alt_stop)
 int
 rte_timer_alt_stop(uint32_t timer_data_id, struct rte_timer *tim)
 {
@@ -635,6 +646,7 @@ rte_timer_alt_stop(uint32_t timer_data_id, struct rte_timer *tim)
 }
 
 /* loop until rte_timer_stop() succeed */
+RTE_EXPORT_SYMBOL(rte_timer_stop_sync)
 void
 rte_timer_stop_sync(struct rte_timer *tim)
 {
@@ -643,6 +655,7 @@ rte_timer_stop_sync(struct rte_timer *tim)
 }
 
 /* Test the PENDING status of the timer handle tim */
+RTE_EXPORT_SYMBOL(rte_timer_pending)
 int
 rte_timer_pending(struct rte_timer *tim)
 {
@@ -777,6 +790,7 @@ __rte_timer_manage(struct rte_timer_data *timer_data)
 	priv_timer[lcore_id].running_tim = NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_manage)
 int
 rte_timer_manage(void)
 {
@@ -789,6 +803,7 @@ rte_timer_manage(void)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_alt_manage)
 int
 rte_timer_alt_manage(uint32_t timer_data_id,
 		     unsigned int *poll_lcores,
@@ -970,6 +985,7 @@ rte_timer_alt_manage(uint32_t timer_data_id,
 }
 
 /* Walk pending lists, stopping timers and calling user-specified function */
+RTE_EXPORT_SYMBOL(rte_timer_stop_all)
 int
 rte_timer_stop_all(uint32_t timer_data_id, unsigned int *walk_lcores,
 		   int nb_walk_lcores,
@@ -1002,6 +1018,7 @@ rte_timer_stop_all(uint32_t timer_data_id, unsigned int *walk_lcores,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_next_ticks)
 int64_t
 rte_timer_next_ticks(void)
 {
@@ -1055,12 +1072,14 @@ __rte_timer_dump_stats(struct rte_timer_data *timer_data __rte_unused, FILE *f)
 #endif
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_dump_stats)
 int
 rte_timer_dump_stats(FILE *f)
 {
 	return rte_timer_alt_dump_stats(default_data_id, f);
 }
 
+RTE_EXPORT_SYMBOL(rte_timer_alt_dump_stats)
 int
 rte_timer_alt_dump_stats(uint32_t timer_data_id __rte_unused, FILE *f)
 {
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 4c6c551c3d..9b4f332f94 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <fcntl.h>
 
+#include <eal_export.h>
 #include <rte_thread.h>
 #include <rte_log.h>
 
@@ -571,6 +572,7 @@ find_vhost_user_socket(const char *path)
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_attach_vdpa_device)
 int
 rte_vhost_driver_attach_vdpa_device(const char *path,
 		struct rte_vdpa_device *dev)
@@ -589,6 +591,7 @@ rte_vhost_driver_attach_vdpa_device(const char *path,
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_detach_vdpa_device)
 int
 rte_vhost_driver_detach_vdpa_device(const char *path)
 {
@@ -603,6 +606,7 @@ rte_vhost_driver_detach_vdpa_device(const char *path)
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_device)
 struct rte_vdpa_device *
 rte_vhost_driver_get_vdpa_device(const char *path)
 {
@@ -618,6 +622,7 @@ rte_vhost_driver_get_vdpa_device(const char *path)
 	return dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_vdpa_dev_type)
 int
 rte_vhost_driver_get_vdpa_dev_type(const char *path, uint32_t *type)
 {
@@ -646,6 +651,7 @@ rte_vhost_driver_get_vdpa_dev_type(const char *path, uint32_t *type)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_disable_features)
 int
 rte_vhost_driver_disable_features(const char *path, uint64_t features)
 {
@@ -666,6 +672,7 @@ rte_vhost_driver_disable_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_enable_features)
 int
 rte_vhost_driver_enable_features(const char *path, uint64_t features)
 {
@@ -689,6 +696,7 @@ rte_vhost_driver_enable_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_features)
 int
 rte_vhost_driver_set_features(const char *path, uint64_t features)
 {
@@ -710,6 +718,7 @@ rte_vhost_driver_set_features(const char *path, uint64_t features)
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_features)
 int
 rte_vhost_driver_get_features(const char *path, uint64_t *features)
 {
@@ -745,6 +754,7 @@ rte_vhost_driver_get_features(const char *path, uint64_t *features)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_protocol_features)
 int
 rte_vhost_driver_set_protocol_features(const char *path,
 		uint64_t protocol_features)
@@ -759,6 +769,7 @@ rte_vhost_driver_set_protocol_features(const char *path,
 	return vsocket ? 0 : -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_protocol_features)
 int
 rte_vhost_driver_get_protocol_features(const char *path,
 		uint64_t *protocol_features)
@@ -797,6 +808,7 @@ rte_vhost_driver_get_protocol_features(const char *path,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_get_queue_num)
 int
 rte_vhost_driver_get_queue_num(const char *path, uint32_t *queue_num)
 {
@@ -832,6 +844,7 @@ rte_vhost_driver_get_queue_num(const char *path, uint32_t *queue_num)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_set_max_queue_num)
 int
 rte_vhost_driver_set_max_queue_num(const char *path, uint32_t max_queue_pairs)
 {
@@ -889,6 +902,7 @@ vhost_user_socket_mem_free(struct vhost_user_socket *vsocket)
  * (the default case), or client (when RTE_VHOST_USER_CLIENT) flag
  * is set.
  */
+RTE_EXPORT_SYMBOL(rte_vhost_driver_register)
 int
 rte_vhost_driver_register(const char *path, uint64_t flags)
 {
@@ -1054,6 +1068,7 @@ vhost_user_remove_reconnect(struct vhost_user_socket *vsocket)
 /**
  * Unregister the specified vhost socket
  */
+RTE_EXPORT_SYMBOL(rte_vhost_driver_unregister)
 int
 rte_vhost_driver_unregister(const char *path)
 {
@@ -1137,6 +1152,7 @@ rte_vhost_driver_unregister(const char *path)
 /*
  * Register ops so that we can add/remove device to data core.
  */
+RTE_EXPORT_SYMBOL(rte_vhost_driver_callback_register)
 int
 rte_vhost_driver_callback_register(const char *path,
 	struct rte_vhost_device_ops const * const ops)
@@ -1164,6 +1180,7 @@ vhost_driver_callback_get(const char *path)
 	return vsocket ? vsocket->notify_ops : NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_driver_start)
 int
 rte_vhost_driver_start(const char *path)
 {
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index 329dd572b7..bc2dd8d2e1 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -11,6 +11,7 @@
 #include <sys/queue.h>
 
 #include <dev_driver.h>
+#include <eal_export.h>
 #include <rte_class.h>
 #include <rte_malloc.h>
 #include <rte_spinlock.h>
@@ -49,6 +50,7 @@ __vdpa_find_device_by_name(const char *name)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_find_device_by_name)
 struct rte_vdpa_device *
 rte_vdpa_find_device_by_name(const char *name)
 {
@@ -61,6 +63,7 @@ rte_vdpa_find_device_by_name(const char *name)
 	return dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_rte_device)
 struct rte_device *
 rte_vdpa_get_rte_device(struct rte_vdpa_device *vdpa_dev)
 {
@@ -70,6 +73,7 @@ rte_vdpa_get_rte_device(struct rte_vdpa_device *vdpa_dev)
 	return vdpa_dev->device;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_register_device)
 struct rte_vdpa_device *
 rte_vdpa_register_device(struct rte_device *rte_dev,
 		struct rte_vdpa_dev_ops *ops)
@@ -125,6 +129,7 @@ rte_vdpa_register_device(struct rte_device *rte_dev,
 	return dev;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_unregister_device)
 int
 rte_vdpa_unregister_device(struct rte_vdpa_device *dev)
 {
@@ -146,6 +151,7 @@ rte_vdpa_unregister_device(struct rte_vdpa_device *dev)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdpa_relay_vring_used)
 int
 rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 {
@@ -257,6 +263,7 @@ rte_vdpa_relay_vring_used(int vid, uint16_t qid, void *vring_m)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_queue_num)
 int
 rte_vdpa_get_queue_num(struct rte_vdpa_device *dev, uint32_t *queue_num)
 {
@@ -266,6 +273,7 @@ rte_vdpa_get_queue_num(struct rte_vdpa_device *dev, uint32_t *queue_num)
 	return dev->ops->get_queue_num(dev, queue_num);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_features)
 int
 rte_vdpa_get_features(struct rte_vdpa_device *dev, uint64_t *features)
 {
@@ -275,6 +283,7 @@ rte_vdpa_get_features(struct rte_vdpa_device *dev, uint64_t *features)
 	return dev->ops->get_features(dev, features);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_protocol_features)
 int
 rte_vdpa_get_protocol_features(struct rte_vdpa_device *dev, uint64_t *features)
 {
@@ -285,6 +294,7 @@ rte_vdpa_get_protocol_features(struct rte_vdpa_device *dev, uint64_t *features)
 	return dev->ops->get_protocol_features(dev, features);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_stats_names)
 int
 rte_vdpa_get_stats_names(struct rte_vdpa_device *dev,
 		struct rte_vdpa_stat_name *stats_names,
@@ -299,6 +309,7 @@ rte_vdpa_get_stats_names(struct rte_vdpa_device *dev,
 	return dev->ops->get_stats_names(dev, stats_names, size);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_get_stats)
 int
 rte_vdpa_get_stats(struct rte_vdpa_device *dev, uint16_t qid,
 		struct rte_vdpa_stat *stats, unsigned int n)
@@ -312,6 +323,7 @@ rte_vdpa_get_stats(struct rte_vdpa_device *dev, uint16_t qid,
 	return dev->ops->get_stats(dev, qid, stats, n);
 }
 
+RTE_EXPORT_SYMBOL(rte_vdpa_reset_stats)
 int
 rte_vdpa_reset_stats(struct rte_vdpa_device *dev, uint16_t qid)
 {
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index f01ae6130e..0353a04dc8 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -12,6 +12,7 @@
 #include <numaif.h>
 #endif
 
+#include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -860,6 +861,7 @@ vhost_enable_linearbuf(int vid)
 	dev->linearbuf = 1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_mtu)
 int
 rte_vhost_get_mtu(int vid, uint16_t *mtu)
 {
@@ -879,6 +881,7 @@ rte_vhost_get_mtu(int vid, uint16_t *mtu)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_numa_node)
 int
 rte_vhost_get_numa_node(int vid)
 {
@@ -905,6 +908,7 @@ rte_vhost_get_numa_node(int vid)
 #endif
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_num)
 uint16_t
 rte_vhost_get_vring_num(int vid)
 {
@@ -916,6 +920,7 @@ rte_vhost_get_vring_num(int vid)
 	return dev->nr_vring;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_ifname)
 int
 rte_vhost_get_ifname(int vid, char *buf, size_t len)
 {
@@ -932,6 +937,7 @@ rte_vhost_get_ifname(int vid, char *buf, size_t len)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_features)
 int
 rte_vhost_get_negotiated_features(int vid, uint64_t *features)
 {
@@ -945,6 +951,7 @@ rte_vhost_get_negotiated_features(int vid, uint64_t *features)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_negotiated_protocol_features)
 int
 rte_vhost_get_negotiated_protocol_features(int vid,
 					   uint64_t *protocol_features)
@@ -959,6 +966,7 @@ rte_vhost_get_negotiated_protocol_features(int vid,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_mem_table)
 int
 rte_vhost_get_mem_table(int vid, struct rte_vhost_memory **mem)
 {
@@ -982,6 +990,7 @@ rte_vhost_get_mem_table(int vid, struct rte_vhost_memory **mem)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_vring)
 int
 rte_vhost_get_vhost_vring(int vid, uint16_t vring_idx,
 			  struct rte_vhost_vring *vring)
@@ -1018,6 +1027,7 @@ rte_vhost_get_vhost_vring(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vhost_ring_inflight)
 int
 rte_vhost_get_vhost_ring_inflight(int vid, uint16_t vring_idx,
 				  struct rte_vhost_ring_inflight *vring)
@@ -1053,6 +1063,7 @@ rte_vhost_get_vhost_ring_inflight(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_split)
 int
 rte_vhost_set_inflight_desc_split(int vid, uint16_t vring_idx,
 				  uint16_t idx)
@@ -1089,6 +1100,7 @@ rte_vhost_set_inflight_desc_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_set_inflight_desc_packed)
 int
 rte_vhost_set_inflight_desc_packed(int vid, uint16_t vring_idx,
 				   uint16_t head, uint16_t last,
@@ -1157,6 +1169,7 @@ rte_vhost_set_inflight_desc_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_split)
 int
 rte_vhost_clr_inflight_desc_split(int vid, uint16_t vring_idx,
 				  uint16_t last_used_idx, uint16_t idx)
@@ -1198,6 +1211,7 @@ rte_vhost_clr_inflight_desc_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_clr_inflight_desc_packed)
 int
 rte_vhost_clr_inflight_desc_packed(int vid, uint16_t vring_idx,
 				   uint16_t head)
@@ -1244,6 +1258,7 @@ rte_vhost_clr_inflight_desc_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_split)
 int
 rte_vhost_set_last_inflight_io_split(int vid, uint16_t vring_idx,
 				     uint16_t idx)
@@ -1279,6 +1294,7 @@ rte_vhost_set_last_inflight_io_split(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_set_last_inflight_io_packed)
 int
 rte_vhost_set_last_inflight_io_packed(int vid, uint16_t vring_idx,
 				      uint16_t head)
@@ -1329,6 +1345,7 @@ rte_vhost_set_last_inflight_io_packed(int vid, uint16_t vring_idx,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_vring_call)
 int
 rte_vhost_vring_call(int vid, uint16_t vring_idx)
 {
@@ -1365,6 +1382,7 @@ rte_vhost_vring_call(int vid, uint16_t vring_idx)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_vring_call_nonblock)
 int
 rte_vhost_vring_call_nonblock(int vid, uint16_t vring_idx)
 {
@@ -1402,6 +1420,7 @@ rte_vhost_vring_call_nonblock(int vid, uint16_t vring_idx)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_avail_entries)
 uint16_t
 rte_vhost_avail_entries(int vid, uint16_t queue_id)
 {
@@ -1498,6 +1517,7 @@ vhost_enable_guest_notification(struct virtio_net *dev,
 		return vhost_enable_notify_split(dev, vq, enable);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_enable_guest_notification)
 int
 rte_vhost_enable_guest_notification(int vid, uint16_t queue_id, int enable)
 {
@@ -1531,6 +1551,7 @@ rte_vhost_enable_guest_notification(int vid, uint16_t queue_id, int enable)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_notify_guest, 23.07)
 void
 rte_vhost_notify_guest(int vid, uint16_t queue_id)
 {
@@ -1567,6 +1588,7 @@ rte_vhost_notify_guest(int vid, uint16_t queue_id)
 	rte_rwlock_read_unlock(&vq->access_lock);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_log_write)
 void
 rte_vhost_log_write(int vid, uint64_t addr, uint64_t len)
 {
@@ -1578,6 +1600,7 @@ rte_vhost_log_write(int vid, uint64_t addr, uint64_t len)
 	vhost_log_write(dev, addr, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_log_used_vring)
 void
 rte_vhost_log_used_vring(int vid, uint16_t vring_idx,
 			 uint64_t offset, uint64_t len)
@@ -1598,6 +1621,7 @@ rte_vhost_log_used_vring(int vid, uint16_t vring_idx,
 	vhost_log_used_vring(dev, vq, offset, len);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_rx_queue_count)
 uint32_t
 rte_vhost_rx_queue_count(int vid, uint16_t qid)
 {
@@ -1635,6 +1659,7 @@ rte_vhost_rx_queue_count(int vid, uint16_t qid)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vdpa_device)
 struct rte_vdpa_device *
 rte_vhost_get_vdpa_device(int vid)
 {
@@ -1646,6 +1671,7 @@ rte_vhost_get_vdpa_device(int vid)
 	return dev->vdpa_dev;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_log_base)
 int
 rte_vhost_get_log_base(int vid, uint64_t *log_base,
 		uint64_t *log_size)
@@ -1661,6 +1687,7 @@ rte_vhost_get_log_base(int vid, uint64_t *log_base,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base)
 int
 rte_vhost_get_vring_base(int vid, uint16_t queue_id,
 		uint16_t *last_avail_idx, uint16_t *last_used_idx)
@@ -1691,6 +1718,7 @@ rte_vhost_get_vring_base(int vid, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_set_vring_base)
 int
 rte_vhost_set_vring_base(int vid, uint16_t queue_id,
 		uint16_t last_avail_idx, uint16_t last_used_idx)
@@ -1723,6 +1751,7 @@ rte_vhost_set_vring_base(int vid, uint16_t queue_id,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_vring_base_from_inflight)
 int
 rte_vhost_get_vring_base_from_inflight(int vid,
 				       uint16_t queue_id,
@@ -1757,6 +1786,7 @@ rte_vhost_get_vring_base_from_inflight(int vid,
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_extern_callback_register)
 int
 rte_vhost_extern_callback_register(int vid,
 		struct rte_vhost_user_extern_ops const * const ops, void *ctx)
@@ -1844,6 +1874,7 @@ async_channel_register(struct virtio_net *dev, struct vhost_virtqueue *vq)
 	return -1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register, 20.08)
 int
 rte_vhost_async_channel_register(int vid, uint16_t queue_id)
 {
@@ -1877,6 +1908,7 @@ rte_vhost_async_channel_register(int vid, uint16_t queue_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_register_thread_unsafe, 21.08)
 int
 rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -1899,6 +1931,7 @@ rte_vhost_async_channel_register_thread_unsafe(int vid, uint16_t queue_id)
 	return async_channel_register(dev, vq);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister, 20.08)
 int
 rte_vhost_async_channel_unregister(int vid, uint16_t queue_id)
 {
@@ -1945,6 +1978,7 @@ rte_vhost_async_channel_unregister(int vid, uint16_t queue_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_channel_unregister_thread_unsafe, 21.08)
 int
 rte_vhost_async_channel_unregister_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -1979,6 +2013,7 @@ rte_vhost_async_channel_unregister_thread_unsafe(int vid, uint16_t queue_id)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_configure, 22.03)
 int
 rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
 {
@@ -2055,6 +2090,7 @@ rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
 	return -1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight, 21.08)
 int
 rte_vhost_async_get_inflight(int vid, uint16_t queue_id)
 {
@@ -2093,6 +2129,7 @@ rte_vhost_async_get_inflight(int vid, uint16_t queue_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_get_inflight_thread_unsafe, 22.07)
 int
 rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id)
 {
@@ -2121,6 +2158,7 @@ rte_vhost_async_get_inflight_thread_unsafe(int vid, uint16_t queue_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_get_monitor_addr)
 int
 rte_vhost_get_monitor_addr(int vid, uint16_t queue_id,
 		struct rte_vhost_power_monitor_cond *pmc)
@@ -2171,6 +2209,7 @@ rte_vhost_get_monitor_addr(int vid, uint16_t queue_id,
 }
 
 
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get_names)
 int
 rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 		struct rte_vhost_stat_name *name, unsigned int size)
@@ -2198,6 +2237,7 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 	return VHOST_NB_VQ_STATS;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_get)
 int
 rte_vhost_vring_stats_get(int vid, uint16_t queue_id,
 		struct rte_vhost_stat *stats, unsigned int n)
@@ -2244,6 +2284,7 @@ rte_vhost_vring_stats_get(int vid, uint16_t queue_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_vring_stats_reset)
 int rte_vhost_vring_stats_reset(int vid, uint16_t queue_id)
 {
 	struct virtio_net *dev = get_device(vid);
@@ -2279,6 +2320,7 @@ int rte_vhost_vring_stats_reset(int vid, uint16_t queue_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_dma_unconfigure, 22.11)
 int
 rte_vhost_async_dma_unconfigure(int16_t dma_id, uint16_t vchan_id)
 {
diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 3c6c5dc114..f78daf98d1 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2017-2018 Intel Corporation
  */
+#include <eal_export.h>
 #include <rte_malloc.h>
 #include <rte_hash.h>
 #include <rte_jhash.h>
@@ -1782,6 +1783,7 @@ vhost_crypto_complete_one_vm_requests(struct rte_crypto_op **ops,
 	return processed;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_driver_start)
 int
 rte_vhost_crypto_driver_start(const char *path)
 {
@@ -1803,6 +1805,7 @@ rte_vhost_crypto_driver_start(const char *path)
 	return rte_vhost_driver_start(path);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_create)
 int
 rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 		struct rte_mempool *sess_pool,
@@ -1886,6 +1889,7 @@ rte_vhost_crypto_create(int vid, uint8_t cryptodev_id,
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_free)
 int
 rte_vhost_crypto_free(int vid)
 {
@@ -1915,6 +1919,7 @@ rte_vhost_crypto_free(int vid)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_set_zero_copy)
 int
 rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 {
@@ -1970,6 +1975,7 @@ rte_vhost_crypto_set_zero_copy(int vid, enum rte_vhost_crypto_zero_copy option)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_fetch_requests)
 uint16_t
 rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 		struct rte_crypto_op **ops, uint16_t nb_ops)
@@ -2099,6 +2105,7 @@ rte_vhost_crypto_fetch_requests(int vid, uint32_t qid,
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_crypto_finalize_requests)
 uint16_t
 rte_vhost_crypto_finalize_requests(struct rte_crypto_op **ops,
 		uint16_t nb_ops, int *callfds, uint16_t *nb_callfds)
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 26dc0bde97..ec950acf97 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -41,6 +41,7 @@
 #define MEMFD_SUPPORTED
 #endif
 
+#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_log.h>
@@ -3359,6 +3360,7 @@ vhost_user_iotlb_miss(struct virtio_net *dev, uint64_t iova, uint8_t perm)
 	return 0;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_backend_config_change)
 int
 rte_vhost_backend_config_change(int vid, bool need_reply)
 {
@@ -3421,6 +3423,7 @@ static int vhost_user_backend_set_vring_host_notifier(struct virtio_net *dev,
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vhost_host_notifier_ctrl)
 int rte_vhost_host_notifier_ctrl(int vid, uint16_t qid, bool enable)
 {
 	struct virtio_net *dev;
diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
index 0348e8dac3..77545d0a4d 100644
--- a/lib/vhost/virtio_net.c
+++ b/lib/vhost/virtio_net.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <linux/virtio_net.h>
 
+#include <eal_export.h>
 #include <rte_mbuf.h>
 #include <rte_memcpy.h>
 #include <rte_net.h>
@@ -1739,6 +1740,7 @@ virtio_dev_rx(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nb_tx;
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_enqueue_burst)
 uint16_t
 rte_vhost_enqueue_burst(int vid, uint16_t queue_id,
 	struct rte_mbuf **__rte_restrict pkts, uint16_t count)
@@ -2340,6 +2342,7 @@ vhost_poll_enqueue_completed(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nr_cpl_pkts;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_poll_enqueue_completed, 20.08)
 uint16_t
 rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -2395,6 +2398,7 @@ rte_vhost_poll_enqueue_completed(int vid, uint16_t queue_id,
 	return n_pkts_cpl;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue_thread_unsafe, 21.08)
 uint16_t
 rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -2452,6 +2456,7 @@ rte_vhost_clear_queue_thread_unsafe(int vid, uint16_t queue_id,
 	return n_pkts_cpl;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_clear_queue, 22.07)
 uint16_t
 rte_vhost_clear_queue(int vid, uint16_t queue_id, struct rte_mbuf **pkts,
 		uint16_t count, int16_t dma_id, uint16_t vchan_id)
@@ -2567,6 +2572,7 @@ virtio_dev_rx_async_submit(struct virtio_net *dev, struct vhost_virtqueue *vq,
 	return nb_tx;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_submit_enqueue_burst, 20.08)
 uint16_t
 rte_vhost_submit_enqueue_burst(int vid, uint16_t queue_id,
 		struct rte_mbuf **pkts, uint16_t count, int16_t dma_id,
@@ -3588,6 +3594,7 @@ virtio_dev_tx_packed_compliant(struct virtio_net *dev,
 	return virtio_dev_tx_packed(dev, vq, mbuf_pool, pkts, count, false);
 }
 
+RTE_EXPORT_SYMBOL(rte_vhost_dequeue_burst)
 uint16_t
 rte_vhost_dequeue_burst(int vid, uint16_t queue_id,
 	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count)
@@ -4197,6 +4204,7 @@ virtio_dev_tx_async_packed_compliant(struct virtio_net *dev, struct vhost_virtqu
 				pkts, count, dma_id, vchan_id, false);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vhost_async_try_dequeue_burst, 22.07)
 uint16_t
 rte_vhost_async_try_dequeue_burst(int vid, uint16_t queue_id,
 	struct rte_mempool *mbuf_pool, struct rte_mbuf **pkts, uint16_t count,
-- 
2.49.0

