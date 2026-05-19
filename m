Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC8CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 556E740652;
	Tue, 19 May 2026 15:13:32 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by mails.dpdk.org (Postfix) with ESMTP id 5F5D14025E;
 Tue, 19 May 2026 15:13:28 +0200 (CEST)
X-UUID: 804255fe538411f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:026a8e8c-0b54-4142-8de1-412a778c81b1, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.12, REQID:026a8e8c-0b54-4142-8de1-412a778c81b1, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:e7bac3a, CLOUDID:3f3c180a3d8ae66c2864073c3e42fa1d,
 BulkI
 D:260519211319GT5JU53M,BulkQuantity:0,Recheck:0,SF:17|19|38|64|66|78|80|81
 |82|83|101|102|127|817|841|865|898,TC:nil,Content:-10|-8|-5|15|50,EDM:-3,I
 P:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 804255fe538411f1aa26b74ffac11d73-20260519
X-User: jinzhiguang@kylinos.cn
Received: from [198.18.0.1] [(123.149.0.81)] by mailgw.kylinos.cn
 (envelope-from <jinzhiguang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 572984907; Tue, 19 May 2026 21:13:17 +0800
Message-ID: <824d07a0-4c30-4d90-8df0-1df2ee1ac2e4@kylinos.cn>
Date: Tue, 19 May 2026 21:13:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] ring: fix zero-copy burst API documentation
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
References: <20260519114629.862-1-jinzhiguang@kylinos.cn>
 <b7fe1363840444ef93ec2c0be2734ff0@huawei.com>
From: jinzhiguang <jinzhiguang@kylinos.cn>
In-Reply-To: <b7fe1363840444ef93ec2c0be2734ff0@huawei.com>
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


>> diff --git a/lib/ring/rte_ring_peek_zc.h b/lib/ring/rte_ring_peek_zc.h
>> index 3254fe0481..fa566e8e0d 100644
>> --- a/lib/ring/rte_ring_peek_zc.h
>> +++ b/lib/ring/rte_ring_peek_zc.h
>> @@ -235,7 +235,7 @@ rte_ring_enqueue_zc_bulk_start(struct rte_ring *r,
>> unsigned int n,
>>    *   If non-NULL, returns the amount of space in the ring after the
>>    *   reservation operation has finished.
>>    * @return
>> - *   The number of objects that can be enqueued, either 0 or n
>> + *   Actual number of objects enqueued.
> Here and in other places, probably better:
> The actual number of objects that can be enqueued.
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Thank you for the review. I will update it and send a v2.
>>    */
>>   static __rte_always_inline unsigned int
>>   rte_ring_enqueue_zc_burst_elem_start(struct rte_ring *r, unsigned int esize,
>>
