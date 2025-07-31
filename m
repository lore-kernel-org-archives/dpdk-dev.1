Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E2C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 16:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD67402C3;
	Thu, 31 Jul 2025 18:01:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 037B9402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 18:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753977677; x=1785513677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H0p0kk53aSB781gZAt0EZxPtwV4qKjgETI8UapJVyPc=;
 b=K6HaYACXp2C9CUzwss3INCjpFS14LkWf4SjowG1b1Rpnm53SaHQGJnYY
 gCPrN9J1GAVIQxIGSLAU11WSuysE9XdT9LQEBj3xpks/ZJQBTvB68TkWl
 EPujJIPE6YzixmI7oC4lOAUS0O4Ngle3r2UNK3+2wZdYr/VsTYxzi7Z8u
 PmjIc2ViLJBj3Gm8Kxh8n/QHeccNw6QXmygAj+Lyu5AsLmA/o+GeTiIxR
 L53IlLfuSjzuizl9NMPT18SmnIPX+MyFK1GEA/iRLXq14vehXG/CBVuiv
 XevYacvJReSj3dh/ix4b4oBcCtt/Ab53nQW+hpFSWz72Z5oAd4kyaG1+P g==;
X-CSE-ConnectionGUID: K/rEA0swRlaByx6c3qUxSA==
X-CSE-MsgGUID: z5kc0dAkTwyYPRUTDHtzFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78857887"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="78857887"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 09:00:52 -0700
X-CSE-ConnectionGUID: ryRMwbUwRDG2TUpmO+NYXg==
X-CSE-MsgGUID: F2ZKnetDTwSOiuDkDrtzKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="167543336"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa005.fm.intel.com with ESMTP; 31 Jul 2025 09:00:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, andremue@linux.microsoft.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/4] improve cmdline file handling in testpmd
Date: Thu, 31 Jul 2025 16:00:37 +0000
Message-ID: <20250731160041.914837-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250704140551.4151993-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some small improvements to cmdline file handling testpmd, inspired by the
desire to have support for multiple cmdline files passed on the commandline
of a testpmd run.

The implementation is somewhat complicated by the setting for echo/noecho
of the commands, because the current implementation uses a global flag for
that - shared between cmdline parameters and interactive CLI commands.

The final complication/addition, is the need for a common basename function
across our supported OS's. This is provided by the rte_basename function in
patch 1.

V4:
* remove ifdefs in testpmd code, by providing common rte_basename fn

V3:
* Fix windows support, no libgen or basename, no asprintf...

V2:
* remove global echo flag, and now support echo/noecho per file loaded
* when echoing, output the file being processed, to clarify things when
  loading multiple files.


Bruce Richardson (4):
  eal: add basename function for common path manipulation
  app/testpmd: explicitly set command echoing on file load
  app/testpmd: allow multiple commandline file parameters
  app/testpmd: improve output when processing cmdline files

 app/test-pmd/cmdline.c                      |  69 ++++++++++--
 app/test-pmd/parameters.c                   |  17 +--
 app/test-pmd/testpmd.c                      |  13 ++-
 app/test-pmd/testpmd.h                      |  15 ++-
 app/test/test_string_fns.c                  | 111 ++++++++++++++++++++
 doc/guides/testpmd_app_ug/run_app.rst       |   3 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  12 +--
 lib/eal/include/rte_string_fns.h            |  32 ++++++
 lib/eal/unix/meson.build                    |   1 +
 lib/eal/unix/rte_basename.c                 |  37 +++++++
 lib/eal/windows/meson.build                 |   1 +
 lib/eal/windows/rte_basename.c              |  53 ++++++++++
 12 files changed, 336 insertions(+), 28 deletions(-)
 create mode 100644 lib/eal/unix/rte_basename.c
 create mode 100644 lib/eal/windows/rte_basename.c

-- 
2.48.1

