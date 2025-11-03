Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF8CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 03:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43E3A40658;
	Mon,  3 Nov 2025 04:26:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8822D40395
 for <dev@dpdk.org>; Mon,  3 Nov 2025 04:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762140382; x=1793676382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UIvZsdUUFgw/UW/iZckF2GCdtdl0pe0qW3rfd1C7HgQ=;
 b=S4Cmh7cArX4hQU3VKHLu/92fTonEdi9epcbDxUuWKaoyAE9J9YuqawES
 h0/VfCZLlbhx3XINOXvrFtlOh0tDSNMTiTYBEr0c1T6SBsiv1UVhrZrHG
 p5aFC9EqSaV5jUi4u99TZexBB2DfOn3hPoK0ybEQ7j3Dhd1yrF8zF9thv
 xmVDHkUg1zn5gQA4gJ6J4Pdp+8jx8ZG19SoAddoSXLDTecAo4WGdhMe5P
 hNF3v7PMz44dLqJV/J6DQElxrv/yMqnXeSBSS+vsdQWEj68GwiMDeA5js
 BVB3/6+MGD1xkHsR/uBhB6iocWcJxIeT15aYhc+DhPpIT270cBxtSVwbP w==;
X-CSE-ConnectionGUID: IUuiOpboRgamGFoP2I67bQ==
X-CSE-MsgGUID: 6Twe3HJqTJ6h1j1PkOh2qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86836205"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="86836205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2025 19:26:21 -0800
X-CSE-ConnectionGUID: 2UWoQgBdTUSQPCW2+SdtEg==
X-CSE-MsgGUID: LjmoGEDkSHKfbpGk5CQvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="187481852"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2025 19:26:19 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: rajesh3.kumar@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 4/4] doc: add PTP IDPF documentation
Date: Mon,  3 Nov 2025 11:06:45 -0500
Message-ID: <20251103160646.140084-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251103160646.140084-1-soumyadeep.hore@intel.com>
References: <20251028060758.233929-1-soumyadeep.hore@intel.com>
 <20251103160646.140084-1-soumyadeep.hore@intel.com>
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

Updated the IDPF Documentation with PTP feature.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/idpf.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..6e02aa3dbb 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -109,3 +109,18 @@ The paths are chosen based on 2 conditions:
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, idpf vector PMD is disabled
   and the scalar paths are chosen.
+
+Time Synchronisation
+~~~~~~~~~~~~~~~~~~~~
+
+The system operator can run a PTP (Precision Time Protocol) client application
+to synchronise the time on the network card in ACC
+(and optionally the time on the system) to the PTP primary.
+
+IDPF PMD supports PTP client applications that use the DPDK IEEE 1588 API
+to communicate with the PTP primary clock.
+Note that PTP client application needs to run on PF in ACC.
+
+.. code-block:: console
+
+   examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 -- -T 1 -p 0x1
-- 
2.47.1

