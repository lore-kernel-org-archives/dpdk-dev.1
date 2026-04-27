Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC4FF8864
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 23:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BD3740285;
	Tue, 28 Apr 2026 01:42:37 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 8FA6940269
 for <dev@dpdk.org>; Tue, 28 Apr 2026 01:42:35 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so603897eec.1
 for <dev@dpdk.org>; Mon, 27 Apr 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777333354;
 x=1777938154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDW3Spwk7Ioq5LDAZTMSmMbxhY524j7I9dACwEU/YAQ=;
 b=gV0PLFraai0lb4TZGScXkWWhkiOjH8Omd19aEHdVQAcsxHXNdxCzxK2jQrF+Zy5Oy9
 33Q3AgJtkGfv/s1gs7eheX+C6V1Ivn58ZafMjJX+7ffqmv+WlUNPxJg9ldvKKyqIn/c5
 wRE9laP4r7C80a+MCLSinWcwOqynHwgFfZIYnwSNfm0BrhzHfy+UPM2Z7Gz/Y59LTuYT
 6vgVjUgw2m6L/8uv+Hu66zYr1xE2i0YDFHhFhrhBohSxl6TpQQQb9hnWNyiEQ8Xr961Z
 4er7J1bbCCyLmITCSxJXZyTB49gXYeA5N6czvuHzJw8meJwsPNguXkSmGmYbYIrCl3OK
 TD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777333354; x=1777938154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDW3Spwk7Ioq5LDAZTMSmMbxhY524j7I9dACwEU/YAQ=;
 b=DiQon/TqNOtnYJN6ZmWqf+O8XEg+wI1CxB+LfQpbnY3MTOpwjh3KAoc/Pfj0suwNi/
 ucuOzf4iCWM2MHMyDLAHR+AAaOcYb2cuaOZxjklHDY8bKOZEjqaLMugK6ckNGhz0GN1U
 zvPqG55bh9PvGS+AHyiEhBhFjPDy8y1iGH8GvE0Pm/IKb0qP/TnJ7s+Gizind7/KmM5g
 9viF7cZPy7ujSl6C5umGBWGoYFRdTk/XWgKUZR6RpEKjaU69ytS+8xVDIvDxcORviDzv
 hR4pef2YqArHH7bxlozYNRVwHP08yu93ykR9RflgMRSx/on5kOmy027KRoqbcvDT4rgj
 mkuA==
X-Gm-Message-State: AOJu0YyFkozyNh8RCSIe4XOManyT8I0m1p/fF06B2WYu6jccdhYN2NFF
 jBdkMRc9wfy3Q+faL9qP1U782kA6JxoEU2UbOBLlgW6/MuGqJoOJEY79D0ZmWW6/jnI=
X-Gm-Gg: AeBDies8gnVAWpO2oexxWK/ullsrG8mcoE2afsoHEfP3Ss7EvNr3/BnyS2ABfA/IPID
 +MQSy2fGtjGZJ8CVOrkqvH8O1p3UmuXJaNLF8HMjhw/eLVYk3UUnuqE8aF30FTfcCJPWqXigSNb
 6rsXrHnmks8x9FSBM/frH/vDnXguihd4eWtIjIF4KFkTJjasc67IFUfWxC92J3I9y6EEJR/hbtQ
 ZCTH6kJ3otsKlkzmt/elYyGq7XkJ1dDME5yKsLeUPwgLeYcXoiK/ynD26Vx3ke9mn9pKFExv1Tc
 a2WlngzOHamf/Vq2rCtPG1g/VeVk9LGc3mmwf5wtlvh33PJ+v/ay1ivXXNVRW4+oneTgXXcagHN
 +Ys/HWHe0GYN2LCEkOl3eE3+bVygdX1kDN29EdKL+11bVEPAC7CBn8+9+qWlq0w4jexEQsle7rv
 /gskCrRX8eeScFxUoJtcSimzJTTbQx0eU6U2UMChcAZPtrbQ==
X-Received: by 2002:a05:7300:4351:b0:2d8:1efe:51dc with SMTP id
 5a478bee46e88-2ed09fb0ca4mr529007eec.6.1777333354154; 
 Mon, 27 Apr 2026 16:42:34 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed0a106524sm863908eec.23.2026.04.27.16.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 16:42:33 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:42:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [RFC v1 0/4] introduce PTP protocol library and software relay
 example
Message-ID: <20260427164230.6e015396@phoenix.local>
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 28 Apr 2026 06:31:02 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> This series introduces a new DPDK library (lib/ptp) for IEEE 1588-2019
> PTP protocol packet processing and a companion example application
> (ptp_tap_relay_sw) that demonstrates its usage.
> 
> Motivation
> ----------
> Several DPDK applications need to classify and manipulate PTP packets
> (e.g. ptpclient, ptp_tap_relay, custom Transparent Clocks). Today each
> application re-implements its own PTP header parsing and correctionField
> handling. A shared library avoids duplication and provides a tested,
> standards-compliant foundation.
> 
> Library: lib/ptp
> ----------------
> The library provides:
>   - PTP header structures (IEEE 1588-2019 common header, timestamp,
>     port identity)
>   - Packet classification: rte_ptp_classify() detects PTP over L2
>     (EtherType 0x88F7), VLAN-tagged L2, and UDP/IPv4 (ports 319/320)
>   - Header access: rte_ptp_hdr_get() returns a pointer to the PTP
>     header inside an mbuf
>   - Inline helpers: correctionField manipulation (48.16 fixed-point),
>     message type extraction, two-step flag check, timestamp conversion
>   - Debug: rte_ptp_msg_type_str() for human-readable message names

The things I noticed were:
Do not use older PTP terminology master/slave; we fixed this in DPDK.
This would cause a NAK for me, and checkpatch would flag it.

AI had lots more to say...

Subject: Re: [RFC v1 0/4] introduce PTP protocol library and software relay example

Some review comments on this RFC.  Overall direction (shared PTP
header+classification library) is good, but there are a couple of
correctness bugs in patch 1/4 that need to be fixed before this can
move out of RFC.

Patch 1/4: ptp: introduce PTP protocol library
==============================================

Error: flag bit positions wrong for the host-order representation
-----------------------------------------------------------------

  +#define RTE_PTP_FLAG_TWO_STEP    (1 << 1)  /**< Two-step flag (bit 1) */
  +#define RTE_PTP_FLAG_UNICAST     (1 << 2)  /**< Unicast flag */
  +#define RTE_PTP_FLAG_LI_61       (1 << 0)  /**< Leap indicator 61 */
  +#define RTE_PTP_FLAG_LI_59       (1 << 1)  /**< Leap indicator 59 (byte 1) */

  +static inline bool
  +rte_ptp_is_two_step(const struct rte_ptp_hdr *hdr)
  +{
  +     return (rte_be_to_cpu_16(hdr->flags) & RTE_PTP_FLAG_TWO_STEP) != 0;
  +}

twoStepFlag and unicastFlag live in byte 0 of the wire flag field
(IEEE 1588-2019 Table 37). leap61/leap59 live in byte 1. After
rte_be_to_cpu_16(), byte 0 of the wire ends up in the upper 8 bits of
the host value, so:

   TWO_STEP needs to be (1 << 9), not (1 << 1)
   UNICAST  needs to be (1 << 10), not (1 << 2)
   LI_61    stays at    (1 << 0)
   LI_59    stays at    (1 << 1)

As written, rte_ptp_is_two_step() always returns false for any real
two-step Sync from the wire, which silently breaks any Transparent
Clock or Boundary Clock built on this library.  TWO_STEP and LI_59
also collide on (1 << 1), which by itself shows the macro layout
isn't right.

Worth adding a unit test that constructs a packet with twoStepFlag
set and checks that the helper returns true.

Error: QinQ classification path is unreachable for standard QinQ
----------------------------------------------------------------

In ptp_hdr_find(), the VLAN block is only entered when the outer
EtherType is RTE_ETHER_TYPE_VLAN (0x8100):

  +     if (ether_type == RTE_ETHER_TYPE_VLAN) {
  ...
  +             /* Double-tagged VLAN (QinQ) */
  +             if (ether_type == RTE_ETHER_TYPE_QINQ ||
  +                 ether_type == RTE_ETHER_TYPE_VLAN) {

Standard 802.1ad QinQ uses outer S-tag 0x88A8 (RTE_ETHER_TYPE_QINQ)
followed by a C-tag 0x8100, then the payload EtherType.  Packets with
the typical S-tag outer never enter the VLAN branch at all, so the
"QinQ supported" claim in the cover letter and the prog_guide does
not match what the code does.

Either accept 0x88A8 as an entry point to the VLAN parser, or drop
the QinQ claim from the documentation.

Warning: VLAN-tagged PTP-over-UDP not handled
---------------------------------------------

The classifier handles plain L2, VLAN-L2, IPv4-UDP, and IPv6-UDP, but
there is no path for VLAN -> IPv4/IPv6 -> UDP -> PTP.  This is a
common deployment pattern.  Not fatal, but please mention it in the
limitations list if it's intentional.

Warning: signed left shift in rte_ptp_add_correction()
------------------------------------------------------

  +     int64_t cf = (int64_t)rte_be_to_cpu_64(hdr->correction);
  +     cf += (residence_ns << 16);

residence_ns is int64_t.  Left-shift of a signed value where the
shifted value is not representable in the result type is undefined
behaviour (C11 6.5.7p4).  In the relay example residence_ns is
computed from (uint64_t)tx_ts - (uint64_t)rx_ts cast to int64_t, so
clock noise or a tx_ts < rx_ts edge case turns this negative.  GCC
and clang happen to produce arithmetic shift, but please make it
well-defined:

   cf += (int64_t)((uint64_t)residence_ns << 16);

or just multiply by (1LL << 16).

Same issue, lower severity, in rte_ptp_correction_ns():

  +     return (int64_t)rte_be_to_cpu_64(hdr->correction) >> 16;

Right-shift of a negative signed value is implementation-defined
(not UB), but a divide expresses intent more clearly.

Info: include order
-------------------

  +#include "rte_ptp.h"
  +
  +#include <eal_export.h>

eal_export.h is conventionally included with the other system /
EAL headers, before the local rte_ptp.h.

Info: overlap with examples/ptpclient
-------------------------------------

ptpclient.c defines its own struct ptp_header / ptp_message.  Since
this series adds a shared library, it would be worth converting
ptpclient as part of the series (or in a follow-up) to avoid
duplicating the same definitions in-tree.


Patch 2/4: doc: add PTP library programmer's guide
==================================================

Just the QinQ wording carryover - prog_guide claims "Double VLAN
(QinQ) + EtherType 0x88F7" but the code as posted only handles
0x8100/0x8100 nesting.  Update either the code or the doc to match.


Patch 3/4: examples/ptp_tap_relay_sw
====================================

Warning: promiscuous enable failure on PHY port is not fatal
------------------------------------------------------------

  +     ret = rte_eth_promiscuous_enable(port);
  +     if (ret != 0)
  +             LOG_ERR("Failed to enable promiscuous on port %u", port);
  +
  +     return 0;

For the PHY port this is what lets the relay see the PTP multicast
group (01:1B:19:00:00:00 / 01:80:C2:00:00:0E).  If it fails, the
relay starts up looking healthy but never receives anything.  At
least exit on failure for the PHY port, or enable allmulticast
explicitly so the failure mode is visible.

Info: per-burst single timestamp
--------------------------------

A single rx_ts and tx_ts is taken for the whole burst.  At
logSyncInterval=-4 (16 packets/sec) bursts are essentially always 1
packet so this doesn't matter, but at higher rates the early
packets in a burst get under-corrected and the late ones
over-corrected by up to a burst's worth of poll latency.  Worth
calling out in the comment block; the test results already imply
single-packet bursts.

Info: missing release notes for new library
-------------------------------------------

Targeted at 26.07 per RTE_EXPORT_EXPERIMENTAL_SYMBOL.  A new library
should add an entry under "New Features" in
doc/guides/rel_notes/release_26_07.rst.
