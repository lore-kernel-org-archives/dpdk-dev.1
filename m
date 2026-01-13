Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EABD2D0EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 14:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F3F84042C;
	Tue, 13 Jan 2026 15:48:22 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6019340276;
 Tue, 13 Jan 2026 15:48:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drBtp1j4NzHnGkT;
 Tue, 13 Jan 2026 22:48:02 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D9B040539;
 Tue, 13 Jan 2026 22:48:20 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 13 Jan 2026 14:48:19 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 13 Jan 2026 14:48:19 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: mbuf fast-free requirements analysis
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdxtsuI54Ph/Or7ES4uJIkNuHGVH/AAHMGowAACuIkAAzd1lUAAd58awAHUVwFAAAtgfgAACVqsAASbdj1A=
Date: Tue, 13 Jan 2026 14:48:19 +0000
Message-ID: <69116a74e319436fb4a06fb6efd684d3@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <0d1645e1c83f4ec4ad676095b910845c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E5@smartserver.smartshare.dk>
 <d290adf103244ff7be53844ee32bb6d0@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65601@smartserver.smartshare.dk>
 <4ef23a6663774a119d3087fb21ede984@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65608@smartserver.smartshare.dk>
 <aUmDTsLxNN-GOGDC@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aUmDTsLxNN-GOGDC@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> > > > > >
> > > > > > 	__rte_mbuf_raw_sanity_check_mp(m, mp);
> > > > > > 	rte_mbuf_history_mark(mbuf,
> > > > > > RTE_MBUF_HISTORY_OP_LIB_PREFREE_RAW);
> > > > > > }
> > > > >
> > > > > Thanks Morten, though should we really panic if condition is not
> > > met?
> > > > > Might be just do check first and return an error.
> > > >
> > > > __rte_mbuf_raw_sanity_check_mp() is a no-op unless
> > > > RTE_LIBRTE_MBUF_DEBUG is enabled.
> > >
> > > Yep, I noticed.
> > >
> > > >
> > > > Using it everywhere in alloc/free in the mbuf library is the
> > > convention.
> > > >
> > > > And if we don't do it here, the __rte_mbuf_raw_sanity_check_mp() in
> > > > rte_mbuf_raw_free() will panic later instead.
> > >
> > > Why?
> > > This new routine (rte_mbuf_raw_prefree_seg) can check that mbuf
> > > satisfies fast-free criteria
> > > before updating it, and if conditions are not met simply return an
> > > error.
> > > Then the driver has several options:
> > > 1) Drop the packet silently
> > > 2) Refuse to send it
> > > 3) Switch to some slower but always working code-path (without fast-
> > > free)
> > > 4) Panic
> >
> > It boils down to purpose.
> >
> > The function is designed for use in the transmit code path designated f=
or fast-free,
> where the application has promised/hinted that packets are fast-free comp=
liant.
> > Violating preconditions in the fast path (by passing packets not compli=
ant to fast-
> free requirements to this function) is a serious type of bug, for which D=
PDK usually
> doesn't provide graceful fallback.
> > I don't want to make an exception (and introduce graceful fallback) for=
 the
> designated fast-free code path.
> >
> > My answer would be completely different if we were designing an API for=
 standard
> packet transmission, whereby some packets living up to certain criteria c=
ould take a
> faster code path for being freed.
> > If that was the case, I would agree with you about returning a value to=
 indicate
> how to proceed, like rte_pktmbuf_prefree_seg() does.
> >
> I would tend to agree. The extra handling for those cases just expands th=
e
> code and adds more potential branches to the resulting binary. Lots of th=
e
> fastpath code just assumes you know what you are doing, and violating
> constraints will lead to panics and segfaults generally. Therefore panici=
ng
> in this case doesn't seem a bit deal to me.
>=20
I understand your point lads, and somewhat agree: if we plan to keep FAST_F=
REE flag forever,
then it is probably the simplest and safest approach.
My hope was that such function will open a possibility for the PMDs to impl=
ement similar
perf improvement completely transparent to the user (without need for speci=
al flags and/or pre-requirements).
But might be I am looking forward way too far with it.
Even what Morten proposed above is a big step, so ok - let's deal with it f=
irst.
Konstantin   =20

 =20

