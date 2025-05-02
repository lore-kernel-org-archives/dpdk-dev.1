Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A2C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F7BD402A0;
	Fri,  2 May 2025 17:11:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D118D4029E
 for <dev@dpdk.org>; Fri,  2 May 2025 17:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746198714; x=1777734714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3pWNKcaw1hx5HqKNGEUeq5pQxfMBpiwEkQfaNVRNgrY=;
 b=PYSgJtSpQTMYVGdjhM/rhMW71XP0kCxgyvnZeqWb7spxBY2xvym+Jjwk
 R0djpxupfwnDqdioErgaUw2PJG//SMcfGi7PsGTobtgBm4EV/Mx2LpyVC
 RV5cdrYBXnjC3tx/Ev7/wr5FSkh6q6B00yXkoplBGqgtkYmjnb3/1Dab1
 x7akzH7598iNxK5UcpFrUzZmXnN95+h2pJ6/XYR18nBcr8zev67PCblt6
 bk3OlJHXaEUnlSDOd+M7yCc62KjKqZ3RJcONvkCqzjuGTEdibgfJZfsZW
 vOLz4BN5JDvCNvB4fu5PJIzgHBTowHzJHjIjG8XWDIkAS8hBM6uqr3Is2 w==;
X-CSE-ConnectionGUID: bFB9F8NIQh6IwcAJAugM2w==
X-CSE-MsgGUID: 4aOZ4KyhQrehvPaZSFJXHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47970462"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47970462"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:11:51 -0700
X-CSE-ConnectionGUID: yWFR7/i4RqWGHsmWeAh7vw==
X-CSE-MsgGUID: 01yHAoMSSn2GoGuH5U7dfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135172719"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 02 May 2025 08:11:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, mb@smartsharesystems.com,
 stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/4] rework and expand EAL lcore options
Date: Fri,  2 May 2025 16:11:30 +0100
Message-ID: <20250502151134.536799-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

Following discussion earlier on this thread on the previous RFCs and
patches submitted [1], this series is a slightly different take on
solving the same fundamental problem - making it easy to use CPU cores
with ids >= RTE_MAX_LCORE, without having massive amounts of code
complexity internally. As previously discussed[2] this patchset
implements proposal "2a" and does the following:

* marks the old coremask parameter (-c) and service core mask (-s) as
  deprecated, so they can be dropped in future. Everything should now be
  done using core lists where possible.
* consolidates the, previously separate but similar, "-l" and "--lcores"
  flags into just short and long versions of the same thing. This does
  not affect the "--lcores" flag at all, but expands the scope of what
  was possible with "-l".
* a new flag, with long/short versions, is added as "-L" to allow the
  user to just specify a range or set of physical CPU core ids to be
  used by the app, and have them automatically mapped internally to a
  set of lcore ids starting at 0. This provides the "easy solution" to
  the original problem stated above.

For completeness, since it's in the same area, the previously separate
documentation patch, adding examples for the "--lcores" parameter, is
rolled into this series as patch 3.

[1] https://patches.dpdk.org/project/dpdk/list/?series=34911&state=*
[2] https://inbox.dpdk.org/dev/Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ger.corp.intel.com/#t

Bruce Richardson (4):
  eal: deprecate old coremask-based EAL parameters
  eal: merge corelist and core mapping options
  doc: provide examples of using lcores EAL parameter
  eal: add option for auto-mapping cpu ids to low lcore ids

 doc/guides/eventdevs/dlb2.rst                 |   6 +-
 doc/guides/faq/faq.rst                        |   8 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |   7 +-
 doc/guides/linux_gsg/eal_args.include.rst     |  61 ++++--
 .../prog_guide/env_abstraction_layer.rst      |   3 +-
 doc/guides/prog_guide/meson_ut.rst            |   2 +-
 doc/guides/prog_guide/multi_proc_support.rst  |   2 +-
 doc/guides/prog_guide/service_cores.rst       |   8 +-
 doc/guides/rel_notes/deprecation.rst          |  10 +
 doc/guides/sample_app_ug/ip_frag.rst          |   7 +-
 doc/guides/sample_app_ug/ip_reassembly.rst    |   7 +-
 doc/guides/sample_app_ug/multi_process.rst    |  14 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |   2 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
 doc/guides/tools/testbbdev.rst                |   2 +-
 lib/eal/common/eal_common_options.c           | 202 +++++++-----------
 lib/eal/common/eal_options.h                  |   6 +-
 lib/eal/windows/include/sched.h               |   1 +
 18 files changed, 168 insertions(+), 182 deletions(-)

--
2.45.2

