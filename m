Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34326C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 08:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D5FB4028B;
	Wed, 19 Feb 2025 09:09:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1EDE34025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 09:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739952582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8DJNlCDUCimZfbL2vPRu6wqbbrfS00Qfp3hEeCFNs4=;
 b=bhIZJERSJo3FLbHUhOzYZZKKwZDGuuxa7yj2mYDLHmoVXg+LkZNvSCP3zCjnRUeylzKsts
 eVrwU1GhKtzM98CEQx0snhNGghvW019zF1uJpFwBcKphZqeie4b5BxGPeIzWCa5d0zpjGZ
 Fcz+5RWdDYod8svQVRvgdZsaeHvgnSo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-6OZLo1M-N1ecits9f9L2SQ-1; Wed, 19 Feb 2025 03:09:41 -0500
X-MC-Unique: 6OZLo1M-N1ecits9f9L2SQ-1
X-Mimecast-MFC-AGG-ID: 6OZLo1M-N1ecits9f9L2SQ_1739952580
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3092c611f29so19056271fa.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 00:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739952580; x=1740557380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8DJNlCDUCimZfbL2vPRu6wqbbrfS00Qfp3hEeCFNs4=;
 b=bHJ0VVHG78b5X+XAQ2C24ouWVituIgn0KM9aLBD9QxX4+XpDU5Q7evoYYTZBxS8zTL
 V9s8pdLHA9ri8F5Mt6i4OY5ogv7Il7K4KezZSPHf9C1eIsTJzfwW8tvq4Bd3YWf/CHk0
 PFGgJHE7mPJppxuvp/cS2kaQwVa7SV770u2zB5WPw9h8u7PaXd2lv0KJ1WhLSBXYh5SU
 R7CeDj7EdMyUaWRZ5PwXUGyNp34DKd5NoNuxhTMx/pip5hX4OmzYQjQP4zhj4phWnFm2
 9UvOOeXhvdvQnzb2LTG0CzJg6FRsIoD+cO2SDQd4K2tqK6AHZNRCDgghSkRzcLPAbYPe
 wM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo7bKNmKrHtKqapEIdrK/24EYOKpiCFdvhVkSzwwzLo86cUIiUe/DgAVXD1Yd/9fFJ14c=@dpdk.org
X-Gm-Message-State: AOJu0Yy9QPKAsxOA6qD0itOsdt1htRsU+BV1vh9ZUvyekt6NBhbXg68i
 T21eC3gcATO2ccsdwpuNsQ7koPpa66YX/WzEEwYqqObRujoqUxjLn6s/PVTergNxXBpMkIcrobG
 KrB9nIkgI9sO1z9O0ExKi4BqNr4LbT0V6NFCFyWmuykymzCWVKyfLaXEBVofYrc8xDzWJeSr+Wm
 IVvsnIvMvknzPOsFI=
X-Gm-Gg: ASbGncuLkLA3e3nN8RqLJSJX3muyxHl+HQatLs7GOOsJ62eFf4Kz4fEMatVimraGu9Y
 QdeDKmJsB3TtpOkuKsmoZegjKSLTyChf8vc1LxeQdmZr8mhLZK7HiK5mGHyfSC8C1
X-Received: by 2002:a05:6512:1092:b0:545:ee3:f3cd with SMTP id
 2adb3069b0e04-5452fe2f265mr4424024e87.9.1739952579754; 
 Wed, 19 Feb 2025 00:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeVThBtncMP5eoN+eS/N4RnC4klXzznvIpuIM6KkaBQmiIzlIkQFPh7MGraXjf/t5UbzszgH7CngOKF1Qywdw=
X-Received: by 2002:a05:6512:1092:b0:545:ee3:f3cd with SMTP id
 2adb3069b0e04-5452fe2f265mr4424010e87.9.1739952579402; Wed, 19 Feb 2025
 00:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20250213075010.2670431-1-david.marchand@redhat.com>
 <f7teczvbcph.fsf@redhat.com>
 <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
 <20250218153508.GA20690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250218153508.GA20690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Feb 2025 09:09:27 +0100
X-Gm-Features: AWEUYZlFXRikmqaLYb-Czj4E_JJ8LUksEGRHvwuAmu6DT_TI-nNNw_-T1C80T6U
Message-ID: <CAJFAV8xWNv5CX16coq1qBwxjY0r3Wg21giXZt5_uA9WzkzTq8A@mail.gmail.com>
Subject: Re: [PATCH] ci: build with MSVC in GHA
To: David Marchand <david.marchand@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>,
 Andre Muezerie <andremue@linux.microsoft.com>, dev@dpdk.org, 
 thomas@monjalon.net, Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ak4hy7a09HcRZKHfm5U_QDcIVVOPBUDo2F9b1TqMYmM_1739952580
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

On Tue, Feb 18, 2025 at 4:36=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> > > > Add a build target in Windows 2022 for MSVC.
> > > >
> > > > Loading MSVC environment and having successive commands in a single
> > > > (cmd or pwsh) shell does not seem to correctly report if one of the
> > > > commands failed.
> > > > For now, load MSVC environment and run commands in separate shells.

Cc: stable@dpdk.org

> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > Acked-by: Aaron Conole <aconole@redhat.com>
> LGTM.
> --
> Andre Muezerie

Applied, thanks.


--=20
David Marchand

