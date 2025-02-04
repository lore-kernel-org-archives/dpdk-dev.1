Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0896C02192
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 02:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91C9240289;
	Tue,  4 Feb 2025 03:35:06 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 78D454003C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 03:35:05 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f9bac7699aso586788a91.1
 for <dev@dpdk.org>; Mon, 03 Feb 2025 18:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738636504;
 x=1739241304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bN2LuwO8po13zDi3mKOJhp2WvzfLQdu/60WtcacbRW4=;
 b=d1DAQCJq9akifFgRJWiWIM5aEZUt2Ln8JiY93dQnJIEcQTGE3SOhZCZOlYcHwHdUCK
 rURrop+P64sj2ak2H2MJz4ieTW6Q77Mp0Wd8ZbuTL1zQ/YUB+u1JOvy3KWnWgtbRQAb0
 EcRwwL86NwG6H16RztpEhVtnkX1DAaDz/VxRpnHJwPl33fL055gPjpzAgM7cp1CQ96Mk
 i68xZsCWhzwaRl7DnjR5CPGn5r9DA6lZ6j5pJpAP41Syjn0xjUth7Nrc8xdu8mT0L7Ja
 SzB8fiM4FD/KfvMWHx+mSA8rn68ACIKEipB+kXKIgRhcWnvDYMCCGRGq0WZtVRD6NYst
 LvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738636504; x=1739241304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bN2LuwO8po13zDi3mKOJhp2WvzfLQdu/60WtcacbRW4=;
 b=vsPxclmbW0Ivss+4kI+apoye193/CzjWWk8gmeJOQZfntZbOhX0f7hsBOLjfGu/64/
 5W9WV0emMdavgxhbQmzBC9sKBuxikgQKe28tjPihS0dZtyIrNfRiIUIFNnG+zIQ3I5rL
 8bTiz4Up3vk/UR6CaDxALv+hC9ddPLLQUkYh8rCjgMA2hoHdPROvQPIbhL1/gkkIwhAg
 +QHuSJ1YsbZBPkjtjR/btQzwai+yap7gZPa83sd8U3apQDvtisH21xPjXlt3ltNimacN
 PlX/j4upMZBHMQe3D3Oy9EkgLf0KL0UxACQo2WPXLbKr9P1UNVhcZCwUEirtDD1VkxY4
 aCuA==
X-Gm-Message-State: AOJu0YyHp6dW7eCcby61IigtXoDON7+N8omgxqnDnyFcg774/f3cVvxP
 UUKGST68jeS7I1L6gRsyYtPgr2RjgcDOJ88JgLOAUlr7nMK6NKOPyDX7ChHsPd4=
X-Gm-Gg: ASbGncuQ1Nzz8kU/k5BYb+cv8kjohu+RSAsmxMMr6v9+cOky8GHRtfAlYJLuNmQ0+WM
 etqRxjTIoiw0JJYdHb2PnRTtxIrW/kwsT839xNXJMZ9om1BNkOBmxG0dzUXIS/Ghj1qXsM3Bo8e
 90XRuaHD9HWSX8whZ8ypadaUfZVFsi9t0gbLdM3IGBM1qxsD/XyjDD1P2onwuv2b0wbhuMbrzbs
 UUDTVrqIbRWvPJwhYprty5XrHjnK6nzienBxXlKh8o7w25VX4BYAFbOzEyROxvMYygcJjw4A/Ep
 NsP7bVuznzTJpcGGf3wFcjssArJLjFkRfSdDlio31B5jY2CkW5L4E/UnDWAAe79rQlZh
X-Google-Smtp-Source: AGHT+IFKdQXVpJbW3UiPQwwofS33gkYiOCfbm/EkiWmVYqtoLu6kIIhf93ZxVymZHJW4N8yf/V7d8g==
X-Received: by 2002:a17:90a:fd97:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-2f83abfedeemr39757996a91.17.1738636504071; 
 Mon, 03 Feb 2025 18:35:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f83bf93b10sm12089446a91.34.2025.02.03.18.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:35:03 -0800 (PST)
Date: Mon, 3 Feb 2025 18:35:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 03/15] net/zxdh: port tables init implementations
Message-ID: <20250203183500.073abb2e@hermes.local>
In-Reply-To: <20250121034433.3033681-4-wang.junlong1@zte.com.cn>
References: <20241210055333.782901-2-wang.junlong1@zte.com.cn>
 <20250121034433.3033681-1-wang.junlong1@zte.com.cn>
 <20250121034433.3033681-4-wang.junlong1@zte.com.cn>
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

On Tue, 21 Jan 2025 11:44:21 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> insert port tables in host.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---
>  drivers/net/zxdh/meson.build   |   1 +
>  drivers/net/zxdh/zxdh_ethdev.c |  24 ++
>  drivers/net/zxdh/zxdh_msg.c    |  65 ++++
>  drivers/net/zxdh/zxdh_msg.h    |  72 ++++
>  drivers/net/zxdh/zxdh_np.c     | 648 ++++++++++++++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_np.h     | 210 +++++++++++
>  drivers/net/zxdh/zxdh_pci.h    |   2 +
>  drivers/net/zxdh/zxdh_tables.c | 105 ++++++
>  drivers/net/zxdh/zxdh_tables.h | 148 ++++++++
>  9 files changed, 1274 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/zxdh/zxdh_tables.c
>  create mode 100644 drivers/net/zxdh/zxdh_tables.h


This patch won't build if RTE_ASSERT's are enabled.

 $ CC=clang meson setup -Dc_args='-DRTE_ENABLE_ASSERT' build

 $ ninja -C build

../drivers/net/zxdh/zxdh_msg.c:1094:33: error: use of undeclared identifier 'zxdh_msg_reply_info'; did you mean 'zxdh_msg_chan_init'?
 1094 |                 RTE_ASSERT(reply_len < sizeof(zxdh_msg_reply_info));
      |                                               ^~~~~~~~~~~~~~~~~~~
      |                                               zxdh_msg_chan_init
../lib/eal/include/rte_debug.h:47:36: note: expanded from macro 'RTE_ASSERT'
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                                    ^
../lib/eal/include/rte_debug.h:52:17: note: expanded from macro 'RTE_VERIFY'
   52 |         if (unlikely(!(exp)))                                                           \
      |                        ^
../lib/eal/include/rte_branch_prediction.h:43:41: note: expanded from macro 'unlikely'
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../drivers/net/zxdh/zxdh_msg.c:285:1: note: 'zxdh_msg_chan_init' declared here
  285 | zxdh_msg_chan_init(void)
      | ^
../drivers/net/zxdh/zxdh_msg.c:1094:32: warning: invalid application of 'sizeof' to a function type [-Wpointer-arith]
 1094 |                 RTE_ASSERT(reply_len < sizeof(zxdh_msg_reply_info));
      |                                              ^~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_debug.h:47:36: note: expanded from macro 'RTE_ASSERT'
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                                    ^~~
../lib/eal/include/rte_debug.h:52:17: note: expanded from macro 'RTE_VERIFY'
   52 |         if (unlikely(!(exp)))                                                           \
      |                        ^~~
../lib/eal/include/rte_branch_prediction.h:43:41: note: expanded from macro 'unlikely'
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../drivers/net/zxdh/zxdh_msg.c:1146:33: error: use of undeclared identifier 'zxdh_msg_reply_info'; did you mean 'zxdh_msg_chan_init'?
 1146 |                 RTE_ASSERT(reply_len < sizeof(zxdh_msg_reply_info));
      |                                               ^~~~~~~~~~~~~~~~~~~
      |                                               zxdh_msg_chan_init
../lib/eal/include/rte_debug.h:47:36: note: expanded from macro 'RTE_ASSERT'
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                                    ^
../lib/eal/include/rte_debug.h:52:17: note: expanded from macro 'RTE_VERIFY'
   52 |         if (unlikely(!(exp)))                                                           \
      |                        ^
../lib/eal/include/rte_branch_prediction.h:43:41: note: expanded from macro 'unlikely'
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
../drivers/net/zxdh/zxdh_msg.c:285:1: note: 'zxdh_msg_chan_init' declared here
  285 | zxdh_msg_chan_init(void)
      | ^
../drivers/net/zxdh/zxdh_msg.c:1146:32: warning: invalid application of 'sizeof' to a function type [-Wpointer-arith]
 1146 |                 RTE_ASSERT(reply_len < sizeof(zxdh_msg_reply_info));
      |                                              ^~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_debug.h:47:36: note: expanded from macro 'RTE_ASSERT'
   47 | #define RTE_ASSERT(exp) RTE_VERIFY(exp)
      |                                    ^~~
../lib/eal/include/rte_debug.h:52:17: note: expanded from macro 'RTE_VERIFY'
   52 |         if (unlikely(!(exp)))                                                           \
      |                        ^~~
../lib/eal/include/rte_branch_prediction.h:43:41: note: expanded from macro 'unlikely'
   43 | #define unlikely(x)     __builtin_expect(!!(x), 0)
      |                                             ^
