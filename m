Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941BECD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8810140299;
	Wed, 24 Jun 2026 01:25:28 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id B1DEA40293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:26 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304f590dd91so436685eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257125;
 x=1782861925; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+yszvQXLQfvuAgPbykSGNvft0qYl6RgeMt8SQQyDBA=;
 b=G73338YtBNyxywWUW3VZ8v1cRAyEVijc5PUOtD0NfZg4XE+xiwvo9YzJYJ+WToCvtW
 jLPp6d/AtoZI1vGzBSBnjGXX1ll/hDLlH/VUmakuCRxpVhFGxQd+H59aGyCsctCo630S
 mSansQN6GBDWSCU/ZRF/2S0Cvre/nwOik9hXtSAP/99oPevxawJ32jfJfVbkRMl17ema
 7Y4zYhQjxiFIMcCnjJ50KYEK/Fg0MOYf4JclnNs1jlDBvUfpQq3+6XfletbT1c7MXJXl
 48dwQr2oUJUMsltDplUirAlhRdZdoySfvyCSRZoeTg7hLCeWrJV7hVD054uGPcxN0I2p
 vdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257125; x=1782861925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+yszvQXLQfvuAgPbykSGNvft0qYl6RgeMt8SQQyDBA=;
 b=ZiUIzSIghTj1C1nbq72Z79gi1xWJ8zzUDfzOKPppmJk1wGQd9ZCSc0pGgjXeF/mxO9
 Emhyyl14PXK0klp8/eSgNGuvWDZf83+aSAuljkPM6IWH2EIcvEKhXZnx1+rLO0vAl3nH
 KYDR5vhs+cKeylQPIrCU56O0LFUzb8d8UTzjN4AWU/ZEzKFBd5TDBthH9Hf7wjxfSF95
 Jmrmt3P5FnqGmbE4fLWokTQhWeLnBmvzPecqq3/80KqiSzf0GLUIsPMCJJX057wMFRf2
 QxNSRQiqHpnx7qF6esEZ6UyuJ6aT3PL8d3zPdNLUrR6U2wQ9S6G0GH14i3MnXPN3amvu
 /Ong==
X-Gm-Message-State: AOJu0YxBRyccUBZFNTHatiJkvXkDXh2Fo5xjXUuzwLMjyndebbnZ+4t1
 c3R6EzC5jOqLpxA6TO4qkCwb6bPavihZZiqj/TN7ocLcWhnTOAk2zfg878BeQ+QTI8X8VFq9bLa
 NFWxW
X-Gm-Gg: AfdE7cmN9b+46u/+wMNJGIZQ2FnPE6tVWUIdTs5Rd9FOhJhYsSyRcIYFhvXbekhEk3c
 p2y96IAyiddt8V2ASdEN/gCY9QupBffY3AjAhDcjkNdPrWaomY2QXJJscBjoxsFxz5fvSgvK+B7
 rWt9mG9GILPbsSPg6xPRQ621nxolabk3UiHytSyBBh7wdjoszHdpSQQHugIGB5wPGlsXyqGmmh8
 BfyMRzlYNoMTyosHHMjudWbnxSrb/UKCBgzLPs/3n5xpJ4PB3Op0jObusAVkt0cnTKLXSd8FpMw
 dOyMYqAaNLSNJH48rjTfqvdOJPF0CxUxeVSV3rCRV1B6/wym9fNy11x8qvv8TuRcG9MzHbzATob
 2EkkjqHVPCcsr9yLyloWW2HwWIWRJ3huXni3NZiUPWtt061ZQNw0LqD2WL8jTv1zzYrGmrrM90a
 fhSEd/RrBPZWgZBjEy/DuZjZi3QI9uP+CU+/BkpTqpcZunhmW13fU=
X-Received: by 2002:a05:7300:ac82:b0:30a:e531:3153 with SMTP id
 5a478bee46e88-30c69235627mr1166158eec.14.1782257125304; 
 Tue, 23 Jun 2026 16:25:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/7] bpf: JIT related bug fixes
Date: Tue, 23 Jun 2026 16:23:11 -0700
Message-ID: <20260623232522.257208-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
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

While implementing JIT for packet capture ran into several issues:
  1. x86 JIT had pre-existing bug which would crash
  2. ARM64 BPF JIT was missing instructions for packet access.
     Which had been discovered previously [1]
  3. Tests related to JIT were not being run or missing coverage.

Fixed all of these. Patches are ordered so that most urgent fix
is first, followed by the test that should have caught the problem.

The arm64 epilogue branch fix (patch 4) was originally posted by
Christophe Fontaine [1]; that series stalled, so it is carried here
with his authorship.

Changes since v3:
 - incorporate review feedback
 - rebase to current main
 - extend the x86 fix to all fixed-width immediates, not just JSET:
   TEST is always imm32, while ROR and the shift group are always
   imm8; patch 1 retitled to match
 - add a regression test for a large shift count (patch 3)

Changes since v2:
 - found more places where the x86 JIT emitted invalid opcodes for
   fixed-width immediates

Changes since v1:
 - add the x86 JSET encoding fix and its regression test, found once
   the convert test ran generated code through the JIT
 - carry Christophe's arm64 epilogue fix with his sign-off
 - convert test now runs the converted filters through the JIT, not
   just loading them
 - kept Marat's ack on the "check JIT was generated" patch; dropped it
   on the convert test since that changed substantially

[1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/

Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (6):
  bpf/x86: fix JIT encoding of fixed-width immediates
  test/bpf: add JSET test with small immediate
  test/bpf: add test for large shift
  test/bpf: check that JIT was generated
  bpf/arm64: add BPF_ABS/BPF_IND packet load support
  test/bpf: check that bpf_convert can be JIT'd

 app/test/test_bpf.c     | 327 +++++++++++++++++++++++++++++++---------
 lib/bpf/bpf_jit_arm64.c | 153 ++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 lib/bpf/meson.build     |   2 +
 4 files changed, 412 insertions(+), 76 deletions(-)

-- 
2.53.0

