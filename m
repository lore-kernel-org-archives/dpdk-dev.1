Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0FC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 11:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F385140EE7;
	Thu, 13 Mar 2025 12:38:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8039240EE3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 12:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741865917; x=1773401917;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X3xaBjRCiCvgpAIeyAKadGSJ/wYpAoTu1RVREaf2z18=;
 b=N59bwgv2ywl7wXICDzUjYQ4hraVzc3gRZXV+SQQjUxB6Zdb/UvKIPQN7
 SCYNLkfcLAApObGIf+6ZU4SO+pAn4ebJKDeLusfpPQRRqpQIVmGMHekZT
 ulrLO78qIN2lI4jLneVV5jNnrYACVLNW6WOW+nyFq6wpZ7QBza4hQshcy
 sIUfFpYsD2yzaAIn6W1e4cqott8hjF4gXGCKuFwiE1vh4Yc8zJ4v2NPrR
 qYGczET0AzTWyinFHM2/OHnG2lKOOmst3wRnzHy4187nskpM20dyqImVt
 EaFeotG/Uf7pu+JAKqy+eUZ38DG2HUtwBAF/014xBuLq4pqZVhIgMdSZu w==;
X-CSE-ConnectionGUID: unhWztLLTX+tqxRlcdMuvg==
X-CSE-MsgGUID: dVlCF+/tSQquPKAsMwo5tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42145706"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42145706"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 04:38:36 -0700
X-CSE-ConnectionGUID: BCkl588rSrOhM2IN27hrCQ==
X-CSE-MsgGUID: vnhLOjECSNuG5rm/7YvpqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="120888936"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 04:38:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/3] allow easier use of high lcore-ids
Date: Thu, 13 Mar 2025 11:38:26 +0000
Message-ID: <20250313113829.1480907-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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
0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-ids".

Adding this new parameter required some rework of the existing arg
parsing code, because in current DPDK the args are parsed and checked in
the order they appear on the commandline. This means that using the
example above, the core parameter 130-139 will be rejected immediately
before the "map-lcore-ids" parameter is seen. To work around this, the
core (and service core) parameters are not parsed when seen, instead
they are only saved off and parsed after all arguments are parsed. The
"-l" and "-c" parameters are converted into "--lcores" arguments, so all
assigning of lcore ids is done there in all cases.

TODOs and requests-for-feedback:
- is there a suitable single-letter abbreviation we could use for this
  mapping option. For example, if using "x" it would mean we could use
  e.g. "-xl 130-139" for core options.
- still printfs in the code. This is to make it clearer for anyone
  testing what is happening.
- doc updates - will be done if feedback is positive to move from RFC to
  proper patch.

Bruce Richardson (3):
  eal: centralize core parameter parsing
  eal: convert core masks and lists to core sets
  eal: allow automatic mapping of high lcore ids

 drivers/event/dlb2/dlb2_priv.h             |   2 -
 drivers/event/dlb2/pf/base/dlb2_resource.c |  48 +--
 lib/eal/common/eal_common_options.c        | 338 +++++++--------------
 lib/eal/common/eal_options.h               |   2 +
 lib/eal/include/rte_eal.h                  |   2 +-
 5 files changed, 126 insertions(+), 266 deletions(-)

--
2.43.0

