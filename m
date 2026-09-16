Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8576C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 09:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02429410FD;
	Wed, 16 Sep 2026 11:45:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F1704067A
 for <dev@dpdk.org>; Wed, 16 Sep 2026 11:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789551912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shJy/KQAivhB/AM8Gpd5F+0rJaQE//cU70n807RX2dc=;
 b=TuIb5GsZoXXUHsFlgRoiuQgVO7itK+BKmKIMBV6+RqydkoXG9Dx0qMOPXjetR27pIGTtgz
 Z4HaqIqVp3kdZr36O4cb8t3jV33KFmqSnreh/EX5fM9m1r8sGiS1P17iLGC0qrw/zMTRq+
 OmShFN0Et7axMLuLad8moE7HQzPovXg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-h7dfQz9zMEmlrafheV3lMQ-1; Wed, 16 Sep 2026 05:45:08 -0400
X-MC-Unique: h7dfQz9zMEmlrafheV3lMQ-1
X-Mimecast-MFC-AGG-ID: h7dfQz9zMEmlrafheV3lMQ_1789551907
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b4b020612aso4910935e87.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 02:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789551907; x=1790156707;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=shJy/KQAivhB/AM8Gpd5F+0rJaQE//cU70n807RX2dc=;
 b=ZQJ2Y142frH6hqqcOny/JyM8lFtvPzsWDF4JVzQoTRnfb++WzLjXAWcxaSmU0pi9pa
 mVGe3HDywniLp5F5R/abvkcr4l+MhvzL4n1H0CzgVT6kmOf+Qcr4NczfpRdSzhEhz2GT
 ilPAILYh/zhwbSSZz9g/eyjR5lhFHz2kC5uZPjGA4odOPzNbA0zWz2sb7Qb77XZy6SHj
 nrXNgApLrFkSRXBkmWzjc19uaRbJEwZhTOYbqda3GqIh7+y4B/cc5Cl9LG8cpOhXmDDa
 gwX1wC7Sd8yLUEtSH+2x+RT04Xx9dd/jPR9B+BNez9fAkIKutMqwY5dtie/ykDhO0OXN
 WYMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPCdOjXNM1VvolEgaUZ3rxoXN98dik4mTjAw1A2Yd/EJFU7p+ZEigKnxVu6VulMUtH5co=@dpdk.org
X-Gm-Message-State: AFuF++ncs7WBwa4qhWfvqFxO5icGgIYddK4X/4I92FhSHfQCjX7+WvxC
 WAgHfpMWzBzCDNhtoVDXi7nECQInnXEtwY0QhwcApM2lFvnPb19Y+SGQcnq7RBfshBPeAVOnoZ6
 hKU86dKlviGYU+86EkjDXMtwmm5zrWi5wwUwo9EypwwMY1vCB3fOkoewvfujNrwHfDxd8uQsA3L
 myi18Ix8agBKCcfr9LU+A=
X-Gm-Gg: AYBFou0KvUGNrcOXY0x8VjlInKtYkGaR7i3PpANjeKSsRuhmrhw+YY6C5HTtzP6rw8y
 k3iznQ4fG1CG3xkobrEmIF2ba8GPt3AQZA+Zc++my9C7iljLERbhTanCLI/CtJAktM3Dsxhm36L
 Kbs8mIrrRRSuZg1casB7jbNdzdANYhyIHBD/0lDYImRJgdcdPH387rh9KTDZUHQiDoK1uJ97gMp
 hEfMWKL8F05MPMA8c8m+APZGmlN4OiRj/KR533Mbhn/EkOf
X-Received: by 2002:a05:6512:6cf:b0:5b6:1a7c:24 with SMTP id
 2adb3069b0e04-5b8b6649c84mr520727e87.39.1789551906869; 
 Wed, 16 Sep 2026 02:45:06 -0700 (PDT)
X-Received: by 2002:a05:6512:6cf:b0:5b6:1a7c:24 with SMTP id
 2adb3069b0e04-5b8b6649c84mr520717e87.39.1789551906468; Wed, 16 Sep 2026
 02:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
 <20260901101926.1574209-1-hemant.agrawal@nxp.com>
 <GV1PR04MB107502B059AE97F8E6EB7860589BE2@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB107502B059AE97F8E6EB7860589BE2@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 11:44:53 +0200
X-Gm-Features: AcwNN1UPz90RmFl93fyZag1Cf0NDZcF0XZ9C_FcNkdoHJz736drAdzwxJS1WfV0
Message-ID: <CAJFAV8xvV868a4cCK-b-yUVQioqD_tDHZZitsXC+U24A=kZQQQ@mail.gmail.com>
Subject: Re: [PATCH v15 00/23] NXP DPAA driver enhancements and fixes
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "dev@dpdk.org" <dev@dpdk.org>, ci@dpdk.org, Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FB65Znq5-v8ozazZJHTlXOx0tjBMLiSfVkeLWl3s9Tc_1789551907
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

On Fri, 11 Sept 2026 at 07:06, Hemant Agrawal <hemant.agrawal@nxp.com> wrot=
e:
>
> Hi @David Marchand @stephen@networkplumber.org
>
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82My last series could not be applied a=
s it has dependency on 1 patch, which is already in net-next. (but not in m=
ain)
>
> If I send a new version with :   Depends-on: patch-168711 ("net/dpaa: fix=
 Rx queue shutdown before init")
>
> https://git.dpdk.org/next/dpdk-next-net/commit/?id=3D6109b26794c6c3639e9b=
e8b2a659ba7d8040d4fb
>
>
> Will it work in CI ?

Afaik, unfortunately, the Depends-on: tag is not implemented in all CI.
It seems the only good solution is to work and get patches merged in a
single tree at a time :-(.


--=20
David Marchand

