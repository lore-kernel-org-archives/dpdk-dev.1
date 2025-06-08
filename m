Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 22:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00AC4026B;
	Mon,  9 Jun 2025 00:16:28 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 0F2ED4025F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 00:16:25 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6fad79433bbso34403466d6.0
 for <dev@dpdk.org>; Sun, 08 Jun 2025 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749420985;
 x=1750025785; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLlBI2zY0uSpQ0MqyIcjGAJT6VQwUbHJrCJTtDu7JIk=;
 b=VFU6TEYcqr0e8ZAItjyk4BuDQdnQBzfewKiH2BvOoFzTjWyxKTw3KgSQfi+7e5V4WP
 eDP0tiN93Od9uCveMC3J2HuEp/6wbqeM8QEpcrDBZIV8IIgw1HA3NjrL5PI1t3SZhx3q
 Z4dGlM7RzmzY4R6uBpdCrxSHb9diUBCVO8ibJ4uXlaya02azQ6tGpK/QYA0dlSZZ1y7y
 16rfuaf7kXeH4HVUFQmqnYkJWJ0K4yZqbZwyujPwzHwQYGUXYSrlrLD4xj8C08+4sDyF
 uVS27OG6Ne1hH4HAToYMbnaInsb3hQ3z4/bPL5bRMzq1n6u1CG2rlGEmevdeTOq/3PVl
 3JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749420985; x=1750025785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLlBI2zY0uSpQ0MqyIcjGAJT6VQwUbHJrCJTtDu7JIk=;
 b=BByZ6HreGU6Q0Pmhdos/0nd+eJQGaCmwrRrFE6FJ3e5iScC7u0LGhSWF7DCi9+BUqO
 2Add9fseMWLrF8DoJYIiukCkndwb8v2+HlX2dpRL2DQOyVcI8B/xPcwIXKiPp1f6LiRq
 4nPe17jINrHsyJZO9Y574HVQwRoOCJoBWvpRYpuUKekrZgQJT7MjMixCgEMWUoQbAAea
 ueg4KBLEQh2XQHSy+Z7SKINqGfDrd+QdQaTeufZzhwgZ24LSWsQJTnZDb90hcB65m0Vp
 MH1WQur6wtWffbmpoLoomlet70d0xovJBHy4y9pHFf2Rd3dCx0oYm94m5rxGS39a8PgY
 RL7g==
X-Gm-Message-State: AOJu0YxnDDDEYX0+Fqo69PGMnoqh9+95ws8dxR/+K13teRZ89/B85Pyi
 IV66cDLEYIn5vSVkfPUbrlM0rvb9Sbx98hgOMzJc9Z9VqWUbVoOypqkLTzNkaqwtX4c=
X-Gm-Gg: ASbGncv6d8cFN5/z3FokjavJL+kA6H69ItnkyJWas/QmXZvuk0vg07HnSF38YysceSU
 1oCDLFHWOTt2FVSaY0Vw3uLAAAoIXqH+fFBVc/U8VWjscACG6+8UWivzcHOZZYxUsaiUD5vvG9M
 /h6Ou9VuFXkt721zcNC7a1gvEJeMesFMGcQynZIPvZfGbs1bI3SC1/+/UMPtBNvnCg+b6E8IngA
 Z5p34iPTnlpHZ4AKVctXMmxs7fHQ8rjVHbx+xorZlwKD1EL2IxPvdM83k0QyzWdA66kmT2CyuBp
 OIPIAiThTVv9VdoEp7nFoe9LRSz6jZ/XbnPXYf+di3j/giePOTlNi7QS9gk1c/1Rx5lAWYa/quJ
 1hyRDzmidXFBVlzvGmNjF5WfA4BXS5sAO3MQsr0U=
X-Google-Smtp-Source: AGHT+IHCsTpwytDSrXTgoIHFM2xuuQrQtnOHn5YPkdU287cNZKeWXUaPTUhS6XWbuokDPCdTRH7WUA==
X-Received: by 2002:ad4:5ae5:0:b0:6fa:c41e:ccae with SMTP id
 6a1803df08f44-6fb08f5f7cfmr204392176d6.23.1749420985136; 
 Sun, 08 Jun 2025 15:16:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac8452sm43489636d6.31.2025.06.08.15.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:16:24 -0700 (PDT)
Date: Sun, 8 Jun 2025 15:16:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250608151621.0a7f91bb@hermes.local>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
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

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> +RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
> +				  (rte_pcapng_t *self, uint16_t port,
> +				   const char *ifname, const char *ifdescr,
> +				   const char *filter))
> +{
> +	/* Call the new version with a default link_type (Ethernet) */
> +	return rte_pcapng_add_interface(self, port, DLT_EN10MB,
> +									ifname, ifdescr, filter);
> +}
> +

Indentation here is wonky, will fix on merge.
