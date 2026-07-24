Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F1C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 08:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F4F402A7;
	Fri, 24 Jul 2026 10:24:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3F0B4029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 10:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784881467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuZTbq5qZT2mDLsdBPhaXOy1ONrTYTGatAdJPLpvwPg=;
 b=KCliiPXiIijraat2l4KafRhEt2usOo+q9rKi49KZfLCQYV7BDfQy/US51lTu/W6l5Qh2Y4
 LTM2tYrggqUwY96h4bRe5KOvSr45vUlkIu7XJHS3X9cic8D2tn9Q1/s9vXXfItJ62zE3VU
 Ze/y5CQBMayGR3Wjj/sM1rJnnwFdBz8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ZbeLvp7OMWK0kq7fAJPgIQ-1; Fri, 24 Jul 2026 04:24:25 -0400
X-MC-Unique: ZbeLvp7OMWK0kq7fAJPgIQ-1
X-Mimecast-MFC-AGG-ID: ZbeLvp7OMWK0kq7fAJPgIQ_1784881464
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b29e7e8ab6so744082e87.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 01:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881464; x=1785486264;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xuZTbq5qZT2mDLsdBPhaXOy1ONrTYTGatAdJPLpvwPg=;
 b=ndz5pHBe3agvIDQIeMjuwExXgzss8ex0VB4O9bQvN/LRTNpGrNKqXpwy8BqojWgex4
 3V3JFGpSiwX8OF3msZYmmCj39+nHEJOcFvHaHjBO5hW3M5oITVXItuCzMuBqHDNViOdv
 D69rw4sLeq9lU0Rr6yvsK8UKOlMenmJlylSas+tgaMJVBCPxBUhobvCL+NZ+xrVkDSaf
 tOArSVx9F/2FyV9kLdYrta5f3n9QC5OPxDUkfmpBp5HYW2YgrN3xWGjhlnZrwtX+7CVk
 xT8+5cqK7Tm+Sh6LFpZu+MFIqbXvxP64DX31n/HXbDUjTkuOS9bMApCP/Hf0N5/YD06J
 F2GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqypSvVunKrm4w7tFOSqnpv3Ps4Alc4T6ziuNzMz594/EwdTg3sIk/LfhD+86oVKrAYyOk=@dpdk.org
X-Gm-Message-State: AOJu0YzZY53x8Yh/SobPByhokD7DyTR2zUJWR/5apwerPPlm+ktfXZSa
 X6U+FdUg9LWcV9dc54zTSv8Rm8d/+bB3PhFtruVXs3Em3TBVpaOgRUmM5aP5gHYE4ctkIpPPqsA
 94UoXVl10Zn/H4KNM9XILRaNr1F9scVAQJohL18M30CSRP59GnoT8Vn2IfIudBZnHh21hyhXR1F
 4jYndVLi7liiToX7Nv7s0=
X-Gm-Gg: AR+sD11XOGPsT/ahfLh/SJ8cocXrGKgG0rp61uVmjuXoPr0J2w+g1g+pJIx0Mbi5HZy
 rBhCa6OI/eB1tLkc8nB8S/iOmNcTdoTEWXeyAAUHUsRF404emX1yfi2xjkRJi0VVftaPRQIhGyw
 0QIM0bWa3ndTMPTITg1RqIA8cL5JPACHIQg0SSQQFYrufO1bneOTyVCz3ftb4hDiDDK/lt/VAIF
 rUdm6Qf1kIxzce5qMedLA7pM1yIYflsq8UIeYbb7BhFaFnQ
X-Received: by 2002:a05:6512:22d1:b0:5b2:a22c:50ff with SMTP id
 2adb3069b0e04-5b2b33664cbmr971165e87.19.1784881464174; 
 Fri, 24 Jul 2026 01:24:24 -0700 (PDT)
X-Received: by 2002:a05:6512:22d1:b0:5b2:a22c:50ff with SMTP id
 2adb3069b0e04-5b2b33664cbmr971163e87.19.1784881463678; Fri, 24 Jul 2026
 01:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <1742242184-19600-1-git-send-email-longli@linuxonhyperv.com>
 <4683947.Icojqenx9y@thomas>
In-Reply-To: <4683947.Icojqenx9y@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 10:24:10 +0200
X-Gm-Features: AUfX_mzAxCgOc8d2IOFUgFzfNGdYPWPRA0y3NAkJLH2oPZfGJHeOs5-I6i3-KuY
Message-ID: <CAJFAV8w9gDdRo-V0DofkAQFw4mJrQ3oFSxVGDQkbVJMHR82BjQ@mail.gmail.com>
Subject: Re: [Patch v3] doc: announce bus/vmbus API changes
To: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hpvVD5VPLHP7lmMftJoCOSenRzQNLNqA5-NhYFUT-jw_1784881464
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

On Mon, 24 Mar 2025 at 19:48, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 17/03/2025 21:09, longli@linuxonhyperv.com:
> > From: Long Li <longli@microsoft.com>
> >
> > All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
> > It's not feasible or practical to use those APIs by the application.
> > Those APIs will become internal in DPDK 25.11.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
>
> Applied, thanks.

Could you work on this cleanup for 26.11?

Thanks.

-- 
David Marchand

