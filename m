Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A92CDB466
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 01:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1B54021F;
	Mon, 22 Jun 2026 03:22:45 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id AA87840150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 03:22:42 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=R+4gHq7lmflhIYJcUFn83CIm0i23FstCoN+RGD+oGgw=;
 b=Y/QOomvmvQauLroTgVM/OReAc417pUtsrnBQj/T4Vfi+pTcL00bkcMWDL27LIksU/CKZDDLnj
 raPpGftEmQakcozaYrLd7ShKZlSFn+knlTGV1ipeJt1vHGzJuXLKq1njrYuISvO+XivgMUINmgc
 UP8ERllP5BmAQ1SVA2fsa7I=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gk9FZ4rjnznTVr;
 Mon, 22 Jun 2026 09:13:54 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id DFB174056C;
 Mon, 22 Jun 2026 09:22:39 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Jun
 2026 09:22:39 +0800
Message-ID: <15b95ab5-af2e-40d2-8ea8-a5d14a52dfc0@huawei.com>
Date: Mon, 22 Jun 2026 09:22:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>
CC: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <zhanjie9@hisilicon.com>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260618190339.2fc76616@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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


On 6/19/2026 10:03 AM, Stephen Hemminger wrote:
> On Wed, 17 Jun 2026 13:48:37 +0200
> Morten Brørup <mb@smartsharesystems.com> wrote:
>
>>> From: Huisong Li [mailto:lihuisong@huawei.com]
>>> Sent: Wednesday, 17 June 2026 12.28
>>>
>>> Add the RTE_LCORE_ prefix to the lcore role enum values in
>>> rte_lcore_role_t
>>> to follow DPDK naming conventions.
>>>
>>> - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
>>> - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
>>> - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
>>> - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
>>>
>>> Old names are kept as macros aliasing to the new names to preserve
>>> backward compatibility.
>>>    
>> Series-Acked-by: Morten Brørup <mb@smartsharesystems.com>
>>
> The problem with this patch it causes build failures now with abi diff.
>
> Example build log...
>
>
> 2 functions with some indirect sub-type change:
>
>
>
>
>
>   [C] 'function rte_lcore_role_t rte_eal_lcore_role(unsigned int)' at eal_common_lcore.c:74:1 has some indirect sub-type changes:
>
>   return type changed:
>
>   type size hasn't changed
>
>   4 enumerator deletions:
>
>   'rte_lcore_role_t::ROLE_RTE' value '0'
>
>   'rte_lcore_role_t::ROLE_OFF' value '1'
>
>   'rte_lcore_role_t::ROLE_SERVICE' value '2'
>
>   'rte_lcore_role_t::ROLE_NON_EAL' value '3'
>
>   4 enumerator insertions:
>
>   'rte_lcore_role_t::RTE_LCORE_ROLE_RTE' value '0'
>
>   'rte_lcore_role_t::RTE_LCORE_ROLE_OFF' value '1'
>
>   'rte_lcore_role_t::RTE_LCORE_ROLE_SERVICE' value '2'
>
>   'rte_lcore_role_t::RTE_LCORE_ROLE_NON_EAL' value '3'
>
>
>
>
>
>   [C] 'function int rte_lcore_has_role(unsigned int, rte_lcore_role_t)' at eal_common_lcore.c:85:1 has some indirect sub-type changes:
>
>   parameter 2 of type 'enum rte_lcore_role_t' has sub-type changes:
>
>   enum type 'enum rte_lcore_role_t' changed at rte_lcore.h:33:1, as reported earlier
>
>
>
>
>
>
>
> Error: ABI issue reported for abidiff --suppr /home/runner/work/dpdk/dpdk/devtools/libabigail.abignore --no-added-syms --headers-dir1 reference/usr/local/include --headers-dir2 install/usr/local/include reference/usr/local/lib/librte_eal.so.26.1 install/usr/local/lib/librte_eal.so.26.2
We just came back from the Dragon Boat Festival.
I also received this ABI change warning. But I didn't have any good 
ideas yet.
Thanks for helping to handle this.
Sorry for the inconvenience.

