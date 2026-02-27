Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80859FD5313
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 886694027F;
	Fri, 27 Feb 2026 10:00:39 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id C947D4003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:00:37 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=iBQ64KSyqBxpwP5txP4g+gJ4Io0tb2FDLR9HM7GXw7U=;
 b=mOvgzNDJsmWU57d4gP2g6XFTWCGcMc8S3bbUST4lcoOXuqj78iFmptXwoTHHWz1wNdg+u3ink
 B62NSJp5ZVaz6p527brPnqa9UnRUn7fENmXVuurl8zrrdiOIuwfAwRlwqSVkeamCgWkNTuOpIQw
 WidJYe5kX7T0PQ2gNc3Y0/0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fMhxX4JhxzpTKX;
 Fri, 27 Feb 2026 16:55:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A7714056A;
 Fri, 27 Feb 2026 17:00:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 17:00:34 +0800
Message-ID: <f03f5fa5-267f-42e3-95b5-58ab5d362e1e@huawei.com>
Date: Fri, 27 Feb 2026 17:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] vhost: fix use-after-free in fdset during shutdown
To: David Marchand <david.marchand@redhat.com>, Yehor Malikov
 <malikovyehor@gmail.com>
CC: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <chenbox@nvidia.com>,
 <stephen@networkplumber.org>, Yehor Malikov <Yehor.Malikov@solidigm.com>
References: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
 <20260218090540.89215-1-malikovyehor@gmail.com>
 <CAJFAV8wfwo1y67H5M=6hCk9ifyqMpqxEySUWu9u9KE3Niy3jcg@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8wfwo1y67H5M=6hCk9ifyqMpqxEySUWu9u9KE3Niy3jcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 2/18/2026 6:27 PM, David Marchand wrote:
> On Wed, 18 Feb 2026 at 10:05, Yehor Malikov <malikovyehor@gmail.com> wrote:
>>
>> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
>>
>> The fdset_event_dispatch thread runs in a loop checking the destroy
>> flag after each epoll_wait iteration. During process exit,
>> rte_eal_cleanup() frees hugepage memory while the fdset thread is
>> still running. Since the fdset structure was allocated with
>> rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
>> causes use-after-free.
>>
>> Switch fdset allocation from rte_zmalloc/rte_free to libc
>> calloc/free. The fdset is a control-path structure that does not
>> need hugepage memory. Using libc allocation ensures the fdset
>> remains valid after rte_eal_cleanup() releases hugepages.
>>
>> Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
> Cc: stable@dpdk.org
> 
>>
>> Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
> 
> Thanks for the fix.
> 
> Acked-by: David Marchand <david.marchand@redhat.com>
> 
> 

