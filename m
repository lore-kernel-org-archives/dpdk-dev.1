Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F18F9D0F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 21:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 892EA4028F;
	Tue, 14 Apr 2026 23:10:18 +0200 (CEST)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48]) by mails.dpdk.org (Postfix) with ESMTP id E31F24028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 23:10:16 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-688a8e5fe5eso2981238eaf.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776201016;
 x=1776805816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSbVavxhJpSbCM+ar0YFw5d5VTMynxSfdvn8G1N+Hbc=;
 b=EULe4E51maKB7vb27X2hmKPl/4s66gzOaOx2Igyrseo1Avk3BKV2Cjqa10hVIzILdE
 841E4tHQOJEQv7cahZgimwIiGO3KYZ3TiQIiqCA1iqZLMxYk0hMDx3IfdqZ0j2BKtfuU
 AfYJjI8gWpxLV0zUkJDwayVYOrhS2QW/d98Z/hCdt9j57S57zNRmsCSUeBzbl4kqewNh
 U0G+QmxqJYLR5hXYf/K07WOKVUNYCabFwWJn1Aufg7C9hQxSNp9thcPKbPx0NoMr/fhv
 zcZ+jfHaSRDVVto0ie5ShbqbnXlUp4fCsYCTBk5+/6gDHTRh18JJh/JMpEYFSycwqLz7
 WRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776201016; x=1776805816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSbVavxhJpSbCM+ar0YFw5d5VTMynxSfdvn8G1N+Hbc=;
 b=BEjAhke7xqZ7gf76A3hnl0wArwLcpGfVlv4i8gkpsuEh+HXt8s6FFjo2sDlSLEIiU2
 azP0oA8mbcVyeojkfCWXgm+Pc34Use7HHOu0L/Up7G51CW7i1SwrOd+DIv+M+coBgz7O
 /DLYLe72nUebwytWK19NyjcgFoli0xHHSeGMaAbQzNHYCUz1a3YmmWO70NBMdS6rOOVa
 wdOMQodnTkAWCgAdV1ji+yWvGLMNm1opT9CUNGK7n24FMTl1hrObOaK+NUOS+RwBUiHq
 wTw9LPgbWwNcSx3d0yQbbbcU1igxawZ21B7QSELSRNdblJVefGX3SOEBF++EUYajZ+nz
 NEtQ==
X-Gm-Message-State: AOJu0YzWGDBx/CQUaSJw4EumiO1DV/cG7UuT25Mxi4dFfKA0MNxOyHU7
 8Qm26WTIukFzxldNWT5r2JP7K2BkJvIc3jNq4rFkPwkRuBiy5ir+uwurhnNpX2XVGry7Bgfb/iX
 LGSlA
X-Gm-Gg: AeBDieuX8Wh/vWBlu6ivliONpTxpzXfwTkEQD63GSRNpeSixqv9K5P6aLqJP6Lq5E6o
 k5d9kFrTLzUt83Gixs1DEFUKNHI8InIXKPQAw9XOD0ODIwayxrzm7DuTXwDXLRorVyqLg+tZVMF
 cuxMGVqekEELAqxiqX+eMVxVZ+JvjNhqSz9bMrtcgm0+MnoFgwxnZ+xrGn8AndYTB9FTvHL3hsT
 JKwIxRziBQVmbzj+V7c8d9RbYu0/Fxoz1BvqSkj66JOL0i7IrIJZDmFOoUKNbVQ/J9m0aL/QZX6
 Vj8QYYm4ZMQ7THnT89BikTRgCbmIxT2txVUcgRWpjoDh9dGiY/5JbSz4N0D9XBuSINh9Dl4ABgr
 NuI0yWVlWGHrk8Eg7or8glURYcqLUtz0n/7Xdq1Hj9BOIxwOjev/J5N8yYhW/q8GNSVy4UQb9Hh
 2UjazS6vLxitJWUHn7R5tsHsySVrxv96PoSkahQ5gDJ5eh0vCocwkS1g==
X-Received: by 2002:a05:6820:2908:b0:67e:1887:34b4 with SMTP id
 006d021491bc7-68be8dd14dfmr9467696eaf.58.1776201015761; 
 Tue, 14 Apr 2026 14:10:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc82ea711sm7770224eaf.4.2026.04.14.14.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:10:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 0/6] Add AGENTS.md and scripts for AI code review
Date: Tue, 14 Apr 2026 14:08:37 -0700
Message-ID: <20260414211012.951613-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The analyze-patch.py and review-doc.py scripts support multiple AI
providers (Anthropic, OpenAI, xAI, Google) with mbox splitting,
prompt caching, direct SMTP sending, and token usage tracking with
optional cost estimation.

v14 - AGENTS.md: add SPDX license header and copyright
    - AGENTS.md: fix misleading rte_mbuf rte_malloc example
    - AGENTS.md: add rte_zmalloc_socket guidance for queue buffers
    - analyze-patch: exit code mapping


Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 2170 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1509 ++++++++++++++++
 devtools/compare-reviews.sh            |  263 +++
 devtools/review-doc.py                 | 1184 +++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 doc/guides/rel_notes/release_26_07.rst |    5 +
 8 files changed, 5200 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.53.0

