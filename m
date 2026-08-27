Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5948EC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 04:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2255640151;
	Fri, 28 Aug 2026 06:45:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BEE6F40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 06:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787892348; x=1819428348;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=thBX8x3K1P0MFQzeDBl6J6TuI356OQtkRENA6Tq8yJk=;
 b=nFesj+F16YgP5agl/T+mXC61FC4e4I+5Vup5+Oh+VsEGph7XU7eLXxW5
 GIPHLbI0bOh6Jxb/Xn/R5AQe1kAYO7YkZloF4CtXNJk7GSnvLHOB9vL8e
 HsGRsbOwtgdnyPIt2Q8JG+dWfOwPpwBU5Huo+eDtZzdgrB8TR9XlhKXcQ
 MtnEsyodeFEuvz4ZJnAaXlidPVGkeahv3K+gtj3+cI5BaykU2YRsxsamo
 KrOmoGPAUP5fplr/XU50Trh49pPcfpJj0ZHEGtQzYWBenZooXB5FPF1C/
 8bXimnRgHFh5PwoMvOVzIRKUWE31oKF9z5cPLo5C/+eOUPKaOYTHapBZk g==;
X-CSE-ConnectionGUID: RQSy+6RRR8egeRhTaoSsFw==
X-CSE-MsgGUID: lx/XSUL6RL+wgqOVOYyinw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99915187"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="99915187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 21:45:47 -0700
X-CSE-ConnectionGUID: n6U/OteLR5q9rPFp1+hhdQ==
X-CSE-MsgGUID: r1iJEWPXTxmj/TBhgkrj4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="297954085"
Received: from spr4.iind.intel.com ([10.138.182.75])
 by orviesa002.jf.intel.com with ESMTP; 27 Aug 2026 21:45:45 -0700
From: Atul Patel <atul.patel@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, praveen.shetty@intel.com, atul.patel@intel.com,
 dhananjay.shukla@intel.com
Subject: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Date: Fri, 28 Aug 2026 02:52:16 +0530
Message-Id: <20260827212216.765057-1-atul.patel@intel.com>
X-Mailer: git-send-email 2.34.1
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

The VF ID was incorrectly set to only the PCI function number,
which fails when VFs span multiple PCI devices (device IDs > 0).
Calculate the VF ID as (device_id * 8) + function to correctly
map VFs across devices.

Fixes: f1ab44fb0ebf ("net/cpfl: add vCPF port info")

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Signed-off-by: Atul Patel <atul.patel@intel.com>
Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c |  3 ++-
 drivers/net/intel/cpfl/cpfl_ethdev.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 4315adb68c..01e1b57cc8 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2839,7 +2839,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 		pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
 		vi.pf_id = CPFL_HOST0_CPF_ID;
-		vi.vf_id = pci_dev->addr.function;
+		vi.vf_id = VCPF_VF_ID_FROM_PCI(pci_dev->addr.devid,
+						pci_dev->addr.function);
 
 		v_id.vport_id = cpfl_vport->base.vport_info.info.vport_id;
 		v_id.vport_type = cpfl_vport->base.vport_info.info.vport_type;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index d41aa93191..97ec128128 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -103,6 +103,16 @@
 	((((type) & 0x3) << 14) + (((host_id) & 0x1) << 13) +	\
 	 (((pf_id) & 0x1) << 12) + ((vf_id) & 0xfff))
 
+/* Max VFs per PCI device (functions 0-7) */
+#define VCPF_VFS_PER_PCI_DEV	8
+
+/* Calculate VF ID from PCI device and function IDs.
+ * VFs span multiple PCI devices, e.g.:
+ *   device 0: VF 0-7, device 1: VF 8-15, etc.
+ */
+#define VCPF_VF_ID_FROM_PCI(device_id, function) \
+	(((device_id) * VCPF_VFS_PER_PCI_DEV) + (function))
+
 struct cpfl_vport_param {
 	struct cpfl_adapter_ext *adapter;
 	uint16_t devarg_id; /* arg id from user */
-- 
2.34.1

