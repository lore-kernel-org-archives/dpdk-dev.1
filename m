Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0803CCDE00B
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 04:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16C1D4066E;
	Fri, 14 Nov 2025 05:27:31 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 30B0F40151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 05:27:30 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b8c0c0cdd61so1223909a12.2
 for <dev@dpdk.org>; Thu, 13 Nov 2025 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763094449;
 x=1763699249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xub0NOg4R0uucodt+7GmxT6HsGioXTo2dChxu1bZaOY=;
 b=n0cHyQ+2gwf3Rx37j5hkBqXxR2RNfXPCUzd5ivV+RQqh5YDvrqtRMCuVFlFHIXIpwr
 Fi3slEL4kcZY1dIsRUbi1dJbBigCy61s9qWtQFW6TtajXWZuroh72mcHHzTXiCNFwF9M
 iN9I64CYfBYmj8Xb8gVhGNMOXCCnBcVOu/qkQfEjDYbo4jomol1OOipS1dGFDktUIr0r
 BrXEvvcVCYLh68u2jBfW3VGh9YajJ/ZTV8/xVWFvh5/xrwVEboV//kmSLvh5DAsIlIrQ
 EZzAdc4tJz+I9LGl2QfDSfEYJ1hUtUbjJaGxvsJTbLSco/Y0jU1/oNUy4YHaxYH3fb7c
 b2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763094449; x=1763699249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xub0NOg4R0uucodt+7GmxT6HsGioXTo2dChxu1bZaOY=;
 b=PBKxJPWUrZP0Tdy29kgCE08SmZXFs/BInWZ/lof6bDJhlqtH3bplwgQm/aU+u3Gvrc
 wMvVqSa3sUu2j/cg/AQu1KIYhYe95UV0NuHYJgHwFrKsmg9JIER+LXoOOj7UjGZJsPUm
 kkB8UD6i5+co3sEkNfzBwPbbaGLMUPZEU0B7epuhSYBAjNAnP6WKLcX5rGCtzHPxdu7b
 +ZU58i0ddycbt+dqXeJ6vgCjR7DBH9acdxwqClsDdSIhJTc3qegJVjfJSAh+AYMDINfx
 0zM94TuZ3sX/khUl87xb6qpjCBVbQYCXv9VOd+0fPkHeQ3QmYjvJ+khnNou6TLyxP18p
 OUOg==
X-Gm-Message-State: AOJu0YzvARnPQOrPiuvOqe8VORn5YjIEB3tVsbftAoznvVeCzWe1pE+i
 VRZ8v+bh5VhFg/GuNrAzv/Fr4NCu1x3qj1kV0C/pWs9mlRSWcinVY6AP++ZhdD8ZC14=
X-Gm-Gg: ASbGncvCRFf/brALqj9SEByPhi9OCdObUKAntep4ArINdVO/YGDRvnIB19n8Opzdwqj
 8z6snenG9R+O7MLl/uHyzdwqlvPu8Hr8Cdud1M+/KfyswCxApWfFH4FzCjI/RH92ith4MszNptm
 XwAGToIGU+1eNIBCvboHJ3tEFose5/ke5TUqKGmrekUs6YNYX1ZHnaVt5T4h8gmP25zeExUM0AT
 lll5bPgiCdxPMjVjfkG4p2rPSGx03FUrwVEiF/Fk8X3RQebyyltTWoHgeUrYwEetiYads/eIkqX
 n1/Ik1pS1XcxyynPkaXWil3DPJSZS/lmLHOPkb1WqcLSNE7/IebSece5004R51ozBCQpfUE+/zF
 wI6loRMjH/NDneysnSzG/hagkOTbCWHN5A09w1SU5zvLGx3+YJuQC08IG06dWeb9PWIxXQsE5zS
 wuFY/M1vviK89ikz1As5QoJihcj4rVzhb/+OC2q23kHzSsgY4SzLDqxLw=
X-Google-Smtp-Source: AGHT+IH18u5BtENK4b+StUeU3tLKyfJZnl8ZgRPjCVSsrH4dE8Vs+0iC+gLA54H+kL6aozYkrLww7g==
X-Received: by 2002:a05:7022:69aa:b0:11b:3742:1257 with SMTP id
 a92af1059eb24-11b4120ca2amr947640c88.34.1763094449020; 
 Thu, 13 Nov 2025 20:27:29 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885c0sm5637048c88.3.2025.11.13.20.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 20:27:28 -0800 (PST)
Date: Thu, 13 Nov 2025 20:27:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, orika@nvidia.com, thomas@monjalon.net
Subject: Re: [PATCH] ethdev: add GENEVE encapsulation and decapsulation actions
Message-ID: <20251113202725.4aaefeee@phoenix>
In-Reply-To: <20251113102158.48040-1-sunyang.wu@jaguarmicro.com>
References: <20251113102158.48040-1-sunyang.wu@jaguarmicro.com>
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

On Thu, 13 Nov 2025 18:21:58 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Add new flow action types for GENEVE tunnel manipulation:
> 
> 1. RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP - For encapsulating packets into
> GENEVE tunnels
> 2. RTE_FLOW_ACTION_TYPE_GENEVE_DECAP - For decapsulating packets from
> GENEVE tunnels
> 3. struct rte_flow_action_geneve_encap - Data structure to define tunnel
> encapsulation parameters
> 
> These actions allow users to build more flexible network virtualization
> solutions using GENEVE tunnels as specified by RFC8926.
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  lib/ethdev/rte_flow.h | 50 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
> index 3d2ccdeb92..fc03489511 100644
> --- a/lib/ethdev/rte_flow.h
> +++ b/lib/ethdev/rte_flow.h
> @@ -2825,6 +2825,23 @@ enum rte_flow_action_type {
>  	 */
>  	RTE_FLOW_ACTION_TYPE_NVGRE_DECAP,
>  
> +	/**
> +	 * Encapsulate flow in GENEVE tunnel defined in the
> +	 * rte_flow_action_geneve_encap action structure.
> +	 *
> +	 * See struct rte_flow_action_geneve_encap.
> +	 */
> +	RTE_FLOW_ACTION_TYPE_GENEVE_ENCAP,
> +
> +	/**
> +	 * Decapsulate outer most GENEVE tunnel from matched flow.
> +	 *
> +	 * If flow pattern does not define a valid GENEVE tunnel (as specified by
> +	 * RFC8296) then the PMD should return a RTE_FLOW_ERROR_TYPE_ACTION
> +	 * error.
> +	 */
> +	RTE_FLOW_ACTION_TYPE_GENEVE_DECAP,
> +
>  	/**
>  	 * Add outer header whose template is provided in its data buffer
>  	 *
> @@ -3738,6 +3755,39 @@ struct rte_flow_action_nvgre_encap {
>  	struct rte_flow_item *definition;
>  };
>  

It is too late to put a new feature like this into this release.
And if targeting next-release 26.03 the ABI is not allowed to change.
That means you will need to put the new flow actions at the end of the
enum rte_flow_action_type so that values don't get reordered.

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 24 October 2025
- PMD features freeze (-rc2): 7 November 2025
- Builtin applications features freeze (-rc3): 17 November 2025
- Release: 26 November 2025

See https://core.dpdk.org/roadmap/
