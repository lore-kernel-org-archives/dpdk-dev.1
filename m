Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4C606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gV8c8W8J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B281740264;
	Mon,  2 Nov 2026 08:46:03 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 086734003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:46:02 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2792099f8f.2
 for <dev@dpdk.org>; Sun, 01 Nov 2026 23:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793605562;
 x=1794210362; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3M6jk92987mfLg+ZmR1rIINWMDkD24U5iibdg42yEbM=;
 b=gV8c8W8J0KcJmgy6Y4EPC52XFMP1mFq+zsoEl05cifc9rrwIVTsFQx+JS9hBs4H4Fm
 6RH4ZNZD6ODEHXx9XFiQnG7RO8Mi3Y0fu8Z9ubKM8/cQFiZAIvBRqs960wvnXx9TkY6N
 CMLavCAZRAzxhxEAyRkuHFttnWXOnPlG4RCL6u1LJzK3SQP0d6bLOrGpA16YFcqZSIhZ
 gUUVNxN9/8EBpCZueypquDmYI54fbsePhdwqbeTllWOaEfT0YhzYz8qj7je9W1q9ayY3
 Con+2iU8lU4jn7NT+IgwQfhrliPIE/VhnnRxUoivsFpli2cp5Ol7wtTRrB50qx5O/jZ1
 4OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793605562; x=1794210362;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3M6jk92987mfLg+ZmR1rIINWMDkD24U5iibdg42yEbM=;
 b=fiqeGGL72vaFyed5wjBYI8Fb2cVoKKusN+paMKNkiZ3qchXsSkLh2CID0pAAcv64Pw
 FBe1gsnRQP8iUtkBM2M25cyuSWeZe5CwSyRRd7TQm5jXZMnEaY3iWcTrmCxv0oblri7v
 YqP/Nf+gDIAxjL3T1AWSwdNkDUCpscDTfxEmN34BfJ7YdYF+mpvg2dbUGQst/pzZOhND
 9z1ATUllEb7NH8RS4VuHyCTX0amXcmPri//mKFQ9TJeFCx3DwxSyYNFq6sLGYDeLRfWF
 8acpfKgtHzeVi6r96RD/fcY+zS8AgcsRW93tv5+6aP0m2vdF8qXVKptLUmJqw97REQqZ
 ZSKw==
X-Gm-Message-State: APuU4Z8F2ia+eUCNkItJSU9+rrER0C64yPHKJ+t0FWr88moccsVYJ0+0
 qDk/qiqYXGArr4S7bMERSfqHyvL5knMP9S/mzl/44cf23KTYTbKG6rzanyY2/Ik6h/M=
X-Gm-Gg: AYBFou1CNsuRWkJZFrZ2VJNFhSw99BgHrtVuL8EThyndiv9d8KlfyHPQkBoFLwkhmgG
 samV0ebth34AJa3y94sqncWsNTYs6zYQK9B38XUzvDXLw+zBzjPyMdZ74N3a6yzjkdEMBRc+jbv
 jwOrMU7D53LsksThFjn34wCvf+UiXmHPu9udYHmvt7Mpja4LEh1gYsVCXAW3pJXw0INi4U4mdeU
 fESfDNlzf4G8XlVMSTt0sHuG9CpIu1Q4Wr4CGg40hTMkbUlsgQw/uETJG8uumYXPRRRlfXNqudL
 4zu0OLYctAD76V3BFTs50EiiTENMBmZAfF1v1gIeqbH64g6Mom9j6mVlNWbawX3kvb4rBMNChjZ
 GCEttL2BdNn7n+trI1pDl3h6ot63lcANyq17WBq/FoL11T1JK+fkwTc5g1lIUjvr51rfbgzE+dB
 av00LTbhVAMjiGVMK5xuC0xhccPWwstAyJsY4QxGy7RyK4tWDe5EINPhuIoO8njmAEmHcsywkMa
 MwPIk+0otu9F7sEC5Ctb6lxBLLPfI/SEQxbSpyuJUQt51xsT8VS1An+/FlucbDrMbQAHxV64oZk
 B74xGCSMm9RnxLLQycZJ5IZHH9y8b3iBAbB6nA2ErILiPK9md40JP6hXcxTr9fgIbGe3gi9Ek4j
 JaTVzP9+uTkiRcQ==
X-Received: by 2002:a05:6000:250a:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e6e303c68mr20347860f8f.14.1793605562326; 
 Sun, 01 Nov 2026 23:46:02 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm18924636f8f.1.2026.11.01.23.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:46:02 -0800 (PST)
Date: Mon, 2 Nov 2026 08:45:59 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/4] net/gve: TSO descriptor count fixes for GVE DQO
Message-ID: <20261102084559.1e58036c@stephen-xps.local>
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
References: <20261030184304.508282-1-joshwash@google.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 11:42:59 -0700
Joshua Washington <joshwash@google.com> wrote:

> https://inbox.dpdk.org/dev/20250707231812.1937260-7-joshwash@google.com/
> introduced descriptor limit checks for TSO packets in DPDK.
> Unfortunately, a couple of bugs have been found in the implementation.
> 
> This patch series introduces fixes for those bugs while correcting the
> overly restrictive behavior recently introduced mandating that all
> headers be in the same buffer.
> 
> The final patch in the series introduces tx_pkt_prepare as an option to
> ensure that there is a way to get a clear signal of when packets violate
> hardware limitations. Before a recently introduced patch, the GVE
> behavior was to stop transmitting at the first invalid packet, which
> would allow the application to do any necessary linearization or packet
> modification before attempting to transmit again. It turns out that that
> behavior is considered incorrect, so offer tx_pkt_prepare as an
> alternative.
> 
> Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")

You dont need Fixes for anything that changed during 26.11 development
window. Only for changes that need backports.

AI review also mentioned.

Review: [PATCH v2 0/4] net/gve: DQO TSO validation fixes

Applied to next-net (339c992f25) with no conflicts. Each commit
builds with -Dwerror=true.

Patches 1/4 and 4/4 look correct. The seg_offset change in 1/4
matches the descriptor layout: the first seg_remain bytes close out
the open segment, and only the rest is divided by tso_segsz.


Patch 2/4: net/gve: account for multi-mbuf headers when validating TSO

Warning: stale comment in gve_tx_validate_pkt_limits().

The data_len < headlen check is gone, but the comment above it
still says the headers must be "contained in the first segment".
Update it:

	/* TSO headers may span up to GVE_TX_MAX_HEADER_DESCS_TSO
	 * buffers; the payload must not be empty.
	 */


Patch 3/4: net/gve: introduce Tx packet preparation for DQO format

Warning: tx_prepare rejects every TSO packet whose headers span
mbufs, which makes the relaxation in 2/4 unreachable for apps that
call rte_eth_tx_prepare().

GVE_TX_CKSUM_OFFLOAD_MASK_DQO includes RTE_MBUF_F_TX_TCP_SEG through
GVE_TX_CKSUM_OFFLOAD_MASK, so "csum && tso" is just "tso". Every TSO
packet therefore goes through rte_net_intel_cksum_prepare(), and
that returns -ENOTSUP when

	rte_pktmbuf_data_len(m) < l2_len + l3_len + l4_len

The commit message says "in this case" as if some TSO packets skip
the call. None do. Pick one of these:

 - State it plainly: TSO packets that go through tx_prepare must
   have all headers in the first segment. Split headers are only
   accepted from apps that call tx_burst directly. Then drop the
   dead csum variable:

	if (tso) {
		err = rte_net_intel_cksum_prepare(tx_pkt);
		if (err != 0) {
			rte_errno = -err;
			return i;
		}
	}

 - Or seed the pseudo-header for split headers too: read the
   L3/L4 headers with rte_pktmbuf_read() and write the TCP checksum
   field into whichever segment holds it.

Info: this adds a tx_pkt_prepare op and tags it Cc: stable. That is
a new driver op, not a bug fix. Stable maintainers may want it
dropped from the backport, or want the commit message to say why
existing apps need it.
