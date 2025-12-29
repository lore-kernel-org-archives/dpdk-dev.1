Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DA8E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 252FA40267;
	Mon, 29 Dec 2025 21:48:26 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id DA6A24025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:24 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so1257125f8f.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041304;
 x=1767646104; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWpM+GDKczGfzcpjtUbIh994tTD0DHL9/KAymdOCs7M=;
 b=2TvYQ9wm8ewWpY08tbI1vQOFoi1YFsMKFDbPKX7jChclVasgpzBirB56NnOqdV12uF
 7+gL+C3NQceh12ALBVM8pkluz9CgzU2ryzh5lxtUxphlxTHimRxPd81w5hYCL+a8AP3+
 8EaPgwkK7I++qpBVoUWUCd6szSYkzLW93eMXaCbXRt+u4ZG+wKMPv+4h1XiOmQ35+Z6H
 WtUdKJDaAyNtg6TIQ9vNIVNi4LgEZgcfA2gWRkHMgE9zCldfG9DDCq+myHgkX1II3reL
 kibO8qrOnkqawEo8zV4BrLZgJMwqg/kzs3aMIIai++13IW1F+NBAuNCykhLJMhejFec+
 F2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041304; x=1767646104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TWpM+GDKczGfzcpjtUbIh994tTD0DHL9/KAymdOCs7M=;
 b=VkIJ2rENK+NktcuSVj4K99qC1NI9d+oCjXLN87zplZf//NH3EiEuqpF+x6WycND7ub
 y4sHa0RzOgS2/SbhUmT+c8XoCOUKO0lvdOPDG2MLNsm3vS7MMLlSSDE7ukFb2Rs7HwWj
 ksVq3sqAsky0MhU8kZ5pJ3vXmq4QKhLoZCkELBXZvp9Fp5vb1b3DgxgyBDNKEmH0ipJ1
 dcwvg+lDIZz3WhJpMSXQiieuHM6plbDQZfqcQWs2p+O3Ar7UvHID43YqJKwKcZkKepb9
 fcR3n8BXouStANYMZIu4UqLPa0rGeEtp7Csjw2IKdymvN8NEDOybHmoeDRic33dB027K
 CMmQ==
X-Gm-Message-State: AOJu0YyxCZNmAloRNcbh88KPTHpxuoVXNXfbO2s5VX2JuY/gNJsNDizQ
 /aS67KFuvz2pgUB9nycOgEv1pC1hCOEg0feyiZ0XiiQC0oNVxHRC3Ew3VQpTcQSSurDre4kJAq3
 fuCHJRcE=
X-Gm-Gg: AY/fxX7k7Zn94TaihIubg+smHOg0fcmgIswd0QfzI18RbH+Mq4dmLzId4GbqKL+zqKF
 8dp1VYrUmoy2WFVTZxSlX7scOcQY4kO6MZQXwaHxPV/Vlmpr5eq7kHFbz6OVi5cRYbZNZ2BC0JN
 Ib63+Sw7HCniNmaaTbyIBuKkbKXONUtYnP09eq5zVKU8+ICoJMRzNB4IcDK+pYw8kWEdPLuDoof
 ecN7qah4XcP7T3QogPrCVGpXEvWJ9Qpiu5XFdCb/sXY4t6tdMmnXT44cff365xIADzTlUpDbrV3
 tPC4V3hyX9r91jj3sFM0P6Vax3TUsIoHI2Rl9pVeEU7mZr3cfZVdfKi4P4Csan397J4kNBtv54E
 KhUIlUuBXKAc3WnVqLEUGxzzXLBRIionVC18THeUlVuUbVhRHfSRfnw7scyLH1as4LvqvVLql/g
 naHAYQ1XFZQ+JlEtvl1wxokfhEHZejcej1wlPwtCLmrf0Z82tcBg==
X-Google-Smtp-Source: AGHT+IGOcCqJQJuutd4kkFMCndhkqBih+DlWXksKeL+dg0uIVixrJ4jhC+EMpZF44sKtJ53mbFuL6g==
X-Received: by 2002:a5d:5451:0:b0:432:5bac:3914 with SMTP id
 ffacd0b85a97d-4325bac39a8mr24593562f8f.40.1767041304065; 
 Mon, 29 Dec 2025 12:48:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/18] fix format overflow in libraries
Date: Mon, 29 Dec 2025 11:37:58 -0800
Message-ID: <20251229204818.61231-1-stephen@networkplumber.org>
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


v9 - fix bug in creating socket path
   - add more release notes
   - workaround older mingw in ubuntu 22.04

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

