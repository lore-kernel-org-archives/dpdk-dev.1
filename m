Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D4CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02E3D40A75;
	Thu,  6 Nov 2025 08:13:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 893634013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762413226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4CDFso4DWEA0p3asJOxSu4/nTltZor5mW3kXVzoiM=;
 b=GVW49TlxVmHNU/v95teKxA9PrtxgRtHcE1P9yBlCkKJUjvhUt3P7rD1amvbP+wda0hMW8c
 f5DDZL/DziC/PkOddTA1JnaINp5VPAczJrvyF28gFdYSRObFaqLYh3J6t5DE+hm4Z/V1Cs
 PEiT0vktskJ7LIzY0U4/MpUH/MdIx50=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-0D3r4awOONiOyp8Ngwg4EQ-1; Thu, 06 Nov 2025 02:13:45 -0500
X-MC-Unique: 0D3r4awOONiOyp8Ngwg4EQ-1
X-Mimecast-MFC-AGG-ID: 0D3r4awOONiOyp8Ngwg4EQ_1762413223
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-592fd238f0eso1048249e87.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 23:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762413223; x=1763018023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zy4CDFso4DWEA0p3asJOxSu4/nTltZor5mW3kXVzoiM=;
 b=xLhE1l1oyWs8BjB9IuEPnNvm0Tu8ZDfoSZCnW/b6NRTzGR9zt8nTJDPZZo/C8qiE0U
 H6q1pY/YYGm8nXRfbWsVNSUzR+arO9QZQNFGDIctS5ofuTM2m7vnsPM/RQ/+XMv4C/7U
 mK/jALfpM3idTKseWyeDm1e31gcOatCP18iXR5TYog2bxgDlwLKrxVZNhY+EfPk3ELrD
 +OTxMPuYlsapnGau21wGlIUIGpYl6Wpnggtvg/2jU9XYHHvoG6rMpZmb7dq+9ZcMAc/C
 Yxn5bYh/cBtEujn7iKvJi3FGVPOgTgfyBe7+/XfKcV+L0MkllZwFP6LUTJvTzcnv6dOs
 F0Ew==
X-Gm-Message-State: AOJu0YzjgzZsBOe48CP6Z5qMJMBOnSht2YfqOYF+OkY+iO5lLm47BBfS
 m1TTNGTFWQ064KTJrDbOG0Efax79UrpZa6K+nBDhgHPLayjp5lmGwcDejB/6U1PqDM01hrPHpFr
 UqiyK1a7ZlW7OaLs7lYcsjPBsewLVCVxP1ZWpX2REU5VofQpQ+s8lfNGC2upEzc6CQnmitDz/yQ
 AeWDLXSzvFH7rWmAAHC+4=
X-Gm-Gg: ASbGncuc9J/608Mrav25TDUeTAxb2iMx8mVh9/8UeqHkd5Vq5i3L7TbfI/wA6i4TMQA
 NLW96SC+sjjZZEBRWGcpyxjdvF9LgVyqmhd2aICLLoIO9kenfU3e53Y6jmzA3DuNa9mVSl1H4pp
 Ku49NIY3q8GS4o3tN7DHT3JsM1Nhy0pW8F9EL+8O2t319GZQLc6b2IE44S4g==
X-Received: by 2002:a05:6512:a93:b0:592:f7ee:6dcf with SMTP id
 2adb3069b0e04-5943d55ddc9mr1831022e87.9.1762413223227; 
 Wed, 05 Nov 2025 23:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2rMr8oAOTITvMqq92gWc7mQXooA0dKrGW6CJigMGg7Z3vtCyUqyIlTw10S7V0QXQaJ/Y7CZqWYhDkhnrlbu8=
X-Received: by 2002:a05:6512:a93:b0:592:f7ee:6dcf with SMTP id
 2adb3069b0e04-5943d55ddc9mr1831017e87.9.1762413222807; Wed, 05 Nov 2025
 23:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20251105084309.3851898-1-david.marchand@redhat.com>
 <20251105084309.3851898-2-david.marchand@redhat.com>
 <f7t346sm8b6.fsf@redhat.com>
In-Reply-To: <f7t346sm8b6.fsf@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Nov 2025 08:13:30 +0100
X-Gm-Features: AWmQ_bm6ctEo3y-IwXZh2LO2d4lr-mSw4NNlZdx-XzkHuQmoPzZMhdcJOHEBlHE
Message-ID: <CAJFAV8xXHdcS0kiwLc1RCJnZw4rs-b8p=Mho4OUGC8Tvss3e-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ci: add dependency in GHA for AMD uncore power driver
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, sivaprasad.tummala@amd.com, 
 Michael Santana <maicolgabriel@hotmail.com>, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QrFLZdLNWj8NIdSRtcJ9T6JLFmqHeYmGxFtf46LPSt4_1762413223
X-Mimecast-Originator: redhat.com
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

On Wed, 5 Nov 2025 at 23:19, Aaron Conole <aconole@redhat.com> wrote:
>
> David Marchand <david.marchand@redhat.com> writes:
>
> > Adding only for Fedora, as I could not find the library for Ubuntu.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Agreed - I didn't see anything (well, there are ubuntu repos that mirror
> the EPEL repositories, which is strange to see - but I don't think
> they're installable).

If someone knows better, we can enable for Ubuntu builds later.

Series applied, thanks for the review Aaron.


-- 
David Marchand

