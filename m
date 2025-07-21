Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96C2C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:09:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B2EE40678;
	Mon, 21 Jul 2025 17:09:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B459040677
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753110552; x=1784646552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sMS2yrnn5nhX+7yItg+n+u5485BjKsOTVWAWw3P8zFM=;
 b=A+gyC6o90T518dmKb07CA6qkkzXISA1ZDxVRz1zIdBmmA3HP/k6aO7KR
 Lyn227yu23Pe5GmiPlrrlDo4uYesp90TcC/1lh3Yuh/fnA12JMJcEVFA9
 bUuzl2+t9rnHJQVx1GIc4KjwqZjXFd6ALtDnDXaLVTdWgiKJQwN9yFV2+
 y5VeJ1l1sj7YnPzzsZB0B3fbs9AQ1+LXIsLgQwkQygJeOoI3yVu410X3+
 g4oUHgVYFnzz7FMwsRDUyId7kjEuddypWmG3yTvVCZEeq7WRXdO58/Bjn
 C6/gBuV0AZqs9CrH4gy5sgiH3jaqiWxxuKNlJZNOQJfzh1I8YwUgagDVO Q==;
X-CSE-ConnectionGUID: BbB4G0r3SVi1RhklUTJU8g==
X-CSE-MsgGUID: Yk+MXhxAQ7KbehZccyqfxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55179769"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="55179769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:09:11 -0700
X-CSE-ConnectionGUID: TCVJ1TDRQM+EJKYBAEFjpA==
X-CSE-MsgGUID: 6BeXD44BSny9/tCeFRxRrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="159291163"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 21 Jul 2025 08:09:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 3/9] argparse: allow user-override of help printing
Date: Mon, 21 Jul 2025 16:08:36 +0100
Message-ID: <20250721150843.2737763-5-bruce.richardson@intel.com>
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

