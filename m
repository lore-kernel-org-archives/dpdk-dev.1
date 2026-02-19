Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2E4E9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 06:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8250B402CC;
	Thu, 19 Feb 2026 07:17:27 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 6BBF5402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 07:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771481845;
 bh=/yECynI3b/TMrN2MD4i7ot2XAVuEoZ+cjRTwZ42FvsU=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=QxY3qpC0rVVacxPr20sOOCTKoi83Wgh9ckNcirOzzMyDaeO2xcT86xenDMoSPTBdf
 nXshUry/SB9HvErw3eBPF3gcqA7R7l3OOn0GwrmhN03kI3ANSUIDz+q8E46tzWNMRu
 5wRWi+AuKU5zYnypK0iHP01OVp5kg85M2EM3fUC2N8L8fHnG2/ja+MxcTrH7KelCRw
 9sn81aKDHysEzoP9SqcZcpxnbP2jLWQhZcwZTa8JNHdRFdEzGpaMAXNAwfwt4pT1NT
 FG7Z/sDHHSDod3l1WE2N7rkcs1F//TOsUDwDRdnYBDegSqT977nH6TYYPpzW0FmdXZ
 K+VKIcVA+zZIg==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E87FD11800B6;
 Thu, 19 Feb 2026 07:17:24 +0100 (CET)
Message-ID: <73181990690a4db48275b94f434913b601c3be4d.camel@cesnet.cz>
Subject: Re: [PATCH] net/nfb: fix eth_node memory leak in deinit
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Date: Thu, 19 Feb 2026 07:17:24 +0100
In-Reply-To: <20260218181621.1066237-1-stephen@networkplumber.org>
References: <20260218181621.1066237-1-stephen@networkplumber.org>
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

Thank you. Can be squashed, but it's OK this way.

Acked-by: Martin Spinler <spinler@cesnet.cz>

On Wed, 2026-02-18 at 10:16 -0800, Stephen Hemminger wrote:
> The eth_node array allocated with calloc() in nfb_nc_eth_init() is
> freed on the error path but not in the normal teardown path via
> nfb_nc_eth_deinit(). Add the missing free().
>=20
> Fixes: 9b173c0f89 ("net/nfb: get correct link speed")
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/nfb/nfb_ethdev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
> index e267dca9af..ba7c849a4b 100644
> --- a/drivers/net/nfb/nfb_ethdev.c
> +++ b/drivers/net/nfb/nfb_ethdev.c
> @@ -186,6 +186,7 @@ nfb_nc_eth_deinit(struct pmd_internals *intl)
>  	for (i =3D 0; i < intl->max_rxmac; i++)
>  		nc_rxmac_close(intl->rxmac[i]);
> =20
> +	free(intl->eth_node);
>  	free(intl->txmac);
>  	free(intl->rxmac);
>  }
