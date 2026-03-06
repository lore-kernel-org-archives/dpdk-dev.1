Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD7F01821
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 983AA402E3;
	Fri,  6 Mar 2026 11:58:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0B20940278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794710; x=1804330710;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EvWuJtGPHTWc+H5bVwx3dpOMEH9/nuQpH5VQhLMhs+0=;
 b=bAsTqD19sg/T6LdK0+YXiuhz6FA4QJourkGSViqGMgMQseQEDMQdSCVD
 hCT9PZmQw8f3GS30Gq4r4Yr9cwiAhxPt8JE4PcUcuibtLMQnDNMSU1GzG
 2iHY+0+Uj1Ww1/Zm0VXqipHk/yNT4Q7B8LnjVHSOgjt7Ca04U0WBylwtR
 TTHa4VdNbxNWNAIWoedG5mbtaMZqZMXX0MvyYj3d3rTuR8Xk0dqFYvuSR
 VIBugDTV9fmbvERsYZgHr4Y7Oz94ECnaaiNp/XvhNyd+AB1H9vVR84Z/4
 c8ny28Rm7O079Nld4Dz0UO0iC02rD9hpS+EHnAkQ7yhvknfIE6QOyRDi2 Q==;
X-CSE-ConnectionGUID: f317CjOHRuu0FXLFQp9EBg==
X-CSE-MsgGUID: LRitENtnRq6qdrOVqbqn9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984541"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984541"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:28 -0800
X-CSE-ConnectionGUID: k0xL6tYETjS/XjyWo2xPCA==
X-CSE-MsgGUID: ZL/YeZ8rQae+jju/1kVhIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678378"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 0/8] Reduce reliance on global response buffer in IAVF
Date: Fri,  6 Mar 2026 10:58:16 +0000
Message-ID: <cover.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
References: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
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

In many places where we are calling down into virtchnl, we are using a
globally allocated adminq response buffer. This is unnecessary, so replace
with adminq buffers allocated on stack. However, because IAVF virtchnl
message queue works asynchronously in most cases, we can't remove the
global buffer entirely, and we need to do some cleanup and refactoring to
be able to reduce our usage of these buffers. This patchset does that.

v1 -> v2:
- Stats query was passing in a pointer-to-pointer and storing pointer to
  global adminq response buffer as output parameter, so changing that to a
  local buffer resulted in storing a pointer to a buffer that was stack
  allocated (i.e. introduced a use-after-free).

v2 -> v3:
- Reworked the virtchnl message handling to not rely on implicit behavior
- Split up into 8 patches for easy review

Anatoly Burakov (8):
  net/iavf: avoid passing around pointers
  net/iavf: add a variable for hena
  net/iavf: add virtchnl interrupt enable flag
  net/iavf: rework "async" virtchnl requests
  net/iavf: refactor sending virtchnl messages
  net/iavf: respect output buffer in virtchnl
  net/iavf: do not use global virtchnl buffer
  net/iavf: embed virtchnl response buffer

 drivers/net/intel/iavf/iavf.h        |  58 +---
 drivers/net/intel/iavf/iavf_ethdev.c |  50 ++-
 drivers/net/intel/iavf/iavf_vchnl.c  | 483 ++++++++++++++++-----------
 3 files changed, 304 insertions(+), 287 deletions(-)

-- 
2.47.3

