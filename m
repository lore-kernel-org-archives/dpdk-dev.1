Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80BEE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 06:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ABC4402CC;
	Thu, 19 Feb 2026 07:20:34 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id DCE23402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 07:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771482032;
 bh=KV9jqmXhVw9pM6BO2IT7LoPTlCX3D3PrdKZs+liNzyQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=FAPB1ilD/Q+AmB7R7q3ZZDh5FXPXvMiCPbXmDkRrpwghIJywgGDclaB6JPmU986BA
 izwrLbHa3a6vjzXSrcHDqHSz3x9dcVB8xEBbLFt1TlHWkcrtSbWSlZpr0FeqS+Yg4f
 aI0jE+R9noBUIWa/ekJIOO7ypMdKJL4Uu/kZ5dNA+py1IR7nXDhROdD1aOaBdOjeB1
 /eGYRMN2h8koBRI6lAsPFp74j7fcHbUs/KEDCSbQX+csE4B5fTkHAb4OG05noJFbAU
 Joayfw0p3ECK+zqUc/CQwTw1XrzecC4FOehIMhCPkzNS+YgWUd2XM5tfijHYZOUiyl
 m3jEnlegK31ng==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 8860111800B6;
 Thu, 19 Feb 2026 07:20:32 +0100 (CET)
Message-ID: <d6f174ffc3252d4cbfe5132bb0916ca3986a7492.camel@cesnet.cz>
Subject: Re: [PATCH 5/7] net/nfb: support setting Rx MTU
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Thu, 19 Feb 2026 07:20:32 +0100
In-Reply-To: <20260218102058.53296e9e@phoenix.local>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260206170435.302184-6-spinler@cesnet.cz>
 <20260218102058.53296e9e@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

> Since mtu is 16 bit value, you need to use uint32_t to avoid
> overflow.
>=20
> Something like:
> +	uint32_t frame_len =3D (uint32_t)mtu + RTE_ETHER_HDR_LEN + RTE_ETHER_CR=
C_LEN;
> +	if (frame_len > priv->frame_len_max_cap)
> +		return -EINVAL;
>=20
> +	for (i =3D 0; i < intl->max_rxmac; ++i)
> +		nc_rxmac_set_frame_length(intl->rxmac[i], frame_len, RXMAC_FRAME_LENGT=
H_MAX);

Thank you, this check is cleaner.
