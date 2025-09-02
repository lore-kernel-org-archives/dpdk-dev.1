Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A7CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:49:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ED5E40615;
	Tue,  2 Sep 2025 12:49:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DFEA9402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756810165; x=1788346165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DJnMoQ2v+4LxON2EI02lZu+FE7uNtATezoZtSIqA1aY=;
 b=UhAyBjkNv2yZ6raA4s27bnwJmKxpdCp50c7VqGc+UtPRf8t5SnI8ZDYk
 Kzhtir5fyD8Ce4Iv9rtWqJ+TNpy7zLfp7A2Tr+tOOzKIg2MEpdZQCBPdw
 aGESJxs7vNrLu+BMY/SbX/9bzYCAr7XvTWdgXDAvfDWdF4uWz/lxg6h9o
 HErsaopllujNNsAe508JXipDXJ3uMi7F7eApElM/XzAKRpJNu0bINX3UN
 WXjbVX7T+OcYayn9aTaJ5Eg5jarj0dpzu4pW4OV3KThYflwZijqTNoWRH
 p5le0FRyOG5e1gH6Jqf84oRSA9ioxyF9dxILu+SYdvOBL7SnkG55TDCPn A==;
X-CSE-ConnectionGUID: V++ciR/4RCOYPD7FvptB1Q==
X-CSE-MsgGUID: fWfd+Y1qTR2PIMZCARA8Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59014547"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59014547"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:49:23 -0700
X-CSE-ConnectionGUID: b6UyMhzDQMSmvAZa4IER4A==
X-CSE-MsgGUID: YreDzP26Qta7BYVmqTveNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="175609381"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 03:49:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/4] Fixes for net/intel Rx Path Selection
Date: Tue,  2 Sep 2025 10:48:55 +0000
Message-Id: <20250902104859.2100141-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901095953.1858938-1-ciara.loftus@intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
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

This series contains fixes for the code surrounding Rx path selection
in the i40e and iavf drivers. It is mostly the removal of redundant
and duplicate code. The target is the next-net-intel tree.

Ciara Loftus (4):
  net/i40e: fix supported offloads for Rx vector path
  net/i40e: fix vector Rx queue set up logic
  net/i40e: remove redundant vector Rx queue setup code
  net/iavf: remove duplicate in scalar offload list

 drivers/net/intel/i40e/i40e_rxtx.c            | 40 ++-----------------
 drivers/net/intel/i40e/i40e_rxtx.h            | 11 ++++-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |  6 ---
 drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
 4 files changed, 14 insertions(+), 44 deletions(-)

-- 
2.34.1

