Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D1FF495E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D180F40657;
	Mon, 30 Mar 2026 16:14:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 80618402D3
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880065; x=1806416065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=260K7/m48ugS5RPsm+rFvTefhTgwz3kR41OODw7tUvY=;
 b=THiwSQMx+cG0iIIj2X0RQOG6wEygId6xIwR9BnM13hyfbNoOsDVFJN0G
 8wwekZI902DqPqISRV4MTFndqvDVC82Vi7g7H7LlVmZLsnK4SDsS8trpC
 FJS8IdeCyhfy7TrHGFX6hpe4bw0VTRjWFKWj207ERWM5Nu6O7WqLWsgJC
 yRrzRFZ/SD1wRjnxXI1B6AJ+YyJh1J1Hap1ydi/3Hc0Bmz97SXzyZAAyB
 KgbRGZX0ZLiVynOtfOSEcbWYpS3JAGD3Qn9IFBWipQeeLDpCk+LGsS02z
 zSAfiCotgKnBxm4A9LHxJyaSXDfmUDnJ1n1uZLpUMOaR1HEGAK2Jkyt15 g==;
X-CSE-ConnectionGUID: QQLoFdhySdCcvUsIjgqdnQ==
X-CSE-MsgGUID: Iwpo4ooPTSOfjYxchV1FjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761658"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761658"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:23 -0700
X-CSE-ConnectionGUID: /bsBzKsMTcaER7mmqmyxyA==
X-CSE-MsgGUID: 0Y0CC6/STiKxOfgcNF3CNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123028"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/6] net/ice: merge version tables for E810 and E830
Date: Mon, 30 Mar 2026 15:11:02 +0100
Message-ID: <20260330141415.1267233-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
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

Most columns in the version table for E810 and E830 are the same, so
merge the two by renaming the "firmware" column to "E810 FW" and add a
new column for "E830 FW" with only the last two row populated.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/ice.rst | 71 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 216c79b6f2..bfd1514b39 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -58,47 +58,36 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
 and Linux distributions that were tested and verified
 are listed in the Tested Platforms section of the Release Notes for each release.
 
-For E810,
-
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP | Firmware  |
-   +===========+===============+=================+===========+==============+===========+
-   |    21.11  |     1.7.16    |      1.3.27     |  1.3.31   |    1.3.7     |    3.1    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    22.03  |     1.8.3     |      1.3.28     |  1.3.35   |    1.3.8     |    3.2    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    22.07  |     1.9.11    |      1.3.30     |  1.3.37   |    1.3.10    |    4.0    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    22.11  |     1.10.1    |      1.3.30     |  1.3.37   |    1.3.10    |    4.1    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    23.03  |     1.11.1    |      1.3.30     |  1.3.40   |    1.3.10    |    4.2    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    23.07  |     1.12.6    |      1.3.35     |  1.3.45   |    1.3.13    |    4.3    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    23.11  |     1.13.7    |      1.3.36     |  1.3.46   |    1.3.14    |    4.4    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    24.03  |     1.13.7    |      1.3.35     |  1.3.45   |    1.3.13    |    4.4    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    24.07  |     1.14.11   |      1.3.36     |  1.3.46   |    1.3.14    |    4.5    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    24.11  |     1.15.4    |      1.3.36     |  1.3.46   |    1.3.14    |    4.6    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    25.03  |     1.16.3    |      1.3.39     |  1.3.53   |    1.3.14    |    4.7    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    4.8    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-
-For E830,
-
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    DPDK   | Kernel Driver | OS Default DDP  | COMMS DDP | Wireless DDP | Firmware  |
-   +===========+===============+=================+===========+==============+===========+
-   |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    1.0    |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.11   |
-   +-----------+---------------+-----------------+-----------+--------------+-----------+
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    DPDK   | Kernel Driver | Default DDP  | COMMS DDP | Wireless DDP |  E810 FW |  E830 FW |
+   +===========+===============+==============+===========+==============+==========+==========+
+   |    21.11  |     1.7.16    |   1.3.27     |  1.3.31   |    1.3.7     |    3.1   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    22.03  |     1.8.3     |   1.3.28     |  1.3.35   |    1.3.8     |    3.2   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    22.07  |     1.9.11    |   1.3.30     |  1.3.37   |    1.3.10    |    4.0   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    22.11  |     1.10.1    |   1.3.30     |  1.3.37   |    1.3.10    |    4.1   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    23.03  |     1.11.1    |   1.3.30     |  1.3.40   |    1.3.10    |    4.2   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    23.07  |     1.12.6    |   1.3.35     |  1.3.45   |    1.3.13    |    4.3   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    23.11  |     1.13.7    |   1.3.36     |  1.3.46   |    1.3.14    |    4.4   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    24.03  |     1.13.7    |   1.3.35     |  1.3.45   |    1.3.13    |    4.4   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    24.07  |     1.14.11   |   1.3.36     |  1.3.46   |    1.3.14    |    4.5   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    24.11  |     1.15.4    |   1.3.36     |  1.3.46   |    1.3.14    |    4.6   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    25.03  |     1.16.3    |   1.3.39     |  1.3.53   |    1.3.14    |    4.7   |          |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    25.07  |     2.2.8     |   1.3.43     |  1.3.55   |    1.3.23    |    4.8   |    1.0   |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+   |    25.11  |     2.3.14    |   1.3.43     |  1.3.55   |    1.3.25    |    4.9   |    1.11  |
+   +-----------+---------------+--------------+-----------+--------------+----------+----------+
+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.51.0

