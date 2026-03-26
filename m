Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3B109E52B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 01:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA17427BD;
	Thu, 26 Mar 2026 02:37:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 71913402C4
 for <dev@dpdk.org>; Thu, 26 Mar 2026 02:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774489057; x=1806025057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oOdimk7IjNETaM9Q9G+O/G8mWvo95EIEvE+YFU97VeM=;
 b=imCevorZBM5d1gl4fWdkZJ6HWTlfoinmxkqWU6YChbu3q9awZhrjvrC2
 EhKmaPvbYSg1tNhaKcx8ftKsrfU+e61BUHNmFiDKzUo5NCy3UlwQDdcXw
 PEthYpQHNxeQSbYmNUFrh5xrMntxe8QL/P3jVXUD7w3fIsZWJUhAIqmLo
 OSLlRrXOa5XId9UOS7c2yanxfFqJy1xR13Pcjrl4AqLSeg7uD4Q6lywlh
 1GxDwjTQMS/AkdLCcFKYToldMX4tYHOzF0H4V2T6gyL4lClT6z5kmpzKS
 MYZDC1R+VKFTX73aIYanQcsJqJGJD5FxE3l+IR12/JaiAo1Yesv+uNAVm g==;
X-CSE-ConnectionGUID: XMXNU6/jS8qchHWrNIXB9w==
X-CSE-MsgGUID: x6M6ii9zTE2wbUFbjXWmqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75442392"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75442392"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:37 -0700
X-CSE-ConnectionGUID: 3fnavWIBS0Cu1tZD6GfOXA==
X-CSE-MsgGUID: H/yxn0jET5qH2k2+xoz5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="255347300"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:35 -0700
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 1/3] net/ice: updated ice latest recommended matching list
Date: Thu, 26 Mar 2026 00:54:05 +0000
Message-Id: <20260326005407.623302-2-hailinx.xu@intel.com>
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

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 216c79b6f2..ea73f26b00 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -89,6 +89,8 @@ For E810,
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    26.03  |     2.4.5     |      1.3.53     |  1.3.61   |    1.3.25    |    4.91   |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 For E830,
 
@@ -99,6 +101,8 @@ For E830,
    +-----------+---------------+-----------------+-----------+--------------+-----------+
    |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.11   |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
+   |    26.03  |     2.4.5     |      1.3.53     |  1.3.61   |    1.3.25    |    1.20   |
+   +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 Dynamic Device Personalization (DDP) package loading
 ----------------------------------------------------
-- 
2.34.1

