Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39013D2ECFD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0FF40274;
	Tue, 20 Jan 2026 02:58:07 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 624F94026D
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:05 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso891689366b.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874285;
 x=1769479085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiXTW+K3q9hbcPA/H/o2lsQyRR6J+g5eOd78EgjiSPU=;
 b=Hf0ukEiyxz7XHK/Cf67+e3Fh6RbEInoJkl0nRqydUKr7XTIxNJJqs7j98dRiCpXMdg
 v2D0rhCZy4zWwzI4z+HHA0ORJ7KBjyJ9bJZecULtfG7q0aZBRjG92btZq2mfK5OUPfQg
 cW364JiStm+246kLKtSDxVOXEt/GSF1xbgM0tyZK+s7HM5wJvxfBIfP31vm/27HK8282
 lierkilv1lSLBSOBdh71Vv/aVsMFvXAaQBmn1Y+HWPqclQ6AW6vPac+mXP9tRwGxeUNI
 cMRkrAXHUVOCS7PPYdaCey6MdNlparsDSKHniS/FpvbYGsA0d6OgLsaFM92TWlwYyD/0
 D0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874285; x=1769479085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SiXTW+K3q9hbcPA/H/o2lsQyRR6J+g5eOd78EgjiSPU=;
 b=nuFlCFB+YPZLgOPithaDutGjOsemI3Y4NgIisJQBptRQ1Xdaf4pWzKgqUv/0g8i45S
 NIpHj5HH/9tkbf9RRGxrRCZahTnXzNiIB8CviOPBEeintPVaUDI4X6JXGsix2FFqCKZr
 wo32kLaU/SnXSrSsaYJFcpiUvDr6TXo0ydnHJh9lNF3zdcmFL3cIKgQV/hcp5i91K643
 rKe4/1cvuEwXTiOdzZpDcD6r80n3tuX5BzEREFJ0zf3OojWukFKO/Mo96/rVn702JpqD
 xGGhR59BAV3bEkqGYnsD7vt2mlIiZ+sO3kh2HcDssMi1WMKlBmA+vzCMAmVCTYWTHVB8
 WX2w==
X-Gm-Message-State: AOJu0YwMNLJUMyWQq6uFVZOQWt3F/xVskicvOULFE/AMZR4jnUCSPxtF
 cCyz/tjoDQ3UI+WSIygJbKDhF30aHo1AO2LIrx9eHUwGWxYGirgMKotwkjGX4t3+qouOP1A9PMv
 sNH15
X-Gm-Gg: AY/fxX6X+kdfnAWYLMJBrGA8SJvZdUB1pKGIx779b5/yd09vYpb2BrsS5PWtMO6ljy6
 Z5IT7TKOZqJ+2ARCG+BKO0Q0R2HK8dE/H0UlW9LoymQ9EW2m3U1GrZBea1/JBgMw1VufW0gSnPo
 j7wbiVhHuz8P4lD/yr0JY5+BrZBziL6NVQNbmEX0X3zxNYAw3gFVm3CnoYZ0Vtn8XcTTdxBNlen
 K11KYRWS2ElJYdbI0g+IpSG4oHKkvGXFEtKGOAsC7HRue7JCJwvhNX2zmCl7lpzGbA3oU2T9EKT
 9juwGnsHEWPIRCfqjJSBRGHVJur5T5+R+h46QOey+wWnPNEopqmZCI9esjqHlScxs38ggz5Aksb
 L1gnW74PBPimLYhmQchHhhbgyobQb+xArHXlmydAP8ZDf+hV2zoDZ/W7edAnwmfVKCXQtkvT5JU
 Wn/k4TmNQAOdk1n/ZDE3KoAyIp+9acmJeJhLmHl2IHCZlt2cvilg==
X-Received: by 2002:a17:907:c22:b0:b72:d577:11cc with SMTP id
 a640c23a62f3a-b879388dabfmr1299965566b.12.1768874284725; 
 Mon, 19 Jan 2026 17:58:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] fix test failures on larger core systems
Date: Mon, 19 Jan 2026 17:55:03 -0800
Message-ID: <20260120015759.301155-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <0260118201223.323024-1-stephen@networkplumber.org>
References: <0260118201223.323024-1-stephen@networkplumber.org>
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

This series addresses several test failures that occur sporadically on
systems with many cores (32+), particularly on AMD Zen architectures.
I think Ferruh may have addressed similar problems in earlier	
releases.

The root causes fall into three categories:

1. Missing rte_pause() in synchronization spinloops (patch 1)
   Tight spinloops without pause cause SMT thread starvation and
   unpredictable timing behavior.

2. Fixed iteration counts that don't scale (patch 2)
   The atomic test performs 1M iterations per worker regardless of
   core count. With 32+ cores, contention causes timeout failures.

3. File-prefix collisions during parallel test execution (patches 5-6)
   Multiple tests using the default "rte" prefix compete for the same
   fbarray files, causing EAL initialization failures.

Additionally, two BPF-related fixes that I was seeing on
this system.

4. Lack of error checking in BPF elf load test (patch 3)

5. Unsupported BPF instructions with newer clang (patch 4)
   Clang 20+ generates JMP32 instructions that DPDK BPF doesn't support.

v2 - Drop the unnecessary fsync()
   - Rework the file prefix handling for trace tests

Stephen Hemminger (6):
  test: add pause to synchronization spinloops
  test: fix timeout for atomic test on high core count systems
  test: fix error handling in ELF load tests
  test: fix unsupported BPF instructions in elf load test
  test: add file-prefix for all fast-tests on Linux
  test: fix trace_autotest_with_traces parallel execution

 app/test/bpf/meson.build    |  3 +-
 app/test/suites/meson.build | 23 +++++++++----
 app/test/test_atomic.c      | 67 ++++++++++++++++++++++---------------
 app/test/test_bpf.c         |  3 +-
 app/test/test_threads.c     | 17 +++++-----
 5 files changed, 70 insertions(+), 43 deletions(-)

-- 
2.51.0

