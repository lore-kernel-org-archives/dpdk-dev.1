Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE32D12675
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 21:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD1D4021F;
	Tue,  2 Dec 2025 22:42:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 12C04400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 22:42:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764711777; x=1796247777;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+dgzQM+6HHYJS+leB65767bDAGE7hzp0f21g7IBd/BE=;
 b=LkWBlYf83WwPZsqmSeSN6imZrxfcebGjHuFfa6EljOywcE2y3CLJCdkR
 UVlaiXi2w9CBySTMrA1SZLra8URDQNImVOakwVMkANKeBRMLhQs+IjBaw
 pQfDsCtROkogjHfvxTuIzpJji4gX74WWe9P68620tZvUA+IUu2m1pBgTu
 XwJQmXcoq89UDaBx4FJ3lKOZ6s05BWIru/CzQiWJYzzVcsEjVq49jftGV
 IaUaINpkKlvvQrgySNcksRQGsSuOzlctSnNRBU/7yDAv56oBVwUPkuxD8
 8TY+IE6FsJtS3zS5g9JuN6wqQQHbHjfEJcHShe3l6ZrKS/qsxz5Ov+eyN w==;
X-CSE-ConnectionGUID: SMNHGcbNT6G+9VYTXyvlug==
X-CSE-MsgGUID: jVwyK2JoRUiukQZ/rob0Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66655171"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; d="scan'208";a="66655171"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 13:42:55 -0800
X-CSE-ConnectionGUID: 0DKumTZGQkaOWsINnmWKNQ==
X-CSE-MsgGUID: sUHAO9w9TziHoxBLVT5fLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; d="scan'208";a="195284937"
Received: from client-08.iind.intel.com ([10.190.203.148])
 by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2025 13:42:54 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] doc: update QinQ strip & VLAN filter notes
Date: Tue,  2 Dec 2025 20:55:53 +0000
Message-ID: <20251202205554.24405-1-anurag.mandal@intel.com>
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

Tested QinQ stripping with TPIDs 0x88A8 and 0x8100.
Removed QinQ related obsolete notes for FW version >= 8.4.
Added new "QinQ strip" section under "Sample Application Notes".
Added VLAN filter enable command to its notes as, VLAN cannot
be added to port without it.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/i40e.rst | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 165798fb94..45dc083c94 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -357,9 +357,41 @@ To start ``testpmd``, and add vlan 10 to port 0:
     ...
 
     testpmd> set promisc 0 off
+    testpmd> vlan set filter on 0
     testpmd> rx_vlan add 10 0
 
 
+QinQ strip
+~~~~~~~~~~~
+
+QinQ TPID is set as 0x8100 IEEE 802.1Q by default.
+For QinQ strip with TPID 0x88A8 IEEE 802.1ad, extend VLAN is enabled and VLAN outer tpid is set to 0x88A8.
+Vlan filter steps can be added before or after.
+
+To start ``testpmd``, and enable QinQ strip for TPID 0x88A8 on port 0:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
+    ...
+
+    testpmd> vlan set extend on 0
+    testpmd> vlan set outer tpid 0x88A8 0
+    testpmd> vlan set qinq_strip on 0
+
+For QinQ strip with TPID 0x8100, extend VLAN is enabled only.
+
+To start ``testpmd``, and enable QinQ strip for default TPID on port 0:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --forward-mode=mac
+    ...
+
+    testpmd> vlan set extend on 0
+    testpmd> vlan set qinq_strip on 0
+
+
 Flow Director
 ~~~~~~~~~~~~~
 
@@ -919,10 +951,7 @@ Vlan related Features miss when FW >= 8.4
 
 If FW version >= 8.4, there'll be some Vlan related issues:
 
-#. TCI input set for QinQ  is invalid.
-#. Fail to configure TPID for QinQ.
-#. Need to enable QinQ before enabling Vlan filter.
-#. Fail to strip outer Vlan.
+#. TCI input set for QinQ is invalid.
 
 Example of getting best performance with l3fwd example
 ------------------------------------------------------
-- 
2.43.0

