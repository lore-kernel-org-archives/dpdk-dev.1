Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD206C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 09:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C43BC40150;
	Thu, 20 Aug 2026 11:03:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2985C400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 11:03:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D9A3B207DD;
 Thu, 20 Aug 2026 11:03:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 00/61] reduce use of rte_memcpy
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 20 Aug 2026 11:03:13 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
In-Reply-To: <42ecbb8129514f52b456549ee66757b2@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 00/61] reduce use of rte_memcpy
Thread-Index: AQHdMGQKcnXPGD6CJUuLHW36LEokwbamelUAgAAionCAAAR2IA==
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
 <42ecbb8129514f52b456549ee66757b2@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
>=20
> > About replacing rte_memcpy with memcpy()...
> >
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Thursday, 20 August 2026 07.12
> > >
> > > The DPDK function rte_memcpy() only exists as an optimization
> > > for shortcomings in performance of libc memcpy() on some =
platforms.
> >
> > Yes, and those platforms should benefit from it.
> >
> > E.g. the vhost performance improvements for Haswell and Broadwell
> [1].
> > Where similar performance improvements implemented in the relevant
> > compilers (GCC, Clang, MSVC)?
> >
> > [1]:
> >
> https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd
> > 3675fa
> >
> > IMO, performance should remain a high priority for DPDK.
>=20
> As I can read the series, good few of them do remove rte_memcpy from
> the CP,
> where it is clearly irrelevant.

Agree!

> For those on the DP, at least for some of them we can run perf tests:
> let say for hash we do have perf_autotest which can be used to measure
> the
> perf diff. If there is none, or neglectable - then no point to keep
> rte_memcpy here.

Unless that perf test is run on all platforms, the result only shows =
perf diff on the tested platforms.

>=20
> >
> > > Many platforms have no special rte_memcpy() and just use memcpy().
> > >
> > > But many analysis and test tools know that memcpy() is a special
> > > case and check for overwrite, bounds errors etc. Therefore =
memcpy()
> > > should be preferred wherever possible.
> >
> > I think this is the only substantial benefit of replacing
> rte_memcpy() with
> > memcpy()!
> > Could we reap this benefit by having special builds for such tools,
> where
> > rte_memcpy() is modified to use memcpy() instead?
> > Then we wouldn't have to compromise on performance.
> >
> > Also, rte_memcpy() used to have a pragma disabling bounds checks due
> to some
> > Intel drivers using [0] instead of []; the pragma was removed from
> rte_memcpy()
> > when the Intel drivers were fixed.
> > I'm not sufficiently familiar with analysis/test tools to say what
> they can detect
> > when using memcpy() instead of the copy methods used by =
rte_memcpy().
> >
> > >
> > > This patch series introduces a coccinelle script to find
> > > calls to rte_memcpy() where size is fixed, and change them to
> > > regular memcpy(). This was the starting point for this cleanup.
> > >
> > > There is also some cleanups to include rte_memcpy.h and string.h
> > > where needed. Often the includes were happening by some other
> > > header. And also removal of rte_memcpy.h where no longer needed.
> > >
> > > The result is a 46% reduction in use of rte_memcpy.
> > > The remaining rte_memcpy can be cleaned up later:
> > >  - drivers with active maintenance (like mlx5);
> > >  - changes to rte_memcpy which need benchmarking;
> > >  - test code for rte_memcpy can be removed as last step.
> > >
> > > No functional change, no warnings in all compilers including LTO.
> >
> > memcpy() does not always use inline vector instructions for fixed
> size copy [2].
> >
> > [2]:
> > =
https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@sma
> > rtserver.smartshare.dk/
> >
> >
> > Another disadvantage of rte_memcpy() is the lack of developer
> guidance.
> > It is not well documented when to use rte_memcpy() and when to use
> memcpy().
> > We discussed something similar on the Tech Board meeting yesterday;
> it is not
> > well documented when to use which type of "ring" (normal, RTS, HTS),
> so maybe
> > we could remove one of them.
> > But removing an option is not an improvement, if the removed option
> would
> > have been the better choice for some use cases.
> >
> > PS: The general guidance for rte_memcpy() usage is something like:
> > rte_memcpy() only in fast path,
> > memcpy() everywhere else,
> > assignment "=3D" when copying fixed size structures.
>=20
> I suppose for te_memcpy() we can be even more strict:
> Use it only for DP, and only after measurement, that shows
> clear perf improvement over ordinal memcpy().
> Alnd also ask contributors to document it (in the comments), i.e.:
> /* on <platform testsed> rte_memcpy() gives X% perf boost when doing
> ...*/
> rte_memcpy(...);

Disagree!
DPDK has performance optimized libs and functions.
Developers should not need to document that using a DPDK function is =
faster than using a libc function.
We don't require perf measurements for using DPDK rte_hash instead of =
libc hashmap.

I agree about not using rte_memcpy() in the control plane.
And I support Stephen's effort to clean this up.

But why the eagerness to avoid using rte_memcpy() in the fast path?

