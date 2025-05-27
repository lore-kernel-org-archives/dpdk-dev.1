Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB7C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66D8340662;
	Tue, 27 May 2025 17:29:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id AC2044028D
 for <dev@dpdk.org>; Tue, 27 May 2025 17:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748359760; x=1779895760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=92iPPxhylHLEo9WXjQh7jroXma3LPugrT0mQnpRLQdo=;
 b=n8J1Eem5K0qR0f6svvMV+OKh3ZPE48ExGyCeONKiV2NYos8SpOEYWeGm
 cfSknsGrIfsud3g0vAeVisTccpWKTts0NkeXnWT8YhQENJJHwImSXSMqH
 lwY18z9InUzPYpraGsNahvL7pRcEZyPyJ8G5q8Erol43Gw2qOwHDh+Rq9
 byCJzNBp+0sSlYvG9iiTHGi/ioTgirWiNSYjFPXsD8hdiSYkKKNIMqjc+
 QH8lRniziRJHymmQozaG25nIxyDFTkOmCCya5aOGYvJVRtJ4B2UdYZMxA
 BJAJTakPePjVXxba6d+V9DxGu6tBwlSf9CV+ZQNJbzsaiU3MR5+ul6oSV A==;
X-CSE-ConnectionGUID: d5NYYpaHTqGG7mL79TxWiA==
X-CSE-MsgGUID: bATLI9zkQEWqfd6ImEh8rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50233244"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50233244"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:29:18 -0700
X-CSE-ConnectionGUID: BHbsRTWNQuyyG3GX2Mf5YQ==
X-CSE-MsgGUID: KxdG1PpYSnu5D9BdisWHow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="180067285"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 May 2025 08:29:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 0/3] lcore options cleanup
Date: Tue, 27 May 2025 16:29:10 +0100
Message-ID: <20250527152913.279011-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313113829.1480907-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset performs some basic cleanup of EAL lcore arguments before
any more serious work is done on them (as discussed in previous patchset
revisions).

* mark the old coremask parameter (-c) and service core mask (-s) as
  deprecated, so they can be dropped in future. Everything should now be
  done using core lists where possible.
* consolidate the, previously separate but similar, "-l" and "--lcores"
  flags into just short and long versions of the same thing. This does
  not affect the "--lcores" flag at all, but expands the scope of what
  was possible with "-l".
* Add documentation of examples of use of the -l/--lcores parameter

V5: adjust the examples in patch 3, to only use quotes where necessary
  and explain in a note why they are sometimes used in the examples.

Bruce Richardson (3):
  eal: deprecate old coremask-based EAL parameters
  eal: merge corelist and core mapping options
  doc: provide examples of using lcores EAL parameter

 doc/guides/eventdevs/dlb2.rst                 |   6 +-
 doc/guides/faq/faq.rst                        |   8 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |   7 +-
 doc/guides/linux_gsg/eal_args.include.rst     |  50 +++++--
 .../prog_guide/env_abstraction_layer.rst      |   3 +-
 doc/guides/prog_guide/meson_ut.rst            |   2 +-
 doc/guides/prog_guide/multi_proc_support.rst  |   2 +-
 doc/guides/prog_guide/service_cores.rst       |   8 +-
 doc/guides/rel_notes/deprecation.rst          |  10 ++
 doc/guides/sample_app_ug/ip_frag.rst          |   7 +-
 doc/guides/sample_app_ug/ip_reassembly.rst    |   7 +-
 doc/guides/sample_app_ug/multi_process.rst    |  14 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |   2 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
 doc/guides/tools/testbbdev.rst                |   2 +-
 lib/eal/common/eal_common_options.c           | 141 +++---------------
 lib/eal/common/eal_options.h                  |   4 +-
 17 files changed, 96 insertions(+), 179 deletions(-)

--
2.48.1

