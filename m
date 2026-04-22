Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F2F9B5F5
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD7F40661;
	Wed, 22 Apr 2026 11:16:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7A14440651
 for <dev@dpdk.org>; Wed, 22 Apr 2026 11:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776849386; x=1808385386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HfotPmSrL1txFKd+X4xmZi8DTKZdwdKQqR9YCaQ3pZ8=;
 b=dZaRfstLtNMLVkzMUkMbUfF/EcOkh8WeVPhN9krG6dzMhyw2rg5QxIRQ
 gshOpMPm0Itp/TUuDiWdV87CATlbf4ZQvYAk/qfGrz7lKM7yDlzd/X/ci
 F8njuBIWIMPCfxw01RJ2ie0LwLVwXta754ZBqdaotVOcKFpOyzsNUC1Ge
 GX1O2Y/u+L4GyEFb78dq0BVHdmSPHJ3TdIDL4RCCIbFDly3/3X0RoqlFU
 YVHCwnlV1UqKaZ2M03wJtd1f+USgRxVBquwsb/duDygE53d2kpgShz5Zu
 fcU2leKv3wEbq2oS6Ho5CdNPLN4b1NEOtERv308/uj7Ta/XtdKaopONbi A==;
X-CSE-ConnectionGUID: gq5s/KtUSDaVoRkc4Hz0QQ==
X-CSE-MsgGUID: 87aKtOMJR06QxEcTcgdCuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89266810"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="89266810"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:16:25 -0700
X-CSE-ConnectionGUID: VqkaTh47SUytVSj/RBGfAw==
X-CSE-MsgGUID: xkBWqpFuTyi3wDtbjgLGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229631857"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 22 Apr 2026 02:16:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v5 3/3] doc: announce change to LLDP packet detection in iavf
 PMD
Date: Wed, 22 Apr 2026 09:16:09 +0000
Message-ID: <20260422091609.1797686-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422091609.1797686-1-ciara.loftus@intel.com>
References: <20260417105610.1161242-4-ciara.loftus@intel.com>
 <20260422091609.1797686-1-ciara.loftus@intel.com>
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

