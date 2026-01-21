Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14EEC44503
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A78DA427CB;
	Wed, 21 Jan 2026 12:11:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3A8FA400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768993902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbhN05ak8+OqypUulsov9f6DeddVm1OAxFnKj38EVn0=;
 b=CGHshernwfGid7zyG+y0qleL0qxez8hRRG2hMBQG877DCxoUXpSJ7FO00d5em7ych6Iv9k
 ZVuxR8xqa1LOiuR6Hjwcdyqr8VVDs/ciehUmKQfmIAmx1ofOyMFOmjXZKdRIY/946HgtmK
 3AHnqQGq35PEZeYO25kyDQP3CQK+WRk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-1GBPPwMXMWGSUFrl_Lp7KQ-1; Wed, 21 Jan 2026 06:11:41 -0500
X-MC-Unique: 1GBPPwMXMWGSUFrl_Lp7KQ-1
X-Mimecast-MFC-AGG-ID: 1GBPPwMXMWGSUFrl_Lp7KQ_1768993900
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-385bb7f429cso1053421fa.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 03:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768993900; x=1769598700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbhN05ak8+OqypUulsov9f6DeddVm1OAxFnKj38EVn0=;
 b=ohHKm9pZ4YLgW6JTWKIJ+clGc60SCUFM3m2Uhtlsqh5qjor2aVhi11y0vmwOQT7xDI
 Rqo0L/5GVq/n9wM3T71zMiqwiwNNKVf27+BIoAk1vAYl6oy0ut1HGPpYLGx3lfIa+RBO
 h8EYFgIPOw2j/JNYSnJ6rtY7YpUuZ9oVgvb1dTLl2Er6SqwULdWhY0RNM6RBhVnDlhua
 iQqi1xBdysLTN+C2fQt4nk3Od9l/v094uc96C6U8oSIw4ONduFR7+XlNIZzCrj/+JwpL
 dP/9/ncrhOXmn6uFJNgC1SrYSHIHXkPaGwH8eR+FJxZ8CITRmeusFRaEr4vg5AiQLAWM
 gTUQ==
X-Gm-Message-State: AOJu0Yx4G0TfqRDeX1GfwjhfgNfyq7G5ytfqH9pmDfmUX8ZyFoFRyqs3
 kxVRVzXCIYLzNRnLCNpmzHaUUxXldiVwzRASNFlc38B5g1G+HwGQxPqh2CY1xyWRkjQy0JQu75l
 nLCIFeKcjx/XOmYNiBaHlRiSBCgqDUy5fYh2D11u+97VvHSc61Bae5b5dNxF562YOAQD39adG82
 fdwFQtgZL6G2AYYw50W6s=
X-Gm-Gg: AZuq6aIq406zw770TyUUubG+e4VDiTgasfV4Hn8WHjam+uIEJ7uv7TKzw2K0V0uxcgB
 +3Ubt+kTy5xyipMuCJXCowVHA3LLm8vW0YJ9QNHmbkUTQzpEN2afeWzqIFAG+xUdDF/HIVZUigA
 AABIHRslvIG0r2CfSq2uh3fORANX6HymMHzSdgWmnnh+JgQ2UTUIqLt3WOy9tHEdXkmjF4
X-Received: by 2002:a2e:a987:0:b0:383:1255:9236 with SMTP id
 38308e7fff4ca-38384337b81mr60235451fa.41.1768993900006; 
 Wed, 21 Jan 2026 03:11:40 -0800 (PST)
X-Received: by 2002:a2e:a987:0:b0:383:1255:9236 with SMTP id
 38308e7fff4ca-38384337b81mr60235331fa.41.1768993899569; Wed, 21 Jan 2026
 03:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20260121110757.1948723-1-thomas@monjalon.net>
 <20260121110757.1948723-2-thomas@monjalon.net>
In-Reply-To: <20260121110757.1948723-2-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 12:11:28 +0100
X-Gm-Features: AZwV_QjTYYZc4nNLoph4t1arj6yuMpkqJ6zHxXXjnKdnPC6kL9ZWK-4GXWJk5HE
Message-ID: <CAJFAV8xsio-H2xqAAOxDQeOPsnCqNiABkPG97k+y+DyzOnX5_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] common/mlx5: fix variable shadowing
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, stable@dpdk.org, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VThuAWrmOdFV5MCw5ePAT3whddj01sHhiH9Wo-v2GfU_1768993900
X-Mimecast-Originator: redhat.com
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

On Wed, 21 Jan 2026 at 12:08, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> The word "unused" is too common for being used in a header.
> There is a warning because a parameter is named "unused" in mbuf:
>
> lib/mbuf/rte_mbuf.h: In function 'rte_mbuf_tx_offload':
> error: declaration of 'unused' shadows a previous local [-Werror=shadow]
>  1910 |         uint64_t ol3, uint64_t ol2, uint64_t unused)
>       |                                     ~~~~~~~~~^~~~~~
>
> Such value should be prefixed with "MLX5".
>
> Fixes: bd935fe3e624 ("net/mlx5: wrap sampling actions per OS")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

