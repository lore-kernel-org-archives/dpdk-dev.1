Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4DA106F303
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:49:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83D1C427B3;
	Thu, 26 Mar 2026 09:49:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8AB26402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 09:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774514987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=em67/gm1S8jHsi6fpVTcsR+k3u2u7TSAENU99Pj0MwA=;
 b=HI93KFiAafeHTP7AdmRq+uSguqCJMlnWztI78Z5fwPRwo3SwbS2WPufFrJurv2n4CQvCFl
 FJB4vZK9dUrpx03YiY0mrhCzy2aA7PXZpIfuGu7lXkUEmT6Eq9KkxzO3dQ4b0uIwQ3rIOX
 OzWrgYdP5FL/1K1WOkGIb7WvEu9A5hI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-YUMTHVwjMS2KZkoa0iHRPQ-1; Thu, 26 Mar 2026 04:49:46 -0400
X-MC-Unique: YUMTHVwjMS2KZkoa0iHRPQ-1
X-Mimecast-MFC-AGG-ID: YUMTHVwjMS2KZkoa0iHRPQ_1774514985
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so6491695e9.2
 for <dev@dpdk.org>; Thu, 26 Mar 2026 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774514984; x=1775119784;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=em67/gm1S8jHsi6fpVTcsR+k3u2u7TSAENU99Pj0MwA=;
 b=oHAeu6U2IrEE+Qw7GhIPIE15EExi/NuTy1UV1+/Lx+sMlzIYmd7VJghRSsLWuh4D92
 ElvhcXj7Ix0F0G3yZYxBIHVjqt+01X4pr4TIj71EEsUpiYTYtZMlbDNHxSmoY2A3qwwR
 qWFRG8O4A6S5QXN/eRrNrPGln0kReWiiE/6RuOaCQPLTd++JvlNHiQQg+/gyCxS5UYDN
 yyohEfPn+MEesApqf8zjwYOoFPLM6LEf3FqA7QSioNtiEOPI+W94N3ItgIv44eOhNpPm
 KNJtGvq49CoFi9TUDUmOo8HGMDEA0REyM9T4Y7oGahLnXsnduTa//ue0B6twb0Kc6nhK
 Y2Ow==
X-Gm-Message-State: AOJu0Yy/ymzdsPHxUWNmaIy1BPABO53xttmbJ3v87t3POvSw4LtzqOQG
 WTK0lGMIyLk6CWUSmAfAvKyreVq12oui5Pd87zdqBv6gSP6UDt1Vp/d5OOe7oqv9izF+/hHhiB3
 ScUVUf1jkyTesWizsSuXA3YXax8sFE9XyRC/yKt8/oRui3SjGbuon
X-Gm-Gg: ATEYQzx8Zb3ORg9I7P//wOWjhTd7dmCtwyyF/jj55FvGifM5xHyiBg9ShT7nVhGyK0n
 NZQHfJtC7pQgmCbcQdpHfw/3cnMHrTQjYatBi9tzED/JQnMmi+j0uzz9AnBigjJHrjvk/pDENBd
 VQFQxExEywDIBqa6DQaQpWsAnl9EO0gRexRs4gFmPAiLELNXu9RRH2WFB5bnlByrZN8iim83Vct
 O87qa0EYdtSHS0/8YNWr4nBQ4jOaGnqaxCb+i7tkFde/COtbtazx4oA8m+gkoGXzVNEqc+mbSua
 WkMvHIThqpA87bmjSh/fss2MwkI4O7VkdIYupQ2DR7l3/CyqoXK3qR9fn0bMuXaDYKfU6rE1HYo
 G7r8yXGpk8egLRgjjLfI8/Qgd
X-Received: by 2002:a05:600c:3b22:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4871608460fmr92767115e9.28.1774514984160; 
 Thu, 26 Mar 2026 01:49:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4871608460fmr92766695e9.28.1774514983631; 
 Thu, 26 Mar 2026 01:49:43 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9f0afsm27877885e9.10.2026.03.26.01.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 01:49:42 -0700 (PDT)
Message-ID: <b76461bc-1b61-447d-96e6-b170bcc3686e@redhat.com>
Date: Thu, 26 Mar 2026 08:49:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] bus/fslmc: fix bus cleanup
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-3-david.marchand@redhat.com>
 <0b33ca24-dce4-47f2-aacd-cb0e9ecfd5d6@redhat.com>
 <CAJFAV8zs4ToAEXq7EvvH-MEpvdrGUaEPzd1L8BQx=zmJ67iUXQ@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8zs4ToAEXq7EvvH-MEpvdrGUaEPzd1L8BQx=zmJ67iUXQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 360mBmF3N46KGw7ThBpRGETAO9beq5qmDtClH7MAYpU_1774514985
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

On 3/26/26 8:22 AM, David Marchand wrote:
> On Mon, 23 Mar 2026 at 17:59, Kevin Traynor <ktraynor@redhat.com> wrote:
>>
>> On 3/23/26 10:52 AM, David Marchand wrote:
>>> The close operation was never closing probed devices.
>>>
>>> Taking a step back, reevaluating the devargs makes no sense during the
>>> close step, as a probed device must have passed the allow/block list
>>> evaluation initially.
>>>
>>> Since the device contains a reference to the driver that probed it,
>>> simply call this driver remove op.
>>>
>>> Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: David Marchand <david.marchand@redhat.com>
>>> ---
>>>  drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
>>>  1 file changed, 4 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
>>> index 550d4e0e8d..7daa18d850 100644
>>> --- a/drivers/bus/fslmc/fslmc_vfio.c
>>> +++ b/drivers/bus/fslmc/fslmc_vfio.c
>>> @@ -1393,7 +1393,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
>>>  {
>>>       struct rte_dpaa2_object *object = NULL;
>>>       struct rte_dpaa2_driver *drv;
>>> -     int ret, probe_all;
>>> +     int ret;
>>>
>>>       switch (dev->dev_type) {
>>>       case DPAA2_IO:
>>> @@ -1411,22 +1411,9 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
>>>       case DPAA2_ETH:
>>>       case DPAA2_CRYPTO:
>>>       case DPAA2_QDMA:
>>> -             probe_all = rte_fslmc_bus.bus.conf.scan_mode !=
>>> -                         RTE_BUS_SCAN_ALLOWLIST;
>>> -             TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
>>> -                     if (drv->drv_type != dev->dev_type)
>>> -                             continue;
>>> -                     if (rte_dev_is_probed(&dev->device))
>>> -                             continue;
>>> -                     if (probe_all ||
>>> -                         (dev->device.devargs &&
>>> -                          dev->device.devargs->policy ==
>>> -                          RTE_DEV_ALLOWED)) {
>>> -                             ret = drv->remove(dev);
>>> -                             if (ret)
>>> -                                     DPAA2_BUS_ERR("Unable to remove");
>>> -                     }
>>> -             }
>>> +             drv = dev->driver;
>>> +             if (drv && drv->remove && drv->remove(dev))
>>
>> Not new but dpaa2_qdma_remove doesn't return an error which seems like a
>> bug, but it has it's own log and it's just a log here anyway, so not
>> critical.
>>
>>> +                     DPAA2_BUS_ERR("Unable to remove");
> 
> Indeed, the dma/dpaa2 driver does not report errors.
> And there is probably more to fix in the fslmc bus, as I see that the
> bus .unplug() does not check the driver .remove() return value either.
> 
> I did not dig deeper in this bus for now as I was focusing on the
> devargs evaluation.
> 
> Could you open a bugzilla for tracking this issue?
> 

Sure, I will do that

> Thanks.
> 
> 

