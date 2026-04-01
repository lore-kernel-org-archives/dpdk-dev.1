Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86710F6FBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 15:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FBB40E03;
	Wed,  1 Apr 2026 17:42:44 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4AEAD40E11
 for <dev@dpdk.org>; Wed,  1 Apr 2026 17:42:43 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-82a7ebc729dso3009897b3a.3
 for <dev@dpdk.org>; Wed, 01 Apr 2026 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775058162;
 x=1775662962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=S3yfxjdh6lxFpC+O/7yrhHV5+OgJWnAL5HM7pNOdbdVqAXtFszalcRJObSOwL3+RQt
 sLCYFjRahwLW1x4Qr8Z99fFqoHrqEYKFtCOwdg9HwHhfXYIzGspXYy2mMjPIU302cvXy
 W/eo1rJmtPpBk6PP2+J8W1XHFD68+RIL0NYiusSybvoou0/kAvReqic1KXngBP0vEmcf
 eQ5p7NBJ1vnL2ac+1tnlnN7bmrK7b/dKOEqjKPNroqtj+SwXpsHveFFoObA3npl9FllB
 rAG2eQwUZW8rl6Ud/Zl/7ooAaZUBgVb8GodtiOTqb6N+Pc2N4CmIT2NSJAqWMVGykoeV
 1ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058162; x=1775662962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwUoaiktWfyR592Jioo+jHne/v6H21Jvqkq2rf2t0xk=;
 b=kTghu6PChebvu1KyRC+gdBFM0UUrX3wx/aTiKNQGSuNvNBushID4QJAk/fSkW54VfM
 IT4ndqxyCVtIWEFQi/k+29yNZUtam6lVJnXD6d7R8NsON+MoqkcB3Inp7vLw5/BEk+ry
 74udKLf+bQXdTTX/IrrMvyCZeCizZySZHlsdMHmdgfB4Lga7CqbXre2XTbSOPKC3zS3v
 DlOqiUS24iAbbE4OOto46ihIfEZwFarN85ZrbPNLAJ1QIg4wFPoCD69ejB51xTPgZ45X
 rMZWlLXkqz9lcTCDQMxAfOBx8izzCkW07/ZjGABitmkqaxOfsW2LuXm07KaYP2pFwLQR
 +chg==
X-Gm-Message-State: AOJu0Yy0kGrTl5JCcjuhGZbsODXRbgrsd9DwtajmxyF9Y3uegWc0IbUK
 jwrKop41OKQsK3gQ9ZSZGr15BMghuUafEgGtdEC0/ALCJkmW/ztr8RQJlC+kdFNCGH2Bwk35ALR
 NPAUJ
X-Gm-Gg: ATEYQzxWK+oqj8PO2OnCIp+ztymShJjuVLCd4b5wIvfqb/rVUG9M8Oq9Mve3pwRXTyN
 B1WGHtuPDFEz+csR7ygLjGRTkhPX0sja5hCT0S5p7t3kCGb35hnE6OG/++jlB54PrlqcJJWw2qt
 mP8IV5AO7i7wzsttyPzvfhLso0NLjXbqR7rkKIbnNjFCE1KeagD9oZx20WD5Sfi/R+zHD+oN+B4
 Uio5j1BOPp2rMLICGszoSjGqKKmik/4s5C1J5sQ1iHvH0Nv3CNQODrfUor5npYCwFux6tT38+pr
 1waCHEfOsxBnnmvIxRpPXtdBf2Plocock/SY2GEcQBFSbM4OSQeX0SFvioc/scKyoVn3PZFzUjR
 V+9yO3eVG5CwciZyg97cFJL3Xasu+HBDCgMRO/L2vY/E7k5L1Anjctl7y8B5oE0KRi7DRepI6uG
 R21LHw62D5S8Q1+xYOWqo50DzE7WyGxBfF
X-Received: by 2002:aa7:88d1:0:b0:82c:2468:a163 with SMTP id
 d2e1a72fcca58-82ce8ac45bfmr4144976b3a.34.1775058162399; 
 Wed, 01 Apr 2026 08:42:42 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2694csm297749b3a.2.2026.04.01.08.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:42:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Wed,  1 Apr 2026 08:38:11 -0700
Message-ID: <20260401154218.160500-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401154218.160500-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260401154218.160500-1-stephen@networkplumber.org>
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

