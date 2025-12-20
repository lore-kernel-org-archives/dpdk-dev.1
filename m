Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2AE668AE
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Dec 2025 09:05:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38112402B5;
	Sat, 20 Dec 2025 10:05:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A45DB40296
 for <dev@dpdk.org>; Sat, 20 Dec 2025 10:05:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B6E7022B35;
 Sat, 20 Dec 2025 10:05:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 27/27] net/intel: remove index for tracking end of
 packet
Date: Sat, 20 Dec 2025 10:05:45 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65603@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251219172548.2660777-28-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 27/27] net/intel: remove index for tracking end of
 packet
Thread-Index: AdxxDPqPDTlhdlhAQ/+nlVMaOys6kwAgh/vA
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20251219172548.2660777-28-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Friday, 19 December 2025 18.26
>=20
> The last_id value in each tx_sw_queue entry was no longer used in the
> datapath, remove it and its initialization. For the function releasing
> packets back, rather than relying on "last_id" to identify end of
> packet, instead check for the next pointer being NULL.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

[...]

> @@ -2523,14 +2523,13 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue
> *txq,
>  			pkt_cnt < free_cnt &&
>  			tx_id !=3D tx_last; i++) {
>  			if (swr_ring[tx_id].mbuf !=3D NULL) {
> -				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
> -				swr_ring[tx_id].mbuf =3D NULL;
> -
>  				/*
>  				 * last segment in the packet,
>  				 * increment packet count
>  				 */
> -				pkt_cnt +=3D (swr_ring[tx_id].last_id =3D=3D tx_id);
> +				pkt_cnt +=3D (swr_ring[tx_id].mbuf->next =3D=3D NULL)
> ? 1 : 0;

Note to reviewers:
Dereferencing the mbuf (instead of checking last_id) does not add a =
potential cache miss, because rte_pktmbuf_free_seg() dereferences it =
anyway.

> +				rte_pktmbuf_free_seg(swr_ring[tx_id].mbuf);
> +				swr_ring[tx_id].mbuf =3D NULL;
>  			}
>=20
>  			tx_id =3D swr_ring[tx_id].next_id;

