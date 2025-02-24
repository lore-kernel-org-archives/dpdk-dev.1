Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC1C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6305841153;
	Mon, 24 Feb 2025 16:26:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 266B5410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740410781; x=1771946781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3GVESEVVsywYvUcBs+nClny41nw+ukemy8JJEijGP6A=;
 b=nMbEQy1NWhU8eoMkfDtANtcGBqB614jx/wo7fYz0WxUYWeh3tiHbRd32
 csjtAIbJz1Nd0M74VEXsCSmb4jBJxqtUeU937lRQzhfqPpHvN0Sry4X3C
 ygTVbMYVmJDa2+gwkwELKQ0Rp/His96uhvCHmPt2NmX9aVF298ROeDAVt
 altRDHED/zNGLTe7VFtvX/DYyytTxbGXgr7+W0NUirmyzXB1A/znu1+xR
 eFEFwRq8mXmDKg4UXSu5rUu/AZuETHO0vrndnwL5D/7bg5yss27xepjYh
 M3P12YxBshquVYmL4/LEC7w5MHJixI2uVJklkUiM4jNGXdyrYM/SHkUxz Q==;
X-CSE-ConnectionGUID: dRI8V61PQDKBcP/selMXJg==
X-CSE-MsgGUID: ZiJY7QeUSqu6QN6TM8XZ0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44823606"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44823606"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:26:21 -0800
X-CSE-ConnectionGUID: 7ad2Y2bmTxWg2SCtpsFZkA==
X-CSE-MsgGUID: CXvMfnK0Q/ulY3At10785Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116107646"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2025 07:26:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] doc/nics: improve structure of Intel VF section
Date: Mon, 24 Feb 2025 15:26:05 +0000
Message-ID: <20250224152611.1012935-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152611.1012935-1-bruce.richardson@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Intel VF section in the NIC guide document had descriptions of the
various drivers at a very deep level of the document hierarchy. Improve
the structure of the doc by giving those per-driver subsections their
own top-level section. Also create a new top-level section for details
of hypervisor use of VFs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/intel_vf.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 4780ee7add..2b0eebcafe 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -68,8 +68,12 @@ and the Physical Function operates on the global resources on behalf of the Virt
 For this out-of-band communication, an SR-IOV enabled NIC provides a memory buffer for each Virtual Function,
 which is called a "Mailbox".
 
+Intel SR-IOV drivers
+--------------------
+
+
 Intel® Ethernet Adaptive Virtual Function
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Adaptive Virtual Function (IAVF) is a SR-IOV Virtual Function with the same device id (8086:1889) on different Intel Ethernet Controller.
 IAVF Driver is VF driver which supports for all future Intel devices without requiring a VM update. And since this happens to be an adaptive VF driver,
 every new drop of the VF driver would add more and more advanced features that can be turned on in the VM if the underlying HW device supports those
@@ -126,7 +130,7 @@ For more detail on SR-IOV, please refer to the following documents:
     * ``offload``: Check for use of an unsupported offload flag.
 
 The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In a virtualized environment, the programmer can enable a maximum of *64 Virtual Functions (VF)*
 globally per PCIE host-interface of the Intel Ethernet Switch FM10000 Series device.
@@ -157,7 +161,7 @@ However:
     The above is an important consideration to take into account when targeting specific packets to a selected port.
 
 Intel® X710/XL710 Gigabit Ethernet Controller VF Infrastructure
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In a virtualized environment, the programmer can enable a maximum of *128 Virtual Functions (VF)*
 globally per Intel® X710/XL710 Gigabit Ethernet Controller NIC device.
@@ -196,7 +200,7 @@ However:
     one transmit queue. The default number of queue pairs per VF is 4, and can be 16 in maximum.
 
 Intel® 82599 10 Gigabit Ethernet Controller VF Infrastructure
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The programmer can enable a maximum of *63 Virtual Functions* and there must be *one Physical Function* per Intel® 82599
 10 Gigabit Ethernet Controller NIC port.
@@ -271,7 +275,7 @@ However:
     The above is an important consideration to take into account when targeting specific packets to a selected port.
 
 Intel® 82576 Gigabit Ethernet Controller and Intel® Ethernet Controller I350 Family VF Infrastructure
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In a virtualized environment, an Intel® 82576 Gigabit Ethernet Controller serves up to eight virtual machines (VMs).
 The controller has 16 TX and 16 RX queues.
@@ -316,6 +320,10 @@ However:
 
     The above is an important consideration to take into account when targeting specific packets to a selected port.
 
+
+Hypervisor Use of VFs
+---------------------
+
 Validated Hypervisors
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -341,7 +349,7 @@ For supported kernel versions, refer to the *DPDK Release Notes*.
 .. _intel_vf_kvm:
 
 Setting Up a KVM Virtual Machine Monitor
-----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The following describes a target environment:
 
-- 
2.43.0

