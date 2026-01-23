Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7720D74EF5
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F52A4026F;
	Fri, 23 Jan 2026 17:03:05 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 411EE4021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:03:04 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so3069575eec.1
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769184183; x=1769788983; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdsujPA3al0itvw8vdSyJ+S7ZXfhkhhLTVitXubjyIc=;
 b=Z7aBsTfTu/tkA96tWYRkwpq+UuSfrf/5rcz0tMOVil3PUkqW7MDS8P03j17xxEtemm
 lBXcc5+DTG4f36UD3vtRY/VrTIYYjECzB9pt3bAMnZJPdDR8Y0o87P8IoTXOAIbi2GCN
 5kay4W+PL9MCOiQHLOYAzyt1gbFKoNHLEbTANQrwOpV8qoimbbRrh2dVXwCnw6/TE7Zq
 /ze8Gq0vuLUwgvIYlAdWjp7nGxL3I7r5nMgXYb4zWm6Qkyg0SqhXbonIGONZ8FXkUgFS
 NCojtIxycrH5jCnFJxL0nAgC/oOlNxiRWz26QTW12J4dxSFTqFskFQxpMyMCntEPrtHN
 djLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184183; x=1769788983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cdsujPA3al0itvw8vdSyJ+S7ZXfhkhhLTVitXubjyIc=;
 b=nxqO6jvKWXyy8dJxB5wVo+LHz75ep8c9jIGkL+d98NnPwo3y65UCj19bA02cb6uic7
 r6qRu/wCSacooGuMlJg46R+sTrpKWTVHujFvcZwVHGua7wEq5HWQWWakXN0bDMJeTUbk
 uBxutjL2z74vTRPxdF38j5nOKCK409mtYDFW+3fOMLsPTkPwEOYEEUmPo5QJC0KdaSJv
 80sXLbn8Idi80fTrXH4Cb9MywTqZTCjqEfIsLYwjr5qcLAxMZ8R8AER3Eb0FA9Flc/gw
 y+4Y37f161TI46rwIAgWtr6YYEJYqfRDEWglZeK6wcssqUxCNmHmCMB0Bap52DYuIjUo
 rAxg==
X-Gm-Message-State: AOJu0Yyg1e0bdiqTjYYczxBULL4V6b0R2oCM+DDgpQQ87j+D2D4Bd/4L
 hxBH47hez4SdsjGvAu7RZ5dsSDa+rZQHhM9QbBJj5Tg7ehVTJ7S7dH4Hu+PVqw==
X-Gm-Gg: AZuq6aIt5g2tm57DqTEW+fwDgOsC/5vURuwlmXD+32h9Qi/+LTMaIQVvJrKSV0W0FuB
 tNlimHspajzOqKmdGqlYVZCEMiufsACcnZUXfE2Y5UlcEAcu6nrzeUhgP33DrxOmxZAgba7rYLI
 j6iV4AIB/oZaIwC/01njug9mkawt71AFbmrj2hOo3wSsgNJd0uq5u0Z9PGgjOeFpFOQOLWi01nM
 EHr2lJDEg1Q2we1V7sjrXSZAvrFcLbymyp+2Ddo5WWpe4f3eeYXzYWSgyr83SVWrDoqLQTo6XWr
 rhjt7KU9FKiyO3cofHUQllmn5YGE0LPzztkVXUFAyJCq/sHnPTALMzGW6+sPS5uRbt1d6uYznh3
 l1l/VcCPB0ahBicKcRvTaPaPM3GdD3tvoAmwyN0FFH3IyhNdosGxiIB0WQwljLbxKuxiVkOjSfo
 32NXH3T6YqHOH99i6gtdYJVA==
X-Received: by 2002:a05:7300:cacf:b0:2ae:581f:ce5 with SMTP id
 5a478bee46e88-2b739956f8fmr1636760eec.7.1769184182818; 
 Fri, 23 Jan 2026 08:03:02 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73a6f5d2asm3514158eec.14.2026.01.23.08.03.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Jan 2026 08:03:02 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott <scott_mitchell@apple.com>
Subject: [PATCH v16 0/2] net: optimize __rte_raw_cksum
Date: Fri, 23 Jan 2026 08:02:42 -0800
Message-Id: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
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

From: Scott <scott_mitchell@apple.com>

This series optimizes __rte_raw_cksum by replacing memcpy with direct
pointer access, enabling compiler vectorization on both GCC and Clang.

Patch 1 adds __rte_may_alias to unaligned typedefs to prevent a GCC
strict-aliasing bug where struct initialization is incorrectly elided.

Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
to enable compiler optimizations while maintaining correctness across
all architectures (including strict-alignment platforms).

Performance results show significant improvements (40% for small buffers,
up to 8x for larger buffers) on Intel Xeon with Clang 18.1.

Changes in v16:
- Add Fixes tag and Cc stable/author for backporting (patch 1)

Changes in v15:
- Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST

Changes in v14:
- Split into two patches: EAL typedef fix and checksum optimization
- Use unaligned_uint16_t directly instead of wrapper struct
- Added __rte_may_alias to unaligned typedefs to prevent GCC bug

Scott Mitchell (2):
  eal: add __rte_may_alias to unaligned typedefs
  net: __rte_raw_cksum pointers enable compiler optimizations

 app/test/meson.build         |   1 +
 app/test/test_cksum_fuzz.c   | 240 +++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c   |   2 +-
 lib/eal/include/rte_common.h |  34 ++---
 lib/net/rte_cksum.h          |  14 +-
 5 files changed, 266 insertions(+), 25 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

-- 
2.39.5 (Apple Git-154)

