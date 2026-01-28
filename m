Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF75D46BF6
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E2794014F;
	Wed, 28 Jan 2026 20:43:01 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id D4E6E4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:42:59 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b720e4dcb4so349643eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769629379; x=1770234179; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HN5PbvnoIy3qCHQS88sb9enIsA61EX/cNznfgJtd/E=;
 b=BI2se2puL+Y4XvTp4iFv3zMuFu7YRWPcqfG4tTNmHuYWLYhIQi3KuPgi7YJ3P6hnwM
 8vid226opFtO6pDQf/ScWHXdyi7o3VpnTGdImgy3UBTumFiHEcAV9+ipCpMVOZFI9koy
 Oc2VkW/OnFrH8BhRqHUlUirZMN+ore2v65x3KdgMImR0Cw5MezCUO26PWMfBN0PLIQlB
 sW+T9sjcQvuVvoBAkJMIlC+wOYyeVps+ZoSiQkWyEfyjlSZwwKxhj90ddH1H1C1UTls7
 A0PoEW5Xb9FNUmsG6XnmZbhmMr+fDnLMh/3Zt3Pnb4n2DrWbe4Aupzr5iaEXAsrdj54D
 02fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629379; x=1770234179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4HN5PbvnoIy3qCHQS88sb9enIsA61EX/cNznfgJtd/E=;
 b=adePEjPj3SyOos0S7wA9IWb1Y9MyoEPo7NwlvV+dPDDANzRH3IIcBtvwy3q8IYsSmS
 osehTQF5+SWcZBFuhwOAn4el72AhbgfNbFX7SQvElND+T78/ip0PhNBL0KSGQBZqu1ji
 XqHWS76C17upXp9F4sfHuw88nU+PfoCMete8NRuzsIgkwlwos+7ZbYdGdidffF3dGAv7
 XolquEiKamjsI7PHnGQvKKTBKmyh78NanqvK08uOZo/SMcQ923VAfnU8iRvAOQabVfFd
 uO4uqfd+nTxT2UK1QwDz83CRa0BpiG/JnOLN2f0GgDpWc4HptfzzLg9DmC6O+BgTOpYu
 xr9g==
X-Gm-Message-State: AOJu0YwwT0R+0xoEcn9inAiSQFDLskcV2RjyPjVzIjIlPlDOWcHr42bs
 9bK4QpwjP3lffk2IW6e+lqG2w2Zszt3gNKrptQYuvThDi3WWd4XmFCX6jrYRTQ==
X-Gm-Gg: AZuq6aJ5Ok/O+dmpTl+YHvbyXMfTuzZ5vi+bSTB2Z6qEYYgzyCIpPUFL0JQE0GO4drR
 v2S4UhiewSat1lHBbozXQVEwMdFC7fcwn13wG1NeuURa04J3qw/OEtTT0GVb3hNgl0doTtq1J+Q
 1Tfovc/UAlNg8s9jPRdubL8+Lpy0s0O3tTrnp86g1wzBFuDa97K/oT8CGVaOBGSuHagxjXTOoLt
 ZyGcgArF89vz8xoorEdAyeZ7bDmWd4G9t4ck59cX0ESGU0Nekm+PtSJxmRf+kUqlhO5IJQRGPeH
 PmvUkOHJ4siKHap9QnrAKEXUHOJsGJ9fYkxwj2gjl+misBmNe2qAe1dE7C9bPzsY+mYzigyT7rh
 cUvl1dAWg7B0DHULi+9OAi+a1CR5ap5wUX1K7PBUSyA2fVRLKrlHSeKg7GVv+LNB613PYnkqa7g
 Auj3qfImAZD+5M0o6Wd/+FjlhQExxnX9hIjqyBeUAGmmI8A6F/Xg==
X-Received: by 2002:a05:7300:7307:b0:2b6:adb4:8a18 with SMTP id
 5a478bee46e88-2b78d9f6104mr3852114eec.22.1769629378622; 
 Wed, 28 Jan 2026 11:42:58 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1adef97sm3928968eec.29.2026.01.28.11.42.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 11:42:58 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v18 0/2] net: optimize __rte_raw_cksum
Date: Wed, 28 Jan 2026 11:41:39 -0800
Message-Id: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
References: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott.k.mitch1@gmail.com>

This series optimizes __rte_raw_cksum by replacing memcpy with direct
pointer access, enabling compiler vectorization on both GCC and Clang.

Patch 1 adds __rte_may_alias and __rte_aligned(1) to unaligned typedefs
to prevent a GCC strict-aliasing bug where struct initialization is
incorrectly elided, and avoid UB by clarifying access can be from any
address.

Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
to enable compiler optimizations while maintaining correctness across
all architectures (including strict-alignment platforms).

Performance results show significant improvements (40% for small buffers,
up to 8x for larger buffers) on Intel Xeon with Clang 18.1.

Changes in v18:
- Fix MSVC compile error __rte_aligned(1) must come before type
- Fix test_hash_functions incorrect usage of unaligned_uint32_t

Changes in v17:
- Use __rte_aligned(1) unconditionally on unaligned type aliases
- test_cksum_fuzz uses unit_test_suite_runner
- test_cksum_fuzz reference method rename to
test_cksum_fuzz_cksum_reference

Changes in v16:
- Add Fixes tag and Cc stable/author for backporting (patch 1)

Changes in v15:
- Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST

Changes in v14:
- Split into two patches: EAL typedef fix and checksum optimization
- Use unaligned_uint16_t directly instead of wrapper struct
- Added __rte_may_alias to unaligned typedefs to prevent GCC bug

Scott Mitchell (2):
  eal: add __rte_may_alias and __rte_aligned to unaligned typedefs
  net: __rte_raw_cksum pointers enable compiler optimizations

 app/test/meson.build           |   1 +
 app/test/test_cksum_fuzz.c     | 234 +++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c     |   2 +-
 app/test/test_hash_functions.c |   2 +-
 lib/eal/include/rte_common.h   |  45 ++++---
 lib/net/rte_cksum.h            |  14 +-
 6 files changed, 271 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

--
2.39.5 (Apple Git-154)

