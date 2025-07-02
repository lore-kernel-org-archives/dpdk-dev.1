Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6AC83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 15:02:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D64CF402A0;
	Wed,  2 Jul 2025 17:02:30 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 837A540285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 17:02:29 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6fad3400ea3so63620996d6.0
 for <dev@dpdk.org>; Wed, 02 Jul 2025 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751468549;
 x=1752073349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWYx1fpRPjW1fDIMZQWPOUtUQZiMTUNu4lmSX3PnaoE=;
 b=Wo4SL69Mklsgx41LIXPwUolxkdiO/ROl7pySu01lB8rnTDshgAc7r8tRcJk8T6SJsk
 1RvsPtuUP0YjPAWd1k/VAQe/K6Uj8/7bvHjYw+ApOA/MDJ7+il0jt0GTjmWxe6EenWe7
 uQYHWAi/kUkgIMkp5sf7+EV0oIubxzv8KFbSNYy50+go+bqyXpIHR/Uq7BbwAm7Fj66u
 W2deIAQHPF7KphN256FRuHoRLD44rHcEvnjtNaaAjw9ifIEVYGza0IJgbNYS+SJ1RFxE
 m4znrdZhxy5OhlObzYAu2PoDe7PhyfVrmsKwNYxZX4QwcZe11xK/Jmn5qiNytstEL+qz
 9H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468549; x=1752073349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWYx1fpRPjW1fDIMZQWPOUtUQZiMTUNu4lmSX3PnaoE=;
 b=DTxiyw4ijWsmymJXto6I1JgXSZdV5UveIqrtmrdvkiBVxChytYvjT43b4K0slxuWej
 JNie6U+jci7rlBU/SPYF1soenRk/WXX0AdXV2CthsV3x3XubjhvAoudsASlX2mR3fB3B
 4wELAgelc/LlfFrMAY7iU9eEdA1vcAR07wj5MHRQjdRfQh/LotPjTpRSSv6OdqGaDUGD
 s+SOoyC9MGJzJISdoINs95ycWfwlSKUFEO2etuXkZJa4hIAXOrwRt8PD8bMSDQRybYsa
 01dQw7JUr7qhd6poyBpGw5jDJRrwDLm7TlZfaxpc6xAa2SHVmNeMW50PoQ+02a68X6BY
 8x+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIR6LuIJowIdYPnMTNKmLPs1XPnwOMrP2gfRXid1rjC9Lrt+MrVbZ536oj212d5Si8N0Y=@dpdk.org
X-Gm-Message-State: AOJu0YxiIK8PsEQ9qV9kxuH63nacPJ04YrW1bUcvVy9nRKDUwm7celiK
 tTkB8zWAkNL/4kX+YzZ6q2hNzO0rInaM5cuRqdCk0IAL33Lz8A7TD9heVrhgb3RGjEs=
X-Gm-Gg: ASbGncszlckbwubrGcQe4/dDGfrCi7MSfbJpsDxzQBCjJo35fTYPLWl7VHMKuXg3foz
 rdeJY3lpUAHcfbsBkG0ucrZdhkSPJZZjc+J3DsXlk27wK+9t975C9tUH0PPUyVL0SVhKguht0XM
 gM/nnalkg6w/xNQK3MdyMuh8z5GUEHXhqeR3IjbxzPIk+QL9uUYuDJRmGJMGvDk+FuMr8DL79Bp
 WsHxDpaxJCP7fwinXYKqKTFGO7v8W+C5fAOHwSvUdlexqlwErFW34KynQlthzDHnDaYIzGZVYnG
 wFvlDKqTVVbP/RLncq0QdUZ01lUMC8zV0DNSoEIzBbjgOZNB6VMiQcD9loDYUDTYXjBL0wUwMMI
 slVySll2tIgKsPPWaUiBYWFLLMsibWlgiHd8F+KI=
X-Google-Smtp-Source: AGHT+IHDKdwmdcS1U75ets7Howlpc6fiSR88t8qWqjTAdK2FGk1vMTBOfFRpJ5VOHVnRQ7CtyZMfMQ==
X-Received: by 2002:a05:6214:5c44:b0:701:77e:5e9b with SMTP id
 6a1803df08f44-702b1c10232mr44337326d6.40.1751468548619; 
 Wed, 02 Jul 2025 08:02:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771acfe6sm101193266d6.31.2025.07.02.08.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 08:02:28 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:02:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v3 2/2] net/zxdh: add support flow director ops
Message-ID: <20250702080225.39d417bc@hermes.local>
In-Reply-To: <20250702073453.113779-3-chen.bingbin@zte.com.cn>
References: <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
 <20250702073453.113779-1-chen.bingbin@zte.com.cn>
 <20250702073453.113779-3-chen.bingbin@zte.com.cn>
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

On Wed,  2 Jul 2025 15:34:45 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN,
> and mask matching, supporting multiple actions
> include drop/count/mark/queue/rss,and vxlan decap/encap.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---
>  doc/guides/nics/features/zxdh.ini  |   16 +
>  doc/guides/nics/zxdh.rst           |    1 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.h     |    1 +
>  drivers/net/zxdh/zxdh_ethdev.c     |   27 +
>  drivers/net/zxdh/zxdh_ethdev.h     |   13 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |   10 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    1 +
>  drivers/net/zxdh/zxdh_flow.c       | 2003 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_flow.h       |  237 ++++
>  drivers/net/zxdh/zxdh_msg.c        |  263 +++-
>  drivers/net/zxdh/zxdh_msg.h        |   31 +-
>  drivers/net/zxdh/zxdh_tables.h     |   10 +-
>  13 files changed, 2539 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_flow.c
>  create mode 100644 drivers/net/zxdh/zxdh_flow.h


The 25.07 release is at rc2 so only urgent bugfixes.
Will take this early in 25.11 cycle.
