Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF9CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 23:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29037402D8;
	Tue, 30 Sep 2025 01:57:30 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id D6C93402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 01:57:28 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4da37f6e64cso44706411cf.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759190248;
 x=1759795048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwQiy4fSLmVqcLMNwvNkE2MuBRhZfc97cE2Vm8pRj5g=;
 b=Bvr5Hlbz4C5tEElseWIF0hCdfD6Q/HNLt+xD4Us/C9KhFz7DdVaSZ7286u93OHmRGI
 bInBFctWaND1eHteBML/Yo1hDrMBovS7gprxHuQsp74l03EoGzEYnizwGfywVtvnx4pb
 MaepjnpKQzlxqAi0OPSYlHeOPQISt2EQcbqdTSxrbHlo1RnkMGhW9AXDck63mlez83t0
 p0jDICoQXz5UOvUnu8eBEBDZJWmpNcC7bIoXuoH03XHUZQBmbwLyc6Bc0NLP4eqqNfW+
 /VUZj8M2B+NtR4QrHI+GgaqS2Tuh9xzpqzOoKCkZPVZZyMrll4FXMrLhtjz4hTunB0Cy
 8cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759190248; x=1759795048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwQiy4fSLmVqcLMNwvNkE2MuBRhZfc97cE2Vm8pRj5g=;
 b=JVqEI55XPO3pvotPjmADhaOPpWLec5rQyyj2dK9CfKuMwWbVFd32GQc/Ugr9r8HLmJ
 +QAPuyzPq0uKFE3XYSP5Fn+h/PsnrWcmNGJD6+QdToueOU2pv30dC6ge24mVs+ABdAVW
 pzzEn4oK9XUT1JEYGHfYQPclf37L7+gtes2Ye6pBoBn2hO89QKUlg0BphFmrJdMxSoqn
 jZ+z0MKqT1irWtwGH+4xwrgomIvVAKWpaosQ5nyEIM4WkYVhEVE+tK1C3wSp0Ob4Ytk9
 DpOs+fuy1zAHaDvNPOWM7cX4rGA7F0Dl8+FuGJeTdsg1YCiLbCaKR04mSsacmbdjJiWl
 2dPw==
X-Gm-Message-State: AOJu0YzNAJsY9vAwdwrbRiGddbhNu9wdv2aPv5mkyXKMtXyCGoie2Z9b
 dOcBTkMWfpiOqFNPbfF0Su5AcsbsVIFFywoQdnSCHhk+A6DI5a+A5BpwEmPKTALgbWY=
X-Gm-Gg: ASbGncsMhsHmxZ/bCEGMXPpe7x55ZqfbwToXiUjU0dJkurj99+OWLgcd60NeQJOI7KA
 p5HOpsdMe4ZVMkGMbvxFN+lDV5EhYV1kwn3LLjjU6cEOVhr9RD2/fbyOLpNh5XH2lNG0EXK8Wjw
 EBYTcCYKZp5oMG31fSVMPCBkP0kf+pL/UPrmwiWbMSvPAPGeBmtZCNotO4qhbTl0Euuyi7Y3Unx
 RQ/7h2vIATgfkQvxWaeelzNL15sFBaNFz4aXaeMhtuhvN6gB3PxljZ3sh3Wpx6wPUbSS3JrzD+x
 hvgqYZFVJG7q+xc5e5oHaSSMdvAjr2hBD0+1PwNSyYrnDDfW6tI4oqwXjkBtNsbG3y6mR4vc5iw
 ec+ceE7lsVzTEDNrqQDdrwjl673nNFM4T+OFSzO3DsLvYZOnrQJ38ImJn2B/bEEfVsm4ZwUFgZj
 K5IMHLlgZ0B/TkzNelG62g4G168teEPBf/1A==
X-Google-Smtp-Source: AGHT+IHsH2/evp0ATSRUU36eS4njRPS3XrwMOW3fQKA9n6EJwqtHuhkjVrC6RG9swXg2Ig7v0u7lhQ==
X-Received: by 2002:a05:622a:54b:b0:4de:9079:6755 with SMTP id
 d75a77b69052e-4de9079b719mr163902341cf.81.1759190248071; 
 Mon, 29 Sep 2025 16:57:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db0b56feacsm89145531cf.17.2025.09.29.16.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 16:57:27 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:57:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>, <liuyonglong@huawei.com>,
 <kangfenglong@huawei.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>
Subject: Re: [PATCH 0/2] bugfix for hns3
Message-ID: <20250929165724.38379ae7@hermes.local>
In-Reply-To: <20250929113554.2443832-1-yangxingui@huawei.com>
References: <20250929113554.2443832-1-yangxingui@huawei.com>
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

On Mon, 29 Sep 2025 19:35:52 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> This patchset fixes some bugs.
> 
> Xingui Yang (2):
>   net/hns3: fix VLAN tag loss for short tunnel frame
>   net/hns3: print invalid MAC address from firmware
> 
>  drivers/net/hns3/hns3_common.c |  6 ++---
>  drivers/net/hns3/hns3_ethdev.h |  1 +
>  drivers/net/hns3/hns3_rxtx.c   | 48 +++++++++++++++++++++++-----------
>  3 files changed, 37 insertions(+), 18 deletions(-)
> 

Queued to next-net
