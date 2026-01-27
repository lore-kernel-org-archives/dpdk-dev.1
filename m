Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88477D2FECD
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB0CC40F35;
	Tue, 27 Jan 2026 19:15:16 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 93CC140E50
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:15:15 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124566b6693so13247894c88.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769537714; x=1770142514; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p2H2bsrcZh/HFyfEBVBDZA9hHDlFxiSnzK1LyYYqI24=;
 b=edPQC+03zIldi6bcNrLYYZ92F1K7ByVR0K0l2GfeAeodoxFL0kTfxk+/pPHJgLWNfW
 tVGuxLzsn3nHglxXOpzXBTg1KReHjeYOIomgQm6r9xAI79jXS3Mc+CIX2FyP2QyyY1SO
 IduydjikTBmiri2QoOdWLLi7bTGx+L7f16FMf3thzjsdvNREL5Q7PVkm0/sBFGTYL8w7
 we0/vKh/9vhc1m6s4ZvvN4EOpgfPJyuOZGRLTsf96NxODcf2GTTV0wc/ib7sAMcLOz2H
 w0sx1PvTPlm0blcxTik60+XOG+eRjLlKbbj+q+7mISzfXaqxOjLTWxAIagwTwph2bLSN
 cMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537714; x=1770142514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2H2bsrcZh/HFyfEBVBDZA9hHDlFxiSnzK1LyYYqI24=;
 b=dVs7tJAvh7MqouVrGKxhzMsEGJrpbksKjWVfOCmkUHp4aDEFi1M2LRKuptrKDtyTaB
 IOtnnT3r2OK2qE6rX6APW6xprXfPOuexmzue/2xC0s+9UxJcoJON9236LrZxII5i/YcH
 u81c0eK1Y9tWMWt3x+dZo4isEn7u5VknaPf73z0eS3Qzi7xbeZSXLqtSx88ESVF+HiMc
 kRVfqPd+wK3kYmvZpE2y6aotxJkCH8ziymV8jIhAePRkZEvBePAz8SZV/a143A++QAwM
 zVCNLEloeqtE638wywaTlWPKrvdAkFWXrk/CYUm25cm/h8Nka7pdxKRbN4ezT2IEN04O
 WvVg==
X-Gm-Message-State: AOJu0YyKOZI3cJJxLy+z82HU1Wqf4Urm8HQdd+m8Qhh0Dwcucbo07Pmv
 ozN/9SGiKx8bjUc6jDj+Twq/lMWAcvy4i7+BmswuYCTzDxGQdb2vb3Nhotf4Tw==
X-Gm-Gg: AZuq6aJ79eHrDhcjAbwh1pzkTBVXFvrgW8Gs9lb6zHAq2LuS7m4lTSP5cWuSbi1YWMD
 8Bu/uWfQ+phn5Zhn6MMJxgfZxWZj5hVxA8IO800EEOqgljTyUsniq0UPiSKFlrewWMG0SDx9ws9
 gq8WurNoR18DEAsq220RZ/yLqXd27GcFZP0CLfTs5XJa1nP2aaa2oJ4UyxEkG2zDTO8b+wys+2X
 P+wxydzEhwH72T8LeYmf3cPfsbOX64GU1Wee17JG9Qw4x3OcncsJeXtJ5ccA8Z9U3kutWutwxoE
 vN06qbF9jriiaZtPbeoz+WT5KQlnbtI+cJEwNRD6Wt0TIyYx4EMGZBBj7CSPxAbRW5tvnrdRnvF
 w0RN3vj0d7DHEtNVwbvNkxZHrqa4WRdvbvidYPaX0Y8iMPP+u42bWDd2Oec0P3oc1kqU8C7E5Yw
 cN7TLWjAztx2yg4O4jN0e/Yzav3ktV0XsNVHZsDz25q4w030LtLA==
X-Received: by 2002:a05:7022:b8d:b0:11b:9386:a3c0 with SMTP id
 a92af1059eb24-124a0129df7mr1491523c88.43.1769537714207; 
 Tue, 27 Jan 2026 10:15:14 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a7bf8f5dsm483172c88.7.2026.01.27.10.15.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jan 2026 10:15:13 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott <scott.k.mitch1@gmail.com>
Subject: [PATCH v1 0/3] net/af_packet: correctness fixes and improvements
Date: Tue, 27 Jan 2026 10:13:52 -0800
Message-Id: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This series addresses correctness issues and adds performance
optimizations to the AF_PACKET driver, laying the groundwork for
upcoming advanced features.

The series is structured as:

Patch 1/3: Thread safety and frame calculation fixes
  - Critical correctness fixes for multi-threaded environments
  - Proper atomic operations and memory ordering for tp_status
  - Fixes frame address calculation bugs

Patch 2/3: Performance optimizations
  - Use rte_memcpy() for better performance
  - Add prefetching for next frame/mbuf
  - Use rte_pktmbuf_free_bulk() instead of individual frees

Patch 3/3: New features and device arguments
  - Software checksum offload support
  - TX poll behavior control (txpollnotrdy devarg)
  - Improved devarg validation

These changes prepare the driver for planned follow-up patches that will
add significant new capabilities:

- io_uring SQPOLL support for TX send notify, which meaningfully improves
  performance by eliminating syscall overhead and enabling kernel-side
  polling

- GRO/GSO support via PACKET_VNET_HDR to aggregate packets and reduce
  per-packet interface traversal overhead

- TPACKET_V3 protocol support for block-based RX/TX processing, providing
  packet batching benefits and reducing cache pressure

The correctness fixes in patch 1/3 are particularly important for these
future features, as io_uring SQPOLL mode involves asynchronous kernel
updates to tp_status from independent CPU cores, requiring proper memory
ordering.

Scott Mitchell (3):
  net/af_packet: fix thread safety and frame calculations
  net/af_packet: RX/TX rte_memcpy, bulk free, prefetch
  net/af_packet: software checksum and tx poll control

 drivers/net/af_packet/rte_eth_af_packet.c | 389 +++++++++++++++-------
 1 file changed, 270 insertions(+), 119 deletions(-)

--
2.39.5 (Apple Git-154)

