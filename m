Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E647606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ovyW2+id
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2881A400D7;
	Tue, 27 Oct 2026 15:03:00 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mails.dpdk.org (Postfix) with ESMTPS id D68A0400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:02:57 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso3299476a91.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793109776;
 x=1793714576; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3QxjEEzVtRFlXcYPBZEPnbqNZAlRKtO0fvV8WZqEz3Q=;
 b=ovyW2+idUNoEpue2t2JvFf44YE8+SvCoSGLEB+dzcwVYxR2smpQz+rLjSfii4+B7KV
 MAaMQtZFgRxFb2eiDV6z9eQvo5/ZYOECyipm5ADDUh7uqIo8BA062D2fRzGa8PfzkUZk
 5Brt33sGblbNKVGIbOj1J1rViCJB0zKoX8tgHM8PQs2X+2sZoYF3gtMd4uv6TPjWc+lA
 /RChnoubAE1oYMLLUhCGWr1EKUr3tPFYB8P4v5RpCKO0xVa9OzI4U5PrtG7Ua+EY4ubK
 eC4KhF0VkDZ1AxvNidswtGHUeNStr9IepFOsfMp7osPoNxBUmO3dzXHPnJWh42iHULvF
 YgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109776; x=1793714576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3QxjEEzVtRFlXcYPBZEPnbqNZAlRKtO0fvV8WZqEz3Q=;
 b=GjtDMR5veuusAAMAxxT2NCBqmHwrRcJt7B2NJMPBIrCyXrsV/XXzwc1da4RWASwWqq
 dg5fHFW4fxsrUSsd8NOs+yp3+1fsEfrn4xOpF7Lg8vXT4lBYgQvedL9j0Oa1ZGynVCou
 dOSmLs5X/J2vCa07D0TFBd3KJNw3hTFYQHNPNkdQh8ATnxNsAy19gjP6wT1JTfYcQx96
 qkOsRIkBeKvYhcFpgPuoJgrnz6MSPE1RtJkv5cWWKjDHuP1lS0/ek2uSvPH2mEpXyuxH
 a7yarDAt7DMjLXXRo3W+E17s06dZBaH2uBl1zDMJZvz4nv+K7aB4g540K9pK/G72TN7U
 ePyw==
X-Gm-Message-State: AFq9FYL4y4pxN4cZiT3yD56PW5W8hGRoJ9Bxr/ULGcDqDGdwAFvlJNM7
 ww0I+kBpgt4JvSoQ80+KbV/E7fBhflhQCrSHNg5vMJFRY+kEYZZTJMMn90fzEaf9J08=
X-Gm-Gg: AYBFou0M0GFlwB/ZNuIcnoaKVEXxg0qJ5r/pd7Yex8+w7Bs4tDbqgzyif3pyLlAzhPY
 7PO5VBadE6qUOWhimkA8wwnObCcNq64NbAWrcubHXoIy9SEKCO/sCoOBLzwzt2K2DJpPnJ6IoFI
 X17wD4EBO82XY0uoSyclAxbc+atXm+OUCQdeoG3xZ70L07K1bj6PK7uo2j1C2OSRtIP9Pekv4s0
 hNBAQ+qH729bIMpKBSHOmU8Uv4/+ePPqFci84uN1MGkthF095rDq2/y0Lk4Cmc4f/znjbPJx8Vt
 5tD8esQxloofvDanSa5ccOkQ2V6MamGOI5j+s2e7rso0g14go66M58oA98CKuMqgV/8zQIiteIM
 zHcKNldhydkIof05PLz9+2pONmKlteJDMvbWnJvUn/KjNlcwjmR/bHMoMOCp+1IR1XVD9j/Xs6v
 rF0XNncb31HSBoQSQ6Tkir6nTWVONI0dj7YAY9Z86CujWG/jN7uTO/V9Usnt75mQnnLNkdR4zNK
 IYNCv9ezO9hYHyM9DXFBdRckp3k15keuPdJ+CJ1CD35VVIdibgBW1C0KyZSPaN469ko1G1iHxtv
 Q9Di59C054Bd2PIm/kvUUw==
X-Received: by 2002:a17:90b:1812:b0:3aa:fdad:7d6e with SMTP id
 98e67ed59e1d1-3adeac04979mr8596565a91.10.1793109775595; 
 Tue, 27 Oct 2026 07:02:55 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebae7f3csm8876018a91.3.2026.10.27.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:02:54 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:02:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, weh@microsoft.com, longli@microsoft.com
Subject: Re: [PATCH v2 0/2] net/mana: fix tx burst error handling and add
 TSO support
Message-ID: <20261027070250.0f8fa630@phoenix.local>
In-Reply-To: <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
 <20261026212125.3193356-1-tathagat.dpdk@gmail.com>
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

On Mon, 26 Oct 2026 21:21:23 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This series fixes error handling in the MANA transmit burst and adds
> hardware TCP segmentation offload (TSO).
> 
> Patch 1 drops a packet that cannot be sent, counting it in stats.errors,
> instead of skipping or stalling on it, so rte_eth_tx_burst() keeps
> returning a contiguous prefix and a short return means only a full ring.
> It also bounds the segment count by the size of the SGL array.
> 
> Patch 2 adds hardware TSO for IPv4 and IPv6 TCP packets.
> 
> Testing on Azure Standard_D8ds_v6 (kernel 6.8.0-1067-azure, MANA PCI
> 7870:00:00.0; the driver reports no firmware version), two VMs on one
> subnet:
> - VM A ran testpmd txonly, modified locally to emit TCP packets with
>   RTE_MBUF_F_TX_TCP_SEG set (not part of this series), after
>   "csum set ip hw 0", "csum set tcp hw 0" and "tso set 1460 0".
> - VM B captured the frames with tcpdump on its kernel interface, GRO off.
> - A 4000-byte IPv4 packet in a single mbuf, in mbufs with a header-only
>   first segment, and in mbufs with payload in the first segment, each
>   arrived as 1514, 1514 and 1080 byte frames with consecutive TCP
>   sequence numbers, per-segment IP IDs and valid IP and TCP checksums.
> - Plain UDP with "tso set 0" was unaffected.
> IPv6 TSO was not tested.
> 
> v2:
> - Patch 1:
>   * Drop unsendable packets and return a separate consumed count instead
>     of breaking out of the burst; break only when the ring is full.
>   * Move the MAX_SGL_ENTRIES_FOR_TRANSMIT check here from patch 2, limit
>     nb_seg_max and nb_mtu_seg_max to it, and add Fixes and Cc stable.
> - Patch 2:
>   * Use the drop path for all per-packet TSO failures.
>   * Honour the TCP checksum implied by RTE_MBUF_F_TX_TCP_SEG when the
>     packet is sent unsegmented.
>   * Bound the TSO segment walk and check the SGE count against the
>     expected one, instead of the unreachable check in the loop.
>   * Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 next to
>     struct gdma_work_request.
>   * Document the extra SGE in mana.rst, add a release note, and rewrite
>     the commit message.
> 
> With the drop-and-continue path, CQE suppression is back to the original
> behavior where only an uncompleted final packet of a burst may wait for a
> subsequent burst to generate a CQE.
> 
> Tathagat Priyadarshi (2):
>   net/mana: fix transmit burst error handling
>   net/mana: add hardware TSO support
> 
>  doc/guides/nics/features/mana.ini      |   1 +
>  doc/guides/nics/mana.rst               |   8 ++
>  doc/guides/rel_notes/release_26_11.rst |   4 +
>  drivers/net/mana/gdma.c                |   5 +
>  drivers/net/mana/mana.c                |   4 +-
>  drivers/net/mana/mana.h                |   6 +-
>  drivers/net/mana/tx.c                  | 191 +++++++++++++++++++++----
>  7 files changed, 186 insertions(+), 33 deletions(-)
> 

AI review still turning up errors here.

Review: [PATCH v2 0/2] net/mana: tx error handling and TSO

Patch 1/2 is a good fix. Patch 2/2 has two hardware field width
truncations and a checksum bug in the new non-TSO fallback.


[PATCH v2 1/2] net/mana: fix transmit burst error handling

Info

  Dropping a packet now happens mid-burst, after the previous WQE may
  have been posted with suppress_tx_CQE_generation set (the decision
  is made on pkt_idx + 1 < nb_pkts). If every remaining packet in the
  burst is dropped, the last posted WQE has no CQE and its mbufs (and
  any suppressed ones before it) are not reclaimed until a later burst
  posts another WQE. Same for the post-failure break and the 32-bit
  wqe_count break. Pre-existing, not a blocker here, but worth a
  follow-up: decide suppression after validation of the next packet,
  or never suppress the last WQE before ringing the doorbell.


[PATCH v2 2/2] net/mana: add hardware TSO support

Error

  Non-TSO fallback computes the wrong pseudo-header checksum.
  The fallback branch is entered for TCP_SEG packets with
  tso_segsz == 0 or no payload, and passes m_pkt->ol_flags (with
  RTE_MBUF_F_TX_TCP_SEG still set) to rte_ipv4_phdr_cksum() /
  rte_ipv6_phdr_cksum(). Those helpers use length 0 when TCP_SEG is
  set, so the seed is wrong for an unsegmented frame and the hardware
  emits a bad TCP checksum. Mask the flag:

	uint64_t ol = m_pkt->ol_flags & ~RTE_MBUF_F_TX_TCP_SEG;
	...
	tcp_hdr->cksum = rte_ipv4_phdr_cksum(ip_hdr, ol);

  Also, TCP_SEG with tso_segsz == 0 or l4_len == 0 is invalid input
  per the mbuf API. With gso_hs == 0 the fallback writes cksum at
  l2_len + l3_len == 0, corrupting the Ethernet header. Drop these
  instead of sending them:

	if (m_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
		if (unlikely(m_pkt->tso_segsz == 0 ||
			     m_pkt->l4_len == 0 ||
			     m_pkt->data_len < gso_hs))
			goto drop;
		is_tso = m_pkt->pkt_len > gso_hs;
	}

Error

  client_data_unit is a 14-bit field in struct gdma_wqe_dma_oob, but
  tso_segsz is uint16_t. Any tso_segsz >= 16384 is silently
  truncated; 16384 becomes 0 == NOT_USING_CLIENT_DATA_UNIT and a
  64KB frame is handed to the wire unsegmented. Reject it:

	#define MANA_TSO_MAX_SEGSZ ((1u << 14) - 1)

	if (unlikely(m_pkt->tso_segsz > MANA_TSO_MAX_SEGSZ))
		goto drop;

Error

  last_v_bytes is an 8-bit field, but gso_hs is
  l2_len + l3_len + l4_len and can exceed 255 (IPv6 extension headers,
  VLAN plus TCP options). gdma.c writes sgl[0].size into it and the
  value wraps. Drop TSO packets with gso_hs > UINT8_MAX, or state the
  real hardware header limit and check against that.

Warning

  The extra SGE for a TSO header split is documented as a limitation
  but not reflected in dev_info. tx_desc_lim.nb_seg_max is the TSO
  limit (nb_mtu_seg_max is the non-TSO one), so applications and
  rte_gso trusting it build packets that are then dropped. Advertise
  the real limit and drop the mana.rst paragraph:

	uint16_t max_sge = RTE_MIN(priv->max_send_sge,
				   MAX_SGL_ENTRIES_FOR_TRANSMIT);

	dev_info->tx_desc_lim.nb_seg_max = max_sge - 1;
	dev_info->tx_desc_lim.nb_mtu_seg_max = max_sge;

Warning

  No bounds on the TSO request beyond the above. What is the maximum
  payload (pkt_len - gso_hs) and the minimum MSS the adapter accepts?
  Check both in the TSO validation and drop out-of-range packets,
  rather than leaving it to the device.

Info

  The TSO and non-TSO SGL loops duplicate the MR lookup and SGE fill.
  One loop with a start offset on the first segment covers both:

	uint32_t off = 0;

	num_sge = 0;
	if (is_tso) {
		/* SGE0: headers only */
		if (fill_sge(&sgl, num_sge++, m_pkt, 0, gso_hs, mr))
			goto drop;
		off = gso_hs;
	}
	for (m_seg = m_pkt; m_seg; m_seg = m_seg->next, off = 0) {
		if (m_seg->data_len == off)
			continue;
		if (fill_sge(&sgl, num_sge++, m_seg, off,
			     m_seg->data_len - off, mr))
			goto drop;
	}

  With expected_sge already checked against the array size, the
  m_seg != NULL || num_sge != expected_sge re-check goes away.

Info

  Header rewriting (total_length, hdr_checksum, cksum) in tx_burst
  modifies data the application may share (refcnt > 1, external
  buffers). The existing TCP_CKSUM path does the same, so not new,
  but the conventional place is tx_pkt_prepare. A mana_tx_prepare()
  using rte_validate_tx_offload() and rte_net_intel_cksum_prepare()
  would also move the segment-count checks out of the fast path.

Info

  Commit message: drop "allowing transmit bursts of up to 64KB TCP
  packets at wire speed". The test log is useful, but belongs below
  the "---" line, not in the permanent history.
