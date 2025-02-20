Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B29AC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E1F402B2;
	Thu, 20 Feb 2025 21:32:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5DC814026D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:32:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 90E68203E3A2; Thu, 20 Feb 2025 12:32:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90E68203E3A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740083523;
 bh=IkZCsvtpEOmI7WbS+pDlDzc20oR/QI7+Ae3eVAOytao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RCqEQFOtdtP+acDRSD36NL3iKolOWdKrq7yT1G3qi0nCxvZ8dkwFMIDk9g27a9Xmx
 Vs8k+0WRyQbBtAxAzE59CZaoneQVod4WrowU7Fv4ixVJkQ3m6jBRMGwGkjikhVk0+M
 SmobWnPbaO6dW6L6XGWEiED3340nJu26oS5bIZsw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/6] mbuf: enable to be compiled with MSVC
Date: Thu, 20 Feb 2025 12:31:42 -0800
Message-Id: <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling with MSVC the error below shows up due to function
versioning:

../lib/net/rte_net_crc.c(418): error C2061: syntax error:
    identifier '__attribute__'

MSVC allows alias function names to be exported, but the mechanism is
different than the one used by gcc. It was considered to enhance the logic
in the existing version.map files but that file is also passed to other
tools on Linux, making this challenging. A simpler approach is to have an
optional version.map file to be used only when Microsoft's linker is to be
used. This optional map file is only necessary for libraries that have
versioned code.

v3:
- updated check-symbol-maps.sh to also handle ms_linker.map files.

v2:
- updated versioning macros so that the latest mbuf/net code can compile
  with MSVC. V1 did not have these changes because by the time that series
  was sent out the versioning problem had not surfaced yet.
- for testing purposes, dpdk-test was build with msvc and crc_autotest
  was run successfully. This test is known to call the versioned function
  which raised the issue.

Andre Muezerie (6):
  doc: update guide on versioning macros
  buildtools: update map_to_win.py to use optional map file
  eal: update versioning macros
  devtools: check ms linker map files
  net: update use of versioning macros
  mbuf: enable to be compiled with MSVC

 buildtools/map_to_win.py                   | 16 ++++++-
 devtools/check-symbol-maps.sh              | 49 ++++++++++++++++++----
 doc/guides/contributing/abi_versioning.rst |  6 +++
 lib/eal/include/rte_function_versioning.h  | 19 +++++++++
 lib/mbuf/meson.build                       |  6 ---
 lib/net/rte_net_crc.c                      |  2 +
 lib/net/version_ms_linker.map              | 23 ++++++++++
 7 files changed, 106 insertions(+), 15 deletions(-)
 create mode 100644 lib/net/version_ms_linker.map

--
2.48.1.vfs.0.0

