Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C5C282C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 21:43:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9891E410E7;
	Fri, 28 Feb 2025 22:43:49 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4CA410D4
 for <dev@dpdk.org>; Fri, 28 Feb 2025 22:43:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5E86F210D0DA; Fri, 28 Feb 2025 13:43:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E86F210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740779025;
 bh=zMw2HVez2KGyQsNTB6IurLD/WytjzkUowqTilXixyy8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rWU1xiPNMCav9Wmqr+vYDWP66pJ8VuAeVu5dE5z20nX4iRQBkW33mE3qNZp668zfi
 CzB8TwYU40cz7oFIwzFjZ7rQjy7yrtixf86m986s2hCs6CzqsH58rSYBEHuQJ/QS9p
 LplQSSSjkwsXe0Mh2Mf6ZXrHRu8gFadJuBeq+cVY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 0/2] allow AVX512 instructions to be used with MSVC
Date: Fri, 28 Feb 2025 13:43:41 -0800
Message-Id: <1740779023-1274-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
References: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
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

TODO: Add subdir('msvc'). We can't do this until the common part in
config/meson.build is merged.

Andre Muezerie (2):
  config: allow AVX512 instructions to be used with MSVC
  devtools/dump-cpu-flags: add tool to update CPU flags table

 config/x86/msvc/meson.build                | 287 +++++++++++++++++++++
 devtools/dump-cpu-flags/README.md          |  25 ++
 devtools/dump-cpu-flags/cpu-names.txt      | 120 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.cpp | 119 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.py  |  41 +++
 5 files changed, 592 insertions(+)
 create mode 100644 config/x86/msvc/meson.build
 create mode 100644 devtools/dump-cpu-flags/README.md
 create mode 100644 devtools/dump-cpu-flags/cpu-names.txt
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.cpp
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.py

--
2.48.1.vfs.0.0

