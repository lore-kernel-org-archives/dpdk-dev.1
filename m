Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C55C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F5F840613;
	Sun, 18 Jan 2026 21:12:30 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 147FC402B3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:28 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso32551645e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767148;
 x=1769371948; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tr3SOD2TWLFKKllbQWuk+6QHY20MESIoJA9H9U5S/As=;
 b=bMwrXEItTqOAsfPh5tDzdcmUNFeSla41+zdhTuhKjp1TgyMalC0bChk5rgmmS4ET0/
 UIc0pT6Ri+JEoKidXWr21oejoJZlEFIvOU6WgbFvhP233Ve/Rj2Elq5kI820wUcav9Ut
 RxH44D5aTQbh5WU8s7E3mTW3cZchMQKm8CLqGfIgPt80gl0g478QEZDTxQMCMGa/xMwm
 1o9bXRwb+JnDNkBTsMFBKqBiYdaSSGNoLdWmUoIhhO7AGz25wmszhKF8eJJ9CZ4Dmf/M
 +ltYZN6k5qFX8B7nDI+cngFii8t12xTRDxQSlQk/M1YKA+Ouhzruhi8sf0gqxJk7Lr+l
 YSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767148; x=1769371948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr3SOD2TWLFKKllbQWuk+6QHY20MESIoJA9H9U5S/As=;
 b=G/PEmxtlxheUskOUVPd/D6zQtWwDxXkTIi5i42dZ7Sb33rXZrkEKRzHVCzSDil8UmP
 tN0l/BMwfX3FVbXPpe5N+PTT9BYRRCwF9HpLPH80U5F4HQvcEet3vGtSJcZrANWZHqTq
 vuODrDEtN0aZ3vQgME2h7YN5LnTUd7Sz04lJnsQqMoqQQOzY/6kOCM2AquXDM/rQoIHV
 m4/J3hAw9BbgQ6RuTn11Eo5kh2brD/IdGTAxbfIEuuNOWIEO0VvnTLlJdE/f/7S8XrUb
 GYRs6TKDM1z/QGJ6oMykJOPHUSDu1u3PTOiykWsGrPqmy5lHllgou8KJspZsxleKF3dL
 PH1g==
X-Gm-Message-State: AOJu0YzvhSYzSgrtzmRJ9Swb/v7fqJaS7tXvqpNQFBSW2dhYV2AcBhGv
 aJUHr+AYZy5C6pIGSAXHj8WFbnG1mLYYuh+GNzcf9YMiEys5yp69s5CjYjGZ3lGfmDcOUPyoGDM
 WH882
X-Gm-Gg: AY/fxX6Jh+mmPlINRLTmoKdvAiyDiayyUl4A5aGD/9je8lB8LekiXLCO1GMtYNA+Ki6
 MrEu/7SZbbLFigHjROGDyBp2qlX+HEnn4jikFkUJFsVix4m6mGYhawsDgqXRJzCNfR7L2dDRSC8
 y7rtaXUq2rEFmkaSALH4SwhwP9VwC1fhKbi4tQJe+kbIUTPvlAiZhZ5g1w/zEKodXbfOVfc/vxC
 f1ZVyOKdHhUJY92iVWiHdUYkkzTJuEiAPslWz3n7Zv3RUREs/nJFNMjdb19ObWc8aowsQJYgPcZ
 J8wimm1Fq9FPyDUoRYPNbu/BgaTIRdUjILxkzAXTjyBBNr8xsecvuhfswAK2LC9AeMNo0T1Gysf
 cXaTmftvt6x1pCzKoOaJwXGVu9i9AYsxM8i4ak9VJjXjkSxl82PW3EK5TO7WqnXMokW4BdA36iM
 TXtRlUacnAxa8Eo0EXa6oL4RHvB1xAww/BI/lIIuvDOu2mjIE5SQ==
X-Received: by 2002:a05:600c:3f06:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-4801eb0359amr112544805e9.17.1768767148476; 
 Sun, 18 Jan 2026 12:12:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] test: fix sporadic failures on high core count systems
Date: Sun, 18 Jan 2026 12:09:07 -0800
Message-ID: <20260118201223.323024-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
   Bugzilla ID: 952

3. File-prefix collisions during parallel test execution (patches 5-6)
   Multiple tests using the default "rte" prefix compete for the same
   fbarray files, causing EAL initialization failures.

Additionally, two BPF-related fixes are included:

4. Race condition in BPF ELF loading (patch 3)
   Missing fsync() before close() causes sporadic EINVAL failures.

5. Unsupported BPF instructions with newer clang (patch 4)
   Clang 20+ generates JMP32 instructions that DPDK BPF doesn't support.
   Bugzilla ID: 1844

Stephen Hemminger (6):
  test: add pause to synchronization spinloops
  test: fix timeout for atomic test on high core count systems
  test: fix race condition in ELF load tests
  test: fix unsupported BPF instructions in elf load test
  test: add file-prefix for all fast-tests on Linux
  test: fix trace_autotest_with_traces parallel execution

 app/test/bpf/meson.build    |  3 +-
 app/test/suites/meson.build | 20 ++++++++---
 app/test/test_atomic.c      | 67 ++++++++++++++++++++++---------------
 app/test/test_bpf.c         |  5 ++-
 4 files changed, 62 insertions(+), 33 deletions(-)

-- 
2.51.0

