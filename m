Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EDFC982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 16:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D7884279C;
	Fri, 18 Sep 2026 18:51:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 95C2540285;
 Fri, 18 Sep 2026 18:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789750305; x=1821286305;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MoDqPxCQH2CJJ9iSYimS7wNvKjeKuOE+DudHxcOKNEM=;
 b=l7sJU4XQGdnSj8XcKOtNZxeazuSw0V+pZDBR+d93j1ttPBoTmtj6vlpI
 uSX1slr24zMhwjBx3I8rrTgajK/Yn5yZb1GGYEUt0c5xxXeFvuz257qeZ
 8c9co8KhVDysiI5iHqin0nuuvRtRDSeOOH47yvlrsnasQxn2xZk6VxrMR
 Es4FGrWp6iA+VwAT9UV74pMa+kCIEhaxBC4l/tENEkhw2Yxio2Pp33JnL
 /WHEfDY4lUPEvz4VvagOqATv/UF42lVe1T8wmk7ITx3YVqL6NWcTWMwyb
 AFuDpSb2abvrmsj+q2++zmqa/CrdLNmyYFBwmdcpeZL2gaQxq6Td7rCB/ w==;
X-CSE-ConnectionGUID: MMZtQjeKT7m16JfycvyZFw==
X-CSE-MsgGUID: oSzBpBLrRDSNqohW5GO+Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="92778298"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="92778298"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 09:51:44 -0700
X-CSE-ConnectionGUID: kDubVo4nS265zhma3IrExw==
X-CSE-MsgGUID: KiWi4usNQzK8Qzkv8eyCLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2717637"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 18 Sep 2026 09:51:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] vdpa/ifc: fix argument parsing
Date: Fri, 18 Sep 2026 17:51:33 +0100
Message-ID: <20260918165133.1945089-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The argument parsing in ifcvf was storing only 2 bytes to a 4-byte
integer value, leaving the int possibly with garbage in the top two
bytes. However, despite being an int, the value was actually used as a
boolean both times something was passed. Therefore, fix the bug by using
bool values and change the arg parsing function to match that.

Bugzilla ID: 2040
Fixes: 40ef35f4a504 ("net/ifc: detect if VDPA mode is specified")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..eed6f969d4 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -1480,18 +1480,19 @@ static struct rte_vdpa_dev_ops ifcvf_net_ops = {
 	.get_dev_type = ifcvf_get_device_type,
 };
 
-static inline int
-open_int(const char *key __rte_unused, const char *value, void *extra_args)
+static int
+parse_bool(const char *key __rte_unused, const char *value, void *extra_args)
 {
-	uint16_t *n = extra_args;
+	char *endp = NULL;
 
-	if (value == NULL || extra_args == NULL)
+	if (value == NULL || extra_args == NULL || value[0] == '\0')
 		return -EINVAL;
 
-	*n = (uint16_t)strtoul(value, NULL, 0);
-	if (*n == USHRT_MAX && errno == ERANGE)
+	unsigned long n = strtoul(value, &endp, 0);
+	if (*endp != '\0' || n > 1)
 		return -1;
 
+	*(bool *)extra_args = (n == 1);
 	return 0;
 }
 
@@ -1635,8 +1636,8 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	uint64_t features;
 	struct ifcvf_internal *internal = NULL;
 	struct internal_list *list = NULL;
-	int vdpa_mode = 0;
-	int sw_fallback_lm = 0;
+	bool vdpa_mode = false;
+	bool sw_fallback_lm = false;
 	struct rte_kvargs *kvlist = NULL;
 	int ret = 0;
 	int16_t device_id;
@@ -1662,9 +1663,9 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		return 1;
 	}
 
-	ret = rte_kvargs_process(kvlist, IFCVF_VDPA_MODE, &open_int,
+	ret = rte_kvargs_process(kvlist, IFCVF_VDPA_MODE, &parse_bool,
 			&vdpa_mode);
-	if (ret < 0 || vdpa_mode == 0) {
+	if (ret < 0 || !vdpa_mode) {
 		rte_kvargs_free(kvlist);
 		return 1;
 	}
@@ -1757,7 +1758,7 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
 	if (rte_kvargs_count(kvlist, IFCVF_SW_FALLBACK_LM)) {
 		ret = rte_kvargs_process(kvlist, IFCVF_SW_FALLBACK_LM,
-				&open_int, &sw_fallback_lm);
+				&parse_bool, &sw_fallback_lm);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.53.0

