Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1609FCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5DB4065B;
	Wed,  3 Jun 2026 17:51:30 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 2E12B40651
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:51:29 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137ec563a95so3697120c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780501888;
 x=1781106688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emJ/e9j1VfFKkqqiJ1jhPUBKlIVDJu/II+Jmb+r6Srk=;
 b=FNewBiiah3Tktc2x7L79rTUHl8qYh0wVzKYGov9tqBG4eWuUQQ/gg8xeWA7XG89Bdj
 yhYUbP1pU7RtvdLQivJizET5nBvtsIprlo36YWfj5x5DrbGLmuLJKPuDWq/N7K9UzH0a
 wAlPIawNjLg/I6Sxo0lK3m3ZV/7jDNgeZDgnHiCoj9TulUm7gDhRsbtCIEJ+oo2FDVjT
 QnfHucZd3YOQBIWCBfapDjFa7vexFBaC4c78oIOKMp76EsagIEKFphNOTGduZ35efU8O
 BHsp1NTFIPFI66AEygtMWlSreYhJkzUMrnQPEmxupZK3S3ZMsG26Y0siHzxJxy9Df+mY
 RCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501888; x=1781106688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=emJ/e9j1VfFKkqqiJ1jhPUBKlIVDJu/II+Jmb+r6Srk=;
 b=TpFQeXFPbskKTsDJfRM4eoujhUKsdaePtkxVtHIYYN/U8AZX9+38Qg1kSC8yWBr5dd
 I56AgacAp17H6SP8yKmage/lKqtgq3WWo57UhZmlAwnZI9vO/OCBqzq6pC+p0cq/P+UC
 UvnFPyr1UUsxuArf22CXtievnsutEEgQRenajaO0OyQAU7qXAPzc9mwHdQRU7VzBpYek
 5QSztIHfssE3Y2Ii897/qVwy6FEZ+s26vRrM5W5E9tNcBdp9W5aki93EFkC7m0vFCw3k
 1gPO04rYm2ahV4YOb4D0PwiVwdtxIZv2lBWQsdFisHVM3WZwKlZAKbPtMFrXEw8zJA6v
 QoLA==
X-Gm-Message-State: AOJu0Yw3HibQsSWG/DcTk/tBs6bJu6aBEfoL9us5pQ4TglHJdYa+Yh6N
 QnfccUfxG102oAQwZ9YE+L/SG5t2Ao6dKOPkgw0w5kh6Tn6wwtqCwaE1donkEsgW2+I=
X-Gm-Gg: Acq92OF3ltMiO3GHMzuduaMyT43An/+9XvCD6hXUZi6NQBwm3oF3liix+N1xQPU9K7j
 vxXUNwyQzTw2loIImRVDlyTmM7bVggIU2JEwMxTTb9nKozI/fAMB/nFdURP15JpFpnDKK4NYC//
 NwCaTHR8RMvKVIMNBYdrx0mFMh7+/ikeMcWfdsO0Fn6OpDc5yq8lLabXGurl817JO0GW5wB2a7B
 ZOiddOKRmtVSqJSt62bAah/PnrdjfGgJYddbuU3YwW5ekAyV8Crq53iKm0Vk/7JhFySB6ZNIW2X
 4my0P89qmrjRfBJ8WtZn3TZFtowB7JgdJdGGYV/fOXmchO0GWVJ0bwLCHepnKkqgiMXFHbvlrli
 6tDiFyr4Uag9hlpfAnnxYPQwYTtVGgaFtZjtuJ73iS89IAR37Ns/0sLtbpCrOEHmJTGfiwO8HfV
 +tvj3z1HT8YJ6WFmf1VvMegKvRBw6VQLwr1J8rdxp/RdjcVchuV8W4e3oI3sFkGzSENvff1Cwx3
 HQ=
X-Received: by 2002:a05:7300:3213:b0:304:8364:e95c with SMTP id
 5a478bee46e88-3074fa92c24mr2119516eec.15.1780501888216; 
 Wed, 03 Jun 2026 08:51:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm3712407eec.11.2026.06.03.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:51:27 -0700 (PDT)
Date: Wed, 3 Jun 2026 08:31:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] net/ark: fix null dereference on allocation failure
Message-ID: <20260603082738.1d94ed4d@phoenix.local>
In-Reply-To: <20260603052207.118688-1-denserg.edu@gmail.com>
References: <20260603052207.118688-1-denserg.edu@gmail.com>
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

On Wed,  3 Jun 2026 08:21:54 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> +		if (eth_dev->data->dev_private == NULL) {
> +			ARK_PMD_LOG(ERR,
> +				    "Memory allocation for dev_private failed!"
> +				    " Exiting.\n");

Do not split error messages across lines. And no need for ! and the Exiting part.
