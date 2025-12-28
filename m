Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B75BE784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66A86402A0;
	Sun, 28 Dec 2025 21:19:29 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id A006740267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:28 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so89794725e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953168;
 x=1767557968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkdY1gdXsgEqynkXbwmfM68GHL7sW/2x+mXkuepHYbw=;
 b=nkCDLhbXH+9IPBcDltNU/ubZLZxPHwqrJBpeD4Ty5l9QVSUo2gqj4h6Vv49477x5i/
 EopxT4BvtEqHDlbQtQye+zcsqUOSUpBsHHg3SQKufSPkjg1JpNB6T4ScUBjwk6cpPRos
 l1pfl/aW0XJylff/2KQG1/2MhyfwWP62N3loV21WikTVwU+mEG6N6L6dvimLl4wk5V5l
 O2ugzX2kpd8++nPPyl8CU2MHYE4NNXCovrTK3T+wgVQXsrQSbc6cFFEaYskKx+7+izl0
 XlbKMIyaIJrZvrDRCeIp4IT4ZGmgiv72saXAvPThWBotkXxXVM1l8wpdH+dZzcvci4Tu
 gshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953168; x=1767557968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vkdY1gdXsgEqynkXbwmfM68GHL7sW/2x+mXkuepHYbw=;
 b=gUFf5EzlTUPPSb6cGwtziipnL4Bz+k6J0eU225eMy2z0KstQjQP6bSburjcIMSYSkI
 qvUDXnRlE79nuDdu1Jqc3Fm2J0Zx8x/Ojx18oC3tTmldF+3L3QMVrSfEmx1tjfJNbygT
 hlxrZxWj+yqJlI+ZwoYk9MnN75O5Of/Ora2SsTNWu/qvrVeys51yMOjk5EUu/VUknLTK
 h0au6DV6+z90Rv2GFl4rodOvAzIGXJa0JyBZIW/gGeO+kubxqkpnonqXYHdi4g43TTwy
 WJ/8jNeuu2iKzU0i3JnkUB7fev429fuHBgfx8X4XEYSJ2lw/9mM0rfaucaF1NdM0+Mtg
 GWbA==
X-Gm-Message-State: AOJu0YzjTxb9Ae4zuk1xWgUqFvu4EU2JcgBBPvVvEAuAlb7A8gecCle6
 fYz0zHq9JkLQPPK8aHLxchG3oOM4gAChVm3Nuib2vg5lf5E5Eg5e/bmG7V0Jo+lznUUMZCaHBBv
 MzfQRz18=
X-Gm-Gg: AY/fxX5lp+LFgf5ZrA4yEN2clZUlsFNJ+GEI9VFyfu5JZCtnowbtS9ND6ANBHFFOSfm
 OgcuWsAIknm7SUpnnbZixcK4SGYPyJZF4CLEGhrXY2PT281rpJTDe+fZtBMCpo/NTQtcphBOjDC
 Ww1ol/aCN8o1bIsg6kNNMb2OetMAux+NqnVyLyG3F4U+Lr9auxlnOnZ7+VDQIGChCPWlU4RHBTk
 zoThrhHzJDXxVZKKHDZ2XgUYBe36KKQm0OKp308CZYBy2kncmVDV4hTqmN0HrQMyMF5p2ZtAldB
 lbVIco41xFFSqu+1kNGxqWXqoZQiD4UzMUzkEx5V00+1fyUDh5sYsS3H5Vievp21LfxYVSRKG1v
 u7XVueG6/I8R+MLHukZAxtdTuYh/gZ9/TdOCpRDuTWC0VycGLmTp/OcPqHxnopcwl185aZI25SI
 5vL86AxFhuE3lVB1svW3tLUSB7QwlrPn4BuPYFfUhVLectTzc/+g==
X-Google-Smtp-Source: AGHT+IHn31IB35QED2IXjOWGlFHa5BgEta+4cp5sEKs+W9tn8LbXHbYnDNsvISF9zG2l9IQFo9qqcw==
X-Received: by 2002:a05:600c:35c1:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-47d19553912mr386566085e9.15.1766953168226; 
 Sun, 28 Dec 2025 12:19:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/18] fix format overflows in libraries
Date: Sun, 28 Dec 2025 10:56:03 -0800
Message-ID: <20251228201236.547268-1-stephen@networkplumber.org>
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


v8 - small changes such as adding updates to docbook comments
     and avoiding asprintf where not needed

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
 lib/cfgfile/rte_cfgfile.h              |  6 +-
 lib/eal/common/eal_common_config.c     |  6 +-
 lib/eal/common/eal_common_memory.c     |  2 +-
 lib/eal/common/eal_common_options.c    | 17 +++--
 lib/eal/common/eal_common_proc.c       | 83 ++++++++++++++--------
 lib/eal/common/eal_common_tailqs.c     | 13 +++-
 lib/eal/common/eal_filesystem.h        | 23 ++++--
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
 28 files changed, 354 insertions(+), 166 deletions(-)

-- 
2.51.0

