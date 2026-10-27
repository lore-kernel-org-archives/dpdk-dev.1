Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FF606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=VtHtMw5e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09CF54025A;
	Tue, 27 Oct 2026 05:14:26 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 28765400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 05:14:24 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e96502e447so31949305ad.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793074462;
 x=1793679262; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hi+MW02QAuYKQOegjv78LHcF8s6ye6rOOYYQOmuCvAU=;
 b=VtHtMw5eiZFDpL00H49onmlt1iS7dYJWOwX1zv1xT5UnDz1WyGfuhL8O/nKk+XvWIS
 68EWsRfgcxJQTG23d5zMNWUpUXQeQgY79FKSz/nympV2YmvZaYvZTfkLDz0KslQoVteQ
 NZi+U57eHxeOq4j3IVu1bdfsBafjdEhTDmksCV3tg9/siIEtQoCwC05kz4YxSaYFzQpv
 dong2FmElJCkdvwUaAs6bsf3EBIFISJwqoR19aUJtrsmFywMp+dEHCWQDbGX/vMHhPyS
 PrzaYgGR6NhShpeis1CQySjHUVPoMD7C41bsdRH7FhupPOriejxhpXQubvt/JFArtwEl
 L36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793074462; x=1793679262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hi+MW02QAuYKQOegjv78LHcF8s6ye6rOOYYQOmuCvAU=;
 b=PgBXFpj2W9LSlbJBvsk4sPNox9qcbPsyzBoo5YzAupHa67xeP7tLHJ+09zvPjIj+qU
 5yDff6g2BIsOItajVPauO+Msgy4B5lo+4GKFZGy24zNMOGvX/76jQvcTt9+F7NBQBdsO
 x5Hf822aDy8JZRqG/3GQ/bsoN6cd6c8hw1hTZRAWvyFds/0gDh5xJ2OldlNl7VAeNBxM
 aqG2kmUMif6J2iyFJn8gt63+yYzzZ2LC4755lLfswQZIIPFiG/NRMbz/cjg1IC3+QkWX
 4wJAoaBGhJV9bDAvB80lP3Uw5LEKyXu6Oa+NKwmMFHYGc0D7SIvxfhC70zEJynAIfrOV
 Uf4w==
X-Gm-Message-State: AFq9FYIXmR2M1Dwg7EyTd3ZJ2uAudpzYbhPcJ9dAYnK9CWMHuo1U2V5D
 nr3gmU5B9OuKg+Blefchpr953bluJZ20H1rPhE7HZMc6u28EQT00GAhz2PAI0MZS1EU=
X-Gm-Gg: AYBFou0e9jJzSz8dF9X/RDSiAp4wKyR0e8ZvYQgf61Eed7bVBVLvN/6JQpZQ4bFXHZX
 bW4xiZnaV08EAlGUHVumkiEF3K8eN5ltbDRb5pOlwr0AUW1yP9WO6QNYOAfdhLTu0fKTS8yVEbl
 chmEXa55fSF+A37l8wlS4n156IXRapFRvKcldGaJJBO3mZw0o5VroNVJWSJmI/iMtbFoKo3BQBN
 AxaIFcjCcJzCnFvUXbz/Vrb1HgYVynw+Z487HKjgBexI/mGA9S0F6akOJoq+O4R45DhnvpgFqO1
 xgJRuKNfDjai8asc5VSOLhQEPYLH/EhQkBLLQb/bJ+kb1mPDf4KbJrqokKGdF3RzTaWUEfgL13Z
 Sz/1I/G7E8x+JItNcTxBN8Y2liBP+wj9ZMBNgl005sSevsO7AgNkhayQGs9/MRdGNMbH0cvejak
 yXBlpZR4fBLGEkEI3FWQ5ZTUZgkRBixBUIaNosqiStuMX9Rbexm4/N5glFBIP2M/YRAWIghDHW5
 ttls9BxDCG7EkFb8wy253IZk2g5aT0ts2bvggT1osxtJw/rI43x2siju6n1AeqjCFLJRUUYjSEd
 NZjxxKArgGn0DOX1NZWvk4/xE7o37y4tMoXrFqzzV8U=
X-Received: by 2002:a17:902:f689:b0:2ea:a2ea:5f62 with SMTP id
 d9443c01a7336-2eaa2ea6690mr67799615ad.24.1793074462428; 
 Mon, 26 Oct 2026 21:14:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c912f9sm2677845ad.60.2026.10.26.21.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 21:14:21 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:14:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/3] net/gve: TSO descriptor count fixes for GVE DQO
Message-ID: <20261026211419.69813624@phoenix.local>
In-Reply-To: <20261026202327.3897802-1-joshwash@google.com>
References: <20261026202327.3897802-1-joshwash@google.com>
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

On Mon, 26 Oct 2026 13:23:24 -0700
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

AI spotted issues here. 

Subject: Re: [PATCH 0/3] net/gve: DQO TSO descriptor validation fixes

Series summary

Patch 1 is correct. Patch 2 relaxes the requirement that TSO headers
be in the first mbuf, but patch 3 then calls
rte_net_intel_cksum_prepare(), which rejects exactly those packets.
The series needs to pick one behaviour.


Patch 2/3 + 3/3

Error: rte_eth_tx_prepare() rejects split-header TSO packets that
patch 2 now allows.

rte_net_intel_cksum_flags_prepare() in lib/net/rte_net.h has:

	if (unlikely(rte_pktmbuf_data_len(m) <
		     inner_l3_offset + m->l3_len + m->l4_len))
		return -ENOTSUP;

So after patch 3, any application that follows the documented
prepare-then-burst model (e.g. testpmd csum engine) still cannot send
a TSO packet whose headers span mbufs. Only applications that skip
tx_prepare get the relaxation from patch 2.

Does DQO actually need the TCP pseudo-header checksum seeded? If not,
drop the rte_net_intel_cksum_prepare() call. If it does, either keep
the data_len < headlen check for TSO in gve_tx_validate_pkt_limits()
and drop the relaxation from patch 2, or do the fixup across segments
with rte_pktmbuf_read() and copy the result back.


Patch 3/3

Warning: prepare and burst count descriptors differently.

prepare uses nb_segs for non-TSO packets, but gve_tx_pkt_nb_data_descs()
(and the burst fill loop) skip zero-length segments. A non-TSO packet
with empty segments can fail prepare with ENOTSUP while burst would
send it. Use the same count as burst:

	tso = !!(tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG);
	...
	nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt) + tso;

and drop the comment about nb_segs.

Info: adding a tx_pkt_prepare op is a behaviour change for stable
users; stable maintainers may not want it backported with patches 1
and 2.


Patch 2/3

Info: the header walk can stop as soon as the limit is exceeded
rather than walking the rest of a chain of empty mbufs:

	if (likely(tx_pkt->data_len > 0)) {
		header_remain -= tx_pkt->data_len;
		if (++num_header_descs > GVE_TX_MAX_HEADER_DESCS_TSO)
			return false;
	}


Patch 1/3

Info: subject has "segment" twice ("fix segment TSO segment offset").
