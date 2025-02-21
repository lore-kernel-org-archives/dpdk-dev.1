Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5974FC021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 19:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58BF4410E8;
	Fri, 21 Feb 2025 20:14:41 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 72AC5410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 20:14:40 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220f4dd756eso51549235ad.3
 for <dev@dpdk.org>; Fri, 21 Feb 2025 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740165279;
 x=1740770079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsHTNRzGY/UPiuQBemuInWU5tFdPDf3Po19Lu2f2iiY=;
 b=dZDhHR4gkOloxTujTMEhsDmB0gjgTO0QG4JCD50UljxnJd3PaRIRw299yl9l8Q0NtP
 y4GqQnA5XgrsnPL5eTycQiLxZYQsXCs6JNYBlLBsqa9mLJHHr1l8nSLteTyxk9VpJIYN
 jBqarPslH8Hxu9qkisHxSxOSR8UWRjJ1bpn5tF5O3eqqM9E8C/HbGxb0POFigf85PL6P
 fyBvf+wZ363L7TSB0mcOGMaNnhIGXOAfZohd6QmbuQWanDHcA9EYTpe8iWhG2xht+hCG
 uFoQ3BRKKE0hFKPapicaGG+csZ1Cyf+hz1OsLvB7/MoMZYq2Ij7tomzrQAUwiWNiG8ar
 m0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740165279; x=1740770079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsHTNRzGY/UPiuQBemuInWU5tFdPDf3Po19Lu2f2iiY=;
 b=NHChMYPM1/nlSh9F3oaNI4KlxjT3eM7MQhEEXV8Wf5bCKQDmXJrOMdrtA17O1wHA/u
 BvsBvVlM9D1fINOJf/KaPcMKnmi6a9Xr8/0Vd9/xP+Ik9wzWB2DUJI4KK0qg9FaS7hUK
 tb45LQLz6oiF9Je6N9h5iuDMLFPFzeOiePCOI8ljOw+MXbsj6g9Z2Z4xInYLUXqdfTpw
 xwEIhm3XxFYk/xxPQpin5nNOtJnr+cmCgsSmrRhRMa6BWsmb0LdFhNtBxufB8sJTzlr6
 q34MEnGgUwRHdR5KgQVBfQL1yPd+1zLxXrrscnhKIejC7yXy3ecIek8ys0lZWHWhJxle
 XiFg==
X-Gm-Message-State: AOJu0Yypzew7WYJZIxKdBSFfuoqMaNF8/IxAAQDQmrP9rmBZG4YZKgJx
 e98wYwRzrGHiG+UB5myR3Wex693uN7s93yEXveHGIJzik0xoCuepukzyWuy/kAk=
X-Gm-Gg: ASbGnctHmv/EfT2AaHPnCn1TusWVwAz5wNiA0CKOXv5JIjfGtj0+F9HdYVXg9yiYFKe
 AthQPFBFK3wVCiuj6fDzpVEdbthpCaPPhOnA+luurd3+oaMvs3dk208AipIwcE3tiN8rDTarEDR
 5TQ0Dx+gwqwuHCzOR6b6nJryzNAqm3fBXA0Mrx2eL7pzMaRG83DYigXpTo7NomEZe6YhzoMKzld
 IXHFvnJtSxGcCkCfyroFwBhH8IcKnZ1I0kew7Bv8epwaGfbEi4RleR7NLxfauIgQ9GSHx1dPrBa
 XoCicLm+5j6akQ71RuR0gPgOKOMuAtROh6ldAe/aiWCgxAS7my9TvnsAOL++OwSpclbK3RqrX01
 7iis=
X-Google-Smtp-Source: AGHT+IEpNngZt4+Zs8/3wYPTPVDhXx0o+cxHZFIUh2tHa9DxbWZDYoLMUhqXdfEstPs7Rkg4V9SEnw==
X-Received: by 2002:a17:903:98b:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-2219ff4e4bbmr63231325ad.13.1740165279242; 
 Fri, 21 Feb 2025 11:14:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545c897sm142123635ad.118.2025.02.21.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 11:14:39 -0800 (PST)
Date: Fri, 21 Feb 2025 11:14:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Megha Ajmera <megha.ajmera@intel.com>
Cc: dev@dpdk.org, jasvinder.singh@intel.com, cristian.dumitrescu@intel.com
Subject: Re: [PATCH] sched: fix wrr parameter data type
Message-ID: <20250221111437.08e56fbb@hermes.local>
In-Reply-To: <20250221124755.427459-1-megha.ajmera@intel.com>
References: <20250221124755.427459-1-megha.ajmera@intel.com>
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

On Fri, 21 Feb 2025 18:17:55 +0530
Megha Ajmera <megha.ajmera@intel.com> wrote:

> wrr tokens getting truncated to uint8_t in wrr_store function() due to
> type mismatch. This patch chnages the data type to uint16_t.
> 
> Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")
> 
> Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> ---
>  lib/sched/rte_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
> index d8ee4e7e91..dcef44b91b 100644
> --- a/lib/sched/rte_sched.c
> +++ b/lib/sched/rte_sched.c
> @@ -66,7 +66,7 @@ struct __rte_cache_aligned rte_sched_pipe {
>  	uint64_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
>  
>  	/* Weighted Round Robin (WRR) */
> -	uint8_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
> +	uint16_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
>  
>  	/* TC oversubscription */
>  	uint64_t tc_ov_credits;

This would be a change in ABI.
