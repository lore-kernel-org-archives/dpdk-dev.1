Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20620D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C34A40156;
	Tue, 20 Jan 2026 15:14:00 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 2212E4013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768918438;
 bh=Gy67hmPfcZodvivTWAv8N2d8yQQmBx//PmlnSfKvQlM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ekSo/OpDmJtGvr1WSaXupJwR5ACIUfkX5kI5sM6ANhmrAy+UZhOMV9cC9hFZKZU3s
 +bgiHVHqtTy3TCdWQgCkWJTQO7kpDIYXN2TnDtw/ILNZEe5gsjnE0vO7uOLcrDon4c
 c0tcqLPSLo7W3JZ8cRttkB+xOG6gl3ZNwPvVW0xN+xQRuqvG7Ap5tOOdf7EutwDjJq
 EoFTRuiSPPGuLf3pCBaboUQ3FkJliblM5+P999/VSt+ynGjNk85lVNwJHEhT5sptmo
 xG+4j8BpPUXddrskPhff1z7bRzLZOYM5VSbLskzaQXPwm8grElfmcDjKafsuvj8tUi
 25MwJJByMxNPw==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id CF8851180072;
 Tue, 20 Jan 2026 15:13:58 +0100 (CET)
Message-ID: <79b62ea1ceadf3c0d5c6e124715e12f429cb8f35.camel@cesnet.cz>
Subject: Re: [PATCH v3 4/6] net/nfb: use process private variable for
 internal data
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 15:13:58 +0100
In-Reply-To: <20260119161351.20d06a34@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-5-spinler@cesnet.cz>
 <20260119161351.20d06a34@phoenix.local>
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

On Mon, 2026-01-19 at 16:13 -0800, Stephen Hemminger wrote:
> > Internal structures of libnfb can't be shared between processes.
> > Move these structures from dev_private to process_private, which allows
> > secondary process to correctly initialize and uninitialize the eth_dev.
> >=20
> >=20
> > diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
> > index 917b830283..09d4b7da5f 100644
> > --- a/drivers/net/nfb/nfb.h
> > +++ b/drivers/net/nfb/nfb.h
> > @@ -48,7 +48,9 @@ struct pmd_internals {
> >  	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
> >  	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
> >  	struct nfb_device *nfb;
> > +};
> > =20
> > +struct pmd_priv {
> >  	uint16_t max_rx_queues;
> >  	uint16_t max_tx_queues;
> >  };
>=20
> Where does max_rx_queues get populated in the secondary process?
> What if either process calls configure to change number of queues?
>=20
> Don't see other drivers splitting structure here.

The NFB PMD must use separate handles for each process (each process
has its own FILE* and mmap handles from libnfb). However, some data,
such as max_rx_queues, is constant and can still be stored in shared
memory (and inited by RTE_PROC_PRIMARY).

The pmd_priv is stored in data->dev_private, so it is shared between
processes. However, your comment pointed at the opposite issue, that
the nfb_eth_dev_init() assigns to the (pmd_)priv->max_rx_queues in both
process types (duplicate assignment).
I will fix this by moving those assignments to the RTE_PROC_PRIMARY-
only block.

By the way, this partial diff shows the struct pmd_internals being
split into the new struct pmd_priv. Semantically, however, the struct
pmd_internals is the new one, is newly alocated and holds the
process_private data.

Does that make it better sense now?
