Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E9CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E9C44065A;
	Tue, 16 Jun 2026 11:29:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEF7B4060C
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:29:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781602187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxA1DMlTneZOI0ceP7JAOxuhnYQeLGGt31IrRVTeB9M=;
 b=C+czXzpmZ3XM4SmhA9GYhNTHg6/idCRkKz8D7SmGC0WUyr05YsypFL9sT8dhiIZaBTlzhf
 G8YEijAyjte3k8vjHLbBPriKF5xYOKr8mG6wgNbg58Bp1MoBq4ID0C0L8i6cWSsR2mc8/e
 9BcpFn7Z5Du8kUNj5XePWPw1Z84+Iio=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-21je8RuTNxqOc2jhOf67Lg-1; Tue, 16 Jun 2026 05:29:46 -0400
X-MC-Unique: 21je8RuTNxqOc2jhOf67Lg-1
X-Mimecast-MFC-AGG-ID: 21je8RuTNxqOc2jhOf67Lg_1781602184
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39695d8ceaaso19182641fa.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602184; x=1782206984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxA1DMlTneZOI0ceP7JAOxuhnYQeLGGt31IrRVTeB9M=;
 b=Sdti0mKzkVUMwokDoyfh/Igv/YNeDx6ivFI8hyaE/sEYzOJKczO88GArYmoVjKCY36
 IYJX16Ozi3mT9CanH3GfaPOlkRSe4O/LRMP+1lFe+PDqhSpOaPhKiy4WGDt0VkoygMb6
 9wxnBBcUDKfvVUykYNDSzVfoJyic8V+OOkSkuF3wUnbYcz5oQ5tXq0FQMcnvFSRPEvPf
 pp26ZD35hzVrqM8GDLs2Dcv28DrmneN1ye8e1XfdSYNe9xVKJNst1t3PnN2mLmG3JhPz
 zwb/vu4J7MTg8rxPM/cN6XPYRG7kwj1R8PPFGTiD4VreXml0ofdyLpg/JdG/iWzihXoj
 9wbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4kf0WCGFaSsOaLyqum+h5sr+OxYKgUUsAk7h5SSzX70q5IDPRtJjwnNVylZk8FS2b5do=@dpdk.org
X-Gm-Message-State: AOJu0Yw9Vy8TGojEnt0cfhV4HZXg//eekIy2dsmNiBTFCzpvyk9+AaAB
 IPYB9zkAv8Yx+dfw+MYz1AYdbtosuwT/nNYKbiupTpeQgXWFNcqcxpZlaZlO0oAcWAVSKof1LAY
 L+TL7l1S3gypqNTFi22NsSvB7Hs2F6bkhJQnhFj9cGGGL6/5/CL3viwS2cSXLNZhGkHgHFYPtvS
 PNH141aOoAOvp5AyAV0ck=
X-Gm-Gg: Acq92OECY0eX99p0dSHGMYkQQhdWMh8YOTR4EkzBv9+SBRw0UACkNTo4b4jWlx6rzYI
 w/NG/9U06/JK+0Eh6hnUxOZV6ccVrVBxvHiwlqmVDtBCFqeFUsc2LY5vOhfAWhvTIAm6ZYg6wlx
 Hr3yuTHBy6oL+HaS7Atl+Jk2+YgU/uWQRU3pSL5GmeVesLlpbUxcCIM0b0o6wE1HVBCz4FTJU3c
 znn7oCIe2hGEdMJoXjM7snlzcjWLOqgm3vE0tT+sgDxtazepjH5QtYqqMfq/Cc2qCCJmQ==
X-Received: by 2002:a2e:a587:0:b0:396:d714:af72 with SMTP id
 38308e7fff4ca-3992b0574d2mr52493531fa.13.1781602184226; 
 Tue, 16 Jun 2026 02:29:44 -0700 (PDT)
X-Received: by 2002:a2e:a587:0:b0:396:d714:af72 with SMTP id
 38308e7fff4ca-3992b0574d2mr52493401fa.13.1781602183701; Tue, 16 Jun 2026
 02:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-3-maxime@leroys.fr>
 <CAJFAV8xH9GOGF2aR7tp2uMsjhpJs-1gXW=xzG4Gak3T_n1KpNQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xH9GOGF2aR7tp2uMsjhpJs-1gXW=xzG4Gak3T_n1KpNQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 11:29:31 +0200
X-Gm-Features: AVVi8CePShRWSXay4DaGVeGt9pNF4fYdCqr33jOTDNQR_lfYKBxcNSQJuQMFT0c
Message-ID: <CAJFAV8y-q5Bc=sgz9fewDdTopS9442rTXeeiFjjhPG5Cajs22A@mail.gmail.com>
Subject: Re: [PATCH 2/9] eal/interrupts: keep real errno on epoll error
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org, 
 stable@dpdk.org, Harman Kalra <hkalra@marvell.com>, 
 Cunming Liang <cunming.liang@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q4qDgmub3r-3Fqfu7N3Ngpbdpeco_09ioo5YGq7TT-U_1781602184
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

On Tue, 16 Jun 2026 at 10:02, David Marchand <david.marchand@redhat.com> wrote:
>
> On Thu, 11 Jun 2026 at 17:50, Maxime Leroy <maxime@leroys.fr> wrote:
> >
> > Some interrupt users have several vectors backed by the same eventfd
> > (e.g. several Rx queues behind one DPAA2 portal eventfd). Adding the
> > second vector to the same epoll instance then fails with EEXIST.
> >
> > Upper layers such as ethdev and bbdev already treat -EEXIST as a
> > non-fatal duplicate registration (if (ret && ret != -EEXIST)), but
> > rte_intr_rx_ctl() lost that information: rte_epoll_ctl() returned -1 and
> > rte_intr_rx_ctl() flattened every failure to -EPERM.
> >
> > Return the negative errno from rte_epoll_ctl() (its documented contract
> > is already "a negative value") and stop rte_intr_rx_ctl() from
> > flattening errors to -EPERM, so EEXIST reaches the upper layers that
> > already handle it; other failures carry their real errno.
> >
> > Fixes: 9efe9c6cdcac ("eal/linux: add epoll wrappers")
> > Fixes: c9f3ec1a0f3f ("eal/linux: add Rx interrupt control function")
> > Cc: stable@dpdk.org
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>
> Reviewed-by: David Marchand <david.marchand@redhat.com>
>
> Nit: the eal/ prefix is only for OS specific / arch specific changes.
> The title prefix should be interrupt:

I took this fix directly in main.
Applied, thanks.


-- 
David marchand

