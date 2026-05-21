Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3848CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 02:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD66B4028D;
	Thu, 21 May 2026 04:54:31 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by mails.dpdk.org (Postfix) with ESMTP id 85E0D400EF;
 Thu, 21 May 2026 04:54:24 +0200 (CEST)
X-UUID: 5b567b1654c011f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b34e697e-a8ea-4334-b7f5-ead365e317e1, IP:10,
 URL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:13
X-CID-INFO: VERSION:1.3.12, REQID:b34e697e-a8ea-4334-b7f5-ead365e317e1, IP:10,
 UR
 L:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:13
X-CID-META: VersionHash:e7bac3a, CLOUDID:c54c6170ef2ecd5bc5bc4664c4f2ba7c,
 BulkI
 D:260520165956E3QXJLGP,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
 |83|101|102|127|841|865|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File
 :nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
 :0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b567b1654c011f1aa26b74ffac11d73-20260521
X-User: jinzhiguang@kylinos.cn
Received: from [198.18.0.1] [(123.149.0.81)] by mailgw.kylinos.cn
 (envelope-from <jinzhiguang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 1080316702; Thu, 21 May 2026 10:54:16 +0800
Message-ID: <c515f255-5306-4412-acab-0dba26d18a8b@kylinos.cn>
Date: Thu, 21 May 2026 10:54:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ring: fix zero-copy burst API documentation
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org,
 stable@dpdk.org
References: <20260519114629.862-1-jinzhiguang@kylinos.cn>
 <20260519133853.889-1-jinzhiguang@kylinos.cn>
 <D6Rbi5-MSBSppW6LoqeJTg@monjalon.net>
From: jinzhiguang <jinzhiguang@kylinos.cn>
In-Reply-To: <D6Rbi5-MSBSppW6LoqeJTg@monjalon.net>
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


On 2026/5/20 16:59:42, Thomas Monjalon wrote:
> 19/05/2026 15:38, jinzhiguang:
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -756,6 +756,7 @@ Jing Chen <jing.d.chen@intel.com>
>>   Jingguo Fu <jingguox.fu@intel.com>
>>   Jingjing Wu <jingjing.wu@intel.com>
>>   Jingzhao Ni <jingzhao.ni@arm.com>
>> +jinzhiguang <jinzhiguang@kylinos.cn>
> Maybe you want to insert a space? What is your first name and family name?
> Please use capital letters where appropriate.
Thank you for the review! I will update the .mailmap in the v4 version 
of the patch.
