Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052FDC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 09:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 436D0402A0;
	Thu,  3 Jul 2025 11:07:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17E8240292
 for <dev@dpdk.org>; Thu,  3 Jul 2025 11:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751533674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGXxunUsCDySWE+p7nC2+Y9HmjaUM4EzAai3qahpK6Q=;
 b=UTzCNt/sQQX+8QCV9VgmnZ7SZgvu60c4tYhNaRPAq2K5Rn3y2UYlwufhxz5vhafVAUIYJ8
 2bB70wVh0mQXEl27QRrvMl9WXVGgPCudmMl6Gd64UxbCN6Pt9PChxlKZzOFkQ/vytXJF1P
 +vXHaStCqBPwZ8fBgCiIhkM1EEeMWNU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-xtXUy1koNk-1MIBKCJ1ofQ-1; Thu, 03 Jul 2025 05:07:53 -0400
X-MC-Unique: xtXUy1koNk-1MIBKCJ1ofQ-1
X-Mimecast-MFC-AGG-ID: xtXUy1koNk-1MIBKCJ1ofQ_1751533672
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5551d40d2dbso2158030e87.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 02:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533672; x=1752138472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGXxunUsCDySWE+p7nC2+Y9HmjaUM4EzAai3qahpK6Q=;
 b=Vsfg+W2+C1Bl6+4iiu3UBNNDmSJK28CPrFmpTCUnb8bV8Ilv62jmAkonYS2Fxf+tXX
 aVskWQKA17f3Y7lIJIHMqqd6t5XWIFDMdJ1caPWdmxWWjMFl7o26GmWrlGthOKF6LM86
 Epl1TWnekbCqzl863AOsDKORexCErM2eKQQZMro0+iG/7W9+MWpGVaPFc/Ub5dIzeeCD
 LZZaSSQrjdTxdDlIJQJJAB8Ef62qlfB1zd9bMAarFXtxy9R/v4k+sIIoliRwExVo7+xq
 rl1Fx2oFrzJ/ToGgMGIZ2DIRj0EHsclfYLSIZAcosIn5OEX6Ch8Bo0OwQI51ueh8gkJs
 dyqA==
X-Gm-Message-State: AOJu0YwOfaVvHVMFTEAw3qhYKkZdREL3N3YICVp8Eot5LwVddpkyhGhP
 jdGyQcd8w6WkLwwQ5CV64gLSo/LewKUSUH9oyp/wJLLib+Oyg/c+1SF0dq8Ijhjwxf4PZwivmoU
 0/HfoM9Grkd59oAFKSu8rRmN9FyM+IVVsvoi2ged8sU2PHjOn3HDu8TMPtqTdivzGkJj2ueiUsM
 62ESD1G8xHem8L9qPE4kM=
X-Gm-Gg: ASbGncvragERA8Un9KgBYwy+FPnyHvwrt1fhZpXPy+w1KJT3hODED1RRhowt2e2GMWI
 ZlKy+z9hHSCvAHQ+M28rDRQLZRZyhp7Bkti1joUdCZ0OY2f3Lyw3OXpaPrjh1MidUOxsZGlU+c4
 qfdYO/kg==
X-Received: by 2002:ac2:4c54:0:b0:553:3945:82ac with SMTP id
 2adb3069b0e04-5562836afe6mr2025593e87.29.1751533671849; 
 Thu, 03 Jul 2025 02:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8dTClW9fQmoEUv3mXGNh9TyLfz2RAiXx4AxPSqzCG9dc6irih5sbscWZXfdlP9SiuoHLqL0Po3GgP/Bc3yLo=
X-Received: by 2002:ac2:4c54:0:b0:553:3945:82ac with SMTP id
 2adb3069b0e04-5562836afe6mr2025583e87.29.1751533671395; Thu, 03 Jul 2025
 02:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
In-Reply-To: <20250617150252.814215-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 11:07:39 +0200
X-Gm-Features: Ac12FXwVdzilNfrcXw_cbBX2-2c85PR-nTAuuObD0n9EPjzO8mP8At0zbBn2fao
Message-ID: <CAJFAV8wRCa3JodNNCRRjkEG=R+CPLovdo7AZCPXnf9gANZ7jBg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] latencystats: fix receive sample MP issues
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, "Varghese, Vipin" <Vipin.Varghese@amd.com>, 
 "P, Thiyagarajan" <Thiyagarajan.P@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IbRg4g-OrnVlc-CJdi7oKt0u4t1NWlz7O2wQO9YFwC8_1751533672
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

On Tue, Jun 17, 2025 at 5:03=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> After investigating latencystat test failures, discovered it poorly
> designed to handle bursts and multiple queues.
>
> v3 - reduce patch changes, break a line that was too long
>
> Stephen Hemminger (2):
>   latencystats: fix receive sample MP issues
>   latencystats: optimize locking on transmit
>
>  lib/latencystats/rte_latencystats.c | 64 +++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 21 deletions(-)

Series applied, thanks.


--=20
David Marchand

