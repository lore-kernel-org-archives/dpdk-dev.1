Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D161CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61B514065F;
	Wed, 20 May 2026 11:29:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A96BC40609
 for <dev@dpdk.org>; Wed, 20 May 2026 11:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779269395; x=1810805395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xQpDLBMnO3PJRmxm3QMYUexkb9gA8Rh3sOEVI8L3pZ8=;
 b=Juou5jizEzflnlwrr6dWO0TQXPSP7/bpq2XjTwfwkQLjD+INoNCo44Do
 /qVCqiul+b2tKP/7qccGR8BfHFTCEC6s2wZF9ehXpChwTvg745FdR1sC8
 Eb2Ib4j+eFxBufB+0eVdd2zEm162+BR+h85G9t975Zq4561NZUlMfQyqK
 2pEG8/vVwelzzYKgmpCX3Czw1UY5RAktU/rt+1aePNgSabGoFnx2vdzMe
 dOkOoJCqfk4cTfmJ3pgOXNl2sy3Ik5vhgnWsBHAVIpulQvZxg7+a/YLE1
 eWETwIdNKO0tpy4jU7zop5WczSRQ67Ay2InUw2KIKAYojDkw6TXofd9nc A==;
X-CSE-ConnectionGUID: 78kZJZYJQFu/CwOnjy0StA==
X-CSE-MsgGUID: rAdDbnROSRyXoB4gu5GyRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80013705"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80013705"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:29:54 -0700
X-CSE-ConnectionGUID: tVDshMZWSR6iNqk8lMmkjA==
X-CSE-MsgGUID: z+1Rcno9R6egfl3Puxphgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="245088191"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa005.jf.intel.com with ESMTP; 20 May 2026 02:29:53 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v2 2/2] doc: update recommended matching versions for cpfl and
 idpf
Date: Wed, 20 May 2026 18:03:06 -0400
Message-ID: <20260520220306.85273-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520220306.85273-1-soumyadeep.hore@intel.com>
References: <20260509015408.29188-3-soumyadeep.hore@intel.com>
 <20260520220306.85273-1-soumyadeep.hore@intel.com>
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

Update the recommended MEV-ts release version corresponding to DPDK
release in the cpfl and idpf drivers documentation.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/cpfl.rst | 21 ++++++++-------------
 doc/guides/nics/idpf.rst | 19 ++++++++-----------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index bc42c524ea..377397e621 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -28,19 +28,14 @@ It is highly recommended to upgrade the MEV-ts release
 to avoid compatibility issues with the cpfl PMD.
 Here is the suggested matching list which has been tested and verified.
 
-   +------------+------------------+
-   |     DPDK   |  MEV-ts release  |
-   +============+==================+
-   |    23.07   |      0.9.1       |
-   +------------+------------------+
-   |    23.11   |       1.0        |
-   +------------+------------------+
-   |    24.07   |       1.4        |
-   +------------+------------------+
-   |    24.11   |       1.6        |
-   +------------+------------------+
-   |    25.07   |       2.0        |
-   +------------+------------------+
+=====  ==============
+DPDK   MEV-ts release
+=====  ==============
+26.07       2.2
+25.11       2.0
+24.11       1.6
+23.11       1.0
+=====  ==============
 
 
 Configuration
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index c7c76190c8..cc89d22cf0 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -26,17 +26,14 @@ It is highly recommended to upgrade the idpf kernel driver, MEV-ts release
 to avoid compatibility issues with the idpf PMD.
 Here is the suggested matching list which has been tested and verified.
 
-   +------------+---------------+------------------+
-   |    DPDK    | Kernel Driver |  MEV-ts release  |
-   +============+===============+==================+
-   |    23.07   |    0.0.710    |      0.9.1       |
-   +------------+---------------+------------------+
-   |    23.11   |    0.0.720    |       1.0        |
-   +------------+---------------+------------------+
-   |    24.11   |    0.0.754    |       1.6        |
-   +------------+---------------+------------------+
-   |    25.07   |    0.0.772    |       2.0        |
-   +------------+---------------+------------------+
+=====  =============  ==============
+DPDK   Kernel Driver  MEV-ts release
+=====  =============  ==============
+26.07     0.0.780           2.2
+25.11     0.0.772           2.0
+24.11     0.0.754           1.6
+23.11     0.0.720           1.0
+=====  =============  ==============
 
 
 Configuration
-- 
2.47.1

