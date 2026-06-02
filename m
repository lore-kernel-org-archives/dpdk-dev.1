Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E8C5DF71
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF81240649;
	Tue,  2 Jun 2026 11:08:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7ABA4402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780391334; x=1811927334;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FQy5HTLOQOG5kOwhZzobrD490L0ns0VMuluSOZnaZus=;
 b=GsU4WPC58OJHIZ5eWGmIgnI+WYaSVNNIVCA+mQJopGNagAsqHOj4zGT/
 zHM0uNUmN8z9o8WhtZfQZgNAuujOi7kmmNeMr4OUwPNp6WH2YeM+n2jya
 hnrYvNEerPWh3VozQpIiIJ2stEDhgypsZkDmbq5yQpMpar+W534UMj2+2
 n4PBybbFgJQ7ftDIRiyP7wWNhx4KeG5u3zEkyaz91rJYYZO70xjBFmr9D
 5MsaIYlwG329lp/Jpif4vl0YRi0VEI2Oug1beiILFlYVt/bXNyBlPnTAh
 eWAuabvl0GJuvpdQwmEMsi1CTJJDCkngVBoo22tBbfQj25n35Yq/1FIqX g==;
X-CSE-ConnectionGUID: vEdGNuksRh2aJoOsrIZlkw==
X-CSE-MsgGUID: uVhy3gVJT+WmjrWYPaFQgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80201502"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80201502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:08:53 -0700
X-CSE-ConnectionGUID: gzdPfagvTKCfpmU6S4C02Q==
X-CSE-MsgGUID: zNv4MRA/SAasHABPYuPnmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="247809469"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 02 Jun 2026 02:08:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/3] remove unneeded build options
Date: Tue,  2 Jun 2026 10:08:44 +0100
Message-ID: <20260602090847.905721-1-bruce.richardson@intel.com>
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

Having unnecessary build options just makes things confusing for
the user, and expands the set of potential builds. This set
makes 3 build options no-ops, and marks them as deprecated for
future removal.

Bruce Richardson (3):
  build: deprecate kernel dir option
  build: deprecate standalone tests option
  build: deprecate HPET build option

 app/meson.build                      | 6 +-----
 app/test/test.c                      | 7 -------
 app/test/test_timer.c                | 5 +++++
 config/meson.build                   | 2 +-
 doc/guides/linux_gsg/enable_func.rst | 2 --
 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 lib/eal/linux/meson.build            | 5 +----
 meson_options.txt                    | 6 +++---
 8 files changed, 18 insertions(+), 22 deletions(-)

--
2.53.0

