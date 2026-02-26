Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE1DFD9E15
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 21:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82B1F402B2;
	Thu, 26 Feb 2026 22:35:11 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id D37B34026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 22:35:10 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1270adc5121so1693588c88.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 13:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772141710;
 x=1772746510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDj2ZPC0i5hp45sMoqdLBpdndiywgw7wD93dw3V8Az0=;
 b=T7CFf7dbOCfV2kBLYfnjh63lOIKbgej1R91VxcNNYFnLRi7uM6LaME4bp66cnkjk7m
 sWLmDG7MYF2w7UFQ2XkG4Tmj+OeiCl3gFv5UyPel96poodjybCTEdkyeK/a3VYuBoGO5
 XVAFM6Us0A6JC2sT4/O87jY+IKQnF8JGSjguM6Or3evc91GI6d6OGjOROmfOaghj6OgY
 KrqvNjRnXFQzYEi03Du+rmVyFRcEuE3yTJBafZVbxSSr0zfqY7N8vDVE9/vUSSVhkxxt
 L+bcPVVYyaUavefdF/BuQWKc/sfDcy+3RLBd9Tq2IHYnNB+KEcDzGcG+qMrXOd1Vs5R5
 4Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772141710; x=1772746510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vDj2ZPC0i5hp45sMoqdLBpdndiywgw7wD93dw3V8Az0=;
 b=A9Q4wnuc6VZVbgWiicZeB3NgWiZBA5SrXv3evjDU4Grgr3NF57DMN80WzIwTFMPLUV
 uT/YnsC/0sma8vwNiFh0JapxzhzYD8h/y5LuW6ne0opGVgUbaYjfVd51SHRoe5TP73JS
 6iPg0V9NgRYtTIRhkZTGSZKE021aSoJsfzRtQ/4OGrdsXb+3F5JsR0gGQeYw2S0VndO1
 nXuDnUfIeh/1x4zAMATXoCa+uzQ2G0qzgvEiO2ja3gFRlatWThprNL/sZcku81KcK0SS
 tPaDeXpa+OlT9InF/7Cv+zvAsitBYm2BeTS5LAqBfhJmnTagOyfCanhrZBVEHI28ijFz
 m/FA==
X-Gm-Message-State: AOJu0YzR8A4F6Zr0fEutnG5YyGMl3AUPFYaKbTDnGN9nuGDwb84o/nPz
 gmqAyLht9Er5zKWx4ealTsj86l4nr3uXWQHawvYlnmuSbV1ho6c98EQSuloSYhmGxQs=
X-Gm-Gg: ATEYQzxFRmD4h4AZa/CTFQ9M8dS0PsDJWu9WQYGsDSYzSAJf6aKMj0EgxU+pL6DGUui
 OSXkjyo9Y5nrpRDK4ojLOivjYdBLAbJ1SoX9ywi7C51gsz34GgYYzkDQp5ZMrFoDFstYXIGqyI2
 ScnGCiGBMtiti7Aj/zP3CEYnQ+KnhBTPM27re0WtjPjz8pAUBIUejZULYtF7OpfiuB3uJxPfQcO
 3l+fn+cntsIL+yvlcb8L00Y5gtjHA2fGMlNcyJbFpOK/UO0lP97zafh++4kaJsP2S195Qqr2z/o
 KgMk+pyz+cvbbsSMld2wN64X8+nk4cSvS6szBs5nNK5M1eMcq2FPpsSFJvJrvnOohs8elQ4zIUD
 pLro4xjVgFjIsYENXltL06hcSRQnwiWnQaBOe7nIgLUxmIZCYjm5FXZI/l1I9B28QBPnOCBTDfl
 2La5XkEM9kJOWbRY947ZsvyG4dqopMJg2iIAZCSSuRz6SCU2X2xUrxe8/aQ8yia9ZyifzoDPcgn
 yg=
X-Received: by 2002:a05:7022:4a1:b0:119:e56b:98b9 with SMTP id
 a92af1059eb24-1278fcf034emr186389c88.32.1772141709848; 
 Thu, 26 Feb 2026 13:35:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899eab46sm3018379c88.8.2026.02.26.13.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 13:35:09 -0800 (PST)
Date: Thu, 26 Feb 2026 13:35:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, aman.deep.singh@intel.com
Subject: Re: [PATCH] app/testpmd: reduce txonly multi-flow src_port range
Message-ID: <20260226133507.52427384@phoenix.local>
In-Reply-To: <20260226191625.1049670-1-longli@microsoft.com>
References: <20260226191625.1049670-1-longli@microsoft.com>
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

On Thu, 26 Feb 2026 11:16:25 -0800
Long Li <longli@microsoft.com> wrote:

> Reduce the UDP source port OR-mask from 0xC0 to 0xF0, lowering
> unique high-byte values from 64 to 16 (16 unique ports per lcore).
> 
> Modern SmartNICs rarely need more than 16 queues to saturate RX,
> and excessive unique ports can exhaust hardware flow caching,
> degrading performance.
> 
> Unique source ports by lcore count:
>    1:  16,  2:  32,  4:  64,  8: 128,  16: 256
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Make sense to make this less spread out.
I wonder if this should be a parameter to allow for testing different
spreads?
