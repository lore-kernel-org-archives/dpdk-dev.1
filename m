Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBBD73E88
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D5C34026F;
	Thu, 29 Jan 2026 21:41:19 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id E08264014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:41:17 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so7601545e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769719277;
 x=1770324077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siCaLr99kpUpKYcP7HbtCpv2Vnh0cWZSPQEdDwz5aRE=;
 b=BDoBBTmRDKL0EQXrRua1Dt6Ym+jHqtyEVfQLhbBgV35Wx8Xpa4kvzJdJlllBCH53Zp
 9nsF7Mr9fQRhrM5OhGp1Y+idlihwNfx3Z+s+9FRkZX7F3q7LMtgmvR52GT9nLnj+f53i
 k9xqFlVWNU/RgbNPgPtZ0X5raKp7HEpIUzhNnYC7AMME7/R0UHF4Z7y/Uy/UQP757bpp
 SoIktAuLyOXueWfPNMJEqXSBwNcV4qX2k0+0rr8qcOnUBNsDyKwIHVQB71FcVxiubNNv
 ElRfsxAwUYmgBeGG6a/njbT6NJp9vflaho0LxHLo5cBnXu5mH9kDssZUQrC0SmADx1Lc
 6tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769719277; x=1770324077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=siCaLr99kpUpKYcP7HbtCpv2Vnh0cWZSPQEdDwz5aRE=;
 b=O8MNiNZptxziTmnoJY3a6y4848GoLIDGjsxsh18Ki/roE6cke+3vMotnfzT8gwJ4Q6
 0TFw2pu98hXDiT7xZQ+KzAkJfCGYTVTxf4cTpTalSBLK4S9u82k2pUHUYsACpytasO7v
 Q8RwJvNHjHWiJeSXeX8sEVSmb1HLntjBQfljUoGJzPGc1buXUs9Sc+7joWBhC9vFRml2
 fQRfxtibn2Q/HlH3NfMqyRuRrr0U/7Se//x5dEQGWVXASMEWlZXXlFGCAROfI09bYl/6
 iLYLO2IudlLNru4ZVwV4dX2pnobGpHdcwT8F8QdXkuw+NmYnqNKsmErqBbThcRyRn/hr
 curw==
X-Gm-Message-State: AOJu0Yw09AFgFi+iPgyF2AfP59AABDex2sh0cqeQORfFKppHr6uVthmQ
 w6fSqxEmGSl4TEA4rw78jBMwOTI8mmBwubNhWcu+tg2BFPzYVnrSR7TbOX+bzbl5mf5HCy8hARm
 1gUvI/FA=
X-Gm-Gg: AZuq6aJ8qHcwx/AXxo8knsqVr+E5mEcR3Pa+rRsuSqSKDmkiusW/XBme7tfJd80UPhb
 DW8JEHeFO09y4/Nh7gGAAcj0J3SEmTQhpRkTE+hiAEM6WY1ybvequLEyu5be7QsEL1r28nTwtCu
 gZd4R24v4BMTL3BbnVH/7nzcRm4z/QASlvsHOjTvd620oXvlT7AZ0sXA5nKwSoGmq4HnDC1jixZ
 seCDR0LnBJYNlUyT4cf5uDWeV/aB8NiDMwxfruUmUru8PyuJSFkPXEfjeYEMnSv8MF3iqGgQd3v
 wt6m1ElQdGB9ZxPEbgR3JUSdps2B9tAo/SnXv3tcIDdc2MeEYnadkZ29snDLh/Rf81uNRJgTviv
 qgv+sBpmbYLVWQAqkaw/zAjM39eZ2t4RjPQ4Km8vL6Ilpee+pi1ohgN6GPNQxConoPdUGIsXb5m
 uMw+kwj89UCflyBZoSRwkCLeb76dRlYrbm47fjR5yeCnnFh8+yKQ==
X-Received: by 2002:a05:600c:a00a:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-482db47d0d1mr5334575e9.24.1769719276997; 
 Thu, 29 Jan 2026 12:41:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm157551375e9.6.2026.01.29.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:41:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 0/4] devtools: add AI-assisted code review tools
Date: Thu, 29 Jan 2026 12:38:14 -0800
Message-ID: <20260129204112.174523-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109014106.398156-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
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

This series adds infrastructure for AI-assisted code review of DPDK
patches and documentation. It provides guidelines for AI tools and
scripts to interface with multiple AI providers.

The AGENTS.md file consolidates DPDK coding standards, commit message
requirements, and common review feedback into a format optimized for
AI code review tools. The accompanying scripts enable automated patch
analysis using Claude, ChatGPT, Grok, or Gemini.

Patches:
  1. AGENTS.md - Guidelines document for AI review tools
  2. analyze-patch.py - Multi-provider patch review script
  3. compare-reviews.sh - Compare reviews across providers
  4. review-doc.py - Documentation review with diff output

Changes in v9:
  - Revised prompt to cleanup false positives
  - Added flag to analyze patch to work for LTS releases --lts
    and review date

Changes in v8:
  - Batch processing: both scripts now accept multiple files and
    generate separate output for each
  - Changed -o/--output to -o/--output-dir for organized file output
  - Added -d/--diff option to force .diff and .msg file generation
  - Added -q/--quiet option to suppress stdout when processing batches
  - Added strip_diff_markers() to clean output in non-text formats
  - Expanded AGENTS.md with additional guidance and examples
  - Improved help text with better examples and documentation

Changes in v7:
  - Add "Review Philosophy" section to AGENTS.md with guidance on
    confidence levels and concise feedback
  - Add "Priority Areas" section covering security, correctness,
    and architecture concerns that reviewers should focus on
  - Minor code cleanups in analyze-patch.py

Changes in v6:
  - Expanded AGENTS.md with "Unnecessary Code Patterns" section
  - Added guidance on rte_malloc() and rte_memcpy() appropriate use
  - Added symbol naming guidelines for static linking
  - Improved email sending in review-doc.py with native SMTP support

Changes in v5:
  - Added review-doc.py for documentation review
  - Added email sending capability to scripts
  - Expanded forbidden tokens documentation

Changes in v4:
  - Added compare-reviews.sh script
  - Multiple output formats (text, markdown, html, json)
  - Improved error handling

Changes in v3:
  - Added support for OpenAI, xAI Grok, and Google Gemini
  - Added prompt caching for Anthropic to reduce costs
  - Restructured AGENTS.md for better machine parsing

Changes in v2:
  - Split into separate patches
  - Added verbose mode with token usage statistics

Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   | 1198 +++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   |  862 +++++++++++++++++++++++++
 devtools/compare-reviews.sh |  192 ++++++
 devtools/review-doc.py      | 1098 ++++++++++++++++++++++++++++++++
 4 files changed, 3350 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

