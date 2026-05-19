Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A35CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A166A40296;
	Tue, 19 May 2026 13:57:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 31E7A4025E;
 Tue, 19 May 2026 13:57:36 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKY7D1F9kzJ468g;
 Tue, 19 May 2026 19:56:56 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D4AC40584;
 Tue, 19 May 2026 19:57:34 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 12:57:33 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 19 May 2026 12:57:33 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: jinzhiguang <jinzhiguang@kylinos.cn>, Thomas Monjalon
 <thomas@monjalon.net>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] ring: fix zero-copy burst API documentation
Thread-Topic: [PATCH] ring: fix zero-copy burst API documentation
Thread-Index: AQHc54VhvA0OxYdmPEq+YFT9yFQq9bYVPdUQ
Date: Tue, 19 May 2026 11:57:33 +0000
Message-ID: <b7fe1363840444ef93ec2c0be2734ff0@huawei.com>
References: <20260519114629.862-1-jinzhiguang@kylinos.cn>
In-Reply-To: <20260519114629.862-1-jinzhiguang@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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


> These are burst APIs relying on RTE_RING_QUEUE_VARIABLE behavior, they
> operate on a best-effort basis and return the actual number of
> objects processed (between 0 and n).
>=20
> Update description to match implementation.
>=20
> Fixes: 47bec9a5ca9f ("ring: add zero copy API")
>=20
> Signed-off-by: jinzhiguang <jinzhiguang@kylinos.cn>
> ---
> Cc: honnappa.nagarahalli@arm.com
> Cc: stable@dpdk.org
> ---
>  .mailmap                    | 1 +
>  lib/ring/rte_ring_peek_zc.h | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 4d26d9c286..a4f91f2131 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -756,6 +756,7 @@ Jing Chen <jing.d.chen@intel.com>
>  Jingguo Fu <jingguox.fu@intel.com>
>  Jingjing Wu <jingjing.wu@intel.com>
>  Jingzhao Ni <jingzhao.ni@arm.com>
> +jinzhiguang <jinzhiguang@kylinos.cn>
>  Jiri Slaby <jslaby@suse.cz>
>  Job Abraham <job.abraham@intel.com>
>  Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
> diff --git a/lib/ring/rte_ring_peek_zc.h b/lib/ring/rte_ring_peek_zc.h
> index 3254fe0481..fa566e8e0d 100644
> --- a/lib/ring/rte_ring_peek_zc.h
> +++ b/lib/ring/rte_ring_peek_zc.h
> @@ -235,7 +235,7 @@ rte_ring_enqueue_zc_bulk_start(struct rte_ring *r,
> unsigned int n,
>   *   If non-NULL, returns the amount of space in the ring after the
>   *   reservation operation has finished.
>   * @return
> - *   The number of objects that can be enqueued, either 0 or n
> + *   Actual number of objects enqueued.

Here and in other places, probably better:
The actual number of objects that can be enqueued.
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

>   */
>  static __rte_always_inline unsigned int
>  rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int es=
ize,
> @@ -265,7 +265,7 @@ rte_ring_enqueue_zc_burst_elem_start(struct rte_ring
> *r, unsigned int esize,
>   *   If non-NULL, returns the amount of space in the ring after the
>   *   reservation operation has finished.
>   * @return
> - *   The number of objects that can be enqueued, either 0 or n.
> + *   Actual number of objects enqueued.
>   */
>  static __rte_always_inline unsigned int
>  rte_ring_enqueue_zc_burst_start(struct rte_ring *r, unsigned int n,
> @@ -442,7 +442,7 @@ rte_ring_dequeue_zc_bulk_start(struct rte_ring *r,
> unsigned int n,
>   *   If non-NULL, returns the number of remaining ring entries after the
>   *   dequeue has finished.
>   * @return
> - *   The number of objects that can be dequeued, either 0 or n.
> + *   Actual number of objects dequeued.
>   */
>  static __rte_always_inline unsigned int
>  rte_ring_dequeue_zc_burst_elem_start(struct rte_ring *r, unsigned int es=
ize,
> @@ -471,7 +471,7 @@ rte_ring_dequeue_zc_burst_elem_start(struct rte_ring
> *r, unsigned int esize,
>   *   If non-NULL, returns the number of remaining ring entries after the
>   *   dequeue has finished.
>   * @return
> - *   The number of objects that can be dequeued, either 0 or n.
> + *   Actual number of objects dequeued.
>   */
>  static __rte_always_inline unsigned int
>  rte_ring_dequeue_zc_burst_start(struct rte_ring *r, unsigned int n,
> --
> 2.53.0

