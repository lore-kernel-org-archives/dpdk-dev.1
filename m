Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D496CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 01:40:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D0954029C;
	Mon,  1 Sep 2025 03:40:40 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id DC67E4028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 03:40:38 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-77256200f1bso385378b3a.3
 for <dev@dpdk.org>; Sun, 31 Aug 2025 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756690838; x=1757295638; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLPa+TPlxQr4BxTBnsnXq6Vk/HBUsOXqPD0Cjm/aUmU=;
 b=Y0dfyfWp2K7+Bm4x5Sc80CEiWCv2c+ls3LenTLJTkig9XGXTQtvSQagXQyQTpSXuBv
 oev6bPfIA32vUPWVG+qJfND3O59JaDBPZgmNsBh7il6kw1SamhoRhZjtSMA+ZC2mYNLS
 hZxkWS34TMKxupdrsvUgZCl8u2chEzZzjtd/Wob1jobVyIRAYmVgHAX01tc3mJyEB8H3
 9PiXE1FGuiv7qbZbp4jFzxzl5y39R4BlHOX8yqyDK9AyWSlbocJoyHO5f0wudZkWat9X
 3jaqcGoRuhLy02tiW6flWAy1w13SLgClPV7zw9ppPl6sFdXw/lrLKxDVl2a2CMCxhBhX
 zCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756690838; x=1757295638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLPa+TPlxQr4BxTBnsnXq6Vk/HBUsOXqPD0Cjm/aUmU=;
 b=GIeHGpCEsy64IVHZwLw55bLhtE1GjlTkMqDbU/2aTIwBOA3CI+7i7kFgW+RJB5LhhR
 Fl1LvXwgZMFvL2EyxkonjsouYRktxqG5X8E22kBncRTNlvKNR+iYr8wPNhZprSSQpQdS
 L7FvDIOMIF32tjbs5JozPb92e6gcufxUlt2m77nJDxrK5ZCEqVYEIXW2MA5dZeTFl/hb
 GDnE3muxmQC0yeOI4c/s0z0Bl9ecXbAlaVe6pC4XCh7N+xKiYkfevzt8UDvsjMFD8Xmy
 +rqDzYMArrbrKM3ttqjTa+kzGoe+USHKhq0ycS4PUP4AdcHOjBMj9SeTCicTWB4KSpZ6
 RO8w==
X-Gm-Message-State: AOJu0YzRImSlYnEZtQRxggBDI036vP/aj5JMLcIHxIRnhh126q6bC6Mu
 FeF6Xd+epbWWskOv9HTy8fSbLbGJ/gXtrnupiya7BHDcWo6lmjabbbV4
X-Gm-Gg: ASbGncv1fdUaucy6vq+hAqf0dDEPaPH09/rA68b/9N477AVpX9Gq/aMHU3D7ze1vpQY
 M81D18v1baUtNmSTKOKnNOmVp1OkMW9CmagPqhmWceTz0qpT65+zQ64J2PqO6L20gIMfmmNVOsy
 a6XNbiUf9d37fJlbrKosKkxgP3jzPJcvxA2yqVpGG/fXRISAYS1KznTZAJ7QaKcremo15FExW5p
 pPNn7zjkz69k0z/Mb/Y6WN1zTM6UiLXkrWk8x1Qa7KI8kiz3Him3sqa6tSJZ8OEoxFAKcZL6XN7
 hQTBEiy4mAf8SymPdwhMwfzW8nfsjy6C9WNEMYM89Jdlu3lzVBSYCXBPMPAW/gh6Blsecd+7tw4
 IchifblsCIdEAZGAxyVg2zYfJ2ApBE4jqd5DbfNsuQoR76oKMW8Q5Gy7dgA==
X-Google-Smtp-Source: AGHT+IHKCvhUhUsxcIfjTGHhHaT06tw5g284Vakf435WEnujXGNdYGc21DSXcK46hG+ZsOgASaVtmg==
X-Received: by 2002:a05:6a00:ae12:b0:772:4200:a20e with SMTP id
 d2e1a72fcca58-7724200ae32mr7894696b3a.24.1756690837780; 
 Sun, 31 Aug 2025 18:40:37 -0700 (PDT)
Received: from [192.168.31.142] ([125.120.234.137])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26a3e3sm8984110b3a.13.2025.08.31.18.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 18:40:37 -0700 (PDT)
Message-ID: <f9547bec-3ef8-46d9-92dd-94e2d9c81940@gmail.com>
Date: Mon, 1 Sep 2025 09:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20250829125734.7fd3aae2@hermes.local>
 <4699661b-3c78-4be6-a743-5f02f3da7e7c@gmail.com>
 <20250830202152.5d3c859e@hermes.local>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <20250830202152.5d3c859e@hermes.local>
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

On 8/31/2025 11:21 AM, Stephen Hemminger wrote:

> On Sun, 31 Aug 2025 08:55:59 +0800
> Moses Young <mosesyyoung@gmail.com> wrote:
>
>> On 8/30/2025 3:57 AM, Stephen Hemminger wrote:
>>> On Fri, 29 Aug 2025 22:49:52 +0800
>>> Yang Ming<mosesyyoung@gmail.com> wrote:
>>>   
>>>> The current implementation hardcodes the socket file path to
>>>> /var/tmp, which has two issues:
>>>>
>>>> 1. Hardcoding absolute paths is not good practice.
>>>> 2. /var/tmp may not be writable in containerized or restricted
>>>>      environments (e.g. when the filesystem is mounted read-only).
>>>>
>>>> This patch replaces the hardcoded path with a socket file name
>>>> (MLX5_SOCKET_FNAME) located in the DPDK runtime directory
>>>> returned by rte_eal_get_runtime_dir(). This ensures the socket
>>>> file can be created in both normal and containerized
>>>> environments, while maintaining uniqueness by appending the
>>>> process ID.
>>>>
>>>> Acked-by: Dariusz Sosnowski<dsosnowski@nvidia.com>
>>>>
>>>> Signed-off-by: Yang Ming<mosesyyoung@gmail.com>
>>>> ---
>>> Rather driver specific logging, why is there not a way in EAL log
>>> library to ope a diagnostic dump.
>> Hi,
>>
>> Thanks for your comment. This patch is mainly an adaptation for
>> our product, which runs in container environments with read-only
>> filesystems. The goal is simply to remove the hard-coded /var/tmp
>> path while keeping backward compatibility with existing test cases.
>>
>> I agree that having a generic EAL facility for diagnostic dumps
>> would make sense in the longer term. However, I believe such
>> further development should be handled by the mlx5 driver
>> maintainers (Mellanox/NVIDIA), while this patch focuses only on
>> the immediate portability fix.
>>
>> Brs,
>> Yang Ming
> The point is other drivers have the same container problem.
> And would be good to follow conventions that containers impose.
Hi Stephen,

Thanks a lot for the feedback and for pointing this out. At the
moment, our products is using Intel and Mellanox NICs.  We only
observed this container filesystem issue on Mellanox NICs while
the Intel driver works fine, so this patch is limited for now.

I fully agree that a more generic EAL-level solution would be
better for the broader ecosystem and future-proof for other
drivers as well. That seems to need wider discussion and input
from maintainers, but I'm glad to support or test if such work
is started.

Best regards,
Yang Ming
