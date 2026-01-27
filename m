Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921AD340A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E0F140E0C;
	Tue, 27 Jan 2026 17:33:05 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 624B340297
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:04 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3841629f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531584;
 x=1770136384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtLku+I4vJN78GzmUN2LOoRP4MgtH4lEo3n3wJIq9l4=;
 b=F+iSRP7YlB6lxjehwuVDmZOwotveWXTVbRiOrSZhPq4oBtVWN6glgNEsQyuIk1ycyZ
 jPS8PyPYD+MixLJCET2looVJTlSlYjum8unqNrCDvKDhITMSndmfjLAJALSL13ZstePP
 boJCPYtAICEKDM/hLf3aX7n+9KrSAey2Dt3LQMZmdf2NODM4hXVLQIcm8A95zwb6W54b
 zmv5mQnB6jP26RvzndbgS/hV+InYy6LzfWYT4TgcFMajF8YHjKGe163I50wb4cwADEai
 oyELpoq9xE9P6RRArR2nosQWtSIqhfyuJXSB0dlHhkJgTh8RX3orlK20p0UkWILjYJi9
 VoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531584; x=1770136384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CtLku+I4vJN78GzmUN2LOoRP4MgtH4lEo3n3wJIq9l4=;
 b=e+KiDBMtLP+7U+xsujrpu/YkpmJYJMqoT8vKRscppd3O7JIX3RYkois6Ok91rSB/V9
 Y1/a97krbuNCXHS4dqYvzj3aoiPoITvmNGXmn1Q02UoZDVDZqt3f2bkmnEJnbKt2o+7o
 3qGHib20VwWGe3rN85yeyEdKELkR6EyNIANvy9/zx08p2l7SngCtHJtjqbMpbNIGROgw
 X4ZGfezsZBUCgeEsn5oZpCpBt8Vcwa3IlE0j1nFlInkNjNyhI0Y6U+UsnGzIbEaFLd/t
 ExgPvcj7MIYN8Cym5NxmA8qDhkkwv4VFtIuDN80sf25lqNlBocE0NupgfTFwr3YAk/IY
 efSw==
X-Gm-Message-State: AOJu0YzzJWAN0IFMbYhdBZvSfrc0YtIqgeYDUqesX48oFpDGtWMnhxqi
 sOqwZhhuFKNn1069b8s7MNLQBeqnPD1nguOTKa070dHEmqzT+vbYB0dL84Ef5Icx72dJNlFOdKw
 DaTfq
X-Gm-Gg: AZuq6aJLStZGNup15qnRBLdNlFN6DvfviDYAYJC497S0jDyEeFrpgthanEZkSro6FhG
 UBaJT3lp/FWhsxgMChE10PPShHOeQ7JVl1+YYbfWbqUfL5DjTyG/JNN4NpMAL7D25hVWCsXAxMi
 NikER4kxAaVeXtjA4x02I2rGe6Nee/wCd1zKsgs6WED52S/ZsntOpvYzAGELhD8S90r26ciuY8w
 narz03GamONgIoxr47KJXaeR1521qs+Y50cs7Ajz8mFXQq0s7EpHI8u++0xvTqPk06cWt7aZYQq
 lCGYH8oE/Pkt3Q4oPI+FMcb13qQ/yWlKePP1ZluBuvY7utyhE4oDndZzVaGSWkFTURytOwr4nH+
 /ypZtVkJbs4U0N22NHm686HyEqf9Qjp4pgC+tje5jAPq/egw6FHu2HIOVoPB4HFRZJjY2dDNR84
 qlVw0KCxx39FuvgsyQNrVfgKhs/vi5MGmcu9FVfeWMrhbkpqbvaQ==
X-Received: by 2002:a05:6000:430d:b0:435:8f1b:bb32 with SMTP id
 ffacd0b85a97d-435dd1c0c5fmr3376359f8f.32.1769531583457; 
 Tue, 27 Jan 2026 08:33:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 00/17] lib: improve string overflow safety
Date: Tue, 27 Jan 2026 08:30:14 -0800
Message-ID: <20260127163258.75566-1-stephen@networkplumber.org>
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

