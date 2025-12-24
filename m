Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC14FE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92EEC40262;
	Wed, 24 Dec 2025 23:13:09 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 5912A40150
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:08 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so2702481f8f.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614388;
 x=1767219188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGdDfB3CKIfuJI0i+exB84zXwRnykJ9OAG3Vjrs6ZgE=;
 b=rhqjrMc8/iIxUgiKVwr8BqnP9Worsuyu2pH8vxncaJ4rTbLcFBtSxV8gsLx5g0qp/K
 xekAWps/di5BalPMSVJNMwHC4t2t2BwYZ874UyrY+d9PrCKO+tzNsmwFUXB5ARyZ0C1f
 M/UyymArseVIbjjTCarzCRujp/hob3c23AJ7h5d/f9f++sYRhwny3fprTUsWXdMXeOk6
 xktyWY9uNjyaq0doMK9Xd64Huuzg1pBuWXTNnikFA52XCzI8XSJOIeO1RJbJ7tvy52bi
 /d/3X51jXQxx6M62WX/mvA5HRMpIjrYuUI8dfb62SDqacF70UkxmEKVrARxh4bQpXJnS
 I2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614388; x=1767219188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGdDfB3CKIfuJI0i+exB84zXwRnykJ9OAG3Vjrs6ZgE=;
 b=LLkmwZ9a48kSqNM9mPq/mV2HyajBJtqh1VdYN/Y1e8iy1cflTnNHPIBSJjjEvVWzAM
 UPeir1xDhdHt+kaInKZHX/dFHYtUZ/hXAOUHFdLeMoEJ01/2WJPajq5WGzgRp/GA9Ydz
 2L84B2ESfB59P/pmpDDe/O9UPd/wFaP2J4Z6sqoJmvMYPIwku7dnnGSDC0Kw7WY+NsH4
 Qt8v8VIE1xsgttKmiQx3PMR0oNmT6YD3KtLSmiF93ALJYdbarKGEFREVe4hDjeKxMDby
 OmycrTyTz4KbdKTBXaJFPlhk5f6hidHvdXPwHxCFkCxTy4LTC3UKknKndYDEDA+bwD5V
 8j8A==
X-Gm-Message-State: AOJu0YzNnbzgRqvoFd0qfr2gdz7vYCjeKFvM9iMZ7DOiwB/epmJAosTh
 UqliYiQVXwPr2YksnmMs/eSudyqSzM5lC7v+KGIt08rP2E+WIFOFDvnRl1wEJDmygEp9fK/LYuk
 jVpCjCgA=
X-Gm-Gg: AY/fxX4zSk2cnWO3WztUBDZGxjo+rCDXqxmgKBWCu+23f8xpiq469Q8q7Js8e/YsRLO
 E7fkg1PTBNwevQeL5TSXrH4jTkVcvHQuAVmMbnjO9kHun4Sf4LU3KqIFouLx9afnyyxnUaW60KB
 eaQKL2fskddtui2sKurPALVrpMiprJwepouK6SA2lzJ6m5T8vY+GEQtiY6LfiCcqd6S6zlBEz9G
 05oa8XEmaPEgoM4ofkIcrgsM0brOaT93/eYdNo/JKH4pYGs8BLs684MJkqNvvsIdnq54vZWA4fB
 zdUl027jFP2IWeoAuB9DiHt1LQyN3qKBz6E92PehFfEHEdSbJ1d/h02SkUEO1jAw7J7mFnoEYrt
 KDFLrZmM1wEda7/epNZKO/2BwHIS9Vutb9tArgyr+jQ5JCt52tPE8uOqjen3D2kzaGrsES34YGD
 MPazZ1kHvCvy2gaOsWBId+VZDc+c4BAgnTdX/Ri73T75y2itt1vA==
X-Google-Smtp-Source: AGHT+IGw0bg6ISSTmXla+Gb/untibtIrjU94qwNHiFqSRAs6tOPK0euvB7gJSRroymvYDoIjbnoYIw==
X-Received: by 2002:a5d:588f:0:b0:430:ff0c:35fe with SMTP id
 ffacd0b85a97d-4324e50b989mr24327942f8f.45.1766614387533; 
 Wed, 24 Dec 2025 14:13:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/18] lib: fix format overflows
Date: Wed, 24 Dec 2025 14:11:41 -0800
Message-ID: <20251224221301.52714-1-stephen@networkplumber.org>
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

Change all the libraries to find and fix cases where a string
could overflow when formatting or using strclpy. This does provide
early indication of possible problems where the file prefix is too
long to fit in unix domain socket path, and where a hash table
is being requested that has a name too long.

v7 - simplify and fix Windows build

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
 doc/guides/rel_notes/release_26_03.rst |  3 +
 lib/cfgfile/rte_cfgfile.c              | 43 ++++++++---
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
 lib/lpm/rte_lpm.c                      | 17 +++--
 lib/meson.build                        |  4 --
 lib/telemetry/telemetry_legacy.c       |  7 +-
 lib/vhost/vhost.c                      | 14 ++--
 25 files changed, 335 insertions(+), 161 deletions(-)

-- 
2.51.0

