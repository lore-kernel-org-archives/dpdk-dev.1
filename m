Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4EC02199
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09303410D3;
	Thu,  6 Feb 2025 21:15:20 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id C71DB40EE2
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:15:18 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2123874a91.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738872918; x=1739477718; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UgiTVtGEVwIRG6rhSordOps5Eep8Se06xUJ8i29owPo=;
 b=b4X0a1KVQxbSit48SwYcYoJqIgAXsHBQVEbPPHNKfu5/FJOwYj1qzgnFmaV0PiXVUT
 98vdOyAA2BUsGv8AOG36AmcuAx0JJeTg8OPB1yTgW6rAz44PW3ln1qCv4Jt1Joo1OKQH
 UENQC1MSfrERIOZsHUSttzV6ytCfLqk65MKIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872918; x=1739477718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgiTVtGEVwIRG6rhSordOps5Eep8Se06xUJ8i29owPo=;
 b=OITvb8NEM9CGSFnfFT9W7ksP/ISn50rFnXUVG22Fj4egmyzWJL2nYrPQxve7Iz7aAK
 s0megqsRbNNJmoxckIlya2TMaXFwAysIXGvGLLIDW7YL9oDv4cDPWUJvPvwPYXG7Hbqi
 4SOdV+3XK6LyTT4KK/hbQHMGITxpHd7WhV8kSY0dy741KOOidT0VbthwL1UISYYFO+XA
 yFPHwslwqaMANIi3676wwdPriedTCodek0iqMQmDOU2wWSvwPTVKwHWdamosoodunInm
 BhXGM0F3SkcBllEgEIT5r+zTcoiKQVH2B2PNu1v8Clt701kWGkQ0n84HlGTaE2GgPRR/
 YTIQ==
X-Gm-Message-State: AOJu0YwQIZk+fLTwkaeovN7aEaf8xpAaeCIOzSubXlpUlDNBoL0m6UFv
 w++/yAbGVOe6L8rMaH3ip2xAEVVSO7C/gmDCxWGkTh/SalZRE6PaF8Zm0HIT6KnLgUY/VxwnhTE
 t5ShpY7N/j7STQXBCndSuOiFFcaAQdHjWvKcfnQ==
X-Gm-Gg: ASbGnct3kRBp9mTLneWjXlptMTffWwT8FyXRjjOe+8j663P7mMjp7Blh3n3ZE93zFUr
 M26Mr9wVUaIpCoCIl+cCnj73qgNSGUyAIVp7Z92gPEkdr3wW1xOnF11GTgqpOAbUB34BXLarkXh
 TM/GGtfIDBGZCN3FeoQTJHavgLrGnjyg==
X-Google-Smtp-Source: AGHT+IG1t6TMGLqSFgWfQi72jl4jB7oV8f7/QMCSydG8ckr0lpj87K+wSRmRaawxfsAB/u0MLFwxt60SmMfNdcOc3zQ=
X-Received: by 2002:a17:90b:23d7:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2fa24064340mr588833a91.13.1738872918029; Thu, 06 Feb 2025
 12:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20250204160739.1603197-1-aconole@redhat.com>
In-Reply-To: <20250204160739.1603197-1-aconole@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Feb 2025 15:12:09 -0500
X-Gm-Features: AWEUYZmHtArXIBLaiA_tHUUPC3mEmxK_I78y38cprtvtvHVHujvWJxD2pCvn1Gk
Message-ID: <CAJvnSUB3tEHviAfrjMuwFefS-zEj3k7EbxC3XBSn3D68B6Z==w@mail.gmail.com>
Subject: Re: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000096d558062d7ee63e"
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

--00000000000096d558062d7ee63e
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Triggering a retest due to testbed instability yesterday.

--00000000000096d558062d7ee63e
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Recheck-request: iol-intel-Performance<br><br>Triggering a retest due to testbed instability yesterday.</div></div>

--00000000000096d558062d7ee63e--
