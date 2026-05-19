Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32175CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C44F40650;
	Tue, 19 May 2026 15:42:34 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by mails.dpdk.org (Postfix) with ESMTP id 555FF4025E;
 Tue, 19 May 2026 15:42:31 +0200 (CEST)
X-UUID: 928240e0538811f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:eb67e3a4-8553-4a30-801f-e7c4cd57abfd, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:eb67e3a4-8553-4a30-801f-e7c4cd57abfd, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:1460456b33029621a2607576877ce041,
 BulkI
 D:260519214228S27U87YK,BulkQuantity:0,Recheck:0,SF:17|19|38|64|66|78|80|81
 |82|83|101|102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,F
 ile:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
 ,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 928240e0538811f1aa26b74ffac11d73-20260519
X-User: jinzhiguang@kylinos.cn
Received: from [198.18.0.1] [(123.149.0.81)] by mailgw.kylinos.cn
 (envelope-from <jinzhiguang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 2043530029; Tue, 19 May 2026 21:42:26 +0800
Message-ID: <bf587f4a-45ab-42ed-ac5d-5af972d3dab3@kylinos.cn>
Date: Tue, 19 May 2026 21:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ring: fix zero-copy burst API documentation
To: Thomas Monjalon <thomas@monjalon.net>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260519131846.1089-1-jinzhiguang@kylinos.cn>
From: jinzhiguang <jinzhiguang@kylinos.cn>
In-Reply-To: <20260519131846.1089-1-jinzhiguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


Please ignore this patch. It was sent with incorrect threading.
> These are burst APIs relying on RTE_RING_QUEUE_VARIABLE behavior, they
> operate on a best-effort basis and return the actual number of
> objects processed (between 0 and n).
>
> Update description to match implementation.
>
> Fixes: 47bec9a5ca9f ("ring: add zero copy API")
>
> Signed-off-by: jinzhiguang <jinzhiguang@kylinos.cn>
> ---
> Cc: honnappa.nagarahalli@arm.com
> Cc: stable@dpdk.org
> ---
>   .mailmap                    | 1 +
>   lib/ring/rte_ring_peek_zc.h | 8 ++++----
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 4d26d9c286..a4f91f2131 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -756,6 +756,7 @@ Jing Chen <jing.d.chen@intel.com>
>   Jingguo Fu <jingguox.fu@intel.com>
>   Jingjing Wu <jingjing.wu@intel.com>
>   Jingzhao Ni <jingzhao.ni@arm.com>
> +jinzhiguang <jinzhiguang@kylinos.cn>
>   Jiri Slaby <jslaby@suse.cz>
>   Job Abraham <job.abraham@intel.com>
>   Jochen Behrens <jochen.behrens@broadcom.com> <jbehrens@vmware.com>
> diff --git a/lib/ring/rte_ring_peek_zc.h b/lib/ring/rte_ring_peek_zc.h
> index 3254fe0481..43d6a53075 100644
> --- a/lib/ring/rte_ring_peek_zc.h
> +++ b/lib/ring/rte_ring_peek_zc.h
> @@ -235,7 +235,7 @@ rte_ring_enqueue_zc_bulk_start(struct rte_ring *r, unsigned int n,
>    *   If non-NULL, returns the amount of space in the ring after the
>    *   reservation operation has finished.
>    * @return
> - *   The number of objects that can be enqueued, either 0 or n
> + *   The actual number of objects that can be enqueued.
>    */
>   static __rte_always_inline unsigned int
>   rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
> @@ -265,7 +265,7 @@ rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
>    *   If non-NULL, returns the amount of space in the ring after the
>    *   reservation operation has finished.
>    * @return
> - *   The number of objects that can be enqueued, either 0 or n.
> + *   The actual number of objects that can be enqueued.
>    */
>   static __rte_always_inline unsigned int
>   rte_ring_enqueue_zc_burst_start(struct rte_ring *r, unsigned int n,
> @@ -442,7 +442,7 @@ rte_ring_dequeue_zc_bulk_start(struct rte_ring *r, unsigned int n,
>    *   If non-NULL, returns the number of remaining ring entries after the
>    *   dequeue has finished.
>    * @return
> - *   The number of objects that can be dequeued, either 0 or n.
> + *   The actual number of objects that can be dequeued.
>    */
>   static __rte_always_inline unsigned int
>   rte_ring_dequeue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
> @@ -471,7 +471,7 @@ rte_ring_dequeue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
>    *   If non-NULL, returns the number of remaining ring entries after the
>    *   dequeue has finished.
>    * @return
> - *   The number of objects that can be dequeued, either 0 or n.
> + *   The actual number of objects that can be dequeued.
>    */
>   static __rte_always_inline unsigned int
>   rte_ring_dequeue_zc_burst_start(struct rte_ring *r, unsigned int n,
