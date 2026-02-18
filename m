Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF93E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:48:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D03FB40299;
	Wed, 18 Feb 2026 09:48:09 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5317D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:48:08 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0DF15206E7;
 Wed, 18 Feb 2026 09:48:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Date: Wed, 18 Feb 2026 09:48:04 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
In-Reply-To: <20260216180011.393782-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Thread-Index: Adyfbh+QQ8hdUf3CSq6qHaLT07yviABNlVGg
References: <20260216180011.393782-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
> Sent: Monday, 16 February 2026 19.00
>=20
> The documentation for rte_eth_tx_burst() uses the word "sent" to
> describe the return value, which is misleading. Packets returned as
> consumed may not have been transmitted yet; they have been accepted
> by the driver and are no longer the caller's responsibility.
>=20
> This matters because the common usage pattern is:
>=20
>     n =3D rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
>     for (i =3D n; i < nb_pkts; i++)
>         rte_pktmbuf_free(mbufs[i]);
>=20
> For this to work correctly, the contract must be:
>  - tx_pkts[0..n-1]: ownership transferred to the driver.
>  - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.
>=20
> Several drivers (and AI-assisted reviews) misinterpret the current
> wording and treat packets with errors as unconsumed, returning a
> short count. This causes callers to retry those packets indefinitely.
> The correct behavior is that the driver must consume (and free)
> erroneous packets, counting them via tx_errors.
>=20
> Replace "sent" with "consumed" in the return value description,
> spell out the mbuf ownership contract, clarify the error handling
> expectation, and update the @return block to match.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ethdev/rte_ethdev.h | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index 0d8e2d0236..9e49c4a945 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -6639,13 +6639,24 @@ uint16_t rte_eth_call_tx_callbacks(uint16_t
> port_id, uint16_t queue_id,
>   * of the ring.
>   *
>   * The rte_eth_tx_burst() function returns the number of packets it
> - * actually sent. A return value equal to *nb_pkts* means that all
> packets
> - * have been sent, and this is likely to signify that other output
> packets
> + * has consumed from the *tx_pkts* array. The driver takes ownership
> of
> + * the mbufs for all consumed packets (tx_pkts[0] to tx_pkts[n-1]);
> + * the caller must not access them afterward. The remaining packets
> + * (tx_pkts[n] to tx_pkts[nb_pkts-1]) are not modified and remain the
> + * caller's responsibility.
> + *
> + * A return value equal to *nb_pkts* means that all packets have been
> + * consumed, and this is likely to signify that other output packets
>   * could be immediately transmitted again. Applications that =
implement
> a
>   * "send as many packets to transmit as possible" policy can check
> this
>   * specific case and keep invoking the rte_eth_tx_burst() function
> until
>   * a value less than *nb_pkts* is returned.
>   *
> + * If a packet cannot be transmitted due to an error (for example, an
> + * invalid offload flag), the driver must still consume it and free
> the
> + * mbuf, rather than stopping at that point. Such packets should be
> + * counted in the *tx_errors* port statistic.

The above paragraph is driver centric, it should be application centric.
Suggest rephrasing as:

If a packet cannot be transmitted due to an error (for example, an =
invalid offload flag), the rte_eth_tx_burst() function will still =
consume it, rather than stopping at that point.
Such packets are counted in the *oerrors* port statistic.

NB: In struct rte_eth_stats [1], the error counter is named "oerrors", =
not "tx_errors".

[1]: =
https://elixir.bootlin.com/dpdk/v25.11/source/lib/ethdev/rte_ethdev.h#L27=
3

While discussing details...
Let's say a packet has 4 segments, and the driver only has 2 descriptors =
remaining available.
In that case, I think the driver should not consume the packet, but =
leave it for the application to either drop it or retry transmitting it =
later.
Do we want to mention this case too, or is it a semi-obvious case of the =
descriptor ring having no more room?

> + *
>   * It is the responsibility of the rte_eth_tx_burst() function to
>   * transparently free the memory buffers of packets previously sent.
>   * This feature is driven by the *tx_free_thresh* value supplied to
> the
> @@ -6679,9 +6690,9 @@ uint16_t rte_eth_call_tx_callbacks(uint16_t
> port_id, uint16_t queue_id,
>   * @param nb_pkts
>   *   The maximum number of packets to transmit.
>   * @return
> - *   The number of output packets actually stored in transmit
> descriptors of
> - *   the transmit ring. The return value can be less than the value =
of
> the
> - *   *tx_pkts* parameter when the transmit ring is full or has been
> filled up.
> + *   The number of packets consumed from the *tx_pkts* array.
> + *   The return value can be less than the value of the
> + *   *nb_pkts* parameter when the transmit ring is full or has been
> filled up.
>   */
>  static inline uint16_t
>  rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
> --
> 2.51.0

