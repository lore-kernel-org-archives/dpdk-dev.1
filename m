Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34324C83F34
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 14:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 610A9402DC;
	Fri, 18 Jul 2025 16:34:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1D7174014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 16:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752849244; x=1784385244;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qq2OQXwPQ3U+U6s5/IHP/AxjHECMdxWvZeGlGmIi514=;
 b=kq+RYC7/r3O5Ep0IIm/JdFWdXsXJm5A2CGNeZpuP3uCXISsAp1JHPmlr
 IGaXvvG/9VWNgPfnV1fwVT+5j3WF4GL44PGsZxkwSxv3EdxCuHAPgv4xU
 aoigtFEniEIGMp5kL2w8Pf/XBjWMDhj9s/lTvoZE42OOXr87MX5RegB5X
 ZJA3GhhwJFCoUwGVa6KsKdMRkAoLtqDjiXBfoj0ayAzfs/6dL1Z+CAzoM
 JLQOl7vCCaTLXxf8RwW5m1S5Vvdw7TfkkdlmxVPmW4ZiJgoiUW0HkW4zT
 PEdYJqekZAW0STAbJgR62CwMf/gD5eF49MQZBY134b1hplih7BvDnLZ1+ Q==;
X-CSE-ConnectionGUID: uP13X48BSf2uG3A/e5czBQ==
X-CSE-MsgGUID: nDkiepw9Twy+34kdrj5j6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72597068"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72597068"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 07:34:03 -0700
X-CSE-ConnectionGUID: CVGNNmALRhuyEKCn1sJyEw==
X-CSE-MsgGUID: RSNm1ilJTUihGd5QzKAMqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="162389289"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2025 07:34:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/9] rework EAL argument parsing
Date: Fri, 18 Jul 2025 15:33:46 +0100
Message-ID: <20250718143356.1578988-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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

When processing cmdline arguments in DPDK, we always do so with very
little context. So, for example, when processing the "-l" flag, we have
no idea whether there will be later a --proc-type=secondary flag. We
have all sorts of post-arg-processing checks in place to try and catch
these scenarios.

To improve this situation, this patchset tries to simplify the handling
of argument processing, by explicitly doing an initial pass to collate
all arguments into a structure. Thereafter, the actual arg parsing is
done in a fixed order, meaning that e.g. when processing the
--main-lcore flag, we have already processed the service core flags. We
also can far quicker and easier check for conflicting options, since
they can all be checked for NULL/non-NULL in the arg structure
immediately after the struct has been populated.

To do the initial argument gathering, this RFC uses the existing
argparse library in DPDK. With recent changes, and two additional
patches at the start of this set, this library now meets our needs for
EAL argument parsing and allows us to not need to do direct getopt
argument processing inside EAL at all.

An additional benefit of this work, is that the argument parsing for EAL
is much more centralised into common options. This single list with
ifdefs makes it clear to the viewer what options are common across OS's,
vs what are unix-only or linux-only.


Bruce Richardson (9):
  build: add define for the OS environment name
  argparse: export function to print help text for object
  argparse: allow user-override of help printing
  eal: add long options for each short option
  eal: define the EAL parameters in argparse format
  eal: gather EAL args before processing
  eal: ensure proper cleanup on EAL init failure
  eal: combine parameter validation checks
  eal: simplify handling of conflicting cmdline options

 config/meson.build                        |    1 +
 doc/guides/contributing/design.rst        |    2 +-
 doc/guides/linux_gsg/eal_args.include.rst |   20 +-
 doc/guides/prog_guide/argparse_lib.rst    |   16 +
 lib/argparse/rte_argparse.c               |   46 +-
 lib/argparse/rte_argparse.h               |   21 +-
 lib/eal/common/eal_common_memory.c        |    3 +-
 lib/eal/common/eal_common_options.c       | 1299 +++++++++++----------
 lib/eal/common/eal_options.h              |  102 +-
 lib/eal/common/eal_private.h              |   11 +
 lib/eal/freebsd/eal.c                     |  245 +---
 lib/eal/linux/eal.c                       |  470 +-------
 lib/eal/linux/eal_memory.c                |    2 +-
 lib/eal/meson.build                       |    2 +-
 lib/eal/windows/eal.c                     |  156 +--
 lib/meson.build                           |    1 +
 16 files changed, 954 insertions(+), 1443 deletions(-)

--
2.48.1

