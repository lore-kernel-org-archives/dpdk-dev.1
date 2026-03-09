Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D2EF36F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AAC2402DC;
	Mon,  9 Mar 2026 08:50:18 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5AF8940281
 for <dev@dpdk.org>; Mon,  9 Mar 2026 08:50:16 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTq0Y3H3xzJ4692;
 Mon,  9 Mar 2026 15:49:33 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 1139E40585;
 Mon,  9 Mar 2026 15:50:16 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 07:50:15 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 9 Mar 2026 07:50:15 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Thread-Topic: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
Thread-Index: AQHcrUXi4ZBN5LlCak+VAMvKtWPN2bWl18/w
Date: Mon, 9 Mar 2026 07:50:15 +0000
Message-ID: <540b570f12bb458997f4b8a1a4322dff@huawei.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
In-Reply-To: <20260306084710.492520-4-rjarry@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.174]
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



> When rte_hash_add_key_data() is called with an existing key, the old
> data pointer is silently overwritten. With RCU-protected readers still
> potentially accessing the old data, the application cannot safely free
> it since the old pointer is never returned.
>=20
> This series fixes the issue in two places:
>=20
> * When RCU is configured with a free_key_data_func callback,
>   rte_hash_add_key_data() now automatically defers freeing the old data
>   on overwrite. No caller changes are needed.
>=20
> * If rte_hash_del_key() fails to enqueue the deleted entry in
>   RTE_HASH_QSBR_MODE_DQ, it falls back on RTE_HASH_QSBR_MODE_SYNC to
>   avoid leaking slots and data pointers.
>=20
> v3:
>=20
> * Use rte_atomic_exchange_explicit() to swap the new data pointer with
>   the old one in search_and_update().
>=20
> * Removed the rte_hash_replace_key_data() API=20

That's a pity - I think it is a useful one.

> which required to bubble
>   a potential old_data pointer from search_and_update() to all
>   intermediate callers down to __rte_hash_add_key_with_hash(). It made
>   an already complex code even more obscure.
>=20
> v2:
>=20
> * New patch to fallback to SYNC mode when DQ fails on delete.
> * Check key_idx =3D=3D EMPTY_SLOT in DQ mode to differentiate when old_da=
ta
>   is NULL.
> * Also fallback to SYNC mode when DQ fails on replace.
>=20
> Robin Jarry (2):
>   hash: avoid leaking entries on RCU defer queue failure
>   hash: free replaced data on overwrite when RCU is configured
>=20
>  app/test/test_hash.c                   | 134 +++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_03.rst |   7 ++
>  lib/hash/rte_cuckoo_hash.c             |  47 +++++++--
>  lib/hash/rte_hash.h                    |   8 +-
>  4 files changed, 187 insertions(+), 9 deletions(-)
>=20
> --
> 2.53.0
>=20

