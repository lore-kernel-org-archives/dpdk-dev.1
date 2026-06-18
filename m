Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E3ECD98F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1A384064F;
	Thu, 18 Jun 2026 17:47:13 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 64E7D4064F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:47:12 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so1522889c88.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781797631;
 x=1782402431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8h3LPe0K2df8E8lEkbRdxEoL9yJkdPBRBh00PKD0C0=;
 b=QxxyNmp3FISNjs/GBCs6UOo5GgaOB2UJgAWwhxbM+SrVBOQHhMy6GmNQVKnC+U61aE
 /lWZViG4rg5jHrA2hXVGtlcNtKi3wF8vi0ViIqWP/lmDiVH9y07y5Xj2h2M3MAuyuqrf
 j5uXAkUUR8WbiFSkgTffbfHBhrL4TycZ3wI3uZQvXv08BQ0nQr6sYF/6WkW7OJsOl2Km
 oRDski7XQgQ67X+pD/X2anJ6LwFB7jEDzYsqxOmsVsgAd+A9/jIo0xk0mZR2csjoRqci
 Bt5mvdNqI6K4j2eQeE3fFQyv6pY8jVUgFYhDw9eF5Yr3/kdtz5gshd4pV7CMfXuGAivB
 ZSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797631; x=1782402431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G8h3LPe0K2df8E8lEkbRdxEoL9yJkdPBRBh00PKD0C0=;
 b=rL+eM7UuTxdIBeBqeRZxWbRHJZPQ+UNiqR1+BbIM7RghkQ3rSaFx2kCHtBLW+IDSQC
 82582se6NWoNF2AUcjyvj4hFDqtYki2emJiOmVlB1SHh/qtlJ5CAZSv9vnWZjAcH8UGg
 WO7MyOo59/sHtqRTRHhmZ6p+H0qfRfiIi0c8pmR07Fle2VaLmOSW42JdJ7rnAoBtCQFF
 ZAEtSYdshF+sdbYpEkHOEnjNpn4Pdj46gHf6KEprZ9nkTlqJdQfk5f60jBOWes9O3rpo
 WXH4rnw7p3bwu7Ngp9AuLCY5uk0h0qRFrfZ4TNR2nUWqmeoDk38wow+XwTJw9CzDYvG7
 ug5g==
X-Gm-Message-State: AOJu0YxVII36Sfoxi0Xi/YnZYBhSCsiOM0kt2inMuufUULsnVWs2jXMQ
 xjWxN9j3TFco42SxUD7M9bpkK0PyzCKAfTejHn9vF5CtPv87xdUMxUUS15rjJltpVJQ=
X-Gm-Gg: AfdE7cmqsmugknE021IfsLSE/Ft92UnP5A9Ou5sdFVkAQYETVKiihJGaIytF5hjcE0+
 7K26Skda78RFkZ0Z4hQmbjOzlQ9Egp4LHbwPB+9bP79RektEhQXN9BC1Jk+ifXOwjNSQWw0wDF+
 553rU15AY7tI06hkrr9mr1n4rSIQjfcIMrEqmMe1CuMQBx4PkkknrNDXT9RvqnPis53Mg1HTEiq
 kw8W1kWLyovovFTGF+Bx/ff/z7Ms9SZ8aXAMFY0r5Tp/RLq6e7Dimk0/Zju2cSLtHXuYGO6wl9N
 TUgBItuOC9LtSPTz8Z0lNynDC0KqMaqmFOktd/ad2+h6f/unFFzRwrV6DN5TxrA7tKjX337uI2h
 9dX/g2zU4hQAT+TMS0nOchR/eIE1on5/BtAcYS3eRMwbsO3ix+lmOCwNyx+cxzXLyXHpjPmhf10
 upodTdJHN4vA4JRgI3tJiD5/pEOKleGBHljz22+mA7I9VeajuN77lZlLtpTEqvGeDf
X-Received: by 2002:a05:7022:6727:b0:12d:de3f:f3e5 with SMTP id
 a92af1059eb24-139a21bacaemr96244c88.37.1781797631130; 
 Thu, 18 Jun 2026 08:47:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0357sm24199005eec.11.2026.06.18.08.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:47:10 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:46:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com, Marek
 Kasiewicz <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v2 0/7] Intel network drivers enhancements
Message-ID: <20260618084648.7c43eb59@phoenix.local>
In-Reply-To: <20260618144442.312844-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
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

On Thu, 18 Jun 2026 10:44:35 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> This series introduces several improvements to Intel iavf and ice
> drivers, including a new ethdev API for header split mbuf callbacks,
> increased ring descriptors, and improved PTP timestamping.
> 
> Marek Kasiewicz (7):
>   ethdev: add header split mbuf callback API
>   net/iavf: increase max ring descriptors to hardware limit
>   net/iavf: allow runtime queue rate limit configuration
>   net/ice/base: reduce default scheduler burst size
>   net/ice: timestamp all received packets when PTP is enabled
>   net/iavf: disable runtime queue setup capability
>   net/intel: support header split mbuf callback
> 
>  drivers/net/intel/common/rx.h         |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c  |  3 --
>  drivers/net/intel/iavf/iavf_rxtx.h    |  2 +-
>  drivers/net/intel/iavf/iavf_tm.c      | 11 ++--
>  drivers/net/intel/ice/base/ice_type.h |  2 +-
>  drivers/net/intel/ice/ice_ethdev.c    |  1 +
>  drivers/net/intel/ice/ice_rxtx.c      | 72 ++++++++++++++++++++++++---
>  drivers/net/intel/ice/ice_rxtx.h      |  2 +
>  lib/ethdev/ethdev_driver.h            | 15 +++++++
>  lib/ethdev/rte_ethdev.c               | 51 ++++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h               |  7 +++
>  11 files changed, 153 insertions(+), 15 deletions(-)
> 

AI review found lots of problems with the implementation as well.

Series composition

This v2 series bundles seven patches under one cover letter, but only
1/7 (ethdev API) and 7/7 (net/intel) implement the header-split mbuf
callback. Patches 2/7 (iavf max ring desc), 3/7 (iavf queue rate
limit), 4/7 (ice base burst size), 5/7 (ice PTP timestamp), and 6/7
(iavf runtime queue setup) are unrelated driver changes. Please split
these into a separate series so each can be reviewed and merged on its
own merits; mixing them obscures the dependency and complicates bisect.


[PATCH v2 1/7] ethdev: add header split mbuf callback API

Warning: struct rte_eth_hdrs_mbuf carries only buf_addr and buf_iova,
no length. The callback therefore cannot tell the PMD how large the
application buffer is. In buffer-split mode the NIC DMAs up to the
queue's configured payload buffer size; if the application buffer is
smaller, the hardware writes past it. Add a length field and have the
PMD (and/or ethdev) validate it against the configured payload size.

Warning: the buffer lifetime and ownership are undocumented. The
Doxygen does not state who owns the buffer after the payload mbuf is
freed, whether the address is consumed as-is or with headroom applied
(the 7/7 implementation adds RTE_PKTMBUF_HEADROOM to the IOVA -- see
below), or that the callback must return a distinct buffer per call.
These are contract details an application cannot guess.

Warning: new experimental API with no testpmd hook and no functional
test in app/test. Both are required for new ethdev API.

Warning: new experimental public API but no release notes entry
(doc/guides/rel_notes/release_26_07.rst). The series touches only the
three code files.

Info: rte_eth_hdrs_set_mbuf_callback() validates port_id and the
hdrs_mbuf_set_cb hook, but passes rx_queue_id to the PMD without
checking it against dev->data->nb_rx_queues. Sibling per-queue ethdev
calls (e.g. rte_eth_rx_queue_setup) validate the queue id at the
ethdev layer. The ICE PMD does check it in 7/7, but validating in the
wrapper would be consistent and would protect future PMDs that forget.


[PATCH v2 7/7] net/intel: support header split mbuf callback

Error: overwriting buf_addr/buf_iova on a pool mbuf corrupts the
payload mempool. At all three sites (ice_alloc_rx_queue_mbufs,
ice_rx_alloc_bufs, ice_recv_pkts) the payload mbuf is allocated from
rxq->rxseg[1].mp and then has its buf_addr/buf_iova rewritten to point
at application memory:

	if (ret >= 0) {
		mbuf_pay->buf_addr = hdrs_mbuf.buf_addr;
		mbuf_pay->buf_iova = hdrs_mbuf.buf_iova;
	}

DPDK never restores buf_addr/buf_iova on free. When these mbufs are
returned to rxseg[1].mp (via rte_pktmbuf_free of the received chain,
or _ice_rx_queue_release_mbufs on queue stop), the pool objects retain
the foreign buffer pointer, and buf_len still describes the original
mempool buffer. The next rte_mbuf_raw_alloc()/raw_alloc_bulk() from
that pool hands back an mbuf pointing at application memory. The
correct mechanism for pointing an mbuf at non-pool memory is
rte_pktmbuf_attach_extbuf() (sets buf_addr/buf_iova/buf_len, the
EXTERNAL flag, and a free callback), or a dedicated external-buffer
mempool. As written the payload pool is progressively poisoned.

Error: the callback's failure return is swallowed. On ret < 0 the code
skips the address update but still programs the descriptor from the
mbuf's current buf_iova:

	rxdp->read.pkt_addr =
		rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb_pay));

Because of the pool corruption above, a recycled mbuf's buf_iova may
point at a buffer the application already reclaimed, so a failed
callback silently arms the NIC to DMA into stale/foreign memory. A
callback failure should abort the refill (or fall back to a known-good
pool buffer), not fall through. Separately, the documented contract is
"0 on success, negative on failure"; the test should be ret == 0, not
ret >= 0.

Warning: RTE_PKTMBUF_HEADROOM is silently applied to the supplied
IOVA. The descriptor is programmed with rte_mbuf_data_iova_default(),
i.e. buf_iova + data_off (128), but the API documents buf_iova as "the
IOVA of the payload buffer". The NIC therefore writes 128 bytes into
the application buffer, and the tail of a buffer sized to the payload
overruns by the headroom. Either document that the headroom offset is
applied, or program pkt_addr from the raw buf_iova for callback-
provided buffers.

