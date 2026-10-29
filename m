Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97121606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VdtMxpVB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A1C40664;
	Thu, 29 Oct 2026 19:04:05 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mails.dpdk.org (Postfix) with ESMTPS id DA9984025A
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:04:04 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso616149a91.0
 for <dev@dpdk.org>; Thu, 29 Oct 2026 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793297043;
 x=1793901843; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1INbMM7UpP76q3QDCmwbVdIG8LBPggQ4RtEXJ5ZSDBM=;
 b=VdtMxpVBpIHPVEVu+8snKvKtLgp7rjYSvUfmiDSL6HWwNbLpomYaMy2OTGy046MCy+
 X4o32XyMkxISh8WXje7iiRj1Yq0reFqG9KFc9wBJ1NivgF9LJjp/49jpIet/vIlyCj4Q
 aOXgufl8Qib6fXSCb3lCKhx/A4CV0N4i4zbQDEDlzgocwEuy0wW01WatixRca6P8tdix
 c0aDyG785UFTyp5Rtrv2Co02/QrYG1fM8CfdgTAjOtpWIrA7TaXjLGA/xb9ScKqV6p3B
 gLLDQGCIBljZHJPyXq7e9ldDwB2aoD/M5ZrzAscH8wllHB3ulWRFI9j8d2Bl8HVg8D7w
 R39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793297043; x=1793901843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1INbMM7UpP76q3QDCmwbVdIG8LBPggQ4RtEXJ5ZSDBM=;
 b=va6MF6a12zcuvDtT2hUEL/Gl0VU1sPpf0CwUdG/lzaNgqgd6obE4JGPrsQ1G0w2gT5
 kRczLQv2T8NjwMY0vxQoh/J6EqxvWFDjLjyp0cvjA1yCWbM6DZfKBL4TYE7sqCVGWT7e
 Ws2eFXGfEaI9shuNULU12KADBPoCdXuyT0gOlyATwWeUkvhzf0g83A4NzwIHaaJAn/4V
 nxq3lHaeccP9aQw8BT9PrFPnQ6ysm6BaI+1bXk5x4zIO0yqVw9MsDabU/dRwA2Ez7Z4B
 fmprFiPH0fyRGKhb3p6Kvwb/v/b+C/qbZXLSF49pWCKQsyVIw85SbHC5l6kVGtMqPMQi
 /kGg==
X-Gm-Message-State: AFq9FYK3UbyWcutPFQ4Ppt4KLXN0l949sjDFvMTsXQLZIxkEc0h5+77a
 E0Uocx32Oka9mqS2pLwIAlGtmkaPYDDEpjV2a1OdMMYHJbb4JYld4seWIQQxSNVrxIF5MqrIweN
 QksBX/EQ=
X-Gm-Gg: AYBFou0LmHLwmQLCy9F7B/39uiprkLh+plXBlGhcfJrCsE08L6DZjqk43KP44+c1Sxf
 AzZ9jMMM/ers0jqE3W6Qlkgjbe39aWoRTxSIWsL/oWcfIUIaM1X5vcWNyYx/70L9t5X49MpVEFI
 DyqE1u5RAfqrZOXsdVLOYEm0l2cF2XkuftS3hTbP75fr5FB3r3r9qeEjDMLHPIMkIfKeEwdJRwW
 KqrvRYdLhu4D8JCCtlFd0wG4kbghLBfr4upj0Z3eR6g8gy7h8fFwIlwIR7O2sy8unhyEEjWU0GV
 7M2USl8TpvGbJj1e9pR6hjaZp5YtJfeqhINbwD+xZd8Z6a/nwonB6rmcEPaYFsJYk1S+j4zanMJ
 ldcL6Gthk0FC9nxKppg7IWCDQhhS9O/AOhw+m1ZKoDs+TsGpk6K4mU9eELtVQbm5LmEJh0Gq/Xb
 EIf5CBTPpcmbU0u6OK4tBTRiu/qZzyv4pFt3Bfvedj6d6v1csNcNUF1liXDBuQ3QihrCp3pEUaj
 W9/UrsOSEtiDopYeGCHBSLWw27qdu9fTGLw1Mj1/cThe3wlGDoUX6nSrZ1ttzr742vVX/Zd/bqD
 +oO8jlq+B1fQNC8k1RAV4K2aDEZqyoBTLlnA3gMoe30NSgKBk7SDDGXf2HfhLFtirkeSelk=
X-Received: by 2002:a17:90b:2d8c:b0:3ac:1629:4091 with SMTP id
 98e67ed59e1d1-3ae6f020bfbmr2177205a91.45.1793297041386; 
 Thu, 29 Oct 2026 11:04:01 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb056296d4sm111853a12.29.2026.10.29.11.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:04:01 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:03:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Yu Jiang <yux.jiang@intel.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] examples/vhost: fix hang on exit
Message-ID: <20261029110357.543ab245@phoenix.local>
In-Reply-To: <20261029165729.1081754-1-stephen@networkplumber.org>
References: <20261029144727.119072-1-stephen@networkplumber.org>
 <20261029165729.1081754-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 09:57:29 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> destroy_device() waits for the worker lcore to ack device removal.
> Since the signal handler rework, the workers exit before the vhost
> drivers are unregistered, so the destroy callback spins forever.
> 
> Maing thread now blocks SIGINT and SIGTERM and uses sigwait
> to wait for one of these signals. Then unregisters and tells
> worker threads to stop.
> 
> Bugzilla ID: 2071
> Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
> Cc: stable@dpdk.org
> 
> Reported-by: Yu Jiang <yux.jiang@intel.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

This is compile test only, and needs ack from Maxime or submitter.
