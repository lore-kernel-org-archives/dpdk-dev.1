Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5571125847
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEEA34060A;
	Wed, 11 Mar 2026 16:58:37 +0100 (CET)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53]) by mails.dpdk.org (Postfix) with ESMTP id E61B8402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 16:58:36 +0100 (CET)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4138136f02eso16561fac.2
 for <dev@dpdk.org>; Wed, 11 Mar 2026 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773244716;
 x=1773849516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW+JLZt3E2yUN5m1FJ3Jdue6DtmCbimv5qt+VntIxYY=;
 b=sUjREIahjfZZa35OxkjLCOA6aNBDDm07Ab7T7uU7rObpsYYH+ExwJeEIhf5BmwhzMt
 ofOkbaDMtpI8sWmkHTfuMlliA0sN/z09zP0X3nDZh1bbWvc8FPRSXFzxoagRwcuTGpDD
 IGi1Rn5kYP22cpJKbmFclFv4RR9xiaucu49JbY2+MoJf4Do4umvKYwvSIT5vUQ7AG1Ly
 wErG8SCpEBuK+5l3a+qvGs23cLyy3m91Tl2k/WBcd0T4sJHHVALrAIyg1RNS6PNwhSFO
 gkllpHkZ+gou8Q6eUspjCpMOLXVuYFv1ksjGiRtqYna1CoKzwE0UfiETcrq5nvhn3OvF
 f5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773244716; x=1773849516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tW+JLZt3E2yUN5m1FJ3Jdue6DtmCbimv5qt+VntIxYY=;
 b=LaD4Ix6b4VepQsupugJxxW+zN+Ehl/c25Ly0RNMt49cQKl4Qr8MOSLJOjwvqYrX9LB
 MPUlFz1JXyYon3/HnGVJX8RhYDPYnZcv8cXgh19hMl4xHFa3DOiThdzNSEVP/oujuBor
 pvEiuAmjep6A9K2rMhLXCfv+g+LMYzJtPBe1Z2lH+SYL96KM4okpU0BkRqrs7EErdeDD
 eSWQ5IeLb+zOQbwE1GMoed292btbt3kY3aK+YOibj6xs1SvZiPumjqWjcS49YcjeOu4M
 vDhYxc2TFHuU5AWNod8pA3AnLyoRnIg6jcLofx1W8BO+6hTXL9RYcvQ78jFN1KpYVryx
 Y4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMN0T5UuVl7hcFKJx/pr1zeOYUPQmoW9SkpbB05zxz6Pi1yM/Dzov9i6pXgywjXmZWTLg=@dpdk.org
X-Gm-Message-State: AOJu0YzZZZ1AwXuo8xxxggSkE26CQ3nWvo/HZQ71iBOJer9HvPMhZ8lY
 9v/fjYrCwXgOWIPi71+op5oCNWtHyRRvZ4WqsCvr0MnBjXrjdoXruj8+2+HYlBPuek4=
X-Gm-Gg: ATEYQzywUefBFFucthAqhJda0oJkPcePlpdNS2eI6NPCfIScctZg9zaBvFHVa/B+VxC
 bANCHsWrvWHiNH7KbVlGC8Ga0mOEkcVcUBuMh7qjWqyQVNRQbOMIbzHEq/t9JR+E4GpOSLJZ94T
 1FyG92ePMTeIzoTTAVJNYSUBdcF1Y1p1wZq7t9/t1dluJ3hSheqkZ+emCqWaVurmkfCaJJbeAFo
 H2YI3zfE0eanDQLHUbPj0vVRyspwbck8YoLx+4JjX/c5UEyl20JZVDRu4d1o3RCPUKqZMmSl1Fm
 7A6Q/lOLV6Bc7aDXp1Hv5DF2M0CmAUCVIr/B1h6nPDwKFCBHoySOMj3m16LdqqnBcZxeXx22Xn/
 I0/GcwBV06TXC3Pth1/ApwQr4ewXkvlE+MxEh6IhKDHfghhM/M8DoMR8TWd9j9FkfS9g0G3xm8D
 WaPUUgXdwtzJA66EmgFY2JZnJnwk0wuylg8D0=
X-Received: by 2002:a05:6871:7296:b0:417:33b7:8c3c with SMTP id
 586e51a60fabf-4177cab61d7mr1825787fac.36.1773244715937; 
 Wed, 11 Mar 2026 08:58:35 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e26e2c6sm2602469fac.7.2026.03.11.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:58:35 -0700 (PDT)
Date: Wed, 11 Mar 2026 08:58:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: mempool name size incorrect?
Message-ID: <20260311085833.3d832d17@phoenix.local>
In-Reply-To: <144d8fcf192645e3aa240fc43d85097c@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65773@smartserver.smartshare.dk>
 <f8381c90-d73c-446c-bb2f-2fe3bc921714@oktetlabs.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65777@smartserver.smartshare.dk>
 <144d8fcf192645e3aa240fc43d85097c@huawei.com>
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

On Wed, 11 Mar 2026 10:52:11 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > > On 3/10/26 5:10 PM, Morten Br=C3=B8rup wrote: =20
> > > > Isn't the RTE_MEMPOOL_NAMESIZE too short?
> > > >
> > > > Looking at the names sizes:
> > > >
> > > > RTE_MEMZONE_NAMESIZE =3D 32,
> > > > RTE_RING_NAMESIZE =3D RTE_MEMZONE_NAMESIZE - (sizeof("RG_")=3D4) + =
1 =3D =20
> > > 29, =20
> > > > RTE_MEMPOOL_NAMESIZE =3D RTE_RING_NAMESIZE - (sizeof("MP_")=3D4) + =
1 =3D =20
> > 26 =20
> > > >
> > > > Referring to [1], I think it should be fixed as:
> > > > - #define RTE_MEMPOOL_NAMESIZE (RTE_RING_NAMESIZE - \
> > > > 			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
> > > > + #define RTE_MEMPOOL_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
> > > > 			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
> > > >
> > > > There is no ring involved, so I guess it is some kind of copy-paste=
- =20
> > > search-replace error. =20
> > > > =20
> > >
> > > I guess ring is involved in fact since the default mempool driver is
> > > ring.
> > >
> > > See drivers/mempool/ring/rte_mempool_ring.c ring_alloc().
> > >
> > > Yes, it is not ideal, but at least it explains why RTE_RING_NAMESIZE
> > > is used. =20
> >=20
> > Thanks, that explains it. Bad layer violation...
> > Let's hope no future mempool driver adds anything longer than "RG_" to =
the
> > name of any memzone it creates.
> >=20
> > Looking into the associated string length checks, using a too long name=
 will fail
> > with ENAMETOOLONG.
> > So, using a long mempool name might succeed with some mempool drivers a=
nd
> > fail with others. :-(
> >=20
> > I guess there's no simple fix for that.
> > And I was wrong to think that the RTE_MEMPOOL_NAMESIZE should be
> > increased from 26 to 29. =20
>=20
> As a generic thought: might be it is time to make the length across these
> structs (mempool, ring, etc.) arbitrary?
> At our next big API breakage or so.

It would be good to switch to flexible array for these structures.
Put name[] at end of struct.

Might want to have a sanity check of really misuse like 1K or something
