Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635ADD2ED16
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B09040E50;
	Tue, 20 Jan 2026 16:16:38 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id C213740E50
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768922197;
 bh=rDl/BdKnzYNyHbdCpJTzZJpN61nyb917Ag+DhqZR4FE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=FsaObmYSLT1skwrLBx/ecijL5QyxxLyfHRovCIpLBYtcAXETHa8wBpxjttw86g8aM
 ey4UcdXGJJ0ykkGSOqUAxFS4UegROTKcFK3V5ZzK/T9pkKtesm2FBqRfQrJ8sm5tft
 vPIpDtttvf1BvEmUm1+ji4YLsB5OMH32l6I8cWH9KfL4/AStLBEdKmdX/s/mvjvDzS
 P2/jM9GtflKuIpaJWrliNNbAqjgZCPnZWW0wQk4kaXIeoac/ku1ctUfz7t0ZcZm+uv
 C+Hrwwq7ywcG16BHnOtNocv0akpGtLE9b/+l6GnwvIRcG8ZpOffmtDEHU/O1ddx0Gz
 W0Y9deaJENN7A==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 995411180072;
 Tue, 20 Jan 2026 16:16:37 +0100 (CET)
Message-ID: <7eb5f5af32a8d6447c1dc314e40e6e182acc930a.camel@cesnet.cz>
Subject: Re: [PATCH 1/8] net/nfb: prepare for indirect queue mapping scheme
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 16:16:37 +0100
In-Reply-To: <20260116093400.74fc31ed@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-2-spinler@cesnet.cz>
 <20260116093400.74fc31ed@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
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

On Fri, 2026-01-16 at 09:34 -0800, Stephen Hemminger wrote:
> On Thu, 15 Jan 2026 16:16:49 +0100
> spinler@cesnet.cz wrote:
>=20
> > diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
> > index d85c5fba62..ef41d100ac 100644
> > --- a/drivers/net/nfb/nfb.h
> > +++ b/drivers/net/nfb/nfb.h
> > @@ -47,6 +47,10 @@ struct pmd_internals {
> >  	uint16_t         max_txmac;
> >  	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
> >  	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
> > +
> > +	int             *queue_map_rx;
> > +	int             *queue_map_tx;
>=20
>=20
> Since these are queues, would prefer uint16_t rather than int.

The int type of the queue_map_rx values here corresponds with the
libnfb API.
However this patch should have update also the types in function
headers (nfb_eth_*x_queue_init; the nfb_eth_*x_queue_setup is fine).

> > +	internals->queue_map_rx =3D rte_malloc("NFB queue map",
> > +			sizeof(*internals->queue_map_rx) *
> > +			(priv->max_rx_queues + priv->max_tx_queues), 0);
>=20
> Use rte_calloc() of arrays.
> > +	if (internals->queue_map_rx =3D=3D NULL) {

Ack.
