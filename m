Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C27FCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 01:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DE4B40A6D;
	Tue, 10 Mar 2026 02:59:22 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id CD98F40687
 for <dev@dpdk.org>; Tue, 10 Mar 2026 02:59:19 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d749f99691so896239a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773107959;
 x=1773712759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVt/enIgXjGE17QLz3ruXqz1aAXcBI9cbAUEDgHgxtE=;
 b=OLtKs0LY6TppB1L6/XHKidLX3UR+4n/O0YF8Nop2x0QhWrDfmPgKY6YqSkmlHZr5sU
 u1S7wKzfP17jLirZahSBYXwcwh/+eZjSU59YXYdNx0GfEESE/WxnTVzMyA+u9Wc+xUcI
 07cvkH+rL2EBl6a+4KuiNMVQJebEGIsEsPvFK2yVhfI4QIUoSBPtnwI4g5uPX25IlQQ/
 VkSLhPX0K0gLnVcDjkOxD8p8rbgrImFWSdKRxo9ClN/DYGVVmn0l0iGTowBd15mgGLmy
 IyDLsWdrqNTFRyxmLQC9iSJHTTWpLGX971Ik3ntetfc/B/n/hF+Z9C/tvd+ypXMIV+ZS
 WZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773107959; x=1773712759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVt/enIgXjGE17QLz3ruXqz1aAXcBI9cbAUEDgHgxtE=;
 b=VL5rmF3rSUu2WrZWRspd+4MahwLwA5iPt5/x4ugbjHDOojpExXbcEvjAJ16Vlo5BuB
 xkAdNw8ffvt3In01Kc58Vs8bhXWK00gTTor23dnFhUwuhu9I42MLex5LT9JDe+iflgLY
 hDNnk/SFXTvzf1Ayeh6YN9NLaYiOZJpgvMcQPqz9Y+7nqy/maQIi387kZX5SG1cPlwMe
 04ubPC80AznezUTPkoQA2KLC7ojEB4x6Y/AdakA9j+tsvTC2qnWABVYw3XikNKPjo7Ro
 Z/8/s+uEhnT8MZTepop6V1Ra69AvnGe1bzvnWXbRWwAhDHWnRcMXk32pyW7ZmEzBD4Wc
 flzw==
X-Gm-Message-State: AOJu0Yx7VRevOWG7qON0+me8cDfGcujMCvXwyZGybU1u37BQXTUR4tha
 lNQ0ooQMwvsMXRW/jTVMZm6IsQIYS3/DabDdtZBwd/Abeky+GQNw0M7c0yV46Pl2BN/nFaJSV0H
 HxFkHb3U=
X-Gm-Gg: ATEYQzzbuUE7I2vYkXHKOnDF//kqVABIyt3j/A8a1XRtMXYbqmS14XLqI/RM+YEhHVG
 EN01idXPXo14iItn48jqZjt6fo2NPTxCknSbM0jcaOjo8DZPqvLOEl8cyc8Xq9lAnjc5X6YAKy3
 Lv5jq5wWVmsipGiQcy5yBsWU6NHKvuYf9TBe5BNYhiRbumgGKso1//nHjzN5n5eUJ9vAyUTphjH
 Je4qNwiXAXWmCu20YlJpiiKGpfuk+2uqph3SOVshPJ6wIgyOGwsUKapIQ2DZ2jg+4KFjegiZv9i
 QHssTN6H1IpQ8N13jVdg0rCpW65xngD8KFJI/dfqXS2tZNyNUYNqIqEw5judObsN/lBQSgPdfWy
 k9TWm0TITFQYAQ5D2qTx0A1BzgHCfOJodJoqtD+JuxziwGKJfkW6i7e4gG5ueHyoOSl7v/0pgoq
 FoKP3YsK/qjNaKw3BkL3SkaasWku7DoJkN
X-Received: by 2002:a05:6870:6588:b0:417:392e:4e67 with SMTP id
 586e51a60fabf-417392e62acmr2903561fac.20.1773107958979; 
 Mon, 09 Mar 2026 18:59:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756d4c0e0sm1172716fac.13.2026.03.09.18.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 18:59:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Mon,  9 Mar 2026 18:57:25 -0700
Message-ID: <20260310015910.331784-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310015910.331784-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260310015910.331784-1-stephen@networkplumber.org>
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

Add a new section to the contributing guide describing the
analyze-patch.py script which uses AI providers to review patches
against DPDK coding standards before submission to the mailing list.

The new section covers basic usage, provider selection, patch series
handling, LTS release review, and output format options. A note
clarifies that AI review supplements but does not replace human
review.

Also add a reference to the script in the new driver guide's
test tools checklist.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/new_driver.rst |  2 +
 doc/guides/contributing/patches.rst    | 59 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/doc/guides/contributing/new_driver.rst b/doc/guides/contributing/new_driver.rst
index 555e875329..6c0d356cfd 100644
--- a/doc/guides/contributing/new_driver.rst
+++ b/doc/guides/contributing/new_driver.rst
@@ -210,3 +210,5 @@ Be sure to run the following test tools per patch in a patch series:
 * `check-doc-vs-code.sh`
 * `check-spdx-tag.sh`
 * Build documentation and validate how output looks
+* Optionally run ``analyze-patch.py`` for AI-assisted review
+  (see :ref:`ai_assisted_review` in the Contributing Guide)
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 5f554d47e6..1e50799c19 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -183,6 +183,10 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
 
 * Code and related documentation must be updated atomically in the same patch.
 
+* Consider running the :ref:`AI-assisted review <ai_assisted_review>` tool
+  before submitting to catch common issues early.
+  This is encouraged but not required.
+
 Once the changes have been made you should commit them to your local repo.
 
 For small changes, that do not require specific explanations, it is better to keep things together in the
@@ -503,6 +507,61 @@ Additionally, when contributing to the DTS tool, patches should also be checked
 the ``dts-check-format.sh`` script in the ``devtools`` directory of the DPDK repo.
 To run the script, extra :ref:`Python dependencies <dts_deps>` are needed.
 
+
+.. _ai_assisted_review:
+
+AI-Assisted Patch Review
+------------------------
+
+Contributors may optionally use the ``devtools/analyze-patch.py`` script
+to get an AI-assisted review of patches before submitting them to the mailing list.
+The script checks patches against the DPDK coding standards and contribution
+guidelines documented in ``AGENTS.md``.
+
+The script supports multiple AI providers (Anthropic Claude, OpenAI ChatGPT,
+xAI Grok, Google Gemini).  An API key for the chosen provider must be set
+in the corresponding environment variable (see ``--list-providers``).
+
+Basic usage::
+
+   # Review a single patch (default provider: Anthropic Claude)
+   devtools/analyze-patch.py my-patch.patch
+
+   # Use a different provider
+   devtools/analyze-patch.py -p openai my-patch.patch
+
+   # Review for an LTS branch (enables stricter rules)
+   devtools/analyze-patch.py -r 24.11 my-patch.patch
+
+   # List available providers and their API key variables
+   devtools/analyze-patch.py --list-providers
+
+For a patch series in an mbox file, the ``--split-patches`` option reviews
+each patch individually::
+
+   devtools/analyze-patch.py --split-patches series.mbox
+
+   # Review only a range of patches
+   devtools/analyze-patch.py --split-patches --patch-range 1-5 series.mbox
+
+When reviewing for a Long Term Stable (LTS) release, use the ``-r`` option
+with the target version.  Any DPDK release with minor version ``.11``
+(e.g., 23.11, 24.11) is automatically recognized as LTS,
+and the script will enforce stricter rules: bug fixes only, no new features or APIs.
+
+Output can be formatted as plain text (default), Markdown, HTML, or JSON::
+
+   devtools/analyze-patch.py -f markdown -o review.md my-patch.patch
+
+The review guidelines in ``AGENTS.md`` focus on correctness bug detection
+and other DPDK-specific requirements. Commit message formatting and
+SPDX/copyright compliance are checked by ``checkpatches.sh`` and are
+not duplicated in the AI review.
+
+.. note::
+
+   Always verify AI suggestions before acting on them.
+
 .. _contrib_check_compilation:
 
 Checking Compilation
-- 
2.51.0

