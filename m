Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E2DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:26:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 867F540E2C;
	Wed, 23 Jul 2025 16:26:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B8F9F40B98
 for <dev@dpdk.org>; Wed, 23 Jul 2025 14:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753275432; x=1784811432;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZRHTpNHCIr045YO0dtoZGlwk4Zpy1E5zRkl2oRWOjDU=;
 b=GN+bgosVuUOjAdEaE9F+rtRn0xtbJDwUFSBV1ZbIAkW0hn0pc+AtNXRA
 wBQ55Vfv+mR4/0DIddcVKVrgpRHUl8hQYEqjxn4CCMu1FbPVf5I6+tvuS
 uGe98RO5yqK91QnEBc4fpbF/idFcDK6HRweVKVrNGG+3Uqk0g0zJRkFxq
 m+/qdNC9BAW2+VgRCufSP96Msbr2nwdQtyMjoRxDe6OhWSJyyzGy3yUs0
 wOuKfmZKIYiQf8gZhGoD7VTmGH9rscMNVcVNUE5flaD2YvJnhSH/hqAQk
 6heY3Byjzl0xwFgOwcv/GVAwI1hOU9SR65aRdlHFXAh3PATpaxWsei7d/ w==;
X-CSE-ConnectionGUID: quv9vGkHRBmd7uVrnD7y+w==
X-CSE-MsgGUID: kXvG95xVTpyO4FIHK/eZdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55701949"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="55701949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 05:57:10 -0700
X-CSE-ConnectionGUID: JsReudvVR5GrmjtzUcd5eQ==
X-CSE-MsgGUID: x1rjvgHjTky+sEzVeX/+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="190501404"
Received: from txandevlnx322.an.intel.com ([10.123.117.44])
 by fmviesa001.fm.intel.com with ESMTP; 23 Jul 2025 05:57:06 -0700
From: Ashok Kaladi <ashok.k.kaladi@intel.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH] net/tap: fix BPF build failure in cross-compilation
 environment
Date: Wed, 23 Jul 2025 07:57:02 -0500
Message-Id: <20250723125702.3787183-1-ashok.k.kaladi@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Jul 2025 16:26:49 +0200
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

During cross-compilation, BPF build incorrectly includes header files
from the host system instead of the target sysroot. This leads to
build failures due to incompatible headers or unavailability of header
files in the host.

Fix by using the Meson sysroot property to correctly locate and include
BPF-related headers from the cross-compilation environment.

Fixes: d8d065045c4a ("net/tap: rewrite RSS BPF program")
Cc: stephen@networkplumber.org

Signed-off-by: Ashok Kaladi <ashok.k.kaladi@intel.com>
---
 drivers/net/tap/bpf/meson.build | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tap/bpf/meson.build b/drivers/net/tap/bpf/meson.build
index 35d7438c74..1b87d5018e 100644
--- a/drivers/net/tap/bpf/meson.build
+++ b/drivers/net/tap/bpf/meson.build
@@ -39,13 +39,14 @@ endif
 
 enable_tap_rss = true
 
-libbpf_include_dir = libbpf.get_variable(pkgconfig : 'includedir')
+# Determine sysroot if cross-compiling and the property exists in the
+# init files. Note that this environment variable will have to be passed
+# in as a property during meson setup.
+sysroot = meson.get_external_property('sysroot', '')
+libbpf_include_dir = sysroot + libbpf.get_variable(pkgconfig : 'includedir')
 
-# The include files <linux/bpf.h> and others include <asm/types.h>
-# but <asm/types.h> is not defined for multi-lib environment target.
-# Workaround by using include directoriy from the host build environment.
 machine_name = run_command('uname', '-m', check: true).stdout().strip()
-march_include_dir = '/usr/include/' + machine_name + '-linux-gnu'
+march_include_dir = sysroot + '/usr/include/' + machine_name + '-linux-gnu'
 
 clang_flags = [
         # these are flags used to build the BPF code
-- 
2.43.0

