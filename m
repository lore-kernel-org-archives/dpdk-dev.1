Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6240FE8385B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 07:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6075C402A2;
	Tue, 17 Feb 2026 08:09:42 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9CFD24029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 08:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771312180;
 bh=2zfy8jjf6k1EE7E6AdeNKelZRK1tVgPZc62DbszpAjI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=j64VzTEbpSWDXd+fYkhrB6g0j7rRKFbSp+wmVWHvuzMfk9bvKQNOErSZ0FJI/UiX7
 3cy5RleOQLT1HbakxhwJribS3ty/FqfIlk3wlPXZ3XsY91M37QNTHIPNyrxWLZbgHj
 D40H26nIs6wqiew63Q7oKRtDWGTvptvAjASz6Uxb7497MRuRRd8nE5Cd94FbETMFtg
 2+9s7W3IMuTCSUIcSJ+zKXyHMJoWrt2ays1tMR51okcYrWNgbvUTnna94E9TkzQKAu
 5126pMZL84pdNT+M71QShlQoWR4oI3LdFlUCuNAYW7t7LG8iDcNSFGMfeWsJTrJOI0
 kRM0qa+rJQ9cw==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 5A9D31180086;
 Tue, 17 Feb 2026 08:09:40 +0100 (CET)
Message-ID: <06bb3288b409107ddf125fba93219c9a7ed6a2b7.camel@cesnet.cz>
Subject: Re: [PATCH v9 0/8] net/nfb: rework to real multiport
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 17 Feb 2026 08:09:40 +0100
In-Reply-To: <20260216141104.5055879c@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260216162506.2702066-1-spinler@cesnet.cz>
 <20260216141104.5055879c@phoenix.local>
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

> After some feedback to the AI review. It still had minor feedback, do you=
 want more detail?
> I can take this as is or you can send new version.

I think I can address only one warning from the AI review:
the propagated return value in Patch 4.

> Patch 2: If rte_eth_dev_create() succeeds but rte_eth_dev_get_by_name()
> returns NULL, the created device is never added to the cleanup TAILQ
> and leaks.

The rte_eth_dev_create() does not return rte_eth_dev*, so I don't have
a handle to cleanup something with rte_eth_dev_destroy().

The only solution that comes to my mind, is to add the rte_eth_dev
temporary handle to let say a second 'temporary' TAILQ list inside
nfb_eth_dev_init() (called in rte_eth_dev_create()), which will be
checked after the rte_eth_dev_create() returns. However, it's still
messy and doesn't solve the problem comprehensively.

> Patch 3: nfb_default_dev_path() return value used without NULL check befo=
re passing to nfb_open().

Both is fine (nfb_default_dev_path doesn't returns NULL, nfb_open can
handle NULL: calls nfb_default_dev_path() internally in that case).

> Patch 4: The kvargs callback returns errors from input validation (e.g., =
bad port string) but ifc_params.ret is only set after nfb_eth_dev_create_fo=
r_ifc, so the caller can overwrite the real error with 0.

Fixed in v10.


> Patch 8: Release notes don't mention the new vdev/simulation support from=
 patch 3.

Quite a minor feature.
