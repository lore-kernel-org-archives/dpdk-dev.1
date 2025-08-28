Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB09CCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 02:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A274C4027D;
	Thu, 28 Aug 2025 04:18:23 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id C064940263
 for <dev@dpdk.org>; Thu, 28 Aug 2025 04:18:21 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2445806df50so4146465ad.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756347501; x=1756952301; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5dJ9Z29PY0KxRmja5aIc4UdOhFkuNTvYcr1bbDxWuSg=;
 b=EEP1UwnrTUOUJSJLWJa44L6ewOpn8LgwlDZwrR7iXIul/zg9L4B0TcK9ZWJiAz/63a
 mQb6sZ1IBrAQhXheierWJZWNZ1KFajEjNuEwmp7k2a4lQqx8q6s90L/AznbdZL+XtY6e
 5dcC2bYs6QpAe87fhzAm97Tfal5TtXHkGg+c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756347501; x=1756952301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dJ9Z29PY0KxRmja5aIc4UdOhFkuNTvYcr1bbDxWuSg=;
 b=UIQVE8izitXUy06eBnGCSWY1/KYHEhF4zuZDCLLevW/nOYeegavMZMYG6OY2tAge1r
 TmA1Grj9tV7vPGfppuYk00N7nWNepLeO5FO+Au3eUzpvEjFuVQSYonnVVWXzxisoR8m0
 ZlyBwc6Ik09GEOYy0218PKE6ndFIOP06GccdPQ2kvaAVhHonq6TcmBetbOoS+YRjo8mQ
 35UT8wAHwuvI4pbpebmcJaN9QlVQg9GrvEBpirkWByAT9Pn6a7KAxoFDHGHTokFi0Yng
 b2g4uTqGvQxKjp0yLoV61lJM+WsX2z4bZDxUPz6D60cSaSW0UH4wG6MIRP4njcSDdKgW
 dbAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrLQPSOuXBLkBJ54IGWa7xadpmH8kZyDNDQYokMymjifPYmp+hJCojIpOdX604B/zJJf8=@dpdk.org
X-Gm-Message-State: AOJu0YzxNt/wopUVCuuXC0y5wwaT/ASvH9ceKfTjUfTeAbv6MFTRiByB
 SKDuYa1CNNdicO6xI3B+A6y9DTl5rLVYpecGl/+hByaXEKPVnHoDzx82ms9h2ffiiQIIbtNFnYU
 zx5aCzYP73WW6e/6UM8cLxQbDsDV2kQSfwESWT3QncQ==
X-Gm-Gg: ASbGncs/e85UPv3Uqu+E04md054km1DJHZWdMX/9+UsPaw9xnQyQ3RVsK3Howr8cafy
 qEZmFRQ7JmByS1qIwo+jqlJ53uagg3v5EKgAO9kZeeR4B5q4s289F2FfzZVi+rEoJMDzv8G5yZu
 voRLIVmxKdpBpy+U+vfeYrq41JhIclUn3BNGm1QyeRJtflwjl2BOas/qwh8MKTuI/kOiKcWP2CM
 Nt5Q7WvIR95xXS1tteZd+Hf+dwqZbGFGuWPpNMW2bJZ
X-Google-Smtp-Source: AGHT+IGWdYxr3+B+rwfmjxNjfOcw40wZx5FETUjRIObqnPaC0Rixcum0lri7V0G7U3agh6B/GOoBqNy8prjufxnC464=
X-Received: by 2002:a17:903:1207:b0:240:5549:708e with SMTP id
 d9443c01a7336-2462ef942bdmr255890025ad.46.1756347500807; Wed, 27 Aug 2025
 19:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
 <20250820140651.39604-1-dmarx@iol.unh.edu>
 <20250820140651.39604-2-dmarx@iol.unh.edu>
In-Reply-To: <20250820140651.39604-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 27 Aug 2025 22:11:39 -0400
X-Gm-Features: Ac12FXy-SULMaV_hvCh5p0BY-g1Raf-XSkL9Lj7nYPEAYtDzcytJ3G1ZNY7E3X8
Message-ID: <CAJvnSUCuiDEiKASDNW79zOQMakDGO0eTMOJfpEDJD3ZcS4fYog@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: make one link the default topology
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e35d74063d6384bd"
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

--000000000000e35d74063d6384bd
Content-Type: text/plain; charset="UTF-8"

This looks good except that I found the commit message to be confusing. For
instance, it is not true that all one link test runs will skip before this
patch - they will in fact run. I do know what you mean of course but I
think we should just be more clear.

I just modified the commit message to the below (ran the check scripts of
course) and pushed. Thank you for the patch!

    dts: make one link the default topology

    Currently the default topology for test suites when not specified
    is two link. However, the majority of the DPDK functions tested
    in DTS can be tested with a single link. It is more intuitive for
    a testsuite or testcase lacking a topology decorator to default
    to the more basic requirement of 1 link, and force tests which
    really do require two link to include decorators explicitly
    saying so.

This is now applied to next-dts.

--000000000000e35d74063d6384bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This looks good except that I found the commit message=C2=
=A0to be confusing. For instance, it is not true that all one link test run=
s will skip before this patch - they will in fact run. I do know what you m=
ean of course but I think we should just be more clear.<div><br></div><div>=
I just modified the commit message to the below (ran the check scripts of c=
ourse) and pushed. Thank you for the patch!</div><div><br></div><div>=C2=A0=
 =C2=A0 dts: make one link the default topology<br>=C2=A0 =C2=A0 <br>=C2=A0=
 =C2=A0 Currently the default topology for test suites when not specified<b=
r>=C2=A0 =C2=A0 is two link. However, the majority of the DPDK functions te=
sted<br>=C2=A0 =C2=A0 in DTS can be tested with a single link. It is more i=
ntuitive for<br>=C2=A0 =C2=A0 a testsuite or testcase lacking a topology de=
corator to default<br>=C2=A0 =C2=A0 to the more basic requirement of 1 link=
, and force tests which<br>=C2=A0 =C2=A0 really do require two link to incl=
ude decorators explicitly<br>=C2=A0 =C2=A0 saying so.<br><br>This is now ap=
plied to next-dts.</div><div><br></div><div><br></div><div><br></div><div><=
br></div></div>

--000000000000e35d74063d6384bd--
