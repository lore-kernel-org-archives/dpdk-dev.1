Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323DFD715E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 19:03:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E666F40278;
	Sat, 24 Jan 2026 20:03:00 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 0C07140269
 for <dev@dpdk.org>; Sat, 24 Jan 2026 20:02:58 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so46707565e9.0
 for <dev@dpdk.org>; Sat, 24 Jan 2026 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769281378;
 x=1769886178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoyvPd3zp6//b+kuzMQvzqXAKlGq/3b9s/Q5p1C5GM8=;
 b=OKiKJIbw7hPn0RC/G9+v1eqQSFrt8C57gNW9+mUWlJWUFHuc628Og5Fp5WMd9/52pf
 VLhYLNamrKAZ3wxoCOGjhPDHaAo83ApwcNxuCAJY8mmuRHIg8OVET3qwi80bDdl1yFID
 iZbKHJJB5F/VzaXYJOb3ITeAiVLRUwdtgCQY98unV6Uum1QFw3kVBJrRripfWItZXIpK
 vPrFyznufH2V0Y2TAkHT8khQrvaZKxjzsrwEUVLWSIDav5m5c7g533gvWOPTXipsev5u
 WaGoyxtduMSkvsW5nS6J2gw1ilc37xe6r0BEdXhXnR/sS9meh8WDJYngQmmdGQZVRH3J
 pePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769281378; x=1769886178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PoyvPd3zp6//b+kuzMQvzqXAKlGq/3b9s/Q5p1C5GM8=;
 b=gK8waI9z153GbKiI/nBRSKdEsliTxayaRELiYUfVeAm1bFa8akQR1TItHO1UyUs3Qw
 Gt4fdxzWSoWKpjobBZ/wzb0fnqMhUuHHcTJuWMtsbF7GEjQGqtfQbsj5cYR67MJe32ng
 bkDHB6YFkmUehfhJmQ4SM+5QYqkxxsXWW9ma93ezSzb/FwyUWi+PFaxF5UwSKJ93MaMI
 3GNtZUNnh6gS7ylcCA6qjtAt4J6OzWDl4a/pcF/lEsWxpA48gHnWtXtPlBncDE5HDjn2
 rTsr/6Ty9Ktk0XRSIeKgJTGLWWWpewbhI619gvyfGLJUfixie6QGPVvJq/OSIn/f54+E
 NeMw==
X-Gm-Message-State: AOJu0YyjscB27ucXYTH+B+OfaWINVTuLsaBkgioZ1XkGg/VVyXvkAh1X
 chEizlR6lIlAw2utQNDJEBAYitD2LEHJsFUDp37w6rawY9gDTW0DROj2K0Qthh5d3tZ2xm3ZeAJ
 KnAt0
X-Gm-Gg: AZuq6aJlqEqP967kES3E94Vlmr7E7PvLYTyyypLZyT7aR0TcoZ6kuh25Bxt8W/TERZz
 SpwbxSUxRwAtqWtnxBGGnLWTvNBEuMDmmMedUPn/tqLVgHkPQu4AHWEDfpcxtODmPqPZA9V+sVW
 jngPOhq07wkP2l3INlcK/RRgxbS80uWTpEqDcwruMtXkiZDk6XrTYpbmeMIBWXMVLugR5xgEV64
 V6iXdXnB1cdoOQb9U8ebfV0ANwP+wPcDTN2jbGAgnHyIyEEZvi77HErR5YituJqyCububCnm2Je
 hGcpCeDyixl1W86tRjLx5drDelLXfTLe986aihPLiEYO7aQmE2iA2jvTVuyiowRz+qfYdp95KBT
 WSo99pOOtF9ZyKRenJwZX3zMuPekMEKifM2QnV4qH1+gLWix4Lx3tRPoYvMS+VkUdqniihKMM58
 PsIlJODMDQAIWsFplC/2aIkeLR7eXbB7nsPdjdXaKBWHjkER25wQ==
X-Received: by 2002:a05:600c:8b77:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-4804c9c1352mr113280555e9.28.1769281378135; 
 Sat, 24 Jan 2026 11:02:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745e6sm15661277f8f.33.2026.01.24.11.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 11:02:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/4] devtools: add AI-powered code review tools
Date: Sat, 24 Jan 2026 11:00:29 -0800
Message-ID: <20260124190253.216424-1-stephen@networkplumber.org>
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

This series adds AI-powered code review tools to assist contributors
and maintainers in validating patches against DPDK coding standards
before submission.

The tools leverage large language models from multiple providers to
analyze patches and documentation for compliance with DPDK guidelines.
By catching common issues early, these tools can reduce review cycles
and improve overall patch quality.

Key features:
- Multi-provider support: Anthropic Claude, OpenAI ChatGPT,
  xAI Grok, and Google Gemini
- Review patches against comprehensive AGENTS.md guidelines
- Review documentation for spelling, grammar, and clarity
- Multiple output formats: text, markdown, html, json
- Email integration via SMTP using git sendemail configuration
- Cross-provider comparison for evaluating review consistency

The AGENTS.md document consolidates DPDK contribution requirements
from multiple sources (patches.rst, coding_style.rst, check-git-log.sh,
checkpatches.sh) into a structured format optimized for AI review
tools. Severity levels align with existing validation scripts.

All scripts are implemented in Python using only standard library
modules, requiring no external dependencies beyond the AI provider
API keys.

Usage examples:

  # Review a patch
  ./devtools/analyze-patch.py 0001-net-ixgbe-fix-something.patch

  # Use a different provider
  ./devtools/analyze-patch.py -p openai my-patch.patch

  # Compare reviews across all configured providers
  ./devtools/compare-reviews.sh -o ./reviews my-patch.patch

  # Review documentation and generate diff
  ./devtools/review-doc.py doc/guides/nics/ixgbe.rst
  git apply ixgbe.diff && git commit -sF ixgbe.msg

  # Send review to mailing list
  ./devtools/analyze-patch.py --send-email --to dev@dpdk.org patch.mbox


v6 - add output format options
   - add send-email option
   - use python rather than shell

Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add script to compare AI reviews across providers
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   | 939 ++++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   | 733 ++++++++++++++++++++++++++++
 devtools/compare-reviews.sh | 192 ++++++++
 devtools/review-doc.py      | 892 ++++++++++++++++++++++++++++++++++
 4 files changed, 2756 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

