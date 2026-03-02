Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B088E9B36A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF004028C;
	Mon,  2 Mar 2026 12:41:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 61BFC400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:41:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772451668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6OhCi9U+gM0a1m4bEQ3nPBR4neyjCHTfqv/oB0UGAKY=;
 b=YNGFKQHITWGfMlcExkhyXMtQ/bqTTyn17yQElRVYjT+6uMEpVYldfQKqHUdIRrm67fZh3y
 +pemCJdpZ1sgMnzArQMFCh7m7ysPDPl8heEq/3cdW8nhGzZVX0jVLzdudk3NjXaZB1xRTe
 xv0gW2bMcbvNHsydXC6hH2tDiwobRT4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-a7IJnm3KP4WbWKTi4r-sFw-1; Mon, 02 Mar 2026 06:41:07 -0500
X-MC-Unique: a7IJnm3KP4WbWKTi4r-sFw-1
X-Mimecast-MFC-AGG-ID: a7IJnm3KP4WbWKTi4r-sFw_1772451666
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439a85831e5so1107003f8f.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 03:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772451666; x=1773056466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OhCi9U+gM0a1m4bEQ3nPBR4neyjCHTfqv/oB0UGAKY=;
 b=vli3eVZi0CfE11HyP2Q4BWvGOJ1fV9zJ+poq0NiCTXBOS+xg9N+Jm2lwUmjGdR/Vix
 LeUiC0fj5Q5vk6ZuVyG9vNp39W8zCCVteYmwO1d6vcYndwKDL96fz6PzKrJss1eNEARV
 8QLVnVNdegmt5ln/V/JLJLWqXu/cdLKGlh5zMeWZtKV0GcBic2lqLRRsQIlqH5ATfOCc
 wafC9J9nNdMFS9slMPhj6TGIb0BdqMEE754dX5bFqfBbYvdKHELm3j1THCsjUAFbYO7f
 ALeEXQfLhy+9JDzXjE2lc+guSlrxRkI6F3WLPVs8yVfS25fFVxbPYihgfsduGMGUzu/O
 lFUA==
X-Gm-Message-State: AOJu0Yx/9dicgebQavHDW8kB4fjgkh8USin5nOjI+9m0FwREQb4sgiaX
 TPM3qwtTxkrDhQltewXNCbNzZamk0fMwLnBSlV/JCj8SG2VDpNNDa7bjncycQMRc4hXdi56Oz3o
 JjsG6NGo+vkIRDcWDYncS4R81V8PQ5g/POYRY9d+ZwHO3
X-Gm-Gg: ATEYQzyrmTEOBeOcDLtgd5+CYWJkuB9O7M9c3f0X+UnBB7/0c3M+hrTo5R4LzQkMCL+
 L71C/D7+BfsXWFb0tYOgMc/FQPYTsTi9hbfQsIbKo+Co+sSXGB4twXrQwLag0k+A45vKkfx18/4
 VizEPQmb2xuKxe8cq+cbFZBkr5/Di5odhNBMy5gHf6FZDXAGdtPyWhrv+663rAfokeMy8Rh0cQd
 4pI6R7LSw+pJ+GOPKJPis6fzwq7zA9x2DbgV5n/0Wv9WR/bSEYA/5nrfSmBEp2EBcvWi2AyBT/N
 Efuom6HJFvDiaRVSg52KcT72PqUS82IBqt1aHs6Nuaj2lr+24Qm7hJYWGdJDif+FrYM5J2AUSOj
 z+OPybaPiLjMipEzFtBPyW/O+
X-Received: by 2002:a05:6000:4411:b0:439:ba4d:bf3d with SMTP id
 ffacd0b85a97d-439ba4dc1fbmr2185953f8f.59.1772451666378; 
 Mon, 02 Mar 2026 03:41:06 -0800 (PST)
X-Received: by 2002:a05:6000:4411:b0:439:ba4d:bf3d with SMTP id
 ffacd0b85a97d-439ba4dc1fbmr2185902f8f.59.1772451665806; 
 Mon, 02 Mar 2026 03:41:05 -0800 (PST)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ad3daf89sm28194751f8f.20.2026.03.02.03.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 03:41:05 -0800 (PST)
Message-ID: <af147029-820f-41b5-bb09-4e52bb7b297b@redhat.com>
Date: Mon, 2 Mar 2026 11:41:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] interrupt disconnect/error event handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, hkalra@marvell.com
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
 <20260219105252.2b807358@phoenix.local>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260219105252.2b807358@phoenix.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B_jnE6AU7SVUZF2WHbQkbk_66PVjhRqpJ2rGrY38TL8_1772451666
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

On 2/19/26 6:52 PM, Stephen Hemminger wrote:
> On Thu, 19 Feb 2026 14:38:49 +0000
> Kevin Traynor <ktraynor@redhat.com> wrote:
> 
>> These patches are to fix some issues with epoll event handling for
>> EPOLLERR/EPOLLRDHUP/EPOLLHUP.
>>
>> 1/3: handles these disconnect/error events for interrupts that are read
>> in eal
>>
>> 2/3: provides an API for interrupt callbacks to get the interrupt events
>> for the active interrupt
>>
>> 3/3: deal with the observed issue as reported in
>> https://bugs.dpdk.org/show_bug.cgi?id=1873 where mlx5 devx interrupts
>> cause a busy-loop and 100% CPU of dpdk-intr thread.
>>
>> v4:
>> Updated to allow for case where devx interrupt handler may handle
>> multiple completions during one interrupt call, leading to no data being
>> read in a subsequent call as flagged by Slava.
>>
>> - 1/3 No change
>> - 2/3 New API rte_intr_active_events() to get interrupt events
>> - 3/3 Use new API in mlx5 devx interrupt handler to detect if
>>   disconnect/error events and if so unregister the callback
>>
>> v3:
>> - 1/2 and 2/2 fix some coding nits (Stephen/AI/David)
>> - 2/2 Make log level consistant (David)
>>
>> v2:
>> - Only handle disconnect/error epoll events when the read is done in eal
>>   interrupt code. This is to allow interrupt handlers like virtio deal
>>   with disconnects in an appropriate
>> - Detect if not data is read in the mlx dex interrupt and if so unregister
>>   the callback
>>
>> Kevin Traynor (3):
>>   eal/linux: handle interrupt epoll events
>>   eal/interrupt: add interrupt event info
>>   net/mlx5: check devx disconnect/error interrupt events
>>
>>  drivers/net/mlx5/linux/mlx5_ethdev_os.c |  20 +++++
>>  lib/eal/freebsd/eal_interrupts.c        |   7 ++
>>  lib/eal/include/rte_interrupts.h        |  23 ++++++
>>  lib/eal/linux/eal_interrupts.c          | 103 +++++++++++++++++-------
>>  lib/eal/windows/eal_interrupts.c        |   7 ++
>>  5 files changed, 133 insertions(+), 27 deletions(-)
>>
> 
> Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> FYI - AI review gives long winded version of "this is patch is good"
> The only worthwhile feedback was that there should be a release note for
> a new API.
> 

Thanks Stephen. I will address this on the next version.

