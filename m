Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D45C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 21:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 671484026D;
	Fri, 27 Jun 2025 23:37:04 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id E7E45400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 23:37:02 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 64B1414001CE;
 Fri, 27 Jun 2025 17:37:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 17:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751060222;
 x=1751146622; bh=zGFBL6hBCDai8tr0LHaoUBKlJDVy/W9wNiqxkJpFfg4=; b=
 SJof/09brXAzlZFTl5EDSYEnKwoGF1evUXDN32M7WqR6c82Y+goS0g+uvo/CBBhh
 FX0AVP4fDmWkF3M3C93dvu7QWY1Bh27C1sbXgG/utQgVdDHWzoHUXZm4oKOd//Xq
 u30Gt7UvnKyn3reUlT8UGjeqnBuSGP7Lsar5BQ4iX2rsz5bK25PgQMwNthJr2Pgx
 7zyPeT7YlTcWeutatfM7VA5IT3s2hY8X71Deigqe+TWFCUiJGKoWSXuL9rDSd6og
 sfIKDZHApKLUyEJlTsWvhwQs3cSJ32eCc0jkAf2Kt4+Cq2FH1FK5pj0mRpKrFDnv
 FeJv+N8+K6DbaCJzrtak2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751060222; x=
 1751146622; bh=zGFBL6hBCDai8tr0LHaoUBKlJDVy/W9wNiqxkJpFfg4=; b=F
 XUIbBdWou/eKZNN38nkZUEwpZyzHbLsJHuKb+zzAgAlRF8Dv9W4iEtgYBLg/9Uhx
 bIjbHl/6tFKrpgwPuatXg/AVtwJQwOWUEYD4xecNODNkN2CsEC7zEsC7XoNns/RJ
 i+vpjQnleNGKHKUMiJ0GgdWIe1Rcy4HWbZoIA+9Z98u5jiHXzkZmfjMp3rU/p6v7
 KKXh0sBLzESi5QjqKAmyeLHuBInsuKYBl1GW45Xt9Z8if6pE6dd7g9zmq1ZDxLqw
 L01CdtgwLhZ08oqDmCEldZDNmV1JXt287iQWb5ap8wtk8mNjDf6HhPP0X+lO8ixt
 wCykNP26T66eJjl5gd6NA==
X-ME-Sender: <xms:_Q5faC5LPF4I4kT4yV25xGticesPz-6IfFG5kGKjYKLmis3kamKu1A>
 <xme:_Q5faL5ylcUJFzTEn_JrAgVgN8OoI_vCvRpRgdQV1j22B3LDBw8HeMiFKX8BrTs9n
 q3bs43aBrtlnr0Fzg>
X-ME-Received: <xmr:_Q5faBfnQOjmpnSKJ3pGG3AjO2rG9oskCAnHSFLIYtLgjp-PYD0RzrKmxGLXLrMUmlcHvSMO7Hi5S1xkwJr94oGYdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhsrgigvghnrgesmhgrrhhvvghllhdrtg
 homhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhr
 ghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehnuggrsghilh
 hpuhhrrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepphgshhgrghgrvhgrthhu
 lhgrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrth
 drtghomhdprhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhhsrgigvg
 hnrgduieesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_Q5faPJ6WHNyWiaTVTkK4wAIE9MRve8tyIIONBEkefhQuEpmUlhQOQ>
 <xmx:_Q5faGKJfQrZoygRu-uWJrqQ444Dv4PKjh4MWlxrjXyDFe9o0d_bmA>
 <xmx:_Q5faAwnIGSIA8dVBlNPL9CQ_DHH4FYtsOhQZBXR-yPo5ihUuMzANA>
 <xmx:_Q5faKL5cl7H37sbui-T7oa6AZolx1JYI0PvLzwIxrP8KlFzwwnokQ>
 <xmx:_g5faKhQFMtWAD2ed10zm9nJp0s-LiNLdG-ujTB6sam58h1zTh2gX96U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 17:37:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, Nitin Saxena <nsaxena16@gmail.com>
Subject: Re: [PATCH v7 1/2] node: add global node mbuf dynfield
Date: Fri, 27 Jun 2025 23:36:58 +0200
Message-ID: <4399662.1SvkZsmPdQ@thomas>
In-Reply-To: <CAG6-93znfSj8EP8-2TdyWGCBBEskPdd7Rx2y5+Rq87PAXL96=g@mail.gmail.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250626065901.55d0dcbd@hermes.local>
 <CAG6-93znfSj8EP8-2TdyWGCBBEskPdd7Rx2y5+Rq87PAXL96=g@mail.gmail.com>
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

26/06/2025 16:14, Nitin Saxena:
> On Thu, Jun 26, 2025 at 7:29=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> > On Thu, 19 Jun 2025 21:14:49 +0530
> > Nitin Saxena <nsaxena@marvell.com> wrote:
> >
> > > +#ifndef RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE
> > > +/** Size of persistent mbuf fields */
> > > +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> > > +#endif /* RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE */
> > > +
> > > +#ifndef RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE
> > > +/** Size of overloadable mbuf fields */
> > > +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> > > +#endif /* RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE */
> > > +
> > > +/** Size of node mbuf dynamic field */
> > > +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> > > +     (RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE + RTE_NODE_MBUF_OVERLOADA=
BLE_FIELDS_SIZE)
> > > +
> > > +/**
> > > + * Node mbuf overloadable data.
> > > + *
> > > + * Out-of-tree nodes can repurpose overloadable fields via
> > > + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are =
not
> > > + * preserved and typically can be used with-in two adjacent nodes in=
 the graph.
> > > + */
> > > +typedef struct rte_node_mbuf_overload_fields {
> > > +     union {
> > > +             uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> > > +     };
> > > +} rte_node_mbuf_overload_fields_t;
> >
> > Having a blank scratchpad rather than a real defined structure means you
> > lose any type checking or potential overflow checking.
>=20
> Patchset-1 creates a blank scratchpad but patchset-2 adds following
> fields when added field is used in ip4/ip6 nodes
> So idea is to add relevant structures as and when they are used
>=20
>  diff --git a/lib/node/rte_node_mbuf_dynfield.h
> b/lib/node/rte_node_mbuf_dynfield.h
>  index 1069c07d44..045c13e352 100644
>  --- a/lib/node/rte_node_mbuf_dynfield.h
>  +++ b/lib/node/rte_node_mbuf_dynfield.h
>  @@ -46,6 +46,15 @@ extern "C" {
>    */
>   typedef struct rte_node_mbuf_overload_fields {
>   >------union {
> +>------>-------/* Following fields used by ip[4|6]-lookup ->
> ip[4|6]-rewrite nodes */
> +>------>-------union {
> +>------>------->-------struct {
> +>------>------->------->-------uint16_t nh;
> +>------>------->------->-------uint16_t ttl;
> +>------>------->------->-------uint32_t cksum;
> +>------>------->-------};
> +>------>------->-------uint64_t u;
> +>------>-------};
> >------>-------uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> >------};
> } rte_node_mbuf_overload_fields_t;
>=20

I assume it is OK to merge.
It was supposed to be merged in -rc1,
so it is applied now for -rc2, thanks.


