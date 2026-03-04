Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222BEB7ED5
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE4F402A9;
	Wed,  4 Mar 2026 12:40:49 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DBB104003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:40:47 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQrLZ3R3zzHnHCr;
 Wed,  4 Mar 2026 19:39:50 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 2011440587;
 Wed,  4 Mar 2026 19:40:46 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 4 Mar 2026 11:40:45 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 4 Mar 2026 11:40:45 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH dpdk v2 2/3] hash: free replaced data on overwrite when
 RCU is configured
Thread-Topic: [PATCH dpdk v2 2/3] hash: free replaced data on overwrite when
 RCU is configured
Thread-Index: AQHcnNR1JtqKrZ/RBUe9BMJJWdn6q7WeVUww
Date: Wed, 4 Mar 2026 11:40:45 +0000
Message-ID: <2630d756f843466dbe1da67f2a65c7d7@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
 <20260213103441.1505659-3-rjarry@redhat.com>
In-Reply-To: <20260213103441.1505659-3-rjarry@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.154.43]
Content-Type: text/plain; charset="us-ascii"
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



> When rte_hash_add_key_data() overwrites an existing key, the old data
> pointer is silently lost. With RCU-protected readers still potentially
> accessing the old data, the application has no safe way to free it.
>=20
> When RCU is configured with a free_key_data_func callback, automatically
> enqueue the old data for deferred freeing via the RCU defer queue on
> overwrite. In SYNC mode, synchronize and call free_key_data_func
> directly.
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  app/test/test_hash.c                   | 134 +++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_03.rst |   6 ++
>  lib/hash/rte_cuckoo_hash.c             | 101 ++++++++++++++-----
>  lib/hash/rte_hash.h                    |   8 +-
>  4 files changed, 224 insertions(+), 25 deletions(-)
>=20
> diff --git a/app/test/test_hash.c b/app/test/test_hash.c
> index 3fb3d96d0546..56a7779e09b9 100644
> --- a/app/test/test_hash.c
> +++ b/app/test/test_hash.c
> @@ -2342,6 +2342,137 @@ test_hash_rcu_qsbr_dq_reclaim(void)
>  	return 0;
>  }
>=20
> +static void *old_data;
> +
> +static void
> +test_hash_free_key_data_func(void *p __rte_unused, void *key_data)
> +{
> +	old_data =3D key_data;
> +}
> +
> +/*
> + * Test automatic RCU free on overwrite via rte_hash_add_key_data.
> + *  - Create hash with RW_CONCURRENCY_LF and RCU QSBR in DQ mode
> + *    with a free_key_data_func callback that increments a counter.
> + *  - Register a pseudo reader thread.
> + *  - Add key with data (void *)1.
> + *  - Overwrite same key with data (void *)2 via rte_hash_add_key_data.
> + *  - Report quiescent state, trigger reclamation.
> + *  - Verify the free callback was called exactly once.
> + *  - Delete the key, report quiescent state, reclaim again.
> + *  - Verify the free callback was called a second time.
> + */
> +static int
> +test_hash_rcu_qsbr_replace_auto_free(void)
> +{
> +	struct rte_hash_rcu_config rcu =3D {
> +		.v =3D NULL,
> +		.mode =3D RTE_HASH_QSBR_MODE_DQ,
> +		.free_key_data_func =3D test_hash_free_key_data_func,
> +		.key_data_ptr =3D NULL,
> +	};
> +	struct rte_hash_parameters params =3D {
> +		.name =3D "test_replace_auto_free",
> +		.entries =3D 16,
> +		.key_len =3D sizeof(uint32_t),
> +		.hash_func =3D NULL,
> +		.hash_func_init_val =3D 0,
> +		.socket_id =3D SOCKET_ID_ANY,
> +		.extra_flag =3D RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF,
> +	};
> +	struct rte_hash *hash =3D NULL;
> +	uint32_t key =3D 55;
> +	int32_t status;
> +	int ret =3D -1;
> +	size_t sz;
> +
> +	printf("\n# Running RCU replace auto-free test\n");
> +
> +	hash =3D rte_hash_create(&params);
> +	if (hash =3D=3D NULL) {
> +		printf("hash creation failed\n");
> +		goto end;
> +	}
> +
> +	sz =3D rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
> +	rcu.v =3D rte_zmalloc(NULL, sz, RTE_CACHE_LINE_SIZE);
> +	if (rcu.v =3D=3D NULL) {
> +		printf("RCU QSBR alloc failed\n");
> +		goto end;
> +	}
> +	status =3D rte_rcu_qsbr_init(rcu.v, RTE_MAX_LCORE);
> +	if (status !=3D 0) {
> +		printf("RCU QSBR init failed\n");
> +		goto end;
> +	}
> +
> +	status =3D rte_hash_rcu_qsbr_add(hash, &rcu);
> +	if (status !=3D 0) {
> +		printf("RCU QSBR add failed\n");
> +		goto end;
> +	}
> +
> +	/* Register pseudo reader */
> +	status =3D rte_rcu_qsbr_thread_register(rcu.v, 0);
> +	if (status !=3D 0) {
> +		printf("RCU QSBR thread register failed\n");
> +		goto end;
> +	}
> +	rte_rcu_qsbr_thread_online(rcu.v, 0);
> +
> +	old_data =3D NULL;
> +
> +	/* Add key with data =3D (void *)1 */
> +	status =3D rte_hash_add_key_data(hash, &key, (void *)(uintptr_t)1);
> +	if (status !=3D 0) {
> +		printf("failed to add key (status=3D%d)\n", status);
> +		goto end;
> +	}
> +
> +	/* Overwrite same key with data =3D (void *)2 */
> +	status =3D rte_hash_add_key_data(hash, &key, (void *)(uintptr_t)2);
> +	if (status !=3D 0) {
> +		printf("failed to overwrite key (status=3D%d)\n", status);
> +		goto end;
> +	}
> +
> +	/* Reader quiescent and reclaim */
> +	rte_rcu_qsbr_quiescent(rcu.v, 0);
> +	rte_hash_rcu_qsbr_dq_reclaim(hash, NULL, NULL, NULL);
> +
> +	if (old_data !=3D (void *)(uintptr_t)1) {
> +		printf("old data should be 0x1 but is %p\n", old_data);
> +		goto end;
> +	}
> +
> +	/* Delete the key */
> +	status =3D rte_hash_del_key(hash, &key);
> +	if (status < 0) {
> +		printf("failed to delete key (status=3D%d)\n", status);
> +		goto end;
> +	}
> +
> +	/* Reader quiescent and reclaim again */
> +	rte_rcu_qsbr_quiescent(rcu.v, 0);
> +	rte_hash_rcu_qsbr_dq_reclaim(hash, NULL, NULL, NULL);
> +
> +	if (old_data !=3D (void *)(uintptr_t)2) {
> +		printf("old data should be 2 but is %p\n", old_data);
> +		goto end;
> +	}
> +
> +	ret =3D 0;
> +end:
> +	if (rcu.v !=3D NULL) {
> +		rte_rcu_qsbr_thread_offline(rcu.v, 0);
> +		rte_rcu_qsbr_thread_unregister(rcu.v, 0);
> +	}
> +	rte_hash_free(hash);
> +	rte_free(rcu.v);
> +
> +	return ret;
> +}
> +
>  /*
>   * Do all unit and performance tests.
>   */
> @@ -2423,6 +2554,9 @@ test_hash(void)
>  	if (test_hash_rcu_qsbr_dq_reclaim() < 0)
>  		return -1;
>=20
> +	if (test_hash_rcu_qsbr_replace_auto_free() < 0)
> +		return -1;
> +
>  	return 0;
>  }
>=20
> diff --git a/doc/guides/rel_notes/release_26_03.rst
> b/doc/guides/rel_notes/release_26_03.rst
> index afdf1af06c20..693034bcb0d2 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -87,6 +87,12 @@ New Features
>    * Added support for AES-XTS cipher algorithm.
>    * Added support for SHAKE-128 and SHAKE-256 authentication algorithms.
>=20
> +* **Added automatic deferred free on hash data overwrite.**
> +
> +  When RCU is configured with a ``free_key_data_func`` callback,
> +  ``rte_hash_add_key_data`` now automatically defers freeing the old dat=
a
> +  pointer on key overwrite via the RCU defer queue.
> +
>=20
>  Removed Items
>  -------------
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index 8189bde024be..f487b3b725dd 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -75,6 +75,7 @@ EAL_REGISTER_TAILQ(rte_hash_tailq)
>  struct __rte_hash_rcu_dq_entry {
>  	uint32_t key_idx;
>  	uint32_t ext_bkt_idx;
> +	void *old_data;
>  };
>=20
>  RTE_EXPORT_SYMBOL(rte_hash_find_existing)
> @@ -763,10 +764,11 @@ enqueue_slot_back(const struct rte_hash *h,
>=20
>  /* Search a key from bucket and update its data.
>   * Writer holds the lock before calling this.
> + * If old_data is non-NULL, save the previous data pointer before overwr=
iting.
>   */
>  static inline int32_t
>  search_and_update(const struct rte_hash *h, void *data, const void *key,
> -	struct rte_hash_bucket *bkt, uint16_t sig)
> +	struct rte_hash_bucket *bkt, uint16_t sig, void **old_data)
>  {
>  	int i;
>  	struct rte_hash_key *k, *keys =3D h->key_store;
> @@ -776,6 +778,8 @@ search_and_update(const struct rte_hash *h, void *dat=
a,
> const void *key,
>  			k =3D (struct rte_hash_key *) ((char *)keys +
>  					bkt->key_idx[i] * h->key_entry_size);
>  			if (rte_hash_cmp_eq(key, k->key, h) =3D=3D 0) {
> +				if (old_data !=3D NULL)
> +					*old_data =3D k->pdata;

For consistency, shouldn't we use here instead of load/store:
*old_data =3D rte_atomic_exchange_explicit(&k->pdata, data, ...);
?
=20

>  				/* The store to application data at *data
>  				 * should not leak after the store to pdata
>  				 * in the key store. i.e. pdata is the guard
> @@ -807,7 +811,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
>  		struct rte_hash_bucket *sec_bkt,
>  		const struct rte_hash_key *key, void *data,
>  		uint16_t sig, uint32_t new_idx,
> -		int32_t *ret_val)
> +		int32_t *ret_val, void **old_data)
>  {
>  	unsigned int i;
>  	struct rte_hash_bucket *cur_bkt;
> @@ -817,7 +821,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
>  	/* Check if key was inserted after last check but before this
>  	 * protected region in case of inserting duplicated keys.
>  	 */
> -	ret =3D search_and_update(h, data, key, prim_bkt, sig);
> +	ret =3D search_and_update(h, data, key, prim_bkt, sig, old_data);
>  	if (ret !=3D -1) {
>  		__hash_rw_writer_unlock(h);
>  		*ret_val =3D ret;
> @@ -825,7 +829,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
>  	}
>=20
>  	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
> -		ret =3D search_and_update(h, data, key, cur_bkt, sig);
> +		ret =3D search_and_update(h, data, key, cur_bkt, sig, old_data);
>  		if (ret !=3D -1) {
>  			__hash_rw_writer_unlock(h);
>  			*ret_val =3D ret;
> @@ -872,7 +876,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash
> *h,
>  			const struct rte_hash_key *key, void *data,
>  			struct queue_node *leaf, uint32_t leaf_slot,
>  			uint16_t sig, uint32_t new_idx,
> -			int32_t *ret_val)
> +			int32_t *ret_val, void **old_data)
>  {
>  	uint32_t prev_alt_bkt_idx;
>  	struct rte_hash_bucket *cur_bkt;
> @@ -892,7 +896,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash
> *h,
>  	/* Check if key was inserted after last check but before this
>  	 * protected region.
>  	 */
> -	ret =3D search_and_update(h, data, key, bkt, sig);
> +	ret =3D search_and_update(h, data, key, bkt, sig, old_data);
>  	if (ret !=3D -1) {
>  		__hash_rw_writer_unlock(h);
>  		*ret_val =3D ret;
> @@ -900,7 +904,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash
> *h,
>  	}
>=20
>  	FOR_EACH_BUCKET(cur_bkt, alt_bkt) {
> -		ret =3D search_and_update(h, data, key, cur_bkt, sig);
> +		ret =3D search_and_update(h, data, key, cur_bkt, sig, old_data);
>  		if (ret !=3D -1) {
>  			__hash_rw_writer_unlock(h);
>  			*ret_val =3D ret;
> @@ -997,7 +1001,8 @@ rte_hash_cuckoo_make_space_mw(const struct rte_hash
> *h,
>  			struct rte_hash_bucket *sec_bkt,
>  			const struct rte_hash_key *key, void *data,
>  			uint16_t sig, uint32_t bucket_idx,
> -			uint32_t new_idx, int32_t *ret_val)
> +			uint32_t new_idx, int32_t *ret_val,
> +			void **old_data)
>  {
>  	unsigned int i;
>  	struct queue_node queue[RTE_HASH_BFS_QUEUE_MAX_LEN];
> @@ -1023,7 +1028,7 @@ rte_hash_cuckoo_make_space_mw(const struct rte_hash
> *h,
>  				int32_t ret =3D rte_hash_cuckoo_move_insert_mw(h,
>  						bkt, sec_bkt, key, data,
>  						tail, i, sig,
> -						new_idx, ret_val);
> +						new_idx, ret_val, old_data);
>  				if (likely(ret !=3D -1))
>  					return ret;
>  			}
> @@ -1076,6 +1081,29 @@ alloc_slot(const struct rte_hash *h, struct lcore_=
cache
> *cached_free_slots)
>  	return slot_id;
>  }
>=20
> +/*
> + * When RCU is configured with a free function, auto-free the overwritte=
n
> + * data pointer via RCU.
> + */
> +static inline void
> +__hash_rcu_auto_free_old_data(const struct rte_hash *h, void *old_data_v=
al)
> +{
> +	struct __rte_hash_rcu_dq_entry rcu_dq_entry =3D {
> +		.key_idx =3D EMPTY_SLOT, /* sentinel value for
> __hash_rcu_qsbr_free_resource */
> +		.old_data =3D old_data_val,
> +	};
> +
> +	if (h->hash_rcu_cfg =3D=3D NULL || h->hash_rcu_cfg->free_key_data_func =
=3D=3D
> NULL)
> +		return;
> +
> +	if (h->dq =3D=3D NULL || rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) =
!=3D 0)
> {
> +		/* SYNC mode or enqueue failed in DQ mode */
> +		rte_rcu_qsbr_synchronize(h->hash_rcu_cfg->v,
> RTE_QSBR_THRID_INVALID);
> +		h->hash_rcu_cfg->free_key_data_func(h->hash_rcu_cfg-
> >key_data_ptr,
> +						    old_data_val);
> +	}
> +}
> +
>  static inline int32_t
>  __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
>  						hash_sig_t sig, void *data)
> @@ -1092,6 +1120,7 @@ __rte_hash_add_key_with_hash(const struct rte_hash =
*h,
> const void *key,
>  	struct lcore_cache *cached_free_slots =3D NULL;
>  	int32_t ret_val;
>  	struct rte_hash_bucket *last;
> +	void *saved_old_data =3D NULL;
>=20
>  	short_sig =3D get_short_sig(sig);
>  	prim_bucket_idx =3D get_prim_bucket_index(h, sig);
> @@ -1103,18 +1132,20 @@ __rte_hash_add_key_with_hash(const struct rte_has=
h
> *h, const void *key,
>=20
>  	/* Check if key is already inserted in primary location */
>  	__hash_rw_writer_lock(h);
> -	ret =3D search_and_update(h, data, key, prim_bkt, short_sig);
> +	ret =3D search_and_update(h, data, key, prim_bkt, short_sig,
> +				&saved_old_data);
>  	if (ret !=3D -1) {
>  		__hash_rw_writer_unlock(h);
> -		return ret;
> +		goto overwrite;
>  	}
>=20
>  	/* Check if key is already inserted in secondary location */
>  	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
> -		ret =3D search_and_update(h, data, key, cur_bkt, short_sig);
> +		ret =3D search_and_update(h, data, key, cur_bkt, short_sig,
> +					&saved_old_data);
>  		if (ret !=3D -1) {
>  			__hash_rw_writer_unlock(h);
> -			return ret;
> +			goto overwrite;
>  		}
>  	}
>=20
> @@ -1153,33 +1184,39 @@ __rte_hash_add_key_with_hash(const struct rte_has=
h
> *h, const void *key,
>=20
>  	/* Find an empty slot and insert */
>  	ret =3D rte_hash_cuckoo_insert_mw(h, prim_bkt, sec_bkt, key, data,
> -					short_sig, slot_id, &ret_val);
> +					short_sig, slot_id, &ret_val,
> +					&saved_old_data);
>  	if (ret =3D=3D 0)
>  		return slot_id - 1;
>  	else if (ret =3D=3D 1) {
>  		enqueue_slot_back(h, cached_free_slots, slot_id);
> -		return ret_val;
> +		ret =3D ret_val;
> +		goto overwrite;
>  	}
>=20
>  	/* Primary bucket full, need to make space for new entry */
>  	ret =3D rte_hash_cuckoo_make_space_mw(h, prim_bkt, sec_bkt, key, data,
> -				short_sig, prim_bucket_idx, slot_id, &ret_val);
> +				short_sig, prim_bucket_idx, slot_id, &ret_val,
> +				&saved_old_data);
>  	if (ret =3D=3D 0)
>  		return slot_id - 1;
>  	else if (ret =3D=3D 1) {
>  		enqueue_slot_back(h, cached_free_slots, slot_id);
> -		return ret_val;
> +		ret =3D ret_val;
> +		goto overwrite;
>  	}
>=20
>  	/* Also search secondary bucket to get better occupancy */
>  	ret =3D rte_hash_cuckoo_make_space_mw(h, sec_bkt, prim_bkt, key, data,
> -				short_sig, sec_bucket_idx, slot_id, &ret_val);
> +				short_sig, sec_bucket_idx, slot_id, &ret_val,
> +				&saved_old_data);
>=20
>  	if (ret =3D=3D 0)
>  		return slot_id - 1;
>  	else if (ret =3D=3D 1) {
>  		enqueue_slot_back(h, cached_free_slots, slot_id);
> -		return ret_val;
> +		ret =3D ret_val;
> +		goto overwrite;
>  	}
>=20
>  	/* if ext table not enabled, we failed the insertion */
> @@ -1193,17 +1230,21 @@ __rte_hash_add_key_with_hash(const struct rte_has=
h
> *h, const void *key,
>  	 */
>  	__hash_rw_writer_lock(h);
>  	/* We check for duplicates again since could be inserted before the loc=
k */
> -	ret =3D search_and_update(h, data, key, prim_bkt, short_sig);
> +	ret =3D search_and_update(h, data, key, prim_bkt, short_sig,
> +				&saved_old_data);
>  	if (ret !=3D -1) {
>  		enqueue_slot_back(h, cached_free_slots, slot_id);
> -		goto failure;
> +		__hash_rw_writer_unlock(h);
> +		goto overwrite;
>  	}
>=20
>  	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
> -		ret =3D search_and_update(h, data, key, cur_bkt, short_sig);
> +		ret =3D search_and_update(h, data, key, cur_bkt, short_sig,
> +					&saved_old_data);
>  		if (ret !=3D -1) {
>  			enqueue_slot_back(h, cached_free_slots, slot_id);
> -			goto failure;
> +			__hash_rw_writer_unlock(h);
> +			goto overwrite;
>  		}
>  	}
>=20
> @@ -1263,6 +1304,11 @@ __rte_hash_add_key_with_hash(const struct rte_hash
> *h, const void *key,
>  	__hash_rw_writer_unlock(h);
>  	return slot_id - 1;

With multiple goto labels that function becomes even more complicated.
Can we just add old_data as an extra parameter:=20
__rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
                   hash_sig_t sig, void *data, void **old_data)
And make the callers to invoke __hash_rcu_auto_free_old_data()?

> +overwrite:
> +	if (saved_old_data !=3D NULL)
> +		__hash_rcu_auto_free_old_data(h, saved_old_data);
> +	return ret;
> +
>  failure:
>  	__hash_rw_writer_unlock(h);
>  	return ret;
> @@ -1566,6 +1612,15 @@ __hash_rcu_qsbr_free_resource(void *p, void *e,
> unsigned int n)
>  			*((struct __rte_hash_rcu_dq_entry *)e);
>=20
>  	RTE_SET_USED(n);
> +
> +	if (rcu_dq_entry.key_idx =3D=3D EMPTY_SLOT) {
> +		/* Overwrite case: free old data only, do not recycle slot */
> +		RTE_ASSERT(h->hash_rcu_cfg->free_key_data_func !=3D NULL);
> +		h->hash_rcu_cfg->free_key_data_func(h->hash_rcu_cfg-
> >key_data_ptr,
> +						    rcu_dq_entry.old_data);
> +		return;
> +	}
> +
>  	keys =3D h->key_store;
>=20
>  	k =3D (struct rte_hash_key *) ((char *)keys +
> diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
> index f692e0868dcf..e33f0aea0f5e 100644
> --- a/lib/hash/rte_hash.h
> +++ b/lib/hash/rte_hash.h
> @@ -226,7 +226,9 @@ rte_hash_max_key_id(const struct rte_hash *h);
>   * Thread safety can be enabled by setting flag during
>   * table creation.
>   * If the key exists already in the table, this API updates its value
> - * with 'data' passed in this API. It is the responsibility of
> + * with 'data' passed in this API. If RCU is configured with a
> + * free_key_data_func callback, the old data is automatically
> + * deferred-freed via RCU. Otherwise, it is the responsibility of
>   * the application to manage any memory associated with the old value.
>   * The readers might still be using the old value even after this API
>   * has returned.
> @@ -253,7 +255,9 @@ rte_hash_add_key_data(const struct rte_hash *h, const=
 void
> *key, void *data);
>   * Thread safety can be enabled by setting flag during
>   * table creation.
>   * If the key exists already in the table, this API updates its value
> - * with 'data' passed in this API. It is the responsibility of
> + * with 'data' passed in this API. If RCU is configured with a
> + * free_key_data_func callback, the old data is automatically
> + * deferred-freed via RCU. Otherwise, it is the responsibility of
>   * the application to manage any memory associated with the old value.
>   * The readers might still be using the old value even after this API
>   * has returned.
> --
> 2.53.0

