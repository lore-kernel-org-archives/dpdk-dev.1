Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7467CC5DF67
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 08:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28E1240294;
	Tue, 18 Aug 2026 10:11:50 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E24DD4028E
 for <dev@dpdk.org>; Tue, 18 Aug 2026 10:11:47 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XuYcfxPnFzDYgsMzJCIjCt4VoJIo0tKGzgbklspO09I=;
 b=wZqRpRczE+pss9SMgCVvPBkfFSiEw+gkjeJLxK/wT0XA2INyUjaTfSHX7E/vJl1fnOfD9B0cf
 7+CoNR1eO36fh4d3WL3ubK4EAdDB327CIOwy8BZnR3NMVL7BdyVngd/UwhEm5ZZPmhA0lLXf32w
 uXQKuZxrEaBzZAWn7OrH+YA=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hPMq730BDzJ46Yt;
 Tue, 18 Aug 2026 16:11:31 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 7EC614058D;
 Tue, 18 Aug 2026 16:11:37 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Aug 2026 09:11:37 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 18 Aug 2026 09:11:37 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] stack: introduce pile
Thread-Topic: [PATCH] stack: introduce pile
Thread-Index: AQHdKmHxOTsi6KhTAk+e68voB41GrLaiLgIAgAFLs5A=
Date: Tue, 18 Aug 2026 08:11:36 +0000
Message-ID: <898dbda9dea547649b1ad6781a356090@huawei.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <aoMIQo7y_DyafUDg@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aoMIQo7y_DyafUDg@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.234]
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



> On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Br=F8rup wrote:
> > Added a new high-performance lock-free "pile", using the Stack API.
> > The pile behaves roughly like a stack, but is not strictly LIFO.
> >
> > The pile is optimized for pushing/popping bulks of objects, which
> > it does significantly faster than the lock-free stack.
> >
> > Pushing/popping a number of objects not divisible by the compile time
> > configurable bulk size is handled gracefully, but not as fast as
> > complete bulks.
> >
> > Performance examples, stack_pile_perf_autotest vs. stack_lf_autotest:
> >
> > On a single core, pushing/popping 1 or 8 objects is similar speed.
> > On a single core, pushing/popping 32 objects is 2x faster.
> > On a single core, pushing/popping 512 objects is 10x faster.
> >
> > On four cores, pushing/popping 1, 8 or 32 objects is slightly faster.
> > On four cores, pushing/popping 512 objects is 4x faster.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  app/test/test_stack.c               |  71 +++++-
> >  app/test/test_stack_perf.c          |  15 +-
> >  config/rte_config.h                 |   3 +
> >  doc/guides/prog_guide/stack_lib.rst |  67 +++++-
> >  lib/mempool/rte_mempool.h           |   2 +-
> >  lib/stack/meson.build               |   3 +-
> >  lib/stack/rte_stack.c               |  18 +-
> >  lib/stack/rte_stack.h               |  79 +++++++
> >  lib/stack/rte_stack_lf.h            |   1 +
> >  lib/stack/rte_stack_pile.c          |  35 +++
> >  lib/stack/rte_stack_pile.h          | 334 ++++++++++++++++++++++++++++
> >  11 files changed, 609 insertions(+), 19 deletions(-)
> >  create mode 100644 lib/stack/rte_stack_pile.c
> >  create mode 100644 lib/stack/rte_stack_pile.h
> >
> Looking at this a little closer, and thinking some more, here are some of
> my further thoughts/ideas on this:
>=20
> * For most cases using a mempool, I can't see having non-strict LIFO
>   behaviour being an issue, and there is nothing in the mempool API that
>   makes any ordering guarantees about what buffers get given by get/put,
>   and in fact we can't make any guarantees because of the fact of multipl=
e
>   cores doing allocs and frees. Therefore, for the mempool driver, I
>   believe one pre-emptible implementation is enough, so therefore the pil=
e
>   mempool driver should just replace the current LF one.
> * For apps which may want to use the stack structs directly, not through =
a
>   mempool, I can see that having defined ordering behaviour may be
>   beneficial. However, if multiple cores are involved, then we can never
>   guarantee ordering, I believe, so I'm not sure its worth trying to
>   enforce strict LIFO for such cases. [If you need the same elements back
>   in the correct order from a core, then use a regular stack without shar=
ing
>   it].
> * IF we decide that we really, really want LIFO ordering across multiple
>   cores - despite the likely random ordering of allocs/frees between thos=
e
>   cores, I still think that this implementation should replace the LF
>   stack. If we reverse the order of elements on enqueue (or dequeue) then
>   we should be closer to correct LIFO ordering - and fully lifo if allocs
>   and frees are based on multiples of the burst size.
>=20
> I suppose for me the main question to be resolved is - do we have scenari=
os
> where we a) have multi-core operation on the stacks and b) absolutely mus=
t
> have strict LIFO ordering? In the absense of that, I'd very much be in
> favour of replacing the existing LF implementation completely with this
> one.

I am agree with Bruce - it is probably worth to replace current lfstack imp=
lementation with this new one,
as new one is proved to be way much faster.
One more observation: instead of making RTE_STACK_PILE_BULK_SIZE compile ti=
me constant,
why not to make it configurable variable (at lfstack instance creation time=
)?
Then in theory we can support current behavior too - user can create a pile=
 with no bulks,
and all requests will go via solo code-path.   =20
That way we'll have good perf improvement, while preserving old-behavior co=
mpatibility for those
who needs it.
Though have to admit, I don't know any off-hand who will need it :)


=20

