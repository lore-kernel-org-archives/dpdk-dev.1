Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7DD73E86
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 07:03:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 348184066B;
	Mon,  2 Feb 2026 08:03:06 +0100 (CET)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by mails.dpdk.org (Postfix) with ESMTP id 685FA40285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 08:03:04 +0100 (CET)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5664340e14fso1194897e0c.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 23:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770015783; cv=none;
 d=google.com; s=arc-20240605;
 b=CH0NDtRdm3zjoLaqWwy2QuzRgV6+oSz3ZTbwd9WWkzmSlJTelSbmDy/DRtS6PdJdDH
 6m+XG9IaKCNwBiikonwZqa/GnnKgYGEdA0kpWrEBHFTAGPHZXur0YmFYh30wHTv+GmWG
 NRnt67Op4RhDODXPVm21fLmyH1tMXfZDAl65FJmkzxOEB6UOWwox+S3HqY8khXU6j27Y
 IrxVjorMFln8WTA+iLk4QN/eEkPjhGwyd8Rha688/xPvvEpHcW/C6cgSqMj9VRiaFR9h
 mkFU6Wea7Bbj7z7RSRo7es3Dnf2oR8ylSROo51HXXY9uCavNhrk5V5h21HoYKdhmSeCt
 M54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4+h0YGKsP+DsznbFcjJpkg6AtZbGcYWTbuAfOwbkMSg=;
 fh=+L1L+ZHbKjrb2f5CsW4olkadjYbHjR06LFcqyhSoUu4=;
 b=jogIFUNlYhSsYVtNkKIQ4m7DVM0arm+xBo+dPuUkBmoa+OMZBqQpXhSYCJuIOw2/zE
 zp4JM/XCc9nntShTo4q6nPUx+R8RBzAUW6NemtWGdNQxcuOnIvtROGsIJPBVPS3G7d3z
 pg8xVYGrQtAP0Cjyk1hhAAffHM1Wg6hN+jKavfGQn1O7VxAOWyeSFnI3Htk1p4YgCxGH
 wLQBAFVvEG241U9pPo54TS4XuSQc5oK04GUiOZMZL3DSgIHbfydtKSgSZ+uDSfjETxao
 9wzwjnlSJNBWmHyHh7qSq0fsLakmOGwYW9EWvuSACxhmt2/wumlMWINZYstUNcwBR4B5
 WB8w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770015783; x=1770620583; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4+h0YGKsP+DsznbFcjJpkg6AtZbGcYWTbuAfOwbkMSg=;
 b=LYkgPN3y0IZji/zKXVzF8ivutP1TKOHyqdtzg6RXX5Dt4+GKvCx86p6IRyVR2yegMG
 8kfWy3fBjfz/ynjNNafOBzmpSzffexc9OYmEQeWD3GGw0W2wHNQo/oiYE8e9CY+MZ627
 bz1G9gI1UUyLrPJICIM23hKJABBjSmBTtbrMZulYAc1aoN6yxdtNByFD+y90Vkmalg++
 71JSsuGqP3k4B36AwkRqexAE/4pkU+s4NkkzLMbXekNdf8MY/9BjucCx1ok6eRo+T5NV
 anYtlu0a+QEHN+xGfx95HdKxeB9ywHr301P9iYyifWNP0rYDQgbtV2g3us6xZkDmZ2JH
 delg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770015783; x=1770620583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+h0YGKsP+DsznbFcjJpkg6AtZbGcYWTbuAfOwbkMSg=;
 b=t89k1dCCTmRCM5cK6VFycl/iJP0OuXerdS7sHFwBJ2vv8BffcL8jo/xp6PcFdj5gra
 fKS+LiUZQ5V+JT60aPOuflSxDoiuLf4KdbhP2ci1L1zPd161051ZBxoFsh7FKv5hs1Td
 pS9NaYIzACk1CQE86zHAmvvGUep2Rg8U92Edvxa2c2tJKqgs7AARpJDVoSiT0BLVsd3S
 G+/BqNlvFs6tgjoo3khafKNz4hmTun8YJ8a23bo12RImVpFOn1hEHb9RNQrIaKAqSq97
 GIcO+8PbpbqA7enjqcIh++EvcGZ2AN78RUkW3/goo4bGzEiV6frFuS1PbQ4+QZUcNewx
 barQ==
X-Gm-Message-State: AOJu0YzI98wIpzX2B5qYkU6t4htIe6AoP/mzoT+fRkUZ0Tyk02Q4h3Tx
 nO6QkRJJTQL3z743qzhsgFN0VoCrHwk8RLeesPW6aJdqN0tX1VPT1VENxHIFFa21PtsGv1cIqdE
 Gt6Uz7aI2sGP8WVqfbQQE5dWBW6YvsHTr7Cx0
X-Gm-Gg: AZuq6aLzHHhXeGflkWTRxVaPpz+qRfja21lDsIw5ORl/I/jMXk2wGUl9ttu/h4tEkxj
 MAy+gKQcn2kmtGlBK4mo6pxOSteQg/ssNHDNcZEr7knvbSJct2y6sZ9jh65nLksnuIo4ASSwC5k
 KFSBnxZR0SSqtkNghfTC4EOGT3XHBAHfp/mXhuwMbDI+2ee1DBhwoXNK12BkObWVVIyEEHxJw16
 pdyl6uVGOnBqOLGed20kOuj9NiHOv3eZ26rnFBNq9kVWWesumgcUDjaxWYoCx0n+jYUJ0d2LygO
 EvW2vw==
X-Received: by 2002:a05:6122:3a10:b0:563:460b:fe25 with SMTP id
 71dfb90a1353d-566a00362edmr2574194e0c.8.1770015783661; Sun, 01 Feb 2026
 23:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-2-stephen@networkplumber.org>
 <CAFn2buD=1CwnP92LGuj7fGzi_Cujnp8eTV96ZzTNKBjsA6kzOA@mail.gmail.com>
 <20260128130014.0489e0a0@phoenix.local>
In-Reply-To: <20260128130014.0489e0a0@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 23:02:53 -0800
X-Gm-Features: AZwV_QiJzE9WRTbl6bhA0BjSanEWKK9cFgSs54IcCCv9v_BJqDUU4yfBeITXaLs
Message-ID: <CAFn2buDhLQstsTxLyqsK3ZbOJG4ZgOGreKm0Lv7seieBEfJq_w@mail.gmail.com>
Subject: Re: [RFC 1/4] net/af_packet: remove volatile from statistics
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, "John W. Linville" <linville@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
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

Without volatile, is there any guarantee the consumer thread will see
the writes from the producer thread? For example, couldn't the
compiler cache rx_pkts in a register on the consumer side?
// Consumer thread:
uint64_t prev = 0;
while (monitoring) {
    uint64_t curr = rx_pkts;  // Compiler may cache in register
    if (curr != prev) {       // Without volatile: may always be false
      update_display();       // Never executes
      prev = curr;
    }
}

I created a godbolt comparing different approaches
(https://godbolt.org/z/1Gaz6jPxh) showing assembly for x86-64 and ARM
at -O3. Summary:
1. Plain load/store: Fastest. No visibility guarantees. May tear on 32-bit.
2. Volatile: Provides visibility. May tear on 32-bit.
3. Atomic load/store (relaxed): Same performance as volatile. Provides
visibility and guarantees no tearing (even on 32-bit).
4. Atomic_fetch_add: Heaviest cost (LOCK on x86).

My concern is that Option 1 (Plain) has no guaranteed visibility - the
compiler may optimize away loads entirely. Since Option 3 (Atomic
Load/Store) has identical instruction cost to Volatile but provides
formal guarantees (visibility + no tearing), would that be the
preferred solution?
