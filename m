Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F13D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0E24025F;
	Sun,  7 Dec 2025 20:12:50 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 701E340156
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:12:49 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so32740775e9.0
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134769;
 x=1765739569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnpbxXjmUgS12d48P4tkpq/0l7+4e9IA6QyWPe237RE=;
 b=ZRl1DheyNHco2wpBpEXtBYfPCwhjdgWXwnGv2d4g3LKoNG2LUeXAQy0ou/A9Aaxyen
 bVh30MCNt0wfa3oT/K58GBdf3S4iinekfoBz9TMxQfPhaF322sTfSTXvOOqzRP6Kq0j2
 6WqDFvVERR4o4MD9bvTUbR4DqAbqZzswjbJoAYgn/tq/QaGYoIPB0E5ETVr92UJfj9gt
 gOtcPRkw0KEAskbwhwxEMp9aLNtWg+YfTbKoiBZZstEyXq2qciE7161cofiVTLpDRVI4
 O3dHaLZmOHdiBXVih9HzTo8zv1ox18ZNGV+W6wSGa55Q8/2HSwuL7qB0KbfOGXopHU82
 IUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134769; x=1765739569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnpbxXjmUgS12d48P4tkpq/0l7+4e9IA6QyWPe237RE=;
 b=aEiLEZ3IYtBOlz65Y50NwANe1igBI9oNxBMOH+6K18nqrIEmI/jroi/oGRtpZ/4mcM
 IBm6JbdETVQRTcH3gAYMfT/GSG7AclyraZAD2w9IyCc9aoh0+TEUPME+HPBdelznAA3k
 2bqaH9LvL1+xCLXTGbvh+p+ePpSDorB5azY5xEEW7SJ0QidHUn4JUqrNzLFkVHzk1n0F
 lDGjLvLzcS0bbjYCOC64NTJ8zhv+amb1aa8B27ilKsuxNrTS92oxsfsrQizbIeWqUbBj
 vpmSB4ll2rpKJxk0m7gVnK8xIEjTsx+R1QxIWYaSF9YLMC0rQqz4uZ2P4CEDVs0aDHlg
 rJVw==
X-Gm-Message-State: AOJu0YwvZ+U2kPo2eQzRh+RMCC8wVvh/J/2VaZFwXj28+FzQ/46RcNCZ
 NJMxWKMLwHSP9EqQVAPQL4vzfwgk+q/SgRmq7I/ylRQDwj8oNnhQS0RxPp4tBN0FhuTXvPPCOwy
 qVGcO
X-Gm-Gg: ASbGnct48Ez1pvJthwuRr7pBGZOWBbe5QPga3edk0CZJM9nHSc0zfBK7q0qxDck8aMa
 a2o+Z1WawXt/tWTvOE/po7oEmk8SRPK1r2klcKBGXi4p9RHEp+YFiZbVbWHCuDcRWKVKezEeLdo
 d5L4CsCHO13lO8HeLhUgAqURm8d0cHB1Ru2Vev/kkdqafxiVPv3kWuXScWkuk37qci8bkT02lcr
 HjmWig19KiUr+c7/kgb/qfLZ2h7aJI/Z7YowOvfqlc306tT2Ek4sqmTKhfzBcuREeEipZUQQB0i
 w76JUb+i64/sxJwOo04Te5gQF2aWAisSjX3OQsjtCrw0rgs+Fv1jWOxS3jjlPAwox5Uo2nOQG40
 saEqNOVM8l9e1neQxK6eFJ9a98UQzoOA/UYgbvx5NJgrWtf1/V7xEazrTRAwlKq0NZqTOg0kUlJ
 02k50b1xEihq2IPuR1nDldyQMl62F/OfK0/K7PrOEOamGV6VsoYg==
X-Google-Smtp-Source: AGHT+IFkt48XqpSJahefxqG4cCm2hA0Sgh2ByaibbkGv4sli4r6l9JESQVKxOtxirpp9aO1Q7eCxAg==
X-Received: by 2002:a05:600c:524f:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47939e282efmr61189445e9.26.1765134767665; 
 Sun, 07 Dec 2025 11:12:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:12:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/17] lib: fix format overflows
Date: Sun,  7 Dec 2025 11:11:51 -0800
Message-ID: <20251207191242.165619-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
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

Change all the libraries to find and fix cases where a string
could overflow when formatting or using strclpy. This does provide
early indication of possible problems where the file prefix is too
long to fit in unix domain socket path, and where a hash table
is being requested that has a name too long.

Stephen Hemminger (17):
  eal: use C library to parse filesystem table
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  telemetry: avoid possible string overflow
  efd: handle possible name truncation
  eal: warn if thread name is truncated
  eal: avoid format overflow when handling addresses
  eal: add check for sysfs path overflow
  eal: limit maximum runtime directory and socket paths
  eal: check for hugefile path overflow
  eal: check tailq length
  eal: handle long shared library path
  ethdev: avoid possible overflow in xstat names
  vhost: check for overflow in xstat name
  lib: enable format overflow warnings

 app/test/test_hash.c                   | 21 ++++++
 doc/guides/rel_notes/release_26_03.rst |  3 +
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  2 +-
 lib/eal/common/eal_common_options.c    | 17 +++--
 lib/eal/common/eal_common_proc.c       | 83 ++++++++++++++--------
 lib/eal/common/eal_common_tailqs.c     |  5 ++
 lib/eal/common/eal_filesystem.h        | 23 ++++--
 lib/eal/freebsd/eal.c                  |  6 +-
 lib/eal/linux/eal.c                    |  6 +-
 lib/eal/linux/eal_hugepage_info.c      | 98 ++++++++++++--------------
 lib/eal/linux/eal_memalloc.c           | 11 ++-
 lib/eal/linux/eal_memory.c             |  9 ++-
 lib/eal/windows/eal.c                  |  6 +-
 lib/efd/rte_efd.c                      |  7 +-
 lib/ethdev/rte_ethdev.c                | 35 ++++++---
 lib/graph/graph_pcap.c                 |  9 ++-
 lib/hash/rte_cuckoo_hash.c             | 41 +++++++----
 lib/hash/rte_fbk_hash.c                | 14 +++-
 lib/latencystats/rte_latencystats.c    |  9 ++-
 lib/lpm/rte_lpm.c                      | 25 +++++--
 lib/lpm/rte_lpm.h                      |  2 +-
 lib/meson.build                        |  4 --
 lib/telemetry/telemetry_legacy.c       | 37 ++++++----
 lib/vhost/vhost.c                      | 14 ++--
 25 files changed, 325 insertions(+), 168 deletions(-)

-- 
2.51.0

