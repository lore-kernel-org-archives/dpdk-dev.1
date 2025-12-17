Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99638D65C49
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C1B240275;
	Wed, 17 Dec 2025 15:13:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 016C14026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:13:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B4B03202CC;
 Wed, 17 Dec 2025 15:13:48 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3] net/ice: add MAC anti-spoof option
Date: Wed, 17 Dec 2025 15:13:47 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655F3@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] net/ice: add MAC anti-spoof option
Thread-Index: AdxvW4Ws7RlO/Bc3Ta6AFtnJOnAHjAAAqeFA
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
 <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655F2@smartserver.smartshare.dk>
 <aUK0GxJjmJDB0ojE@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Mandal, Anurag" <anurag.mandal@intel.com>, <dev@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
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
> Sent: Wednesday, 17 December 2025 14.46
>=20
> On Wed, Dec 17, 2025 at 01:37:16PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 17 December 2025 12.53
> > >
> > > On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> > > > On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Br=F8rup wrote:
> > > > > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > > > > Sent: Wednesday, 3 December 2025 15.36
> > > > > >
> > > > > > Hi Morten Br=F8rup,
> > > > > >
> > > > > > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > > > Sent: 03 December 2025 17:11
> > > > > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf,
> enum
> > > > > > > ice_vsi_type type)
> > > > > > >  		/* Source Prune */
> > > > > > >  		if (ad->devargs.source_prune !=3D 1) {
> > > > > > >  			/* Disable source prune to support VRRP
> > > > > > > -			 * when source-prune devarg is not set
> > > > > > > +			 * when source-prune devargs is not set
> > > > > > >  			 */
> > > > > > >  			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > > > > -			vsi_ctx.info.sw_flags |=3D
> > > > > > > +		} else { /* Enable Source Prune in Rx */
> > > > > > > +			vsi_ctx.info.sw_flags =3D
> > > > > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > > > > >  		}
> > > > > >
> > > > > > This looks like a bug fix related to Source Prune?
> > > > > >
> > > > > > Ans: Not exactly.
> > > > > > Initially, Source Prune was disabled, and MAC Anti-spoof
> check
> > > was
> > > > > > enabled by default. This was done by following:-
> > > > > > Source Prune is disabled by setting local loopback with
> > > > > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted
> > > packets
> > > > > > from being looped back in some circumstances.
> > > > > > Now, MAC Anti-spoof check can be disabled by clearing both
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and
> > > > > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx
> > > loopback
> > > > > > with
> > > > > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > > > >
> > > > > > As we moved to making both source prune and mac anti-spoof
> check
> > > > > > disabled by default, I thought no point to set
> > > > > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and
> then
> > > > > > clearing it to disable mac anti-spoof.
> > > > >
> > > > > OK. Thank you for elaborating.
> > > > >
> > > > > >
> > > > > > Thank you.
> > > > > >
> > > > > > Regards,
> > > > > > Anurag M
> > > > >
> > > > > Note to maintainers:
> > > > > This devarg is like the Source Prune devarg.
> > > > > If we want to elevate these exotic features into proper Ethdev
> > > APIs, it should be done for both devargs in a separate patch.
> > > > >
> > > > > Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > >
> > > > Applied to dpdk-next-net-intel.
> > > >
> > > Unfortunately, this patch causes changes in the driver behaviour
> > > leading to
> > > CI failures. These issues can be seen with testpmd where packets
> are
> > > looping back inside a nic port unexpectedly.
> >
> > Can you please elaborate "packets are looping back"?
> >
>=20
> When testpmd is configured for mac forwarding, sending in a single
> packet
> leads to a constant stream of packets being handled by testpmd.
>=20
> > If the packets egress on one physical port, they certainly shouldn't
> ingress back on the same physical port.
> >
> > However, if they egress on one virtual port, and are internally
> switched to ingress on another virtual port on the same physical port,
> I would consider that expected behavior - the same would happen if
> those ports were physical and connected to the same physical switch.
> >
> > If they are ingressing on the same virtual port they were sent on,
> that would seem like a bug in the NICs virtual switch. A physical
> switch normally wouldn't transmit packets back out on the port they
> ingressed on.
> >
>=20
> Not exactly sure what is happening internally, it needs some
> investigation.

Sure sounds like it.
Let's hope it's only testpmd, and not a broader issue with the =
NIC/driver.

>=20
> > > Therefore, this patch
> > > needs to
> > > be dropped from next-net-intel.
> > >
> > > Can you please do a new version adding the feature you require
> while
> > > still
> > > keeping the existing default behaviour.  I'm going to move the
> patch
> > > status
> > > from accepted to "changes requested" in patchwork, in anticipation
> of a
> > > new
> > > version.
> > >
> > > Regards,
> > > /Bruce
> >
> > This sounds like the CI needs to be fixed.
> > Why does the CI expect this kind of filtering to be enabled by
> default?
> > I wouldn't expect other NICs to perform similar filtering.
> >
> It could well be a testing issue, or a combination of incorrect =
default
> behaviour and a sub-optimal test case. However, until that is fully
> root-caused, I'm backing out the patch for safety.

A new patch with reverted default behavior seems like the proper =
short-term solution.
While investigating, we can live with the wrong default behavior, as a =
"well known bug".
And the configurability will be helpful for root-causing.

>=20
> /Bruce
