Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99305D46BE2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 873A84026F;
	Wed, 28 Jan 2026 18:31:44 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 3F2374003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:31:43 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so504695e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621503;
 x=1770226303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HY9nAhANWLQY3mKG4Ji9XTL6FpXH+gGz4Pl8yEI7XpY=;
 b=iibN+TplBhFEu5b9ZXhgytwA2j8ncPBdgjjI5HY2QZdSS3zLNffo0Or4OwYgB11e/A
 ZG6ceTTtyeBEE7qvGuI/7RIxfA99OZ2g0w+443dLnKFEJSL/TnEKy32QfUduuD87t4aL
 1e91rm/YoKBOwsh19Yw2+012KlsfuviD0JGV6qxWeFl7CpkHdRXCCxBjgds5/Z6mzfi6
 pvPz1zbQiO84lIfx6auEImNXvi9tft5QEsDE/n59VcmHQIbT6YimHky9Qdc5rtRGcaoe
 Zv4YLfvc7kCAOknAJEykoN3bPHuEAzpUa5mCuBuCXN5i/wXs7LuLc9e/rybsAoKVeNqx
 u57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621503; x=1770226303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY9nAhANWLQY3mKG4Ji9XTL6FpXH+gGz4Pl8yEI7XpY=;
 b=F5En7NjLY3OUhND28tKcxVzu1TOa9kWc4tLsEoFC0DrbUoH9ieH2SFXCcxXIWW/Ha2
 HZQK43ORTiJECXaoDXiqE+qSQu9VTDPJoBxgW1jN2Rm1F6Gl9Uo+0NiaoXcui+weifMA
 qEog2mU7/G9IQ1uF+sSLK0vfbZ+vFPUcK7ewZuSWjxBKhn/99iKGQEapwG9jcY/NmtdV
 zxRXp2FLd+VBrDppG7fPvFlFrCRhhcjnX/70lc0NybpBn6CM5YntBxVIa1dMRftSbG7E
 LCWaIhEQtTXf2jCewmuJxzD53dEjcvM1a/oYqRLDonjGJ1bNL6oadlstYV9Mr7ElDpUb
 xHow==
X-Gm-Message-State: AOJu0YxZh/ZOh9Nlz+ylrsDgAcJEOxE/GrIPkHIBDLtk+iXf9z+jcbHl
 SK5WiHwOp2tq7mtJ+Ay0J4ZyMep3gaXaDtcjXTXL7Iw9w3vMDXI+aI7yZcw0bV2nI+ExP+UE0Y8
 0RFHL
X-Gm-Gg: AZuq6aIu3axeGey8U3FTL5Hn8SAkAWU1LP5s9akRPyis688FQbQIM6OnpMDfWAgGRNN
 USMq1nOmv6c1ufUVFLgIiwfeJSWfjEqvtt2KhLE80vt23hUbEX9k7ZKE8SvRue6lN2PtoFPScIF
 NBx/Ou+7jtTdR5CvivJJf64gREKrWFxogYzWX4+L2b5Qtqofhg5xq00ZYzboF1/i5JKXD+ZOxAf
 +gmHOgBNMWa49GFcO4/0L+LmRYZdrjzsmSiMLJcjUSPHpPbfOzLEXllvX/Ne2o25FrAQK9e3keM
 wbGJP6pGxT7xBjLG6+VgQlnQpendJPHBCPKU1z9Q11tUbZiPiU12t5sBrPXnHn6IA6rKeL85Zhs
 nA3QQUl2iZbviI5m0Wb/1V0ZWJgpwgK3rtnZH8dN1CAWZljGG8KHRSLcp66vpe/fCXvAx3mWQ/a
 jJmtly5KLI+CmYsYHdM9JCt+wmfbIGKxQrVWfGW1gzG1SOqPGiEQ==
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr59045495e9.36.1769621502640; 
 Wed, 28 Jan 2026 09:31:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133732875e9.7.2026.01.28.09.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:31:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/4] net/af_packet: cleanups and optimizations
Date: Wed, 28 Jan 2026 09:30:16 -0800
Message-ID: <20260128173138.151837-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This series contains several improvements to the AF_PACKET PMD:

1. Remove unnecessary volatile qualifiers from statistics counters
   and standardize on uint64_t for consistency.

2. Add a unit test for the AF_PACKET PMD. The test creates a TAP
   interface and uses it to verify basic send/receive functionality,
   statistics, and device operations.

3. Implement VPP-style single/dual/quad loop pattern with software
   prefetching in the receive path. This optimization processes
   packets in batches of 4, 2, and 1, prefetching upcoming frame
   headers and packet data to improve cache utilization and hide
   memory latency.

Note: The test code in patch 2 and the prefetch optimization in
patch 4 were generated with the assistance of Claude AI (Anthropic),
with manual review and cleanup afterwards.

The prefetch pattern is modeled after FD.IO VPP's packet processing
loops, which have proven effective in high-performance networking
applications. The key techniques are:
- Loop unrolling to reduce branch overhead
- Prefetching next iteration's data while processing current batch
- Graceful fallback from quad to dual to single packet processing

Testing was performed using the new unit test on a TAP interface.
Performance testing on real hardware with high packet rates would
be valuable to quantify the prefetch benefits.

Stephen Hemminger (4):
  net/af_packet: remove volatile from statistics
  test: add test for af_packet
  net/af_packet: fix indentation
  net/af_packet: add VPP-style prefetching to receive path

 app/test/meson.build                      |   1 +
 app/test/test_pmd_af_packet.c             | 875 ++++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c | 286 +++++--
 3 files changed, 1079 insertions(+), 83 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.51.0

