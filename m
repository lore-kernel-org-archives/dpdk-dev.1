Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDFCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 17:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D46DA4042F;
	Wed, 20 May 2026 19:07:44 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id F031B400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 19:07:42 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7cfc382d896so17291837b3.3
 for <dev@dpdk.org>; Wed, 20 May 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779296862;
 x=1779901662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMxhDWxbMs01OYNeVfx9EdLJRs/I4aD59xafYm6/WRY=;
 b=oZsS3CkmN9ECendjU03LA/VhQNm+eGyp9/X8SK+u5FdrYzabpZXtIdoTlZ3hc3G3sN
 jPdezZ3FUHN/rpBXf5SqZJl80/da2E8/KgWMYowPP5ohzhsMqx+04N+QO743GUGIqiCr
 Poo1b2U6VLuRaS3H0JsgASU8vefC47oEJSbDWFNIZFGAXDh3kdfDecZzjO0469Tx6mXP
 UIKWXL09e3tLp2yBe/pSE8l5nsh0YUbNKUoYzrjVr5SY6B0T9W8pSygmBMxOgsDqKXW2
 j5UCVEfKjVtuSd2Mcs1zuW5ELZdoHzLY5Nmp+H2JpwIdK4sduEUWPxZRysT7j0EOfWDo
 9Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296862; x=1779901662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zMxhDWxbMs01OYNeVfx9EdLJRs/I4aD59xafYm6/WRY=;
 b=pxNV738iLOalvk1g5dSO2aL00tx5vdv22C4tzA2At+hfdORtmfQEnYTbORDC03pq9D
 hnr6Rj5nCMRNHfGfrI8PL81IG0J2sl01AYlVRBB7nDcCRkyU25OVL7iUyCxwMBrBQuy8
 TgwefzyQRlya3rOg9VjnivFVYF4NJi8THZ9tDP5Y00+S2bS5VjF5/M8PDN8NIrnVdWX9
 oojEFzZ+j7Fkn0AQzfiHZ7jF0NIAuuCpt5omZlX/QJsgJb4qbVzGB6XUpWWPhL/zh756
 YqhYsVm+nrBaBRkM3tBAzeqXD+CY9NlLxOJym0N12Vg/aD3RSIi9TJFa9niCa5I5Gneu
 LFjg==
X-Gm-Message-State: AOJu0YyTHlp1BMAA221VF8UzXvBYcSuMFvwCpiaDGgnoDkGdWkysBnHH
 PtkZvAin+HKRyN1LIIoos3CSxjgWPqVYLiiWPAMzeNtQ09GPE02z3lyTaPoZBua6Ln8=
X-Gm-Gg: Acq92OHN0b1zNsX5ZNc0EYJR5/2kxIzv5oNzz3nfywOWO1u+379wy0il3kWO/7nehKa
 qnFRbIppygksy0UpBtb3uBcPvFjD6OkkpC0/umr8oV2C25Lcd8BdINs/m2fs9k8XZ8lWeyNNc/Y
 7Ke9Dj+FPoVqCIqj64scvjzNjEu7UW1J9YXvFm75O3ARDLxjRcE2bcHpmTDTtYnOiUXFNd05spd
 y6kCsFhA8GDMuW3rJVoSEHvFxwm/r1f+tEpVbd3277LQW5NgO3y/VbM6DsI3Zi8C6HuFMAd8Uui
 Jv2zzhoxGcoVX3AWv8hnP6qhOKI/TJicFl3CcA8MwSMFNMuZyH0P5td9VzCvf+kbm7aTbtTyBTY
 e2HMKnpwoBT0JmdkLBf8tEJsah0I4vf0y9F2k0l6WdNLPan3FkQrNjQIRIJ2Bg60cTfPgTFIBxJ
 Mvd4mkq6UNtRq4Wejlda+dFtZipXTVNs0krOuhboJFMTTeuwPnVvIHD1zhEAFYL/ZiI1jm6p34z
 RU=
X-Received: by 2002:a53:c04c:0:20b0:65d:b6dd:69f3 with SMTP id
 956f58d0204a3-65e227f6c40mr20082168d50.36.1779296862120; 
 Wed, 20 May 2026 10:07:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0dbd101asm9477962d50.19.2026.05.20.10.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:07:41 -0700 (PDT)
Date: Wed, 20 May 2026 10:07:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal Sieron <michal.sieron@nokia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] linux/mem: atomically prefault hugepages in alloc_seg
Message-ID: <20260520100738.7042b965@phoenix.local>
In-Reply-To: <20260520125756.530808-1-michal.sieron@nokia.com>
References: <20260520125756.530808-1-michal.sieron@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 20 May 2026 14:57:56 +0200
Michal Sieron <michal.sieron@nokia.com> wrote:

> In rare cases, when a secondary process calls rte_eal_init() it can
> cause a data race during page prefaulting in alloc_seg().
> 
> An atomic compare-exchange in a loop should eliminate the data race.
> 
> Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
> ---

AI had good suggestion when reviewing this.
Your version is still racy (on the read side).

A simple non-racy, and no loop version would be:

	rte_atomic_fetch_or_explicit((int *)addr, 0, rte_memory_order_relaxed);
