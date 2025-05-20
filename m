Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED49DC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B7C040B8F;
	Tue, 20 May 2025 18:19:26 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id BF5494029C
 for <dev@dpdk.org>; Tue, 20 May 2025 18:19:25 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-601956fa3beso5679148a12.0
 for <dev@dpdk.org>; Tue, 20 May 2025 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747757965;
 x=1748362765; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XR6IDdAW/8xE1w485EVaGsWC1r8cDFisZSXzUVqm1o=;
 b=lYdnvhoFEQU865dAjaFRt93TReuJ9f9QU6tW9BRfi00gT0LZwUaoXxYZqvFsc+vkyU
 j4nLy/An6Yrg3aL/Ay1oAjtDRYEma+wiqOMiHC7+ctI8LGNlzbUkYHgDAp/i/dPtCVzl
 jbYyk8yMARAs9J6jgPi0lSz2ecgEegmH75nCOJUS9OrJZhrfaxXOps4pWhpnsEh4gjZt
 z0FVTB8s4pX6mzBl4TogGIYt5D528jMOv6sfdVj4Q76XVzzEq/dE8LIEQMUhR1dZLUj4
 tg3N/BMm03jV2CJHUHoFlzaJr4aK8LOY3UuS7p1QJi8CvkYmxJ7PUkoOKcree4Bqryyq
 rkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747757965; x=1748362765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XR6IDdAW/8xE1w485EVaGsWC1r8cDFisZSXzUVqm1o=;
 b=Q2hpnqZA0h/9mgm3kobHotVP/yOulOTtvHAI419NtelvU3Xsdw/pjbbPuXSQ71nK3a
 w8nxtaURrrOz6XKRNzuIJ9KZW+eM9PfOV6pkNmdH2baPq3y4OW6ZzDKZZZKBbQ0r9Gyi
 x8xkeew4U1654IYeO799GrcvlKoTZ45kd9lM2oadCZ3BNy4+yurR7oVmfhmyOHY5QRZp
 DIgJfR3szlxyko20svV9CWGdLno7g7tRZYrrlELmeWXsndSZYb/Tw6j85Ba3l6nWF+pI
 eukDMYqT6ytFZhQb2zVdUh5raMrWB+1/Tq5tJj1Qsv84SsEvXqWVt40hlMmKIhVmZHu/
 4TEw==
X-Gm-Message-State: AOJu0YzzNRGSM5Ti34+RiRod2bv8QiGXCFuNBp+/WIR+ccEj5K0ZvNzZ
 cChzj8kiNKPTzfJjAvyxk7VchUPTqAtW+/mTKYYWb/i+jA6d+DmTwh+L67IjjAUsD9Y=
X-Gm-Gg: ASbGncvFRXUxcacjsjwXIsUGAXWgUSXyX3T7IOzec00AATRQYsz5+lA720MFn8+rsLU
 0wHtY5/ohKZ+YuniidNSTAAo+UUabOnqXQju08Vnvlifgs84y4pglAynE2wxkIcpRDzSWIgfi6/
 beMu5Jmneuho1G6UTdhwmRoYe0rW6HxNbeaR+PDqxNbr43cQdF87kHe9ekcWgJKehJLNzr0WKW5
 Zdih4UJiOqnCFdMG8n4LiaNOErp7sowrakLulTQr2Je3Db7g3j+aGOK1rorOAxsTaoL4RsXsttU
 E018+saRVeLsiPhdsUmutacOo3MXn6NsTj4oDaQHo88Hob3Q+bpUBS8Nli4cEQCoDqHcVh3Dock
 1mi0rbWa0QUci29AadJGo24xxnDk7
X-Google-Smtp-Source: AGHT+IHOyRQ2ZBNKVYs3UF2EhqAfWZHW0V1ZT6GBjwBHM7SLNp+Z0pkYQ5Di7DnPnUVMf3aNLDc7EA==
X-Received: by 2002:a17:906:387:b0:ad5:3504:a6b with SMTP id
 a640c23a62f3a-ad535041225mr1047592766b.52.1747757964704; 
 Tue, 20 May 2025 09:19:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca3bdsm742708866b.160.2025.05.20.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:19:24 -0700 (PDT)
Date: Tue, 20 May 2025 09:19:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 2/3] cmdline: add floating point support
Message-ID: <20250520091917.6d17ad14@hermes.local>
In-Reply-To: <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
References: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
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

On Wed,  7 May 2025 16:22:11 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. Use C library for parsing.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

This looks good, please resolve the checkpatch warnings.
Not that all code has to checkpatch clean but lets try and make new
code be cleaner.
