Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50303C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 19:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2119240B94;
	Thu,  6 Mar 2025 20:08:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 67F4740B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 20:08:39 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B66102110485; Thu,  6 Mar 2025 11:08:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B66102110485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741288118;
 bh=QlwXTJSGCfQE3Al1yLiEuAZoZI/P0qc21GaDPhF08WQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rmTyBv2Q/vyYnaPnGNRxNojQjKVhny81CMvlHTt9WYmen6I1io0b2SVOVdBkFqkU4
 TQ7SEQ7s/lrRvP/XGYFcIC3qwYypjISLLc1H/JRyEQB++uQsPRZS26uDBrqLw3sLaf
 izo3c8mCSoRsoxtSerDT7H8PjxPMgCVBDRFc9o4s=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/2] allow AVX512 instructions to be used with MSVC
Date: Thu,  6 Mar 2025 11:08:32 -0800
Message-Id: <1741288114-15179-1-git-send-email-andremue@linux.microsoft.com>
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

v3:
- Added subdir('msvc') to config/x86/meson.build (now that other required
  patches are merged).

Andre Muezerie (2):
  config: allow AVX512 instructions to be used with MSVC
  devtools/dump-cpu-flags: add tool to update CPU flags table

 config/x86/meson.build                     |   1 +
 config/x86/msvc/meson.build                | 287 +++++++++++++++++++++
 devtools/dump-cpu-flags/README.md          |  25 ++
 devtools/dump-cpu-flags/cpu-names.txt      | 120 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.cpp | 119 +++++++++
 devtools/dump-cpu-flags/dump-cpu-flags.py  |  41 +++
 6 files changed, 593 insertions(+)
 create mode 100644 config/x86/msvc/meson.build
 create mode 100644 devtools/dump-cpu-flags/README.md
 create mode 100644 devtools/dump-cpu-flags/cpu-names.txt
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.cpp
 create mode 100644 devtools/dump-cpu-flags/dump-cpu-flags.py

--
2.48.1.vfs.0.0

