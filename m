Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90306606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hQWZ69n4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8F67402A4;
	Tue, 17 Nov 2026 12:09:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 27E0F4026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 12:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794913777; x=1826449777;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m4aKO9W7nJGeCU96r1GdwN7mnhK9Oshs1fUfsneCEmk=;
 b=hQWZ69n43Jf7S4chFSirceYSLARKHJECqggnxAklzJNaZnmwl0n4snEq
 GbnW3yvqxLbLAIsMirEVco8rqgs4H+D7bi9r1xNszM+71fDyzWpb4vV+F
 hzW0euYuyi14wMxI3yicRRGnccsyESJfZLNijStZ8h4wVXJmOajQF+SNx
 zgZ/RdhxtFghSn4jYuPN0MIwlT6++i0DvpUm33NKDg+CJ2r17GmjS9H1Y
 /bfX8fE9YNQOOZHdRebY4EZygunMxVq1bYVOsMwCk4oW+eujCdFkWigoE
 BxCgLZplQ1I940u+xj7w2eFSkYKrl+7Dtmf4BdTosQZWRyiQymRJWjqZ+ Q==;
X-CSE-ConnectionGUID: cduQukr6SQeE4BdbMwj15w==
X-CSE-MsgGUID: G4CeIIJVQDSCH0ipzNRyBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3788973"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3788973"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 03:09:36 -0800
X-CSE-ConnectionGUID: JeLWY/8LSBa3P50xK3fYZg==
X-CSE-MsgGUID: DfGV/iz0QNGr1EFSgb5d5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10036911"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa009.jf.intel.com with ESMTP; 17 Nov 2026 03:09:35 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] doc: announce timesync support for cpfl and iavf
Date: Tue, 17 Nov 2026 11:04:30 +0000
Message-Id: <20261117110430.842264-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cpfl timesync support and the iavf PTP hardware clock
read support were added without updating the documentation.

Add both to the release notes, and mark timesync as
partially supported in the cpfl and iavf feature matrices,
as cpfl implements only the enable, disable and read time
operations, and iavf implements only the read time operation.

Fixes: 48ded83e8a5c ("net/cpfl: support timesync")
Fixes: f0ac118828ea ("net/iavf: support reading PTP HW clock time")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/features/cpfl.ini      | 1 +
 doc/guides/nics/features/iavf.ini      | 1 +
 doc/guides/rel_notes/release_26_11.rst | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/doc/guides/nics/features/cpfl.ini b/doc/guides/nics/features/cpfl.ini
index 6aa4a8a7ef..d606692c98 100644
--- a/doc/guides/nics/features/cpfl.ini
+++ b/doc/guides/nics/features/cpfl.ini
@@ -19,6 +19,7 @@ L3 checksum offload  = P
 L4 checksum offload  = P
 Timestamp offload    = P
 Packet type parsing  = Y
+Timesync             = P
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 4d95e2a0fc..a5f3e1f9c9 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -35,6 +35,7 @@ Timestamp offload    = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = P
 Packet type parsing  = Y
+Timesync             = P
 Descriptor status    = Y
 Extended stats       = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d3ab3662dd..e6c51ada05 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -163,6 +163,13 @@ New Features
     gated behind the new ``func-error-support`` devarg (default off).
     Added a ``func_error_recovery`` xstat to report the recovery count.
 
+* **Updated Intel cpfl driver.**
+
+  * Added support for the timesync API to enable, disable
+    and read the device PTP hardware clock (PHC).
+    Once enabled, the Rx hardware timestamp offload reports
+    valid nanosecond values.
+
 * **Updated Intel i40e driver.**
 
   * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
@@ -177,6 +184,8 @@ New Features
     The old name is no longer accepted.
   * Increased the maximum number of secondary unicast MAC addresses from 64 to 32k.
     This increases a VF port memory footprint by ~192kB.
+  * Added support for reading the PTP hardware clock (PHC) time
+    with ``rte_eth_timesync_read_time()``, when allowed by the PF.
 
 * **Updated Intel ice driver.**
 
-- 
2.25.1

