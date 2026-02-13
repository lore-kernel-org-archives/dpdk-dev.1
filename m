Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9832EF99E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 21:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 735E840672;
	Fri, 13 Feb 2026 22:41:25 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id CDC8A40677
 for <dev@dpdk.org>; Fri, 13 Feb 2026 22:41:22 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso951505f8f.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771018882;
 x=1771623682; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=V30AslcM4w0ssDEK7eZc1/kIMvZsZOnb/jaGNilQxx52LHmNFcjSu6ySSOKF6btqrH
 yKiklV4F5a2W5TZ7gz0fzvx3UPtXAbvPnf6n9OaNjU/6o9tOy5RA6I4sa75kOCU6aYxI
 v3A1noyFsxNpabJbBT/u6C78UoNIKNB3nwbE+vI8AY7LhOZfGSeHVkk0MNApI+w5YrM4
 9dtltb47ize942bsMQDEQdPxn6hpm2Qyqvhce4yZ7cwPPxYlnGpWWH5BJVDuePStEZPy
 kJrvoUhVYY30zyf3xK0wRSLX6k1S+67IMQaVUtLrrz4nWK2PsGdlqRqpppEdOpZR681E
 B+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771018882; x=1771623682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=reF3KcktjeUqbAAOC5CgjYlMLwPW5MmboH3cMHT3iISx7HKsiNRkEp8dqv+JLblIKo
 TSzYKMiSmwBBIPXtYQ61QH09iRZTnCV+Hm/3bWue1WXnWd0H9tv3+x7Lpp5NB0EqspDD
 hIoR0/MytWuUAesEZneERsSstNkCSz6LY1iBLwFAOdEK++1yNaDQH/LcQpDMXdhjaHgR
 AlkRdTd9F7d9Xm6qUyJRW2dez1WDyqaoqxbUS7+zf/A+NOEtfaaW41ISWDtuypFIR+k2
 C9xtFs7q1WCBIGV9iV/JZhsImNwf4IbwvR1/h7AgeIOxiQw84TBN31PHwf+GkqJGZtQB
 uf7Q==
X-Gm-Message-State: AOJu0YxNdOawHkOv43kb0jdKEF6kNOlSqUWczra+WQC0x3kc2++YgyBn
 f7YXoCpQAQ7l1jQLJ3RKwXiL/kbeqdzYYlmrE1gMtXB1F0dLgz1cR+Ez+Eeyd+r/hoG64oX8pe1
 CuJ47B5Q=
X-Gm-Gg: AZuq6aJdPeqRMZa5/r9jO2EBFb0QMczioIzJEuNrd1kOoNYmatU2pENnTHA/wC1r8bL
 3hEcgUNVyPfVQEz3BbMc5R7UvQskuqOBe3fib+xqNZWUGvpvnFEJHZAPooohAS/EuM+RUA+ARV1
 9KJOJPrEOgqWAl79rZTt8B2BChdaAX1ikkhevvxOAdoQcDX+BxGZRjyLaIj0XSa1W9ut63qM85m
 tCHjSdfiY8qmXdxJ8wZ3x1a5va5oaIgkQnugCIq/L3kjG8z5QNjR+utUjOxw7BFQIwgjH7D+LEU
 F9SSGPuwlpGL5ZXwNfcPozqNxqGELEW72wezG1WNLHk1/5y/ia1MqaN/ChMOJxE4BpbWRhAGk2g
 on3VWRJILpRxjHgucBJXkULu/RxEV5XEuFm0TH918JCuKCW8U5YCEyRxjBkzilHmfArt36BCwA1
 /MryNbUL0Z6V6KRMej/+tUn0Ck/Na0p7D7gDNuaqM7KRCH876zjART9tyzZpmrcA==
X-Received: by 2002:a05:6000:1447:b0:436:1a24:df81 with SMTP id
 ffacd0b85a97d-437978c0a34mr5557599f8f.2.1771018882390; 
 Fri, 13 Feb 2026 13:41:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm8346895f8f.33.2026.02.13.13.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 13:41:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 5/6] doc: add AI-assisted patch review to contributing guide
Date: Fri, 13 Feb 2026 13:39:10 -0800
Message-ID: <20260213214107.234072-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213214107.234072-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
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

