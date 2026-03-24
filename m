Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83DF54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89BC1402D6;
	Tue, 24 Mar 2026 16:57:00 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 86EE9402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:56:59 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so6810506eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774367818;
 x=1774972618; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmwNQ7bZeRn+da4w8LZpkiHPneXzm75LtffnbqlmX8c=;
 b=2JKgFi5PTMh8sWJrJYGYIWUGA8Fdmuz9DMm2wn7JTGr5j+qH7kHsdVmeZfj5//Iy2K
 WHTR/a6HfRYYRTJVpj6yVFUDGw/1Cq5Al+tM25/Qt+uG7yh+BmgHPT94pp/pKLj5XF5H
 FCjBIKUD7kT/J2/HNEbgMBJc2NQbE8zGXXFZVv8ejG9pP7SxUGNXwOpDcfbJ/hzPIKdv
 +Hj1r1UH8dt2lmbk50wOgJfEFaCXor+XyccIYKAPu7wmZ1ES49V32Kp9+bhA/sYVXeOz
 F/auCwcf2Q7QaC173EKrg9m7v4YyFhNj5cjKdhFci07ggqbCJjGZCWSrDkCG+5EC0I1S
 64GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367818; x=1774972618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmwNQ7bZeRn+da4w8LZpkiHPneXzm75LtffnbqlmX8c=;
 b=oReEoWqkGDPb1UnD22y4aRdSUda0x13mHrIQvaZgd/qlKyDhCAW2gm5gvDUVLM6vrR
 9zVq991T5A5+eJc4aAvB6MqpHRPXWf1BMOOEb60cNsUKSP+rnwwtVRELDxhVCTTMLbq/
 MOWSV1jdHy0kQCij3/brrdjYE2S9KYyZ060zOlMdcp3zx29RLxNRcg6tdgYoMYg0Sj30
 W7hB2hh9KlTu/et7KyJkWeQJVzeP1mXgPSaen5EaR3bQobF2ylLN5fIKyomlduJ1ZDkh
 fGOa6GRkVW3hL0fh8aieDa/3yjzFeYbIu1hFhfbuiKA3bTTkMqDGBOoFqJaOP5D00+Ad
 ZnGw==
X-Gm-Message-State: AOJu0Yy5fuJtqOw5xYKCWT+TyjYujEkblFjaKQifE2VzZQXZxtgRwfIt
 j5iC1Wqe983PbbIrI2fgbgB1vMc56PXI7wI8VR/Cj8eO/pTI73WbAKk/F9ZBtxb6S0U=
X-Gm-Gg: ATEYQzyIEfd0K01emN1IzVz6hVk2d1RutLn0RWlBSNZh6TWttt73SQYTnYodn2AR1Mv
 Q/8NvO6hjVyUHIifXYBSKD2DTFSPPvSbH0mp4VwU3HEM96xWOnhs8+pZ0O/i6V9JC1SxwDWVq1d
 FMdNYM7koyk6A63Yaf5CEb0EYLfe25lITFuu5ILZT4UsE8Ob688TtqmivBQk/mIYm9OWcfehsch
 hHQWyR1KwY8m+xYRLOBfkMtxFdunTgXSrhneMsy+ZI3Eh0Y9I/srjFNC8JiU2itd7DR2hjOmphH
 /bxAMZXKSxsCkx9aee3kG8a62GoYM88nYviCBfTAkIE2tZb/McN4mVznMFpQKAMfysFvF7ml6Sx
 oaVGpo4ZWuW+n16GoRQQl7Osb+3QcbgQVjtgK5+lhSmpqiHBl2ipxL1wNrSrj64TvRQ2V6+1NNp
 MxFLQH7iESautKcoGGgj3phCH1WlPVXhety8E=
X-Received: by 2002:a05:7301:6794:b0:2c0:d04c:a6a6 with SMTP id
 5a478bee46e88-2c1095a62admr7585594eec.6.1774367818446; 
 Tue, 24 Mar 2026 08:56:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10aefd778sm20930882eec.0.2026.03.24.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:56:58 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:56:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix memory leak in port flow configure
Message-ID: <20260324085653.38ebe80d@phoenix.local>
In-Reply-To: <20260324081045.6022-1-shperetz@nvidia.com>
References: <20260324081045.6022-1-shperetz@nvidia.com>
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

On Tue, 24 Mar 2026 10:10:44 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When "flow configure" is issued multiple times on the same port,
> port_flow_configure() allocates a new job_list via calloc() without
> freeing the previous allocation, leaking it. The old pointer is
> simply overwritten.
> 
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...  
> 
> The patch fixes this by freeing the existing job_list before allocating
> the replacement.
> 
> Fixes: df503d757b36 ("app/testpmd: fix flow queue job leaks")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Applied to next-net
