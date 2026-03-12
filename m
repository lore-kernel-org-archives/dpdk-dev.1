Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB61067041
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 15:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F91840613;
	Thu, 12 Mar 2026 16:05:50 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id 1317D402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 16:05:49 +0100 (CET)
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id E0DAE6012D;
 Thu, 12 Mar 2026 16:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773327949;
 bh=MQ90H85nq6a3LfrXqmGTW0jznBgmci3FxgvkI/tvBp0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W0Bkgsmc85pW99ota10XaAWbaGQPM+GIxOVbSYtbgvhQ/xBzyVunTH0vsPcyHRF4j
 ziibeD3LHL8+fnt6oT2eujIzdhDuxwyj6bbAFevgit23Dh/Ay3i+CgnwNXVp3ruCni
 NWgtym4ZO3CYF1zfKdLEtCwly0sPW4YK7K3y1cWcqWpG5J3S0dlxicBOP0BhoyyUHR
 +edWx495hxMUV19OZ7Zw1AkwUZSvpoqtapW7Sje3hdSmJurlEjxU7QpxEg7h/si0Sg
 e7nYIq9ae7UqzyoU6OljE82mIpyr9r/ysJ1Eqdjg7uAbxaj9kBBgaLWSsYPXYcXt8G
 jNj7fnM4a5ruA==
Date: Thu, 12 Mar 2026 16:05:35 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 10/10] net/mlx5: add rate table capacity query API
Message-ID: <abLWPxI8j49C2voo@L30177.local>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-11-vjardin@free.fr>
 <20260311093540.5ada20a3@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311093540.5ada20a3@phoenix.local>
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

Hi Stephen,

Thank you for the review, see below,

Le 11/03/26 09:35, Stephen Hemminger a écrit :
> On Wed, 11 Mar 2026 00:26:53 +0100
> Vincent Jardin <vjardin@free.fr> wrote:
> 
> > +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_pp_rate_table_query, 26.07)
> > +int rte_pmd_mlx5_pp_rate_table_query(uint16_t port_id,
> > +				     struct rte_pmd_mlx5_pp_rate_table_info *info)
> > +{
> > +	struct rte_eth_dev *dev;
> > +	struct mlx5_priv *priv;
> > +	uint16_t used = 0;
> > +	uint16_t *seen;
> > +	unsigned int i;
> > +
> > +	if (info == NULL)
> > +		return -EINVAL;
> 
> Prefer NULL checks in ethdev layer
> 
> > +	if (!rte_eth_dev_is_valid_port(port_id))
> > +		return -ENODEV;
> 
> Ditto checks for port_id should be at ethdev

This function is a PMD-specific API declared in rte_pmd_mlx5.h, not an ethdev op.
  application -> rte_pmd_mlx5_pp_rate_table_query() -> mlx5 internals

Therefore, the function must validate its own inputs:
 - port_id validity (via rte_eth_dev_get_by_name() / rte_eth_dev_is_valid_port())
 - info != NULL

Adding a generic ethdev op (ex eth_rate_table_query_t) for a concept
only one driver supports would be over-engineering.  If other drivers later
expose a similar rate table concept, that would be the time to factor out a
generic ethdev API.

> > +	dev = &rte_eth_devices[port_id];
> > +	priv = dev->data->dev_private;
> > +	if (!priv->sh->cdev->config.hca_attr.qos.packet_pacing) {
> > +		rte_errno = ENOTSUP;
> > +		return -ENOTSUP;
> > +	}
> > +	info->total = priv->sh->cdev->config.hca_attr.qos
> > +			.packet_pacing_rate_table_size;
> 
> Since DPDK allows 100 character lines now, don't need line break

ok

> > +	if (priv->txqs == NULL || priv->txqs_n == 0) {
> > +		info->used = 0;
> > +		return 0;
> > +	}
> > +	seen = mlx5_malloc(MLX5_MEM_ZERO, priv->txqs_n * sizeof(*seen),
> > +			   0, SOCKET_ID_ANY);
> 
> Since this only has lifetime of this function, use calloc() instead
> since that avoids using huge page memory, and compiler and other checkers
> "know about" malloc functions and engage more checks.

Nope, I'll use
  mlx5_malloc(MLX5_MEM_SYS | MLX5_MEM_ZERO, ...
in order to remain consistent with mlx5's cases I could grep despite there are
still 3 other calloc() occurences that I did not analyze.

In any cases, it'll end up with calloc() (mlx5_malloc()).

Best regards,
  Vincent
