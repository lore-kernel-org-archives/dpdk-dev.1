Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8831D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40C3140E18;
	Tue,  9 Dec 2025 12:27:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5CDF640A87;
 Tue,  9 Dec 2025 12:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279640; x=1796815640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A/9EpZqYdG9YVyNrZJbQwavn866ohnB3CcF8s5V87Co=;
 b=am/6fUGU7aKJbXxAeJwJR2hwacxt+hRvbBDkBLkZgSYBWMGSV/KW+4aE
 Z8UK9twm6aa5RNiX3/tx8Bh5DPv+wqNr6EGXckVUXrDDMp6KrIS+eOBpe
 7wTN1fKfunxFDc7TKaGHzJcBy5372gRDIwlx7PE7DluITar6XITC5V/nl
 DyOpKTyTME64ltFtmj6ttjZIKgsdsscvjfW0NiLc4I9S4zCGGgdMVAzvi
 6Hvc/zfkA2dxE7GQ81uWbhB2gBc6f0FpGj8oXdz+f1RY8oQVAMg2H77xC
 4BV4shoCFGVWbHeewyXzJIwrebuFO63z3iLcvdFC7bmuOg8+qzBf4ZXEG g==;
X-CSE-ConnectionGUID: StpcOcxcRH+ZLuH7YoPrUg==
X-CSE-MsgGUID: 7FFnDRD5Q5+aYzmLSqzGwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117053"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:19 -0800
X-CSE-ConnectionGUID: o9+iQLbUSq6cuDREhcQkaQ==
X-CSE-MsgGUID: HOe0ZGh5SjSxj+DUXwi2VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270247"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:18 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 13/13] docs: fix TSO feature status in i40e driver
 documentation
Date: Tue,  9 Dec 2025 11:26:52 +0000
Message-ID: <20251209112652.963981-14-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

Fixes: 9ed94e5bb04e ("i40e: add vector Rx")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/i40e.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/i40e.ini b/doc/guides/nics/features/i40e.ini
index 4610444ace..fb00b69830 100644
--- a/doc/guides/nics/features/i40e.ini
+++ b/doc/guides/nics/features/i40e.ini
@@ -16,7 +16,7 @@ Runtime Tx queue setup = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
-- 
2.43.0

