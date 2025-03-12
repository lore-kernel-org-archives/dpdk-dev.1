Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF20C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 07:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB17D402CE;
	Wed, 12 Mar 2025 08:51:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B165D40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 08:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741765888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdTAXs60zw5EIV/sRnYtmPdRaVvSL6iTvEzcPjZV8g4=;
 b=B/QdPVEDrZBqqh4qXTz2KAwTjCthRasunHoJ3qMR9eXzADb35ZmFXNWhjnIcK68eGT/Vbv
 OYbvLWNxE1+dx/9/6qHdjoTp7EbUKKYjZfwZatR9YGSKUJNaNHUFpD0P00DLAuFfVJXbro
 6yVCeyF+M6ebQby/GubSwKvWdfvvvfw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Kr7AIu-mPGSutUKO83yrrQ-1; Wed, 12 Mar 2025 03:51:26 -0400
X-MC-Unique: Kr7AIu-mPGSutUKO83yrrQ-1
X-Mimecast-MFC-AGG-ID: Kr7AIu-mPGSutUKO83yrrQ_1741765885
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5496d38f725so3511009e87.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741765885; x=1742370685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdTAXs60zw5EIV/sRnYtmPdRaVvSL6iTvEzcPjZV8g4=;
 b=HNGHirmc3vPT6d4P7c3HCvd/w0ZH3B5WSzNWWemzBmB0xhxtHXHp+nb/raYXWvDGOX
 f6oQWr7rHqMo2hDUKi8f9TYn1ZSOAznZne5xh6CQWITBlrjQqya/AFwX6ID6drSJTZln
 rAPjHUA3mmbhnbeS6TSSlrXPJcVo6eDAqZekdekRLzdGdNGIxZ8+pOhacP9zL8NgPn7N
 aRUWNhbJBjoveyJuS4Z5IKR0GN6dzmk38sIIutJWjdPf1ZB0EEsBIg81rIwUOMUkwhsp
 gIrsbHFY/VH8VKHyQFSIbh1GTAVs/G/8dh8oaXUGqyx01sIEChlFkmomE24v2e4wN9Et
 r3Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcB7r+DC+QAdT/ml/77ia1pfl6LPMD4bbV9kbt1YnEAgMiKtPl9dC2X8/VcVde0zXRTM8=@dpdk.org
X-Gm-Message-State: AOJu0YwV4zMAHWv9vg/6gs1wZlSkKwv/u9kFHALCUZFdosNdOotcC2sA
 HgofC35Wrkz8SvgRBN7XFNyqWQxDbS5lzsdB2Gjgo8qHnhFwQdc/v8j4fUyO19xsvq9g/BAJ1ZT
 dDyhtCOiT0CdGjxIRGGp9esNtq0rJqi1S8Fz7ftOgkodnOvkYLqCyXWKqB7QjvHF0Tw+10MFdaQ
 2Jsj/QtYnfWqKPdos=
X-Gm-Gg: ASbGncsTQ6T+jYV7INDsppJEjMs4tsmbifF/rLeiVHU0/+3efOje4rQ4JFNJixPY30m
 dL+yBA0NavscB6+7T/ajW1tgEiD+r7Rz9NFDgjd3uOxxtxD1Ogio5a+6/0xKg4GMYu6jaJHVYx6
 k=
X-Received: by 2002:a05:6512:3d0b:b0:545:5a5:b69d with SMTP id
 2adb3069b0e04-54990e67732mr7909256e87.31.1741765885311; 
 Wed, 12 Mar 2025 00:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6412/5rZE63cQft/zFwkBq9TfELM696DDMhyL+/l+dtENNphISBFXLWF3vDd51c00quCKGVK3GSeaFR1J3PU=
X-Received: by 2002:a05:6512:3d0b:b0:545:5a5:b69d with SMTP id
 2adb3069b0e04-54990e67732mr7909251e87.31.1741765884934; Wed, 12 Mar 2025
 00:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Mar 2025 08:51:12 +0100
X-Gm-Features: AQ5f1Jo87lShh8kEA6ndQg_QbUNCbh_KZ6J4_4SOjtWRVgdJ1LCZvLHu0KUlq0E
Message-ID: <CAJFAV8zw8WaafXmZtfe1OwoxZWrKaq03zPb_a-Vb5woXL4r40g@mail.gmail.com>
Subject: Re: [PATCH] drivers: remove invalid options for MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JsCGKtUYMDve1RCIZVyq2R34xcL5DLmz4YH4Xc0XlJI_1741765885
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

On Wed, Mar 12, 2025 at 3:14=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling "drivers" directory with MSVC the errors below popped up:
>
> 1)
> LINK : warning LNK4044: unrecognized option
> '/Wl,/def:V:\github\dpdk\build\drivers\rte_bus_vdev_exports.def'; ignored

I reworked passing the export map in my RFC series.

>
> 2)
> cl : Command line warning D9002 : ignoring unknown
>     option '-fno-asynchronous-unwind-tables'

This part lgtm.

>
> The fix is to remove the unnecessary/invalid option when using MSVC.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>


--=20
David Marchand

