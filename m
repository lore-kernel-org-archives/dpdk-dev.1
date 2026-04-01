Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD810F6FD9
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 15:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FF744029D;
	Wed,  1 Apr 2026 17:42:27 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id B97F7400D7
 for <dev@dpdk.org>; Wed,  1 Apr 2026 17:42:26 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-82735a41920so2330931b3a.2
 for <dev@dpdk.org>; Wed, 01 Apr 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775058146;
 x=1775662946; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKWlU6MSi37CKnnI/SdnwTgd/Edm1PSKNs5UoWDDyqs=;
 b=uCaAIo+by6onb00vR7bmOK5u7vUOWNY/CCd7OJUd0DqN55EHtF6NI2/Mm2EA3CUpS/
 8GFNPfApa7Uz0dYYv/LjAIYf5Aof1SmZJOWasokudQYUe3XmSM8z8kQtUdbdnFsiC7q9
 Nz1Kq+xKxNa7r+OF9M16sI///89kSqWkFjCTJmgvy+cqukpdY25LWT3kq3mKbi+nwJ5t
 kShX5ZYWhfW20PY3/VLTbTp6MMNTjbYRNuDdrjo0RBYKpsN6tj8DOl/7XCZ7uGC6XWXH
 zTwCmb4t2aPfSRjTN7S6pK8k7xNmU0Hoba2GzB6lAJczYaOyn7byKjCvL6LKJKPVJEWU
 4svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058146; x=1775662946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKWlU6MSi37CKnnI/SdnwTgd/Edm1PSKNs5UoWDDyqs=;
 b=K083q39BZw9yZHZJobbmMeaEN3pSGYuy/dye6LKdB/mvToJrA35K3DE/ndM0ibeKJp
 zVM01VGLL3uPr5jzlswgCMFmlJHew4wXzQPXeuxi1GRXBfsl/42QCTIwb9Q5I8IynB+l
 4DvtII49AEmjeSGbBgMU/6kZKi0UC19y5PYUxS+LOZzD1k2bf66CrOxgYOt0YCzghwEC
 39U4ZrZodja7lbQ+jRK+4qL/ggTq37zWaePqjdWVFhDq8P0ZpNXtOXc3/CHnFcPB3iUF
 W5zH4Gv07RvD0HJSeFZdGr6M5W/81Bwir9wI54njgrgXP7EtsWSaeUV+raPpScPhoOqH
 +C4A==
X-Gm-Message-State: AOJu0YxZjOIsXXsArZtLfGbQHqkCnmbXcZaPbfykxwX2Z6YyUGVZWJN8
 5Gq7ocQPJxI/mmdYsAxoLKHiFJ5Dqp8Ob9r7MFdYS5ibKsy8g4KgkOZoIRYX4BmFu1VKaEFSS+r
 JCwBV
X-Gm-Gg: ATEYQzxmrz3SjhE+etNmGbyjgTASAPmnZeRfzsGkiHKlokykFvrZZxKxDgrX+2Ua9gW
 JADO/gj2pmMV4pAWJlD7ahK7emGBiCNDrJpxlZR64RLmD8BvMSii+M/gUeOUs72w5aBSwk8dBob
 0KDU2WRNbWPs7545951WJpMN4LvYIMU+vp8Ed7v5ReZBzL/nXMbGJRLZuDrCyXIYJZdSgenRksq
 qhNAabtHAwf7NrXdev7wBCSclC5SFojSUKd08EpXbT25kMcib6dhGppvr9D+OoZFsU/0AxEY7Af
 wbvOJVwz1QjH3hQz4/cWwMfEy00mK4EKUPp+K2XHrOh9LV1vIvrWdiGYh9qr74beZSY9tJ8x8Me
 Uh1pF/sQpkHKfM/kxzQ3Tlp7UI0F3MDU2SdwNhEyhMRjLEIrXWcGEcRCnSM3xrrelQcZMLmiM3i
 zEp2fQ22qMa8qjVQVQRA3kGiOD89635d5z
X-Received: by 2002:a05:6a00:418e:b0:82a:64c7:8c6d with SMTP id
 d2e1a72fcca58-82ce890e6b1mr4365037b3a.25.1775058145581; 
 Wed, 01 Apr 2026 08:42:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2694csm297749b3a.2.2026.04.01.08.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:42:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 0/6] Add AGENTS.md and scripts for AI code review
Date: Wed,  1 Apr 2026 08:38:06 -0700
Message-ID: <20260401154218.160500-1-stephen@networkplumber.org>
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

v12 - add token usage metrics to analyze-patch.py and review-doc.py
      call_api() returns structured TokenUsage alongside response
      always print token summary (input/output/cache) to stderr
      add -c/--show-costs for per-provider cost estimation
      include token_usage in JSON metadata output

v11 - add more checks related VLAN and mtu
      add checks for unsigned overflow on shifts

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

 AGENTS.md                              | 2162 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1528 +++++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1277 ++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 7 files changed, 5228 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.53.0

