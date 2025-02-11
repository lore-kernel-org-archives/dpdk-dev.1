Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA58C021A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 13:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 906EE40156;
	Tue, 11 Feb 2025 14:57:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B59CD40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739282257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMXJew5md2tBG32+DAQc5D6bT2zm8NXjPN+nwlxN8tI=;
 b=bB0n7/dWfPoOZWQ4zVOz/ZhnhHp1Lc3klDFFkhsIDbubuTjmA0DeK/NgzfPG2mp0kRVpUJ
 6aYvemFuNhlHtySm27z6okOyhzdo7aWxs4492CuJp7ZE7p7i1cdiKtxwiNzjSIqMsSXiUZ
 zHCIOHUvNVAW4XEXMaqPKtRSMVsf1hI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Bh3J2QQlM9GxTe0CFpj4SA-1; Tue, 11 Feb 2025 08:57:35 -0500
X-MC-Unique: Bh3J2QQlM9GxTe0CFpj4SA-1
X-Mimecast-MFC-AGG-ID: Bh3J2QQlM9GxTe0CFpj4SA
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5450eef8479so799208e87.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 05:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282254; x=1739887054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMXJew5md2tBG32+DAQc5D6bT2zm8NXjPN+nwlxN8tI=;
 b=SYAT1/p2ujCIQxVFX9C8DGNlgXro/Bap6G54U/a4hy9Ru1D5alFO+geEkpQBxM5/Ax
 g4B8sXEFgiqri8j981/zLv2Bd2eYRK1Rpx9qx34PYI8Ug2R8fv2U2Sw0lx357qKkX0pp
 gd4lXNxpH/SUCXdrUZZWZV8FnxEhU1Bens8hNNxAZ6t63FsYX1D+H3m7Op+10gbmzKfJ
 Ni+/dDuZd38Pta9ZkDg+skMqLKi7CZTjAR+ppYoKtylYdEDAUZr0sh7MO0JQAURonq6N
 0oz8X9sUmPbulCWmngdS37GyYWbT5c/UCP0sbsEBF2mff7jjcNn3fXIT9uuPCp+wZKiA
 pXiA==
X-Gm-Message-State: AOJu0Yy8a7M2R6D+aUbSKwlyi+5lVJfhbGBwtWq3ofL4SpnRF/yY9tLZ
 yEx3dBfWNRIsEGiK24NYMHwfsiwKc/e7F3HFp/Wu3kfbeqfGz1y/Pr84+KyqyRssHlogCxsegiH
 Csvwk3Bn7gsOEYjgD4YdrClYVWqbI0MvR0MPJ4PZtz/T5GrpegmM9GZnc/2CIHrNKU/mixCg/h7
 KfR5bkBUZiTW28fSY=
X-Gm-Gg: ASbGncsPoE2ZdN5qgFxlOrNWBFrlTvxrtaxQ1cTya7CgZLYY2bnp6YnreIIstWrHgfq
 2h/Ga5CHCQ0tFppgW14yzXqTbLyvGYNKFoqZEBRSZfxwaCVBHN8S02Kws5ZbowYYK
X-Received: by 2002:a05:6512:3a94:b0:545:1233:d4f9 with SMTP id
 2adb3069b0e04-5451233d61bmr1066411e87.30.1739282254220; 
 Tue, 11 Feb 2025 05:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGtTMz4avZzXCMPorgvmlI5cfUdf4WJSMlr+rkf3zavqQAenNHxdPjyfWzTRkAJzuZos/0lrFZUBiHRFpoil8=
X-Received: by 2002:a05:6512:3a94:b0:545:1233:d4f9 with SMTP id
 2adb3069b0e04-5451233d61bmr1066399e87.30.1739282253854; Tue, 11 Feb 2025
 05:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20250121163539.2308702-1-bruce.richardson@intel.com>
In-Reply-To: <20250121163539.2308702-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 14:57:21 +0100
X-Gm-Features: AWEUYZnQkPaKz8deGXAPsmfOgb9-QVI2wbF6J089xPRbTqh-hHKV6v5qLAwc72c
Message-ID: <CAJFAV8yXqN=nmnqc5T7Eyt6KeVJOisk+MCadLxzjoLkjS3n48w@mail.gmail.com>
Subject: Re: [PATCH] net/i40e: reduce log level of global register update msg
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RAJdsWVkXztvQu3HGjTdMvazJRg-Xa5EwfNyIy37wAU_1739282254
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

On Tue, Jan 21, 2025 at 5:36=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The modifying of a global register value, which has an affect on multiple
> ports is an important change to HW. However, the actual details of that
> change is only relevant to developers and not general users. Therefore
> reduce the log level from "warning" - which implies something is wrong -
> to "info".
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

