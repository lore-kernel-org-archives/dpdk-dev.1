Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5AAD41143
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 09:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81ECF40DDC;
	Thu, 15 Jan 2026 10:04:53 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DF0854003C;
 Thu, 15 Jan 2026 10:04:52 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6925D229AD;
 Thu, 15 Jan 2026 10:04:51 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mbuf fast-free requirements analysis
Date: Thu, 15 Jan 2026 10:04:49 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65660@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aWipWVON45iXUTrg@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdyF+3HIbtYbg/PgTF65mYhBA8NSpQAAP/MA
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <aWfGCglFfkpOAxgh@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565E@smartserver.smartshare.dk>
 <aWipWVON45iXUTrg@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>,
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

> > > > I wonder if the vector implementations have strong requirements
> that
> > > packets are not segmented...
> > > >
> > > > The i40 driver only sets "tx_simple_allowed" and =
"tx_vec_allowed"
> > > flags when MBUF_FAST_FREE is set:
> > > >
> > >
> =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> > > 0e_rxtx.c#L3502
> > > >
> > >
> > > Actually, it allows but does not require FAST_FREE. The check is
> just
> > > verifying that the flags with everything *but* FAST_FREE masked =
out
> is
> > > the
> > > same as the original flags, i.e. FAST_FREE is just ignored.
> >
> > That's not how I read the code:
> > ad->tx_simple_allowed =3D
> > 	(txq->offloads =3D=3D
> > 	 (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
> > 	 txq->tx_rs_thresh >=3D I40E_TX_MAX_BURST);
> >
> > Look at it with offloads=3D(MULTI_SEGS|FAST_FREE):
> > simple_allowed =3D (MULTI_SEGS|FAST_FREE) =3D=3D =
(MULTI_SEGS|FAST_FREE) &
> FAST_FREE
> > i.e.:
> > simple_allowed =3D (MULTI_SEGS|FAST_FREE) =3D=3D FAST_FREE
> > i.e.: false
> >
>=20
> Which is correct. The only flag allowed is FAST_FREE, but its not
> required.
> If the input flags were just MULTI_SEGS, it would end  up as:
>=20
> simple_allowed =3D (MULTI_SEGS) =3D=3D 0
> i.e. also false
>=20
> So the FAST_FREE flag does not affect the result.

OK, now I get it.
It's an obfuscated way of writing:
simple_allowed =3D (offloads & ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) =
=3D=3D 0

Suggest updating for readability next time that code is touched.

The comment "only fast free is allowed" [1] didn't help me either;
I interpreted it as "it's only allowed when fast free is set".
Now that I understand the code, I can also interpret the comment as =
intended.

[1]: =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L3502

Thanks for clarifying, Bruce!

