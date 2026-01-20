Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44668D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C6EB40E40;
	Tue, 20 Jan 2026 15:14:16 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 59FF540E3F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768918454;
 bh=5ZYmOmzUBiiXz6nlAw/LeqyQ7Lb1jIxu4Q50ygOkPTI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=fLDWvk/95MgazFLqDz2XBs+m88mR8keEBQSvXYk3L7clzp85U8a94SFzBV28kxwOr
 EenmOWFTDSTQrPDzp+qSJ0Ozo9IPXc6hVgSQyZQxHHe1uGqiiBJqzp3I4H2p/OSa/3
 uZZY5R0cdTxLwmswQcJUPckPJ1ZUjRsPrO0hS5/qvd3NePZtjeM2Ppa5nmNFlPutOh
 mEk50/zUXEbiw9RIBZtcxv4xFC3Y6zbEH7w3bE6jwW4Q1hpv6ct/LK53UMNjp1IX/h
 uuMPugt+Wx54stxkpCv3ZDx24KGxI0yYSU9y0szusGAP63Txvzji+KQ4OyQuhajgey
 YKjkGYQiujEBw==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 2B03C1180072;
 Tue, 20 Jan 2026 15:14:14 +0100 (CET)
Message-ID: <c44c9a88c3cbc093f3b80832e767af86643368de.camel@cesnet.cz>
Subject: Re: [PATCH v3 6/6] net/nfb: stop only started queues in fail path
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 15:14:14 +0100
In-Reply-To: <20260119160936.466f9cba@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-7-spinler@cesnet.cz>
 <20260119160936.466f9cba@phoenix.local>
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

On Mon, 2026-01-19 at 16:09 -0800, Stephen Hemminger wrote:
> On Fri, 16 Jan 2026 16:20:57 +0100
> spinler@cesnet.cz wrote:
>=20
> > From: Martin Spinler <spinler@cesnet.cz>
> >=20
> > The driver should stop only running queues in case of error
> > inside eth_dev_start.
> >=20
> > Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> > ---
>=20
> This is a bug fix, shouldn't have a Fixes and CC of stable?

Well, the behaviour of the driver is exactly the same, but the code is
wrong. Ack.
