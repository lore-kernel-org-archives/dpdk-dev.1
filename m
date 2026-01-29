Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA2D73E84
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3421F40274;
	Thu, 29 Jan 2026 21:17:34 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 7AFCD4014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:17:32 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso8425335e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769717852;
 x=1770322652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFZ0GFeFRsfUa7PBcLkbnFOY/nzYxFQHlL98HWXL3NA=;
 b=FNp9PG/elnE+MNjbGQfLEwd6YT5FOySds7GkL55FpPTI8Q1MAcXt6P0XSkHaHDPytE
 wnPM+z1TD3s03IThkkugzQjU/vFy+lT6AdSEjcJqDo2BgEKRDP+A3Ql1OBWR7qy1Bak4
 YJMqiV1sH3KLMIs+GcjIVQx9sqx2YTFTdRowto/KSjZUfCeCD5FFy50Nq+rZKVYdZnLb
 snQKPJh3vqmjj8kQpblnUs7tlKbs/l9RcncpMiaRrJcj3DGWw3xuOuWPArsg1yD2QYtO
 10rHInz9pUMEZvO6h87mFvqottDDoRYVKrEAlpFJp+wCZHfdW7dazNnYAAslDXmNtzit
 XS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769717852; x=1770322652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFZ0GFeFRsfUa7PBcLkbnFOY/nzYxFQHlL98HWXL3NA=;
 b=DaVT562guDrItskBKEB5Aqlh4LOOmu++tpzMjg1cruAfei/we2LW68JC6WXPKz5+nn
 3p4gsw0nygpVy0tI/GLK4ChV86vA+G6Ts2ZgJo8WXOPw0cvGIhhZc9F7zDxHOi9tfMdl
 DsrIIV54OnFWMJJqVrt4uq+xYzAZi84nVfLE0O00A8yLK5UXbMaIfdVqvprswP4Xpw70
 6Aocw7bBOjfGkrO1vfxk6/j9f0vD8dnkmRr0E+fl5myMBD2tUeyNUPKoc1TTEjS46O6P
 Nbq04py02Xw3EF4tUgFsZtoEtJtXPYL+5HsYR0fn2lSQfRcf3gO5vy7f/hCA13ocNV7A
 qrKA==
X-Gm-Message-State: AOJu0YzCYrtzGwGxu0bLNyGjyUMrX6F7g9R9u9WluydSyWD18CLbq0uS
 v+z1qntz0dQZBK/R8XFIKl4Zp+/s/bwKlngMBTSEWEXuQlGN+dlVYAPKEbwS/Y674A4=
X-Gm-Gg: AZuq6aLGmswDnEbkCfaRd8X7XH2GGNhfOauaUTnWtGUyqsnMqgKBOWbO2WsaWpRQKrf
 kI4LWajqb0tSL3rtDVqmvMMZRDNyqW5Fc6LMpWxRAm0dhmTIdaYIBXsQORhCEebNJy56CEDOEUF
 rwV8OioUxhPBIZLKSsQV2wBNK/55GTCaEWOoOO8Duhfotq/NDfO5t4QdeXKUujhxQZ9VHyunqhR
 ZADWMYmAjrLZIrGf/0iKL/ZbiMjogjSlvvH/P2nOEz8PYQontbsa0BLWX1aIZgMZwCPPVht3L+B
 qshs7xw88QhgnU8QnljKiyuUrGUjPGqo5WI9S4sHN41DSDwTrUPGLHwUptdTZoSbvl7yrJpaQtw
 ChJJ8bvRWGUAH84+NtRPEaKTTaXdRz0Z/20bJE+AWyUSLd6aIqp4+0/efM/+fPlFgXcibVl92l6
 VxNfu9MtK6oUaoEeupkGeArBk5hd1FWeoPheVt6BxGXDOFrB4qiFTF
X-Received: by 2002:a05:600c:1e24:b0:480:6a46:3616 with SMTP id
 5b1f17b1804b1-482db448890mr4697815e9.4.1769717852074; 
 Thu, 29 Jan 2026 12:17:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm16406858f8f.6.2026.01.29.12.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:17:31 -0800 (PST)
Date: Thu, 29 Jan 2026 12:17:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhanibek Bakin <zhanibek.bakin@gmail.com>
Cc: dev@dpdk.org, mtetsuyah@gmail.com, stable@dpdk.org
Subject: Re: [PATCH] net/null: fix Tx statistics accumulation
Message-ID: <20260129121727.23c60947@phoenix.local>
In-Reply-To: <20260129090312.98636-1-zhanibek.bakin@gmail.com>
References: <20260129090312.98636-1-zhanibek.bakin@gmail.com>
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

On Thu, 29 Jan 2026 14:03:12 +0500
Zhanibek Bakin <zhanibek.bakin@gmail.com> wrote:

> The eth_stats_get() function incorrectly uses assignment (=) instead
> of accumulation (+=) for opackets and obytes in the TX queue loop.
> This causes only the last TX queue's statistics to be reported,
> while the RX side correctly uses +=.
> 
> Fixes: 31326ce7f151 ("net/null: count all queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhanibek Bakin <zhanibek.bakin@gmail.com>
> ---
> v2: Fixed Fixes tag to use 12-character hash
> ---

Looks good, queued to next-net.
