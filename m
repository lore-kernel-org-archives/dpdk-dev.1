Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937AC369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 21:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141F84042E;
	Tue,  8 Apr 2025 23:24:47 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5794040270
 for <dev@dpdk.org>; Tue,  8 Apr 2025 23:24:44 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5C1172113E95; Tue,  8 Apr 2025 14:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C1172113E95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744147483;
 bh=FASmlFAHmiSUeNxoq4uh33HNOZO93KKd/50jwkkrSA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C+NvvuouQzcEJ3x53VF5ZxdvDE8e4s5x0YHfYY95Pud2EMkcyEy/VP7TwdzNQ7WuE
 RR+G+0zhoOErwVJ42VhBH0pBmtInFb7MaXkXqXFyEpNdG6EqVHdokxdnI2rFPgndNm
 I8+WVM5KUIJSbSfBMXW2KJ0B2tXMXZtLM2pFW3Hw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 0/1] mbuf: enable to be compiled with MSVC
Date: Tue,  8 Apr 2025 14:24:36 -0700
Message-Id: <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
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

Now that the issues preventing this lib from being compiled with MSVC
are fixed it can be included in the compilation.

v4:
- removed all symbol-related changes, leaving only the change to enable
  MSVC compilation.
- only adding cflags '-mpclmul' and '-maes' when the compiler used
  supports them.

v3:
- updated check-symbol-maps.sh to also handle ms_linker.map files.

v2:
- updated versioning macros so that the latest mbuf/net code can compile
  with MSVC. V1 did not have these changes because by the time that series
  was sent out the versioning problem had not surfaced yet.
- for testing purposes, dpdk-test was build with msvc and crc_autotest
  was run successfully. This test is known to call the versioned function
  which raised the issue.

Andre Muezerie (1):
  mbuf: enable to be compiled with MSVC

 lib/mbuf/meson.build | 6 ------
 lib/net/meson.build  | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

--
2.49.0.vfs.0.0

