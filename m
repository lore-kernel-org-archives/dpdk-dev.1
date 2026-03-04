Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D1EFCE33
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:03:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B38640679;
	Wed,  4 Mar 2026 19:03:17 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 1FA99410E4
 for <dev@dpdk.org>; Wed,  4 Mar 2026 19:03:15 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-89a06bc2f1bso46263736d6.1
 for <dev@dpdk.org>; Wed, 04 Mar 2026 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772647394;
 x=1773252194; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVt/enIgXjGE17QLz3ruXqz1aAXcBI9cbAUEDgHgxtE=;
 b=z5UZC0gHJUDyvQoRpH6v5a7fqsMaasMB+9Op95o6J0G2vFhchwoUpWOwWKDv7L5dNB
 uJUYNEOCZAmz2Hj5rFJeZ0OHj3js8AgoJQZ1gUtyY9PR9TwN85q6mahFoPsAPqWfVlWe
 9JMgCNSB5lYzvFIOUKKEaf1MxPfiv9B4VU3+gIobPBRyTOmsoSO0ra+EJeNq+O/1aKM1
 52zUoORBE4Y7+Q7Cipl/1bX54cu5C9g0A5KBj63ZhN8RwhBPjR8/ZlN9A5vA6KpSBxXk
 4BakQDcAEADDJG2IUvaLV5nFXjz23Zn9ErZ8lKTgzkoLx4PyrK4d2dy6b10Q2WcAW18R
 6Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647394; x=1773252194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVt/enIgXjGE17QLz3ruXqz1aAXcBI9cbAUEDgHgxtE=;
 b=tLsfx6Uh5j1s3Z4zymJj5WCijaUoHqSPY93iB5pwtxpGNsBw61jyInpz9KYqxu9d0S
 eUXe7gaPAAqXnm+acO81g1NxsGxW9yiVL4Ztn1/Ie9lDGmcRg5ZnKk8Zh68q1fQxjpzJ
 67J/qdihXuV1oQ8oGUbFQcQJl/L260PgwMF3im6rs0rFJ1eArxsGP+f7SEj+jQZFKwfp
 S4J0CE5uxauKYDcYG+/AqdbRJNN5S5rR3Q1D4FZb8OGObxJUX9uZw7d3JA/zZVbpNIfE
 sSzSP+fkumHrBGItn8qM0Qzg/TH4zxpMGnQPdF9tRQ5nl0Rky2JnlV781RKdyGPaqBL0
 LnvQ==
X-Gm-Message-State: AOJu0YzXeVeQo45wmIWyf4HaVlmMTDq+nCwGILVV5TqvFbq7otml0XmK
 ZN7rn31CY0bTcbnAewb7OfwPKubgHECNJpQp/Gkdz3JUQYiP3YpPvhV6IcAFqm+H4xmIIpO4JeK
 5rKevRR0=
X-Gm-Gg: ATEYQzyA1PREw3GGv/sQn6hlpLXf4lfRIo/M13WQnrcGNEK1aliLuJk4LpGC28f2ca4
 Mn622HzHWkUwnYhb9Fh4SvO8BZE2Ywg4GB2KscyLCba7JnRXNEibek1lqkD24Be96RwKlBycq4C
 57AdbHVRNB+LMJE+kUoRzO5p9lfrqwgaVTiyEIh8Be0TWDX9meT152yEbEAYxK/OlfZMNjoqaT2
 /oe0Mj64hFJRk5kFfEms3OmQeSFlb4fD89CgbaQmyawGljfO1ACYFAnSb+Sz1IH+8V+/9E3vich
 nI1onqL/JblTGV+w2OC0JE+JNS94ELRXrUfWRGWMSzO8HapaeFHq6tBTOWgeXDNbqaM77K01H5A
 9RbdyaCyA0MbJ+jGx77OIpJQu3po9vllMNpw9VxzpEhBzmWMEeu5fnhZt6KSokyYFis9jYkjCtr
 eeMQ6tcFFmCDGM3ZmKHIikziwX9LrKayPURuslXKEz3mFTRaUFH5hR4vJgsvmYWw==
X-Received: by 2002:a05:6214:252f:b0:894:6c73:7e79 with SMTP id
 6a1803df08f44-89a199a89e7mr37722466d6.18.1772647394363; 
 Wed, 04 Mar 2026 10:03:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a083a95fbsm51698626d6.38.2026.03.04.10.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:03:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 5/6] doc: add AI-assisted patch review to contributing guide
Date: Wed,  4 Mar 2026 09:59:41 -0800
Message-ID: <20260304180303.436779-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304180303.436779-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260304180303.436779-1-stephen@networkplumber.org>
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

