Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C986A40E13;
	Tue,  3 Jun 2025 16:33:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD46840E18
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748961234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMKlQGwqhyijfkm6V8FIypxiEM2GnvDSQfUsTptfaWw=;
 b=Mk89P0r7DlXLnBY0CtMoTTAkJzrKO9MMDsO62b+VH/Zoj8S31vxcqmJDuTDk9ogL03a8iV
 1z4Spn6RrKL5qd5epEoZGZ12i3z/FByY8U12P6xP6P9l6Q+7c/X+G4/rim8uZCoBE0cJ9v
 e9mf8iU+FykgVWznvj9KZK2TCiJB7mw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-Gyqry7IeNQWY_iwJA4zDTw-1; Tue, 03 Jun 2025 10:33:53 -0400
X-MC-Unique: Gyqry7IeNQWY_iwJA4zDTw-1
X-Mimecast-MFC-AGG-ID: Gyqry7IeNQWY_iwJA4zDTw_1748961232
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-55334debc43so2697895e87.2
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961231; x=1749566031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMKlQGwqhyijfkm6V8FIypxiEM2GnvDSQfUsTptfaWw=;
 b=IAlB0m3globZJO8vSH1clFIfiBIORfAqC1XU/JDFGekjsJeff1kVuAWlNKbIV6E8Yk
 1W60v9wxxANCpnXgV6kXyd9jg0AzHEZIy4HWYYJXtBTGouAcZ73+cMm/VXkPINIBBiM8
 alnT8fKC5SoNUNNrLfa4Gc62hE23g6qq4nYxkRAiWNntdBLs3VpHv7h84UVEktcBjKEI
 3Ec3gFXpgQEpcJWrk1yB8FPkWhmTPF0qHLBuM2wj28podRWy+kYhQJhnVfD4wLv/s91L
 n0mcZ8Cypnni3hL4pcaFa79aZ5darXLR+hIntxiffkCd21xnM846OweDG6T78Ump7N8g
 aUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQTu9R6doFU66/hu1MBkZ6QryD1ss4g7bSmpmLej7pM7xNGOcBjNSoEUG9Vx22HC3Xvmk=@dpdk.org
X-Gm-Message-State: AOJu0YyGM1WoFQxh+t4V3U+zTIM03/KSaXliqihREhM18SNEDO6pToLB
 5miRdnpSkH0u91Pma8r9HInZIu6inhn+yFrmUhVQ1GxzFfA95LnZMH6xjP6xzHiz0ZcAKspscdS
 mo8hKjyizjdFjoYsRrxzvaFL3EWxpjczmFe8LpslMrxUHpRA5X7PUTAiGpRh7dJmPWIkVRFzFVk
 c1KLDiJoBAPHQnrKeDS8k=
X-Gm-Gg: ASbGnctwW6cV57Brh/d8vhpVN8fRqSO8091T+/MVKhrqKxrUSiaiqzfOcTL78IQepyR
 tqHoSrVKgs46tHvNaO0GT5BQheUzSA2PLVfw8+VuFMVTof8PEYiEJ0+05wT6ipERviz+C6E0=
X-Received: by 2002:a05:6512:b18:b0:553:2c01:ff44 with SMTP id
 2adb3069b0e04-5533d161017mr4375465e87.2.1748961231590; 
 Tue, 03 Jun 2025 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ4jwBm8N6dTsRohd1TUyEKQLfcv5/dK91IJIPZLsx/homNlDnkhDtTmaqmoc9DjmG1OAhO+LgrHVEzJy3NlE=
X-Received: by 2002:a05:6512:b18:b0:553:2c01:ff44 with SMTP id
 2adb3069b0e04-5533d161017mr4375456e87.2.1748961231193; Tue, 03 Jun 2025
 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <1736028594-15393-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1736028594-15393-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Jun 2025 16:33:38 +0200
X-Gm-Features: AX0GCFsPHqYGtcgvHt8c8CLquASjpgzdLBH9q2R-GDAsk1d7rnbTClVDJwhRS28
Message-ID: <CAJFAV8wm6+5+Fz_Oah5sLZCNm+Coj0j-VKXLSVUSDLnSGC5auA@mail.gmail.com>
Subject: Re: [PATCH] app/test-fib: enable test-fib on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m7DgmaIrketgVkJJ-cdNMxfcAQtTtTabV2r_HlgwL9c_1748961232
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

On Sat, Jan 4, 2025 at 11:10=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Removed a few includes which were not needed and included
> rte_os_shim.h to handle strtok_r which does not exist on
> Windows with that exact name.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

