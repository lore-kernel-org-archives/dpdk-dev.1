Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EDECFD31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 09:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7929340654;
	Mon, 24 Nov 2025 10:32:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 342EB40648
 for <dev@dpdk.org>; Mon, 24 Nov 2025 10:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763976772; x=1795512772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jeNcj5n+cSF7U/qCfHEbt61YOghj/VxitxKsGWFc0Yo=;
 b=N0Mn1PzLGpiHHxHhUNzqQ19i2ZcrQRyxINd/JcrEBfUrIHSqtawklNyd
 62156o+RTpp6zPrTFchHORqhuAEM9++0R4gyPDq0saBMk104tVdaqUPe3
 mOEx+KZ/HvJF1AZpo5rIq/0iUQe18eJl/HLmWR8dslsCRCWt3THsn/sIJ
 0Ze1yCRyYWcqRvNKUexEyJfaiJOslmwmcmTVh8LO9ZNEOK9pviamic4de
 IuzwZM4F/DKPZP8/+sm4RhSMDYEdAz6gqZFu8ZzT6+GuIZZaMUr9qlZW6
 W9ALv68oXsNwDUv+0wjW2gq77OYtN3+n9XyjzFMgxAxLCOSgU4GWfFiv1 A==;
X-CSE-ConnectionGUID: yd6y3AEdSNK0/K0qLgSDlQ==
X-CSE-MsgGUID: f4wg2XHsRou2LJPz8krMOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65864776"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="65864776"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:51 -0800
X-CSE-ConnectionGUID: 9I54kg5gTvCVqE0hgGVHWg==
X-CSE-MsgGUID: aQoRuvbZQuuf8XLSxKUfoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="223251993"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 01:32:50 -0800
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 2/2] net/i40e: updated latest recommended matching list
Date: Mon, 24 Nov 2025 08:50:10 +0000
Message-Id: <20251124085010.707091-3-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124085010.707091-1-hailinx.xu@intel.com>
References: <20251124085010.707091-1-hailinx.xu@intel.com>
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

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/i40e.rst | 72 +++-------------------------------------
 1 file changed, 4 insertions(+), 68 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 6f9dab73e2..165798fb94 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -104,6 +104,8 @@ For X710/XL710/XXV710,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.11     |         2.28.13       |       9.55       |
+   +--------------+-----------------------+------------------+
    |    25.07     |         2.28.7        |       9.54       |
    +--------------+-----------------------+------------------+
    |    25.03     |         2.27.8        |       9.53       |
@@ -128,50 +130,6 @@ For X710/XL710/XXV710,
    +--------------+-----------------------+------------------+
    |    21.11     |         2.17.4        |       8.30       |
    +--------------+-----------------------+------------------+
-   |    21.08     |         2.15.9        |       8.30       |
-   +--------------+-----------------------+------------------+
-   |    21.05     |         2.15.9        |       8.30       |
-   +--------------+-----------------------+------------------+
-   |    21.02     |         2.14.13       |       8.00       |
-   +--------------+-----------------------+------------------+
-   |    20.11     |         2.14.13       |       8.00       |
-   +--------------+-----------------------+------------------+
-   |    20.08     |         2.12.6        |       7.30       |
-   +--------------+-----------------------+------------------+
-   |    20.05     |         2.11.27       |       7.30       |
-   +--------------+-----------------------+------------------+
-   |    20.02     |         2.10.19       |       7.20       |
-   +--------------+-----------------------+------------------+
-   |    19.11     |         2.9.21        |       7.00       |
-   +--------------+-----------------------+------------------+
-   |    19.08     |         2.8.43        |       7.00       |
-   +--------------+-----------------------+------------------+
-   |    19.05     |         2.7.29        |       6.80       |
-   +--------------+-----------------------+------------------+
-   |    19.02     |         2.7.26        |       6.80       |
-   +--------------+-----------------------+------------------+
-   |    18.11     |         2.4.6         |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    18.08     |         2.4.6         |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    18.05     |         2.4.6         |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    18.02     |         2.4.3         |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    17.11     |         2.1.26        |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    17.08     |         2.0.19        |       6.01       |
-   +--------------+-----------------------+------------------+
-   |    17.05     |         1.5.23        |       5.05       |
-   +--------------+-----------------------+------------------+
-   |    17.02     |         1.5.23        |       5.05       |
-   +--------------+-----------------------+------------------+
-   |    16.11     |         1.5.23        |       5.05       |
-   +--------------+-----------------------+------------------+
-   |    16.07     |         1.4.25        |       5.04       |
-   +--------------+-----------------------+------------------+
-   |    16.04     |         1.4.25        |       5.02       |
-   +--------------+-----------------------+------------------+
 
 
 For X722,
@@ -179,6 +137,8 @@ For X722,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.11     |         2.28.13       |       6.51       |
+   +--------------+-----------------------+------------------+
    |    25.07     |         2.28.7        |       6.50       |
    +--------------+-----------------------+------------------+
    |    25.03     |         2.27.8        |       6.50       |
@@ -203,30 +163,6 @@ For X722,
    +--------------+-----------------------+------------------+
    |    21.11     |         2.17.4        |       5.30       |
    +--------------+-----------------------+------------------+
-   |    21.08     |         2.15.9        |       5.30       |
-   +--------------+-----------------------+------------------+
-   |    21.05     |         2.15.9        |       5.30       |
-   +--------------+-----------------------+------------------+
-   |    21.02     |         2.14.13       |       5.00       |
-   +--------------+-----------------------+------------------+
-   |    20.11     |         2.13.10       |       5.00       |
-   +--------------+-----------------------+------------------+
-   |    20.08     |         2.12.6        |       4.11       |
-   +--------------+-----------------------+------------------+
-   |    20.05     |         2.11.27       |       4.11       |
-   +--------------+-----------------------+------------------+
-   |    20.02     |         2.10.19       |       4.11       |
-   +--------------+-----------------------+------------------+
-   |    19.11     |         2.9.21        |       4.10       |
-   +--------------+-----------------------+------------------+
-   |    19.08     |         2.9.21        |       4.10       |
-   +--------------+-----------------------+------------------+
-   |    19.05     |         2.7.29        |       3.33       |
-   +--------------+-----------------------+------------------+
-   |    19.02     |         2.7.26        |       3.33       |
-   +--------------+-----------------------+------------------+
-   |    18.11     |         2.4.6         |       3.33       |
-   +--------------+-----------------------+------------------+
 
 
 Configuration
-- 
2.34.1

