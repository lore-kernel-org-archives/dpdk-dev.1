Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F35CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:59:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 418C3427B3;
	Mon, 17 Nov 2025 09:59:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEE44026F
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALmDHWOwEPcdzO8z7/TiLd5fCQOQCQcxhXjTM8ph72w=;
 b=Wdr9bW91xSSEYPo1b5GGm0GfLRSeYMbpWURKNHJda3yr37J+deMANyY9eQw25U7I4SSzUd
 4zjknYlUDkKIVB776z6s+9OCwXriy6bIDxpgfOCaAJ3mEjijaK4qEbEPM0nJc/PSlftRKk
 LD04NHzgqUy3gGTRFsIY49xdazOE084=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-AYNSRUWSMxekY0wJ6bV_nA-1; Mon, 17 Nov 2025 03:59:11 -0500
X-MC-Unique: AYNSRUWSMxekY0wJ6bV_nA-1
X-Mimecast-MFC-AGG-ID: AYNSRUWSMxekY0wJ6bV_nA_1763369950
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59436279838so3181256e87.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 00:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369949; x=1763974749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ALmDHWOwEPcdzO8z7/TiLd5fCQOQCQcxhXjTM8ph72w=;
 b=jDYkV1gT1u0R/7zDdAObl0oaa/arAPOS0t0Q41zWqtvrvyM1dXWc6c/Cp/XXT10Lw3
 BVCAt188V4EuG6xDZeKb/1onCv3J8Djci01kikYuaLRxg0/IMjGpiF9y5Xs7lKEJ4bMD
 I2CNYPQTViQs/GMqcByb8iOIasKHkJR8B9ZPszpbQMO2uBplOAVKiC4SnLJ6T2QKeXHE
 WBsthjOHm+oyiScf5VJNA5lXQeYxLQg38vJzLmISvbimYywkpu4Gw5SFVG2NnWpUe9nB
 FBc19kFSEze1e0IU+M9B3/i3YCj7FJmu8E6ZOA0h7Nu3Oltfj/LDjW+J8cO0lJx9VCCk
 gdgA==
X-Gm-Message-State: AOJu0Yzfjtyzlaas3RnUUqSyxnyf+sDtq6nqmMmFrj98IDkp2D85eJmt
 34ZDkQWtPoJ8pdL4M9RHO65Uf9D5NHyoztp3OFGT8jZvDNDHFNz4fT7+XYylodPbQ479EFylIS9
 VQSMwgkT24FHgt7GAXinpJdfrSxBXn9xG7LLbSGAt7Zbj40Qw/ttvPXrJITr5eqJSDe1csYbGTO
 Io3j449FQZrUALGBZuuv8=
X-Gm-Gg: ASbGncvSrYaLCKAYMoHvR70zVQcJEunJUq3Dv9mVJIgbXppqER+lXPBmGL5fM24fIPK
 kw+7sctZr8GxsZWS+C1NjTY1M+Ob8xynm48djqpcZIfZC4f7lC5BT2AvwkN/I2w5FWQhnql7pvI
 41aMNwVjb7U6I9MCjmtNry8mJTYRypVnQHvzrQO4hrqfFy04MZN8OjUeXSD3dLlFtV23RG
X-Received: by 2002:a05:6512:39cd:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59584217be0mr3926266e87.47.1763369949534; 
 Mon, 17 Nov 2025 00:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4XiHKc32yxE0iF2DRzCBFvaUwtO7iexOu9nOhP1RRUmKdlQub6f1GT3Xo2l5eFMjPaQzHjZfClET1MGnQW40=
X-Received: by 2002:a05:6512:39cd:b0:594:4b55:d2dc with SMTP id
 2adb3069b0e04-59584217be0mr3926255e87.47.1763369949076; Mon, 17 Nov 2025
 00:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
 <20251112091049.2669481-2-david.marchand@redhat.com>
 <CAHHRULXYKbmYT7tY4Qino9dhZccZwBoQYJusjDNJkOi6e62NHw@mail.gmail.com>
In-Reply-To: <CAHHRULXYKbmYT7tY4Qino9dhZccZwBoQYJusjDNJkOi6e62NHw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 17 Nov 2025 09:58:57 +0100
X-Gm-Features: AWmQ_blSMxupFW8MlDMUCT13gqZXXTcQS5T4FDba_UZ9TeoJ7SaAAC7OkB1KmME
Message-ID: <CAJFAV8yqgU43xHTn_-Wo0FeSjbBHoPHP7yCbz=ju63np9PxO6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] crypto/dpaa2_sec: remove crypto device in bus
 device
To: Maxime Leroy <maxime@leroys.fr>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, 
 Sachin Saxena <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XkUaa7Go830uYItngwNPAFKR8tr2yU_ZuXMHSwKfjzY_1763369950
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

Hello,

On Mon, 17 Nov 2025 at 09:36, Maxime Leroy <maxime@leroys.fr> wrote:
> > @@ -4526,10 +4524,14 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driv=
er *dpaa2_drv __rte_unused,
> >  static int
> >  cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
> >  {
> > +       char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
> >         struct rte_cryptodev *cryptodev;
> >         int ret;
> >
> > -       cryptodev =3D dpaa2_dev->cryptodev;
> > +       snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
> > +                       dpaa2_dev->object_id);
> > +
> > +       cryptodev =3D rte_cryptodev_pmd_get_named_dev(cryptodev_name);
> >         if (cryptodev =3D=3D NULL)
> >                 return -ENODEV;
> >
> > --
> > 2.51.0
> >
> Should we add a function to generate the cryptodev name instead of
> duplicating the code, similar to how it=E2=80=99s done for PCI devices (i=
.e.,
> rte_pci_device_name)?

I am not sure I get the parallel..
rte_pci_device_name is a bus level name, I don't see how we could
define a fslmc bus level helper that would help here.
Ah, you mean adding a helper internal to this cryptodev driver?

I can respin this today, but after this, I'll be offline for the rest
of the week (ovscon 2025).

Btw, this series is a cleanup (those drivers have been like this for a
long time), and it can be deferred to next release if we are too short
on time.
On the other hand, the fixes from
https://patchwork.dpdk.org/project/dpdk/list/?series=3D36702 seem valid
for 25.11.0 (or at least backport material for 25.11.1).


--=20
David Marchand

