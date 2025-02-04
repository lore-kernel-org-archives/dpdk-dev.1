Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBEC02192
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 01:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 368FB40A76;
	Tue,  4 Feb 2025 02:58:49 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E3A9240289
 for <dev@dpdk.org>; Tue,  4 Feb 2025 02:58:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E2F07205493C; Mon,  3 Feb 2025 17:58:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2F07205493C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738634325;
 bh=r7+UKf2WNUjhdYFYYs9FFXta8y9TA2Lu8T4GkaHoEtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R/CnwzeRuZTOKyoChrkJLfnsyDsziGohUrCsG9iFJgQdMwE9qBD/6+Hv81g2gSLJR
 CxTeRfAaZ5rfgq8v6wYbD2rHOa4fM2XTbMXgZdqRhm1HE/A9J68V52KLOyuuSJIRoz
 npC2ifQBLKob37wKA1rZS4cJVs1vi4Eg4zz8pIBc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	david.marchand@redhat.com
Subject: [PATCH v3 0/2] enable build of lib/stack when using MSVC
Date: Mon,  3 Feb 2025 17:58:36 -0800
Message-Id: <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC does not support inline assembly, which is used by the
implementation of rte_atomic128_cmp_exchange and is needed
by the C11 flavor of lib/stack.

A special implementation of rte_atomic128_cmp_exchange
compatible with MSVC is added to rte_stack_lf_c11.h. It uses an
intrinsic function when using MSVC, and inline assembly when other
compilers are used.

Existing atomic tests (which are not C11 compatible) are
now skipped when using MSVC.

v3:
 * Isolated the additional implementation of rte_atomic128_cmp_exchange
   to MSVC only.

v2:
 * Added MSVC compatible implementation of rte_atomic128_cmp_exchange
 * Skipped non-C11 atomic tests when using MSVC

Andre Muezerie (2):
  test: disable non-C11 atomic tests for MSVC
  stack: enable build with MSVC

 app/test/test_atomic.c       |  2 ++
 lib/stack/meson.build        |  6 ------
 lib/stack/rte_stack_lf_c11.h | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

--
2.47.2.vfs.0.1

