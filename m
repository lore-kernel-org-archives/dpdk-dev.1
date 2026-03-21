Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B171099B54
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1495940274;
	Sat, 21 Mar 2026 06:48:44 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C131A4026A
 for <dev@dpdk.org>; Sat, 21 Mar 2026 06:48:41 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AE407205CA;
 Sat, 21 Mar 2026 06:48:40 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH dpdk v2] net/tap: add software MAC address filtering
Date: Sat, 21 Mar 2026 06:48:38 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657AC@smartserver.smartshare.dk>
In-Reply-To: <20260320195824.341323ae@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH dpdk v2] net/tap: add software MAC address filtering
Thread-Index: Ady43pvfV9eHxah3TWidS6NsneqcDQAFqRFg
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260320164523.810401-2-rjarry@redhat.com>
 <20260320195824.341323ae@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Robin Jarry" <rjarry@redhat.com>
Cc: <dev@dpdk.org>
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

> On Fri, 20 Mar 2026 17:45:24 +0100
> Robin Jarry <rjarry@redhat.com> wrote:
>=20
> > +	dst =3D rte_pktmbuf_mtod(mbuf, struct rte_ether_addr *);
> > +
> > +	if (likely(rte_is_unicast_ether_addr(dst))) {

The NULL addr check should go here:
    if (unlikely(rte_is_zero_ether_addr(dst)))
        return false; /* Invalid destination address in packet */

> > +		for (i =3D 0; i < TAP_MAX_MAC_ADDRS; i++) {
> > +			if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
> > +				return true;
> > +		}
> > +		return false;
> > +	}
>=20
> Since unused slots are zero, probably need to drop packets with all
> zero dest.

You should drop packets with NULL dst addr; it is not allowed on the =
wire.

Alternatively, you can put the broadcast address in the unused entries =
in the mac_addrs table; it will not match any unicast ether addr.

