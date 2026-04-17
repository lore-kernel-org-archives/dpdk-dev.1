Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC545F43689
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1368F40668;
	Fri, 17 Apr 2026 12:08:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2060240662
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776420497; x=1807956497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HfotPmSrL1txFKd+X4xmZi8DTKZdwdKQqR9YCaQ3pZ8=;
 b=bSo33D+G1dXwluy94YQjIqZqoI7dP+IQnsSxSgntqmXjRborbAmZJDKq
 dBLESf51kop4JEUE3mlZXjfn2xOnXKLoIwoS1J+x7R5GKYI9mZOwu5Pst
 kJlcs96QHfVKunjwi8l0zBQWosbmFUVfrRwglUczTJOBicDESAgXY2Ja0
 RxAYGaa0RZ44XeQsf/WSxzMIPslGHEnFg4oeAgsV3diBXlNh9JuAW7Slj
 Vif0j5LZLfgE0QBG/nCmN6VGXPhwtR2zfIKAsW7d6aBBPH7jj84RsT+iv
 6esUnjGSph5DGGucfDHqfDz1bgcbNbOFrkT0PG5UXKnpH5aKYW/1OU3Iw w==;
X-CSE-ConnectionGUID: TZN+JgcTThW2NGwc8HosJg==
X-CSE-MsgGUID: uNCCvMcXTeedK1MljNjF8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88887893"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="88887893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:08:17 -0700
X-CSE-ConnectionGUID: 7/I/nnkgRumh1wkqBjIkiQ==
X-CSE-MsgGUID: PH+EGbZGTsq/h6dJDMAkNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="234987836"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 17 Apr 2026 03:08:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 3/3] doc: announce change to LLDP packet detection in iavf
 PMD
Date: Fri, 17 Apr 2026 10:08:04 +0000
Message-ID: <20260417100804.1143121-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417100804.1143121-1-ciara.loftus@intel.com>
References: <20260306115214.467033-1-ciara.loftus@intel.com>
 <20260417100804.1143121-1-ciara.loftus@intel.com>
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

