Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A710ED674
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 13:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A03042E3A;
	Fri, 27 Mar 2026 14:05:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 91CE542E1D
 for <dev@dpdk.org>; Fri, 27 Mar 2026 14:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774616713; x=1806152713;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A34T6dyzSvZ8Hvs8mxGJq1FFpu3LLTXInzSquaXVVwA=;
 b=O3+PzuIXEQ1IBhmi2tlNUpDZ6TnYBWzf38fE6pyI2EhTDEWtLXXLFuvv
 CzuNHCbcVEBShnfeBBjz+8N9hYpPrsWx9b4TxUaxPIZnNr4f0ww8bVDOF
 HR90rov0khaSIfnnhrsY/3vbAh+siKyAL0qmteyCyDNqOr9GRKWmY4oQt
 EQMxraf0zTqaFEKUZIxI/JCFhDvabr/X55Q8/phe+Oj8Blfwhctbhw1FC
 uQMpGafSaSXdH6M9rHJHd1/HLC0B38zH2gzww0TvWmMHLeOitrR391PJy
 kRv5C1b0vTF5sdEWOGzcX4+2RQFW9jG3UM6s5X7Dm+hsWI9E7s6NmfbNH w==;
X-CSE-ConnectionGUID: pC6vJRRWS8ypx3w5jTaaEQ==
X-CSE-MsgGUID: t7OpJLVZQPW7mL2Av20a8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75654591"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75654591"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:05:12 -0700
X-CSE-ConnectionGUID: zOoowyKvQtqg1mi+iwALgw==
X-CSE-MsgGUID: JmxXImKcRpK/G//2QVuzjg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2026 06:05:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/4] net/i40e: drop unsupported releases from version table
Date: Fri, 27 Mar 2026 13:04:46 +0000
Message-ID: <20260327130448.1033651-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327130448.1033651-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
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

