Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658FCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78920402C4;
	Fri,  3 Oct 2025 10:15:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 71B84402AF
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479317; x=1791015317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EguIG9jlDorKPfkC4V78Od8t9bHszydRbAczBVDY/bc=;
 b=Lpp/OSqawdKWYEBAxFmbtdbdG37D+4CgKwV1X557djcbS2GusqlkDt3H
 GECVwK3u8hszg6aZF01dolCUTY3+oXdkiNSHNAzPOzK0BhPiOZRfnIz1j
 0pIZxkp/XXGaWYp8IISFNBJNGlqps5B6hj62WoSsDtnt5QVoi7D5Q3OJD
 KgaiRpJ03+j4GdFRxZtUshXIeJ8SZfHSfG3tY1eYYUVEoRcz/j33pIj52
 Y42CCTOUJgPgZXhPSdje22XZ3nHqBejXORBr3VTQThcS72l9FLO9EIFf9
 Qvx5VoMMbNXSvxssIZAaI6TA/u18SjscSGnb30/qxQ86W79x13wPOab67 w==;
X-CSE-ConnectionGUID: DsJh7JsXST6xYFeIsCQirQ==
X-CSE-MsgGUID: 7BYEP69gQmCWoJFI0JaWYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473544"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:16 -0700
X-CSE-ConnectionGUID: +FXNts/uRKeQU+red6d2BA==
X-CSE-MsgGUID: 5ZVklve0TbqpJsJyTurGnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525813"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 03/18] argparse: allow user-override of help printing
Date: Fri,  3 Oct 2025 09:14:55 +0100
Message-ID: <20251003081510.1197166-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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
index c3b94e1896..f73bab1227 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -76,6 +76,13 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
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
index f0c2c33178..2b5da5f1db 100644
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

