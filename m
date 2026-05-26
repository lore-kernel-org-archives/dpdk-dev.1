Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A5CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:57:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D2040695;
	Tue, 26 May 2026 10:57:31 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5857B40280
 for <dev@dpdk.org>; Tue, 26 May 2026 10:57:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2E5C020A2F;
 Tue, 26 May 2026 10:57:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] mempool: improve cache behaviour and performance
Date: Tue, 26 May 2026 10:57:22 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6589B@smartserver.smartshare.dk>
In-Reply-To: <ahCAgitAAK3e5Kf3@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mempool: improve cache behaviour and performance
Thread-Index: AdzqBd8290TXpe3IQVGZyqH7ljztuAC5xtmw
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAgitAAK3e5Kf3@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>
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
> Sent: Friday, 22 May 2026 18.13
>=20
> On Sun, Apr 19, 2026 at 09:55:26AM +0000, Morten Br=F8rup wrote:
> > This patch refactors the mempool cache to eliminate some unexpected
> > behaviour and reduce the mempool cache miss rate.
> >
> > 1.
> > The actual cache size was 1.5 times the cache size specified at run-
> time
> > mempool creation.
> > This was obviously not expected by application developers.
> >
> > 2.
> > In get operations, the check for when to use the cache as bounce
> buffer
> > did not respect the run-time configured cache size,
> > but compared to the build time maximum possible cache size
> > (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> > E.g. with a configured cache size of 32 objects, getting 256 objects
> > would first fetch 32 + 256 =3D 288 objects into the cache,
> > and then move the 256 objects from the cache to the destination
> memory,
> > instead of fetching the 256 objects directly to the destination
> memory.
> > This had a performance cost.
> > However, this is unlikely to occur in real applications, so it is =
not
> > important in itself.
> >
> > 3.
> > When putting objects into a mempool, and the mempool cache did not
> have
> > free space for so many objects,
> > the cache was flushed completely, and the new objects were then put
> into
> > the cache.
> > I.e. the cache drain level was zero.
> > This (complete cache flush) meant that a subsequent get operation
> (with
> > the same number of objects) completely emptied the cache,
> > so another subsequent get operation required replenishing the cache.
> >
> > Similarly,
> > When getting objects from a mempool, and the mempool cache did not
> hold so
> > many objects,
> > the cache was replenished to cache->size + remaining objects,
> > and then (the remaining part of) the requested objects were fetched
> via
> > the cache,
> > which left the cache filled (to cache->size) at completion.
> > I.e. the cache refill level was cache->size (plus some, depending on
> > request size).
> >
> > (1) was improved by generally comparing to cache->size instead of
> > cache->flushthresh, when considering the capacity of the cache.
> > The cache->flushthresh field is kept for API/ABI compatibility
> purposes,
> > and initialized to cache->size instead of cache->size * 1.5.
> >
> > (2) was improved by generally comparing to cache->size / 2 instead =
of
> > RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.
> >
> > (3) was improved by flushing and replenishing the cache by half its
> size,
> > so a flush/refill can be followed randomly by get or put requests.
> > This also reduced the number of objects in each flush/refill
> operation.
> >
> > As a consequence of these changes, the size of the array holding the
> > objects in the cache (cache->objs[]) no longer needs to be
> > 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
> > RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.
> >
> > Performance data:
> > With a real WAN Optimization application, where the number of
> allocated
> > packets varies (as they are held in e.g. shaper queues), the mempool
> > cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> > This was deployed in production at an ISP, and using an effective
> cache
> > size of 384 objects.
> >
> > As a consequence of the improved mempool cache algorithm, some
> drivers
> > were updated accordingly:
> > - The Intel idpf PMD was updated regarding how much to backfill the
> >   mempool cache in the AVX512 code.
> > - The NXP dpaa and dpaa2 mempool drivers were updated to not set the
> >   mempool cache flush threshold; doing this no longer has any =
effect,
> and
> >   thus became superfluous.
> >
> > Bugzilla ID: 1027
> > Fixes: ea5dd2744b90 ("mempool: cache optimisations")
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> > Depends-on: patch-163181 ("net/intel: do not bypass mbuf lib for =
mbuf
> fast-free")
> > ---
> > v5:
> > * Flush the cache from the bottom, where objects are colder, and =
move
> down
> >   the remaining objects, which are hotter.
> > * In the Intel idpf PMD, move up the hot objects in the cache and
> refill
> >   with cold objects at the bottom.
> > v4:
> > * Added Bugzilla ID.
> > * Added Fixes tag. For reference only.
> > * Moved fast-free related update of Intel common driver out as a
> separate
> >   patch, and depend on that patch.
> > * Omitted unrelated changes to the Intel idpf AVX512 driver,
> specifically
> >   fixing an indentation and adding mbuf instrumentation.
> > * Omitted unrelated changes to the mempool library, specifically
> adding
> >   __rte_restrict and changing a couple of comments to proper
> sentences.
> > * Please checkpatches by swapping operators in a couple of
> comparisons.
> > v3:
> > * Fixed my copy-paste bug in idpf_splitq_rearm().
> > v2:
> > * Fixed issue found by abidiff:
> >   Reverted cache objects array size reduction. Added a note instead.
> > * Added missing mbuf instrumentation to the Intel idpf AVX512 =
driver.
> > * Updated idpf_splitq_rearm() like idpf_singleq_rearm().
> > * Added a few more __rte_assume(). (Inspired by AI review)
> > * Updated NXP dpaa and dpaa2 mempool drivers to not set mempool =
cache
> >   flush threshold.
> > * Added release notes.
> > * Added deprecation notes.
> > ---
> >  doc/guides/rel_notes/deprecation.rst          |  7 ++
> >  doc/guides/rel_notes/release_26_07.rst        | 10 +++
> >  drivers/mempool/dpaa/dpaa_mempool.c           | 14 ----
> >  drivers/mempool/dpaa2/dpaa2_hw_mempool.c      | 14 ----
> >  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 52 +++++++++++---
> >  lib/mempool/rte_mempool.c                     | 14 +---
> >  lib/mempool/rte_mempool.h                     | 70 =
++++++++++++-----
> --
> >  7 files changed, 104 insertions(+), 77 deletions(-)
> >
> Can the idpf and dpaa changes be made in separate patches, so we can
> review
> the mempool changes along in a single patch? Even if the commits can't
> work
> logically together, perhaps they can be separated for review, and then
> squashed on apply?

Sure.

The idpf changes are required due to the driver bypassing the mempool =
API.
If such direct access to the mempool cache is required, it would be =
better to add a mempool cache zero-copy API.

The dpaa changes are simple clean-ups.
They set a variable which this mempool change makes obsolete, so no need =
to set it.

