Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A7C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109CA402E9;
	Mon, 31 Aug 2026 12:26:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 064414025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171989; x=1819707989;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=llxCLpRpjlp8xOzk70Wzf6CHddSB4iHR9gFQM3PtVWQ=;
 b=PTH6RBqC4rGFNHupvJSmEw19R/zEo2eUAG7rGmgZ2/wqyaHQBNWLfH1u
 Cqc0AevP2gSfIm8rW3ZA5Ya8fO0KRWAuVuuRGVyZUSH4tfe8FLavZDBtY
 /twOb8iPIW7VFoVw7ihbc0NsCfTbhLmrmQRkL2z26IKTIRNxEQqp5QCM6
 tps2MLwXqFHw7a2uYG8e3xnIgc8bIyw2v/PgeYIYXaJbKki5RXHNK0wRI
 RCNo/3S/E7cLU3OUgNB0E00GP9Cn5qLDAX3ovGMCnJ3x1h0jNmoYIAMuo
 K5LRc79r9lmHESCRLJ1T0rxknYtrZ9uBaejJA2cfRPSLbysdpPwmr2aW+ w==;
X-CSE-ConnectionGUID: abXXPudPSrGUniKtVh5uZA==
X-CSE-MsgGUID: cWui+UMaRJWQfgTGlxHlTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452414"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452414"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:28 -0700
X-CSE-ConnectionGUID: l8Z4LqJ9QRGVq+dwS6tPoA==
X-CSE-MsgGUID: IE8VHSUhRcKJTl/m1izouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424134"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/7] VLAN and QinQ fixes for iavf
Date: Mon, 31 Aug 2026 11:26:13 +0100
Message-ID: <20260831102621.495759-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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
 drivers/net/intel/iavf/iavf_ethdev.c          | 12 ++--
 drivers/net/intel/iavf/iavf_rxtx.c            | 56 +++++++++----------
 drivers/net/intel/iavf/iavf_rxtx.h            |  4 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 12 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 18 ------
 drivers/net/intel/ice/ice_rxtx.c              |  6 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  3 +-
 11 files changed, 74 insertions(+), 85 deletions(-)

--
2.53.0

