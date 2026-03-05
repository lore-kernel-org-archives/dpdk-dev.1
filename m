Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327EF47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A2114029D;
	Thu,  5 Mar 2026 18:52:31 +0100 (CET)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54]) by mails.dpdk.org (Postfix) with ESMTP id 68AAF40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:52:29 +0100 (CET)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso8012266d50.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:52:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772733149; cv=none;
 d=google.com; s=arc-20240605;
 b=jSmbLkDnZ8Au73py6e40FR/mgjax9fh7dZ8K9fIHzmxTqXectWv0WS/stGMif24bmX
 yBacwfGaSx/aniULlONuOTnAgF0QHTfKTb24ft1IFS/G8obgRIpoULLfoFyVFs989tt+
 TnlELlulzxqnNZLgmJIbMlN/KpX7oI6we0wbBcLFK05GtmKNaA0kc6Dw5AzJ2QbeD88B
 PvSzByMB+18pOOZsyBu2+8jj+GQFYDNKLNsCOyEdYfUM45J2RuTsXP85gh6ii7Bmn2rz
 N0zyY6UwpE45T8IZLdZ0hKfAgvosWgks0+G1Lq3lKCW+nd/sWYj/DpXqfhlHjfwDYBxh
 R4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VdSHj15qXUkCbgoINsa80MRrJQJFGJ4qssFtT6OAYco=;
 fh=3r3rQZ2WUHhFkB/zVbqwVKwO8tWcnd4mALVow0p3BkI=;
 b=ixMDPNvDkVio4/aQGjopUrxZfE8/FLMWHNafA+vYNlGr3CrLPz4cWc+BaKs6/OMFrr
 hDZ7mqHvbOqzuYzIxwh+ZCBa4JApj5EpuTsK9ogtAvsyDQU7aX7P4Lh2UButst0jw2GA
 cVgAhRb6CxLAA8vEwPgUjZSj5mQKIRKbJ+VFT4CBzi0qOBogxmPKwljQ2N8Bu8I/W77b
 dzTLe5XPtm0qqIT7XOEiAoE1H+ObvvYaRmBHMmQ/m0bGKnqKgwNCtbqQHQHN3JEMbiLR
 YAwkrJpv85gMFYXH73dacI0ix8xLNa4scnPV2Hd7GJrZj0FhcsdXMqBPT0I3qorjo8ji
 6WFA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772733149; x=1773337949; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdSHj15qXUkCbgoINsa80MRrJQJFGJ4qssFtT6OAYco=;
 b=VX6BwtwHqTA0h6A7wE01Etl72l+c74z8w4pZM1uYU4PCJukMpARFYgoonnSV3Py9uW
 H7UCBhETuGwkxyZT07t95oksBShrP59dFCxzFVjQfQMYrvN9wa1IG+6uJpMifWbHOaRa
 qJ3Y89YXyNahJOpeaBRO8v6dY7NVw3+ypM3dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733149; x=1773337949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VdSHj15qXUkCbgoINsa80MRrJQJFGJ4qssFtT6OAYco=;
 b=CXH950VX17rd7H4C5NHIir9D8keIVl72X5koyLpMcqLfTT0ohNrua9RKLwoe3WuRqR
 bibZEHW1wkyV1qj68emtkfyrfBOLuyPyERq82wnLb+iG+Z3b/agPp1cXsNWlhLtqR/hz
 r9iBmFHTBh13neqlvXS92cmLx7qTynqCB3X0I+bNeGzFxJiPsjwREpZExRNFdBguzUyc
 hVXEREew8IMrZGffZ22CYdS7f84YxRnttI5Ng/m8+24lz7WoOQxl4X3JP8eOBe+ZVI0d
 bomqHmkfZxMZxtYwb9Fouwf7ztQAhF631KoFiFeMGUyFL3vFaScQF0b/OHYv5lKU/z8b
 PfTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF2S+L08HQiO7dRzoB12qG9NkUIAY+n2rb5ASxQw/hzU4bDNzSeN58BMui/rJHceLpPKg=@dpdk.org
X-Gm-Message-State: AOJu0YwoqWzjHhJJiR0nNh2SbtJiJDj28ibhahvEITxYpu6sqnpjTNI1
 gjz030BqK/Z9R7JYUjO4YU549fpTI4rWYYK6k32qy5cgcU/87VOt3IkFiZxFR+VaOKahfSvbn26
 uxkotFQxwBGpjECffSvT3LcqOTgprPvwUywP3I66g0g==
X-Gm-Gg: ATEYQzzk/1CgUcXp2t5hDnhhE7u6MzfApNLPRwpKCLJmInMOmm3QNgLFkEBhtoc+zYC
 Ed5ON6zWycE0k7UrVg+w6NEYZuPl/2NdRPtua4wntIMpQoU3Ux/Sg5UF9nzam87D7TAteoBC5O5
 yyjeHZ3yV75JjUs1CcNUK9jpL73aTbhFzKM/H0Vx9MJSIqraXHKw7t+tdrSfDzvUFmkWabHwya0
 MNhBJ2qgRDN//9I65qc4Tst63q3nkv4oPRR0nB8uec0RsUqMYYN/XMdi8HA2ie1+khx3q7ET/Gr
 OhJ2VH0g0XBzfqokbYPmgxAcT775qd2R
X-Received: by 2002:a05:690e:408b:b0:64a:cedf:4a3c with SMTP id
 956f58d0204a3-64cf9b5f929mr5621257d50.17.1772733148631; Thu, 05 Mar 2026
 09:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20260303170136.509304-1-dmarx@iol.unh.edu>
 <20260303184131.514380-1-dmarx@iol.unh.edu>
 <CAJvnSUCYgph9OuFS7fWkyu6kLOqxoA7QZPjB51_XMZv-am7LMw@mail.gmail.com>
In-Reply-To: <CAJvnSUCYgph9OuFS7fWkyu6kLOqxoA7QZPjB51_XMZv-am7LMw@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 5 Mar 2026 12:52:17 -0500
X-Gm-Features: AaiRm51x2uf3hT-kPAVaoOrCXj2PRPhLXzXJAgOn_ibp7vwVJJH1NCcfKm6MzHE
Message-ID: <CABD7UXMwht1WacxRG_tjVVo63t072L1r4GDEpDKv448dF7tqHA@mail.gmail.com>
Subject: Re: [PATCH v4] dts: refactor flow suite with generator pattern
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

On Thu, Mar 5, 2026 at 11:50=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> wr=
ote:
>
> > -    @func_test
> > -    def drop_action_IP(self) -> None:
> > -        """Validate flow rules with drop actions and ethernet patterns=
.
> > +                try:
> > +                    verification_method =3D getattr(self, f"_verify_{t=
est_case.verification_type}")
> >
> > -        Steps:
> > -            * Create a list of packets to test, with a corresponding f=
low list.
> > -            * Launch testpmd.
> > -            * Create first flow rule in flow list.
> > -            * Send first packet in packet list, capture verbose output=
.
> > -            * Delete flow rule, repeat for all flows/packets.
> > +                    if test_case.verification_type =3D=3D "queue":
> > +                        testpmd.set_verbose(level=3D8)
> > +                        testpmd.start()
> >
> > -        Verify:
> > -            * Packet is dropped.
> > +                    verification_method(
> > +                        packet=3Dtest_case.packet,
> > +                        testpmd=3Dtestpmd,
> > +                        **test_case.verification_params,
> > +                    )
>
> Is testpmd.start() only being called for queue tests, but not drop
> tests? Do you need to pull the testpmd.start() outside of the "if
> test_case.verification_type =3D=3D "queue":" block?

This is odd, it definitely should be outside of the queue block, but
looking at the logs testpmd.start() gets called on the drop action
cases anyways. I'm not sure if this is automatically called through
send_packet_and_capture or something similar, either way I'll update
this so that start is called in _run_tests for all actions.
