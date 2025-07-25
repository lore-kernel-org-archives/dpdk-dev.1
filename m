Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C9C83F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 11:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BA440144;
	Fri, 25 Jul 2025 13:03:36 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id EC372400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 13:03:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpQ1V1MXbz6D94g;
 Fri, 25 Jul 2025 19:02:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7675F1402FE;
 Fri, 25 Jul 2025 19:03:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Jul 2025 13:03:34 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 25 Jul 2025 13:03:34 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Huichao Cai <chcchc88@163.com>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] acl: fix the value of the trans table
Thread-Topic: [PATCH] acl: fix the value of the trans table
Thread-Index: AQHb/U4E1ExqpzjH+USW2wWj4iz59rRCrJNw
Date: Fri, 25 Jul 2025 11:03:34 +0000
Message-ID: <272ed4f83fae4b4a8659aa5e5c01a74a@huawei.com>
References: <20250725102151.6677-1-chcchc88@163.com>
In-Reply-To: <20250725102151.6677-1-chcchc88@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.191]
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


Hi

> The node_array[RTE_ACL_DFA_SIZE] is assigned to
> RTE_ACL_IDLE_NODE and is used as a node of
> RTE_ACL_NODE_SINGLE type, but it is currently based
> on the implementation of idle arrays with a value of all
> 0 to point to itself, which is unsafe, if the value of the
> idle array is not 0, it will produce undefined behavior,
> so it needs to be given node_array[RTE_ACL_DFA_ SIZE]
> plus RTE_ACL_QUAD_SINGLE.

 Not sure I understand what is the problem you are trying to fix?
Any test-case which can demonstrate the failure?

> Signed-off-by: Huichao Cai <chcchc88@163.com>
> ---
>  lib/acl/acl_gen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
> index 3c53d24056..95c7888162 100644
> --- a/lib/acl/acl_gen.c
> +++ b/lib/acl/acl_gen.c
> @@ -497,7 +497,7 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_t=
rie *trie,
>  	 * highest index, that points to itself)
>  	 */
>=20
> -	node_array[RTE_ACL_DFA_SIZE] =3D RTE_ACL_IDLE_NODE;
> +	node_array[RTE_ACL_DFA_SIZE] =3D RTE_ACL_QUAD_SINGLE | RTE_ACL_IDLE_NOD=
E;
>=20
>  	for (n =3D 0; n < RTE_ACL_DFA_SIZE; n++)
>  		node_array[n] =3D no_match;
> --
> 2.27.0

