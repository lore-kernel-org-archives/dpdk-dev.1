Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D3C53219
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 528C940269;
	Tue, 28 Jul 2026 16:49:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF194014F
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785250145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30QEZU1MlZp32wX8KOcR0u54Q9FORat0W8j7nzt9rQ4=;
 b=XcpmhC2bVu7ktQ9gX0kg0jVsokx7bjq8ItzWNrvMEpZxnfrCUfI+EhQrQAziTPAZyzkjtf
 /9Rp3rnrf7Ql5G2yVi5cyyav/C81wG47r5eCK8q1ZOogyMRheSgSkRSeFO5qmMlSv94wcV
 fz9zGfPFNmmdfECHbMQMg9/JLaqIOkE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-yGYu0PotPDWStgX6qkzOOw-1; Tue, 28 Jul 2026 10:49:03 -0400
X-MC-Unique: yGYu0PotPDWStgX6qkzOOw-1
X-Mimecast-MFC-AGG-ID: yGYu0PotPDWStgX6qkzOOw_1785250141
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b29e7e8ab6so568602e87.0
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785250141; x=1785854941;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=30QEZU1MlZp32wX8KOcR0u54Q9FORat0W8j7nzt9rQ4=;
 b=bQoMH13yygwfZHbAdSuvDFDTsvbso/3nC8mWgAcFUw85WLe3zO1Pzlg1jew4/KTUti
 siUOfLnuuPej4s+Yqi5HcBz8+gaFvTnQAVr/2eZAqTC7KKwaSUlYm0JQU/rQwfqXizod
 J+W/78zmkD7uiiK8L27Z/acSifcOBkaptlCHDsulwa8WNw9SCPr5HaJ+fBCugrbxlLMP
 nFFnaZ8l+LcqSmcrG1eSrQWUUMwvUlGlNNCoUOwOxZpZT33teU9oYAUE3j2pX5YB3p4A
 /uJlMsIw/mJ9g9tYSCdQXYrt82byCdZYvgT1fLQkqWptk039tYTLUj3MuEMHlTWiByba
 VSvQ==
X-Gm-Message-State: AOJu0Yx+uIXbh9Ree/yS3bfAyEr0r+cH70GR/tADBAPMmwHACLvY1fAN
 h4n6lH8a0rcJH2uxFeVWBhgU1/tfrGYhgzWY0nvxGgHylKaeRSQ361D9HQ5vWs9MGaQCKt+Qe2l
 xWXVCF+yeMFIyJDlQWtzLPmFom8d8C2fFqpsVreOQ0yOlQlpKEnImhPiC7yEOIO5IFXXIIaA+gp
 tsCuzhrcTq8NmOBwSqvzU=
X-Gm-Gg: AR+sD10jgjJ2yx6UY5hanE3ioFGy8I6uCqQGEqs5OYhlB9aa5bSIQlSo5eN+k/bzmPg
 1dNwT61cUm5//vVHHm9JVLHkU2hxTFZ3MwKyIY4a4dOB4eixqXG1OCtLtNiaiUVCVu+EF6v+xaw
 ecvNG/GxRVhaQdaQ6Z8/4ZN2AQXc1uwpq/PiqA6UH+T3Bi/jy+iIUcmTitK03NETfGnC4E9KGQG
 b88ppkUeDFF9IPLUgrCEJ6JFZS6s2Ldu8/ACebGybU3nqKs
X-Received: by 2002:a05:6512:2345:b0:5b2:aa5d:9ce7 with SMTP id
 2adb3069b0e04-5b2d02143b5mr651313e87.10.1785250141362; 
 Tue, 28 Jul 2026 07:49:01 -0700 (PDT)
X-Received: by 2002:a05:6512:2345:b0:5b2:aa5d:9ce7 with SMTP id
 2adb3069b0e04-5b2d02143b5mr651301e87.10.1785250140824; Tue, 28 Jul 2026
 07:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260724164520.192203-1-stephen@networkplumber.org>
 <20260728142135.106054-1-stephen@networkplumber.org>
In-Reply-To: <20260728142135.106054-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 28 Jul 2026 16:48:47 +0200
X-Gm-Features: AUfX_mz66WrOxcWDBc7aC6KPCYSOq_2AzU9U7VZl11blPlYPes8_k1g9ATY9EIQ
Message-ID: <CAJFAV8ygfADmEH-rZegJ4PkzmbJzPCvF3aFg61LS0p3cgQbNeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] remove legacy packet framework
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-xETIDo63JgV0dNBbqnjcEakXc2ua77IEUhg5ifvSY_1785250141
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

On Tue, 28 Jul 2026 at 16:22, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Remove the legacy packet framework examples and libraries.
> This was announced in 24.11 but never completed.
>
> v3 - also cleanup cocci scripts
>
> Stephen Hemminger (6):
>   app/test: remove packet framework tests
>   app/test-pipeline: remove application
>   examples/ip_pipeline: remove example
>   pipeline: remove legacy API
>   table: remove legacy API
>   port: remove legacy API

Not sure why, but downloading the mbox from patchwork gives broken patches.
Maybe the binary part gets mangled...

At least, downloading from inbox.dpdk.org works.


-- 
David Marchand

