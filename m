Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8756C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEAB540E6E;
	Mon, 14 Sep 2026 16:44:31 +0200 (CEST)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 16ECD40A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1789397069;
 bh=OzW/8Ctr8RexNpgTc1RiS9pR0oF5SK7Dfs0GwDAEHdw=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=XZjt+iR3WfuxJBjBAFYW9UBa28gEVSlu7p7V/3Sq/REWS1IYTjNF82M+TSZ7qV7oo
 kvCPgtLFptNcD33b876D67YdrOW1OJG35e0XXjhTgHOz21V9bDBnHGXHoOE9YkBig1
 cR/0otLAzEA6ofpQqAzilaLTTqXgFV+sqsE6BwMW82fwEu3idFosR7WebM3obW0m1H
 UEYUuV3DT5nsDk/EfYNp1IGmozi7OfgyIgM0zgKtL9+lhKJOaBKLpMZL3bbew6WBXp
 +4/zDsjnEdzyJSUeorrsdTKfOzayw9dcKD3rvs1cXulxfc+kDayhZ4jekR9uH1Eow7
 0NG58/4Lr+5kg==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id C890A118010A;
 Mon, 14 Sep 2026 16:44:29 +0200 (CEST)
Message-ID: <358d08199abc5eaf9abbc491e4e4370591c9fae3.camel@cesnet.cz>
Subject: Re: [PATCH 34/62] net/nfb: use kvargs numeric helpers
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Date: Mon, 14 Sep 2026 16:44:29 +0200
In-Reply-To: <20260914054912.755403-35-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260914054912.755403-35-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

On Sun, 2026-09-13 at 22:47 -0700, Stephen Hemminger wrote:
> Replace the open coded isdigit(), errno and end pointer checks in
> nfb_eth_dev_create_for_ifc_by_port() with a range checked conversion.
>=20
> The "port >=3D LONG_MAX" test was redundant with the interface count
> check that follows it, since ifc_cnt is far below LONG_MAX.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Martin Spinler <spinler@cesnet.cz>
