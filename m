Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D17E8305D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 07:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A07C402A2;
	Tue,  3 Feb 2026 08:07:45 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 85D4640281
 for <dev@dpdk.org>; Tue,  3 Feb 2026 08:07:44 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a95e592fso7513979c88.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 23:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770102463; x=1770707263; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIlOp/m5AFDZjBYb8b3odOG/tQa0DZ0AfEnJY+USMbc=;
 b=OAx7ySFHq/VhXhO0chQqjwDkWzcdkYOLNSJ8WDs1JMSSh5nRVYVXj8FVvhTr0kEs2T
 ZKHsc6s1zYWBd8f1BwteAfIePqAw9Rj2Wv00anqlhxv1/xFnvTe0rfEr0DDNriaO2mhB
 okaEhTiwhmFV7PsGQ6idFUr55RWCR/6nuwKnt3rPBKFM5d2J7Q5W3k51taDGscV3SEUS
 6X9YjaTRe5LpsUuqNktKD9bBkQ7cbJYxQpcAJcqykQWLN6yFlwlHKCRCVlQX32Z1Eabj
 TcKbPtqflpicArsjxvm0euAnPffDs6ffwJgPqK88RadhbV0CF4FS+XE9rP6qZPU9aJvD
 jPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770102463; x=1770707263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PIlOp/m5AFDZjBYb8b3odOG/tQa0DZ0AfEnJY+USMbc=;
 b=L2lOy1MQ7Ix5xfqYz5XXQsf1x5B0MYw86jAm9rZfp1ZHOGOs5XoEsBpQbDIayTCdgc
 Ov4FFCxOdHpZEGnS5Wb8LxGpxYIRdcRBGYwkBH5vQ4dRwkgtezdK/1KIGQVSdKMsV4ZY
 MA+2pm3d1n6fPvrBJo7FTCpyoaqiyyd9riCKkys74rNmCfB1kf64M5LbBa2g3PpNtHsr
 Un0rS4nFu8cjRTIm8Z/y9iubDtzcZ8IR5IT8TFOD1o8Xsdkz9vxdS/o8Fj+gMac059qg
 d+jVi44AMCLx/m5THrT0sSdoX4+iiK6Y/1wXEM96E5bZ9YBzQ5rxIZKia1vjL4NCXeQD
 BGlg==
X-Gm-Message-State: AOJu0YyyPSjydPX7Ra2IILRQf93v6tGrmlEffO3H6XwshF5xBH8gjgax
 e6n5G17fj51ICIGsPXXCPjcvwcFdZ9dEKwwcZd8sQcXdRWBs1GO0ZAV1GBSAkA==
X-Gm-Gg: AZuq6aJ5Od0v/0zOQjTE4BsEgK1FO/jg31IZxAavE/bLjVv3Nx7dfRPkEqhyCdnTVr6
 RXE7jVvv1Nk2fpy0mAc6Tt/UBev48bQZZgD72lhUMZBFiJxFGvyH8s2guHmu/hyBKKr/V9jAA5C
 latDKkOKDaDHvLeJSRycwCj62vCLfWYOrYsudTLTt22FEwbp0b4k2/ye0HQRNyCiMvTUS1/KHUw
 k52YoW5poCX9Mnj9eAQIhXUxe1SCYoRXa/5+w1Zc77ARJ4jlketJURRKMoUaTNfw12tMDmko1uf
 5arIu1BNItP3tLRazuAsbF5aQNnsY1uhH3V6GmfkegEpteqOJetJhLaL5JNG/PgA2E+QJAvyQgF
 2p25d4ET9GQRv/aQipgxFSxT5nU5f2gI2u43wX3+Wm5l8sWoGvMWjuT7swH7l/Oowhlj+O4TlUS
 a/iIPvwm3q6DzmjyFGtXuEVA==
X-Received: by 2002:a05:7022:e13:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-125c1008db7mr6350291c88.36.1770102463078; 
 Mon, 02 Feb 2026 23:07:43 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a16cfaa8sm21073318eec.4.2026.02.02.23.07.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 23:07:42 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v5 0/4] af_packet correctness, performance, cksum
Date: Mon,  2 Feb 2026 23:07:36 -0800
Message-Id: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
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

v5 changes:
- rte_net_ip_udptcp_cksum_mbuf moved to rte_net.c (avoid forced inline)
- rte_net_ip_udptcp_cksum_mbuf remove copy arg, handle more mbuf types
- af_packet and tap calling code consistent for sw cksum

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
 drivers/net/af_packet/rte_eth_af_packet.c | 253 +++++++++++++++-------
 drivers/net/tap/rte_eth_tap.c             |  70 +-----
 lib/net/rte_net.c                         |  68 ++++++
 lib/net/rte_net.h                         |  22 ++
 7 files changed, 287 insertions(+), 141 deletions(-)

-- 
2.39.5 (Apple Git-154)

