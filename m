Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE00C021A0
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8976B40E0C;
	Tue, 11 Feb 2025 23:02:42 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D175C4027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:02:40 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2F455210D0D9; Tue, 11 Feb 2025 14:02:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F455210D0D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739311360;
 bh=suFCJ/chfqcHkhXJijDuIVK6NdYCSI4iamQkjaVa09o=;
 h=From:To:Cc:Subject:Date:From;
 b=muBB9/f2iJuTsR40Z8kW+woW/KCSELVCrijWUkKUHyLHvZH6+cZWKW6CQHJdvuiSK
 P60WSAvyPDj3BDVy+gqcrsyXe5Nthpo6hbjKgqKxR3P0fcN6Yg4AnJf4XSjH7iAzfW
 gNVS3EEjFOtnSdCLqRxOM8q+CSpSaaCCKyO24V8U=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 00/10] enable "app" to be compiled with MSVC
Date: Tue, 11 Feb 2025 14:01:56 -0800
Message-Id: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

This series fixes many issues that prevent the "app" directory
from being compiled with MSVC.

Andre Muezerie (10):
  eal: add workaround for __builtin_constant_p
  test_alarm: avoid warning about different qualifiers
  test-pmd: fix printf format string mismatch
  test-pmd: do explicit 64-bit shift to avoid implicit conversion
  test-pmd: avoid undefined behavior
  test-pmd: avoid non-constant initializer
  test-pmd: don't return value from void function
  test-pmd: declare lcore_count atomic when using C11 memory model
  test: add workaround for __builtin_constant_p in test_memcpy_perf
  app: enable app directory to be compiled with MSVC

 app/meson.build                     |   4 --
 app/test-pmd/cmdline.c              |  19 +++--
 app/test-pmd/cmdline_flow.c         |  22 +++---
 app/test-pmd/csumonly.c             |  12 ++--
 app/test-pmd/meson.build            |   4 +-
 app/test-pmd/testpmd.c              |   2 +-
 app/test-pmd/util.c                 |   2 +-
 app/test/test_alarm.c               |  12 ++--
 app/test/test_memcpy_perf.c         | 106 ++++++++++++++--------------
 app/test/test_ring_perf.c           |   6 +-
 lib/eal/include/generic/rte_pause.h |   2 +-
 lib/eal/include/rte_common.h        |  12 ++++
 12 files changed, 114 insertions(+), 89 deletions(-)

--
2.47.2.vfs.0.1

