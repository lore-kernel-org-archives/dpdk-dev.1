Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B38D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CFC840E35;
	Tue, 20 Jan 2026 15:14:03 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 2906640E34
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768918442;
 bh=uIN7sES7YBnRar2hXjR/2TN7s1qK2rwKU12t+gLTZrY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=CvaEqOpXVySL9y7L+PtIeVPGhXlvBQNLSDs9l1j19398ltFRiHvF0y8JtSoKTQNRB
 CKNPhnZr/qZ8cJ1HQZuIs3tVSntQLkw00d2MHGt9F3YdVQwy9offv8W2esqhpl9xuQ
 kKYkSlaaGEBxu2lEokhjMPAxIaftAcWOooG+KfgeaAS3VWBScI3GO78Kr9y0tgC5LZ
 F7C2eGnyvcSZb2XTs9E7j2NPGE+kxKgMr4nPe+WxybM7h1A8SEQL3JG+6nIaZJWHmf
 vBcHEmFPv6KgOMR/yvwyv5fA9rlEDeaO6sFoNyT3gyiCTB/jFItXtMLG66ZsGVnsC9
 uTXn93Z2TV5dw==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id F2DEE118007E;
 Tue, 20 Jan 2026 15:14:01 +0100 (CET)
Message-ID: <92def102e5687ce7a27293c569184aa550bf3379.camel@cesnet.cz>
Subject: Re: [PATCH v3 5/6] net/nfb: release allocated resources correctly
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 15:14:01 +0100
In-Reply-To: <20260119161044.552ed2ff@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-6-spinler@cesnet.cz>
 <20260119161044.552ed2ff@phoenix.local>
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

On Mon, 2026-01-19 at 16:10 -0800, Stephen Hemminger wrote:
> On Fri, 16 Jan 2026 16:20:56 +0100
> spinler@cesnet.cz wrote:
>=20
> > From: Martin Spinler <spinler@cesnet.cz>
> >=20
> > Internal handles are initialized in eth_dev_init, so the cleanup
> > should be done in eth_dev_uninit.
> >=20
> > Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> > ---
>=20
> Looks like a bugfix and should have Fixes tag.

Ack.
