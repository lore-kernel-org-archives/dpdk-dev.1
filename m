Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DC606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fMCzH2aM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F82640DD8;
	Tue, 10 Nov 2026 22:02:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 9133840296
 for <dev@dpdk.org>; Tue, 10 Nov 2026 22:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794344522; x=1825880522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p8YJCfBh9dhATRtnFoiPxkEe9711oyAzrf5HrqTJtpI=;
 b=fMCzH2aMhTF3iOhz6LGc3jfCmgMkw77TaqF0Ihz1Skus2qvMsq1WVZba
 4sDlX8iPGb9zmXdcHiITlw08QdyxKJFO0Az3cgaa0mV+bi6j7J//2gLEc
 9jPjatOcg65VJJHQ6zOmAR8y42dXZ7wAsAQyQMxqZV+LyNNa+7YDcCnql
 VQz2JdViZzTMGAoq8tlCZpnTRT2Csztr8DX3i11MvY0Fmy7GHqKYYax1p
 r42CqJgk/o1Q6tChgqNKjUO7/qrLK/1jOcMRLx4QMdZ0AtFKgOVCuCSyj
 sIJs/vqolXOzA7dlC1B+y0DDiwdLFYaMrOS6DJNN01j/FLcI5I9C1CT+k A==;
X-CSE-ConnectionGUID: KgNYesz+SPCF28cIe5fJLA==
X-CSE-MsgGUID: +4W/JNXaSWG5ZaN0PAXFPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3141135"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3141135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 13:01:50 -0800
X-CSE-ConnectionGUID: QecQlrxPS/mbKpykrwW8pw==
X-CSE-MsgGUID: FpAMaBUMRduZjnNCQ3VYZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8405990"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 13:01:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] Support Linux format PCI addresses on BSD
Date: Tue, 10 Nov 2026 21:01:39 +0000
Message-ID: <20261110210142.1734222-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151524.3990486-1-bruce.richardson@intel.com>
References: <20261104151524.3990486-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DPDK EAL parameters for specifying PCI devices use the linux format,
even when on FreeBSD, and Linux format is the standard throughout our
docs, so make some updates to allow BSD tools to also support that
format for consistency.

Specifically:
* Have the PCI address output from dpdk-devbind script use Linux format
  on both Linux and BSD
* Allow the FreeBSD kernel module, nic_uio, accept parameters in either
  BSD or Linux format.

After these changes, the Linux format ([DDDD:]BB:DD.F, all hex), can be
used across the board in BSD, while still allowing BSD format
([pciD]:B:D:F, all decimal), for compatibility as before.

V2:
* Reworked following AI review of V1.
  - cleaned up patch 2 with typecasts to calls to isxdigit() etc.
  - kept compatible handling of invalid BDFs by skipping them
  - supported trailing commas on BDFs

Bruce Richardson (3):
  usertools/dpdk-devbind: align BSD output format with Linux
  kernel/nic_uio: support Linux format PCI addresses
  app/test: add unit tests for nic_uio BDF parsing fns

 app/test/meson.build                  |   1 +
 app/test/test_kmod_pci_bdf.c          | 187 ++++++++++++++++++++++++++
 doc/guides/freebsd_gsg/build_dpdk.rst |   9 ++
 doc/guides/tools/devbind.rst          |   4 +
 kernel/freebsd/nic_uio/meson.build    |   2 +-
 kernel/freebsd/nic_uio/nic_uio.c      |  85 +++++-------
 kernel/freebsd/nic_uio/pci_bdf.h      | 157 +++++++++++++++++++++
 usertools/dpdk-devbind.py             |   5 +-
 8 files changed, 397 insertions(+), 53 deletions(-)
 create mode 100644 app/test/test_kmod_pci_bdf.c
 create mode 100644 kernel/freebsd/nic_uio/pci_bdf.h

--
2.55.0

