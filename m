Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3128606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=R5jnoXwP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E73040281;
	Wed,  4 Nov 2026 13:25:04 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 047F44025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:25:03 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso2530893a12.0
 for <dev@dpdk.org>; Wed, 04 Nov 2026 04:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793795102;
 x=1794399902; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=haPt5kA1Fc6RNsxI+Cj8RS48s/w11vjGz2xFOO1QM1c=;
 b=R5jnoXwPbcU0DN4j9jRZM1wkZXV86ZFV0vQKWdLupaPWVQEQ0DpM+cfYNiJfzwf0NQ
 7opJnJbzbGxMxtNLaWnAP8ZEAhqkIAP771Q2SRLBy/SF88i+pnGSNwttHy42Y4lmkMw0
 epaFtREQT7Orzza/35kaUX8/b93dh7dL00e5h2D/5IV5pWaR0Gngg8HtbyBMbtTng1o2
 6Shh8msAQi3SEUDfLcCAfs+XbVBRJXnnxrOWWDFXYd1/vNXI8/Qs32RoCgYp7zdWBb+Q
 gUapa4sk5wI7K95jgiy3VoIjse4kLr2LfigXkM7Oe81A68fUXE3Xl5a0+bCuEh7j14K6
 /FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795102; x=1794399902;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=haPt5kA1Fc6RNsxI+Cj8RS48s/w11vjGz2xFOO1QM1c=;
 b=cExTNtCNCCoCtQ9ArFmriHInqRy89JmeJYlHYOs+MLrA6ZheHGv0FpNouRQs9+j1IK
 LOIbd7n3oAgSkoLzsMAIn9PxEURus7wJcdxqI06mUDh1OXFOsuh/IdCJIjpQ+c6A0A2e
 gV3qmIEpwWvzxOr+MCdFK5K1qRrg8u7YQxL3nPONSDlriK+T7PX/LIvTDnEE88i8CcEP
 ROP9jNY4ziNtZ8l5FgSifp3V3QxzzMSgl1FAGkyp0sAnDJYe7lDOW46jQPmWZU8OAaB9
 G/DhAER0E4rjEd3fBEw4vTs4mtu+dwNt349RSox7zR0Omk62E7QSQfaRpCVXLqR8C7RP
 dOtQ==
X-Gm-Message-State: APuU4Z+U7BwvSl6iSW8XJsZB9mpxKQtLg621C4LNCNfm+/H7KX2AJH38
 V0v1rhO4XF83HBQmW2s4RDJFAosAAaWvkcxZ8lAC88/vJGzYFfp+Ew86pxQa1gIGH4M=
X-Gm-Gg: AYBFou0DExhGl4COEcwPJQpE2+xWil1qhvLBxxP0SW3AS8uHZa+FijfS4R0Y/cIt3TR
 HX1JVbh9IHXu82E4iYp4hNJNuZ4LHt+H8/dxoObdcv/8+ZaAINwpTT5hQg/aElwfDMzFQrazV/c
 /zoGI5ljAF2R3ZcOxvOYo5Lrt99oLFKgIONKXwc+KO8Ax49SJYeJPeIlj+2SHQ9uJtfCqFH2BGb
 WhjKe2VIsYu7/hQrLK4xC3LKGTsU33wCSCnfK0ChHjfdyjiSCRdz2Kzj9k4vrk3VRr9cNRM+4tI
 Ne97t4Pf2ovFlk9fdS640Zc1k9mYc9DFNAF6RG8Po5QDE7HdSCVsOtYwCscc5L1Wlv+xJ+aS6Zb
 +VfrkPelPprRi4EMFB+UhfbNrYWraSm3V+kaPEcXS1Oefiq9aw7Sg6QxLJAlRyCzJOUkylGeeTP
 vvSD3Xo/bQvSe0a+SVbjOaCtEM8Ta38u0xK6SsAR68FIXYToS8bmW0g0F4YrwJjGRNYRQsFmxKj
 Xdv/dRZ6j/kYGZRyF/LWkCSA62rrqHzQrhj1j/xpK8P1pDmP69SMVpj30xZG6lU5Y/iWSPwi8uW
 4PQj4mhdMJyFLcFW1GUsu7xxJi6JVQg2QS8dQhJmWGMdivg//Qr1ZExcvfG2TTtSffXyh4Ga2uV
 E5P+7u5ougaOvVi0=
X-Received: by 2002:a05:6402:a251:20b0:6b4:8b1e:2866 with SMTP id
 4fb4d7f45d1cf-6b4b0c0d79fmr10782263a12.16.1793795102422; 
 Wed, 04 Nov 2026 04:25:02 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55ac46445sm680850a12.13.2026.11.04.04.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:25:01 -0800 (PST)
Date: Wed, 4 Nov 2026 13:24:57 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: <dev@dpdk.org>, <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>
Subject: Re: [PATCH 00/13] raw/ntb: post-merge fixes
Message-ID: <20261104132457.78d41700@stephen-xps.local>
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 16:49:48 +0530
Raghavendra Ningoji <raghavendra.ningoji@amd.com> wrote:

> This series addresses the post-merge review of the AMD NTB support
> by Stephen. Some of the issues also exist in the Intel code and in
> released versions; those patches are tagged for stable.
> 
> - Patches 1-4 fix the type confusion in rte_pmd_ntb_get_mem_align(),
>   the unbounded peer memory window count, the off-by-one in the
>   address remapping and the memory window leaks.
> 
> - Patch 5 fixes the doorbell interrupts with vfio-pci: only MSI-X
>   vector 0 (DB0) was serviced, so the DB1/DB2 exchange of dev_stop
>   never completed and the stop waited for its 1s timeout.
> 
> - Patch 7 removes the AMD hardware event handling, which could not run
>   as wired, and documents that hardware events are not handled.
> 
> - Patches 8-9 fix the Rx path: a partially consumed packet was leaked
>   and desynchronized the ring, and an mbuf owned by the application
>   could be freed again on device stop.
> 
> - The other patches are documentation and cleanup.
> 
> The peer memory window size check suggested for the AMD handshake is
> not added: all the AMD scratchpads are in use, and the window limit
> register programmed with the local memzone length already bounds what
> the peer can reach.
> 
> Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
> file transfer, and stop/quit with DB1/DB2 exchange.
> 
> Raghavendra Ningoji (13):
>   raw/ntb: fix device check in memory alignment query
>   raw/ntb: fix peer memory window count check
>   raw/ntb: fix memory window bound in address remapping
>   raw/ntb: fix memory leaks
>   raw/ntb: fix doorbell interrupts with VFIO MSI-X
>   raw/ntb: fix AMD processor names
>   raw/ntb: remove AMD hardware event handling
>   raw/ntb: fix Rx of incomplete packets
>   raw/ntb: fix double free of Rx mbufs on stop
>   examples/ntb: fix raw/ntb library linking
>   doc: add NTB device info change to ABI section
>   doc: add IOVA requirement for NTB
>   raw/ntb: remove unused AMD register definitions
> 
>  doc/guides/rawdevs/ntb.rst             |  12 ++-
>  doc/guides/rel_notes/release_26_11.rst |   6 +-
>  drivers/raw/ntb/ntb.c                  | 136 ++++++++++++++++++++-----
>  drivers/raw/ntb/ntb.h                  |   7 +-
>  drivers/raw/ntb/ntb_hw_amd.c           |  54 ++--------
>  drivers/raw/ntb/ntb_hw_amd.h           |  25 +----
>  drivers/raw/ntb/ntb_hw_intel.c         |   9 +-
>  examples/ntb/Makefile                  |   3 +-
>  8 files changed, 149 insertions(+), 103 deletions(-)
> 

Lots of AI reported issues here:

Subject: Re: [PATCH 00/13] raw/ntb: post-merge fixes

Series applies to main (26.11-rc2) and builds at every commit with
-Dwerror=true (raw/ntb + examples/ntb).

Patch 04/13 raw/ntb: fix memory leaks

Warning: mw_size is freed in dev_close, but rte_rawdev_close() does not
detach the device; it stays attached and its ops remain reachable.

  +	rte_free(hw->mw_size);
  +	hw->mw_size = NULL;

After close, rte_pmd_ntb_get_mem_align() passes the new checks from
patch 1 (attached, dev_ops == &ntb_ops, mw_id < mw_cnt) and on Intel
calls intel_ntb_get_mem_align(), which does

	return hw->mw_size[mw_id];

i.e. a NULL dereference. A configure after close does the same in
intel_ntb_dev_handshake() (hw->mw_size[i]), and ntb_dev_info_get()
now hands the application mw_cnt = 2 with mw_size = NULL; ntb_fwd
indexes ntb_info.mw_size[0] unconditionally.

Both vendors have a fixed count of 2 windows (XEON_MW_COUNT,
AMD_MW_COUNT), so drop the allocation and embed the array in
struct ntb_hw. It then lives exactly as long as dev_private, the
info->mw_size pointer stays valid, and the leak goes away with no
free at all:

	#define NTB_MAX_MW	2
	...
	uint64_t mw_size[NTB_MAX_MW];

with RTE_BUILD_BUG_ON(XEON_MW_COUNT > NTB_MAX_MW) (and AMD) in the
vendor init, and the rte_zmalloc()/NULL check removed there.

Patch 05/13 raw/ntb: fix doorbell interrupts with VFIO MSI-X

Warning: db_intr_handles is an array of process-private pointers
(handles come from rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE))
used only by the control path. No reason to put it in hugepage memory.

  +	hw->db_intr_handles = rte_zmalloc("ntb_db_intr",
  +				nb_efd * sizeof(*hw->db_intr_handles), 0);

Use calloc(nb_efd, sizeof(*hw->db_intr_handles)) and free() in
ntb_db_intr_unregister().

Info (pre-existing, not introduced by this patch): peer_dev_up is a
plain uint8_t written by the interrupt thread (DB1/DB2 handlers,
"hw->peer_dev_up = 0;") and polled by ntb_dev_stop():

	while (hw->peer_dev_up && time_out) {

Now that DB2 is actually delivered, this loop is the normal stop path
rather than the timeout. It only works because rte_delay_us() is an
opaque call. Should be rte_atomic_store_explicit()/load with
release/acquire, as a separate patch.

Patch 08/13 raw/ntb: fix Rx of incomplete packets

Info (pre-existing, not introduced by this patch): the new on-stack

  +	struct rte_mbuf *new_mbufs[NTB_MAX_DESC_SIZE];

like the existing rx_desc[], is only bounded because nb_rx_desc is
assumed <= NTB_MAX_DESC_SIZE. ntb_rxq_setup() takes
"rxq->nb_rx_desc = rxq_conf->nb_desc;" without checking that, or that
it is a power of two (the ring indexes use & (nb_rx_desc - 1)); only
the ntb_fwd example range-checks it. The same function also leaks rxq
when rx_mp is NULL. Worth a separate fix:

	if (rxq_conf->rx_mp == NULL ||
	    rxq_conf->nb_desc < NTB_MIN_DESC_SIZE ||
	    rxq_conf->nb_desc > NTB_MAX_DESC_SIZE ||
	    !rte_is_power_of_2(rxq_conf->nb_desc))
		return -EINVAL;

placed before the rte_zmalloc_socket().

Review-Result: WARNING
