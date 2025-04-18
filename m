Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9740C369C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:31:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7839940649;
	Fri, 18 Apr 2025 20:31:22 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id E1B0F40613
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:31:20 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so2179544a91.2
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001080;
 x=1745605880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd/+sQEghyIfaJalLbImbtxvxdYkZ0ZYZp++rqXOTro=;
 b=NqsGEb1DZyg8YFmmYya9LfJQxMxbi10LAIw7DXf6xutmkG0IU89V7g09Yes/lJ4iP4
 IppYIGDHeqxbkryRgRbJqvEpuUGnP9oeGwY4RMQCQrlCrs6aa5SHY9X6SeS2Kt3I85Yy
 OC2nX7w8zI7hEEayUmR3Ae7STfH3xjcoOrhWXFx+uPxdDennnF+V1NLNVnRbBGw021AT
 K1TSU0/6rt9pYyQohGnseLJGwE3WuVDlY/B3ob/G/mPD0AX5cCEmShtp/SiYeBwQkrgl
 QzHU8g5xuQbTG3rmKdBd6cr06O2uKSf62c1b74Hxg/+Huizx5LTAYJlkxmr61KX3p9Ot
 /eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001080; x=1745605880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gd/+sQEghyIfaJalLbImbtxvxdYkZ0ZYZp++rqXOTro=;
 b=cyJRY1EtMXRdgM4jC0tdFMq4avZ5/QSypkAJ1TyYf315nACCeNy9iMYUIqBfCNh99h
 RgaGHR1U3nqKheMhe3cDRtLJ+mPqEvXfPDLe/tRfjWgzGGJ2NxOQTho9qImQdpO6eXTk
 0/VzMYy1ucdGnFUMTLy2uTKH90DEd2TsOYFRxHD414nKy2Pr9u2ZN+FLH2IktRTqWa7F
 YUB/P347KD1Hlh1wnillAo8NmfwVM1Bv+eqzHeBb53YX24wE3oL9knqYwiWlttPSEFV/
 Q0IxMqu3r7rohPDpX9+MlcUv+hLd3Pzgbuyl+aZA8P1smAyxYL4oHmwTPYFODfQWkRf1
 uWfA==
X-Gm-Message-State: AOJu0YzHjznVuTV5OgiZ+qe8f5ugmqUDxjLIMUG9F/n8jVz+cX39VPUo
 kjhZMhhMDBFda3MPOIRrrMwp70Ooj+WoWb51lCO8fpN+QMe8HiHBbd0xPOmGJVM=
X-Gm-Gg: ASbGncvkRnT+0AzR3+qiDkD9fyXhSw1z8RxsVDgRvVHbSYBYHBC9lfawmYQKIbTRWOm
 IimQ1cVCFPrFsZryPlv/khTQCQVl83IwfDF9ZYAPLSYws9el/yFRsDQV2cqX++OnAYmvN0VaQcm
 ubBmA4JLxSMT/V4D9edugs/qTmBq9Q3Pm5tobTXpnmDMLjqIb006mzVHaiiCjIuYXR1eqpm76bt
 Bzqnc9RBenjO7MHhjEcd6X2hZCmWAD2BEk3JOo4c01f9ll9OiKgvSWKffFQ9h+X1rO9+tX50VUS
 l7i5uDTzWe/t05JWeosIJIYJUQDVTUK5NdECcaek4b7mwudcsHso/E7mCi0n2jy0fsVJen4zI3/
 LnTZ6WBZP0MWCWUI9
X-Google-Smtp-Source: AGHT+IGCke/QChHEANVBlX1TLEaVFjuICJHElBRb/4Zd1y2glMEB6svaGi10ay6m7OiuiLZ5/r39Mw==
X-Received: by 2002:a17:90b:2b8b:b0:2ff:502e:62d4 with SMTP id
 98e67ed59e1d1-3087bccb0d8mr4620385a91.32.1745001080125; 
 Fri, 18 Apr 2025 11:31:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df1cc9asm1554745a91.22.2025.04.18.11.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:31:19 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:27:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [RFC 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250418112715.68687924@hermes.local>
In-Reply-To: <20250418090621.9638-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-18-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +	u8 pause_set; /**< Flag of PAUSE frame setting. */
> +	pthread_mutex_t pause_mutuex;
> +	struct nic_pause_config nic_pause;
> +

Please don't use pthread functions unless there is a special reason
to do so. Why not a simple spinlock.

PS: the spelling of mutex is wrong here.
