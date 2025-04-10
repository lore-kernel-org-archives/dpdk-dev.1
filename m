Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9EC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 22:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39A584028A;
	Fri, 11 Apr 2025 00:46:53 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id F037C40285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 00:46:51 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-223fb0f619dso14585565ad.1
 for <dev@dpdk.org>; Thu, 10 Apr 2025 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744325211;
 x=1744930011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSeKoYC+8rLLaCUjMc5sBg6XjktbI1d+mCx0oLEDGjk=;
 b=zHoGqjY7+Aei0DJwkULJfYVCjgCJ7mGP/a+Vxs2IVKdXltkcbox/88vU9fLO1k6kaw
 c7RXWnzR0e+8X+0zOFzra2JCxZXykCaAArbuvU7Um2zShd7peteaMAzunNui6m/qEwx2
 JpeiRRFzenDJKjDs7CSgMKdy/rJqyy++kUqFyzJcLAYwlX6aZTv5ITYC9z0GcgMR4wm9
 4ZXR5rjG/lXr2JjZMjAR30hAVt3wI5QXzm0pjWxwz9BjWxSnrzWvSvvebX0kGqZ4iVHG
 yQj/2CNf0wk8ibb6vHiN2Bz2k6VpFRhyWxP48LctRR3ScX8Z7EGnEPpcbrTVVlJLt3oO
 pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744325211; x=1744930011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSeKoYC+8rLLaCUjMc5sBg6XjktbI1d+mCx0oLEDGjk=;
 b=u7DXmkkQQ25Im18+Aod4mOs6QatnqPd+YkW+A6nsrA0kCN2/xmkrdC8z826wtelrOE
 yzC/BavWcr8fsJgBWGJW3QDoSoblIygpZfc7YfH+WMqY1dJJ8369mX6rl3mAvRcgGcPY
 bMSipTAIlT5ZwcxD4vCLv18vRrRztoceoOSs4QpZkhglOGcsWm4x6ler4hd81/Ct9Ur3
 JhQMPoV4KOGNgm18vlE+GREnmkMfX8Oyc5CQlalsbC68MGHvi92IkXcOCZu5VdkUgDza
 cnkdDA1VEhzxzHoSl0xqYGHrgZ952mk9C+dYzDSM965h9eDe3xhaOos7YDedfKnqOLjP
 Z74Q==
X-Gm-Message-State: AOJu0YwWNqoeKmBRPrXFEnZ6I9jVj29l2uUhCZKzTnHf9NbVQMGb0ZSM
 B6vIpKaowyxvs3VY7bQSw9oqCSeqkUv2N42p7sN2vBKxTBD9J1bIafVUkBnLNEQ=
X-Gm-Gg: ASbGncvO5AWdUJodeGLM+VaHjJQo8Vs95LwEdZHh80tfoWGwjjSs5kY00Kz3Vdxlefp
 VS/wJ+8jtYKMBsYVzGinQ2j2a/F+aEovbfRDL5W9QgqkSnf+M0NvTgB+GUDYWzvxxsWixXQxYQx
 bxgLOw9NMGrNpXEDeS28fi5Q6oon4Wzch8gc4FHufZmaM50JgnT/etr/27/kHG9Ujumq/c0FdXM
 u3mKYt70u+EZlW7OgenKUbUKEty+P9dYk18YanDT38c8nSbCHM+JJnXAx66UJNdxOpSeBcDPg19
 54zuWzl44JIJDEP35ffKiwuNQ6bVLYLEUTmkpPRXeki8MdvV75Hap2wpX/4JMKKWKtYjJMVC9gD
 2yIRizuoCkd8ux7yQ
X-Google-Smtp-Source: AGHT+IFpEkLNq5daRTYhxfz6J9WA4fVXV8QZVj6DahyLZyR7dPAQrTTYd8DOjvb4bMWADVsC2ky5EA==
X-Received: by 2002:a17:902:db0e:b0:223:66bb:8995 with SMTP id
 d9443c01a7336-22bea4ab827mr6262715ad.20.1744325210934; 
 Thu, 10 Apr 2025 15:46:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb52cdsm36033015ad.191.2025.04.10.15.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:46:50 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:46:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, Luca Vizzarro
 <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH 1/2] dts: add packet capture test suite
Message-ID: <20250410154648.74fa8f97@hermes.local>
In-Reply-To: <20250331155800.449823-2-thomas.wilks@arm.com>
References: <20250331155800.449823-1-thomas.wilks@arm.com>
 <20250331155800.449823-2-thomas.wilks@arm.com>
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

On Mon, 31 Mar 2025 16:57:59 +0100
Thomas Wilks <thomas.wilks@arm.com> wrote:

> +    def _start_pdump(
> +        self,
> +        pdump_params: list[PdumpParameters],
> +        eal_params: EalParams | None = None,
> +    ) -> BlockingDPDKApp:
> +        if eal_params is None:
> +            eal_params = EalParams()
> +
> +        eal_params.append_str(" ".join([f'--pdump "{param}"' for param in pdump_params]))
> +
> +        pdump = BlockingDPDKApp(PurePath("app/dpdk-pdump"), app_params=eal_params)

Please test dpdk-dumpcap not pdump. The old pdump is legacy, has too complex an options,
can't work in many cases and is a general mess. Dpdk-dumpcap was built as a replacement
and has way more features and will be supported.

I intend to deprecate pdump and remove it in 25.11.
