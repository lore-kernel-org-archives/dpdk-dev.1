Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD8DC44507
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 11:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E563B402D3;
	Wed, 15 Jul 2026 13:00:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A25CF4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 13:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784113211; x=1815649211;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kuQMWUPRXqyq+Y4R3FAP1vDP6r6wMR5T0fNm7QFeKio=;
 b=lpzu/VGIPmTwb9tMxstTh402IVMj8WFM9iBoWbhGB8ZmHGYDM0DR7fQw
 2muI6Jo5NOhD8exNHpgBS/bNkJV2Wv2ycrRiwnAMKIE4ug5NueLIKstFz
 39mglaqyhwAqmxIHMhXGPnkpHp1NhSfVkA2hj/XZqxvdIHcIsKKV4PIe+
 83qWXi9JmQUIhGn2WVeVzLHUU1zeFlD8HLwpjs4JyrS3pOeaW87ZwZX4n
 1Vp9TPB4GsCclVN0Wdl0GKoxMYaih+mAbRwdJj4PzuOoxQRnQXDAmNXj6
 z9WRxrBE/QBrppLpy52n0a8J3CwWvCy+QSkXg9n8K7qwJ1slWQvu+snEl Q==;
X-CSE-ConnectionGUID: SZbTXIajRzW472DNhDfYpg==
X-CSE-MsgGUID: /uDIGgo2Qpe7hX2uNCcbSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95393160"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="95393160"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 04:00:09 -0700
X-CSE-ConnectionGUID: S9pjncF2ReSTNWr6k5PKGw==
X-CSE-MsgGUID: JtM1ysuYQTKV5fDOqLklqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="260449366"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 15 Jul 2026 04:00:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] doc: add deprecation notice for iavf devarg auto reconfig
Date: Wed, 15 Jul 2026 10:59:59 +0000
Message-ID: <20260715105959.2216756-1-ciara.loftus@intel.com>
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

The `auto_reconfig` devarg in the iavf driver is enabled by default and the
case for ever disabling it is weak. When disabled, it means the user is
requesting the driver not to restore settings (unicast/multicast
promiscuous modes) when recovering from a reset. The use case where this
might be desired is during a VF initiated reset where the user initiates
the reset and wants the VF brought back up in an untouched state. That
scenario can be facilitated by extending the `rte_pmd_iavf_reinit` API
rather than relying on this devarg, so it should be safe to remove the
devarg.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index f5c12cc747..b88774a3ae 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -159,3 +159,12 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* net/iavf: The ``auto_reconfig`` devarg is deprecated and will be removed
+  in a future release. It allows disabling the automatic restoration of
+  device settings after a VF reset, but this is of questionable value
+  since most applications expect their settings to be preserved
+  transparently across a reset. The only use case for this devarg is
+  arguably a VF initiated reset; however this functionality could be
+  supported by extending the ``rte_pmd_iavf_reinit`` API instead of
+  relying on a devarg.
-- 
2.43.0

