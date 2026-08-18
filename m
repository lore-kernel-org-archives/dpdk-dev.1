Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C90C5DF67
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 06:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C229C402BD;
	Tue, 18 Aug 2026 08:50:07 +0200 (CEST)
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by mails.dpdk.org (Postfix) with ESMTP id 497D94028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 08:50:06 +0200 (CEST)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66ac1d28eb7so13640481d50.3
 for <dev@dpdk.org>; Mon, 17 Aug 2026 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787035805; x=1787640605; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HkD0+/dS9zd4rSpnW9DMeLMi7AZwAzoqfIV6Lwr1unE=;
 b=MgUBRjso0rWdC9pzLK0fgCsKWxPc5vowqbgxlY9IsYkys8i7yCfSkUXleDGv6OwKXF
 esSx8Ir3yugFluJJlGGr37tsf8fPf9aTR3iOfN8LSI7JzBkRSFfG8BRLmp3DpRpJRqBX
 f8uXT3l3OLIgJ2c3dq/bYEDeUyrI9yRNGPD2hbqQGXKqRF0DkOzZO2x66MjFG4yPahmr
 qA/VysIQG84H99mbPguaN9KZmYmYjW4FkIdr8vFdMQXy+eqrmVsfOPUcFXzw1YIyUOVV
 at8xC5zmT5Fb79JZX9uxXn9GZv80I0aayuWHuw4i0C/MX/niIgqWDMN675W9R4SKzydM
 Lgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787035805; x=1787640605;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HkD0+/dS9zd4rSpnW9DMeLMi7AZwAzoqfIV6Lwr1unE=;
 b=Wq76gCOHOxFgQSfYUu8eUX7xvX51WvDKYRWG28ibXdD/6rbXfDQ8SCSmgEzibc1RUy
 ZKgPNGU4I5TVLfHY7Zv9O6r4qDGX4wDnzecGU3r90t403ucA+WheXSqytkPlhoSWijSW
 VIme+zvzvWBQqFwGj9qrtnRxNRT1p+q53ZJI3wR9M1WNV8QcAtyiQ8Wh6o4HQpL+JlWx
 d4bZ1f15A8vSam1qQqHvyC0L603AwBI4VA7nLZocoZdm52/36MgVHB8haf5+Y3giOV0n
 JsnMbU39ieWhP1HUoUrX3U71C090PJK3QU35ikD/ZS6KsmffZ/7MjHaTy8APp7LaCONc
 UVnQ==
X-Gm-Message-State: AOJu0YwM5SA3YzgzlNniiWNNoe3ZUQNjd+rd04rTG64Cq1U791SC+a2n
 VSEkBSRIe3qm3VTGfXz6MptDKj+2uYHduF1yi2HJr2YZ2za9HRwpUUV6CaRha9IoLKx9PmI05fm
 4XYxqU+WZqbjwPaslkMZJBmOtdJArPtrZhSIM7d2ycbD4DdzqwigI2LysCXiDmxcKfuvcbiDCW3
 xISexrGloFS/WHR15ezsLTwto=
X-Received: from yxxn13.prod.google.com ([2002:a53:490d:0:b0:65e:25b3:b508])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:78c:b0:66a:d2cf:1b8e
 with SMTP id 956f58d0204a3-66cb9d6f5b1mr1775688d50.20.1787035804971; Mon, 17
 Aug 2026 23:50:04 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:49:57 +0000
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260818065000.1597610-1-blasko@google.com>
Subject: [PATCH v7 0/2] net/af_xdp: add Rx timestamping and read_clock support
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
v7:
- Patch 1:
  - Fail immediately if SIOCGHWTSTAMP ioctl fails to ensure SIOCSHWTSTAMP
    is only issued with an existing configuration read back from kernel.
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
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 344 ++++++++++++++++++++++++-
 4 files changed, 394 insertions(+), 9 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

