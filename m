Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77098EF99DF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 21:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56186402B2;
	Fri, 13 Feb 2026 22:41:14 +0100 (CET)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67]) by mails.dpdk.org (Postfix) with ESMTP id 0A6404027A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 22:41:12 +0100 (CET)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1461381f8f.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771018872;
 x=1771623672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QqjrixFagRLOC27UKC5iQ0lHfdvciFsdIQg73rhDpE=;
 b=gWWKdUnt8lKIW0ApEgctk3nMZ/77VT7S398LHtqPtGNOg6C46WzbHfE64tp4yZVIH5
 zFdYAcGoO/Dv1fD0Qbo7bigt+8wcmHy3EXSqyBZy1sqOr6Lz06d5RkS024fpkeP5NU+0
 k0nPLQLS+zwJPPJtNyanHD+VPNLv5SY3usI1pIo8zsncTUbtW3AbJWQB4ULBBt7tfK+C
 fTt6eQ2LIreWDDFX+jMstJGH6BLmrn6LWtAXgUMdszL0MjVGaE4PglP+sxkvXlncCFcA
 23UK2zSbo16rsisWE0GPRTXbA7xYXrK7S9xzB70SqfmMCSCw4gEKuDMHgDyEXXOWGXAc
 nK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771018872; x=1771623672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QqjrixFagRLOC27UKC5iQ0lHfdvciFsdIQg73rhDpE=;
 b=SEmeTd8q7RmgioB8BpkiFDPb5to+UTx0FyIJrzYMQU0EDKCoXpPVQplCX4NeTi3Ou2
 r3/v7D+1NV+R0u8HyhJm29hn6uMfgEIU1SRacaIrRaRK5hqDy+7VJLkR7LVLT/fwEyLl
 UJfFm1CXEB6h7PswrrbpuMiclIPJ6nYQ1XsWbvzlrV4GC+HI4gEdL7B2R0NsWcgr9Hy6
 ZbWTm+ZuwohWm7B52fuAH1rNZ4/3Ce8mmqt4t09F5RWDPvAS2hP0ckGF1/rFxTE1MNeL
 +OYSexRrDCVywyMitllDMPaO7m2nHMt1u5fGmXFfV2jsym1wO5PzbYGuDhY/u7OWl0el
 RPow==
X-Gm-Message-State: AOJu0YxeF66z0LAFIWTel7bVKnmlazIgaipSVAC/+agoeJebU/6nBlJB
 GpJkJ359NP1sNWUX/G9yOHk8th8jpO/7AoFiS4zQGQp0NwITltOr5OzdoyiBhKb5n1SFN2l+7ft
 zjzEcVYQ=
X-Gm-Gg: AZuq6aI7Idg30jpxWczlQwilP/mAlSYeVYbQgFsqiLWJr2WZCYYhlIgk6zCU+xZxS2p
 Acb9iucA0w138DrHqlgns2PE0bBVKUPDC28Ltr24m8EOr687opfBs5Wo+V7W22F30R0dLYMVAGt
 t13NTVue/XV3IICOUaPJLAEiw/LgzUsDiYHOhAsW28gbGnNU69wvFuTMtyhWA2Nr/YxohdH8JDl
 p3P6ePyP9cpRZW+0he/w4vCHeMpKLgRSHLGDXIrP2g08hxDvNu7TTZmKm5+c17hzSYuGHeJRnb+
 uOBks1Memm+uCDEkdPYlfD/88Aw8PsIflcT6WiQX6PqM2LpgxKmchw1dPOfujBhvGKNGU712eLj
 cNGKHbkDnLJVj0Rpx5PJEsOB37UVFWkZ9N4EzJgGHPCEoahofumQ/sEna4j/KupZ1MX+UbyxsJd
 rJC5aTb95TkEK4GZtBeEnMwMmOUi27oTBHD0WMIl7zNw1qXI3jfEz0zhvdMA2MRS2EHJkYJaAt
X-Received: by 2002:a5d:5850:0:b0:437:7010:1cf5 with SMTP id
 ffacd0b85a97d-4379db31b4fmr1881880f8f.5.1771018871900; 
 Fri, 13 Feb 2026 13:41:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm8346895f8f.33.2026.02.13.13.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 13:41:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 0/6] devtools: AI-assisted code and documentation review
Date: Fri, 13 Feb 2026 13:39:05 -0800
Message-ID: <20260213214107.234072-1-stephen@networkplumber.org>
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

This series adds tooling for AI-assisted review of DPDK patches and
documentation. The goal is to catch common coding style violations,
commit message formatting errors, and documentation issues before
patches reach the mailing list, reducing reviewer workload on
mechanical checks.

The approach uses a structured guidelines document (AGENTS.md) that
codifies the project's existing standards from the contributor
documentation, coding style guide, and validation scripts into a
format that AI models can apply consistently. The review scripts
then submit patches or documentation against these guidelines using
any of several AI providers.

The series includes:

  1. AGENTS.md - consolidated review guidelines derived from
     patches.rst, coding_style.rst, check-git-log.sh,
     checkpatches.sh, and the Coccinelle scripts

  2. analyze-patch.py - reviews patches against AGENTS.md using
     AI providers (Anthropic, OpenAI, xAI, Google), with support
     for patch series splitting and LTS-specific rules

  3. compare-reviews.sh - runs the same patch through multiple
     providers for comparison, auto-detecting available API keys

  4. review-doc.py - reviews documentation files for spelling,
     grammar, and technical accuracy, with batch processing and
     multiple output formats

  5. Contributing guide updates documenting the new tools

  6. MAINTAINERS entry for the new files

AI review is intended as a supplement to human review, not a
replacement. The tools are optional and require the contributor
to have an API key for their chosen provider.

v9 - update AGENTS.md to cover bugs that were found in 26.03
     and previous PVS studio scans.

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1767 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1334 ++++++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1098 +++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   56 +
 7 files changed, 4457 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

