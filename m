Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF0CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74B940676;
	Fri, 24 Oct 2025 19:11:38 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id A86AC4067C
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:37 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a2738daea2so2049440b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325897;
 x=1761930697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu/naPZ0qul2fVFAp9cewzQhYoX8h0E3kIFlsxhUO4g=;
 b=Ck7trguShLuhrGMSCUz8P7JJz5lDcWedw769NP1wZC4rPZnutmd1K01EtLknnjobzh
 LF1+5aTs6Jc4ea/MccAoNLwqJQNGqOHCCtFf/+r9t530K32UsRVkqMlpN4gq9huqD1CO
 sWTj8VsxfUsSGoMyceIvjRjg9cdii7toy5DJcpeqP4qt3Iq1ClaT4oFDJNV+2LDcBCOJ
 JAInUsQ3WCo1FZGD+U7SIt5VaLk/u9Zp92wHNK5HLY9YLhuRRHj5YZ/IBTTFKsWqA9kB
 tuV6+Ck8xFQ9MCZGEkioH0jdGMZh34GgFXwTTnhEFarPptt+AZNpj40Ef1nu+Bg7ge6K
 2yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325897; x=1761930697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu/naPZ0qul2fVFAp9cewzQhYoX8h0E3kIFlsxhUO4g=;
 b=dZEBi1WnC/4An4DU7EubUjkC1tM8cophH7MrBENrIn1rLht4qgw29I+o0u7MI3bFAS
 yM1GrhTdlBf5Ljn5VJR73FOpANnWAayWLZv5VgxdcfqZuFS/EBN9mhoBL008myqoHnh2
 nlbMxUOUgRVhOi2luDENJSGXd1qVZFi39dPI9bgvX8Li4O4JhQagb1wQQKv7tdhZL/Vo
 hH6zkwju63W0BqtcoR2pFJY+k8PL8tkK8Niat7PGvg9CZnA/LovWyG0dpG31QxxDGM8t
 IvJtR4ImACvx7HDAjaDpKq+qJ0iKmu9QapWWr10AOuXuV11HHEh8dtApm6HU1Qw5iWsq
 ohzg==
X-Gm-Message-State: AOJu0YwWnjhN3gLwrFrMXUH/N1aVLZ8o93pxDMMsr0LdGTuykG8AaKqW
 sIIRz5dOJpP71tYM3kqTBc607b6yPeJENvf+ZgJHAUdDC005qYHloHQQPbfwi/F5+687rHkJCyW
 q24Gu
X-Gm-Gg: ASbGncssLETELAIhG2tbw6y2wGTVjJM1ezmUtZzRL35FHIecJ5op24ooC4ZhebVvA5F
 3VUEPsDu4btXc0Lf1stRtNgFEv0KrB3wc4n54pzWKNgEDitMxmbDNq8tcJE2Aawh49BErxyA0HV
 ChxLpRjzdGNaFG13CxcE9iBCWuxYb57UGNkK6lSf+NxcVu85IkyC6dgZzaVLix8kUF/59f3QpW6
 Eal1nXHmuK6e4MvAOy50U04NfPyhteQMl45UEIQRElqtDnAvFHpEz7yIJi9oESmO2AWMuXA/aFE
 h2sQM5A3nEv+BcdPPxjwIMyrFTV2NLf7ldb/GDSquFeIVAP8CmvO+uLsy+iiFDZLoYe6ezz6ZuO
 n77bTjHVT/QnNCI7Z0Nev2AzQqOpXUMzac0TAHIgXpRhfQGYkioKrH8gHToPESvzezm78H7qk5n
 Q+zuBh53NOVbHqHNQWAbcsroi6k6Vlysr92Q==
X-Google-Smtp-Source: AGHT+IGZS5hYXJrPGBLogyRYrPOjITL/5XG9gCqAPv2jOU8WesfVsiaeioRSyVBIBfVDIfr6ayErsg==
X-Received: by 2002:a05:6a00:22c9:b0:781:9ae1:1be6 with SMTP id
 d2e1a72fcca58-7a2206eb5f2mr34529438b3a.6.1761325896845; 
 Fri, 24 Oct 2025 10:11:36 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:36 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:01:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 13/13] net/sxe: add virtual function
Message-ID: <20251024100105.6c97d3d1@phoenix>
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:17 +0800
liujie5@linkdatatechnology.com wrote:

> +static const struct sxevf_irq_operations sxevf_irq_ops = {
> +	.ring_irq_interval_set   = sxevf_ring_irq_interval_set,
> +	.event_irq_interval_set  = sxevf_event_irq_interval_set,
> +	.ring_irq_map		 = sxevf_hw_ring_irq_map,
> +	.event_irq_map		   = sxevf_event_irq_map,
> +	.pending_irq_clear	   = sxevf_pending_irq_clear,
> +	.ring_irq_trigger		= sxevf_ring_irq_trigger,
> +	.specific_irq_enable	 = sxevf_specific_irq_enable,
> +	.irq_enable			  = sxevf_irq_enable,
> +	.irq_disable			 = sxevf_irq_disable,
> +};
> +

For tables like this, it is best to align all the functions.
Maybe your editor settings were different but DPDK assumes TAB == 8 spaces.
