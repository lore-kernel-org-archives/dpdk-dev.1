Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F9BFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:48:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 578A5406A2;
	Wed, 29 Apr 2026 13:48:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39137402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IW7zyawrzhEDoHga58/SoTH66jq1Blo96UTPnx3c6lc=;
 b=VbtdkpLumgQssxCB+pmHlkDHHj2tg8Ck/g5aoSh7NJQfeLyEOSCK604URWI/0Wz+T70jDZ
 +O3xbtp2imqAu0fm+t3EqTCUKGBpQxcdnPc+YNSWykK+asreSD3atLe5/w8wGpFASYv0+T
 QkedExGZyAf+AV+MJpX+ImxMIMMIpMc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Joxn7sjCPRygwV0zkMAU_w-1; Wed,
 29 Apr 2026 07:48:44 -0400
X-MC-Unique: Joxn7sjCPRygwV0zkMAU_w-1
X-Mimecast-MFC-AGG-ID: Joxn7sjCPRygwV0zkMAU_w_1777463308
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD0B21800451; Wed, 29 Apr 2026 11:48:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23BCA1800480; Wed, 29 Apr 2026 11:47:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>, Ashish Gupta <ashishg@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Howard Wang <howard_wang@realsil.com.cn>,
 Chunhao Lin <hau@realtek.com>, Xing Wang <xing_wang@realsil.com.cn>,
 Javen Xu <javen_xu@realsil.com.cn>, Wenbo Cao <caowenbo@mucse.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>,
 Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH 23/23] bus: add class device conversion macro
Date: Wed, 29 Apr 2026 13:44:56 +0200
Message-ID: <20260429114503.932575-24-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ugZGSrc3y06tRryfuZb7xSVwDNA5syhUwPh16GgkHeU_1777463308
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Add a new helper macro RTE_CLASS_TO_BUS_DEVICE that provides a unified
way to convert from any device class (ethdev, cryptodev, eventdev, etc.)
to a bus-specific device type. This macro works with any device class
that has a 'device' field pointing to struct rte_device.

Remove the bus-specific ethdev convenience macros (RTE_ETH_DEV_TO_PCI,
RTE_ETH_DEV_TO_AUXILIARY, RTE_ETH_DEV_TO_VDEV) and replace all uses
with the generic RTE_CLASS_TO_BUS_DEVICE macro.

Convert all drivers to use RTE_CLASS_TO_BUS_DEVICE instead of
the pattern RTE_BUS_DEVICE(dev->device).

Simplify code that was using an intermediate struct rte_device pointer
by applying RTE_CLASS_TO_BUS_DEVICE directly on the device class pointer.

This reduces code duplication and provides a consistent interface that
can be used for all device classes.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/baseband/acc/rte_acc100_pmd.c         |  4 +-
 drivers/baseband/acc/rte_vrb_pmd.c            |  2 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |  4 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  2 +-
 drivers/bus/auxiliary/bus_auxiliary_driver.h  |  3 --
 drivers/bus/cdx/bus_cdx_driver.h              |  2 -
 drivers/bus/pci/bus_pci_driver.h              |  3 --
 drivers/bus/vdev/bus_vdev_driver.h            |  3 --
 drivers/compress/octeontx/otx_zip.c           |  2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  3 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |  4 +-
 drivers/event/cnxk/cnxk_eventdev.c            |  2 +-
 drivers/event/dlb2/pf/dlb2_pf.c               |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c    |  2 +-
 drivers/net/ark/ark_ethdev.c                  |  2 +-
 drivers/net/atlantic/atl_ethdev.c             | 12 +++---
 drivers/net/avp/avp_ethdev.c                  | 22 +++++-----
 drivers/net/axgbe/axgbe_ethdev.c              |  4 +-
 drivers/net/bnx2x/bnx2x_ethdev.c              |  2 +-
 drivers/net/bnxt/bnxt_ethdev.c                | 12 +++---
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c            |  4 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  2 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c            |  2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |  4 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |  4 +-
 drivers/net/dpaa/dpaa_ethdev.c                | 16 +++-----
 drivers/net/dpaa2/dpaa2_ethdev.c              |  8 ++--
 drivers/net/dpaa2/dpaa2_recycle.c             |  6 +--
 drivers/net/ena/ena_ethdev.c                  | 10 ++---
 drivers/net/enetc/enetc4_ethdev.c             |  4 +-
 drivers/net/enetc/enetc4_vf.c                 |  4 +-
 drivers/net/enetc/enetc_ethdev.c              |  2 +-
 drivers/net/enic/enic_ethdev.c                |  4 +-
 drivers/net/enic/enic_fm_flow.c               |  6 +--
 drivers/net/enic/enic_vf_representor.c        |  2 +-
 drivers/net/gve/gve_ethdev.c                  |  2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  8 ++--
 drivers/net/hinic3/base/hinic3_hwdev.c        |  7 ++--
 drivers/net/hinic3/hinic3_ethdev.c            | 16 ++++----
 drivers/net/hns3/hns3_cmd.c                   |  2 +-
 drivers/net/hns3/hns3_common.c                |  8 ++--
 drivers/net/hns3/hns3_ethdev.c                |  6 +--
 drivers/net/hns3/hns3_ethdev_vf.c             |  6 +--
 drivers/net/hns3/hns3_rxtx.c                  |  4 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  4 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
 drivers/net/intel/e1000/em_ethdev.c           | 12 +++---
 drivers/net/intel/e1000/em_rxtx.c             |  2 +-
 drivers/net/intel/e1000/igb_ethdev.c          | 30 +++++++-------
 drivers/net/intel/e1000/igb_pf.c              |  2 +-
 drivers/net/intel/e1000/igc_ethdev.c          | 22 +++++-----
 drivers/net/intel/fm10k/fm10k_ethdev.c        | 16 ++++----
 drivers/net/intel/i40e/i40e_ethdev.c          | 28 ++++++-------
 drivers/net/intel/i40e/i40e_ethdev.h          |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  8 ++--
 drivers/net/intel/ice/ice_dcf.c               |  6 +--
 drivers/net/intel/ice/ice_ethdev.c            |  6 +--
 drivers/net/intel/ice/ice_ethdev.h            |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.h          |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |  3 --
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  6 +--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 40 +++++++++----------
 drivers/net/intel/ixgbe/ixgbe_flow.c          |  4 +-
 drivers/net/intel/ixgbe/ixgbe_pf.c            |  2 +-
 drivers/net/intel/ixgbe/ixgbe_tm.c            |  2 +-
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  2 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       | 20 +++++-----
 drivers/net/nbl/nbl_core.c                    |  2 +-
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  6 +--
 drivers/net/netvsc/hn_ethdev.c                |  3 +-
 drivers/net/nfp/nfp_ethdev.c                  |  8 ++--
 drivers/net/nfp/nfp_ethdev_vf.c               |  6 +--
 drivers/net/nfp/nfp_net_common.c              |  8 ++--
 drivers/net/ngbe/ngbe_ethdev.c                | 20 +++++-----
 drivers/net/ngbe/ngbe_ethdev_vf.c             | 16 ++++----
 drivers/net/ngbe/ngbe_pf.c                    |  2 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  2 +-
 drivers/net/octeon_ep/otx_ep_mbox.c           |  6 +--
 drivers/net/qede/qede_ethdev.c                |  6 +--
 drivers/net/r8169/r8169_ethdev.c              |  6 +--
 drivers/net/rnp/rnp_ethdev.c                  |  6 +--
 drivers/net/sfc/sfc.c                         |  4 +-
 drivers/net/sfc/sfc_ethdev.c                  |  2 +-
 drivers/net/sfc/sfc_intr.c                    | 10 ++---
 drivers/net/sfc/sfc_rx.c                      |  3 +-
 drivers/net/sfc/sfc_sriov.c                   |  2 +-
 drivers/net/sfc/sfc_tx.c                      |  3 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  4 +-
 drivers/net/txgbe/txgbe_ethdev.c              | 26 ++++++------
 drivers/net/txgbe/txgbe_ethdev_vf.c           | 16 ++++----
 drivers/net/txgbe/txgbe_flow.c                |  4 +-
 drivers/net/txgbe/txgbe_pf.c                  |  2 +-
 drivers/net/txgbe/txgbe_tm.c                  |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c        | 11 ++---
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  4 +-
 drivers/net/xsc/xsc_ethdev.c                  |  2 +-
 drivers/net/zxdh/zxdh_ethdev.c                |  8 ++--
 drivers/raw/ifpga/afu_pmd_n3000.c             |  4 +-
 lib/eal/include/bus_driver.h                  | 18 +++++++++
 100 files changed, 336 insertions(+), 340 deletions(-)

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index 061f595a98..cbcacc7aa3 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -3993,7 +3993,7 @@ acc100_dequeue_ldpc_dec(struct rte_bbdev_queue_data *q_data,
 static void
 acc100_bbdev_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	dev->dev_ops = &acc100_bbdev_ops;
 	dev->enqueue_enc_ops = acc100_enqueue_enc;
@@ -4646,7 +4646,7 @@ rte_acc_configure(const char *dev_name, struct rte_acc_conf *conf)
 				dev_name);
 		return -ENODEV;
 	}
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(bbdev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(bbdev, *pci_dev);
 	rte_bbdev_log(INFO, "Configure dev id %x", pci_dev->id.device_id);
 	if (pci_dev->id.device_id == ACC100_PF_DEVICE_ID)
 		return acc100_configure(dev_name, conf);
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index fe23c01b5c..1f85e33462 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -4353,7 +4353,7 @@ vrb2_dequeue_mldts(struct rte_bbdev_queue_data *q_data,
 static void
 vrb_bbdev_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct acc_device *d = dev->data->dev_private;
 
 	dev->dev_ops = &vrb_bbdev_ops;
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index cb805a1732..45bd171ca7 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -2873,7 +2873,7 @@ fpga_5gnr_dequeue_ldpc_dec(struct rte_bbdev_queue_data *q_data,
 static void
 fpga_5gnr_fec_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	dev->dev_ops = &fpga_5gnr_ops;
 	dev->enqueue_ldpc_enc_ops = fpga_5gnr_enqueue_ldpc_enc;
@@ -3376,7 +3376,7 @@ int rte_fpga_5gnr_fec_configure(const char *dev_name, const struct rte_fpga_5gnr
 				dev_name);
 		return -ENODEV;
 	}
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(bbdev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(bbdev, *pci_dev);
 	rte_bbdev_log(INFO, "Configure dev id %x", pci_dev->id.device_id);
 	if (pci_dev->id.device_id == VC_5GNR_PF_DEVICE_ID)
 		return vc_5gnr_configure(dev_name, conf);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index d27164c6f4..04ac445820 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -2316,7 +2316,7 @@ fpga_dequeue_dec(struct rte_bbdev_queue_data *q_data,
 static void
 fpga_lte_fec_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	dev->dev_ops = &fpga_ops;
 	dev->enqueue_enc_ops = fpga_enqueue_enc;
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index cab5f86d03..65e1814ec0 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -128,9 +128,6 @@ struct rte_auxiliary_driver {
 	uint32_t drv_flags;                   /**< Flags RTE_AUXILIARY_DRV_*. */
 };
 
-#define RTE_ETH_DEV_TO_AUXILIARY(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_auxiliary_device)
-
 /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
 #define RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA 0x002
 
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index 1ac481119c..01684466ed 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -60,8 +60,6 @@ struct rte_cdx_device {
 	struct rte_intr_handle *intr_handle;	/**< Interrupt handle */
 };
 
-#define RTE_ETH_DEV_TO_CDX_DEV(eth_dev)	RTE_DEV_TO_CDX_DEV((eth_dev)->device)
-
 #ifdef __cplusplus
 /** C++ macro used to help building up tables of device IDs. */
 #define RTE_CDX_DEVICE(vend, dev)	\
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index cb7039f8d6..c04ebddf59 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -47,9 +47,6 @@ struct rte_pci_device {
 				/**< Handler of VFIO request interrupt */
 };
 
-#define RTE_ETH_DEV_TO_PCI(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
-
 #ifdef __cplusplus
 /** C++ macro used to help building up tables of device IDs */
 #define RTE_PCI_DEVICE(vend, dev) \
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index 8d114e4b3b..ecfc5384fc 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -19,9 +19,6 @@ struct rte_vdev_device {
 	struct rte_device device;               /**< Inherit core device */
 };
 
-#define RTE_ETH_DEV_TO_VDEV(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_vdev_device)
-
 static inline const char *
 rte_vdev_device_name(const struct rte_vdev_device *dev)
 {
diff --git a/drivers/compress/octeontx/otx_zip.c b/drivers/compress/octeontx/otx_zip.c
index 8673561a81..7cf3283680 100644
--- a/drivers/compress/octeontx/otx_zip.c
+++ b/drivers/compress/octeontx/otx_zip.c
@@ -142,7 +142,7 @@ zipvf_push_command(struct zipvf_qp *qp, union zip_inst_s *cmd)
 int
 zipvf_create(struct rte_compressdev *compressdev)
 {
-	struct   rte_pci_device *pdev = RTE_BUS_DEVICE(compressdev->device, *pdev);
+	struct   rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(compressdev, *pdev);
 	struct   zip_vf *zipvf = NULL;
 	char     *dev_name = compressdev->data->name;
 	void     *vbar0;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index f437350539..d3cf1ddd57 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -481,7 +481,7 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	if (dev->data->queue_pairs[qp_id] != NULL)
 		cnxk_cpt_queue_pair_release(dev, qp_id);
 
-	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (pci_dev->mem_resource[2].addr == NULL) {
 		plt_err("Invalid PCI mem address");
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index d7b53723e7..3d980d096f 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4383,7 +4383,6 @@ static int
 dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 {
 	struct dpaa2_sec_dev_private *internals;
-	struct rte_device *dev = cryptodev->device;
 	struct rte_dpaa2_device *dpaa2_dev;
 	struct rte_security_ctx *security_instance;
 	struct fsl_mc_io *dpseci;
@@ -4392,7 +4391,7 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 	int retcode, hw_id;
 
 	PMD_INIT_FUNC_TRACE();
-	dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
+	dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(cryptodev, *dpaa2_dev);
 	hw_id = dpaa2_dev->object_id;
 
 	cryptodev->driver_id = cryptodev_driver_id;
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index a499c8d0bc..d6d1b2cea9 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -156,7 +156,7 @@ otx_cpt_que_pair_setup(struct rte_cryptodev *dev,
 			     DEFAULT_CMD_QLEN);
 	}
 
-	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (pci_dev->mem_resource[0].addr == NULL) {
 		CPT_LOG_ERR("PCI mem address null");
@@ -1001,7 +1001,7 @@ static struct rte_cryptodev_ops cptvf_ops = {
 int
 otx_cpt_dev_create(struct rte_cryptodev *c_dev)
 {
-	struct rte_pci_device *pdev = RTE_BUS_DEVICE(c_dev->device, *pdev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(c_dev, *pdev);
 	struct cpt_vf *cptvf = NULL;
 	void *reg_base;
 	char dev_name[32];
diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index 6f000ff49e..272ba235a4 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -654,7 +654,7 @@ cnxk_sso_init(struct rte_eventdev *event_dev)
 		return -ENOMEM;
 	}
 
-	pci_dev = RTE_BUS_DEVICE(event_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(event_dev, *pci_dev);
 	dev->sso.pci_dev = pci_dev;
 
 	*(uint64_t *)mz->addr = (uint64_t)dev;
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index 82075bbf0b..c78783e59d 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -784,7 +784,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 
 	dlb2_pf_iface_fn_ptrs_init();
 
-	pci_dev = RTE_BUS_DEVICE(eventdev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eventdev, *pci_dev);
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index 4292644fde..c0e06e4aa0 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -332,7 +332,7 @@ skeleton_eventdev_init(struct rte_eventdev *eventdev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	pci_dev = RTE_BUS_DEVICE(eventdev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eventdev, *pci_dev);
 
 	skel->reg_base = (uintptr_t)pci_dev->mem_resource[0].addr;
 	if (!skel->reg_base) {
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..d6e34021ce 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -315,7 +315,7 @@ ark_dev_init(struct rte_eth_dev *dev)
 	if (ret)
 		return ret;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	rte_eth_copy_pci_info(dev, pci_dev);
 	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 2925dc2478..d55d6d50bb 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -359,7 +359,7 @@ static int
 eth_atl_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct atl_adapter *adapter = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct aq_hw_s *hw = ATL_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	int err = 0;
@@ -478,7 +478,7 @@ static int
 atl_dev_start(struct rte_eth_dev *dev)
 {
 	struct aq_hw_s *hw = ATL_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	int status;
@@ -606,7 +606,7 @@ atl_dev_stop(struct rte_eth_dev *dev)
 	struct rte_eth_link link;
 	struct aq_hw_s *hw =
 		ATL_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
@@ -687,7 +687,7 @@ atl_dev_set_link_down(struct rte_eth_dev *dev)
 static int
 atl_dev_close(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct aq_hw_s *hw;
 	int ret;
@@ -1093,7 +1093,7 @@ atl_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 static int
 atl_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	dev_info->max_rx_queues = AQ_HW_MAX_RX_QUEUES;
 	dev_info->max_tx_queues = AQ_HW_MAX_TX_QUEUES;
@@ -1344,7 +1344,7 @@ atl_dev_link_status_print(struct rte_eth_dev *dev)
 
 #ifdef DEBUG
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	PMD_DRV_LOG(DEBUG, "PCI Address: " PCI_PRI_FMT,
 				pci_dev->addr.domain,
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index 3bc5171336..8af6c45381 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -361,7 +361,7 @@ static void *
 avp_dev_translate_address(struct rte_eth_dev *eth_dev,
 			  rte_iova_t host_phys_addr)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_mem_resource *resource;
 	struct rte_avp_memmap_info *info;
 	struct rte_avp_memmap *map;
@@ -414,7 +414,7 @@ avp_dev_version_check(uint32_t version)
 static int
 avp_dev_check_regions(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_avp_memmap_info *memmap;
 	struct rte_avp_device_info *info;
 	struct rte_mem_resource *resource;
@@ -550,7 +550,7 @@ _avp_set_rx_queue_mappings(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
 static void
 _avp_set_queue_counts(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct avp_dev *avp = AVP_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_avp_device_info *host_info;
 	void *addr;
@@ -610,7 +610,7 @@ avp_dev_attach(struct rte_eth_dev *eth_dev)
 	 * re-run the device create utility which will parse the new host info
 	 * and setup the AVP device queue pointers.
 	 */
-	ret = avp_dev_create(RTE_ETH_DEV_TO_PCI(eth_dev), eth_dev);
+	ret = avp_dev_create(RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device), eth_dev);
 	if (ret < 0) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to re-create AVP device, ret=%d",
 			    ret);
@@ -664,7 +664,7 @@ static void
 avp_dev_interrupt_handler(void *data)
 {
 	struct rte_eth_dev *eth_dev = data;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	void *registers = pci_dev->mem_resource[RTE_AVP_PCI_MMIO_BAR].addr;
 	uint32_t status, value;
 	int ret;
@@ -723,7 +723,7 @@ avp_dev_interrupt_handler(void *data)
 static int
 avp_dev_enable_interrupts(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	void *registers = pci_dev->mem_resource[RTE_AVP_PCI_MMIO_BAR].addr;
 	int ret;
 
@@ -748,7 +748,7 @@ avp_dev_enable_interrupts(struct rte_eth_dev *eth_dev)
 static int
 avp_dev_disable_interrupts(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	void *registers = pci_dev->mem_resource[RTE_AVP_PCI_MMIO_BAR].addr;
 	int ret;
 
@@ -773,7 +773,7 @@ avp_dev_disable_interrupts(struct rte_eth_dev *eth_dev)
 static int
 avp_dev_setup_interrupts(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret;
 
 	/* register a callback handler with UIO for interrupt notifications */
@@ -793,7 +793,7 @@ avp_dev_setup_interrupts(struct rte_eth_dev *eth_dev)
 static int
 avp_dev_migration_pending(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	void *registers = pci_dev->mem_resource[RTE_AVP_PCI_MMIO_BAR].addr;
 	uint32_t value;
 
@@ -954,7 +954,7 @@ eth_avp_dev_init(struct rte_eth_dev *eth_dev)
 	struct rte_pci_device *pci_dev;
 	int ret;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	eth_dev->dev_ops = &avp_eth_dev_ops;
 	eth_dev->rx_pkt_burst = &avp_recv_pkts;
 	eth_dev->tx_pkt_burst = &avp_xmit_pkts;
@@ -1977,7 +1977,7 @@ avp_dev_tx_queue_release_all(struct rte_eth_dev *eth_dev)
 static int
 avp_dev_configure(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct avp_dev *avp = AVP_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_avp_device_info *host_info;
 	struct rte_avp_device_config config;
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index c14d04a11d..aceec49c0c 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2230,7 +2230,7 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 	rte_bit_relaxed_set32(AXGBE_STOPPED, &pdata->dev_state);
 	pdata->eth_dev = eth_dev;
 
-	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	pdata->pci_dev = pci_dev;
 
 	pdata->xgmac_regs =
@@ -2453,7 +2453,7 @@ axgbe_dev_close(struct rte_eth_dev *eth_dev)
 		return 0;
 
 	pdata = eth_dev->data->dev_private;
-	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	axgbe_dev_clear_queues(eth_dev);
 
 	/* disable uio intr before callback unregister */
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_ethdev.c
index 7b96e1acee..4f1f97a999 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.c
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c
@@ -639,7 +639,7 @@ bnx2x_common_dev_init(struct rte_eth_dev *eth_dev, int is_vf)
 
 	/* Extract key data structures */
 	sc = eth_dev->data->dev_private;
-	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	pci_addr = pci_dev->addr;
 
 	snprintf(sc->devinfo.name, NAME_SIZE, PCI_SHORT_PRI_FMT ":dpdk-port-%u",
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 071093aabc..5506037cc2 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -862,7 +862,7 @@ static int bnxt_alloc_prev_ring_stats(struct bnxt *bp)
 
 static int bnxt_start_nic(struct bnxt *bp)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(bp->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(bp->eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	uint32_t queue_id, base = BNXT_MISC_VEC_ID;
@@ -1167,7 +1167,7 @@ uint64_t bnxt_eth_rss_support(struct bnxt *bp)
 static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 				struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pdev = RTE_BUS_DEVICE(eth_dev->device, *pdev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	struct bnxt *bp = eth_dev->data->dev_private;
 	uint16_t max_vnics, i, j, vpool, vrxq;
 	unsigned int max_rx_rings;
@@ -1719,7 +1719,7 @@ static int bnxt_ptp_start(struct bnxt *bp)
 static int bnxt_dev_stop(struct rte_eth_dev *eth_dev)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rte_eth_link link;
 	uint16_t i;
@@ -5143,7 +5143,7 @@ bool bnxt_stratus_device(struct bnxt *bp)
 
 static int bnxt_map_pci_bars(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct bnxt *bp = eth_dev->data->dev_private;
 
 	/* enable device (incl. PCI PM wakeup), and bus-mastering */
@@ -6600,7 +6600,7 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
  */
 static int bnxt_drv_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct bnxt *bp = eth_dev->data->dev_private;
 	int rc = 0;
 
@@ -6684,7 +6684,7 @@ static int bnxt_drv_init(struct rte_eth_dev *eth_dev)
 static int
 bnxt_dev_init(struct rte_eth_dev *eth_dev, void *params __rte_unused)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	static int version_printed;
 	struct bnxt *bp;
 	int rc;
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index e1e2c0e878..8ff0e20364 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -192,7 +192,7 @@ ulp_session_init(struct bnxt *bp,
 	if (!bp)
 		return NULL;
 
-	pci_dev = RTE_BUS_DEVICE(bp->eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(bp->eth_dev, *pci_dev);
 	pci_addr = &pci_dev->addr;
 
 	pthread_mutex_lock(&bnxt_ulp_global_mutex);
@@ -556,7 +556,7 @@ bnxt_ulp_port_deinit(struct bnxt *bp)
 		     bp->eth_dev->data->port_id);
 
 	/* Get the session details  */
-	pci_dev = RTE_BUS_DEVICE(bp->eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(bp->eth_dev, *pci_dev);
 	pci_addr = &pci_dev->addr;
 	pthread_mutex_lock(&bnxt_ulp_global_mutex);
 	session = ulp_get_session(bp, pci_addr);
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 06d1c9b362..7ae16186c6 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2177,7 +2177,7 @@ cnxk_eth_dev_init(struct rte_eth_dev *eth_dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
 	/* Parse devargs string */
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 49e77e49a6..460ffa32b6 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -7,7 +7,7 @@
 int
 cnxk_nix_info_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *devinfo)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	int max_rx_pktlen;
 
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 0c337a6cc8..82e67eeff1 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -1704,7 +1704,7 @@ static int eth_cxgbe_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->dev_ops = &cxgbe_eth_dev_ops;
 	eth_dev->rx_pkt_burst = &cxgbe_recv_pkts;
 	eth_dev->tx_pkt_burst = &cxgbe_xmit_pkts;
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* for secondary processes, we attach to ethdevs allocated by primary
 	 * and do minimal initialization.
@@ -1767,7 +1767,7 @@ static int eth_cxgbe_dev_init(struct rte_eth_dev *eth_dev)
 
 static int eth_cxgbe_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	uint16_t port_id;
 	int err = 0;
 
diff --git a/drivers/net/cxgbe/cxgbevf_ethdev.c b/drivers/net/cxgbe/cxgbevf_ethdev.c
index d8eba8afef..750dc7da4d 100644
--- a/drivers/net/cxgbe/cxgbevf_ethdev.c
+++ b/drivers/net/cxgbe/cxgbevf_ethdev.c
@@ -113,7 +113,7 @@ static int eth_cxgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->dev_ops = &cxgbevf_eth_dev_ops;
 	eth_dev->rx_pkt_burst = &cxgbe_recv_pkts;
 	eth_dev->tx_pkt_burst = &cxgbe_xmit_pkts;
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* for secondary processes, we attach to ethdevs allocated by primary
 	 * and do minimal initialization.
@@ -177,7 +177,7 @@ static int eth_cxgbevf_dev_init(struct rte_eth_dev *eth_dev)
 
 static int eth_cxgbevf_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	uint16_t port_id;
 	int err = 0;
 
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index d4b4793f16..9f976d179b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -217,7 +217,6 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 	uint64_t rx_offloads = eth_conf->rxmode.offloads;
 	uint64_t tx_offloads = eth_conf->txmode.offloads;
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
-	struct rte_device *rdev = dev->device;
 	struct rte_eth_link *link = &dev->data->dev_link;
 	struct rte_dpaa_device *dpaa_dev;
 	struct fman_if *fif = dev->process_private;
@@ -230,7 +229,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
+	dpaa_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 	__fif = container_of(fif, struct __fman_if, __if);
 
@@ -426,13 +425,12 @@ dpaa_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 static void dpaa_interrupt_handler(void *param)
 {
 	struct rte_eth_dev *dev = param;
-	struct rte_device *rdev = dev->device;
 	struct rte_dpaa_device *dpaa_dev;
 	struct rte_intr_handle *intr_handle;
 	uint64_t buf;
 	int bytes_read;
 
-	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
+	dpaa_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 
 	if (rte_intr_fd_get(intr_handle) < 0)
@@ -502,7 +500,6 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 {
 	struct fman_if *fif = dev->process_private;
 	struct __fman_if *__fif;
-	struct rte_device *rdev = dev->device;
 	struct rte_dpaa_device *dpaa_dev;
 	struct rte_intr_handle *intr_handle;
 	struct rte_eth_link *link = &dev->data->dev_link;
@@ -530,7 +527,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
+	dpaa_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 	__fif = container_of(fif, struct __fman_if, __if);
 
@@ -1267,9 +1264,8 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		/* Set up the device interrupt handler */
 		if (dev->intr_handle == NULL) {
 			struct rte_dpaa_device *dpaa_dev;
-			struct rte_device *rdev = dev->device;
 
-			dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
+			dpaa_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa_dev);
 			dev->intr_handle = dpaa_dev->intr_handle;
 			if (rte_intr_vec_list_alloc(dev->intr_handle,
 					NULL, dpaa_push_queue_max_num())) {
@@ -2119,7 +2115,7 @@ dpaa_dev_init_secondary(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_device = RTE_BUS_DEVICE(eth_dev->device, *dpaa_device);
+	dpaa_device = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa_device);
 	dev_id = dpaa_device->id.dev_id;
 	cfg = dpaa_get_eth_port_cfg(dev_id);
 	fman_intf = cfg->fman_if;
@@ -2236,7 +2232,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_device = RTE_BUS_DEVICE(eth_dev->device, *dpaa_device);
+	dpaa_device = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa_device);
 	dev_id = dpaa_device->id.dev_id;
 	dpaa_intf = eth_dev->data->dev_private;
 	cfg = dpaa_get_eth_port_cfg(dev_id);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index dc9ea700ac..803a8321e0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1339,7 +1339,6 @@ dpaa2_eth_setup_irqs(struct rte_eth_dev *dev, int enable)
 static int
 dpaa2_dev_start(struct rte_eth_dev *dev)
 {
-	struct rte_device *rdev = dev->device;
 	struct rte_dpaa2_device *dpaa2_dev;
 	struct rte_eth_dev_data *data = dev->data;
 	struct dpaa2_dev_priv *priv = data->dev_private;
@@ -1351,7 +1350,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	int ret, i;
 	struct rte_intr_handle *intr_handle;
 
-	dpaa2_dev = RTE_BUS_DEVICE(rdev, *dpaa2_dev);
+	dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa2_dev);
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1458,12 +1457,11 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 	struct fsl_mc_io *dpni = dev->process_private;
 	int ret;
 	struct rte_eth_link link;
-	struct rte_device *rdev = dev->device;
 	struct rte_intr_handle *intr_handle;
 	struct rte_dpaa2_device *dpaa2_dev;
 	uint16_t i;
 
-	dpaa2_dev = RTE_BUS_DEVICE(rdev, *dpaa2_dev);
+	dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *dpaa2_dev);
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
@@ -2918,7 +2916,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
+	dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa2_dev);
 
 	hw_id = dpaa2_dev->object_id;
 	ret = dpni_open(dpni_dev, CMD_PRI_LOW, hw_id, &priv->token);
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 14416c41d0..f78d12362e 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -607,9 +607,8 @@ lx_serdes_eth_lpbk(uint16_t mac_id, int en)
 int
 dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 {
-	struct rte_device *dev = eth_dev->device;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
+	struct rte_dpaa2_device *dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret;
@@ -674,9 +673,8 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 int
 dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 {
-	struct rte_device *dev = eth_dev->device;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
+	struct rte_dpaa2_device *dpaa2_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret = 0;
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ea4afbc75d..ad2ac6dbbf 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -924,7 +924,7 @@ static inline void ena_indirect_table_release(struct ena_adapter *adapter)
 
 static int ena_close(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ena_adapter *adapter = dev->data->dev_private;
 	struct ena_com_dev *ena_dev = &adapter->ena_dev;
@@ -1457,7 +1457,7 @@ static int ena_stop(struct rte_eth_dev *dev)
 {
 	struct ena_adapter *adapter = dev->data->dev_private;
 	struct ena_com_dev *ena_dev = &adapter->ena_dev;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint16_t i;
 	int rc;
@@ -1503,7 +1503,7 @@ static int ena_create_io_queue(struct rte_eth_dev *dev, struct ena_ring *ring)
 {
 	struct ena_adapter *adapter = ring->adapter;
 	struct ena_com_dev *ena_dev = &adapter->ena_dev;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ena_com_create_io_ctx ctx =
 		/* policy set to _HOST just to satisfy icc compiler */
@@ -2422,7 +2422,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 
 	adapter->edev_data = eth_dev->data;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	PMD_INIT_LOG_LINE(INFO, "Initializing " PCI_PRI_FMT,
 		     pci_dev->addr.domain,
@@ -3978,7 +3978,7 @@ static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *de
 
 static int ena_setup_rx_intr(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int rc;
 	uint16_t vectors_nb, i;
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index df9f007473..78eba70a08 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -956,7 +956,7 @@ enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
 {
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
 	eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
@@ -986,7 +986,7 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int error = 0;
 	uint32_t si_cap;
 	struct enetc_hw *enetc_hw = &hw->hw;
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 3f257234a0..bec7128e41 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1249,7 +1249,7 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct enetc_eth_hw *hw =
 			    ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int error = 0;
 	uint32_t si_cap;
 	struct enetc_hw *enetc_hw = &hw->hw;
@@ -1297,7 +1297,7 @@ enetc4_vf_dev_intr(struct rte_eth_dev *eth_dev, bool enable)
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct enetc_hw *enetc_hw = &hw->hw;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret = 0;
 
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index b2bbace16c..f41f3c1803 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -886,7 +886,7 @@ static int
 enetc_dev_init(struct rte_eth_dev *eth_dev)
 {
 	int error = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index a853a5047a..2e5cd186f9 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -454,7 +454,7 @@ static uint32_t speed_capa_from_pci_id(struct rte_eth_dev *eth_dev)
 	struct rte_pci_device *pdev;
 	uint16_t id;
 
-	pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	id = pdev->id.subsystem_device_id;
 	for (m = vic_speed_capa_map; m->sub_devid != 0; m++) {
 		if (m->sub_devid == id)
@@ -1292,7 +1292,7 @@ static int eth_enic_dev_init(struct rte_eth_dev *eth_dev,
 	enic->rte_dev = eth_dev;
 	enic->dev_data = eth_dev->data;
 
-	pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	rte_eth_copy_pci_info(eth_dev, pdev);
 	enic->pdev = pdev;
 	addr = &pdev->addr;
diff --git a/drivers/net/enic/enic_fm_flow.c b/drivers/net/enic/enic_fm_flow.c
index c2c3e55206..4b0a513977 100644
--- a/drivers/net/enic/enic_fm_flow.c
+++ b/drivers/net/enic/enic_fm_flow.c
@@ -3229,7 +3229,7 @@ enic_fm_init(struct enic *enic)
 	if (rte_eth_dev_is_repr(enic->rte_dev))
 		addr = &VF_ENIC_TO_VF_REP(enic)->bdf;
 	else
-		addr = &RTE_ETH_DEV_TO_PCI(enic->rte_dev)->addr;
+		addr = &RTE_CLASS_TO_BUS_DEVICE(enic->rte_dev, struct rte_pci_device)->addr;
 	rc = enic_fm_find_vnic(enic, addr, &enic->fm_vnic_handle);
 	if (rc) {
 		ENICPMD_LOG(ERR, "cannot find vnic handle for %x:%x:%x",
@@ -3361,7 +3361,7 @@ enic_fm_allocate_switch_domain(struct enic *pf)
 	if (rte_eth_dev_is_repr(pf->rte_dev))
 		return -EINVAL;
 	cur = pf;
-	cur_a = &RTE_ETH_DEV_TO_PCI(cur->rte_dev)->addr;
+	cur_a = &RTE_CLASS_TO_BUS_DEVICE(cur->rte_dev, struct rte_pci_device)->addr;
 	/* Go through ports and find another PF that is on the same adapter */
 	RTE_ETH_FOREACH_DEV(pid) {
 		dev = &rte_eth_devices[pid];
@@ -3373,7 +3373,7 @@ enic_fm_allocate_switch_domain(struct enic *pf)
 			continue;
 		/* dev is another PF. Is it on the same adapter? */
 		prev = pmd_priv(dev);
-		prev_a = &RTE_ETH_DEV_TO_PCI(dev)->addr;
+		prev_a = &RTE_CLASS_TO_BUS_DEVICE(dev, struct rte_pci_device)->addr;
 		if (!enic_fm_find_vnic(cur, prev_a, &vnic_h)) {
 			ENICPMD_LOG(DEBUG, "Port %u (PF BDF %x:%x:%x) and port %u (PF BDF %x:%x:%x domain %u) are on the same VIC",
 				cur->rte_dev->data->port_id,
diff --git a/drivers/net/enic/enic_vf_representor.c b/drivers/net/enic/enic_vf_representor.c
index 05b2efedcb..fc836100b4 100644
--- a/drivers/net/enic/enic_vf_representor.c
+++ b/drivers/net/enic/enic_vf_representor.c
@@ -655,7 +655,7 @@ int enic_vf_representor_init(struct rte_eth_dev *eth_dev, void *init_params)
 	}
 
 	/* Check for non-existent VFs */
-	pdev = RTE_ETH_DEV_TO_PCI(pf->rte_dev);
+	pdev = RTE_CLASS_TO_BUS_DEVICE(pf->rte_dev, *pdev);
 	if (vf->vf_id >= pdev->max_vfs) {
 		ENICPMD_LOG(ERR, "VF ID is invalid. vf_id %u max_vfs %u",
 			    vf->vf_id, pdev->max_vfs);
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 73f4935b1f..227e1cc70e 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1410,7 +1410,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	reg_bar = pci_dev->mem_resource[GVE_REG_BAR].addr;
 	if (!reg_bar) {
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index 75534c1ce2..91a4348fb6 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -1234,7 +1234,7 @@ static int hinic_dev_stop(struct rte_eth_dev *dev)
 static void hinic_disable_interrupt(struct rte_eth_dev *dev)
 {
 	struct hinic_nic_dev *nic_dev = HINIC_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	int ret, retries = 0;
 
 	rte_bit_relaxed_clear32(HINIC_DEV_INTR_EN, &nic_dev->dev_status);
@@ -2745,7 +2745,7 @@ static int hinic_nic_dev_create(struct rte_eth_dev *eth_dev)
 			    eth_dev->data->name);
 		return -ENOMEM;
 	}
-	nic_dev->hwdev->pcidev_hdl = RTE_ETH_DEV_TO_PCI(eth_dev);
+	nic_dev->hwdev->pcidev_hdl = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *nic_dev->hwdev->pcidev_hdl);
 
 	/* init osdep*/
 	rc = hinic_osdep_init(nic_dev->hwdev);
@@ -3086,7 +3086,7 @@ static int hinic_func_init(struct rte_eth_dev *eth_dev)
 	u32 mac_size;
 	int rc;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* EAL is SECONDARY and eth_dev is already created */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
@@ -3218,7 +3218,7 @@ static int hinic_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	PMD_DRV_LOG(INFO, "Initializing pf hinic-" PCI_PRI_FMT " in %s process",
 		    pci_dev->addr.domain, pci_dev->addr.bus,
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 5d12cf7b5f..d09a8f7e7d 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -74,10 +74,11 @@ struct mgmt_event_handle {
 };
 
 bool
-hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)
+hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
-	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv == RTE_PCI_KDRV_VFIO) &&
-		(rte_vfio_noiommu_is_enabled() != 1));
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
+
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && rte_vfio_noiommu_is_enabled() != 1;
 }
 
 int
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index f4eb788686..361e52f7b9 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1474,7 +1474,7 @@ hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t sq_id)
 int
 hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = PCI_DEV_TO_INTR_HANDLE(pci_dev);
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	uint16_t msix_intr;
@@ -1493,7 +1493,7 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 int
 hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = PCI_DEV_TO_INTR_HANDLE(pci_dev);
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	uint16_t msix_intr;
@@ -1695,7 +1695,7 @@ static void
 hinic3_disable_interrupt(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))
 		return;
@@ -1710,7 +1710,7 @@ static void
 hinic3_enable_interrupt(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))
 		return;
@@ -2080,7 +2080,7 @@ hinic3_dev_release(struct rte_eth_dev *eth_dev)
 {
 	struct hinic3_nic_dev *nic_dev =
 		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int qid;
 
 	/* Release io resource. */
@@ -3394,7 +3394,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	struct rte_pci_device *pci_dev = NULL;
 	int err;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* EAL is secondary and eth_dev is already created. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
@@ -3460,7 +3460,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		err = -ENOMEM;
 		goto alloc_hwdev_mem_fail;
 	}
-	nic_dev->hwdev->pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	nic_dev->hwdev->pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *nic_dev->hwdev->pci_dev);
 	nic_dev->hwdev->dev_handle = nic_dev;
 	nic_dev->hwdev->eth_dev = eth_dev;
 	nic_dev->hwdev->port_id = eth_dev->data->port_id;
@@ -3616,7 +3616,7 @@ hinic3_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	PMD_DRV_LOG(INFO, "Initializing %.4x:%.2x:%.2x.%x in %s process",
 		    pci_dev->addr.domain, pci_dev->addr.bus,
diff --git a/drivers/net/hns3/hns3_cmd.c b/drivers/net/hns3/hns3_cmd.c
index ad4ef9e189..34e12e7359 100644
--- a/drivers/net/hns3/hns3_cmd.c
+++ b/drivers/net/hns3/hns3_cmd.c
@@ -551,7 +551,7 @@ hns3_set_dcb_capability(struct hns3_hw *hw)
 		return;
 
 	eth_dev = &rte_eth_devices[hw->data->port_id];
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	device_id = pci_dev->id.device_id;
 
 	if (device_id == HNS3_DEV_ID_25GE_RDMA ||
diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 28d7e94ffb..29b51856d9 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -812,7 +812,7 @@ hns3_init_ring_with_vector(struct hns3_hw *hw)
 int
 hns3_map_rx_interrupt(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint16_t base = RTE_INTR_VEC_ZERO_OFFSET;
@@ -878,7 +878,7 @@ hns3_map_rx_interrupt(struct rte_eth_dev *dev)
 void
 hns3_unmap_rx_interrupt(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct hns3_adapter *hns = dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
@@ -912,7 +912,7 @@ int
 hns3_restore_rx_interrupt(struct hns3_hw *hw)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[hw->data->port_id];
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint16_t q_id;
 	int ret;
@@ -943,7 +943,7 @@ hns3_get_pci_revision_id(struct hns3_hw *hw, uint8_t *revision_id)
 	int ret;
 
 	eth_dev = &rte_eth_devices[hw->data->port_id];
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	ret = rte_pci_read_config(pci_dev, &revision, 1, RTE_PCI_REVISION_ID);
 	if (ret != 1) {
 		hns3_err(hw, "failed to read pci revision id, ret = %d", ret);
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index a66fc5d81a..dbe26df77d 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -4526,8 +4526,7 @@ hns3_get_port_supported_speed(struct rte_eth_dev *eth_dev)
 static int
 hns3_init_pf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_device *dev = eth_dev->device;
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
 	int ret;
@@ -4656,8 +4655,7 @@ static void
 hns3_uninit_pf(struct rte_eth_dev *eth_dev)
 {
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
-	struct rte_device *dev = eth_dev->device;
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct hns3_hw *hw = &hns->hw;
 
 	PMD_INIT_FUNC_TRACE();
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index 59fb790240..84e733a0f5 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -1622,7 +1622,7 @@ hns3vf_clear_vport_list(struct hns3_hw *hw)
 static int
 hns3vf_init_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
 	int ret;
@@ -1739,7 +1739,7 @@ hns3vf_notify_uninit(struct hns3_hw *hw)
 static void
 hns3vf_uninit_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
 
@@ -2377,7 +2377,7 @@ static int
 hns3vf_reinit_dev(struct hns3_adapter *hns)
 {
 	struct rte_eth_dev *eth_dev = &rte_eth_devices[hns->hw.data->port_id];
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct hns3_hw *hw = &hns->hw;
 	int ret;
 
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 3528fda8a5..3b299c2f21 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -1093,7 +1093,7 @@ hns3_dev_all_rx_queue_intr_enable(struct hns3_hw *hw, bool en)
 int
 hns3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -3066,7 +3066,7 @@ hns3_tx_push_get_queue_tail_reg(struct rte_eth_dev *dev, uint16_t queue_id)
 #define HNS3_TX_PUSH_QUICK_DOORBELL_OFFSET	64
 #define HNS3_TX_PUSH_PCI_BAR_INDEX		4
 
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint8_t bar_id = HNS3_TX_PUSH_PCI_BAR_INDEX;
 
 	/*
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 03599e6432..562b2dd3c9 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2764,7 +2764,7 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	uint8_t p2p_q_vc_out_info[IDPF_DFLT_MBX_BUF_SIZE] = {0};
 	struct cpfl_vport_id vi;
 	struct cpchnl2_vport_id v_id;
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	int ret = 0;
 
 	dev->dev_ops = &cpfl_eth_dev_ops;
@@ -2836,7 +2836,7 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	}
 	/* get the vport info */
 	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
-		pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+		pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
 		vi.pf_id = CPFL_HOST0_CPF_ID;
 		vi.vf_id = pci_dev->addr.function;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 56f8f39829..4cc73f216b 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -298,7 +298,7 @@ int vcpf_add_queues(struct cpfl_adapter_ext *adapter);
 int vcpf_del_queues(struct cpfl_adapter_ext *adapter);
 
 #define CPFL_DEV_TO_PCI(eth_dev)		\
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
+	RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device)
 #define CPFL_ADAPTER_TO_EXT(p)					\
 	container_of((p), struct cpfl_adapter_ext, base)
 #define CPFL_DEV_TO_VPORT(dev)					\
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index 9e15e882b9..62ab57268f 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -273,7 +273,7 @@ eth_em_dev_is_ich8(struct e1000_hw *hw)
 static int
 eth_em_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(eth_dev->data->dev_private);
@@ -563,7 +563,7 @@ eth_em_start(struct rte_eth_dev *dev)
 		E1000_DEV_PRIVATE(dev->data->dev_private);
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret, mask;
 	uint32_t intr_vector = 0;
@@ -762,7 +762,7 @@ eth_em_stop(struct rte_eth_dev *dev)
 {
 	struct rte_eth_link link;
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	/*
@@ -816,7 +816,7 @@ eth_em_close(struct rte_eth_dev *dev)
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret;
 
@@ -1062,7 +1062,7 @@ static int
 eth_em_rx_queue_intr_enable(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	/* device interrupts are only subscribed to in primary processes */
@@ -1647,7 +1647,7 @@ static int
 eth_em_interrupt_action(struct rte_eth_dev *dev,
 			struct rte_intr_handle *intr_handle)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_interrupt *intr =
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index 54971fe285..e0dcc6a82a 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -2093,7 +2093,7 @@ em_flush_desc_rings(struct rte_eth_dev *dev)
 {
 	uint32_t fextnvm11, tdlen;
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t pci_cfg_status = 0;
 	int ret;
 
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index ef1599ac38..a4370fe32b 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -529,7 +529,7 @@ igb_intr_enable(struct rte_eth_dev *dev)
 		E1000_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
@@ -546,7 +546,7 @@ igb_intr_disable(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
@@ -783,7 +783,7 @@ static int
 eth_igb_dev_init(struct rte_eth_dev *eth_dev)
 {
 	int error = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct e1000_vfta * shadow_vfta =
@@ -1004,7 +1004,7 @@ eth_igbvf_dev_init(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
 	hw->device_id = pci_dev->id.device_id;
@@ -1300,7 +1300,7 @@ eth_igb_start(struct rte_eth_dev *dev)
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret, mask;
 	uint32_t tqavctrl;
@@ -1537,7 +1537,7 @@ static int
 eth_igb_stop(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct e1000_adapter *adapter =
@@ -1646,7 +1646,7 @@ eth_igb_close(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_eth_link link;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct e1000_filter_info *filter_info =
 		E1000_DEV_PRIVATE_TO_FILTER_INFO(dev->data->dev_private);
@@ -2931,7 +2931,7 @@ static int eth_igb_rxq_interrupt_setup(struct rte_eth_dev *dev)
 	int ret;
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int misc_shift = rte_intr_allow_others(intr_handle) ? 1 : 0;
 	struct rte_eth_dev_info dev_info;
@@ -3002,7 +3002,7 @@ eth_igb_interrupt_action(struct rte_eth_dev *dev,
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_interrupt *intr =
 		E1000_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 	int ret;
 
@@ -3496,7 +3496,7 @@ igbvf_dev_start(struct rte_eth_dev *dev)
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret;
 	uint32_t intr_vector = 0;
@@ -3560,7 +3560,7 @@ igbvf_dev_start(struct rte_eth_dev *dev)
 static int
 igbvf_dev_stop(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct e1000_adapter *adapter =
 		E1000_DEV_PRIVATE(dev->data->dev_private);
@@ -3608,7 +3608,7 @@ igbvf_dev_close(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_ether_addr addr;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -5410,7 +5410,7 @@ eth_igb_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = E1000_MISC_VEC_ID;
 
@@ -5434,7 +5434,7 @@ eth_igb_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct e1000_hw *hw =
 		E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = E1000_MISC_VEC_ID;
 
@@ -5516,7 +5516,7 @@ eth_igb_configure_msix_intr(struct rte_eth_dev *dev)
 	uint32_t vec = E1000_MISC_VEC_ID;
 	uint32_t base = E1000_MISC_VEC_ID;
 	uint32_t misc_shift = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	/* won't configure msix register if no mapping is done
diff --git a/drivers/net/intel/e1000/igb_pf.c b/drivers/net/intel/e1000/igb_pf.c
index c7588ea57e..50df3daeb7 100644
--- a/drivers/net/intel/e1000/igb_pf.c
+++ b/drivers/net/intel/e1000/igb_pf.c
@@ -29,7 +29,7 @@
 static inline uint16_t
 dev_num_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	return pci_dev->max_vfs;
 }
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 727ea36c2b..de35da2c36 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -440,7 +440,7 @@ static void
 igc_intr_other_disable(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
@@ -460,7 +460,7 @@ igc_intr_other_enable(struct rte_eth_dev *dev)
 {
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
@@ -576,7 +576,7 @@ static void
 eth_igc_interrupt_action(struct rte_eth_dev *dev)
 {
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 	int ret;
 
@@ -679,7 +679,7 @@ eth_igc_stop(struct rte_eth_dev *dev)
 {
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rte_eth_link link;
 
@@ -799,7 +799,7 @@ static void
 igc_configure_msix_intr(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	uint32_t intr_mask;
@@ -882,7 +882,7 @@ igc_rxq_interrupt_setup(struct rte_eth_dev *dev)
 {
 	uint32_t mask;
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int misc_shift = rte_intr_allow_others(intr_handle) ? 1 : 0;
 	int nb_efd;
@@ -990,7 +990,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t nsec, sec, baset_l, baset_h, tqavctrl;
 	struct timespec system_time;
@@ -1307,7 +1307,7 @@ igc_dev_free_queues(struct rte_eth_dev *dev)
 static int
 eth_igc_close(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
@@ -1359,7 +1359,7 @@ igc_identify_hardware(struct rte_eth_dev *dev, struct rte_pci_device *pci_dev)
 static int
 eth_igc_dev_init(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	int i, error = 0;
@@ -2257,7 +2257,7 @@ static int
 eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
 
@@ -2280,7 +2280,7 @@ static int
 eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
 
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 97f61afec2..ca438d2d02 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -693,7 +693,7 @@ fm10k_dev_rx_init(struct rte_eth_dev *dev)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct fm10k_macvlan_filter_info *macvlan;
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 	struct rte_intr_handle *intr_handle = pdev->intr_handle;
 	int i, ret;
 	struct fm10k_rx_queue *rxq;
@@ -1161,7 +1161,7 @@ static int
 fm10k_dev_stop(struct rte_eth_dev *dev)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 	struct rte_intr_handle *intr_handle = pdev->intr_handle;
 	int i;
 
@@ -1371,7 +1371,7 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -2364,7 +2364,7 @@ static int
 fm10k_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 
 	/* Enable ITR */
 	if (hw->mac.type == fm10k_mac_pf)
@@ -2381,7 +2381,7 @@ static int
 fm10k_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 
 	/* Disable ITR */
 	if (hw->mac.type == fm10k_mac_pf)
@@ -2397,7 +2397,7 @@ static int
 fm10k_dev_rxq_interrupt_setup(struct rte_eth_dev *dev)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 	struct rte_intr_handle *intr_handle = pdev->intr_handle;
 	uint32_t intr_vector, vec;
 	uint16_t queue_id;
@@ -2794,7 +2794,7 @@ static int
 fm10k_dev_close(struct rte_eth_dev *dev)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 	struct rte_intr_handle *intr_handle = pdev->intr_handle;
 	int ret;
 
@@ -3060,7 +3060,7 @@ static int
 eth_fm10k_dev_init(struct rte_eth_dev *dev)
 {
 	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(dev, *pdev);
 	struct rte_intr_handle *intr_handle = pdev->intr_handle;
 	int diag, i, ret;
 	struct fm10k_macvlan_filter_info *macvlan;
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 100a751225..559df03a69 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -981,7 +981,7 @@ is_floating_veb_supported(struct rte_devargs *devargs)
 static void
 config_floating_veb(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -1549,7 +1549,7 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 		return 0;
 	}
 	i40e_set_default_ptype_table(dev);
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	intr_handle = pci_dev->intr_handle;
 
 	rte_eth_copy_pci_info(dev, pci_dev);
@@ -2041,7 +2041,7 @@ void
 i40e_vsi_queues_unbind_intr(struct i40e_vsi *vsi)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(vsi);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
 	uint16_t msix_vect = vsi->msix_intr;
@@ -2157,7 +2157,7 @@ int
 i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(vsi);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
 	uint16_t msix_vect = vsi->msix_intr;
@@ -2236,7 +2236,7 @@ void
 i40e_vsi_enable_queues_intr(struct i40e_vsi *vsi)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(vsi);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
 	struct i40e_pf *pf = I40E_VSI_TO_PF(vsi);
@@ -2263,7 +2263,7 @@ void
 i40e_vsi_disable_queues_intr(struct i40e_vsi *vsi)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(vsi);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
 	struct i40e_pf *pf = I40E_VSI_TO_PF(vsi);
@@ -2431,7 +2431,7 @@ i40e_dev_start(struct rte_eth_dev *dev)
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int ret, i;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	struct i40e_vsi *vsi;
@@ -2612,7 +2612,7 @@ i40e_dev_stop(struct rte_eth_dev *dev)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct i40e_vsi *main_vsi = pf->main_vsi;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int i;
 
@@ -2674,7 +2674,7 @@ i40e_dev_close(struct rte_eth_dev *dev)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_filter_control_settings settings;
 	struct rte_flow *p_flow;
@@ -3831,7 +3831,7 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct i40e_vsi *vsi = pf->main_vsi;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	dev_info->max_rx_queues = vsi->nb_qps;
 	dev_info->max_tx_queues = vsi->nb_qps;
@@ -4884,7 +4884,7 @@ i40e_pf_parameter_init(struct rte_eth_dev *dev)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t qp_count = 0, vsi_count = 0;
 
 	if (pci_dev->max_vfs && !hw->func_caps.sr_iov_1_1) {
@@ -10033,7 +10033,7 @@ i40e_dev_flow_ops_get(struct rte_eth_dev *dev,
 static void
 i40e_enable_extended_tag(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint32_t buf = 0;
 	int ret;
 
@@ -11219,7 +11219,7 @@ i40e_dev_get_dcb_info(struct rte_eth_dev *dev,
 static int
 i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint16_t msix_intr;
@@ -11247,7 +11247,7 @@ i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 i40e_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint16_t msix_intr;
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index dcbdf65047..c39a5a8802 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1467,7 +1467,7 @@ int i40e_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
 int i40e_vf_representor_uninit(struct rte_eth_dev *ethdev);
 
 #define I40E_DEV_TO_PCI(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
+	RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device)
 
 /* I40E_DEV_PRIVATE_TO */
 #define I40E_DEV_PRIVATE_TO_PF(adapter) \
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..4ad9e594bb 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1947,7 +1947,7 @@ iavf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint16_t msix_intr;
@@ -1983,7 +1983,7 @@ iavf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint16_t msix_intr;
 
@@ -2767,7 +2767,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(eth_dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
@@ -2926,7 +2926,7 @@ static int
 iavf_dev_close(struct rte_eth_dev *dev)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 51716a4d5b..0953fd6668 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -658,7 +658,7 @@ ice_dcf_send_aq_cmd(void *dcf_hw, struct ice_aq_desc *desc,
 int
 ice_dcf_handle_vsi_update_event(struct ice_dcf_hw *hw)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(hw->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(hw->eth_dev, *pci_dev);
 	int i = 0;
 	int err = -1;
 
@@ -738,7 +738,7 @@ dcf_get_vlan_offload_caps_v2(struct ice_dcf_hw *hw)
 int
 ice_dcf_init_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret, size;
 
 	hw->resetting = false;
@@ -873,7 +873,7 @@ ice_dcf_init_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 void
 ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 715d1522f9..f0a9a8e536 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2623,7 +2623,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	}
 
 	ice_set_default_ptype_table(dev);
-	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	intr_handle = pci_dev->intr_handle;
 
 	pf->adapter = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -2956,7 +2956,7 @@ ice_dev_close(struct rte_eth_dev *dev)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -4520,7 +4520,7 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	bool is_safe_mode = pf->adapter->is_safe_mode;
 	u64 phy_type_low;
 	u64 phy_type_high;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index ea73f8bcb3..92baa62cc4 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -708,7 +708,7 @@ struct ice_vsi_vlan_pvid_info {
 };
 
 #define ICE_DEV_TO_PCI(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
+	RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device)
 
 /* ICE_DEV_PRIVATE_TO */
 #define ICE_DEV_PRIVATE_TO_PF(adapter) \
diff --git a/drivers/net/intel/idpf/idpf_ethdev.h b/drivers/net/intel/idpf/idpf_ethdev.h
index 5105eea1c5..99496c59da 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.h
+++ b/drivers/net/intel/idpf/idpf_ethdev.h
@@ -85,7 +85,7 @@ struct idpf_adapter_ext {
 TAILQ_HEAD(idpf_adapter_list, idpf_adapter_ext);
 
 #define IDPF_DEV_TO_PCI(eth_dev)		\
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
+	RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device)
 #define IDPF_ADAPTER_TO_EXT(p)					\
 	container_of((p), struct idpf_adapter_ext, base)
 
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
index 6d531120b8..505b8f367a 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
@@ -310,9 +310,6 @@ struct ipn3ke_hw {
 	uint8_t *hw_addr;
 };
 
-#define RTE_ETH_DEV_TO_AFU(eth_dev) \
-	RTE_BUS_DEVICE((eth_dev)->device, struct rte_afu_device)
-
 /**
  * PCIe MMIO Access
  */
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index cd34d08055..af1af31f1d 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -2070,7 +2070,7 @@ ipn3ke_rpst_stats_reset(struct rte_eth_dev *ethdev)
 		return -EINVAL;
 	}
 
-	afu_dev = RTE_ETH_DEV_TO_AFU(ethdev);
+	afu_dev = RTE_CLASS_TO_BUS_DEVICE(ethdev, *afu_dev);
 	if (!afu_dev) {
 		IPN3KE_AFU_PMD_ERR("afu device to reset is NULL!");
 		return -EINVAL;
@@ -2138,7 +2138,7 @@ ipn3ke_rpst_stats_get
 		return -EINVAL;
 	}
 
-	afu_dev = RTE_ETH_DEV_TO_AFU(ethdev);
+	afu_dev = RTE_CLASS_TO_BUS_DEVICE(ethdev, *afu_dev);
 	if (!afu_dev) {
 		IPN3KE_AFU_PMD_ERR("afu device to get statistics is NULL!");
 		return -EINVAL;
@@ -2228,7 +2228,7 @@ ipn3ke_rpst_xstats_get
 		return -EINVAL;
 	}
 
-	afu_dev = RTE_ETH_DEV_TO_AFU(ethdev);
+	afu_dev = RTE_CLASS_TO_BUS_DEVICE(ethdev, *afu_dev);
 	if (!afu_dev) {
 		IPN3KE_AFU_PMD_ERR("afu device to get statistics is NULL!");
 		return -EINVAL;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..39db5368b7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1085,7 +1085,7 @@ static int
 eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 {
 	struct ixgbe_adapter *ad = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
@@ -1598,7 +1598,7 @@ eth_ixgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	int diag;
 	uint32_t tc, tcs;
 	struct ixgbe_adapter *ad = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
@@ -2264,7 +2264,7 @@ ixgbe_vmdq_vlan_hw_filter_enable(struct rte_eth_dev *dev)
 static int
 ixgbe_check_vf_rss_rxq_num(struct rte_eth_dev *dev, uint16_t nb_rx_q)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	switch (nb_rx_q) {
 	case 1:
@@ -2506,7 +2506,7 @@ ixgbe_set_vf_rate_limit(struct rte_eth_dev *dev, uint16_t vf,
 	struct rte_pci_device *pci_dev;
 	int ret;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	ret = rte_eth_link_get_nowait(dev->data->port_id, &link);
 	if (ret < 0)
 		return ret;
@@ -2614,7 +2614,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	int err;
@@ -2921,7 +2921,7 @@ ixgbe_dev_stop(struct rte_eth_dev *dev)
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int vf;
 	struct ixgbe_tm_conf *tm_conf =
@@ -3082,7 +3082,7 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
 	int ret;
@@ -3970,7 +3970,7 @@ ixgbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 static int
 ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 
@@ -4100,7 +4100,7 @@ static int
 ixgbevf_dev_info_get(struct rte_eth_dev *dev,
 		     struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
 	dev_info->max_rx_queues = (uint16_t)hw->mac.max_rx_queues;
@@ -4668,7 +4668,7 @@ ixgbe_dev_interrupt_get_status(struct rte_eth_dev *dev)
 static void
 ixgbe_dev_link_status_print(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 
 	rte_eth_linkstatus_get(dev, &link);
@@ -4780,7 +4780,7 @@ static void
 ixgbe_dev_interrupt_delayed_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_interrupt *intr =
 		IXGBE_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
@@ -5344,7 +5344,7 @@ ixgbe_remove_rar(struct rte_eth_dev *dev, uint32_t index)
 static int
 ixgbe_set_default_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	/*
 	 * This function calls into the base driver, which in turn will use
@@ -5508,7 +5508,7 @@ ixgbevf_dev_start(struct rte_eth_dev *dev)
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t intr_vector = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	int err, mask = 0;
@@ -5621,7 +5621,7 @@ ixgbevf_dev_stop(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	/*
@@ -5669,7 +5669,7 @@ static int
 ixgbevf_dev_close(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret;
 
@@ -5975,7 +5975,7 @@ ixgbe_convert_vm_rx_mask_to_val(uint16_t rx_mask, uint32_t orig_val)
 static int
 ixgbevf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_interrupt *intr =
 		IXGBE_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
@@ -6005,7 +6005,7 @@ ixgbevf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 		IXGBE_DEV_PRIVATE_TO_INTR(dev->data->dev_private);
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IXGBE_MISC_VEC_ID;
 
@@ -6025,7 +6025,7 @@ ixgbevf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 ixgbe_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t mask;
 	struct ixgbe_hw *hw =
@@ -6162,7 +6162,7 @@ ixgbe_set_ivar_map(struct ixgbe_hw *hw, int8_t direction,
 static void
 ixgbevf_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -6213,7 +6213,7 @@ ixgbevf_configure_msix(struct rte_eth_dev *dev)
 static void
 ixgbe_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_hw *hw =
 		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..659007980a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1272,7 +1272,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	const struct rte_flow_item_e_tag *e_tag_mask;
 	const struct rte_flow_action *act;
 	const struct rte_flow_action_vf *act_vf;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL,
@@ -1430,7 +1430,7 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 {
 	int ret = 0;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t vf_num;
 
 	ret = cons_parse_l2_tn_filter(dev, attr, pattern,
diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/ixgbe_pf.c
index d9a775f99a..2c014a0b96 100644
--- a/drivers/net/intel/ixgbe/ixgbe_pf.c
+++ b/drivers/net/intel/ixgbe/ixgbe_pf.c
@@ -32,7 +32,7 @@
 static inline uint16_t
 dev_num_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	return pci_dev->max_vfs;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_tm.c b/drivers/net/intel/ixgbe/ixgbe_tm.c
index 27a821285d..50c7fa228a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_tm.c
+++ b/drivers/net/intel/ixgbe/ixgbe_tm.c
@@ -365,7 +365,7 @@ ixgbe_queue_base_nb_get(struct rte_eth_dev *dev, uint16_t tc_node_no,
 			uint16_t *base, uint16_t *nb)
 {
 	uint8_t nb_tcs = ixgbe_tc_nb_get(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t vf_num = pci_dev->max_vfs;
 
 	*base = 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
index 901d80e406..bad699dd70 100644
--- a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
+++ b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
@@ -190,7 +190,7 @@ ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params)
 	representor->pf_ethdev =
 		((struct ixgbe_vf_representor *)init_params)->pf_ethdev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(representor->pf_ethdev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(representor->pf_ethdev, *pci_dev);
 
 	if (representor->vf_id >= pci_dev->max_vfs)
 		return -ENODEV;
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index c2300a8955..35d364fb19 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -25,7 +25,7 @@ rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -60,7 +60,7 @@ rte_pmd_ixgbe_ping_vf(uint16_t port, uint16_t vf)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -92,7 +92,7 @@ rte_pmd_ixgbe_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -123,7 +123,7 @@ rte_pmd_ixgbe_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -153,7 +153,7 @@ rte_pmd_ixgbe_set_vf_vlan_insert(uint16_t port, uint16_t vf, uint16_t vlan_id)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -252,7 +252,7 @@ rte_pmd_ixgbe_set_vf_split_drop_en(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -289,7 +289,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
 	if (!is_ixgbe_supported(dev))
@@ -338,7 +338,7 @@ rte_pmd_ixgbe_set_vf_rxmode(uint16_t port, uint16_t vf,
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -386,7 +386,7 @@ rte_pmd_ixgbe_set_vf_rx(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
@@ -438,7 +438,7 @@ rte_pmd_ixgbe_set_vf_tx(uint16_t port, uint16_t vf, uint8_t on)
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
 
 	dev = &rte_eth_devices[port];
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!is_ixgbe_supported(dev))
 		return -ENOTSUP;
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index df8c0c76ed..6a823e9bfb 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -32,7 +32,7 @@ static void nbl_init_func_caps(const struct rte_pci_device *pci_dev, struct nbl_
 
 int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	const struct nbl_product_core_ops *product_base_ops = NULL;
 	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 	int ret = 0;
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 2b0413fb7c..35485ea691 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -868,7 +868,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
 	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	struct nbl_board_port_info *board_info;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(net_dev->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(net_dev->eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	u8 *mac;
 	int ret;
@@ -991,7 +991,7 @@ static void nbl_dev_leonis_stop(void *p)
 	const struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	const struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
 	const struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(net_dev->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(net_dev->eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	u8 *mac;
 
@@ -1105,7 +1105,7 @@ static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
 	struct nbl_register_net_param register_param = { 0 };
 	struct nbl_register_net_result register_result = { 0 };
 	struct nbl_dev_ring_mgt *ring_mgt;
-	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	const struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret = 0;
 
 	net_dev = rte_zmalloc("nbl_dev_net", sizeof(struct nbl_dev_net_mgt), 0);
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index fa936cfde7..cb7035e15f 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1525,7 +1525,6 @@ static int
 eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 {
 	struct hn_data *hv = eth_dev->data->dev_private;
-	struct rte_device *device = eth_dev->device;
 	struct rte_vmbus_device *vmbus;
 	uint32_t mtu;
 	unsigned int rxr_cnt;
@@ -1536,7 +1535,7 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	rte_spinlock_init(&hv->hotadd_lock);
 	LIST_INIT(&hv->hotadd_list);
 
-	vmbus = RTE_BUS_DEVICE(device, *vmbus);
+	vmbus = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *vmbus);
 	eth_dev->dev_ops = &hn_eth_dev_ops;
 	eth_dev->rx_queue_count = hn_dev_rx_queue_count;
 	eth_dev->rx_descriptor_status = hn_dev_rx_queue_status;
diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index cbd1deffb4..d2da18013c 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -363,7 +363,7 @@ nfp_net_start(struct rte_eth_dev *dev)
 	struct rte_eth_txmode *txmode;
 	struct nfp_net_hw_priv *hw_priv;
 	struct nfp_app_fw_nic *app_fw_nic;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	net_hw = dev->data->dev_private;
@@ -770,7 +770,7 @@ nfp_net_close(struct rte_eth_dev *dev)
 
 	hw = dev->data->dev_private;
 	pf_dev = hw_priv->pf_dev;
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	app_fw_nic = NFP_PRIV_TO_APP_FW_NIC(pf_dev->app_fw_priv);
 
 	/*
@@ -1022,7 +1022,7 @@ nfp_net_init(struct rte_eth_dev *eth_dev,
 	struct nfp_net_hw_priv *hw_priv;
 	struct nfp_app_fw_nic *app_fw_nic;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	net_hw = eth_dev->data->dev_private;
 
 	hw_init = para;
@@ -2879,7 +2879,7 @@ nfp_pci_uninit(struct rte_eth_dev *eth_dev)
 	uint16_t port_id;
 	struct rte_pci_device *pci_dev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* Free up all physical ports under PF */
 	RTE_ETH_FOREACH_DEV_OF(port_id, &pci_dev->device)
diff --git a/drivers/net/nfp/nfp_ethdev_vf.c b/drivers/net/nfp/nfp_ethdev_vf.c
index 23fa5b82ad..a86cc36592 100644
--- a/drivers/net/nfp/nfp_ethdev_vf.c
+++ b/drivers/net/nfp/nfp_ethdev_vf.c
@@ -30,7 +30,7 @@ nfp_netvf_start(struct rte_eth_dev *dev)
 	struct nfp_net_hw *net_hw;
 	struct rte_eth_conf *dev_conf;
 	struct rte_eth_rxmode *rxmode;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	/* Disabling queues just in case... */
@@ -169,7 +169,7 @@ nfp_netvf_close(struct rte_eth_dev *dev)
 		return 0;
 
 	net_hw = dev->data->dev_private;
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	hw_priv = dev->process_private;
 
 	rte_free(net_hw->eth_xstats_base);
@@ -266,7 +266,7 @@ nfp_netvf_init(struct rte_eth_dev *eth_dev)
 	const struct nfp_dev_info *dev_info;
 
 	port = eth_dev->data->port_id;
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	dev_info = nfp_dev_info_get(pci_dev->id.device_id);
 	if (dev_info == NULL) {
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index d35eee970a..2d36311cfe 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -1568,7 +1568,7 @@ nfp_rx_queue_intr_enable(struct rte_eth_dev *dev,
 	struct nfp_net_hw *hw;
 	struct rte_pci_device *pci_dev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	if (rte_intr_type_get(pci_dev->intr_handle) != RTE_INTR_HANDLE_UIO)
 		base = 1;
 
@@ -1589,7 +1589,7 @@ nfp_rx_queue_intr_disable(struct rte_eth_dev *dev,
 	struct nfp_net_hw *hw;
 	struct rte_pci_device *pci_dev;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	if (rte_intr_type_get(pci_dev->intr_handle) != RTE_INTR_HANDLE_UIO)
 		base = 1;
 
@@ -1606,7 +1606,7 @@ static void
 nfp_net_dev_link_status_print(struct rte_eth_dev *dev)
 {
 	struct rte_eth_link link;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	rte_eth_linkstatus_get(dev, &link);
 	if (link.link_status != 0)
@@ -1635,7 +1635,7 @@ nfp_net_irq_unmask(struct rte_eth_dev *dev)
 	struct rte_pci_device *pci_dev;
 
 	hw = nfp_net_get_hw(dev);
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	/* Make sure all updates are written before un-masking */
 	rte_wmb();
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 8b9d6371fb..f7b4a8b159 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -321,7 +321,7 @@ ngbe_swfw_lock_reset(struct ngbe_hw *hw)
 static int
 eth_ngbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(eth_dev);
 	struct ngbe_vfta *shadow_vfta = NGBE_DEV_VFTA(eth_dev);
 	struct ngbe_hwstrip *hwstrip = NGBE_DEV_HWSTRIP(eth_dev);
@@ -958,7 +958,7 @@ ngbe_dev_start(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_hw_stats *hw_stats = NGBE_DEV_STATS(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	int err;
@@ -1160,7 +1160,7 @@ ngbe_dev_stop(struct rte_eth_dev *dev)
 	struct ngbe_adapter *adapter = ngbe_dev_adapter(dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_vf_info *vfinfo = *NGBE_DEV_VFDATA(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int vf;
 
@@ -1256,7 +1256,7 @@ static int
 ngbe_dev_close(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
 	int ret;
@@ -1843,7 +1843,7 @@ ngbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 static int
 ngbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 
 	dev_info->max_rx_queues = (uint16_t)hw->mac.max_rx_queues;
@@ -2258,7 +2258,7 @@ ngbe_dev_interrupt_get_status(struct rte_eth_dev *dev)
 static void
 ngbe_dev_link_status_print(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 
 	rte_eth_linkstatus_get(dev, &link);
@@ -2472,7 +2472,7 @@ static s32
 ngbe_fc_hpbthresh_set(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	u32 max_frame_size, tc, dv_id, rx_pb;
 	s32 kb, marker;
 
@@ -2653,7 +2653,7 @@ ngbe_remove_rar(struct rte_eth_dev *dev, uint32_t index)
 static int
 ngbe_set_default_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	ngbe_remove_rar(dev, 0);
 	ngbe_add_rar(dev, addr, 0, pci_dev->max_vfs);
@@ -2797,7 +2797,7 @@ ngbe_uc_all_hash_table_set(struct rte_eth_dev *dev, uint8_t on)
 static int
 ngbe_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t mask;
@@ -2867,7 +2867,7 @@ ngbe_set_ivar_map(struct ngbe_hw *hw, int8_t direction,
 static void
 ngbe_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t queue_id, base = NGBE_MISC_VEC_ID;
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 6406df40d0..ea3a988df6 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -152,7 +152,7 @@ eth_ngbevf_dev_init(struct rte_eth_dev *eth_dev)
 {
 	int err;
 	uint32_t tc, tcs;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ngbe_hw *hw = ngbe_dev_hw(eth_dev);
 	struct ngbe_vfta *shadow_vfta = NGBE_DEV_VFTA(eth_dev);
@@ -465,7 +465,7 @@ static int
 ngbevf_dev_info_get(struct rte_eth_dev *dev,
 		     struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 
 	dev_info->max_rx_queues = (uint16_t)hw->mac.max_rx_queues;
@@ -588,7 +588,7 @@ ngbevf_dev_start(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t intr_vector = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	int err, mask = 0;
@@ -688,7 +688,7 @@ ngbevf_dev_stop(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_adapter *adapter = ngbe_dev_adapter(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (hw->adapter_stopped)
@@ -725,7 +725,7 @@ static int
 ngbevf_dev_close(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret;
 
@@ -898,7 +898,7 @@ ngbevf_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 static int
 ngbevf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ngbe_interrupt *intr = ngbe_dev_intr(dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
@@ -920,7 +920,7 @@ ngbevf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct ngbe_interrupt *intr = ngbe_dev_intr(dev);
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = NGBE_MISC_VEC_ID;
 
@@ -960,7 +960,7 @@ ngbevf_set_ivar_map(struct ngbe_hw *hw, int8_t direction,
 static void
 ngbevf_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	uint32_t q_idx;
diff --git a/drivers/net/ngbe/ngbe_pf.c b/drivers/net/ngbe/ngbe_pf.c
index bb62e2fbb7..db2384e28c 100644
--- a/drivers/net/ngbe/ngbe_pf.c
+++ b/drivers/net/ngbe/ngbe_pf.c
@@ -18,7 +18,7 @@
 static inline uint16_t
 dev_num_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* EM only support 7 VFs. */
 	return pci_dev->max_vfs;
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 99be30523a..876d2f9d7d 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -777,7 +777,7 @@ static int otx_ep_eth_dev_query_set_vf_mac(struct rte_eth_dev *eth_dev,
 static int
 otx_ep_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	struct otx_ep_device *otx_epvf = OTX_EP_DEV(eth_dev);
 	struct rte_ether_addr vf_mac_addr;
 	int ret = 0;
diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/otx_ep_mbox.c
index 3e94c66677..5e6be29a96 100644
--- a/drivers/net/octeon_ep/otx_ep_mbox.c
+++ b/drivers/net/octeon_ep/otx_ep_mbox.c
@@ -346,7 +346,7 @@ otx_ep_mbox_intr_handler(void *param)
 {
 	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)param;
 	struct otx_ep_device *otx_ep = (struct otx_ep_device *)eth_dev->data->dev_private;
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	union otx_ep_mbox_word mbox_cmd;
 
 	if (otx2_read64(otx_ep->hw_addr + CNXK_EP_R_MBOX_PF_VF_INT(0)) & CNXK_EP_MBOX_INTR) {
@@ -369,7 +369,7 @@ int
 otx_ep_mbox_init(struct rte_eth_dev *eth_dev)
 {
 	struct otx_ep_device *otx_ep = (struct otx_ep_device *)eth_dev->data->dev_private;
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 	uint64_t reg_val;
 	int rc;
 
@@ -402,7 +402,7 @@ void
 otx_ep_mbox_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct otx_ep_device *otx_ep = (struct otx_ep_device *)eth_dev->data->dev_private;
-	struct rte_pci_device *pdev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pdev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pdev);
 
 	otx2_write64(0, otx_ep->hw_addr + CNXK_EP_R_MBOX_PF_VF_INT(0));
 
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index c676c6fa75..4efc2dd349 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1231,7 +1231,7 @@ static int qede_args_check(const char *key, const char *val, void *opaque)
 
 static int qede_args(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_kvargs *kvlist;
 	struct rte_devargs *devargs;
 	int ret;
@@ -1540,7 +1540,7 @@ static void qede_poll_sp_sb_cb(void *param)
 
 static int qede_dev_close(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct qede_dev *qdev = QEDE_INIT_QDEV(eth_dev);
 	struct ecore_dev *edev = QEDE_INIT_EDEV(qdev);
 	int ret = 0;
@@ -2529,7 +2529,7 @@ static int qede_common_dev_init(struct rte_eth_dev *eth_dev, bool is_vf)
 	adapter = eth_dev->data->dev_private;
 	adapter->ethdev = eth_dev;
 	edev = &adapter->edev;
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	pci_addr = pci_dev->addr;
 
 	PMD_INIT_FUNC_TRACE(edev);
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index b2b1882aa5..2ac0189b61 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -301,7 +301,7 @@ rtl_dev_start(struct rte_eth_dev *dev)
 {
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int err;
 
@@ -684,7 +684,7 @@ rtl_dev_interrupt_handler(void *param)
 static int
 rtl_dev_close(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
@@ -908,7 +908,7 @@ rtl_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf
 static int
 rtl_dev_init(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 15a976ac85..e48ad0e317 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -728,7 +728,7 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 	if (adapter->intr_registered && adapter->eth_dev == eth_dev)
 		rnp_change_manage_port(adapter);
 	if (adapter->closed_ports == adapter->inited_ports) {
-		struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
+		struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 		if (adapter->intr_registered) {
 			/* disable uio irq before callback unregister */
 			rte_intr_disable(pci_dev->intr_handle);
@@ -1667,7 +1667,7 @@ rnp_rx_reset_pool_setup(struct rnp_eth_adapter *adapter)
 static int
 rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	char name[RTE_ETH_NAME_MAX_LEN] = " ";
@@ -1798,7 +1798,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 static int
 rnp_eth_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	uint16_t port_id;
 	int err = 0;
 
diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 69747e49ae..39cd8d519a 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -781,7 +781,7 @@ static int
 sfc_mem_bar_init(struct sfc_adapter *sa, const efx_bar_region_t *mem_ebrp)
 {
 	struct rte_eth_dev *eth_dev = sa->eth_dev;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	efsys_bar_t *ebp = &sa->mem_bar;
 	struct rte_mem_resource *res =
 		&pci_dev->mem_resource[mem_ebrp->ebr_index];
@@ -1283,7 +1283,7 @@ sfc_probe(struct sfc_adapter *sa)
 {
 	efx_bar_region_t mem_ebrp;
 	struct rte_eth_dev *eth_dev = sa->eth_dev;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	efx_nic_t *enp;
 	int rc;
 
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 6be98c49d0..6be91789cf 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3309,7 +3309,7 @@ static int
 sfc_eth_dev_init(struct rte_eth_dev *dev, void *init_params)
 {
 	struct sfc_adapter_shared *sas = sfc_adapter_shared_by_eth_dev(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct sfc_ethdev_init_data *init_data = init_params;
 	uint32_t logtype_main;
 	struct sfc_adapter *sa;
diff --git a/drivers/net/sfc/sfc_intr.c b/drivers/net/sfc/sfc_intr.c
index ddddefad7b..6a09da9f67 100644
--- a/drivers/net/sfc/sfc_intr.c
+++ b/drivers/net/sfc/sfc_intr.c
@@ -56,7 +56,7 @@ sfc_intr_line_handler(void *cb_arg)
 	boolean_t fatal;
 	uint32_t qmask;
 	unsigned int lsc_seq = sa->port.lsc_seq;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 
 	sfc_log_init(sa, "entry");
 
@@ -102,7 +102,7 @@ sfc_intr_message_handler(void *cb_arg)
 	efx_nic_t *enp = sa->nic;
 	boolean_t fatal;
 	unsigned int lsc_seq = sa->port.lsc_seq;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 
 	sfc_log_init(sa, "entry");
 
@@ -158,7 +158,7 @@ sfc_intr_start(struct sfc_adapter *sa)
 	if (rc != 0)
 		goto fail_intr_init;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	intr_handle = pci_dev->intr_handle;
 
 	if (intr->handler != NULL) {
@@ -240,7 +240,7 @@ void
 sfc_intr_stop(struct sfc_adapter *sa)
 {
 	struct sfc_intr *intr = &sa->intr;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 
 	sfc_log_init(sa, "entry");
 
@@ -318,7 +318,7 @@ int
 sfc_intr_attach(struct sfc_adapter *sa)
 {
 	struct sfc_intr *intr = &sa->intr;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 
 	sfc_log_init(sa, "entry");
 
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index a193229265..305c680944 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1277,8 +1277,9 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 
 	info.nic_dma_info = &sas->nic_dma_info;
 
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	rc = sa->priv.dp_rx->qcreate(sa->eth_dev->data->port_id, sw_index,
-				     &RTE_ETH_DEV_TO_PCI(sa->eth_dev)->addr,
+				     &pci_dev->addr,
 				     socket_id, &info, &rxq_info->dp);
 	if (rc != 0)
 		goto fail_dp_rx_qcreate;
diff --git a/drivers/net/sfc/sfc_sriov.c b/drivers/net/sfc/sfc_sriov.c
index 009b884d8d..f41d1b1719 100644
--- a/drivers/net/sfc/sfc_sriov.c
+++ b/drivers/net/sfc/sfc_sriov.c
@@ -44,7 +44,7 @@ sriov_mac_addr_assigned(const efx_vport_config_t *vport_config,
 int
 sfc_sriov_attach(struct sfc_adapter *sa)
 {
-	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(sa->eth_dev);
+	const struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	struct sfc_sriov *sriov = &sa->sriov;
 	efx_vport_config_t *vport_config;
 	unsigned int i;
diff --git a/drivers/net/sfc/sfc_tx.c b/drivers/net/sfc/sfc_tx.c
index ebc0a8235b..fac56cb27c 100644
--- a/drivers/net/sfc/sfc_tx.c
+++ b/drivers/net/sfc/sfc_tx.c
@@ -230,8 +230,9 @@ sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 
 	info.max_pdu = encp->enc_mac_pdu_max;
 
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	rc = sa->priv.dp_tx->qcreate(sa->eth_dev->data->port_id, sw_index,
-				     &RTE_ETH_DEV_TO_PCI(sa->eth_dev)->addr,
+				     &pci_dev->addr,
 				     socket_id, &info, &txq_info->dp);
 	if (rc != 0)
 		goto fail_dp_tx_qinit;
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 76ed76a045..6e34da7c3c 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -1471,7 +1471,7 @@ static int
 nicvf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
 	struct nicvf *nic = nicvf_pmd_priv(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -2234,7 +2234,7 @@ nicvf_eth_dev_init(struct rte_eth_dev *eth_dev)
 		}
 	}
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 5d360f8305..0f484dfe91 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -525,7 +525,7 @@ static void
 txgbe_parse_devargs(struct rte_eth_dev *dev)
 {
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_devargs *devargs = pci_dev->device.devargs;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_kvargs *kvlist;
@@ -601,7 +601,7 @@ static int
 eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 {
 	struct txgbe_adapter *ad = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(eth_dev);
 	struct txgbe_vfta *shadow_vfta = TXGBE_DEV_VFTA(eth_dev);
 	struct txgbe_hwstrip *hwstrip = TXGBE_DEV_HWSTRIP(eth_dev);
@@ -1397,7 +1397,7 @@ txgbe_vmdq_vlan_hw_filter_enable(struct rte_eth_dev *dev)
 static int
 txgbe_check_vf_rss_rxq_num(struct rte_eth_dev *dev, uint16_t nb_rx_q)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	switch (nb_rx_q) {
 	case 1:
@@ -1664,7 +1664,7 @@ txgbe_set_vf_rate_limit(struct rte_eth_dev *dev, uint16_t vf,
 	struct rte_pci_device *pci_dev;
 	int ret;
 
-	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	ret = rte_eth_link_get_nowait(dev->data->port_id, &link);
 	if (ret < 0)
 		return ret;
@@ -1736,7 +1736,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
 	struct txgbe_vf_info *vfinfo = *TXGBE_DEV_VFDATA(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t intr_vector = 0;
 	int err;
@@ -2034,7 +2034,7 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_vf_info *vfinfo = *TXGBE_DEV_VFDATA(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int vf;
 	struct txgbe_tm_conf *tm_conf = TXGBE_DEV_TM_CONF(dev);
@@ -2163,7 +2163,7 @@ static int
 txgbe_dev_close(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
 	int ret;
@@ -2822,7 +2822,7 @@ txgbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 static int
 txgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	dev_info->max_rx_queues = (uint16_t)hw->mac.max_rx_queues;
@@ -3500,7 +3500,7 @@ txgbe_dev_interrupt_get_status(struct rte_eth_dev *dev,
 static void
 txgbe_dev_link_status_print(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_eth_link link;
 
 	rte_eth_linkstatus_get(dev, &link);
@@ -3631,7 +3631,7 @@ static void
 txgbe_dev_interrupt_delayed_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
@@ -3978,7 +3978,7 @@ txgbe_remove_rar(struct rte_eth_dev *dev, uint32_t index)
 static int
 txgbe_set_default_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	txgbe_remove_rar(dev, 0);
 	txgbe_add_rar(dev, addr, 0, pci_dev->max_vfs);
@@ -4149,7 +4149,7 @@ txgbe_convert_vm_rx_mask_to_val(uint16_t rx_mask, uint32_t orig_val)
 static int
 txgbe_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t mask;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
@@ -4231,7 +4231,7 @@ txgbe_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
 static void
 txgbe_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t queue_id, base = TXGBE_MISC_VEC_ID;
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 39a5fff65c..7a50c7a855 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -232,7 +232,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	int err;
 	uint32_t tc, tcs;
 	struct txgbe_adapter *ad = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(eth_dev);
 	struct txgbe_vfta *shadow_vfta = TXGBE_DEV_VFTA(eth_dev);
@@ -561,7 +561,7 @@ static int
 txgbevf_dev_info_get(struct rte_eth_dev *dev,
 		     struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	dev_info->max_rx_queues = (uint16_t)hw->mac.max_rx_queues;
@@ -696,7 +696,7 @@ txgbevf_dev_start(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t intr_vector = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	int err, mask = 0;
@@ -801,7 +801,7 @@ txgbevf_dev_stop(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (hw->adapter_stopped)
@@ -841,7 +841,7 @@ static int
 txgbevf_dev_close(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int ret;
 
@@ -1023,7 +1023,7 @@ txgbevf_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 static int
 txgbevf_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
@@ -1045,7 +1045,7 @@ txgbevf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = TXGBE_MISC_VEC_ID;
 
@@ -1085,7 +1085,7 @@ txgbevf_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
 static void
 txgbevf_configure_msix(struct rte_eth_dev *dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t q_idx;
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index a97588e57a..1bb0d3978c 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1171,7 +1171,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	const struct rte_flow_item_e_tag *e_tag_mask;
 	const struct rte_flow_action *act;
 	const struct rte_flow_action_vf *act_vf;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL,
@@ -1328,7 +1328,7 @@ txgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 			struct rte_flow_error *error)
 {
 	int ret = 0;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t vf_num;
 
 	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
diff --git a/drivers/net/txgbe/txgbe_pf.c b/drivers/net/txgbe/txgbe_pf.c
index 700632bd88..91f73521fe 100644
--- a/drivers/net/txgbe/txgbe_pf.c
+++ b/drivers/net/txgbe/txgbe_pf.c
@@ -33,7 +33,7 @@
 static inline uint16_t
 dev_num_vf(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	return pci_dev->max_vfs;
 }
diff --git a/drivers/net/txgbe/txgbe_tm.c b/drivers/net/txgbe/txgbe_tm.c
index b62bcf54aa..29c7c4adfb 100644
--- a/drivers/net/txgbe/txgbe_tm.c
+++ b/drivers/net/txgbe/txgbe_tm.c
@@ -354,7 +354,7 @@ txgbe_queue_base_nb_get(struct rte_eth_dev *dev, uint16_t tc_node_no,
 			uint16_t *base, uint16_t *nb)
 {
 	uint8_t nb_tcs = txgbe_tc_nb_get(dev);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t vf_num = pci_dev->max_vfs;
 
 	*base = 0;
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index fcda002297..d4f4bb0920 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -73,13 +73,13 @@ eth_virtio_pci_init(struct rte_eth_dev *eth_dev)
 {
 	struct virtio_pci_dev *dev = eth_dev->data->dev_private;
 	struct virtio_hw *hw = &dev->hw;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		hw->port_id = eth_dev->data->port_id;
 		VTPCI_DEV(hw) = pci_dev;
-		ret = vtpci_init(RTE_ETH_DEV_TO_PCI(eth_dev), dev);
+		ret = vtpci_init(pci_dev, dev);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "Failed to init PCI device");
 			return -1;
@@ -91,7 +91,7 @@ eth_virtio_pci_init(struct rte_eth_dev *eth_dev)
 		else
 			VIRTIO_OPS(hw) = &virtio_legacy_ops;
 
-		ret = virtio_remap_pci(RTE_ETH_DEV_TO_PCI(eth_dev), dev);
+		ret = virtio_remap_pci(pci_dev, dev);
 		if (ret < 0) {
 			PMD_INIT_LOG(ERR, "Failed to remap PCI device");
 			return -1;
@@ -111,7 +111,7 @@ eth_virtio_pci_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 err_unmap:
-	rte_pci_unmap_device(RTE_ETH_DEV_TO_PCI(eth_dev));
+	rte_pci_unmap_device(pci_dev);
 	if (!dev->modern)
 		vtpci_legacy_ioport_unmap(hw);
 
@@ -127,11 +127,12 @@ eth_virtio_pci_uninit(struct rte_eth_dev *eth_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 		dev = eth_dev->data->dev_private;
 		hw = &dev->hw;
 
 		if (dev->modern)
-			rte_pci_unmap_device(RTE_ETH_DEV_TO_PCI(eth_dev));
+			rte_pci_unmap_device(pci_dev);
 		else
 			vtpci_legacy_ioport_unmap(hw);
 		return 0;
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index da9af08207..b7cf217724 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -308,7 +308,7 @@ eth_vmxnet3_setup_capabilities(struct vmxnet3_hw *hw,
 			       struct rte_eth_dev *eth_dev)
 {
 	uint32_t dcr, ptcr, value;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	VMXNET3_WRITE_BAR1_REG(hw, VMXNET3_REG_CMD,
 			       VMXNET3_CMD_GET_MAX_CAPABILITIES);
@@ -381,7 +381,7 @@ eth_vmxnet3_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->tx_pkt_burst = &vmxnet3_xmit_pkts;
 	eth_dev->tx_pkt_prepare = vmxnet3_prep_pkts;
 	eth_dev->rx_queue_count = vmxnet3_dev_rx_queue_count;
-	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
 	/* extra mbuf field is required to guess MSS */
 	vmxnet3_segs_dynfield_offset =
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 07fc52ac7b..39a67ff8cd 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -1048,7 +1048,7 @@ xsc_ethdev_init(struct rte_eth_dev *eth_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	priv->eth_dev = eth_dev;
-	priv->pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	priv->pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *priv->pci_dev);
 
 	ret = xsc_dev_init(priv->pci_dev, &priv->xdev);
 	if (ret) {
diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index aeb01f4652..80ff19b3ea 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -111,7 +111,7 @@ zxdh_intr_unmask(struct rte_eth_dev *dev)
 	if (rte_intr_ack(dev->intr_handle) < 0)
 		return -1;
 
-	hw->use_msix = zxdh_pci_msix_detect(RTE_ETH_DEV_TO_PCI(dev));
+	hw->use_msix = zxdh_pci_msix_detect(RTE_CLASS_TO_BUS_DEVICE(dev, struct rte_pci_device));
 
 	return 0;
 }
@@ -1586,7 +1586,7 @@ static int32_t
 zxdh_init_device(struct rte_eth_dev *eth_dev)
 {
 	struct zxdh_hw *hw = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	int ret = 0;
 
 	ret = zxdh_read_pci_caps(pci_dev, hw);
@@ -1820,7 +1820,7 @@ zxdh_get_dev_shared_data_idx(uint32_t dev_serial_id)
 static int zxdh_init_dev_share_data(struct rte_eth_dev *eth_dev)
 {
 	struct zxdh_hw *hw = eth_dev->data->dev_private;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	uint32_t serial_id = (pci_dev->addr.domain << 16) |
 				(pci_dev->addr.bus << 8) | pci_dev->addr.devid;
 	uint16_t slot_id = 0;
@@ -2201,7 +2201,7 @@ is_inic_pf(uint16_t device_id)
 static int
 zxdh_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct zxdh_hw *hw = eth_dev->data->dev_private;
 	int ret = 0;
 
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index f092ee2dec..d5520a0d71 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -1467,11 +1467,11 @@ static struct rte_pci_device *n3000_afu_get_pci_dev(struct afu_rawdev *dev)
 	if (!dev || !dev->rawdev || !dev->rawdev->device)
 		return NULL;
 
-	afudev = RTE_BUS_DEVICE(dev->rawdev->device, *afudev);
+	afudev = RTE_CLASS_TO_BUS_DEVICE(dev->rawdev, *afudev);
 	if (!afudev->rawdev || !afudev->rawdev->device)
 		return NULL;
 
-	return RTE_BUS_DEVICE(afudev->rawdev->device, struct rte_pci_device);
+	return RTE_CLASS_TO_BUS_DEVICE(afudev->rawdev, struct rte_pci_device);
 }
 
 static int dma_afu_set_irqs(struct afu_rawdev *dev, uint32_t vec_start,
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index b97967930a..d741d94634 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -459,6 +459,24 @@ void rte_bus_unregister(struct rte_bus *bus);
 #define RTE_BUS_DRIVER(drv, bus_drv_type) \
 	container_of(drv, typeof(bus_drv_type), driver)
 
+/**
+ * Helper macro to convert a device class pointer to a bus-specific device type.
+ * Works with any device class (ethdev, cryptodev, eventdev, bbdev, etc.) that has
+ * a 'device' field pointing to struct rte_device.
+ *
+ * Example: RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev) or
+ *          RTE_CLASS_TO_BUS_DEVICE(eth_dev, struct rte_pci_device)
+ *
+ * @param class_dev
+ *   Pointer to device class structure (e.g., struct rte_eth_dev *)
+ * @param bus_dev_type
+ *   Bus device type for type inference (e.g., *pci_dev or struct rte_pci_device)
+ * @return
+ *   Pointer to the bus-specific device structure
+ */
+#define RTE_CLASS_TO_BUS_DEVICE(class_dev, bus_dev_type) \
+	RTE_BUS_DEVICE((class_dev)->device, bus_dev_type)
+
 /**
  * Helper macro to iterate over all devices on a bus.
  *
-- 
2.53.0

