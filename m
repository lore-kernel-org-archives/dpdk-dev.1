Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2ACC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:53:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C159B40654;
	Wed,  5 Feb 2025 19:53:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3A0894060B
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:53:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 506A9203F59B; Wed,  5 Feb 2025 10:53:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 506A9203F59B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738781595;
 bh=Chmf9dxFIda/DOGRfoiKoPVSQUN770tI6rjDNh+U1tw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=loHN8V+EtURI+behx8/RHU63/9MaxRQL2kcze/WwK98h2MuG3KlXS3XJxndEUDznA
 iuws6RUGdJkULRgBI2tn+gBntP5oYrgafFOMucTHVtFn692vcIRZthKU0YMh4uQnKz
 Vzz8d+cfs3eeDXbgz/1TzUwWjT3ar0Is3pGinEm4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 dsinghrawat@marvell.com, palok@marvell.com, stephen@networkplumber.org
Subject: [PATCH v3 1/2] drivers/common: remove unused variables and add MSVC
 compiler flag
Date: Wed,  5 Feb 2025 10:53:09 -0800
Message-Id: <1738781590-2408-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738781590-2408-1-git-send-email-andremue@linux.microsoft.com>
References: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
 <1738781590-2408-1-git-send-email-andremue@linux.microsoft.com>
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

Removed unused variables and added MSVC specific compiler flag to
ignore warnings about unused variables, like is being done for
other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/idpf/base/meson.build       | 13 ++++++++++---
 drivers/common/idpf/idpf_common_rxtx.c     |  2 --
 drivers/common/idpf/idpf_common_virtchnl.c |  4 ++--
 drivers/common/sfc_efx/base/efx_mae.c      |  2 +-
 drivers/common/sfc_efx/base/efx_table.c    |  1 -
 drivers/common/sfc_efx/base/meson.build    | 20 +++++++++++++-------
 6 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/common/idpf/base/meson.build b/drivers/common/idpf/base/meson.build
index f30ec7dfc2..c069507f12 100644
--- a/drivers/common/idpf/base/meson.build
+++ b/drivers/common/idpf/base/meson.build
@@ -6,9 +6,16 @@ sources += files(
         'idpf_controlq_setup.c',
 )
 
-error_cflags = [
-        '-Wno-unused-variable',
-]
+if is_ms_compiler
+    error_cflags = [
+            '/wd4101', # unreferenced local variable
+    ]
+else
+    error_cflags = [
+            '-Wno-unused-variable',
+    ]
+endif
+
 foreach flag: error_cflags
     if cc.has_argument(flag)
         cflags += flag
diff --git a/drivers/common/idpf/idpf_common_rxtx.c b/drivers/common/idpf/idpf_common_rxtx.c
index a04e54ce26..9b17279181 100644
--- a/drivers/common/idpf/idpf_common_rxtx.c
+++ b/drivers/common/idpf/idpf_common_rxtx.c
@@ -1178,7 +1178,6 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
-	struct rte_eth_dev *dev;
 	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
 	uint16_t rx_id = rxq->rx_tail;
 	uint16_t rx_packet_len;
@@ -1310,7 +1309,6 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
-	uint16_t i;
 
 	volatile struct idpf_base_tx_desc *txd = txq->tx_ring;
 
diff --git a/drivers/common/idpf/idpf_common_virtchnl.c b/drivers/common/idpf/idpf_common_virtchnl.c
index de511da788..0ae1d55d79 100644
--- a/drivers/common/idpf/idpf_common_virtchnl.c
+++ b/drivers/common/idpf/idpf_common_virtchnl.c
@@ -362,7 +362,7 @@ idpf_vc_queue_grps_add(struct idpf_vport *vport,
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_cmd_info args;
-	int size, qg_info_size;
+	int size;
 	int err = -1;
 
 	size = sizeof(*p2p_queue_grps_info) +
@@ -1044,7 +1044,7 @@ int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_in
 	struct idpf_adapter *adapter = vport->adapter;
 	struct virtchnl2_config_rx_queues *vc_rxqs = NULL;
 	struct idpf_cmd_info args;
-	int size, err, i;
+	int size, err;
 
 	size = sizeof(*vc_rxqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_rxq_info);
diff --git a/drivers/common/sfc_efx/base/efx_mae.c b/drivers/common/sfc_efx/base/efx_mae.c
index 9ae136dcce..1429e7dd0a 100644
--- a/drivers/common/sfc_efx/base/efx_mae.c
+++ b/drivers/common/sfc_efx/base/efx_mae.c
@@ -740,7 +740,6 @@ efx_mae_mport_by_pcie_function(
 	__in				uint32_t vf,
 	__out				efx_mport_sel_t *mportp)
 {
-	efx_dword_t dword;
 	efx_rc_t rc;
 
 	rc = efx_mae_mport_by_pcie_mh_function(EFX_PCIE_INTERFACE_CALLER,
@@ -4280,6 +4279,7 @@ efx_mae_action_set_replay(
 	__out			efx_mae_actions_t **spec_clonep)
 {
 	const efx_nic_cfg_t *encp = efx_nic_cfg_get(enp);
+	(void)encp;
 	efx_mae_actions_t *spec_clone;
 	efx_rc_t rc;
 
diff --git a/drivers/common/sfc_efx/base/efx_table.c b/drivers/common/sfc_efx/base/efx_table.c
index 13a12a116e..50e9a37d1c 100644
--- a/drivers/common/sfc_efx/base/efx_table.c
+++ b/drivers/common/sfc_efx/base/efx_table.c
@@ -240,7 +240,6 @@ efx_table_describe(
 	const efx_nic_cfg_t *encp = efx_nic_cfg_get(enp);
 	unsigned int n_entries;
 	efx_mcdi_req_t req;
-	unsigned int i;
 	efx_rc_t rc;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_TABLE_DESCRIPTOR_IN_LEN,
diff --git a/drivers/common/sfc_efx/base/meson.build b/drivers/common/sfc_efx/base/meson.build
index 7fc04aa57b..c8deb4555e 100644
--- a/drivers/common/sfc_efx/base/meson.build
+++ b/drivers/common/sfc_efx/base/meson.build
@@ -66,13 +66,19 @@ sources = [
         'rhead_virtio.c',
 ]
 
-extra_flags = [
-        '-Wno-sign-compare',
-        '-Wno-unused-parameter',
-        '-Wno-unused-variable',
-        '-Wno-empty-body',
-        '-Wno-unused-but-set-variable',
-]
+if is_ms_compiler
+    extra_flags = [
+            '/wd4101', # unreferenced local variable
+    ]
+else
+    extra_flags = [
+            '-Wno-sign-compare',
+            '-Wno-unused-parameter',
+            '-Wno-unused-variable',
+            '-Wno-empty-body',
+            '-Wno-unused-but-set-variable',
+    ]
+endif
 
 c_args = cflags
 foreach flag: extra_flags
-- 
2.47.2.vfs.0.1

