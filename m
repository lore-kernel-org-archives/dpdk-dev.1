Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 17:27:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9C3409FA;
	Mon, 27 Oct 2025 18:27:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9A16E4067D
 for <dev@dpdk.org>; Mon, 27 Oct 2025 18:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761586064; x=1793122064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fuY/st23pf4MSqLypCS2/ADsw2zq/cD8bCchVSc2WwE=;
 b=N68tIE+Gz96gv1COYCUNnILGha/x2qwwGx1dv81ISvHgjtihJ333INWF
 u/0iLp43LLfFhLX+PUrWNqL4XluBiVc6SQOJ30ZQ1OuclGeG9omNfmq5K
 BFCOtUocmD6AQxFHdaKb464omd4QPpE/wuNGwlbMH1jlIgxwcN/Sc2E9a
 diJ4jlngNPiZBSK5rIpPruPKdbphhUAGZNRYGPZ3/K3zLDbqRDjWz/utv
 trk/GjmTpmG0Q4vsZcN51uRck1KJpYCEBuJAt9uF4OSiTeRZp8/OljP/w
 iuRUos0UWG307Bzfw0ScqUpy/cXFj95xXDmu837YZbNHMuDxmLOHud39a w==;
X-CSE-ConnectionGUID: I7uRFEPOQF6mfSxN6Md9vw==
X-CSE-MsgGUID: 5YVmQB2JTceM58r7U9G1ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74350897"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="74350897"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 10:27:43 -0700
X-CSE-ConnectionGUID: 0z/NO+fwR6iBOWTawq+7Ow==
X-CSE-MsgGUID: sgPJ03W0Q5u0SYwmIaneZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; d="scan'208";a="189140765"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa003.jf.intel.com with ESMTP; 27 Oct 2025 10:27:42 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v2 4/4] doc: add PTP IDPF documentation
Date: Tue, 28 Oct 2025 02:07:58 -0400
Message-ID: <20251028060758.233929-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028060758.233929-1-soumyadeep.hore@intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
 <20251028060758.233929-1-soumyadeep.hore@intel.com>
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
 doc/guides/nics/idpf.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..e76632904b 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -109,3 +109,19 @@ The paths are chosen based on 2 conditions:
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, idpf vector PMD is disabled
   and the scalar paths are chosen.
+
+Time Synchronisation
+~~~~~~~~~~~~~~~~~~~~
+
+The system operator can run a PTP (Precision Time Protocol) client application
+to synchronise the time on the network card in ACC
+(and optionally the time on the system) to the PTP master.
+
+IDPF PMD supports PTP client applications that use the DPDK IEEE 1588 API
+to communicate with the PTP master clock.
+Note that PTP client application needs to run on PF in ACC
+and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector mode.
+
+.. code-block:: console
+
+   examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
-- 
2.47.1

