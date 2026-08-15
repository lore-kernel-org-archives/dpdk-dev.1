Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A24C5B572
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 00:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4050C4026C;
	Sat, 15 Aug 2026 02:46:05 +0200 (CEST)
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by mails.dpdk.org (Postfix) with ESMTP id 72B1240264
 for <dev@dpdk.org>; Sat, 15 Aug 2026 02:46:03 +0200 (CEST)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66bd78339a5so4829033d50.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786754763; x=1787359563; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+md/dUccBcOoOf/WDR8EcAHaQaZX1aDPzOtpQc3XL6k=;
 b=qTu4psp3rlqTcP3ZXbc5yl18op6QvvmWjBgdyNBHuu6enTI/gqddVZNqNNLB+a+XWf
 +U5Eu8A3qHfrjTk1NJaAqgTJ6MbQXnUaKCSJtun+AVIUjLpKBw85/kewFBP9fZ5sWXmy
 biUXuo5Gg+nuZVRQyle3bUtSiyZLvyZMZ9RdESw2SibMp8D8jgK7fcgSaXvP/TH9pvgl
 BzwUr6CT4zqkYFFyVgbI5q0s50Bu+lHRh9chMfCfYvCyO0FxF2yN9V5jfgFNG/F08EO5
 zvHXIHFWIo/YWNuumk/Qnw8TKGf6DzTkfJ9iBUffOHLj76mfQkcHsf3kE34mSq4bqGYK
 sOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786754763; x=1787359563;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+md/dUccBcOoOf/WDR8EcAHaQaZX1aDPzOtpQc3XL6k=;
 b=IKGVJljimCM+/4giS1nfuPcM43ePq0QYTwkxXY8S5IYo+7GiGpIY5lUre+a+2sUpTc
 JJSNkpm3PyVGPv2IIH5B9dUGqcVMQMi7Qe95xIwO3kM3G531NrHX2I+NER1xAfZFsjhc
 8MMnPISbmigNuOVSjEQ043a/Oi6OOWffrpTwkJaGLTFUvbTgDqsLUw35u3lWGXDX/ezZ
 v6hnWb0IansLT09bRQA7N1XWQeUGtsCQxqXxpU5RoemAtEWhU0ogaxZGfS7VVgJcY0ei
 B05oH/W8gHRkOZpzAKL+9W5jzQe4bUxCyEhn+wQO/jxmrAKPODgBM+MFScKYHnyF6YvG
 +Yig==
X-Gm-Message-State: AOJu0YyDHnQ7jNHebnKd8jMr5pZxesFia8LzDdwIFSJNjAqRn3QGFFQ/
 5FfUEjcvf7tyjghqVS7DOx0hhIe9HwanJwO1rGffzNyd1MytGYAkFH3PaMm4FJfBbIlIa8P4zg5
 AJ0zz5H10QmO1kwuguzhUVAjn2qUMSZV3eZDfFc/mh/EsbkKjCCeEDLRqMT68kQlTzlw3xCuo01
 7yGjbo53cF0+1euDgqYuEBasc=
X-Received: from yxrw5.prod.google.com ([2002:a53:b5c5:0:b0:667:d754:d5e])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:2206:b0:668:96a9:e54
 with SMTP id 956f58d0204a3-66c72be646cmr2936632d50.23.1786754762318; Fri, 14
 Aug 2026 17:46:02 -0700 (PDT)
Date: Sat, 15 Aug 2026 00:45:50 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815004553.3479994-1-blasko@google.com>
Subject: [PATCH v6 0/2] net/af_xdp: add Rx timestamping and read_clock support
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, mtahhan@redhat.com, joshwash@google.com, 
 jtranoleary@google.com, blasko@google.com
Content-Type: text/plain; charset="UTF-8"
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

This patch series introduces support for dynamic Rx timestamping and
clock querying in the AF_XDP Poll Mode Driver.

The first patch introduces three new vdev devargs to specify
layout-agnostic metadata offsets and bitmasks for extracting hardware
Rx timestamps from XDP metadata into the mbuf dynamic timestamp field.

The second patch implements the read_clock ethdev operation, querying
ethtool for the interface's PTP Hardware Clock index at start and using
clock_gettime to query the NIC hardware clock time.
---
v6:
- Patch 1:
  - Add per-queue Rx timestamp offload support.
  - Refine SIOCGHWTSTAMP filter check and preserve flags.
  - Fix feature matrix ordering in af_xdp.ini.
  - Add conversion and overlap validation for devargs.
  - Unify timestamp extraction for ZC and CP paths.
  - Update documentation formatting, bounds, and casing.
- Patch 2:
  - Fix ptp_fd cleanup path in eth_dev_close().
  - Lower PTP open failure log level to INFO.
v5:
- Patch 1:
  - Fix rx_timestamp_enabled check in eth_rx_queue_setup().
  - Update af_xdp.rst documentation and code example.
  - Update release notes for 26.11.
- Patch 2:
  - Update release notes for 26.11.
v4:
- Patch 1:
  - Validate rx_timestamp_offset (8 <= offset <= 256) and valid_hint_offset
    (1 <= offset <= 256) bounds.
  - Revert parse_integer_arg() to base 10 and add dedicated parse_hex_arg()
    for validity mask.
  - Optimize fast-path check and use rte_pktmbuf_mtod_offset() macro.
  - Preserve config.tx_type in SIOCSHWTSTAMP instead of forcing
    HWTSTAMP_TX_OFF.
  - Return -errno on socket failure and replace (caddr_t) cast with
    (void *).
  - Advertise RTE_ETH_RX_OFFLOAD_TIMESTAMP conditionally when
    rx_timestamp_offset >= 0.
  - Update af_xdp.ini features matrix with Timestamp offload = Y.
  - Document CAP_NET_ADMIN requirement and persistent HW filter side
    effect in af_xdp.rst.
- Patch 2:
  - Move ptp_fd into pmd_process_private for multi-process safety.
  - Decouple /dev/ptpX opening from RTE_ETH_RX_OFFLOAD_TIMESTAMP.
  - Move read_clock documentation out of "Options" into its own section
    in af_xdp.rst.
  - Add #ifndef guards around CLOCKFD and FD_TO_CLOCKID macro definitions.
  - Replace (caddr_t) cast with (void *).
v3:
- Patch 1:
  - Add PMD documentation and release notes entry.
  - Move dynamic mbuf timestamp field registration to eth_dev_start().
  - Replace 64-bit pointer casting with memcpy.
  - Add devargs validation and support auto-base integer parsing.
- Patch 2:
  - Add documentation and release notes entry.
  - Add PTP file descriptor cleanup on device start, stop, and close.
  - Return -errno on clock_gettime() failure and fix PTP open error logging.
v2:
- Patch 1:
  - Replace static metadata struct assumption with configurable vdev devargs
    for layout-agnostic timestamp offset extraction and validity verification.

Mark Blasko (2):
  net/af_xdp: add af_xdp rx metadata and dynamic timestamping support
  net/af_xdp: add read_clock support to AF_XDP PMD

 doc/guides/nics/af_xdp.rst             |  51 ++++
 doc/guides/nics/features/af_xdp.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   7 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 340 ++++++++++++++++++++++++-
 4 files changed, 390 insertions(+), 9 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

