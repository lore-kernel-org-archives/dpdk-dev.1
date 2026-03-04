Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA83EB7ED5
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6501D402A9;
	Wed,  4 Mar 2026 12:44:15 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8F7FD4003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:44:13 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQrQX5NWQzHnHJ7;
 Wed,  4 Mar 2026 19:43:16 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 648AE40587;
 Wed,  4 Mar 2026 19:44:12 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 11:44:12 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 4 Mar 2026 11:44:12 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH dpdk v2 3/3] hash: add replace API returning old data on
 overwrite
Thread-Topic: [PATCH dpdk v2 3/3] hash: add replace API returning old data on
 overwrite
Thread-Index: AQHcnNR4ankF7NJa006MOPBl64BQRLWeXo+w
Date: Wed, 4 Mar 2026 11:44:11 +0000
Message-ID: <94e89279fa254e8297c69ba5bfd37963@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
 <20260213103441.1505659-4-rjarry@redhat.com>
In-Reply-To: <20260213103441.1505659-4-rjarry@redhat.com>
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



>=20
> Add rte_hash_replace_key_data() and rte_hash_replace_key_with_hash_data()
> which behave like their add_key_data counterparts but return the previous
> data pointer via an output parameter. On fresh insert, *old_data is set
> to NULL.
>=20
> When the caller provides old_data, no automatic RCU deferred free is
> performed: the caller takes ownership of the old pointer and is
> responsible for freeing it.
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  app/test/test_hash.c                   | 80 ++++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_03.rst |  6 ++
>  lib/hash/rte_cuckoo_hash.c             | 42 ++++++++++++--
>  lib/hash/rte_hash.h                    | 67 +++++++++++++++++++++
>  4 files changed, 189 insertions(+), 6 deletions(-)
>=20
> diff --git a/app/test/test_hash.c b/app/test/test_hash.c
> index 56a7779e09b9..fcc02ea31205 100644
> --- a/app/test/test_hash.c
> +++ b/app/test/test_hash.c
> @@ -2473,6 +2473,83 @@ test_hash_rcu_qsbr_replace_auto_free(void)
>  	return ret;
>  }
>=20
> +/*
> + * Test rte_hash_replace_key_data (explicit replace, no RCU).
> + *  - Add key with data pointer (void *)1.
> + *  - Replace same key with data (void *)2, verify old_data =3D=3D (void=
 *)1.
> + *  - Lookup and verify data =3D=3D (void *)2.
> + *  - Replace with a new key (not yet inserted), verify old_data =3D=3D =
NULL.
> + */
> +static int
> +test_hash_replace_key_data(void)
> +{
> +	struct rte_hash_parameters params =3D {
> +		.name =3D "test_replace_key_data",
> +		.entries =3D 64,
> +		.key_len =3D sizeof(uint32_t),
> +		.hash_func =3D NULL,
> +		.hash_func_init_val =3D 0,
> +		.socket_id =3D SOCKET_ID_ANY,
> +	};
> +	struct rte_hash *hash;
> +	void *old_data =3D NULL;
> +	void *data =3D NULL;
> +	uint32_t key1 =3D 42;
> +	uint32_t key2 =3D 99;
> +	int ret =3D -1;
> +
> +	printf("\n# Running replace key data test\n");
> +
> +	hash =3D rte_hash_create(&params);
> +	if (hash =3D=3D NULL) {
> +		printf("hash creation failed\n");
> +		goto end;
> +	}
> +
> +	/* Add key with data =3D (void *)1 */
> +	ret =3D rte_hash_add_key_data(hash, &key1, (void *)(uintptr_t)1);
> +	if (ret !=3D 0) {
> +		printf("failed to add key (ret=3D%d)\n", ret);
> +		goto end;
> +	}
> +
> +	/* Replace same key with data =3D (void *)2 */
> +	ret =3D rte_hash_replace_key_data(hash, &key1, (void *)(uintptr_t)2,
> &old_data);
> +	if (ret !=3D 0) {
> +		printf("failed to replace key (ret=3D%d)\n", ret);
> +		goto end;
> +	}
> +	if (old_data !=3D (void *)(uintptr_t)1) {
> +		printf("old_data should be 0x1 but is %p\n", old_data);
> +		goto end;
> +	}
> +
> +	/* Lookup and verify data =3D=3D (void *)2 */
> +	ret =3D rte_hash_lookup_data(hash, &key1, &data);
> +	if (ret < 0 || data !=3D (void *)(uintptr_t)2) {
> +		printf("lookup returned wrong data %p (ret=3D%d)\n", data, ret);
> +		goto end;
> +	}
> +
> +	/* Replace with a new key (not yet inserted) */
> +	old_data =3D (void *)(uintptr_t)0xdeadbeef;
> +	ret =3D rte_hash_replace_key_data(hash, &key2, (void *)(uintptr_t)3,
> &old_data);
> +	if (ret !=3D 0) {
> +		printf("failed to insert new key via replace (ret=3D%d)\n", ret);
> +		goto end;
> +	}
> +	if (old_data !=3D NULL) {
> +		printf("old_data should be NULL on fresh insert but is %p\n",
> +		       old_data);
> +		goto end;
> +	}
> +
> +end:
> +	rte_hash_free(hash);
> +
> +	return ret;
> +}
> +
>  /*
>   * Do all unit and performance tests.
>   */
> @@ -2557,6 +2634,9 @@ test_hash(void)
>  	if (test_hash_rcu_qsbr_replace_auto_free() < 0)
>  		return -1;
>=20
> +	if (test_hash_replace_key_data() < 0)
> +		return -1;
> +
>  	return 0;
>  }
>=20
> diff --git a/doc/guides/rel_notes/release_26_03.rst
> b/doc/guides/rel_notes/release_26_03.rst
> index 693034bcb0d2..73418523809c 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -93,6 +93,12 @@ New Features
>    ``rte_hash_add_key_data`` now automatically defers freeing the old dat=
a
>    pointer on key overwrite via the RCU defer queue.
>=20
> +* **Added hash replace API.**
> +
> +  Added ``rte_hash_replace_key_data`` and
> ``rte_hash_replace_key_with_hash_data``
> +  functions that return the previous data pointer on key overwrite, lett=
ing the
> +  caller manage its lifecycle.
> +
>=20
>  Removed Items
>  -------------
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index f487b3b725dd..cf957de55288 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -1106,7 +1106,7 @@ __hash_rcu_auto_free_old_data(const struct rte_hash
> *h, void *old_data_val)
>=20
>  static inline int32_t
>  __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
> -						hash_sig_t sig, void *data)
> +			     hash_sig_t sig, void *data, void **old_data)
>  {
>  	uint16_t short_sig;
>  	uint32_t prim_bucket_idx, sec_bucket_idx;
> @@ -1305,7 +1305,9 @@ __rte_hash_add_key_with_hash(const struct rte_hash =
*h,
> const void *key,
>  	return slot_id - 1;
>=20
>  overwrite:
> -	if (saved_old_data !=3D NULL)
> +	if (old_data !=3D NULL)
> +		*old_data =3D saved_old_data;
> +	else if (saved_old_data !=3D NULL)
>  		__hash_rcu_auto_free_old_data(h, saved_old_data);
>  	return ret;
>=20
> @@ -1321,7 +1323,7 @@ rte_hash_add_key_with_hash(const struct rte_hash *h=
,
>  			const void *key, hash_sig_t sig)
>  {
>  	RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL)), -EINVAL);
> -	return __rte_hash_add_key_with_hash(h, key, sig, 0);
> +	return __rte_hash_add_key_with_hash(h, key, sig, 0, NULL);
>  }
>=20
>  RTE_EXPORT_SYMBOL(rte_hash_add_key)
> @@ -1329,7 +1331,7 @@ int32_t
>  rte_hash_add_key(const struct rte_hash *h, const void *key)
>  {
>  	RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL)), -EINVAL);
> -	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0);
> +	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0,
> NULL);
>  }
>=20
>  RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash_data)
> @@ -1340,7 +1342,7 @@ rte_hash_add_key_with_hash_data(const struct rte_ha=
sh
> *h,
>  	int ret;
>=20
>  	RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL)), -EINVAL);
> -	ret =3D __rte_hash_add_key_with_hash(h, key, sig, data);
> +	ret =3D __rte_hash_add_key_with_hash(h, key, sig, data, NULL);
>  	if (ret >=3D 0)
>  		return 0;
>  	else
> @@ -1355,13 +1357,41 @@ rte_hash_add_key_data(const struct rte_hash *h, c=
onst
> void *key, void *data)
>=20
>  	RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL)), -EINVAL);
>=20
> -	ret =3D __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), dat=
a);
> +	ret =3D __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), dat=
a,
> NULL);
>  	if (ret >=3D 0)
>  		return 0;
>  	else
>  		return ret;
>  }
>=20
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_replace_key_with_hash_data,
> 26.03)
> +int
> +rte_hash_replace_key_with_hash_data(const struct rte_hash *h,
> +				    const void *key, hash_sig_t sig,
> +				    void *data, void **old_data)
> +{
> +	int ret;
> +
> +	RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL) ||
> +			(old_data =3D=3D NULL)), -EINVAL);
> +
> +	*old_data =3D NULL;
> +	ret =3D __rte_hash_add_key_with_hash(h, key, sig, data, old_data);
> +	if (ret >=3D 0)
> +		return 0;
> +	else
> +		return ret;
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_replace_key_data, 26.03)
> +int
> +rte_hash_replace_key_data(const struct rte_hash *h, const void *key,
> +			  void *data, void **old_data)
> +{
> +	return rte_hash_replace_key_with_hash_data(h, key,
> +			rte_hash_hash(h, key), data, old_data);
> +}
> +
>  /* Search one bucket to find the match key - uses rw lock */
>  static inline int32_t
>  search_one_bucket_l(const struct rte_hash *h, const void *key,
> diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
> index e33f0aea0f5e..4a328c51501c 100644
> --- a/lib/hash/rte_hash.h
> +++ b/lib/hash/rte_hash.h
> @@ -279,6 +279,73 @@ int32_t
>  rte_hash_add_key_with_hash_data(const struct rte_hash *h, const void *ke=
y,
>  						hash_sig_t sig, void *data);
>=20
> +/**
> + * Replace a key-value pair in an existing hash table, returning the pre=
vious
> + * data pointer associated with the key. If the key does not exist, it i=
s
> + * inserted and *old_data is set to NULL.
> + *
> + * This operation is not multi-thread safe and should only be called fro=
m one
> + * thread by default. Thread safety can be enabled by setting flag durin=
g table
> + * creation.
> + *
> + * When old_data is provided, no automatic RCU deferred free is performe=
d on
> + * overwrite; the caller takes ownership of the old pointer and is respo=
nsible
> + * for freeing it (e.g. via RCU).
> + *
> + * @param h
> + *   Hash table to add the key to.
> + * @param key
> + *   Key to add to the hash table.
> + * @param data
> + *   Data to add to the hash table.
> + * @param old_data
> + *   Output: on overwrite, set to the previous data pointer.
> + *   On fresh insert, set to NULL.
> + * @return
> + *   - 0 if added/replaced successfully
> + *   - -EINVAL if the parameters are invalid.
> + *   - -ENOSPC if there is no space in the hash for this key.
> + */
> +__rte_experimental
> +int
> +rte_hash_replace_key_data(const struct rte_hash *h, const void *key,
> +			  void *data, void **old_data);
> +
> +/**
> + * Replace a key-value pair with a pre-computed hash value in an existin=
g hash
> + * table, returning the previous data pointer associated with the key. I=
f the
> + * key does not exist, it is inserted and *old_data is set to NULL.
> + *
> + * This operation is not multi-thread safe and should only be called fro=
m one
> + * thread by default. Thread safety can be enabled by setting flag durin=
g table
> + * creation.
> + *
> + * When old_data is provided, no automatic RCU deferred free is performe=
d on
> + * overwrite; the caller takes ownership of the old pointer and is respo=
nsible
> + * for freeing it (e.g. via RCU).
> + *
> + * @param h
> + *   Hash table to add the key to.
> + * @param key
> + *   Key to add to the hash table.
> + * @param sig
> + *   Precomputed hash value for 'key'
> + * @param data
> + *   Data to add to the hash table.
> + * @param old_data
> + *   Output: on overwrite, set to the previous data pointer.
> + *   On fresh insert, set to NULL.
> + * @return
> + *   - 0 if added/replaced successfully
> + *   - -EINVAL if the parameters are invalid.
> + *   - -ENOSPC if there is no space in the hash for this key.
> + */
> +__rte_experimental
> +int
> +rte_hash_replace_key_with_hash_data(const struct rte_hash *h,
> +				    const void *key, hash_sig_t sig,
> +				    void *data, void **old_data);
> +
>  /**
>   * Add a key to an existing hash table. This operation is not multi-thre=
ad safe
>   * and should only be called from one thread by default.
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0
>=20

