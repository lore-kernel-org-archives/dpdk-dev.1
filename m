Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD75C79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89A8A410FD;
	Wed,  9 Sep 2026 16:47:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CE8514067A;
 Wed,  9 Sep 2026 16:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788965235; x=1820501235;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=INTxR/IIL+WTNyEbNUv55zsj4z6luqIcIL+/eCKU+FE=;
 b=gUNhqltVUs1h2METrdt8thzvDSluhl2ZWAWdsQXv9BWZSfyoGuxlMcea
 thuiAHMeqihEjJY6KoN1m6CbpDTQj5neWTAR4cT4L08WO4j8u8byydvpA
 fv57eMnIzWX62WBYDcKOKHKeNaIeKKWFvbGc/TmnOhAGWbYdWbTohDIM+
 Obw8T4MVa6VkGIuJftW5W3MJFPIXXrYYRAoXPmgzQKDOliDCzhXD1WwvI
 JblxoqjZGk48ctDw/oj8qw+ZHeOagpMBA+oPIVu/bGhQ204lyJRmZ8pxW
 JIzJ2ADffMZ8RRrTgDf+M02st4ODVM5WlYj/F3JAQG+D3jU8OgaL9Wp4a Q==;
X-CSE-ConnectionGUID: LZykwlkmRIyYQ6u07dhA0A==
X-CSE-MsgGUID: QNEuYgbcSP21ME83Lvn0Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89518788"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89518788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 07:47:13 -0700
X-CSE-ConnectionGUID: pkF+QEFeTNuJh9o3Lw4zYQ==
X-CSE-MsgGUID: I+dgLr3oSA6FT9dZsXV9+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267051340"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Sep 2026 07:47:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] usertools/telemetry-watcher: fix hang on startup
Date: Wed,  9 Sep 2026 15:46:31 +0100
Message-ID: <20260909144631.1122673-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Commit cbfdffb1083d ("usertools/telemetry: load aliases from config
directory") added an extra printed output line to startup of the
dpdk-telemetry script when an alias file was loaded. This confuses the
wrapper script dpdk-telemetry-watcher, causing it to hang on startup.
Only print out the message when script is run interactively.

Fixes: cbfdffb1083d ("usertools/telemetry: load aliases from config directory")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
index e575f269cb..b4dd789143 100755
--- a/usertools/dpdk-telemetry.py
+++ b/usertools/dpdk-telemetry.py
@@ -98,7 +98,9 @@ def load_aliases(alias_path=None):
     except OSError as e:
         print("Warning: failed to read {}: {}".format(alias_path, e), file=sys.stderr)
 
-    print("Loaded {} aliases from {}".format(len(aliases), alias_path))
+    # only print this informational message in interactive mode
+    if os.isatty(sys.stdin.fileno()):
+        print("Loaded {} aliases from {}".format(len(aliases), alias_path))
     return aliases
 
 
-- 
2.53.0

