Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B6C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 16:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6DC6402CC;
	Fri, 21 Feb 2025 17:55:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A7C78402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 17:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740156904; x=1771692904;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bsVp9iesAXQs+1HmPGZnzuv1QvXqcuHveHcgMUve0KU=;
 b=a0APAnIB+5NVtgzc0m1nlFP/+an7D0YeKkHFIcC5MjujqlnXzpY4YpFf
 jZgHsxFihSAwwCUjTZwpXV+x3VeOAASBZ0saQBiImUt7NEOVJyCUk4Faj
 6rIlidxvN4GaEswowTZ+vAV6pQ3GQ+j30XDmfz10E8IG5a143lq/ATh83
 OhO4wKPDo5PPI0HoVnNyeOzDtXyqnH7bIER1C39+1VSXHPYUo1pO/0nLy
 YfTKIpOUwD4lSDM2xP1jWDP/2Vhcyq9vSLJZFkfC7fImX6aW6YrInOhhY
 RkoXA/RSK+a8yZl62NgXvpv/PkeA9HQPEV76VXB3WOWR3lBcLz9Gv70LW Q==;
X-CSE-ConnectionGUID: UVvPDzxPRp2OaHKsdNIcxg==
X-CSE-MsgGUID: snHqXE3ySHyL6pPVtsX9eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44764944"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="44764944"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 08:55:03 -0800
X-CSE-ConnectionGUID: ryMDhhHNQp+12/NNCVJ72A==
X-CSE-MsgGUID: 6SFQwJuMQp2ruz5/7CwHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="146258641"
Received: from silpixa00401316.ir.intel.com ([10.243.23.87])
 by orviesa002.jf.intel.com with ESMTP; 21 Feb 2025 08:55:02 -0800
From: Chris MacNamara <chris.macnamara@intel.com>
To: dev@dpdk.org
Cc: Chris MacNamara <chris.macnamara@intel.com>
Subject: [PATCH v1] doc/guides: update monitor PMD mode description
Date: Fri, 21 Feb 2025 16:54:40 +0000
Message-ID: <20250221165440.832528-1-chris.macnamara@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

A recent CPU change requires an extra enabling step for
the umonitor instruction on Intel CPUs.
This is now detailed in the l3 fwd power manager doc.

Signed-off-by: Chris MacNamara <chris.macnamara@intel.com>
---
 .mailmap                                          | 1 +
 doc/guides/sample_app_ug/l3_forward_power_man.rst | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..c4bc38752f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -263,6 +263,7 @@ Christopher Reder <christopher.reder@broadcom.com>
 Christoph Gysin <christoph.gysin@gmail.com>
 Christos Ricudis <ricudis@niometrics.com>
 Chris Wright <chrisw@redhat.com>
+Chris MacNamara <chris.macnamara@intel.com>
 Chuanshe Zhang <zhangchuanshe@icloudshield.com>
 Chuanyu Xue <chuanyu.xue@uconn.edu>
 Chuhong Yao <ych@panath.cn>
diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index 3271bc2154..d0af28e0ec 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -293,6 +293,11 @@ and has three available power management schemes:
 ``monitor``
   This will use ``rte_power_monitor()`` function to enter
   a power-optimized state (subject to platform support).
+  On recent Gen 4 Xeon Scalable Processors the umonitor instruction
+  is disabled by default.
+  An additional step is required to enable the umonitor instruction.
+  Writing 0 to bit 6 of register 0x123 will enable umonitor.
+  `More details are available via Monitor and Umonitor Performance Guidance <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/monitor-umonitor-performance-guidance.html>`_
 
 ``pause``
   This will use ``rte_power_pause()`` or ``rte_pause()``
-- 
2.43.0

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

