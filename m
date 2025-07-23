Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CAAC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF20410E4;
	Wed, 23 Jul 2025 18:21:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 55DE440144
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753287664; x=1784823664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/HxFwF/qylJHh4tzWWnQPCN1LnPc60FCI4AnzzXb1Lw=;
 b=ceGv8kdT2q7eGghjg+4uVc3XwQh/jVqdKfUB2pIxK1DqdHIuAMyAGd50
 wSn50cBMGP9XOoX4iFiwU40jKOvl8BVH1Co0FAUeLfEGAbtEyUg4w2rmi
 VQ12dgGf2FwDfoUg3Nrp7DLQlT6gElEsls9n7huuiLcNRfWfYK+D8le9f
 yFz7fNGeazIO9LfK00zhBSLe4fvsehtfq/7d7Fz1x+h1H8tX2VQm+LZ0b
 U9PQtwK9tqbRWvLiFQbur95ZgEi5CHEkuWP21FrxDSYyQtAo9qPvRLgRk
 MsoQ7jF2wA5KSA2KKVQxwlYNHdu+AyZWSbCkA/DBagGWRrPoqdQfktGAg w==;
X-CSE-ConnectionGUID: dalMIjlIRX2jQH4lc2TZdw==
X-CSE-MsgGUID: tS3rhtwIRreF8LBxHBr5vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43197977"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43197977"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 09:21:03 -0700
X-CSE-ConnectionGUID: LYhcELDWRneFmvo2RC9r5w==
X-CSE-MsgGUID: PWQILlivTDaDfe8r3vSiHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160148914"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 09:21:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v7 04/13] argparse: add documentation on supported value types
Date: Wed, 23 Jul 2025 17:20:02 +0100
Message-ID: <20250723162013.2392-5-bruce.richardson@intel.com>
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

