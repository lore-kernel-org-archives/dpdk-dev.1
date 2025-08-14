Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B3CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 10:20:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9633842707;
	Thu, 14 Aug 2025 12:20:47 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 1DD054026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 12:20:46 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-70a9f15f15fso6842696d6.2
 for <dev@dpdk.org>; Thu, 14 Aug 2025 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755166845;
 x=1755771645; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ExpWH5XiesFm8gXxlP9FdN5vfjZVfmtBw2tsSZeROM=;
 b=CJrdDNdregTw6eM7ESt7QLPKMHtvaA9uczeQgpzas5opD6BWMWSzLaEIzXCB7Kp6W4
 0aqmfYwwu4UEkxOQJwkaKVTF+UQy5t4CHEo3Sf6vMoNNjzb60dx1e2oQ8CL/58z53XXb
 DtMiSGEzJYez0gApxxjSwdjNY0hB2jfZM38XdL4KxCEntxkyFIYVkxxAFPVZnlCaoFCX
 2BVlbjLmZiOyH5VPtw+r150H7PjcQqXzUwH8n/n4iobjUf+GaNuT13CANLE62R0++Wrj
 LDH+067/ZaSpKYbv3W+tPZXTVR6xHXYmcLmCwvibXaHIGwHpz6cABXJAPNRbbOo9d6X+
 TnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755166845; x=1755771645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ExpWH5XiesFm8gXxlP9FdN5vfjZVfmtBw2tsSZeROM=;
 b=miOv9OuWWQP/Km+/uLWnY2+FQtHqmOB0cy9TS6ks108F3gbMiEBZg9tHjunQ90rz76
 piVaiUGicocLUe0Uy4BW5MRW12+gq8BvMdTZ0QLrjCkVREGRlGNUpHePhK8R/OlMkaGX
 xmnqpdLfhYKJAMYwzzF8FFlTF84MDW3QF3cELQnlykYPnYqoZtzuLtOAAi8ErUPphfBw
 65pVbtPFrKoM604eqQlS4V7sMcfgWWpyRCMPIX5t+CYflaE8VLd6dQZ9CoD9SM/pOD6P
 LcABcT4WZ04HHELgyVIwdPdTQbwvmJmHn3sLFTRomO0tQPxzKgyASzjhM1Vpe3wTAf53
 HW2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+z8oyNbcCh/y7+5s98Xqot70sktR0J4UT07nKluPC6bVNNCbslFjbWUz9iPV57OVTpZc=@dpdk.org
X-Gm-Message-State: AOJu0YwjDC2jJeKrQGpIUW0FqD3gsZ6j/oPJV3r3ySygGi1P0ELQq9OR
 3gG2pHPaxupDOdV4xrcUfIXR3gB/qoMecrndC5znOrrcvT6JbjpJf1aeqvzc29RwcqkxHwGf6Am
 ykHjS1TsWbdYUp4s18bfHwZJmmvhzD8uspm/4Jpk4HA==
X-Gm-Gg: ASbGncuWCmnDDoyMgv7P8BKQvAI98TvTh33YjUQlPrTfJfTzROPGFQsIxg8zjgZVZMl
 mdELTH9anJ4t1BGzJqGK4AN0ljFePOFnaVXSmRxVJzXosmjpvWIYb1+HP5bcW/uzsZtwtoQ+gDD
 TwUj+S59JVbhsT+L081/2pK5WWWZ5lYF0hVe6WFi5Nou5nAn3u4j7CFzp/L+FSriM6xt1x+ntZc
 LGPQILd
X-Google-Smtp-Source: AGHT+IFp2FOrvYIadUAJoNdON7z5KyrsSUrdl1SH6TKGlPpcDQCWWkKOYQLsDvcZqnrogBcnagIt/LJGztSIsvW1NbU=
X-Received: by 2002:ad4:4eaa:0:b0:709:d658:3bd2 with SMTP id
 6a1803df08f44-70b9827c301mr22251066d6.1.1755166845468; Thu, 14 Aug 2025
 03:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250814093350.5ecaiakzdgvfjbwk@ds-vm-debian.local>
In-Reply-To: <20250814093350.5ecaiakzdgvfjbwk@ds-vm-debian.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 14 Aug 2025 15:20:18 +0500
X-Gm-Features: Ac12FXxWn9wn68ZzzTG-3ZlLztLpJpDXc7ROaQtMmMT-b6MkztKyBWwg60ihm70
Message-ID: <CA++2-x5QtO14OnRcrTQjTiavOREwFGRSpQ_4bSFvJf0B69HOhA@mail.gmail.com>
Subject: Re: [PATCH v3] net/mlx5: fix connection tracking state item validation
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000589d89063c50a00a"
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

--000000000000589d89063c50a00a
Content-Type: text/plain; charset="UTF-8"

Hi Dariusz,
Thanks for the feedback.
Please check v4 of this patch including the requested changes.

Regards,
Khadem

--000000000000589d89063c50a00a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi=C2=A0Dariusz,=C2=A0</div><div>Tha=
nks for the feedback.=C2=A0</div><div>Please check v4 of this patch includi=
ng the requested changes.=C2=A0</div><div><br></div><div>Regards,=C2=A0</di=
v><div>Khadem</div></div></div>

--000000000000589d89063c50a00a--
