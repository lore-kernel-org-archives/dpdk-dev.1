Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD9D108B8EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:10:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21DA1402B2;
	Fri, 20 Mar 2026 11:10:33 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5042D40272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 11:10:32 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 23F77205CA;
 Fri, 20 Mar 2026 11:10:32 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH dpdk] net/tap: add software MAC address filtering
Date: Fri, 20 Mar 2026 11:10:31 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657AB@smartserver.smartshare.dk>
In-Reply-To: <20260319221034.703656-2-rjarry@redhat.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH dpdk] net/tap: add software MAC address filtering
Thread-Index: Ady37UH947h1vOu2RD2IrYu/bsfsbAAYgWQw
References: <20260319221034.703656-2-rjarry@redhat.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Robin Jarry" <rjarry@redhat.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

> +static inline bool
> +tap_mac_filter_match(struct rx_queue *rxq, struct rte_mbuf *mbuf)
> +{
> +	struct pmd_internals *pmd =3D rxq->pmd;
> +	struct rte_eth_dev_data *data;
> +	struct rte_ether_addr *dst;
> +	uint32_t i;
> +
> +	if (!pmd->macfilter)
> +		return true;
> +
> +	data =3D pmd->dev->data;
> +	if (data->promiscuous)
> +		return true;
> +
> +	dst =3D rte_pktmbuf_mtod(mbuf, struct rte_ether_addr *);
> +
> +	if (rte_is_broadcast_ether_addr(dst))
> +		return true;
> +
> +	if (rte_is_multicast_ether_addr(dst)) {
> +		if (data->all_multicast)
> +			return true;
> +		for (i =3D 0; i < pmd->nb_mc_addrs; i++) {
> +			if (rte_is_same_ether_addr(dst, &pmd->mc_addrs[i]))
> +				return true;
> +		}
> +		return false;
> +	}
> +
> +	for (i =3D 0; i < TAP_MAX_MAC_ADDRS; i++) {
> +		if (rte_is_zero_ether_addr(&data->mac_addrs[i]))
> +			continue;
> +		if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
> +			return true;
> +	}
> +	return false;
> +}

Performance optimization; the vast majority of packets are unicast:

if (likely(rte_is_unicast_ether_addr(dst)) {
    if (unlikely(rte_is_zero_ether_addr(dst)))
        return false; /* Invalid destination address in packet */
    /* Note: Compiler loop unrolls. */
    for (i =3D 0; i < TAP_MAX_MAC_ADDRS; i++) {
        if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
            return true;
    }
}

if (data->all_multicast)
    return true;

for (i =3D 0; i < pmd->nb_mc_addrs; i++) {
    if (rte_is_same_ether_addr(dst, &pmd->mc_addrs[i]))
        return true;
}

if (rte_is_broadcast_ether_addr(dst))
    return true;

return false;

Also, all the variables and function parameters could be "const"; =
although I don't know if it makes any practical difference.


>  static int
> -tap_set_mc_addr_list(struct rte_eth_dev *dev __rte_unused,
> -		     struct rte_ether_addr *mc_addr_set __rte_unused,
> -		     uint32_t nb_mc_addr __rte_unused)
> +tap_set_mc_addr_list(struct rte_eth_dev *dev,
> +		     struct rte_ether_addr *mc_addr_set,
> +		     uint32_t nb_mc_addr)
>  {
> -	/*
> -	 * Nothing to do actually: the tap has no filtering whatsoever,
> every
> -	 * packet is received.
> -	 */
> +	struct pmd_internals *pmd =3D dev->data->dev_private;
> +
> +	if (nb_mc_addr =3D=3D 0) {
> +		rte_free(pmd->mc_addrs);
> +		pmd->mc_addrs =3D NULL;
> +		pmd->nb_mc_addrs =3D 0;
> +		return 0;
> +	}
> +
> +	pmd->mc_addrs =3D rte_realloc(pmd->mc_addrs,
> +				    nb_mc_addr * sizeof(*pmd->mc_addrs), 0);
> +	if (pmd->mc_addrs =3D=3D NULL) {
> +		pmd->nb_mc_addrs =3D 0;
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(pmd->mc_addrs, mc_addr_set,
> +	       nb_mc_addr * sizeof(*pmd->mc_addrs));
> +	pmd->nb_mc_addrs =3D nb_mc_addr;
> +
>  	return 0;
>  }

This is not thread safe.
If it needs to be thread safe, you must ensure that =
tap_mac_filter_match() - running on another lcore - is done using the =
mc_addrs array before you free it here.

