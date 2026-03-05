Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633AF3D33C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 320564029D;
	Thu,  5 Mar 2026 18:17:08 +0100 (CET)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by mails.dpdk.org (Postfix) with ESMTP id F220D40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:17:06 +0100 (CET)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64cb577e79cso8747902d50.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772731026; cv=none;
 d=google.com; s=arc-20240605;
 b=BCUoN4YGv3VzVabpJtYfcpn0YRMgeNKPjsu4JGKiAQ1Q2szy7nWJP1IJr8mk4wlWle
 bgBR5YxYT2qXhY1Opvx4fu0260wdcIcZoX0JpJdn5VHlRP41IzUddJXNb+ukcAHg4Ftc
 Y83cZKQrYTKw21dv9u6KSmUvlIj1wRL8QatIwpkkYaaKYB8/Hd88NIz16Ger1BYz5hpk
 sTA6iQAz80FlT0ONJGlhbuVhApVuIq2tM/PsIiJhfUeQZ1kQIFxhrMzqUN3O97TCYTR/
 Upv8ls7UbLrI7CxyuSR/UhfvHcOJ+M4NC405hwvN0+ykoq+EA2IGqwuPBz+/bsoEXXuA
 Y6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8FaqFaU83qae7m6zgyxzQsOQlv2NM8i4JCShr9wSf8w=;
 fh=CSEddOqJAZO31yaJPqNdqswyIYLuI09OkyhI4mP5Zi4=;
 b=U5shfpt8KmXHZqD0UAPUaZj65Ie1FJxHdeXNYNhF9sci/Tg+8aEq+QY75KlnfRQLzY
 Ct7i73V/zdZnnjydEtGjCnNsU8QuHLiXyFMNQzyctowsMZzfzGStsZf4BQ8g8o85pFn6
 xAEeRaLwOu/B62ieN3EKgnKMg3ml3yXWIpgie+Ku0Wj5z1ymGqHwUpYLmQyZtjCNKZtQ
 ymVQiHcBcV8ZqPiLmrzySc0oK/+NSlAA8/pPVGyNcYVGMee+PlDsrq17CLC/ISUUS26s
 AGJHrB6DRcixtHzGfb/vnuXbEQe3rhEVSzvgvk5bCPdQ9SqkPwkbC6pFBY7n7PI3cXMA
 E8CQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772731026; x=1773335826; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FaqFaU83qae7m6zgyxzQsOQlv2NM8i4JCShr9wSf8w=;
 b=Ozwp/27a81nc6cAJIOi9R4EtVCjyeWFbV6GRL2NdZgDmTqhaVG7YviVQv2zXBD7k3M
 ltV8uhBsLUc4VCW3GmM1JpDr4eJ4C5s2lzUVNfxEev7L5jlFjp0SZmtskbhFNUuyfrvP
 cC6yadE8VdTmLLQN5zQn1FCC0oiOWP6Tdj+fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772731026; x=1773335826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8FaqFaU83qae7m6zgyxzQsOQlv2NM8i4JCShr9wSf8w=;
 b=FRj+7uls3rYk2OwzHvwSgcQE8O/YDgHphqdj/DZTMeFwqtHpyWDKWJEXNucmFQTdmx
 Z7gY6nXI5iotEKoaijh1ME2EAEu+plmLVbcJ9GPL0uUQDNHPff8QcUAsIkILD3rImf44
 Q5kkM/aVeXYyVjrDYQ7BmyGCiEk0C2Yg/aEZ8lkzUQJBXBG7hLs0KqdWRXTqSFvIw3a1
 TsQubfuKr27UyIJgrkuPdtFja2xJRde5G1z7WPqT8baFXiksXKQXiZTNnxYeFOcj1+sS
 bXPAGAetRuHTZoIPtiYNEUOEM/3MnlpZ9vkcppsgigLPOsNf1LAH/BUyriYEYSbywewu
 sCsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuPq8wdF4vJilV3M5Qmy3Fe/5LvuBx6rUPsWtXSFVjhYrG79B5viXhA0BBISAWPIJkiFY=@dpdk.org
X-Gm-Message-State: AOJu0Yz2iIG2at8DSF/AGNZgUgIa6uWBMZObfdK8fRgPPnueF2ZXHnyR
 vREE8IMocdh1ccaTj5NvsszAk8UC36LkOmOxfUEUNQ9MVPxEgEJSIsx0XQmuJ1ff4l8XLM/4ohP
 oMjNQSopjijHIZUWY2i8r7kF8A19VUnVTB2FnBqRO2A==
X-Gm-Gg: ATEYQzwxoc2gM70y7R1/ndDCi895OPwv6y+Bc2115COstqHEAL8a17ft4IKjJVZdeNr
 WqSNsVwcvU0QavqYaOAunnshg5SL8A/5ME5pJWdKUNjeWWdoBKK1SSAfGOB+LJT7pT81yu2u+oc
 TCOit+Q00RdHE69XSeb2OhHzwhbXvZ04XMe0+GPgYz4FomamdmVhj+BMt2Q3oy9hchYhcxzQYP0
 CBWqTxSS5dVT5hv6dIxQhTn1YDKzbAlG1WlKU9irJm5YnrSp2xyd4T5h+A6iDjWXY4zfq+OxMaf
 mckPu/ZJLlucjW9p2ptzGg==
X-Received: by 2002:a05:690e:1518:b0:64c:c616:c324 with SMTP id
 956f58d0204a3-64cf9b9cf3amr5483865d50.40.1772731026035; Thu, 05 Mar 2026
 09:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20260106213803.205934-1-dmarx@iol.unh.edu>
 <20260227192016.495703-1-dmarx@iol.unh.edu>
 <CAJvnSUB00qRvEORQi9GYhca6i_Li7gsNgQ0S1PZ1HDumBeUzSw@mail.gmail.com>
In-Reply-To: <CAJvnSUB00qRvEORQi9GYhca6i_Li7gsNgQ0S1PZ1HDumBeUzSw@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 5 Mar 2026 12:16:55 -0500
X-Gm-Features: AaiRm51M6mOR3xnpjMDPhHPhYwHZJjKdvVjD6aBgaGmGNGAdRkLyC1Mkcn6UmU4
Message-ID: <CABD7UXOKSVs828tV0XApo1MkMeV1Owx_OY5SFYLhRmd2XX-MYw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: refactor flow suite with generator pattern
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

On Thu, Mar 5, 2026 at 11:46=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> wr=
ote:
>
> On Fri, Feb 27, 2026 at 2:20=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wro=
te:
> >
> > +@dataclass
> > +class FlowTest:
> > +    """A complete flow test ready for execution."""
> > +
> > +    flow_rule: FlowRule
> > +    packet: Packet
> > +    verification_type: str
> > +    verification_params: dict[str, Any]
> > +    description: str =3D ""
> > +
> > +
> > +@dataclass
> > +class FlowTestResult:
> > +    """Result of a single test case execution."""
> > +
> > +    description: str
> > +    passed: bool
> > +    failure_reason: str =3D ""
> > +    flow_rule_pattern: str =3D ""
> > +    skipped: bool =3D False
> > +    sent_packet: Packet | None =3D None
> > +
> > +
> > +@dataclass
> > +class ModifyTestCase:
>
> Don't just rename FlowTestCase to FlowTest - also drop Case from this
> class, and JumpTestCase etc.

Makes sense, I'll add to the next version
