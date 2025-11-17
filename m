Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C380CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:59:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E0C7402C6;
	Mon, 17 Nov 2025 18:59:51 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5E19C402A7
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:59:50 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-bd1b0e2c1eeso843644a12.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402389;
 x=1764007189; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKNqqnun4uR8VnkiouUtxTDjx7+/oNMAUs2FVi2Bwng=;
 b=YDzh6bCgr+G7r87WWo8mTeKPjN9Vstrf9YcECvbQ5/Htr4cDnU7bJ9A+WMb3CTM1Pg
 /Z+EW334WspKVEYHLF1M4TVUUBq909d/PsD+tym7DVR0M02K0wKTYxFzpcq4bsb15RzV
 339cBy24nhoRCBlqnv/9atg2lAhWOHg6bR2FfizGYpWY9ilc02oHP5ShGM1SjuFZseYW
 LhmI/aGE7yZsVW/ee0YU57S1s0mwP+xRShaGnC+/tRTKRPmqqNPEcd2hHzqdZnZuSeOw
 3BgtvIohQt2GkEX+ESJChrDgaWMco0Zis6+KiMzSrVuNCPzYwspWnEEkJFBVO+Px3ORp
 6L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402389; x=1764007189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZKNqqnun4uR8VnkiouUtxTDjx7+/oNMAUs2FVi2Bwng=;
 b=XUE22BAe6mnxEIpQyVFrJNaFcSAhMOaENZWyYLUS7VnuB7/XpAfVo99xoJYf0uYK/u
 RRd5gfC7QxFbO4T6OYh0UicEH5PwUWfDQfwVm3h5q++NJCVZidASxSO8HPx2WhzSPYBJ
 ARqJvNxYRVlv1aRC1VqJEKGY0yyFX2L5VTckV5hwH0iCr2pM6KkficTMO1ubsZ41EoOm
 BR5EkxgxP1/8fdhet/zZ1UAyk8iK+mk36IQqnUHZXdgjXOvyhn68pVPIQtt2d7aDQZ5W
 ookJtGdZCTXsrVcp7YJSDF+YOKw0QNRvhNn2cWd3Gq/73k1T3G2jEyFUx+RLe9pD79OW
 j62w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4WjZJppBqIH0UhqghTln8buEBva9lflvOZDCv1nejmCVxdAb2lynahy6iZ0LAOviiz50=@dpdk.org
X-Gm-Message-State: AOJu0YynheZehM/XuNzXO49chYhC1WwP9hs6CMcqf7jLhKI8ImWOIU+M
 +bGu/nBAQYEamgcUK4jqz6slLV5URKPl/a8CNpdQN//0/tAu14bFy2WsnvihlAWm4Ag=
X-Gm-Gg: ASbGncuEpG0GBoHraXze7fjA6wlyW3ySZ09AhyJ+k6T5sNxWrMLYnSGxPZwIgKQ4A1T
 mc0E/omtKiEtJ7NJcxVrclR8i0e+JvMUDpnWC1xm22+HnjsP/hB1JRW2roKeM15sUOQuUn3xapJ
 KbVJSqXgqWtFSCW/ABNAJncl91McXedjMHby8qqrv1Z1lgUrA6y0Ct/NljIwdXHrLZ291TYSFXz
 Cfy87S0ACcG2MKBoCfFVMEeI8XnL40PVqC8Vwx6i/6v7Sqotg62DZ5goiwtG6huYSWnFuSbVnZ3
 IN0i7Xc3a0mrzC/nVn7qUN7V3RdqYEHNThVxd6JOGGViSmhVwogdxW3K4cIY0QR+BTzKFlJ76BS
 9nOYjdF5PyYrQyM7dOCoPglelZmnYhePtUJZh/zuwrIMQ4ztjxiOVsQ9U7mEwIUQr9Fx+Vra85A
 Hl3YF6sGecBJ2PEUjmIusnYMecjONecmx+IfRrsvSnp7gw5geqOET/UKc=
X-Google-Smtp-Source: AGHT+IHSF8/Ubom0p9/FYqIXQj/svnAHDDxgKKet6HO+JFeJZX/dzDVD4QHQoDWKpO+pYaJoQ415Qw==
X-Received: by 2002:a05:7301:db0a:b0:2a4:3593:c7d5 with SMTP id
 5a478bee46e88-2a4abb32e23mr6285209eec.21.1763402389367; 
 Mon, 17 Nov 2025 09:59:49 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm54951580eec.0.2025.11.17.09.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:59:49 -0800 (PST)
Date: Mon, 17 Nov 2025 09:59:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <mkashani@nvidia.com>
Subject: Re: [PATCH 2/2] net/mlx5: fix the masked value for a rule for sync API
Message-ID: <20251117095946.0b9037b9@phoenix>
In-Reply-To: <20251117080942.9750-1-bingz@nvidia.com>
References: <20251117080942.9750-1-bingz@nvidia.com>
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

On Mon, 17 Nov 2025 10:09:42 +0200
Bing Zhao <bingz@nvidia.com> wrote:

> When inserting a rule via HWS synchronous API, the underlayer
> implementaiton is a bit different from HWS. The template(async)
> API calls are re-used. In the template API definition, the user
> should ensure that there is no value bit that is not masked by
> the template.
> 
> In the legacy SWS synchronous API, when translating the item, if a
> mask is provided together with the spec. The value is the result of
> the spec OP-AND mask. If no mask, a default mask with all 1s are used
> and the value of the spec remain the original input.
> 
> By introducing the new logic to do the OP-AND and duplicate the
> items from the input in the rte_flow layer. The spec field will
> be with the correct value after inline OP-AND calculating. The rule
> will be inserted with proper value as expected by the user.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Cc: mkashani@nvidia.com
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> ---
> Depends-on: patch-158854("lib/ethdev: support inline calculating masked item value")

Please don't use depends-on if possible, since CI system doesn't really support it.
