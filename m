Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A7C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 01:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C778440E0C;
	Fri, 28 Feb 2025 02:52:33 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EB9B740E13
 for <dev@dpdk.org>; Fri, 28 Feb 2025 02:52:31 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CF125210EAC3; Thu, 27 Feb 2025 17:52:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF125210EAC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740707550;
 bh=LccuQtZlmsw38wtjilMwSgtdHP1xIZJoA7qyGQaXUyk=;
 h=From:To:Cc:Subject:Date:From;
 b=fbTbmranrIqUrVWPMxasgg1j0GKdycL9UHs5szr4szGQRck88MDs+zTmLuRReAe9u
 x133AMCD4QD4LF12JGRuow8TPhWtn496ocu7RbhVHqSgPs7VklZ3BuWJoJ4lZga9Eq
 7aNsDNHqRpo3GHYpGuKBq6JXJK7Kpx/SyeU3uaRI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 0/2] allow AVX512 instructions to be used with MSVC
Date: Thu, 27 Feb 2025 17:52:15 -0800
Message-Id: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
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

This patchset allows users to specify the CPU for which the generated
code should be optimized for in the same way it's done for GCC: by
passing the CPU name. When no name is provided 'native' is assumed
meaning that the code should be optimized for the machine compiling
the code.

MSVC does not provide this functionality natively, so logic was
added. This additional logic relies on a table which stores instruction
set availability (like AXV512F) for different CPUs.

To make it easier to update this table a new devtool was also added.

Andre Muezerie (2):
  config: allow AVX512 instructions to be used with MSVC
  devtools/dump-cpu-flags: add tool to update CPU flags table

 config/x86/meson.build                     |  87 ++++---
 config/x86/msvc/meson.build                | 287 +++++++++++++++++++++
 devtools/dump-cpu-flags/README.md          |  25 ++
 devtools/dump-cpu-flags/cpu-names.txt      | 120 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.cpp | 119 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.py  |  41 +++
 lib/acl/meson.build                        |   8 +-
 lib/member/meson.build                     |  11 +-
 8 files changed, 648 insertions(+), 50 deletions(-)
 create mode 100644 config/x86/msvc/meson.build
 create mode 100644 devtools/dump-cpu-flags/README.md
 create mode 100644 devtools/dump-cpu-flags/cpu-names.txt
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.cpp
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.py

--
2.48.1.vfs.0.0

