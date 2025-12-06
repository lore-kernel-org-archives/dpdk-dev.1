Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89714D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4395D40268;
	Sat,  6 Dec 2025 19:44:17 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 8EF1240156
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:15 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42f8e39cf89so187022f8f.3
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046655;
 x=1765651455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5MOnI6y6xxIyiTUVtH9tV3evm8NS8iXoUZh8eIIwi8=;
 b=vVc91CIMMvYEIsU8Ye1RvUBWfMxM8jvuWf6rC/lrBi3KiUYH+WqP9VPAMcHbzzKp5U
 ElqyszymRab7SOLk8BngQDYWFlDp4HjeEZzpPtPRbbyBglfWafoqoW56MQVcCB2ly0Tg
 wu4iyD1jF0GcEMXYELqQUyRBBbtpVqiIVB4CMLcD+MWoG/U/E7qNrQVfD1xuY4LwV3lY
 cFBGHDhgGjShNil2ucIUpg6AKcGCrUFC3TotjxNhM3fAux5TPbamJwjRJ3aiqAU4QM3N
 EGjN+MsSVd0Z+nCtVbBNYlxGzhsOiZITF6/9xxZFwPrHo+vYfC4oGzGljtARkXbxJ8gv
 YHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046655; x=1765651455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5MOnI6y6xxIyiTUVtH9tV3evm8NS8iXoUZh8eIIwi8=;
 b=WnFPvGGMo1lgAxJjPzINXg5AILNJNS1xYZscynvd7ioqc1VJ8ya6RlS6/x+y8EbQSs
 vAH4AfR9kC45N+kbwdnlp1WFtro+CLK89BPYF1vxvgXizWRVxIwGLDlyrp2Z2lXM/Dgv
 7c09H/4/tkKBfjnQ6ovrkVCpgA5APEocgSisAPzbSxTbyWFJ92pkJDJKxEE6KL54LMV1
 VubUKY/VOhNbEI61vEQj0Ia33WwgxN5bHp3rVwMBiGfUHFaIzYpt7htm+I1vbLYqzDma
 BLEl7ZveRImepSKCgWVir6WMmlGk/frO8zutNvKaEwiZ0edwDS2/MU5V5/8lQR6ja1rM
 zy8w==
X-Gm-Message-State: AOJu0Yy3xSXueNUugFEhOHKPKNuXX/x0fRMLGr7xnSacPJ2wH+2FtcYQ
 x6A6bLtTk6Ioh07qCnBXR32iJRb/QLhxdl56h+hCsjEMk+RyXtZN000/1dZVwAj3RyG/b6QPuK6
 2Zd7p
X-Gm-Gg: ASbGncvGjT+spmIeb4wuqPQfJ3576T/NHOnXBsK9RWaFhOFlxmyn8EuYtKmzjDPseDP
 fOj6hsJvnqas7y1zaZweGa+YRD+LNf/dZB2EEDD+3BjkX2GxmaCsMy4z21cMu6ZdZrov+sC7Y+z
 AM1KcsAWXL1AfT7o2Nm82JIH6nm0lQqGz+YByiAIBx1Aml+8ItcIhsAmSFE+L8sd23rUxgeO86r
 LHxn9kJNRzDK85f+pJn0+5p6+qkBmnfhlJwfgemdNkwY5jaELP/+N/XCUneDAHYsQDH0WO+mqHD
 YkLJZZ5hIv2FPTwirAz/qcSmgO+D4QWKT0cHNQhu9qNmqja+TE+FmjwvqC+fxa4mPDga4mOZrA/
 9pctmr24XpY6O9ltq07OXTops+3KTjuLf4bo13tbNdqKA5uux3rAlJVqVOWS4+1gRV/eO03/asq
 +861YQI3NCrmBds8FuaDlG1D+Hvk6J0nWUy4a1idmdQaaSASoM1w==
X-Google-Smtp-Source: AGHT+IGk9Wxb9J6A8EytLTijMwWOAHtg7zT7R/0LsbEA0l3sd95x2aIKAYL4trN8dYpDYAeM0wJrCA==
X-Received: by 2002:a05:6000:2403:b0:42c:b8fd:21bb with SMTP id
 ffacd0b85a97d-42f89f5df37mr3220377f8f.39.1765046654876; 
 Sat, 06 Dec 2025 10:44:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/16] lib: find and fix possible string overflows
Date: Sat,  6 Dec 2025 10:43:01 -0800
Message-ID: <20251206184410.542725-1-stephen@networkplumber.org>
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

v4 - fix build on 32 bit and windows

Stephen Hemminger (16):
  eal: use C library to parse filesystem table
  lpm: restrict name size
  hash: add checks for hash name length
  graph: avoid overflowing comment buffer
  latencystats: add check for string overflow
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
 lib/vhost/vhost.c                      | 14 ++--
 24 files changed, 303 insertions(+), 153 deletions(-)

-- 
2.51.0

