Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FCCA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 08:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A21F0402BD;
	Tue,  2 Sep 2025 10:11:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5331F402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 10:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756800680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjoCcHma7WuCudyvwm7YDBfFQUvVFAbaRlD6/YAFKx4=;
 b=dwDrWklaqaLeG7LtUVd7b5KgHUe3SnnU3WGbFOv8U8YgNOQQq2jJJ4YHjaFCAGj6TsPDv5
 c5b4dqkUB6ziDAbtNsp6jOm7zhLsWy+LxCgmfHEowOMfNraFRc0gR26oFzvrm9p5TBmCnL
 p+IhZ0fK+VaIz3/PTK7L/iKO2uXEIMI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-KOLvRJJUOPyemymjSfhNnw-1; Tue, 02 Sep 2025 04:11:19 -0400
X-MC-Unique: KOLvRJJUOPyemymjSfhNnw-1
X-Mimecast-MFC-AGG-ID: KOLvRJJUOPyemymjSfhNnw_1756800678
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55f70a5c9e3so1995389e87.1
 for <dev@dpdk.org>; Tue, 02 Sep 2025 01:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756800678; x=1757405478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjoCcHma7WuCudyvwm7YDBfFQUvVFAbaRlD6/YAFKx4=;
 b=i/rfT4aQ919Fefh8DWcqRO46SB+Tt6WK/3Tqvxui9rLVDW9SmDNZDaBL2Pj4yeiFCw
 vMYvPSsNwZ0AsgpD95/ygRH0zdv7YPOg5V2Esb2eaGbb2/ICGMUW80sW81j2jvnhDHJQ
 OP7VmYXCcz1VT/VuHn7JoePPh1Xwv+mnWHK306LJ7/EyqGTBk7aTsTC3tgXHRfPLRLJs
 8FPc9kZer347VhOm4H4HcO/sacIrPWIqrcxCnH58nsk6zJyd4J5ZRLjqzIzsJ2YoFVEh
 T1XE1B5tDvIXLcM+kbmd9C1K6/jz7WbiCRkOII0IE8eHRVXc9QUWkrWwhMZIvLtTv693
 mwDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXReA4Y1x3dipU8yZOPQF7+G+9OaD8xfwMopdR4x/okcWZSMYtUQPW+qPWfuGZaLxneyPw=@dpdk.org
X-Gm-Message-State: AOJu0YxhqZUfnEGT6EsSrvJn8Q/uvAaNzSlvfpWaKXfo5NZwsu+cSg6a
 YtwRLz9rnd2j6r1UFVz/qzgGAvXGynZnyHEOgU/9jbXSyBzLqxhbIUfMT2ngltybxjKMviLUBd9
 Nry1sM5gFs4dyakJa8FIIeamq5RdOlVcWxtJkjamLiT5qzRVS1Ld7r4p216F6+rnUmZG0Z5Ii/h
 sXDPHMXm58HaPc0+87970=
X-Gm-Gg: ASbGncu9fFGJKZpmH7Nvhvx+GuJD/GdHr+lsY9DCpdfu2hkVF3ey22ADvR0oDgxnNdZ
 mlA/t6Nd9pYOg24133gmnAKs8R7rXaAelZKG5t764NPouGMnhsEOtjqfZHV3C/7URtzYAOP6h6A
 /SuAZfPIA6ar9RwQ48AJJI+RQ=
X-Received: by 2002:a05:6512:3985:b0:55f:4760:ffeb with SMTP id
 2adb3069b0e04-55f709c845amr2631690e87.49.1756800677745; 
 Tue, 02 Sep 2025 01:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE69y2vrySymey9U+TI2c+liG2tYzYbjsQmv5XOEdJbKfSDBkUkU09az+24IxgiQGNcq1fo5d1Q2dmZENQI6vE=
X-Received: by 2002:a05:6512:3985:b0:55f:4760:ffeb with SMTP id
 2adb3069b0e04-55f709c845amr2631682e87.49.1756800677032; Tue, 02 Sep 2025
 01:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y5C3-TZ-m-xECRZi3=tMqUE1BUahpE=-UfTxPWaXWRdQ@mail.gmail.com>
 <20250830002333.GA6088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250830002333.GA6088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 2 Sep 2025 10:11:05 +0200
X-Gm-Features: Ac12FXztlhPjyWiV_AAbz7A_V7HdCjlIiiml_fp59HpIbymNI3AD-7Xf0lqX4HE
Message-ID: <CAJFAV8yhjevtCqORT=baHT+sSX1sPALhzYoEB9DVo67WnZjx7Q@mail.gmail.com>
Subject: Re: [PATCH] test-flow-perf: Enable to build on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Wisam Jaddo <wisamm@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: axTM7G8aC1EJsCVt7c7-eUW_R6McGKtd-ye1CGuSe2A_1756800678
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

Hello,

On Sat, 30 Aug 2025 at 02:23, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> On Fri, Aug 29, 2025 at 03:04:10PM +0200, David Marchand wrote:
> > Hello,
> >
> > On Tue, 5 Aug 2025 at 22:00, Andre Muezerie
> > <andremue@linux.microsoft.com> wrote:
> > >
> > > This patch fixes some issues which were preventing this test to be
> > > built on Windows:
> > >
> > > - Remove VLAs (not supported by msvc).
> > > - Replace strsep() (which is not natively available on Windows)
> > >   with strtok_r().
> > > - Remove the "thousands" separator from printf() calls as it is
> > >   not available on Windows.
> >
> > Can we use rte_size_to_str() instead?
> >
>
> I considered doing that, but I thought that since the app is printing deltas it
> could be better to print the exact numbers instead of some approximation like
> "1.02 k" which could possibly make debugging harder.
>
> If you strongly believe that rte_size_to_str() should indeed be used here I can
> make the change.
>
> What are your thoughts about this?

No strong opinion: just that we introduced this rte_size_to_str() for
this "thousands" separator stuff.
I don't mind merging as is, and I did not hear from Wisam, so I guess
this is fine.


-- 
David Marchand

