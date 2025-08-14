Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2107CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 09:04:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB13402A8;
	Thu, 14 Aug 2025 11:04:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7349A4026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 11:04:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 317A72051E;
 Thu, 14 Aug 2025 11:04:22 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 1/1] ethdev: add support to provide link type
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 14 Aug 2025 11:04:18 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
In-Reply-To: <20250814081215.1904078-1-skori@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 1/1] ethdev: add support to provide link type
Thread-Index: AdwM8y2gJJFP2yOwTjOYAzysfQqsEgAA26yA
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <skori@marvell.com>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: <dev@dpdk.org>,
	"Nithin Dabilpuram" <ndabilpuram@marvell.com>
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

> From: skori@marvell.com [mailto:skori@marvell.com]
> Sent: Thursday, 14 August 2025 10.10
>=20
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
>=20
> Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> to a readable string.

Please consider if "connector" is a better name than "link type", if =
this is related to physical interfaces only.
E.g. is there an "LACP" link type for link aggregates (bonded links)?

Also, should a "virtual" link type (or connector) be added for =
TAP/Virtio/VMXNET3/ring and similar non-physical interfaces?

More comments inline below.

>=20
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
> v3..v4:
>  - Convert #define into enum.
>  - Enhance comments for each port link type.
>  - Fix test failures.
> v2..v3
>  - Extend link type list as per suggestion
>  app/test/test_ethdev_link.c      | 18 +++++++-----
>  lib/ethdev/ethdev_trace.h        |  7 +++++
>  lib/ethdev/ethdev_trace_points.c |  3 ++
>  lib/ethdev/rte_ethdev.c          | 46 ++++++++++++++++++++++++++++--
>  lib/ethdev/rte_ethdev.h          | 48 =
++++++++++++++++++++++++++++++++
>  5 files changed, 113 insertions(+), 9 deletions(-)
>=20
> diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
> index f063a5fe26..5d1a784208 100644
> --- a/app/test/test_ethdev_link.c
> +++ b/app/test/test_ethdev_link.c
> @@ -17,23 +17,25 @@ test_link_status_up_default(void)
>  		.link_speed =3D RTE_ETH_SPEED_NUM_2_5G,
>  		.link_status =3D RTE_ETH_LINK_UP,
>  		.link_autoneg =3D RTE_ETH_LINK_AUTONEG,
> -		.link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX
> +		.link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX,
> +		.link_type =3D RTE_ETH_LINK_TYPE_NONE

RTE_ETH_LINK_TYPE_UNKNOWN

>  	};
>  	char text[RTE_ETH_LINK_MAX_STR_LEN];
>=20
>  	ret =3D rte_eth_link_to_str(text, sizeof(text), &link_status);
>  	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
>  	printf("Default link up #1: %s\n", text);
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg",
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 2.5 Gbps FDX Autoneg =
None",

"Link up at 2.5 Gbps FDX Autoneg Unknown"

>  		text, strlen(text), "Invalid default link status string");
>=20
>  	link_status.link_duplex =3D RTE_ETH_LINK_HALF_DUPLEX;
>  	link_status.link_autoneg =3D RTE_ETH_LINK_FIXED;
>  	link_status.link_speed =3D RTE_ETH_SPEED_NUM_10M;
> +	link_status.link_type =3D RTE_ETH_LINK_TYPE_SGMII;
>  	ret =3D rte_eth_link_to_str(text, sizeof(text), &link_status);
>  	printf("Default link up #2: %s\n", text);
>  	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 10 Mbps HDX Fixed",
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at 10 Mbps HDX Fixed SGMII",
>  		text, strlen(text), "Invalid default link status "
>  		"string with HDX");
>=20
> @@ -41,7 +43,7 @@ test_link_status_up_default(void)
>  	ret =3D rte_eth_link_to_str(text, sizeof(text), &link_status);
>  	printf("Default link up #3: %s\n", text);
>  	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Unknown HDX Fixed",
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Unknown HDX Fixed SGMII",
>  		text, strlen(text), "Invalid default link status "
>  		"string with HDX");
>=20
> @@ -49,7 +51,7 @@ test_link_status_up_default(void)
>  	ret =3D rte_eth_link_to_str(text, sizeof(text), &link_status);
>  	printf("Default link up #3: %s\n", text);
>  	RTE_TEST_ASSERT(ret > 0, "Failed to format default string\n");
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at None HDX Fixed",
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at None HDX Fixed SGMII",
>  		text, strlen(text), "Invalid default link status "
>  		"string with HDX");
>=20
> @@ -57,6 +59,7 @@ test_link_status_up_default(void)
>  	link_status.link_speed =3D RTE_ETH_SPEED_NUM_400G;
>  	link_status.link_duplex =3D RTE_ETH_LINK_HALF_DUPLEX;
>  	link_status.link_autoneg =3D RTE_ETH_LINK_AUTONEG;
> +	link_status.link_type =3D RTE_ETH_LINK_TYPE_GAUI;
>  	ret =3D rte_eth_link_to_str(text, sizeof(text), &link_status);
>  	printf("Default link up #4:len =3D %d, %s\n", ret, text);
>  	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
> @@ -92,7 +95,8 @@ test_link_status_invalid(void)
>  		.link_speed =3D 55555,
>  		.link_status =3D RTE_ETH_LINK_UP,
>  		.link_autoneg =3D RTE_ETH_LINK_AUTONEG,
> -		.link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX
> +		.link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX,
> +		.link_type =3D RTE_ETH_LINK_TYPE_UNKNOWN
>  	};
>  	char text[RTE_ETH_LINK_MAX_STR_LEN];
>=20
> @@ -100,7 +104,7 @@ test_link_status_invalid(void)
>  	RTE_TEST_ASSERT(ret < RTE_ETH_LINK_MAX_STR_LEN,
>  		"Failed to format invalid string\n");
>  	printf("invalid link up #1: len=3D%d %s\n", ret, text);
> -	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg",
> +	TEST_ASSERT_BUFFERS_ARE_EQUAL("Link up at Invalid FDX Autoneg =
Unknown",
>  		text, strlen(text), "Incorrect invalid link status string");
>=20
>  	return TEST_SUCCESS;
> diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
> index 482befc209..c5cba0edba 100644
> --- a/lib/ethdev/ethdev_trace.h
> +++ b/lib/ethdev/ethdev_trace.h
> @@ -2110,6 +2110,13 @@ RTE_TRACE_POINT_FP(
>  	rte_trace_point_emit_string(ret);
>  )
>=20
> +RTE_TRACE_POINT_FP(
> +	rte_eth_trace_link_type_to_str,
> +	RTE_TRACE_POINT_ARGS(uint8_t link_type, const char *ret),
> +	rte_trace_point_emit_u8(link_type);
> +	rte_trace_point_emit_string(ret);
> +);
> +
>  /* Called in loop in examples/bond and examples/ethtool */
>  RTE_TRACE_POINT_FP(
>  	rte_eth_trace_macaddr_get,
> diff --git a/lib/ethdev/ethdev_trace_points.c
> b/lib/ethdev/ethdev_trace_points.c
> index 071c508327..706acdf356 100644
> --- a/lib/ethdev/ethdev_trace_points.c
> +++ b/lib/ethdev/ethdev_trace_points.c
> @@ -206,6 +206,9 @@ =
RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_speed_to_str,
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_to_str,
>  	lib.ethdev.link_to_str)
>=20
> +RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_type_to_str,
> +	lib.ethdev.link_type_to_str)
> +
>  RTE_TRACE_POINT_REGISTER(rte_eth_trace_stats_get,
>  	lib.ethdev.stats_get)
>=20
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..db496d70c4 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3285,18 +3285,60 @@ rte_eth_link_to_str(char *str, size_t len, =
const
> struct rte_eth_link *eth_link)
>  	if (eth_link->link_status =3D=3D RTE_ETH_LINK_DOWN)
>  		ret =3D snprintf(str, len, "Link down");
>  	else
> -		ret =3D snprintf(str, len, "Link up at %s %s %s",
> +		ret =3D snprintf(str, len, "Link up at %s %s %s %s",
>  			rte_eth_link_speed_to_str(eth_link->link_speed),
>  			(eth_link->link_duplex =3D=3D RTE_ETH_LINK_FULL_DUPLEX) ?
>  			"FDX" : "HDX",
>  			(eth_link->link_autoneg =3D=3D RTE_ETH_LINK_AUTONEG) ?
> -			"Autoneg" : "Fixed");
> +			"Autoneg" : "Fixed",
> +			rte_eth_link_type_to_str(eth_link->link_type));
>=20
>  	rte_eth_trace_link_to_str(len, eth_link, str, ret);
>=20
>  	return ret;
>  }
>=20
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_type_to_str, 25.11)
> +const char *
> +rte_eth_link_type_to_str(enum rte_eth_link_type link_type)
> +{
> +	static const char * const link_type_str[] =3D {
> +		[RTE_ETH_LINK_TYPE_NONE] =3D "None",
> +		[RTE_ETH_LINK_TYPE_TP] =3D "Twisted Pair",
> +		[RTE_ETH_LINK_TYPE_AUI] =3D "Attachment Unit Interface",
> +		[RTE_ETH_LINK_TYPE_MII] =3D "Media Independent Interface",
> +		[RTE_ETH_LINK_TYPE_FIBER] =3D "Fiber",
> +		[RTE_ETH_LINK_TYPE_BNC] =3D "BNC",
> +		[RTE_ETH_LINK_TYPE_DA] =3D "Direct Attach Copper",

RTE_ETH_LINK_TYPE_DAC

> +		[RTE_ETH_LINK_TYPE_SGMII] =3D "SGMII",
> +		[RTE_ETH_LINK_TYPE_QSGMII] =3D "QSGMII",
> +		[RTE_ETH_LINK_TYPE_XFI] =3D "XFI",
> +		[RTE_ETH_LINK_TYPE_SFI] =3D "SFI",
> +		[RTE_ETH_LINK_TYPE_XLAUI] =3D "XLAUI",
> +		[RTE_ETH_LINK_TYPE_GAUI] =3D "GAUI",
> +		[RTE_ETH_LINK_TYPE_XAUI] =3D "XAUI",
> +		[RTE_ETH_LINK_TYPE_CAUI] =3D "CAUI",
> +		[RTE_ETH_LINK_TYPE_LAUI] =3D "LAUI",
> +		[RTE_ETH_LINK_TYPE_SFP] =3D "SFP",
> +		[RTE_ETH_LINK_TYPE_SFP_DD] =3D "SFP_DD",

"SFP-DD"

> +		[RTE_ETH_LINK_TYPE_SFP_PLUS] =3D "SFP_PLUS",

"SFP+"

> +		[RTE_ETH_LINK_TYPE_SFP28] =3D "SFP28",
> +		[RTE_ETH_LINK_TYPE_QSFP] =3D "QSFP",
> +		[RTE_ETH_LINK_TYPE_QSFP_PLUS] =3D "QSFP_PLUS",

"QSFP+"

> +		[RTE_ETH_LINK_TYPE_QSFP28] =3D "QSFP28",
> +		[RTE_ETH_LINK_TYPE_QSFP56] =3D "QSFP56",
> +		[RTE_ETH_LINK_TYPE_QSFP_DD] =3D "QSFP_DD",

"QSFP-DD"

> +		[RTE_ETH_LINK_TYPE_UNKNOWN] =3D "Unknown"
> +	};
> +	const char *str =3D NULL;
> +
> +	if ((link_type < RTE_DIM(link_type_str)) && =
link_type_str[link_type])
> +		str =3D link_type_str[link_type];
> +
> +	rte_eth_trace_link_type_to_str(link_type, str);
> +	return str;
> +}
> +
>  RTE_EXPORT_SYMBOL(rte_eth_stats_get)
>  int
>  rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index f9fb6ae549..92d1ded51f 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -329,6 +329,39 @@ struct rte_eth_stats {
>  #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
>  /**@}*/
>=20
> +/**@{@name PORT type
> + * Ethernet port link type
> + */
> +enum rte_eth_link_type {
> +	RTE_ETH_LINK_TYPE_NONE =3D 0, /**< Not defined */
> +	RTE_ETH_LINK_TYPE_TP,       /**< Twisted Pair */
> +	RTE_ETH_LINK_TYPE_AUI,      /**< Attachment Unit Interface */
> +	RTE_ETH_LINK_TYPE_MII,      /**< Media Independent Interface */
> +	RTE_ETH_LINK_TYPE_FIBER,    /**< Optical Fiber Link */
> +	RTE_ETH_LINK_TYPE_BNC,      /**< BNC Link type for RF connection */
> +	RTE_ETH_LINK_TYPE_DA,       /**< Direct Attach copper */
> +	RTE_ETH_LINK_TYPE_SGMII,    /**< Serial Gigabit Media Independent
> Interface */
> +	RTE_ETH_LINK_TYPE_QSGMII,   /**< Link to multiplex 4 SGMII over one
> serial link */
> +	RTE_ETH_LINK_TYPE_XFI,      /**< 10 Gigabit Attachment Unit =
Interface */
> +	RTE_ETH_LINK_TYPE_SFI,      /**< 10 Gigabit Serial Interface for =
optical
> networking */
> +	RTE_ETH_LINK_TYPE_XLAUI,    /**< 40 Gigabit Attachment Unit =
Interface */
> +	RTE_ETH_LINK_TYPE_GAUI,     /**< Gigabit Interface for bandwidth =
like
> 50/100/200 Gbps */
> +	RTE_ETH_LINK_TYPE_XAUI,     /**< 10 Gigabit Attachment Unit =
Interface */
> +	RTE_ETH_LINK_TYPE_CAUI,     /**< 100 Gigabit Attachment Unit =
Interface
> */
> +	RTE_ETH_LINK_TYPE_LAUI,     /**< 50 Gigabit Attachment Unit =
Interface */
> +	RTE_ETH_LINK_TYPE_SFP,      /**< Pluggable module for 1 Gigabit */
> +	RTE_ETH_LINK_TYPE_SFP_PLUS, /**< Pluggable module for 10 Gigabit */
> +	RTE_ETH_LINK_TYPE_SFP28,    /**< Pluggable module for 25 Gigabit */
> +	RTE_ETH_LINK_TYPE_SFP_DD,   /**< Pluggable module for 100 Gigabit */
> +	RTE_ETH_LINK_TYPE_QSFP,     /**< Module to mutiplex 4 SFP i.e. =
4*1=3D4
> Gigabit */
> +	RTE_ETH_LINK_TYPE_QSFP_PLUS,/**< Module to mutiplex 4 SFP_PLUS i.e.
> 4*10=3D40 Gigabit */
> +	RTE_ETH_LINK_TYPE_QSFP28,   /**< Module to mutiplex 4 SFP28 i.e.
> 4*25=3D100 Gigabit */
> +	RTE_ETH_LINK_TYPE_QSFP56,   /**< Module to mutiplex 4 SFP56 i.e.
> 4*50=3D200 Gigabit */
> +	RTE_ETH_LINK_TYPE_QSFP_DD,  /**< Module to mutiplex 4 SFP_DD i.e.
> 4*100=3D400 Gigabit */
> +	RTE_ETH_LINK_TYPE_UNKNOWN =3D 31, /**< Unknown Link Type */

For reference, we do have both RTE_ETH_SPEED_NUM_NONE and =
RTE_ETH_SPEED_NUM_UNKNOWN, where RTE_ETH_SPEED_NUM_NONE represents "link =
down, zero speed", and RTE_ETH_SPEED_NUM_UNKNOWN represents "link up, =
unknown speed".

But I doubt we need both RTE_ETH_LINK_TYPE_NONE and =
RTE_ETH_LINK_TYPE_UNKNOWN...
I agree that we need a value to represent "connector type unknown", but =
do we also need a value to represent "connector not present"? When can a =
port have no connector?

> +};
> +/**@}*/
> +
>  /**
>   * A structure used to retrieve link-level information of an Ethernet =
port.
>   */
> @@ -341,6 +374,7 @@ struct rte_eth_link {
>  			uint16_t link_duplex  : 1;  /**<
> RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
>  			uint16_t link_autoneg : 1;  /**<
> RTE_ETH_LINK_[AUTONEG/FIXED] */
>  			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
> +			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
>  		};
>  	};
>  };
> @@ -3116,6 +3150,20 @@ int rte_eth_link_get_nowait(uint16_t port_id, =
struct
> rte_eth_link *link)
>  __rte_experimental
>  const char *rte_eth_link_speed_to_str(uint32_t link_speed);
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * This function converts an Ethernet link type to a string.
> + *
> + * @param link_type
> + *   The link type to convert.
> + * @return
> + *   The string representation of the link type.
> + */
> +__rte_experimental
> +const char *rte_eth_link_type_to_str(enum rte_eth_link_type =
link_type);
> +
>  /**
>   * @warning
>   * @b EXPERIMENTAL: this API may change without prior notice.
> --
> 2.43.0

