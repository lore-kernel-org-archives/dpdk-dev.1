Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96BAC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 18:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC55540611;
	Fri,  8 Aug 2025 20:26:10 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 08DC140270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 20:26:09 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so17187455ad.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754677568; x=1755282368; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lqEtcncRnPNBdaZnTXI99lAjdefPg/qwKd9eaV4aS/g=;
 b=B8R0YRYzr6k+ulDgRjAfTRjOx1qf6mALWVVziqqdNclydEMqyHterhQT44LdMV1J7E
 vEE1BjeMpl5SQXZw3KUPxaVOlZfMyGywIvGeILcDggVqd6gqE6dXpiThHYBStRSpCebr
 ytphu314Uci/VsSfquN/m4fGj6YIVRUwKHAbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677568; x=1755282368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqEtcncRnPNBdaZnTXI99lAjdefPg/qwKd9eaV4aS/g=;
 b=IP+rLKnGXgqx9j2QKtU7WsBqA1/czzgP3ri7U6MO76YCAXA7snEFunMt+9d57IlzP5
 D8ekEV1amFu7FmTWkz3rWTBgZZtSl/kYvK4ex1C7s9BNpGil2Sm6Z14YAtcwRjGe9Rdp
 HySG/PADB4GVFQepNV/USq7aegnBvuTTow9fAnMuuYXw0MKfoEVvcxGvV5Gaepf3GxOk
 +KScfX/RWwp2g27ym3N+w/jFuddgG+q3oliebvibx47TpSnDmB9193ZWKDHxpu6Qm1v9
 YM5APLIuXotKnQfA2jG7CEseWoGHLzd7uzBcF4O80dT421GQu5nkRmcNEQkZ1Og6m5QD
 UABA==
X-Gm-Message-State: AOJu0Ywdsama7c7zQ1bfOwmRJrZqSxztYY+CDi3hKqYvvUbq5N6uhlo8
 B3MRIlpkSf+ojy1ndJuQ0kWyt/E5lxaKU3njey19ssSMzrcO+Ck/HYpxdVm3fUigdfxsfj1ZFSm
 3fuj731rb4LJIJb4jXw7iWsLt7Jf+RPMlsgPC3SW+Mw==
X-Gm-Gg: ASbGnctWF9hhlVaTMY4l302aUPLNu3kGZHcHa1ooB7aztSplJWwfapuB/skfRK/jZtb
 mkgm3oBp92xxf5YSvDj4FKnvXz+ScJpUdAnv06/yD41YNPrfj3dg18n3Yc6DS9lN1qZX2e2P4ho
 n8m/Jn5xzEcgZnICoIDxRELGMG1eJYS0+erxW5ab+O6ioKSCvO9h8g42XYhW9bIrzsFCRVHRcXi
 KtHoCQ8du8Q4qU8kGAcyuPc7//DAFL4
X-Google-Smtp-Source: AGHT+IFrysK1eMVdkMkxlb/t3Izkmr3xgFKoAaKWFo8Uov+ZpBmFlhD5xcDsnz9atFY+msefA6FCGUu4xJ9yBXGCK3k=
X-Received: by 2002:a17:902:ebc7:b0:242:4b7e:fad1 with SMTP id
 d9443c01a7336-242c2206d7cmr45347695ad.28.1754677568135; Fri, 08 Aug 2025
 11:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-4-luca.vizzarro@arm.com>
In-Reply-To: <20250725151503.87374-4-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 8 Aug 2025 14:19:50 -0400
X-Gm-Features: Ac12FXyVM4d87rym2Me8JSTpl0KsO7tAqbbD8GqVP_r_Nae7jNDagrmurNG1CUE
Message-ID: <CAJvnSUCR8PF47O1Y-kdhXYtCq2fOL9KvogVqiRk+sPeN+9oKOg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dts: add current test suite and cases to context
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000024ff54063bdeb50d"
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

--00000000000024ff54063bdeb50d
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000024ff54063bdeb50d
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--00000000000024ff54063bdeb50d--
