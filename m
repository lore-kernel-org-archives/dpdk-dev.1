Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140BC83F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 02:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A855402CA;
	Wed, 23 Jul 2025 04:32:51 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 85EF64026D
 for <dev@dpdk.org>; Wed, 23 Jul 2025 04:32:49 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id EE114E080B;
 Wed, 23 Jul 2025 06:32:47 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am EE114E080B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753237968;
 bh=RisyYLjje8yStBUz0GQoxjAd2+RHNxzmZtZXbqCXiqc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=VIGCYHdKn9yc0MNwNEoB8UNrpQ5NE6v8UehTYZ/y9t+ulgtemBSD3ogZf2Qv0Vtlp
 U2HQST7C2ragFubVl4jaA6Sq4vIn5g3WjB+d0poAAwZswaa0TsAzNR4QCAw6W6CT7O
 QTaWrzTodNAEeN2U3hTFRWj3sKGB/EsH5qGV+W8nB8Pt6tiDesEH5kPyMYNJrnJ/wj
 JgaKjNfqTaPMhNg+ZnqDwzZaWZQqFyM9iODyp3pwO6EFV8E+19NRG03SpXS9GgsqoX
 i7HrsBfCe7bLVQiparO3pDQjJYyFxR7uvbRiEV7YxeJMaJEAhUX4QDYOVQy0e5iuFU
 fl7DUWMj30OFw==
Date: Wed, 23 Jul 2025 06:32:45 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v6 08/13] pcapng: split packet copy from header insertion
In-Reply-To: <20250722173552.184141-9-stephen@networkplumber.org>
Message-ID: <26484aa4-4065-04de-8327-263178b81ece@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-9-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Stephen,

On Tue, 22 Jul 2025, Stephen Hemminger wrote:

> In new model, the packet was already copied, only need

Copied? But what if it was "indirect attached" instead, as the model envisages?

Perhaps this is a silly question of mine, but it may not be clear what happens
in case of 'RTE_ETH_MIRROR_INDIRECT_FLAG' - whether it is safe to modify the
mbuf and whether the 'indirect' clone has to be "freed" in the sense of being
detached/refcnt updated after successful pcapng write, to avoid memory leaks?

> to wrap it in pcapng format.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> lib/pcapng/rte_pcapng.c | 178 +++++++++++++++++++++-------------------
> lib/pcapng/rte_pcapng.h |  27 +++++-
> 2 files changed, 120 insertions(+), 85 deletions(-)
>
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index 2a07b4c1f5..6db5d4da50 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -1,3 +1,4 @@
> +
> /* SPDX-License-Identifier: BSD-3-Clause
>  * Copyright(c) 2019 Microsoft Corporation
>  */
> @@ -432,8 +433,24 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
> 	return 0;
> }
>
> +/* pad the packet to 32 bit boundary */
> +static inline int
> +pcapng_mbuf_pad32(struct rte_mbuf *m)
> +{
> +	uint32_t pkt_len = rte_pktmbuf_pkt_len(m);
> +	uint32_t padding = RTE_ALIGN(pkt_len, sizeof(uint32_t)) - pkt_len;
> +
> +	if (padding > 0) {
> +		void *tail = rte_pktmbuf_append(m, padding);

If the packet was indirectly attached in fact, is this OK to do? Just asking.

Thank you.

> +		if (tail == NULL)
> +			return -1;
> +		memset(tail, 0, padding);
> +	}
> +	return 0;
> +}
> +
> /*
> - *   The mbufs created use the Pcapng standard enhanced packet  block.
> + *  The mbufs created use the Pcapng standard enhanced packet block.
>  *
>  *                         1                   2                   3
>  *     0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
> @@ -468,71 +485,28 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
>  *    |                      Block Total Length                       |
>  *    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>  */
> -
> -/* Make a copy of original mbuf with pcapng header and options */
> -RTE_EXPORT_SYMBOL(rte_pcapng_copy)
> -struct rte_mbuf *
> -rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> -		const struct rte_mbuf *md,
> -		struct rte_mempool *mp,
> -		uint32_t length,
> -		enum rte_pcapng_direction direction,
> -		const char *comment)
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_insert, 25.07)
> +int
> +rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
> +		  enum rte_pcapng_direction direction, uint32_t orig_len,
> +		  uint64_t timestamp, const char *comment)
> {
> 	struct pcapng_enhance_packet_block *epb;
> -	uint32_t orig_len, pkt_len, padding, flags;
> -	struct pcapng_option *opt;
> -	uint64_t timestamp;
> -	uint16_t optlen;
> -	struct rte_mbuf *mc;
> -	bool rss_hash;
> -
> -#ifdef RTE_LIBRTE_ETHDEV_DEBUG
> -	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
> -#endif
> -	orig_len = rte_pktmbuf_pkt_len(md);
> +	uint32_t pkt_len = rte_pktmbuf_pkt_len(m);
> +	uint32_t flags;
>
> -	/* Take snapshot of the data */
> -	mc = rte_pktmbuf_copy(md, mp, 0, length);
> -	if (unlikely(mc == NULL))
> -		return NULL;
> -
> -	/* Expand any offloaded VLAN information */
> -	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
> -	     (md->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)) ||
> -	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
> -	     (md->ol_flags & RTE_MBUF_F_TX_VLAN))) {
> -		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_VLAN,
> -				       md->vlan_tci) != 0)
> -			goto fail;
> -	}
> +	if (unlikely(pcapng_mbuf_pad32(m) < 0))
> +		return -1;
>
> -	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
> -	     (md->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)) ||
> -	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
> -	     (md->ol_flags & RTE_MBUF_F_TX_QINQ))) {
> -		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_QINQ,
> -				       md->vlan_tci_outer) != 0)
> -			goto fail;
> -	}
> +	uint16_t optlen = pcapng_optlen(sizeof(flags));
>
> -	/* record HASH on incoming packets */
> -	rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
> -		    (md->ol_flags & RTE_MBUF_F_RX_RSS_HASH));
> +	/* make queue optional? */
> +	optlen += pcapng_optlen(sizeof(queue));
>
> -	/* pad the packet to 32 bit boundary */
> -	pkt_len = rte_pktmbuf_pkt_len(mc);
> -	padding = RTE_ALIGN(pkt_len, sizeof(uint32_t)) - pkt_len;
> -	if (padding > 0) {
> -		void *tail = rte_pktmbuf_append(mc, padding);
> +	/* does packet have valid RSS hash to include */
> +	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
> +			 (m->ol_flags & RTE_MBUF_F_RX_RSS_HASH));
>
> -		if (tail == NULL)
> -			goto fail;
> -		memset(tail, 0, padding);
> -	}
> -
> -	optlen = pcapng_optlen(sizeof(flags));
> -	optlen += pcapng_optlen(sizeof(queue));
> 	if (rss_hash)
> 		optlen += pcapng_optlen(sizeof(uint8_t) + sizeof(uint32_t));
>
> @@ -540,10 +514,10 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> 		optlen += pcapng_optlen(strlen(comment));
>
> 	/* reserve trailing options and block length */
> -	opt = (struct pcapng_option *)
> -		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
> +	struct pcapng_option *opt = (struct pcapng_option *)
> +		rte_pktmbuf_append(m, optlen + sizeof(uint32_t));
> 	if (unlikely(opt == NULL))
> -		goto fail;
> +		return -1;
>
> 	switch (direction) {
> 	case RTE_PCAPNG_DIRECTION_IN:
> @@ -556,24 +530,20 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> 		flags = 0;
> 	}
>
> -	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS,
> -				&flags, sizeof(flags));
> -
> -	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE,
> -				&queue, sizeof(queue));
> +	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
> +	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
>
> 	if (rss_hash) {
> 		uint8_t hash_opt[5];
>
> -		/* The algorithm could be something else if
> -		 * using rte_flow_action_rss; but the current API does not
> -		 * have a way for ethdev to report  this on a per-packet basis.
> +		/* The algorithm could be something else but the current API does not
> +		 * have a way for to record this on a per-packet basis
> +		 * and the PCAPNG hash types don't match the DPDK types.
> 		 */
> 		hash_opt[0] = PCAPNG_HASH_TOEPLITZ;
>
> -		memcpy(&hash_opt[1], &md->hash.rss, sizeof(uint32_t));
> -		opt = pcapng_add_option(opt, PCAPNG_EPB_HASH,
> -					&hash_opt, sizeof(hash_opt));
> +		memcpy(&hash_opt[1], &m->hash.rss, sizeof(uint32_t));
> +		opt = pcapng_add_option(opt, PCAPNG_EPB_HASH, &hash_opt, sizeof(hash_opt));
> 	}
>
> 	if (comment)
> @@ -583,19 +553,14 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> 	/* Note: END_OPT necessary here. Wireshark doesn't do it. */
>
> 	/* Add PCAPNG packet header */
> -	epb = (struct pcapng_enhance_packet_block *)
> -		rte_pktmbuf_prepend(mc, sizeof(*epb));
> +	epb = (struct pcapng_enhance_packet_block *) rte_pktmbuf_prepend(m, sizeof(*epb));
> 	if (unlikely(epb == NULL))
> -		goto fail;
> +		return -1;
>
> 	epb->block_type = PCAPNG_ENHANCED_PACKET_BLOCK;
> -	epb->block_length = rte_pktmbuf_pkt_len(mc);
> -
> -	/* Interface index is filled in later during write */
> -	mc->port = port_id;
> +	epb->block_length = rte_pktmbuf_pkt_len(m);
>
> -	/* Put timestamp in cycles here - adjust in packet write */
> -	timestamp = rte_get_tsc_cycles();
> +	/* Put timestamp in cycles here - adjusted in packet write */
> 	epb->timestamp_hi = timestamp >> 32;
> 	epb->timestamp_lo = (uint32_t)timestamp;
> 	epb->capture_length = pkt_len;
> @@ -603,9 +568,56 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
>
> 	/* set trailer of block length */
> 	*(uint32_t *)opt = epb->block_length;
> +	return 0;
> +}
> +
> +/* Make a copy of original mbuf with pcapng header and options */
> +RTE_EXPORT_SYMBOL(rte_pcapng_copy)
> +struct rte_mbuf *
> +rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> +		const struct rte_mbuf *md,
> +		struct rte_mempool *mp,
> +		uint32_t length,
> +		enum rte_pcapng_direction direction,
> +		const char *comment)
> +{
> +	uint32_t orig_len = rte_pktmbuf_pkt_len(md);
> +	struct rte_mbuf *mc;
>
> -	return mc;
> +#ifdef RTE_LIBRTE_ETHDEV_DEBUG
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
> +#endif
> +
> +	/* Take snapshot of the data */
> +	mc = rte_pktmbuf_copy(md, mp, 0, length);
> +	if (unlikely(mc == NULL))
> +		return NULL;
> +
> +	/* Expand any offloaded VLAN information */
> +	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
> +	     (md->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)) ||
> +	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
> +	     (md->ol_flags & RTE_MBUF_F_TX_VLAN))) {
> +		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_VLAN,
> +				       md->vlan_tci) != 0)
> +			goto fail;
> +	}
> +
> +	if ((direction == RTE_PCAPNG_DIRECTION_IN &&
> +	     (md->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)) ||
> +	    (direction == RTE_PCAPNG_DIRECTION_OUT &&
> +	     (md->ol_flags & RTE_MBUF_F_TX_QINQ))) {
> +		if (pcapng_vlan_insert(mc, RTE_ETHER_TYPE_QINQ,
> +				       md->vlan_tci_outer) != 0)
> +			goto fail;
> +	}
> +
> +	/* Interface index is filled in later during write */
> +	mc->port = port_id;
>
> +	if (likely(rte_pcapng_insert(mc, queue, direction, orig_len,
> +				     rte_get_tsc_cycles(), comment) == 0))
> +		return mc;
> fail:
> 	rte_pktmbuf_free(mc);
> 	return NULL;
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57564..4914ac9622 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -99,7 +99,7 @@ enum rte_pcapng_direction {
> };
>
> /**
> - * Format an mbuf for writing to file.
> + * Make a copy of mbuf for writing to file.
>  *
>  * @param port_id
>  *   The Ethernet port on which packet was received
> @@ -117,7 +117,7 @@ enum rte_pcapng_direction {
>  * @param direction
>  *   The direction of the packer: receive, transmit or unknown.
>  * @param comment
> - *   Packet comment.
> + *   Packet comment (optional).
>  *
>  * @return
>  *   - The pointer to the new mbuf formatted for pcapng_write
> @@ -129,6 +129,29 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
> 		uint32_t length,
> 		enum rte_pcapng_direction direction, const char *comment);
>
> +/**
> + * Format an mbuf for writing to file.
> + *
> + * @param m
> + *   The mbuf to modify.
> + * @param queue
> + *   The queue on the Ethernet port where packet was received
> + *   or is going to be transmitted.
> + * @param direction
> + *   The direction of the packer: receive, transmit or unknown.
> + * @param orig_len
> + *   The length of the original packet which maybe less than actual
> + *   packet if only a snapshot was captured.
> + * @param timestamp
> + *   The timestamp for packet in TSC cycles.
> + * @param comment
> + *   Packet comment (optional).
> + */
> +__rte_experimental
> +int
> +rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
> +		  enum rte_pcapng_direction direction, uint32_t orig_len,
> +		  uint64_t timestamp, const char *comment);
>
> /**
>  * Determine optimum mbuf data size.
> -- 
> 2.47.2
>
>
