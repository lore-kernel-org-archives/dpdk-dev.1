Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB5CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 17:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15784402C4;
	Thu, 11 Sep 2025 19:53:12 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5FA40285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 19:53:10 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7e8704e9687so110531385a.1
 for <dev@dpdk.org>; Thu, 11 Sep 2025 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757613190;
 x=1758217990; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dhV2MCMDHjAwx7SGrgR7GJ1MnmImjtYVd75RsVVyeg=;
 b=A2IP4wRUMLrcmAOaDu6LYpAl0OnmSesawsYh55q6D1H+EQpazqTtYsAQdbMkSLZoE6
 ntfWKXxHdR6+y4P18njdt0WsQKMS59KIqd/6D8PV6RNQJ5N0f9YzmMpEBK0yae3PEWRK
 a1g22YsAlCwm0lFK9qGb+cB1lviLwITCH9DmrmAwvftVwwQ2WR6LoBua5750HMioKBFV
 VAYXLjCCTUy3sbNM6Ni3/vLyGKLZXHPdOVfZdlt+P3D4cEfxqThaCzoaov7zBrIgAQX8
 EitJe9rpHcz9bRnc0KZkOUInnyoNcU/syAJ3mjIphEXeN9CYKlKgyKNImyqvgANeshv9
 OQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613190; x=1758217990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dhV2MCMDHjAwx7SGrgR7GJ1MnmImjtYVd75RsVVyeg=;
 b=MXuZMfF+l1gvkEGNw6TpleewFVkA95U//gqIfVrjr90cQ7Pd5K7GB1AHBeNR7nO+E/
 k3b8Z6nyVk5/+EkcXOdIrjmm6COIrlQGN5Jxh61f8bHgvodRC3z2LKI4CgEgqpPz7Y81
 tMdrk6MjL82ilGxrpR1mz/Y9hvQpRDo+Gany8vqqTelDERT7vq6oVR2Ydl3jOlR/GFa+
 +lVbwk16nvoZXJB00F4CtJ6DzWQHBf9m3a8gIpcCHmNK+YMB8T95NFlyyktU+eXjlQNT
 ZPad7MsX8ULknuD3+m/+eMIQoE6wczqJ/1Va5H3a1fd3TRfjOSHCZhEoeYGVYnNfGS84
 kSzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCSw1ATKGUpf4L9uP1YyqyZ0js4r2prYGCWSf2tDIJwC89frhckSitggod3j9qzVxyLng=@dpdk.org
X-Gm-Message-State: AOJu0Yzq0+kjOCNahUG4MEB41Duzknek737icDZhiJn95DSmzUh6Omqx
 TdsGX/IhE5SwuFr72to9KkPqJOhnrwDNsfI2KRNpfxy4YnqEmIxIItNZsnZef1+j72Y=
X-Gm-Gg: ASbGnct2U/Tvri/01weQnlNxefvpaig/XHRJeVwoCEs0qBkw2NuWVz7MvuTxXephPsA
 CcNpiMDU6CqHZVw0DoCxNf16tvuQAdJ928O5r2iFg/K9qzbIsPt7Lj9NzVVnerXOlDrYG+15YO+
 CiM7m4E/onNT/RPbOKurY8L7dXccO4ULpmtR2VBZ5EDbxgrTQBmBruuKKnNd1kIi3n4AjJmSL/L
 J86lLbajoz+y6ivijRtIXtLWAC/kN4CnWTzQQG9xk6D0VRGyIT6ITZfBGh6iD5T1PtXgjY9WH2q
 ESDjoY9hc9pGMQKC8NihnrOF/FO9juxw6rixeLcIXIsSX78+fpL2tfb5Fk1ZGp07lZxtmkQtK05
 plZ3YN+fdx7PrCzbfC0J+ZN+f81D3h2IANgcRl9jnjrBph25wtPi8S4TkepdyKKHFy9kPOKJf1o
 g=
X-Google-Smtp-Source: AGHT+IGBCXNDowvSqDFWjg0+RA0MKUHQReEurNIFKJfQXcCfFOVaXfFjvyxKDguQ5ZMw27DmthHPiw==
X-Received: by 2002:a05:620a:a217:b0:813:9023:981d with SMTP id
 af79cd13be357-823fc1d337amr33704885a.19.1757613190049; 
 Thu, 11 Sep 2025 10:53:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820cf0079dasm138899485a.60.2025.09.11.10.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:53:09 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:53:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Lijun Ou <oulijun@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250911105305.5eb9c67a@hermes.local>
In-Reply-To: <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Thu, 11 Sep 2025 03:25:01 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the secondary process testpmd application running any fwd_engine
> and after that primary has exited will cause a crash.
> 
> This patch forces secondary process forwarding lcores
> in fwd_engine to stop before the primary process exits.
> 
> Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>

NAK
As you said, you did not test it on Windows, yet you added #ifdef
for Windows support. Since Windows doesn't support secondary
processes (yet) how could you.

Adding Windows here has to wait until it can be tested.
