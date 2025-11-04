Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FAACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06B440651;
	Tue,  4 Nov 2025 15:31:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 565D040269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762266704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKdMe0LCGkD/53xuvD1sAdIi6xl//fohWMulqyGmw6M=;
 b=JvRmpt8F2cTu7GqHOk6vVlClGdQQH3S5nPGYUF6wfIJCiC0p4612dhNeBZ16AZstJtwtPa
 ekiCurZDqd0TPPAqA7zTSox72IoudTkoXj8pqvPbAfOc0tyoXaISX6FYU0YHm341QcQ5Rf
 J/mANfE5BLaCzq68AGwyJPxGB8EbS5Y=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-B___8toYP8Ka2zQB6zdeQw-1; Tue, 04 Nov 2025 09:31:40 -0500
X-MC-Unique: B___8toYP8Ka2zQB6zdeQw-1
X-Mimecast-MFC-AGG-ID: B___8toYP8Ka2zQB6zdeQw_1762266699
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-37777da28beso35950651fa.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 06:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762266698; x=1762871498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKdMe0LCGkD/53xuvD1sAdIi6xl//fohWMulqyGmw6M=;
 b=p2RSiIMfpEabmG2dJdkDuIXhzR4BoGtUK/W6MF9BM6RPAZvBhcBogBZpxbwtqaWikC
 BVMJi39puGVU8Pns1JzJu6RxPCcGrTtAFwMpygApmUeqWfkolO6e3vv26Mbc4Wu3pzIm
 CfNZonqj8z8ZKA3B2FHV3DvkJG51Ud9G52N/UVKVMP/6B0n+V94sRjiLjhaC00WC9jCV
 BSPfY9LWiTkk7++ilcCQ82aw3B1T2gnaQy78gTAMEjLMg99gXvpKBxepN64nIDNlrCCT
 bWe/CAs7EHQrQWvtGFAgMzYI98OsQ1FyaolRZxTzgX9tt7Y/svr5doUWPzumFYPXLxjJ
 ZYZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO4dSNIQdXeJ0T1KHuRiMqObXJ/FIPRvD602Kj5BEJZBw1Wi28gGAFdCnnuDXtuImjLRU=@dpdk.org
X-Gm-Message-State: AOJu0YysZ5LduTnLlKyzteRiD67tubFtt6Ake5u5H4rbLja8tDD0zE+P
 3nCNajEECtUaXlaIbvpNDEWZtV2kRk2lCGd5isglhoBFQX6XylHOKzpEba8TPlazcLL+m7Q19ns
 q5YF2sdrwxTlF07hw5azv1ENSvce0ab5uFezzf2Em1L8xNXmBh4FrDvLxiAq4I2J42mJc5tpFyl
 Uo8ZczEQSLqVZDhakX4Gk=
X-Gm-Gg: ASbGncv4K3PV8vaHI5N2MP47Gs9BCxQZW6/qKsHp3bmns8cylaYDcUpxzVpSabOcpsK
 4WgoZYJlze/47oJ9st7hyoRwXmNoCL9OJgquthZ6Hxg6aZFkeZD4S+uYyi6+DpcxqaaIFmIMsDT
 2fCpPDl7RR0ltjSoYSEKjKNULShmZwJ5ptv642LEVZOs5wD7KGtyn/jg==
X-Received: by 2002:a2e:ab1a:0:b0:37a:389d:5dae with SMTP id
 38308e7fff4ca-37a389d6060mr18100351fa.31.1762266698477; 
 Tue, 04 Nov 2025 06:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsxZ/XHmE+6iRXUB4GFi6QQ/8BBcoYCnl4E9MV3EBv6ObVrq6d4R2MExOxEEUHkkzy+6iHcbLEHhtWeQmshNo=
X-Received: by 2002:a2e:ab1a:0:b0:37a:389d:5dae with SMTP id
 38308e7fff4ca-37a389d6060mr18100281fa.31.1762266697975; Tue, 04 Nov 2025
 06:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <d1f2634a-7c8c-4d3f-9578-dfc80ce504aa@huawei.com>
In-Reply-To: <d1f2634a-7c8c-4d3f-9578-dfc80ce504aa@huawei.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 4 Nov 2025 15:31:26 +0100
X-Gm-Features: AWmQ_blGV9wWkFZd6b_qmXqL0l0P6Ut2nxlmO3prWFI34RyuaC-rtC4lUHgnFcI
Message-ID: <CAO55csytvDfOi9MbUn-WUyC9-Dx-1n1MNJyijfHhZK7M10wQVw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix use-after-free race during cleanup
To: fengchengwen <fengchengwen@huawei.com>
Cc: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 David Marchand <david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4KC3x7lLbiJtDqAX-npjrsXkzNY3KaoAODqmcqbctyU_1762266699
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Shani,

Thanks for the fix, more comments below:

On Tue, Nov 4, 2025 at 10:50=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> On 11/4/2025 4:09 PM, Shani Peretz wrote:
> > This commit fixes a use-after-free that causes the application
> > to crash on shutdown (detected by ASAN).
> >
> > The vhost library uses a background event dispatch thread that monitors
> > fds with epoll. It runs in an infinite loop, waiting for I/O events
> > and calling callbacks when they occur.
> >
> > During cleanup, a race condition existed:
> >
> >   Main Thread:                    Event Dispatch Thread:
> >   1. Remove fds from fdset        while (1) {
> >   2. Close file descriptors           epoll_wait() [gets interrupted]
> >   3. Free fdset memory                [continues loop]
> >   4. Continue...                      Accesses fdset...   CRASH
> >                                   }
> >
> > The main thread would free the fdset memory while the background thread
> > was still running and using it.
>
> Who will free fdset memory ? I check the lib/vhost/socket.c and found the=
re are no explicit free.
>
> I think it maybe the hugepage free because the fdset use rte_zmalloc(). I=
f it's, please explicit
> add it into the commit log.

I agree with Feng, it would be good to provide more information on who
is freeing the memory.

> >
> > The code had a `destroy` flag that the event dispatch thread checked,
> > but it was never set during cleanup, and the code never waited for
> > the thread to actually exit before freeing memory.
> >
> > This commit implements `fdset_destroy()` that will set the destroy
> > flag, wait for thread termination, and clean up all resources.
> > The socket.c is updated to call fdset_destroy() when the last vhost-use=
r
> > socket is unregistered.
> >
> > Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
>
>

We also need to call fdset_destroy in vduse_device_destroy() if it is
destorying the last VDUSE device.
We might need to add a counter to struct vduse to know whether this is
the last device.

Other than that, the patch looks good to me.

Thanks,
Maxime

