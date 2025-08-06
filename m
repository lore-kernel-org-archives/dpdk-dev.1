Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCBAC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 572D34026C;
	Wed,  6 Aug 2025 23:42:17 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8E10E400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:15 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso164134f8f.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516535;
 x=1755121335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kPHEyDObIwMlBM9kmAyfXXO6uXfX+kv994rCyUhmw0=;
 b=O8Z8lzVCSfMi3ovjQMY+KNrdGx/D0qQOkrKsgmaBjkgePK5IlhZ965B5mFWv9yv2Uy
 VkXbSQPi4dY16fkKFxmTbJEi8I7eWd2TaDUkNgPKP7rf9Z/hI6X/JvtGbc2uX8U6AK8I
 dnBX1nF/9h6WvEveUXtbw5IXI3PeAV/TkNxuN2xeGXujhonJk2PRo6+yP5YaJWnwbp+O
 eiMxOBFUoNJlE08Tk7Zh7HqXt5suzGib725VmnS6iDOfzQVDEhH74kpxJzUJxq8h6N8Q
 oAr3z6zDZWR1YqkA5h7AD7oc4op04B0ZmgTfmwJkQ4NDdSmfBpgiqA7rgQN1Jt9ZDXXn
 fEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516535; x=1755121335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kPHEyDObIwMlBM9kmAyfXXO6uXfX+kv994rCyUhmw0=;
 b=PzpDP3ejKxiyhEwzVHqPFOZXEGhow/j0T9oFtLnS0ZNu2fylWKxdtUKqWcCG3FV13M
 BLZfxPw5ejkYk2VyIAuzRNHePJyfRMCpErPBumCyhjwrsOeBH/jOLunHPvu+rHYFQhO0
 uOndBZDKQppVH+RFmOFTmE6ZenanEXNZf9YkhcmIeZW5V6YRgwD0k1/DwXKGCGnaY8k4
 GZbTdDOGdFYaPYM62kORehH5aoFYsTQCQ1I6waDlW6xjek8d8BDcdGNJK6REWCjrlnv6
 GlsTxu1NYX5EBQh2EUr1kkaIeDIJsX5T3IANVxGncogdLkK6KRsK1UVrsmRNJ3ehLve/
 AZ8g==
X-Gm-Message-State: AOJu0Yx9Sg1+V3X2vNzdalP7F46YvMiK0EqDx/J09m8KykxSb4O3+kBg
 IovptA+A7thLNqxG528k4yG42rpTqPV0s3TenwOQQEYADN4ux+VBuDuTfl/Xdt/Tc0b2lLJODsH
 jOZsE
X-Gm-Gg: ASbGncvei4FpABja9B5xn1KBQ1apmbHh71jOTRkOMehIOJfKQ3HGvLlamVHJSXn/ME9
 bbIGYEJ6l1erdEteBVxg5ead6q/5JYHec1MBZq9WO7ufbJk6ilWvjCRjg8v7S2dQoOxZbNd7zFn
 L7ojGaBQhNzIWg9Iu19SgmRqzAkvYQvdyl8Cr2QeESP9NqhA0f024hIaUklpmcMhigKTmRNh+ke
 Z0vHt1USA1APOSzm5i0G2xR/FT48iaUe2bBoEJwnq1YOGGneIPtfXdd11N6HPnx3uSo4PspeYQj
 GLyCE2Kiyb4GaYKYGGSGWI8Fa04D/+9vOjjJIw+V3s8XhDp8Qvyl/0YKjOqtWvP/XUr3KtXkUi6
 7v/9WdH4ZvLzzhX+FiPES37R1hm+L+5B8wivkS/HpfBfJi0v4M2u/aiMaOCRzMBIOENnmNZjJA7
 43q+8Ff1Q=
X-Google-Smtp-Source: AGHT+IHm+QmWufyLSHFgmhI8X1+4fu5YEtPaiEXMq0SEf6I+ZJx1yXbDN5ksCI/zZMqGJ5z3UsthaQ==
X-Received: by 2002:a5d:5d85:0:b0:3b7:81a6:45c1 with SMTP id
 ffacd0b85a97d-3b8f48cd02emr3228825f8f.6.1754516534532; 
 Wed, 06 Aug 2025 14:42:14 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/13] Packet capture using port mirroring
Date: Wed,  6 Aug 2025 14:40:29 -0700
Message-ID: <20250806214200.193029-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

This is a rework of how packet capture is done in DPDK.
The existing mechanism using callbacks has a number of problems:
  - can't work when packets are sent and received in secondary process
    because callbacks only function in the primary process
  - requires "opt-in" from application

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's:
one to add a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command syntax is
unchanged (no doc change needed). Using the new mirror mechanism, the
dumpcap program creates a port using ring PMD and then directs a port
mirror to that new ring PMD instance.  Then the packets are extracted
from the ring.  If capturing on multiple devices, they all get
mirrored to the same ring PMD.

The dumpcap program needs to be able to start the ring PMD it created
but the existing ethdev API is broken when used from secondary process.
One of the patches fixes that, it was also reported previously in Bugzilla.

The mirror API has a restriction that the port being mirrored to must allow
lock free transmit. This is because both Rx and Tx as well as multiple
queues need to go over the same transmit queue. Although it might be possible
to have some complex mapping between multiple ports/queues being mirrored
to multiple transmit queues, that gets to be a lot of overhead in API's
and implementation. Fixing the ring and null PMD to allow lockless
transmit is good enough.

Added tests for the mirror features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

Future items:
  - need release note and documentation
  - more through testing on real hardware
  - figure out deprecation plan for pdump

v9 - address build issues resulting from ethdev dependency changes

Stephen Hemminger (13):
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  ethdev: reorder bpf and ethdev dependency
  bpf: add ability to load bpf into a buffer
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  app/testpmd: support for port mirroring
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  app/dumpcap: use port mirror instead of pdump

 app/dumpcap/main.c                          | 392 ++++++++++++---
 app/dumpcap/meson.build                     |   3 +-
 app/test-pmd/cmdline.c                      |  13 +
 app/test-pmd/cmdline_mirror.c               | 194 ++++++++
 app/test-pmd/cmdline_mirror.h               |  13 +
 app/test-pmd/meson.build                    |   1 +
 app/test/meson.build                        |   7 +-
 app/test/test_bpf.c                         |  28 ++
 app/test/test_ethdev_mirror.c               | 325 +++++++++++++
 app/test/test_mp_secondary.c                |  50 +-
 config/rte_config.h                         |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/ring/rte_eth_ring.c             |  49 ++
 lib/bpf/bpf_load.c                          | 111 ++++-
 lib/bpf/meson.build                         |   9 +-
 lib/bpf/rte_bpf.h                           |  38 ++
 lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c}  |  35 +-
 lib/ethdev/ethdev_driver.c                  |  12 +-
 lib/ethdev/ethdev_driver.h                  |   6 +
 lib/ethdev/ethdev_private.c                 | 141 ++++++
 lib/ethdev/ethdev_private.h                 |  29 ++
 lib/ethdev/ethdev_trace.h                   |  17 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/meson.build                      |   8 +
 lib/{bpf => ethdev}/rte_bpf_ethdev.h        |   0
 lib/ethdev/rte_ethdev.c                     |  99 ++--
 lib/ethdev/rte_ethdev.h                     |  23 +-
 lib/ethdev/rte_ethdev_core.h                |  12 +-
 lib/ethdev/rte_mirror.c                     | 501 ++++++++++++++++++++
 lib/ethdev/rte_mirror.h                     | 147 ++++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/meson.build                             |   4 +-
 lib/pcapng/rte_pcapng.c                     | 179 +++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 34 files changed, 2253 insertions(+), 251 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
 rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

