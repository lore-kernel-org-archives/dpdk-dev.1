Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2107C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC9240289;
	Wed,  5 Feb 2025 16:29:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8242C40270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:29:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738769375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HeS0vv9wEncZBQlVj/+fvBOEk3Ncn9X4MUr0RyGgmsg=;
 b=Zml1RTwYjArYSddF3PnDdF1uJfxFpbIZ26F+Vd01cCUJUmhcu1gm4TM9L7dmlUVAGhHYNP
 ONUpTnwCxvEdwgykaNa/B5kd7gsnLNox7IYhPwom4ITTQAtaRhUCqxa9F9NCsWg26DwNDc
 mCrt3amD5gBbb9qwnFQpiTgbPmGBzsk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-EtyxytSzMtSx5ULnoD696g-1; Wed,
 05 Feb 2025 10:29:32 -0500
X-MC-Unique: EtyxytSzMtSx5ULnoD696g-1
X-Mimecast-MFC-AGG-ID: EtyxytSzMtSx5ULnoD696g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C262719560A7; Wed,  5 Feb 2025 15:29:30 +0000 (UTC)
Received: from [10.39.208.34] (unknown [10.39.208.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7067C1800358; Wed,  5 Feb 2025 15:29:29 +0000 (UTC)
Message-ID: <48f33e8b-8ba5-49f1-a38c-7e0f6efec30b@redhat.com>
Date: Wed, 5 Feb 2025 16:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Vhost: fix FD entries cleanup
To: Chenbo Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <20241224154958.146852-1-maxime.coquelin@redhat.com>
 <CAJFAV8zwCx+Xsa12TaLye3A9dSSSbt_T_-cc6Lc71oNyLv9=nw@mail.gmail.com>
 <3EE665CF-8BD9-4F3E-8CF4-30F0A285A7CC@nvidia.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <3EE665CF-8BD9-4F3E-8CF4-30F0A285A7CC@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EsFuv1YXqIip5eLbrdhvw5deJTI2t1IAMs6qbiESUqE_1738769371
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Chenbo & David,

On 2/5/25 8:27 AM, Chenbo Xia wrote:
> Hi David,
> 
>> On Feb 4, 2025, at 21:18, David Marchand <david.marchand@redhat.com> wrote:
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hello vhost maintainers,
>>
>> On Tue, Dec 24, 2024 at 4:50 PM Maxime Coquelin
>> <maxime.coquelin@redhat.com> wrote:
>>>
>>> The vhost FD manager provides a way for the read/write
>>> callbacks to request removal of their associated FD from
>>> the epoll FD set. Problem is that it is missing a cleanup
>>> callback, so the read/write callback requesting the removal
>>> have to perform cleanups before the FD is removed from the
>>> FD set. It includes closing the FD before it is removed
>>> from the epoll FD set.
>>>
>>> This series introduces a new cleanup callback which, if
>>> implemented, is closed right after the FD is removed from
>>> FD set.
>>>
>>> Maxime Coquelin (3):
>>>   vhost: add cleanup callback to FD entries
>>>   vhost: fix vhost-user socket cleanup order
>>>   vhost: improve VDUSE reconnect handler cleanup
>>>
>>> lib/vhost/fd_man.c | 16 ++++++++++++----
>>> lib/vhost/fd_man.h |  3 ++-
>>> lib/vhost/socket.c | 46 ++++++++++++++++++++++++++--------------------
>>> lib/vhost/vduse.c  | 16 +++++++++++-----
>>> 4 files changed, 51 insertions(+), 30 deletions(-)
>>
>> I tried this series, and it fixes the error log I reported.
>>
>> On the other hand, I wonder if we could do something simpler.
>>
>> The fd is only used by the registered handlers.
>> If a handler reports that it does not want to watch this fd anymore,
>> then there is no remaining user in the vhost library for this fd.
>>
>> So my proposal would be to rename the "remove" flag as a "close" flag:
>>
>> @@ -12,7 +12,7 @@ struct fdset;
>>
>> #define MAX_FDS 1024
>>
>> -typedef void (*fd_cb)(int fd, void *dat, int *remove);
>> +typedef void (*fd_cb)(int fd, void *dat, int *close);
>>
>> struct fdset *fdset_init(const char *name);
>>
>> And defer closing to fd_man.
>> Something like:
>>
>> @@ -367,9 +367,9 @@ fdset_event_dispatch(void *arg)
>>                         pthread_mutex_unlock(&pfdset->fd_mutex);
>>
>>                         if (rcb && events[i].events & (EPOLLIN |
>> EPOLLERR | EPOLLHUP))
>> -                               rcb(fd, dat, &remove1);
>> +                               rcb(fd, dat, &close1);
>>                         if (wcb && events[i].events & (EPOLLOUT |
>> EPOLLERR | EPOLLHUP))
>> -                               wcb(fd, dat, &remove2);
>> +                               wcb(fd, dat, &close2);
>>                         pfdentry->busy = 0;
>>                         /*
>>                          * fdset_del needs to check busy flag.
>> @@ -381,8 +381,10 @@ fdset_event_dispatch(void *arg)
>>                          * fdentry not to be busy, so we can't call
>>                          * fdset_del_locked().
>>                          */
>> -                       if (remove1 || remove2)
>> +                       if (close1 || close2) {
>>                                 fdset_del(pfdset, fd);
>> +                               close(fd);
>> +                       }
>>                 }
>>
>>                 if (pfdset->destroy)
>>
>>
>> And the only thing to move out of the socket and vduse handlers is the
>> close(fd) call.
>>
>> Like:
>>
>> @@ -303,7 +303,7 @@ vhost_user_server_new_connection(int fd, void
>> *dat, int *remove __rte_unused)
>> }
>>
>> static void
>> -vhost_user_read_cb(int connfd, void *dat, int *remove)
>> +vhost_user_read_cb(int connfd, void *dat, int *close)
>> {
>>         struct vhost_user_connection *conn = dat;
>>         struct vhost_user_socket *vsocket = conn->vsocket;
>> @@ -313,8 +313,7 @@ vhost_user_read_cb(int connfd, void *dat, int *remove)
>>         if (ret < 0) {
>>                 struct virtio_net *dev = get_device(conn->vid);
>>
>> -               close(connfd);
>> -               *remove = 1;
>> +               *close = 1;
> 
> I have one concern here is compared with this RFC, the proposal changed the timing
> of close connfd，which means on QEMU side, cleaning up resources will happen later.
> 
> Currently I can’t think of issues could be introduced by this change (maybe you and
> Maxime could remind me of something :)

That's a good point.
I just tested David's suggestion with Vhost-user with OVS and QEMU:
- guest shutdown + reconnect
- live-migration
- OVS restart

It seems to behave very well.

> Besides this, definitely this proposal is cleaner.

I agree, I will send a new revision re-using David's proposal.

Thanks,
Maxime

> 
> Thanks,
> Chenbo
> 
>>
>>                 if (dev)
>>                         vhost_destroy_device_notify(dev);
>>
>>
>> Maxime, Chenbo, opinions?
>>
>>
>> --
>> David Marchand
>>
> 

