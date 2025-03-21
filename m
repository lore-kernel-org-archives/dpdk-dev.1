Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22316C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 01:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76B9340665;
	Fri, 21 Mar 2025 02:16:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2E46A40268
 for <dev@dpdk.org>; Fri, 21 Mar 2025 02:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742519802; x=1774055802;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GmvFuYgiHUUbo7a0HWnu/ne+BT+Oyu53eY9c4Axk7jw=;
 b=F0hjrJKylOogQFo3qLA/vM7AzxHI2ykB01A2kSTMPjnKZ+bPaCGl6/qY
 OlzAxWCxgBCgnwe5Jfkqij0li5iXs00JLuYpw1EvC1A2i7wyvYV+/4gsd
 HQPPHJBC+O57jTe+Ow/0Wh7a9LqTQ6YfQFYwkLrx9k7TXAmpFfsgwZzse
 iOc0BRuGSz7p1AMzKn+JgAXFCwpE9DcCFAWCm4xnhj7tUVzedpwOE07sB
 kWGTtcANldFn4Mupt8W7s1mRZbRWngZ6kXUwkiJLb4BLv7QoZBTRM8Wae
 ttlV0RFgwb+EBc1BxikXloh1SpgSHgezhTtG1AqgU9Ff0Z2MijfgllbgN Q==;
X-CSE-ConnectionGUID: ko7mNUK9TQSmyrqd+xO9ig==
X-CSE-MsgGUID: qqGmWl4oQ4yDsEy/L9AUxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="55159786"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="55159786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 18:16:40 -0700
X-CSE-ConnectionGUID: VvZIZ+UlQgKsDjOvvRyMnA==
X-CSE-MsgGUID: 7UmAYo/fTpi8BBcX3A2Xdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="124211010"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 18:16:38 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinx <hailinx.xu@intel.com>
Subject: [PATCH v1] net/i40e: updated latest recommended matching list
Date: Fri, 21 Mar 2025 08:36:51 +0800
Message-Id: <20250321003651.988509-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: hailinx <hailinx.xu@intel.com>
---
 doc/guides/nics/i40e.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 35585efc44..ba592d23fe 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -104,6 +104,8 @@ For X710/XL710/XXV710,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.03     |         2.27.8        |       9.53       |
+   +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       9.52       |
    +--------------+-----------------------+------------------+
    |    24.07     |         2.25.9        |       9.50       |
@@ -175,6 +177,8 @@ For X722,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.03     |         2.27.8        |       6.50       |
+   +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       6.50       |
    +--------------+-----------------------+------------------+
    |    24.07     |         2.25.9        |       6.50       |
-- 
2.25.1

