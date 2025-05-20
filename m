Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA7C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C1240BA4;
	Tue, 20 May 2025 18:40:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id F2E3440B97
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759245; x=1779295245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QNUm58hFHZ5FQE0bEi2uJIrJMhsgs5LaSo/NE/7SpfI=;
 b=iw2EXPvUjxRsuG9kN0HAZKQm+f0i2nMhkMtUi20oTXFxBeag3hF3hbEq
 6M2Q6GuOD39BhKYkuTuGlWENfF69uPkeyNcTQEBlJSVb5oJ5EdjvU5uJT
 ZtFQjpJp0zUE7vnrXYd8Y6UV7HaddSi+Gb+exNGdKNZRjnBS2MjjQ0k4F
 CA10intpZMTzEGKGWxRVyAu5/p0wpHNgd0vEDm2WYztltvWO/8q0fk/7R
 cZcZ2pSgMBAkW7yRegwGHHZBzSt4E6U15pShl1cZmR2KjMjvJ19hRg/+s
 r1lVyJpD44aSjsDgpR2LeMJmrdZ7n/NkGD3aco7Zyz5sx5zBYZARVjjVk A==;
X-CSE-ConnectionGUID: Rb2/AByLS+SptkyWE+5LCw==
X-CSE-MsgGUID: x8hQWZzITNWF5qVQoUCuPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320467"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320467"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:44 -0700
X-CSE-ConnectionGUID: NQqQwb7aQQi7oOJFVEaGhQ==
X-CSE-MsgGUID: 1APjamLtTgmFDM0sM9Vw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759476"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [RFC PATCH 2/7] argparse: add support for string and boolean args
Date: Tue, 20 May 2025 17:40:19 +0100
Message-ID: <20250520164025.2055721-3-bruce.richardson@intel.com>
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

Sometimes we don't want to parse the string at all, when doing arg
parsing, and just save it off for later. Add support for that.

Also, rather than assuming boolean values have to be the same size as
uint8 (or some other size), add an explicitly type for that - which also
allows checking for true/false and 0/1 values explicitly.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
Note: when adding support for strings, I was uncertain as to whether the library
  should copy the string, or just store the pointer to the original value. This
  patch takes the former approach and makes a copy, but I'd appreciate feedback
  on people's thoughts as to whether this is the best approach.
---
 lib/argparse/rte_argparse.c | 34 ++++++++++++++++++++++++++++++++++
 lib/argparse/rte_argparse.h |  6 +++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 18290e0c38..1cc06b550b 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -508,6 +508,38 @@ parse_arg_u64(struct rte_argparse_arg *arg, const char *value)
 	return 0;
 }

+static int
+parse_arg_str(struct rte_argparse_arg *arg, const char *value)
+{
+	if (value == NULL) {
+		*(char **)arg->val_saver = arg->val_set;
+		return 0;
+	}
+	*(char **)arg->val_saver = strdup(value);
+
+	return 0;
+}
+
+static int
+parse_arg_bool(struct rte_argparse_arg *arg, const char *value)
+{
+	if (value == NULL) {
+		*(bool *)arg->val_saver = (arg->val_set != NULL);
+		return 0;
+	}
+
+	if (strcmp(value, "true") == 0 || strcmp(value, "1") == 0)
+		*(bool *)arg->val_saver = true;
+	else if (strcmp(value, "false") == 0 || strcmp(value, "0") == 0)
+		*(bool *)arg->val_saver = false;
+	else {
+		ARGPARSE_LOG(ERR, "argument %s expect a boolean value!", arg->name_long);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 {
@@ -521,6 +553,8 @@ parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 		{ parse_arg_u16 },
 		{ parse_arg_u32 },
 		{ parse_arg_u64 },
+		{ parse_arg_str},
+		{ parse_arg_bool },
 	};
 	uint32_t index = arg_attr_val_type(arg);
 	int ret = -EINVAL;
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index d0cfaa1e4c..332184302e 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -60,8 +60,12 @@ extern "C" {
 #define RTE_ARGPARSE_ARG_VALUE_U32      RTE_SHIFT_VAL64(4, 2)
 /** The argument's value is uint64 type. */
 #define RTE_ARGPARSE_ARG_VALUE_U64      RTE_SHIFT_VAL64(5, 2)
+/** The argument's value is string type. */
+#define RTE_ARGPARSE_ARG_VALUE_STR      RTE_SHIFT_VAL64(6, 2)
+/** The argument's value is boolean flag type. */
+#define RTE_ARGPARSE_ARG_VALUE_BOOL     RTE_SHIFT_VAL64(7, 2)
 /** Max value type. */
-#define RTE_ARGPARSE_ARG_VALUE_MAX      RTE_SHIFT_VAL64(6, 2)
+#define RTE_ARGPARSE_ARG_VALUE_MAX      RTE_SHIFT_VAL64(8, 2)
 /**
  * Flag for that argument support occur multiple times.
  * This flag can be set only when the argument is optional.
--
2.48.1

