Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E6C9832B
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 21:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06ED342EAA;
	Sat, 17 Jan 2026 22:21:20 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5F3754025E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 22:21:18 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-121a0bcd376so761634c88.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768684877; x=1769289677; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQZRAffUv9Sh3LF0K+TnkUOjPvYKMxA9+UgLkHSb4+M=;
 b=lmPN66AWeJ+ne6TgfQmGZhnr4t4msYU8keKJ3D4ySsiwsS+RyrbJXZQD4LxGy7LcfV
 RcYTMUUBDA9IWK5XWWc6zE/skocJ3kQvR+t6XBSRBA4AGJRdMZAPYSo+jCrJVLt38qnn
 Eidr/DxnDfsIv1M+Ax2ty+EVMuOkI3Up36yMGXHHA1+cCTApPMVr9HKidojBck8S/sCO
 ptpfCifvyj3SwkULE+pbJt2VwLZToODP5EgWTYFuMWMWVQ08SrW9xewTLayUNrG2nwZi
 AdjeobdvAQZcyMlXEtJ2DyDRKcrR8bGiwgiuAoI+dYipQ+gSI9ZeIFwqyoEpDmbSMHL8
 B9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768684877; x=1769289677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQZRAffUv9Sh3LF0K+TnkUOjPvYKMxA9+UgLkHSb4+M=;
 b=B84TIEP+9zA/nTKilYsci3zZU1JD/6Fh9oEiulUscLLMOCguwE9KAv3csZKSk/3VW1
 S1o9xznFWK6ovQkFo7XpHqQwTIkM5oeYtkpnMHrWZjSrCakr+9I7bzH/nyQV0ZO5OZCS
 QWaTTAsOgyc2r3n2YXHzOcdoob4syVMJMp5gG3ht/ZkkU2DzAIx5/uaZMqSd55X/Dk5N
 0H+vX4lh3CvbnpcXZ+ilkdLXatev21h9d4BtIgZCCqLwI0ye4H91K4TdsAQU1RjjzvFs
 44BIC1SGdSG0nAHgSj+3xkD+uuqkN6aYXkZBRwlzo4T+pP4a0UTxHtvK6xFuwn5eQTzv
 rqOA==
X-Gm-Message-State: AOJu0YwySyfl/EvX8mMOxgVmqGgDkCncYi+IxBXwRs++nfmAunuLHvAm
 xV0XUUDrrIZjN1z7dPj6znzMtyTAYpuoo3hxYUy6McLmyiSC5fuUFg0KwP9Zyw==
X-Gm-Gg: AY/fxX7hJWTvdTKgC+liuyPbay424yAZ9yACKKvHVWaEmdLJxipaon4/AHadrg07cjT
 CK25wN/Wo0QefOhRlvoRvusTz4WrRCWRknuy/W5dCH4NldeuUcjq+KMf7kVlPpyKwwOg+IDmVt1
 zf8Js2Yt6/JDk5KuDwmraTBEZBGcY5D4cFKgv5tBPhAwAzGmVqrNiN0wyuhsGy4Ve/IHu1grM2T
 65UTS5LGUNXxUF+oJ/xGf6uuw0jVmKPmcQs6dTbnckcrvFjp7Sx2av03SDWb93se+jwlAt5KGdP
 laArc32HvOFqqPFhHKeO9P5cyjU0rfPSmTFCFDTeanhIZehedYS18KzzeZFiGrYJ4DuO442nlZS
 lVE5EqzcQWw6HpKyKUIRHJz7TnUk6WCpnfZK/wqitPY3RjmyhwZGXSCua/LURe6yxiuftJ7cdKn
 8BXUv6Meukm1DdtGNIMekiBw==
X-Received: by 2002:a05:7022:f91:b0:119:e56b:c753 with SMTP id
 a92af1059eb24-1244a73e230mr5528454c88.24.1768684877060; 
 Sat, 17 Jan 2026 13:21:17 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1244af10736sm8480076c88.14.2026.01.17.13.21.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 13:21:16 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v15 0/2] net: optimize __rte_raw_cksum
Date: Sat, 17 Jan 2026 13:21:12 -0800
Message-Id: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

This series optimizes __rte_raw_cksum by replacing memcpy with direct
pointer access, enabling compiler vectorization on both GCC and Clang.

Patch 1 adds __rte_may_alias to unaligned typedefs to prevent a GCC
strict-aliasing bug where struct initialization is incorrectly elided.

Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
to enable compiler optimizations while maintaining correctness across
all architectures (including strict-alignment platforms).

Performance results show significant improvements (40% for small buffers,
up to 8x for larger buffers) on Intel Xeon with Clang 18.1.

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

