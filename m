Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A2C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 14:22:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2FA402C4;
	Tue, 18 Feb 2025 15:22:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E9F3402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 15:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739888565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaFsO+M5jWLvBmL8eiIjM/Di5szhDuMOGpfubL0/qJo=;
 b=a3mnGrTw7XqbM0SHzcOsNcBCMANMI4FxkQvjyP7h6WWPHETm9nF/IND3vOxPSdthoF+A6q
 pg9ogqlNKbrxv5uxZzFjidQ9Tj9Prv43/qHvwarYN/AkH2WckXOtJfCpHAGPB1fOr/AUKc
 2Y+oRrQum0iJjgMgHVkeU6ELPsj9/58=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-7obIahujOEuZiBxJofgaPQ-1; Tue, 18 Feb 2025 09:22:41 -0500
X-MC-Unique: 7obIahujOEuZiBxJofgaPQ-1
X-Mimecast-MFC-AGG-ID: 7obIahujOEuZiBxJofgaPQ_1739888560
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-309624acea8so14804171fa.0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 06:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739888560; x=1740493360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaFsO+M5jWLvBmL8eiIjM/Di5szhDuMOGpfubL0/qJo=;
 b=s0wmzKiDSfq3+kTRUTXSWgeRwx/fPBf3UHWop6kaVYf8jcLEhCjQ9pEL3YxY2Vpc/o
 cBcyOfClWotNujQmv1z52rmmDXzffwc0GO+vZCO4o29Mvq3gOnFivJFptL9ZUdddJl1t
 hOTsRcRPsfCeyUQyxHfWZay1pmkVpi7MQfXVpdbFYaz8MmZErVNy58BdbGNa8VX8R8iW
 E6UMxsD1wXA1qTfrflF7k+o9kBVHRlMQcSs3/RxkcRoXSmq3YCfOdudoW82UC3mumZVJ
 1sP+9CaZlAO89VtfR21cXOZTAQgKjdwpBZHN1Y5clwg5N/BLIX8e5NCY5JWEjpKofXGV
 J0EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCzU6L7s940CwxsLNJDK+j2EfYGnAz4+xTkMnbXSS45isHj4IYH+xlsB3FoV76dK0HTP4=@dpdk.org
X-Gm-Message-State: AOJu0Ywj0CAis7LcxLmre70y6tyGuwKKpee8N0a2ZM1fnLlrpdwlLG8m
 dW8H+JHTX6Vnt7BT7z9GlumZiKnCHLf+4iq1yJC7l5nMWnEHQo0g/1dkpyp9tn5jV5XcOVNPjil
 LD0iyyWFqosoHLPqT4cvro6P9UEJdjDvIKgAXswMzjYbohHfptkr21mSuWhFz0SYsGMNc8kdits
 rkJXHpg0Ms6ly2uv8=
X-Gm-Gg: ASbGnctBfYLcl5bSuqsVr2A0poOvgd8xQjxTn+xJyRUOtOIgpEgrBhxYrk6y60Z23qq
 D6OS7OI6qvNWqPnyJ39ryiX+PlbQ74uRMlBEPq9eOgN3mxp8mRDZo8bwcxpXP351F
X-Received: by 2002:a2e:9bd4:0:b0:2ff:b8f5:5a17 with SMTP id
 38308e7fff4ca-309288c09e5mr36688421fa.5.1739888560256; 
 Tue, 18 Feb 2025 06:22:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlUuZtXXuKTARdjh/n9/vEacNmaWAIu65ZExXCfVanaMaIPpnMjwNiJKNBH1Xs1uYDtC4D+h9g8R/kcog4wMU=
X-Received: by 2002:a2e:9bd4:0:b0:2ff:b8f5:5a17 with SMTP id
 38308e7fff4ca-309288c09e5mr36688341fa.5.1739888559868; Tue, 18 Feb 2025
 06:22:39 -0800 (PST)
MIME-Version: 1.0
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zzqa50xJLTk2gb2eZR2fSXNaLX7rHkEx_jdJkERk7Asw@mail.gmail.com>
 <4810322be9134e939513693ae1e88884@huawei.com>
In-Reply-To: <4810322be9134e939513693ae1e88884@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 18 Feb 2025 15:22:28 +0100
X-Gm-Features: AWEUYZmPEc4Kcerco6hhAoaCsyo89AQIiK3XeA3q10m3rWfwHt9OO8VWELAsqiE
Message-ID: <CAJFAV8zrcg3yy6c7_Fo5dm_g8KmBYPtGMvcZyaDq_jpYdu3=Sw@mail.gmail.com>
Subject: Re: [PATCH v22 00/27] remove use of VLAs for Windows
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EblElzGE8Jh3hTJVyfaqhPWWQW-2D_JH5RvgBO-aQDE_1739888560
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

On Fri, Feb 7, 2025 at 3:23=E2=80=AFPM Konstantin Ananyev
<konstantin.ananyev@huawei.com> wrote:
> > > As per guidance technical board meeting 2024/04/17. This series
> > > removes the use of VLAs from code built for Windows for all 3
> > > toolchains. If there are additional opportunities to convert VLAs
> > > to regular C arrays please provide the details for incorporation
> > > into the series.
> > >
> > > MSVC does not support VLAs, replace VLAs with standard C arrays
> > > or alloca(). alloca() is available for all toolchain/platform
> > > combinations officially supported by DPDK.
> >
> > - I have one concern wrt patch 7.
> > This changes the API/ABI of the RCU library.
> > ABI can't be broken in the 25.03 release.
> >
> > Since MSVC builds do not include RCU yet, I skipped this change and
> > adjusted this libray meson.build.
> >
> > Konstantin, do you think patch 7 could be rewritten to make use of
> > alloca() and avoid an API change?
> > https://patchwork.dpdk.org/project/dpdk/patch/1738805610-17507-8-git-se=
nd-email-andremue@linux.microsoft.com/
>
> I am not big fan of alloca() approach, but yes it is surely possible.

Can you please explain your reluctance?


> BTW, why it is considered ad API/ABI change?
> Because we introduce extra limit on max allowable size?

Yes, this is what was mentionned in the commitlog.


> If that would help somehow, we can make it even bigger: 1K or so.

Strictly speaking, it is still an API change.


--=20
David Marchand

