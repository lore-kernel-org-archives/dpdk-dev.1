Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BAACC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 23:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B01740291;
	Fri, 16 Oct 2026 01:26:11 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 421C640041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 01:26:10 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1418773a91.2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792106769;
 x=1792711569; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YN/5xXgSMcE5TDNmz0MwnPtycv+rHWarA2h05tG4ux8=;
 b=zwRIRn/6/vXCgv5ZQq1NLftBINKknFuBjNssvtzzzDWZIleo1JHsy6B2k1p+pE0fjf
 6SxFDaRJ8np9e0XfBFerbDQfHS44iezhbxsUeNqbwQoubFINPBWSn0d9WWr1uSYcr3Hl
 c5JkZOKfMc5naFW/mJujTmOGHbBCdgNwXsofo2w1ft8zF7pPty1K7SC343OMHy0nvBQW
 8FeaAGi21nzAP2Ydn1d3Wr5fI8cAF+Is6Q3jwU5WHkbgnIVKaKSwBn4c6yuDB19WsCGg
 xqDklnRf5Rfr1Vt+KGoNJtSAaUuHN2IO0OHW3ZEysX532LqTpyIZN3/vniM1H70bRV9x
 2bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792106769; x=1792711569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YN/5xXgSMcE5TDNmz0MwnPtycv+rHWarA2h05tG4ux8=;
 b=ej6ADEoRzpOh4UvD+eC8iAn9t4kikEBLoZ2EdUjzDTD2mvWwPVtxRxZhSgbh3efPUZ
 r3xvorxrbGztOiafoPw3o9tErHpeOwwrVK3bSFAkeBMVYkE2giveO/gzqoSK10cWgrL0
 r+RmqMPfwRm2uc+DNsjlEqKMvGIyl2MSykFzVijWGaaoeQTCNuhzLQDheNQwdrWXZWuf
 MlCudzP55jBI19ZmAQj0AW3qZu/iMgUmP7A8/OKCkXbW5NLW7+J+vHpzfoIi/WRZkbh6
 b7pdDOXCuTA8zuKJyru0+g1+Du4p37pguricL3oCt04d4SFy4qbH6prDWzswxaC5TM/Y
 JK8w==
X-Gm-Message-State: AFq9FYKxqQ/hAkyphp9OjE0MWCGFMUlL5GcbpCto/0gW3biPVeA00Cj6
 Oqx24fcrHcXSWnFqr7AsQBtHxxM2OArBXW2bfUk7oCk3xRVn3cgREKdT2Lxebp1QbnQ=
X-Gm-Gg: AYBFou2xpCSiosQoYlV4JrIRZcrVhBEvNjcvkDG9GU7/sOL9vCdjvAmW77uZcMuwKMd
 FLNjAil3mS3jwq0Y2IUgP0mQTvppkc27I/loJcyXhAQLd/YoFHKnkZ804YPQyf4WfPf01ExLIWn
 2RZaGmN9UYTDbnv7Rm9c7s7R+eSZkTsO+K7xDuZyJ0Xt2lNQeHAeUa+AGlAkpLidQ9poGcf+TjY
 zpJMhnOemKmXDywrPgtMrA2NGCJbIwvwWXoSe+OD6Nv6X5ukhlyRzkDMQv2FiivyMooppnhpwA5
 U2FqoAwHxS2Ff2OJW2bU/cspLtg4NuR8EB+g6J1VCgPYCKDB7rYwWHtQGWqdmvl7iN0DQBmUntV
 wyI2b2n9UXkfrh0jOTJedTuJzKjwX8JS6tkKhxCqWGRTP5EmyJ6ifQnLp16YXepZGJsA4xC4nLM
 4pOQoqyVqvTrOj6jOlRY59r9U0HUEgaa28ygGz2tx+xjSkTuSuHfL2e4R022AHAOvAT3wVGu7Ty
 lkSrFbyZ0as1EfnQKpeNFt0UhyANKlCHPA6qAmP
X-Received: by 2002:a17:90a:10cf:b0:3ab:9c73:12f with SMTP id
 98e67ed59e1d1-3ab9c73097dmr9939364a91.24.1792106769042; 
 Thu, 15 Oct 2026 16:26:09 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm6287069a91.0.2026.10.15.16.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 16:26:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:26:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11-S2 00/11] net/dpaa2 updates
Message-ID: <20261015162605.1c0b93fc@phoenix.local>
In-Reply-To: <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
References: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
 <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
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

On Thu, 15 Oct 2026 14:55:02 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> Changes in v11:
> - Fix fragmented packet type handling to match hardware parser
>   summary reporting.
> - Address review comments.
> 
> Series overview:
> - fix an integer overflow in the CCSR region mapping,
> - set Tx confirmation on device init and support a larger burst size,
> - support MPLS and PPPoE flow distribution,
> - support the flow drop action and a per-device default flow miss action,
> - identify Rx mbuf hash information by FLC and add minimum key size
>   support,
> - parse tunnel and fragmented packet types,
> - remove the unused soft parser driver and rename Rx queue flags.

Applied to next-net
