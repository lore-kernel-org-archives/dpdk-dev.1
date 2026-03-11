Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E41125866
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:29:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FCFD410D0;
	Wed, 11 Mar 2026 19:29:41 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 21ECF40EF0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 19:29:40 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EC46720A38;
 Wed, 11 Mar 2026 19:29:39 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH v7] eal/x86: optimize memcpy of small sizes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Mar 2026 19:29:38 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6577E@smartserver.smartshare.dk>
In-Reply-To: <abGfSARwKc4TV_dU@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] eal/x86: optimize memcpy of small sizes
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdyxeF5VSAlf5NnOQICw9RagTe1E4AACcbCQ
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260220110824.235784-1-mb@smartsharesystems.com>
 <abGfSARwKc4TV_dU@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Liangxing Wang" <wangliangxing@hygon.cn>,
 "Thiyagarajan P" <Thiyagarajan.P@amd.com>,
 "Bala Murali Krishna" <Bala.MuraliKrishna@amd.com>
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
> Sent: Wednesday, 11 March 2026 17.59
>=20
> On Fri, Feb 20, 2026 at 11:08:24AM +0000, Morten Br=F8rup wrote:
> > The implementation for copying up to 64 bytes does not depend on
> address
> > alignment with the size of the CPU's vector registers. Nonetheless,
> the
> > exact same code for copying up to 64 bytes was present in both the
> aligned
> > copy function and all the CPU vector register size specific variants
> of
> > the unaligned copy functions.
> > With this patch, the implementation for copying up to 64 bytes was
> > consolidated into one instance, located in the common copy function,
> > before checking alignment requirements.
> > This provides three benefits:
> > 1. No copy-paste in the source code.
> > 2. A performance gain for copying up to 64 bytes, because the
> > address alignment check is avoided in this case.
> > 3. Reduced instruction memory footprint, because the compiler only
> > generates one instance of the function for copying up to 64 bytes,
> instead
> > of two instances (one in the unaligned copy function, and one in the
> > aligned copy function).
> >
> > Furthermore, the function for copying less than 16 bytes was =
replaced
> with
> > a smarter implementation using fewer branches and potentially fewer
> > load/store operations.
> > This function was also extended to handle copying of up to 16 bytes,
> > instead of up to 15 bytes.
> > This small extension reduces the code path, and thus improves the
> > performance, for copying two pointers on 64-bit architectures and
> four
> > pointers on 32-bit architectures.
> >
> > Also, __rte_restrict was added to source and destination addresses.
> >
> > And finally, the missing implementation of rte_mov48() was added.
> >
> > Regarding performance, the memcpy performance test showed cache-to-
> cache
> > copying of up to 32 bytes now takes 2 cycles, versus ca. 6.5 cycles
> before
> > this patch.
> > Copying 64 bytes now takes 4 cycles, versus 7 cycles before.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> > v7:
> > * Updated patch description. Mainly to clarify that the changes
> related to
> >   copying up to 64 bytes simply replaces multiple instances of copy-
> pasted
> >   code with one common instance.
> > * Fixed copy of build time known 16 bytes in rte_mov17_to_32().
> (Vipin)
> > * Rebased.
> > v6:
> > * Went back to using rte_uintN_alias structures for copying instead
> of
> >   using memcpy(). They were there for a reason.
> >   (Inspired by the discussion about optimizing the checksum
> function.)
> > * Removed note about copying uninitialized data.
> > * Added __rte_restrict to source and destination addresses.
> >   Updated function descriptions from "should" to "must" not overlap.
> > * Changed rte_mov48() AVX implementation to copy 32+16 bytes instead
> of
> >   copying 32 + 32 overlapping bytes. (Konstantin)
> > * Ignoring "-Wstringop-overflow" is not needed, so it was removed.
> > v5:
> > * Reverted v4: Replace SSE2 _mm_loadu_si128() with SSE3
> _mm_lddqu_si128().
> >   It was slower.
> > * Improved some comments. (Konstantin Ananyev)
> > * Moved the size range 17..32 inside the size <=3D 64 branch, so =
when
> >   building for SSE, the generated code can start copying the first
> >   16 bytes before comparing if the size is greater than 32 or not.
> > * Just require RTE_MEMCPY_AVX for using rte_mov32() in
> rte_mov33_to_64().
> > v4:
> > * Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
> > v3:
> > * Fixed typo in comment.
> > v2:
> > * Updated patch title to reflect that the performance is improved.
> > * Use the design pattern of two overlapping stores for small copies
> too.
> > * Expanded first branch from size < 16 to size <=3D 16.
> > * Handle more build time constant copy sizes.
> > ---
> >  lib/eal/x86/include/rte_memcpy.h | 526 =
++++++++++++++++++++---------
> --
> >  1 file changed, 348 insertions(+), 178 deletions(-)
> >
>=20
> I'm a little unhappy to see the amount of memcpy code growing rather
> than
> shrinking, but since it improves performance I'm ok with it. We should
> keep
> it under constant review though.

Agree!

I just counted; 149 of the added lines are for handling =
__rte_constant(n). So it's not as bad as it looks.
But still growing, which was not the intention.
When I started working on this patch, the intention was to consolidate =
the copy-pasted instances for handling up to 64 bytes into one instance. =
This should have reduced the amount of code.
But then it somehow grew anyway.

>=20
> > diff --git a/lib/eal/x86/include/rte_memcpy.h
> b/lib/eal/x86/include/rte_memcpy.h
> > index 46d34b8081..ed8e5f8dc4 100644
> > --- a/lib/eal/x86/include/rte_memcpy.h
> > +++ b/lib/eal/x86/include/rte_memcpy.h
> > @@ -22,11 +22,6 @@
> >  extern "C" {
> >  #endif
> >
> > -#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 100000)
> > -#pragma GCC diagnostic push
> > -#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > -#endif
> > -
> >  /*
> >   * GCC older than version 11 doesn't compile AVX properly, so use
> SSE instead.
> >   * There are no problems with AVX2.
> > @@ -40,9 +35,6 @@ extern "C" {
> >  /**
> >   * Copy bytes from one location to another. The locations must not
> overlap.
> >   *
> > - * @note This is implemented as a macro, so it's address should not
> be taken
> > - * and care is needed as parameter expressions may be evaluated
> multiple times.
> > - *
>=20
> I'd be wary about completely removing this comment, as we may well =
want
> to
> go back to a macro in the future, e.g. if we decide to remove the
> custom
> rte_memcpy altogether. Therefore, rather than removing the comment, =
can
> we
> tweak it to say "This may be implemented as a macro..."

The comment is still present in the "generic" header file used for the =
Doxygen documentation:
https://elixir.bootlin.com/dpdk/v26.03-rc1/source/lib/eal/include/generic=
/rte_memcpy.h#L99

All other architectures rely on the "generic" header file, and have no =
Doxygen comments at all.
We could also remove them from the x86 implementation.
That would shrink the file even more. ;-)
But I'd rather keep the comments - at least for now.

>=20
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Thank you for quick response, Bruce.

>=20
> PS: If we want a little further cleanup, I'd consider removing the
> RTE_MEMCPY_AVX macro and replacing it with a straight check for
> __AVX2__.
> CPUs with AVX2 was introduced in 2013, and checking Claude and
> Wikipedia
> says that AMD parts started having it in 2015, meaning that there were
> only
> a few generations of CPUs >10 years ago which had AVX but not AVX2.
> [There
> were later CPUs e.g. lower-end parts, which didn't have AVX2, but they
> didn't have AVX1 either, so SSE is the only choice there]
> Not a big cleanup if we did remove it, but sometimes every little
> helps!

Good idea. But let's not do it now.

