Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE95C19F2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 09:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E55740671;
	Thu, 27 Feb 2025 10:14:30 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1233C40290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 10:14:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D5E4320EB4;
 Thu, 27 Feb 2025 10:14:28 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] mempool: micro optimizations
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 10:14:27 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA86@smartserver.smartshare.dk>
In-Reply-To: <Z79G8hI3Yc6kcT2O@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: micro optimizations
Thread-Index: AduIbvIjALCtlDjfTt6IZVP2XQC+FgAFa0hQ
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z79G8hI3Yc6kcT2O@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
	<dev@dpdk.org>
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
> Sent: Wednesday, 26 February 2025 17.53
>=20
> On Wed, Feb 26, 2025 at 03:59:22PM +0000, Morten Br=F8rup wrote:
> > The comparisons lcore_id < RTE_MAX_LCORE and lcore_id !=3D =
LCORE_ID_ANY
> are
> > equivalent, but the latter compiles to fewer bytes of code space.
> > Similarly for lcore_id >=3D RTE_MAX_LCORE and lcore_id =3D=3D =
LCORE_ID_ANY.
> >
> > The rte_mempool_get_ops() function is also used in the fast path, so
> > RTE_VERIFY() was replaced by RTE_ASSERT().
> >
> > Compilers implicitly consider comparisons of variable =3D=3D 0 =
likely, so
> > unlikely() was added to the check for no mempool cache (mp-
> >cache_size =3D=3D
> > 0) in the rte_mempool_default_cache() function.
> >
> > The rte_mempool_do_generic_put() function for adding objects to a
> mempool
> > was refactored as follows:
> > - The comparison for the request itself being too big, which is
> considered
> >   unlikely, was moved down and out of the code path where the cache
> has
> >   sufficient room for the added objects, which is considered the =
most
> >   likely code path.
> > - Added __rte_assume() about the cache length, size and threshold,
> for
> >   compiler optimization when "n" is compile time constant.
> > - Added __rte_assume() about "ret" being zero, so other functions
> using
> >   the value returned by this function can be potentially optimized =
by
> the
> >   compiler; especially when it merges multiple sequential code paths
> of
> >   inlined code depending on the return value being either zero or
> >   negative.
> > - The refactored source code (with comments) made the separate
> comment
> >   describing the cache flush/add algorithm superfluous, so it was
> removed.
> >
> > A few more likely()/unlikely() were added.
> >
> > A few comments were improved for readability.
> >
> > Some assertions, RTE_ASSERT(), were added. Most importantly to =
assert
> that
> > the return values of the mempool drivers' enqueue and dequeue
> operations
> > are API compliant, i.e. 0 (for success) or negative (for failure),
> and
> > never positive.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  lib/mempool/rte_mempool.h | 67 =
++++++++++++++++++++++---------------
> --
> >  1 file changed, 38 insertions(+), 29 deletions(-)
> >
> Is there any measurable performance change with these modifications?

It varies.
Here are some of the good ones, tested on a VM under VMware:

mempool_autotest cache=3D512 cores=3D1
n_get_bulk=3D64 n_put_bulk=3D64 n_keep=3D128 constant_n=3D0
rate_persec=3D1309408130 -> 1417067889 : +8.2 %

mempool_autotest cache=3D512 cores=3D1
n_get_bulk=3D64 n_put_bulk=3D64 n_keep=3D128 constant_n=3D1
rate_persec=3D1479812844 -> 1573307159 : +6.3 %

mempool_autotest cache=3D512 cores=3D1
n_max_bulk=3D32 n_keep=3D128 constant_n=3D0
rate_persec=3D825183959 -> 868013386 : +5.2 %

The last result is from a new type of test where the size of every =
get/put varies between 1 and n_max_bulk, so the CPU's dynamic branch =
predictor cannot predict the request size.
I'll probably provide a separate patch for test_mempool_perf.c with this =
new test type, when I have finished it.

