Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F397C8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 11:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F67240287;
	Mon,  7 Jul 2025 13:18:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9299F4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751887082; x=1783423082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WjtAqYgvg+zsnOjis+waPj6Zjdf4GzImUzdRFMv9FAw=;
 b=MKOkYX0jwqnWv3OXTBVrAUHJhzIpgeBzgM/q9F7EjrsVFOF4uZoHQMjm
 C8Tbs/h+F2wyPUHk+HVwaRDSyrqAeqeHTXWc/uN08282Fcpz5qV32GmNy
 yqyKbIhasPczjZmN+Qv8awFjb7W0ovNoiRpcO303dTMIIuS5QMn+Qv6SZ
 F01MyZIt20jdPoQZ58NIFb05gV6/0MVYe3Z2ajUiRXUE7vBW3+U12/ddL
 6rDmTujBXCJfETCdbap4/QC0cEN+wcfC/hheUXu+psTY58gLseac9QqwR
 2m1FO9OqBEJY0VBLMWuqWDars3WflfixFqwW6fli0AqGiw5P6RGcSIILk Q==;
X-CSE-ConnectionGUID: hwopfhUHQk+BsvjIm7olxQ==
X-CSE-MsgGUID: zRPjI2ATT3if2Azkv/DfjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54228330"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="54228330"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 04:18:00 -0700
X-CSE-ConnectionGUID: u8wR2nqgS1qXcx2YJMk+XA==
X-CSE-MsgGUID: rZvBI2dxSX66fk5a5C3eVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="155670910"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 07 Jul 2025 04:17:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/3] improve cmdline file handling in testpmd
Date: Mon,  7 Jul 2025 12:17:48 +0100
Message-ID: <20250707111751.183469-1-bruce.richardson@intel.com>
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

V3:
* Fix windows support, no libgen or basename, no asprintf...

V2:
* remove global echo flag, and now support echo/noecho per file loaded
* when echoing, output the file being processed, to clarify things when
  loading multiple files.

Bruce Richardson (3):
  app/testpmd: explicitly set command echoing on file load
  app/testpmd: allow multiple commandline file parameters
  app/testpmd: improve output when processing cmdline files

 app/test-pmd/cmdline.c                      | 100 ++++++++++++++++++--
 app/test-pmd/parameters.c                   |  17 ++--
 app/test-pmd/testpmd.c                      |  13 ++-
 app/test-pmd/testpmd.h                      |  15 ++-
 doc/guides/testpmd_app_ug/run_app.rst       |   3 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  12 +--
 6 files changed, 132 insertions(+), 28 deletions(-)

--
2.48.1

