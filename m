Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638B7CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 11:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05F9E4068A;
	Fri, 24 Oct 2025 13:53:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EC5664060F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 13:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761306789; x=1792842789;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3qsKTNEQInhDJTeZSoJEWrY7laHt0PDoQGLK9RJjVWA=;
 b=lNPKa8LbCGCzzpZUcYWegyjwmfQ9PjNnnPHyWW5YZQTTSkqV1BsbKdBd
 N1iGvLhe2zk3fKjarC8WCSDfKnflh1LBZLUelpYOG594YUFHhQYQZ7TF3
 Fbt+1F+JJPTNJdphv4I0SFG7o9UAsqsi1QCwyLLgyv+2xEYIOMikHs9VZ
 JpQZ6KEMiNrENOE7iV9NrDQYcodbHc+pq3X9g+1KbOSsD/gaEJ0ai5iJN
 XFY1dDlWAuViQkPo5OZuB3fB4/AyRK9y4Djz1jcV6LDvUCGRWcAKFIzml
 AtpNXcM7WVSyVRv/MN8aFROGGXVgv2qedahNECe1gGlSjuToKYgfwEPZ9 Q==;
X-CSE-ConnectionGUID: ltJQ3ZrtQn+YGK++On7QwQ==
X-CSE-MsgGUID: pYFRT5wOShWPTjRfRsZ3Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63394273"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="63394273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 04:53:08 -0700
X-CSE-ConnectionGUID: Np+vmt+4R1G4Z0wAHuatTA==
X-CSE-MsgGUID: sO0vO/G5R/2/PcmvU0+wHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="188709805"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.197])
 by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 04:53:07 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 4/4] doc: add PTP IDPF documentation
Date: Fri, 24 Oct 2025 17:38:40 +0530
Message-Id: <20251024120840.420016-5-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024120840.420016-1-soumyadeep.hore@intel.com>
References: <20251024120840.420016-1-soumyadeep.hore@intel.com>
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
2.34.1

