Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6807AC98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 557C042F0A;
	Thu, 24 Sep 2026 08:47:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 10C2542EE3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNM8AQ/t71OPmI28gul+LSaYGiW+UIanAPTAWDk//uw=;
 b=PPB/dxRhLYV1zYt7jAmm1VNMESEG1CmF6x+3j/p90UMI99//AELTcYHiXvKdG/WJdc6QsB
 Lw+25gdZqRWnF+1HT2NrJsqUGmlEIzGadbfR0j0lJ2HZsNitPY3BDsx4460lbEzk1wwCwT
 qtAK5isTgwVYlITVSiSjtJnLRYGS7j0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-L8YfRt9LNby3iKSR4utQ7w-1; Thu, 24 Sep 2026 02:47:12 -0400
X-MC-Unique: L8YfRt9LNby3iKSR4utQ7w-1
X-Mimecast-MFC-AGG-ID: L8YfRt9LNby3iKSR4utQ7w_1790232431
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b617595b4fso1079207e87.0
 for <dev@dpdk.org>; Wed, 23 Sep 2026 23:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232431; x=1790837231;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jNM8AQ/t71OPmI28gul+LSaYGiW+UIanAPTAWDk//uw=;
 b=nU3htTwBnZBedShux71BgaK1rPk7st7KTEfXk5MHB99E4zjPJ4PpRQQGRpjICNR02d
 +VHFJg3NNOfbH9id61pYgW08UXc4YTIwWlgGaXBilTeJD4BDfLqXQJIIIGFwv9dfylsk
 ugnTVOrp37pBP9/WxxCxG132pmnuhORslygZxE53sjI0v91Hv7RjcomsVXnuHybvUDQX
 wUa7bgC9pfnUO3iDmSQZlAGpahryJSSac9xWwIrwlOvinb251b5H/N97PJ1NioqtsriB
 yx+Pir8LLdYQSBbhfp3dmif5Hr/fWRL65tOy0rj88PQG1Qt1tdpSo5GeH9o9PhRaJCHV
 g4Fw==
X-Gm-Message-State: AFuF++ncjCAmSS9gX3uj815TfiH2Ap2KawryjF1zEPcqmde17eTiV1Zl
 jPbHOavoHXFoJ802n/XrPAIFPSE/Oj6jZZOiqdVL/UqS/+VJ3SGYZS5sHuhWZyzMCxmNI9epRrG
 CxU8cYCAAtRLK1xoaB4xfqcVy1ugnQostTuM54KEE8jYLB9cspIwQbwqFs0EAD+3Ah2ZsJ81F02
 bLDhaOOGAbiEmuX9NRBSI=
X-Gm-Gg: AYBFou1FvsVv7JCtDryanZOndK0uu2SdbYxGyzPw1JEVCUjezk+XItgaKVtGSaNtlsy
 +OcdNLLnilHioWb3gxCfd6hjRx82IAT9TbNox9+i13DCfmcoljzDZvkx+RQVceyd3quIDn9BQ//
 d1OeM6XJoZkMAD6lw07HtsNmhcslmMp7n8oDJZloBFhETPHFhGj7NsFkoX7ID0MaNLhS/KCvihS
 IzAaPJkJGaGZlNH0lSDDkAQCWFX7UDx3FdNYIuviFBsYqNQ
X-Received: by 2002:ac2:5ed1:0:b0:5b8:da5a:937c with SMTP id
 2adb3069b0e04-5b8df0db9c3mr343748e87.17.1790232431293; 
 Wed, 23 Sep 2026 23:47:11 -0700 (PDT)
X-Received: by 2002:ac2:5ed1:0:b0:5b8:da5a:937c with SMTP id
 2adb3069b0e04-5b8df0db9c3mr343739e87.17.1790232430845; Wed, 23 Sep 2026
 23:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 24 Sep 2026 08:46:58 +0200
X-Gm-Features: AclHuK82QKA18bxeLoFTs2JoaMZScd0gpQFGo9-aFQT7tmaNkf-Fw924X4SOyTU
Message-ID: <CAJFAV8z4mrPq5CPKOeBE1nS1-_Bkxkfy6_EziBYb4Uo+mj-dyg@mail.gmail.com>
Subject: Re: [RFC v2 00/16] Device unplug and bus cleanup refactoring for NXP
To: hemant.agrawal@nxp.com
Cc: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GNUT0kCaTXlD4ybMHMJ8m7B0w5xaPrnL0TG3YpDnJAw_1790232431
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

Hello Hemant,

On Thu, 17 Sept 2026 at 09:49, David Marchand <david.marchand@redhat.com> wrote:
> This is a followup to the refactoring started in 26.07.
>
> I took some time with my best AI friend to cleanup DPAA and FSLMC bus
> drivers.
>
> Like the last time, only compilation has been checked.
> I have no hardware to test runtime.
>
> One thing that could be broken is either the order of devices
> initialisation, or bugs in the device filtering that I tried to
> simplify.
>
> I went with the approach of splitting the device list between
> internal bus object (that I called "control" devices, maybe a better
> name can be found), and normal bus device object for which DPDK has a
> driver.
>
> I think it is worth testing and fixing, as it will make the two NXP
> bus drivers similar to other bus drivers (but keep the special IO devices
> handling internal to the FSLMC bus for example).

Could I get a round of tests? Or should I just sent a non RFC series?

I see potential conflicts with other series coming from NXP.
I think it is worth getting this cleanup in, to limit the number of
special cases for those two bus drivers when compared to other buses.


-- 
David Marchand

