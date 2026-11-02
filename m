Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB56606EE9C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jzPq+RWM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEE140612;
	Mon,  2 Nov 2026 20:40:24 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 63D2B402E3
 for <dev@dpdk.org>; Mon,  2 Nov 2026 20:40:23 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c46bd7a7345so694764466b.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 11:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648423; cv=none;
 d=google.com; s=arc-20260327;
 b=rp8CZ2g5yRDYTZi9LwrIO7VhnMreR6t9ZUkOHdp9/Ds3lT/YQTiw72xhSCLFjnahmn
 Id83lhC8xuudr1zCkmn53iW01uW8nikXmJLQKSYRwkipizBafH/tHwE7qa4HYe/R1P/R
 /CeugMnv/3eR3YYSrZ4+A+xbuUHYsAThmoSNwxMzHq9NosdmqeqSkb5BTQt+Uc2+fiif
 lG/bDgRCrPFT3JY3//y2X+1y2poeH40Fr1fKy0lKI4ekUdbKqh5U5cbrHItqMU9Nl4C+
 hXtcYWmWuKfOBYSIJ3pLqknLC0IeuKS47QKg36gUwoqbXXyliiVpWhzeaXgbuN2ksmY6
 6BXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m07lNSTcCMd6eQItQuezFT/i7ULG++/QuaR7iVDVpxs=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=Y0y4csLeLLNBg5EeHTT7Mvf8wcanicYnxQDbQc7h7yfz5gdmnQg1rqF8AFqUZ7O5Rp
 Q5GpaCoweNop0Wn+WNFkOZ+BTkn3yWMeHSPYPZ8HfEsOFjTccVdOPWOnNj4oVYAcgszX
 tzaV8Zh2ixBxAU7lNeNVfRRXTyEsYSVvTU3q4NuHXNgkZLGHMMD9+UHLY6QH2e9LrWNJ
 t4/VCrPhOs45nj3qSdk0gMB+ovlo/qL1iUzeuSnCasjnfW62uEuYRphi/24IDMV6JRIX
 Mez0JrpvgPisDlFQH8JYPv7fUk6cSnMrJRBzf+C+k0/HShMbn/SdiHCPr5Kyo0ysn/8Y
 FhnQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793648423; x=1794253223; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m07lNSTcCMd6eQItQuezFT/i7ULG++/QuaR7iVDVpxs=;
 b=jzPq+RWM+KVd+8QMrQBwi5wG9q776i99x2V/jssbGFjvsUXGRqhxTPkLRyiWZhckvF
 c0FuJhCEhf/LZFKSY9XFp6OpzZ+tOWrpU8+cS2xWxO+743CbqzbRcLLlRT2164Yv9sTp
 qOaNCsxsFKUq+81LI176ePqZ2XDRXTcNiKE72BRrnTUeB4MLEnIlmeUccv1ywDa/GdHD
 0WAohjCD8b0/rAKRb/VXYreGjJcz/ktf6p4TRu+3IGSAsJq/woSkj17Y8NcJSP74CQ4w
 cXhugHCC3q4b0Ai6jdAnkxWKEvKEr+88YYKinjK/V9C416ac5wsy13Kq6jcNCaRyXqW4
 iZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648423; x=1794253223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m07lNSTcCMd6eQItQuezFT/i7ULG++/QuaR7iVDVpxs=;
 b=HbkFFER0wwpsTi2iKwV3kdNsk691d9ByOx0nxOTh4oj/AiTJUwX9IqmvGcTdxFlB4f
 fA9UtMMHPAMZfqaE6TWG7cwBK7pc0yazI9WIpqg5RmiODo03ixRLyk8Syph9G9tmOvA+
 nOt8WGYPjY08A1++I5qVkuuy7paLCGtzNtZhxoYZg07HwONL7twZfdDjr0V/A9UFIuEs
 wYfGSP8B2FyP2o8WvyGVHb+BL8nC3ourYVxT/vQBlyvqCc6+xIGwAyDRLDs/plCyicv0
 20S1acf7AkmLJZVWoM2IKXeb1Fm+BuNHg9HsFP9NC8NhgLouXoufiH46LUKoZQLQK670
 SywQ==
X-Gm-Message-State: APuU4Z8oy3mosPrURZqILMfuS4dR40Yy+5ysuyLTp5RH7cnaGslygz+m
 L30NgELPzOgDMQ6O+ik8WwxufMVTnStEHGKAQnr3vPGE3aKY3ep8/0QJ84507mG6tFj2QLLfJgV
 6PMhcKL584F6Na/wVFTMqrXLmcGF0ZTm8F3f9UrUl6iclYt/IidR2hzGw
X-Gm-Gg: AYBFou0w/09xlq7OxJbfRT0inIoq6f25izP6FF7ltfa0M81T1zpS/HdmHuOQlJSSSZJ
 GsZWIDqLTodugz3kB7RvUBd6WCMHacwjTMYdH9f2OkN7nYFBnga5GhI5A3DnzBADDcsh3jXjRHx
 z9BQoTaSkOczgeQkOuywtdbfQOlLisP0uCvBTzvELHe7tnDhnyLdtOF5MEpt/yIQ47NEjXAdRTo
 AqOMSzXFqaFzbbiqLy88pIuZvyzBySJhsv1ZF7NR8NITc2lFXsKiSkThndonoVlpRSu1KYKmF7b
 DpjESsFUQHHX5hmIDsS8wOzbXLndZHuA2bL/vPLprEhLbTpsE3yD1ECQlCSrAaNzxmZnzaHEQRn
 eXYYbRoQHF2auvITJEcMJq59xZwLblX/4Y+EsdeD3HTrzYX0FYg==
X-Received: by 2002:a17:907:a08c:b0:c2e:616b:6763 with SMTP id
 a640c23a62f3a-c4ca795564dmr950254766b.3.1793648420896; Mon, 02 Nov 2026
 11:40:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
 <20261102084559.1e58036c@stephen-xps.local>
In-Reply-To: <20261102084559.1e58036c@stephen-xps.local>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 2 Nov 2026 11:40:09 -0800
X-Gm-Features: AclHuK9_tN4tLwQq0b8GjFnsDF6c0m3PVw_wnzYZlqVAabA9tPLsCX65gZERX9M
Message-ID: <CALuQH+U7sCUJvDs3dvX9hu0vFtGDXBQf12F=VJ8WTRUnOmmw2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net/gve: TSO descriptor count fixes for GVE DQO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 11:46=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 30 Oct 2026 11:42:59 -0700
> Joshua Washington <joshwash@google.com> wrote:
>
> > https://inbox.dpdk.org/dev/20250707231812.1937260-7-joshwash@google.com=
/
> > introduced descriptor limit checks for TSO packets in DPDK.
> > Unfortunately, a couple of bugs have been found in the implementation.
> >
> > This patch series introduces fixes for those bugs while correcting the
> > overly restrictive behavior recently introduced mandating that all
> > headers be in the same buffer.
> >
> > The final patch in the series introduces tx_pkt_prepare as an option to
> > ensure that there is a way to get a clear signal of when packets violat=
e
> > hardware limitations. Before a recently introduced patch, the GVE
> > behavior was to stop transmitting at the first invalid packet, which
> > would allow the application to do any necessary linearization or packet
> > modification before attempting to transmit again. It turns out that tha=
t
> > behavior is considered incorrect, so offer tx_pkt_prepare as an
> > alternative.
> >
> > Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")
>
> You dont need Fixes for anything that changed during 26.11 development
> window. Only for changes that need backports.

Which patch(es) does this refer to? I think some of these patches are
fixing previous fixes. For those patches, should I just base the fix
on the same patch that the original fix was addressing? Otherwise,
they could be applied to next-net, but not as fixes, which would
prevent backporting.

>
> AI review also mentioned.
>
> Review: [PATCH v2 0/4] net/gve: DQO TSO validation fixes
>
> Applied to next-net (339c992f25) with no conflicts. Each commit
> builds with -Dwerror=3Dtrue.
>
> Patches 1/4 and 4/4 look correct. The seg_offset change in 1/4
> matches the descriptor layout: the first seg_remain bytes close out
> the open segment, and only the rest is divided by tso_segsz.
>
>
> Patch 2/4: net/gve: account for multi-mbuf headers when validating TSO
>
> Warning: stale comment in gve_tx_validate_pkt_limits().
>
> The data_len < headlen check is gone, but the comment above it
> still says the headers must be "contained in the first segment".
> Update it:
>
>         /* TSO headers may span up to GVE_TX_MAX_HEADER_DESCS_TSO
>          * buffers; the payload must not be empty.
>          */
>
>
> Patch 3/4: net/gve: introduce Tx packet preparation for DQO format
>
> Warning: tx_prepare rejects every TSO packet whose headers span
> mbufs, which makes the relaxation in 2/4 unreachable for apps that
> call rte_eth_tx_prepare().
>
> GVE_TX_CKSUM_OFFLOAD_MASK_DQO includes RTE_MBUF_F_TX_TCP_SEG through
> GVE_TX_CKSUM_OFFLOAD_MASK, so "csum && tso" is just "tso". Every TSO
> packet therefore goes through rte_net_intel_cksum_prepare(), and
> that returns -ENOTSUP when
>
>         rte_pktmbuf_data_len(m) < l2_len + l3_len + l4_len
>
> The commit message says "in this case" as if some TSO packets skip
> the call. None do. Pick one of these:
>
>  - State it plainly: TSO packets that go through tx_prepare must
>    have all headers in the first segment. Split headers are only
>    accepted from apps that call tx_burst directly. Then drop the
>    dead csum variable:
>
>         if (tso) {
>                 err =3D rte_net_intel_cksum_prepare(tx_pkt);
>                 if (err !=3D 0) {
>                         rte_errno =3D -err;
>                         return i;
>                 }
>         }
>
>  - Or seed the pseudo-header for split headers too: read the
>    L3/L4 headers with rte_pktmbuf_read() and write the TCP checksum
>    field into whichever segment holds it.

I will drop patch 2, since the driver requires checksum offloading for
TSO packets.


>
> Info: this adds a tx_pkt_prepare op and tags it Cc: stable. That is
> a new driver op, not a bug fix. Stable maintainers may want it
> dropped from the backport, or want the commit message to say why
> existing apps need it.



--

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
