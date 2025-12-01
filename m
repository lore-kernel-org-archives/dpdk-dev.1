Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CFD116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 13:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7BA44029C;
	Mon,  1 Dec 2025 14:47:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2377640261
 for <dev@dpdk.org>; Mon,  1 Dec 2025 14:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764596841; x=1796132841;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5vH2nAEHxn8VnNjg8GKyMSn3WxNQ+g3tIksMjvcIU98=;
 b=mC+7X3B7bqGiHtt97FJtqBFOSCi1VYENtUHI98DwjAYfYtljqgHgaU04
 qvSQ//cxUXilLmWg58Rp0pI+xJX1LoivvYLK+kTbqxa9dY2oYMtmkYYgB
 7sTC/QA+Nd1JIPCVUuUKIC0eWIiUYz141nnJSUzU5O7I1ByRWof8G3eO7
 Mm9GJvmP6VlljiMrg1YooEk+23cWqLNhA/vcJdGMfopnNVJkvgoH739Tf
 6Vnc1pCrSPKR98+G6hmgUk2akPQKy48mVqOEnqtr+Y2mpqbCoD4G6c1c+
 fvPF1S/SDj1ilqiq9IjO3XBW6y447XZPWbCQCyaS5MukFXU40lIlmUk2n g==;
X-CSE-ConnectionGUID: wQVrp3IJSTmOPH47P1Q03A==
X-CSE-MsgGUID: kBpup7OoTw6CufYOBXTJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="54090261"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="54090261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 05:47:20 -0800
X-CSE-ConnectionGUID: hO5wsiVYT3a1OlxP67oxxw==
X-CSE-MsgGUID: cD2yoZwfSm6gmXq6oJGSHw==
X-ExtLoop1: 1
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 05:47:20 -0800
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH] doc: update device configuration in qat guide
Date: Mon,  1 Dec 2025 13:47:10 +0000
Message-ID: <20251201134711.797983-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
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
 doc/guides/cryptodevs/qat.rst | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 68d792e4cc..b56203eed6 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -499,7 +499,28 @@ If you are running on a kernel which includes a driver for your device, see
 
    The asymmetric service is not supported by DPDK QAT PMD for the Gen 3 platform.
    The actual crypto services enabled on the system depend
-   on QAT driver capabilities and hardware slice configuration.
+   on QAT driver capabilities and hardware slice configuration.\
+
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
 
 Installation using kernel.org driver
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0

