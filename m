Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC42C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 16:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FB9040E34;
	Mon,  9 Jun 2025 18:25:00 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3612C4064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 18:24:59 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d219896edeso450055385a.1
 for <dev@dpdk.org>; Mon, 09 Jun 2025 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749486298;
 x=1750091098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTvzzNCz5NkBD9Drcvf7dcjuVKyGgrch2EeEc+glZuY=;
 b=isy9lXDdHwzbx2M9LkEm7opHdLYRwjXFW8NbtSM3/5ajl2ARVvJg6DExpll6P3rOjZ
 7vYXaGylFYZ0jWRPaWv4k5QeZuI8gYMbJsfnmMWj1Dte5ARh85jlMjQQDqm+ziCai6m2
 6SyZI7cMqrJtPHFogYydrJZWmFOwdDyrsnzREqQMjAicVa7fesPQNBGwIojW1cjyOkGu
 b+bGYS9MY+rBmOxCL7tzQvK37lte3J4W5sT9EC01hAI8/pOQVF0XHL81+eoBD7T72fgg
 5+ItEUeJd2n+ZZ0XIlhYtjCnpKFZnBIgq4MNHRGB463fYfjMfoV5ZycSp4YufVeT1M/J
 BDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749486298; x=1750091098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTvzzNCz5NkBD9Drcvf7dcjuVKyGgrch2EeEc+glZuY=;
 b=SPGbl8IcrBB5wWe8DgYVgMGV1TT6t/mg+Vy8JXxBx2wwd7UdZs9PluBiIsXGJXxbxh
 K+PWHerse1AXSn+gM83v71dKQhwt6060avy2irKr02cZtm4xN02bibL8s2+gogn0+/rx
 oYk9FkEg7Uxvctcml71m4MZp78kc6RUcbl3tl+JRIGavT1UsD/X46PXTIM3aQultjLOL
 NRKMFgNKFUNlELoOg1K+tH3rELzsoHWAEuUU5QpjN4w7CDKXhVT/J3Wu16J10tItIbpY
 d0zzt8KXSKT2El2vu+PCStHJqwrzOahyjYxZy/eWA7kNwUF0wXRFEJ6h+l1CP3YoTgJO
 96Jg==
X-Gm-Message-State: AOJu0Yy/aJCn5y4ixuKYLXEJ5ZMBlfoFcWwJWbCSJF84T/G6L6JK0r52
 o16Hs9GQs2i7wxS2eyV1OFduJXtFafy7Usokc1zNADoYl/tKINWi7suaqtA4s3F+Gmc=
X-Gm-Gg: ASbGncvznPclqCWd6SnMiw+Kv/4lD2do8umU/30ZW/9FvtDqcEIIs3aeaB0S/CjZIu6
 miNIxxxufJqz4oiYC+OyReZu/Z2mLPJ6W6B9ZijS857afz4LJFY02NvOUe/nAD9d1T5O78L/wGZ
 Sxm7/EsFkRAf5I6AE7FyVSN9on4wPXEC5pclt241Qnpwx7jHpQHDM6H8cJJwFZcvnA0h9a3NiYU
 01rguTmq48jQb7SCWZJinadipaDPPhf0oke7IFVQWcjdyy7rdzp20anmVvhsB/TXQL2msFohZMZ
 ceqDGWM1t1i732I8RqJ7CO+aNeN9tRUhNt+JXpcKd3b1n4StuNv5ShKYEKbaPKpxf76XrBaqxNI
 p5sCT/xUtwYo8+J2LtoAoYp274L/2
X-Google-Smtp-Source: AGHT+IFq908BMVtvs4IRb8W22rcJMzf1nPjMWh2E4v3ilAZ8rCh0QL6MJFzocsnAkL39k2oCZ7NrlA==
X-Received: by 2002:a05:620a:40cc:b0:7c9:5eca:ea3b with SMTP id
 af79cd13be357-7d229887d10mr2114971885a.31.1749486298332; 
 Mon, 09 Jun 2025 09:24:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09adc0d9sm53416016d6.52.2025.06.09.09.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:24:58 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:24:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250609092455.241e4273@hermes.local>
In-Reply-To: <DM8PR02MB8171CB561807D476C05E013DE96BA@DM8PR02MB8171.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
 <20250608153439.322f6c88@hermes.local>
 <DM8PR02MB8171CB561807D476C05E013DE96BA@DM8PR02MB8171.namprd02.prod.outlook.com>
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

On Mon, 9 Jun 2025 15:51:03 +0000
Dylan Schneider <schneide@qti.qualcomm.com> wrote:

> In this case, is it best to just pass 1 with a comment saying that is DLT_EN10MB? Or is there a way we can get it defined in all configs?

Just add a dependency on libpcap like other places do (see pcap PMD)
