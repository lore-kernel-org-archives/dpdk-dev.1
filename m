Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860AEC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD1C942793;
	Wed, 23 Jul 2025 18:21:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id C292242707
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753287679; x=1784823679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MLgpTJTxLrm3c3FxCQMbpd8CWTdMgFBs3QDUhHCuLYE=;
 b=klwaMN/g+5ZWmaGl6xy5gM5s6ca/gEFaol65EVJ6nanRK+q5icbOuQUt
 31XLZHwBdUNIt1sFdntZNAzPc5jKnKQ2/xeZBFvly5zNF3e4lerVwstm0
 7+5i78wQtIsO/QhdSwbz8yzCyLdaNkfTpsyDmLP1WTTPbjFyIIvCbXkIR
 6DxC5sU+zExSCNrqb1jkrDRy2aNuTeajXfndNbrVECJU8LyPazcIVQfxQ
 9EhwWp9NSVE7hIUzdnEjkfkdOh3JL15FGs3qp5WzyTy6GBDQ8Ksl0KZqd
 wLM3o7xmVcSeo4w3wd2EVKz0P0elK8J9ZrtIh2X2Vt8NfzZRJfPEVX2x5 g==;
X-CSE-ConnectionGUID: 6EjkyxOmRsSDAVsOlYtcUw==
X-CSE-MsgGUID: fZ5BeU/6QI+NU/PYdoIFPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43198025"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43198025"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 09:21:18 -0700
X-CSE-ConnectionGUID: vEvUOuzNQvGoNfsMLWBd8A==
X-CSE-MsgGUID: 6VQCX4PxQRWilwehwf5yRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160148949"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 09:21:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 13/13] eal: add warnings about ignored options
Date: Wed, 23 Jul 2025 17:20:11 +0100
Message-ID: <20250723162013.2392-14-bruce.richardson@intel.com>
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

The lcoreid-base option only applies when used with the lcores-remapped
option, so print a warning when it's used with an lcores or coremask
flag, or when no core specification is given at all.

To do this, we add some generic infrastructure to allow us to warn about
options which are ignored when either used together or not used
together.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index af2bd33fd4..5992f4e43b 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -201,6 +201,47 @@ conflicting_options(uintptr_t opt1, uintptr_t opt2, const char *opt1_name, const
 #define CONFLICTING_OPTIONS(args, opt1, opt2) \
 	conflicting_options((uintptr_t)(args.opt1), (uintptr_t)(args.opt2), #opt1, #opt2)
 
+enum when_ignored {
+	OPT_IGNORED_WITH,
+	OPT_IGNORED_WITHOUT,
+};
+static inline bool  /* return bool so we can track what warnings are printed */
+ignored_option(uintptr_t ignored, uintptr_t opt2, const char *ignored_name, const char *opt2_name,
+		enum when_ignored when)
+{
+	char name1[64];  /* should be the max length of any argument */
+	char name2[64];
+
+	if (!ignored)
+		return false;
+
+	strlcpy(name1, ignored_name, sizeof(name1));
+	strlcpy(name2, opt2_name, sizeof(name2));
+	for (int i = 0; name1[i] != '\0'; i++)
+		if (name1[i] == '_')
+			name1[i] = '-';
+	for (int i = 0; name2[i] != '\0'; i++)
+		if (name2[i] == '_')
+			name2[i] = '-';
+
+	if (when == OPT_IGNORED_WITH && opt2) {
+		EAL_LOG(WARNING, "Option '%s' ignored when used with option '%s'", name1, name2);
+		return true;
+	} else if (when == OPT_IGNORED_WITHOUT && !opt2) {
+		EAL_LOG(WARNING, "Option '%s' ignored without option '%s'", name1, name2);
+		return true;
+	}
+	return false;
+}
+/* prints a warning when option "ignored" is used *with* option "opt2" */
+#define IGNORE_OPTION_WITH(args, ignored, opt2) \
+	ignored_option((uintptr_t)(args.ignored), (uintptr_t)(args.opt2), #ignored, #opt2, \
+			OPT_IGNORED_WITH)
+/* prints a warning when option "ignored" is used *without* option "opt2" */
+#define IGNORE_OPTION_WITHOUT(args, ignored, opt2) \
+	ignored_option((uintptr_t)(args.ignored), (uintptr_t)(args.opt2), #ignored, #opt2, \
+			OPT_IGNORED_WITHOUT)
+
 /* function to call into argparse library to parse the passed argc/argv parameters
  * to the eal_init_args structure.
  */
@@ -249,6 +290,12 @@ eal_collate_args(int argc, char **argv)
 			CONFLICTING_OPTIONS(args, in_memory, huge_unlink))
 		return -1;
 
+	/* warn about some ignored options */
+	if (!IGNORE_OPTION_WITH(args, lcoreid_base, lcores) &&
+			!IGNORE_OPTION_WITH(args, lcoreid_base, coremask))
+		/* only warn about not having --lcores-remapped if we didn't already warn */
+		IGNORE_OPTION_WITHOUT(args, lcoreid_base, lcores_remapped);
+
 	argv[retval - 1] = argv[0];
 	return retval - 1;
 }
-- 
2.48.1

