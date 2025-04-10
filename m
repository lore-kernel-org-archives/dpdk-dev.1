Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61221C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 09:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A374B40674;
	Thu, 10 Apr 2025 11:39:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79A4B40669
 for <dev@dpdk.org>; Thu, 10 Apr 2025 11:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744277952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbrHRpHRQRKk7Xd+EPnTWOuKtJKRwRnb8LRucgr0gsw=;
 b=BCDSetP4aQY4sf8+/wRGhGh54C8aIdDjEv5JMYtJ5TNrSDouL0vOMvWgYfHj8eCrYbMRSg
 mv9M+ZGTR3WsjdVG1YIVO5sJiO/03EKs4Y1rWzg4taBsYIzvZB9hqD59Nyps/QZm//P9Dk
 YKYcb4zhKqoDhow3DNvvO3e+Hm5mEl4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-oLqlduW8PRu_dNxMETYkCw-1; Thu, 10 Apr 2025 05:39:11 -0400
X-MC-Unique: oLqlduW8PRu_dNxMETYkCw-1
X-Mimecast-MFC-AGG-ID: oLqlduW8PRu_dNxMETYkCw_1744277950
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30bf9ed6da1so2765071fa.2
 for <dev@dpdk.org>; Thu, 10 Apr 2025 02:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744277950; x=1744882750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbrHRpHRQRKk7Xd+EPnTWOuKtJKRwRnb8LRucgr0gsw=;
 b=sl+AmmqEzvSZw8zrbZ8bENShAAshhSyqiGpMh3peM4Uaaxnbm6YtxDhyAa5d716uRw
 jGMzoQK3e8tf/C41O3onjCd8vUhUHx3UeW4FIMTdkmV70Ypc/F29n0eWd3gE6NYgdoFE
 CMMwMWRa3qqOK/+rI2wITTUeJvdQvIS5g+fi2PoBfzfa9FTRpcpEgBQs2tqn3nLIxFlY
 VD1m+uHbL1jcSVrLZGMygTKaGMyfQWjCWzXYbUXCKCtHwEM6qxCH1vm/HuvqM2D16skz
 xBeX5SH7UmSK1QqBzA92ami+tlCeCtqg4XFdJFQO9HQIy3rBrjapqfU/yYVKVOpOKYnN
 qHdQ==
X-Gm-Message-State: AOJu0YwvSHxr+7xuPv+Q+U7i2duaEiAYczfFa8mNAiBJLokOUN0+nwLA
 waMfleGjmWN2ctQ18P5eI+xjylOaoj4v8lGRf6Odar8N7OfPv43jJRxsF7nrl5NoG34t7oMHRpd
 QdwRsBIjaaS02d+WKQGoUB6/E2VVOyXz/GUkiai5zYRBzCI81d4VdTY50vV38FrCdEa2JuLYPmT
 oe8iPi77pRf5kaW0w=
X-Gm-Gg: ASbGncuNq36RaF9nbX8pBrfPJstrpqAr9iLjy0XHsj24ie3sJcT2sA6m8WrTYDM/7wZ
 WTL9XA045PiiPNP89fBK36wTzN4RDWNm+XC6ZW6NJFtaXy+tMYdeJXZKtyjJ01xQ2ZqArJvU=
X-Received: by 2002:a2e:bd05:0:b0:30b:b9e4:13c5 with SMTP id
 38308e7fff4ca-30fa41a55b1mr6736631fa.4.1744277949771; 
 Thu, 10 Apr 2025 02:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58iLdDzqdGntyE2VKnLoijlnQmAk7ttBrW2w43DvhiJHsiZDYkIrVlugmyYL5Ec5AwW0oA2vx0JLezD+2UN8=
X-Received: by 2002:a2e:bd05:0:b0:30b:b9e4:13c5 with SMTP id
 38308e7fff4ca-30fa41a55b1mr6736461fa.4.1744277949318; Thu, 10 Apr 2025
 02:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250326103928.1189243-1-david.marchand@redhat.com>
 <Z-WTsS31MSnmXMU4@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-WTsS31MSnmXMU4@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Apr 2025 11:38:57 +0200
X-Gm-Features: ATxdqUECMpOpWxu6x3EqUZi1oXPLs1VEkkvspkpEeEZ0QxRHkgCMQdv4T4j2i-E
Message-ID: <CAJFAV8zRmKX7ArLdo5XCZH2MT91nw5BvPEPSnu=4oDKZvtFZng@mail.gmail.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
To: David Marchand <dmarchan@redhat.com>
Cc: dev@dpdk.org, bluca@debian.org, stable@dpdk.org, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 David Christensen <drc@linux.ibm.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dR2XxqfyNFdtbo9udR-2VUKPRMOkglb1lmtAXC7Vvls_1744277950
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

On Thu, Mar 27, 2025 at 7:06=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> > Caught in OBS for Fedora Rawhide on aarch64:
> >
> > [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> > [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> > [  198s] In function =E2=80=98alloc_completion=E2=80=99,
> > [  198s]     inlined from =E2=80=98acl_start_next_trie=E2=80=99 at
> >       ../lib/acl/acl_run.h:140:24,
> > [  198s]     inlined from =E2=80=98search_neon_4.isra=E2=80=99 at
> >       ../lib/acl/acl_run_neon.h:239:20:
> > [  198s] ../lib/acl/acl_run.h:93:25: error: =E2=80=98cmplt=E2=80=99 may=
 be used
> >       uninitialized [-Werror=3Dmaybe-uninitialized]
> > [  198s]    93 |                 if (p[n].count =3D=3D 0) {
> > [  198s]       |                     ~~~~^~~~~~
> > [  198s] ../lib/acl/acl_run_neon.h: In function =E2=80=98search_neon_4.=
isra=E2=80=99:
> > [  198s] ../lib/acl/acl_run_neon.h:230:27: note: =E2=80=98cmplt=E2=80=
=99 declared here
> > [  198s]   230 |         struct completion cmplt[4];
> > [  198s]       |                           ^~~~~
> >
> > The code was resetting sequentially cmpl[].count at the exact index tha=
t
> > later call to alloc_completion uses.
> > While this code seems correct, GCC 15 does not understand this (probabl=
y
> > when applying some optimisations).
> >
> > Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup th=
e
> > various vectorized implementations accordingly.
> >
> > Bugzilla ID: 1678
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied as is, thanks.


--=20
David Marchand

