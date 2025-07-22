Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F4C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B4F94067A;
	Tue, 22 Jul 2025 16:04:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 819FD4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 16:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753193070; x=1784729070;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sMS2yrnn5nhX+7yItg+n+u5485BjKsOTVWAWw3P8zFM=;
 b=LKrOJKwHSznMbDZk6mBM0PiUn5L0vS6HbwzIwmZHyPcaFZn47onU9Dv/
 x6ghODO68ipUkYpDoJOxCJPihOQNYvgFoLwjoSBB9aSSC2MQ/3vbFC9/j
 HfGfHeKxF9QinbFpAoZZZvUQ4nUntk6nykYyoRWrJmOWUvq1fxtBrlniB
 9IsmMRL8HPb3j0blDxAQiGc9Z1EqOigHDTCAxjjnJXdkR6EWTZVNhiR+v
 4TM/j5wE/Scsj6bpMUIttgPwahnlFtrwaWDflCX56UG3LiBrQDUewBCjg
 kxCspXp8lVF8hrnUDP1TjBSamJ1849FjnJRxK+Yb4ZEPn3Op5/H9AvhaB g==;
X-CSE-ConnectionGUID: mhIvSgZYRjCQacE3dZgJaw==
X-CSE-MsgGUID: X4UccOKXQyaD8MuDGqoDzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59241946"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="59241946"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 07:04:02 -0700
X-CSE-ConnectionGUID: /e/BlxC1ScOKLbuXgIGfFg==
X-CSE-MsgGUID: Oyqa3TflRB6tx7HLi3NScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="190104393"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa001.fm.intel.com with ESMTP; 22 Jul 2025 07:03:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 3/9] argparse: allow user-override of help printing
Date: Tue, 22 Jul 2025 15:03:08 +0100
Message-ID: <20250722140316.3568603-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250722140316.3568603-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250722140316.3568603-1-bruce.richardson@intel.com>
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

When the arguments passed to argparse include -h/--help then usage
information is automatically printed. Provide the capability for the
user to supply their own help function for this.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/prog_guide/argparse_lib.rst | 16 ++++++++++++++++
 lib/argparse/rte_argparse.c            |  5 ++++-
 lib/argparse/rte_argparse.h            |  7 ++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index 9f11714890..b309260d20 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -24,6 +24,8 @@ Features and Capabilities
   #. autosave: used for parsing known value types;
   #. callback: will invoke user callback to parse.
 
+- Supports automatic help and usage information.
+
 Usage Guide
 -----------
 
@@ -193,3 +195,17 @@ Then the user input could contain multiple ``--xyz`` arguments.
 
    The multiple times argument only support with optional argument
    and must be parsed by callback way.
+
+Help and Usage Information
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The argparse library supports automatic generation of help and usage information.
+When the input arguments include ``-h`` or ``--help``,
+it will print the usage information to standard output.
+If the default help output is not what is wanted,
+the user can provide a custom help printing function by setting the ``print_help`` field in the ``rte_argparse`` object.
+(If this field is set to NULL, the default help printing function will be used.)
+
+If the custom help printing function wants to use the text produced by the default help function,
+it can call the function ``rte_argparse_print_help()`` to get the help text printed to an output stream,
+for example: stdout or stderr.
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index d3b32c6357..e7b9bf573d 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -821,7 +821,10 @@ rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 		goto error;
 
 	if (show_help) {
-		rte_argparse_print_help(stdout, obj);
+		if (obj->print_help != NULL)
+			obj->print_help(obj);
+		else
+			rte_argparse_print_help(stdout, obj);
 		exit(0);
 	}
 
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index baf278f6b9..63b49ba220 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -160,8 +160,13 @@ struct rte_argparse {
 	rte_arg_parser_t callback;
 	/** Opaque which used to invoke callback. */
 	void *opaque;
+	/**
+	 * Function pointer for printing usage when -h is passed.
+	 * If this is NULL, default printing function will be used.
+	 */
+	void (*print_help)(const struct rte_argparse *obj);
 	/** Reserved field used for future extension. */
-	void *reserved[16];
+	void *reserved[15];
 	/** Arguments configuration. Must ended with ARGPARSE_ARG_END(). */
 	struct rte_argparse_arg args[];
 };
-- 
2.48.1

