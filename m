Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48CCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 05:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32C9340262;
	Mon, 27 Oct 2025 06:47:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8FCD44003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 06:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544052; x=1793080052;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lmM4r00zTjIEoIzlxC1atXCG/+x1Fg5hp/SA03lVOPw=;
 b=lUdFRrphfEOBzQ/445+0Yol/hKLVOMjxG1RYpv+Pop4A7qv9khdkE2ku
 zUYNZQ7AWC171JBzqbNL0HcRUEKi/3Mcqlp3wxeJFuMWgHpdOpqmpdIJ8
 OwdO9yYKFKSK8ea2Z12sM+eHX0rR8qPlMysbcBB3rmwiU/rZuClsTAiDF
 3XFrYflZYk1TC201rw8xj5gfTZ5ww5DLr/iWLGF1UAQaM3hcU+H46lHv3
 78TH9naIFbfAYEEzzVtmEyi/kFFVU/LQmX0PeiR+1fXJc23m+C3LyWywk
 2NlxMrYMRfNcWZ22jAfdlihSw4oXmK8EPpMMKEfBlEavcbznyXaXprcJ9 w==;
X-CSE-ConnectionGUID: ndj/uL/XTB25/A0ChTsVmg==
X-CSE-MsgGUID: rJ0ssuVWSkCIwUDZz49Z2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66232927"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66232927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:47:30 -0700
X-CSE-ConnectionGUID: GdoHsw1KSrGFmXI5esX1Vg==
X-CSE-MsgGUID: QLXQknf8Rm6vRqQPIwI26g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="189265775"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 26 Oct 2025 22:47:28 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 0/3] Update TxPP feature
Date: Mon, 27 Oct 2025 14:27:58 -0400
Message-ID: <20251027182801.191295-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
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

Fix bugs in TxPP implementation and update the documentation
for the same.

Soumyadeep Hore (3):
  net/ice: restrict testpmd to scalar path for TxPP
  net/ice: fix PTP clock corruption with TxPP
  doc: update TxPP documentation

 doc/guides/nics/ice.rst          | 4 ++++
 drivers/net/intel/ice/ice_rxtx.c | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.47.1

