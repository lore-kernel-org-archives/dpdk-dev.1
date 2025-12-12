Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC4D4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45F3340E64;
	Fri, 12 Dec 2025 12:06:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C50B240E30;
 Fri, 12 Dec 2025 12:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537605; x=1797073605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xel/7bfJGrBx4R2oY9YgmQkQKU8rAofjBK72fALrMfw=;
 b=aAqo5XN9+681uEasAdGXD0Z8IC0pIDVq0t2rlRfKqHbqYXqq0MKhNrfC
 V9XWVKrqs7MAtaX6nd9IU6KSX8spP966lrQKmYNaqKHF9bqZ24IUhJfEA
 O/Fjf/wZ4aP1s7dEsPb1ZEvzzdH1mogKQhXl8d17cMacbOW6mGY4hEQ/K
 TmAS+/igXWL5+OUBe6WPffed7dsqOSslxLZlRYa4dj5bUBtwWKh6tu19e
 6afIIVZ7KaUOfViognwca9a1M3qJ0cIp+wtjEuJlq5igjWCiAIEkG1dEI
 gdcvbtQL+ExY7iwaZttVXP799GSrOY7GKX2xXPRJiOlKjlZxdrNvB08KE Q==;
X-CSE-ConnectionGUID: mgoWygjdQMyP/xpJa2O7Cg==
X-CSE-MsgGUID: XXZl977FQouwpK6LfihUnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472056"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472056"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:44 -0800
X-CSE-ConnectionGUID: rBqSEoZeSRmHrqhohHhAjA==
X-CSE-MsgGUID: Nbt+4hZ3Q6a5WfiG2NIKsA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:43 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 08/10] docs: fix TSO feature status in iavf driver
 documentation
Date: Fri, 12 Dec 2025 11:06:26 +0000
Message-ID: <20251212110628.1634703-9-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change the status to
partially supported.

Fixes: 319c421f3890 ("net/avf: enable SSE Rx Tx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 7695e3ff7c..6c9e97594f 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -17,7 +17,7 @@ Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

