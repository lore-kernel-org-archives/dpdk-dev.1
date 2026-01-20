Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C57D2ED16
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F5BD40E8A;
	Tue, 20 Jan 2026 16:16:44 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id CB3F240E72
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768922202;
 bh=RtA0nt/B4QL5KMxtLAPKfYFTEh2zmuBL9iae7cC9fxQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OonGa0XWhCG3No9UBS06lXmGdOHGFRzQjOhJkyCPDcwIqCgcrfMstI0j7oCbfSVDu
 yuky5SH8FABlOzFXvnbnZFHaADyDVdbj3IZ6rXplccQ75hk+cTz0WGacriw1YlEtrF
 9Sm/xlT75G7hKvs8sMc8hO9Nebyzou8ZvT9Ab7NzMJHLIc4Y9N3BMxfygu2JIZ8bgm
 AWAbu3OFFKio+6q4YbyiqZevHuyNER1Iid8dvLV6i5ulsQE9iGi5HXJIn40V7doxSW
 2Gn3ZaqD+eX5qZszrWaNttWhWjFjuSIX9V6tcfDgsD0haU+zyAB5lzgk/EZQ7kd/r7
 aynb3gmwJJpDQ==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 96C591180078;
 Tue, 20 Jan 2026 16:16:42 +0100 (CET)
Message-ID: <931956087a9335959e8a581eb466e4fe88f01118.camel@cesnet.cz>
Subject: Re: [PATCH 4/8] net/nfb: add device argument "port" to limit used
 ports
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 20 Jan 2026 16:16:42 +0100
In-Reply-To: <20260116093602.3fad3610@phoenix.local>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260115151656.393106-5-spinler@cesnet.cz>
 <20260116093602.3fad3610@phoenix.local>
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

On Fri, 2026-01-16 at 09:36 -0800, Stephen Hemminger wrote:
> On Thu, 15 Jan 2026 16:16:52 +0100
> spinler@cesnet.cz wrote:
>=20
> > =20
> > +static int fill_port_mask(const char *key __rte_unused, const char *va=
lue, void *opaque)
> > +{
> > +	int ret =3D 0;
> > +	char *end =3D NULL;
> > +	uint64_t *port_mask =3D opaque;
> > +	int port;
> > +
> > +	port =3D strtol(value, &end, 16);
> > +	if ((value[0] =3D=3D '\0') || (end =3D=3D NULL) || (*end !=3D '\0'))
> > +		ret =3D -1;
> > +
> > +	if (ret !=3D 0 || port >=3D 64 || port < 0)
> > +		return -1;
> > +
> > +	*port_mask |=3D (1ull << port);
> > +	return 0;
> > +}
>=20
> Do you really want to allow negative values, why not use strtoul()
> Also, if there is a limit of 64 this should be a #define or config consta=
nt

Good point, thanks.
Also will use the RTE_BIT64 for port_mask.
