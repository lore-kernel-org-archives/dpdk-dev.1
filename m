Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593CC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 08:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1FDA4028B;
	Wed, 19 Feb 2025 09:16:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F0344025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 09:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739952963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZYWZSAUf5iAsCFfaqgK9SsNX3NZl5EfASYAqvX4+RE=;
 b=TUhxUKKauUsT4xBZjRv/Fmtt8T3QldVKbFmksZeN5m5gJjxR8Sa2LuBe8gDD0MPTjDSSlq
 Vz5sicvqBDCF6fG411oESXlJVAvPB3J/K0VswcNZUta7fA20yfAb9fLx/V5DQ3rqU9FdKI
 wicVhcvQm0IeBVCPYXsuK9afZ59Fw4g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-Jtx7qsZNNn-dMOPiO0KOgQ-1; Wed, 19 Feb 2025 03:16:00 -0500
X-MC-Unique: Jtx7qsZNNn-dMOPiO0KOgQ-1
X-Mimecast-MFC-AGG-ID: Jtx7qsZNNn-dMOPiO0KOgQ_1739952959
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-545314fc4c6so2216334e87.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 00:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739952958; x=1740557758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZYWZSAUf5iAsCFfaqgK9SsNX3NZl5EfASYAqvX4+RE=;
 b=TRdWiFLkap3wlGJpKFIlVRjMRl8oA93xnM7l9HBYjpx6Np7DXmIGuePNGjk4JvMzv1
 oFnT8IoPgIYR/uVwt3obuB0Z4d9vfAIb2BugPlSBf1SbLVpdTkX0JM95OOAPcqYXFnaK
 s6mG/87MqzbILZu05SwiEZrwS1XD1JcIaxJ1ZZI56Pf/Ois2OyCEO74pt7lefCKU1Ox0
 911uAcrXfSnSGGystp83Ph77PeVlVM7X36D/JWGKFWnwIRiuK3VqIFTdY3tw82PZQp92
 Ctjb63b+FlkQj91BL7UfWYGXrx6WzflmeYASQZaFECRhf6NxzEBDJQeRoHci+f5tYz+I
 +DmA==
X-Gm-Message-State: AOJu0Ywm85PowDKKsd8UuF8Q60oon5GY89ltvhqE4LLf9IohqYI0o4bl
 16/qgFVVGMxWVuH+MZYEXOqymZhw11OVqVDv9YhdDD0woC2r/GtjJsFwCTX2QrbZQZRfyqLYC1h
 JE5M/tMh8fyq7g5/01mGd/ghQmVcgqEyNtCllOoCBsVioWVYbb6CP5VwzkItK/Jjw5p1pJ7TYEC
 Fw5dDtr6rN5GWnoqk=
X-Gm-Gg: ASbGncteN/Z32ukKSx7nWc2huKchnx0D3pml6DSwZTImXbQ1ny5XmB+i72yohETVjAH
 Cqw/QcFUtSzMAe0znE1lPBZJydpwVwI2Pjk+at/j0pdAASuBu0y8l48kJZvsv+Zwj
X-Received: by 2002:a05:6512:4004:b0:545:1e2d:6b8e with SMTP id
 2adb3069b0e04-5462ef1588bmr875781e87.42.1739952958501; 
 Wed, 19 Feb 2025 00:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhIePsucb0ad0T3qfresKON8dKR7HyBPA2ATOej6hDJHleYsTYjWz76wKOR0Ipba2Qut8FNcQTuvwj20Zqp/Q=
X-Received: by 2002:a05:6512:4004:b0:545:1e2d:6b8e with SMTP id
 2adb3069b0e04-5462ef1588bmr875765e87.42.1739952958135; Wed, 19 Feb 2025
 00:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Feb 2025 09:15:46 +0100
X-Gm-Features: AWEUYZnN8LNVUcZEy0nZgHo4hCyC0rVtUh-5iryR_61dIzxVmFAZ_P6PPbotGdU
Message-ID: <CAJFAV8yAyy4W=6D+1MCdvW1NJ48Zc6Anh_HL=r+QC8C8cMGaZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Remove weak symbols
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com, Chengwen Feng <fengchengwen@huawei.com>, 
 Chaoyong He <chaoyong.he@corigine.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rpjl1SFl3ryVNdC0IZOjfy7pLDD76B8O8twzia3C_aY_1739952959
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

On Tue, Feb 18, 2025 at 4:37=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> This is an alternative to Andr=C3=A9 series:
> https://inbox.dpdk.org/dev/1735009552-31906-1-git-send-email-andremue@lin=
ux.microsoft.com/
>
> Weak symbols can be easily replaced with some linking updates, and make
> it clearer which symbols are actually ending up in the final binary.

Series applied, thanks.


--=20
David Marchand

