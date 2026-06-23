Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A37CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E2B5402D5;
	Tue, 23 Jun 2026 16:10:52 +0200 (CEST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id D3896402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:10:50 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-697ebe536b6so139713a12.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 07:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782223850; cv=none;
 d=google.com; s=arc-20240605;
 b=kTdIpN8rfNKM2HTLF3wkuxUv+U7UZIWfxHmSX/N4pBdWzf35r1F7CpN0L1vFEmLDa9
 ksP4U/FdJPCXf4scLrI+7RL/1Ldl2bBuie8J96s0LvrR5vRqWN9T0rmBsD5fSp01NGAA
 P6+SqYX/YpVHWwNEnrtErHBFNWjcX3DQudcX36UgOavTwot0wouMcz4fpOFq4Nj3bKmw
 lPwsJchImUk1+XD1NiSt2PzFcpWhiZ3Zxs4QjDAly4AiGLlHQ6+Doz5RvBVLTvudJ0Vh
 1OyhupcsMf0NME79oPgHAF9wOnfOY39vjsRNevkws9HJdHABeF/rGQ3lG7j/M1lggYoU
 FNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qgV6xnz2UAFHFEY//U/C9sBf+d1FO2jFIin6j7kTsvc=;
 fh=hKqwDe/gK7Ztp6zBWHlmOXruMkrf8nuiXIoCIlYJCTM=;
 b=O0RZEG2hpEaJBmAB3ZBcFnVwvfOpDGHOxNyI8XY11CkR4lQr66/PHsocMhIpr/esJG
 PZhaJjAd3MhqGI071afP5Zd8lShwWVm3zjJ5Atlss8vBFJBi1p2Ak4CCAaA7y1L137O3
 e0+13vFvFWIGjA5aem51VrShv+W0R1oHGE46M31CwIOmuHMlFhpGpm7ajpEESkz/bQlE
 oLvfB8X8pLTSmwJl74Dx+kKYbULXI3Do4gq6nEtqIZ7Q/ObJ6Hs8ktuh+ETM3EbNGcZB
 QSQ/i1P72PkYhkwVdFM0kDqOX8gSOATPmWHDmD3B58HL/1VFNn+etEqhSpt/CLSELbnB
 xFwQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782223850; x=1782828650; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qgV6xnz2UAFHFEY//U/C9sBf+d1FO2jFIin6j7kTsvc=;
 b=Ff5p27CanY959PVBj+FK5Ge5rdl4R0OmFx4ucP86jB08zv79UB/GBVL2HUfoSBrhBZ
 LmhIkNuTP7HzFjJqFcnnOIQEgDW1LGN5Se+unAAlTC/GJyEJ+6umi0I6YQhw787EiqVA
 yhXgHCu9AE56/lv8ukHygeYcVGd7b2Y/ZoJHCo/VrD1serN9KJGrW5axBmTT6b/BQiIp
 YPWDz3LraH9UKGrC4k1oCV/+UWvhcH0ooMmkJYQlP9IJdLi5+nZ6f/1Cb30kKA4u+0ud
 7xxgYyhelY4bFkaU2UgnnXyj57gF76khOluDfUGrYA2koE1xyJRsKsP0QeCWPgfScdup
 3HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782223850; x=1782828650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgV6xnz2UAFHFEY//U/C9sBf+d1FO2jFIin6j7kTsvc=;
 b=WMG2Sus1OK5rmuvIeBrxOKdh1wdSozBE2yCjCny/kvApnFm/WvzyB64KqZqB5RukOG
 o1cZBhxqBbJF0xkkOMFkJIIEyszu62MLKY9tBCCKktr5g5MaB5nuafji+tRumAFMr62j
 rBJdwBHmmQTOrLX0LLuBhdBG2e9qvmGF7nRgbKYG32vu4eJ9Cf/wS9MgD4qWx7mb75Ue
 ODgwVTZYiUlnaSsBY5EA4+HKNRWw5rxk5GMJrytrsylVRBtUtbvW0DC0rZqmkq05zvTW
 6kelGvP5e9Hq4wgwDbYtVL8cgSl5Kpp1jub5NTMJEDDzFlg3eZL4ujQdRnWSabJmvyVL
 kMiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3fN97/wfk4fZEQz1zS0QfCUbI+rhvw2Q9F8w1JXAtn6xytp5nLBFrbEB/M8yk/6F6oH0=@dpdk.org
X-Gm-Message-State: AOJu0YywvqE2iG9K2XHOnzYSZaaSC4/Nemka9k0G4UkmroHcjESWvVZO
 qz7owmtxegdTzE7Xq1zaM5Q7Tl35N/WwFBaHb8kdP6C+6ztWo1D/j4KDCLh13wbpW79WeWl/gdY
 b8A6xWDfKJs06XaNYONO14VZOXnsLAFcKrVpU
X-Gm-Gg: AfdE7cmTBzoMaBLwUtt/vdJriuHMcQxcg+ycyP4qlDR9IsAByVw0YfCmy66ox3MeFyq
 r2hkWylfrp797eUpBFTjhPYyVqeklbvniEnrJYvlCg5fNd70l0E33QD8PQ3NOT2JvSAwJwBquE7
 pTixh/Q1XYf096OcRIql94jJzZnXisiYosDCXVFXjC6G0KnEh25St9lulm+2NYXP91C0BoSBkmY
 MalWWnJEVhnkmtGkstuazH6kubuHRhkzJEMUZfchRFXAyyNpIkEDHeWZOJelLjj7MzHDHDY3gaI
 j/YuDOtCIkoNOjn+yjJZDaYvUPxZe74=
X-Received: by 2002:a05:6402:50d3:b0:697:c63a:3669 with SMTP id
 4fb4d7f45d1cf-697c63a376dmr3529692a12.23.1782223849800; Tue, 23 Jun 2026
 07:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
 <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
 <CAHfVqdWKoDqb0uD_HrF8e=GqadThPhZj0vZnRYDW=KMPei0mXQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6593A@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6593A@smartserver.smartshare.dk>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Tue, 23 Jun 2026 17:10:38 +0300
X-Gm-Features: AVVi8CeI2w9Ze9rWsAU2-AUUEMYyVIpo9k_PpUEQThW_is0ZDHx3AYTu99_L5pI
Message-ID: <CAHfVqdXW_=8Gn_hy7zYSztAngy=Un2HJ4d+8Ds-EyaqpjM=WHQ@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
Content-Type: text/plain; charset="UTF-8"
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

> > also, instead of adding cacheline for this profiling data, can we
> > share with line 1 that used solely for xstats?
>
> This profiling data is 4 indexes * 2 values * 8-byte fields, so one cache line in itself.
make sense.
btw, the default value of RTE_GRAPH_BURST_SIZE is 256, I suspect that
real applications will enforce smaller burst when pulling from input
devices (e.g. 32). Do you expect such cases to change
RTE_GRAPH_BURST_SIZE?
