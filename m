Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5725EA8121
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41CA540698;
	Tue, 10 Feb 2026 15:47:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D92940609
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:47:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770734831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/onpyZJXY2Y9VIyYdifYueW7jjGZW9lsk2KplDlhW7M=;
 b=YHc9QLXl3cUgtMbA08+r7u/Cf8qVf1jkZnzxGnmQ/Pqbj9a/kxUC5FdnV5kSrZvbtLZEnn
 kZQ6EX2j898nTje5u9mlIvQtnmY/3jzLlxnLWto7gq1r5EndeeSP7SDvQy8zJhCF+ffLC1
 ettYXh90843UFKuWjOHlAsTY3XReX2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-kbz-i3JSO8SnuhaaBzLG1A-1; Tue, 10 Feb 2026 09:47:10 -0500
X-MC-Unique: kbz-i3JSO8SnuhaaBzLG1A-1
X-Mimecast-MFC-AGG-ID: kbz-i3JSO8SnuhaaBzLG1A_1770734829
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so7729045e9.0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770734829; x=1771339629;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/onpyZJXY2Y9VIyYdifYueW7jjGZW9lsk2KplDlhW7M=;
 b=ePEP7VUmzMhXNpv/GFdKyfziv+JJLsPlGiMzz5DZUuHQDM77uRmhsYbdSNml3UMga6
 EaWF29TbLW7X4Akv8NLQSObc+p75XiLByt7Jvpw4/j8sZlINx1CcACKZHHvv6JT/E4x8
 J2u7oLQztkZ5sJAng7TyfmXHsKCHdaQgOhRPhIEsvj/ETpohnP6nZtXaPiAA+efwKkex
 Ys9G+J/Dc7xgX2CFmynRvf1OLTV7fMIUfp9zOsdKdh2BaCTDwovwkTdFiElhiTNVjnx8
 g7bAeyN5O4RcojmfQo22G/rMsJwsDUph8u+lrE4sjwAixhJR5rkn6Qz5DvfxBWVXPEIA
 P2pg==
X-Gm-Message-State: AOJu0YwFqagc57oNiOELFPzR4uVkmZIFxbSPJVZlXrqARHXpkC5//dRv
 pXdG8BkL1oNF33Ck8m6lyNVwSHuNi6/wF54U9RuWB7Q8DRIk3kDi+K2xghaB1B2H+zBh/0qZRDY
 p7wOzANp1Lv+557ezccamkv6/VJKPlOb5+COsQ5rLYgpw
X-Gm-Gg: AZuq6aKJEcXQcLtTF0/+IRqz705SbxqO/I59FGi4tUK6TiaNdjrLjSZSFROVy4PJPc8
 BiTbaZ4YMk7VftNAaDrlpwdYeQsC60Vuha7FcePD/vmJ71k0rfFa/5WcnmWYd8+l8cgBPmhXiCs
 tQaTraz7bdFdR0HG++Ugjt3MbkVx+sGCnlSMw87aHOxQcLD7ayIPLX31zwOF/KO3eeXSo9WmMM9
 9h8YH2/4JPD2qTQ/dp4POuK7/LluCqUAv1Esh6ZeZAwpQP9leblFWKQ1F0XGaGCV+PX3exH1b+/
 dP19zkh+mlwK3h1MycqyMiDHrh4jq7e6JC+7ajbTxVts9+gVbmFA5Ebphd+iRivRvmLDn7bofys
 XgwOqqUKLIIaR5/RAjZl2zk3b
X-Received: by 2002:a05:600c:a08c:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483201dadabmr224997755e9.7.1770734828985; 
 Tue, 10 Feb 2026 06:47:08 -0800 (PST)
X-Received: by 2002:a05:600c:a08c:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-483201dadabmr224997325e9.7.1770734828539; 
 Tue, 10 Feb 2026 06:47:08 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e5b63sm196761585e9.1.2026.02.10.06.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 06:47:07 -0800 (PST)
Message-ID: <8d2aed2e-87fb-4946-b96a-f0d07a11d5f2@redhat.com>
Date: Tue, 10 Feb 2026 14:47:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] eal/linux: handle interrupt epoll events
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, stable@dpdk.org, Harman Kalra <hkalra@marvell.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-3-ktraynor@redhat.com>
 <CAJFAV8w0ic1OzGHSmLecR4bGjPCxTWuYA_yCEoxqBSR28aKo5A@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8w0ic1OzGHSmLecR4bGjPCxTWuYA_yCEoxqBSR28aKo5A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q6G7MB7AZv0b0sgWgYCL5cRvR5kPNj9pt_y_JP_izhY_1770734829
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 10/02/2026 09:17, David Marchand wrote:
> Hello Kevin,
> 
> On Fri, 6 Feb 2026 at 18:21, Kevin Traynor <ktraynor@redhat.com> wrote:
>>
>> Add handling for epoll error and disconnect conditions EPOLLERR,
>> EPOLLHUP and EPOLLRDHUP.
>>
>> These events indicate that the interrupt file descriptor is in
>> an error state or there has been a hangup.
>>
>> Only do this for interrupts that are read in eal. Interrupts that
>> are read outside eal should deal with different interrupt scenarios
>> appropriate to their functionality. e.g. virtio interrupt handling
>> has reconnect mechanisms for some cases.
>>
>> Also, treat no bytes read as an error condition.
>>
>> Bugzilla ID: 1873
>> Fixes: af75078fece3 ("first public release")
>> Cc: stable@dpdk.org
> 
> Cc: Harman.
> 
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
>> ---
>>  lib/eal/linux/eal_interrupts.c | 67 ++++++++++++++++++++++------------
>>  1 file changed, 44 insertions(+), 23 deletions(-)
>>
>> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
>> index 9db978923a..68ca0f929e 100644
>> --- a/lib/eal/linux/eal_interrupts.c
>> +++ b/lib/eal/linux/eal_interrupts.c
>> @@ -887,4 +887,26 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
>>  }
>>
>> +static void
>> +eal_intr_source_remove_and_free(struct rte_intr_source *src)
>> +{
>> +       struct rte_intr_callback *cb, *next;
>> +
>> +       /* Remove the interrupt source */
>> +       rte_spinlock_lock(&intr_lock);
>> +       TAILQ_REMOVE(&intr_sources, src, next);
>> +       rte_spinlock_unlock(&intr_lock);
>> +
>> +       /* Free callbacks */
>> +       for (cb = TAILQ_FIRST(&src->callbacks); cb; cb = next) {
>> +               next = TAILQ_NEXT(cb, next);
>> +               TAILQ_REMOVE(&src->callbacks, cb, next);
>> +               free(cb);
>> +       }
>> +
>> +       /* Free the interrupt source */
>> +       rte_intr_instance_free(src->intr_handle);
>> +       free(src);
>> +}
>> +
>>  static int
>>  eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>> @@ -952,4 +974,16 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>>
>>                 if (bytes_read > 0) {
>> +                       /**
>> +                        * Check for epoll error or disconnect events for
>> +                        * interrupts that are read directly in eal.
>> +                        */
>> +                       if (events[n].events & (EPOLLERR | EPOLLHUP | EPOLLRDHUP)) {
>> +                               EAL_LOG(INFO, "Disconnect condition on fd %d "
> 
> This is an anormal situation, I would make this log level the same as
> other logs below.
> 
> The fact that the interrupt fd gets into this state should be
> something to report and investigate.
> 

ok. I'll change to warning.

> 
>> +                                       "(events=0x%x), removing from epoll",
>> +                                       events[n].data.fd, events[n].events);
>> +                               eal_intr_source_remove_and_free(src);
>> +                               return -1;
>> +                       }
>> +
>>                         /**
>>                          * read out to clear the ready-to-be-read flag
>> @@ -957,5 +991,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>>                          */
>>                         bytes_read = read(events[n].data.fd, &buf, bytes_read);
>> -                       if (bytes_read < 0) {
>> +                       if (bytes_read > 0) {
>> +                               call = true;
>> +                       } else if (bytes_read < 0) {
>>                                 if (errno == EINTR || errno == EWOULDBLOCK)
>>                                         continue;
>> @@ -965,27 +1001,12 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
>>                                         events[n].data.fd,
>>                                         strerror(errno));
>> -                               /*
>> -                                * The device is unplugged or buggy, remove
>> -                                * it as an interrupt source and return to
>> -                                * force the wait list to be rebuilt.
>> -                                */
>> -                               rte_spinlock_lock(&intr_lock);
>> -                               TAILQ_REMOVE(&intr_sources, src, next);
>> -                               rte_spinlock_unlock(&intr_lock);
>> -
>> -                               for (cb = TAILQ_FIRST(&src->callbacks); cb;
>> -                                                       cb = next) {
>> -                                       next = TAILQ_NEXT(cb, next);
>> -                                       TAILQ_REMOVE(&src->callbacks, cb, next);
>> -                                       free(cb);
>> -                               }
>> -                               rte_intr_instance_free(src->intr_handle);
>> -                               free(src);
>> -                               return -1;
>> -                       } else if (bytes_read == 0)
>> -                               EAL_LOG(ERR, "Read nothing from file "
>> +                       } else { /* bytes == 0 */
> 
> "bytes_read == 0", or remove this comment as the code is quite compact
> and leaves little space for wondering what this else block is about.
> 

Ack. I will take it as a compliment and remove the comment ;-)

> 
>> +                               EAL_LOG(WARNING, "Read nothing from file "
> 
> I would keep this log at the same level than the < 0 condition.
> It seems the same type of error.
> 
>>                                         "descriptor %d", events[n].data.fd);
> 
> And avoid splitting the format string.
> 

Ack.

> 
>> -                       else
>> -                               call = true;
>> +                       }
>> +                       if (bytes_read <= 0) {
>> +                               eal_intr_source_remove_and_free(src);
>> +                               return -1;
>> +                       }
>>                 }
>>
>> --
>> 2.52.0
>>
> 
> Except those nits, the fix looks correct.
> 
> Acked-by: David Marchand <david.marchand@redhat.com>
> 


Thanks David. I will make these changes in v3.

> 
> 
> 

