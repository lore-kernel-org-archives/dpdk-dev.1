Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864ED2595D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92C7340E2A;
	Tue, 27 Jan 2026 09:12:23 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1675F40A77
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769501541;
 bh=2TgIKgz9UtYsFmkn5FwKoQT+wfzdNkHfBg4m+jG8zXw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=KHixiotmoLGMoNp02hsoxg5Zwi7ClKOWYmsZtPkO5iD/GnvuLTXR8vg35sxRQe1FW
 qLce/go8e4ahgty5C58uHsrMGCoxjFXfRFFjjhtNdt9y/JEDVD/Q1qU/By1tK5zFdG
 U3Hqu9ehQq3U7JbR1bbQxAmTNmGyPe4fA3kd7EqRDzlNfxb9sf5ahSPezdVifyfKD8
 q46edUBr3f0M+j6ek0x9DZ9iZPOIna1j9EL2NpPKUHKQ5Pya/BO8zIkwTiXOJ0M0hN
 ADT9Umybe641bqOFFUarXV9swJU6v9Lrd1ThK2p3QyRLXQOkdy24UvubcMM2l1LaGB
 Jyf2koy8PmHgA==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D703B118008C;
 Tue, 27 Jan 2026 09:12:21 +0100 (CET)
Message-ID: <c290d24b4985d46730bc4f45919128193bb91bc2.camel@cesnet.cz>
Subject: Re: [PATCH v5 2/8] net/nfb: create one ethdev per ethernet port
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 27 Jan 2026 09:12:21 +0100
In-Reply-To: <20260126163710.5bf8a275@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260123172224.1567362-1-spinler@cesnet.cz>
 <20260123172224.1567362-3-spinler@cesnet.cz>
 <20260126163710.5bf8a275@phoenix.local>
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

On Mon, 2026-01-26 at 16:37 -0800, Stephen Hemminger wrote:
> > +TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);
>=20
> You should put static in front of TAILQ_HEAD so that the head is not
> global if you don't need it to be.
>=20
> > +static struct nfb_pmd_internals_head nfb_eth_dev_list =3D
> > +	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
> > +

I don't understand this. The static is already in front of the
nfb_eth_dev_list global variable.


The TAILQ_HEAD() just defines a struct (not a variable), which is
visible just in the one .c file.

When I use static, as you suggest (or as I think you suggest):
static TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);
$ ninja
[2/30] Compiling C object ... net_nfb_nfb_ethdev.c.o
...nfb_ethdev.c:49:1: warning: useless storage class specifier in empty
declaration
