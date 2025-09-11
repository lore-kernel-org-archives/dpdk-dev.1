Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F364CAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 23:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BC2F40299;
	Fri, 12 Sep 2025 01:51:06 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5EC8D40285
 for <dev@dpdk.org>; Fri, 12 Sep 2025 01:51:04 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-81f9cfa70deso93465085a.1
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757634663;
 x=1758239463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0HvjaY50yTyrrFbagIWTTjUJwCRMW8tAJG6zfxrOj8=;
 b=Jv/lTfRLV3325kxSs7h2ggb1cZJN1yYqW22oyBLoHXiKAsyZD6GwnfgTq7LjGRwZoj
 ZX3+elk+ciPl5DbRZUGHQfx37pPL9MMxaudFPAdQLvgZEKS0Gf7vomDHuIhZvOI5BGP/
 ppcJ2EBxmOPwV6xjNqFDpLglOqhli13hzMDo85mSFdsLg5qkTMK7tLq9HYzgjtYO8mWD
 4nVpt5f9WEQOR70HIGd5j3/9Jj/8MzV0Z08iXOHl1AoIUxyoGlQt5MgS6FRausAROriq
 kNZ1VLFFzQhT1s6jPg8oVjMw36pq2myKFK6nMC9/yUY85/KSc57prGOPl6QVECTXRANk
 hL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757634663; x=1758239463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0HvjaY50yTyrrFbagIWTTjUJwCRMW8tAJG6zfxrOj8=;
 b=d293wFCLi/feiPVFUHeAAMXoq00fA1LsuKNkaEtsqCaIOMDDtGwBNDMJrb7TpW24xd
 uMrTL21PXRSrLx46Uq9BGSV2NGpTkKC964Gdv0wsGd1rwlu7gUf+PwCOk2pLc4KXrk9L
 cMcwbSRn9XHvW+qhyqUYoD3fE5CHruQ5zeO7niHPFgsXqGUk/pLpUMQhA0qZ2cQo7LfF
 FTJD6Jk3IckuMlPv0kHSPSBsOJEFlGZwr1636shY02PqQDQZh+L7a+cWXpLAm1SP2dZS
 I9tUG7DD8TaAez0K2FQ01zyukfjZjrtyqQZM11uF55NxlSy5S0J5WMIBws9C2tXVe9iJ
 utFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsXg9aFYa666nVfhyNYuqws9tZurOrWz4cop3SrZPWKyIprD3I2TEgf5LTahhtxcOhc8c=@dpdk.org
X-Gm-Message-State: AOJu0Yx4uGuBpBcr//+XvApIBkyALD9e7nk8qbTpC88/CDt8j14BiYZy
 V0RKOUbu/XBQjd3ZKeI1NfsmXaiv/cPX8YL+O/QWY4VEhEsuEUCLUVJNonHzruLodgc=
X-Gm-Gg: ASbGncuxiKX5KUuz1v5DLgRD4TatWTZAlmyzUU1GwZJVHn/BV0xj29ZyQRO97eSmDiT
 G96nrEzcY3jn3mPyfNuG7ONCCFSh8A2jVDw/+9ET46E4IJHqdyYDiVZ0yEn4enM9nmSyEMfthff
 BUO7XEZFBpqk8C1JGpCbW+K8lK0rDxjI5RYtOpTqf4xObAwVs5N2VTd7D5G/vFi2LsTAmgp2EIY
 meKGHvrTsElTFH/lT0nNijmTCniakhl3urmyHu4zqoSPDY3RmjD+VuVtnKQatFtNIhSqczgjUCJ
 +9CI5KsEJa7fOsdiFMm0fqdwHTNyoVS6+reMoSLx+dgMGRtoOuFAnTs2AAWTy5qCznySibChOuH
 A26LWatYyztTEwyFonPjNYtxm2Y19p+OQkofXP17iSGbh24zE82JaaayeYxEoLdRjK4nIssWa1o
 aJXahdcUGvJA==
X-Google-Smtp-Source: AGHT+IESHec/Gwj+UBGQBC97IgvRZj0gXHYrJ7sVgdV1FSNpJ5uRwmiNrtwNEc8chmNLm+xqVQQ59g==
X-Received: by 2002:a05:620a:4044:b0:81c:b2d7:9d55 with SMTP id
 af79cd13be357-81ff5c558cemr598883085a.22.1757634663380; 
 Thu, 11 Sep 2025 16:51:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820cd701434sm180380485a.42.2025.09.11.16.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 16:51:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:50:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Lijun Ou <oulijun@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250911165058.31fd0101@hermes.local>
In-Reply-To: <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Thu, 11 Sep 2025 03:25:01 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the secondary process testpmd application running any fwd_engine
> and after that primary has exited will cause a crash.
> 
> This patch forces secondary process forwarding lcores
> in fwd_engine to stop before the primary process exits.
> 
> Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

Ok, the Windows #ifdef was confusing me then looked more closely.
This patch is adding a set of rings so that primary and secondary
can communicate, the adding one command.

The idea is good, but there is a better way to handle this.
There already exists a way for primary and secondary to communicate
through the mp service. This is used for hotplug and pdump and probably
other things as well.

The communication can be either way, for example I proposed patches
to pdump so that primary can tell secondary to participate.

https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.12786-7-stephen@networkplumber.org/

This of testpmd can be done in similar way.
The handler in secondary should be able to act same as
when SIGINT is received. Set the flag f_exit which will cause the main
loop to exit.

This can then happen immediately, and the proc monitor alarm function
is only then needed to handle when primary process crashes.


