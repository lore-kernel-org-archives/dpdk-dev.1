Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAC606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S+1R+3Ra
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E922C402BF;
	Tue, 17 Nov 2026 18:34:28 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTPS id EC62D402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:34:26 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so736836a12.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794936865;
 x=1795541665; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d/0A2DMb22xY69b4JR6C7jEtkGQvpG8trXy7spFAY5k=;
 b=S+1R+3RaA8hUyEWjnzwqXGlXplXcW4xsRgrNGZSFGNqviReKL7AEHFmm3juahmki8F
 b7htlx0iGM48vyMA+lCaS66oYnNfKAcOqsqJcsHHR6ZV6fnyjlJSeYn/f2HfWyUnf2AU
 hxHLYFwXdNpJ9aJKKvEDzHFzwRPmvUMPSlimLsMx4NroXZ2zKXn1pakZPVa+Jgcg8Stz
 m9c1zv8HwkXxxTClPNeLdg3VCQH7/4j8i5WI5/gzoMOl+mpLh6tQQ3f8isnFAJoJkCb9
 exo6MzeOqsrPhvyokpdcIDQBkq5ZxuMGJv+1G2txlRUNUWkjveJQNeZF3I28Ux4dH1WA
 BhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936865; x=1795541665;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d/0A2DMb22xY69b4JR6C7jEtkGQvpG8trXy7spFAY5k=;
 b=0nawfxYEUQReEETuOu6JNBWGWt7qAc9cc2IVnjKKj+vWi+V1W3voDmhG3J8WoWNXN7
 jjeAlk3YsBdJmVOtTmR1kniDEcpIZ2NCAeZz1bSm/5FKVji2tR1vlGiwr0daRfGJ8rjv
 6u8lwFJw26INK5sA8bK5Osi7w6zqewwH5uR9gdFRrT6jQrkS+Kp5eAA0gBZtG2pl65gB
 Z8F5soSEszPPl+dt5t0fufx+vyG867BDcLkPuH+kn8afZk2vHA5DylZEOhtZdY+GzNtx
 czcoQiIAdFm8zzjePcN+Xgjx9nvv/UlpYyTluWWfm10/AtD6zKfGPJDtoxwo1zGVutUd
 hODw==
X-Gm-Message-State: APuU4Z+eO6FXEW7dTxzL8XL27oRvtVY3v0uEhaK55pB9p3AeAMaG0EIN
 gmDPPtr2gipU9bWCmYgsvUaDZjSZ4IkZA+rQdidVTkZNcOGb1tgLbJDygM6rEhxQi7Q=
X-Gm-Gg: AZFdTZdqEy36oNL2BvZeggssL5rsFqDp9xmrXPvW8KMWPftdUZzjNEr3XlnB/MM0eww
 pf+ViCxinkWsdtvPyiiNFxUCTZDERuAqwtVGFI+4A2czk5Ul1LcI2fIjlYbvR2GfC7VgSfgIr7a
 e0EjSjUs11O8VmK+ZbVm41l3byNcpc1dlg3Oqajp75lU4+lUkVA48u3hfLVhEAIQxYdGk/goG/M
 U57H8+kPAH/VdU49MtqFM9FWBECiRlf4BpF/LqCJ9EZryAK6iGy5R3/kNGzuconEQM7Gh89qaCl
 pAG7QhAabz3E7GVLO7GIroMoEEUP/lpgF8l3BuCe65+Dm3FsOX7XdWJyy5t105caefC34A+i7vk
 eQf0dukYrVzucJgsd5ugRbwgv90TPhiDitCPp7rYZoWImo0oaVguLFQc8nKcMjY3QRGGJHG2W/+
 P4EYH1WXpWFt7ItQXqojWcvYppdHqLvDL2KVdINRvnnvgQEIxJJqRvzIXmXn7F3AxMlLn8xM7Wv
 iYStl2UU3ALKYIBUFJB2VRo7/y3Eh0vE05iRywPmq421pZscUSF94qfecU8pxo7FasrPtQ4BYVl
 SGjddNR4qXWa9jmIbS55kL2qmWeWblzRMGeAC8G/aXxNoYoaTvsq09gRMcsfddXjG54CLyXCdA=
 =
X-Received: by 2002:a17:90a:c2cc:b0:3b1:6689:a016 with SMTP id
 98e67ed59e1d1-3b3d07d4794mr67858a91.16.1794936865097; 
 Tue, 17 Nov 2026 09:34:25 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3b110c0sm11682764a91.3.2026.11.17.09.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:34:24 -0800 (PST)
Date: Tue, 17 Nov 2026 09:34:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, Joshua Washington
 <joshwash@google.com>, stable@dpdk.org, Harshitha Ramamurthy
 <hramamurthy@google.com>, Rushil Gupta <rushilg@google.com>
Subject: Re: [PATCH] net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell
Message-ID: <20261117093422.752cc7ad@phoenix.local>
In-Reply-To: <20261115140016.3830109-1-rnwolfe@google.com>
References: <20261115140016.3830109-1-rnwolfe@google.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 09:00:16 -0500
Ryan Wolfe <rnwolfe@google.com> wrote:

> In GQI Queue Page List (GQI_QPL) mode each Tx queue copies outgoing
> frames into a fixed QPL bounce FIFO (512 pages = 2 MiB on GCE, ~236
> 8,832-byte cacheline-aligned jumbo frames) even when nb_tx_desc is
> configured to 2048. Under sustained jumbo bursts three bugs cause
> unnecessary packet drops and mbuf tracking hazards:
> 
> 1. Entry cleanup in gve_tx_burst_qpl() only ran when nb_free < free_thresh
>    (32) or fifo_avail == 0. With 2048 descriptors, 236 jumbo frames leave
>    nb_free = 1811 and non-zero remainder bytes in fifo_avail, so entry
>    cleanup never ran and every QPL wrap stalled mid-burst. Reclaim when
>    fifo_avail drops below half of fifo_size, and do not count normal
>    FIFO/ring-full backpressure as hardware stats.errors.
> 2. When is_fifo_avail() failed mid-burst after queuing packets, the driver
>    polled gve_tx_clean() once before writing qtx_tail, so the device had
>    not yet started draining the newly queued frames, and a single
>    GVE_TX_MAX_FREE_SZ batch after many small frames could stop short of
>    freeing a jumbo slot. Flush qtx_tail first and loop gve_tx_clean()
>    while next_to_clean advances.
> 3. sw_ring[sw_id] and the first TSO header slice were allocated/written
>    before verifying total FIFO space, gve_free_bulk_mbuf() did not clear
>    the first freed slot, and gve_tx_burst_ra() skipped mid-burst ring
>    cleanup and wrote pkt_len instead of data_len into the first segment
>    descriptor of multi-segment non-TSO packets.
> 
> Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
> ---

The AI review spotted some changes needed.

[PATCH] net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell

The FIFO fixes look right. Checking the TSO header and payload
together before allocating also fixes a real leak: the old code
allocated the header slice, then hit goto end_of_tx when the payload
check failed. iov_ring[tx_id] was overwritten on the next burst, so
that FIFO space was never returned to fifo_avail. The reclaim helper
rings the doorbell before polling, which is the right order.

Error

TSO packets with pkt_len <= hlen now goto end_of_tx. That is a
per-packet validation failure handled as backpressure. The app
retries the same mbuf forever and the queue stalls. Drop the packet
and move on:

	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
		uint32_t data_len, need;

		if (unlikely(tx_pkt->pkt_len <= hlen)) {
			txq->stats.errors++;
			rte_pktmbuf_free(tx_pkt);
			nb_drop++;
			continue;
		}

Leave nb_drop out of stats.packets. A better long-term fix is a
tx_pkt_prepare callback that rejects these before tx_burst, since
gve has none today.

Warning

The commit message does not match the code. Item 3 says
sw_ring[sw_id] is written before the FIFO check, but commit
1299806a ("net/gve: delay adding mbuf head to software ring")
already moved it. This patch does not touch that ordering. Drop the
claim.

This patch makes six separate changes to two Tx paths, under one
Fixes tag, and is marked for stable:
  - gve_free_bulk_mbuf() clears slot s
  - QPL FIFO reclaim, doorbell flush and wider is_fifo_avail()
  - QPL TSO check before allocating
  - RA: clean the ring mid-burst
  - RA: use data_len for the first descriptor
  - stats.errors removal in both paths
Split it into at least three patches: the free_bulk fix, the QPL
FIFO changes, and the RA fixes. Give each one a Fixes: tag pointing
at the commit that added that bug. Not all of them date back to
a46583cf43c8. Splitting lets stable maintainers backport each fix
on its own.

Say in the commit message why the free_bulk fix matters. In RA
mode a TSO packet uses two descriptors, but sw_ring[] is set only
for the first one. The second slot can still hold a stale pointer
from a previous wrap. The old code did not clear slot s, or earlier
slots whose refcount was still held, so gve_tx_clean() could free
that stale mbuf a second time. That is a double free, not a vague
"mbuf tracking hazard". The RA data_len fix is the same kind of
bug: the device was told to read pkt_len bytes from the first
segment, past the end of that segment. Both deserve their own
patch and a clear description.

The commit message is long and reads like generated text. Make it
short and factual, and say how this was tested: which instance
type, which queue mode, and the traffic used to reproduce.

Info

Use for (;;) rather than do { } while (true) in
gve_tx_reclaim_fifo_qpl(). Add a blank line between it and
gve_tx_alloc_from_fifo().
