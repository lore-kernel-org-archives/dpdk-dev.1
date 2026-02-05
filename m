Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD34ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78EB740684;
	Thu,  5 Feb 2026 18:53:02 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id DD551402E6
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:53:00 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-483100e97d8so7748305e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770313980;
 x=1770918780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vVl+C/myu/MggOPx0MHK7RzOOd8uLv8TFL5os2V3lE=;
 b=3dwN/DpBCPqlvrJnuz8ctPjI1bTanJLF3WiCVuoptP18BIElmViDwS9uTuxq1JMvyP
 4Z287kGC1SyeMsdHVfDGMLA/u6SFq5NsZ9SkXJsjjHBhC/Jh25bCOJ+CyCx77SrtcI/6
 jxGKMtICw67Fv5GiPMjRf15HHJpr1eqcframYHyGJXJmUXtrNVEMHZOOBHtai3oSKtZm
 g870/TJjIv5KsaFErVwT/oy+g7O0l8yTJUpm6k9YPie3jCOQhgzEcyEzALTuCMf9d6pc
 wwRfuRo2CyYbGE24jELsS0xtNykge9Vu2mfd+7OFcHTd/BzhLx+3Tgte7n8fYqMMImSY
 Hh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770313980; x=1770918780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2vVl+C/myu/MggOPx0MHK7RzOOd8uLv8TFL5os2V3lE=;
 b=FHlHVNCDnni5h9DNNYOCYISVC9NuUjrgwgqSkVrrnUUJnZmPfxYiMvQZ/ehKdWPtzZ
 AyHNhSdDOA/uGepQiJu9JfMawSLlKxmkl79lY+xoD8+oHx5PPaEmvNmRDe8dWWziBsU2
 9mCEstvc1uLkDYC21LTx+YHBET3j0xExkigA6N5MUI+QlVevEyZ2RE0bsTrwCTbUkhTN
 jfXz4pqcpusNgGaAVIr3s8Jq4OX9FwC1QZeKfnp2V9BfhfIt76I8CEosv6KHIFXgIvAK
 uL8i6dTe8KwOph6H/xHM1+B7vDN07hKEiGmcgGwSbhp3tyIENPEW/dj1uWtLMJ7tXm8C
 J+0g==
X-Gm-Message-State: AOJu0Ywf2Ct34dAS2czfbvbuwwvQIDrJ4mLoeUj3k47+y8EgxaZUXKTt
 wWGs9A5Z93CThb/mAx/GSYnEETNOWx8IT21LD6ztQ3iG3eie/B/mNqxMzu5jBSANpmTUUEl9HJ5
 Lk0sgciI=
X-Gm-Gg: AZuq6aLbpkiFq1Or4RiK2qpgNLq17wB4hCiW1HzTYioNbQ1iLNxFAV/exjDZ93GVfqW
 QXgUAvCNZJtrot6rIV4bEH1BFeSpo+cE48sIfKlX3Erz8bPgsp1K3xGRO5FJCzAFWINaZ4uU6Y8
 J8hHEp8u6f+KMLhImvXZXu6oAd4mFY34ShgLTFcbyMiYB+CdBKRxGNY88iROFrinj3jZDoHAUZ1
 jo8iDpDbklRzRsVOUN5BsVOkJMnJym9M8c8jrIviayNUrLvoxacJQydTAFuLfzTFONPMW94Zt1k
 Msf3wxQqxWNKAHruVXIG18csNwC3/bww2UHNNIaE7l1k3GseEUt5MyQTHDSn5BenotHioCyiCru
 b8Xdza8C9w4GYKTc/awYPaMyApes1K/LNHMsSzA3WeBzCEwf/2qh1Y8BSioyklItX2pXVmgma8N
 Es6rqbR2I3s//wcx4u7oS9BsRkM4VqbP0SmrrHqaTXHkP8JbM7jQ==
X-Received: by 2002:a05:600c:6290:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48320226676mr2855005e9.34.1770313980382; 
 Thu, 05 Feb 2026 09:53:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e1099sm667185e9.6.2026.02.05.09.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:52:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/6] devtools: AI-assisted code and documentation review
Date: Thu,  5 Feb 2026 09:51:31 -0800
Message-ID: <20260205175255.652963-1-stephen@networkplumber.org>
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

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1392 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1334 +++++++++++++++++++++++
 devtools/compare-reviews.sh            |  192 ++++
 devtools/review-doc.py                 | 1098 +++++++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   56 +
 7 files changed, 4082 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

