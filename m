Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB0606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oUNeP/Qx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0477E40281;
	Wed,  4 Nov 2026 13:09:58 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 4EF874025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:09:56 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso95166266b.3
 for <dev@dpdk.org>; Wed, 04 Nov 2026 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793794196;
 x=1794398996; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mxgYrqAR8RYMqrQIeomXgrEJf6g946Zu3dsqiIdZRe0=;
 b=oUNeP/QxBhIcq0yf4eB7NP6pvQCu7rZqqqJzIXEpX9zyDAmZ9MK8b9Mn6FD87S8D0G
 yh9aKheB8OREm8G9hOjEdi9bWBGHRQ4VUq0pfmmYQ+s1V3EQsWQVaWtJDdcI1eA1jump
 ZeRcXzROfUf1uDxkvuMEdQuqvrX/t9r9T8JOUB7nukgogKGonTFk53XMihEXAjqK+DWe
 cpbfUrKnE8ElXQnQxkiE4sBto2yOBHESEt92h4GPRHmUG/0tAWoM0rOB8pOS1sUNgNCd
 vuLfDqfIyqPSVlVMmfMmYE97o/kdUrYFfEzt/90ciYeAF1gZF9L6u3sHl86vfecxmQP7
 irSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794196; x=1794398996;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mxgYrqAR8RYMqrQIeomXgrEJf6g946Zu3dsqiIdZRe0=;
 b=yeb0PHDDoItjq1Eq+JyZvJ17Bz4QThGrBc/7GAOLWjXYlzI35cf+1g+qwOmKbTK3NE
 KMibbw5VFtVNfrkP+VvCZMrOTqX4CFpRh/7yyu9/xMXXkrPXBkgYzhRlk/ajjSjcon3A
 flzRo0+cXO4ABjAvcwwH1r2jFzLExOMiANb3GhGu/XMrILx9+sxqZNbzYklEhWgn+1o3
 12bkUEsQDE5G5lza0JA3TD83O9x5wE2TQM3GOydTyhdQIdmaxrE1I+WLTzmmYHimw31R
 LGZt6kfv0m+e0p3QM2Mu6RMXe94xl7tRkM+t+ZXmVvrLQB5YMJC4srhW6/XtzoW+z4oO
 AzjA==
X-Gm-Message-State: APuU4Z8Pan2vPMU6eGbKrnl/wVrnznjOxgZlfhcUQRhE//rDSTtcQ2xV
 TAvLjT3ZkD9mU2gpp8dW9y643c6IFIeHM3Wiv1p1flnsLABoY3Z/cXmtsM63NdSZROc=
X-Gm-Gg: AYBFou3KF1RC5pCH2WFWsZ5juKz08QjclBeqLgrugsCSjxVbLxdUm3fCZyyP9NYty3W
 mdlzUsKPXjX64d9CwTh0UOAIk6c73kq2XDqnA8ds78NPtpMQRrVFRW3mDjSAX1B4pKRo2Ja0t5c
 3DDLWr0ot8hHqP27J7RShuXOPuqRPqQsK3HSC5bF80qesuo3oxSTypfXMz+XIZayzELc4prFgI1
 yJlHaArt/XQhdFvP4HBdIIlKodFt4EKnRQvSZCwlOuNPSmTRZhYYp2P8txtLnf4Gz4JUs0RX+eN
 DwYBfOfzpcc/iNY0vmeg40ql1t68NvFI0Cm7WEOzdjSuIdFoGpnMEvASD35cfkg8WtDTR/k+Tb3
 EIMbREWaQinXybyfwSjgpNhuQtyflTULmHaOWRvjD6rNeLJ2Wp068OgRQCuaurT2OqKSjDliO8T
 kfUJhQVZtPFjp3GHZYBGXR9/VmgYguOAzWu5K+U0AB0zf99hxGiNscr0ixQz5cQONi2lpVgh8lg
 2r8U56AWQgP5l/D1jnZAvnb8cLdKDnpSACm+WWtI6M0bZf6u37Ddsk6A+N4v+DJBH1p0SnyM7mN
 LF6lPjx6CtYRup0ltIOe8OiDWxXxgG29v/C/mKFDXr2/LnHYrX2v4r1UxzjA5YdgB/lbrXQXQzV
 v/qK4GAWopk1m+pc=
X-Received: by 2002:a17:907:fdcb:b0:c41:f29:72b1 with SMTP id
 a640c23a62f3a-c4ca7aeb21bmr1372694766b.47.1793794195820; 
 Wed, 04 Nov 2026 04:09:55 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e42318fsm60985066b.18.2026.11.04.04.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:09:54 -0800 (PST)
Date: Wed, 4 Nov 2026 13:09:50 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <thomas@monjalon.net>,
 <andrew.rybchenko@oktetlabs.ru>, <maxime.coquelin@redhat.com>,
 <chenbox@nvidia.com>
Subject: Re: [PATCH] ethdev: add 1.6T link speed
Message-ID: <20261104130950.23c898e0@stephen-xps.local>
In-Reply-To: <20261103130127.3466533-1-mkashani@nvidia.com>
References: <20261103130127.3466533-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 15:01:27 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index 19244836899..16a1ef0a64c 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -296,6 +296,11 @@ struct rte_eth_stats {
>  #define RTE_ETH_LINK_SPEED_200G    RTE_BIT32(15) /**< 200 Gbps */
>  #define RTE_ETH_LINK_SPEED_400G    RTE_BIT32(16) /**< 400 Gbps */
>  #define RTE_ETH_LINK_SPEED_800G    RTE_BIT32(17) /**< 800 Gbps */
> +/*
> + * 800 Gbps is standardized in IEEE 802.3df; IEEE P802.3dj is
> + * standardizing 1.6 Tbps as the next rate.
> + */
> +#define RTE_ETH_LINK_SPEED_1600G   RTE_BIT32(18) /**< 1.6 Tbps */
>  /**@}*/

I am ok with the rest of the changes but the comment.
There is no reason to add comment for one speed. Looks like
something AI generated to tell itself how important it is.

Will drop the comment during merge
