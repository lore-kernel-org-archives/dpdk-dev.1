Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7FED35690
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9417740274;
	Wed, 28 Jan 2026 10:36:14 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 7CE61400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:36:13 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124877d78a6so4380142c88.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 01:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769592972; x=1770197772; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWctvwMLzan6h7VAsrTFIrrIIHs78aS/C3j4jYhnsuY=;
 b=AgX+b8yOWiVj4Iltz4l/9aV3l9je4tEYIeaiCXGqjX0w+6B2tz+a5RueJoQVcWoLcO
 DfoiWtli/5HNXyUi4hy/6vKd//RUVLuK6+T+kOJpsUUsexovOzDqvn1svETivgo/9vlL
 A8qGY1w6lcr8N8ox79muguW7jFqeFzvMgtcJB4ZOvgy4BIFS6QUtj0LefswG26br2Sh6
 nwzS1t6ZzC+t7GwxodsmplllBAaMyBUgAwB2I7Mn0FEgNLoiEp0s+qMx2RuAz/PKv943
 LrQMt2LJD93ZabEC1GoBW2iP1eMfSVNaZKTmM5a07Uetaywc2vWJH431oCvAFvMJ/pss
 p//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769592972; x=1770197772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWctvwMLzan6h7VAsrTFIrrIIHs78aS/C3j4jYhnsuY=;
 b=B3QI1qFwLFYJN3gdTFXHuCjgTnd3M9Pwmh7MJ8xIloAdT4XUR3fYaMzVzjy/nOEA0A
 QJ00kX9NyKljWJEjJhd1obA4h7F9ZynX2GSQGRC5h/SCPsCFNwPxyRU9tLE2TLBOQfxP
 TaNd/wxCrMEHisbshJaAiHGPx4YJIZ54RXRSvgqrFaPn6yI9EXjX3vXVP/o59XATIseo
 pnHVXxDZS47ty2Uc3kYO/I3rDNjAja1B7IntJZqq0pZwW3TB2UTK0Vcld9vmKIdLtQKH
 J8KSKgEJqEfJzoFMX+pYpAijOuKL2ld/ArPNTnxWGJszUG0MLeJJ8tkVjBxbTxkHP8HD
 jG7g==
X-Gm-Message-State: AOJu0YyW7Pz6UVxzWcagVIdT2yYdfKJfzdSwS5LF3OpdRin/mfge60sE
 E4CdSThy7h6lgmW53kLbTHKWlMM3AXd6n+EIJrJYjlPP314NV07EBM8H1MLkKA==
X-Gm-Gg: AZuq6aLYCcfNUC1rj5JNj0u2C1MbN2VrusEFGKv3WeG2oGmP9igpuT0dkeDNxNBNfs9
 USw6/3NiKgAGyCGbg9fZ9tbDQac4yzyVOpTEwF+JpGIE7tVjTn0So1SPkdxTW6k2IlRg1o7ke7T
 fBNhEIugwFAvZixdkU8emKXvCYWG8P//K/Yd2jQ7kxqXsmEUISbcqEAIZyJdwnbJHJyi3/KCWTA
 x9Jeyin6ZlzhrMR6M4TNJ/XLxQYqNaFAPOCAuhyjBzIf+U8ZiSymHY2ikJ3XFvOApNeXO9mH5b1
 sdDoeITcXHheH1UYs836nehAVx8rb/XnYhDbc6SUPiglHwhGtMZgPjZIyK+WzobkUomxT//a+sr
 kHWuyEfOW9I9OTJUDDQE1kIuQFj146AX9qd+2ghg0mgBjJDjlkGmQ1VIsFsDfd46GNoA4Bl3thg
 0a573VP2VDLB6xm2Dw5+bSjK7MJ7iyx8fS
X-Received: by 2002:a05:693c:61d0:b0:2ae:5af4:7d65 with SMTP id
 5a478bee46e88-2b78da0f5d1mr2670240eec.31.1769592972159; 
 Wed, 28 Jan 2026 01:36:12 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a14bb02csm1834864eec.0.2026.01.28.01.36.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 01:36:11 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v2 0/4] af_packet correctness, performance, cksum
Date: Wed, 28 Jan 2026 01:36:03 -0800
Message-Id: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
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

This series fixes critical thread safety bugs in the af_packet PMD
and adds performance optimizations.

Patch 1 fixes two major correctness issues:
- Thread safety: tp_status was accessed without memory barriers,
  violating the kernel's PACKET_MMAP protocol. On aarch64 and other
  weakly-ordered architectures, this causes packet corruption due to
  missing memory ordering. The fix matches the kernel's memory model:
  volatile unaligned reads/writes with explicit rte_smp_rmb/wmb
  barriers and __may_alias__ protection.

- Frame calculations: Fixed incorrect frame overhead and address
  calculations that caused memory corruption when frames don't evenly
  divide blocks.

Patches 2-4 add performance improvements:
- Patch 2: Bulk mbuf freeing, unlikely annotations, and prefetching
- Patch 3: TX poll control to reduce syscall overhead
- Patch 4: Software checksum offload support with shared rte_net
  utility

v2 changes:
- Patch 1: Rewrote to use volatile + barriers instead of C11 atomics
  to match kernel's memory model. Added dependency on patch-160274
  for __rte_may_alias attribute.
- Patch 4: Refactored to use shared rte_net_ip_udptcp_cksum_mbuf()
  utility function, eliminating code duplication with tap driver.

Scott Mitchell (4):
  net/af_packet: fix thread safety and frame calculations
  net/af_packet: RX/TX unlikely, bulk free, prefetch
  net/af_packet: tx poll control
  net/af_packet: software checksum

 doc/guides/nics/af_packet.rst             |   6 +-
 drivers/net/af_packet/rte_eth_af_packet.c | 257 ++++++++++++++++------
 drivers/net/tap/rte_eth_tap.c             |  61 +----
 lib/net/rte_net.h                         |  90 ++++++++
 4 files changed, 283 insertions(+), 131 deletions(-)

--
2.39.5 (Apple Git-154)

