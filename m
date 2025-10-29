Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769BBCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 00:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42FAD4028D;
	Wed, 29 Oct 2025 01:56:28 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id CCD5040262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 01:56:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=VklPGhKSQdl+DnNi7i2FWzdRAieDATQHgzj0xbaSl1E=;
 b=5Nugbm951XEJI+JY91+dF26PIhOzmNMEQFJheMRVwQWIit3XJZ+6HWvkl3tsdNjNf+cCKp38u
 d23lCEkQWpbriRuhaH3qlMW8JQxAl1ia0jUHBYcsD625lHDfALb7XFzc9OoaGaMu6uIM5F4jcvJ
 9A7odtyIDr+exL+PbNVqLTY=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cx81b0GBLznTVF;
 Wed, 29 Oct 2025 08:55:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6AB211800B2;
 Wed, 29 Oct 2025 08:56:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 08:56:23 +0800
Message-ID: <3cd4f993-4886-4e33-8a85-5c6ed9fc7d8e@huawei.com>
Date: Wed, 29 Oct 2025 08:56:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] enhance ethdev telemetry
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <dev@dpdk.org>
References: <20251025094239.4915-1-fengchengwen@huawei.com>
 <20251028064653.54941255@phoenix>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251028064653.54941255@phoenix>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 10/28/2025 9:46 PM, Stephen Hemminger wrote:
> On Sat, 25 Oct 2025 17:42:37 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> This patchset contains two commits which enhancing ethdev telemetry.
>>
>> Chengwen Feng (2):
>>   ethdev: support telemetry RSS algorithm
>>   ethdev: support hide zero when telemetry regs
>>
>>  lib/ethdev/rte_ethdev_telemetry.c | 56 ++++++++++++++++++++++---------
>>  1 file changed, 40 insertions(+), 16 deletions(-)
>>
> 
> Queued to next-net
> 
> Does the documentation need updating? or a release note?

Currently there are no telemetry document.

Maybe we need add one telemetry section in eal/ethdev/crypto/eventdev/dmadev rst.



