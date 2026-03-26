Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82295109E52B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 01:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 349B3427C9;
	Thu, 26 Mar 2026 02:37:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7E622427BD
 for <dev@dpdk.org>; Thu, 26 Mar 2026 02:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774489060; x=1806025060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GIna8eekck40lSvm9ehu0Gqh2MqHmUgfvHMcUscmmlw=;
 b=aPuvUnb2JZWpNSwT0fWah8S9Tyb5Y9hOh9xVwq8U3BN3dyWHmAJkqiym
 S4xIzYg1ox1WGac5dra7rXAZeURJAe386ZAEV3yIe/2kk+Gu38M3tkox0
 Yg2MG0MNrbiTbqi0d/FQd2WJyOy15+z/UVF7YM3Azt+2LyKls7g+NAzgQ
 Ic62OyWeBRFvJ+5O+gQHSg8UhWQXa2nUfdKhG1oomqIGw3AGeunExHL0i
 PfBYG/0GTSAbebZML/pXnO4WrimlTAWEUyiPn9xIqcZlogJ6SIS3bc+cG
 qBXKaa58apCd28DSCZXa11QQ1f1ZUUg6GlbkkitUxzFTI6vGBXF75Uvi0 A==;
X-CSE-ConnectionGUID: r6WfM16sSMmvZt/GoK+rAg==
X-CSE-MsgGUID: r2c4rChPSee5HgIW7wXDqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75442395"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75442395"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:39 -0700
X-CSE-ConnectionGUID: 8CI/MKV8SfSY4BAPFgnf+Q==
X-CSE-MsgGUID: qaLdTQJKTyac7y1MFpHHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="255347308"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:37 -0700
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 2/3] net/i40e: updated i40e latest recommended matching list
Date: Thu, 26 Mar 2026 00:54:06 +0000
Message-Id: <20260326005407.623302-3-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326005407.623302-1-hailinx.xu@intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
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

1. Reorder recommended table
2. add 26.03 recommended version

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/i40e.rst | 52 +++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 0c52807f26..a057db865c 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -104,31 +104,33 @@ For X710/XL710/XXV710,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
-   |    25.11     |         2.28.13       |       9.55       |
+   |    21.11     |         2.17.4        |       8.30       |
    +--------------+-----------------------+------------------+
-   |    25.07     |         2.28.7        |       9.54       |
+   |    22.03     |         2.17.15       |       8.30       |
    +--------------+-----------------------+------------------+
-   |    25.03     |         2.27.8        |       9.53       |
+   |    22.07     |         2.19.3        |       8.70       |
    +--------------+-----------------------+------------------+
-   |    24.11     |         2.26.8        |       9.52       |
+   |    22.11     |         2.20.12       |       9.01       |
    +--------------+-----------------------+------------------+
-   |    24.07     |         2.25.9        |       9.50       |
+   |    23.03     |         2.22.18       |       9.20       |
    +--------------+-----------------------+------------------+
-   |    24.03     |         2.24.6        |       9.40       |
+   |    23.07     |         2.22.20       |       9.20       |
    +--------------+-----------------------+------------------+
    |    23.11     |         2.23.17       |       9.30       |
    +--------------+-----------------------+------------------+
-   |    23.07     |         2.22.20       |       9.20       |
+   |    24.03     |         2.24.6        |       9.40       |
    +--------------+-----------------------+------------------+
-   |    23.03     |         2.22.18       |       9.20       |
+   |    24.07     |         2.25.9        |       9.50       |
    +--------------+-----------------------+------------------+
-   |    22.11     |         2.20.12       |       9.01       |
+   |    24.11     |         2.26.8        |       9.52       |
    +--------------+-----------------------+------------------+
-   |    22.07     |         2.19.3        |       8.70       |
+   |    25.03     |         2.27.8        |       9.53       |
    +--------------+-----------------------+------------------+
-   |    22.03     |         2.17.15       |       8.30       |
+   |    25.07     |         2.28.7        |       9.54       |
    +--------------+-----------------------+------------------+
-   |    21.11     |         2.17.4        |       8.30       |
+   |    25.11     |         2.28.13       |       9.55       |
+   +--------------+-----------------------+------------------+
+   |    26.03     |         2.28.16       |       9.56       |
    +--------------+-----------------------+------------------+
 
 
@@ -137,31 +139,33 @@ For X722,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
-   |    25.11     |         2.28.13       |       6.51       |
+   |    21.11     |         2.17.4        |       5.30       |
    +--------------+-----------------------+------------------+
-   |    25.07     |         2.28.7        |       6.50       |
+   |    22.03     |         2.17.15       |       5.50       |
    +--------------+-----------------------+------------------+
-   |    25.03     |         2.27.8        |       6.50       |
+   |    22.07     |         2.19.3        |       5.60       |
    +--------------+-----------------------+------------------+
-   |    24.11     |         2.26.8        |       6.50       |
+   |    22.11     |         2.20.12       |       6.00       |
    +--------------+-----------------------+------------------+
-   |    24.07     |         2.25.9        |       6.50       |
+   |    23.03     |         2.22.18       |       6.20       |
    +--------------+-----------------------+------------------+
-   |    24.03     |         2.24.6        |       6.20       |
+   |    23.07     |         2.22.20       |       6.20       |
    +--------------+-----------------------+------------------+
    |    23.11     |         2.23.17       |       6.20       |
    +--------------+-----------------------+------------------+
-   |    23.07     |         2.22.20       |       6.20       |
+   |    24.03     |         2.24.6        |       6.20       |
    +--------------+-----------------------+------------------+
-   |    23.03     |         2.22.18       |       6.20       |
+   |    24.07     |         2.25.9        |       6.50       |
    +--------------+-----------------------+------------------+
-   |    22.11     |         2.20.12       |       6.00       |
+   |    24.11     |         2.26.8        |       6.50       |
    +--------------+-----------------------+------------------+
-   |    22.07     |         2.19.3        |       5.60       |
+   |    25.03     |         2.27.8        |       6.50       |
    +--------------+-----------------------+------------------+
-   |    22.03     |         2.17.15       |       5.50       |
+   |    25.07     |         2.28.7        |       6.50       |
    +--------------+-----------------------+------------------+
-   |    21.11     |         2.17.4        |       5.30       |
+   |    25.11     |         2.28.13       |       6.51       |
+   +--------------+-----------------------+------------------+
+   |    26.03     |         2.28.16       |       6.51       |
    +--------------+-----------------------+------------------+
 
 
-- 
2.34.1

