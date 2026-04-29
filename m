Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214FFF8873
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC61402EE;
	Wed, 29 Apr 2026 16:14:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 88607400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777472077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9fTyhqnS5cB5zSPCwxcGkMnk+V7E/RAR0N4q6jTnZk=;
 b=SzDO8KSA+ZMYVJag7seuOC8i8QUhbsv6kMu7RJm6/fXkXIDYusKfCL9ULcRMqlzWVxsyuj
 vkVnLXNzThakYaaX5UQ/2xEP9CHN6Oq7rczQ1jMhUz3qdb86JRgdd5JQRYVMY81sXx9b3g
 qoGIiwgsbKQBQgNbBIC9XsjCusIQQas=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-9sdj7OrENbWli-qvYSJqjQ-1; Wed, 29 Apr 2026 10:14:35 -0400
X-MC-Unique: 9sdj7OrENbWli-qvYSJqjQ-1
X-Mimecast-MFC-AGG-ID: 9sdj7OrENbWli-qvYSJqjQ_1777472074
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a2c8db25f3so9295954e87.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472074; x=1778076874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9fTyhqnS5cB5zSPCwxcGkMnk+V7E/RAR0N4q6jTnZk=;
 b=tZtJZW6xfUCzD1vo/QFFHVaP64PAi0KWAJeB36ryPcCoBknHqumfflLKMw6vr3glhi
 my1NWH9tBl1SIT1N9IgTcv8ZBiCiy2SHHjjCO/4cuJ1ZhjJGu2x5BlE0I9KJK4bnFH7E
 W9s314Ev4d80V0nV5ndkmdTZGgGbvF/ENy0SYgYBmrcXnExshpdKYQ3bGo60baUiKody
 I0SSixn5ORaHL6pvXHFEFkg59JqMWk4ToLSO/yN12j7EnySZ9HEGDIRbZL/gE6l6fuFs
 QPmlOenXIAQe4CF72Auv+8wst6K979KTAOKTyzDbUVlh+HIZo5Wtlq37OCc9yds0w2iF
 Di1w==
X-Gm-Message-State: AOJu0YwjjNQEFBR8+ui9+KjARqlmNP2mluYTNaERaFy/XSvNU0DTY8a9
 dkqClzpmDDfCJXn4TiZ0kdLQmQ9hvtK37yHTojnw+9fHNpJJsUzucH60U9kacSri3MCgxCehaqk
 J91cyd4hodLTx10qK3Eb+hPTReE5bxpnoKP5RGchzHYCDMpCWPyTu32OV/5rmTMH0kIwlkAUeqe
 CpF20OdWP0+MdC4vd/wl8=
X-Gm-Gg: AeBDieuzm6/y0SQk6xVIeHqlaoO5zPE1ixFteqzNzUpGDUQtCfzioPr+UEnoRpayjE4
 eej0Mya9qDo2v26gWB5T77vK775wGwf9k+hEgmnbV+lCe2sgU2f17obpbHQ6/n6RA/lebwzpwGO
 Zu48GLeLM0ffUvcekq5Kv+LLbcWirMI6SbYwEOKzvHnqsKtV6zZWS8prlWnPJi/8kLnGeWTL8s9
 dN4U+tBpuXBxuF1wIxgODIxGL8eVeL2mi8h90Nwn4OYg+Kfe+AdmlCwMx5oXefEEWwIvWEPunug
 oYPH
X-Received: by 2002:ac2:599c:0:b0:5a7:4a60:1454 with SMTP id
 2adb3069b0e04-5a74a601458mr852984e87.33.1777472073873; 
 Wed, 29 Apr 2026 07:14:33 -0700 (PDT)
X-Received: by 2002:ac2:599c:0:b0:5a7:4a60:1454 with SMTP id
 2adb3069b0e04-5a74a601458mr852969e87.33.1777472073391; Wed, 29 Apr 2026
 07:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260429130935.3681177-1-thomas@monjalon.net>
In-Reply-To: <20260429130935.3681177-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Apr 2026 16:14:21 +0200
X-Gm-Features: AVHnY4IHU7rb_rGVNP2ljmVjNHZMYMzhMgCxsYAYTrZPNZaLQPeJiXQYJfH1ckM
Message-ID: <CAJFAV8yAP34iRGiGKx0+Ls6_FpSa0EubP3KiDrUEU0fY-tp0FQ@mail.gmail.com>
Subject: Re: [PATCH] devtools: fix SPDX tag check
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oLN_lSMa7RmR_57-lE69A0R8re0XFAF9kE1E230ATAE_1777472074
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

On Wed, 29 Apr 2026 at 15:10, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> If a file has no SPDX tag and is not filtered out by no_license_list,
> there will be an error when using its path containing a slash
> in the sed command delimited with slashes.
>
> It is fixed by using the pipe character as sed command delimiter.
>
> Fixes: b99a3b8aa989 ("license: standardize SPDX tag")
> Cc: stable@dpdk.org
>
> Reported-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

