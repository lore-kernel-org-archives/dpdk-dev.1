Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC4C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 15:21:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC4942E7B;
	Fri, 13 Jun 2025 17:21:17 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7D20E402E1
 for <dev@dpdk.org>; Fri, 13 Jun 2025 17:21:15 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7cadd46eb07so233921085a.3
 for <dev@dpdk.org>; Fri, 13 Jun 2025 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749828074;
 x=1750432874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vg2RTDt5W4dxPznlqhnOEH+qbJLYgIKijAPlG705fxs=;
 b=lUMVP/OiwpfydQjPR6OEbZ31uo5/6bEDZvtWUuoSAZabtpwNOS6ZtBEIRazNMGPYG5
 MxAvMIxByu1q3brebfULrk3CwRQqZo4ta1OZdqrxg/LclS7yHnI04cVeoAxhZbmtgrad
 0U4F8Klw3p28Pan+JMsfNoWUjIA/4eyAQA0oM18BOmWeBfL48dMED0e16qzW+g6NbHFY
 lPVXk2T2AqT5MK/gxg/MM4Sd4miVu/+j+EtVjH1OOOPRprKQicgy7GoERqTFVsfCgvIl
 mhUgNS86uOXm2bmO9sHck17eWD6ahvmE9j61Y49b+/HO3LR8SuSfLMAmKG0XXvo2C6GT
 ATHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749828074; x=1750432874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vg2RTDt5W4dxPznlqhnOEH+qbJLYgIKijAPlG705fxs=;
 b=w/BjOW8g/Km1dCDr0yBGEq17bCV7PrrZ2nrgPDz+YrVJpTH8Vd2HIhSUZnUZiia5cQ
 cHBlJYfYHzq1ggcTW0JammYyrOfW+q+j/AKuMBPjdM/fVcnSh/u7tXpgEg57DiW+rBCv
 z3oPEmFQyxIs5VsRMZKCyjiC/hFtcMi8o4oV+f5JtYs3GgoNlwx1HilhyIuX00LCl3Y+
 kCa0Tot6izOLq06jeXQWUL9Gvi8uB68YaDpNk7ByIsG6ZgcgkIVr0XwfQp4O27dVnNO7
 OcqivZSGqjVqFAWhQv/TAk3vmDGeQj2itkvny9Zu7f8ZwZ18UcrqFxGLomg7ciyhf+L3
 7VBQ==
X-Gm-Message-State: AOJu0Yy7YCdz5NCEPdxA2bAALRtolU06Fba7ZGIInQ0/+yoN5AdRf2HI
 JW3wfTbGuLaYZX0XbImgXpSuMpBsvlmIPDID47Ajsu6tmLNMdLVdDsFk5XH3+D8xq6s=
X-Gm-Gg: ASbGncuOQfdTRB3up9RBgReOBCWdeLcJtn9wsmkmkSGP8vWj+vbLajKoDwqwQWZJST8
 26PPqkR3BAFxvFQHsXOABrVeB33qO4WasldxNZs29zLTfJl4DITkS6dnalZEcOrDxUbr4Tm4U45
 019/Bnxdqj1RLrSh9mgrSD+XyIkMs87t5joT7kB9g8RZDXqLapOQlcZqeob1Ie4i6PpdauBvUY1
 e9DXFtIXNC2lUmr4gMgy+mqaqq3kN6hBZihKQW9QEy+9GHbJ7hAworcpgHC6yzL/UE+aQkjlX+r
 IgmvFn9NzAdnvtisRDAsVuNZGA54LxUvcv2O0fhxPNIU6x63GONcL6+oosD5CNFD/p2aji8Hgrg
 wSM+F8TyBxFsmtQoL1RapggzJakpQaF2Z1UAltUo=
X-Google-Smtp-Source: AGHT+IFE3PE/j0SPJRq3+wpJkmsn7+H2ieiq/bX4djJP+vzmqi/tPL5RVAMECuxwUShjXqP0ayFnmQ==
X-Received: by 2002:a05:620a:408c:b0:7d3:914b:abe6 with SMTP id
 af79cd13be357-7d3bc397ee4mr604163785a.23.1749828074550; 
 Fri, 13 Jun 2025 08:21:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8eacbc7sm181987185a.62.2025.06.13.08.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 08:21:14 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:21:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Kyo.Liu" <kyo.liu@nebula-matrix.com>
Cc: "dev" <dev@dpdk.org>, "Chenbo Xia" <chenbox@nvidia.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENI?= v1 10/17] net/nbl:  bus/pci:
 introduce get_iova_mode for pci dev
Message-ID: <20250613082110.7da767b6@hermes.local>
In-Reply-To: <7e74f0d2-d947-405e-86ea-ea532dcaca95.kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
 <20250612085840.729830-11-kyo.liu@nebula-matrix.com>
 <20250612104034.5d5abac9@hermes.local>
 <7e74f0d2-d947-405e-86ea-ea532dcaca95.kyo.liu@nebula-matrix.com>
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

On Fri, 13 Jun 2025 10:28:06 +0800
"Kyo.Liu" <kyo.liu@nebula-matrix.com> wrote:

> Hello, Stephen:
>  Thanks for your review. This patch is particularly important for our NBL driver because our coexistence implementation depends on it.
> Unlike RDMA devices that support hardware page table translation, our hardware requires a software-managed approach to avoid IOVA conflicts since both user-space and kernel-space DMA operations share the same domain. This architectural constraint makes the patch essential for:
> 1. Maintaining correct memory isolation
> 2. Preventing IOVA collisions in shared DMA operations
> 3. Enabling safe driver coexistence
> We'd be happy to:
> 1. Provide additional technical details if needed
> 2. Make any necessary adjustments based on your feedback
> Anyway, we really hope this patch could be accepted, Thanks again

The approach is sound just want more feedback from the developers.
Other drivers may have similar things to worry about.
If the driver is upstream then it makes it easier to test and review.
