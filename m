Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66688CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 05:47:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ED43402F0;
	Mon, 27 Oct 2025 06:47:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4B2402C9;
 Mon, 27 Oct 2025 06:47:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544057; x=1793080057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dIi5zuJW2C83nEy2jh1khwtgDtVu58liIn12sL7f3Dw=;
 b=QihBy7IqJsJFMpLYqVOIJsxm8LfktisYq+vGG9R2m9rrG0JHv7A3k9VX
 CQKgGxUHAnOrRC7EuzcQJG+6bFwkGjxjd0gdLx6USNYyfNE5OR4DXt/ic
 7kHsm1jPeODFcAG+bA12I2X+p7sEFp2ys/xlpNk2A2TtaAa4NNeM2nfEk
 OS+HVr9jC033fnZamRQkqcGr+5kxV6XbgKp7zc/0+ye3LCgkDKJtvwV/1
 NcGpHa2KEmhCNiYVs1DJ42CLGDF+fZhEGIII4c8OdKLH6LWaQBYdeamoB
 zbVnT/I7TK/vx/lTepmkaVB9iieP0fv86sF069mY8zMc1sZdU/0bUyt60 w==;
X-CSE-ConnectionGUID: CTo4qx3GS8WdWadEcPgbvg==
X-CSE-MsgGUID: +orm0FkzQ5CuZvWnQ8LriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66232936"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66232936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:47:37 -0700
X-CSE-ConnectionGUID: mlVXG91JQySRmDcstLAX7w==
X-CSE-MsgGUID: rxsGM1kqQ7q3IGYx4qID2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="189265796"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 26 Oct 2025 22:47:35 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v1 3/3] doc: update TxPP documentation
Date: Mon, 27 Oct 2025 14:28:01 -0400
Message-ID: <20251027182801.191295-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251027182801.191295-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
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

TxPP feature works only when DPDK library is compiled with
PTP feature enabled and application is run on PF.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/nics/ice.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..a15304fb34 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -457,6 +457,10 @@ This feature is currently supported only in E830 adapters.
 The flag ``RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP`` is used to enable the feature.
 In order to deliver timestamps internally ``set txtimes`` is used,
 where inter burst and intra burst time interval in nsecs is provided.
+
+Note that dpdk library should be compiled using PTP support enabled and testpmd
+application should run on PF.
+
 For example:
 
 .. code-block:: console
-- 
2.47.1

