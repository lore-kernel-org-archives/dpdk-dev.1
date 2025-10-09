Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAFFCCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06164066F;
	Thu,  9 Oct 2025 15:01:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B9D394065E
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014873; x=1791550873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/HxFwF/qylJHh4tzWWnQPCN1LnPc60FCI4AnzzXb1Lw=;
 b=cxk5sZW79IjfkdITh8ryGfcKYJQ/QCGf4TLxvVSk2H4JdKTQrf9UPec6
 73FqHOEFWRyhpVD05d0U+wwJh+2T6RuWJz2Rg2C3PkCtvUDL+xq9DiUlB
 H84V0vsZWGp8IV6KzVpYLsjXIynQQaq3FcOlb2ypzIjL3pK/Hn0v4GzPQ
 Sx5mb4lh0vf20n7rmtxX/8Qb1By4j6YeUvplflpTXP7lb3DHy1BG2OyfA
 Ldj0ljKBAYN6Hmpwqwo6Uu/KeLokmj+Jk7mt5356TFT6nEujs7qpVDb/t
 NT7NU1f+vMuJpczyKj4hYs+fAE3/+FeV8V229760XGwQa+WDQi4OI32oF w==;
X-CSE-ConnectionGUID: XIKtrYj8Q/OcXs9J+cQvyA==
X-CSE-MsgGUID: Swdp1Zl8TmaBWqJarQne5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663063"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663063"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:13 -0700
X-CSE-ConnectionGUID: jRz84O9mTl6ITrDgAN+rGg==
X-CSE-MsgGUID: YnefPrh2Tla1H0pFhTP0rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951592"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 05/21] argparse: add documentation on supported value types
Date: Thu,  9 Oct 2025 14:00:40 +0100
Message-ID: <20251009130056.2630343-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

The different value types supported by the argparse library are not
discussed in the documentation, so add some reference material about
them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/prog_guide/argparse_lib.rst | 73 +++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index b309260d20..7868af5672 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -160,6 +160,75 @@ both use this way, the parsing is as follows:
 - For argument ``ooo``, it is positional argument,
   the ``ooo_val`` will be set to user input's value.
 
+Supported Value Types
+~~~~~~~~~~~~~~~~~~~~~
+
+The argparse library supports automatic parsing of several data types when using
+the autosave method. The parsed values are automatically converted from string
+input to the appropriate data type and stored in the ``val_saver`` field.
+
+Integer Types
+^^^^^^^^^^^^^
+
+The library supports parsing various integer types:
+
+- ``RTE_ARGPARSE_VALUE_TYPE_INT`` - signed integer
+- ``RTE_ARGPARSE_VALUE_TYPE_U8`` - unsigned 8-bit integer
+- ``RTE_ARGPARSE_VALUE_TYPE_U16`` - unsigned 16-bit integer
+- ``RTE_ARGPARSE_VALUE_TYPE_U32`` - unsigned 32-bit integer
+- ``RTE_ARGPARSE_VALUE_TYPE_U64`` - unsigned 64-bit integer
+
+.. code-block:: C
+
+   static int my_int;
+   static uint16_t my_port;
+   static uint32_t my_count;
+
+   static struct rte_argparse obj = {
+      .args = {
+         { "--number", "-n", "Integer value", &my_int, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_INT },
+         { "--port", "-p", "Port number", &my_port, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U16 },
+         { "--count", "-c", "Count value", &my_count, (void *)1000, RTE_ARGPARSE_VALUE_OPTIONAL, RTE_ARGPARSE_VALUE_TYPE_U32 },
+         ARGPARSE_ARG_END(),
+      },
+   };
+
+String Type
+^^^^^^^^^^^
+
+String arguments are parsed using ``RTE_ARGPARSE_VALUE_TYPE_STR``.
+When using this type, the input value is saved to the provided pointer without any parsing or validation.
+
+.. code-block:: C
+
+   static const char *my_string;
+
+   static struct rte_argparse obj = {
+      .args = {
+         { "--name", "-n", "Name string", &my_string, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR },
+         ARGPARSE_ARG_END(),
+      },
+   };
+
+Boolean Type
+^^^^^^^^^^^^
+
+Boolean arguments are parsed using ``RTE_ARGPARSE_VALUE_TYPE_BOOL`` and accept the following input formats:
+
+- ``true``, ``false`` (case-sensitive)
+- ``1``, ``0`` (numeric format)
+
+.. code-block:: C
+
+   static bool my_flag;
+
+   static struct rte_argparse obj = {
+      .args = {
+         { "--enable", "-e", "Enable feature", &my_flag, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_BOOL },
+         ARGPARSE_ARG_END(),
+      },
+   };
+
 Parsing by callback way
 ~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -167,8 +236,8 @@ It could also choose to use callback to parse,
 just define a unique index for the argument
 and make the ``val_save`` field to be NULL also zero value-type.
 
-In the above example, the arguments ``--ddd``/``--eee``/``--fff`` and ``ppp``
-both use this way.
+In the example at the top of this section,
+the arguments ``--ddd``/``--eee``/``--fff`` and ``ppp`` all use this way.
 
 Multiple times argument
 ~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.48.1

