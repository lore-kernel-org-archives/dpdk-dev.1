Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7813D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E621F40262;
	Fri, 23 Jan 2026 05:29:52 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id E66E8400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:29:50 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so1508197f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142590;
 x=1769747390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adUn7yv5rvnY5Rd6Y2vFoOo8HW70UenxmZvq4FtLCjU=;
 b=jZLFTkmgDi6y1OXqdWQd5QO1jkTAyO0QLIu0qzDRbGI1oSaob/arp/CoiBBGZointd
 ELR8mi1xKJJ0IIic6zO5FIlsU+O+JEgWthy7jYpxs8+m4uYlx/9UBMpaurCISpW4bFfq
 6Ment7IvD6Mr0fIDP6u/1S9QKuhMCE/wnEPGQ1pa6kc5gjod1ri3TmHBsO79han5XNja
 qMxUhZp3AQJfSVZBYTzGoy45XajGblZ/fQMEER6BK0FqH7L9Kdc23lG9nJSmx3nGIIyB
 iAcv+bsRqn7ZOFU6zULGZpxlUsgOqBTyPuDMZfDtqTC6L8BxNUOQKo+nZ870LplOgAY6
 rFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142590; x=1769747390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=adUn7yv5rvnY5Rd6Y2vFoOo8HW70UenxmZvq4FtLCjU=;
 b=MQT9GHPALwnhJrFmH51HDGPXnbRzDPVPepemOJIFuwB+gjfar1F1/BmqFa1A3vWkB7
 MdOFr8r5eSyPzEx1/+N4Gy5C37X0JCI5WPboiXEPJMWHtIk7Fdy0T5eqerkBOjgcLpWq
 V0tpByQc5p0oTxPZ/Z3Orj4OK1FmC+FJisBmCQjGkfFXeg7VlBhYOa/0M7H/sA0gQnzm
 6nQbfAW0TUUSPy4zTN4PCo8n3i9eYg8N0NmVLPhFTQKs4bTDKrXGla9rlF8ApqMl/nUr
 19BeityRcZhozCX7WYe09IztJG+5lNxKrrkW4c14VcR65u3GyF3DDP7ZuhPrbzgu4CA1
 KqJg==
X-Gm-Message-State: AOJu0YyltR6kFZjXgwFGZb9dbchLbspns7lmKRk07YS0NUDMDo3FJUly
 ybVrggB92W+TnCr1AIKDmfuaJBBvT/yOnfBkNP5YEUtpOLCxu/ZbLELJPbSWn2qOhclzF9WtLhI
 +z4rt
X-Gm-Gg: AZuq6aKSeNAEgAK5EAnPLeVKxf3GTp+ZPnfD01zBeczcQoky3t56tMZe9UYV3vayb6n
 YBnPWt+Ot7Z30bhP5pUlvg/TyLsPBtzqzcpDWZF7gz6RYj9eGeNYxGMBGfNXe3B2jts17jZzOJi
 l33RAZmEInrS4R3t1s7ltuTKBircXIiiIWpdDADafDC5BBCUxWeTvJKrRkFvsz3+mjmtlvetHDq
 AXDEtEn5aKQNh70EA4olmLGHuofJQjoOKqQtZYaFfKKC47dDSRkJtgDdJgjjKSlrWZGr6CSsXZU
 Gu98/JO59AbkJm0+eFjfsUUwr3xZ/OZgLOfavmKaHrywMPSZsQR5gD/TilRIEKYPEIETrZEjR3y
 Fp4i3sGk55GBbLypnTkNhh3KXP/mS8hKDPd9i95G8jgzs+FSWhUfFuKPUhQOoCq3HLIGwN88+eE
 xBuPDWoYQRamoF5Zcj89o3ulJurefbzb4dfV2+pOZjjYiDFuJUdg==
X-Received: by 2002:a05:6000:2211:b0:435:8f88:7236 with SMTP id
 ffacd0b85a97d-435b15fa222mr2686125f8f.36.1769142590185; 
 Thu, 22 Jan 2026 20:29:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:29:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 00/18] lib: improve string overflow safety
Date: Thu, 22 Jan 2026 20:27:58 -0800
Message-ID: <20260123042945.159075-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

This series improves defensive programming by adding proper string length
validation and overflow checking throughout DPDK libraries. The goal is
to eliminate silent truncation of names and paths, provide meaningful
error feedback, and enable compiler format overflow warnings.

Motivation
----------
Many DPDK APIs accept name parameters with defined maximum lengths
(e.g., RTE_LPM_NAMESIZE, RTE_HASH_NAMESIZE). Previously, names exceeding
these limits were silently truncated via snprintf/strlcpy, potentially
causing subtle bugs like duplicate names or unexpected behavior. This
series addresses these issues systematically.

Changes Overview
----------------
The patches fall into several categories:

1. API input validation (patches 1-2, 6, 13, 17):
   - Add explicit length checks for name parameters in lpm, hash, efd,
     tailq, and cfgfile APIs
   - Return ENAMETOOLONG when names exceed limits
   - Document new error conditions in API headers
   - Add corresponding unit tests

2. Internal buffer overflow detection (patches 3-5, 8-10, 12, 15-16):
   - Check snprintf/strlcpy return values for truncation
   - Log warnings when internal string operations truncate
   - Increase buffer sizes where they were too small
   - Use dynamic allocation (asprintf) where appropriate

3. Path handling improvements (patches 7, 11, 14):
   - Use standard C library routines (getmntent) for parsing /proc/mounts
   - Enforce UNIX_PATH_MAX for socket paths to fail early
   - Handle arbitrarily long shared library paths

4. Error message improvements (patches 1-2, 6):
   - Include rte_strerror() in failure messages
   - Provide more context when operations fail

5. Enable compiler warnings (patch 18):
   - Remove -Wno-format-truncation flag
   - All preceding patches fix the warnings this would trigger

API Changes
-----------
The following APIs now return ENAMETOOLONG for oversized names:
  - rte_lpm_create()
  - rte_hash_create()
  - rte_fbk_hash_create()
  - rte_efd_create()
  - rte_eal_tailq_create()
  - rte_cfgfile_add_section()
  - rte_cfgfile_add_entry()

These are documented in the release notes and header files.

Testing
-------
- Existing unit tests pass
- New test cases added for hash name length validation
- Build tested with format overflow warnings enabled

Stephen Hemminger (18):
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  telemetry: check for path overflow
  efd: handle possible name truncation
  eal: use C library to parse filesystem table
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  eal: add check for sysfs path overflow
  eal: limit maximum runtime directory and socket paths
  eal: check for hugefile path overflow
  eal: check tailq length
  eal: handle long shared library path
  ethdev: avoid possible overflow in xstat names
  vhost: check for overflow in xstat name
  cfgfile: add length checks and increase line buffer
  lib: enable format overflow warnings

 app/test/test_hash.c                   | 21 ++++++
 doc/guides/rel_notes/release_26_03.rst | 13 ++++
 lib/cfgfile/rte_cfgfile.c              | 43 +++++++++---
 lib/cfgfile/rte_cfgfile.h              |  6 +-
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  3 +-
 lib/eal/common/eal_common_options.c    | 17 +++--
 lib/eal/common/eal_common_proc.c       | 85 +++++++++++++++---------
 lib/eal/common/eal_common_tailqs.c     | 13 +++-
 lib/eal/common/eal_filesystem.h        | 27 ++++++--
 lib/eal/freebsd/eal.c                  |  6 +-
 lib/eal/linux/eal.c                    |  6 +-
 lib/eal/linux/eal_hugepage_info.c      | 92 ++++++++++++--------------
 lib/eal/linux/eal_memalloc.c           | 11 ++-
 lib/eal/linux/eal_memory.c             |  9 ++-
 lib/eal/windows/eal.c                  |  6 +-
 lib/efd/rte_efd.c                      | 18 +++--
 lib/ethdev/rte_ethdev.c                | 35 +++++++---
 lib/graph/graph_pcap.c                 |  9 ++-
 lib/hash/rte_cuckoo_hash.c             | 41 ++++++++----
 lib/hash/rte_fbk_hash.c                | 12 +++-
 lib/hash/rte_fbk_hash.h                |  1 +
 lib/latencystats/rte_latencystats.c    |  9 ++-
 lib/lpm/rte_lpm.c                      | 16 +++--
 lib/lpm/rte_lpm.h                      |  1 +
 lib/meson.build                        |  4 --
 lib/telemetry/telemetry_legacy.c       |  7 +-
 lib/vhost/vhost.c                      | 14 ++--
 28 files changed, 366 insertions(+), 165 deletions(-)

-- 
2.51.0

