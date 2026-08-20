Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4634340268;
	Thu, 20 Aug 2026 15:07:44 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9261C400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:07:43 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Tf+5DUYA4hMaf1jy+DsC7SCDbTscgdeF95jZgztoHSk=;
 b=jzTV3Oy+QgHtN4aClNxJ9pY3QETEsXlZDA9FBW0cVUdyyLizZ2MnDMblsZdCd56jq6FEDSZ3I
 YFZks8gKB7oX0kqEySTrL0HOrd/1zwbiIvTwOemTcTQe/viQ4xEtMHIs+rvKRAp1BShSSAeFvoo
 RuNHH0ec3Ce+ESvjPG6wv00=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hQkHT06gKzHnGcs;
 Thu, 20 Aug 2026 21:07:17 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C4FF140570;
 Thu, 20 Aug 2026 21:07:38 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Aug 2026 14:07:38 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 20 Aug 2026 14:07:38 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH 00/61] reduce use of rte_memcpy
Thread-Topic: [PATCH 00/61] reduce use of rte_memcpy
Thread-Index: AQHdMGQKcnXPGD6CJUuLHW36LEokwbamelUAgAAionCAAAR2IIAAPMvQ
Date: Thu, 20 Aug 2026 13:07:38 +0000
Message-ID: <f469a51afd3547eca1ce56f6abb0285b@huawei.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
 <42ecbb8129514f52b456549ee66757b2@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
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



> > > About replacing rte_memcpy with memcpy()...
> > >
> > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > Sent: Thursday, 20 August 2026 07.12
> > > >
> > > > The DPDK function rte_memcpy() only exists as an optimization
> > > > for shortcomings in performance of libc memcpy() on some platforms.
> > >
> > > Yes, and those platforms should benefit from it.
> > >
> > > E.g. the vhost performance improvements for Haswell and Broadwell
> > [1].
> > > Where similar performance improvements implemented in the relevant
> > > compilers (GCC, Clang, MSVC)?
> > >
> > > [1]:
> > >
> >
> https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd
> > > 3675fa
> > >
> > > IMO, performance should remain a high priority for DPDK.
> >
> > As I can read the series, good few of them do remove rte_memcpy from
> > the CP,
> > where it is clearly irrelevant.
>=20
> Agree!
>=20
> > For those on the DP, at least for some of them we can run perf tests:
> > let say for hash we do have perf_autotest which can be used to measure
> > the
> > perf diff. If there is none, or neglectable - then no point to keep
> > rte_memcpy here.
>=20
> Unless that perf test is run on all platforms, the result only shows perf=
 diff on
> the tested platforms.

How this patch differs from all others?
For each and every change we made in DPDK, to ensure that there is no
perf regression introduced we rely on:
1) CI auto testing
2) manual testing from some platform vendors (once per release cycle)
3) good will of submitter to test the changes he produces as much as possib=
le
Obviously, yes we are not testing on each possible platform and yes, in the=
ory
some regressions can sneak in unseen.
But that could happen with other patches too, so from my perspective -
we just need our usual testing procedure here, if it shows no regression,
the patch is good to go in.

> >
> > >
> > > > Many platforms have no special rte_memcpy() and just use memcpy().
> > > >
> > > > But many analysis and test tools know that memcpy() is a special
> > > > case and check for overwrite, bounds errors etc. Therefore memcpy()
> > > > should be preferred wherever possible.
> > >
> > > I think this is the only substantial benefit of replacing
> > rte_memcpy() with
> > > memcpy()!
> > > Could we reap this benefit by having special builds for such tools,
> > where
> > > rte_memcpy() is modified to use memcpy() instead?
> > > Then we wouldn't have to compromise on performance.
> > >
> > > Also, rte_memcpy() used to have a pragma disabling bounds checks due
> > to some
> > > Intel drivers using [0] instead of []; the pragma was removed from
> > rte_memcpy()
> > > when the Intel drivers were fixed.
> > > I'm not sufficiently familiar with analysis/test tools to say what
> > they can detect
> > > when using memcpy() instead of the copy methods used by rte_memcpy().
> > >
> > > >
> > > > This patch series introduces a coccinelle script to find
> > > > calls to rte_memcpy() where size is fixed, and change them to
> > > > regular memcpy(). This was the starting point for this cleanup.
> > > >
> > > > There is also some cleanups to include rte_memcpy.h and string.h
> > > > where needed. Often the includes were happening by some other
> > > > header. And also removal of rte_memcpy.h where no longer needed.
> > > >
> > > > The result is a 46% reduction in use of rte_memcpy.
> > > > The remaining rte_memcpy can be cleaned up later:
> > > >  - drivers with active maintenance (like mlx5);
> > > >  - changes to rte_memcpy which need benchmarking;
> > > >  - test code for rte_memcpy can be removed as last step.
> > > >
> > > > No functional change, no warnings in all compilers including LTO.
> > >
> > > memcpy() does not always use inline vector instructions for fixed
> > size copy [2].
> > >
> > > [2]:
> > >
> https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@sma
> > > rtserver.smartshare.dk/
> > >
> > >
> > > Another disadvantage of rte_memcpy() is the lack of developer
> > guidance.
> > > It is not well documented when to use rte_memcpy() and when to use
> > memcpy().
> > > We discussed something similar on the Tech Board meeting yesterday;
> > it is not
> > > well documented when to use which type of "ring" (normal, RTS, HTS),
> > so maybe
> > > we could remove one of them.
> > > But removing an option is not an improvement, if the removed option
> > would
> > > have been the better choice for some use cases.
> > >
> > > PS: The general guidance for rte_memcpy() usage is something like:
> > > rte_memcpy() only in fast path,
> > > memcpy() everywhere else,
> > > assignment "=3D" when copying fixed size structures.
> >
> > I suppose for te_memcpy() we can be even more strict:
> > Use it only for DP, and only after measurement, that shows
> > clear perf improvement over ordinal memcpy().
> > Alnd also ask contributors to document it (in the comments), i.e.:
> > /* on <platform testsed> rte_memcpy() gives X% perf boost when doing
> > ...*/
> > rte_memcpy(...);
>=20
> Disagree!
> DPDK has performance optimized libs and functions.
> Developers should not need to document that using a DPDK function is fast=
er
> than using a libc function.
> We don't require perf measurements for using DPDK rte_hash instead of lib=
c
> hashmap.

Not sure what libc hashmap you are talking about?
AFAIK such thing doesn't exist.. or you talking about c++ maps?
If so, then I think the analogy is not correct.
Why not to remember another example when we get rid of our own
hand-written atomics and barriers in favor of using atomics ones.

>=20
> I agree about not using rte_memcpy() in the control plane.
> And I support Stephen's effort to clean this up.
>=20
> But why the eagerness to avoid using rte_memcpy() in the fast path?

I think we are not talking about 'avoiding' but about 'limiting'.
There are many cases, when people use rte_memcpy() just because
'it is used in other places, so it is probably better'=20
In general memcpy()  and rte_memcpy() have same syntax,
provide same functionality, plus CC vendors made a good progress in optimiz=
ing memcpy(),
so now for many cases it provides nearly the same or better performance.
I think no-one forces to replace rte_memcpy() in places where it does provi=
de better results,
but for the cases when there is no perf difference, I think memcpy() should=
 have precedence.
     =20


