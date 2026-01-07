Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CFCD5822
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 10:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E42840267;
	Wed,  7 Jan 2026 11:28:36 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 27C404021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 11:28:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmPQ6237YzJ467F;
 Wed,  7 Jan 2026 18:28:30 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BCA040571;
 Wed,  7 Jan 2026 18:28:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 11:28:33 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 7 Jan 2026 11:28:33 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 03/12] net/pcap: use bool for flags
Thread-Topic: [PATCH 03/12] net/pcap: use bool for flags
Thread-Index: AQHcfzsNszFR4cJ6ukWSCmO4WMucw7VGeZzw
Date: Wed, 7 Jan 2026 10:28:32 +0000
Message-ID: <4b0f415322e2457d93b695469847b113@huawei.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260106182823.192350-4-stephen@networkplumber.org>
In-Reply-To: <20260106182823.192350-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 6 January 2026 18:27
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH 03/12] net/pcap: use bool for flags
>=20
> Save some space by using bool for flag values.
> Use common code to parse value of a boolean flag.

Note that there might technically be some performance cost of this. Said th=
at,=20
since original code did not leave any comments why ints were used, let's th=
ink=20
it was not on purpose, while bools are cleaner and less error-prone.

I however think that proper bool conversion should use true or false on=20
assignment/initialization, not 1 or 0.

// snip

> @@ -1180,31 +1181,29 @@ open_tx_iface(const char *key, const char *value,=
 void *extra_args)
>  }
>=20
>  static int
> -select_phy_mac(const char *key __rte_unused, const char *value,
> -		void *extra_args)
> +process_bool_flag(const char *key, const char *value, void *extra_args)

This function probably belongs in some common library. There is a similar c=
ode=20
in lib/argparse/rte_argparse.c and lib/cmdline/cmdline_parse_bool.c that mi=
ght=20
benefit. Having some tests could also be useful.

I would also think of naming more, word "process" does not really convey mu=
ch=20
meaning. How about "parse_bool"?

>  {
> -	if (extra_args) {
> -		const int phy_mac =3D atoi(value);
> -		int *enable_phy_mac =3D extra_args;
> -
> -		if (phy_mac)
> -			*enable_phy_mac =3D 1;
> -	}
> -	return 0;
> -}
> +	bool *flag =3D extra_args;
> +	/* table of possible representation of boolean */
> +	static const char * const values[] =3D {
> +		"false", "true",
> +		"0", "1",
> +		"disable", "enable",
> +		"on", "off",

Last pair is swapped.

> +	};
>=20
> -static int
> -get_infinite_rx_arg(const char *key __rte_unused,
> -		const char *value, void *extra_args)
> -{
> -	if (extra_args) {
> -		const int infinite_rx =3D atoi(value);
> -		int *enable_infinite_rx =3D extra_args;
> +	for (unsigned int i =3D 0; i < RTE_DIM(values); i++) {
> +		if (strcmp(value, values[i]) =3D=3D 0) {

Maybe strcasecmp (just suggesting)?

> +			*flag =3D !!(i & 1);
>=20
> -		if (infinite_rx > 0)
> -			*enable_infinite_rx =3D 1;
> +			PMD_LOG(INFO, "%s set to %s",
> +				key, *flag ? "true" : "false");

Should we have a common use {"false", "true"} inline function somewhere?=20
Logging of infinite_rx in the same file could use it, as well as a few othe=
r=20
places.

> +			return 0;
> +		}
>  	}
> -	return 0;
> +
> +	PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
> +	return -1;
>  }
