Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B653AC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 14:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D27B40695;
	Fri, 31 Jan 2025 15:49:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4DBC6402EE
 for <dev@dpdk.org>; Fri, 31 Jan 2025 15:49:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738334966; x=1769870966;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zlKPhY8lBkpipMQ+/mLO/q32dLG2+hw64PFJigOt66o=;
 b=YTcChtri8mQ7tEGn3p9sb03MQLjNqaCJ67rWgBZgUJHAo+wzbGXqrTmV
 V7f6ffwv2c9CMI6duTHjuD6uF7Vw4ABPiRqZhZmSn9t2BdoL1j5MTkfwC
 GWBLWolCOqMrM5SN9ZlPXnh5P0Ekleev7Y2kYFbs+Jqk4quL9KqgHUgyT
 WieU28fpiVqG+hsmC/p54qLW7nmp1v0ilnBFmvINRhkzLMukCO1JoTcXb
 QZfAIBLVhOLUyX3xfiUUlbTZMbjIOkZbTus1yZAV+AhzNSJYSRJcDVOtq
 OW1oVaduqtm498pRsiWB1GhOqqcH9wc0xu4PEW2UISgokQY7f9O4yBosy Q==;
X-CSE-ConnectionGUID: fFFXCD61TbOOWT7YgCXZSg==
X-CSE-MsgGUID: RGS+tjOQQDCD3hdNt0iB7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="42652434"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="42652434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 06:49:25 -0800
X-CSE-ConnectionGUID: dF/HBg+8Q2uKrzFi20RhmA==
X-CSE-MsgGUID: cW61miV9Q6eC7RbyZSdddQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="109424194"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by orviesa009.jf.intel.com with ESMTP; 31 Jan 2025 06:49:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/dmadevs: clarify naming constraints for idxd devices
Date: Fri, 31 Jan 2025 14:49:15 +0000
Message-ID: <20250131144915.2129736-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

The requirement to have DPDK in the DSA wq name is given in the idxd
chapter section 5.3.3 [1]. However, that information should also be
given in section 5.3.1 [2] where we list out the fields to be set and
what values they should have.

[1] https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-probing-and-initialization
[2] https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#intelreg-dsa-devices-using-idxd-kernel-driver

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/dmadevs/idxd.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/dmadevs/idxd.rst b/doc/guides/dmadevs/idxd.rst
index cb8f1fe729..d1ac6b770a 100644
--- a/doc/guides/dmadevs/idxd.rst
+++ b/doc/guides/dmadevs/idxd.rst
@@ -57,6 +57,8 @@ The internal engines, which do the copies or other operations,
 and the work-queues, which are used by applications to assign work to the device,
 need to be assigned to groups, and the various other configuration options,
 such as priority or queue depth, need to be set for each queue.
+Furthermore, to mark a work-queue for use by DPDK, so it will be picked up in device scans,
+the queue must be assigned a name starting with either ``dpdk_`` or the DPDK application's ``file-prefix`` parameter (default ``rte_``).
 
 To assign an engine to a group::
 
@@ -71,6 +73,8 @@ Some configuration options include:
 * wq-size: the size of the WQ. Sum of all WQ sizes must be less that the total-size defined by the device.
 * type: WQ type (kernel/mdev/user). Determines how the device is presented.
 * name: identifier given to the WQ.
+  For DPDK to automatically find and use the queue as a DMA device,
+  the queue must be assigned a name starting with either ``dpdk_`` or the DPDK application's ``file-prefix`` parameter (default ``rte_``).
 
 Example configuration for a work queue::
 
-- 
2.43.0

