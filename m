Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B24E6FE24
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2EDB40265;
	Tue, 23 Dec 2025 19:14:24 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 091BA4025A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:23 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1032394566b.3
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513663;
 x=1767118463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxgIH/JAuLHY6RrtJ6f/4jJYq2Oi6Pa9WpMqtdHb0Pc=;
 b=Acq0+80RvA0pGUqp3GPsc1lBA93mSjYo4dchR28vX/FXEK+ZlBB73RdtyD6Wp4qsEb
 J150Cm5o240bd++MhW4mkHMG1z7+Tgp6LMbCCGdUmGO4iPRHmEIwUtiAG/xcZ/flUqiD
 w1TCXajq3FrNT3TckyahuODkby9BoeRxYYao2nrizpbeYMuCqA7cmPUxMNnNQ90RIqVS
 p12G64bVCBG5aQIdMAP0tWByfBdgEK7iAipAU1jxC9xvjiNlaGEgJ7lzFpOOGOX+zu7Q
 uRRFi6bpjjCtbeSF+vcf8SmWwls50tu6d/EwPrU+0R/IwDyP6aRJ4vAJ7+LJsLSO2k0C
 0XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513663; x=1767118463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BxgIH/JAuLHY6RrtJ6f/4jJYq2Oi6Pa9WpMqtdHb0Pc=;
 b=rPiNxzcJo4s90If9z1Vw0WpuUQAzmTmKi0bNu74fSRPRUk6k2rGzgGcw5b1QtOURR/
 5MbNCUlJCB9PAdurNRf9DzRG8Xtcjwp6Uo+sMVuiDGA+zZ6ahjoO9I3KHYiPI77/fXBf
 fDm0Hlzz8O55utBF4pAqm1ugYby6eqZQKGG6SCZqJ/QEKkREtaD7X8dy3dl4lO+90ZEU
 GjIZrZNekVXQxrnzz01LYQQPMLYtGYyLeDqNQ/MeaGEoJLP/RAvO63I5+XCsP+8OAccI
 RV96oVpF9nAw75v1TjlTE0jWHUq1g6jOVPBsaar/uV0bzO3fjYha+RkmO93YHEeQvJ/l
 hNeQ==
X-Gm-Message-State: AOJu0Yx4QlVzcSWn2iU9HXOFs1w77UEtJKJB1yN304pVQ8JuFA+OYM4+
 KdvBaZn8bg7NDZCTTyoeoCLBIjJD4HZdl6yfhKYqG0D8p95tqpQcoD1sP9DIsHhf6gfMwpFigL8
 vpKPgNYU=
X-Gm-Gg: AY/fxX4UmUPRiKqYKQyktlzUy/Y+8na8sszoLGUjHon8E2hEKYHXt988bA1ZN5mVojO
 4rNH4L3BwbpAZF3j8AGEoGquR9WyRf4A2G+uxlg/C1NC6ZgnvLeltitEF5Fb5yB4bl72C7kVwk9
 MNdJoLkKXeV2Di2DEH2ajKKbn8yHXlihs+1zL+YLtscMIqA69qHmYb9Uor877VdctbtTvz/dzai
 BakqQv37b4EvzNG43QTjSjj1TXK5Ogwhw+Is/AXEYVST+Tsxm/pLKKeNc1lspi+jG8L3y/AFXH3
 HNl3COQjR1O4KEwIdriJIJJ17gPGo8K+qIxW00xeloYfHoC1ontVPK31VKZb1MFjo03r/+6tjm3
 /ofZLyIatmbVdqQnF0RnRoF2fmErQII81JDF3IvJHIpBdI/mH5nREcOlDArJgUbtY33cvPK5BmO
 oGQMRm+X2/w8pyU/O2rSo8aoYMClJbMamkYW5PyyxJw+GeecPo7ksC/7zSAiSA
X-Google-Smtp-Source: AGHT+IEaYwO1gMjZsi3EVLSKonz6/Rzu6FLZ3EbfQHaq88HmafsT7JdUta57sZk72bJEIWLIvLAsHg==
X-Received: by 2002:a17:907:9810:b0:b70:be84:5186 with SMTP id
 a640c23a62f3a-b80371d66camr1615950166b.44.1766513663275; 
 Tue, 23 Dec 2025 10:14:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/18] lib: fix format overflows
Date: Tue, 23 Dec 2025 10:12:58 -0800
Message-ID: <20251223181418.40834-1-stephen@networkplumber.org>
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

v6 - rebase and add length checks to cfgfile

Stephen Hemminger (18):
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
  telemetry: avoid possible string overflow
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
 lib/cfgfile/rte_cfgfile.c              | 36 +++++++---
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
 26 files changed, 352 insertions(+), 177 deletions(-)

-- 
2.51.0

