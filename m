Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C09FEF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D621140289;
	Sun, 15 Feb 2026 00:47:33 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id C135040274
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:32 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48378136adcso8753545e9.1
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112852;
 x=1771717652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kziOZBWeGTBHFJWoQGBVxVswWohQssfqimOcTrMKqP0=;
 b=SmINavwDZIWqaGlinhH1Jjy9WCLChQBsFHK+IfXjHL4odImhu9jxsysdEJ0c1P4Tub
 qUBDzlyxnNqDGeZ0pTygixHIam59ZwiOMeKf+f7ChKFiH3xX1F9WOX0a0wm5cMRt9HH6
 MMApO9rZHPxnmKNrdXdF1b/gniOrGtl9wKuHW2kI/g+JWySTJSTFZlfpw03dRY2O/Wpn
 ICGUKWK5LRfs7NZ8CFDyoX8AM200qhzmBY1jp/kY/cCkE/i1fu5K+PFH9D5luMHZAJ/y
 mEB1uRjAz4yadqNzvTwthcsqim+R1lPRnEjGWvJcKzDRBX/s8Q1QT7VS0FuCJH8hQ731
 +7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112852; x=1771717652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kziOZBWeGTBHFJWoQGBVxVswWohQssfqimOcTrMKqP0=;
 b=qVcp+ilFEXgSAsbcpfti9JwjSiRp2/BlmDPRcjJ/LLj5ttG1y/Deets6Zfu1B/goCL
 tB9ufjuR1xULoo3VrDRDdAmX9GndXK8JFLIzFNksI9cl+Grhu9Ycp7QjatqOgYQbYhkl
 hUgQK8yZCYu+OltaAtz0tULE2/zPk9S5ho/wqjlNh3LMJDCCud92WILG0rX5Lji0xtg5
 fdtPGnOaogUZgCSl9+xpQBVBPJeAyoTbZ1Slea1W/E8GaAlVnfK+idveSuGPqWMw9cPT
 H3lyflSdCWArBUnkHAkMZ68D9YGp4Wqde5OHDtM9Y2hKAp9i3S8NPC6NoO+GO+M207br
 OwLA==
X-Gm-Message-State: AOJu0YwJ7CwYq2PvJYHBzVOcT0MloQwWlSRhMDi/y7OHoXBnhpBBoAIY
 V/+ieF8bP7NPgRAuNGxa8bvrend3RU5MKs7sBZ5Uy7mA6lPTs/qgBs9gm//iDQTwJ719DX2Q3sg
 ti14Y
X-Gm-Gg: AZuq6aKwf8ztXMndvI4sS9Dm/94ZxrNTmqfAND8HMhm9POEp5pR2jUV+dcka5ED8B4t
 EEfioNu9x8JMt2nqVnbZl8HrCNY++1I+GKlr2jUAyABWiVuQRd6a3MuvWjVYPfVQTLuhAQwxv/o
 bwWKo9rqik5m37/pYmmK0Kt7QWQVO93kYPYEgytp221u+/F+P5AFOJ1dr90jHijewnOBZ1ndKVt
 W/9FVu7dNog8M1xXhfSjsSY2x0xP5k9VwSN5UzW3GOT3iGhj5TgfQhkc+MHuKD9bnOrvqlCwDyh
 M14+NyqbAXv6I9vJf8Q2Rd0OEedEr9ttoL6jJBwLM0w1BXlIncPsN/nGLRyV+eTHTGzGu9O5HYP
 a+jlWr0yUUtCV0ck/fj5VkESWXkf6CiRMT2RZ9zSdoZ8cuSbPwEXgmEUAeoAeG9re0XW6/tuO/+
 LAJvKglHVzldv408T368dUhmOipCyr0jK3hPiSQb0Tq/rahtD/aMzSInibWPZ8Xuhh
X-Received: by 2002:a05:600c:8209:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-48379c1f524mr59678305e9.27.1771112851567; 
 Sat, 14 Feb 2026 15:47:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/11] net/rtap: add io_uring based TAP driver
Date: Sat, 14 Feb 2026 15:44:09 -0800
Message-ID: <20260214234726.188947-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20241210212757.83490-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
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

This series adds net_rtap, an experimental poll mode driver that uses
Linux io_uring for asynchronous packet I/O with kernel TAP interfaces.

Like net_tap, net_rtap creates a kernel network interface visible to
standard tools (ip, ethtool) and the Linux TCP/IP stack.  From DPDK
it is an ordinary ethdev.

Motivation
----------

This driver started as an experiment to determine whether Linux
io_uring could deliver better packet I/O performance than the
traditional read()/write() system calls used by net_tap.  By posting
batches of I/O requests asynchronously, io_uring amortizes system
call overhead across multiple packets.

The project also served as a testbed for using AI tooling to help
build a comprehensive test suite, refactor code, and improve
documentation.  The result is intended as an example for other PMD
authors: the driver has thorough unit tests covering data path,
offloads, multi-queue, fd lifecycle, and more, along with detailed
code comments explaining design choices.

Why not extend net_tap?
-----------------------

The existing net_tap driver was designed to provide feature parity
with mlx5 when used behind the failsafe PMD.  That goal led to
significant complexity: rte_flow support emulated via eBPF programs,
software GSO implementation, and other features that duplicate in
user space what the kernel already does.

net_rtap takes the opposite approach -- use the kernel efficiently
and let it do what it does well.  There is no rte_flow support;
receive queue selection is left to the kernel's native RSS/steering.
There is no software GSO; the driver passes segmentation requests
to the kernel via the virtio-net header and lets the kernel handle
it.  The result is a much simpler driver that is easier to maintain
and reason about.

Given these fundamentally different design goals, a clean
implementation was more practical than refactoring net_tap.

Acknowledgement
---------------

Parts of the test suite, code review, and refactoring were done
with the assistance of Anthropic Claude (AI).  All generated code
was reviewed and tested by the author.

Requirements:
  - Kernel headers with IORING_ASYNC_CANCEL_ALL (upstream since 5.19)
  - liburing >= 2.0

Should work on distributions: Debian 12+, Ubuntu 24.04+,
Fedora 37+, SLES 15 SP6+ / openSUSE Tumbleweed.
RHEL 9 is not supported (io_uring is disabled by default).

v6:
  - fix lots of bugs found doing automated review
  - convert to use ifindex and netlink to avoid rename issues
  - implement xstats

Stephen Hemminger (11):
  net/rtap: add driver skeleton and documentation
  net/rtap: add TAP device creation and queue management
  net/rtap: add Rx/Tx with scatter/gather support
  net/rtap: add statistics and device info
  net/rtap: add link and device management operations
  net/rtap: add checksum and TSO offload support
  net/rtap: add multi-process support
  net/rtap: add link state change interrupt
  net/rtap: add Rx interrupt support
  net/rtap: add extended statistics support
  test: add unit tests for rtap PMD

 MAINTAINERS                            |    7 +
 app/test/meson.build                   |    1 +
 app/test/test_pmd_rtap.c               | 2620 ++++++++++++++++++++++++
 doc/guides/nics/features/rtap.ini      |   26 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/nics/rtap.rst               |  101 +
 doc/guides/rel_notes/release_26_03.rst |    7 +
 drivers/net/meson.build                |    1 +
 drivers/net/rtap/meson.build           |   30 +
 drivers/net/rtap/rtap.h                |  152 ++
 drivers/net/rtap/rtap_ethdev.c         |  864 ++++++++
 drivers/net/rtap/rtap_intr.c           |  207 ++
 drivers/net/rtap/rtap_netlink.c        |  445 ++++
 drivers/net/rtap/rtap_rxtx.c           |  803 ++++++++
 drivers/net/rtap/rtap_xstats.c         |  293 +++
 15 files changed, 5558 insertions(+)
 create mode 100644 app/test/test_pmd_rtap.c
 create mode 100644 doc/guides/nics/features/rtap.ini
 create mode 100644 doc/guides/nics/rtap.rst
 create mode 100644 drivers/net/rtap/meson.build
 create mode 100644 drivers/net/rtap/rtap.h
 create mode 100644 drivers/net/rtap/rtap_ethdev.c
 create mode 100644 drivers/net/rtap/rtap_intr.c
 create mode 100644 drivers/net/rtap/rtap_netlink.c
 create mode 100644 drivers/net/rtap/rtap_rxtx.c
 create mode 100644 drivers/net/rtap/rtap_xstats.c

-- 
2.51.0

