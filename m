Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B681CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 07:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 427CF40A89;
	Sun, 16 Nov 2025 08:43:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EFA994026C
 for <dev@dpdk.org>; Sun, 16 Nov 2025 08:43:56 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B87CD20C65;
 Sun, 16 Nov 2025 08:43:55 +0100 (CET)
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Nov 2025 08:43:54 +0100
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
In-Reply-To: <20251116035749.45922-1-anurag.mandal@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Index: AdxWrTT2zGCirvvcTJKsUcbjSN2siAAGLhTg
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251116035749.45922-1-anurag.mandal@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anurag Mandal" <anurag.mandal@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <thomas@monjalon.net>, <andrew.rybchenko@oktetlabs.ru>
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

+TO: Ethdev maintainers, regarding new Ethdev APIs

> From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> Sent: Sunday, 16 November 2025 04.58
>=20
> VRRP advertisement packets are dropped as TX-errors upon transmission
> from
> a vsi of ice PF due to MAC anti-spoof check which is enabled by
> default.
> There is no way to disable this check in the Tx direction to avoid
> these packets being dropped.
>=20
> This patch introduces devargs "mac-anti-spoof" to allow user to
> disable MAC anti-spoof check. Disable MAC Anti-spoof check
> in the Tx direction to avoid getting dropped as TX-errors upon packet
> transmission when their source MAC address matches one of the MAC
> addresses assigned to that same NIC port.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

This is the same story as with Source Prune.
Please disable source-prune filtering by default, and provide an option =
to enable it.
Also, suggest shortening the devargs name to simply "anti-spoof", like =
"source-prune"; they both operate on MAC basis.

Let's make something generic instead, to replace those silly devargs.
We have individual Ethdev APIs to enable/disable various Rx filtering, =
e.g. "promiscuous", "all multicast".
Obviously, we don't want to introduce new APIs for every semi-exotic =
filter any NIC may offer, like "source prune" and "anti spoof", but we =
could introduce a set of generic Ethdev APIs to support filters such as =
these, using a bitfield enum. E.g.:

/* Enable one or more filters. */
int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);

/* Disable one or more filters. */
int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);

/* Get bit field of filters enabled. */
int64_t rte_ethdev_filter_get(uin16_t port_id);

/* Get bit field of filters supported by device. */
int64_t rte_ethdev_filter_capa(uin16_t port_id); /**/

/** Destination MAC must match NIC's MAC address.
 * (This is the inverse of Promiscuous.)
 * Default enabled.
 */
#define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
/** Multicast Hash.
 * (This is the inverse of All Multicast.)
 * Default enabled.
 */
#define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
/** Source Prune.
 * [Insert description here.]
 */
#define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
/* Add new Rx filters here, in increasing order. */
/* Add new Tx filters here, in decreasing order. */
/** Anti-Spoof.
 * [Insert description here.]
 */
#define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
/** Used for error return values which are negative. */
#define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)

