Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E273ECA0FFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 15:38:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3424402E3;
	Sat, 30 Aug 2025 17:38:32 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id AB5E640275
 for <dev@dpdk.org>; Sat, 30 Aug 2025 17:38:31 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4b320c1353dso6965741cf.1
 for <dev@dpdk.org>; Sat, 30 Aug 2025 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756568311;
 x=1757173111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrdrTRhwJq6dnJAEesb/4KutG83y4/k2uGHdFnopEdo=;
 b=lRU/wu/kCxOsds3W4zDwiUCZbxa9ujh6FY4P6MCOtrDws5sU7PC1309x50JNlON+MQ
 aSCjdUSmPM+7SNjKW8VZaz6gmkwH43TzN2owjHc4QP2pgd05g6hj6KxtzuTuOWGSFk2U
 HVzppZ8xbQvmdAH7o5oOSSIloVS/DpuFKFoMKuqpPZmyzw+OfvVndd60GoP8Mg0upaRc
 /FW9Aq/JnBwiX2QhAOjSqAVsNSpDSgcx1vLAPAec7YO8j4zQ+8mOMiIeJjdGH43fJh16
 sMeBJSOII4KBETlzZQw2xp3cdWNnO7lqSJ5iaHt0mblLnt6Yaozv0KWfAujcgRLsx+uQ
 zR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756568311; x=1757173111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrdrTRhwJq6dnJAEesb/4KutG83y4/k2uGHdFnopEdo=;
 b=n4IqrsFQIeZzErSJtRZyHR/1O9CXr4IZjrmxhwMDnlyoFht3XwgeC+eaZLwjsbanBW
 RYdd7XflCYKw1fS3+kEyj8CNwniL49ykMRvi/Rh9/nEnT/qqZz/eF2+nHLcbdQb93tVQ
 5BqlaTt/OVhjlr6XhAOtgPNk5gKkLEP69VOYbWn/vQ8J6PsBvP9Kiffu4KZ7FByRz5Ol
 Dztd5sElGgmlu2M+VG0qps36Mmi11h4wbmEhv3gbG2qf8AJKLuO53zFca1kNXgD6Bv5t
 3i83I3+KEXo8n4FNGMfCgPAv6fxgu2LPL6bPqQPjrwNacCbblQvhteKJLAGT25J80Ucl
 Ozuw==
X-Gm-Message-State: AOJu0Yyjl4OzhKfxzmSv1kgYuYLouIOCpr+Jwg6QUC+O/dxci/SGbof0
 jHg5COrYwdA2Ke1bUxEVzo1rfavFCdiNOlRxzf5zC11YZO/1RxLqh/8skA6QCmaHuL8=
X-Gm-Gg: ASbGncughY0v+6HZ171DraY9KIB+/6UJak0OdHTndGKzpDaZOR56r8bXtyQQda95qJw
 7TZywENap3o8s7Zqli4tFAeIK5G2cr0W9zP7dDbXKveYHRMgvrz2JXnSkzkv5ro6ouGdQlDv31O
 zXGU/UXYLMtNaqLIX8Qu67B1M2kkfOhZpO2Q+5Q+mFuvTYRVBPfoAemh7DkQiJVL3pNUPi1f+Y8
 1antHIrb8QkRUTc5+cy/6zIa+wZdtkkPyXF/luy51qsv7L9Pomg2Du7nANuoLSO2MrHybS+AZ7o
 P76+cdUpr3S4lPdNSubMP0XQ4WOIsDOBpSIXwiSVTlgFkYFFvW8GLba9cdw6NhWspULXdpOuJC7
 EOGt4h2/OId4NDuqv12qy4ZznH3RCYyysaGJeIoWNm9DRQutjhWxMyDWTtgigqvjxmXftECEiMo
 0=
X-Google-Smtp-Source: AGHT+IFQgTFvN7yGSfYS58bF4rPT+gY6afg17+VJFpmttz+cnC7EZV0bqqEXiNvnuieOB0dGg3Emfg==
X-Received: by 2002:a05:622a:199f:b0:4b2:8ac5:27c5 with SMTP id
 d75a77b69052e-4b31dd82934mr27220681cf.80.1756568310619; 
 Sat, 30 Aug 2025 08:38:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b30b599c52sm34331801cf.23.2025.08.30.08.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 08:38:30 -0700 (PDT)
Date: Sat, 30 Aug 2025 08:38:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [V6 00/17] add-hinic3-PMD-driver
Message-ID: <20250830083827.12244c60@hermes.local>
In-Reply-To: <20250830124332.5351-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830124332.5351-1-wff_light@vip.163.com>
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

On Sat, 30 Aug 2025 20:43:04 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> *** BLURB HERE ***
> 

You are supposed to replace this text "*** BLURB HERE ***" with a
short concise description of the patch series.

> Feifei Wang (2):
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
> 
> Xin Wang (6):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initialization
>   net/hinic3: add RSS promiscuous ops
> 
> Yi Chen (9):
>   doc: add hinic3 driver
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add flow control and FDIR module
>   drivers/net: add hinic3 PMD build and doc files
> 
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |   60 +
>  doc/guides/nics/hinic3.rst                 |   47 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_07.rst     |    4 +

25.07 is released. new patches should be targeting 25.11
