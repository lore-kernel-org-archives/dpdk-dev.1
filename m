Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774CD46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:01:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 610E74014F;
	Wed, 28 Jan 2026 20:01:35 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 763084003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:01:34 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so1252145e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769626894;
 x=1770231694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUz3ygcuBOPcaZk8qwXcZzh08sT3jZ86S692/j0yFPE=;
 b=ggy+3Uy+SBG3AnW8B55bhe8gdBjFKbe37JTZ3Xuv3nFCo4kt7n14oGHqiTClhg6MYK
 itrmQfuHh607hwalpHhglLX0BcoJiCZOu7+C4KVQ1+QqzWgfig7sDshAWuiabLTblJJo
 h0FkGEf4rrXvh7iwm/evegC1Ggd3EoVINeWtpt5vGsjIP87Ta8Upxyu1K+2hNtJ+wex8
 oGaf/8Zbid1srelkYH+1q4hrwZaMvWkHq00yAClgzYc4I10Ky4klsM3HrQPkbArFzZ+h
 PX8dQa9Tpv7eD3ZP0NQCGT3QDC3U1TQdiDbc6Kci+aVnpM4VBZ/3AJriXViw9GvJeUG/
 Rc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626894; x=1770231694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GUz3ygcuBOPcaZk8qwXcZzh08sT3jZ86S692/j0yFPE=;
 b=jcWoz08dH7+CcXwZXp8UgrInxrfzBlSuIlEAeeQ3Eo995+wAl10A039y8jeUDQtcJS
 pA/Z+KV3/GawpTYzhMtM3C+FyYoPV8KimEVMo7YgEmL0nCkfZInax7wcclcAEHNgkBY8
 NTtHTCTVTn9FhL8s7MOgsMaghXW91IRwtjAc/S206xPHjHMjBCbDPga/dmFChwkDYmfr
 sdxu5GjDp9hh7XzPXScKCoYBgsc/smxMpV6/3HnpG1+D7bP0jB/6hi76S/iXi7Z0W+qW
 sNUZZQlVy9nanzUigWjt5EZO52j3BUVZeW/89PUjuMNSjmL2bcyoh6n4SePGYj+p/n9x
 LUyQ==
X-Gm-Message-State: AOJu0Yz8qSX7ln0r9OMZ9WF7hAsD1Y37phiTAjfecLppJN0ns6UMemFz
 0E7JZXePw3bNBU2kMfcIbfs4g3yYYit4v00BBFNoIIkl7c52beYU02Zf0GvPnqzCKsyLXEqWyCw
 xGCZU
X-Gm-Gg: AZuq6aIpd+gk5GXQkjV3+4pYfXEf3iVtNEyf4zok1+CxW+wW4nJqmjH4+qKRAe0vgo1
 UhM+6szM8H5M2TXVqdwR7Xj8hmDxZb5d+5dqA6dROiM2i2orR2LeTWKMiH1Kf8OSQi2Jy3Sy8cz
 gZlDbYnhn3u3VcXNMq8grUPYtV2vZ/zcRdU+7EoqLPWEA953AJyOLyaKE3i2WYZlwm+NMczHXr6
 dUfcqt+9dUJ0/VhUCf64w92a/q4bRl5O71JaveQr3KXLXdnH6O+Fo1r9Sj9UgB4P7LkMmINySKx
 JgoglbdxwDwj/ssSBk/SWOUFybnBiSCGD19LboIq+zlGELrmK8PpDvGF06dK//D9ro+26+9FxJQ
 xpFzmZ4U8g9h4WdITL62ACXS6In869BcgWO3GAoIFLSzCpkcMOyyXuSnG7OgFvRiBKGXFCdBjKG
 t7CNi6kjkzjllhdZL14HxXlpbW7e6SrnJ8TBnwZE03KjwNvo1yqw==
X-Received: by 2002:a05:600c:350b:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-48069bfa50fmr80565075e9.6.1769626893317; 
 Wed, 28 Jan 2026 11:01:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm8673333f8f.3.2026.01.28.11.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:01:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/5] net/null: improvements and bug fixes
Date: Wed, 28 Jan 2026 11:00:08 -0800
Message-ID: <20260128190127.465743-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series makes several improvements to the null PMD driver and
adds comprehensive unit tests.

The series:
1) Cleans up the info_get callback by removing redundant argument
   checks and using proper constants (UINT32_MAX instead of cast).

2) Extends the packet burst generator to support larger packets
   by changing type from uint8_t to uint16_t, enabling better
   testing of drivers with various packet sizes.

3) Adds a comprehensive unit test for the null PMD covering RX/TX,
   statistics, custom packet sizes, copy mode, no-RX mode, link
   status, device info, RSS, RETA, and multi-threaded TX.

4) Adds validation that the mbuf pool passed to rx_queue_setup
   has sufficient data room for the configured packet size.
   This prevents generating invalid mbufs in copy mode.

5) Adds validation that the packet size devarg doesn't exceed
   UINT16_MAX, which is the maximum size for a single mbuf
   data segment.

Patches 4 and 5 are marked for stable backport as they fix
potential issues where invalid mbufs could be generated.

v8:
  - Rebased to latest main
  - Minor revision to avoid changes in later fixes

v7:
  - Added release notes to patch 1
  - Simplified test code by using single-line comments and struct
    initializers instead of explicit zeroing
  - Added two new bug fix patches (patches 4 and 5) that validate
    packet size against mbuf data room constraints

Stephen Hemminger (5):
  net/null: cleanup info response
  test: generate larger packet bursts
  test: add a test for null PMD
  net/null: add check for pool vs packet size
  net/null: check packet size argument

 app/test/meson.build                   |   1 +
 app/test/packet_burst_generator.c      |  34 +-
 app/test/packet_burst_generator.h      |   4 +-
 app/test/test_pmd_null.c               | 916 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  10 +
 drivers/net/null/rte_eth_null.c        |  21 +++---
 6 files changed, 959 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

Stephen Hemminger (5):
  net/null: cleanup info response
  test: generate larger packet bursts
  test: add a test for null PMD
  net/null: add check for pool vs packet size
  net/null: check packet size argument

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  34 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 936 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   |  20 +-
 5 files changed, 970 insertions(+), 25 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

