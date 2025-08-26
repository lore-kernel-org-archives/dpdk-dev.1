Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1CCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 19:43:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D5134065B;
	Tue, 26 Aug 2025 21:43:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5DF8840612
 for <dev@dpdk.org>; Tue, 26 Aug 2025 21:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756237398; x=1787773398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j9Ixze0hZoB5l3siI1+MHFDCb4KMcmdAraB33CBdtWs=;
 b=ZFeVaOZq/secvhrhQRHXp/Jw3R7/s655Td+5CVfFC8Gbfg+2rNZ/pcan
 i5tBpZnoBNsnzdZcpA83Ac3VCzRC54zoLfBIOR/tRy1F/KrUu5O2ZOqQJ
 rmn0E+9diXLgl1G4WJT6S2A9rLOfCqo14SwivP51ZJjWy0QsCDrA1jKAS
 9//fpRgnpCd6t9U/hqkT938PgTbck6A1dC5cnIOmJDCFwt+seSLTQsG4H
 mFhFwKafmkTgL56wARPQq4TQriV+ZY3HpO5CcVyfZs7sQaQUqOzH/Jn+k
 +PNmRrPGNqbQWN9uTEil+iRf3C/0TgfiX/Jzh5tJJWizEznG7sLPKAJT/ w==;
X-CSE-ConnectionGUID: VQWd0vBSQQWQ8ceY8cVsQA==
X-CSE-MsgGUID: z91Q6eEKR2i243dEc7GeHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62300038"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62300038"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 12:43:15 -0700
X-CSE-ConnectionGUID: S9fDSeh7QnKkaYaTIQrJkA==
X-CSE-MsgGUID: bQgpXFscSbO9JCNHnnrSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169592177"
Received: from unknown (HELO spr-npg-bds1-eec2..) ([10.233.181.123])
 by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 12:43:15 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 2/2] doc: clarify the window index usage in bbdev
Date: Tue, 26 Aug 2025 12:43:24 -0700
Message-Id: <20250826194324.95284-3-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826194324.95284-1-nicolas.chautru@intel.com>
References: <20250826194324.95284-1-nicolas.chautru@intel.com>
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

Clarify the usage, range and mapping for the set of window
indexes of each cyclic shift for the FFT processing pipeline.

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 doc/guides/prog_guide/bbdev.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index 6f1f3f65fb..064c2b1fe6 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -296,8 +296,11 @@ Capabilities details for FFT function
 
 The total number of distinct time windows supported
 for the post-FFT point-wise multiplication is exposed as ``fft_windows_num``.
-The ``window_index`` provided for each cyclic shift
-in each ``rte_bbdev_op_fft`` operation is expected to be limited to that size.
+The ``window_index`` provided for each cyclic shift in each ``rte_bbdev_op_fft`` operation is
+expected to be within the range (0 to ``fft_windows_num`` - 1).
+These indexes for up to 12 cyclic shifts are mapped consecutively into an array of 6 bytes
+(ie. the first index is the first 4 most significant bits of the first byte, etc...):
+``uint8_t window_index[RTE_BBDEV_MAX_CS_2]``.
 
 The information related to the width of each of these pre-configured window
 is also exposed using the ``fft_window_width`` array.
-- 
2.34.1

