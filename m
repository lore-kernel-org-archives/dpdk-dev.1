Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CDFE9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2E14067D;
	Thu, 19 Feb 2026 18:51:23 +0100 (CET)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67]) by mails.dpdk.org (Postfix) with ESMTP id 1098340671
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:51:20 +0100 (CET)
Received: by mail-ot1-f67.google.com with SMTP id
 46e09a7af769-7d4c4cacf78so469169a34.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523479;
 x=1772128279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=ifOlN7Lhu8dn3V/vJ6cThhgEJzf7+/BZND5caNuiCH0L9feskhlNIuv+Ib9iAE8EyC
 3nlBJQKGW8whkqhPWF6/I5HsXJyUz+Y3NQ+Z/RxmoE0tBUmQnL115R42Gx2tZzvs+O20
 TkAyIEmLHskJbV/hJtO9UOnfXJZO3xd8HemY7DdgerbRJyHFIzGzfrFBCu1jJG09qNcS
 z41PU0QDIR36/0sxQLefO+PywtsjSjCgsIWEXbJM2ijlek6qIN435/6Zsd2s8hTU0xx8
 Ikn9Nl1sv7vF2J00/sWfc+Dpi69QiqabtiSs/WVkDj80z39PtAwFnXAeWDK7GBSuh7RO
 sv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523479; x=1772128279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=Y4aiwy8IJRxSBnVQepnx9+oCDHFcZk+Iysjjlhv2GRNwOWa0bXl2nJbvSn8NbID88W
 j5McqjUx/D+bVsYf+iQ6h7LROVA/pVBZz1sweHXN+yC/2/q13mWSKZDS5HtbdeQJ9nGb
 rophwN+M8RxUakugNsJw617/83fJqRur2np21NP1k05VicxmNcDnAxzvQqgMcjGeN5t5
 FwX5ckBuIQ1JkhAS0dqrrgf6YWP25RQudNoXKB9gN13hCxehT4BfqEcIm7lwynN+mleL
 K3N55LxcQLo08JfBxJNUH0SCO/iWVsH4ikYvBglBuWNJc09ZfhBF2VONU4k2/c7dDJB9
 HbBQ==
X-Gm-Message-State: AOJu0YxZs2TNbE6XJwwTS+wHtElB0bWNVwiXknYipLJmwHDRYFHLmmL4
 et+xtZhVbIhbx/ddSkHH1JAyUqCCP5dfxd95WRNExyIjsTvF3B5LNrdnnmDfEWyPjyUEc8oBJ7I
 o+DQl0ok=
X-Gm-Gg: AZuq6aJVeRkBXhH7WKZO+S4F7cOQXkTEVdzQlKd1N5rZV1zmFd8nDT3uTmjmJYaTAyP
 7ZKfWHJDnZ+xJ7aEumalOSJXkdvudbGEAWZk3WogXVv6akbJQUB1f2Kp5TPD7I73Sj9dfQCw382
 kvn70ubuVrr9ggsXbnBtxNg6N49LIPMvOEHpGdEGQKlRzKLEKMMroOL+JKoBCI6dtqxl2CU9T9H
 efuxqsUE7mwWCos+bwQFft0BKoCob2jVePD4gkfMwWQ+fh6580WqFvV1kG3dsGgS1tG+rSzv4wP
 /R/PihCSBl8YObOB4BZ0Ud5urPMmp77uK7JMBVqoAP26EugpzdebkjAroxPBQaI672djKGk6eRf
 DzkPBZShAzm7jDe8rilGZV84qqcrY7mLMRDCxvHYEBhvI0jGEdTb/jPo/2g22GLPj4dpCUco/Mi
 Gg0SvE65TG71YIUC3k39cukFfNu9+SkEU8bs8C2SKBOVMgpoINXykLmUzM563F3Q==
X-Received: by 2002:a05:6820:81cb:b0:672:5803:bcf4 with SMTP id
 006d021491bc7-6785c511543mr7762313eaf.77.1771523479324; 
 Thu, 19 Feb 2026 09:51:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67985df6ffcsm10261701eaf.4.2026.02.19.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Thu, 19 Feb 2026 09:48:50 -0800
Message-ID: <20260219175110.287747-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219175110.287747-1-stephen@networkplumber.org>
References: <20260213214107.234072-1-stephen@networkplumber.org>
 <20260219175110.287747-1-stephen@networkplumber.org>
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
 doc/guides/contributing/patches.rst    | 56 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index 5f554d47e6..74fc714d16 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -503,6 +503,62 @@ Additionally, when contributing to the DTS tool, patches should also be checked
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
+The review guidelines in ``AGENTS.md`` cover commit message formatting,
+SPDX licensing, C coding style, forbidden API usage, symbol export rules,
+and other DPDK-specific requirements.
+
+.. note::
+
+   AI-assisted review is a supplement to, not a replacement for,
+   human review on the mailing list.
+   Always verify AI suggestions before acting on them.
+
 .. _contrib_check_compilation:
 
 Checking Compilation
-- 
2.51.0

