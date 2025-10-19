Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F1CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F194F427DA;
	Sun, 19 Oct 2025 18:59:18 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 50A26427B4
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:59:17 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 381917A0042;
 Sun, 19 Oct 2025 12:59:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 19 Oct 2025 12:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760893156;
 x=1760979556; bh=oxvX0w39zjen3ge7O+KjpsmgMGKacbCP53vvcOP/cUw=; b=
 O2++QbhFAary61eMSapcrBfpxc0IRFApOYS88kM/m+kjK+fGx5gRckvqhHFmfexW
 i+FjGHOwj1LiQuW/KobE6OqKfbb1VwYrOF1imVXCq9POJWdy4OEL2UseobzcLAxQ
 S0VhnEwX9k4DSfL7SyjRxviNBpedYKFgs2sB12/4SF406j+O0g5v/tyEtY1S7dvb
 rl1IJgdnULM8ztY54MCvY0YSS3WijaTXSnplili2IyApDTqYEm8E025js9go305k
 3DMNIr/r5nHRzTjhFBdcWodM+BVFrcto2lqoV7kNq+av7MqwFf/4t5+ve0a6c36j
 Q6YavpvytQcUj11QZCTCQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760893156; x=
 1760979556; bh=oxvX0w39zjen3ge7O+KjpsmgMGKacbCP53vvcOP/cUw=; b=S
 s0JtIlhZsUzQkbLF0AXdvoeWmeXazT7KlTxmRHLTn0wlJPV9C4D3YL7P0GyBz9Pf
 hZ+OEV93S/CXkTfOyK31vv2A7VOZSRQr6bYaaOEUD8FFxZv8L2faLOe4u8F0uzdW
 klzrjMt20KmYOU6zkismsNSvGPXxNYCbnvxlisTmXXT2IxnFkJmPHPJJLDFypZri
 TeZ4Y5dd5hESMpElGWZJg3TXju46aGDjpJY0Zkd4yiRe5JCt0TENiVApgNm89HPz
 VUuQ50ip2aGmvUWSj2tw2chy74chWgJnf34TGkw8Rd1lidPnG5JrTNrg70KHKNDN
 B5RchsCf49O3m7Bo9AjgQ==
X-ME-Sender: <xms:4hj1aM9k4U9ZNQA3jqqfbMRg2P72NjIhI5I9yaE_m9Z61xtstUPutA>
 <xme:4hj1aOxFq0Y7q2M1EM_TREyc20HMA8Xtgc0YGXD8NTqIXT95cACD1K4IcOn9jNfXU
 mnopRHuV6yAvlJN_d3-DL0QmjTm4d_aLzeIoaCJ_9VcWELU0kjwDRw>
X-ME-Received: <xmr:4hj1aB4pKYlqVjivHGlv2fTKehVzTHzGA5O0SacXwvR41a7rGfTgzPHXH4fKC8HxOvHtaAC-_t3x2MMT2IjXSQu3Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehgeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhn
 thgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehk
 ohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtoh
 eprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphht
 thhopehivhgrnhdrmhgrlhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:4hj1aN9wiNtl3SknDS7h5QgiOm0zXS709SgwN88eTFqoPvyNao3SNw>
 <xmx:4hj1aOomoRHeiqSCAvgMI1BKeSgCuIK1FPvAc8eids0QlMUC94EW4g>
 <xmx:4hj1aGrrNIvribws6UNK8O_MhnZ5il88jH7xVQghL00n8msgGzDsWg>
 <xmx:4hj1aJ0GAOtjEaCtqBexwCGy43hNBUUu0FkudC1VB4HNZif4zyBMgg>
 <xmx:5Bj1aOTXrjDGgypHYnHE2kSH6NxPfqU4gXIQqLRjWRvvilpSRSuEWnsF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 12:59:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Date: Sun, 19 Oct 2025 18:59:11 +0200
Message-ID: <2602540.zToM8qfIzz@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
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

09/10/2025 19:35, Morten Br=C3=B8rup:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > +		m->pkt_len =3D 0;
> > > +		m->tx_offload =3D 0;
> > > +		m->vlan_tci =3D 0;
> > > +		m->vlan_tci_outer =3D 0;
> > > +		m->port =3D RTE_MBUF_PORT_INVALID;
> >=20
> > Have you considered doing all initialization using 64-bit stores? It's
> > generally cheaper to do a single 64-bit store than e.g. set of 16-bit
> > ones.
>=20
> The code is basically copy-paste from rte_pktmbuf_reset().
> I kept it the same way for readability.
>=20
> > This also means that we could remove the restriction on having refcnt
> > and
> > nb_segs already set. As in PMDs, a single store can init data_off,
> > ref_cnt,
> > nb_segs and port.
>=20
> Yes, I have given the concept a lot of thought already.
> If we didn't require mbufs residing in the mempool to have any fields ini=
tialized, specifically "next" and "nb_segs", it would improve performance f=
or drivers freeing mbufs back to the mempool, because writing to the mbufs =
would no longer be required at that point; the mbufs could simply be freed =
back to the mempool. Instead, we would require the driver to initialize the=
se fields - which it probably does on RX anyway, if it supports segmented p=
ackets.
> But I consider this concept a major API change, also affecting applicatio=
ns assuming that these fields are initialized when allocating raw mbufs fro=
m the mempool. So I haven't pursued it.
>=20
> >=20
> > Similarly for packet_type and pkt_len, and data_len/vlan_tci and rss
> > fields
> > etc. For max performance, the whole of the mbuf cleared here can be
> > done in
> > 40 bytes, or 5 64-bit stores. If we do the stores in order, possibly
> > the
> > compiler can even opportunistically coalesce more stores, so we could
> > even
> > end up getting 128-bit or larger stores depending on the ISA compiled
> > for.
> > [Maybe the compiler will do this even if they are not in order, but I'd
> > like to maximize my chances here! :-)]

Morten, you didn't reply to this.
Can we optimize more with big stores?


