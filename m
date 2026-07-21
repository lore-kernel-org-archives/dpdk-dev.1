Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD8C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30CA1402A7;
	Tue, 21 Jul 2026 14:11:39 +0200 (CEST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mails.dpdk.org (Postfix) with ESMTP id D5CFF40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 14:11:37 +0200 (CEST)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81df8abfa7eso207464567b3.0
 for <dev@dpdk.org>; Tue, 21 Jul 2026 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784635897; x=1785240697; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZL6n/tF6mViUQusrUwVXxidKDepWWumTCYHl29OKmpc=;
 b=k2NduD5h8GVPaAmzWjkxzmZprf6EMylyyfMb6daI1oxo5tic43UEqrH4HDgB3UYo7r
 fLtbm3kLBVbOeCYzkaeLo5QAKCnwfq0cjjPN+st03jaYhJ7JZHGm3g+mhvIpWcRw+3Xk
 9V35g6+3WgAiETy8G2bqOSiz94L9k1cr32IWtOQbdZpWIroae+nsH3TB/mZFrXnv5aV1
 12eq9lDn9benIUiGxIOK7MR0c6o9jKXvqbW0R3O3UwvkckdaXp7EgTrHb6uPwA1z2+qV
 AshIefDAxfRGlHSonF7Aoazjm4MnVJo5LlRH73vSotIIm7s5RW27xzBt+alS6gLYigWv
 N2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784635897; x=1785240697;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZL6n/tF6mViUQusrUwVXxidKDepWWumTCYHl29OKmpc=;
 b=hHDhHU7huGjlLk7duP8PiGZ0pluw6N4A/f4V8W3eKjFQGNNFFmqkT034av2yGyVv8t
 2kiB0zLxkVKeHGp/a9knYRz+n2In5P/1HPiZTDiHqSWhi4eSIFTwTf+c+swCKfE0Fjcu
 /lviopkBed7J0rfnffMEdz6s6HPs8uedN5/XZr3Yea+B4/Mp+3ysgRBp3zXkLhR7iob9
 tM3uJXNiKh+soss8QWbS5rCvL67sJPJyYTJiX1ZVamLUOuoT7fxLVn8wg8eqGunJ4Kab
 kjwMXGXFNeyY+RkCxMwjKUHyY6d2bp/3JfsyoU+4JML6snDD6t7jCJDoWgpmakrumx/J
 qwqQ==
X-Gm-Message-State: AOJu0YwFIRXUT3ouXle//0mm7pZAuBxA1TQHRCktvwLdzH8nGeTcSWrj
 BVWY/Vr0b9Dj13XjOIuYhVSzScFeWcozi6jtUgRQ2ZY08W1uTdkQkGjpfD7HQnXvmAzvA0gWaA3
 7J7s2rvpE2+hC272Oej81P9jajwfAb97pDxLCmlVhyOIOrnzU2Aee5pLPdqIxyYXfm7WdZ/GWf+
 FeFgeE4JPRmR5BciBfxCnp8cc=
X-Received: from ywbfd13.prod.google.com
 ([2002:a05:690c:318d:b0:81b:e4f3:2177])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4d84:b0:80c:2874:67b8
 with SMTP id 00721157ae682-81ef254a7d6mr54313937b3.32.1784635896699; Tue, 21
 Jul 2026 05:11:36 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:26 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721121129.2911774-1-blasko@google.com>
Subject: [PATCH v3 0/2] net/af_xdp: add Rx timestamping and read_clock support
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, mtahhan@redhat.com, joshwash@google.com, 
 jtranoleary@google.com, blasko@google.com
Content-Type: text/plain; charset="UTF-8"
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

This patch series introduces support for dynamic RX timestamping and
clock querying in the AF_XDP Poll Mode Driver.

The first patch introduces three new vdev devargs to specify
layout-agnostic metadata offsets and bitmasks for extracting hardware
RX timestamps from XDP metadata into the mbuf dynamic timestamp field.

The second patch implements the read_clock ethdev operation, querying
ethtool for the interface's PTP Hardware Clock index at start and using
clock_gettime to query the NIC hardware clock time.
---
v3:
- Patch 1:
  - Add PMD documentation and release notes entry.
  - Move dynamic mbuf timestamp field registration to eth_dev_start().
  - Replace 64-bit pointer casting with memcpy.
  - Add devargs validation and support auto-base integer parsing.
- Patch 2:
  - Add documentation and release notes entry.
  - Add PTP file descriptor cleanup on device start, stop, and close.
  - Return -errno on clock_gettime() failure and fix PTP open error logging.

v2:
- Patch 1:
  - Replace static metadata struct assumption with configurable vdev devargs
    for layout-agnostic timestamp offset extraction and validity verification.
- Patch 2:
  - New patch introduced in v2 to support read_clock ethdev operation.
---

Mark Blasko (2):
  net/af_xdp: add af_xdp rx metadata and dynamic timestamping support
  net/af_xdp: add read_clock support to AF_XDP PMD

 doc/guides/nics/af_xdp.rst             |  42 ++++
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 279 ++++++++++++++++++++++++-
 3 files changed, 322 insertions(+), 6 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

