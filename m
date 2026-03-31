Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1032E10F9303
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB2FA40697;
	Tue, 31 Mar 2026 23:41:34 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 73CC140613
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:41:33 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so2364225e9.0
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774993293; x=1775598093; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=cYFpWxNG2K88zHGPVDgMI2nDzBT4pagidE+NmbRjvCQ=;
 b=E3PwXg+idJuDf+aLNlNui5WJMFYdUb+iDu95PgtQPWU4P+HbMYb2C6+RLPcfPuRQVI
 6NgJEMJwhRQ125F8h5d740qGgYw50iZ1M7+ocrGSGXHGS8glKuTCtAdyvRF2lR5WCM7o
 j+gqDLomz2/H5xNbS+sPLA7GnTeJJeVac8228XjOAQNjfk/sT1NNmD26H2HM6gyPnj9O
 G2dqSXq+7ZqhQ2jNR/gLktRs10f9YmvPGatowrQ06fHMmQQ9/TBqfQivT5nLwNdwmV/j
 jBKRfWDZ81XwtO26aSeidArsvWmIThSOmKMWPKrT4wRbKqcl6tetu1yUP3B1y82ya3ov
 1k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774993293; x=1775598093;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYFpWxNG2K88zHGPVDgMI2nDzBT4pagidE+NmbRjvCQ=;
 b=quuNOyUZdR1d0NLqDk6hfccMLUwMcoCn39epnaU7cOPYl6i17FwU/qpbZF+WUyboAr
 jlBLt0ivNHVG/Sw6VFfv4/B+FrmCgHZ56QKbBE2RGzhWdTVBa5lRXJb3dveoPMD6TwrO
 w3gaOhfvSQIwx4LBeFS4cxW3tzQl1T/LafG71FR/O43fIkt4MT8L1pgzESoWpHTgojLk
 SHgQXaxe1f+2k+RyV4M4HHWOvRiLq1QuDlbp5Zx28qkkIMEwItsniV2IVZ22YIOcPi6r
 YHH2cI7H9utk6mWlitXFCAQh0f4hwfzzEt/e6nh+scYs19LdSz5E8jiDDlcR+7mzpOXC
 W9+g==
X-Gm-Message-State: AOJu0Yy6800syopuBiTJyJBiTmK+BsGbMMKNr8wNom6s2qsc9+eEoiMr
 tR2+c8kJrujtoQwjh/aZ6EmTZn9oKgyDeeg+CyqKoPZN3Xbv5ddwC6mL0reS2g==
X-Gm-Gg: ATEYQzy3T+ikpMnUOSXxms5GrCrK7gNoIGHa1h6TshsoomZc0TWjykGutbdvDNDxYy9
 5zu6zBKBfoB+hwvpS292QRwEQ1Dv5ge1fufvW/E8G7YS09eBOsPSnvBBa3uxXfowwjXCpUKTC6c
 fJYu6ETpNVQCaPeGfjxXGiU9JH5OH0H2oSWYAHf+MVfftlf8jEsyhWEQyx3wbR5+EPis8slNDMG
 lPwoyC/j9puyGZoLt/2Yaqjocfze/SO0alXjx+YZp5rkOdJv3oN/zIF5MK9VgJ/WwqF5TgkHCL6
 rQj4uHSReA2pCvp1pGGJQMDJeU+akDpyX9SF/D23gO2hPwJWUvL62CtM3y0ekYksYZGOr8Nsa1A
 WOoxZJn8GPVjzNshRINigxprMZ++386xijBySFsEWQsTBya29zFe6Ncd6EuSLo4S/8U5pQbJ5Ol
 09Io5G3Glk9PgQD5Oa
X-Received: by 2002:a05:600c:450e:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488835d17edmr15474505e9.14.1774993292869; 
 Tue, 31 Mar 2026 14:41:32 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:5eee:7f89:5053:515f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e81a2cesm67187285e9.8.2026.03.31.14.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:41:32 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, rjarry@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 0/5] fib: shared and resizable tbl8 pool
Date: Tue, 31 Mar 2026 23:41:12 +0200
Message-ID: <20260331214117.142495-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

This RFC proposes an optional shared tbl8 pool for FIB/FIB6,
to address the difficulty of sizing num_tbl8 upfront.

In practice, tbl8 usage depends on prefix distribution and
evolves over time. In multi-VRF environments, some VRFs are
elephants (full table, thousands of tbl8 groups) while others
consume very little (mostly /24 or shorter). Per-FIB sizing
forces each instance to provision for its worst case, leading
to significant memory waste.

A shared pool solves this: all FIBs draw from the same tbl8
memory, so elephant VRFs use what they need while light VRFs
cost almost nothing. The sharing granularity is flexible: one pool per
VRF, per address family, a global pool, or no sharing at all.

This series adds:

  - A shared tbl8 pool, replacing per-backend allocation
    (bitmap in dir24_8, stack in trie) with a common
    refcounted O(1) stack allocator.
  - An optional resizable mode (grow via alloc + copy + QSBR
    synchronize), removing the need to guess peak usage at
    creation time.
  - A stats API (rte_fib_tbl8_pool_get_stats()) exposing
    used/total/max counters.

All features are opt-in:

  - Existing per-FIB allocation remains the default.
  - Shared pool is enabled via the tbl8_pool config field.
  - Resize is enabled by setting max_tbl8 > 0 with QSBR.

Shrinking (reducing pool capacity after usage drops) is not
part of this series. It would always be best-effort since
there is no compaction: if any tbl8 group near the end of the
pool is still in use, the pool cannot shrink. The current LIFO
free-list makes this less likely by immediately reusing freed
high indices, which prevents a contiguous free tail from
forming. A different allocation strategy (e.g. a min-heap
favoring low indices) could improve shrink opportunities, but
is better addressed separately.

A working integration in Grout is available:
https://github.com/DPDK/grout/pull/581 (still a draft)

Maxime Leroy (5):
  test/fib6: zero-initialize config struct
  fib: share tbl8 definitions between fib and fib6
  fib: add shared tbl8 pool
  fib: add resizable tbl8 pool
  fib: add tbl8 pool stats API

 app/test/test_fib6.c        |  10 +-
 lib/fib/dir24_8.c           | 234 ++++++++++---------------
 lib/fib/dir24_8.h           |  17 +-
 lib/fib/fib_tbl8.h          |  50 ++++++
 lib/fib/fib_tbl8_pool.c     | 337 ++++++++++++++++++++++++++++++++++++
 lib/fib/fib_tbl8_pool.h     | 113 ++++++++++++
 lib/fib/meson.build         |   5 +-
 lib/fib/rte_fib.h           |   3 +
 lib/fib/rte_fib6.h          |   3 +
 lib/fib/rte_fib_tbl8_pool.h | 149 ++++++++++++++++
 lib/fib/trie.c              | 230 +++++++++---------------
 lib/fib/trie.h              |  15 +-
 12 files changed, 844 insertions(+), 322 deletions(-)
 create mode 100644 lib/fib/fib_tbl8.h
 create mode 100644 lib/fib/fib_tbl8_pool.c
 create mode 100644 lib/fib/fib_tbl8_pool.h
 create mode 100644 lib/fib/rte_fib_tbl8_pool.h

-- 
2.43.0

