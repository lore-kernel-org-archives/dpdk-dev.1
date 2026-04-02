Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C2D6AAFF
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 944BA40E6E;
	Thu,  2 Apr 2026 21:46:31 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 9D4B940E34
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:46:27 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so1934861eec.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775159187;
 x=1775763987; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=Bu7N+ZXQtzlmbLaK/Nceaf3MLqLzE3ogyhPHQxHAdLGWw6b0quqIbfwLpsmnOZky63
 N6gddY0n44QUc+21/TYcQ418I7pZRhfArE9Bsy6fjid3NhW2lsGsBQgqGCZL/vLNgXH5
 j7R/bzMgIqCABCt6e0k/IaOWVE3JLFBS6UUoy61RTWqCfJ1s4uFX4uGyPJZTYOlqnbYM
 UN9FqDFqN0YUSCo485/Q/v9zqV3JNtp4nRpmtGQOyyeHTNU7j7dmVc5v3wSiUapRj+Aq
 kL5Op6Xmc6FqfJEFniSPhAF1gVkwf9M3IwM0fwwBSGJvZXJVHg50hHq8SJX+yMCeKyet
 JVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775159187; x=1775763987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=CosOQS+X2XsUxLdeaIaOsSuGBtBlFXduHreqoNYEMfF3/Iw1w0FYMVjMO9ijYW9mPU
 /LQoSkGRRTVFb7yNHXZ4Ha073ENIGY7cIoIoiaY7q0G1aOOpkk3u9bkSlQr7xfvWp6qE
 aMv5G3lJcPioS1bvtmIlrLG5JnLoX9o9sOhG/ABEBykVgTpKF4m2b9rknyNtkX6RFBOQ
 PS64XCSinilts8M2/vi6+UDT7OTe7Y/J20Wplmpd1sgGaW/0x0soP1DW3yImOl8jYi7F
 LZWYtFmUD+VGMKrNf+0Dq/BAuyLootMaufBhVrxHU/Ucv5K5y1bpBvfLRlCxgwkIY6gM
 qwZg==
X-Gm-Message-State: AOJu0YxYXiThivD7virGcCFa+D7ipmGVoLKjh9Kk49OmbM3U1G9ksotx
 eJib3jmg5KG8xePJV9SD85bgS7ulNgzsIt2NXPPlj2LrYfucKpH4zsObgtezHEBHhrJ+ClXKiSZ
 IENQJ
X-Gm-Gg: AeBDievYHQxihwcVkLMaZK1LDMfRA0Fc/DrydvXWFj0evpZ5cvika9+0eYFsm/6wY5B
 en7H87I6Ca/Fq2GKR9vIz/Cl+/98dlmq1yxcKe7NUukYBxhqPwppXMc9C4L3b5SkTrbYvenkkH8
 mGAjAg5XI5k0CIsgN4Hh8nTiVJRLL7P1L9bBb8DwbPNXrfFGI4ziM1My22HMCNazrBuOiV2DR2P
 r/8dAQ8X0RxGG0RnztG19bOxOjO6A8J0OGLGV1Nr5pFe5WiVDaPtQFKoZ1tZeHWoTftJB6B0ldf
 R/Poyz5FFudqz91OMibZpcXFKJGHheuYy2tPlB7d/QYxNtL5uDMckkAe1G3KtsYePZXhLIC5w9W
 yVaMcFrF6jV4t29AX2NNU1G5LA5LiHQGC4ySLfbHcOabqflx0ZqsLEjohERNLPazuNNTVxGvaYT
 o8+83lsa4ErPshK3HSmQMbvWsNMyEqGpDv
X-Received: by 2002:a05:7300:231f:b0:2c1:6cfd:73d4 with SMTP id
 5a478bee46e88-2cbfc46367bmr219666eec.23.1775159186596; 
 Thu, 02 Apr 2026 12:46:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ec7sm3164279eec.3.2026.04.02.12.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:46:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Thu,  2 Apr 2026 12:44:35 -0700
Message-ID: <20260402194618.134002-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402194618.134002-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
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
2.53.0

