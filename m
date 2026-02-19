Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197FE9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE4DE402CA;
	Thu, 19 Feb 2026 18:40:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 59DE3402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771522803; x=1803058803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HqSB1gOMrASsrl/dF+sHZmCdvNufLX2B4sd4ftfN7eI=;
 b=P4NOblfezON7m4XoyifqG87lqzHnabHRJLoPuj6WTb3FpElwkqD8jo3B
 5yrsyFI+eQromHbf5otaxdAJ3kI6EMSjzY6m8xhMSWId86LQEji4YZijA
 xa+HXoUsb97xc8Wx7L+MZJvWKYOpsVdk1scIDLPfqixpHx3Okq1T5j+C8
 16O7zvk8oZsOR6qvozai3lZtqSFn6C3/aPvKQhAMPR6c9ao26C/oRZVyP
 Lxc7vRT7or2px5MZtP1rl+nFKCMPu/468qA1j90zorULFifB/0Tw64Aex
 9igmAvbC/UbBIR8sIWv4ORFQ6TrwWyzi11iD4Yes28lxJWZGucKIAINg9 A==;
X-CSE-ConnectionGUID: srGHUoG8Rrq6Wh9wD6yUkA==
X-CSE-MsgGUID: YPvu8jtsS1mrRO1I1kkWZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72518100"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72518100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 09:40:02 -0800
X-CSE-ConnectionGUID: l0OtIZBaR7CgXc3e4EVhLA==
X-CSE-MsgGUID: IHdG4rmSSpWhpSBoBjJIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="212803234"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 09:40:01 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/4] improve net/null dependency handling for tests
Date: Thu, 19 Feb 2026 17:39:49 +0000
Message-ID: <20260219173953.2182757-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122122354.1820368-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
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

A number of unit tests take advantage of net_null driver to use
as a dummy packet source. When this driver is disabled we then get
tests failures in fast-tests. Fix these by recording the dependency
appropriately or by skipping test sections if the dependency isn't
present.

V2: reworked changes following feedback, discussion and other upstream
    changes

Bruce Richardson (4):
  test/event_eth_rx_adapter: skip tests if no ethdevs
  test/event_eth_tx_adapter: remove dependency on NULL PMD
  test: fix missing dependency on null networking driver
  build/tests: add warning for missing NULL PMD dependency

 app/test/meson.build                 | 10 ++++++++--
 app/test/test_event_eth_rx_adapter.c | 14 ++++++++++----
 app/test/test_event_eth_tx_adapter.c |  4 ++++
 3 files changed, 22 insertions(+), 6 deletions(-)

--
2.51.0

