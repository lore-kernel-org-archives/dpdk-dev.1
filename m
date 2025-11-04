Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7ECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 09:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 042B5402ED;
	Tue,  4 Nov 2025 10:32:58 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 834C940285;
 Tue,  4 Nov 2025 10:32:56 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1WGvQseb7MPkHRn5LIcr9C4ivj5r4UjBuM9nA+9N6Eo=;
 b=mZi0zvShk9IjuVCK5QupkTzVx7rei174bUZ47kzOWyCpG6pEK28/KLdNilZA34VnjHfYmNHzk
 d8DIG8IPVdpSUkaCkVWuGQisz/ccJ+v+Vyv9h6HzC93wg6JNJAOn+BlZKNkf2t78aDVRRueOpwH
 r1zIuCu7QPrmwarTwcV/vz8=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d139j4G3yz1K96k;
 Tue,  4 Nov 2025 17:31:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B7AA18001B;
 Tue,  4 Nov 2025 17:32:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 17:32:54 +0800
Message-ID: <d1f2634a-7c8c-4d3f-9578-dfc80ce504aa@huawei.com>
Date: Tue, 4 Nov 2025 17:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: fix use-after-free race during cleanup
To: Shani Peretz <shperetz@nvidia.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo
 Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
References: <20251104080931.8102-1-shperetz@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104080931.8102-1-shperetz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 11/4/2025 4:09 PM, Shani Peretz wrote:
> This commit fixes a use-after-free that causes the application
> to crash on shutdown (detected by ASAN).
> 
> The vhost library uses a background event dispatch thread that monitors
> fds with epoll. It runs in an infinite loop, waiting for I/O events
> and calling callbacks when they occur.
> 
> During cleanup, a race condition existed:
> 
>   Main Thread:                    Event Dispatch Thread:
>   1. Remove fds from fdset        while (1) {
>   2. Close file descriptors           epoll_wait() [gets interrupted]
>   3. Free fdset memory                [continues loop]
>   4. Continue...                      Accesses fdset...   CRASH
>                                   }
> 
> The main thread would free the fdset memory while the background thread
> was still running and using it.

Who will free fdset memory ? I check the lib/vhost/socket.c and found there are no explicit free.

I think it maybe the hugepage free because the fdset use rte_zmalloc(). If it's, please explicit
add it into the commit log.

> 
> The code had a `destroy` flag that the event dispatch thread checked,
> but it was never set during cleanup, and the code never waited for
> the thread to actually exit before freeing memory.
> 
> This commit implements `fdset_destroy()` that will set the destroy
> flag, wait for thread termination, and clean up all resources.
> The socket.c is updated to call fdset_destroy() when the last vhost-user
> socket is unregistered.
> 
> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>


