Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CA3CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 18:24:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BA544021F;
	Thu, 28 May 2026 20:24:46 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id C8F2C4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 20:24:45 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3045c195251so6885131eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779992685;
 x=1780597485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGRBtl33f7o7W3gIkNt6leuIuFrzAsdz7dz8PPTwSsk=;
 b=wO8v5oFZ8tc0ec0uxnUoVJocwpvzpYfQS3BkskRQC7s7193ewSFcvTiIINHpU7wpB9
 TmNI2byZwOe4VNiqHS8i2ikyS5M914rorS4ryySuNWF9PE/u+EhkJgasGUyGNHMNX7XB
 tJczMVouOOqfLnIKvCrQDzxSN644DpQJc54Mcl4vPLSnU4xM//lSszy/siWBbAN5kJbV
 GfW7cTLKAFBYC8mZDFM0wUaKD57WechLFYOmbzJ0YhMi8rgKmwYTSLDYsLBxkcKOAvHK
 xkP8uGc0/B4/9G4GXrNfywXQNbUXkYjs2C0QCt9p0zWgZCE6TywArhNXlKI8y33yg2Ad
 4drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779992685; x=1780597485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hGRBtl33f7o7W3gIkNt6leuIuFrzAsdz7dz8PPTwSsk=;
 b=kZDM04qyDVFv+M8tnYnOHOoJyceqxQTwEDx6Um1AmjPDinGbD+Fl2aKmh3hKUoH0gn
 nduR+j1cWINnLuIuJgKTnDnA57n7kzfq+mLcO+BH9BaNByHjdBL+f2zEk/QNbMni3phr
 IrJY1tSPYGLnaxSp52utt4ai3PJytfnps+EK1x9Knb/kU/5iM4NgSWVsvcwaFBTLdWzz
 ACSmQfHJzuFt6lx7fjmTycOm189hzQhANrQmbuegldtDEHXSLeW1MuggLPfNNvpCuNgD
 YaxzOvME3r2PGhisnBwiCra7cvWXFiYiCnRCoNByWUCog7GsMWXhIUIYwOitrF0R3Cov
 8L4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GFbSzAvRnUB1YjFwHnp77Dtr8FdzPWtOcZw0AdaC6LJUR7SHzNsH2sMTAOlgf6zW6d4I=@dpdk.org
X-Gm-Message-State: AOJu0Yybmg3VXc4mSdz9oFN/GB0J6wrBxhLKYruDsNGpFugnrKYvBLJb
 89LMNX/h2NsmpEILsrFIUs+1RKaiVnAwkNzS/8kHlTNCWXBCZcsUulySH50L5UZxveM=
X-Gm-Gg: Acq92OFuqv66qZs8/Fjx+wCnTSGEUVdXeOpkWF2nSkgUYZPjqHkOwEvl7SnIORna+tY
 EPZPLcya1/aFDRoSmaTYT5da0SD0MRzRM/0mCHA8YslsAFoqwNEPKfImbSmsrxnti3X/H9QFCg5
 cfk2H1+Vd0lNofLrfTGlurQHxcRb8ODzGbM+994qfCrh0AKMSnnrl9I49yjaeuXwmlvnkwahALW
 jl8a6LUU5M9wwEGDjdcGMQupqwk915W8scguF7D43+DZfdkIsiXg2TB8nbrcUIpNwj8k7n5uzAI
 EpZEOaHTZZGUf6O8ikOW0x6N1W9cq549yGKNfOhqQaVPqvSpNbF8kkkp9IR8qxtTpNxpPmfzf17
 tmj1ImVQQ4XRByvx4mv3aetCKty4tuXDUaji4ZA2NmbB+//Rl4oWxlPzNuWjp92WtRW/+lJU2Hf
 ECRDGplwFRrebZR1D44gevY6bmPZoON9xH23uf8XIMQbmmPPqeDtMAzFm8RsEFV3StofEG1ASKH
 AA=
X-Received: by 2002:a05:7300:6d08:b0:2ce:25be:c8e8 with SMTP id
 5a478bee46e88-304e9139e95mr41280eec.17.1779992684450; 
 Thu, 28 May 2026 11:24:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e94e54besm13974eec.4.2026.05.28.11.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:24:44 -0700 (PDT)
Date: Thu, 28 May 2026 11:24:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@microsoft.com>
Cc: Wei Hu <weh@linux.microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>, Long Li
 <longli@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 0/2] net/mana: add device reset support
Message-ID: <20260528112440.3f7e25cc@phoenix.local>
In-Reply-To: <SE3P153MB18483B2B0A91A49747176C88BB092@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260522065943.126703-1-weh@linux.microsoft.com>
 <20260526123747.46871467@phoenix.local>
 <SE3P153MB18483B2B0A91A49747176C88BB092@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
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

On Thu, 28 May 2026 07:30:03 +0000
Wei Hu <weh@microsoft.com> wrote:

> >    so they are invisible to rte_rcu_qsbr_check in the primary, and
> >    the secondary MP handler (mana_mp_reset_enter) does not call
> >    qsbr_check at all -- it just sets db_page = NULL and munmaps.
> > 
> >    The dev_state check at the top of secondary tx_burst is racy:
> >    the page can be munmapped after the in-loop read of db_page but
> >    before the doorbell write at the bottom.  The "All secondary
> >    threads are quiescent" log line in mana_mp_reset_enter is not
> >    true.
> > 
> >    The secondary needs a real reader-side primitive -- its own
> >    qsbr with secondary lcore registration, or an rwlock the MP
> >    handler takes before munmap.
> >   
> 
> Thanks for the v3 review, @Stephen. I will send out v4 to incorporate most
> of the review comments except for this one. 
> 
> The review on this point is not correct. Here I am providing analysis from
>  AI and my own test results to show why.
> 
> The concern is that "rte_rcu_qsbr_thread_register is only called
> from mana_dev_configure, which the secondary never runs", so
> secondary tids are unregistered and invisible to rte_rcu_qsbr_check.


Thanks, I have become way to familiar with AI reaching false conclusions.
