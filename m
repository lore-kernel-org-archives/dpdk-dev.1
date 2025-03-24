Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305AC36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 17:30:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C31840B99;
	Mon, 24 Mar 2025 18:30:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6D3C440A7F
 for <dev@dpdk.org>; Mon, 24 Mar 2025 18:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742837442; x=1774373442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2mWl5JOd1AZZXgNhydlhBoMLcFME+RkvBcdj1s7XYaE=;
 b=VJqUBmXb7Y3++9gST8TQklWOajl5c+FBemEyJhHanfQczcHkn3AeENe5
 BzVLtyUeYKu6cKAHcZvW/dzm1EmenII4JXq+yD5C9inog+qWS8RXX5aob
 54Og8RHkxEhNwIvBzw9LN8kz27aXtn5mR1z6b0ZlFjqE4/SIG+sGsclsS
 bcwA5J3WWWpLlDV+1ZsWPeoztgCDFWy6x6jrdRVS+G65vBcZ/9By1DOmh
 DUO/JUpzgXwXpQpmvczh5QrWJsMZZMcJDqPe9GFvmKvJQvUPTjS6bWOkv
 prpzuqfRuH7d2IV3ggHmfn6GUsITuEo291SgMsB+bMZaZlEK3V1YmpELB g==;
X-CSE-ConnectionGUID: rzx4pyFnRPCUKM0VNbrXrg==
X-CSE-MsgGUID: Yp5Dr9nJRxaqh31NIvfazQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47715559"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="47715559"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 10:30:40 -0700
X-CSE-ConnectionGUID: DAoEyZo8Rx2eKBTi+2JSVQ==
X-CSE-MsgGUID: FIVlAaKrSma5CJRjp2l2dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="124141939"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 24 Mar 2025 10:30:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] allow easier use of high lcore-ids
Date: Mon, 24 Mar 2025 17:30:26 +0000
Message-ID: <20250324173030.3733517-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250313113829.1480907-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
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

Traditionally, DPDK has had a direct mapping of internal lcore-ids, to
the actual core numbers in use. With higher core count servers becoming
more prevalent the issue becomes one of increasing memory footprint when
using such a scheme, due to the need to have all arrays dimensioned for
all cores on the system, whether or not those cores are in use by the
app.

Therefore, the decision was made in the past to not expand the
build-time RTE_MAX_LCORE value beyond 128. Instead, it was recommended
that users use the "--lcores" EAL parameter to take the high-numbered
cores they wish to use and map them to lcore-ids within the 0 - 128
range. While this works, this is a little clunky as it means that
instead of just passing, for example, "-l 130-139", the user must
instead pass "--lcores 0@130,1@131,2@132,3@133,...."

This patchset attempts to simplify the situation by adding a new flag to
do this mapping automatically. To use cores 130-139 and map them to ids
0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-ids",
or using the shorter "-M" version of the flag: "-Ml 130-139".

Adding this new parameter required some rework of the existing arg
parsing code, because in current DPDK the args are parsed and checked in
the order they appear on the commandline. This means that using the
example above, the core parameter 130-139 will be rejected immediately
before the "map-lcore-ids" parameter is seen. To work around this, the
core (and service core) parameters are not parsed when seen, instead
they are only saved off and parsed after all arguments are parsed. The
"-l" and "-c" parameters are converted into "--lcores" arguments, so all
assigning of lcore ids is done there in all cases.

RFC->v2:
* converted printf to DEBUG log
* added "-M" as shorter version of flag
* added documentation
* renamed internal API that was changed to avoid any potential hidden
  runtime issues.

Bruce Richardson (3):
  eal: centralize core parameter parsing
  eal: convert core masks and lists to core sets
  eal: allow automatic mapping of high lcore ids

 doc/guides/linux_gsg/eal_args.include.rst  |  26 +-
 drivers/event/dlb2/dlb2_priv.h             |   2 -
 drivers/event/dlb2/pf/base/dlb2_resource.c |  48 +--
 lib/eal/common/eal_common_options.c        | 340 +++++++--------------
 lib/eal/common/eal_options.h               |   3 +
 lib/eal/include/rte_eal.h                  |  14 +-
 lib/eal/version.map                        |   2 +-
 7 files changed, 161 insertions(+), 274 deletions(-)

--
2.45.2

