Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E9C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8E12402D3;
	Thu, 20 Feb 2025 03:01:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 39464402BB
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:01:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2F796204E595; Wed, 19 Feb 2025 18:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F796204E595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016907;
 bh=Y+2UkdCVMf2/408pOvU+CeMDZarSyRcFywZ/xHckHyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b5rqh5a6wJE+xWtTgAkUrE3BSQNUFpgcskhJl84rB1LJb3zVDo7WqPYWmId/1Yr1I
 TYNUE5/wYT00OUC3hUz7hisdkgG2HvlFm3h2PMxEl7GOC49lppi+TpGeccjiqPGQPF
 VXeGWjD3a4m33MnB/uXruo8NvTi1HWgZb99cqrlA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 00/10] enable "app" to be compiled with MSVC
Date: Wed, 19 Feb 2025 18:01:29 -0800
Message-Id: <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
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

v3:
- use clever expression with _Generic for __rte_constant and use it
  where __builtin_constant_p was being used.
- use %u in csumonly.c and just cast variables to unsigned int.

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

 app/meson.build                     |  4 ---
 app/test-pmd/cmdline.c              | 16 +++++----
 app/test-pmd/cmdline_flow.c         | 22 ++++++------
 app/test-pmd/csumonly.c             | 23 ++++++------
 app/test-pmd/meson.build            |  1 -
 app/test-pmd/testpmd.c              |  2 +-
 app/test-pmd/testpmd.h              |  2 ++
 app/test-pmd/util.c                 |  2 +-
 app/test/test_alarm.c               | 12 +++----
 app/test/test_memcpy_perf.c         | 54 ++++++++++++++---------------
 app/test/test_ring_perf.c           |  6 +---
 lib/eal/include/generic/rte_pause.h |  2 +-
 lib/eal/include/rte_common.h        |  2 +-
 13 files changed, 73 insertions(+), 75 deletions(-)

--
2.48.1.vfs.0.0

