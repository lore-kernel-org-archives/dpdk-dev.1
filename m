Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44034CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 00:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 060AB4028D;
	Wed, 29 Oct 2025 01:15:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BF88C40262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 01:15:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B6EA6206CD;
 Wed, 29 Oct 2025 01:15:28 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] bitmap: change return value of rte_bitmap_free
Date: Wed, 29 Oct 2025 01:15:23 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65512@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251028204432.880074-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bitmap: change return value of rte_bitmap_free
Thread-Index: AdxIS69dApWzcEUiSxmH4CDpRMnEtgAHOxtQ
References: <20251028204432.880074-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Cristian Dumitrescu" <cristian.dumitrescu@intel.com>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Tuesday, 28 October 2025 21.45
>=20
> No existing code is checking the return value of rte_bitmap_free
> and other functions like rte_free do not return an int.
> Change it to just a stub void function.
>=20
> This was motivated by Coverity warnings about unchecked return
> value.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thank you for cleaning up this.

With or without suggestion inline below,
Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

>  /**
> - * Bitmap free
> + * Bitmap free does nothing in current version.

Consider keeping the original headline and adding a note that it does =
nothing in current version instead.

>   *
>   * @param bmp
>   *   Handle to bitmap instance
> - * @return
> - *   0 upon success, error code otherwise
>   */
> -static inline int
> -rte_bitmap_free(struct rte_bitmap *bmp)
> +static inline void
> +rte_bitmap_free(struct rte_bitmap *bmp __rte_unused)
>  {
> -	/* Check input arguments */
> -	if (bmp =3D=3D NULL) {
> -		return -1;
> -	}
> -
> -	return 0;
>  }

