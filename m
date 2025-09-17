Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E74CAC599
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 15:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E462D402C3;
	Wed, 17 Sep 2025 17:21:06 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 685E840285
 for <dev@dpdk.org>; Wed, 17 Sep 2025 17:21:05 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b04271cfc3eso869928666b.3
 for <dev@dpdk.org>; Wed, 17 Sep 2025 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758122465;
 x=1758727265; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY8zKzTtBSCWKWKGZH0DP0ZS0fQWzxtuC9QKaqBwiso=;
 b=E1KfmUDUB3/YqCHIddM80Y8IStO6VfB1zslXga0CERcqUz4aAAMhtAxEs2wyWXwYcg
 74zasUtAT4Iv7OLXeXWClYggUlIP9kjv7vPWhIlhW/Bhdc8yhBcQKOuD9F2cq2DEAf9+
 FAs7uxPjtVSA5wZs1bn9CTksXh06BdFRTuui2kj8jE+mvC7LiyCRI+d7GWEcmy8UJbnw
 ikO2flDgzFHD5RG7yvyzYEX1Fvma09cF/n8TnuvWivWvFXM48Xp2B50AODyBCJtzO8TC
 bpMj6v2JWFFlriV+UvUWT0i+7XLn/E0HTTxURk7vaHv/zim5SP3QCuMnYWekkS/2qU1d
 7YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758122465; x=1758727265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tY8zKzTtBSCWKWKGZH0DP0ZS0fQWzxtuC9QKaqBwiso=;
 b=OS0c9LNrP7v+EQ9qfZtAmk2IS9/ue/WD4zBAUmWZCCBn9I4LoVCtun5FBKc6Mzulkc
 r4yj1+XsfzR3JJRNvOgTRjBCm2Wzl+huxCfa8REFlte2lwVGcFjVFM9PfhdCUcJ9rj2Q
 YA8lNHpd3fuN34sbO+eMfLvGaP+CJ+1/yBr6lb/MnTxV2RnxEgBBd+nzrSHqodwfWS7a
 kHOjXcl2Y1nPFNM3j/weMUnMuMcflKO+uGXODopS3Qkdi/dWy8gR25n84+cCy4rtMr/V
 XPZGWXJJi8vcITTTVKJwAZ5Gb83B+JaG7tPjL6mYkkiwPP03WNt/ABbeN1qTcmFF5zF3
 tUow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWudH55PfPHSSgUTVnR8BZrAjADFf4sZykrH2YUIYBXQ8kTSmTcHEBJrRopQo7tV9h1xG0=@dpdk.org
X-Gm-Message-State: AOJu0Yxe6QStAogbW1w1/zYcXi+PZgwB8Dqa1kL2F9ZsipAL7x40V6Ou
 x0PtRHFbNL/tMWeNUI5+c8CGrnSrV8AJUepD8zqA+pFyptYpbkF9wznkxXVK29LERXg=
X-Gm-Gg: ASbGnctVp5AsStvHcCA0tV/idMHcr86O3Y5OrN9QUocC3NLGaTradf4W5jThl7to34b
 Bh69FAek0sSeRfaYfye/reZuoC8LriUdhwuUvsEFIfNPP3iFDEjDeCO5mAwbRCzgakmf1YZWoDU
 WCcKZ0RvH4nFyGImINWmVSTmBsQPImnAZItJYHL/Ag0rDnkamc4e/6e35ER5KAl+jbE860F7Kfq
 U871X5/lLPjJ+IUMfnYAHOCMYADswoE2OZqlzYuk6birqxp8JMSocSl+eZJaa6J3IyZagukdd6H
 KX+k4kK8N/Stfe2LmPs6QWp5yVpYb839obHVuZxp1UaBRVvXxr4BkHJmVXwH5l6/FfqogjOUX06
 UqLav1MQe3DjZBINhC02UAqzPz8sj3cHWJMxjlFNDAkIbgjXVsnH6CTpLOxNWIxTdFQt4jrNv80
 v+enfe2TYd2A==
X-Google-Smtp-Source: AGHT+IHPyaTwChUZtFgICur5d/qfUrxMBB1mDsq27Yozj0ycMdvmuDB+ce3CmBNm8KiakNnTfE+obA==
X-Received: by 2002:a17:907:3f09:b0:b04:2edd:280b with SMTP id
 a640c23a62f3a-b1bc02f6839mr310353366b.39.1758122464826; 
 Wed, 17 Sep 2025 08:21:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32f202dsm1396030266b.84.2025.09.17.08.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:21:04 -0700 (PDT)
Date: Wed, 17 Sep 2025 08:04:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org,
 mb@smartsharesystems.com, bruce.richardson@intel.com,
 ajit.khaparde@broadcom.com, jerinj@marvell.com,
 konstantin.v.ananyev@yandex.ru, david.marchand@redhat.com,
 maxime.coquelin@redhat.com, gakhil@marvell.com, viacheslavo@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>
Subject: Re: [PATCH v2 2/4] net/mlx5: mark an operation in mbuf's history
Message-ID: <20250917080437.363a2ee3@hermes.local>
In-Reply-To: <13612908.O9o76ZdvQC@thomas>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-3-shperetz@nvidia.com>
 <20250916141427.67caf4bb@hermes.local> <13612908.O9o76ZdvQC@thomas>
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

On Tue, 16 Sep 2025 23:31:34 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 16/09/2025 23:14, Stephen Hemminger:
> > On Tue, 16 Sep 2025 18:12:05 +0300
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >   
> > > record operations on mbufs when it is allocated
> > > and released inside the mlx5 PMD.
> > > 
> > > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> > > ---  
> > 
> > If you are adding this to one driver, it means it should be
> > done to all drivers. Which means it is creating lots of churn
> > and testing.  
> 
> Why a new feature should be applied to all drivers?
> We never force a new feature to be implemented by all,
> it is impossible to do.

It should at least be a reasonable subset of drivers. Doing it for only 
one device makes it much less usable. At a minimum need to cover the drivers
that are commonly used and part of the CI test structure. It really isn't
that hard for this history stuff to find where to put a few calls.

Also the obvious ones like null, ring, and any demo skeleton code.


> 
> > For me, this amount of churn and #ifdef is not worth it.  
> 
> I agree we could avoid the #ifdef with a dummy function
> which would be optimized out by the compiler.
> 
> > Think of a better way using some other mechanism.  
> 
> Except avoiding the #ifdef, I don't see what better to do
> for tracking what the driver is doing with mbufs.

Tx and Rx burst could do one marking step.


