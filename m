Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D85F4368B
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E819340666;
	Fri, 17 Apr 2026 12:56:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0C593402B2
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423392; x=1807959392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HfotPmSrL1txFKd+X4xmZi8DTKZdwdKQqR9YCaQ3pZ8=;
 b=XioGMbDKbWqZo6IZW2FYeY1GCrGi5B+uHmOWG1AoGy/a4clqQw7BegK1
 yfM57NjbD003KjK2Oyl63IqDdIIY4R/J33hEUSPU/ROOdERTIFo7wvxjV
 O+7/pbfGWCrdNf+5gt8fSIhrldjjV1TdYKbRU6LUpyD8TuTqHp6qvg+lz
 RLB0P8YJc1RXR9A34TzEAnQQX6/CwS8I274eIMSxJ1n+8yzWGf/jxwHl+
 4haLbfyf8Js3TC8dfx1adupeZHAp5xXS9iAcdo/Zf7YitBm6ls6FXd3fM
 0AtA+tNkN/a45XPEo9MoGGEpdfXpwcIEv1KsZfmRzOsbWiCaQfA9+MfIi A==;
X-CSE-ConnectionGUID: Agkzlbe/RNi3YMtAHj6gSw==
X-CSE-MsgGUID: 297AY3FhQEK0Y1psT7KEWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="87739762"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="87739762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:56:31 -0700
X-CSE-ConnectionGUID: oQOA/+ZBR26MAEq2VHJezg==
X-CSE-MsgGUID: 8+t0kf1uQaK4RTxFQHvbNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="224498019"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2026 03:56:31 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v4 3/3] doc: announce change to LLDP packet detection in iavf
 PMD
Date: Fri, 17 Apr 2026 10:56:10 +0000
Message-ID: <20260417105610.1161242-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417105610.1161242-1-ciara.loftus@intel.com>
References: <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417105610.1161242-1-ciara.loftus@intel.com>
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

The iavf PMD transmit paths currently use two methods to
identify if an mbuf holds an LLDP packet: a dynamic mbuf
field and the mbuf ptype. The ptype method is enabled via
the enable_ptype_lldp devarg. A future release will remove
the dynamic mbuf field approach at which point the ptype
will be the only approach used.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 35c9b4e06c..17f90a6352 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -154,3 +154,7 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* net/iavf: The dynamic mbuf field used to detect LLDP packets on the
+  transmit path in the iavf PMD will be removed in a future release.
+  After removal, only packet type-based detection will be supported.
-- 
2.43.0

