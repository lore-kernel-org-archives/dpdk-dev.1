Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:25:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0770340663;
	Wed,  5 Feb 2025 18:25:05 +0100 (CET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id E3877402E0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:25:03 +0100 (CET)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-30224cee64dso33841fa.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738776303; x=1739381103; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdncLNwuoQR/mvCEtZc5fV7Nu++JULNkH80DgciogFc=;
 b=N3Rp65kp+jHAnYeEMc/eGuzoiyuniSwmwAd7JcPK7zr7UOnHwKRrfEQX1IeXg7pCO6
 6+dZElnc6/s3VyX+Ji2Y+rMhzXcx4cX/MfntQTpus8U63zHkODbZtfA48Liq/oz7zk9l
 MCSaiQQr+p6AnGS+IW+aB5doBZeubW4+wlQVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776303; x=1739381103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdncLNwuoQR/mvCEtZc5fV7Nu++JULNkH80DgciogFc=;
 b=RGwPCeE1OSzDVAWiABL9BMKRJl+16TPI6hk3YftmoAjxJu2O0iQJxP5uIXcnwdLwzm
 t296QsY2H7JEwNkhBG7Zpq6FdaCM6qQErRqnQngs9iEyuw/sF+me+G3PwUuBHkCKI+Bg
 aHjhW2HMjXDaPceS2MAGcCf13toSdkKVCAx2wib9gO7QdpSOagb04wkapNEYoRNIZ5gd
 EY1wdeOqjNXbpUCqcurcQEyPS1Hs+9+aV0oz66PDiGNH28tVYUglxUsrzL2/uHpzRBe5
 e+aOY6vN+S4ZtFvWCtVGCcXAuil5ijn4OoBBy3371YF5pmsuF3KLR8onrdHSdaxSlGov
 fceg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU6+kavN9opYI8mql6rVnkZB1DMpy/xarGUT9EMd5Fzw2wD9AfnN5LPO7vqa3G8HrMJTs=@dpdk.org
X-Gm-Message-State: AOJu0YwrJ2sI532WZVUmplM9LOoc/ei9R8JesW4p3MFcFX0Sj09ryk+C
 XczEyMDIVygJaIpPzC6lpxSc6JGcPQnFrm863XZG0hO2FnYOa85BhykQdSbXw9Zypol2ciJhfet
 zUm23qB0jB1SvBnLwFLYE1yBPdVnfJz1ugCzC9Q==
X-Gm-Gg: ASbGnctSeDyS7G/x1ErSiXb/VRlJreLFiuA0jzTbClniIs+GQ1Q5ZEaLZhzHiS2k3xD
 gHulhvx84nM1/c+RiNk7gghT+t3Immq01+mI2LEMsunvlq2lOsmicUAbO4imhk4a0lR7LxIPK8e
 xSGvej+0Ryimqahx4R1WvWeemWzPVKxGk=
X-Google-Smtp-Source: AGHT+IGVj3OQVTGrtXXWr4cz8f5jbHKpy58kNCgT44fdkNF1AkdHN/2hD85OXdpIbiwNcYBdjF+HAjH8653n3T6Q3rs=
X-Received: by 2002:a2e:a592:0:b0:306:1253:1d5a with SMTP id
 38308e7fff4ca-307cf242d73mr4926251fa.0.1738776303257; Wed, 05 Feb 2025
 09:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20250131193803.168498-1-npratte@iol.unh.edu>
 <20250203163850.249461-1-npratte@iol.unh.edu>
 <20250203163850.249461-3-npratte@iol.unh.edu>
 <77ef65b2-3a3d-489a-a4da-474d181193a0@arm.com>
In-Reply-To: <77ef65b2-3a3d-489a-a4da-474d181193a0@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 5 Feb 2025 12:24:52 -0500
X-Gm-Features: AWEUYZk9AqMTkBR-f40PLG2E-pun-UU7Oi_4nT7GejDMgRWdy-THz6R0n11PJx0
Message-ID: <CAKXZ7egr_0cidsW8gihuDzqn7dEfLff9yD-+XQ1wBQMA5CjC2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rework run-time MTU adjustment test case
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Honnappa.Nagarahalli@arm.com, stephen@networkplumber.org, 
 thomas.wilks@arm.com, probb@iol.unh.edu, thomas@monjalon.net, 
 dmarx@iol.unh.edu, yoan.picchi@foss.arm.com, paul.szczepanek@arm.com, 
 ian.stokes@intel.com, dev@dpdk.org
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

My bad! I'll fix that real quick.

On Mon, Feb 3, 2025 at 11:51=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:
>
> On 03/02/2025 16:38, Nicholas Pratte wrote:
> > --- a/dts/tests/TestSuite_mtu.py
> > +++ b/dts/tests/TestSuite_mtu.py
> > @@ -164,22 +164,33 @@ def test_runtime_mtu_updating_and_forwarding(self=
) -> None:
> >               # Configure the new MTU.
> >
> >               # Start packet capturing.
> > -            testpmd.start()
> >
> Sorry!! you forgot to remove the lines above until the docstring I presum=
e.
> >               testpmd.set_port_mtu_all(1500, verify=3DTrue)
> > +
>
> Looks good otherwise!
>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
