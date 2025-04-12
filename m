Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF1C369A1
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Apr 2025 09:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B55E940658;
	Sat, 12 Apr 2025 11:59:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4C4B640285
 for <dev@dpdk.org>; Sat, 12 Apr 2025 11:59:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DD94D207AC;
 Sat, 12 Apr 2025 11:59:13 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 08/13] mbuf: add fields for mirroring
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 12 Apr 2025 11:59:10 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FBC8@smartserver.smartshare.dk>
In-Reply-To: <20250411234927.114568-9-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 08/13] mbuf: add fields for mirroring
Thread-Index: AdurPIpb4VgFOPMLQGGT6CJwg9IkhQAT1wPg
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-9-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Saturday, 12 April 2025 01.45
>=20
> Add field to union used for sched/event etc, for use when
> an mbuf is mirrored.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/mbuf/rte_mbuf_core.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> index a0df265b5d..1806dddd67 100644
> --- a/lib/mbuf/rte_mbuf_core.h
> +++ b/lib/mbuf/rte_mbuf_core.h
> @@ -589,6 +589,14 @@ struct __rte_cache_aligned rte_mbuf {
>  						 * @see
> rte_event_eth_tx_adapter_txq_set()
>  						 */
>  					} txadapter; /**< Eventdev ethdev Tx
> adapter */
> +					struct rte_mbuf_mirror {
> +						uint32_t orig_len;
> +						uint16_t queue_id;
> +						uint16_t direction;
> +						/**< Port mirroring uses this to
> store origin
> +						 * @see rte_eth_mirror()
> +						 */
> +					} mirror;
>  					uint32_t usr;
>  					/**< User defined tags. See
> rte_distributor_process() */
>  				} hash;                   /**< hash information

Stop overloading the "hash" field!

We now have dynfields. The mbuf structure's dedicated fields should be =
limited to absolute core features.

Long term, the "hash" field should be cleaned up.
E.g. if we get rid of the Flow Director and make the 8 byte "sched" =
(Hierarchical Scheduler) a dynfield, the "hash" field can be reduced =
from 8 byte to 4 byte (RSS hash).

I acknowledge that some mbuf fields can be overloaded and thus used for =
multiple purposes - i.e. a value only used for ingress/forwarding (e.g. =
RSS hash) can share an mbuf field with a value only used for egress =
(e.g. Scheduler).

The overloading of the "hash" field is too much already. E.g. can the =
Hierarchical Scheduler be used together with the Eventdev ethdev Tx =
adapter, or are they mutually exclusive due to sharing the same mbuf =
field?

Going to the extreme, we would completely replace the "hash" field by =
dynfields.

In short: Overloading the "hash" field with port mirror information is a =
step in the wrong direction.

> */
> --
> 2.47.2

