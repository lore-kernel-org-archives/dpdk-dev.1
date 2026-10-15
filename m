Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A509CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BA05402DF;
	Thu, 15 Oct 2026 18:18:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC7D402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792081101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0hZdEqBMTt8l13Bv6DjeekP2tkh5qNqrv6cDbC2liOk=;
 b=h4BC33nf/WNUEXzUELH0ZUEoBa+pNcFCy2uVK97bbj7NxDJHmteQBcAtv1MdoNSOqkZcnQ
 AoWabJK70vvuKo/P2VO3zK8t5uKetZgFt46ZX2OtOpTOMCLR5c52NR9rpSrLEAXe8ip2Qh
 7szhkvlOLxyrpI9kIuX6UtU9Oohpn14=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-VFw44CfUMca4T1NHDcGevw-1; Thu, 15 Oct 2026 16:18:20 +0000
X-MC-Unique: VFw44CfUMca4T1NHDcGevw-1
X-Mimecast-MFC-AGG-ID: VFw44CfUMca4T1NHDcGevw_1792081099
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so26836911fa.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081099; x=1792685899;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0hZdEqBMTt8l13Bv6DjeekP2tkh5qNqrv6cDbC2liOk=;
 b=wgY1URbr5RQ1fLJ8B8s1PD5qwL7z3dHPOzgPpUkyLSZOu9ePs4sYYjHszqOVjSvjbh
 AS2Bp1Jkl4ePp2g5YMJ6NyEppiZHk/92pj8mFCYmUqnNPDZ0MMJA7F1A1ilQH4dx+J0f
 2X2Ypgwf+78jGAP5UKtOdE+iNK39qrYe+kz9wVU/r8HhyEnc79FlUfZEb7hpZWlS76xC
 UESLTvkTkP16WmF83ab37y9unl7Q/252FR+o1Ohl7jahfcnzl6xTexBXZgU6rYiNX2vg
 61OBhLxvlwMiv3KVGT56BudKAp3KeCM2INm+O+IjY4HqIoWmmhrEjYR9mSAqC36yIsc2
 nSjQ==
X-Gm-Message-State: AFq9FYIi0IOpRzPi4a6bZJI7+mevdcU4xSdEpLFbBngC9vHNb57+bPvj
 JwWYHxl5MBXrfaPWtqIEAoX0Nrc37DT46zn40rOE6+4DSAz3TGBbjiDYzw+MtgnwydWyVTVTj1n
 4U/wSDxrxpzFpt/3d9qjcZYIRQ+ausTstfvTCRp5RNrhA7V50ToQ3D7ApExrsfQ+tUvxIg+JZTE
 0OdvHwaj9SyMGijwaCDdk=
X-Gm-Gg: AYBFou0HHwOBpP6IXiMeS5WULipIdYaB+Sr7iY3OnDaGbaK0g42O/JKRhg2JwLr17yw
 FOHOEu0pE3htJkEDOw4ESMDZr+DL8WW7D3mDqB2rQaaNCHYsfSp4HVCVSpL0IbW4yPl6mIgxxMF
 xfkfR9vO44SlqUNgAMoVnwbcLfGvMSWRnsnR3uLqEBJnvrwwCB19jtm6ymvi1nJrxR6C0CmqYXN
 R5Qv96xW2cPkR3oO8zKxakP0PpJISGMa2xzAmln/4A7NB2R
X-Received: by 2002:a05:6512:110a:b0:5bc:f400:6fcd with SMTP id
 2adb3069b0e04-5bcf4007230mr5292180e87.34.1792081099038; 
 Thu, 15 Oct 2026 09:18:19 -0700 (PDT)
X-Received: by 2002:a05:6512:110a:b0:5bc:f400:6fcd with SMTP id
 2adb3069b0e04-5bcf4007230mr5292153e87.34.1792081097870; Thu, 15 Oct 2026
 09:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261015160157.3348253-1-david.marchand@redhat.com>
In-Reply-To: <20261015160157.3348253-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 18:18:04 +0200
X-Gm-Features: AclHuK8rWZW1RlXFh15G1EhLsbJNgsZsoy4yP8mXKRh9ijRS7Wh-mA2CnEPTW_A
Message-ID: <CAJFAV8w=A5JUbeSjRREiYMzsn1JVqwtpzGWdkDC=Yz-u475j_g@mail.gmail.com>
Subject: Re: [PATCH] ci: fix dependency on cmdline
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Aaron Conole <aconole@redhat.com>, 
 Robin Jarry <rjarry@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5VM7rhXxsUv-NFgifoz1M1PKeWfqUV1FeMcyrq5CAo0_1792081099
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

On Thu, 15 Oct 2026 at 18:02, David Marchand <david.marchand@redhat.com> wrote:
>
> The unit tests, testpmd and some examples depend on the cmdline library.
> Without it, the "mini" target in GHA ends up as a build failure.
>
> Fixes: 6de2c9c791b8 ("build: make cmdline optional")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied quickly, to avoid red flags in GHA.


-- 
David Marchand

