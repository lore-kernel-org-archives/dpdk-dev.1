Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B53C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 09:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09AD5402D3;
	Thu, 27 Aug 2026 11:08:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17A454003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 11:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787821702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LnOsD0vj4kyqRCu42RhscAoXZRdf7H4D7KwIY1z9p1A=;
 b=SGvkz34HHUDheXtvq7+dc2yBn2kvNZoZVDjFJskWQSM6+4RlBbunEuJknT/sZbWfU+T7y3
 6JwjQs7+qBzU1In+hAWCmSwUt/xrDhRCGCYoVH+46nqVHboHbariy3bJE+CExNJRTpDMIK
 76dzlt4hb8KfxhQTOke4L9ldA6FzpYU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-k_gX2WvQMRSzuWpuYs4Y5g-1; Thu, 27 Aug 2026 05:08:21 -0400
X-MC-Unique: k_gX2WvQMRSzuWpuYs4Y5g-1
X-Mimecast-MFC-AGG-ID: k_gX2WvQMRSzuWpuYs4Y5g_1787821700
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b4ab63ee90so874989e87.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 02:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821700; x=1788426500;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LnOsD0vj4kyqRCu42RhscAoXZRdf7H4D7KwIY1z9p1A=;
 b=mqo9arELt1ZMlKHkhdttjKhRLda2/Uo87Ryboh09kjfysbn0FVHR6YRM8LlDbYq5LJ
 2kuMRBzaBexKE+F8GHakf9co4JQtT+oYz7rRuv9Yi8vnQWXbvqFnNw7sd+a40aU5x0My
 d86erJwWcJROnHvg+TUVn3cQFeFk2Gs5r0Ex1CZfcZ5QatvW4T0UpXU/VCutitemoSgi
 txahftPBYCFQ1FzrKL3WMSfeqqb7Rwsjqkd9j5NE0no+KDhYWjDKCZwrtRhG1X6AmqH/
 RZgRifW9Khlx0Glc7BK4yh64UgB73ZxvrT+QJC+5O1jg5AyhQiiPI+ShQke5LoOxSN00
 gv5A==
X-Gm-Message-State: AFuF++lvzwIRHAlK6ajpnejUVYvkGBmqepRkE2Bfnh0K6tIcScsnFc4W
 g50PpphrBlrAbGJH1XoryRFYyT/neCL5GHDMjmTegx3MEuKG92iwl+UfGlC/uusrot5eTWVfUi4
 2OA+gbcAr4E0axgnGW+tw6hti0SxPBFFjtjl3DeO/kDiXKcf5I7MOVVrNnm0648bee9aUFWmUEs
 zKae+6QKQR/Gfa9LCgQlY=
X-Gm-Gg: AR+sD13e4+IFgM9JYuok2j8gnhqqgmc3gcGPtyyJCzReH+rU+USH+4hPx1BRsfuXdiv
 +3zzv3a6El39erWc/Qne4CYkKlZwbzJ/W3RWWBSNcWKKPe2p683nRNDTGPOOGvuwHD7+snvjSIi
 gEbRaXkwcar7GgjN/0SsqArwCxVkzxbNGC9Fm2EBwPoWxXrDJ0dRlrWSteWPksmKSrhJfHlu2gS
 VO6G75ybi8IEseyPZ628K+0IrVbUhdS0B1o6KncfPKX3tku
X-Received: by 2002:a05:6512:1249:b0:5b5:e1b5:e963 with SMTP id
 2adb3069b0e04-5b5e1b5e9f6mr402982e87.2.1787821699753; 
 Thu, 27 Aug 2026 02:08:19 -0700 (PDT)
X-Received: by 2002:a05:6512:1249:b0:5b5:e1b5:e963 with SMTP id
 2adb3069b0e04-5b5e1b5e9f6mr402967e87.2.1787821699243; Thu, 27 Aug 2026
 02:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-5-stephen@networkplumber.org>
In-Reply-To: <20260826235933.194681-5-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Aug 2026 11:08:07 +0200
X-Gm-Features: AcwNN1XNAK21QOgEb9n1XswfZPsP4UDFvKi4EzxpYQYghYxBmcNAJli-6V8lm4E
Message-ID: <CAJFAV8xy6SKarAo6Vx3VA4Cnv5c3o=crOzvH3_u64XLH8GW7HQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] net/qede: remove unused app version variable
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Devendra Singh Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>,
 Rasesh Mody <rmody@marvell.com>, Igor Russkikh <irusskikh@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fxHaR8cASfmSa7Jp4ETseNk0_6lWJ_ny6LVMzIU4pQs_1787821700
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

On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> qed_dbg_set_app_ver() validates the caller's version and stores it.
> But the variable s_app_ver is never used in DPDK driver.
>
> clang 23 reports:
>
>   qede_debug.c:820:12: warning: variable 's_app_ver' set but not used
>         [-Wunused-but-set-global]
>
> Remove the variable and the dead store.

Maybe go one step further?
qed_dbg_set_app_ver() looks useless.

>
> Fixes: ec55c118792b ("net/qede: add infrastructure for debug data collection")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


-- 
David Marchand

