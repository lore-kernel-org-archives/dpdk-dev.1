Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7DBCD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9774066F;
	Fri, 22 May 2026 00:46:04 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 65B324065D
 for <dev@dpdk.org>; Fri, 22 May 2026 00:46:00 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-132d1b2519eso14442175c88.0
 for <dev@dpdk.org>; Thu, 21 May 2026 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403559;
 x=1780008359; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVduYH+Rn4lWre0b5NXulqAIaAff+oWNGK3UJ6yzans=;
 b=OwBY+CRfc1tNlo6WkcphQpFPgQjJ5sNIlpuYZurvuuaZyslHultxp6AgR/veqrErg8
 732NLQqx1y1zhBwnbMgO/NoyFE66KLun33rSDJsIClzKsDJ5eiQtOmpKMkwtrL9ZYNUA
 VUzw6kfItNxWx+FXvJbqAhLQd5AWotF8M2d53MrKw11dxyCpB3Ansdo1RZlKb4tJgNUI
 crMie8vkj+qDF7LIGdfn+hxy91W891/Q8FLeYdGhLi7dO7e5sNnV0dTcr7kuYxtCr5GX
 PtddXstUuMVDYmHZBFetCymE1nCtyBs5Z8sAgRQUZz6CR1VVZ79oAbptkxcUDagW2oVA
 ar7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403559; x=1780008359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVduYH+Rn4lWre0b5NXulqAIaAff+oWNGK3UJ6yzans=;
 b=qTOK0YKi90xFXkL8Se74HY5u61YY1eTPra8aA2UV5s8h81A6DVBX4Q903LkRNBgRM1
 0FLvUCeCO5adWh1lBG0qGDpztcb/ldBFQn6jMlZmOmaCtI3kWvX1twMOO0CJLRK4Alpz
 oq79lp8IFC6JV7XgoIqrBQRmuLYYyE/AoWj0XxG1dEVBqqD5lrUR2X3syiiHDWuEBV35
 7061Qwwy3lOV36uoXtorICUBmOUoJNpaHGTQUjtVHl0hwkndruvXkOGfuYG/74cpBeMw
 MS20cLEMGRZBEy0nTLKTAosp3JMBbV8V/W3xjfFmZu1+BcoaUOa06/QZlKv+HTD54hnV
 hbEg==
X-Gm-Message-State: AOJu0Yx8sttxIEGBnrFj+erpcebaXPCc64lFBHOt3V/YY30GD+xA2ByI
 4uYoKUjxq9/AxPdEDr4Df85mZkhCJc6Qt7Ze2xdztBEsl0PWfdy1C5fudgRNezcHWAxlqPVXn+k
 EVfAG
X-Gm-Gg: Acq92OGCX7MWTOSWbQ9nCH8+mL9hpRlr7DlVehsTF/iWiE5W25p6Lef56gMvBQK/8+O
 XQ2/jnYC2GlC6Rf8XBuz4APVYGnmsUOE8sMs5ho5nDT1TKFnV1ghiQgW2qRTt3OXCI8EJy90EvA
 5ES2S66nWYlwdwCbzGyHGSWHgNI1rVVEX86B2ApncvsTPW4iRfzEGZwnf5UkEVUg7veIiemGM3R
 qFxYTa1YPc4qwyXBcJcejyvj/YT8sxh3nWoVHIK4sWFSz57TZnKk2/122JONk+0bSQeY5ihWzhI
 4dtU8XQ6kzXtz+RytRN1R5HsmnYqErzB/6WdXvqAYZeIL7t7pIfEPHThmXRVMKiJltVFBvwZpT3
 79y94i8A/MlP2A2ZHMPSi4lhBhpbOqMTaGBBbLhg9L47bWuZeX9S3U67a1EIqxDRWGvu5ydb98q
 FvmFTdEmDnMcgakNB5a0DV5VuqvhcLmsz2DFNPqUzyqB5DG9pBy6kwp6kqDUdsQgN2Kc0Hoang
X-Received: by 2002:a05:7022:609c:b0:135:d749:5761 with SMTP id
 a92af1059eb24-1365f8117a4mr524912c88.8.1779403559400; 
 Thu, 21 May 2026 15:45:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136621d3ae9sm496044c88.5.2026.05.21.15.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:45:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v15 6/7] doc: add AI-assisted patch review to contributing
 guide
Date: Thu, 21 May 2026 15:44:38 -0700
Message-ID: <20260521224550.927338-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521224550.927338-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260521224550.927338-1-stephen@networkplumber.org>
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
index 5f554d47e6..52001570c6 100644
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
+Contributors may optionally use the ``analyze-patch.py`` script
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
+   devtools/ai/analyze-patch.py my-patch.patch
+
+   # Use a different provider
+   devtools/ai/analyze-patch.py -p openai my-patch.patch
+
+   # Review for an LTS branch (enables stricter rules)
+   devtools/ai/analyze-patch.py -r 24.11 my-patch.patch
+
+   # List available providers and their API key variables
+   devtools/ai/analyze-patch.py --list-providers
+
+For a patch series in an mbox file, the ``--split-patches`` option reviews
+each patch individually::
+
+   devtools/ai/analyze-patch.py --split-patches series.mbox
+
+   # Review only a range of patches
+   devtools/ai/analyze-patch.py --split-patches --patch-range 1-5 series.mbox
+
+When reviewing for a Long Term Stable (LTS) release, use the ``-r`` option
+with the target version.  Any DPDK release with minor version ``.11``
+(e.g., 23.11, 24.11) is automatically recognized as LTS,
+and the script will enforce stricter rules: bug fixes only, no new features or APIs.
+
+Output can be formatted as plain text (default), Markdown, HTML, or JSON::
+
+   devtools/ai/analyze-patch.py -f markdown -o review.md my-patch.patch
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

