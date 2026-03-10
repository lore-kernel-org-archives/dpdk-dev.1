Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCAFCC9A8
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 01:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 357C140285;
	Tue, 10 Mar 2026 02:59:15 +0100 (CET)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 011094014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 02:59:13 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-466ec4c6852so1626540b6e.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 18:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773107953;
 x=1773712753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYzRyjG0ILlx88jCoXGc11TA7D1MKEekJJJvzd6RXjo=;
 b=Zd6ZGEJY0dDc2+OhfdNqICG0aTHO9Nug5++4qG3LYo2HUch5Hb2H7y6aaSOONLlKZj
 aNz2nJK1VDN4Wy8DLxxFb4cyUDX+TMNYNWP2gAhWDf8P1majfNfJmLQk0Z+jnq9MI3gK
 ePkLc6D1M867jMcZ2nbDerW9G7kw3IS85uhF3wil+QjZTNqbj1eiy5B4hOgF3yMNnk37
 gkoTDFdkoS5nI3g7OwkV3jeYvGpM+g+NKxKWwlOlqjfba6sYDo9jxpwcZIy8Ib873PkY
 5WYBIsa+/SZ8snRmce72MOdp/aDwFRnp2BPqtftKgbucWmA7xOzwsrKprfmjYr30jCe3
 Ng1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773107953; x=1773712753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zYzRyjG0ILlx88jCoXGc11TA7D1MKEekJJJvzd6RXjo=;
 b=rXpC1w6b6OzKTY8B8Lt6aEaGVTmm3d6v34KEuzg+kKIZr3etncsR4SG1ocGxUhxqi3
 mRsRG+OvMmnWiScweLjpSYAh2LbOcqc04X7DL0EkLVVjQK6yHCNkaPRDRZvv2p5Ky2TP
 So/WYBcB6NeBiUEoM1Rpcdf4cFLG/pNuBxfbuEpFchrxkwDj/RIz6Fc+1VVSpsMgv3eO
 2Ve6vi+KVeqHZaiSPBIap6lO+/rX6KwHz4EAYoXq8javuR4iZCdQUZAOVH4TTxB4Px+T
 ZgIoLex3lqaORrNdviZj1aC3v5xSZTt/y4lq57kk4RStUuxRM2bMHAeIEOqIbgyRQ07H
 ARJw==
X-Gm-Message-State: AOJu0Yzu+e8aEi5CqRPq+KpqjaD5FB4GzNLqpHlAAHxp/oSy8UDrt9cY
 36laupPTDMUcfHJLtuN4gvPGlfuS7CvY7Csjjfzdoojmx/6A1obEdz9+gldYKfwlvboNkU8ACey
 5b4e0BZY=
X-Gm-Gg: ATEYQzzl2ajEBFoBfuKWiUPWqCsMxnrweI9aTQNgGQv4R+hTEkkIk3oMvBDL19ISEdA
 dCj+TFzXY/Ke21Y11fqoksm1hmifHaFom/1Kejcli3wvV05awBu0RzNMLAAJFQNN8900QYWy0t3
 UrAOjsZOFVfbrHWoFBzs8yXJZszHrN58BZjbPz5ugBIv8jverL/vB/7luB5qCA64q/+K/SrAIgT
 l43U9iI/Sp3PyGsaKUxbwl4N6QaIphc5fM3GUbVF2npsD6m5QxUroVbRgZ+Uq8MSotA2VQjNu4C
 R7M0lG0oFQ+LCv9KxSFrPBXaJmcTIk9N+ZJUzlw6V4Z0Yc0pAqLA+VMI+FzFnKN3S/sIz225aCt
 c/mUbMwb0bn3Qppi46I76Fqnya2AKfeEzBnyGHY6z1H+JSZsNVVmXkIg89ZyHl4MnYbPKqRj8QJ
 mcoifmtMPRJMAPiLNiaHUjT2M8wj/rj3HA
X-Received: by 2002:a05:6808:6a83:b0:467:1e7b:72d0 with SMTP id
 5614622812f47-4671e7c0b65mr788544b6e.5.1773107953065; 
 Mon, 09 Mar 2026 18:59:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756d4c0e0sm1172716fac.13.2026.03.09.18.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 18:59:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 0/6] Add AGENTS and scripts for AI code review
Date: Mon,  9 Mar 2026 18:57:20 -0700
Message-ID: <20260310015910.331784-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126184205.104629-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
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

Add guidelines and tooling for AI-assisted code review of DPDK
patches.

AGENTS.md provides a two-tier review framework: correctness bugs
(resource leaks, use-after-free, race conditions) are reported at
>=50% confidence; style issues require >80% with false positive
suppression. Mechanical checks handled by checkpatches.sh are
excluded to avoid redundant findings.

The analyze-patch.py script supports multiple AI providers
(Anthropic, OpenAI, xAI, Google) with mbox splitting, prompt
caching, and direct SMTP sending.

v10 - add more checks about mtu, buffer size and scatter
      based of Ferruh's revision in 2024.

v9 - update AGENTS to reduce false positives
   - remove commit message/SPDX items from prompt (checkpatch's job).
   - update contributing guide text to match actual AGENTS.md coverage.

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 2115 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1348 +++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1099 ++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 7 files changed, 4823 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

