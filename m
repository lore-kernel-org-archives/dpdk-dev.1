Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A6E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69358402F2;
	Mon,  9 Feb 2026 19:40:51 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id A908F402C6
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:40:50 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48068127f00so354425e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662450;
 x=1771267250; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAyEQY+HuCvoYCCXXDQA5Amb+1BdiImUHOQtaazMmFI=;
 b=zZ1u2T/hiMtBlGFK5lluVTHEPedpAkFOUzYbZ+pbphOn8V/TiOQRH+WeDTTR8qlfIs
 nHppK6pe4C90G6XTlPi6YxNDbCJHnkmOEstf6GVzsBzpr6p4MzmoDXcbcg6jJoJ+6xQy
 VTbm9WVR2RuXDRhZ6JZ8vcuOGdYlxHbHqGl4Q1zjo68Pi3x22weO/FdlsiPI9GXw/de+
 ioOLfmJqSQzmzCyWO2/UTiDQCHyGVQmWMO1iSUrjigSKogRisST4YgoT+ugDCbUMMDqJ
 16SYo3w16Nofz3JInGx6XDVg0YP0TKDhWzyvxfVIx0lSuuoWd1GimNSi18I6KSYFjYXq
 0S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662450; x=1771267250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAyEQY+HuCvoYCCXXDQA5Amb+1BdiImUHOQtaazMmFI=;
 b=MSmeiKWiHL4/ROVaZZydYlBVL+mel5Tc1l7bIEY3irUXxrZSiMHtWL7pA7+o0qjo4l
 YcXYNQKaKM9H7YCstIGTyvqRFbwowkG/1ZldmGXCjNAGQhE96EQYj8ohNtwieTDthQ8S
 AMaBkSCCidpU+2qjt4vdeU0U/nXwDjMArlYl+5//AfTz2ca+FzMYHuv+dydBfb9LVbYA
 oSPaZbPOJOYqIxRlnGuaIJm0gUwR26b3DqNkH9t0rokwx3uX8rN5v+DHI4N/ZkcnPBLI
 ld8Z8WmeLghBj/3wQq7C3QLYrEu5lCxePlJXbEhOVtOnyLtR+7YoALLa3uUGW4Xc9pOm
 O9kQ==
X-Gm-Message-State: AOJu0YzVSwiezpipwD/iuHzgFTmEJNxZEjoEDpQMT7JyadEoDesnUt5B
 dVy2cEWaVf8Ef7rU6Hr9y2Hf/TSBvSS4Iw43AQJpWF/Sr0KykdnCzS2Oa/e7M9fYlvYmpqzrQah
 Lh1gA
X-Gm-Gg: AZuq6aKVwvJz0yZBUVLfbVP8/iMuJUgA+iNlNO2v0PXx7MHVF6znntMA9V4ZbfVt1F1
 pUrV1AmguZgLE4uFfVlZb7XiQmb1/tndFZWw4TAaEPQIda9JzS8Q/2u0qnud3qY41tFK4e50YE1
 boyGMll/8jE0A9v2BcWiE3PPdU1xRM+38wiPv701Y80YwgLqDZJfrXHjqHdoAdkUAmxOzowYI3g
 jtKS6YLLofezUs5QBg9LV/U0D/8Nyu8kmotWPYry7z0Qi8cjmEoT/ck/GM1zRAjWM4pfn8Lm6SC
 QDpDjg6iEBcBDjW0KhbtL0aepdXQ+nTFpcAVPo3Oz56bpFbrCjrNCpmWa4LsUmdfWHHTWfHjRyi
 /Lr7fVRYm+EBhun4Njtba5sFpM80LxwTknBkHUkkJfxsSEgNTAXE01Rlu0y8NYM7q7vwDqVwRt2
 O7mnfvcxVYhWI+BjU3J9th8wwWNL1Nkg2UktHZEKPcUuBHVA9wqb1b4ZpdEVFS
X-Received: by 2002:a05:600c:3552:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-48320339137mr193878925e9.34.1770662449879; 
 Mon, 09 Feb 2026 10:40:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/10] net/rtap: add io_uring based TAP driver
Date: Mon,  9 Feb 2026 10:38:59 -0800
Message-ID: <20260209184045.132774-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20241210212757.83490-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

net_rtap takes the opposite approach — use the kernel efficiently
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

Known working distributions: Debian 12+, Ubuntu 24.04+,
Fedora 37+, SLES 15 SP6+ / openSUSE Tumbleweed.
RHEL 9 is not supported (io_uring is disabled by default).

v5 - revised, renamed and expanded from the v4 ioring PMD
   - more complete testing and dependency handling


Stephen Hemminger (10):
  net/rtap: add driver skeleton and documentation
  net/rtap: add TAP device creation and queue management
  net/rtap: add Rx/Tx with scatter/gather support
  net/rtap: add statistics and device info
  net/rtap: add link and device management operations
  net/rtap: add checksum and TSO offload support
  net/rtap: add link state change interrupt
  net/rtap: add multi-process support
  net/rtap: add Rx interrupt support
  test: add unit tests for rtap PMD

 MAINTAINERS                            |    7 +
 app/test/meson.build                   |    1 +
 app/test/test_pmd_rtap.c               | 2044 ++++++++++++++++++++++++
 doc/guides/nics/features/rtap.ini      |   25 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/nics/rtap.rst               |  101 ++
 doc/guides/rel_notes/release_26_03.rst |    6 +
 drivers/net/meson.build                |    1 +
 drivers/net/rtap/meson.build           |   28 +
 drivers/net/rtap/rtap.h                |  100 ++
 drivers/net/rtap/rtap_ethdev.c         |  908 +++++++++++
 drivers/net/rtap/rtap_intr.c           |  267 ++++
 drivers/net/rtap/rtap_rxtx.c           |  784 +++++++++
 13 files changed, 4273 insertions(+)
 create mode 100644 app/test/test_pmd_rtap.c
 create mode 100644 doc/guides/nics/features/rtap.ini
 create mode 100644 doc/guides/nics/rtap.rst
 create mode 100644 drivers/net/rtap/meson.build
 create mode 100644 drivers/net/rtap/rtap.h
 create mode 100644 drivers/net/rtap/rtap_ethdev.c
 create mode 100644 drivers/net/rtap/rtap_intr.c
 create mode 100644 drivers/net/rtap/rtap_rxtx.c

-- 
2.51.0

