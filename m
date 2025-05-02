Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36366C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 20:26:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC614402F0;
	Fri,  2 May 2025 22:26:41 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 240E5402E6
 for <dev@dpdk.org>; Fri,  2 May 2025 22:26:39 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-30a5094df42so1418111a91.0
 for <dev@dpdk.org>; Fri, 02 May 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746217599;
 x=1746822399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSDEuYlFVxM1Wc9entAMrAue1VxGHU1S44LNMzTSjbo=;
 b=nA5RnG4SnvSKs/BDxi9GqBHBKXolnpcJS9z322PCgI4S91VTiFBJ14EomZE41VcO5K
 Nk54r648X4S0fGck6n7doNszGpMqnnmUGb/cWi6fE4scL5Kj8xzHgMu9tM9bcIYSeeC4
 D+HtCVhDiXd9AtS9flv1gjJa6XtdbDSKci95chyXw+C37MOvVRZFZmOo41VkWYCuZuNF
 quNgLYv3hY7rRe+FoICFSHNh1RWcZsGmWjfAKUFUsKC+A+8tG89yZKWgt4RrNnSNqSSz
 LBuMFBuAo4qH1j/dqHjcRifUGU+J3yZlqbdEjV2yzYSwi0CzXX8K9L+R/QVR73GC+kBj
 HTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746217599; x=1746822399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSDEuYlFVxM1Wc9entAMrAue1VxGHU1S44LNMzTSjbo=;
 b=v1fMttOTGEkaHtg/YON6zyirNdHQqswYrtb4WKSnZFnrc5IJEffHfMon3PONO6UCc7
 4yZuWLJX40Gap84WMPpiXaPDl1uMyoW8l2TfCJTv5oCvW574MmBJ4A3zCgnbx6j5O73R
 hpDBi3Ms16IzLNJJJUNCLJSSeZFAq1pE+qvjHjkvQtwpC5G8uAnNwiizWsUG/jVlak5l
 TFwrEC5jIm37eptD+zMmVUmrfgVBtNflyHPpPoENircbExtxUaa+MSQLm8GKDS4qFB2s
 +ZYEUTCQWxfFurJHuk4vioEfqfX2EnnZqU8jp5yqEwr4lTQoWFvRMDjCfSt2Gef4Ouqq
 F7sw==
X-Gm-Message-State: AOJu0YzEFH45a2YNUzdpbIlyuA2u0hCwpW8dVQAroKB4JQz4OyDXkIed
 YsAV9EzZWn9DWel5BQxoQIgcz+w1CY3NZvidCLQxTCMY+SvuZT9Isey4V/IIzBk=
X-Gm-Gg: ASbGnctHTOQeOlAaAyLIIcwXP5Yf6VBYPJYjkZD3Sw8tsNQaZ/lUjLHB0o8dfTvId66
 hDCBPPQVFtYco/E3DvW3P3JlT4ANgfAtyWBG3/sh3KFtLxzGggRHTashCiY/7CgBK3eaVzmsHeF
 Gp74Ur1tIkFA623s+SindPjRNSeM9E7Y60XlKEo9lbR4NUqv/pwRDqPIhah4ZAsTaApgNkgsLOk
 EcuF8fcr8ySwPq4yjJLEp71bgeu5TQLZHaZZsRj8QhWVP+3wHOYso+WLzhfVqFxERznTOOpmMbQ
 383Xa4Yr9akZxb+SpA0UxJsOWUjk2xFloL77D4M2haxH4RcXt6fuGzU8HrF9HvID3Ig0yCYIb0Q
 ZTdcQ5B0xOGnQ3HL1
X-Google-Smtp-Source: AGHT+IH7dPxDyGfMN0nQMDHcz2AtZD0P+gPjZ45Nn3hDGipK1ZUJ03vUhnaMShBW9grb8LdvLZbvXQ==
X-Received: by 2002:a17:90b:514b:b0:2ff:6f88:b04a with SMTP id
 98e67ed59e1d1-30a4e5c5ec1mr6478406a91.15.1746217598790; 
 Fri, 02 May 2025 13:26:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34826677sm6236282a91.40.2025.05.02.13.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 13:26:38 -0700 (PDT)
Date: Fri, 2 May 2025 08:42:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 1/1] app/testpmd: add sleep command
Message-ID: <20250502084213.02b1198a@hermes.local>
In-Reply-To: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
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

On Fri,  2 May 2025 13:27:29 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> @@ -13701,6 +13735,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
>  	&cmd_help_brief,
>  	&cmd_help_long,
>  	&cmd_quit,
> +	&cmd_sleep,
>  	&cmd_load_from_file,
>  	&cmd_showport,
>  	&cmd_showqueue,
> -- 

Looks like original list was in alphabetic order.
Please preserve that
