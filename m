Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35979D172C6
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 04:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083CE40285;
	Mon,  2 Feb 2026 05:48:48 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 1865340281
 for <dev@dpdk.org>; Mon,  2 Feb 2026 05:48:46 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1233b953bebso7256047c88.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 20:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770007725; x=1770612525; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tU/tMOI/Nmmv+Zf+vqa0B8sT0qxBFOwY/NukfUvuSCE=;
 b=ZA2LNrvabFEaZtRvidM56EUf2A0WXLDx2B/GGO/LntEpEJWDN+pi+CSVd+ehagh5Pr
 eTZO9omRmA9+kChJwhNllxlBgEdd3i8ihXWGTry6ey73dQB3JDxb7p0MHQsHkGK3oAUp
 QX+4O9QNXYTfAPT8Xu0Kd8m4h/9bzoAkqcMrWdjqdJ4O/yI4n+2dE9PGmpTDXEdCskMG
 gQlL1/dxsXexuNTv656UEvCCR8bSTf559CzomTh28xUtHerN3nRI1OnxyYwWtTFj3RbL
 mf5GGPOPPURtmf4FEzwzMGvGBmVGXSwpu5ndGya0rIyG9TLNPjgepgd2AvBv0iYLQZGY
 w0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770007725; x=1770612525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tU/tMOI/Nmmv+Zf+vqa0B8sT0qxBFOwY/NukfUvuSCE=;
 b=FTM5+uAJiED3b33Ytxi5xcqZFO/kQqhsCNrr3MFcEAP5z9a3BKQexooQU611rj0ARp
 Qre6gb147hyQlmfHxb1dic+OSEWR8pcKVhY2dLmfBuqLyxObD91BcTeLosdexq9kxFhc
 rjSGkSdrSPe9wFYFkoZf1OIInJ1O5lbAcjgwiM0oEPKokfwP+dtaSEnrxCuoFVrpD3rY
 rGHx7PYtu/IlpORmXcG7BRnmKRrk855krypcR2EVQm1MdoWVVgQc7z8K0tNR/9fdZh7K
 9XIzHCFxVtc7bWJR1mCazUxXDdoUOXzWohn5fVtd0UGhRFSY/tURnFaF0k3uS9sDe39G
 Y7Fw==
X-Gm-Message-State: AOJu0YwiSQN7ie69GY1hv+ZEUBfjbj7PUzeQJRf4Miu8mNuP56kCau7O
 Rckt3X7HjQit+pEPrzceQsBycc8fds7YlgN9lYXnRFh0YbloCJnKBNvE5GBsVQ==
X-Gm-Gg: AZuq6aKoOYBEaIwtHwIusZE41lwGb+C+h+1qqjcXWiGfRPAEjfIpOicHBIRL9zzL7pY
 ZhauizHQ7tvE6RQgKvos4Gd7VwqtQEeCnyglPpXb+2vFYbSR8BHvP1QI9qXNE7/Jh0YL6YmODHA
 iQ2H198JqkLBt21u4koNRlgyuU4qK2XhMnVs0RayKIINWCcge0nREHG4jabfkpSCRYAdSJWXzQF
 kidLIJUbpPiaWMrNxNzux0SiOfchLhFQo3w/JVX0kDHfPk6amX83YsBRdlYpqLgc6w09coWyvJR
 kOOcqIVs4ZICshr74fC4y3pUW4s5zx3vqyab7diTmcx+Z+Umcxa21+t8z2fV7WmXT+hr4/1Mah+
 Hnwu+pCGnP8FjF4HyRBrNGMSWJyNVJSMjAN9A1/cNl/7RDdIDb+CaWszIwKnVU0flAbc1pKDh4o
 ET/c81vtlrO1kSm66rK6ilKCt5fvo=
X-Received: by 2002:a05:7022:68aa:b0:119:e56b:c75c with SMTP id
 a92af1059eb24-125c10061b4mr5518752c88.33.1770007724725; 
 Sun, 01 Feb 2026 20:48:44 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d7f789sm16784293c88.6.2026.02.01.20.48.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 20:48:44 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, david.marchand@redhat.com,
 Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v19 0/2] net: optimize __rte_raw_cksum
Date: Sun,  1 Feb 2026 20:48:39 -0800
Message-Id: <20260202044841.90945-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
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

Changes in v19:
- Move qualifiers before typedef on all platforms
- test_hash_functions explicit 32 bit variable use

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
 app/test/test_hash_functions.c |   6 +-
 lib/eal/include/rte_common.h   |  49 ++++---
 lib/net/rte_cksum.h            |  14 +-
 6 files changed, 279 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

-- 
2.39.5 (Apple Git-154)

