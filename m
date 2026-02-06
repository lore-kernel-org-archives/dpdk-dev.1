Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9985FECD9AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAC9940264;
	Fri,  6 Feb 2026 02:11:51 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 4F0F840156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:11:50 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2b72e49776eso347568eec.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340309; x=1770945109; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cooh3GWhwXJxvN6QrgFqEqJn7/qKLq5LfN89KSRryBo=;
 b=Qv6JVZ2FlIwukaNshuEchce3UmGbSCz86d0JpEQfhrEYtB463uMSDgS1LSB8jj8sKW
 jK6Ml29rcpUqbIGV/NQN3Xiy45cHLvzqSy99NrFsHF2u6Tqeb3RWtQzWEDFq/tZ/8ATe
 oa2og77HREFjBf00ZPyLl336FgJqvr6EEJ9odgQZ56oU5wfdXyPhAIh9YlftYzTnBzAr
 I47c6v4NqGxQEHo/B0PbGrIsCXk+brhbH1wGKV6Wc4/B5xkh4zpXdVQfsGnjNBQGlL/d
 7mBf2hAKj9w2rjpFe3PUnNsuYfjGQTU4aIlPz9hRy9K3mIZ+rWmbhQ64hiY4dAV8GXiX
 qGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340309; x=1770945109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cooh3GWhwXJxvN6QrgFqEqJn7/qKLq5LfN89KSRryBo=;
 b=TV/FkWPfqW+mznsBAHjDRDRY7TqpIqO2JmqoPmcIyGZC1rLPreCbAOgORKOiiHuCGJ
 O6dVmL3G/y8bYNTG6O4SSbJz58V6QxIiPAsSDW0MrynynEKnWLt8zFIBl2tS2+vlotQy
 h1SfhJrKhDEBgLAd57Pk/Z2zYyR5QvIDsWXhZgjnOkS6xUiECTUV6cbx+1xM7vJGR4xw
 sDcFYFPF3jqqawhJdUJRdnuuyvN2Ox5BV1/s6uHNfj5c6Ktvirw4M566YYcUqm+3AZCJ
 SL72ouDKNdM98UnhtN+wnAZIyO8IswWMB6oqgQLP0a/EzFhg3pNMTwBOYpUldtmu00db
 NNIQ==
X-Gm-Message-State: AOJu0YzmI1ryb0OPTF1XyvSh3Rrif+cEm83z/VIisnj82U1Xh1oyNcOB
 yNJA62wbxwmOVI2DKIj2rfkdDUFURhfcVSEI6esrZiZi1/moP0ZZ7snOqNP7og==
X-Gm-Gg: AZuq6aJAmcmqjr2Jxfei7GgN3Kn+8jNS8VtvR2j9K+5GMM23rcCINxH+DikN02rpju7
 3LrvNg+7GjpQ8dyHAKeq0Iy/VefRXi8DYxb94xCXVBJPAAYuLzaN3JUpnzYCBlzmJ3y6OoAaRCZ
 qqiaIEFOXha1Bt/RxfZFj1F3GZbOwmQGudPxQJ2BAjDPLQ/ZDqlHLc4GRayJGkjts7qEDPognip
 2VFmrSODbOy22t2FiBnY68HL8Az3wxUACvhXQ6i6PfdiWLKTtja16POUOHXJV/C9qz4nUe1IfIA
 MdfvhGSCo5ld7X6y6YkibvhTBQm9Hl5cyPPe66hxjbvTyJLKU5+HY8viaDlH9hYwuxH7Ge2whBQ
 Vcxeluj921lOveP8CYXcrpQHR4VBzgnn1BE3nbhoWLJGgQs/cGXapik/VgjPX8++XaIJIHdAITS
 7IVUJqeUvGKpZwXf1mTe78P0wZwZLRyWGyIT/cspGhwrJuUkd88HehMFuy0MjvZLU=
X-Received: by 2002:a05:7300:8184:b0:2b7:ee0e:e9dd with SMTP id
 5a478bee46e88-2b85683434dmr608401eec.25.1770340308946; 
 Thu, 05 Feb 2026 17:11:48 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([216.157.103.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855afc852sm711730eec.13.2026.02.05.17.11.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 17:11:48 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v6 0/4] af_packet correctness, performance, cksum
Date: Thu,  5 Feb 2026 17:11:37 -0800
Message-Id: <20260206011141.2377-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
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
- Patch 2: Bulk mbuf freeing, unlikely annotations
- Patch 3: TX poll control to reduce syscall overhead
- Patch 4: Software checksum offload support with shared rte_net
  utility

v6 changes:
- rte_net_ip_udptcp_cksum_mbuf doxygen EXPERIMENTAL tag

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
 doc/guides/rel_notes/release_26_03.rst    |   9 +-
 drivers/net/af_packet/rte_eth_af_packet.c | 253 +++++++++++++++-------
 drivers/net/tap/rte_eth_tap.c             |  70 +-----
 lib/net/rte_net.c                         |  69 ++++++
 lib/net/rte_net.h                         |  25 +++
 7 files changed, 292 insertions(+), 142 deletions(-)

-- 
2.39.5 (Apple Git-154)

