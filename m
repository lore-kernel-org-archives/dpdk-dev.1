Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D4CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 01:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F52B4026D;
	Sat,  8 Nov 2025 02:08:10 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1325F40261
 for <dev@dpdk.org>; Sat,  8 Nov 2025 02:08:08 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b62e7221351so1089376a12.1
 for <dev@dpdk.org>; Fri, 07 Nov 2025 17:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762564088;
 x=1763168888; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9ut2kTRQ709p5Y+L/hyuHYY+d6P/5TAqrR1Nk0cZSg=;
 b=WK3yDTICor2z84Le9DP5qEKK86RxNFRHJD966K4FDm3MyD1WRL3y0u9bwMVcUbZUSS
 He6QxoWdUQ6ZkcnVojfycejelwxlAmNDjy5nXiPnF7lZIAtCcAxMacvFmuvSoulZt34M
 hq7L/bNAUUQFabhM7iGp09sMqZ6E1wY+5by98AOn8IbHw61Su7p2qLmPBzYTu6lYbKYc
 8EjJds+qTWc1m5NRPTSsOlARcvjHucTd5MBIqUn2x86aRhGydomJxYAjKl6SxONItR8Z
 dElYy4FHSB5GTxDstzWyzFTRBatQzdXmWxwKn4wxef5rrZQvGuCbDkxaKFM2LeU2fW81
 64Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762564088; x=1763168888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O9ut2kTRQ709p5Y+L/hyuHYY+d6P/5TAqrR1Nk0cZSg=;
 b=v1tX2MePx7JdKiAL4BjrXVD1AVjUlkuBJvI4+ATJbJ6dwgns7Rmhm5xZFfKao8tKo8
 LOM15D06m1Prn0s29/BpvnM7RpUGSWYCC2eEHRjcatzAU6fhLBpq37DNlJcY+bTI839U
 eYzMxi8R+Vz/2mPDNm0ntJntAEvKB6RuLxiIumeK1C0sWn10y/z7b4gNU3gOgK4LKn+G
 FuEDC1L28Q0ipmH5qlQMjWPA2BAWbcZYt7mfIuC9zTrSqs3e+XBHxfifCVYKcf8HKaDm
 AZLoeYLigQ9NIpvfhFFiZwYOmbmD0+uCXzohpmxJb0nhnLF4KkiG+vMDZU9HMRIqAC9/
 o4cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7MfeypVCIqPA/X5bj1C6XOVGoKwfiCoD4Rzq4/WdQM5IQWAdiGhBu4q/Y2ADxC58YrRw=@dpdk.org
X-Gm-Message-State: AOJu0YyQKuHb20dxHSi0vq+OauZAGqzKAJMcIMrPouwG1D1yuFvq4FnR
 HGZt9kwb3FBwkROi7JUeLlfxtiqVlwi49TOQIKHZCW23Txq91LHB/jXTdtky+9K4/ek=
X-Gm-Gg: ASbGncvLaruQssDfAsoCgXDHVq3ZAzNd5XdWBloNdIGAEQzHv5Jn//ulmRr50QQ0OEa
 yRGzahEz4vmPCd/PJCwC1pfNAB8ir+VovgZ7QuXRSCkVHrR0gMEeg3qx6cpssSU7uMWmL3kLjev
 Qurr+07udBIG8nR9TzXiO8R2HU2AmqSMM3MCCSS1l4jUed+SShX/CnyZD6bx/+RH0WAui6SH5jm
 itZuupGp4MnmsDBUPdCq93zFRRvvYou6WmVA1j4H6JAlAAA0Gj/9rPDu2fNiUnO+xI+1qyuUDGw
 lGGkJAJoQg2IpnH/PZCwP0f94kGunyG7Scylx7NfU+Bi7ImjUhQPmxGmgKsVUu5o0QDhYbjXW5L
 5MhC6rDxz54W2D9gwrK+HDlC4IjSDCad97gZ9yr3+K6nDEUlKCT2zfufbFR5SdkowbgmxBY5wyJ
 r5hHTFlraUMMk66uxrSAEIjkyJ8DfY3vpTDg==
X-Google-Smtp-Source: AGHT+IGTWpFQafwS6lDtm+7guOzJIsqfDcIgocxIvrtstleFS/mAupE4wShFYXQ/2WClW5dk7ZzrOg==
X-Received: by 2002:a17:902:f70a:b0:295:8da5:c634 with SMTP id
 d9443c01a7336-297e5409d9cmr11515195ad.9.1762564087879; 
 Fri, 07 Nov 2025 17:08:07 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5caf1sm71850385ad.34.2025.11.07.17.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 17:08:07 -0800 (PST)
Date: Fri, 7 Nov 2025 17:08:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Message-ID: <20251107170805.12e51921@phoenix>
In-Reply-To: <2951855794674cada3b9ab9574699917@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-4-stephen@networkplumber.org>
 <2951855794674cada3b9ab9574699917@huawei.com>
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

On Fri, 7 Nov 2025 17:33:08 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > +/*
> > + * Test BPF function that will be loaded from ELF
> > + * This function:
> > + * 1. Reads values from input structure
> > + * 2. Performs some computations
> > + * 3. Writes results to output structure
> > + * 4. Returns sum of values
> > + */
> > +__attribute__((section("func"), used))  
> 
> Do we need `used` here and in other section attributes? I do not thing `clang
> -c` will eliminate non-static/inline functions from the object file, or maybe I
> don't understand the purpose (perhaps needs a comment).
> 
> > +uint64_t
> > +test_func(struct dummy_vect8 *arg)

The BPF loader in DPDK uses section names as the way to find functions.
The original version of this code was autogenerated off of examples used
in kernel BPF.
