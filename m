Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9828EEA86E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 00:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8759C40287;
	Fri, 13 Feb 2026 01:43:49 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 293F34027C
 for <dev@dpdk.org>; Fri, 13 Feb 2026 01:43:48 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso2276625e9.0
 for <dev@dpdk.org>; Thu, 12 Feb 2026 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770943427;
 x=1771548227; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcNkDekcmnqMjoRm9SeWjsvi59fxZe/jdjmPPZUDMmo=;
 b=BeJ38e5RWxqV7jK51YgxbKAD1BX7U376OVI6uTW0nyduTTpsUu/mSuoLhtZDs2CsMD
 o/F1W3NOrHkNN0XgK/WCJYfnU0dqi5Ff49WLTrIHsTUGWpFWBZpsgfPuc7dZC/eKnpvZ
 iR/inw+YB6QEILJa3cZvcWoHs0E3Ob193mDRrkm6NasK1jFBzDQt6NgiohzjXFfZ4mRJ
 dOllrm8zKuY8n2W7tjMSQg1voD0FUHpBbx0piqxYY+djxe6PqCQD+rWrn0cu+eiULt81
 Ok+KnXHyl10FTNlVwDwAmARXghQGno5rDE0qadvCIbrFRp9QFLAQjujTrfL1/tL5x7py
 V6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943427; x=1771548227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PcNkDekcmnqMjoRm9SeWjsvi59fxZe/jdjmPPZUDMmo=;
 b=EmaH+2OVqmE0G0LdxFDbDQwIRL6oHRDzCxS4YUth6DB7riHymc62mqDCaSn18EHjtY
 aNkzOZeG73pct7sMzUr1AKefGXf+kFrCWHTDpLtLw0zs/NHq6D6b9zwXHDWb/zna0kQr
 duQDax2Oade8YCUU8CNF0D4/1T4HLJmuVPXuPISmSTzjXgU1+0/ZyAWwe888zhHZOakc
 N6m3/zpi96/lE/rEKV3L3wbcXhBjOGoZGtdHWzPR9r0OIX4deSxSqqiyffwdykYxypwM
 8O69pEMY1YZ+wUbQlwQDVZK/t8vjROlnl2NY/oplbLytjaYFWA7lDcPlglQZKXM++DTy
 nFUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVwk2YZznWD5IhWUFfTY2owaE2VUWLWiMnBTLnYao5QwsrtXK/Z4f8wpKb0we/3IZTHhQ=@dpdk.org
X-Gm-Message-State: AOJu0Yw44QhMaS1h/e1lp2MbjNNiAi67T0NipaIjxrMXlt1FJp8geFu5
 xeWvJDNPmFjf4TYJyBKEF7NTeXMaQJFBCFTpqDggTTCeFQ69WYeympNcRHrCmmehG/c=
X-Gm-Gg: AZuq6aLAsm4GSXZO0KvKdYJ/qrp8gqttA3L6nLqEXDZ4d03IAl1QE9lBV90eooU1cDX
 dw16osCq/Ztx5E7LqdPNCDRSIDlzRqBqd7SkjYO6rlYTM1Jl5oZt5teUataSTdsWbKyqKT8GBms
 jN9lUL4W6bVSqhOCuPF6d3uu8c2cd0gnO9j2ysXERBaJW7ePcW9aUFEzNFZNOwfQFG1VmRfdDa2
 NhmbEjBIZ+eO/EkzI49Rpp5ItldJ/dkBwz7dFnW06X0NinlespfWCS4MYOKR/tUTT0h4n89+S0Z
 qn35x18EUFdnRfi0u3UCsWdIooKK/TgOmYOn/vDuRZO6dPvR7uc7Ei+s/OyMVmFCK5WvsxrlaVi
 ipXQ4Hcq5RqNScNLpCyYmSe3P72IBi81sj0i0LlLe3RIhuw8fH14iMk6dTGiNPHajzlQmdkgXdZ
 dKx4jb34EeYZ758UpsFUJ9iQ47Zo16SWWEgkDQHVMIc69AzgBzas/v1Abnh+9pRYxI
X-Received: by 2002:a05:600c:21c7:b0:47e:e48f:43b5 with SMTP id
 5b1f17b1804b1-48372f704c1mr1156125e9.18.1770943426970; 
 Thu, 12 Feb 2026 16:43:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a29977sm4343695e9.14.2026.02.12.16.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:43:46 -0800 (PST)
Date: Thu, 12 Feb 2026 16:43:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, Ori Kam
 <orika@nvidia.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260212164341.074639cd@phoenix.local>
In-Reply-To: <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local> <2762564.TLkxdtWsSY@thomas>
 <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 6 Feb 2026 16:40:39 +0100
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:

> p=C3=A1 6. 2. 2026 v 15:02 odes=C3=ADlatel Thomas Monjalon <thomas@monjal=
on.net>
> napsal:
>=20
> > 04/02/2026 15:53, Stephen Hemminger: =20
> > > On Tue, 3 Feb 2026 09:34:26 +0100
> > > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
> > > =20
> > > > >
> > > > > The kernel version of checkpatch complains here. The DPDK shell =
=20
> > script =20
> > > > > seems to be set to ignore this but.
> > > > >
> > > > > WARNING: break is not useful after a return
> > > > > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > > > > +               return cmd_flow_parsed(out);
> > > > > +               break;
> > > > >
> > > > > Should I create a new patch set or just let it be at this moment?=
 =20
> > > > Lukas =20
> > >
> > >
> > > I am ok with it as is. =20
> >
> > Better to update.
> >
> > There are other warnings:
> >
> > WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strnc=
py
> > - see: https://github.com/KSPP/linux/issues/90
> > #13052 <https://github.com/KSPP/linux/issues/90#13052>: FILE:
> > lib/flow_parser/rte_flow_parser.c:12825:
> > +       strncpy(buf, str, len);
> >
> > and a lot of WARNING:LONG_LINE
> >
> > I can have a look after the decision. =20
>=20
> >
> > And on a more general note, I would have expected to ask the opinion
> > of rte_flow maintainers, but they are not Cc'ed in these patches.
> > =20
> I communicated primarily with Stephen, and will CC Ori too. Anyone else?
>=20
>=20
> > I'm a bit skeptical about adding this outside of ethdev library
> > which defines the flow API.
> > =20
>=20
> CCing Ori to make a decision. I don't mind putting it directly into ethdev
> as well, I just thought the parser could be its own separate lib as it is
> just consuming strings and producing rte_flow structures. I can see the
> heavy ties to the flow library, though. Thomas, Stephen, what are your
> opinions?

I am beginning to agree with Thomas, this belongs in the ethdev directory
next to rte_flow.

Also, not sure what the purpose of parser_ops is. It says to pass NULL, but
test-pmd is doing something else. It would be better to have an initializer
(i.e RTE_INIT) instead? Maybe



