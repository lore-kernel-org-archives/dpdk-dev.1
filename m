Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4151D59D99
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 10:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F8BF4026F;
	Mon, 15 Dec 2025 11:41:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8610E40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 11:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765795288; x=1797331288;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4D21oKucd+xBm+Ihre+5Yn3k83K+UprJKPXJN3vxu1I=;
 b=TttqnGfPT75VO+0tVcMOhf9G4vECaYOpP6Oggk4iFxoNPgOQOv4GSTzN
 fCCJbXxbf7AZ49puT4rRYk3SlDT2ph8tV4UrgWPU5CiAM4p09bfR3eW1Z
 tsjBhuFmOF36fDtzsR0xnzpXWb3MTyjNgmYbXMjY+gBOjrxPht3wzNjmS
 o8VfLgIW5CnuoVU2LCcCUaHAxBKzgsE06q7qEuSorjc4pJ+kRb2WbbMEK
 rx07fMDiNLecNh78hF7eZVrbj+dXi9oQeKF9vpY18rXhGLYCVOWyT0GnM
 +7IfDaRFH/FToKcjsJMQIgwWcjB3iZuV1Dk8aX85YU0RW8Fkm2pNEC0Qr Q==;
X-CSE-ConnectionGUID: laWWYUT2TeOBscZ5/47Tgw==
X-CSE-MsgGUID: NEP2eOcLRjSR8ornEly8Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78809384"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="78809384"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 02:41:27 -0800
X-CSE-ConnectionGUID: G2te88eQT36pFvrasTZrQA==
X-CSE-MsgGUID: 5R4cHV1FQhyvmxWaVbvZHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197735994"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa008.jf.intel.com with ESMTP; 15 Dec 2025 02:41:26 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v2] doc: update device configuration in qat guide
Date: Mon, 15 Dec 2025 10:41:09 +0000
Message-ID: <20251215104109.1476713-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201134711.797983-1-emma.finn@intel.com>
References: <20251201134711.797983-1-emma.finn@intel.com>
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

Added note for QAT driver information and device
configuration for services.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/cryptodevs/qat.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 68d792e4cc..bae7724a76 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -501,6 +501,27 @@ If you are running on a kernel which includes a driver for your device, see
    The actual crypto services enabled on the system depend
    on QAT driver capabilities and hardware slice configuration.
 
+..note::
+
+   With the introduction of QAT Generation 4, the in-tree drivers are available within the
+   mainline Linux kernel. Out-of-tree (OOT) drivers for QAT Gen 4 are currently in sustaining
+   mode, meaning they will only receive maintenance updates without new feature development.
+   Future generations of QAT will be supported with in-tree drivers exclusively.
+
+.. note::
+
+   For **in-tree drivers**, when multiple QAT instances are available, each instance is assigned a
+   different crypto service by default (asym;sym or dc). The available crypto queue pair request
+   will return zero if the corresponding service is not enabled.
+
+   To verify the device configuration, run:
+    cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
+
+   For symmetric and asymmetric crypto services, ensure that `"asym;sym"` are enabled.
+   For **out-of-tree drivers**, the configuration file for each instance can be found at:
+    /etc/<GEN>_dev<ID>.conf
+
+
 Installation using kernel.org driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

