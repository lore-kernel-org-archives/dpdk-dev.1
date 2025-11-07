Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533BDCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 21:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F37402E3;
	Fri,  7 Nov 2025 22:53:43 +0100 (CET)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mails.dpdk.org (Postfix) with ESMTP id BDA8E40261
 for <dev@dpdk.org>; Fri,  7 Nov 2025 22:53:42 +0100 (CET)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-37a415a22ecso11699871fa.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762552422; x=1763157222; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EeT/+m6WP/Zxi5YDBFpvceQAszMXMiF+N+sBRUBVbU=;
 b=eN01bnL+d9qaL9NxJKpwXgPwf4aaBNpcWF5nrg/NNUg52EpNAwPuAG8gcnVE3BGV1f
 mBQrdp932Hp66lesiXSoSDrncJwvrFaa4KP5vSQE1FFy6IZPn1DLscq4uvZhHjRE1oIT
 cBO213766g+qXZMP9ObSRP2PPOv0RY1TwJQdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552422; x=1763157222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4EeT/+m6WP/Zxi5YDBFpvceQAszMXMiF+N+sBRUBVbU=;
 b=C8/XykjiCVT1soo+E8jEWaePDqR+dHHWGdU+YSvNRamXZmsnkPjokXaaQGOa41rewL
 WNgHrInqH9ver/NKiZr4HYLzZlKWjXe2oCYsWwcNgkK8KIYMVqO5NTPav3GLEU0Koirg
 47WL1f/uHbefAPkWkAplcxfstuCIJW5cBxE2ceR85//EWe8mum3mh7nf+EMSexsSNP+g
 tciNH20k6LwQ9JwQiZcoip5yeZW7f6hAQoWZmNc9QpUmReK6nKydoY2jLZewIkY43r42
 UF4PgzEcj7b3pYTVvFLMiyheJSMiT0MKZBlvCaPCIoH66KJ99wceHPYeFWeNej6r0ixn
 bMxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGqZ5q2L330csrNJLTtQgdsyVAtHTDBVZhzy+YGIq8AayeoynyIBnZUBQHEdZUeAuFlk0=@dpdk.org
X-Gm-Message-State: AOJu0YzE3AO0idoZkj7jv965/RMb0N5yhgZGu6R1KQxrL4hvDLa7LoeC
 phLaS6W2VMper4vtuZFIdk9bSCe5fqPV5aoDh3NnFh4N8QVDMUKj81Xw2I2z3+rHNs4GsB+B3kg
 MAufo14vKOZ80Ddd55sgPCoWtrVrpXK4F3UcSn5L0wg==
X-Gm-Gg: ASbGnctJ8dyQ0NqsnFh58iKLUCRvYAQXFcRR8sh3sUVJuQgapMsdMdGj7gvY5sO2ShU
 /PlxFH20MiRuYtKvvVmIGXqXeGrQGoGnFuK+HRfjonmt7e935fYED7K65AY6j4SvMX7mbyjcA8F
 z3fdB0G7oSfYQayoCNUrhJCAtB3hsDSSJfzR+ZKGbbgbiQI21gugraPu4mDq6sJfutdMJ2biKul
 AEQ6S9U1Fpt+G3PY1aHnMwk4AGXEH6cBnKlpmJo80EGRYRgQotOSx6aoz89HZeF3rNI/jSIqoA=
X-Google-Smtp-Source: AGHT+IEOgp1lWWQb5Hc78moMClzGZmbLmM1lrUApVW0F66odsr6H2rQTfCWO4sC3/l6RBtKJ6hib9hWfgKank8xAfhU=
X-Received: by 2002:a05:651c:19ab:b0:37a:3823:5a9a with SMTP id
 38308e7fff4ca-37a7657036amr9225541fa.16.1762552422058; Fri, 07 Nov 2025
 13:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20251024174702.600147-1-dmarx@iol.unh.edu>
 <20251024185056.607160-1-dmarx@iol.unh.edu>
 <20251024185056.607160-3-dmarx@iol.unh.edu>
 <CAJvnSUAHYDFrZ2cEZPUxdunAe95MpQbvwpU7AUtGFK9q+XRmKA@mail.gmail.com>
In-Reply-To: <CAJvnSUAHYDFrZ2cEZPUxdunAe95MpQbvwpU7AUtGFK9q+XRmKA@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 7 Nov 2025 16:53:30 -0500
X-Gm-Features: AWmQ_bkxFlB0F_UjJLdCIc7hvVb8witMVoIsDve-R94LHpqHXjHvfccvZmygjcs
Message-ID: <CABD7UXMC+XNBcuXNrbd85mD7jANuqLrx_zYmJQECz+2URCr2jQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dts: add virtio forwarding test suite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

On Fri, Nov 7, 2025 at 3:49=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wro=
te:
>
>
>
> Is it the case that if I already have tap0 created on my SUT machine, thi=
s testsuite will create a tap1 and then the testsuite will fail to run prop=
erly on the line above (because tap1 won't be brought up)? If there is no w=
ay of getting around this limitation, we should add a new capability for "t=
ap interface names available" or something and skip if tap0 is found in "ip=
 a" or a similar solution.

Yes, I've added a workaround which sends a delete tap0 command prior
to the testpmd session starting. If the tap0 interface doesn't exist
it fails silently and continues with the rest of the test case.

>>
>
>
> Otherwise, change the pvp requirement to ONE_LINK, set portlist to 0, 2, =
1 (2 is the vdev) when 2 link topology, and 0, 1 when 1 link, and set forwa=
rding to chained mode so that the packet forwarding works as expected regar=
dless of whether we have 1 or 2 physical interfaces the testpmd instance is=
 using.

Done

>
> Thanks.
>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Thanks for the review!
