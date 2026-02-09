Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA5E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BE9402F2;
	Mon,  9 Feb 2026 20:51:01 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 2E421402DB
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:51:00 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso1251965e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770666660;
 x=1771271460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2GieL1fOdDCy0w8XF5eBzrnT+SbfIWYfufTAsqdaTI=;
 b=CakLKe8caI1BgtRpSk8HLLeOPkqeVEmvcJwdNv5eaE+8L8KRYsRocScO57LxTlK6rX
 H8WNhFgEeWl3/++4qF6dncqfFqhgPle8Oniac9orzEqka5L8o8uXCZavjyc34jPdMxQP
 E3gQTOfa24XXxofjOQFKEkk1pNjlmDp6VujT3O0m0SRLwDJ5PDwnTJaaUmgCjhi7WKK6
 r0osNpN7BI20HsLD79tUXPofrX1ZqN+nlKg2KKghfF7n8QGbZBn3Rt87N1pYInkd9B6n
 ETlpsIpu56G/xC209oMN5gs99qJ7FzHzXkOYOtzSIuY1pZ/WOx7FzIZJtj1aUK6Cdgj0
 F4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666660; x=1771271460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2GieL1fOdDCy0w8XF5eBzrnT+SbfIWYfufTAsqdaTI=;
 b=rWNjATpoEWCjP1WtJlxnQUzY5C3+OZNcHYrA7WiDs52YmFqesPtzWg0sktq4Rn08jz
 MYp5fekIhoIVBpDN96UXdhy36WE0AGX0TpsdAM4+hYpkgYSwlxnZEJCzOBIfc/5ZiGR5
 dhCM/gcchilttiRmhA/QnbX1zHZBguIH435PEh2mKXZKqNqu4z3z3ZHSE5oxbJuGeyob
 vcPm8gcJP0dsyT7SAg58yzp7ZXi0rQJNj0bbg2qvaTQYYW6O/3KLYYRJSDyTD2ARthoG
 Dkc/AxPouLf1lLwjIl3X/zy6lEWrED/uDhOFvTFvaHRUpy/I8snXinrk/UUqqc80layM
 qZIg==
X-Gm-Message-State: AOJu0YzqqvAgdbOdaGg33efszVvTCqeMpspnvvpBgAtw3n9e53lNaUwP
 eTJAY6W5UnY4IwYiIQhtMzuXg19wwch35I3Wfpk7EiMEpYbLGA2NrKfZCCYcsIOW8m23wi6MD3O
 Rcspv
X-Gm-Gg: AZuq6aKzHUpsa/PXHhfayar5XRw4oLu6qUT9svPQnr5nYDO6h7/FFqrx2fMUxLYxmCc
 ac2LCJhg7VNFQ1vI/XMgZjeTMzKeLTij0DNb7Sgo/PcxSyRjJcOy5gQVSBUHyO5dz2xW9VMRWYB
 SRgJ7ejVHlqYvN2t5FRysBJsWy1TSzds5w79UHHQzEYyE959dULlDoj54kaA8e0ke3WT/tjjyyA
 GF3jdH/FT480U2k9dpXJYAeKda8Sip/K22cpebU5nlvKQCggJqdNSD65hX4nQw2KKjp3G1AjBXr
 0xNL0Sh47qcKqfXXkfUf4UR12JCZm5LruYQdg/eu9n57AXxH0KDXBbHe1jiCM7GBb82KsXuVtVY
 c+spXNf5DJrHvs/AiClwYTIaN+CTNUUdUeNRfQlyAlE1FXZZPhrfxgBIxgoNkdDEIcjf5B9ZWgu
 Rg0V8oZQ+Hz8sHyGe1udY5rs/j2brcFQTUVoTmE6RCOniQ2BimPQ==
X-Received: by 2002:a05:600c:19c7:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483201db067mr163237295e9.1.1770666659648; 
 Mon, 09 Feb 2026 11:50:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm10178345e9.3.2026.02.09.11.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:50:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/6] add AGENTS.md and scripts for AI code review
Date: Mon,  9 Feb 2026 11:48:48 -0800
Message-ID: <20260209195055.142484-1-stephen@networkplumber.org>
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

Add a structured reference document that enables AI code review tools
to validate DPDK contributions against project standards. This document
consolidates requirements from multiple sources into a machine-readable
format optimized for automated validation workflows.

The AGENTS.md file synthesizes guidelines from:
- DPDK Contributing Code documentation (patches.rst)
- DPDK Coding Style guidelines (coding_style.rst)
- DPDK validation scripts (check-git-log.sh, checkpatches.sh)
- Linux kernel patch submission process
- SPDX License Identifier specification
- DPDK Coccinelle scripts (cocci)
- common items spotted on mailing list review

Key sections include:
- SPDX license and copyright header requirements
- Commit message format with precise limits (60 char subject,
  75 char body) and tag ordering rules
- C coding style including explicit comparison requirements
- Forbidden tokens table derived from checkpatches.sh
- API tag placement rules for experimental and internal APIs
- Patch validation checklists with severity levels

The forbidden tokens section documents restrictions on deprecated
atomics, logging functions, threading APIs, and compiler built-ins
that are checked by the existing checkpatches.sh infrastructure.

Severity levels (error/warning/info) align with the exit codes and
messaging from check-git-log.sh and checkpatches.sh to help automated
tools prioritize feedback appropriately.

References:
- https://doc.dpdk.org/guides/contributing/patches.html
- https://doc.dpdk.org/guides/contributing/coding_style.html
- devtools/check-git-log.sh
- devtools/checkpatches.sh
- devtools/cocci/

v8 - revisions to AGENTS.md to detect more bugs.
     previous prompt was screening out leaks where AI wasn't sure
     enough to report it.


Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1514 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1334 +++++++++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1098 +++++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   56 +
 7 files changed, 4204 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

