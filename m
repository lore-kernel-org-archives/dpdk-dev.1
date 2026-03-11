Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC21112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C555A40A84;
	Wed, 11 Mar 2026 17:35:46 +0100 (CET)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41]) by mails.dpdk.org (Postfix) with ESMTP id 3C391402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:35:45 +0100 (CET)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-67bb87f866bso56925eaf.2
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246944;
 x=1773851744; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIdafhg9I1VECcKoB61zccdaWu5NZRi5/sE51e2e4Oo=;
 b=laSxEKXBjD7AuZUCs1AFJyeJU+mRWOw/Zo0axQxKsXStC1RuXJUwP86/DSyxf5MmQ+
 FKr1ggkeBNgFe0OS+/SxIyA5GnfINHEwQZy3Db/t0Di/CTkXy8lV1FtD6dlADI6omVZH
 u5pA+Sohsj4gnBKXoLsB5y2wjbtMAOxNMz7PvSEXt0ssmF/gneZwg3jzaUJdUFdAxu9+
 Qc3kcE/P436pbpI87uq2ce1wImzWfnM8b34iQ3bZCUOHYkDAwTDilr3ON8fYGt0adskT
 0HkE6NE0NkxwFkrM6fiBbKD1XwZoy1yTQ0+yZgEQ7/gqNgH80G6wlLC4LPASFXb0JLkA
 O1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246944; x=1773851744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AIdafhg9I1VECcKoB61zccdaWu5NZRi5/sE51e2e4Oo=;
 b=HaJZ3oTZla5yi6hp0kZmYBHbiztE4s9ATxws3sKK2WYvE8NWesVO8lhH+y8oQNw76A
 xoGb4B+/zvxQcmHdD12wVZWo0b0vDGUvrmJOsxMSt/ATaeErb0yAHBZjZfB6TXFsDRIx
 Xrx6TZhn0E0hUrkMvmhOZVkyi+Hzh2L1n294nZhSN0RRFacBLCwTbaM6E8r1Dusftz/q
 GEsuw86//Fx7YmwgNgxnkGLYeuUfV9uiCCnhQV27SserWCho7AfLM7wD84v0l7fkBT49
 CX10PT8QLPR3zu7ydq6G0eW3kuzgVVgxZo1LfX4fCd4ndS8VZR6ov3wm7sNRPdD43Ds+
 CdsA==
X-Gm-Message-State: AOJu0YyTs2tfnq3dgyXIOFtbXkz3YrJ4KB8GjcUfI0kivRZF6AuPe88Y
 m+Yn6BXzPmm9DUR2WkTSAlU2r6iZrLWEbrQ6r5DLyMM2vE2+vWEdKgf7mLqyvKsJoxQ=
X-Gm-Gg: ATEYQzyJlKPsLCdQNVy4kCkb59Ed9ndp2QxCAWLsPR0ArvTG1eJfMcaNGVAU3yUjS78
 HCy7Ayhm9Cij3MQGook39fmUcMHhio26Mbv63J0c2ECSfVwgeVb0Ks33ktZnTm4BJjJhtbWn8il
 zreF+Xy390UDWVZozOt+rfa1o4OlB0ZgXYsy7E9HPnbldsLaOKez/qMd5Q8wvwSM6aZ2PD33V8g
 MyltDlN2HY3YwTH+Gs7pzmQQ03d3uAnNXIacJ+GvBXxqANdGu2EMVF6iFj/68AV1YplREGuLPeJ
 NMC4cvujQ7VHLn6m/+6z8QIVhjWfeMCdmDEhFsCYEEbzfc9oBJbAX3qEkF+7QmQs4Y5dxd+Is0N
 KINLMua1HWvy+WzZJ0x2ESZApTMiKa8Q0808AQ4eMqNJUwJFHfNY1soTVp4eL6q+7t76kE2+3Rn
 cw7v+mtB5pVk4ZDqF5+pdeAPtCH2h0Z7RxGks=
X-Received: by 2002:a05:6820:168e:b0:67b:b182:19e with SMTP id
 006d021491bc7-67bc889874emr2178339eaf.11.1773246944338; 
 Wed, 11 Mar 2026 09:35:44 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9118bc7sm1743197eaf.6.2026.03.11.09.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:35:44 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:35:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 10/10] net/mlx5: add rate table capacity query API
Message-ID: <20260311093540.5ada20a3@phoenix.local>
In-Reply-To: <20260310232653.2935764-11-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-11-vjardin@free.fr>
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

On Wed, 11 Mar 2026 00:26:53 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_pp_rate_table_query, 26.07)
> +int rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
> +				     struct rte_pmd_mlx5_pp_rate_table_info *info)
> +{
> +	struct rte_eth_dev *dev;
> +	struct mlx5_priv *priv;
> +	uint16_t used = 0;
> +	uint16_t *seen;
> +	unsigned int i;
> +
> +	if (info == NULL)
> +		return -EINVAL;

Prefer NULL checks in ethdev layer

> +	if (!rte_eth_dev_is_valid_port(port_id))
> +		return -ENODEV;

Ditto checks for port_id should be at ethdev

> +	dev = &rte_eth_devices[port_id];
> +	priv = dev->data->dev_private;
> +	if (!priv->sh->cdev->config.hca_attr.qos.packet_pacing) {
> +		rte_errno = ENOTSUP;
> +		return -ENOTSUP;
> +	}
> +	info->total = priv->sh->cdev->config.hca_attr.qos
> +			.packet_pacing_rate_table_size;

Since DPDK allows 100 character lines now, don't need line break

> +	if (priv->txqs == NULL || priv->txqs_n == 0) {
> +		info->used = 0;
> +		return 0;
> +	}
> +	seen = mlx5_malloc(MLX5_MEM_ZERO, priv->txqs_n * sizeof(*seen),
> +			   0, SOCKET_ID_ANY);

Since this only has lifetime of this function, use calloc() instead
since that avoids using huge page memory, and compiler and other checkers
"know about" malloc functions and engage more checks.
