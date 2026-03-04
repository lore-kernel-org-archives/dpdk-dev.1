Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5184EB7EB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 10:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99D63402E4;
	Wed,  4 Mar 2026 11:28:39 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E37AA402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 11:28:38 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQpll51LRzJ46fN;
 Wed,  4 Mar 2026 18:28:03 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 43EFF40569;
 Wed,  4 Mar 2026 18:28:38 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 10:28:37 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 4 Mar 2026 10:28:37 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "Yipeng
 Wang" <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH dpdk v2 1/3] hash: avoid leaking entries on RCU defer
 queue failure
Thread-Topic: [PATCH dpdk v2 1/3] hash: avoid leaking entries on RCU defer
 queue failure
Thread-Index: AQHcnNR1LUpUXMxhO0eCvghJicMsorWeSXsA
Date: Wed, 4 Mar 2026 10:28:37 +0000
Message-ID: <88e57c33615943249451d2ef48d00fc9@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
 <20260213103441.1505659-2-rjarry@redhat.com>
In-Reply-To: <20260213103441.1505659-2-rjarry@redhat.com>
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
> When rte_rcu_qsbr_dq_enqueue() fails in DQ mode, the deleted key slot
> is never freed and becomes permanently leaked. Fall back to synchronous
> reclamation instead of only logging an error.
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/hash/rte_cuckoo_hash.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index da12825c6ed2..8189bde024be 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -1870,18 +1870,15 @@ __rte_hash_del_key_with_hash(const struct
> rte_hash *h, const void *key,
>  		/* Key index where key is stored, adding the first dummy index
> */
>  		rcu_dq_entry.key_idx =3D ret + 1;
>  		rcu_dq_entry.ext_bkt_idx =3D index;
> -		if (h->dq =3D=3D NULL) {
> +		if (h->dq =3D=3D NULL || rte_rcu_qsbr_dq_enqueue(h->dq,
> &rcu_dq_entry) !=3D 0) {
>  			/* Wait for quiescent state change if using
> -			 * RTE_HASH_QSBR_MODE_SYNC
> +			 * RTE_HASH_QSBR_MODE_SYNC or if RCU enqueue
> failed.
>  			 */
>  			rte_rcu_qsbr_synchronize(h->hash_rcu_cfg->v,
>  						 RTE_QSBR_THRID_INVALID);
>  			__hash_rcu_qsbr_free_resource((void *)((uintptr_t)h),
>  						      &rcu_dq_entry, 1);
> -		} else if (h->dq)
> -			/* Push into QSBR FIFO if using
> RTE_HASH_QSBR_MODE_DQ */
> -			if (rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) !=3D
> 0)
> -				HASH_LOG(ERR, "Failed to push QSBR FIFO");
> +		}
>  	}
>  	__hash_rw_writer_unlock(h);
>  	return ret;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

