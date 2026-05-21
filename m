Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2783CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 07:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E096E40290;
	Thu, 21 May 2026 09:46:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55CB44028D
 for <dev@dpdk.org>; Thu, 21 May 2026 09:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779349578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6rosQgJbTEMn3nbtU+NU2Q9stTmE6FqGY3vHaxPxrQ=;
 b=Gaj0W3eqag8nKyrXixRNQ2+idwsPuPfwDqZYFsGqFV7ltmXvbeaKdmwLReIgZIXmjhDDty
 VaayhWbBRPOii2zU0aK8a5bNM0BLlEkTXbM/PMk/08ahdrrAZ/qMTRc6Nvg9tuwqSGJ/qU
 qL67U4HffUsM3KxJeHrpzfYgb9wUUIQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-3KQGxO9YPa6jlbOzxxpQcg-1; Thu, 21 May 2026 03:46:17 -0400
X-MC-Unique: 3KQGxO9YPa6jlbOzxxpQcg-1
X-Mimecast-MFC-AGG-ID: 3KQGxO9YPa6jlbOzxxpQcg_1779349575
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a8eb090b8eso4321212e87.0
 for <dev@dpdk.org>; Thu, 21 May 2026 00:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779349575; x=1779954375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6rosQgJbTEMn3nbtU+NU2Q9stTmE6FqGY3vHaxPxrQ=;
 b=cVohYcscewL3NjiOmbZDoPdv1BxSFtA+jfqMPRcSKA8KbkeFmYyIQUwZFprmEwIKAc
 Y81S9idx64huIVlBtAd5ijHk+aJJ0c0lT3jmpGb0zfxYpuOeut5uT4XmrfBM0T2dZrA/
 lKa31jTCCLkOGvlfCZenWD2gZfIfUtNz4stHgIEIQDLS+j9kIYC4jEBZFRqHTLOV5OAS
 hrbMSQruS+OJlBxmXt5rkR21K+x4F6ZqmtYYgHKOl/N30q26TwxL2mu1sCPPgGLWxCXJ
 F9V3G46F1Fy/3BEUGrlTjto/+0IbnWSJVW+Lm7elxtK+KWkaTdOOu+7+t9+ljVUBU9m4
 rlpg==
X-Gm-Message-State: AOJu0YyLVUazlqfHR54poumu+WWTlTGsnj0WG3uh/N4TnC6r2l+LylBb
 xWw/N8p7UbeXuxMnWxSxwofyQ/kz0FYr7Ed/4Y5G39E3yzk+ke2Fo1NsaZH8apEJ+kUMPnb575V
 b9jQML4PIcsGjURK4vMGE4u92ONNhqXaUZCfTk0pCt719KiXK5PunbIdfhYcmA1ot8GD8JXXTYW
 BAAt+jryAkIQ3l084/Gf0=
X-Gm-Gg: Acq92OFA7QJq/Z5HX5vQ/KKvwaUpqxNHCJMjoNOFN2IJLEcw9q+qzfZFX1RWCVpGXuO
 yVWApbQYsD0tFIqWmgbENbBwNouM88nla9S9AgQRVqaW37mFW/N2rTGud8YNm8i4n2x1aF6UikZ
 R+8dwf424U3bugGC0eBvI/EVJiiQLTdUL94dHG0XY8fG2OKM/6XnSKfeg4Wzzw6DKcOfKwv6f0n
 sIbl5O9UXkgtZAkugBU4KyQ2qn89NLPJfZZObNttYq6+xxT2skA9+UcLeXtcZVpP8e3Sg==
X-Received: by 2002:ac2:43c8:0:b0:5a8:6cab:4866 with SMTP id
 2adb3069b0e04-5aa2ba97011mr423365e87.41.1779349575439; 
 Thu, 21 May 2026 00:46:15 -0700 (PDT)
X-Received: by 2002:ac2:43c8:0:b0:5a8:6cab:4866 with SMTP id
 2adb3069b0e04-5aa2ba97011mr423353e87.41.1779349574891; Thu, 21 May 2026
 00:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
 <20260506155201.2709810-20-david.marchand@redhat.com>
 <ag3tWZn0f4jIfVWo@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ag3tWZn0f4jIfVWo@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 21 May 2026 09:46:03 +0200
X-Gm-Features: AVHnY4IEH4SfOTTq9yg_kbItU5pzyIdx9qPN225x8au6R7BYNzLvxsVHRNk26-c
Message-ID: <CAJFAV8wNDO9cvcc+wL8kW0QVX5ZKWt1_8+Lug07jB+1RdBWDLA@mail.gmail.com>
Subject: Re: [PATCH v2 19/23] dma/idxd: remove specific bus type
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TnaF997GTCTl0N9ABoJxUnVIDCH6yb1BG5purPtSeCc_1779349575
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

On Wed, 20 May 2026 at 19:20, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, May 06, 2026 at 05:51:51PM +0200, David Marchand wrote:
> > There is nothing that requires a specific bus type.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
> This patch exposes an underlying issue with the DSA driver. When applied,
> attempting to probe the workqueues gives the output:
>
> "EAL: Device wq0.0 is already probed"
>
> For each device. This is because the device is not zeroed in the scan
> function, leaving a non-NULL driver pointer. See inline below.

Thanks for testing!

I think this issue surfaces with patch 15 "bus: implement probe in
EAL", where the dsa bus starts using the generic helper that checks
for rte_dev_is_probed.
But well, nothing is broken atm, no need for you to send a separate fix.
I'll add this fix in the v3.


-- 
David Marchand

