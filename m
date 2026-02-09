Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B96E7E0DF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B9EC40A73;
	Mon,  9 Feb 2026 20:51:12 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 1BAF340696
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:51:10 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so1702715e9.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770666670;
 x=1771271470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=sfTye38v1PZZxUBfF4tI0A2Ym/IB3Y4A9eCeZ6RgkoTtPfzetH35f8Yy1tKIyQ88iz
 pv+NJQd03057qv1XJ9gujyrgRwiauOuC0zvxNLiXEe6mnmodnmx2yEZVlIzFF63IA2Xo
 8WZMh2uhfPkha9HZovp6wnKFh6BuGNMOD21i9AJpmg5ii2l1SDiggn4OuDWIjaBK1i16
 HPRWjciU2B4GJ3mRfmlfIrcy3ku8AxXmk8XsSVpU24ZphIIhybRdDeSVj87U1pcgpEnk
 /1k7+a6kb63Dp5k1EHQRp5xA5vUO5SDZ9PQUnJa0yHv/TBgLojgQ4F5wCcMkhV4vOhng
 HOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666670; x=1771271470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=aFE/nSS30rz7nG/ePtgaHPDiy4vWcAi73JFIscYp/mDsZTs1/GRhH4bYLuOvSQKRmJ
 NzYv/dkhjNwPHwbwE+/+vCvHPoIXH2swQ9p/lGvSbEeyXe30z3lDagV/lnXZO0gTe+Yp
 XsBhXDbglKWbuXhe0qPFaY7LKY/Of01uvPCvnTFafhwlI7DeMDEGiULUiYzxiyGLba5Y
 8w4ESQnEWXTC0RnPrOsKlmHm7E0Ob70XN4z0sBekgJWvNjDhwe1MSg2pX6A1zDYrLpe0
 oyJawKx6x0gljwICqSQq+lU5wsYXBwsxxN7NCEg+guT+gpkUOfDW+02crPqlEb0h5mdL
 mBdg==
X-Gm-Message-State: AOJu0YzV138eGfAfUZKU7oKGCMUeMvOPjHqImn1Iw/dPbpTwp5gDk71k
 eB/K+nPl/FaWcWhBWUrwfjR4fz0nZ8u9til9GLg/LH1IM22U/gN+6k8Pz0187twspCOjpx6Gjs6
 yOYVDBcY=
X-Gm-Gg: AZuq6aIE/ANMtPUdXCZKfBNMYvve8le/X64Ae/ri7il+ayS6SNTUn4S+8KslN8ohJkh
 90rk1uZQFapMdhWW+AS2aGhqsdV4g/keX4Kb3RXZMcnytxPZKdAMNb/Q85PHt3JVdiBI3I2NYHe
 oVHOJ8yIVtJIttEcJ3YocFhaPryd+lIeVAqFGCwLJLMUS18mWFoIzH+NwqitteUQvepsde5MpMc
 fq6qxS8y+w57fptrMn44hq7B/myezocYk43Cuqsl0RiO6D6mqazmvN3NXmMzpY8RKHe3Ka+Sf5T
 SYOyyLURGsnF/S+MzOSSCMWSkQFbaF4wQ2ohmEm5wLVhkp4JR90XlVyJYyOsUMMWnXf8X1xJtJ3
 G7utiOig0oIxoQ1MUCd1bi/XkrbsJy1Vm1WCsrN0wgSg5kqGWdYcLEUN6WqA9gbMG7zvGa/8iut
 kduyK8dBygtwKRV077TmTFivnJy1IZH4D13+Grz0DVEtoLjKkCbhJ+fS3OuH0O
X-Received: by 2002:a05:600c:3f0a:b0:47e:e712:aa88 with SMTP id
 5b1f17b1804b1-48320236ad7mr194928075e9.31.1770666669624; 
 Mon, 09 Feb 2026 11:51:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm10178345e9.3.2026.02.09.11.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:51:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 5/6] doc: add AI-assisted patch review to contributing guide
Date: Mon,  9 Feb 2026 11:48:53 -0800
Message-ID: <20260209195055.142484-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209195055.142484-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260209195055.142484-1-stephen@networkplumber.org>
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

