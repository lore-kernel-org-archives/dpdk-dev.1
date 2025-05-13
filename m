Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA1C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 16:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A4254025F;
	Tue, 13 May 2025 18:17:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2154C40041
 for <dev@dpdk.org>; Tue, 13 May 2025 18:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747153052; x=1778689052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9FsTE4AjRHbafjauwL0vdvkqhX77YaJ7OO+am711voc=;
 b=j8J8OTXuzvNgQuvGuQxN3QkFUaSGZ/+NlxLQ0Sp4/210xrSt00gtQGMP
 soT9MK+brV/CHE489yb7yzV+2IScW34IuSPMLU23NEGybgmkHK2NzFHSK
 77aE5APmDV0kR5fB+BbdZcA13u44yxx96MkJd7DOrR6yiEE4xy5YjMazt
 ievdqk+q7eiIUJL1dNBqOOqdD3p5s+yZMSbUQJd8Nt1YNWmessOwVkA41
 J0DabYgKcMWjb0Ea1mWy9IWcPDBl/AoS1irS76bjp5t10j7q0hcnVP4cb
 cqJ89z0XHavuOnksbF8oe2Xj5a/b+kynRCVW+mEyxgmgKLDrTpR/EfhZ4 w==;
X-CSE-ConnectionGUID: +Kv1kYUfQ1uity5ibj4QAA==
X-CSE-MsgGUID: 1Dw3IlAXSAKWe9ER3XXLaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49130051"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="49130051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 09:17:30 -0700
X-CSE-ConnectionGUID: Iic6vzQfTbyC3Jr3sW2yaQ==
X-CSE-MsgGUID: sS963BlgRCO4jBqzXVvJXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138733205"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa009.fm.intel.com with ESMTP; 13 May 2025 09:17:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/3] lcore options cleanup
Date: Tue, 13 May 2025 17:17:07 +0100
Message-ID: <20250513161710.410000-1-bruce.richardson@intel.com>
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

This v4 scales back some of the work done in the previous versions, since
more options need to be looked at for the core handling. For now, then
this patchset is reduced to some basic cleanup before any more serious work
is done.

* marks the old coremask parameter (-c) and service core mask (-s) as
  deprecated, so they can be dropped in future. Everything should now be
  done using core lists where possible.
* consolidates the, previously separate but similar, "-l" and "--lcores"
  flags into just short and long versions of the same thing. This does
  not affect the "--lcores" flag at all, but expands the scope of what
  was possible with "-l".
* Adds documentation of examples of use of the -l/--lcores parameter

Bruce Richardson (3):
  eal: deprecate old coremask-based EAL parameters
  eal: merge corelist and core mapping options
  doc: provide examples of using lcores EAL parameter

 doc/guides/eventdevs/dlb2.rst                 |   6 +-
 doc/guides/faq/faq.rst                        |   8 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |   7 +-
 doc/guides/linux_gsg/eal_args.include.rst     |  45 ++++--
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
 17 files changed, 91 insertions(+), 179 deletions(-)

--
2.45.2

