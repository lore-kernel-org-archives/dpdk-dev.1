Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F1D30CC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9610402DE;
	Tue, 13 Jan 2026 21:23:35 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 7DACE4028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:34 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so334051a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335814;
 x=1768940614; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHJGO+zv96s9OuCtG5s/YdJpYw7LqbSt0mSDvEwgp9w=;
 b=yFDtcXPcR08UB6bjPeSRV0SUPlN35hDWkyi/LFnI8u04PVjRmpkLiT0jbjvSHE3SpI
 x9MBLnLn0SRJ1uNuxDV+L14+tFi4v3v4ralREh18RpH+Flr8KXE+n0q40FBfo3X0VoHy
 ISQXJOestLTUBs4msRw3CRPo0Skgu4yYGSpJAUdtPE7MqkhiK12EFaYbFS2K95xRuvLd
 QfbsKpFvigHv6R5EHliy5afHnRHVb+vPhgHBimwCtCKo/JrWnnIdtZPXR8rjMq/m70IR
 x8rMcdEN+wvVJ5HhF5X0jLArdmYYo3VO3QPbjqKdr6rT8b9VX7nC2YOax6yxcT1Ve1Tc
 Jyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335814; x=1768940614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IHJGO+zv96s9OuCtG5s/YdJpYw7LqbSt0mSDvEwgp9w=;
 b=ZKaMNrLaKdIcpDJZMLtBAmys8+Zktmy7iwyjEdHh9fC8MnxshPns5ZLuzqhv0y9mZO
 7yemJwaOCQazftUpErB26n1PmdZvQsUjSVoIi2XX86cLZnmBFGDTKiO9Bozs900yo7g1
 zHJumZ+TmcXGfo2yhi2UA/hnle/saRcIYa7AL1GEYLnDQHEQVlE3Iw17Ki6V8svzNSN9
 Zu2nrqYYhfja7fgg0B7AKDS2Nsz3ACmQ9TDw5AU9UTzXZvTTU3w3sykZNKxyOWe1kHVW
 jJeQHo15qKxvnvbVptGhBi28joVVDYuOPpE000WMdhm5+B2QgWQL3bE8i6aT0+9mEaka
 udCQ==
X-Gm-Message-State: AOJu0Yw2bZyTPrQ1GZZ0gagCSflq6zChi9SEFJi4Uo0AN8ZslbL0cqjw
 jKRbPZG8SGpGDv5gnQOWot0WoFo/VFSU7OmexCO0TFvrpxyMlXeFterM0ciM2XM++vvcFsCZRO5
 WjUbT
X-Gm-Gg: AY/fxX6W3lBmWuIyl3FD+cXUtPONDxkTQJmtg+NDXIoMKW4aEhzxbMjwfGfkHQ5/qhS
 JtRiWIwhRyzwhugRJvlgnbthew6Ujvk1CkLLDJ++DzwewZuMd/u0pDs8HpyOHGy2QfyXEqJ4raw
 /N2pGznlOh24BynIxSYVE6pBaHh5pxaTEQIN8OdIhTBC2tUqpMq+0KPpTRpZ+7KmXPDJDrW+5CB
 36onIEqZrrbHxeNmI8p61lnmBqNDs/Gbwwvv4kmRrTrXHUztiIxK1CXKVWKROmqp+ggqUT/uh7A
 xPQOabpIienU6Q0MZDHPIszEUf6UW6DSzPUGsgFFWtJRXC9V341xWHQDNXJ2pyU+9XKuYOMzpR1
 SodMLHY5LIKCc02tPAc/7UnqQGpsAWa0QRR1asB0swexieQsUCqDe03mirfvAcuIuFGgZ5cggRL
 qHbvdDVvb/+GjN3kdhiLqM124OdgAyZi8N0/rS5eXHnGKQl2y42A==
X-Received: by 2002:a17:907:7244:b0:b72:d577:11cc with SMTP id
 a640c23a62f3a-b8761c4469fmr24508366b.12.1768335813929; 
 Tue, 13 Jan 2026 12:23:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 00/18] fix format overflow warnings in libraries
Date: Tue, 13 Jan 2026 12:21:39 -0800
Message-ID: <20260113202329.35190-1-stephen@networkplumber.org>
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

This series fixes format overflow warnings that occur when building
DPDK libraries with -Wformat-overflow enabled. The final patch in
the series removes the -Wno-format-truncation flag from lib/meson.build,
enabling these warnings by default.

The changes fall into several categories:

1. Add explicit name length validation to APIs that create named objects
   (lpm, hash, efd, tailq, cfgfile). These now return ENAMETOOLONG
   instead of silently truncating names.

2. Check snprintf() return values and log warnings when truncation
   occurs in non-fatal cases (thread names, xstat names, ring names).

3. Use asprintf() for dynamic allocation where fixed buffers are
   insufficient (graph pcap comments, hugepage paths, plugin paths).

4. Increase buffer sizes where the existing size was too small
   (telemetry address strings, cfgfile line buffer).

5. Replace PATH_MAX with UNIX_PATH_MAX for unix domain socket paths
   since the actual limit is 108 characters, not 4096.

6. Use standard C library functions where appropriate (getmntent_r
   for parsing /proc/mounts).

All API changes are documented in the release notes under a single
entry describing the new name length checks.

v10:
  - Fixed inconsistent comparison in eal thread name warning
    (now uses RTE_THREAD_NAME_SIZE on all platforms)
  - Fixed typo "peerr" -> "peer" in eal_common_proc.c

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
 lib/cfgfile/rte_cfgfile.c              | 43 ++++++++---
 lib/cfgfile/rte_cfgfile.h              |  6 +-
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  2 +-
 lib/eal/common/eal_common_options.c    | 17 +++--
 lib/eal/common/eal_common_proc.c       | 85 ++++++++++++++--------
 lib/eal/common/eal_common_tailqs.c     | 13 +++-
 lib/eal/common/eal_filesystem.h        | 27 +++++--
 lib/eal/freebsd/eal.c                  |  6 +-
 lib/eal/linux/eal.c                    |  6 +-
 lib/eal/linux/eal_hugepage_info.c      | 98 ++++++++++++--------------
 lib/eal/linux/eal_memalloc.c           | 11 ++-
 lib/eal/linux/eal_memory.c             |  9 ++-
 lib/eal/windows/eal.c                  |  6 +-
 lib/efd/rte_efd.c                      | 18 +++--
 lib/ethdev/rte_ethdev.c                | 35 ++++++---
 lib/graph/graph_pcap.c                 |  9 ++-
 lib/hash/rte_cuckoo_hash.c             | 41 +++++++----
 lib/hash/rte_fbk_hash.c                | 12 +++-
 lib/hash/rte_fbk_hash.h                |  1 +
 lib/latencystats/rte_latencystats.c    |  9 ++-
 lib/lpm/rte_lpm.c                      | 16 +++--
 lib/lpm/rte_lpm.h                      |  1 +
 lib/meson.build                        |  4 --
 lib/telemetry/telemetry_legacy.c       |  7 +-
 lib/vhost/vhost.c                      | 14 ++--
 28 files changed, 368 insertions(+), 168 deletions(-)

-- 
2.51.0

