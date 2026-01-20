Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88073D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 06:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F65D40B9A;
	Tue, 20 Jan 2026 07:34:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A326140A87
 for <dev@dpdk.org>; Tue, 20 Jan 2026 07:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768890852; x=1800426852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UIvZsdUUFgw/UW/iZckF2GCdtdl0pe0qW3rfd1C7HgQ=;
 b=GTANCG21golMC0C0oRRjKbM6rAMTt9u0vmR3HXZICImoMpVZTVOYK6ah
 S7HmGE8spnt430roXAGw5MRmFBdCJ125OiTpxWzYSX9ivvMlCmIbHuwqM
 ZLQbNUTX+gJAECnLx/rmkj1p3YXlAJjUAvhp4QwL9yhA/PraL8BiXLzC/
 s1ZXpweK8k7CdYvuSBMKv6lGXS2rAkiJt6LLQ8qyX2VaFCKGX671jr8eT
 G4z7Y0w+u9xZS/6WZtExOUlS+UinqNI4DH/oC0youOePD1AleMKx5MXGg
 P9z2qkmweOlO7Qk5qifuIEjsqs+SXT8EypBg1DqwLTSjWpktM6P4dgRCF Q==;
X-CSE-ConnectionGUID: gpz+8lFiSD6Wl0liAlptBA==
X-CSE-MsgGUID: CUUhjJ6zSdGvqH4fR/A9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81200592"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="81200592"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 22:34:11 -0800
X-CSE-ConnectionGUID: 9t3VhUX0RjmzlP/ZpvLLnw==
X-CSE-MsgGUID: HdloypSWQJiFYDhRmfeLOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205836451"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 19 Jan 2026 22:34:09 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v4 4/4] doc: add PTP IDPF documentation
Date: Tue, 20 Jan 2026 14:11:20 -0500
Message-ID: <20260120191120.137078-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120191120.137078-1-soumyadeep.hore@intel.com>
References: <20251103160646.140084-1-soumyadeep.hore@intel.com>
 <20260120191120.137078-1-soumyadeep.hore@intel.com>
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

