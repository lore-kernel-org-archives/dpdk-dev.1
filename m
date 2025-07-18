Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B65C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E05E940DCA;
	Fri, 18 Jul 2025 18:32:42 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id ACECE40B9B
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:41 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e34399cdb2so236659285a.3
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856361;
 x=1753461161; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCLabieqDJTE+HXMULP3TgJjigEC8EUFyYOx12vEu/w=;
 b=1nMVIwqMEWSE+u5rEEArV/Nrbys/ngBdk7fwiPQqB4z+5eVgZ+7EMMI1ybpTU6n6Iy
 odd8p4IZ8sGg90wsl2zAoGrXh7qQymPRKLalcQRiSQbmGsQnP2ao0QWl7HlxjCwYeqNr
 vCph9IHV5TFKLT1MYdcOqxeLRK77tjgJuu55rg0cz8aRffHcCGSae68o5yNJK8E7b8KZ
 vVK9Jj5ccmXakd6C+5T5SS4dbofhxKaBY1Q9LN9YvUtc6mq4+2TIOdKpfkX0GY+MZeXM
 +ntn4f25WSx8b8MdP43Bbo1Uez4mmeQQlFOhIwBsulqE0HxRCJC6BQOrHPQE6DMzPNDY
 zn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856361; x=1753461161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCLabieqDJTE+HXMULP3TgJjigEC8EUFyYOx12vEu/w=;
 b=Wue4j2ko9pkd4LlKQ+3Wwm+O2dWw5E1DYSVVtuEkFdGAuu1DNf4ZFr4UNzC8DNYUYz
 zSsWUz7xvpIgZrqo9RWYsQkt+GZt/urBL+RTriqpmSpewPgL1HUXnmL1qjZxMe3vBgwV
 IyU6uTIFSpBKp/6S04139oKN7DChOlv/mTOr3n1ojpy35jv/DKi0THIuunzyJhzoBL7p
 xFMiEBngZlTrbYYLbisjlMEfV+LQ7xITjDmYltL4EHT7xEqZyYE3bjuaBxziIZNXUI7B
 OOsDyuaiQWTiU5Eafr46YY4o7gxl5vy59oGibXZeV994OTnxnlyRSWKTlqlRukms2w/I
 kqOg==
X-Gm-Message-State: AOJu0Yx0xdqoSYkoA7rOAXGiBJD8qGN7RU2WNpcYatDPT/JQDuIgLL4G
 N5ARJSBMkeWSqDotqwD+zB3KHoyqlWvctpd5ZFnEnxDlQav9/tjQ2ZV+1GW9hUHLHtjN2lZeqBP
 uvjuK
X-Gm-Gg: ASbGncsZHY94mwXN6ReaxajEqrNh2TWC2/InPCEOhgqnSZQ7hjn5+3NSJf9B/D/Yhos
 he5PyAWuAvE4p9dGFJecmAujnMOh7fRs3aZwZ5iNbUJcUjfq1JVuP1n+I5U64LbBApdYTueOsyS
 hpsSnMeh6PpGcyI3m+VYtwLqMaeRhzOxktb+cjCzHFCeTAMEYT5Zo17Xs739w8pOJRzUOiPV2oK
 vUt/3X6X7iw9hFnQEqZRSzgV1qv3S577fDFz/3m0ljkUrXUChxWDatTRmf51Ago8Bgpj8d9LSG2
 DNI5PkqvqUo8e6DQ5lLNLujsueRdqg2h8JaQyEu84W68GgvMn8cpPusfSVqXSkEX6RXUE7e1T3R
 mO7kKqDHnF9ITCE5himaN3Igo4rhflwV4JA5YoWh0q3pUf+6FimVUpbLpd16+tKK+GArNSkdE
X-Google-Smtp-Source: AGHT+IG+sRRtwg/bzT+OVoefhpz8+a0WR/+GvdGxkEgtA5SjXzbqCHGMJugg7kP8xoKRJ9M8BfeErQ==
X-Received: by 2002:a05:620a:470a:b0:7e3:4283:e9fe with SMTP id
 af79cd13be357-7e342b8a298mr1347438385a.50.1752856360625; 
 Fri, 18 Jul 2025 09:32:40 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/13] Packet capture using port mirroring
Date: Fri, 18 Jul 2025 09:28:17 -0700
Message-ID: <20250718163236.9870-1-stephen@networkplumber.org>
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

TODO items:
  - need release notes for new features (will wait till 25.11)
  - more through testing on real hardware

v5 - fix build warnings when experimental not enabled.

Stephen Hemminger (13):
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump
  pdump: mark API and application as deprecated

 app/dumpcap/main.c                            | 443 +++++++++++++++---
 app/dumpcap/meson.build                       |   2 +-
 app/pdump/main.c                              |   3 +
 app/pdump/meson.build                         |   1 +
 app/test-pmd/cmdline.c                        |   1 +
 app/test-pmd/cmdline_mirror.c                 | 129 +++++
 app/test-pmd/cmdline_mirror.h                 |  12 +
 app/test-pmd/meson.build                      |   2 +
 app/test/meson.build                          |   7 +-
 app/test/test_ethdev_mirror.c                 | 286 +++++++++++
 app/test/test_mp_secondary.c                  |  51 +-
 config/rte_config.h                           |   1 +
 doc/guides/howto/packet_capture_framework.rst |  15 +-
 doc/guides/nics/bnxt.rst                      |   2 +-
 doc/guides/prog_guide/ethdev/index.rst        |   1 +
 doc/guides/prog_guide/pdump_lib.rst           |   4 +
 doc/guides/rel_notes/deprecation.rst          |   3 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  15 +
 doc/guides/tools/pdump.rst                    |   2 +
 drivers/net/ring/rte_eth_ring.c               |  47 ++
 lib/ethdev/ethdev_driver.c                    |  11 +-
 lib/ethdev/ethdev_driver.h                    |   6 +
 lib/ethdev/ethdev_private.c                   | 142 ++++++
 lib/ethdev/ethdev_private.h                   |  29 ++
 lib/ethdev/ethdev_trace.h                     |  17 +
 lib/ethdev/ethdev_trace_points.c              |   6 +
 lib/ethdev/meson.build                        |   1 +
 lib/ethdev/rte_ethdev.c                       | 101 ++--
 lib/ethdev/rte_ethdev.h                       |  23 +-
 lib/ethdev/rte_ethdev_core.h                  |  12 +-
 lib/ethdev/rte_mirror.c                       | 359 ++++++++++++++
 lib/ethdev/rte_mirror.h                       |  99 ++++
 lib/mbuf/rte_mbuf_dyn.h                       |   9 +
 lib/pcapng/rte_pcapng.c                       | 179 +++----
 lib/pcapng/rte_pcapng.h                       |  27 +-
 lib/pdump/rte_pdump.h                         |  12 +-
 36 files changed, 1843 insertions(+), 217 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

