Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A1E7DF19
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB8564027D;
	Mon,  2 Feb 2026 18:37:14 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id A23134026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:37:13 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-480706554beso51308715e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770053833;
 x=1770658633; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTaQnRp/N38S1WVFvIJWYbLAvIvY785RQoImlWgdIzI=;
 b=uBDl1B/Zn1iB73TFhQ7C50I8O9mtHONeUgLo16c7mqs3JFSZxNjQfGjmyUg+LATnn2
 6E9NrfF33E41k9lEC84LbE8Pa0mlxiJGqt4TPj1fc/W42mYNYEzROANQBv1/sFxwBKnX
 4R/IbwxrSOdEVzmGEJONhIosM9Z55gtHW25GEmJZumyZj16yOW+a0xIzkjx0/rd9n2aO
 6HtQ7ukGVsY0/xiOGw7lGOqdgMw/5cYOs7FhHfFr8JVGYN2ZBWCvtBg0UCqt5lTHVFh+
 SFn1z4RKA52tNy+c0BCXyApUNEYkn5CPWDpjqpdp+oZcl51Tnz6evGWOynWMyPhYof+F
 miog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770053833; x=1770658633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aTaQnRp/N38S1WVFvIJWYbLAvIvY785RQoImlWgdIzI=;
 b=h/WPdOtU0oZApO2w/s0Wy57BHGThzYL2N4y+IRjmuWbyKivdCvRqQJhphqed/q2O+z
 VdaVise9e5jtoT6V+CwaM5HVX3zYc+s1NSPvr9WfEQv1A1w0ynVpOpz5lgPc5QhPYbxL
 l4c+XSqFp/Y1152lG4819d9VuZe/4hHowz75sw3T18ajDCeAQdkcjZqtkOj72Ok0NO1/
 CmaSD5wmVhPTDOGOsvsjWadlDuXrbai44bYDttUZVqBfcbFLozbFrqxV9cBsZMRAVDd0
 +pAWYKYBPwKqW9RP0epsA4x9QlKMxfJAm8IaKaD8s9U8EHG/gFHVkMmCBRIvlGzNfyAe
 pzww==
X-Gm-Message-State: AOJu0YwgNfRnW2uKU++Bgg1Cl4qnf4fAfIsUozqM+lTAxkCKcx37Qt1J
 Oe33UaVgHHMWRwuG92O10pJgTRvcSeA1XDda83cXZSYX7wCPfWXv+jshioTsPy8NkBQ=
X-Gm-Gg: AZuq6aJgfXEZaxrdg2HrdCvzQhEXmIQidTMynfIwp6Mw4n+dlJRaxe7b3liB7SZrtFW
 HjuCMQd4iTVv2KsB1RvXujOTJvJ1oaipddI3TbyOI4nzk8B2APWrnweWW1IDAXTRi1xrbWN8ZFc
 uPkxGcNnlK6PxeIqqIXkh2h4gbgluy0OUjdShUXXjumDxkSOcLC9GDJSYDLzNTgDbK+I5/jisS3
 WpbApCaiV0ZpyHCoZ1IcIK6sbzfTtzADS6xlZ7RIH/Ui46XAKC9CoQdp/S7LXSIaQua5Lxjh2fa
 Tv4UYXq9ObTo1w440Ok9lEXxnawVdfRKO9U8wmzpBeczcx483aSSMQp9UTA38SGUVoicJuAtYgZ
 RpNdWxzmeerqS0apDo7rvQ2lyjYbWgAU0Ly3evf5h70TLaT8ivXbq+1AnKt2phgtNVmfBAqdeyH
 84RTyDSbHqiMQmxyOOXvbJk5tizUDG9ehJsgAUBzhS2QaNLqxcptLC
X-Received: by 2002:a05:600c:1d1b:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-482db4939d8mr159530185e9.20.1770053833209; 
 Mon, 02 Feb 2026 09:37:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e474csm44328775f8f.2.2026.02.02.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:37:12 -0800 (PST)
Date: Mon, 2 Feb 2026 09:37:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, "Claude Sonnet 4.5"
 <noreply@anthropic.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH 2/2] app/testpmd: support selective Rx data
Message-ID: <20260202093707.2c699414@phoenix.local>
In-Reply-To: <20260202160903.254621-2-getelson@nvidia.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260202160903.254621-2-getelson@nvidia.com>
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

On Mon, 2 Feb 2026 18:09:03 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
> index 97d6c75716..638c0b0eb3 100644
> --- a/doc/guides/testpmd_app_ug/run_app.rst
> +++ b/doc/guides/testpmd_app_ug/run_app.rst
> @@ -364,6 +364,11 @@ The command line options are:
>      feature is engaged. Affects only the queues configured
>      with split offloads (currently BUFFER_SPLIT is supported only).
>  
> +    When used with ``--rxpkts`` on PMDs supporting selective Rx data,
> +    enables receiving only specific packet segments and discarding the rest.
> +    Gaps between configured segments and any trailing data up to MTU are
> +    a

I don't see driver support for this. Seems like you are putting out
something that is not testable yet.
