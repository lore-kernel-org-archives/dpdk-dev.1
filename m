Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82177D46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05AB4402BA;
	Thu, 29 Jan 2026 02:43:21 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 2498340297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:18 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so9648885e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769650998;
 x=1770255798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMYgZkuNIQOmuTvVHj9PbnGQjBQv9jvoV/96DgiwaXw=;
 b=dmgqmPfsmIFpCL/fbo8YAqzrPbSVgYMAmRiVPmoqz6EliS6gUqKycTZI+I8x+J8NCw
 cKaa/FJ93nxW3m7bly8VmkkfVuQvPUfenmRqRvpqQVSyh0nyEF3hhq2l23OPQEzKCxuS
 7ipWolQhw0Yg7KvkaRx8HN2CjiArUw46UvWEDaJH3uN4lk0JOJ78RQ6VESg0w49D2Xct
 o0ab+crRVA2/ttcITfSh4J+rRlRyB/5y2+6zx+9yKEnGImZmvIalmz3VPC5S1LXnplTx
 jWkH8HwiEbUMwwZr14q7fIoVwhcGFtJRbEP7Li0w1GWBmLBzRkHE2Jfj9PuJ+qGfyZWA
 CBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650998; x=1770255798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DMYgZkuNIQOmuTvVHj9PbnGQjBQv9jvoV/96DgiwaXw=;
 b=wBlGURBJzx5XgZyomoHBT881a4UDKQUpyo3+RTIA7QJN6KD2Pq4CxImNZJqpm0SwTh
 uF2yoWxCiGOSJDubDP4TB/+xCNDQJTUtFJPGd2uDFHrFPyzOGQ7Iw8+cr1TxxY9tJ8+r
 nCtQvbWgxCSsOkK1AGVafUdKHcnGa5Tctjp0zA2B7dUst39hj0dpnI8YqC6wqvyliohU
 shxifiC3LaG/RTjgf1wkhQsPWXwM732P/OkY+6hmbhKHiL+5rLnfTUY3jFbLv5Zpdag5
 65jxEGJPxVwtX0P1GEdTfiKzUGBT6XChkmf+HhXSmyztGuPHgEW6EHPMCD/J428QBw7a
 5rEg==
X-Gm-Message-State: AOJu0Yxl76H9BuO3Jt/cuZ8sskDvPxAlDfABxlQmKi4EY5XvxJzyLh6m
 t2as7J9vMvusjTchu8ssj3X9BZX9Y4Gu14n1676Fgwz3pnHhVyGeudtl8eh79FSvdE3HnAcKNke
 IGC3L
X-Gm-Gg: AZuq6aJmFqLX9gxRd2sPvQMh4ZZ8h8ggAeOhHRoPha1/wgykY5c6m3DeaHrD/wl5Gk1
 wfV8lGL7lY10TjS5aK0YKHtCxE9e3yFejASPy0OK4Yx2zfbbveUFnHonQxRLRXJXbgy3pi7kScQ
 MVFQppbKtAx+4ydAtBOxuPCtIymhnXnZ47aZFbDHCGbMLEJvH7sg6lBPqF8wADN8c7eY7mksqnR
 j5p3NhEpmBk8JyAulsDD1RZcLI2ckOWNubv1LPkDv7TjHGO/Dw5p9r8DEy7VVp2XWFyfTuLLnWG
 2Cu1sjFWnB3zihxsgzIrVIIUuyLNC7jVIGG68ssAicS3gGMFvIBJ16WM/dJw7AoZTgglCmNOmCR
 TN80rV9LsOyS2vawoRJ+nQOGBqWZCHiBGrQMP7pf7/rdDRCwffC6hwkKmfnUD3VqEaR/YKGuvxQ
 JtYx2OLJTtH4ZBeqfZQCc8OuI8BbFntSMf5LpSmjod4oT+h4LppzzF53jXnrDV
X-Received: by 2002:a05:600c:4e15:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-480828b5ccemr17332825e9.12.1769650998479; 
 Wed, 28 Jan 2026 17:43:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 00/17] lib: improve string overflow safety
Date: Wed, 28 Jan 2026 17:41:03 -0800
Message-ID: <20260129014313.939831-1-stephen@networkplumber.org>
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


v14 - fix build on 32 bit Ubuntu
    - reword commit messages for clarity

v13 - fix and cleanup get_hugefile code
      optimize using statfs() and no string handling needed.
      reword commit messages


Stephen Hemminger (17):
  lpm: reject names that exceed maximum length
  hash: reject names that exceed maximum length
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

 app/test/test_hash.c                   |  21 ++++
 doc/guides/rel_notes/release_26_03.rst |  13 +++
 lib/cfgfile/rte_cfgfile.c              |  42 ++++++--
 lib/cfgfile/rte_cfgfile.h              |   6 +-
 lib/eal/common/eal_common_config.c     |   6 +-
 lib/eal/common/eal_common_memory.c     |   3 +-
 lib/eal/common/eal_common_options.c    |  17 ++-
 lib/eal/common/eal_common_proc.c       |  85 +++++++++------
 lib/eal/common/eal_common_tailqs.c     |  13 ++-
 lib/eal/common/eal_filesystem.h        |  27 ++++-
 lib/eal/freebsd/eal.c                  |   6 +-
 lib/eal/linux/eal.c                    |   6 +-
 lib/eal/linux/eal_hugepage_info.c      | 138 ++++++++++---------------
 lib/eal/linux/eal_memalloc.c           |  11 +-
 lib/eal/linux/eal_memory.c             |   9 +-
 lib/eal/windows/eal.c                  |   6 +-
 lib/efd/rte_efd.c                      |  18 +++-
 lib/ethdev/rte_ethdev.c                |  35 +++++--
 lib/graph/graph_pcap.c                 |   9 +-
 lib/hash/rte_cuckoo_hash.c             |  41 +++++---
 lib/hash/rte_fbk_hash.c                |  12 ++-
 lib/hash/rte_fbk_hash.h                |   1 +
 lib/latencystats/rte_latencystats.c    |   9 +-
 lib/lpm/rte_lpm.c                      |  17 ++-
 lib/lpm/rte_lpm.h                      |   1 +
 lib/meson.build                        |   4 -
 lib/telemetry/telemetry_legacy.c       |   7 +-
 lib/vhost/vhost.c                      |  14 ++-
 28 files changed, 377 insertions(+), 200 deletions(-)

-- 
2.51.0

