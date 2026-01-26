Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFDD1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D996402DE;
	Tue, 27 Jan 2026 00:24:36 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 2DBE2402A9
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:35 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359019da8cso4337570f8f.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469874;
 x=1770074674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeOm0Uzn5kOZDLZRoPQcXpE2fbEKconhnaz84w6aCDI=;
 b=Ub2I5a8MMKCRsb2EoNvDeye6hKcv5j8ymu4S521rvlgWAsTu7hJxlP2mgmDT48pPdT
 dwcMJiqOVsycxVcV6yM+0Tk/IP3aZNggeUHWfe1ufUSE8mYh0yx78LcLrG3LCTT1HJY6
 yZeXh2AV0LhxjSKYYrLd1/SB4eTgFsRMt9PPs+Rc2SmVCubMH1xkWDZsN/lkv/iutkMm
 TH4axUZAP0DXCYt18UbpTPq2YmhFw9lGrUbQ9RRJXenXcagOBNsq6abtZpOZMeiUXQWc
 DEo+bK3QKstGuNWkoB6qaeIeHK1llOrZ+/Uf86Gb90bUZ35MZmneu9ViBalgbSEHGI2a
 WtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469874; x=1770074674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WeOm0Uzn5kOZDLZRoPQcXpE2fbEKconhnaz84w6aCDI=;
 b=DegeYP3IRwRrVQJftfbOjpgLkExbu8I+h0CwhD5gGGN3KV7StQnE2+nXPUkS1WU1/D
 1/x6DRpI6czQzqQI3z+Gqy/CWpokKjlwo/6ayHD2MIroqmXHWp56HYUhMr+xm0ncHgxs
 sNzMS0xJtRhD0z5R8qnK4GRKjeH3M9ScN8U1kkzu/NiapMvy++hhNtK24K9jJ28QDYAF
 XbqDsiVolntyznQJkjO6ZyweNiYq4Tj0WITSe2SBKFHk24ETlw4asehmxKAl76aVvu0X
 k74NSnWZDiSTsEHlF1UUZCcWqBfMGTxXNaz9hTp+WGk9qSu7BF4fxpEMr/iKL+alYhsS
 uBTw==
X-Gm-Message-State: AOJu0YzK45AIo+DUli16T7eCr34bg27K+xAfbRVqnLdnqi2+QarEPrW1
 ghWjyGz+sUX4D8+uMKi1lY9Q9BIISF5UUzNq9Owl+5k7+wah0jCXvVbu0Y0v8OaHAs8dfXvfJy+
 mdZJv
X-Gm-Gg: AZuq6aKcjtOzPAGpDgbCJMmzYazJ6QlPI0dGylOYu/JM6Aaw29eBssUEWvfkTQUPPxN
 ymwzpegEi8wVK++FzpWfXSmZFx3NmTj6gBw/DE+nP+uAtp9lYUZxDloHThVG+7iMyuI2+L04ZAP
 CXecBdKsu7SmDlpONwqiH6x4dF/23fA5u1k8mTNVyQSJS8zvF7bKaWA3H4vcopIUquwmpR02q2I
 MvFERUJmxuTJqC6+9m37g72EUNLxDqgWPZoWpHwW+s2aTi/3n4lS87LNw/IjzSVHET+BHwQQn29
 ORyYnmmF2eTH6Z6mbne/dOyj1TgAX2lGjWmIdugyU/7bwbSQjk5EC7ZBEsAPipy+iTqyEf9GnFQ
 O4I/rpxudsBmd/B0RO39eAosjlbMmNT5nw38gYRlPKZZbTw3RxzLutKrLv2UI0wrNojosKgKrUT
 xx8CX8zn+Xv8AYS5vFS2gH+nz8FER4PoEK049Irg/J3SsMQxTV1J6L0vEkiCd5
X-Received: by 2002:a5d:5d0a:0:b0:435:90a7:8db with SMTP id
 ffacd0b85a97d-435ca1475a7mr10683153f8f.15.1769469873999; 
 Mon, 26 Jan 2026 15:24:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 00/17] lib: improve string overflow safety
Date: Mon, 26 Jan 2026 15:22:08 -0800
Message-ID: <20260126232428.276534-1-stephen@networkplumber.org>
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

1. API input validation (patches 1-2, 6, 12, 16):
   - Add explicit length checks for name parameters in lpm, hash, efd,
     tailq, and cfgfile APIs
   - Return ENAMETOOLONG when names exceed limits
   - Document new error conditions in API headers
   - Add corresponding unit tests

2. Internal buffer overflow detection (patches 3-5, 8-9, 14-15):
   - Check snprintf/strlcpy return values for truncation
   - Log warnings when internal string operations truncate
   - Increase buffer sizes where they were too small
   - Use dynamic allocation (asprintf) where appropriate

3. Path handling improvements (patches 7, 10-11, 13):
   - Use standard C library routines (getmntent) for parsing /proc/mounts
   - Enforce UNIX_PATH_MAX for socket paths to fail early
   - Handle arbitrarily long shared library paths

4. Error message improvements (patches 1-2, 6):
   - Include rte_strerror() in failure messages
   - Provide more context when operations fail

5. Enable compiler warnings (patch 17):
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

v12:
  - Fix build if strlcpy is mapped to snprintf (no libbsd)
  - Drop redundant "eal: add check for sysfs path overflow" patch;
    the sysfs path handling is now consolidated in the hugefile
    path overflow patch using asprintf
  - Fix hash unit test to use SOCKET_ID_ANY instead of invalid
    socket ID when testing name length validation
  - Remove extraneous blank line in cfgfile patch

v11:
  - Rebase and address review feedback

Stephen Hemminger (17):
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  telemetry: check for path overflow
  efd: handle possible name truncation
  eal: use C library to parse filesystem table
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
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
 lib/cfgfile/rte_cfgfile.c              | 42 +++++++++---
 lib/cfgfile/rte_cfgfile.h              |  6 +-
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  3 +-
 lib/eal/common/eal_common_options.c    | 17 +++--
 lib/eal/common/eal_common_proc.c       | 85 +++++++++++++++---------
 lib/eal/common/eal_common_tailqs.c     | 13 +++-
 lib/eal/common/eal_filesystem.h        | 27 ++++++--
 lib/eal/freebsd/eal.c                  |  6 +-
 lib/eal/linux/eal.c                    |  6 +-
 lib/eal/linux/eal_hugepage_info.c      | 90 ++++++++++++--------------
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
 28 files changed, 352 insertions(+), 166 deletions(-)

-- 
2.51.0



Stephen Hemminger (17):
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  telemetry: check for path overflow
  efd: handle possible name truncation
  eal: use C library to parse filesystem table
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  eal: limit maximum runtime directory and socket paths
  eal: check for hugefile path overflow
  eal: check tailq length
  eal: handle long shared library path
  ethdev: avoid possible overflow in xstat names
  vhost: check for overflow in xstat name
  cfgfile: add length checks and increase line buffer
  lib: enable format overflow warnings

 app/test/test_hash.c                   |  21 +++++
 doc/guides/rel_notes/release_26_03.rst |  13 +++
 lib/cfgfile/rte_cfgfile.c              |  42 ++++++++--
 lib/cfgfile/rte_cfgfile.h              |   6 +-
 lib/eal/common/eal_common_config.c     |   6 +-
 lib/eal/common/eal_common_memory.c     |   3 +-
 lib/eal/common/eal_common_options.c    |  17 +++-
 lib/eal/common/eal_common_proc.c       |  85 ++++++++++++-------
 lib/eal/common/eal_common_tailqs.c     |  13 ++-
 lib/eal/common/eal_filesystem.h        |  27 ++++--
 lib/eal/freebsd/eal.c                  |   6 +-
 lib/eal/linux/eal.c                    |   6 +-
 lib/eal/linux/eal_hugepage_info.c      | 112 ++++++++++++-------------
 lib/eal/linux/eal_memalloc.c           |  11 ++-
 lib/eal/linux/eal_memory.c             |   9 +-
 lib/eal/windows/eal.c                  |   6 +-
 lib/efd/rte_efd.c                      |  18 +++-
 lib/ethdev/rte_ethdev.c                |  35 +++++---
 lib/graph/graph_pcap.c                 |   9 +-
 lib/hash/rte_cuckoo_hash.c             |  41 ++++++---
 lib/hash/rte_fbk_hash.c                |  12 ++-
 lib/hash/rte_fbk_hash.h                |   1 +
 lib/latencystats/rte_latencystats.c    |   9 +-
 lib/lpm/rte_lpm.c                      |  16 +++-
 lib/lpm/rte_lpm.h                      |   1 +
 lib/meson.build                        |   4 -
 lib/telemetry/telemetry_legacy.c       |   7 +-
 lib/vhost/vhost.c                      |  14 +++-
 28 files changed, 380 insertions(+), 170 deletions(-)

-- 
2.51.0

