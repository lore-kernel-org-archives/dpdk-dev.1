Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2163C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2825F402CC;
	Tue, 22 Jul 2025 05:51:02 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id A755C402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:51:00 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d45f5fde50so445206385a.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156260;
 x=1753761060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcxMRvP0xlEYro6OIChUYoUTaBal6/mLv0K99QmGr0A=;
 b=m5BWStZBd3Zob686BF2OQ7cskWcNTzbHAci1LWviu3zcJrpGjGeNbogKMcN4uJoNIS
 CoZr2v1zhiBsNWooi/Jv0/Doq0Tzfd7Z8MKhGZoUS4ZMMRPJqbrg19jfldf8nEVR8KDD
 AiD9K8oiJK4Pcav/vei6UGlIVAPW3qQwUEuJlQrZwHcrwsbY4pnCJvdlw6lvPenRreeV
 5Z1NIYurvTAe7/yLvJV5flLu+kJRrqLFsegsUHTdWbFbFLHwR5I+ofpLczSpqT7UocBh
 DMunY7u2LOJsbMLKFQXlUmL7rt9S+9L4l5PVgK+B/AVn0K8sdTm0LnDXXC2+dhow2Pb+
 zBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156260; x=1753761060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcxMRvP0xlEYro6OIChUYoUTaBal6/mLv0K99QmGr0A=;
 b=DQxfei6gnurjwu+svIFBQXCLz/TDxkceNCiu9pF+SarBOtnw4bSgphPhMIdkXboSWP
 SysHhCmppHFfb6FYHefJpfvG3/Q09JuDU56jpaAIHnbXtdM4MIbAWpklkn976QQ9rYUx
 YTT/NlQTw0a6qyizR8auJFwOquw+Fxr8NuYUwRBYi7LjYGHBqWoOHM+9H4Ox7NaVZIMN
 JZ0Y4WAfN2xN9ub3D13UH5dX1Q7xUJYR5tMx7mMbfkC2J9iE7R2WsAWMfQnG6bTlJV7U
 VSkhNKuOmU+JnHDE+iWHh/XmMR2brAYGmORkezH1R503O627k3OjiTUGs61+XffheuFM
 +tVA==
X-Gm-Message-State: AOJu0Yz+YoQfCNYSf5puLEYic2+4zKwHHRFMlhpnzZVCEFGApavXJocA
 CSBPbe0iYOutz5DsXDtOcX91zkfWI9EgeDOEZIwbqy5vps824hCxI2RtW59C+myreEw=
X-Gm-Gg: ASbGncuLg+4D5O+D8+MK+FWX3jb+vEWZwEPIg0JIDWVVHTWekha//nIX16LnbRf/Qsx
 J7gGQEAX5wH1Jt8PrgUYMrdERQbSg7OpkTQ5kFi52f+8+LP8vJ22R3Rr6LBN9ozMJI6LrRIash0
 FZtmi53xf2dY7d2JtlFQIvP3vMjC5tY5/gMrEsdeXs4xJDd5FuH7PB1DOY/t2fm6XDwIBjJfoSS
 VHWKUBXZfDaofrDDb/ena7nbcngHrQ0ImHWf2vtOfVl2x65QDPrgiNSlFflEqBDU2127fEwOdsN
 oHx+0y9sHtXihpt8V0eKy/FDX4rHscK0QgVgKct0cR7eblgsbYhCisWM81dxmyJsdkb4UKCcRlW
 mwSVpNwTbM2YC4pgkebCVNIWPEpmC2FeUaWa9tO7K/Je1OXEziLSwAdxlYcG1LgJYkvXH1lyN5p
 o=
X-Google-Smtp-Source: AGHT+IFkb0BHzBFFfsHiqD/HqJ7fzn6OblGM4bWr4YjM/QTIQnjKzr5j7snJXZAWC0LaW+MR3ignfQ==
X-Received: by 2002:a05:6214:4587:b0:702:d3c8:5c88 with SMTP id
 6a1803df08f44-704f4826657mr372636066d6.17.1753156259977; 
 Mon, 21 Jul 2025 20:50:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bab471esm46304146d6.105.2025.07.21.20.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:50:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:50:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/3] common/sfc_efx/base: fix compiler warnings in X4
 netport API
Message-ID: <20250721205057.3648cf86@hermes.local>
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
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

On Fri, 11 Jul 2025 18:43:46 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
> This series is a follow-up to [1] to fix compiler warnings in the base
> driver that are seen in Windows driver build, also based on this driver.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=35095
> 
> Ivan Malov (3):
>   common/sfc_efx/base: fix compiler warnings in statistic code
>   common/sfc_efx/base: fix compiler warnings in PHY link setup
>   common/sfc_efx/base: fix compiler warning in PHY link getter
> 
>  drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
>  drivers/common/sfc_efx/base/medford4_phy.c | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> -- 
Queued to next-net for 25.11
