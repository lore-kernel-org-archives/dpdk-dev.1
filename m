Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB47C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 15:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D9D402D1;
	Thu,  9 Jul 2026 17:03:28 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6298740268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 17:03:27 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-51c0cea8883so8681591cf.1
 for <dev@dpdk.org>; Thu, 09 Jul 2026 08:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783609406; cv=none;
 d=google.com; s=arc-20260327;
 b=JObDPA8ds7IlTZfneJmiq2c1Ea7XXOvfzzZJvW4elnByQyQiRHJ+YImMdxBGP93v+T
 1M9B7A61D81g4/o48kVlcitdayT2BqrwD/C3B4FoT9BdJA7F0xRLNHaKCYjn7T5U6+GG
 +qpd1IZ5SO3DMb96dord5qyVAG9ftdg5RT3Cir2PeatfdNSlv+5ZShjwDh1UD97VvarD
 427s+b5NWTaGeHI6Oj51gSiutY+0MlfLsgMzRR49N2jZEyqYcOG3ShUyVaSItiVoXl5U
 lC67IVSQ4PGd3mrqL/0XC55Z75VS2LU0/U4rHFx+E0zBczusrGsr5jxMdyLtnq6Vgw2g
 vJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d9I1ZilCGn333LgxlihHm3ZQG7nc5gzvXmi/vhV0dv0=;
 fh=9ku+K6IBHjOpNw0/KhaLc3GKaGOydv8YDviibEb7UQY=;
 b=UPkt5Skt4IddAZlwc52RtYrfs2ijghfTsJANvXxqkfdoXxS7Z6KJNub5lRNRPAIXP1
 Q4IXc17O6x+z4ssz0p1+1sC3R4s2rhP5lsWMEDVfbd+xFqnuorpsxA1zy3fxS6zksYrY
 SjqWVVryZVPzGL2dRtDEGKZnH/vmU6rSB0dFLCp/B0OtvR0i9F7cfciDuYvzSKOK1Y39
 fe2zYjJq+fl6GgTIobAdlIuCOw0sNE4GI9v/g3VcrsXr7nBbBhyAPxPR7mtmkGDetXzU
 jsVwHO7fdcEqdNLaILbLmLTd1k3iPR4OdHhzLlkwqrq/ogMbq6QlywnvOyxDmq1tCD3o
 5D4Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783609406; x=1784214206; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d9I1ZilCGn333LgxlihHm3ZQG7nc5gzvXmi/vhV0dv0=;
 b=RT9mPUEPiHr6DbX8XLVykfLYPHYERsnDTslPpqv9GPIwPMDtV2uRN2RP56swSwCpHI
 fbBtN3O7OS9mL20SF7QoEUVDoq0UaB9fZnqCvlPUDLzyD2syyroXeikwrevN7PotUv3o
 MrjKtHtmLZv+UrhINgAl5PKXDFCNeAKSh/It0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609406; x=1784214206;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d9I1ZilCGn333LgxlihHm3ZQG7nc5gzvXmi/vhV0dv0=;
 b=dpGhBMYtQJtxd4jwt0lq8xrsua8JObASMsHckRyAZc1XHGvEe/h4NFmeMcHL1bz7MX
 r4P6ho97kBqRv6AEy4NiZiZ2X3rgLSZbRka68JT8e1G+f/4cT/SGbRdfCKGgO2LbMPXY
 hLnhQo3xi1VjvucvT1vLVgXJ//1Z795vYfm5P+SYnV/H3n5Eq3e+onrqyy6eM1r+En21
 3dYdKLMr/4ursPa2QFE7U0o6Avh3WIVoa2DNwhsRo08CSYeMxvuTq9hm+9Zny1+m7dU3
 xo/8GE64kUmYHA+g/qaIC+qqnCC/EwewfSIJqF0/3a8Bp7H+FW/LIz66ZFyR3Egu9DQm
 lf7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrW7vu4g6ALVd+XLOX/aZW4FctqapBFswd94bcm1Qke4MbDd8WtHN6Fof8phQ26DEoiLos=@dpdk.org
X-Gm-Message-State: AOJu0Yw6rFSURI8XLLHu7yPmsMN3ty90IQqA8UcrQOOJ6ChUR6NENb6/
 VhbG1S/wA4Csa1I991Uho0+En6K7pJ1l/0vcFMWyjEaicOLZQaeh8Pex+Zdxzd+tio130QkKF2q
 n+9m2rRshOegI3gMTEut29mzZIYaZ7sZfWKVOBLpToQ==
X-Gm-Gg: AfdE7cki8fLjeGIXu2KwnjQdmnFrh08TPjevLfC+7C4rPJrcrewVXw/+gy9JRhMQXat
 0X5+w5cKmF96HUhg8vczhzSWZPzn157ovEavh7kAKPL5wSreAqNfjvFWzPWJG1FoBIEoGBLA4pe
 cYDnUdEh1j6hKIIWm0alzjn+49M8XOq3X4uuqRyx5wIxDYFhNU4KEsouABP56tgNRgxXxAozm0L
 +pEgV5MvGWR3Q/PEZS/V5ytxqKG3GpdjvJkOmhDmwstuj9i/PsTvTlNEcMy34KT1yGRYbArJXq0
 QliOBVZP/1paCsmLFzeHogR6TqpU6PjvksagLshkMr0Ho9ZOrhHuZko+hkaTSxNPMIxxM3WDcQX
 Vph1r3Do6KSFYp3FMtHK6O4Zn4a7NSCWpXoFMseVJLEOPAZHZ5ciKGtZGKWxk/g==
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id
 d75a77b69052e-51c9ba21545mr31032591cf.41.1783609405949; Thu, 09 Jul 2026
 08:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260625181557.2331771-1-knimoji@iol.unh.edu>
 <20260625181557.2331771-2-knimoji@iol.unh.edu>
 <CAK6DuxuiK4h8HKXov8vMam2k3-HwoyjWyWAxC_7qMTFXbDmdxA@mail.gmail.com>
In-Reply-To: <CAK6DuxuiK4h8HKXov8vMam2k3-HwoyjWyWAxC_7qMTFXbDmdxA@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 9 Jul 2026 11:02:50 -0400
X-Gm-Features: AVVi8Cdhw5qUv1u4xbpxR5xZvmlTtfreOmaqnW_mqNp679A6efjny6k-9yNp974
Message-ID: <CAKYPG+zRZY-4NcxoLmO3qJe43ZCks6ipwAv3mSGFK22g1pqK9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add build arguments to test run configuration
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000000f5a0206562eedeb"
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

--0000000000000f5a0206562eedeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree there are some valuable suggestions in the AI code review, I'll
look over those and get a patch out by the end of the day. Thanks Patrick.

On Wed, Jul 8, 2026 at 6:14=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail.=
com>
wrote:

> I think the polish on this patch is okay but also there are some moderate
> importance cleanups that are recommended by the AI code review:
> https://mails.dpdk.org/archives/test-report/2026-June/1011807.html
>
> If you can't get time for this before RC3 I think we can merge this
> series, but some of the cleanups (i.e. safely handling yaml string vs lis=
t
> of strings format in the test_run.yaml) are valuable and if you can add
> that either right now for RC3 or early in the 25.11 release window that i=
s
> ideal. Let me know what you think.
>
> Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
>

--0000000000000f5a0206562eedeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree there are some valuable suggestions=C2=A0in the AI=
 code review, I&#39;ll look over those and get a patch out by the end of th=
e day. Thanks Patrick.</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2026 at 6:14=E2=
=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patr=
ickrobb1997@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">I think the polish on this patch is o=
kay but also there are some moderate importance cleanups that are recommend=
ed by the AI code review:=C2=A0<a href=3D"https://mails.dpdk.org/archives/t=
est-report/2026-June/1011807.html" target=3D"_blank">https://mails.dpdk.org=
/archives/test-report/2026-June/1011807.html</a><div><br></div><div>If you =
can&#39;t get time for this before RC3 I think we can merge this series, bu=
t some of the cleanups (i.e. safely handling yaml string vs list of strings=
 format in the test_run.yaml) are valuable and if you can add that either r=
ight now for RC3 or early in the 25.11 release=C2=A0window that is ideal. L=
et me know what you think.</div><div><br></div><div>Reviewed-by: Patrick Ro=
bb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com" target=3D"_blank">patri=
ckrobb1997@gmail.com</a>&gt;</div></div>
</blockquote></div>

--0000000000000f5a0206562eedeb--
