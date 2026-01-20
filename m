Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A49D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD0F940268;
	Tue, 20 Jan 2026 12:26:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E6C9E4013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768908376; x=1800444376;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BgnC+0BKDJdey6jbchWhJfChb+cokPtt+Lk2EFSzfRM=;
 b=SWuM9ztbuE060keomwUEF/ECkfk+eLKAalaYRzbAlFykk2vK/qlhjtM3
 0/1LbbL4goJkf3XILJgIjDuJLgFsv6fsJG0a4g0uAwr5SvWFTcQQiwJYc
 ux+oXNHAQ96CMm3zOM5NuReDrnfQpakPXWEa85mpVgkhrtGeuxFcZ0/fP
 QuZe3OC2dGG66NLH3BZoDWGqtpJUAyjcl8EPcD4MBE1hdG5xNhUBp3JVK
 5nnIfxboz7RARCV86CdpstOHjGFBxm98UDqz3kkCMsFHLZyAAmTG3Gz57
 nf1QTJ/dn0wqr7CH6bpnRzp91aUiDBioQ8u0fQOPMwi4M9NdHYNW91z37 w==;
X-CSE-ConnectionGUID: kHQJY5KQRoS3Tot3owXC+Q==
X-CSE-MsgGUID: bAvuF1ZGST2CB3F4ow587w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69314493"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="69314493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 03:26:15 -0800
X-CSE-ConnectionGUID: uJ4jN3fuRQCcfrpQGwX9fw==
X-CSE-MsgGUID: E4Y7bC47ThSCcWP6V20ZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205253390"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 20 Jan 2026 03:26:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] improve debug output for EAL flags unit tests
Date: Tue, 20 Jan 2026 11:25:49 +0000
Message-ID: <20260120112552.921243-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

If issues arise in the EAL flags unit tests they can be trick to debug
due to the lack of debugging output when running recursive instances of
the test binary with different EAL flags. Try to improve this situation
by adding extra debug output for recursive dpdk-test calls in general,
and to some of the EAL flags tests in particular that are proving
problematic.

NOTE: there are intermittent failures seen in github actions with the
file-prefix EAL unit tests. The problems seem less frequent, or possibly
"gone", with this set applied, but even if it masks the problem, this
set does give us greater visibility to debug if they do re-occur.

Bruce Richardson (3):
  app/test: add extra logging for recursive calls
  test/eal_flags: add line numbers to error messages
  test/eal_flags: add extra logging for file prefix tests

 app/test/test.c           |  14 +-
 app/test/test_eal_flags.c | 373 ++++++++++++++++++++++----------------
 2 files changed, 224 insertions(+), 163 deletions(-)

--
2.51.0

