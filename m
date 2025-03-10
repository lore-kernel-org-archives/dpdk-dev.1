Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41398C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE7C402E1;
	Mon, 10 Mar 2025 16:18:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 73BF2400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:18:36 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2D68D210C5;
 Mon, 10 Mar 2025 16:18:36 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: allow fast-free to empty cache
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 10 Mar 2025 16:18:35 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
In-Reply-To: <20250310132540.1341258-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: allow fast-free to empty cache
Thread-Index: AduRv/Y5d+yQjREOTVSD8BmUVrearAAD4Vdg
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <anatoly.burakov@intel.com>
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
> Sent: Monday, 10 March 2025 14.26
>=20
> When freeing transmitted mbufs, there is no reason to send the freed
> mbufs directly to the ring if the cache is empty - only if it is zero
> size (in which case the cache pointer is NULL). Therefore, remove the
> empty check and only check for a null cache pointer.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h
> b/drivers/net/intel/common/tx.h
> index d9cf4474fc..d361fe64ab 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> ci_desc_done_fn desc_done, bool ctx
>  		void **cache_objs;
>  		struct rte_mempool_cache *cache =3D
> rte_mempool_default_cache(mp, rte_lcore_id());
>=20
> -		if (!cache || cache->len =3D=3D 0)
> +		if (cache =3D=3D NULL)
>  			goto normal;
>=20
>  		cache_objs =3D &cache->objs[cache->len];
> --
> 2.43.0

Yep, it did look strange.
Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

