Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99521ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634664279F;
	Thu,  5 Feb 2026 18:53:13 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id AF303427A5
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:53:10 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-43628a01c32so155908f8f.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770313990;
 x=1770918790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=vSSdI4rZTqOOnUO/yj/1GoivwEG2CyiwCc7L8TjL7Zzx93tbNFjx4yKrBQ2Utjn06F
 d2MtD2TJClrH/+qzL4PYFuPW7uuz0jFn+vmKrcrLEo7vSwde6mCj6yn0yWvtSOarUO9W
 iXSDm7BX6gebA8Fsfnw9zdqJPCSNWw6uFmDhWthvhQzgf7SEt56N2ALN5jgZ2nkVRBSK
 8e7GD0+x/X8ij51FCly/POkLvf0EFT+gAkYJlHEPZd6HKzSUeMGsr2gz2trPtwg5OvRa
 7PLFldBLjzRqjNk6J5h6u4zr2HhF5K3rAWDjXmfmojg7+yVQPVhU6QEGdd5rTWMdg3FL
 cGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770313990; x=1770918790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tf9U4COyS54aZV8MzpliVz38KQqHUG8RiV1K7NmWg4=;
 b=Zona6A3fW4XSun2FRnK3s11nygrtrGblR7OTbhGrjxqfMqY+DFTde4QE0YiGDRaPWw
 cI+yzm/tsjY/Bqj9emyIJqZi6wASDudmcs5PAODOhZteN2k1uzWsnlVIAxvnHTuc/8hA
 9O2rxTHMyLYhZL+cB96Wsg0cqSPHcLQHC2feJSaH8pQrNwwVmfzlfDcq4V9O0B3COunZ
 CedOwYo6r/GafnKnM7CbQSkmI/Nu4g07fKPErqe39215UtpfchSnZaQCfnq374iZZDlP
 dGz05mm1KmW78qafm4VzV7QC7XzhSqQdLEf7T1UjeOwg7raR7uEfOl0BlDEcP7qhowJ/
 pNKA==
X-Gm-Message-State: AOJu0YylXaXpQeB1qnQuiiB/zagevO2t6pFHbq8D9ShTESJc++HR7Hz4
 2V4aLaT4hFlIeYY7e5TgZoeJI0a/Fyep5HN5CPnUXrwDHsxajbrSOhXeWbe/1N1uGh6L9TSX+QQ
 qvGSOxn4=
X-Gm-Gg: AZuq6aKnlKwIVLLFPyIs3o31ebxF9WXpKjb3NN7yDvp7vzoFv36osaNzbB0kAeZH79g
 dxOfpBbysNaGK83q/sefhoatT89j6lJfi96BuXs5eJMKmmur3B9Oh2EFuf4UM8Na2fjUaWxfJZD
 IkNl6vmX8v0dbFkMdlFR28OzLtFe4KsmlRlQZV2vNR9qzYD4M6Ke6xpC/d90TkmCW1vW/xfYSfL
 EGD7x6qMIuANUSEetW4TFQpLzZnJeQb172OzGJhp8psV21zHlDU7Yvbmhe/r0DV0lUHy5Lxpjqg
 0ueiYA6GIydgbJmlSF0CSEeCqXfCsXS51d+X7MLXiTD363AAfMqoUe48b7vg6fNi54RFzWTNPCn
 nZCiQqT9WohFxM+vlNAIvQVDC0fPeriBBziu8HaFnQ9/iPxjGOKirniZ30LF4kN/NSgxFxhhRh/
 krQRUBs4Obq2ZvFao/FJ3wsEcIq9coZKpJU55pu8oFZozwwndzIw==
X-Received: by 2002:a05:600c:8b76:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-483201e267emr3481205e9.12.1770313990208; 
 Thu, 05 Feb 2026 09:53:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e1099sm667185e9.6.2026.02.05.09.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:53:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 5/6] doc: add AI-assisted patch review to contributing guide
Date: Thu,  5 Feb 2026 09:51:36 -0800
Message-ID: <20260205175255.652963-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175255.652963-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260205175255.652963-1-stephen@networkplumber.org>
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

