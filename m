Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9A19410DD;
	Wed, 23 Jul 2025 18:21:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E33BB410D0
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753287662; x=1784823662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qmIwwyngdgM7EJTS9yk3dte8rJWJDhWz+ct33eOIiS8=;
 b=A/Qf75smNRwaQ2XG7pOmUR3rYMHjp0yNvQHWSS9XidL2lQts8gGofI9U
 TRq/0j7HXiMJ/yWCjPiXplygPJGe9/VgwZLesdED4c3DjdMVKuIDb7Qir
 EkgCFI/+GA0yi5qGrcaQvoSRvfAGLOt3E9l5uWB+2xjv3FO31xo3ZHqFt
 NOpyexN3h84VRTLphhjVSCH9Zy+0kldlX/vy+MMgCZWAx3V4VR6GMK8LF
 gOBELcJrTYQfTNHwb4VUL04lZDg5y9xSPI1eat462mu0Slxin9Q3eDljh
 4Y1JC2N7ik/FZW7arhijtYDhwDB19F26Rt2yb0XIqIT4V3S6ST8FyFYFs w==;
X-CSE-ConnectionGUID: 0B1Q7rmBSyeoYwOZvQ/nGw==
X-CSE-MsgGUID: n7LSsDQySQ2We8kO6+ntIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43197971"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43197971"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 09:21:02 -0700
X-CSE-ConnectionGUID: oSjPmjfYQi+H3gTcIrI4EQ==
X-CSE-MsgGUID: BrLX9BlaQ7GQA7EUy/hnsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160148910"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 09:21:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v7 03/13] argparse: allow user-override of help printing
Date: Wed, 23 Jul 2025 17:20:01 +0100
Message-ID: <20250723162013.2392-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723162013.2392-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
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
 doc/guides/rel_notes/release_25_11.rst |  7 +++++++
 lib/argparse/rte_argparse.c            |  5 ++++-
 lib/argparse/rte_argparse.h            |  7 ++++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

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
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..75bbd0e821 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Allow overriding the automatic usage/help generation in argparse library.**
+
+  The argparse library now supports overriding the automatic help text generation,
+  by allowing the user to provide a custom function to generate the output text.
+  The built-in help text function is available as a public function which can be reused by custom functions,
+  if so desired.
+
 
 Removed Items
 -------------
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

