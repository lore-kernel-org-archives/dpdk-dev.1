Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E240E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 14:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B69402C6;
	Thu, 19 Feb 2026 15:44:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A2361402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 15:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771512273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ztx3sQ9fxBvNHGWk3LOrfWGirScHr9imvSCFdzEh3JQ=;
 b=VX+DQ3lzI3zX3mhZgzZQdC+On4FkGLSYwWcAxn8HvRoDwV0D05umE/I/swl9pAH9K9Ws0m
 tIRXnPsHu0T2/GdLIA7kZ9yLIPxK+5vXciJ+1eluYc/f7KMrU596kB6N06TA2xDGadyrE1
 LQRiIyMvB9twgz5P70sEv+TDOVJIMxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-oTmPggCxMBOYaO-LVKlCKQ-1; Thu, 19 Feb 2026 09:44:32 -0500
X-MC-Unique: oTmPggCxMBOYaO-LVKlCKQ-1
X-Mimecast-MFC-AGG-ID: oTmPggCxMBOYaO-LVKlCKQ_1771512271
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48372facfedso15077775e9.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 06:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512271; x=1772117071;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztx3sQ9fxBvNHGWk3LOrfWGirScHr9imvSCFdzEh3JQ=;
 b=j7+f/FL3/I1JsyxXefxWp23R+iPtnyDp0/MMPJrQVkZLChWvi5mOwZfo6d/hK6PWf/
 W1eqPD8AyzLaib0ivKv+msjzS0pxroKOCvKIiDgSyvvDzmpMGi/M3YZN1dap6+Dnxcz5
 4tWQxiZtjMDR2XpQ5mUDsAnsXmILj4Q2ohTM8VMIsEm560Img68mDIYscVNPMnFaJtU4
 YvnTEIcCK430rR1lUoNddl+vgtPCCXB3WVKsPVVWyjag0LF5i18F3FtJTmIbXhawj7Dl
 vwtK15tKgEVMBIrT37MUpMIcWiJ4X3hVl+2+c3Ls3YZeM2/SK/8CuX8eVGYHvwc5seb8
 CWAw==
X-Gm-Message-State: AOJu0Yw/hsN9Kj4mHHSi/ayh0qDOCDFHbXe1Vg+JP/7w0Tp/bAal8PYU
 ShOf6iljBUM+wfwOH/Qg4g5IE9kBUDLE7HBSAIVVsioEMJ/8uRq1VgfUA1OjahjudNPlJT3sY25
 EillaDOa7WTtrDltn2TLxxtdH0/np0v6/58uwA+txstrh
X-Gm-Gg: AZuq6aJkHHgCc5T0fuXgc0gobEo4ST62/7r1cw13wToBwWm4bnUkkzSxAKazje3Cupd
 ebHq+0X1/X40Svp1IdgrNgjeQzc3PSIQqcTmOdnc5sXX54fWgzqAQO15CTKyY1e8bebR2cDoCBk
 ZjEUc25Y40Bc1x8A4qbjLiYiTySJicsQ7V4q2EkFHzoFIh/5wib5+GTaNGEspFNS3TpFvOCwtM7
 XsKL9n7brLg2zbn4Zsmp3wvwTjEpC/uFb0HOHrs/BHSUIa77mGkkUSdXESLglP4cwON7lN3fcep
 BEQQGVkv1ugPZhwrm0LDiTABf5c8KPxgoK1ybu3c91SmYwYZ6jJCgTOeJd9boURo7URR5qB7Xe6
 28TaaY6lZv+M5xzzB2dxisQ==
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-4839fe90522mr29037545e9.3.1771512271294; 
 Thu, 19 Feb 2026 06:44:31 -0800 (PST)
X-Received: by 2002:a05:600c:214b:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-4839fe90522mr29037115e9.3.1771512270783; 
 Thu, 19 Feb 2026 06:44:30 -0800 (PST)
Received: from [192.168.0.56] ([78.16.129.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b1d79sm21327665e9.3.2026.02.19.06.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 06:44:29 -0800 (PST)
Message-ID: <ea84acc6-35e1-409d-9977-a7b013ab2585@redhat.com>
Date: Thu, 19 Feb 2026 14:44:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
To: Slava Ovsiienko <viacheslavo@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Harman Kalra <hkalra@marvell.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-2-ktraynor@redhat.com>
 <20260206220939.5a90c67c@phoenix.local>
 <dd9faf73-b153-42b8-a42c-418bf22fe1f6@redhat.com>
 <DM4PR12MB60872D62FD8A3616C69E7BFCDF62A@DM4PR12MB6087.namprd12.prod.outlook.com>
 <fdf1a6ed-4505-4170-bb02-ea6104ab445c@redhat.com>
 <DM4PR12MB6087DD2EE1DB24F3A0BE51EADF62A@DM4PR12MB6087.namprd12.prod.outlook.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <DM4PR12MB6087DD2EE1DB24F3A0BE51EADF62A@DM4PR12MB6087.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ikJAoty8xeWGwGhbjBpxustDA4IShAFY1FujISwBYNM_1771512271
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 10/02/2026 20:58, Slava Ovsiienko wrote:
> Hi,
> 
> What about checking EPOLLERR | EPOLLHUP | EPOLLRDHU flags for specific fd in mlx5 habdler?
> 
> if devx_get_async_cmd_comp() returns EAGAIN {
>    if no data were read {
>     call epoll_wait() for specific fd and zero timeout
>     check EPOLLERR | EPOLLHUP | EPOLLRDHU flags
>     if fd is in hanging/error state {
>      - remove handler 
>     }
>   }
> }
> 

Thanks for the suggestion. We already have this info at the time of
callback. So I added an API to get it and made it os agnostic in v4.

Let me know if you have comments or suggestion. Thanks!

> With best regards,
> Slava
> 
>> -----Original Message-----
>> From: Kevin Traynor <ktraynor@redhat.com>
>> Sent: Tuesday, February 10, 2026 9:08 PM
>> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Stephen Hemminger
>> <stephen@networkplumber.org>
>> Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
>> <thomas@monjalon.net>; david.marchand@redhat.com; Dariusz Sosnowski
>> <dsosnowski@nvidia.com>; stable@dpdk.org; Harman Kalra
>> <hkalra@marvell.com>
>> Subject: Re: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
>>
>> On 10/02/2026 17:05, Slava Ovsiienko wrote:
>>> Hi,
>>>
>>
>> Hi Slava,
>>
>>> I'm sorry, I have some concern about the patch.
>>>
>>
>> No problem, that's what reviews are for :-) thanks for reviewing.
>>
>>> How it works, as far as I understand:
>>>
>>> - DPDK simulates interrupts in user mode with epoll_wait()
>>> - mlx5 PMD emits the async counter query command to the NIC
>>> periodically
>>
>> I didn't think this would happen unless there was something like hardware
>> offload, but regardless, yes I agree there may be async counter queries.
>>
>>> - there might be multiple async query commands in the flight
>>> - kernel drivers handles the async query completion interrupts, pushes
>>> the token to the internal completion queue and unblocks associated fd
>>> - epoll_wait() sees this unblocked fd and notifies mlx5 PMD about
>>> - mlx5 PMD reads the completion token from the kernel queue with
>>> devx_get_async_cmd_comp()
>>>
>>> The concern scenario, let's assume:
>>>
>>> - we have 2 async query commands in the flight
>>> - the first async query completes, fd is unblocked, PMD is inviked,
>>> the completion is read by PMD and is being handled
>>> - the second async query completes, fd gets unblocked, the second
>>> token is written to the queue
>>> - the PMD completes the handling of the first completion and reads the
>>> queue again (with devx_get_async_cmd_comp() call in the loop)
>>> - it reads the second token successfully and handles
>>> - then, on the third call, devx_get_async_cmd_comp() returns EAGAIN,
>>> it means queue is empty
>>> - DPDK calls epoll_wait() again and sees unblocked fd
>>> - it call mlx5 PMD, and it calls devx_get_async_cmd_comp(), but queue
>>> is empty (handled in previous interrupt handling)
>>> - with the patch we wrongly remove the handler
>>>
>>
>> I'm not sure, but this ^^^ sounds feasible.
>>
>>> In my opinion, we should handle flags EPOLLERR | EPOLLHUP | EPOLLRDHU
>>> from the epoll_wait()_return also for RTE_INTR_HANDLE_EXT and
>> RTE_INTR_HANDLE_DEV_EVENT interrupt types.
>>>
>>
>> That's exactly what I had in v1 of the patch! The issue is that some clients of eal
>> interrupt may not interpret the condition of EPOLLHUP/EPOLLRDHUP as an
>> error condition and/or want to do some special handling.
>>
>> The example is vhost user server, which puts in place a reconnect mechanism. If
>> we filter out EPOLLHUP/EPOLLRDHUP events in eal, then virtio will not receive
>> the callback and vhost server reconnect is broken. I have some more notes
>> about it in the cover letter.
>>
>> Trying to base on the read pattern in devx handler was an attempt to move logic
>> out of eal so different handlers could be flexible in how they handle this
>> condition.
>>
>> We do have a distinction in that mlx5 uses RTE_INTR_HANDLE_EXT and virtio
>> uses RTE_INTR_HANDLE_VDEV but i'm not sure that is generic enough to base a
>> check/don't check for EPOLLHUP/EPOLLRDHUP events on.
>>
>> So we'd need to come up with another solution if we wanted to filter this in eal.
>> Let's think more on this, though we are a bit constrained by public API as well.
>>
>> A workaround we can do from application is David's hack™ "-a 0000:00:00.0"
>> to skip initial probe. That will at least prevent the issue for mlx devices not used
>> in DPDK, which was the scenario reported.
>>
>> thanks,
>> Kevin.
>>
>>> With best regards,
>>> Slava
>>>
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kevin Traynor <ktraynor@redhat.com>
>>>> Sent: Tuesday, February 10, 2026 5:06 PM
>>>> To: Stephen Hemminger <stephen@networkplumber.org>
>>>> Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
>>>> <thomas@monjalon.net>; david.marchand@redhat.com; Dariusz Sosnowski
>>>> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>;
>>>> stable@dpdk.org
>>>> Subject: Re: [PATCH v2 1/2] net/mlx5: check for no data read in devx
>>>> interrupt
>>>>
>>>> On 07/02/2026 06:09, Stephen Hemminger wrote:
>>>>> On Fri,  6 Feb 2026 17:20:53 +0000
>>>>> Kevin Traynor <ktraynor@redhat.com> wrote:
>>>>>
>>>>>> A busy-loop may occur when there are EPOLLERR, EPOLLHUP or
>>>> EPOLLRDHUP
>>>>>> epoll events for the devx interrupt fd.
>>>>>>
>>>>>> This may happen if the interrupt fd is deleted, if the device is
>>>>>> unbound from mlx5_core kernel driver or if the device is removed by
>>>>>> the mlx5 kernel driver as part of LAG setup.
>>>>>>
>>>>>> When that occurs, there is no data to be read and in the devx
>>>>>> interrupt handler an EAGAIN is returned on the first call to
>>>>>> devx_get_async_cmd_comp, but this is not checked.
>>>>>>
>>>>>> As the interrupt is not removed or condition reset, it causes an
>>>>>> interrupt processing busy-loop, which leads to the dpdk-intr thread
>>>>>> going to 100% CPU.
>>>>>>
>>>>>> e.g.
>>>>>> epoll_wait
>>>>>>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1)
>>>>>> =
>>>>>> 1 read(28, 0x7f1f5c7fc2f0, 40)
>>>>>>    = -1 EAGAIN (Resource temporarily unavailable) epoll_wait
>>>>>>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1)
>>>>>> =
>>>>>> 1 read(28, 0x7f1f5c7fc2f0, 40)
>>>>>>    = -1 EAGAIN (Resource temporarily unavailable)
>>>>>>
>>>>>> Add a check for an EAGAIN return from devx_get_async_cmd_comp on
>>>>>> the first read. If that happens, unregister the callback to prevent looping.
>>>>>>
>>>>>> Bugzilla ID: 1873
>>>>>> Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
>>>>>> Cc: stable@dpdk.org
>>>>>>
>>>>>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
>>>>>
>>>>> AI spotted this, I didn't...
>>>>>
>>>>>
>>>>> Errors:
>>>>>
>>>>>     Line 139: Unnecessary semicolon after closing brace
>>>>>
>>>>> c
>>>>>
>>>>>    };
>>>>>
>>>>> Should be:
>>>>> c
>>>>>
>>>>>    }
>>>>>
>>>>>     Lines 142-146: Block comment uses incorrect style Block comments
>>>>> in C
>>>> code should use /* and */ style, not /** which is reserved for
>>>> documentation comments.
>>>>>
>>>>> c
>>>>>
>>>>>    /**
>>>>>     * no data and EAGAIN indicate there is an error or
>>>>>     * disconnect state. Unregister callback to prevent
>>>>>     * interrupt busy-looping.
>>>>>     */
>>>>>
>>>>> Should be:
>>>>> c
>>>>>
>>>>>    /*
>>>>>     * no data and EAGAIN indicate there is an error or
>>>>>     * disconnect state. Unregister callback to prevent
>>>>>     * interrupt busy-looping.
>>>>>     */
>>>>>
>>>>> Warnings:
>>>>>
>>>>>     Logic clarity: The variable data_read is set to true inside the
>>>>> while loop but
>>>> never checked when data WAS read. Consider if data_read is the
>>>> clearest way to express this condition.
>>>>>
>>>>
>>>> Ack above. Thanks.Will be fixed in v3.
>>>
> 

