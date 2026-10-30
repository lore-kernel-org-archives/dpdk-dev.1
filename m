Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C49606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B+An9Dqb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628C440289;
	Fri, 30 Oct 2026 01:18:52 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C39340151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 01:18:51 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c3f8d72d7ceso17133966b.3
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793319531; cv=none;
 d=google.com; s=arc-20260327;
 b=QLN8qZkDybH+PdAosFBADs3XpDGtOg2Kz1FRMIzhy9CnSazL+vNz8DJd4V7kyt2PZy
 CAKB2OuvwokGBDW4GShA7JBOKmH6tOEsP5Xn+71fEsTPKt0/GFKOIuHQ4EgZCIL/x9u9
 pX2XpoEyJnphC3PywEh3gkgvsdv86X6R7Wu8bniCr7jp8a7pymDXGysA0QodcSRL5CBg
 L8ygah3kJVzcU5EGRE9qIaUe1lA/8+7mWVHHLnxD6UNDx7/CdA36T+zAEiP0fciihCzY
 igvlRyrk9XOdXKFpMBTMrRVVi3G/BTi8ICY3Sh9AP67qcuBBMGGhIAt2kI++KHe52vNv
 41jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PqaHqg/zdCX7I+klMa5X/Xlugg6z3dZi+rSQPPm1FfQ=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=DBZzTkebRDGLWK5v5RaWae6pBeVXmJiLwr33Pp/8ula//8gAvBoBs8HussVw3s5F4a
 qLEgAaN7SizV35vmgXRR2z44FcoZDGj9a+0aREmHvaps0xunIwxm9l9Lr5HV+UjmkRxL
 6tBl2c/RGkxIf3iTFamYdGsV/ua+SCsRUrO5o2WsCABF0p5hclxxhVnpUceKHNtwUXt5
 FYkllaaVWtsEFmgB38GmzHB6liabYpe41Y822jl90Ida8hvrFnI5zd/3qIB9f7g4Q1P0
 JAB1HsRR5/VF8E3IxTwEooifUSoNU+4ChC9Y8wzRlA+v+NWt5u9T/ZwVVGfQ7zCCM12F
 8QBg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793319531; x=1793924331; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PqaHqg/zdCX7I+klMa5X/Xlugg6z3dZi+rSQPPm1FfQ=;
 b=B+An9Dqbl0ubrz/WzJ2yb6UR6X7LGlZE+tKY82J10lMaZiBVxpIaRL/wTaMGjxKDaH
 h5L/xfQOzvvAk9UXrQd2Urp8zkkMHvafvRtSU0pDgxMKPNWz5tRnjIv+K23JCqNCW/8L
 DLo633tDgsbpgrkhqcfbBDG2SUXu8Wf/jPY3I1WhYuD25FxR3jpjSEQ5zPUlApEtFTED
 YZuiVnRbNMlDa/MrPw8g+TroB6gZSfX3wY1lJxdbnZ3AE8oUdVNlanJtVhgfI+ZjvETH
 IT7bX/wA/MvGW+zTxuAKW9dDmLI9DuSW5rEhRpMzn0Mr3zU3aXrZXIJXoJc11Fu877Qn
 IxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319531; x=1793924331;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PqaHqg/zdCX7I+klMa5X/Xlugg6z3dZi+rSQPPm1FfQ=;
 b=a4tfQG1piSVaFUAA3cy6D9101uIgpqRCC0tTojA/Y7xprAcfRbZbp6WA//SVtUcvxV
 cp4D3WN8D46qBJNS7nSasIfMk7p2gFQCPJtyWC9QkX1yGaAjDEfrwhvIeb4Nf2M/P5jx
 6fY09FN0BuI+G5oCiSbYurAyXbLO4zunnE0uv1Lz/W1O2ZuKYqdSr6896gSA6ELRJ0Mn
 B/Oe81cPbFBXR0VwEF9WXs1ViuAhkRZnJ8LLOhV3OH5SMz1Fz46vxc/foxhgvPUOnwxa
 9DEJsKVBToqo9wJO3wRTVqaeerVnBG2UscqFLAd5dqq+NhJBFeeGd/kUdWaP4aIpZRdH
 8kSA==
X-Gm-Message-State: AFq9FYKCe0Ja25LTf+U+loZlF2NqCE8cQqZhfFXZJYbFEo/yXsYqrXlg
 twPZi90wNL668D89+vt7oh2S/swBEpo6Xyg8o+nOuXlo9hxpTreeM9NLX2fP+UqG1ibMMcjAXj+
 tgzw+65VVCfYQ25uQ0KpYFSGQgp3ZRV7VDsErV6y7du/FuUlrWhM0UWsD8wU=
X-Gm-Gg: AYBFou2fm7sm12TSpL5sNyMuvEBLfbEcqixqbV07M9zNhhswLMaC0HPMkPnOHk2GJTn
 +lcUW1U/uv3PuwIq49kFkdZ08lAkUA13eEnIl/ja5NGC/8hrYuP6yO7VQ1vKTLUDb0c4le+JX8v
 gcfl7OQ3Y+rbxXQ49tUcWaJeVzqVDkLxbtZiO/TXVVGLmLW2L3u+z+ij3bXeY08xCnnqjFNWsa8
 3nbgEfL0lVyu2R3Y/ohvQrURYi2DJMxcTOQ4BPX+XG8PryljPBy/HmyPKVdiV9lYkbML1IrHfRU
 FiXT5x/xZvIFDNt0Ul+wlIp4my1JoxlSH6G8cXnouaZ4V5I1hhHk1dRMKLMTUg2PrDo/OQcx96/
 l0up6IcU+9uqROPT2hdkPLK9KiKS/iLuVGcY8+wwJYDQH+tgeJZuj1eEbVV2mby34TOA=
X-Received: by 2002:a17:907:3f8e:b0:c2c:d06f:cf89 with SMTP id
 a640c23a62f3a-c4ca7935e6emr58250766b.2.1793319530104; Thu, 29 Oct 2026
 17:18:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026202327.3897802-1-joshwash@google.com>
 <20261026211419.69813624@phoenix.local>
In-Reply-To: <20261026211419.69813624@phoenix.local>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 29 Oct 2026 17:18:38 -0700
X-Gm-Features: AclHuK_vvD1Y-I4FdmLsGgEP3b9pI20xuxuKa4UxCfuwZ1zyjVSiOwfp0rrCiqM
Message-ID: <CALuQH+XuYM7f9egBnyebPawKTNvme+Z0T6iOCoKs2OWb+BBE7A@mail.gmail.com>
Subject: Re: [PATCH 0/3] net/gve: TSO descriptor count fixes for GVE DQO
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

On Mon, Oct 26, 2026 at 9:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 26 Oct 2026 13:23:24 -0700
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
> AI spotted issues here.
>
> Subject: Re: [PATCH 0/3] net/gve: DQO TSO descriptor validation fixes
>
> Series summary
>
> Patch 1 is correct. Patch 2 relaxes the requirement that TSO headers
> be in the first mbuf, but patch 3 then calls
> rte_net_intel_cksum_prepare(), which rejects exactly those packets.
> The series needs to pick one behaviour.
>
>
> Patch 2/3 + 3/3
>
> Error: rte_eth_tx_prepare() rejects split-header TSO packets that
> patch 2 now allows.
>
> rte_net_intel_cksum_flags_prepare() in lib/net/rte_net.h has:
>
>         if (unlikely(rte_pktmbuf_data_len(m) <
>                      inner_l3_offset + m->l3_len + m->l4_len))
>                 return -ENOTSUP;
>
> So after patch 3, any application that follows the documented
> prepare-then-burst model (e.g. testpmd csum engine) still cannot send
> a TSO packet whose headers span mbufs. Only applications that skip
> tx_prepare get the relaxation from patch 2.
>
> Does DQO actually need the TCP pseudo-header checksum seeded? If not,
> drop the rte_net_intel_cksum_prepare() call. If it does, either keep
> the data_len < headlen check for TSO in gve_tx_validate_pkt_limits()
> and drop the relaxation from patch 2, or do the fixup across segments
> with rte_pktmbuf_read() and copy the result back.
>

TCP pseudo header checksum must be seeded for TSO packets. However, in
the case that the application performs that seeding itself, I would
like to leave it as an option to still send the packet out as long as
it meets the hardware descriptor and packet length limitations. A
packet that is dropped on the receiver due to invalid checksum is not
as severe as a packet that stalls the entire queue. To that end, I am
thinking to only call into rte_net_intel_cksum_prepare() if checksum
offloading is actually requested. In that case, the expectation would
be that all headers are in the same mbuf, matching other drivers with
this behavior. I will make this change in v2 if there are no
objections.

>
> Patch 3/3
>
> Warning: prepare and burst count descriptors differently.
>
> prepare uses nb_segs for non-TSO packets, but gve_tx_pkt_nb_data_descs()
> (and the burst fill loop) skip zero-length segments. A non-TSO packet
> with empty segments can fail prepare with ENOTSUP while burst would
> send it. Use the same count as burst:
>
>         tso =3D !!(tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG);
>         ...
>         nb_descs =3D gve_tx_pkt_nb_data_descs(tx_pkt) + tso;
>
> and drop the comment about nb_segs.

Ah, this is a good point. I was hoping to avoid the packet walk when
it is not necessary. I was planning to make that optimization to the
TX path for multi-mbuf non-TSO packets as well, as a non-fix patch.

While it is technically still a departure, I will trust nb_segs as
long as nb_segs is less than the hardware descriptor limit. If nb_segs
is higher than the limit, the logic will defer to the mbuf walk to get
the actual number of descriptors needed. A future patch will introduce
the same behavior to the datapath.

>
> Info: adding a tx_pkt_prepare op is a behaviour change for stable
> users; stable maintainers may not want it backported with patches 1
> and 2.
>
>
> Patch 2/3
>
> Info: the header walk can stop as soon as the limit is exceeded
> rather than walking the rest of a chain of empty mbufs:
>
>         if (likely(tx_pkt->data_len > 0)) {
>                 header_remain -=3D tx_pkt->data_len;
>                 if (++num_header_descs > GVE_TX_MAX_HEADER_DESCS_TSO)
>                         return false;
>         }
>
>
> Patch 1/3
>
> Info: subject has "segment" twice ("fix segment TSO segment offset").
