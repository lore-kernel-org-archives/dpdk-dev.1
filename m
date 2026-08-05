Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B77C55ABF
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:57:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD323402B6;
	Wed,  5 Aug 2026 14:57:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 77D7440272
 for <dev@dpdk.org>; Wed,  5 Aug 2026 14:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785934669; x=1817470669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xo7hf7PNVdz9Mou7o3Fu2rXVm4fBOJ+U2xZVqS8I3wU=;
 b=Sgl5MUqHA09q+OvEq5sJmhYfKXvlAQSxjrCkZcyiA3/eEeJg4M/lO3wP
 Marnxo1gt4HAJ7YQrUIcf4EKbfnOUZEKe9jkc/ym4DdqDQ62IqggKs8FI
 6YNNHvJYDmkuBImPKKReQmkBxkzryOFyHfmT0qrPfQJ1q7nJcoOg5frCw
 6F90LxadP+Hf3ynqi7ZLSkesW5s5W1bQbC6DV+T92a2vkZQad9mLsVjzj
 WDa1vf6l9cxTNkr9GZxa+YdPocl1fE+EFB9+lhHFr8tI7/3QfFZ9pwSx2
 vYfl8SYq9+sH78yKdlsgkWqXG9l65NhXVAKkTIvTZaqn2MoA/hcmqwagQ w==;
X-CSE-ConnectionGUID: 7vfG8kEETJ+Rb6/LeZX0hA==
X-CSE-MsgGUID: mLwqepbATdG9s5+2OneMSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97101604"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="97101604"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 05:57:48 -0700
X-CSE-ConnectionGUID: MUWyHP5VRG27Hu0+9YECNA==
X-CSE-MsgGUID: sRP80AYjRKqqVm3/vRKKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="285170778"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 05 Aug 2026 05:57:47 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/2] iavf post-reset state restoration updates
Date: Wed,  5 Aug 2026 12:57:33 +0000
Message-ID: <20260805125735.3900483-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721130814.2950332-1-ciara.loftus@intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
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

The iavf auto_reconfig devarg was marked for deprecation in the last release.
The first patch in this series removes the devarg, restoring promiscuous and
all-multicast modes unconditionally after a VF reset. The second patch limits
this restoration to VF reset only, avoiding unnecessary work on dev_start.

v2:
* Remove deprecation notice
* Move release note update from 26.07 to 26.11

Ciara Loftus (2):
  net/iavf: remove auto reconfig devarg
  net/iavf: restore promiscuous mode only after VF reset

 doc/guides/nics/intel_vf.rst           |  5 ---
 doc/guides/rel_notes/deprecation.rst   |  7 ---
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/net/intel/iavf/iavf.h          |  1 -
 drivers/net/intel/iavf/iavf_ethdev.c   | 62 +++++++++++++++++---------
 5 files changed, 45 insertions(+), 35 deletions(-)

-- 
2.43.0

