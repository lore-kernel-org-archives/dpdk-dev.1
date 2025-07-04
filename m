Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B8C8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 18:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC03402AE;
	Fri,  4 Jul 2025 20:34:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1CF3F4028E
 for <dev@dpdk.org>; Fri,  4 Jul 2025 20:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751654083; x=1783190083;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CEfSibBRFysIS1cPuFG+3HbRkIN1cSU/peZJtPIHfYE=;
 b=hatOutIaZbORZdKOtmWYfoMxU6TeKudLBBoIjmRdSsVfslR8FEe+M0vN
 VhUYCxBzLHQ4k84SUqR3wUmZ4zE/iKVQhLGlwKQaIwxeg1FSrap9NUnLE
 T7Bqt2KrY3x/D7L3wF+61A0yYuOgp/Eraf9o0GI0+w/4AupQvcJehbxya
 7OobE6jTrZAfqv8dHhI3KB5qxuBk1sPv3g/9bBxPI5bNHoIOIQV1UiKBb
 YK1PuzlquMYUxT/zH1P+Aruu6S5Wca0JP2XiTQkCzXlbvPkSXuHcsJ9hf
 qHZ4pmXKj+HqwVVJrN8xrI2Ht4sIeE3TgO3kKBxmuBVkItGykPu2sBM3g A==;
X-CSE-ConnectionGUID: GvcTHcHkQ+OgwBgYgNLE8w==
X-CSE-MsgGUID: ioNEIqaUQGCKkbHVKAg8GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="41613065"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; d="scan'208";a="41613065"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 11:34:42 -0700
X-CSE-ConnectionGUID: DyCnbFI8R1WCeTXFKm6yVg==
X-CSE-MsgGUID: nW77kIdpTCqepihgkL41WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; d="scan'208";a="159042634"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa003.jf.intel.com with ESMTP; 04 Jul 2025 11:34:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] improve cmdline file handling in testpmd
Date: Fri,  4 Jul 2025 19:34:33 +0100
Message-ID: <20250704183437.25901-1-bruce.richardson@intel.com>
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

V2:
* remove global echo flag, and now support echo/noecho per file loaded
* when echoing, output the file being processed, to clarify things when
  loading multiple files.

Bruce Richardson (3):
  app/testpmd: explicitly set command echoing on file load
  app/testpmd: allow multiple commandline file parameters
  app/testpmd: improve output when processing cmdline files

 app/test-pmd/cmdline.c                      | 78 ++++++++++++++++++---
 app/test-pmd/parameters.c                   | 17 +++--
 app/test-pmd/testpmd.c                      | 13 ++--
 app/test-pmd/testpmd.h                      | 15 +++-
 doc/guides/testpmd_app_ug/run_app.rst       |  3 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 12 ++--
 6 files changed, 110 insertions(+), 28 deletions(-)

--
2.48.1

