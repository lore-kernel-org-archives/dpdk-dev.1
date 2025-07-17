Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2317C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 06:54:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5F5D402DE;
	Thu, 17 Jul 2025 08:54:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id CF488402D0
 for <dev@dpdk.org>; Thu, 17 Jul 2025 08:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752735292; x=1784271292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FXYXBGWsRrvzBZ7VEK8hTfJzclD7kmPXJMRs2RvRJ74=;
 b=crfoa+wTyyRUMHb+eqhF6wwMRAbem1WBg5DiR1yHcN4oLZ+fRclwthcY
 mHI+v42QvCTfjS38pZXp9EWh9ovPcH/jU7ztMFgAkYhkVdO75kgVooD5k
 J/zjBxfWCa+R+8KxxJjVkqCNX+kyOIchmOpXc5Zphe3f1RzoPWn6w3Ka2
 drV+ZXx4BmIu6Qh9aAZydU+kkZfgyEBm5Lb3RneiEzgwMunEUM3l/AbXF
 Zfo//6F/MCUAcYkTUzr+R5i3lIyH504mUEe4g45/Azz6VjmajxL8hUYqq
 HE4PV7Ybke5Y1vB+Y2zFJgqZXfEUa6ScporDVNCAGgVyB0g9eij+bJVNZ g==;
X-CSE-ConnectionGUID: GcoZEA9IQCm3/Rd8G/gQhg==
X-CSE-MsgGUID: ljhOz2I2QGWQTGnszCBgZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54970987"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54970987"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:51 -0700
X-CSE-ConnectionGUID: RKMW5e0YQa61POLX/XDSYQ==
X-CSE-MsgGUID: Gi1doY1aRkCQHKCxUE53Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="194848780"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:49 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinx <hailinx.xu@intel.com>
Subject: [PATCH v1] net/i40e: updated latest recommended matching list
Date: Thu, 17 Jul 2025 14:16:03 +0800
Message-Id: <20250717061604.3288049-2-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717061604.3288049-1-hailinx.xu@intel.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
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
index 234757cd7a..e7db6f2416 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -104,6 +104,8 @@ For X710/XL710/XXV710,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.07     |         2.28.7        |       9.54       |
+   +--------------+-----------------------+------------------+
    |    25.03     |         2.27.8        |       9.53       |
    +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       9.52       |
@@ -177,6 +179,8 @@ For X722,
    +--------------+-----------------------+------------------+
    | DPDK version | Kernel driver version | Firmware version |
    +==============+=======================+==================+
+   |    25.07     |         2.28.7        |       6.50       |
+   +--------------+-----------------------+------------------+
    |    25.03     |         2.27.8        |       6.50       |
    +--------------+-----------------------+------------------+
    |    24.11     |         2.26.8        |       6.50       |
-- 
2.25.1

