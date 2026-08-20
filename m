Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCCBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 08:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3884F40150;
	Thu, 20 Aug 2026 10:46:32 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B9E12400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 10:46:30 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qFruIhZmZIKw8G6kMMU++CtT3MC1RhjtgrFv3rI40Z4=;
 b=FZbYuhZn4lBQrxIAIB5LhhVCWX2cnHvyU9K3Va+dgGWgrkUGt9P12zhnwBkXsKayDOK/7DqOL
 l2YlYOJndE98jDtKiRSoXHkMJe38L840lRdEjfNAJ4xLPDGkliys/i5nN6+DTX+9LOFwhYrJX1t
 u4E7K0xOIVXD8Wm5rhfHyAQ=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hQcVG1dm3zJ46ZL;
 Thu, 20 Aug 2026 16:46:14 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id AA46B40576;
 Thu, 20 Aug 2026 16:46:23 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 09:46:23 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 20 Aug 2026 09:46:13 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH 00/61] reduce use of rte_memcpy
Thread-Topic: [PATCH 00/61] reduce use of rte_memcpy
Thread-Index: AQHdMGQKcnXPGD6CJUuLHW36LEokwbamelUAgAAionA=
Date: Thu, 20 Aug 2026 08:46:13 +0000
Message-ID: <42ecbb8129514f52b456549ee66757b2@huawei.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.150.94]
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



> About replacing rte_memcpy with memcpy()...
>=20
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 20 August 2026 07.12
> >
> > The DPDK function rte_memcpy() only exists as an optimization
> > for shortcomings in performance of libc memcpy() on some platforms.
>=20
> Yes, and those platforms should benefit from it.
>=20
> E.g. the vhost performance improvements for Haswell and Broadwell [1].
> Where similar performance improvements implemented in the relevant
> compilers (GCC, Clang, MSVC)?
>=20
> [1]:
> https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd
> 3675fa
>=20
> IMO, performance should remain a high priority for DPDK.

As I can read the series, good few of them do remove rte_memcpy from the CP=
,
where it is clearly irrelevant.
For those on the DP, at least for some of them we can run perf tests:
let say for hash we do have perf_autotest which can be used to measure the=
=20
perf diff. If there is none, or neglectable - then no point to keep rte_mem=
cpy here.

>=20
> > Many platforms have no special rte_memcpy() and just use memcpy().
> >
> > But many analysis and test tools know that memcpy() is a special
> > case and check for overwrite, bounds errors etc. Therefore memcpy()
> > should be preferred wherever possible.
>=20
> I think this is the only substantial benefit of replacing rte_memcpy() wi=
th
> memcpy()!
> Could we reap this benefit by having special builds for such tools, where
> rte_memcpy() is modified to use memcpy() instead?
> Then we wouldn't have to compromise on performance.
>=20
> Also, rte_memcpy() used to have a pragma disabling bounds checks due to s=
ome
> Intel drivers using [0] instead of []; the pragma was removed from rte_me=
mcpy()
> when the Intel drivers were fixed.
> I'm not sufficiently familiar with analysis/test tools to say what they c=
an detect
> when using memcpy() instead of the copy methods used by rte_memcpy().
>=20
> >
> > This patch series introduces a coccinelle script to find
> > calls to rte_memcpy() where size is fixed, and change them to
> > regular memcpy(). This was the starting point for this cleanup.
> >
> > There is also some cleanups to include rte_memcpy.h and string.h
> > where needed. Often the includes were happening by some other
> > header. And also removal of rte_memcpy.h where no longer needed.
> >
> > The result is a 46% reduction in use of rte_memcpy.
> > The remaining rte_memcpy can be cleaned up later:
> >  - drivers with active maintenance (like mlx5);
> >  - changes to rte_memcpy which need benchmarking;
> >  - test code for rte_memcpy can be removed as last step.
> >
> > No functional change, no warnings in all compilers including LTO.
>=20
> memcpy() does not always use inline vector instructions for fixed size co=
py [2].
>=20
> [2]:
> https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@sma
> rtserver.smartshare.dk/
>=20
>=20
> Another disadvantage of rte_memcpy() is the lack of developer guidance.
> It is not well documented when to use rte_memcpy() and when to use memcpy=
().
> We discussed something similar on the Tech Board meeting yesterday; it is=
 not
> well documented when to use which type of "ring" (normal, RTS, HTS), so m=
aybe
> we could remove one of them.
> But removing an option is not an improvement, if the removed option would
> have been the better choice for some use cases.
>=20
> PS: The general guidance for rte_memcpy() usage is something like:
> rte_memcpy() only in fast path,
> memcpy() everywhere else,
> assignment "=3D" when copying fixed size structures.

I suppose for te_memcpy() we can be even more strict:
Use it only for DP, and only after measurement, that shows
clear perf improvement over ordinal memcpy().
Alnd also ask contributors to document it (in the comments), i.e.:
/* on <platform testsed> rte_memcpy() gives X% perf boost when doing ...*/
rte_memcpy(...);
=20
  =20
=20


