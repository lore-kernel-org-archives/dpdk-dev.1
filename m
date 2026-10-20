Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755E606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A531B40270;
	Tue, 20 Oct 2026 11:59:19 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B286040144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:59:17 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7DE3C202D4;
 Tue, 20 Oct 2026 11:59:17 +0200 (CEST)
Content-class: urn:content-classes:message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] stack: fix pile GCC memcpy warnings
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 20 Oct 2026 11:59:14 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65ACB@smartserver.smartshare.dk>
In-Reply-To: <atcx9-0kXa2XrzrB@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] stack: fix pile GCC memcpy warnings
Thread-Index: Ad1gdA56FnO1rlJEQTiuz2EqEZGzkQAAsJSg
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
 <atcx9-0kXa2XrzrB@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Ali Alnubani" <alialnu@nvidia.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 20 October 2026 11.19
>=20
> On Tue, Oct 20, 2026 at 08:49:44AM +0000, Morten Br=F8rup wrote:
> > On architectures where rte_memcpy() is defined as memcpy(),
> > GCC warns about source/destination overflow when copying more than
> the
> > source/destination size, even for code paths that are not taken in
> cases
> > where the sizes are smaller.
> >
> > The relevant compiler warnings were disabled for GCC at the two
> > occurrences, and comments describing the reason were added.
> >
> > NB:
> > It has not been investigated which GCC versions are affected.
> > GCC version 10 and up was chosen because that was what the previous
> > versions of x86 rte_memcpy() disabled sligthly similar warnings for.
> >
> > PS:
> > The alternative was to obfuscate the code, but that would make the
> code
> > less readable, and might have unintended effects on architectures =
and
> > compilers not suffering by this issue.
> >
> > Bugzilla ID: 2061
> > Fixes: ee0822a0ef41 ("stack: introduce pile")
> >
> > The pile was introduce with this DPDK release, so no need to
> backport.
> >
> > Reported-by: Ali Alnubani <alialnu@nvidia.com>
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  lib/stack/rte_stack_pile.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/lib/stack/rte_stack_pile.h b/lib/stack/rte_stack_pile.h
> > index 819bd1d47a..69aa0cbf88 100644
> > --- a/lib/stack/rte_stack_pile.h
> > +++ b/lib/stack/rte_stack_pile.h
> > @@ -154,12 +154,25 @@ __rte_stack_pile_push(struct rte_stack *s,
> >  	 * Construct the bulk elements.
> >  	 * Copy bulks in reverse order, but ignore the object order
> within each bulk.
> >  	 */
> > +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 100000)
> > +/*
> > + * On architectures where rte_memcpy() is defined as memcpy(),
> > + * although GCC knows that this code path is not taken when the
> source's size is smaller than
> > + * RTE_STACK_PILE_BULK_SIZE, it still warns about memcpy() source
> overread.
> > + * So we disable the compiler warning for this memcpy() instance.
> > + */
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wstringop-overread"
> > +#endif
> >  	tmp =3D (struct rte_stack_lf_elem *)bulk_first;
> >  	__rte_assume(n_bulk > 0);

I also tried removing  this __rte_assume(). No effect.

> >  	for (i =3D 0; i < n_bulk; i++, tmp =3D tmp->next)
> >  		rte_memcpy(((struct rte_stack_pile_bulk_elem *)tmp)->objs,
> >  				&obj_table[(n_bulk - i - 1) *
> RTE_STACK_PILE_BULK_SIZE],
> >  				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
>=20
> An rte_assume before the memcpy asserting the sizes doesn't help?

GCC complains about the size of the obj_table.
memcpy() overruns it when n=3D=3D1, and thus the compiler knows that the =
size of obj_table is only one object.
Which is true, because this instance of memcpy() copies 32 =
(RTE_STACK_PILE_BULK_SIZE) objects.
But GCC ignores the fact that this code path is not taken when n=3D=3D1, =
and warns anyway.

GCC completely ignores that the code path is not taken.
Referring to description in Bugzilla, it warns when called with =
pushing/popping 1 object.

For verifying that the compiler knows that the problematic code is part =
of the code path when handling 1 object, and ignores this fact anyway, I =
even tried something like:

if (n >=3D RTE_STACK_PILE_BULK_SIZE) {
	bulk copy loop;
}

And it still warns.

>=20
> > +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 100000)
> > +#pragma GCC diagnostic pop
> > +#endif
