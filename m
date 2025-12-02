Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F624CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A25240268;
	Tue,  2 Dec 2025 10:00:48 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 15183400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 10:00:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DD74020B9F;
 Tue,  2 Dec 2025 10:00:46 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
Date: Tue, 2 Dec 2025 10:00:46 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655AD@smartserver.smartshare.dk>
In-Reply-To: <CY5PR11MB6116A4601EB74D4943216EA2E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Index: AQHcVq02Q5MdAwVwH0eQQbAZdQUWgLT07CkAgAFoL7CAAD5rkIAXXmCwgAAuc6A=
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251116035749.45922-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
 <CY5PR11MB61167F082015E76C562C3635E4C9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65566@smartserver.smartshare.dk>
 <CY5PR11MB6116A4601EB74D4943216EA2E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>, <thomas@monjalon.net>,
 <andrew.rybchenko@oktetlabs.ru>,
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

+TO: Stephen Hemminger, might have some kernel-related insights on this.

> From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> Sent: Tuesday, 2 December 2025 09.17
>=20
> Hi Morten Br=F8rup,
>=20
> Apologies for late reply but as the patch was deferred from DPDK =
25.11.
> Hence, I was waiting.
> PFB my answers.
>=20
> Q1: " Please disable anti-spoof filtering by default, and provide an
> option to enable it.
> Like source-prune."
> [Ans]: MAC anti-spoof is enabled by default in kernel ice driver.
> Hence, it seems a better idea to make it enabled by default to keep it
> in sync with kernel and in terms of security.

Mac-source-prune is disabled by default in DPDK, although it is enabled =
by default in the kernel.
Mac-anti-spoof should behave the same way, i.e. disabled by default in =
DPDK.

Also, consider that the kernel is mainly designed for client/server =
applications, while DPDK is mainly designed for packet forwarding =
purposes.
With that in mind, default enabled makes sense for the kernel, and =
default disabled makes sense for DPDK.

>=20
> Q2: " Is support for "vlan-anti-spoof" in the pipeline?"
> [Ans]: Not sure but " vlan_anti_spoof_on" is present in code.

OK.

>=20
> Q3: " What are your thoughts about the generic Ethdev APIs I =
suggested,
> instead of driver specific devargs?"
> [Ans]: It is unlikely that a user would want these mac anti-spoof/src
> prune to be set/reset dynamically. Hence,  it seems devargs likely be =
a
> better solution.
> Generic Ethdev APIs is a good idea but should be taken separately as =
it
> will have much beyond scope than this and would need significant
> effort.
> Also, that again bring the dynamic nature into the picture.

Good point about not needing the dynamic ability. I agree with that.
But devargs are somewhat difficult to work with for applications not =
built for specific ethdev drivers. E.g. our application detects =
available hardware at runtime, and configures it appropriately. Generic =
APIs are much easier to work with than individual driver-specific =
devargs.
So I prefer not to introduce more driver specific devargs.

I acknowledge that my Ethdev API extension idea is feature creep, so I =
will not make it a hard requirement for this patch.
And when mac-anti-spoof is disabled by default (which I do consider a =
hard requirement!), the devarg parameter is reduced to something that =
enables some exotic filter, which I don't object to.

>=20
> Thank you.
>=20
> Regards,
> Anurag M
>=20
> -----Original Message-----
> From: Morten Br=F8rup <mb@smartsharesystems.com>
> Sent: 17 November 2025 14:36
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; =
Richardson,
> Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>; thomas@monjalon.net;
> andrew.rybchenko@oktetlabs.ru
> Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
>=20
> > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > Sent: Monday, 17 November 2025 06.22
> >
> > Hi Morten Br=F8rup,
> >
> > Thanks for your mail and review. PFB my answers.
> >
> > " This is the same story as with Source Prune.
> > Please disable source-prune filtering by default, and provide an
> > option to enable it.
> > Also, suggest shortening the devargs name to simply "anti-spoof",
> like
> > "source-prune"; they both operate on MAC basis."
> >
> > [Ans]: Source prune is disabled by default and option to enable the
> > same has been already committed:[
> >
> https://github.com/DPDK/dpdk/commit/980c840a646a2c8ae49a291c17baf20a74
> > f
> > 36086].
>=20
> Sorry, there was a typo... I meant to write:
> Please disable anti-spoof filtering by default, and provide an option
> to enable it.
> Like source-prune.
>=20
> > I also wanted to shorten the name to "anti-spoof" but I found
> > something called " vsi->vlan_anti_spoof_on" in the same file.
> > Hence, to distinguish between them, used "mac-anti-spoof".
>=20
> OK. Then "mac-anti-spoof" is a good choice.
>=20
> Is support for "vlan-anti-spoof" in the pipeline?
>=20
> What are your thoughts about the generic Ethdev APIs I suggested,
> instead of driver specific devargs?
>=20
> >
> > Thank you.
> >
> > Regards,
> > Anurag M
> >
> > -----Original Message-----
> > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > Sent: 16 November 2025 13:14
> > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;
> > Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> > <anatoly.burakov@intel.com>; thomas@monjalon.net;
> > andrew.rybchenko@oktetlabs.ru
> > Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
> >
> > +TO: Ethdev maintainers, regarding new Ethdev APIs
> >
> > > From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> > > Sent: Sunday, 16 November 2025 04.58
> > >
> > > VRRP advertisement packets are dropped as TX-errors upon
> > > transmission from a vsi of ice PF due to MAC anti-spoof check =
which
> > > is enabled by default.
> > > There is no way to disable this check in the Tx direction to avoid
> > > these packets being dropped.
> > >
> > > This patch introduces devargs "mac-anti-spoof" to allow user to
> > > disable MAC anti-spoof check. Disable MAC Anti-spoof check in the
> Tx
> > > direction to avoid getting dropped as TX-errors upon packet
> > > transmission when their source MAC address matches one of the MAC
> > > addresses assigned to that same NIC port.
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> >
> > This is the same story as with Source Prune.
> > Please disable source-prune filtering by default, and provide an
> > option to enable it.
> > Also, suggest shortening the devargs name to simply "anti-spoof",
> like
> > "source-prune"; they both operate on MAC basis.
> >
> > Let's make something generic instead, to replace those silly =
devargs.
> > We have individual Ethdev APIs to enable/disable various Rx
> filtering,
> > e.g. "promiscuous", "all multicast".
> > Obviously, we don't want to introduce new APIs for every semi-exotic
> > filter any NIC may offer, like "source prune" and "anti spoof", but
> we
> > could introduce a set of generic Ethdev APIs to support filters such
> > as these, using a bitfield enum. E.g.:
> >
> > /* Enable one or more filters. */
> > int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);
> >
> > /* Disable one or more filters. */
> > int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);
> >
> > /* Get bit field of filters enabled. */ int64_t
> > rte_ethdev_filter_get(uin16_t port_id);
> >
> > /* Get bit field of filters supported by device. */ int64_t
> > rte_ethdev_filter_capa(uin16_t port_id); /**/
> >
> > /** Destination MAC must match NIC's MAC address.
> >  * (This is the inverse of Promiscuous.)
> >  * Default enabled.
> >  */
> > #define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
> > /** Multicast Hash.
> >  * (This is the inverse of All Multicast.)
> >  * Default enabled.
> >  */
> > #define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
> > /** Source Prune.
> >  * [Insert description here.]
> >  */
> > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
> > /* Add new Rx filters here, in increasing order. */
> > /* Add new Tx filters here, in decreasing order. */
> > /** Anti-Spoof.
> >  * [Insert description here.]
> >  */
> > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
> > /** Used for error return values which are negative. */
> > #define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)

