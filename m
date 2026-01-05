Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FDC2A072
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 06:24:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79B174028B;
	Mon,  5 Jan 2026 07:24:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 194D140273
 for <dev@dpdk.org>; Mon,  5 Jan 2026 07:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767594247; x=1799130247;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=odeDkF1XCKx1gItDV77q/IiQVzietd/5rDeiIExpum8=;
 b=gDRzatCHlnJznztJTw4xhk0qeXz7VrqgprLHjR1jt4pzonjW7TW4nI9b
 iNb97X5f4wjy4C4qKcI2vwafm1o+CL9zVeriVNoutk8RulYLM77AUANxr
 A0yj0OgzsOF+mHcg8L19iteMtJmpDNpqHeyBUmNCKTwzDqky+FdbPyVLq
 d/r87EKK32oyNAfkOZE1tJ0UQESJSRVf+B4ZeZU2BdB+VyFw2Ce9c8Ga/
 2SOW7EY2i166/4w88Vu12FXfoTGlkvlfYdF1Fr86USzXxPPhQdLHuXUtS
 s75XEgtbNeQiKWZhzvMs2iZhdI6270zErpsmaJxOId/cEiZTw/GM0Mn04 A==;
X-CSE-ConnectionGUID: O5UipNp8RiSfDjiXjRLQUg==
X-CSE-MsgGUID: snSDLlckQUea53bUeDMjew==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="79592945"
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; d="scan'208";a="79592945"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2026 22:24:05 -0800
X-CSE-ConnectionGUID: PHHULlTfRNCztsNSExKQYQ==
X-CSE-MsgGUID: PDZmV0HVTby9QsvfmaKQQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; d="scan'208";a="201552718"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa010.jf.intel.com with ESMTP; 04 Jan 2026 22:24:04 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v11 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Mon,  5 Jan 2026 11:52:54 +0530
Message-Id: <20260105062257.102370-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

v11:
*Fixed indentation issues.

v10:
*Changed desc reading style in Rx path.

v9:
*Some minor fixes.

v8:
*Reworked the receive func to avoid race conditions in Rx path.
*Removed unnecessary compiler barriers.

v7:
*Removed (char) casts, ifdef block as suggested.
*Fixed indentation, line wrapping.
*Did blind write of data to avoid branching.
*changed desc building and writing  order for Tx.

v6:
*used single load/store in splitq_recv_pkts function.
*removed x86-specific intrinsics from common code.

v5:
*Fixed CI errors.
*Used defined constants instead of numbers.

v4:
*moved splitq_rearm_common to a common location.
*reduced duplication of code.
*fixed splitq_recv_pkts function.

v3:
*Fixed some indentation issues.
*Collapsed wrapper and core function into one.
*Fixed some pointer casting and naming inconsistency issues.

v2:
*Fixed CI build related issues.
*Rebased on top of idpf/cpfl rx path selection simplication patch.



Shaiq Wani (3):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx
  doc: note on unsupported completion queue sharing

 doc/guides/nics/idpf.rst                      |   5 +
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 317 +++++++++++++++++-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 7 files changed, 397 insertions(+), 58 deletions(-)

-- 
2.34.1

