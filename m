Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E3CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 14:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEBE240268;
	Tue,  2 Dec 2025 15:25:31 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id E9EAC400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 15:25:29 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 08B537A00F8;
 Tue,  2 Dec 2025 09:25:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 02 Dec 2025 09:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764685528;
 x=1764771928; bh=xqHOPoso57YZMMiRTif7dZtx913zip6lODNRW46HjC0=; b=
 gqSJqUoWPq+7GlCGNLsQoeQ6T9OANoqyMHbH95asvrofYe1ohw5ImZI8x6JgFhwe
 Atta/RZWqC46zMA+wfutYBvHQzH3DXhCJnqMl9HRi8a56TEfZ0KDf+yRX5lT0IFV
 BDdeFMM8AFRYPF6KFUriTsODmgxkJChupK4cF0C2X0mP/YTQIpdgFSgs7KM1DTME
 6rGkwfhzlQRoDo/bhdJt7Fielno5Zs3kulQjPmwKpDIfZJSUPqRUEZdNy6UYWSvK
 B3ItPNqD2F+SuVvRMV7IxcQCP82Sex4sDcG0BXWiJ9ZjMxySut01Gtc7836PBI/+
 EpilH+i8S/aw/RFLqpg6uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1764685528; x=1764771928; bh=x
 qHOPoso57YZMMiRTif7dZtx913zip6lODNRW46HjC0=; b=Fspno5m5giOld4gTM
 g3h4r+4QqZcJAdisrlvcks+O8zayp3hokPf9dVwvigQqevUjbaf8nb+LnLdNjRFT
 fBp9SIExbreMhdT8eHW612Y6CDV42BnISOslg54ZlR31fiStNhx+puJXluXTFuAp
 wsQpcJ6HhLuZTcigrb57izSGWTXDC9JSMQZvp5hp9a7z7pJ00oBJpm0u8/1frCf3
 EaajIHNDHC2nAyohnPmLK4lVFDQHH/pVDtFZyJToLeKggz+kvn3KR6z4N6pJwpS+
 Zvhhtv50iGSK9e0Jkg7Cju8PccjcUJT0vJvsLWeJ5bH/TZvisufDisnEJy7kbit9
 AV2kQ==
X-ME-Sender: <xms:1_YuaVmsAtBGGOOSs5RwFfqcHShQsc0xROYnux_shfEIKnnFVQdcgg>
 <xme:1_Yuabx2N5cfHmel5346YHg2-5DJLyfT4w7d_WTL2ALkVZb9XjRyUO2gulU_QVLBk
 Yb4cdLhSu9rhYNBV-BW1Y_MO2iRVgHqENqercTcckXmN7sBGV7OeQ>
X-ME-Received: <xmr:1_YuaarsosLothP6hgN1JPB2H3KeN1nEDazap8uGiZrmAC7Li1Ls_qKAQSEeuXcUp20tgNEdlURYrdPOe1-0XVFE5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvffufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhn
 jhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtth
 gvrhhnpeffgfehfeevffevveevudevveefjeeuleehhfffffevvdffhffhheekheetlefg
 leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgv
 thdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
 gssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgv
 lhdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvth
 hlrggsshdrrhhupdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgs
 vghrrdhorhhgpdhrtghpthhtoheprghnuhhrrghgrdhmrghnuggrlhesihhnthgvlhdrtg
 homh
X-ME-Proxy: <xmx:1_Yuaa6EhddeeMi07U2gS9CxJxxSkRJnsbdhcQM3wn4SLIszXgZDVQ>
 <xmx:1_YuaReuudiAJLZevjPsPFiRz11r7rlsQbqiggNr7fc39JpfERVvZw>
 <xmx:1_Yuaf43WxeGkAEoE2I-8ed1kYIEZX4uf3N5tUQsqg56VtIunhUiYQ>
 <xmx:1_YuaYvfARDrWw8D8O2cH9dSWEgu3yQmA2wy4qjKwGvoL7WJN-uE0g>
 <xmx:2PYuaW_fDwCZcsQtlWVEjpqwKbHzTLDYCX-1PR197b4VVDs9rfKd0L9->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 09:25:26 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: Re: [PATCH v2] net/ice: add MAC anti-spoof option
Date: Tue, 02 Dec 2025 15:25:24 +0100
Message-ID: <3894525.NgBsaNRSFp@thomas>
In-Reply-To: <CY5PR11MB611648411BC37F6312513596E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655AD@smartserver.smartshare.dk>
 <CY5PR11MB611648411BC37F6312513596E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hello,

Top posting makes this thread difficult to follow.

My quick understanding is that it is an offload feature,
and I don't understand why it is not handled as such in ethdev API.


02/12/2025 10:14, Mandal, Anurag:
> Hi Morten Br=C3=B8rup,
>=20
> Ok. I will make Mac-anti-spoof disabled by default, gave option to enable=
 it  and send a new patch.
>=20
> Thank you.
>=20
> Regards,
> Anurag M
>=20
> -----Original Message-----
> From: Morten Br=C3=B8rup <mb@smartsharesystems.com>=20
> Sent: 02 December 2025 14:31
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Richardson, B=
ruce <bruce.richardson@intel.com>; Burakov, Anatoly <anatoly.burakov@intel.=
com>; thomas@monjalon.net; andrew.rybchenko@oktetlabs.ru; Stephen Hemminger=
 <stephen@networkplumber.org>
> Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
>=20
> +TO: Stephen Hemminger, might have some kernel-related insights on this.
>=20
> > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > Sent: Tuesday, 2 December 2025 09.17
> >=20
> > Hi Morten Br=C3=B8rup,
> >=20
> > Apologies for late reply but as the patch was deferred from DPDK 25.11.
> > Hence, I was waiting.
> > PFB my answers.
> >=20
> > Q1: " Please disable anti-spoof filtering by default, and provide an=20
> > option to enable it.
> > Like source-prune."
> > [Ans]: MAC anti-spoof is enabled by default in kernel ice driver.
> > Hence, it seems a better idea to make it enabled by default to keep it=
=20
> > in sync with kernel and in terms of security.
>=20
> Mac-source-prune is disabled by default in DPDK, although it is enabled b=
y default in the kernel.
> Mac-anti-spoof should behave the same way, i.e. disabled by default in DP=
DK.
>=20
> Also, consider that the kernel is mainly designed for client/server appli=
cations, while DPDK is mainly designed for packet forwarding purposes.
> With that in mind, default enabled makes sense for the kernel, and defaul=
t disabled makes sense for DPDK.
>=20
> >=20
> > Q2: " Is support for "vlan-anti-spoof" in the pipeline?"
> > [Ans]: Not sure but " vlan_anti_spoof_on" is present in code.
>=20
> OK.
>=20
> >=20
> > Q3: " What are your thoughts about the generic Ethdev APIs I=20
> > suggested, instead of driver specific devargs?"
> > [Ans]: It is unlikely that a user would want these mac anti-spoof/src=20
> > prune to be set/reset dynamically. Hence,  it seems devargs likely be=20
> > a better solution.
> > Generic Ethdev APIs is a good idea but should be taken separately as=20
> > it will have much beyond scope than this and would need significant=20
> > effort.
> > Also, that again bring the dynamic nature into the picture.
>=20
> Good point about not needing the dynamic ability. I agree with that.
> But devargs are somewhat difficult to work with for applications not buil=
t for specific ethdev drivers. E.g. our application detects available hardw=
are at runtime, and configures it appropriately. Generic APIs are much easi=
er to work with than individual driver-specific devargs.
> So I prefer not to introduce more driver specific devargs.
>=20
> I acknowledge that my Ethdev API extension idea is feature creep, so I wi=
ll not make it a hard requirement for this patch.
> And when mac-anti-spoof is disabled by default (which I do consider a har=
d requirement!), the devarg parameter is reduced to something that enables =
some exotic filter, which I don't object to.
>=20
> >=20
> > Thank you.
> >=20
> > Regards,
> > Anurag M
> >=20
> > -----Original Message-----
> > From: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Sent: 17 November 2025 14:36
> > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;=20
> > Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly=20
> > <anatoly.burakov@intel.com>; thomas@monjalon.net;=20
> > andrew.rybchenko@oktetlabs.ru
> > Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
> >=20
> > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > Sent: Monday, 17 November 2025 06.22
> > >
> > > Hi Morten Br=C3=B8rup,
> > >
> > > Thanks for your mail and review. PFB my answers.
> > >
> > > " This is the same story as with Source Prune.
> > > Please disable source-prune filtering by default, and provide an=20
> > > option to enable it.
> > > Also, suggest shortening the devargs name to simply "anti-spoof",
> > like
> > > "source-prune"; they both operate on MAC basis."
> > >
> > > [Ans]: Source prune is disabled by default and option to enable the=20
> > > same has been already committed:[
> > >
> > https://github.com/DPDK/dpdk/commit/980c840a646a2c8ae49a291c17baf20a74
> > > f
> > > 36086].
> >=20
> > Sorry, there was a typo... I meant to write:
> > Please disable anti-spoof filtering by default, and provide an option=20
> > to enable it.
> > Like source-prune.
> >=20
> > > I also wanted to shorten the name to "anti-spoof" but I found=20
> > > something called " vsi->vlan_anti_spoof_on" in the same file.
> > > Hence, to distinguish between them, used "mac-anti-spoof".
> >=20
> > OK. Then "mac-anti-spoof" is a good choice.
> >=20
> > Is support for "vlan-anti-spoof" in the pipeline?
> >=20
> > What are your thoughts about the generic Ethdev APIs I suggested,=20
> > instead of driver specific devargs?
> >=20
> > >
> > > Thank you.
> > >
> > > Regards,
> > > Anurag M
> > >
> > > -----Original Message-----
> > > From: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > Sent: 16 November 2025 13:14
> > > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;=20
> > > Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly=20
> > > <anatoly.burakov@intel.com>; thomas@monjalon.net;=20
> > > andrew.rybchenko@oktetlabs.ru
> > > Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
> > >
> > > +TO: Ethdev maintainers, regarding new Ethdev APIs
> > >
> > > > From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> > > > Sent: Sunday, 16 November 2025 04.58
> > > >
> > > > VRRP advertisement packets are dropped as TX-errors upon=20
> > > > transmission from a vsi of ice PF due to MAC anti-spoof check=20
> > > > which is enabled by default.
> > > > There is no way to disable this check in the Tx direction to avoid=
=20
> > > > these packets being dropped.
> > > >
> > > > This patch introduces devargs "mac-anti-spoof" to allow user to=20
> > > > disable MAC anti-spoof check. Disable MAC Anti-spoof check in the
> > Tx
> > > > direction to avoid getting dropped as TX-errors upon packet=20
> > > > transmission when their source MAC address matches one of the MAC=20
> > > > addresses assigned to that same NIC port.
> > > >
> > > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > > ---
> > >
> > > This is the same story as with Source Prune.
> > > Please disable source-prune filtering by default, and provide an=20
> > > option to enable it.
> > > Also, suggest shortening the devargs name to simply "anti-spoof",
> > like
> > > "source-prune"; they both operate on MAC basis.
> > >
> > > Let's make something generic instead, to replace those silly devargs.
> > > We have individual Ethdev APIs to enable/disable various Rx
> > filtering,
> > > e.g. "promiscuous", "all multicast".
> > > Obviously, we don't want to introduce new APIs for every semi-exotic=
=20
> > > filter any NIC may offer, like "source prune" and "anti spoof", but
> > we
> > > could introduce a set of generic Ethdev APIs to support filters such=
=20
> > > as these, using a bitfield enum. E.g.:
> > >
> > > /* Enable one or more filters. */
> > > int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);
> > >
> > > /* Disable one or more filters. */
> > > int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);
> > >
> > > /* Get bit field of filters enabled. */ int64_t=20
> > > rte_ethdev_filter_get(uin16_t port_id);
> > >
> > > /* Get bit field of filters supported by device. */ int64_t=20
> > > rte_ethdev_filter_capa(uin16_t port_id); /**/
> > >
> > > /** Destination MAC must match NIC's MAC address.
> > >  * (This is the inverse of Promiscuous.)
> > >  * Default enabled.
> > >  */
> > > #define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
> > > /** Multicast Hash.
> > >  * (This is the inverse of All Multicast.)
> > >  * Default enabled.
> > >  */
> > > #define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
> > > /** Source Prune.
> > >  * [Insert description here.]
> > >  */
> > > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
> > > /* Add new Rx filters here, in increasing order. */
> > > /* Add new Tx filters here, in decreasing order. */
> > > /** Anti-Spoof.
> > >  * [Insert description here.]
> > >  */
> > > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
> > > /** Used for error return values which are negative. */
> > > #define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)
>=20
>=20





