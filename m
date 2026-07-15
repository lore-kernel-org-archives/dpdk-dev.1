Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870FC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 12:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C33240288;
	Wed, 15 Jul 2026 14:20:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E05654026A
 for <dev@dpdk.org>; Wed, 15 Jul 2026 14:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784118055; x=1815654055;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RMSqlZ1VE5ckXy8yPMMQVOitMTrG4ZUh7gHUqAHe4iY=;
 b=TXa/EIgaIPJzshQCVtNmJ8OsDTYRjXIn/A3mjYQ4qZYsRw00cyEiKg+T
 3c2cxFJYudXdgeQj5EET7cIH2QdCXc8JXnkeDW4FRFgdl7Pq6BDEJ43Am
 WqFHwX2p4kTTn7nzTRS116lGWEkf+D1R1qhTEVKEI7OkLDEsKg7NDvzXK
 wuliGlGpMhEi273oWL0BeFTtIrjLxatGYT6G4AE2GdM5/kPU6LjjFgR5z
 OgZw0bNXwf2Hyw1zl2hUA6vdsoBrp84M2yUH5+UklhKfSrUY0Bj05EZLN
 z9vSXcbZq7mZvPIMGY56f3Z4rt67NHoJ3myC5YmLWTcVPcRpFCDwtscpv Q==;
X-CSE-ConnectionGUID: p8vD7tWNTfueJvwjdmPVAw==
X-CSE-MsgGUID: 0M/cCOXERU6FUWSv5esr6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="87296899"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="87296899"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 05:20:53 -0700
X-CSE-ConnectionGUID: KRbvD02gSheG0jwZwwnV1A==
X-CSE-MsgGUID: NybuF5OnTxKK+AVmeonPWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="280602263"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 15 Jul 2026 05:20:52 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] doc: add deprecation notice for iavf devarg auto reconfig
Date: Wed, 15 Jul 2026 12:20:45 +0000
Message-ID: <20260715122045.2256082-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715105959.2216756-1-ciara.loftus@intel.com>
References: <20260715105959.2216756-1-ciara.loftus@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
* Shortened deprecation note
---
 doc/guides/rel_notes/deprecation.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index f5c12cc747..910feb7cf2 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -159,3 +159,9 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* net/iavf: The ``auto_reconfig`` devarg is deprecated and will be removed
+  in a future release. It allows disabling the automatic restoration of
+  device settings after a VF reset, but this is of questionable value
+  since most applications expect their settings to be preserved
+  transparently across a reset.
-- 
2.43.0

