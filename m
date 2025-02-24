Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F509C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 21:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ABC2427C5;
	Mon, 24 Feb 2025 22:01:43 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BB88940DD0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 22:01:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0FF1F203CDE2; Mon, 24 Feb 2025 13:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF1F203CDE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740430902;
 bh=Srp7afD/kt7c0W/p14A+0DKZTquoC5DEHtMJ21M8KZU=;
 h=From:To:Cc:Subject:Date:From;
 b=aMhvkrVVEMaKRmtec5XvdDnS1LHO4kPn4E1lCyBpiwvGAvDbyJpSDN8DLc1U0Prak
 tRJfj/tfT8WIDfBDnGztpPMFhp6XHTGEjxTyz694vXt+cXG7KnPZhwerwzvtT5YTWf
 CDPmyI9SIllGKmbujok9pxHUZroR2KzVtb16d/Bs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 0/6] allow faster instruction sets to be used with MSVC
Date: Mon, 24 Feb 2025 13:01:13 -0800
Message-Id: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
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

Up to now MSVC has being used with the default mode, which uses SSE2
instructions for scalar floating-point and vector calculations.
https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170

This series allows users to specify the CPU for which the generated
code should be optimized for in the same way it's done for GCC: by
passing the CPU name.
When no explicit CPU name is passed, 'native' is assumed (like it
happens with GCC) and the code will be optimized for the same CPU
type used to compile the code.

MSVC does not provide this functionality natively, so logic was
added to handle these differences, detecting which
instruction sets are supported by the CPU(s), passing the best
options to MSVC and setting the correct macros (like __AVX512F__)
so that the DPDK code can rely on them like it is done with GCC.

Andre Muezerie (6):
  eal: make compatible with instruction set updates for MSVC
  eal: only use numbers as align parameters for MSVC
  config: allow faster instruction sets to be used with MSVC
  drivers/net: make compatible with instruction set updates for MSVC
  acl: make compatible with instruction set updates for MSVC
  member: make compatible with instruction set updates for MSVC

 config/x86/meson.build             | 364 +++++++++++++++++++++++++----
 drivers/net/bnxt/meson.build       |   2 +-
 drivers/net/enic/meson.build       |   2 +-
 drivers/net/intel/i40e/meson.build |   2 +-
 drivers/net/intel/iavf/meson.build |   2 +-
 drivers/net/intel/ice/meson.build  |   2 +-
 drivers/net/intel/idpf/meson.build |   2 +-
 drivers/net/nfp/meson.build        |   2 +-
 drivers/net/octeon_ep/meson.build  |   4 +-
 lib/acl/meson.build                |  16 +-
 lib/eal/common/rte_random.c        |   2 +
 lib/eal/x86/include/rte_vect.h     |  11 +-
 lib/member/meson.build             |  11 +-
 13 files changed, 363 insertions(+), 59 deletions(-)

--
2.48.1.vfs.0.0

