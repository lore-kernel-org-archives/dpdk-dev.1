Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D22BC79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11F040693;
	Mon,  7 Sep 2026 14:48:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 415504064C
 for <dev@dpdk.org>; Mon,  7 Sep 2026 14:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788785285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyyEH6lSyQDk/5tp0neQ/3LkOzQpXYCzizdGOX4XBW0=;
 b=BItIkc9pQMDlmGh4TCUKZ9y51x0J31IJp2vl1xgBb9xz8nyrQD4pJeCvhW37lTpyeZSsFE
 z/JAiJf+TtM4Rnj6vPgfs6ogD6FXl2FrUImRPmPwnZrC8yQEc3skPzN5WfhZM6woGriMps
 PxOUSO4/S0Nc/QWijvNKTXEnRAWFfIc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-OslAqTeZMaSjoCBxgi6ERQ-1; Mon, 07 Sep 2026 08:48:04 -0400
X-MC-Unique: OslAqTeZMaSjoCBxgi6ERQ-1
X-Mimecast-MFC-AGG-ID: OslAqTeZMaSjoCBxgi6ERQ_1788785283
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b5f157bab5so2118148e87.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 05:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788785283; x=1789390083;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QyyEH6lSyQDk/5tp0neQ/3LkOzQpXYCzizdGOX4XBW0=;
 b=JS8HAQ4ILJDvlUXVwthoCy6xMgwWjYdn37Rx5Rnhb23q//f1leprAf9Im0DwkAH/bi
 SMMgJ4/xNcwmmSnBFUc7qgoRKeZKj+K00ruU/tATLJh7gttFedaD3EFKunXSj9Trb0ve
 15Tt2xdLy6jVjkehtuahve21NFZ137lo7obwRipYYYop57X00ieKbltzh7rXMaYbv5/O
 zv1mFQZNYmdGnVDWARdNcuVYWHbsfyR1s92zU3jRbOaJ11wKBbROWCGIDI9ap99Ut49w
 SmgwiYPA0v7acziA4qlrg7MbS1Nu5Xgb/vzNaa8upjCVtMBafVNNr3BEQ2c28i5+Or7i
 lEYQ==
X-Gm-Message-State: AFuF++nXxBZq2ibyy6KzpjAM3mUCBkrSZjPQAzzJ8r7E7cgEr9qNPNvz
 rxrxpqZQSAkd5MwG0qlVe1D4hE4NF0i0gj/b6uP8QFSnPpOHvoKYNRfoaAFzMC5Lc/u4cl+JcY5
 Kcw9sziTN5cxI9/PziQ4P5WuovjZ8B19HK7Qo+9mJqag3+T4/vxGtIx/IQRizR7CgQIytTkyUf9
 7cd5yPWHBvL7S/B3taNuk=
X-Gm-Gg: AYBFou2hmRvzLYs6TAS2420BMVqpsmu/e9aAEgkzoCew2zwszBsSFMiEaYA6wnKJ30O
 JWhjHdnO0L25q4ZMqK4AZD02bRUE0RwPukRX6ZEbjbAQPNCCZCW7z+0foJuoeonSdGPhsaiyq1i
 YusIN5SUfKVTbF0XtKVZUXz4I6ETaaMjZalEVcCjDVopIMg363e+xGYxGaXBm3Vaufgp8l0XhFx
 AvcqXZYTfeiLWSiaKpS/db6eG1e+9xQYy45xiQvep44E0Cb
X-Received: by 2002:a05:6512:b98:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b616edef1amr7366179e87.3.1788785282753; 
 Mon, 07 Sep 2026 05:48:02 -0700 (PDT)
X-Received: by 2002:a05:6512:b98:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b616edef1amr7366160e87.3.1788785282282; Mon, 07 Sep 2026
 05:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260907121348.3049808-1-david.marchand@redhat.com>
 <20260907121348.3049808-3-david.marchand@redhat.com>
 <ap6vmUnxBGv9w9vS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ap6vmUnxBGv9w9vS@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Sep 2026 14:47:49 +0200
X-Gm-Features: AcwNN1Wz0sZ-Hhb7o6hbwNm3gghO8zVsERjVrBFCVR4fvBZmMZBupbVm7xNc6WI
Message-ID: <CAJFAV8zcYWn_sf_G2pt2Fi_SNDYWHaAPjhg0vp5_5zYp37TC=A@mail.gmail.com>
Subject: Re: [RFC v3 2/5] eal/freebsd: fix a FD leak in the alarm subsystem
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, hkalra@marvell.com, stable@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7jDhS9cIvX1AVQ5CZam8dhZTW7UDgCZCjLE3J2GNdyI_1788785283
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

On Mon, 7 Sept 2026 at 14:35, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Sep 07, 2026 at 02:13:45PM +0200, David Marchand wrote:
> > Caught by code review, while looking at rte_intr_instance_free() users.
> >
> > Even if the FD is not used, it must still be closed when uninitialising
> > the alarm subsystem.
> >
> > Fixes: 26021a715067 ("eal/bsd: support alarm API")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I'll fix compilation and resubmit..


-- 
David Marchand

