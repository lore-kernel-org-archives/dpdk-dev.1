Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DACE6BF30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E125402D3;
	Fri, 30 Jan 2026 18:42:57 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id BB3FF4025F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:42:55 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-481188b7760so16816265e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794975;
 x=1770399775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcpnvf5bD9/UlYGfcSO5g65RE87GapADzXvLuvHP7po=;
 b=ZuHeoMhWp+fJBPuo+1nTC+aOyRFFX0E5I0KdAPbtqtiH2EgXk8Yk3NTHtJRwoYyb7E
 9/QUotmgNDgw9vIkRqEmSnOfg+JK4U9wlDrYRHgTksu9rTmygsD1fyaEpmV+UsfUX/qH
 NsxG+pGMyQxSZdCdTr+Je8WlHGx1kytAgMvmIj5HCUCxT5RwCo+9h9XmvxFkOxwPn8OB
 x+dgHogTAj8Zwgh4BzZ/+WJmsIbwU50lUySvE0FRMmhsjbcu6/+qoVazbjr2gZxO7Pt0
 qxThZz1O/IUBM3k3GpBDU/AzDA5K5bAq3ja8N3TygjRBu5vxHN36ysIMotTXrxE1um6i
 ULtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794975; x=1770399775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcpnvf5bD9/UlYGfcSO5g65RE87GapADzXvLuvHP7po=;
 b=qk93oep+lz/BniL6yWQ+QpPrSLPwkyraooVqAfw9ALU7LK0Phmbu9f8UC/FM2yeG3Y
 R31cWigqowuR6ofl7OuIOVB4wo/iF84tap4l6LHL3wusCkH4ArrVtluv5COIpNkhuRB8
 dFXYLBT5vKjhQ1VnoKDa10LjB9xb9lwznUilaZrXQZqk7vlyblVtOvR++RnTDSsOHMRI
 biVupZdfLzygRrPrnKkLo42PeIDdusHmuvblDQWiKfqe4hi6/MTiTAxY9I/bNiinNQiN
 qqsmJZou5BfQE85VJo7opa5pObpIvWc1szjtnVx6m85iSvLkFTsMy8QneSGLL29BAkjJ
 iOgw==
X-Gm-Message-State: AOJu0YxKKLLPrgJ49rDMhMlZxdyKmbreRwhtA0TNElmhPp5qggk9G8L6
 liW40MFLFzw4sKouHslB96vo6sfVrFI6tJmXzeWbBYehsUnqOwkalLnK6jB0mBNBQ1Pgf4IJAJn
 GR7gN8yI=
X-Gm-Gg: AZuq6aIHTOK18EK3+g3lc06SfJSON7rf887uPsIOVSes2C4gjCTjhH+oO/Rztw+qAb/
 XyeFndVDTjIfOawfnIXOE0FKrBjGFI7bn8FlF8dPRvbY2TubhoDB8ZBNYWfKk0Q+QMZ4/w/vvRt
 53QknMtqv0LMpwQ3HowbBJQSlMmI1RxOpw2A2w3mNv3upoufug53HVXokzcyvxnV2etZxP2NpPM
 S3AxPZTNJnPYu3sS1jxRDcYfOkFzWBEphYGGsJpb3p4azYislm3Z2WRpWLpKy6cMuP3G2tiv4gd
 wS7/S45lBy4Vz4nej6wofJkFuiucPsi72AXVXmSYVrSHmUhYfZTE5LNGKg/TX21fcYoT1CiBplH
 XT8R6GlrAWsP35L84smY75astoDzn/6sKzLLKw85eqWV2ocVjMwKmBicLhP3PTeXQESUYSNudJB
 f5XqtGM/zYACUzKllnPFAJqypNDOLFvDkEkMoTUJ2yF7mSldPOhu4RNacbuQ75
X-Received: by 2002:a05:600c:818f:b0:480:49ce:42cc with SMTP id
 5b1f17b1804b1-482db45f4b7mr49364805e9.9.1769794975234; 
 Fri, 30 Jan 2026 09:42:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d98c8desm182241115e9.3.2026.01.30.09.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:42:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 0/4] devtools: add AI-assisted code review infrastructure
Date: Fri, 30 Jan 2026 09:40:59 -0800
Message-ID: <20260130174250.15358-1-stephen@networkplumber.org>
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

Changes in v10:
  - Catch misuse of pthread_mutex
  - More language to defend against false positives
  - Handle large patch bundles by splitting mbox

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


Stephen Hemminger (4):
  doc: add AGENTS.md for AI-powered code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script

 AGENTS.md                   | 1375 +++++++++++++++++++++++++++++++++++
 devtools/analyze-patch.py   | 1323 +++++++++++++++++++++++++++++++++
 devtools/compare-reviews.sh |  192 +++++
 devtools/review-doc.py      | 1098 ++++++++++++++++++++++++++++
 4 files changed, 3988 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100644 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

