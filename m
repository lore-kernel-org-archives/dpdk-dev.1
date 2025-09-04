Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99DCA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 07:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FCAF40EDF;
	Thu,  4 Sep 2025 09:08:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 047AD40280
 for <dev@dpdk.org>; Thu,  4 Sep 2025 09:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756969728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0XfkV5j+7QJLpZ9xSBp4MSow11hYcpri1A6ZjggSZg=;
 b=F9OUJ2bz1rvcgznn96hDFzUHZZcUpe+2huYrGEv2eJpcouGOzCNlsZEUSGSETIH7q2Fg0L
 NRvxHht+pYaZLRQA9BGPJO3Kq/Yx2CK0409qRqHnujDWW0EpO6tn/L13cbpn8wDFm5GV9C
 hui3tUzVhZUjGLeFUwxV7gupGM8tnYM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-n3PanuuaP4WyjNtEwWX2iQ-1; Thu, 04 Sep 2025 03:08:47 -0400
X-MC-Unique: n3PanuuaP4WyjNtEwWX2iQ-1
X-Mimecast-MFC-AGG-ID: n3PanuuaP4WyjNtEwWX2iQ_1756969726
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f6af0aee6so391521e87.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 00:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756969725; x=1757574525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0XfkV5j+7QJLpZ9xSBp4MSow11hYcpri1A6ZjggSZg=;
 b=FzOXW4afSpyjXegctgRL8u+MrQFIJZ2pfRBsmemtPFTZWNVBqznTh1wgS1z5XuGzPn
 18/WnidkBgHyUZSGgcn3kcijxf4Kh0exnJP71WJP1kK/eR9jtA+dnH/GZu4gXMlQh6rg
 t7e9K7RM2xu0H2U1zXQ2ro1GWNpQSb8ZT4tjx9L7bLJoIQep5a4DTYoSR2Voly8Igw2Y
 jpCl8f+U2pFe5qiSIQomY/y3WI/5KynGUGCSlSDYZGqlYBARvzYyt32Slt9AzdksLKad
 SnfVhMOrySuq/+iZonO1vAc/3p53Md/MDreT3SodHfu1mi8G1boXZj4/ju43OiFDlt4a
 NK3w==
X-Gm-Message-State: AOJu0Yza3MeZQmOddVF6CGFUoyx2KXhXZ7GmR699t3QbkMEWsliqmSAZ
 UmTWeJZ5u4fmaGVKliWjVo/usXVq12IYEwss0ehTTe/zZhRNFZDpYORfFY0zqOF3i+rYLiV7Pbd
 d8S9pRLWOgDUJrmMH/6Zxo4O+ZNYU4ZY19C5NpUndhJKEelVxcXBZbOzmyYiyaJEoA0JmEaAveV
 HUF3A612MSSVsOYtYNOiQ=
X-Gm-Gg: ASbGncvQYF1yYPUh0pQb0GA9H99i0xJrhBoYMVHJkV9WG6HDhknYSyBh21coQRVzPqp
 rKBhGhDUjVRaEHCZgEj9Fu22T0YBJRBTbpHP6BVsvVahvsO48vtw/J6dCbp2qtXXnd/o7/EGGx3
 dcOviN8hiMoJZQBz6TctD1PLQ=
X-Received: by 2002:a05:6512:689:b0:55f:43ab:b214 with SMTP id
 2adb3069b0e04-55f708b1ce4mr6210431e87.15.1756969725575; 
 Thu, 04 Sep 2025 00:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe07FDTqfsf83ANn6eyBqomYI1kRyjVHrqv3c5VRdq132/UOSGW3Sx/6jkpan/OuOWDg9uC/BSQGN6vtsn4uc=
X-Received: by 2002:a05:6512:689:b0:55f:43ab:b214 with SMTP id
 2adb3069b0e04-55f708b1ce4mr6210418e87.15.1756969725145; Thu, 04 Sep 2025
 00:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
In-Reply-To: <20250903151800.1965006-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Sep 2025 09:08:33 +0200
X-Gm-Features: Ac12FXxgqEIOvuyR8oCydRNuEaqdLirX78EgJW-BdOGuy_tNNbwcHB1xzMGsn9s
Message-ID: <CAJFAV8zp1E2+sWzL3=8HmnOhjc_kZYEc42=Ki0gGz20K142Srw@mail.gmail.com>
Subject: Re: [RFC v2 0/9] Cleanup VFIO API and import Linux uAPI header
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, maxime.coquelin@redhat.com, 
 anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zM60h4tVxukEkrZ3Os5f3MkOmJVyZ0uJrDQ_11yB1eg_1756969726
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

On Wed, 3 Sept 2025 at 17:18, David Marchand <david.marchand@redhat.com> wrote:
>
> The VFIO headers have a number of issues:
> - showing to the world a lot of internal considerations,
> - defining macros with the VFIO_ namespace (confusing, and a source of
>   conflicts with the VFIO official uAPI),
> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>   expected API (putting the burden on DPDK developers to find the right
>   way to detect the presence of a VFIO feature),
> - (somehow related to the previous point) supporting old version of the
>   Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
>
> This series proposes to cleanup those headers by hiding as much as
> possible internal macros and structures, then removing the explicit
> inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
> application which may want to do some funny stuff with VFIO and should
> already include this header on its own) and finally importing the VFIO
> uAPI header from Linux v6.15 for internal consumption by DPDK
> components.

There was some hiccup in a clang job in GHA.
Recheck-request: github-robot


-- 
David Marchand

