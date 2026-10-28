Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D351606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KHmhfMXx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9F340151;
	Wed, 28 Oct 2026 15:00:57 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 244DB400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:00:55 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8a06454116eso548696b3a.1
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793196053;
 x=1793800853; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uHwfh0xvbTZGU94DRVt6YCbLzpFElZuiA1msHaGhS5s=;
 b=KHmhfMXxponv6e4M8v7WpGhci/4WWNPlJplsbzuxMWipYqbqbh3KrjoZaTB1ijyKEP
 qHRx1uv0bX0JuTRP8vY07MFBbaZMbqQpOIFDDX1pe35ghe71eZivCj0IXZRuEZGUiMzh
 xGa4Kzj3MK8OfjkVOUxvw4akJdxi6mk18HwzxgwsHrsIS1W3Um2P5B6K6tnderdQzKLF
 jw0stRSKRBmYyv2zFCBZZ7dRc8T59TJJE7Nj0/fu2T14su1ZIccZtGR10E1iR+qlRS0o
 wCCQOciYlFsFfnIUQM9TsGcJutQXO0aRcrxYfGxesobSSqn5tIuHo/2pYL3Q6RtgK2BZ
 qMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196053; x=1793800853;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHwfh0xvbTZGU94DRVt6YCbLzpFElZuiA1msHaGhS5s=;
 b=wC0w8JU3drr+kfQPBgQFcYWK5nZidSbQ4SxjPEn+uqunTSbA2H3/saEXLgwrw+XdUO
 YM/+n3pGKCjTRhC2frXcQZZxQLBBuycAoxdv0oAvWE3fzxNTIpHfZ4mXqs+F32xbjJ/U
 I2tQzwkrLKlji6mQ8iXwf0SIv4coOSNcDHaviI8qWPpzqtuVrEWL4rH0/agNTZx/skNr
 nD/874ar8rrwXpfBcrSTjgFG8VUpTj2xLGauoNfFRfSlVaivaH/NyCZwLuDLAy2OFJTk
 MAOcYnyohj4cvE95+tP8bstwHvKHWCU7tAUVpG3VoRDEuESssTrLglNbc9+dA/b4lnKK
 xwhw==
X-Gm-Message-State: AFq9FYK2vtFD42E3GXFp5h7uF9yi1FSTZOWn7V/dmdEJfmKoNKUpS1rv
 nR6jSiSf/wmiOUmqHrZzESjAZPXnfXYtvTehfiigtB3U/ZUFS8kKnFAD+NT/M7/HZaM=
X-Gm-Gg: AYBFou1SuVXS+dZ9GF/si5bX3ouDPkAo1JR0DBfZI/MYLBgibllUQCkA9NG3/lOYHsR
 TQV/7BKEqbtAQfnvdBlA8J9ns/hmawCdW0l19RP/MPqaofliyiPdX1HbvjNZZHnbA0daYsaw9Mc
 4AiaFXQysHZc6O6AHNfyb5nyF2To2glV0KBokYYzriFKkbZNuoZqcgj4vI6M2UYNTU4GzvOwOPV
 bcw30ib9fY8IjEK4eQ3Gj0iugkll/9Cy65d+3ADGGP/xpU49//mPSFdelqVG0d8Ro1IwQjy8PLX
 ag79Dn/RnvKC1cjGeVkHvwYxd7f+T9foSMRXgcyv7CxIKbQ7ur/aFEqMqNj0+31cAmN/iygYojR
 0SaDLjzpZSMtHFhjHYvLVG+3hQhM4rGz2RRo25mYpToE5GnRX4KJbNhfM0dLwp/7gspNHmLMQ1g
 SD8RrQr16t6EkD9cesYuKNBI/OtbNKHCSvTOTtVgd56EfRa9TF09XI1B1+ivItGqRtW1tSijcLo
 3y+32FGmHzVvpTMOK6pK9XvTPX+Ac3ixmiP9iloIBSfQ3ME0L1blF7iI3HE+ght8AeYglpCV2bi
 oP5AU97oOfE+NPK+zKelnzRDAyHXrsJ5Q23JxrOOfCsIVg/mvmvEMUJG8AzJR1i8U7VyXnM=
X-Received: by 2002:a05:6a00:9292:b0:89e:a4f5:3f1 with SMTP id
 d2e1a72fcca58-8a6e7acaf1dmr2156220b3a.15.1793196053202; 
 Wed, 28 Oct 2026 07:00:53 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a5f660b3sm1220707b3a.10.2026.10.28.07.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:00:51 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:00:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, weh@microsoft.com, longli@microsoft.com
Subject: Re: [PATCH v3 0/2] net/mana: fix tx burst error handling and add
 TSO support
Message-ID: <20261028070048.168f3605@phoenix.local>
In-Reply-To: <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 18:21:13 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This series fixes transmit burst error handling and adds hardware TCP
> segmentation offload (TSO) for the Microsoft Azure MANA PMD.
> 
> Patch 1 drops packets that fail validation, counting them in
> stats.errors and consuming them, so rte_eth_tx_burst() maintains a
> contiguous prefix and short returns reflect only ring backpressure.
> It also clamps segment limits to MAX_SGL_ENTRIES_FOR_TRANSMIT.
> 
> Patch 2 implements hardware TSO for IPv4 and IPv6 TCP traffic,
> formatting SGE0 for headers and subsequent SGEs for payload, handling
> GDMA work request flags, advertising RTE_ETH_TX_OFFLOAD_TCP_TSO, and
> handling non-TSO fallback checksums.
> 
> Hardware TSO segmentation was verified on Azure Standard_D8ds_v6 (kernel
> 6.8.0-1067-azure, MANA PCI 7870:00:00.0; driver reports no firmware
> version) between two VMs on one subnet using an earlier revision of
> this series:
> - VM A ran testpmd txonly, modified locally to emit TCP packets with
>   RTE_MBUF_F_TX_TCP_SEG set (not part of this series), after
>   "csum set ip hw 0", "csum set tcp hw 0" and "tso set 1460 0".
> - VM B captured the frames with tcpdump on its kernel interface, GRO off.
> - A 4000-byte IPv4 packet in a single mbuf, in mbufs with a header-only
>   first segment, and in mbufs with payload in the first segment, each
>   arrived as 1514, 1514 and 1080 byte frames with consecutive TCP
>   sequence numbers, per-segment IP IDs and valid IP and TCP checksums.
> - Plain UDP with "tso set 0" was unaffected.
> - The drop paths (packets exceeding segment limit, oversized MSS or
>   header) and IPv6 TSO were not exercised on hardware.
> 
> The v3 changes (hardware field bounds for MSS and header length,
> loop bound, unsegmented fallback checksum masking, and dev_info limit
> advertisement) were compile-tested but have not been re-run on hardware.
> 
> v3:
> - Patch 1: no changes.
> - Patch 2:
>   * Mask RTE_MBUF_F_TX_TCP_SEG in the non-TSO fallback branch so
>     rte_ipv4_phdr_cksum / rte_ipv6_phdr_cksum calculate the full L4
>     length into the pseudo-header checksum.
>   * Reject invalid TSO packets (tso_segsz > MANA_TSO_MAX_SEGSZ or
>     gso_hs > UINT8_MAX) to prevent hardware bitfield truncations.
>   * Reflect the extra SGE for TSO in dev_info by setting nb_seg_max to
>     max_sge - 1 (keeping nb_mtu_seg_max as max_sge) instead of a mana.rst
>     limitation note.
>   * Bound the TSO segment walk by expected_sge and verify SGE count.
>   * Streamline commit message and cover letter.
> 
> v2:
> - Patch 1:
>   * Drop unsendable packets and return a separate consumed count (nb_done)
>     instead of breaking out of the burst; break only when the ring is full.
>   * Move MAX_SGL_ENTRIES_FOR_TRANSMIT clamp from patch 2 to patch 1, and
>     clamp dev_info nb_seg_max and nb_mtu_seg_max.
> - Patch 2:
>   * Use the drop path for all per-packet TSO validation failures.
>   * Honour implied TCP checksum when RTE_MBUF_F_TX_TCP_SEG is set but the
>     packet is unsegmented.
>   * Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 adjacent to
>     struct gdma_work_request.
>   * Add release notes entry and update mana.ini feature matrix.
> 
> Tathagat Priyadarshi (2):
>   net/mana: fix transmit burst error handling
>   net/mana: add hardware TSO support
> 
>  doc/guides/nics/features/mana.ini      |   1 +
>  doc/guides/rel_notes/release_26_11.rst |   4 +
>  drivers/net/mana/gdma.c                |   5 +
>  drivers/net/mana/mana.c                |   9 +-
>  drivers/net/mana/mana.h                |   9 +-
>  drivers/net/mana/tx.c                  | 206 +++++++++++++++++++++----
>  6 files changed, 195 insertions(+), 39 deletions(-)
> 

I can apply it as is. But you may want to look at the length issues
reported in AI review 

Subject: Re: [PATCH v3 0/2] net/mana: tx burst fixes and TSO

Applied to main (e3e29ed), net/mana builds clean with -Dwerror=true
at each commit. Fixes: hashes verified.

Patch 1 drops invalid packets and counts them in the returned value,
which is the right tx_burst contract. The SGL bound fix is correct.
No findings on patch 1.

Patch 2 follows the Linux mana TSO path (header in SGE0,
OOB_IN_SGL | PAD_BY_SGE0, tot_len/payload_len zeroed, pseudo-header
seeded without length). Field widths match: last_v_bytes is 8 bits,
client_data_unit is 14 bits.

[PATCH v3 2/2] net/mana: add hardware TSO support

Info: l4_len is not validated. tcp_hdr->cksum is written at
l2_len + l3_len + 16, so with l4_len < 20 the write can land past
data_len, and SGE0 would split the TCP header. Cheap to reject:

	if (unlikely(m_pkt->l4_len < sizeof(struct rte_tcp_hdr) ||
		     m_pkt->data_len < gso_hs ||
		     gso_hs > UINT8_MAX)) {

Info: total TSO length is not bounded. pkt_len can exceed 64K with
a long chain. If the hardware has a limit on TSO payload, check
pkt_len - gso_hs against it and drop.

Info: the header fixups (IPv4 total_length/hdr_checksum, IPv6
payload_len, TCP cksum) write into packet data from tx_burst. An
application holding a reference to the mbuf (e.g. for retransmit)
sees the modified headers. tx_pkt_prepare is the ethdev hook for
this; the existing checksum path already does the same thing, so
not a blocker for this series.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
