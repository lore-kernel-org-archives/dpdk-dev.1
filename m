Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5807C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10A174060C;
	Fri, 31 Jan 2025 14:13:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5C49840281
 for <dev@dpdk.org>; Fri, 31 Jan 2025 14:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738329228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMDp6iwAAtp2aeUDgqxXw9MyXMC62g4i/o1FMOiLiF8=;
 b=dLg4GjpS2s1UmZD5Q8hGwbH4/DKgvLn4ZghZx9ls0f/5l5U05Y4v9veQtRJf2xVEJqS4m9
 cGkDJy8ioVSvbRJuuYCVxKP95gNHrWWbwTYjuqeFiEvfe9ZuFdhkkypSrJxoyki5dhEVR3
 eslxGc7KjBkCy+cplveESwIOE1Jq3iA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-fQ6UupsHNJ2uj8QxL2YiSQ-1; Fri, 31 Jan 2025 08:13:47 -0500
X-MC-Unique: fQ6UupsHNJ2uj8QxL2YiSQ-1
X-Mimecast-MFC-AGG-ID: fQ6UupsHNJ2uj8QxL2YiSQ
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-307902096d1so14058771fa.1
 for <dev@dpdk.org>; Fri, 31 Jan 2025 05:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738329226; x=1738934026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMDp6iwAAtp2aeUDgqxXw9MyXMC62g4i/o1FMOiLiF8=;
 b=dMxVyvQehku5jr6Tp45MUcTP10pdORxldiG/OYdyR59ydKyHGwdcB+67UEk+BtiTxu
 Te7XUFzFOsa0mGdSOWF9skhFs9QOEn4l9psD3bnPnwypokh4OtWChUqvnM1ZvjA9sCB+
 9SpVpfYPr1Ve2v3kACGP99TsVgOb7Z+Z0ojad3JXC3MghCHofoN3zhIhZe03nMVUko81
 dAXTbse1AxcxZMh9ms8LE9+H1ILF7JVfkIZ1GIHC3Jc1Ik6AzKIlERO8Z3IWdFCK2fYF
 jJth8A/YvW9PBzEJs4lASFh0+a4GIXYauLUI1XjoVn6W7TPsY4CD4Akm3V+Nu1ff6YnA
 lD3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD+kr72OSLBk36zjvi3Kt88iPJtzQ/kqZJ24PBW01tiye63wrFTjKVHOblaNNDt2PmgOY=@dpdk.org
X-Gm-Message-State: AOJu0YwVGbKJVzQEk3GzoVl9x4naEIBT0HKt0REClDX9D2u0sdAuGQL/
 Y2N3VwIVGRE89OCfrRwIfZ3LiJ4uxxvSr6f+kVx8Pw53h85ZNa+n1ASKZZpnA8WOof1GsMfQkQ1
 1SxleZOBAE/fkgdX53t1nxyHwt34pyYBkKbR7UhVVWLMC8JSahKOC6DoVU9EvVmAoymWiByK3Xj
 6ZTj/XuJ5tjUA/dl8=
X-Gm-Gg: ASbGncuDQfurJE5mwjsXnR9V2q8pbbgbcB1W5yzIinuoaxWcB3k8gj6NzvQ/40UY59+
 kjiHwY+4Pl1C13pjDF/ifSYeZwbEeP3JmTzZR3ozreIW8eqfFX6ugkgcpAJ1ktgz9
X-Received: by 2002:a05:651c:2229:b0:2ff:d7cf:a6cb with SMTP id
 38308e7fff4ca-30796839b54mr46888731fa.11.1738329226039; 
 Fri, 31 Jan 2025 05:13:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHucL/t/jINl9PlYF5JIIV84MA2QwMTo7kDsZCmTW67E8i9uxj5ZnI10GCzAoKTJlPI0KJc/6dj/6Kfy34gm4=
X-Received: by 2002:a05:651c:2229:b0:2ff:d7cf:a6cb with SMTP id
 38308e7fff4ca-30796839b54mr46888671fa.11.1738329225593; Fri, 31 Jan 2025
 05:13:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <Z5zMFBv4M8NNb3en@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z5zMFBv4M8NNb3en@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Jan 2025 14:13:34 +0100
X-Gm-Features: AWEUYZlEwSIiA9Z1CGLWUxZNE2RYUwq5tWjnKuVjRnsDqcLd60fm4Kh8j4tCY_I
Message-ID: <CAJFAV8yu8WopbHpu9jZ07AeGyPuPyHCq1BRzCs0kDXYmneruDQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e25J5g4OQxj8fblhsKdZXFeNpC_8SLP9wLZe0CKkYic_1738329226
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

On Fri, Jan 31, 2025 at 2:12=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Jan 31, 2025 at 12:58:13PM +0000, Anatoly Burakov wrote:
> > Intel IGC and E1000 drivers are distinct, but they are actually generat=
ed
> > from the same base code. This patchset will merge together all e1000-de=
rived
> > drivers into one common base, with three different ethdev driver
> > frontends (EM, IGB, and IGC).
> >
> > After the merge is done, base code is also updated to latest snapshot.
> >
> <snip>
> >  drivers/net/intel/e1000/base/README           |    8 +-
> >  .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
> >  drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
> <snip>
> >  drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
> >  drivers/net/intel/igc/base/igc_phy.h          |  337 --
> >  drivers/net/intel/igc/base/igc_regs.h         |  732 ---
> >  drivers/net/intel/igc/base/meson.build        |   19 -
> >  drivers/net/intel/igc/igc_logs.h              |   43 -
> >  drivers/net/intel/igc/meson.build             |   21 -
> >  drivers/net/meson.build                       |    1 -
> >  64 files changed, 3300 insertions(+), 18218 deletions(-)
>
> And I thought my deduplication patchset was good, cutting the codebase do=
wn
> by 1000 lines! Shame you couldn't quite get it to a 15000 line even
> reduction - 14,918 lines just doesn't have that same ring about it! :-)

Now, the question is how many bugs sneaked in respectively those two
cleanups ;-).


--=20
David Marchand

