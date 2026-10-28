Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA835606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IU4daX0N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA29C40284;
	Thu, 29 Oct 2026 10:40:53 +0100 (CET)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 24FFD400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 20:38:03 +0100 (CET)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-67a6cc9acbeso869253d50.3
 for <dev@dpdk.org>; Wed, 28 Oct 2026 12:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793216282; cv=none;
 d=google.com; s=arc-20260327;
 b=VlYosx7ijZFknn5hNz4gOkSe1VOqiSkayJXQRo2q79Ly2MQy+PQgquJmz0C8/SYUuf
 3DeGX0Wwl3hZuLGOuKZby6XG+rXIbN2DOkgzYBDu8+U3hyy+by+Ng5c1rX3W6sjoWp9d
 ciirb7c0iDc1OpXD1TJQthswLG9nIyDmb26aalvSUpSC1jmJ5nkiXso+zAT8kjYAItm7
 Ubtj/KNRkxRn0NSqWsk430UDsz2DAfhTUTKICN+Ytj4GfrJUanDj2tpCEEA2gn5dJCzS
 oFIIdQgW1x7bzlTKnCAvsQ8AuIdgjdiuz9mtilLKbi853bin5Z+A9FQNOvCBDUoxs0O+
 7OdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZJnTOt2jetiHASFMkgjCgkYdIIj3w/LALrikkIrYGDg=;
 fh=AIYL8YynIl3LRjd1YGoTr7ahlVoNB5Dn9lKki5ywPNM=;
 b=l2wgzNhhcktRgASocTnU7gY3oTzH4tldPgF51P2rpFQNORnUgHSkDectpt7WpqRMnQ
 UTEVUJGI06xEKlouhZs8g3blQqkmBqWapQZiRWD2cbUy/AarDStO9ROqMMFtGxcIvz+5
 k4V2hX4KIQsHuTnkUOc2AMVZl2lnio8nWn6Zue3vovWpDlxNDJs7U/A0JPkGfH5towoy
 aIn25KsBWhPY5iCj8qwFZt05qftyAUZU8wgPb7/zan6ziKepSMsvO2jvTE4r68SbnHBA
 gpPlHsluR4tiE5WqIR2zB4Z8JoPkQzmEouwrMiaWycLx8fFs3KBjTbHu3qkkh7C5QpIQ
 owWA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793216282; x=1793821082; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZJnTOt2jetiHASFMkgjCgkYdIIj3w/LALrikkIrYGDg=;
 b=IU4daX0NdwSHsS5AFwONW0QDErafDfGmu+BF1vJLwUdp5LmTUqymL/+/UGFhQ7FuQO
 dxdhdJHMt8PuNLyKIMgevorGJJk4C3KvJYeI94ADQV+0rPm8xbxyAYHQcmyYowncnfq2
 7xcObtZjtz3h+ggOk0We+f/Sf7VBd4+Xue5YxRKddkZLd1WBYzydx9dfuI9vAYUGt/vK
 m7GG3E8kUgswtfMjYyt/P6VRsGjMKbCGTpuxlUsug/J71cNYWBo7t0ZZpZNOsbZ+B5rc
 9BYiMGCDLXwyCNxQjHqdwHlwCEKHk8AkkIKgv3GUzpXHPZL1u3JQSFvlLLV/vq03oKhj
 bt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793216282; x=1793821082;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZJnTOt2jetiHASFMkgjCgkYdIIj3w/LALrikkIrYGDg=;
 b=1xPmt1BJXKXOuTpyucoWd7vfsgDKWVr5SsD6B6WpydnKrzx3dXbCQ/wdK/qOXb6xSD
 y41ti4Czt8RvtPQADsI63h45OQXnjrlIkjkli6mYJvVBUve9JnaGmXPkt2+ufpt81Kum
 CopIgjfnVpDCIXMVJ6AMtlN15qcqiidjJ+IaM6C5iOURK3I41sirK1FFk6WdDkYa1qBL
 yR57AoNRzBWsyuAkFuDrKUGi5COXcQ3lMry2lpcmReQ0Kr3OQCVSaIz1SoVf+R6yYCsZ
 uv5dQBCvoKcZji8VqW+UzzYXdARQ41LipsBEI5bx7ilBVymeYQctL2xpjCl7otm1AoXx
 ph7g==
X-Gm-Message-State: AFq9FYKT3xg4Dd/SceMSNgqWfqNhBQhAT24vDTF58smuQQ75402SRZE9
 TgQsLgTTA3y0m3u+2HikU2gPKZUn7QWKLxuG+mES/Z7efiZnWzT/ALHjwR5KG5To3oLDGSEA65R
 OC7YaiIKCgKOdJDgW1sZ3T1dDLjAJSag=
X-Gm-Gg: AYBFou0O+vyE/PRLCwipz5s8a72kzQxqoieTHkqeAMwsobQ+TIdIPmPkHHjcTNL421S
 Oc446HOD3L7VrwJTKSzpWdmqLroywiwLCqDBBALImYO68MC07SNxTJwi17pIzdRCOdI+JL4Rh1U
 xT3XzkK0DrPgI3O6BS6LdQdCvkJ11Z9ODh4J1b0PxsCF2OgdpT9sjCrIL7HD/vmPHbwAPS5ZrpG
 L0nsAxD0kYZHWtxjnZ352kGnARef7dZKwaoaQLLgln8RTKsuZQ6m7rqWe+iTxPNFu/yZe1rOVue
 Xh9EOeDkHkhXj0m5oWE+lp+k3RGQVjgeq1ZuqE2St9zXasWhEIgw6qAMXCyFdhvZCzXFGoyWbjZ
 LTv75jrJwB/UdiRJr8Lano8LDY19KUkHrJSaE3DXCqEUaQ5zPiOfKOn7m+zKGqHL1fiA2YQKN
X-Received: by 2002:a05:690e:4554:10b0:679:b98d:9b65 with SMTP id
 956f58d0204a3-67a7bc5eaa8mr1793105d50.35.1793216281542; Wed, 28 Oct 2026
 12:38:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
 <20261028070048.168f3605@phoenix.local>
In-Reply-To: <20261028070048.168f3605@phoenix.local>
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Date: Thu, 29 Oct 2026 01:07:50 +0530
X-Gm-Features: AclHuK9gue-wxO_Go3_gS35vnkF12zl032JWJiJGKmygrTN4BuX45YDBIsNx9H8
Message-ID: <CA++LmPVfWLpRtWdr31jWr_=96vpZo2wY+Y-diFhALqahWvxwvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] net/mana: fix tx burst error handling and add TSO
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, weh@microsoft.com, longli@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:40:52 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 7:30=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 27 Oct 2026 18:21:13 +0000
> Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:
>
> > This series fixes transmit burst error handling and adds hardware TCP
> > segmentation offload (TSO) for the Microsoft Azure MANA PMD.
> >
> > Patch 1 drops packets that fail validation, counting them in
> > stats.errors and consuming them, so rte_eth_tx_burst() maintains a
> > contiguous prefix and short returns reflect only ring backpressure.
> > It also clamps segment limits to MAX_SGL_ENTRIES_FOR_TRANSMIT.
> >
> > Patch 2 implements hardware TSO for IPv4 and IPv6 TCP traffic,
> > formatting SGE0 for headers and subsequent SGEs for payload, handling
> > GDMA work request flags, advertising RTE_ETH_TX_OFFLOAD_TCP_TSO, and
> > handling non-TSO fallback checksums.
> >
> > Hardware TSO segmentation was verified on Azure Standard_D8ds_v6 (kerne=
l
> > 6.8.0-1067-azure, MANA PCI 7870:00:00.0; driver reports no firmware
> > version) between two VMs on one subnet using an earlier revision of
> > this series:
> > - VM A ran testpmd txonly, modified locally to emit TCP packets with
> >   RTE_MBUF_F_TX_TCP_SEG set (not part of this series), after
> >   "csum set ip hw 0", "csum set tcp hw 0" and "tso set 1460 0".
> > - VM B captured the frames with tcpdump on its kernel interface, GRO of=
f.
> > - A 4000-byte IPv4 packet in a single mbuf, in mbufs with a header-only
> >   first segment, and in mbufs with payload in the first segment, each
> >   arrived as 1514, 1514 and 1080 byte frames with consecutive TCP
> >   sequence numbers, per-segment IP IDs and valid IP and TCP checksums.
> > - Plain UDP with "tso set 0" was unaffected.
> > - The drop paths (packets exceeding segment limit, oversized MSS or
> >   header) and IPv6 TSO were not exercised on hardware.
> >
> > The v3 changes (hardware field bounds for MSS and header length,
> > loop bound, unsegmented fallback checksum masking, and dev_info limit
> > advertisement) were compile-tested but have not been re-run on hardware=
.
> >
> > v3:
> > - Patch 1: no changes.
> > - Patch 2:
> >   * Mask RTE_MBUF_F_TX_TCP_SEG in the non-TSO fallback branch so
> >     rte_ipv4_phdr_cksum / rte_ipv6_phdr_cksum calculate the full L4
> >     length into the pseudo-header checksum.
> >   * Reject invalid TSO packets (tso_segsz > MANA_TSO_MAX_SEGSZ or
> >     gso_hs > UINT8_MAX) to prevent hardware bitfield truncations.
> >   * Reflect the extra SGE for TSO in dev_info by setting nb_seg_max to
> >     max_sge - 1 (keeping nb_mtu_seg_max as max_sge) instead of a mana.r=
st
> >     limitation note.
> >   * Bound the TSO segment walk by expected_sge and verify SGE count.
> >   * Streamline commit message and cover letter.
> >
> > v2:
> > - Patch 1:
> >   * Drop unsendable packets and return a separate consumed count (nb_do=
ne)
> >     instead of breaking out of the burst; break only when the ring is f=
ull.
> >   * Move MAX_SGL_ENTRIES_FOR_TRANSMIT clamp from patch 2 to patch 1, an=
d
> >     clamp dev_info nb_seg_max and nb_mtu_seg_max.
> > - Patch 2:
> >   * Use the drop path for all per-packet TSO validation failures.
> >   * Honour implied TCP checksum when RTE_MBUF_F_TX_TCP_SEG is set but t=
he
> >     packet is unsegmented.
> >   * Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 adjacent to
> >     struct gdma_work_request.
> >   * Add release notes entry and update mana.ini feature matrix.
> >
> > Tathagat Priyadarshi (2):
> >   net/mana: fix transmit burst error handling
> >   net/mana: add hardware TSO support
> >
> >  doc/guides/nics/features/mana.ini      |   1 +
> >  doc/guides/rel_notes/release_26_11.rst |   4 +
> >  drivers/net/mana/gdma.c                |   5 +
> >  drivers/net/mana/mana.c                |   9 +-
> >  drivers/net/mana/mana.h                |   9 +-
> >  drivers/net/mana/tx.c                  | 206 +++++++++++++++++++++----
> >  6 files changed, 195 insertions(+), 39 deletions(-)
> >
>
> I can apply it as is. But you may want to look at the length issues
> reported in AI review
>
> Subject: Re: [PATCH v3 0/2] net/mana: tx burst fixes and TSO
>
> Applied to main (e3e29ed), net/mana builds clean with -Dwerror=3Dtrue
> at each commit. Fixes: hashes verified.
>
> Patch 1 drops invalid packets and counts them in the returned value,
> which is the right tx_burst contract. The SGL bound fix is correct.
> No findings on patch 1.
>
> Patch 2 follows the Linux mana TSO path (header in SGE0,
> OOB_IN_SGL | PAD_BY_SGE0, tot_len/payload_len zeroed, pseudo-header
> seeded without length). Field widths match: last_v_bytes is 8 bits,
> client_data_unit is 14 bits.
>
> [PATCH v3 2/2] net/mana: add hardware TSO support
>
> Info: l4_len is not validated. tcp_hdr->cksum is written at
> l2_len + l3_len + 16, so with l4_len < 20 the write can land past
> data_len, and SGE0 would split the TCP header. Cheap to reject:
>
>         if (unlikely(m_pkt->l4_len < sizeof(struct rte_tcp_hdr) ||
>                      m_pkt->data_len < gso_hs ||
>                      gso_hs > UINT8_MAX)) {
>
> Info: total TSO length is not bounded. pkt_len can exceed 64K with
> a long chain. If the hardware has a limit on TSO payload, check
> pkt_len - gso_hs against it and drop.
>
> Info: the header fixups (IPv4 total_length/hdr_checksum, IPv6
> payload_len, TCP cksum) write into packet data from tx_burst. An
> application holding a reference to the mbuf (e.g. for retransmit)
> sees the modified headers. tx_pkt_prepare is the ethdev hook for
> this; the existing checksum path already does the same thing, so
> not a blocker for this series.
>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

Hi Stephen,

Thanks for the review and build verification! Please apply v3 as is.

I'll send a separate patch for the l4_len validation. The TSO payload
limit isn't documented,
so I left it unbounded for now and will add a check if I find the
hardware limit.
I will also look into adding tx_pkt_prepare for MANA.

If you'd rather have the l4_len change in a v4, let me know
