Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED51CD98F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07AF54027F;
	Thu, 18 Jun 2026 17:47:11 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 6ED2D40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:47:09 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30c001b21feso426640eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781797628;
 x=1782402428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfSMT4NfLKw8qam3hITdc/XUyHPQuomEg6R3kAgp7jo=;
 b=vVbm+FJqLUpW9+gMNSIbBJ34Fr+kA8mZcGMSdjfV5m0h4K1fCF93MXo3C6zimdaFGW
 wfAj+zE+7k2P9YjKYhGQYToMEToE4uIT4FPwqduGSOyfilgh7yFcPB9nCOzb6ZwraUDV
 kZheD1iVn2hoG2D2OXgZBGQP5roAKNi3bdBQ/qS5e7pj0Tn3nDGQMWvct+f7H6WeNorU
 XqCoYZ51BZ8quCI0cbLiJqhtAgNFXujjTq/4f8wtdwygwH+cEo07iRLydsdoJtuNyfhK
 yBWIYzNtzbgl+eZ/w8iWvZRxswrXqsj4aw87WDPy798NzFh73H6sNZ8mxorQ06aj6TWH
 mkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797628; x=1782402428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JfSMT4NfLKw8qam3hITdc/XUyHPQuomEg6R3kAgp7jo=;
 b=s2VLDVK/YKhGOl7P413W3Nhsj7uBtyrJHLNUPP0OsYXCGpstuu4DVKQIIW0fCQb72h
 bRTgU3WdWtKhIBMIkj5O4H9/Mt08CaLKaLICuMb/RJiUFJz81l4BwlOSW904t5HUSsa8
 VRraz/79jvQfXs723W8YhtNsmV6uC9r5MLZV2u/VjptgPPV1LgNUzJ8K8f2lut7gYIM+
 sMOJcjj6EIdSvHSch38umzxRW9cwycs99ITFoSgSIrxjt01gepk2nkdRTNQhXjqgN9wk
 oYUqJqCTSAQu4kbqQxx0H/rqHuQuZBVpxLuA1GjrpmQCXdNBqgGr+2Jos0+F9IXLK+g/
 pV6Q==
X-Gm-Message-State: AOJu0YxoiHEbDgsFTolSeyu1QQYNSpHMA1/g8OUD/nfHlhTm2iIluTti
 T1ReZx6awFKsaJzQp3GLbRHHZ0jQH/QjHGijv4CRQurlEeQBMMCRjZyVxYqBDfAbcxE=
X-Gm-Gg: AfdE7cnY1AVvfUkADjNVL3IgKv74xKBabEIqTqZG8eoafctpl+6SiNHlfpsZoQyCa1X
 0h0h1MvhasGs/tEcuNJg65vLR88xoBdvm9MO9YMDDHwG1TUDluBfcfmPVoJrCR5zfDNZ/g3okeg
 5stlWlo5qSabiD+W5hdRkdgYK+MR88UKwulX+5GdoxOglHPRkFHTWJKuIGIODbH4HPxdUqm+8x2
 WlaAOiSPwfPK4DK1MBi6Z06hI4yAoutrLZNAqGgSVyQytumNt5IU9DhDHnABdCyBaA61r7ZnnOq
 hFsblHKZPqSOyI1gqv1NunQT3YX8vIpVDZrISwz0zRkE61gtXVlNHj5apeEA+gXKOd9NPkyesRz
 sf4lj12M6j308Cn8N/Atsmqh45DjfUhWt9dum/VxHhIb9bF21vjXY67kR9jtXc9vx9LZQnI/HsX
 VuUgOXkF3JLf94N7IQKN/2Lwsy6CBCRYr0kdcMTVeH2X5ttkxQuqMV7buF0uktZI8A
X-Received: by 2002:a05:7300:bc1a:b0:2ee:be86:7b90 with SMTP id
 5a478bee46e88-30bf09a78e4mr3795346eec.29.1781797628200; 
 Thu, 18 Jun 2026 08:47:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0357sm24199005eec.11.2026.06.18.08.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:47:08 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:45:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com, Marek
 Kasiewicz <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v2 0/7] Intel network drivers enhancements
Message-ID: <20260618084517.4d7f6c85@phoenix.local>
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

This looks interesting but I don't understand the motivation
or use case for the new code. There is no documentation, examples
or test integration.  At this point the patch is in pure RFC state.

More wordy answer from AI...

Documentation and motivation

This adds a new public ethdev RX mechanism but ships no prose
rationale, no documentation, and no worked example. For a new API
the series needs to make the case before the code can be evaluated.

Missing documentation:

- No prog_guide section. A new RX model -- header split where the
  application supplies the payload buffer -- needs a write-up (e.g.
  in doc/guides/prog_guide) covering the buffer-lifetime contract,
  the IOVA/headroom semantics, which offloads must be enabled
  (RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT), and what happens on a PMD that
  does not implement the hook.

- No example or testpmd integration. There is no end-to-end flow a
  reviewer can read or run: register the callback, supply buffers,
  receive, consume, recycle. Without one there is no demonstrated
  use case and no way to validate the design (the mempool-corruption
  and headroom issues in 7/7 would likely have surfaced in a working
  example).

Missing motivation:

- The actual use case is not named. "Zero-copy RX into mapped frame
  buffers with known IOVA" describes a mechanism, not a user. Who
  needs this -- an AF_XDP-style external umem, a GPU/DMA target
  (gpudev), something else? State it.

- The benefit is unquantified. The claim is avoiding "an extra
  memcpy from the mempool mbuf," but the patch replaces that with a
  per-allocation indirect callback on the Rx fast path
  (ice_recv_pkts, ice_rx_alloc_bufs). The rationale should show the
  memcpy actually exists in the path being optimized and that the
  indirect call per buffer is a net win.

- It does not explain why existing mechanisms are insufficient. DPDK
  already lets an application own payload memory via
  rte_pktmbuf_attach_extbuf() and via external-buffer mempools
  (pinned external memory passed to the Rx mempool). The series must
  argue why a new callback API is needed instead of those -- this is
  the same alternative raised against the 7/7 implementation, so the
  motivation and the correctness fix point at the same question.

- Constraints are undocumented: PMD support scope, fast-path
  threading and reentrancy of the callback, and interaction with the
  buffer-split configuration.

Until there is a documented model and at least one example showing
the buffer lifecycle, it is hard to tell whether the callback API is
the right shape -- or whether attach_extbuf / an external-mempool
already covers the use case.
