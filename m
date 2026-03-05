Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA3AF47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:53:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AFE4029D;
	Thu,  5 Mar 2026 18:53:32 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2DC4B40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:31 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-506a1627a09so48826791cf.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733210;
 x=1773338010; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dH11DC/oM9fP6FUObCnh+aFED1iVcHjk1M2dzcYqCsY=;
 b=qL4IY9hI+2dtVTukZ+/DcD4YFZ1BdwNz74MQl0RytUP5u/xsokERw2r1IVUo0pfcX7
 uNqYNRt0pk2DSWr3iP/qCxbQxdZhn3RrwkuJdt0f+v7LvKiHQCl7Pg6MX8FTsryz87hv
 uCMUHY04O3vrh3TbJlGtsyaQ1iW5ZJRr+/6lv9qvoU79ca0Vfn7kvN2Y00+fQncwNYez
 zm9se/ATtOqBDDGv4r2g9jYERO6FDST2oI107AeZZ9G5vx14nxfFralqul2mHuUWhCEc
 KiRgYXOZBipICh1UQV7coK6b4zTlu7ujleXCbE7r5wxCA4PCErAO1fK2NaUGygU9/D3w
 sBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733210; x=1773338010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dH11DC/oM9fP6FUObCnh+aFED1iVcHjk1M2dzcYqCsY=;
 b=YVGiuW8Kpq7rH0nzZMO2Y44mWozdzLnIYzXHCBm2QobTr02N4oVAorWOPJondFxKUV
 x6QwnObE/xgcSAcqTZtjX2HjqsgZM/baHT6CwGUGQcZ/ZWKkqmr40IAGeDea81flgtNQ
 xsks4ZRufOmiEdAy/7u/SN7Dm9Zlxul0NpfMoPnB4ZzApBYesdtb7jnj4Q1fwEa/onSE
 HVX3V/Lri3M1HGxUbMNybMN+xW0vrNf4wh13tw2tLu+Bm52Z1YjpicDcNCsHBCQLoa39
 lzHaLAwbsN7Bsil2Wx/2bswW4UypYcXNuvjN96Y2R9KcNKN9qFvuVn0FNri/mJZYtjDf
 fZog==
X-Gm-Message-State: AOJu0YyfVwqqFl3PPjgTXSWEmvun6CRvnsKlOxSTuyNu6S3i0EHFBgjP
 lt1FqQTJUkeyvRItbUoGtIEHaOuabFIsgw30y3ir1TYamUH4ajRUN+Wj87TD2Duv0aK5D4ALj0N
 Iqmpm
X-Gm-Gg: ATEYQzz4A42J3BS6HJz//isfyjVzeraXXqb8FXJJgI7cdFvppLi4tXH3UttXfDoAD9j
 xcf/XP++pyqGpSlP1DzjjyhRQXjAOCuRFnTLk9nxSHyxigoQN6B5iVmcQGuGDNIj0aWUSDPFYEo
 px7mYikqx/KcrR8MvsV9chzkzYqNVIU2zzEucCkg2rcyNJzn0Idai0mnGPc/V86mE7isc78h+nM
 wMoB+7OQSGZ9Yga/7aITlwXtptR2Ro3UpwCz7JqKFyXhADdW1NEIdMqVnEnePIFirEhDc6jTjW+
 g4bFPX5XGlz0Loar4nyr5zSzTrEVTS8SgXHC3VwMmS/ruvnZ3wu6p8V+GXh59ozeKfCfEyPpmzG
 XRdQw4c22gEBtNZCGL0duaUnh1wLz5xOCeGCHX2r+QS/tQWkvXtlENmLfTWib/4FMrK5xGNN0F7
 BprUZmFKStLczncfGwSPZzg23WGpQnoijVzMj1nqOFAPGeiPMaj+ciHrP2OE1/ok9H9fhM0wIj
X-Received: by 2002:a05:622a:1984:b0:4f1:e9f7:4dee with SMTP id
 d75a77b69052e-508f1dd02cfmr6656851cf.35.1772733210270; 
 Thu, 05 Mar 2026 09:53:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/11] test: fix test failures on high core count systems
Date: Thu,  5 Mar 2026 09:50:54 -0800
Message-ID: <20260305175326.279891-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

Fix several test infrastructure issues affecting high core count systems.

Add rte_pause() to synchronization spinloops that starve SMT sibling
threads on AMD Zen systems. Scale iteration counts inversely with core
count via a new test_scale_iterations() helper to prevent timeouts
from lock contention (atomic, mcslock, stack, timer_secondary tests).

Replace volatile variables with C11 atomics in timer_secondary, fix
parallel test execution by restoring unique file-prefix for fast-tests
on Linux, and fix BPF ELF load test error handling and clang 20+
compatibility.

v4 - drop patches already covered elsewhere
   - replace volatile with C11 atomics in timer secondary test
   - add missing mempool_get error check in timer secondary test
   - move iteration scaling out of worker function in stack test


Stephen Hemminger (11):
  test: add pause to synchronization spinloops
  test/atomic: scale test based on core count
  test/mcslock: scale test based on number of cores
  test/stack: scale test based on number of cores
  test/timer: scale test based on number of cores
  test/timer: replace volatile with C11 atomics
  test: add file-prefix for all fast-tests on Linux
  test: fix trace_autotest_with_traces parallel execution
  test/bpf: fix error handling in ELF load tests
  test/bpf: fix unsupported BPF instructions in ELF load test
  test/bpf: pass correct size for Rx/Tx load tests

 app/test/bpf/meson.build        |  3 +-
 app/test/suites/meson.build     | 19 +++++++---
 app/test/test.h                 | 19 ++++++++++
 app/test/test_atomic.c          | 66 +++++++++++++++++++--------------
 app/test/test_bpf.c             |  7 ++--
 app/test/test_mcslock.c         | 10 +++--
 app/test/test_stack.c           | 11 ++++--
 app/test/test_threads.c         | 17 +++++----
 app/test/test_timer_secondary.c | 45 ++++++++++++++--------
 9 files changed, 131 insertions(+), 66 deletions(-)

-- 
2.51.0

