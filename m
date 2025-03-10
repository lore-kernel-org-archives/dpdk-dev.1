Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E3C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7138940279;
	Mon, 10 Mar 2025 16:34:26 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 70DDB40270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:34:24 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 44544210C5;
 Mon, 10 Mar 2025 16:34:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: allow fast-free to empty cache
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 10 Mar 2025 16:34:23 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FADD@smartserver.smartshare.dk>
In-Reply-To: <Z88E30q5IkJvISW5@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: allow fast-free to empty cache
Thread-Index: AduR0P2sM3/B1/foRmmCRUwPtZ2YCAAAGLyA
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
 <Z88E30q5IkJvISW5@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	<anatoly.burakov@intel.com>
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
> Sent: Monday, 10 March 2025 16.27
>=20
> On Mon, Mar 10, 2025 at 04:18:35PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Monday, 10 March 2025 14.26
> > >
> > > When freeing transmitted mbufs, there is no reason to send the
> freed
> > > mbufs directly to the ring if the cache is empty - only if it is
> zero
> > > size (in which case the cache pointer is NULL). Therefore, remove
> the
> > > empty check and only check for a null cache pointer.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/common/tx.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/intel/common/tx.h
> > > b/drivers/net/intel/common/tx.h
> > > index d9cf4474fc..d361fe64ab 100644
> > > --- a/drivers/net/intel/common/tx.h
> > > +++ b/drivers/net/intel/common/tx.h
> > > @@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > > ci_desc_done_fn desc_done, bool ctx
> > >  		void **cache_objs;
> > >  		struct rte_mempool_cache *cache =3D
> > > rte_mempool_default_cache(mp, rte_lcore_id());
> > >
> > > -		if (!cache || cache->len =3D=3D 0)
> > > +		if (cache =3D=3D NULL)
> > >  			goto normal;
> > >
> > >  		cache_objs =3D &cache->objs[cache->len];
> > > --
> > > 2.43.0
> >
> > Yep, it did look strange.
> > Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>
> >
> Thanks for review.

BTW, I recall other Intel drivers having the same "feature":
https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/iavf/iavf_rxt=
x_vec_avx512.c#L1876
https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/ice/ice_rxtx_=
vec_avx512.c#L891

>=20
> FYI: Given that this is in a sensitive area and we are now past rc2,
> I'm going
> to postponse merging this patch till 25.07, rather than risk it in
> 25.03.

Agree.

>=20
> /Bruce
