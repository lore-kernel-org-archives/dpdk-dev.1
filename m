Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C136C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7858F402AB;
	Fri,  8 Aug 2025 18:58:50 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 289D94028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:49 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso15736785e9.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672329;
 x=1755277129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fgT1qLozEdNlGqlnRXbhzdFCEkxjr3RPpi/NlUUkEA=;
 b=bdX4hhuiUoodqbB9cAGdtDBVLhGX4RLj25yv+fBZEtvkhfR6sE3mGY8nK/4RPiw5F8
 FDPhbTVGvvzAh1qoy1e5vPZcKGJmYi1OSRu+xcNIGP68gsu+7WbU3W0ZzkdR7Acungy5
 0ZB3bXny2X3K/UmAuPs+s1jwlStugvvPa8eGa6hMN3Szx6EuxcJ6qeBS7P8S91JLCbQV
 dPb0AzicvHLFnQ5IDZU41GXmBetlE1k7OFhiYg6DhCe/C0Lr5rB0EXSbKH1mz/BCJeDa
 75bU+bpg4qJQVk/WhscU5++zTtOjI5OtIktM7rBy1LfTbFwT0h90S475Sv2nwM55Lcmw
 9DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672329; x=1755277129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0fgT1qLozEdNlGqlnRXbhzdFCEkxjr3RPpi/NlUUkEA=;
 b=Qne7ZDzuI82BSpo3J12bSz2upi86aOxT8uBPaQkV/pj+7YifvV+Taz1KS+6WXX/MQf
 8ja056SZVJSkyRmFtTH8DU8qeJ80RQNgPM8RiwjcgLsgyOuzEfHV1ojkuWC7YiB6KE4D
 h317fRSKf07qzsgotZYOkpD2aiZ38G1vtGL0wx4G4AxHXZ7iuM/H7fNvhoRs08/upVPm
 +qS/ddwtijErLxx8vtQVAhizeNgjFyxrqEoAYy7U/n7EF3xgRgCMoAwt+gHqpiCM0W4T
 9r7pdf6YagSwSthwUXTEuXQJPRyFjBxH8MnnGeVQmlrqCttDUbG131zUVoXnxmjdgmge
 UGWg==
X-Gm-Message-State: AOJu0Yxa2iGCN0V0fvSKtAFXZ5AWOJ/mReXdrQ1NqQj+O7HmrJma1kQr
 7u0eqVJLw0KZRBPgGTpb3zU1/Ov52MKOl4JEAtZINirEFAQz8euN7lgZ4iZHTa8Xji0ygF4AqpH
 fwW3r
X-Gm-Gg: ASbGncvkqLyd2VC7u+WNPj19Sw/Zhn/odUpbnOt7ytoVzCoxbYCRnKoC/nTyq3SU7n/
 XvOTTcqd3BSyW5+qoBe2NMVvQUjbvTrMlusFObrlQ9aZX4aH81YYCxWwDf8sU6VTpSR8GOg4vJj
 8+LoAXlz6U81QvQR0sOVza4XMkxxrQSpt32vsJAqG+8SlFUkWe+IfpQFSsYEBsQ2uux/iT1SFEu
 fY0IsMozMGxFXBwkoELplMuXPbh+5AwiA7Wq70dH/gxJS7CMS0OyPtKW8zqX1xo+p7PqU08DLAp
 6Utj24dmF2ijwmym7GoO2krZ6hf138U9le8w3jFE6cc0PkgEHLB0++iRg30O0JRrZd8Hbu5X+4y
 8TwSWJesFgsga63GMRHps2DB/NLDcqO7UPaWX+zR33c2CzilZA99S1fGoxkgofVzU4Tu2AaaN
X-Google-Smtp-Source: AGHT+IFPsj+VIAf4F/6XxA8aPgMtQFy0Q0FTcnl+NL5A7jm2UX8MWcdArQH/4KHLjidM6yki77yR6w==
X-Received: by 2002:a05:6000:3104:b0:3b7:96cb:2271 with SMTP id
 ffacd0b85a97d-3b900b50310mr2874119f8f.37.1754672328614; 
 Fri, 08 Aug 2025 09:58:48 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 00/14] Port mirroring for packet capture
Date: Fri,  8 Aug 2025 09:55:38 -0700
Message-ID: <20250808165843.39075-1-stephen@networkplumber.org>
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

The mirror API is optimized to use lockless transmit if possible.
Fix the ring and null PMD to allow lockless transmit for use by capture.

Added tests for the mirror features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

v11 - fix build if BPF is disabled
    - allow mirroring to device that is not lockfree

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

 app/dumpcap/main.c                           | 392 +++++++++++---
 app/dumpcap/meson.build                      |   3 +-
 app/test-pmd/cmdline.c                       |  13 +
 app/test-pmd/cmdline_mirror.c                | 194 +++++++
 app/test-pmd/cmdline_mirror.h                |  13 +
 app/test-pmd/meson.build                     |   1 +
 app/test/meson.build                         |   9 +-
 app/test/test_bpf.c                          |  28 +
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
 lib/ethdev/ethdev_private.c                  | 141 +++++
 lib/ethdev/ethdev_private.h                  |  29 ++
 lib/ethdev/ethdev_trace.h                    |  17 +
 lib/ethdev/ethdev_trace_points.c             |   6 +
 lib/ethdev/meson.build                       |   8 +
 lib/{bpf => ethdev}/rte_bpf_ethdev.h         |   0
 lib/ethdev/rte_ethdev.c                      |  99 ++--
 lib/ethdev/rte_ethdev.h                      |  23 +-
 lib/ethdev/rte_ethdev_core.h                 |  12 +-
 lib/ethdev/rte_mirror.c                      | 508 +++++++++++++++++++
 lib/ethdev/rte_mirror.h                      | 147 ++++++
 lib/mbuf/rte_mbuf_dyn.h                      |   9 +
 lib/meson.build                              |   4 +-
 lib/pcapng/rte_pcapng.c                      | 179 ++++---
 lib/pcapng/rte_pcapng.h                      |  27 +-
 39 files changed, 2342 insertions(+), 252 deletions(-)
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

