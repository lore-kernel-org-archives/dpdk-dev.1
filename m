Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130FC83F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 05:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CAA4026D;
	Fri, 25 Jul 2025 07:43:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E7D34025A
 for <dev@dpdk.org>; Fri, 25 Jul 2025 07:43:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753422189; x=1784958189;
 h=from:to:cc:subject:date:message-id:reply-to:mime-version:
 content-transfer-encoding;
 bh=2svaJMSEZPqNEp2GsfEU+zzgOHJSSWSGxcahw00+PdM=;
 b=hX81Gd0R+8ulo6ni+lLrh/NUp+gJvwXBzWSd6rtEk1psjDhHB04Xt5Au
 5vBxLniB9vCQn7451DGibBeifg5aOQPNGHBivkjjBsUX5/iToiBEunkm2
 hWf+9ukpi3a3l3Ya8pB7QC8wY9Ezaa8XBpSpJFpw6U7YpwIMEYJV4SxGb
 zRNhZvWIr9Cg8UhFtJDEhnq0DGujjL6Hb04xQ1h+DAXd4Qcg+A3Ftw1QP
 DGITE3Uvs6w+MQMMUWt9Le8Ktgo9OdSnDu6I31TNhObZCAKFVM+5xklwV
 ml8YmA9WztbP3TYkz1KysJU+Z0Ia7DMr/f03TwGEv7B8FSAXguGW017Lq g==;
X-CSE-ConnectionGUID: LmLlaAavTyqyzabeHMetWw==
X-CSE-MsgGUID: 8fU60b9sRKy8Wg7f3NgCiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59406074"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; d="scan'208";a="59406074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2025 22:43:08 -0700
X-CSE-ConnectionGUID: 6e8Rz4dmS/KA6+1F5BEmRg==
X-CSE-MsgGUID: MtOSET5jRlecY70EWfyKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; d="scan'208";a="166129190"
Received: from txandevlnx322.an.intel.com ([10.123.117.44])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2025 22:43:08 -0700
From: Ashok Kaladi <ashok.k.kaladi@intel.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v2] net/tap: fix BPF build failure in cross-compilation
 environment
Date: Fri, 25 Jul 2025 00:42:58 -0500
Message-Id: <20250725054258.48135-1-ashok.k.kaladi@intel.com>
X-Mailer: git-send-email 2.39.1
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
Reply-To: 20250723125702.3787183-1-ashok.k.kaladi@intel.com
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

