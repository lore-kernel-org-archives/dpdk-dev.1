Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F855C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27DF04027C;
	Thu,  7 Aug 2025 19:34:49 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 8254440270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:34:47 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso705785f8f.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588087;
 x=1755192887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwcD5/CsDtT6qc9HD5ssNnBSmCc0fhJ29n0O1+nYdM0=;
 b=T2L3iT9vxBnFRdwL/FxRIByXFjvraPoa24FAxljwD3icTSS/9+yGgOfze8d2AkqOdX
 FbzhRUhs7xNz8YGTZt3kI1zEP/op3uW0EqXQUvYCkgGevg3OMaOh1mc5nfJYCJf3aouc
 o1KS8fkE+kk3XutiGap6ryvTPkHLetM0FCpaGpPuwXE4F9Wv02GcLrGOpCcdh2NNp34w
 wDmoAaZPSVaCLJTLw+6z9LdMrGZkhERUXXkLZUmVmgB2cBEdfw8FXgLPms6lErLblLEr
 oIPXFO711fyNw5dHMTuOdzUoS8FkdFI8oZtU5S3xZW1bjoH1q7Qo/HtCg6VN3hC8zowo
 6Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588087; x=1755192887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwcD5/CsDtT6qc9HD5ssNnBSmCc0fhJ29n0O1+nYdM0=;
 b=qsWZUWKChzld7+3HB9sQ/AgQtVs8tT9WpXbhHAbSlin6b4RnA7w3lvGQNoknVjWCOm
 dCsHsJKOTTgONDIRywUXUuqyVJrHmMS7f9g050zaNL3ddMrPG88FFk8IH2Wb/aPgmNjV
 x97zYT4DqLicNyX5AUQKEUJ1DZMUU9IZ4U1PO+A7o+icZRVJBDCRil7OqQAMMo1/9zS0
 apb1HtPv77tt2kXn8/ZuUrBZK1nRy6gdFLI7x3fY4bCPbeEtUaCDmdCiGAqGWdKTExPw
 gKTVZX8aekDkmLk/AX5PoNKg6PTMeDZjU/MOq1C1D4hnp45+0tROWwnU695famwdP2u4
 WkYA==
X-Gm-Message-State: AOJu0YyKQ4sWJIoFm6RA4ujI//dP9uH4znGiITH/Oj0YNs0NG0Ng7mn2
 DCIGhx0qDfbssl1+m1jezqQAozJdZUWgdkNmhZq+Nrk380rmvgQzEoqUJs5yMmir9gDk3nh45ON
 Rugnx
X-Gm-Gg: ASbGncu2a2U1heh7fj4YHwb83FMbWZvXD+vFnxzl/iN/r/u+bW3HFgWiIJK3lI7RppF
 B/88eFUfYsJEZq8bJ6cblSAHl/PcsZzDjU/Iao2Q7VCAwgWtdrrc1QInfyEkQ99V5jvk5iYwnvT
 jde9PegdWpIopgFLq/Fi5cD+9gD2WKXXLUvi76+45wbcKMbHtYdUorqbdQUAeLOKcJPs+VZlrVH
 h4fX1/oZDuOyJkv4G9Ug4RVdGefwH8r57PtVU0GaB5YC4wl96COMqGiDTvY4RwYsG4a2gblhZkD
 ywCvWM4olOIPDXUFdhIIgXnDD9CTXFReJ4pAADD436rP/3Z2krviigoOEIfhEs1UT0WyUjsfkFa
 WhWfpdzV5W9XAJw/NKe2zRm7SfO/8U0NawQDOlOKJB8/fr7MMB30UdnRTGlNWisNGlkk95zYU
X-Google-Smtp-Source: AGHT+IFa8h8ZCyH2CL+/0fu9yyqywyV+xZQv3QFicrmvOiO2T6rfioR6wwJd3+5xjBqJQllEEjHqXQ==
X-Received: by 2002:a05:6000:4312:b0:3b4:9721:2b2b with SMTP id
 ffacd0b85a97d-3b900b499damr86471f8f.12.1754588086661; 
 Thu, 07 Aug 2025 10:34:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:34:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 00/14] Port mirroring feature
Date: Thu,  7 Aug 2025 10:33:14 -0700
Message-ID: <20250807173437.11442-1-stephen@networkplumber.org>
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

v10 - add documentation
    - add dependency for test mp on ethdev

Stephen Hemminger (14):
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
  doc: add documentation for port mirroring

 app/dumpcap/main.c                           | 392 ++++++++++++---
 app/dumpcap/meson.build                      |   3 +-
 app/test-pmd/cmdline.c                       |  13 +
 app/test-pmd/cmdline_mirror.c                | 194 +++++++
 app/test-pmd/cmdline_mirror.h                |  13 +
 app/test-pmd/meson.build                     |   1 +
 app/test/meson.build                         |   9 +-
 app/test/test_bpf.c                          |  28 ++
 app/test/test_ethdev_mirror.c                | 325 ++++++++++++
 app/test/test_mp_secondary.c                 |  50 +-
 config/rte_config.h                          |   1 +
 doc/guides/prog_guide/bpf_lib.rst            |   2 +
 doc/guides/prog_guide/ethdev/index.rst       |   1 +
 doc/guides/prog_guide/ethdev/port_mirror.rst |  68 +++
 doc/guides/rel_notes/deprecation.rst         |   5 +
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst  |  15 +
 drivers/net/ring/rte_eth_ring.c              |  49 ++
 lib/bpf/bpf_load.c                           | 111 +++-
 lib/bpf/meson.build                          |   9 +-
 lib/bpf/rte_bpf.h                            |  38 ++
 lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c}   |  35 +-
 lib/ethdev/ethdev_driver.c                   |  12 +-
 lib/ethdev/ethdev_driver.h                   |   6 +
 lib/ethdev/ethdev_private.c                  | 141 ++++++
 lib/ethdev/ethdev_private.h                  |  29 ++
 lib/ethdev/ethdev_trace.h                    |  17 +
 lib/ethdev/ethdev_trace_points.c             |   6 +
 lib/ethdev/meson.build                       |   8 +
 lib/{bpf => ethdev}/rte_bpf_ethdev.h         |   0
 lib/ethdev/rte_ethdev.c                      |  99 ++--
 lib/ethdev/rte_ethdev.h                      |  23 +-
 lib/ethdev/rte_ethdev_core.h                 |  12 +-
 lib/ethdev/rte_mirror.c                      | 501 +++++++++++++++++++
 lib/ethdev/rte_mirror.h                      | 147 ++++++
 lib/mbuf/rte_mbuf_dyn.h                      |   9 +
 lib/meson.build                              |   4 +-
 lib/pcapng/rte_pcapng.c                      | 179 ++++---
 lib/pcapng/rte_pcapng.h                      |  27 +-
 39 files changed, 2335 insertions(+), 252 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 doc/guides/prog_guide/ethdev/port_mirror.rst
 rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
 rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

