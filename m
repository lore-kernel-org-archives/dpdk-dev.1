Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF4E63F12
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 21:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5FA44028B;
	Sun, 15 Feb 2026 22:45:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 63E6140274
 for <dev@dpdk.org>; Sun, 15 Feb 2026 22:45:57 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2EC2C20F80;
 Sun, 15 Feb 2026 22:45:57 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Date: Sun, 15 Feb 2026 22:45:53 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6571C@smartserver.smartshare.dk>
In-Reply-To: <20260215195348.557945-4-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 03/10] net/tap: clarify TUN/TAP flag assignment
Thread-Index: AdyetOJv9oynk4q/Qh2dRtKdlosadgADo9Eg
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260215195348.557945-4-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> Replace a ternary expression that relied on operator precedence
> between '?:' and '|' with an explicit if/else. No functional change.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/tap/rte_eth_tap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/tap/rte_eth_tap.c
> b/drivers/net/tap/rte_eth_tap.c
> index aa236cf967..31c8c185e9 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -154,8 +154,11 @@ tun_alloc(struct pmd_internals *pmd, int
> is_keepalive, int persistent)
>  	 * Do not set IFF_NO_PI as packet information header will be
> needed
>  	 * to check if a received packet has been truncated.
>  	 */
> -	ifr.ifr_flags =3D (pmd->type =3D=3D ETH_TUNTAP_TYPE_TAP) ?
> -		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;

For unconditional assignment, I prefer ternary expression over if/else.
If you want to improve readability instead of relying on operator =
precedence, suggest:

	ifr.ifr_flags =3D (pmd->type =3D=3D ETH_TUNTAP_TYPE_TAP) ?
			IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);

> +	if (pmd->type =3D=3D ETH_TUNTAP_TYPE_TAP)
> +		ifr.ifr_flags =3D IFF_TAP;
> +	else
> +		ifr.ifr_flags =3D IFF_TUN | IFF_POINTOPOINT;
> +
>  	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
>=20
>  	fd =3D open(TUN_TAP_DEV_PATH, O_RDWR);
> --
> 2.51.0

