Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EAC55171
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 03:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 982B340276;
	Sat,  1 Aug 2026 05:25:41 +0200 (CEST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mails.dpdk.org (Postfix) with ESMTP id F201440262
 for <dev@dpdk.org>; Sat,  1 Aug 2026 05:25:40 +0200 (CEST)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e71268bf6so53312197b3.0
 for <dev@dpdk.org>; Fri, 31 Jul 2026 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785554740; x=1786159540; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jmT0uNGgHo6QdqyYVbG7R1vItUS6Y55iE7Bq9u54LF8=;
 b=bxPiTHAW7mvMuOuQ0wS0zj8ICxAosw11aN5ZagQtl+JnjssecIUqDV/6RpTLj3lXy/
 Xy9vyLE01ihwU46yM1KINtdJcOo9O/30jP66sr1Dy0131/IelxWy/6emEuSylC/utPBa
 pcCmAy4qqoNz3hzcdzMFw9/kOmWLNhGaj4geOTu01y/gWQ62fGrvmYYQuBZgK2g5kW1i
 niWgF2zb7vNq6iMDHIP5pl5fvjcwkgEQFAwS7ncrJtqRcVvsOgRwj9vOdFOJWk6AbzLX
 Yzu31BX6d9K4Y8g9EvYXTysf9BAdDQFBdh7Lq5DOFgxNFxD4yUL0HinJAh8sBm50VrLJ
 Y15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785554740; x=1786159540;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmT0uNGgHo6QdqyYVbG7R1vItUS6Y55iE7Bq9u54LF8=;
 b=HGc7XmwVX7dDQfFHYScLFCpAD6CtXzIVUVj6p+/UowtmBqHTSCZbJfFvRMYuKm3i6+
 tmPkzC+XnGfRqPlPzyNk5GiycgO0yK5k4s6mWcGSMv0M8WIPwUBh7aLjuIGpYvmH6NgK
 zOOfyNOeiDOryr5FYkcvDUqwnq38SK5UJ3c/Cgp+dfSz2EWz1UiyBScXSwANJVgyS1p2
 szVbxRYvvHIMAkyZaE3cw4guw1xXif+uwFXMQ5RMY6lDuShuGAlUOf8sfYHaoXm91T9D
 CfQzwrOut09Jt9yhu5pqd4voDpUYzcaX+gShL1VAg9gPNkVIXha7zjJqlnBoaYjyQWts
 9fmw==
X-Gm-Message-State: AOJu0YxyV8Yq/dWaZ3NpA12MQRSob+8GmOp+iuQZZZ5weUhQoFBmwlXI
 +Rb7jfLDg44Qo0FZkBFLlltx5oqO4djt+pLiQd24XcDuUs1QhQoCoNIAjB0RTUHx172cNs4tQAP
 u1BJGjy9bH7B5pkmuuqZJGrhr+QbQIyUVGa5daVjXCu+jhwjFVcPeiGNkjZzweEnTRWrHu8hGaf
 rOBsRmx/nGKwYtcLugMaMIOgY=
X-Received: from ywg26.prod.google.com ([2002:a05:690c:a0da:b0:81e:aeb9:19ce])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9981:b0:81d:9452:715c
 with SMTP id 00721157ae682-81fd4b494f5mr32520257b3.20.1785554739883; Fri, 31
 Jul 2026 20:25:39 -0700 (PDT)
Date: Sat,  1 Aug 2026 03:25:31 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260801032534.2865192-1-blasko@google.com>
Subject: [PATCH v4 0/2] net/af_xdp: add Rx timestamping and read_clock support
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

 doc/guides/nics/af_xdp.rst             |  46 ++++
 doc/guides/nics/features/af_xdp.ini    |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 322 ++++++++++++++++++++++++-
 4 files changed, 371 insertions(+), 5 deletions(-)

-- 
2.55.0.508.g3f0d502094-goog

