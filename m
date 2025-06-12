Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A4C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 15:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D6642796;
	Thu, 12 Jun 2025 17:47:58 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id AB71442789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:47:57 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d09f11657cso113997285a.0
 for <dev@dpdk.org>; Thu, 12 Jun 2025 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749743277;
 x=1750348077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teDqNed0H3uStpi6gQ8+0TMnvPVhiEPI9FAVqiiCTtA=;
 b=Vg9JFBcWuknjEYZIQ604GzrR+RSUFtMhlK3IZeDH5I/zk2CtWQ/n/65ighKTVykEOT
 4zSJLl4YngzAR2VmJ7Ui7S0i2pAis9Q5Lk9ocIWxZ0KSG36Bwr1m9wDICs1Yow/2q7cS
 Ux4bmGqmMi1MZRxxdyasJqfcXBcSEUf+R08USnjFHil2I1OWRxNv0LxHD6wrp1Oe0ni7
 G4liFOJ3NEK6CMRodm402sTITGZHrS3VJDXnDvYaM28WTyl+MYHsF34IzPVIpVMHb7aI
 tgCbLCRQ4IwlDO0mG5LYpPVuEQlnBTF6qyN5OUGkJpr4ntJXQQKSZJlmdqLMrg0gvJpu
 vIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749743277; x=1750348077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teDqNed0H3uStpi6gQ8+0TMnvPVhiEPI9FAVqiiCTtA=;
 b=kA2uxu5bnITrYov0ONbY5Wei2yS+GuXS7H33o0sS2kuHHz/50OjZ39foYb8U54K8VE
 CiHHXrNl4qW1hSzgold8S1NwFSixGAdUd/d/HYUQLY0yGmvYY991zSF+gAZnnDrsO8Lz
 SeI9+eQTQr66dlGvbTCWX3Rhreex2u0gLN01gCmb3z81A0vu3ubVB8ATd9wwFl/BPOwi
 VmI+26VJmALd55JRcbsTwIPWv0p2w/c0dFRIUZ8NGps7EWSranaFckL06rJdLe1ro2TZ
 HbQgmycY0fCxVjCXCKlR5v51eagQjsMPKT2pyn2gvztKiHLHgykyaExP8Trf1HO+8Iih
 VAfA==
X-Gm-Message-State: AOJu0YwmEMtMlx42v0jJK1mjzaIIUza5uW/i068TU9SvIR0zd/m4RAJK
 zKoO+FyKisl1EaruJrI4JAHb8McEN3vgXiXB2/1Bx1R4/HO8Qwphv+JSRE+vidGgey8=
X-Gm-Gg: ASbGnctbE8c1Ra3bo4Ivwm10jFspOk6RPNcCLij8vkHdzoEO1pZW24F6vF9OVwLQ89q
 jCXul0zZqARLsCCSbf3kp/czK8WXWwaFJu9Dnx8IFZ5Jde1bTPSpe8dvHFedSxhq1WfxpjsaFzA
 Q8PgsEGXoy0qo2IHcxAmCLSMadoV2ov7LLZAdLWn1u/41/D6CM8uDK0D5kZricaAr4FR+Jb0D5/
 T4/zPIQAEcmCaifeGJ9RsAzerCFSAat1ahpMR2BhQA0oGc0zLgcj+DcC7JmBjAoo4CyypXST9MV
 SolY5W74yfQ0CxdQyaUovMVri3tMc7qqwKbxrXIkp41rxt8UrplZ1yPM/syO2Ys/PMlJZk4jTx6
 LjnJAc89I4l7h3+9zhzgsrDehh/Jbf3pNH0HBXSA=
X-Google-Smtp-Source: AGHT+IHo+2YtI+1j97pEMpI6gER2BbqMYzWYyf2BUUeIYxPiKGqGX13AJOLA+ujEgQvJ+DLpTeQjEg==
X-Received: by 2002:a05:620a:254f:b0:7c5:50ab:de07 with SMTP id
 af79cd13be357-7d3a8833b2fmr1161307185a.21.1749743276771; 
 Thu, 12 Jun 2025 08:47:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8eac91bsm54324985a.76.2025.06.12.08.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 08:47:56 -0700 (PDT)
Date: Thu, 12 Jun 2025 08:47:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v8 7/7] test: update to latencystats tests
Message-ID: <20250612084753.12b1bddc@hermes.local>
In-Reply-To: <CAJFAV8y1TqpS6_oN-j9n_PY8mHqCD05n8YU3Jq5VwfXwJUd=dA@mail.gmail.com>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
 <20250610141355.91759-8-stephen@networkplumber.org>
 <CAJFAV8y1TqpS6_oN-j9n_PY8mHqCD05n8YU3Jq5VwfXwJUd=dA@mail.gmail.com>
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

On Thu, 12 Jun 2025 09:00:22 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Tue, Jun 10, 2025 at 4:14=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > No need for loop and memset() here. Just use structure
> > initialization.  Remove unnecessary initializations.
> >
> > Look at the number of samples, min, max and average
> > numbers to make sure they look correct.
> > Forward for longer to make sure multiple samples are taken.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
>=20
> We have random failures on aarch64 in OBS.
> https://bugs.dpdk.org/show_bug.cgi?id=3D1723
>=20
> It may be related to this change, does it make the test more
> susceptible to timing issues?
>=20
>=20

Let me fire up my Raspberry Pi and see.
