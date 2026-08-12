Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA6C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 23:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD2D84026E;
	Thu, 13 Aug 2026 01:37:29 +0200 (CEST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mails.dpdk.org (Postfix) with ESMTP id 531A140264
 for <dev@dpdk.org>; Thu, 13 Aug 2026 01:37:29 +0200 (CEST)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81e7b95cd84so24638827b3.0
 for <dev@dpdk.org>; Wed, 12 Aug 2026 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786577848; x=1787182648; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=41t0acPxYFMpa5QFWbpwiMCtebZbALEaBaDuNdBqSnY=;
 b=OmU1MLsP5DYaIInpHa3RNrf6znJHPva3fiaop0u0wPGiAKVd32rv5kKooYIVI6c8to
 HIN83MWIEL0nh8dbVgQKKHdgaiL+xywbPeQLiTTnuTRTY5iOUFGAFJfl6o9GT7+MP4jB
 4t0abUbC+a+gLI363xJuTaPvTMc63yWG0U8JvIcMptyBfbfUXsbU9Wrd8rk8TrhGafqy
 0iQiAAf942tSMwQGI+UJvd3CzsNiHCxIb6giJ1c9kmDZMzZiB+777NJ6M62H5+PtKngK
 0/0Mpgbw6mkfy8k3PnEUuzW9opT4mT/yyH/TdfUvbYXGvLozTi3QUG7mfcRxARxYCUfn
 iLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786577848; x=1787182648;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=41t0acPxYFMpa5QFWbpwiMCtebZbALEaBaDuNdBqSnY=;
 b=iXGCk0+N0lWWdbWwEjSQ+BMh5rSc/iI0DuHRX/KH+H5/KupYb8/krP8LEKEWgsv4UX
 /YeEC74nLyLOxaFFTJTRfVCa+oLOv68vyL4QVx/nB1iRcrXZ+qKsN+jiM9Z3IhyNabKQ
 RxqoFs2OXhHgBF9Szypeb+oeDKws/9U/4CXPgp9ZZvV9YkILyYf9X8Y94xIjGf6pUkSN
 VhJSoG7wrxvEy7+sH/8NOnAvK6n5rG6qgjXT1sJg6lMSrbQHeUd1LssfNZKOKkWozx3T
 I9fIVtzGJvFMAlALeg2smb5JQcuubWmzUpKrjn4r/XTasutFy5IB3hYXhndAjEs1DkZi
 ge9w==
X-Gm-Message-State: AOJu0YzCs70qZ7ZmTld/blt3J9y5daxpHkXTeYO3K4EvK12jInG2LKtf
 9VNG59rDgXR4JOYHmWXo5Q4uD/kWts4glsPKDwEwgcCcZDfEsdKb1sl2NTo6iwNEGyxPRKmDKh4
 3MBLA9Txv8ajjUcaB2zgMVXOnEHA5EFAx+XQ/Ra1pK4s8UVhzaJ0sZoVTC2dHqTRDVJs4b/ka80
 IseuAEy52l/3dTgZHY5JUps8I=
X-Received: from yxqu18.prod.google.com ([2002:a53:ea12:0:b0:667:7e4b:4cdd])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:ccc6:0:b0:66b:178c:936
 with SMTP id 956f58d0204a3-66c517febfbmr595563d50.43.1786577848044; Wed, 12
 Aug 2026 16:37:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:36:34 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812233637.1968454-1-blasko@google.com>
Subject: [PATCH v5 0/2] net/af_xdp: add Rx timestamping and read_clock support
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

This patch series introduces support for dynamic RX timestamping and
clock querying in the AF_XDP Poll Mode Driver.

The first patch introduces three new vdev devargs to specify
layout-agnostic metadata offsets and bitmasks for extracting hardware
RX timestamps from XDP metadata into the mbuf dynamic timestamp field.

The second patch implements the read_clock ethdev operation, querying
ethtool for the interface's PTP Hardware Clock index at start and using
clock_gettime to query the NIC hardware clock time.
---
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
- Patch 2:
  - New patch introduced in v2 to support read_clock ethdev operation.
---

Mark Blasko (2):
  net/af_xdp: add af_xdp rx metadata and dynamic timestamping support
  net/af_xdp: add read_clock support to AF_XDP PMD

 doc/guides/nics/af_xdp.rst             |  48 ++++
 doc/guides/nics/features/af_xdp.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   7 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 321 ++++++++++++++++++++++++-
 4 files changed, 372 insertions(+), 5 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

