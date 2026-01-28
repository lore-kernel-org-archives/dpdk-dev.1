Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DED46BEC
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:06:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B32114026F;
	Wed, 28 Jan 2026 19:06:36 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id C1CC74003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:06:35 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b714f30461so159480eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769623594; x=1770228394; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGPL4dGwJzrlSMa1uzVB0WH6E8uNybHjcwtWwi6Hxn4=;
 b=cjDZ7G+dtKtG7wgkrTEQVpROKcVa4M7064u3V+S0HRpJU3AB6Nhqw4XvO1O02a9MP6
 rJJ/zPj5nt7pZQs5Krq12ucXtIkHUhPRJ9Bmmp0mp6ElwjNBCQXmQqPn7i7faW85/L+H
 ++R9WjUpccMjiRN17bfqZBOhEbFUBmq/uqMVoViMnUXimU2xrnA193cFn2pMOu7laZo/
 HdqceiR/AFOXdM/1m9KjrLO8rq2uIAcOYfxL/LrzzP4VyFtleTpwPYlhP9UMiDefXAUB
 KIJmZJ5OyFz2MZYCTl9RNE1EFm7o9+LoGNG3TTLVVqWSLgTR0QclSy562e9R3no6e/j6
 VspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769623594; x=1770228394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iGPL4dGwJzrlSMa1uzVB0WH6E8uNybHjcwtWwi6Hxn4=;
 b=ksIjxiYtFRL/HmaQuc4UI7PiAfWpaRkssQ2YsD8SFPWqA79RrNSS540TppQB+2JhRl
 WO/YhZ5xQo4S9AWHmTv4m19m1waRCc4Gi6Uf0lH+8wvfaGWWpMxnfnAdmYj4dHrzMbTf
 5L79E512jAGpNvKUsvKPgvuwLT9qrRGh5H46JiP9vhClrY9wD6VXvUMzD+JaxJ+Q+AYs
 jQIxJ6Xb8I9zhAf9zxq6r5d4jUA+Jkb9+p+Z9tX7ocJ7IV/F6+jH/kgbqPEHtwpOikqT
 An4ZOU18LJ4pq368InsNBx+QhC2PKP3BO7/TeCOIkqmPk9Rl5YYGcitopWUqBCtm65zq
 KDqQ==
X-Gm-Message-State: AOJu0Yzirqe2STymjvOuUgJKtmRLN19vW8UcKD8LbL+PCkkPDQsT36RI
 eYEAgjtb856feTvjz+gvoOtZFz1X72jQ1LGAsnNl1fapVz7KLhI1jbmne47I3Q==
X-Gm-Gg: AZuq6aJs6j39SOco15AVUhm4ynYHMIJVTaCq7+2tqwn03Nyu4f6/EbbpK0eVH4YRl4H
 Lk87iQRCzuLf2NlavNqvOyFN0bUh++r2/055LXD0Y92D4ur17A+NoUd94WHxj13l0LuChSIGTIu
 ZKX0micUFQCr4K+vX9LEo8G6laarlqoPmA8r6MjLEAcRuuDDkoevP00zgXZ39FSEnPEHDL3t3Av
 wbEqxMwUwUTJg03FkL2wI70tNuABYYLc3oT1GgmxAxcuPAL+ForwQeMhCANUHNooovAlf9VQCpI
 C4ppAnLD1v14aMLeExyR9yytr4yWOctlpTSmh5CXzPEF5ZDY7aBKZtS25icQDp/8YJOq7qPudIC
 bOmQG2qgU4NXYGX5pRGndNPNEbzyXjh6F22rgC7J0oD8T/6tCR9+wjyau62uqQ4TF7fqwSH4xK+
 /qJqvpRqaL4W+XmdMjMqjvMHN51qvqee89kMomNGaS4cpOS2Q8Gw==
X-Received: by 2002:a05:7300:e607:b0:2b0:5c14:dec1 with SMTP id
 5a478bee46e88-2b78da0f58bmr3609725eec.36.1769623594079; 
 Wed, 28 Jan 2026 10:06:34 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a1af898asm4013042eec.33.2026.01.28.10.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 10:06:33 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v17 0/2] net: optimize __rte_raw_cksum
Date: Wed, 28 Jan 2026 10:05:14 -0800
Message-Id: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
References: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
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

 app/test/meson.build         |   1 +
 app/test/test_cksum_fuzz.c   | 234 +++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c   |   2 +-
 lib/eal/include/rte_common.h |  39 +++---
 lib/net/rte_cksum.h          |  14 +--
 5 files changed, 264 insertions(+), 26 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

--
2.39.5 (Apple Git-154)

