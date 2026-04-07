Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF0FEEF2A
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 11:58:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F53A40265;
	Tue,  7 Apr 2026 13:58:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E3A774025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 13:58:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775563127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hufuwrq2UEairXXDBg9j6zDHE0UfPcZb1tJqafYjX84=;
 b=gJdsu5k6X3iixkkAdiqXfFINw7cdVk1kM2kUziKSEomCHML9qD2ENTFPaqRihBmu++jHf2
 WaNtFlGyDYASq0X//KKjInhOh98rNGM1FeBeqJxlVqJY+kJ3t8Qvh5VsABLwZrHSOgiznR
 yQyiHC0f8BeRdUOol8PiLPPZuYs3OcE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-a4rSlySEMLuYxbPDzmx9Gw-1; Tue, 07 Apr 2026 07:58:46 -0400
X-MC-Unique: a4rSlySEMLuYxbPDzmx9Gw-1
X-Mimecast-MFC-AGG-ID: a4rSlySEMLuYxbPDzmx9Gw_1775563125
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a2be9dfb74so3048425e87.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775563125; x=1776167925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hufuwrq2UEairXXDBg9j6zDHE0UfPcZb1tJqafYjX84=;
 b=IO7qLA3FMTW2MTBDI651sha7MO3GxzC4FK+XZ4tVomJ3vH3snt9KjxYiNfo9kuQro0
 oi7dL9kpLL8K+chfKqZfVXJmJHo9G8/RTT3ZeO1dGRRV9IfOtOJ4Jc2vQGAXvtcCT9gz
 QyCb3dk2kYHKNWbrdlrNKJSvOjEbqAbmV/5ct37CeCziIL/vU6IUcJ9U4YfNFihOv69O
 G6eLCVHIG/WIMpicS7XCiS90u15pj1D3CGF7zHKKL2O5oTPFkQDE4K+VXFyNooCb/EHo
 fNotf+nRQjW4ieuGcmJN5W0vnVBnO6CaGXGpLihCJZf5zj/Q70+KfWNr3dfpkCAn92GP
 0agQ==
X-Gm-Message-State: AOJu0YxFYCYzg69yAH/ggIw/65vSy1UeR3aMz7k30SnmJ2xGljGA8IWs
 e6wRDFDxFiSNnMs/PthgLtqMyHx7FiceNSWYeP+73Rp3A0i1TR04ihaGenyrxHyBTZi2qfOzuIw
 MNHvMiMODb75GjLHa3aEX+aUKkD0puKwaxMEMdS5IHvu5xr9GcQ2urGXgtKtxDuI+0KD6HGxYPG
 ChrUlC6bNfEBhzsbVZypc=
X-Gm-Gg: AeBDieuxyBhzXONQgp/o03oGaWGSbraGJBD7JIJSULo2fL4pZ4DVrfGNENwC4NL+g1E
 B5T2QMw+OYW2+6mccYVafRxTYe4IqJF1MBTfYIO5hVUzEtWYcc0kox3/cUc3VPnqwmWghazrJ0k
 WyQSivsg0JcmvKl4oZ2+XSm71DWkH1ZIjbF0CYD5L7V7C/JigTqjwsP5eDPsceDycyOklUnKDq0
 zE3x51wzaRUMIGl/AfVOlPJVtAkXZTH6Y9K0ZXvGqpBUsIpb+plERsoogExvIujSYHnDQ==
X-Received: by 2002:a19:520e:0:b0:5a3:7528:6da1 with SMTP id
 2adb3069b0e04-5a375286e2emr3271202e87.0.1775563124565; 
 Tue, 07 Apr 2026 04:58:44 -0700 (PDT)
X-Received: by 2002:a19:520e:0:b0:5a3:7528:6da1 with SMTP id
 2adb3069b0e04-5a375286e2emr3271193e87.0.1775563124031; Tue, 07 Apr 2026
 04:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
In-Reply-To: <20260407115211.1903623-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 7 Apr 2026 13:58:31 +0200
X-Gm-Features: AQROBzBAI-sf_L2RMly5lnlA-pmHRmdebmFGjdT-7py1YvyIP7wRprSNH72oJMQ
Message-ID: <CAJFAV8zfbOjaQD1X6gKJU_+7XadfDpn_PDbpJPN-4wHrptHaLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Rework device probing
To: Maxime Leroy <maxime@leroys.fr>, Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xlU3IO79SoJunAAsy5Wl23rMV-hNHi13QRhqtK1sVcI_1775563125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 7 Apr 2026 at 13:52, David Marchand <david.marchand@redhat.com> wrote:
>
> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>
>
> --
> David Marchand
>
> Changes since v2:
> - rebased for late 26.03 fslmc bus changes,
> - fixed devargs lookup,
> - added debug logs,

Special heads up:
- Maxime, I had to rebase on top of 26.03 changes for the devargs
refresh on hotplug, I kept your tested-by tag,
- Chengwen, thanks for the reviews, I updated patch 5 for the issue on
devargs lookup you noticed,


-- 
David Marchand

