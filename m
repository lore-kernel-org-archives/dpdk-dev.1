Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC3CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 20:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D37EE40292;
	Fri, 29 Aug 2025 22:33:32 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 262074027D
 for <dev@dpdk.org>; Fri, 29 Aug 2025 22:33:31 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7f04816589bso234451885a.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756499610;
 x=1757104410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V74tsM37iBOh6m8FmotlOd/iSOHYqK3aN+YMO5zTsuQ=;
 b=bO1nJ0/liMkVz6gmN+lJXS5MJHNtoBT3vQQ2xjyvI+aHfguaa5W7zeJcmx8m6aIfiV
 0O7Ms2YNw9lATjhSD6xYG/GMiowxUlnhJTOt2M0lpVvuM3eZRuY3BtF+nufhyH5QUNmu
 tFwduCegDQzXLGnOAXSWrbK9vm7/DvdFcf/a+W9pUI5zNJLRNc1Tw030B/+0d5sOePPz
 ofbbFJD9teMZfQGp/t5IqnX2r2evYlwzDqBIT80Zx4i69LruDjpvbJcrAGCakXXWxrca
 7ZgGep9hHrkX+uW761beHZdPDp6O72Ig36ZYAhDBmAlP6ONOinM7vtfxeuaISZ6FBtki
 6sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756499610; x=1757104410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V74tsM37iBOh6m8FmotlOd/iSOHYqK3aN+YMO5zTsuQ=;
 b=SxzwCvcxwDo99E2drXyLP6J1GMejUhEuAsQEk955KB9EHOc75/DpVCnwsUe0t1n7Pz
 EiTzeNUFRYLTrHaiiG17yRWFqhlEC6qGSgklOPaWAJB5E6PuNAd0x/+QRHmV877AuCIO
 o39TvOunFB/e2XfGymqogMeC51q3idOg89GCH3rH+MzyrwCTGfwFS60uCIxqEnzJDXws
 tTdfl8vx8iGHaQjF9BUa//+yuDWTmyWxFWQIHz4qMtpoUWusdxe66+YfSdRentSVodzl
 iQyhLx5L9kffvPty38f2R4foAH+lN3/2R2WIIcm8XhO/lyHtByun6YEe5gCyaWIfCjR1
 RpLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/PX97JVESmPw4NQav0wXTl3laYwE0Dq+QxxOCugigOG5dFsu1QTu6WDUTsoHfdNEa+0=@dpdk.org
X-Gm-Message-State: AOJu0YzYGPj8Ao8IVK4uKzQgrcef+KQbTKSy6+F3T6SrmR/NYoHzjN1X
 lMdNhkw0OZdqMpjZ3pNUJMr2eJK3kiACujEFq3BbmIVXTR70sNoFNgwm3iKMX+5IqJGAq08lDo1
 Aafo3
X-Gm-Gg: ASbGncu1cPvBLHM8kPj/DAC1ZBdMhfF4fFfh//gTc/2sKxJ5IvRuMIsooZ0IPvpa5u4
 +Um+6SOX3wmzFt/pk9jT8tKd5IQ9mu1UOamz01IKYEwuTukwI4MFmb+8UfC2aH5BFyqFIlD0h8W
 pObaefrrjDRwiCXNzGPo5s+XLSzoTobSanRFgLhuC1FgK351CfL6gO4wgYU/j55JbtRUW7unPUK
 9JKferh08jUV6v8rUJZSOnzCvaW39Lou7nd7zdy0qR0q8NbKc785thxjsdc7xudcd6DHhGWXIAR
 64lmp0XrsJYRGlljidTYy8uW/AyFHfEYg9lxOsRGyTcU0IsUJ3SrB6/6F3Q3QjFSLYmy2kQvZPy
 tcAayf7f12k/poZksgRNA/HLGNQdcfO3Rzg8mS/CG/96pQVG/JoFh5gORbRx05xEKDED5E6XZV8
 A=
X-Google-Smtp-Source: AGHT+IHMZ8u72A4RvhCGgjbd6pSqpzWpbZLIUW7o7Ib3EvqriBcaVP3AS0yZkHEVdBTUGOkgPwTuKw==
X-Received: by 2002:a05:620a:6cce:b0:7e9:f820:2b91 with SMTP id
 af79cd13be357-7ea110ba0d7mr3002839485a.82.1756499610339; 
 Fri, 29 Aug 2025 13:33:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc1643ac5esm237779485a.68.2025.08.29.13.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:33:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:33:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v8 1/1] ethdev: add support to provide link type
Message-ID: <20250829133327.67ee8d48@hermes.local>
In-Reply-To: <20250821053425.3227866-1-skori@marvell.com>
References: <20250820175317.3063659-1-skori@marvell.com>
 <20250821053425.3227866-1-skori@marvell.com>
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

On Thu, 21 Aug 2025 11:02:33 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
> 
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

Looks good now. Would prefer that you settle on one
term connector rather than mixing 'link type' and 'link connnector'
in commit description and comments. Do you want me to
make it consistent?

Please also provide release note with short concise summary
and what user should expect as default until/unless drivers
change it.

