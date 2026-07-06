Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCFAC43602
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 16:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E0D0402E9;
	Mon,  6 Jul 2026 18:24:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9C4DD4025F
 for <dev@dpdk.org>; Mon,  6 Jul 2026 18:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783355046; x=1814891046;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ix9kiVaBrwcQbft5y5WFsrZja+1krbYoqOjELq8xnCo=;
 b=DTFkZIIXd5Mt/iQI+tH6ZGU9zSUrkqn6+9Ifm273IpTp4z05fAZGGHIX
 URnuweHN3uLUlgl43AC+jEW9mtzCzwDZ0yHZNqG2lEHfOJtm8ln2FGCug
 enBzgIqley+6bRTxXPBHWyIjJ/A4IzulA14/yEUFoHqUONqwmYzhIn/iE
 yI4SNjTpqllwd0dsxtms+2ynFwH2qvSxvhrg4a8oddcM6PKMSbH/bHhj3
 gFIl5fiB5HZAljWCKA/6dSgTcziGKNqGPCVrZCSrwcbYA4SZvJ4bfEUTC
 Iw4KUi+DPWeZmbWV+ViJa0RfFZ/y9mUvWknlphxC0V3y663U9gO2NvC7R Q==;
X-CSE-ConnectionGUID: Y5hewbzwR6W6eVhLETOjiA==
X-CSE-MsgGUID: w9PwVHvTRfWgMg2LNU43pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95148821"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="95148821"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 09:24:01 -0700
X-CSE-ConnectionGUID: kXG+T47LRZerrQRkFZgNww==
X-CSE-MsgGUID: UNw99685Rj275qOtebEiNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="257335612"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 06 Jul 2026 09:24:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 26.11 0/4] extra unit tests for cfgfile library
Date: Mon,  6 Jul 2026 17:23:43 +0100
Message-ID: <20260706162348.460489-1-bruce.richardson@intel.com>
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

There were a few APIs in the cfgfile library which were not being
tested by the unit tests. Add tests to close that, and other, gaps.

Bruce Richardson (4):
  test/cfgfile: improve coverage for listing APIs
  test/cfgfile: validate config creation APIs
  test/cfgfile: verify file modification API
  test/cfgfile: test for long lines in file

 app/test/test_cfgfile.c                  | 197 +++++++++++++++++++++++
 app/test/test_cfgfiles/line_too_long.ini |   2 +-
 2 files changed, 198 insertions(+), 1 deletion(-)

--
2.53.0

