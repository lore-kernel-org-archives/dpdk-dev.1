Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38692CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 357C0402C9;
	Thu, 18 Jun 2026 23:00:33 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 22FB44028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:31 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30bd47b9f0fso1591774eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816430;
 x=1782421230; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9TnrCydDzQbbyL373axYGjcBRKSVLqJnslygazAdt0=;
 b=NjRc/WWCROEGbKjpubBM0XS8g55mPzCFa4i9iLf2kzoFiD6L0uXYK6j85zG2b2649G
 UJ4oCxE4UMnbMFhOB34O6TGSHwIU+MqOL8U9YLY7K0sCWf9Daucz7Vc62j4AXPaxAjb7
 Jt+gLWm3eE71qeOwn7CBJn54fmepvOILOFk+VmUVZ3yX8W6uD9aB08moZV1TP4ejSayN
 FTE4YRuTIqa7zJdO3JPzw0+yfoe8cEZjmu9GpeGdy9LRm3BPRGoCNXNvIfu4bXNyIeQ0
 2QLaVPqbUjBjM1wrw5iY4WplB7OLYK1oMWAbphhXkQV4x1Bgkrkl3W/jkfRuT1BX3PEo
 yt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816430; x=1782421230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9TnrCydDzQbbyL373axYGjcBRKSVLqJnslygazAdt0=;
 b=Q3KYMe6ehP9zuXf8XVoWVsMDA0H0MBTxmBnQN5tJRj1PUNtXRHMLgJitgY8cTIgd7A
 wSj7H5ewuKJbX1cbByUoNhmc41R7fpNC+qdRjNivb/ECbcB7jkDSEe7yoBDAIKWPE6g4
 KAsTiKgPOjl/BlDS0VnPSC83Zo6l/nXVxGt7XK7rGVkCWKieBtvbB8yd1efWoQEYp++Y
 5nBiSF2gbwbJqoBpGWQNMHzOyZI97A/1XsGdTuCiUiJKrbswyD9OvKd562+wuxOqrUTs
 Vu2hRs5iLrgpT7arI+3YbWNfjrW1JH5vmJ6eFosUIGqgUjpP5nGzR6cu2qqNLAIIfNdJ
 d8GA==
X-Gm-Message-State: AOJu0YylaeuUGHedXUM6kfzqd4NAV/6qad2eoOZtM82W/0F+83HU0I1v
 rnp/gq+soWqhZGs9S6fzFzXUYO0y1OK1cVyB/RJmhwQbgYwxOtmby53kuVErYXrdS4pZzsIc9xX
 8SuzH
X-Gm-Gg: AfdE7clit+py3EjN7YtjiZENHbG+xlizaNp7wYgeI+T58losHNQVZOzct6l9aKHELly
 VpTPQeXqHvPk4stMwezWOqw1cEM0UlNpuOAYVjApUJfQhs18w00EUyZNH+31tJxZXuowis+nJvV
 pF/Yn3I4GH93NksVxUYdQsXppTpWSVWIp8vbaJJ4hgpeEEFJwcjCPYuCyQqhYGVqcglBFplEYtH
 eSUJsVCfL8vHTI0HSj9X7GORTkZuduSX1h9CBvvE6UfvqSe2V44VlDArIy2+pJIGwev/f7Uhnpk
 QJnrWxayX75e24mb6pJ8rtj1ugsSBBxcr0n+fHw6roON18lxNDtUB3BLO+vwZU+8PGPrlrslrzK
 yQBXZD+wbSojc8hE2Fbjvvq8l0Udcg7XiM2d4q8LswVOQU+asEzZJyMLVJzSpcBQriHJoRouOp2
 3FTe5Ljo4oFY+Ith+YTqjhZW8WgIzuAS/M5praa9k9i1mGdEMjUh0=
X-Received: by 2002:a05:7301:3d17:b0:30b:c83b:f56b with SMTP id
 5a478bee46e88-30c06d86996mr857606eec.14.1781816429861; 
 Thu, 18 Jun 2026 14:00:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] bpf: JIT related bug fixes
Date: Thu, 18 Jun 2026 13:47:04 -0700
Message-ID: <20260618210026.430288-1-stephen@networkplumber.org>
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
is first, follwed by the test that should have caught the problem.

The arm64 epilogue branch fix (patch 3) was originally posted by Christophe
Fontaine [1]; that series stalled, so it is carried here with his
authorship.

Changes since v1:
 - add x86 BPF_JSET encoding fix and a regression test (patches 1-2),
   found once the convert test ran generated code through the JIT
 - carry Christophe's arm64 epilogue fix with his sign-off (patch 3)
 - convert test now runs the converted filters through the JIT, not just
   loads them (patch 6)
 - kept Marat's ack (patch 4)
   Since tests change enough, decided to drop his ack for that part.

[1] https://inbox.dpdk.org/dev/20260319114500.9757-2-cfontain@redhat.com/

Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (5):
  bpf/x86: fix JIT encoding of BPF_JSET with immediate
  test/bpf: add JSET test with small immediate
  test/bpf: check that JIT was generated
  bpf/arm64: add BPF_ABS/BPF_IND packet load support
  test/bpf: check that bpf_convert can be JIT'd

 app/test/test_bpf.c     | 184 ++++++++++++++++++++++++++++++++++++----
 lib/bpf/bpf_jit_arm64.c | 153 ++++++++++++++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   2 +-
 3 files changed, 321 insertions(+), 18 deletions(-)

-- 
2.53.0

