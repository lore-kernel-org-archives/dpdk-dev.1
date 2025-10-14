Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5532ECCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 08:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FC1840A7F;
	Wed, 15 Oct 2025 10:59:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id DCED6402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760437368; x=1791973368;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7itTdoPVkiHUPndna1NpMhBb/c2xQ84iZmMwUf4fqDI=;
 b=mSLPhpAGgxLkC8j1VFmaNrZ0biu0sPFuwWbDn9hW0xv4/nnMiQdbgHhV
 kvUwudlyd5HNuFhlp7CxBwuB5tehSonp4etgBQipf4kTFNv/GtnfjKwjV
 amzFxuVKXfM/ZMLmO4EiQTn4EOHvi+z5BvDmOjBQob9nJKPt5oUUpn7Ox
 OsjJxKbgvYzodiq+Cxt3OB8CMnSOVesc/YymWKnhvy3t6ctttKsJwZtHt
 dYYx5RS4cYYZoejbEVxtdAtX49xd1Y1V6lZgaGjp690XgGD6aBweuEEGm
 4SAdt+p64KwBP10nujGevdVdvm7A8Oj/+ih/HlgMzUi1x5QA+W+jSaONT w==;
X-CSE-ConnectionGUID: QctEDJ74QpaFl+mg8sgJQQ==
X-CSE-MsgGUID: 50abKmlyTi6Q4JBuvmvV8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="80031857"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="80031857"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 03:22:47 -0700
X-CSE-ConnectionGUID: th5Xdyc5Txa4+AMJFpJbUg==
X-CSE-MsgGUID: T9EdFI5ATl2LfX2GnaJdag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="185863796"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by orviesa003.jf.intel.com with ESMTP; 14 Oct 2025 03:22:46 -0700
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v7 2/2] net/cpfl: added CPFL devID for MMG
Date: Tue, 14 Oct 2025 15:50:56 +0530
Message-Id: <20251014102056.459175-3-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014102056.459175-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014102056.459175-1-venkatesh.vemula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Oct 2025 10:59:31 +0200
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

CPFL changes added to new CPFL device id for MMG.
rebased to next-net-intel-for-next-net and fixed conflict
and compiler issue.
changed macro name IDPF_DEVICE_ID_CPF to CPFL_DEV_ID_MEV

Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
---
 .mailmap                             |  1 +
 drivers/net/intel/cpfl/cpfl_ethdev.c | 13 +++++++------
 drivers/net/intel/cpfl/cpfl_ethdev.h |  5 +++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0dcd8fce3a..7c121cf5ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1665,6 +1665,7 @@ Venkata Suresh Kumar P <venkata.suresh.kumar.p@intel.com>
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
 Venkatesh Nuthula <venki497@gmail.com>
 Venkatesh Srinivas <venkateshs@google.com>
+Venkatesh Vemula <venkatesh.vemula@intel.com>
 Venkateshwarlu Nalla <venkatn@marvell.com>
 Venkat Koppula <venkat.koppula@caviumnetworks.com>
 Venkat Kumar Ande <venkatkumar.ande@amd.com>
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 110678e312..5fc1825391 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1702,7 +1702,7 @@ cpfl_handle_vchnl_event_msg(struct cpfl_adapter_ext *adapter, uint8_t *msg, uint
 	}
 
 	/* ignore if it is ctrl vport */
-	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF &&
+	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV &&
 			adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
 		return;
 
@@ -2288,7 +2288,7 @@ cpfl_ctrl_path_close(struct cpfl_adapter_ext *adapter)
 {
 	cpfl_stop_cfgqs(adapter);
 	cpfl_remove_cfgqs(adapter);
-	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
 		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
 	else
 		vcpf_del_queues(adapter);
@@ -2299,7 +2299,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 {
 	int ret;
 
-	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF) {
+	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV) {
 		ret = cpfl_vc_create_ctrl_vport(adapter);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "Failed to create control vport");
@@ -2328,7 +2328,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 	ret = cpfl_cfgq_setup(adapter);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to setup control queues");
-		if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+		if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
 			goto err_cfgq_setup;
 		else
 			goto err_del_cfg;
@@ -2354,7 +2354,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 	cpfl_remove_cfgqs(adapter);
 err_cfgq_setup:
 err_init_ctrl_vport:
-	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
 		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
 err_del_cfg:
 	vcpf_del_queues(adapter);
@@ -2868,7 +2868,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 }
 
 static const struct rte_pci_id pci_id_cpfl_map[] = {
-	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_CPF) },
+	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MEV) },
+	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MMG) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index be73e05a0e..e05a0901d5 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -59,7 +59,8 @@
 #define CPFL_ALARM_INTERVAL	50000 /* us */
 
 /* Device IDs */
-#define IDPF_DEV_ID_CPF			0x1453
+#define CPFL_DEV_ID_MMG			0x11E0
+#define CPFL_DEV_ID_MEV			0x1453
 #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
 
 #define CPFL_HOST_ID_NUM	2
@@ -339,7 +340,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 
 		return repr->vport_info->vport.info.vsi_id;
 	} else if (itf->type == CPFL_ITF_TYPE_VPORT) {
-		if (itf->adapter->base.hw.device_id == IDPF_DEV_ID_CPF) {
+		if (itf->adapter->base.hw.device_id == CPFL_DEV_ID_MEV) {
 			vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
 
 			vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
-- 
2.34.1

