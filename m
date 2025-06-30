Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23482C8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BAA5402A5;
	Mon, 30 Jun 2025 17:02:06 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2468B40291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:02:05 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-74af4af04fdso3274296b3a.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751295724;
 x=1751900524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2D4QViomfLEZpMRDUzmhI81NSfQBgcHwgK9JsZQPxw=;
 b=fJmaq0FPTJi+maycpZa53VjArgaUdEGlNLkDYSxeRpPkaRdHh+mxnu07Ytda1DrrSs
 nBu+0TtvET8Cmf3QAcBbKlHefss1fNUOTPbexbhz4/4eL9N9GC2eQCELEmNpEoJOp6qN
 haXh9LB5T+uTjGXJY3IFHDQ5y/Ur+zVpoSBsis/H9ZeK12RFLrXo7vfwp4nIgVIQlZvG
 ZFTvEblXwPSnQ1sH6uGLJ3dK7Av3LroJmfwbWC5YhjpgLvf9sC2cLpoj3ZxRN3UzxFqT
 g+f0R//ePelu3zy6bdnO1kcOldlhQGCg7vnAWP1sw5qncZanw58P4HmsHlNj1xY6X+60
 UmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751295724; x=1751900524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2D4QViomfLEZpMRDUzmhI81NSfQBgcHwgK9JsZQPxw=;
 b=qPHMy3uAQQfENczUyjZ/HbmcDCEYxojFvkxmRwaSmj9cSClOGhYwY6KhPhUrmT5is0
 lPiQIrlFXaBf2scAL4AJQPwBgE1uCftSekfpFx34GGS3TX6812B0lek3ljPcoQbBkQwI
 1wO6EWIBSWQ1LoS++YPq/WFP1QMFSYG2AFt8oOj8FwNHQszOXsHVcd/OwwmqT7zV2Rwj
 edurArBWgaSB3AaOmx0rkjuzP3gCY35ExtQEV014W80yc/LqMED1r+3e04moLfPuZ6kV
 RdzgQxs7a0+TCNB6XtuMHmsC98gY3D3GLLz7fPlHzcEeyFVAuYUJmUZT5f5JgeWdkp7V
 S+Kw==
X-Gm-Message-State: AOJu0Yw1JS3PSEGkWxC3nTIcrlweoHV78CjvVCTaOsLTo19rjDHbKSwA
 iN5pR85Pg9u1tHIpG2stX0zYh6BREDyTYRal8196uVoO3reYFKgrJwJ1X1WKKyTZgSM=
X-Gm-Gg: ASbGncu1ymM5vhW8xMwG6K/Hm78f9IpPRJeDC03sG64AR7CJRM95ckTDJFIa1HKnOE+
 9zwYJ7mkvW90LA2bR8l0+C/iYN2eKcAM1wDjWKkhVcMcImOYNM3r8dJoGPCIehVWnV9ycjA7JH9
 /NM7wIhjz46Gih9Nem5JmJzg1zC+UikNgP+9nj1K29qoQrjd2VH+S97Do8XxEe3KhJQM2VcaeGj
 IRAllQe4UKdZh9MUugNDNJhglhMlUS043Jrouol9e0BDJke7GmeeUCo18F0A6ci9XBRveGJLYSL
 7JhbDcov9v49pHneWoL+PrpZgO3CZSGwf5RkO4HeC2vZ+RxyIylvjWaY8rmE/0a8PINyEdnH4OU
 SCwtHVgUECUivBQsOjSDVpS0cRYRt4pfsYqgPSMw=
X-Google-Smtp-Source: AGHT+IG5lc3defBPmDKE7KYKtpR2UqVmGv41PJeuVcWJnFsWq0v9DgjMD+GduwpdMdvdMDSwdIH94A==
X-Received: by 2002:a05:6a20:12d0:b0:1f3:31fe:c1da with SMTP id
 adf61e73a8af0-220a0cf7360mr21510354637.11.1751295724102; 
 Mon, 30 Jun 2025 08:02:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af541d233sm9764646b3a.61.2025.06.30.08.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:02:03 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:02:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 25.11 0/3] remove fallbacks for old Linux versions
Message-ID: <20250630080202.2d026cdb@hermes.local>
In-Reply-To: <20250630132904.1704901-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
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

On Mon, 30 Jun 2025 13:29:01 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> We no longer support versions of linux before 4.19[1], therefore
> all supported linux versions support F_ADD_SEALS (Linux 3.17+) and
> MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
> support systems which do not support those features.
> 
> [1] https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software
> 
> Bruce Richardson (3):
>   eal/linux: remove fallbacks for old Linux versions
>   vhost: : remove fallbacks for old Linux versions
>   memif: : remove fallbacks for old Linux versions
> 
>  drivers/net/memif/rte_eth_memif.h |  41 -------
>  lib/eal/linux/eal_memalloc.c      | 174 +++++-------------------------
>  lib/eal/linux/eal_memory.c        |   7 --
>  lib/vhost/vhost_user.c            |   7 --
>  4 files changed, 24 insertions(+), 205 deletions(-)
> 

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
