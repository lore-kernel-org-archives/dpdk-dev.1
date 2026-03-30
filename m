Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807010F3DCD
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8DA040670;
	Mon, 30 Mar 2026 16:14:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CCE1C40653
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880067; x=1806416067;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A34T6dyzSvZ8Hvs8mxGJq1FFpu3LLTXInzSquaXVVwA=;
 b=dNswHxVpDN8XspyI6KA3nn63w6DrYkHYGOd/ymvgTHpuXeeJcCVfaj3S
 8bIS0VlWpFJpVsVWM2mhLuNKQX9V+X8WmY/uiUC2eeQgW/hwvoGuCsu4H
 0efTsld2zrDSkO5p/er2k976/Ej01s3eFoZOj39845fsXyXLoDk0dVhVc
 /AUuHlmTQqFETFmuYt9y6LRwEdwtSZYj44qUIV4iyu9jgJaaxS1ljzBsU
 TYpQocUhluYiwpQK8DyBBbps0Nw6gpRFczsFSkMFZnn9wFtaNi9MBvH9o
 HFxjMb4LNsEuU4XF8vUFmlK43q+h2UHUqSbAXuUUul3LUl9p2uiMnYIhh w==;
X-CSE-ConnectionGUID: 1VYzqzQvQ+Cz6ybdbe2SaA==
X-CSE-MsgGUID: Q+oudYmPQzGx9HbunKdEBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761665"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:26 -0700
X-CSE-ConnectionGUID: uKvtv4UpQDeXsOxd/ff4Wg==
X-CSE-MsgGUID: MUxqbGLZR+W7NBrLiEeK8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123046"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 4/6] net/i40e: drop unsupported releases from version table
Date: Mon, 30 Mar 2026 15:11:05 +0100
Message-ID: <20260330141415.1267233-5-bruce.richardson@intel.com>
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

Remove the 21.11 and any non-LTS releases from the version tables for
X710 and X722 NICs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/i40e.rst | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 0c52807f26..f4c8d39e54 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -106,30 +106,12 @@ For X710/XL710/XXV710,
    +==============+=======================+==================+
    |    25.11     |         2.28.13       |       9.55       |
    +--------------+-----------------------+------------------+
-   |    25.07     |         2.28.7        |       9.54       |
-   +--------------+-----------------------+------------------+
-   |    25.03     |         2.27.8        |       9.53       |
-   +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       9.52       |
    +--------------+-----------------------+------------------+
-   |    24.07     |         2.25.9        |       9.50       |
-   +--------------+-----------------------+------------------+
-   |    24.03     |         2.24.6        |       9.40       |
-   +--------------+-----------------------+------------------+
    |    23.11     |         2.23.17       |       9.30       |
    +--------------+-----------------------+------------------+
-   |    23.07     |         2.22.20       |       9.20       |
-   +--------------+-----------------------+------------------+
-   |    23.03     |         2.22.18       |       9.20       |
-   +--------------+-----------------------+------------------+
    |    22.11     |         2.20.12       |       9.01       |
    +--------------+-----------------------+------------------+
-   |    22.07     |         2.19.3        |       8.70       |
-   +--------------+-----------------------+------------------+
-   |    22.03     |         2.17.15       |       8.30       |
-   +--------------+-----------------------+------------------+
-   |    21.11     |         2.17.4        |       8.30       |
-   +--------------+-----------------------+------------------+
 
 
 For X722,
@@ -139,30 +121,12 @@ For X722,
    +==============+=======================+==================+
    |    25.11     |         2.28.13       |       6.51       |
    +--------------+-----------------------+------------------+
-   |    25.07     |         2.28.7        |       6.50       |
-   +--------------+-----------------------+------------------+
-   |    25.03     |         2.27.8        |       6.50       |
-   +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       6.50       |
    +--------------+-----------------------+------------------+
-   |    24.07     |         2.25.9        |       6.50       |
-   +--------------+-----------------------+------------------+
-   |    24.03     |         2.24.6        |       6.20       |
-   +--------------+-----------------------+------------------+
    |    23.11     |         2.23.17       |       6.20       |
    +--------------+-----------------------+------------------+
-   |    23.07     |         2.22.20       |       6.20       |
-   +--------------+-----------------------+------------------+
-   |    23.03     |         2.22.18       |       6.20       |
-   +--------------+-----------------------+------------------+
    |    22.11     |         2.20.12       |       6.00       |
    +--------------+-----------------------+------------------+
-   |    22.07     |         2.19.3        |       5.60       |
-   +--------------+-----------------------+------------------+
-   |    22.03     |         2.17.15       |       5.50       |
-   +--------------+-----------------------+------------------+
-   |    21.11     |         2.17.4        |       5.30       |
-   +--------------+-----------------------+------------------+
 
 
 Configuration
-- 
2.51.0

