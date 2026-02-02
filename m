Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A1BE7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2852A4027D;
	Mon,  2 Feb 2026 19:58:21 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 18C604026D;
 Mon,  2 Feb 2026 19:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770058699;
 bh=30Fw3HnHmMbI4oYOZzPSd0M40R+CbAftqV7MxR3XNTI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=G+faZDZKMdVpR9GF/Y+C2KZBREG9/tgWwolb5Z23/T9yqP3p0lz+lzKEnkclEytTV
 JDhAvI1j8CzFOORmb6/nl+O3jJZJQlOvDqiMXRpBXLgAIw7sQGjPngKEk7IB/tO3PF
 JAdZ4mh3WyU6fwrlRlX8dF9XTLePpaWRCSo2kG0yq7ajhaMSPe80BFTvsvaIPaB49E
 kIvz9T6bD/cuonTvF0cLRoH4GFJXt5PlRxzWDjLNkJovmawRbNCvCUR9RplohYuU/N
 dpW75N0e1E8rgUz0mOkb/IAyOaO2w01r3VEsTxU7mX2VEzvFFW9qJkwenW1KbyeG8u
 BjcO7eBUjTdWw==
Received: from [IPv6:2a00:1028:83a6:8aa::305]
 (dynamic-2a00-1028-83a6-08aa-0000-0000-0000-0305.ipv6.o2.cz
 [IPv6:2a00:1028:83a6:8aa::305])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id A0D1C1180078;
 Mon,  2 Feb 2026 19:58:19 +0100 (CET)
Message-ID: <e491ba818c5c80ffb94e39a21a54b3b3ee2d72e3.camel@cesnet.cz>
Subject: Re: [PATCH v3 1/6] net/nfb: use constant values for max Rx/Tx
 queues count
From: Martin =?UTF-8?Q?=C5=A0pinler?= <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
Date: Mon, 02 Feb 2026 19:58:14 +0100
In-Reply-To: <20260202094733.144a4e73@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-2-spinler@cesnet.cz>
 <20260202094733.144a4e73@phoenix.local>
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

> This patch does not apply cleanly to main or next-net branch.
> Please rebase.

Oh, I'm sorry. My old patch was based on next-net-for-main, where is
included your commit: "net/nfb: remove unused attribute".

Rebasing on next-net-main
