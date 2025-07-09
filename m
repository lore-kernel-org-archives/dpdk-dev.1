Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC35EC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 09:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3337D402D7;
	Wed,  9 Jul 2025 11:31:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 58821402AE
 for <dev@dpdk.org>; Wed,  9 Jul 2025 11:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752053483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jvp7Ha8b0ZGThExcanrP446FmPc1KNI/qgMbaBACTWA=;
 b=YWE2gDFYJL7sCv5NezpBgxJWnm1PExtdMyko8bkM8YIxEmLQXhbpsk67lZV6kKG2F1SIRH
 Aqr8NxBXovaToYHIKOW1hbKxfMkGy77sF+4yd7QYySC2AVSU+1YMaiMhYi0sjUkhp6rlhi
 +AthGYr9yhKI5D+rShlEfeVqMz8PW3I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Ve1gNTV-PMmMNAGSxcp-LQ-1; Wed, 09 Jul 2025 05:31:22 -0400
X-MC-Unique: Ve1gNTV-PMmMNAGSxcp-LQ-1
X-Mimecast-MFC-AGG-ID: Ve1gNTV-PMmMNAGSxcp-LQ_1752053481
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-557e35aad50so2812487e87.0
 for <dev@dpdk.org>; Wed, 09 Jul 2025 02:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752053481; x=1752658281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jvp7Ha8b0ZGThExcanrP446FmPc1KNI/qgMbaBACTWA=;
 b=iETr61a79nNzL92JftHVGcevjGqg9Mm4CKQNjhJNID7VhDpkHy4pDATRgH8MwBflh/
 YYJeozxJlCcbm7J3X9qlimEC87J7Md16qwiH/+4n1IJ2J/AJoy820ANhWXrphYsZ9lX+
 x5bJ1/dQlyojGF9BJQ8U1APKcHHsdcw7A9/Q4uejtrxm340NukxImvJbm73jfGm+g2QA
 JTZUGVA4NHmJy+D9fla0KJpcD7dP4mN+zyxfwioUWR9RS3eg6hXq71CzJpBZU9i9zeup
 3SZFMlIfrrTFpyZirDTLo14qQ3j1HenI/X2C0VaHekcQHuFajoPQMFoBHncOP/mZrOfm
 2I8g==
X-Gm-Message-State: AOJu0Yx2n+VI4wef3frpCnMyu6bqyiZNco4qnNo1uWJHHtR11j4kyDcL
 4RvFWwBRfq0JrlSjJfTm6/jozVUxhfPGpmL5w1B5I/Malu15PvRmKIxpjGj4uG/hJ4bEhG+1cDP
 zG773dyifSEQlpARGdicT3zToBoELYS0jiQYj6WtmNZDdiPaduyvt+ukMpGfba0IRDbP0IdY+4b
 PwROt0JYMxS0ry9ADTfZA=
X-Gm-Gg: ASbGncvgRfjZvRCo9Lrv8gCr2fG1gONSDMt1Qnt31VzNkXPI9py4kxeLuhQ8/VTni3I
 3+InYiueoVlSFQK1MrN6flGIddB8RBgPpMXpYuDKQfJtTiz9p8BeKtPmQGtJH5DHCuz0v3SMMkQ
 N8W0jsoQ==
X-Received: by 2002:a05:6512:3041:b0:554:f79d:ce4e with SMTP id
 2adb3069b0e04-558fa9020a2mr717018e87.38.1752053480709; 
 Wed, 09 Jul 2025 02:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4wmYday1cVCIzravOmt8BI4qAom1+mvQIZgqOzfnl/eFy7ma/CVGR0mHwtS4oUTmU2AR8ffFNmuvcOXqpBes=
X-Received: by 2002:a05:6512:3041:b0:554:f79d:ce4e with SMTP id
 2adb3069b0e04-558fa9020a2mr717001e87.38.1752053480222; Wed, 09 Jul 2025
 02:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250708142305.3636707-1-david.marchand@redhat.com>
 <CAEyhmHRsNi4ed7dTMswGBBm5dX4aQ7+p1cfmGsSvBVXciOKQCg@mail.gmail.com>
In-Reply-To: <CAEyhmHRsNi4ed7dTMswGBBm5dX4aQ7+p1cfmGsSvBVXciOKQCg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 9 Jul 2025 11:31:08 +0200
X-Gm-Features: Ac12FXz37WYg3x-4f4hrqplMbcTbLxUmpivCDay_t-90W8BCHij9RzdmXjO4hVc
Message-ID: <CAJFAV8yRaUKQDt0f2qyb5Y7MHcNUUSxaA+QuYRF7JwwyX8f81A@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: revert Tx free threshold fix
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Baoyuan Li <updoing@sina.com>, Hengqi Chen <hengqi.chen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -M0aXkluKWo2ZgLEJ7ILRQVysdS7y4WFamjgY3aLhmQ_1752053481
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

On Wed, Jul 9, 2025 at 3:34=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Tue, Jul 8, 2025 at 10:23=E2=80=AFPM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > This fix introduced a performance regression.
> >
> > The problem is under investigation, but we are too close to the release
> > (and the virtio/vhost maintainer is not available) to get a fix before
> > the v25.07 release.
> >
> > Revert this change for now, we can revisit during v25.11.
> >
> > Bugzilla ID: 1747
> > Fixes: 3e3c7f3fa5ac ("net/virtio: fix check of threshold for Tx freeing=
")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

Applied, thanks.


--=20
David Marchand

