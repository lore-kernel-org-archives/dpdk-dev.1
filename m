Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC5EE6B77
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Feb 2026 06:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D6DF402A9;
	Sat,  7 Feb 2026 07:09:48 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id F37614029A
 for <dev@dpdk.org>; Sat,  7 Feb 2026 07:09:46 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4833115090dso725765e9.3
 for <dev@dpdk.org>; Fri, 06 Feb 2026 22:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770444586;
 x=1771049386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bl254tIJnx4i6dXuTJIor5iviegJnxcmOKpbaXU0lh4=;
 b=XEnuruW3VeELhifzGeM4rL2T4cy1vzVmXtitjGDdpgX8ZbKCm33Nx1FT3WAbV+YEsG
 LZAx7tNJYDbrMRIgdmlB0t/GB7K1E1e1wE0JxfepfxqXdR29+rUn+aAFz34sV7c22JQ6
 qAFzl5ZMCIjT5ROFniyBrMAhyl82v/3TFNqhXywejvgxSa2MN/2tJtWE4RVSisqDr038
 DmzVtBYAWNNUIS1FhSk1oHyFAGjCJp0N1sJ85GAIpgpJuUdK4MWif+UldIh/tIN9PnfU
 xYr7fbgNrBifNGRl6rJURel6GKBwo4io1RpST09x895t4M9NWfJXl9x4Py2EYoFFjirT
 T6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770444586; x=1771049386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bl254tIJnx4i6dXuTJIor5iviegJnxcmOKpbaXU0lh4=;
 b=K7+89z58i8h9bP15xolzLulWsbqxXENKsyxgHw8xCWIZt1Xdlbhsbrmhk3ZhTaJLHl
 cl1bVRuWnCz2sRvP865zJUjWVhiB3kvHwp2ty6WH1oBYQBNt17hleNT3squIGct1pyIE
 r3y/Zi7AcgLtzasCDLhlERUKHaAlD/HBngnVfIApx7uSxgGDTfS4xnzPPwdgpUaW9RLY
 phvjomRVpXGFJCDct4fK0Wv7zJBjfLB3fayoiRIWI8gQyq/UjBMpLIH9mb1KCeKpAvG4
 bOMI0F+9hSURGu6q0JYXea1BE0FMKYhYasHFcMKEXcHkGQlMd37FrLkANWBRd6qK0BHX
 2aIw==
X-Gm-Message-State: AOJu0YzNXmhkkLXPRrC8VVJyMTb9rhAEZitCwNbMVvWXMWohy9OioMfO
 dKN8rLG/OUlm3IN90xm/G7bblfag+sFS0eBGZvowCIL8lVdyTuhv60xfsvheu279xuI=
X-Gm-Gg: AZuq6aKeXohrS4y4V4U5RtyX8zV4AfWLTEXZx/aTvEgGy7KbwMKwmI777yoCHhU/aUI
 ztmPCFWUDs+kxpO3oMmsW/PDYuiAaoNk+TS35kjJ8eceTSBSqHI/P+IFOLOn3KdfYDWRVDoGgho
 yf7G9mQbSUIUF5LQRC/FYHv8G+wvbkfvISvd8gckSs7GvuNDFWdSVlzpH9heYadNel4Ha+Ln4ZI
 zKeBdCwF8//XKieAAlBbeJIypSea0xn/PCGbyFTC8X4seUUkkadnYLlRrnQK2Av1KTpxSGBZfec
 jpisSVcq6KbvcH2Ga2b4tZQ3LzXzeIvGhk5C9sIn1dB4i+jcQiNECaiJhKbBv+CcmbDJLNtgy7e
 npRt0C4j67gggOXe1PubpYXkr90RAQs1NQo8Jd1xH0xbyUdn2UNezwXEq8U+NLtrOx6fW3QYdvG
 N2cSQ6pzse0tm+L4WcPUAKqtKWXQfSGoN7SMiiS0ONCo3uXTo4VGU1
X-Received: by 2002:a05:600c:6214:b0:483:887:59b0 with SMTP id
 5b1f17b1804b1-4832022ff38mr80076665e9.35.1770444586229; 
 Fri, 06 Feb 2026 22:09:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206b8bbbsm156501755e9.3.2026.02.06.22.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 22:09:45 -0800 (PST)
Date: Fri, 6 Feb 2026 22:09:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
Message-ID: <20260206220939.5a90c67c@phoenix.local>
In-Reply-To: <20260206172054.273858-2-ktraynor@redhat.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-2-ktraynor@redhat.com>
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

On Fri,  6 Feb 2026 17:20:53 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> A busy-loop may occur when there are EPOLLERR, EPOLLHUP or
> EPOLLRDHUP epoll events for the devx interrupt fd.
> 
> This may happen if the interrupt fd is deleted, if the device
> is unbound from mlx5_core kernel driver or if the device is
> removed by the mlx5 kernel driver as part of LAG setup.
> 
> When that occurs, there is no data to be read and in the devx
> interrupt handler an EAGAIN is returned on the first call to
> devx_get_async_cmd_comp, but this is not checked.
> 
> As the interrupt is not removed or condition reset, it causes
> an interrupt processing busy-loop, which leads to the dpdk-intr
> thread going to 100% CPU.
> 
> e.g.
> epoll_wait
>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
> read(28, 0x7f1f5c7fc2f0, 40)
>    = -1 EAGAIN (Resource temporarily unavailable)
> epoll_wait
>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
> read(28, 0x7f1f5c7fc2f0, 40)
>    = -1 EAGAIN (Resource temporarily unavailable)
> 
> Add a check for an EAGAIN return from devx_get_async_cmd_comp on the
> first read. If that happens, unregister the callback to prevent looping.
> 
> Bugzilla ID: 1873
> Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

AI spotted this, I didn't...


Errors:

    Line 139: Unnecessary semicolon after closing brace

c

   };

Should be:
c

   }

    Lines 142-146: Block comment uses incorrect style Block comments in C code should use /* and */ style, not /** which is reserved for documentation comments.

c

   /**
    * no data and EAGAIN indicate there is an error or
    * disconnect state. Unregister callback to prevent
    * interrupt busy-looping.
    */

Should be:
c

   /*
    * no data and EAGAIN indicate there is an error or
    * disconnect state. Unregister callback to prevent
    * interrupt busy-looping.
    */

Warnings:

    Logic clarity: The variable data_read is set to true inside the while loop but never checked when data WAS read. Consider if data_read is the clearest way to express this condition.
