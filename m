Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD8D46BE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF25B4026F;
	Wed, 28 Jan 2026 19:24:21 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 0187F4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:24:20 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so1033585e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769624660;
 x=1770229460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItcZ5b4opyF8pdNqw/LXryr2dGOr9F6GT8Lax5qf7D4=;
 b=ZYDL9TBYn6IGJykhTNR2ov1jphsMJT6KJbugQN2DJ5XwByPR1uuRh0MH7Z2NV0XfmE
 jUvKFHwxTGG6tX5/5SYSfuV29j3/UehYnd2azkIxxCcQ+sGJCmiQDXiOG2LgvdnLxIpo
 VuTlRyiGloDNPQs+B1soi96Pjv6Q5sWidVie1Anij0dCnEcNyZWz8eNVmjxD95KDdX5A
 ZsVM74H07Nyk+3lj0LsBhAJWSyU6+Hn+0QRKE0MXdk5/6zPDrYAmDmy0iGOzk8uI4gNs
 c1BhyZFchDTR/0j/yq1EY36KgBdDjmcnX6kw0PJwH6L8hAEv4fh34g9gjV7e5orqR8qo
 LddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624660; x=1770229460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ItcZ5b4opyF8pdNqw/LXryr2dGOr9F6GT8Lax5qf7D4=;
 b=c59mbLFk23tnLNUUtpQca4qMf+TMGJ3tLi1TDXfZ99DXiNrSHwjtfQ0cEm6BVU3ub8
 SxRWSr8ap8NuUPDqJPNDxSAklKTTNPKh0hA5s6UfNc03mYI5yRuAFJPxAGGQwgQXdBHo
 RTU7I+RIyZicgcHL3OEzzsixggA2IaTwUEpnGsu/bM8sn/Q+f9ShjNiCGSPjLKVujPsH
 ZaeXxTB/0XoJMzdjXAftlfjg6iAfsD8ysICOJyOEItNSOBiax866Z0T8RddbCe5mgUr/
 DaC0SoGgKoAKMgiEy7D1vJpA6vjxd+NAHy/Dn6+Ea+pJZI6nWiVAHJrUgjWG4PeumPu6
 Dcng==
X-Gm-Message-State: AOJu0YzVsch8mdWx/iMTFLHghrGnUxCiVyF/dV79yTHz2erqyTRLqhkd
 MajeO57D1u1/HxTolQAPA40r/f7To1XJjnhQRWexWPL0xrUxgbsQ1FthT75dzC7TNcOSMlgridO
 1z5LJS8k=
X-Gm-Gg: AZuq6aIsRsaHA9mWfH1aDzHpnB3s1IXKxKkQ7HNKHmHRV4toCcISMuBlxRjimK6tNmd
 ywB7V76foKd22KGIy00XCpJImJqnETKriX8jx9anf3QzmhDB3VKyw3bJ3Ay+oP5gUl7u3lQrnYk
 axcMS7LO2MaeAIVnKHecz6r4eEcETa/VRo1vZB3Ez/uRDYFNKiSdEgCCPkTYkf9Iwgt+ZmA9tfM
 EBQOhEvAYK14KuRjEY4KiutCk3SgaaUb2dR9Xscd5im+D7wkXwOavOqbBMIZtZ3DCmGcu7NYQvc
 EJKFI2ljt4ky7CLAsWCu8DIt9jDRL1XBkLJvc1gFLLy/PxTzGJhnvSXJOuv1ymKPyjGPrUeW4UV
 aGctM3VIn6hYFS1CcrxZ3pP0GyFxmNLV+qnqI1Q+nsH9x9hjkX5CopUuA+Ub/rCO+Tseo9P7Lvk
 R/S/y6y4iNhy9Ow2E9PKZNGn0XbyVRsj0snJjCEqhsgOGdXd3htQ==
X-Received: by 2002:a05:600c:699b:b0:477:8b77:155f with SMTP id
 5b1f17b1804b1-48069c3f914mr67479925e9.8.1769624660398; 
 Wed, 28 Jan 2026 10:24:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d883b12sm1017245e9.1.2026.01.28.10.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:24:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/4] devtools: add AI-assisted code review tools
Date: Wed, 28 Jan 2026 10:21:49 -0800
Message-ID: <20260128182401.384530-1-stephen@networkplumber.org>
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

 AGENTS.md                   | 1066 +++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   | 1006 +++++++++++++++++++++++++++++++++
 devtools/compare-reviews.sh |  192 +++++++
 devtools/review-doc.py      | 1098 ++++++++++++++++++++++++++++++++++++
 4 files changed, 3362 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

*** BLURB HERE ***

Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   | 1066 ++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   | 1006 ++++++++++++++++++++++++++++++++
 devtools/compare-reviews.sh |  192 ++++++
 devtools/review-doc.py      | 1098 +++++++++++++++++++++++++++++++++++
 4 files changed, 3362 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

