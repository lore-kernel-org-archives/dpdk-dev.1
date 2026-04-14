Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1357FF9D0F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 21:10:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44CCE40687;
	Tue, 14 Apr 2026 23:10:25 +0200 (CEST)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41]) by mails.dpdk.org (Postfix) with ESMTP id 62F4B4066C
 for <dev@dpdk.org>; Tue, 14 Apr 2026 23:10:22 +0200 (CEST)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-685017d0fbcso3689573eaf.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776201022;
 x=1776805822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52e5O3IGUkbjLxFfM7LIcbhRDXVwyiQNa8RRy6M8GoM=;
 b=tPFAW1MN2PMmOXx53agBlMwXzLRqACgVYluMic1HRZ5bfs3CDtU/YfL0/GL5EdNuj9
 iiuAS3x55V/SZ/ZBffDY2fDiQPnzXToWGgz4vzT23exHvpHOim7o0BU+3LI5nEAvykqd
 CHNdDzWX7MLEeVlWrYlJbY4rfW1zJOwLmAsMFNGbT933d7116UkZAc9z9jks11iCJlzE
 m5eZ4dHIQ43M6itcIdkKJ+o7cZ1fYe9FOtk/DNZc4Rds/UGAN6KtLABwPZSCjd4of/U/
 ICAhjN3WeDsOtj0lZLV1VCXIQVvR1Wl3RA/jYxP9f8byO+iMrRSB0YbezdtmzRrQGANQ
 J4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776201022; x=1776805822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=52e5O3IGUkbjLxFfM7LIcbhRDXVwyiQNa8RRy6M8GoM=;
 b=dxoNRQvVx7EIOBifIP/js/wHlS+S5F8AU7+NVZwYJ/CVKMQNi1YXPRGieQDf3aFBzC
 /9AmcWF+Cq3NCRgERjFuaSuiKbNzZxoWhG0i9/2aZyYGF7XmgmxsqTyAqEiHRtDIannk
 HeZ9kbKT4VA9513e0n8fuK9bEiP2xYtxdJ6EpMiWTWGnUnjZkwiNrvUDg+kl1D/izEsC
 mcLRF55JUpA90R8kqDswtUgaAg/1PAckBJScm8JMdY/ilJIIyJxAdK7IY3uyHoLybBeF
 oIUwA4JX7MX1pJ9yMnj61U5JHRlPxegZJlzN3+8ElaQWl1mEj5zNYwozEAWXPUpaHLpD
 7VKw==
X-Gm-Message-State: AOJu0YxR3yNpyHKaNhjlBYmNRKYmyibu4LTCT3hAiKAtz09IFJhvH+fg
 3YDtu5NQPSAtFTuvmhDORziX7nn28gvkeDiv22hm3ldKm1tv73x1eY4+C/h/n7Eq2RniCBCgOJ5
 vNzCx
X-Gm-Gg: AeBDiev30dnTaVnfxcgRLZFdfDse3zpHSZOMyjQqC485i7X0DG6rOWQ8e1bG2AlypUJ
 rseK2YRPB1EP0N61UnvpQPYXKFBZItFOLdiQ51vaF3VKVo/GxDkoXYPqwdIRx5ahKXX7C1gEuOo
 3T2/kNNt1xfftxpNfGUYaLsuBcdTXFRVsGWWaH7zNebz+0hTKJ85F4L2O6Xg2AvbZM61ayTfwx6
 jLeCc4qolUonN0rSCGijkiTJJoLB2ShC+1OuwlKcGREYFGPeQHMDgyyEAJQUYz4O9tFX39el/5h
 TA67GqfqPwd2BWE7HZhJ3OgnX3T2N0fkhIw/gqXpJ4fOrwb4FkoGe3RURWyecuMY9jMrXNFk20G
 0JPKu8N1QjGxWGKFdIHtEC3Wiuh8g1l3B5i9n/E+Pscdk3zk7h2RBvEvFrlwhulCSLBO8bhoT0X
 hECh8du/h2L7AFnBicnVgklJeeJKgZijINvqLqpebTFVY=
X-Received: by 2002:a05:6820:2208:b0:692:1b8a:8c45 with SMTP id
 006d021491bc7-6921b8a8d69mr1811738eaf.15.1776201021511; 
 Tue, 14 Apr 2026 14:10:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc82ea711sm7770224eaf.4.2026.04.14.14.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:10:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v14 5/6] doc: add AI-assisted patch review to contributing
 guide
Date: Tue, 14 Apr 2026 14:08:42 -0700
Message-ID: <20260414211012.951613-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414211012.951613-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
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
Acked-by: Aaron Conole <aconole@redhat.com>
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

