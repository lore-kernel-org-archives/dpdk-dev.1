Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157FE73141
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 08:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB17A4066B;
	Mon,  2 Feb 2026 09:15:02 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id D824140285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 09:15:00 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-11f1fb91996so4554012c88.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770020099; x=1770624899; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwgTw1NuykJ+gNoFquDxwsLfShNCgeHQuG0WrP7ee9k=;
 b=dAJfDt7s+/tqZdJxIVOIY0H1NlFyVxUsPRAmvyewaCAe9IgthtPm0pyKEvG6n3RJRN
 Wf2+Sd28aZqqrUYw9YOQPiHTekjrEAl4JSLPnbBPFZqWT6Fn3OO1Q0Occe89dEMobjvJ
 6LyH97yFYE2wHbev4MeMUK/O9iIh9NO0C3mPF4P+OfQWKqDCo0yLJY0fRYdRWuncR7gF
 u9hvycNATzaZRNu+RxPy8tHGe3rRCjYnku3IQfZwjabEIF1BVChuIedQoYPU9OedAEWP
 mtYtdOuQ3ITQiZWIMvMVE2zuFPtQKo9Lt8/V4duulBnVdeAUA/eoRX0IM8ADfHHdTU1X
 0ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770020099; x=1770624899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwgTw1NuykJ+gNoFquDxwsLfShNCgeHQuG0WrP7ee9k=;
 b=uMymRLP3tMQs2ooJxjLBSwkCs70erhAXhdmqelyvtWvrGM2wVnl11WpwCMZtdqm2t+
 qbsd2azfaKuNQsAhWeOOsPPz7wB0I+YONjtVTjDrYOmSCE6ZVXep5+n+zXq15czUiJA6
 IuIm6gWMUSGlScCSWdeON3VmBsiZxn5ERNwyje4i00yRFgHyES5nKVIkcwSGaGba0g+J
 mPmHDuHVtOAIAG3sPqu2+ZZN9OnWhtSFMDzICQsS15Ue+09BhJy1VsjT26E7aX4nPyNJ
 8R6l0qvuJNt60u5FATw4o4k3XGjNC4PVU27DtF10rM9/DuKlmZADsNPaweDFFAKtrW/c
 4o3Q==
X-Gm-Message-State: AOJu0Yyl0K0+6QhmADV0wcl9h/zECwL4EbWNSKt2gw8ZyV/mlk4AIRWH
 Km6VUDEJhsQzhpuXX4VKF3IP8IIpQlSnR+b1hngKqS1vnc971BRRPqgG2XWoFQ==
X-Gm-Gg: AZuq6aL9QrPNKob/rejuFXxMWOjwzvNY12YuvEP/PUJrTn3u/J8mm5lqqWHLAj3AIiM
 D/SlENe0rlzTGl+Y7s7NY/Nlo8Cy+SANYL9LnO0FhaJ4UMTvwijcHDfw2ruferjPMYYZzlJqaCk
 R4ONgJK8gpSXxFS8L0rXLyhugO7rgBT6DZ4AJAtFobi6/xXabobs+MyWUOq0sbuzLVxVDR8gbMu
 2Ix9+GJKkzaUL1v/Y1aBtdIGdUnpk75KSWOXTwn6zf2H4g2tHMU/5w/ksqSu9EHga0vazFBNJNT
 DEZt9JikP7w60muZ/s6HVSutRQmev60BicRl0pNv7cZBVWtPimOk0SMFmhBq6gxXmRRdKjUXrMa
 SiyftW3EUQynOeP8eNdb65JllvQ4Jo43CHVhNQuVLFzI0U878CWaYogY9VzaT9OXX7f02iz7nm2
 vw/l6DWrbAuONxfkd29y4EFg==
X-Received: by 2002:a05:7022:2219:b0:119:e569:f27a with SMTP id
 a92af1059eb24-125c102eea9mr5472351c88.35.1770020099125; 
 Mon, 02 Feb 2026 00:14:59 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9d7f597sm17142131c88.5.2026.02.02.00.14.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 00:14:58 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v4 0/4] af_packet correctness, performance, cksum
Date: Mon,  2 Feb 2026 00:14:52 -0800
Message-Id: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
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

v4 changes:
- Remove prefetch (perf results didn't show benefit)
- Fix variable sytle for consistency (declare at start of method)
- Add release notes for af_packet and documentation for fixes

v3 changes:
- Patch 4: Fix compile error due to implict cast with c++ compiler

v2 changes:
- Patch 1: Rewrote to use volatile + barriers instead of C11 atomics
  to match kernel's memory model. Added dependency on patch-160274
  for __rte_may_alias attribute.
- Patch 4: Refactored to use shared rte_net_ip_udptcp_cksum_mbuf()
  utility function, eliminating code duplication with tap driver.

Scott Mitchell (4):
  net/af_packet: fix thread safety and frame calculations
  net/af_packet: RX/TX bulk free, unlikely hint
  net/af_packet: tx poll control
  net/af_packet: add software checksum offload support

 doc/guides/nics/af_packet.rst             |   6 +-
 doc/guides/nics/features/afpacket.ini     |   2 +
 doc/guides/rel_notes/release_26_03.rst    |   7 +
 drivers/net/af_packet/rte_eth_af_packet.c | 236 +++++++++++++++-------
 drivers/net/tap/rte_eth_tap.c             |  61 +-----
 lib/net/rte_net.h                         |  92 +++++++++
 6 files changed, 274 insertions(+), 130 deletions(-)

-- 
2.39.5 (Apple Git-154)

