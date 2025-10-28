Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E0CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 05:30:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA672402C9;
	Tue, 28 Oct 2025 06:29:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 225C14042E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761629393; x=1793165393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kc/nuWArAQ0uV8X/kuu+No3Y/nswmQQyNeplV2/rDTk=;
 b=MRjnb8edJGkP6CrTm/JO+5BpPG7nWIMEnkfVrsdwXXl5HkjjHqXLn1mc
 3lSavHpjGfw7s7xKTazi4dAe43Qiplq3skAa936qbabOHs1p14n1kT7IL
 k7kMVjt9RFLcLico5AIXjkAw5t9UiraOlLjFWxy06bpbt7EpWr0e3TzVD
 hOrKJSumdO01rIsSEWy4Bx6tCoziS1e1eEzlNRjEPZtTyYNbt6JTsHyrH
 LZQr28SbsxmDaj80EquAMsOeyb79TtQP8MwzeK8Im1oOTSGwP7DK4EdVj
 +gaEOjt7FoJLdxP3Xn+a+Fw0ziJY/LELhUM+kCCHgeDyqPd6xoYXIXBZV A==;
X-CSE-ConnectionGUID: 4R1CuX30SqmoJuNmnbpclA==
X-CSE-MsgGUID: Gswmj4UMQuqD7+/x0wLO8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86346435"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="86346435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 22:29:52 -0700
X-CSE-ConnectionGUID: lpBI7YI4Qjm0jhnHNRDwhg==
X-CSE-MsgGUID: xcRgyut1RSKNUdgKJ09ACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="215904156"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 27 Oct 2025 22:29:52 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v9 3/3] doc: note on unsupported completion queue sharing
Date: Tue, 28 Oct 2025 10:59:43 +0530
Message-Id: <20251028052943.121453-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028052943.121453-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028052943.121453-1-shaiq.wani@intel.com>
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

Added a note in the IDPF Poll Mode Driver documentation to clarify
that sharing a completion queue among multiple TX queues serviced
by different CPU cores is not supported in split queue mode.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..47e38fcb13 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -79,6 +79,11 @@ Runtime Configuration
   Then the PMD will configure Tx queue with single queue mode.
   Otherwise, split queue mode is chosen by default.
 
+.. note::
+
+  In split queue mode, sharing a completion queue among multiple TX queues that are
+  serviced by different CPU cores is not supported.
+
 
 Driver compilation and testing
 ------------------------------
-- 
2.34.1

