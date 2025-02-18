Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB60C021AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9910F40666;
	Tue, 18 Feb 2025 17:32:20 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5B6D140654
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:32:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3E56E20376E6; Tue, 18 Feb 2025 08:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E56E20376E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739896334;
 bh=4B+Y7cEpDP1P/3ClQy0sL70PRSgqkHH5NLnRk2iRzVE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Crtu0fV7v5AKDJa9LM2+S/v4jvndyu/7FfRScPYMwZAKcphc8md2IsZjAoLGDA9w9
 WAzkx+Jy83wZzxK0He5X+rlIlNsWk14z4yMoCxXMr3RfNIIT3RY9yAYqcDSJAuIkiR
 9qHtazlFynIzflNrGn1qHVuxDjg5TjTViwwTjRJ8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 00/10] enable "app" to be compiled with MSVC
Date: Tue, 18 Feb 2025 08:31:59 -0800
Message-Id: <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
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

v2:
- use lcore_count as atomic always, not only when RTE_USE_C11_MEM_MODEL
  is set.
- use PRIu64 in csumonly.c instead of casting variables to int.

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
  test-pmd: declare lcore_count atomic
  test: add workaround for __builtin_constant_p in test_memcpy_perf
  app: enable app directory to be compiled with MSVC

 app/meson.build                     |   4 --
 app/test-pmd/cmdline.c              |  19 +++--
 app/test-pmd/cmdline_flow.c         |  22 +++---
 app/test-pmd/csumonly.c             |  23 +++---
 app/test-pmd/meson.build            |   4 +-
 app/test-pmd/testpmd.c              |   2 +-
 app/test-pmd/util.c                 |   2 +-
 app/test/test_alarm.c               |  12 ++--
 app/test/test_memcpy_perf.c         | 106 ++++++++++++++--------------
 app/test/test_ring_perf.c           |   6 +-
 lib/eal/include/generic/rte_pause.h |   2 +-
 lib/eal/include/rte_common.h        |  12 ++++
 12 files changed, 116 insertions(+), 98 deletions(-)

--
2.48.1.vfs.0.0

