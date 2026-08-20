Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55955C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2CD40279;
	Thu, 20 Aug 2026 16:25:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2100F400EF;
 Thu, 20 Aug 2026 16:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787235915; x=1818771915;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=if+PH6R8gS31ayyP7uYS1bYo6J6WMuvseQeKXRzwA+0=;
 b=c5eO9kn3AHDDTaqHRD1YFb7neUB+YAUy9X0TGxUs+648a8ELDx3GFVjq
 +zIxe91zAgsZ0EMyLR+6Yb1cEJQrFkGw9ph58Mg5xGKPi2tIwe020KcEo
 41e3UPRUcQ73EBeBlimQVReHXx3B7mc1mcf/dCXmxc/UK/KqVgjGv9G0h
 UxnYRNquYHi7Lnh2JWfvdXiet57Ku0YSpy9+L7a9rURurk/EgtwylNQLQ
 U9AizXPi60T9yx+F3HnxhBDB2ZUgXRbGPehlkbFRsoKczOM97RtaLI+AJ
 4+vin9I1Xe1Jsu/SRernU8WCRkcfQScx5SY9W4SzsRwFod9MIAmzX+2Wj w==;
X-CSE-ConnectionGUID: KBi3O6twTcOyMHEfY8qY5A==
X-CSE-MsgGUID: mK/4gC8wTyuRo0P8/tiZuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113311559"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="113311559"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:25:14 -0700
X-CSE-ConnectionGUID: 0imHIi6vS1G9/bx1vO3a5g==
X-CSE-MsgGUID: S6i0fWIERyCBCZdd+RJLlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269878671"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 07:25:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/3] add standalone mempool perf testing app
Date: Thu, 20 Aug 2026 15:24:36 +0100
Message-ID: <20260820142439.3684311-1-bruce.richardson@intel.com>
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

While the mempool perf tests in the autotest suite cover a wide
range of possibilities, there is no way they can cover all possible
app permutations, and there is no way to parameterize running a
unit test.

To cover this gap, this patchset proposes a new test-mempool-perf app
which can be used to test out mempool performance across a range of
different scenarios. The options cover (not an exhaustive list):

* underlying mempool driver to use
* mempool cache size
* burst size
* whether to use pipeline or run to completion models
* for run-to-completion how much variability in ordering of allocs
  and frees.
* whether we touch the packets between alloc and free

To simplify the use of the app, if run without parameters the
user is queried for the options to use, and the app thereafter
prints the cmdline to use for future re-runs with same settings.


Bruce Richardson (3):
  app/test-mempool-perf: skeleton of new test app
  app/test-mempool-perf: add perf test logic
  app/test-mempool-perf: add testing in pipeline model

 app/meson.build                   |   1 +
 app/test-mempool-perf/main.c      | 808 ++++++++++++++++++++++++++++++
 app/test-mempool-perf/meson.build |   8 +
 doc/guides/tools/index.rst        |   1 +
 doc/guides/tools/mempoolperf.rst  | 173 +++++++
 5 files changed, 991 insertions(+)
 create mode 100644 app/test-mempool-perf/main.c
 create mode 100644 app/test-mempool-perf/meson.build
 create mode 100644 doc/guides/tools/mempoolperf.rst

--
2.53.0

