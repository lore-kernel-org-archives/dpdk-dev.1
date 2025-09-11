Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64201CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 18:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D56474042E;
	Thu, 11 Sep 2025 20:51:57 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 5A3CA402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 20:51:56 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-726ee1a6af3so11978046d6.1
 for <dev@dpdk.org>; Thu, 11 Sep 2025 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757616715;
 x=1758221515; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nKPLeNnSL1StNM9Q7dUUQmoZ4CXTbE7er66lQWy/JM8=;
 b=FeKKGVuDAQ7IQL1zi3iUUjwj3ujY4KmiVAJKX1PCatQNelZ8dY1LOV271fNiUYkTPq
 vEZH/70iJ9TuDudQKlC/UHKo5O0V+udNE0p0Eff/OkYNDNhzuzta6THlaEau+wMfInwv
 rQwUoR6krbJ/bdY4QyWK2z0Bu+Kj3N9z9SsrqlvxP1gU3rLNN2QT1wP+R/C5YvYlVkEy
 yD4ldYjubHeV/9vPbsO2VGNxUvHUgXMnjgWFK8qIkWu1+H9lxoDutzLHknqnZoSWSuuS
 rpyKkAF0A8I3l3AFQ7Zbx5cs5Vw8s1jQ2FFWHrj8hX8DQNXj1RWaKRAWsHwe1pbrgV9a
 ZG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757616715; x=1758221515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKPLeNnSL1StNM9Q7dUUQmoZ4CXTbE7er66lQWy/JM8=;
 b=f54oTsM5ZfWa2SVuVhLgwQ2p1G1C8x26w4j9mS3PLvwq31FhPIxk+3YnqEbiBwWyj8
 NHiGxFo5xvI3u5MIMA0gohIwJUYVm7VyFXfVgsqXy5uxY089ucQ9EQncZsHs0gxuhCNf
 oLhRoHOiMJshX3VL6Q+is3eGVXcdNYC/0woKmKRfRMwAdc/GaQg64dFfc6TnnDnxIJB3
 i0iG0Euyto3BZKMZW6AQiPA9bn0OS9RTOyEh8rVrJNIqosvPSLuLWtXgZhCUuGtWW04S
 Gr1sr8ivqXN+dOwI6YCW7+LYrIQ8YY7HXtk3fa4GHR6hyxdg67XtK28qeMVoBi0iZOHX
 gOgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX426o4eqlA3V/1OF4at1VXfpfPOvpi9f8MD43oMwSylgRzuhXW7DoYEl+kehtBMmojcJY=@dpdk.org
X-Gm-Message-State: AOJu0Yy2zjsoVQ3Iu+HJjwFKZIlR2GZGyKKCJAFfsCy40FslighC1Yg8
 Eie2doJ85JDs+EGk3diljsRPpmMTBdYdvEEXNjtQ5gZYuXtsfN5Ri57FqolCq3kzAxjSWOlscI3
 YRn/fV+RJi8UJfAuiVgfxHgtg28CoTxmuPz7jaAKwXw==
X-Gm-Gg: ASbGncthM1wyA7RjT2Lp/KocU9XLfo1JJVRikUwU+7Q0/wrEUBDnAtVobq+B40Br6N8
 VfLch7y6dvAUPECA+AJ9iuqubh8IcanMnnvRoyJ+4Bf0BLKl4Z6cjgOp99RMSC9O4I/3HJXcMmO
 UtunjVU7la10F2IcN9DtrWq7KFB4YoDT65D34tpTGvM+yshWcGhjDrK5j8CZPlitF5EywvMHPWK
 /zUiJnGb49KI6tlLBxFZlKuVYZNW0u9MABkwfHxQuVqd30RH9dT8RdiTMlVm6zusigsMnARzFyh
 OHYuIgF/WfIl0qF57obwqJLBsqvCuXAb4uM79nNVKpkkAYlZ85hWfr2onKfOyBD1hu0=
X-Google-Smtp-Source: AGHT+IG+vqF7FYzpBEfthtH9dLcbody1Ns17SQZbnYRIKfh3+jIpkpU5pV19HdEVY3RoGh4ZIkl6OpeYoAsGIIyGcIA=
X-Received: by 2002:a05:6214:f6c:b0:723:5bc:e16f with SMTP id
 6a1803df08f44-767bd287b95mr4989766d6.3.1757616715617; Thu, 11 Sep 2025
 11:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911105305.5eb9c67a@hermes.local>
In-Reply-To: <20250911105305.5eb9c67a@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 11 Sep 2025 23:51:41 +0500
X-Gm-Features: AS18NWDL4UpV7IEShnTC0qgbM7u7Chc3bb8DM0luLdSxK7DDODSGLwcZJfbC-bg
Message-ID: <CA++2-x5D=WkLkAF9q4z-+x17=KsLz_ND_u3So=a_55M6c-2d8w@mail.gmail.com>
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000fc66a4063e8b0779"
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

--000000000000fc66a4063e8b0779
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Thu, Sep 11, 2025, 22:53 Stephen Hemminger <stephen@networkplumber.org>
wrote:

>
> NAK
> As you said, you did not test it on Windows, yet you added #ifdef
> for Windows support. Since Windows doesn't support secondary
> processes (yet) how could you.
>
> Adding Windows here has to wait until it can be tested.
>
I have tested only on Linux, all the codes are under #ifndef i.e., if
window support environment is not defined.

>

--000000000000fc66a4063e8b0779
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div>Hi Stephen,</div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 11=
, 2025, 22:53 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br>
NAK<br>
As you said, you did not test it on Windows, yet you added #ifdef<br>
for Windows support. Since Windows doesn&#39;t support secondary<br>
processes (yet) how could you.<br>
<br>
Adding Windows here has to wait until it can be tested.<br></blockquote></d=
iv></div><div dir=3D"auto">I have tested only on Linux, all the codes are u=
nder #ifndef i.e., if window support environment is not defined.=C2=A0</div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fc66a4063e8b0779--
