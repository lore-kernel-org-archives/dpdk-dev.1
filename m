Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16BFC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25BA840EF1;
	Thu,  3 Sep 2026 16:38:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id DDE48402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788446313; x=1819982313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wqlh1ElvVACS1qLb0yr+Q53JrUFxAOtW+XzzjbB15I0=;
 b=nSyKQ1OGfx3ioADH91GPzAFjvL0Q2/TBzCE8dsaIcgYXJ2z1GLaQ7AdD
 XzzOFtmBs8xvzmETsE3fdxyCY3wkoA7RwB4Zjlf6C7r0zr2YiJx9lyEef
 IA+yBRwzuMQ2C4RSjPF3CJtwf3jRmeGMRCLT3KUvOfcp9QrLe02rT+LgZ
 BdDgE+DpwJyhELzgHch0Gk7FNmSqtgmH/j5uwElX3zdeMNh7ajyqhPa7N
 HRl1LNB9E+Ma8uOP6WMvm9+OIjdV9HqI6K7b8DzI8c93zM80yEuwgENYm
 dSSC4eYA9RTbVa8KIdWmt6VmWj8Wd8QZms0zCUBdEVCrf5ORFexzKQDxC A==;
X-CSE-ConnectionGUID: PtnzzHaOR92Sr1UiI/0RaQ==
X-CSE-MsgGUID: n0UQgUG3So6CSIqjVbfVMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87869755"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87869755"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:38:32 -0700
X-CSE-ConnectionGUID: 80BV0gPYS2K/vHwG1J2d0w==
X-CSE-MsgGUID: NE4/J3qsTmGwu0TstQsIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273894900"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 07:38:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/7] VLAN and QinQ fixes for iavf
Date: Thu,  3 Sep 2026 15:37:22 +0100
Message-ID: <20260903143827.327131-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

This patchset contains a number of small fixes for iavf VLAN
tag handling. Most issues were discovered by AI code review
rather than being found in testing.

v2: 
* add error checking to patch 3

Bruce Richardson (7):
  net/iavf: disable broken QinQ strip on Rx
  net/iavf: fix VLAN tag placement logic
  net/iavf: fix VLAN outer TPID setting on Tx
  net/intel: fix unclear enum names
  net/intel: fix VLAN and QinQ tag position logic
  net/iavf: fix missing outer QinQ tag for tunnelled packets
  net/iavf: remove undocumented conditional macros

 drivers/net/intel/common/tx.h                 | 14 ++---
 drivers/net/intel/common/tx_scalar.h          | 16 ++++--
 drivers/net/intel/i40e/i40e_rxtx.c            |  6 +-
 drivers/net/intel/iavf/iavf_ethdev.c          | 15 +++--
 drivers/net/intel/iavf/iavf_rxtx.c            | 56 +++++++++----------
 drivers/net/intel/iavf/iavf_rxtx.h            |  4 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 12 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 18 ------
 drivers/net/intel/ice/ice_rxtx.c              |  6 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  3 +-
 11 files changed, 77 insertions(+), 85 deletions(-)

-- 
2.53.0

