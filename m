Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315FC369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 22:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F40740A7F;
	Wed, 16 Apr 2025 00:31:59 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 149B6402D6
 for <dev@dpdk.org>; Wed, 16 Apr 2025 00:31:56 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F00FE210C44B; Tue, 15 Apr 2025 15:31:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F00FE210C44B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744756314;
 bh=KO4EsxY+fIboesVnDlnqqXOLE58aXmjw8OSjXqFHUZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FntuUjveA2e2zfU1NHyjnu6VZj3b/3kDQ4Jb1YtLzdhb9AmiwxlPI8MEhbi0uM5I4
 g/EfomIArvWSryv4Rhms3zhw4Qyy0kqZTB4EmuZpvwqgtSTLS411IdEEaPNd1vN765
 xsCT4IIEvJbuvQQ+itC4N6zRBNpBESlw3yCzt0mQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/4] allow pmdinfo to be inserted and parsed using MSVC
Date: Tue, 15 Apr 2025 15:31:33 -0700
Message-Id: <1744756297-21038-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
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

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

Macro RTE_INCLUDE is used in this patch to ensure these special variables
make it to the final binaries.

The elimination of "static" for some of these variables caused name
clashes when __COUNTER__ predefined macro was used. As a workaround,
predefined macro __LINE__ was used instead. However, when __COUNTER__
was used directly from a header file, __LINE__ had to be used from the
.c files, otherwise it would also not result in a unique symbol. This
required a parameter to be added to some macros so that the __LINE__
could be passed from the .c file to the macro defined in the header
(which was originally using __COUNTER__).

With this patchset commands like the one below provide the same JSON
output as would be obtained on Linux.

python usertools\dpdk-pmdinfo.py build\app\dpdk-testpmd.exe

v3:
 - ge-pmdinfo-cfile.py: fixed archiver's syntax to extract object from
   library
 - dpdk-pmdinfo.py: removed is_windows() and replaced with
   os.name == "nt"

v2:
 - dpdk-pmdinfo.py: not importing elftools on Windows
 - not requiring "pefile" Python module during build
 - gen-pmdinfo-cfile.py: renamed "ar" to "archiver"

Andre Muezerie (4):
  eal: add macro to embed information in binaries
  buildtools: use macro to embed information in binaries
  usertools: parse strings from PE images
  drivers: use macro to embed information in binaries

 buildtools/gen-pmdinfo-cfile.py               | 24 +++++++--
 buildtools/meson.build                        |  4 +-
 buildtools/pmdinfogen.py                      | 11 ++--
 drivers/baseband/acc/rte_acc100_pmd.c         |  4 +-
 drivers/baseband/acc/rte_vrb_pmd.c            |  4 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |  4 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  4 +-
 drivers/baseband/la12xx/bbdev_la12xx.c        |  2 +-
 drivers/baseband/null/bbdev_null.c            |  2 +-
 .../baseband/turbo_sw/bbdev_turbo_software.c  |  2 +-
 drivers/bus/auxiliary/bus_auxiliary_driver.h  |  4 +-
 drivers/bus/cdx/bus_cdx_driver.h              |  7 ++-
 drivers/bus/dpaa/bus_dpaa_driver.h            |  4 +-
 drivers/bus/fslmc/bus_fslmc_driver.h          |  8 +--
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |  2 +-
 drivers/bus/ifpga/bus_ifpga_driver.h          |  4 +-
 drivers/bus/pci/bus_pci_driver.h              |  4 +-
 drivers/bus/platform/bus_platform_driver.h    |  4 +-
 drivers/bus/uacce/bus_uacce_driver.h          |  4 +-
 drivers/bus/vdev/bus_vdev_driver.h            |  4 +-
 drivers/bus/vmbus/bus_vmbus_driver.h          |  4 +-
 drivers/common/mlx5/mlx5_common.c             |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c         |  2 +-
 drivers/common/nitrox/nitrox_device.c         |  2 +-
 drivers/common/qat/qat_device.c               |  2 +-
 drivers/common/zsda/zsda_device.c             |  2 +-
 drivers/compress/isal/isal_compress_pmd.c     |  2 +-
 drivers/compress/mlx5/mlx5_compress.c         |  2 +-
 drivers/compress/octeontx/otx_zip_pmd.c       |  2 +-
 drivers/compress/uadk/uadk_compress_pmd.c     |  2 +-
 drivers/compress/zlib/zlib_pmd.c              |  2 +-
 drivers/crypto/armv8/rte_armv8_pmd.c          |  2 +-
 drivers/crypto/bcmfs/bcmfs_device.c           |  3 +-
 drivers/crypto/caam_jr/caam_jr.c              |  2 +-
 drivers/crypto/ccp/rte_ccp_pmd.c              |  2 +-
 drivers/crypto/cnxk/cn10k_cryptodev.c         |  2 +-
 drivers/crypto/cnxk/cn9k_cryptodev.c          |  2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  2 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |  2 +-
 drivers/crypto/ionic/ionic_crypto_vdev.c      |  2 +-
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c       |  3 +-
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c        |  3 +-
 drivers/crypto/ipsec_mb/pmd_chacha_poly.c     |  3 +-
 drivers/crypto/ipsec_mb/pmd_kasumi.c          |  2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c          |  2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c             |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c             |  2 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c           |  2 +-
 drivers/crypto/null/null_crypto_pmd.c         |  2 +-
 drivers/crypto/octeontx/otx_cryptodev.c       |  2 +-
 drivers/crypto/openssl/rte_openssl_pmd.c      |  3 +-
 drivers/crypto/scheduler/scheduler_pmd.c      |  3 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         |  2 +-
 drivers/crypto/virtio/virtio_cryptodev.c      |  2 +-
 drivers/crypto/virtio/virtio_user_cryptodev.c |  2 +-
 drivers/dma/cnxk/cnxk_dmadev.c                |  2 +-
 drivers/dma/dpaa/dpaa_qdma.c                  |  2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |  2 +-
 drivers/dma/hisilicon/hisi_dmadev.c           |  2 +-
 drivers/dma/idxd/idxd_pci.c                   |  2 +-
 drivers/dma/ioat/ioat_dmadev.c                |  2 +-
 drivers/dma/odm/odm_dmadev.c                  |  2 +-
 drivers/dma/skeleton/skeleton_dmadev.c        |  2 +-
 drivers/event/cnxk/cn10k_eventdev.c           |  2 +-
 drivers/event/cnxk/cn20k_eventdev.c           |  2 +-
 drivers/event/cnxk/cn9k_eventdev.c            |  2 +-
 drivers/event/dlb2/pf/dlb2_pf.c               |  4 +-
 drivers/event/dpaa/dpaa_eventdev.c            |  2 +-
 drivers/event/dpaa2/dpaa2_eventdev.c          |  2 +-
 drivers/event/dpaa2/dpaa2_hw_dpcon.c          |  2 +-
 drivers/event/dsw/dsw_evdev.c                 |  2 +-
 drivers/event/octeontx/ssovf_evdev.c          |  3 +-
 drivers/event/octeontx/ssovf_probe.c          |  4 +-
 drivers/event/octeontx/timvf_probe.c          |  2 +-
 drivers/event/opdl/opdl_evdev.c               |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c    |  4 +-
 drivers/event/sw/sw_evdev.c                   |  2 +-
 drivers/gpu/cuda/cuda.c                       |  2 +-
 drivers/mempool/cnxk/cnxk_mempool.c           |  2 +-
 drivers/mempool/octeontx/octeontx_fpavf.c     |  2 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                |  2 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c                |  2 +-
 drivers/net/af_packet/rte_eth_af_packet.c     |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  2 +-
 drivers/net/ark/ark_ethdev.c                  |  2 +-
 drivers/net/atlantic/atl_ethdev.c             |  2 +-
 drivers/net/avp/avp_ethdev.c                  |  2 +-
 drivers/net/axgbe/axgbe_ethdev.c              |  2 +-
 drivers/net/bnx2x/bnx2x_ethdev.c              |  5 +-
 drivers/net/bnxt/bnxt_ethdev.c                |  2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  2 +-
 drivers/net/cnxk/cn10k_ethdev.c               |  2 +-
 drivers/net/cnxk/cn20k_ethdev.c               |  2 +-
 drivers/net/cnxk/cn9k_ethdev.c                |  2 +-
 drivers/net/cnxk/cnxk_eswitch.c               |  2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |  2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |  2 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |  2 +-
 drivers/net/dpaa/dpaa_ethdev.c                |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  2 +-
 drivers/net/dpaa2/dpaa2_mux.c                 |  2 +-
 drivers/net/dpaa2/dpaa2_ptp.c                 |  2 +-
 drivers/net/ena/ena_ethdev.c                  |  2 +-
 drivers/net/enetc/enetc_ethdev.c              |  2 +-
 drivers/net/enetfec/enet_ethdev.c             |  2 +-
 drivers/net/enic/enic_ethdev.c                |  2 +-
 drivers/net/failsafe/failsafe.c               |  2 +-
 drivers/net/gve/gve_ethdev.c                  |  2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  2 +-
 drivers/net/hns3/hns3_ethdev.c                |  2 +-
 drivers/net/hns3/hns3_ethdev_vf.c             |  2 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  2 +-
 drivers/net/intel/e1000/em_ethdev.c           |  2 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  4 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  2 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  2 +-
 drivers/net/intel/ice/ice_ethdev.c            |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  4 +-
 drivers/net/ionic/ionic_dev_pci.c             |  2 +-
 drivers/net/ionic/ionic_dev_vdev.c            |  3 +-
 drivers/net/mana/mana.c                       |  2 +-
 drivers/net/memif/rte_eth_memif.c             |  2 +-
 drivers/net/mlx4/mlx4.c                       |  2 +-
 drivers/net/mlx5/mlx5.c                       |  2 +-
 drivers/net/mvneta/mvneta_ethdev.c            |  2 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |  2 +-
 drivers/net/netvsc/hn_ethdev.c                |  2 +-
 drivers/net/nfb/nfb_ethdev.c                  |  2 +-
 drivers/net/nfp/nfp_ethdev.c                  |  2 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  2 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c             |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  2 +-
 drivers/net/null/rte_eth_null.c               |  2 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  2 +-
 drivers/net/octeontx/base/octeontx_pkivf.c    |  2 +-
 drivers/net/octeontx/base/octeontx_pkovf.c    |  2 +-
 drivers/net/octeontx/octeontx_ethdev.c        |  3 +-
 drivers/net/pcap/pcap_ethdev.c                |  2 +-
 drivers/net/pfe/pfe_ethdev.c                  |  2 +-
 drivers/net/qede/qede_ethdev.c                |  4 +-
 drivers/net/r8169/r8169_ethdev.c              |  2 +-
 drivers/net/ring/rte_eth_ring.c               |  2 +-
 drivers/net/sfc/sfc_ethdev.c                  |  2 +-
 drivers/net/softnic/rte_eth_softnic.c         |  2 +-
 drivers/net/tap/rte_eth_tap.c                 |  4 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c              |  2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c           |  2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c         |  2 +-
 drivers/net/vhost/rte_eth_vhost.c             |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c        |  2 +-
 drivers/net/virtio/virtio_user_ethdev.c       |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  2 +-
 drivers/net/xsc/xsc_ethdev.c                  |  2 +-
 drivers/net/zxdh/zxdh_ethdev.c                |  2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy.c             |  2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c         |  2 +-
 drivers/raw/cnxk_gpio/cnxk_gpio.c             |  2 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |  2 +-
 drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c         |  2 +-
 drivers/raw/gdtc/gdtc_rawdev.c                |  2 +-
 drivers/raw/ifpga/afu_pmd_core.c              |  2 +-
 drivers/raw/ifpga/ifpga_rawdev.c              |  4 +-
 drivers/raw/ntb/ntb.c                         |  2 +-
 drivers/raw/skeleton/skeleton_rawdev.c        |  2 +-
 drivers/regex/cn9k/cn9k_regexdev.c            |  2 +-
 drivers/regex/mlx5/mlx5_regex.c               |  2 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                 |  2 +-
 drivers/vdpa/sfc/sfc_vdpa.c                   |  2 +-
 lib/eal/common/eal_common_options.c           |  2 +-
 lib/eal/include/rte_common.h                  |  6 +++
 lib/eal/include/rte_dev.h                     | 14 ++---
 usertools/dpdk-pmdinfo.py                     | 53 +++++++++++++++----
 182 files changed, 289 insertions(+), 238 deletions(-)

--
2.49.0.vfs.0.0

