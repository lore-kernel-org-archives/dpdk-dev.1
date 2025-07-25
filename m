Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE9C83F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 06:43:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32047402A8;
	Fri, 25 Jul 2025 08:43:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE654025A
 for <dev@dpdk.org>; Fri, 25 Jul 2025 08:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753425808; x=1784961808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2svaJMSEZPqNEp2GsfEU+zzgOHJSSWSGxcahw00+PdM=;
 b=Kn/nPWv54RZSpcWxXYkqZSQxRlmpKObT0YmR8WU3mbKs2UduA/wJMXJ5
 1MJQmsZWXQ8S0q+LUlcNjRwpXwVXSDxrC1o5Fn9/ettbkERfZA50mMsaZ
 60+d1K/qaKmsz30+UvAlwE1yamvhtZdIkBFrZ8FAnWZgqjku9aB7IPUZW
 RHEnAABQc+/eU4oV/yCU2vXtCLQEXkCQJxcjR8AMoJgjyaJ3O7HU4BnmM
 lCobzIzer/Hqlcndfl2x1mRXqXRpqBKS5sKmFLlnSbVG8/GglHL7gl4Fs
 czcrzKIAnP9TMQNqrRzlc7wRs3eqlSoQvD1jmH5fNC7CUc+q3SQPfRd1M A==;
X-CSE-ConnectionGUID: 7cDU36rETkuV2CKyH1pXTg==
X-CSE-MsgGUID: 92ljFQaATFuhfpRyzs8aSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55904276"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; d="scan'208";a="55904276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2025 23:43:27 -0700
X-CSE-ConnectionGUID: oUOu93Q3SeKSBPWGHTCXfw==
X-CSE-MsgGUID: aLD1zy2EQmeOJDzZ/aO5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; d="scan'208";a="197870323"
Received: from txandevlnx322.an.intel.com ([10.123.117.44])
 by orviesa001.jf.intel.com with ESMTP; 24 Jul 2025 23:43:26 -0700
From: Ashok Kaladi <ashok.k.kaladi@intel.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v2] net/tap: fix BPF build failure in cross-compilation
 environment
Date: Fri, 25 Jul 2025 01:43:19 -0500
Message-Id: <20250725064319.80112-1-ashok.k.kaladi@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250723125702.3787183-1-ashok.k.kaladi@intel.com>
References: <20250723125702.3787183-1-ashok.k.kaladi@intel.com>
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

During cross-compilation, BPF build incorrectly includes header files
from the host system instead of the target sysroot. This leads to
build failures due to incompatible headers or unavailability of header
files in the host.

Fix by using the Meson sysroot property to correctly locate and include
BPF-related headers from the cross-compilation environment.

Fixes: d8d065045c4a ("net/tap: rewrite RSS BPF program")

Signed-off-by: Ashok Kaladi <ashok.k.kaladi@intel.com>
---
v2: restored the comment about uname command

 drivers/net/tap/bpf/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/bpf/meson.build b/drivers/net/tap/bpf/meson.build
index 35d7438c74..38b74f044c 100644
--- a/drivers/net/tap/bpf/meson.build
+++ b/drivers/net/tap/bpf/meson.build
@@ -39,13 +39,17 @@ endif
 
 enable_tap_rss = true
 
-libbpf_include_dir = libbpf.get_variable(pkgconfig : 'includedir')
+# Determine sysroot if cross-compiling and the property exists in the
+# init files. Note that this environment variable will have to be passed
+# in as a property during meson setup.
+sysroot = meson.get_external_property('sysroot', '')
+libbpf_include_dir = sysroot + libbpf.get_variable(pkgconfig : 'includedir')
 
 # The include files <linux/bpf.h> and others include <asm/types.h>
 # but <asm/types.h> is not defined for multi-lib environment target.
 # Workaround by using include directoriy from the host build environment.
 machine_name = run_command('uname', '-m', check: true).stdout().strip()
-march_include_dir = '/usr/include/' + machine_name + '-linux-gnu'
+march_include_dir = sysroot + '/usr/include/' + machine_name + '-linux-gnu'
 
 clang_flags = [
         # these are flags used to build the BPF code
-- 
2.39.1

