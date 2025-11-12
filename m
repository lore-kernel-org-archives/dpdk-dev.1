Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D17CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F1F40667;
	Wed, 12 Nov 2025 10:05:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3C43640659
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGpKF3rBue1fYN5X2hLrqrjFDgJV0+gEKQl0xuxO2bo=;
 b=bWq+PSCNyPZKtfz9i3tdojkUC0vW+AfiQEU/UjTUsR9fZIRC4LFRK7CFqd+6UQnS0tacm1
 s6WXO0AUrwclv4vbSVzgjBAfTG1KX3m7Ub6P1xt9mh58rYj8TglmJOjqZspFEIEDmLyHz2
 maZTjbQi54vNLlk9Al6pREVdTg4HD4Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-y3_DMnPKPwa3gGbJUTl77g-1; Wed, 12 Nov 2025 04:04:58 -0500
X-MC-Unique: y3_DMnPKPwa3gGbJUTl77g-1
X-Mimecast-MFC-AGG-ID: y3_DMnPKPwa3gGbJUTl77g_1762938297
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5943ca95853so276522e87.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 01:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762938297; x=1763543097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGpKF3rBue1fYN5X2hLrqrjFDgJV0+gEKQl0xuxO2bo=;
 b=UPFEI39Ktfv8e64wxLnXUHJIzvcDfDY2wAavcIoDVra8/FfdvfBaKVC31IYU/saEfk
 /JnBIeInQiJrIEE1zRmQjEwdEmBrlMyke3zJfN2OucdSFDul0EIhDq6/QKwnxjWnQ38i
 aY1a+8FvFgnNjsDzkn8NrESLFgYrTjqTBrrsmutDIelZdyH6S5wMscPtZu5/nJ9JqohD
 A8OG62zy7okFVTiQFhEkfCdBw8yGUCFM2y7WkwB2mbwG+Gvsy8OYJMK4XnlLM7xQX0H8
 QMQ44edegSGzCKRl68u0BL+Qjyhq/UrVjp8t4JYZLPZwTh8YmLzZFy9yyTVrRj7VwLRP
 4MbA==
X-Gm-Message-State: AOJu0YzFJSkgt6FNCZw5Avqy9TK523QB2xSwvVs2Av2agodJkg7Rr/jf
 8wu9zn8PKukBi2l/hQC6jd83g+n4ZNahmQgcEeE8K2q5MdlJ2RlZfervGXiwepQneTKic893hWV
 w0f+ou4/+O7GIa01YZUV2aPIQNF4DWh2ufLDcLDS6rv7d1QvII0OysDOyuGCfAfTiDhGavcaWUC
 46pyRkvxpaYqqbGNOTA6U=
X-Gm-Gg: ASbGncuskDVQgWxVQjbyVF7TwZ9D/up7EkpC6j04z6tOtL6G3a7p0F468LmtW87Oo2Y
 3BLlRBfyghPszAGOj28gFf/RUgapxd+KReUx6T3+OO8yQYESR8G6OGf39wQi0uLujvPS4HenIVG
 ewJj8zKUEPl22DCGVYR3PUsDcz/qd4+67aazK/O0CBb0GDmKEAt3CfxNiXnQ==
X-Received: by 2002:a05:6512:3501:b0:594:3020:f88a with SMTP id
 2adb3069b0e04-59576df1a6amr777743e87.3.1762938296643; 
 Wed, 12 Nov 2025 01:04:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0O7MtaVfzH4x+MRJpguRZghqFCz7C0RLYKhEzXECdgeSN9AhUnlBM4vPltI62ntXOSO4tqdY95Sodcwmchgs=
X-Received: by 2002:a05:6512:3501:b0:594:3020:f88a with SMTP id
 2adb3069b0e04-59576df1a6amr777727e87.3.1762938296087; Wed, 12 Nov 2025
 01:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251108153207.1512863-5-david.marchand@redhat.com>
 <CAHHRULVe39Hq3ebQJVMfSfBMppEgZX0gmdzSqGoXNJWK5QtGGg@mail.gmail.com>
 <CAJFAV8x4+2pwC=_NGM7J5ikyCY2tLAaQhS2uHLTG-_mShPAHEg@mail.gmail.com>
In-Reply-To: <CAJFAV8x4+2pwC=_NGM7J5ikyCY2tLAaQhS2uHLTG-_mShPAHEg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 12 Nov 2025 10:04:44 +0100
X-Gm-Features: AWmQ_bkGgrGJu5pBy7c7NkZGJ7oUg1nsh4HZQyFJCpxbSZEkCR9UHlzBF7LRTgU
Message-ID: <CAJFAV8ymqLUS_g4jH+pWVuSrMoF5LfNt001KYreVd50rfjUK=g@mail.gmail.com>
Subject: Re: [PATCH 4/5] net/dpaa2: remove ethdev device in bus device
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ufZ01nlHxvuUmyxGGBIiQlSEVSbF0qc1UFUnfQSkA9A_1762938297
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

On Wed, 12 Nov 2025 at 09:56, David Marchand <david.marchand@redhat.com> wr=
ote:
> On Wed, 12 Nov 2025 at 09:44, Maxime Leroy <maxime@leroys.fr> wrote:
> > I don=E2=80=99t think dpaa2_tx_sg_pool should be freed in rte_dpaa2_rem=
ove; it
> > should be freed in dpaa2_dev_close instead.
> > For symmetry, dpaa2_tx_sg_pool should also be allocated directly in
> > dpaa2_dev_init.
>
> Indeed, moving the dpaa2_tx_sg_pool handling in dev_init/dev_close is
> more self contained, and looks cleaner.

On this topic, in rte_dpaa2_probe:

    /* Invoke PMD device initialization function */
    diag =3D dpaa2_dev_init(eth_dev);
    if (!diag) {
        diag =3D dpaa2_tx_sg_pool_init();
        if (diag)
            return diag;

On dpaa2_tx_sg_pool_init() failure, a eth_dev is leaked.
Worth fixing while moving around the code related to dpaa2_tx_sg_pool.


--=20
David Marchand

