Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF7C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DD4C40279;
	Thu, 13 Feb 2025 19:49:32 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7588940263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 19:49:30 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso21001135ad.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739472569;
 x=1740077369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqtjEOfD/TybbTnN3tUs5TWZCI7P0fvuvPsi1MCfgUA=;
 b=n8Y3ZBJNX/pVT1bICFPmm0KLENrmo6EVB5KXZL6ybJACVShy0HiY3CnIIOPLxsS0HE
 D0NIH590/zxuW0KzUOiHAfJpQ7zHmZutRPILAh9AmpthTx6vYYy4usmS6vb/Fma/SLFd
 gnb5noegeOjqckho4IQKUp7OGuWMEm286W2mN+y3R6EQKqz4MG93tR6lFUa9wwCq9fMS
 a8KRv34B4+tqtayt/Yq7lYnRWLzM1ljVabMGooE6SxKffwSDHK/VxAaqcPjpHqzDzgvc
 qceEPMkPxUR1FUTLl0k8XfjU6CE1WodXfxwktDZUrpLFxiYcH2J2B9z06X9Wd29SBMtB
 eb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739472569; x=1740077369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqtjEOfD/TybbTnN3tUs5TWZCI7P0fvuvPsi1MCfgUA=;
 b=RLWCTIlTYcyevQPVn94SBBagh5a2DJE23EPKRJ/4jZyU2mo239GtxmKIKpEtuq4yuN
 09GFJ6HtyvkpJzd1ZUHErK6Tef/QjajYgphClW8ULo9OSpZN04Fpu1SmnK65+YuJO1FI
 oDoKjCcFX2CY52QiuPdVAJEEFz9iTmHPCbtGe/D8mKuLlGqDqc741WOXHBVJD1pU0JhE
 1c+OXXJseSNG6gtQsJ79wVadQwYXI2rQgh8HuFWgey+6ZTnJk2Iwv5p2i+EgKQ5PsXEu
 y0lhEziUUfUSqoGjpOxL6u92LrF/elilCXcx+yZt3VaU46lh55zAKmDBGQnKEsyl+J8k
 M4vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu0QyDdh6K4XSkMUG6gg7Yad3EpDJzayR7Ecy101+CiKadWGxKKqtoyhIxvyFS5PpoT8k=@dpdk.org
X-Gm-Message-State: AOJu0YyQYuWNjdi+KhrI/Z36+birIImIHcfB6Npz/WI3xuJUbHe5lpzu
 968WBoMJrOMuusyXf7IKjrAt7hGwiVCKb7qrMadrrd807qItyjXH/suHRingCmU=
X-Gm-Gg: ASbGnctBtyKO2kpMKlBd80VWDIggs/BE4B03NsNmE//4WMUkf4w/06r3P2v97Uu4iul
 qGuC8IaPT/ikWk8WIFnS1IWFZ8GGV5avdpyML0VL6xoaCnL2XrAiYF++fdHX3iCqOs94ZsIxhhO
 JDS/ViTRl2f7NJ40zJuV4dapxfFUEo1o0IXHD9Waw33SUMbZoNHS4XntVeWLDSePn+5FUNksbIT
 p29pregAdCt9T+DgYu9UxIVAeTWXPzj51anOuwnitYIRheCacq1d6/Iz6Gnx1fFe8oKFkIBdy2o
 e29Lbuwxt4cqZeQIYyRNSxRne16WtD9EwbxrS4A+R7pOPB7BARxdYLaY7jnYSzu0skTC
X-Google-Smtp-Source: AGHT+IGuUkE3YA8ras6t5LK6gs38vNPFxEv6chkgYqjfyYQYsGsUhdKd8Ibc4qgc1ltGw5dqOSCBxg==
X-Received: by 2002:a17:903:2281:b0:21a:7cbe:3a9a with SMTP id
 d9443c01a7336-220bbad69cemr120704545ad.14.1739472569537; 
 Thu, 13 Feb 2025 10:49:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5364385sm15515745ad.63.2025.02.13.10.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 10:49:29 -0800 (PST)
Date: Thu, 13 Feb 2025 10:49:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v12 01/28] net/rnp: add skeleton
Message-ID: <20250213104925.08d7040d@hermes.local>
In-Reply-To: <1739374368-4949-2-git-send-email-caowenbo@mucse.com>
References: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
 <1739374368-4949-2-git-send-email-caowenbo@mucse.com>
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

On Wed, 12 Feb 2025 23:32:21 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> Add basic PMD library and doc build infrastructure
> Update maintainers file to claim responsibility.
> 
> Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
> Reviewed-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  .mailmap                         |  1 +
>  MAINTAINERS                      |  6 +++
>  doc/guides/nics/features/rnp.ini |  8 ++++
>  doc/guides/nics/index.rst        |  1 +
>  doc/guides/nics/rnp.rst          | 82 ++++++++++++++++++++++++++++++++
>  drivers/net/meson.build          |  1 +
>  drivers/net/rnp/meson.build      | 18 +++++++
>  drivers/net/rnp/rnp_ethdev.c     |  3 ++
>  8 files changed, 120 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c

A new driver also means a release note should be added to doc/guides/release/release_25_03.rst
