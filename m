Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123ADC56201
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6E24027B;
	Fri, 20 Feb 2026 16:09:22 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 266E34026D;
 Fri, 20 Feb 2026 16:09:20 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1C624206CD;
 Fri, 20 Feb 2026 16:09:19 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] hash: fix overflow of 32-bit offsets
Date: Fri, 20 Feb 2026 16:09:14 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65735@smartserver.smartshare.dk>
In-Reply-To: <20260220143933.2553112-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] hash: fix overflow of 32-bit offsets
Thread-Index: AdyidsVUeFcp+PsLSJ61wt5krWKMAwAAoBMQ
References: <20260220143933.2553112-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <vladimir.medvedkin@intel.com>, <oleksandrn@interfacemasters.com>,
 <stable@dpdk.org>
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
> Sent: Friday, 20 February 2026 15.40
>=20
> When computing the offset inside the overall hash structure by adding
> an
> offset to a base pointer, the offset was generally calculated by
> multiplying two 32-bit values, which could then overflow. Prevent
> overflow by using (uintptr_t) casts on the elements being multiplied =
to
> ensure they are 64-bit on 64-bit systems.
>=20
> Fixes: b26473ff8f4a ("hash: add reset function")
> Fixes: 406da3dfb3b5 ("hash: move duplicated code into functions")
> Fixes: 9eca8bd7a61c ("hash: separate lock-free and r/w lock lookup")
> Fixes: 4d9ca3ed2133 ("hash: use ordered loads only if signature
> matches")
> Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")
> Fixes: e605a1d36ca7 ("hash: add lock-free r/w concurrency")
> Fixes: 6dc34e0afe7a ("hash: retrieve a key given its position")
> Fixes: f9edbc9bb6bc ("hash: add iterate function")
> Fixes: 75706568a7eb ("hash: add extendable bucket feature")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/hash/rte_cuckoo_hash.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index da12825c6e..f2478d5286 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -705,7 +705,7 @@ rte_hash_reset(struct rte_hash *h)
>  	}
>=20
>  	memset(h->buckets, 0, h->num_buckets * sizeof(struct
> rte_hash_bucket));
> -	memset(h->key_store, 0, h->key_entry_size * (h->entries + 1));
> +	memset(h->key_store, 0, (size_t)h->key_entry_size * (h->entries +
> 1));

Agree.

>  	*h->tbl_chng_cnt =3D 0;
>=20
>  	/* reset the free ring */
> @@ -774,7 +774,7 @@ search_and_update(const struct rte_hash *h, void
> *data, const void *key,
>  	for (i =3D 0; i < RTE_HASH_BUCKET_ENTRIES; i++) {
>  		if (bkt->sig_current[i] =3D=3D sig) {
>  			k =3D (struct rte_hash_key *) ((char *)keys +
> -					bkt->key_idx[i] * h->key_entry_size);
> +					(uintptr_t)bkt->key_idx[i] * h-
> >key_entry_size);

The fix is technically correct.
However, for source code readability purposes:

Please don't cast bkt->key_idx[i] (and similar below) to uintptr_t; it's =
not a pointer type.
It might be reasonable casting it to ptrdiff_t, but I'm not sure about =
that.

The natural type for h->key_entry_size is size_t; it's only smaller to =
save memory or something.
So, please cast the type that naturally would be wider, i.e. use: =
(size_t)h->key_entry_size

PS: If you change the casting as suggested, remember to update the patch =
description accordingly.

With or without above suggestion for readability,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

