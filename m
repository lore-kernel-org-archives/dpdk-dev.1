Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195AF53D65
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637474025E;
	Mon, 16 Mar 2026 16:20:59 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id B3F3A400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:20:58 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-829759ca646so2867519b3a.2
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773674458;
 x=1774279258; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+s8uhpBExT8r8+d2XwEwuO6Yd4vAPQJvUiOTahWbys=;
 b=HpZ+3fPELttTIiK0d8tL1uG7NCkUQbd7KCF8/Ns8nq+eZLCWDZGXozTYKCwMHCaOUo
 wVagZcZI+uthTumOTzbM/dSoTufNBlcGmzUX8A8V5bqxO5WVrKbvjtA+g/Eh1iwbbg3f
 nf4xl+jdylIOgv0AGtwhMbTD/K4uvtyyp1dJPAy8/sZ5JgFoMgsgcNQjfEsIqxlQm/tp
 JgterL783ygrggk44R/BkJu7UlfOpXw8S8NmxxrTjHLnmMLHHz+4sCUKD1OtdEaABq0Z
 837ggvv8nlKPgv8WvJahkhFEJriSGhCLahqmYEtYmMxFjAEJMew/TuvmyaqGjON9uj7f
 F1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674458; x=1774279258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C+s8uhpBExT8r8+d2XwEwuO6Yd4vAPQJvUiOTahWbys=;
 b=K+afW5nD0NOsUkYfQhhlsiJkCw1hf5monGByoFgzlvkPpGNf5zgc/LAlCIZreq/02b
 X9N1bDl+CsLlUA5KePJ1jtDsferz6LQJH8Cc101KnF+fTrANZ64f1KKONweuA9eJk1Ls
 mMXKrkWsep97A2I99zyHsvj6WPWIrey4kVEsufOcG9Rkg70FTFpJ7acl51IUrNEdDGXD
 wOoibVATDdCgVWjw4nrsVYbEGaiXtM9MSTb47gkesLgo7OKQqFROjqbXdpSXprT15AeG
 9lfkY/e0clZu2Nw8c5zSfJAqF0pF0hFNoWbKquzEgkDCGJwERz1oPBQOpyQrjCAEvsBm
 GuSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3mDIZ8h22ND01ps6Q+kybKC5QyQlEKABQBbDzwTUWa2FEqKK9mDcjNLvuQHtjWhkUkM=@dpdk.org
X-Gm-Message-State: AOJu0Yw+6MyKcz9wBwwe/R/PKcxag0at2wV6kuglet7e4lqpT5xn8DYM
 nsHrcHKFLYtjEcBMKbYYYq3cEQIomxfLW1SYdjE2IDxguH/Cxnihzd+5KxSLW1zKkpE=
X-Gm-Gg: ATEYQzz7TViWqAu2lgA03B2xbLaVRdnoe9SO3WgjdGp1lmb1SsQ4hFn8kM29kwp1CuF
 xU65jqmUnHtNZs/TdxQghNL3Hqjp8HFwk1TX3+Y+HROVDI7RE+WFusUTw9FWvUArhZtqpivGhYu
 tljQgU0zj/sLDSNnl5a0t6HqI3ZvpIom+dXhn/Y8fdHkywLZzr0IGQESI4CpVkrDSTXkezzAcgD
 FzU4G1tsa9sCVs4N0DVuLJsyMX6PNAQHbI2KNkLB5ve52jEHVGehFgQBydVKdjnQpyQ8G6SJjKP
 LhTJgLFj1JtsnjLv4tRhJCAWsNQ3z6ZTgG4kwOZa5Y6kDtNbd3tHonCy9Gr9SUANHO4tbv0RfIH
 LWFs9o9Pbn4cWUYkOKTpMcn9fCSLaLkhItc58+j3Axnjwt0CvBj2yAWRRsDEpyAbS8skg62dhIQ
 BAlIvR12G14nUS8natc75CyPlZQeKX2Yf5cun6hWiG/BO2mA==
X-Received: by 2002:aa7:9062:0:b0:827:26e7:5c34 with SMTP id
 d2e1a72fcca58-82a1991fa7bmr12049838b3a.61.1773674457792; 
 Mon, 16 Mar 2026 08:20:57 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a07370353sm17008518b3a.51.2026.03.16.08.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:20:57 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:20:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Pawel Wodkowski <pawelwod@gmail.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, Jerin
 Jacob <jerinj@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix
 timer stats display with lock contention
Message-ID: <20260316082047.3ac04bc0@phoenix.local>
In-Reply-To: <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
 <20260302061805.1666176-1-rkudurumalla@marvell.com>
 <20260302074804.40042d55@phoenix.local>
 <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
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

On Mon, 16 Mar 2026 13:36:30 +0000
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

> Hi @Stephen Hemminger,
> 
> Yes, you're correct that the architecture looks unusual. But since the primary goal here is to stress-test the stats/timer subsystem under contention rather than packet forwarding, I believe the current structure serves its purpose well.


But it also exposes lots of issues. I would argue that if it is a stress test it should be in tests/
not examples. Examples are intended as guidance for how users should use the API.

This is not the example that we should guide users towards.
