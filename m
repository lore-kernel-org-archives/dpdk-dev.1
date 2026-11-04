Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE6606A33A
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZXw2lQWm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B665440299;
	Wed,  4 Nov 2026 16:15:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id A60C140616
 for <dev@dpdk.org>; Wed,  4 Nov 2026 16:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793805334; x=1825341334;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=99PYOiAUPgiQe6NDWv4MO79Oy6lxWFyL9iylJk8O5MA=;
 b=ZXw2lQWmPlGXGfQc2Z5CmYq6Jayii5My89tKDMGYAWKwB7djs3vk2oV0
 FKXp94CVBLMTDtbe9m5wmq6GK7k8Bxl+oqrbv2pDSxf4N+j/EeSNxtWyk
 sNh9JXT9ZwCYORFhNlE2VqHRWZK+IXWLipxF6COGYaZoFG1yK1BxDcqDz
 PWeUboaijtVGhk0mJMfcsUJkJA1zW1v4k4whdtf1T4CKdp7pUYvwsorzg
 vqQ0rdnM20UHBC87Un4HXnvcVmLsx8/RivdIQbOkW97yk0fkA836zTwr3
 WlyoAS1OrdX7TxwHMFBc0YjKLS5ed7fB9RVUalLByo2LEaO+GjpoWhJiZ A==;
X-CSE-ConnectionGUID: raO39+pwSjKzsPvJjV/lqA==
X-CSE-MsgGUID: RN2/aZTaS4+v8GgwTRX9mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2437301"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2437301"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:15:30 -0800
X-CSE-ConnectionGUID: obI7S3tDTdSFO1LH/MGACg==
X-CSE-MsgGUID: oOG5kwCyQweLdA7YvSWxkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7093754"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2026 07:15:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] Support Linux format PCI addresses on BSD
Date: Wed,  4 Nov 2026 15:15:21 +0000
Message-ID: <20261104151524.3990486-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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

Bruce Richardson (3):
  usertools/dpdk-devbind: align BSD output format with Linux
  kernel/nic_uio: support Linux format PCI addresses
  app/test: add unit tests for nic_uio BDF parsing fns

 app/test/meson.build                  |   1 +
 app/test/test_kmod_pci_bdf.c          | 142 ++++++++++++++++++++++++++
 doc/guides/freebsd_gsg/build_dpdk.rst |   8 ++
 doc/guides/tools/devbind.rst          |   4 +
 kernel/freebsd/nic_uio/meson.build    |   2 +-
 kernel/freebsd/nic_uio/nic_uio.c      |  93 +++++++----------
 kernel/freebsd/nic_uio/pci_bdf.h      | 129 +++++++++++++++++++++++
 usertools/dpdk-devbind.py             |   5 +-
 8 files changed, 323 insertions(+), 61 deletions(-)
 create mode 100644 app/test/test_kmod_pci_bdf.c
 create mode 100644 kernel/freebsd/nic_uio/pci_bdf.h

--
2.55.0

