Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA43AD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:42:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 051B5402AB;
	Mon, 26 Jan 2026 19:42:12 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id B2F9E402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:42:10 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4168630f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769452930;
 x=1770057730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SVbfe6crFvbYEaV7FKkRoviskhV1ah8enquZGXC2PI=;
 b=pHzNEa7QlD0Z+yGipd8d+z1ZFRoo2gGyCQVV7RhOJmRiouTREMWW/ZSFq2J8nnli/n
 4SfDtSWynkge1XVSnz/1KJKxJMbOFLLn3PCTWQqbUuJovnRDFLyGc9oED6JwnZmTPlJi
 DCRzm+Az6l2Z2Kb0JlxvXoHvlh2Gl/Bj6f+GKXgglWH3h27ciDIEtD2k1m3rbqaaVrL7
 5q40jOYc7AraZQ80H7Y09ieuMxg7yfzNEcSxdscxZmV18+hafOSuwgkyWFc/HxQxC0pi
 sGNOzgBb+k/FrLnMO09drIo3cu9Zx1WzPuwtpvT1sDcqHhYwvWmWYeVVNhRa6fYAg8ac
 4JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452930; x=1770057730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6SVbfe6crFvbYEaV7FKkRoviskhV1ah8enquZGXC2PI=;
 b=m+S7vQoomD+UogH+RJtZUbQNED70Lt2dyEbtD2RuKiszmPM58uLMkX5pNedCY/DIRx
 3Z+y/DisbdVtpetu+rL7vWQfkbQwDB2f+EShHro+kZzugkuk5FkG/E2P0qxHYHBplvRL
 c6+WrLsm+BOkQSw5a6rYYIPVj3rohreIRURLQpfLOpqLhQBdw+/homrHeCJTOE6Rph66
 1UEwuR/btRh8FEYqQyxo9qbk0W/FauK4rjKfov3zopF3tLo4Z+oeBhNxvivlfOggdY4f
 iRkxbfdQA3SdvlAt6PRVkCaSvTYMkl1Yo2jb3N3tz+6semBxkuuHjDiXdz5O3KwWKdU0
 50DA==
X-Gm-Message-State: AOJu0YxkN75FrJo3w5xGKI5HGhKB9KsqkavSIkMixH0c1umYa2MZg3ET
 PEMTYBv+l2GcJOydTus8dAz5XEJ2qIGxDKnwu/Ns36mrszggRuRJU8iHAM8QWT5rnossi0yhT9k
 FstNvwBo=
X-Gm-Gg: AZuq6aLt6heRgkI27gYjlSfBs9g0ThBgK4N5qix8MXAC7TuLV0kV1wU5l9QeBi6RsxV
 JQFgRzEJNOuZ8uXOClXUCiVGIVlFHvBSahPA/tGKjqshXgpNflKXM5n8q1/IhkO6N8L3AZSHik/
 cmOz+uf9zBzByrPsfwE4v3Ge3Gy4pJzoFq2f0HgERG31tEn4ONhEX//etLhUjhkfyTjzhSR2oAc
 /bO58DCLeIXE4/Ntr+OEflRI+xlYFMFSpLS9WXSFm7+IjcjXAncO+gQo8vOVWVLXxw4jls3qUYh
 eUc8DogP4r3ffNTd2uaENSiVTgn5exrt/ZEZvzo/VXG/rI65AJOGPlAJ2HkmHlqHQjroiZ8k29S
 uq/TyiHOM50Wh7EIkNtz+rHxOmDCyjqB7gQzo8Q2fwZ4Yu6pQap4JMHu30Q/TYv2A0xgTSYtqWL
 ofh9lC2uGhbDvpQGeDLPadbM04aE7EQ6ohFrQwpVjKVke9Da34Ew==
X-Received: by 2002:a05:6000:2888:b0:435:94fe:76bb with SMTP id
 ffacd0b85a97d-435ca1b0aaemr8559786f8f.43.1769452930121; 
 Mon, 26 Jan 2026 10:42:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33210429f8f.13.2026.01.26.10.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:42:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 0/4] devtools: add AI-assisted code review tools
Date: Mon, 26 Jan 2026 10:40:17 -0800
Message-ID: <20260126184205.104629-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0260109014106.398156-1-stephen@networkplumber.org>
References: <0260109014106.398156-1-stephen@networkplumber.org>
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

 AGENTS.md                   | 1000 +++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   |  731 +++++++++++++++++++++++++
 devtools/compare-reviews.sh |  192 +++++++
 devtools/review-doc.py      |  974 ++++++++++++++++++++++++++++++++++
 4 files changed, 2897 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

