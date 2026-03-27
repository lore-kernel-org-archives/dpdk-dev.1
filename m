Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BBA10F2847
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B332742E6C;
	Fri, 27 Mar 2026 16:43:44 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id ABC9842E76
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:43:43 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-829a27414a3so1578504b3a.3
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774626223;
 x=1775231023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=X7W4BFCQmkzWoZ+nXN1LbpzRhnvlVkGJbGn2Xhphi6d4QLwBy5FOVT4WRJ+KUUF1Xa
 6XieHGk/WqlSYtLN5VgnoAeL53RjUD3sJejotoWA2eFFNYW84JEyWlwD+rM2tTGpDXrl
 2fj+Zq2q1Rl80kVQFoXgo+CJ65FFQqAA4KP7rxnUpcePL/W3R8IOqzdtjgwZi7QUUT2N
 cLZv+qsL1elotC/Jnp0pXiQCqn3txWtojreEnWHtFnCGYshNlp+PX0AKbVIeMXTmz92y
 2xbS4/AGwbcMGJWnmcxYXHUFyOBkddcxVifXWfx+mcdmlyJTccvz/8C5Q9u44swmkxLT
 V2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626223; x=1775231023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=QrdmQ5Rm0pCnrb0+aJRh9QUG/Qf3liuvQUREXzsBVW0l2NMrpE7uiyVANZ5ivu9GPg
 S0923AXjONcwUqwnMSHmsqNUrDkhrfZC7bp69WwAILH2K0kSxvntrkwLOJDpvGYK6mPK
 npGGj6r/GiKszGKS3mmfND0TuJu6s2XxIk0NF0ee3RkeHOpb61mazWpEJr/zVC/5A+NE
 vtPBa5VRokjAFE4OCHJC/SYY7NzFvSjn80GueNcyELkaM729Vzk95qSlK+sQ9rJMamRJ
 Zy3T3VafMW/V8zu52Bf9iW9wSh6jAUL+6NiCd+e7GzB8IAOAL3PrghR7vQwt9iy6SNsb
 1KXw==
X-Gm-Message-State: AOJu0Yx1AeajXatYyM5XCP/4E62UGaE1S2f7IhsG9gQ6SGyDMkqWhaGO
 uiAS9376E//h9a7OVX9/UYyfgDIbxYoVjPm6IJ4tz/EEB295OKUyR21IJUSPRIC1Gd0103jGsR3
 dV9zJ
X-Gm-Gg: ATEYQzytdjncUYDNeiZUcE4wIr9qRgAEaft8L177h7eBv+k1x4TLH8MgkpcOEEFN4rl
 47K+nlp9yB0BlPVuLLRBnL4vm0uxkCIJBs/qRVE/0Qx9sMoKxrtLE4oqpoRiVJNlKt7P1EiddLI
 PuCUVYB0CyA77zWHCicWZ06BHvVRrN9/7D8nw1bRRr1friS9Uf2KTcjUge6gGqGjUU8Six/arrK
 z5QgtoSEKboUpm8eVZC6tU6mgRGAbUnm3jFdSD03brKY9t970syizjaM1Jf4b+Yrl0WH9+M9CCZ
 O5jQeHRTkKMpScJsrz77nnCBnpuX2pSRVLHFp2jFUsl96MXwmif2ZHuuc0tk+g7M+8qmpp/ie87
 Wys7QHzufKecVIp2CYYiH/DOBLgBP4sjJeHGZc+UwODei/nYF4udhDRtvO18JuT9THk2SvYq377
 7pGuQOxBGlvL8SUwLTRAfxiddi97VFr/sw
X-Received: by 2002:a05:6a00:3cc9:b0:82c:66f2:1221 with SMTP id
 d2e1a72fcca58-82c960cd0e5mr2867707b3a.58.1774626222783; 
 Fri, 27 Mar 2026 08:43:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d390a4csm7508304b3a.31.2026.03.27.08.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:43:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Fri, 27 Mar 2026 08:41:56 -0700
Message-ID: <20260327154321.25800-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327154321.25800-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260327154321.25800-1-stephen@networkplumber.org>
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

