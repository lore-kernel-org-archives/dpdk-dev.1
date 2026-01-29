Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEFD73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 726314026F;
	Thu, 29 Jan 2026 21:26:43 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id CB6C94014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:26:41 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so8219535e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769718401;
 x=1770323201; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqLImw4SX3BfpABkDdVgHP6AII4QEHpZbmMXhG07qNU=;
 b=YaSkNwfidyDuJSJVf+zLI67+KSDy/H6XFKpCZarlhVPlbenpT/IEwt7B3b+4HOqCob
 4+ED2j2KUV0AYF94CRtqDTT31Q1/NVGUVb1v3bQLMfx0zBNwv2BiaPZpMpERDveVHC/n
 tCd3czNpeZjxHo7OAlJPUck0mHe5JzQ0KhuWORvFmLU4oSMdzYj+P4m6HHNAfQfiBU15
 CJI6mT8albIcr0MOkkM8U2V912K2n5Ak4Tu9jmNc4FUj2dwNIG7pM6skbez81pB8E4r4
 gpPRQ5FrTetmLrHJoiFI2GfTC9VcnQ/S1S5dk0xNfl+wu7MjtFnxCrGZBSdfr0ibEljS
 sN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718401; x=1770323201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AqLImw4SX3BfpABkDdVgHP6AII4QEHpZbmMXhG07qNU=;
 b=sJeOijfWUwl+bVDTynS5No14igV/NJ9t1XjD/LkGX8wOurZo6EnopEGUWZRDTLFsh5
 qVcHtEAzsmdA7pKg2Jibyr+vBsuA8lt4KeCj+AmeVJZePdxUg1j/OQQsrm6i2NeTeaSu
 hiTw6UessW2b6VlfkL0YaokaAFRQ1mKizS2xL3RN9hiJC56DFYGcG9Jc4hBBs6rEqwOl
 rJmAsOs9tBDWjQ27FYx77eNK1aSQv4rnGGVlZg6DDyMMut0fosHhTkbupODscwZkaRH6
 Lz+t3d623WGki0mIJKTQK9EUzcYNuw+/UAcS+WJ1odv1x6+b9cl5QeZWTtJIVadTPWoh
 781g==
X-Gm-Message-State: AOJu0YxkAJK3QzQxLldCWhY0WEbjsaaNDUeoT+h3OHzadVbh2SGdZpsI
 7jRgpzO/rFYKo2RzgKnY8eyLXHt0n6tSd5T4Kt0FhezZtfKec0Uf5M6Qq5LVdc6Z2FHnRndMY8s
 nzjYt
X-Gm-Gg: AZuq6aK8/pdT6UaBVn7A1++aHPFQbMirZ5SKuEzriZcbII4SRDavwdDxdLwyHGH0dQf
 SmNs/B9T8aJB5bexC400Nnup2zfOz4OvJtDqL487bEyGLpdUmo/pC8rgOTgMkKc4OXi1oJbM5oM
 ayRjlwegbUmQSwe63e10izPPonBvTTrVG969OJ8tbv2TBxnZZl6RU2LAuUIlyoH+k5fChZkxa7g
 da3L9LBqVyIVRSLgs/+h0O/VrYvg0vFOoL1PPohW6ylV5KtIH89DDOZIR4Y2aiRSUJrFQc6YRYL
 nYPk+1G1mfM3cukZQzalTr00NV1ukmfjcmBXKJsukWHAEEFhNzrxEhRs8c7QrxJGD+ErOpLt+Tv
 MiU91uSb/iF3VfYaT3+NF31s/CHpsCwqIfzK0A6yXGjSy1RhMDFklY9WzlE/MF51qsUJ/GtxZJF
 uLWjC/TNIjOOtMJkA7DqcpBHMlJyagwVoz+2kAIgGRHBL810pohQ==
X-Received: by 2002:a05:600c:474f:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-482db4596d4mr5125555e9.7.1769718401232; 
 Thu, 29 Jan 2026 12:26:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e2ba7asm4819435e9.20.2026.01.29.12.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:26:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 0/5] net/null: improvements and bug fixes
Date: Thu, 29 Jan 2026 12:25:26 -0800
Message-ID: <20260129202635.173530-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series makes several improvements to the null PMD driver and
adds comprehensive unit tests.

The series:
1) Cleans up the info_get callback by removing redundant argument
   checks and using proper constants. Also sets min_rx_bufsize to
   the configured packet_size, enabling the ethdev layer to reject
   undersized mbuf pools.

2) Adds proper validation for numeric devargs (packet_size,
   packet_copy, no_rx) using a common helper function that rejects
   empty strings, trailing non-numeric characters, and out-of-range
   values.

3) Removes redundant argument validation in dev_ops callbacks that
   is already performed by the ethdev layer.

4) Extends the packet burst generator to support larger packets
   by widening parameter types from uint8_t to uint16_t.

5) Adds a comprehensive unit test for the null PMD covering RX/TX,
   statistics, custom packet sizes, copy mode, no-RX mode, link
   status, device info, RSS, RETA, and multi-threaded TX.

Patches 1 and 2 are marked for stable backport as they fix issues
where invalid mbufs could be generated or invalid arguments silently
accepted.

v9:
  - Consolidated argument validation into a single patch with
    common helper function get_unsigned_arg()
  - Merged pool vs packet size check into the cleanup patch
  - Removed redundant argument validation in a separate patch
  - Reordered patches to put fixes before tests

v8:
  - Rebased to latest main
  - Minor revision to avoid changes in later fixes

v7:
  - Added release notes to patch 1
  - Simplified test code by using single-line comments and struct
    initializers instead of explicit zeroing
  - Added two new bug fix patches (patches 4 and 5) that validate
    packet size against mbuf data room constraints

Stephen Hemminger (5):
  net/null: cleanup info response
  net/null: validate the numeric devargs
  net/null: remove redundant argument validation
  test: support larger packet sizes in burst generator
  test: add a test for null PMD

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  34 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 935 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   | 113 ++--
 5 files changed, 997 insertions(+), 90 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

