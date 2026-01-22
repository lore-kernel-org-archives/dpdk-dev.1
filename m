Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E19DD3EE64
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4721B4027A;
	Thu, 22 Jan 2026 14:13:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CF4684021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:13:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 253B320AD6;
 Thu, 22 Jan 2026 14:13:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Date: Thu, 22 Jan 2026 14:13:06 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260122122354.1820368-4-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Thread-Index: AdyLmg9X1LBKBy1mS/OJFobyY7rhhAABFlqw
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 22 January 2026 13.24
>=20
> Having the net_null driver always available can be convenient and
> allows
> use by unit tests, so add this trivial driver to the always-enable
> list.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> ---
> I'm not sure if we want this to be always enabled or not, so sending
> this as an RFC. I can see definite advantages to doing so, but I also
> dislike having too many components on the always-enable list.
>=20
> Since I'm ambivilent myself, including this patch so the community can
> decide.

I don't think real applications use this.
If they do, they can include it manually.

My main objection is:
We are setting the wrong precedence if we make stuff like this mandatory =
for convenience.

But I agree with the reason you are suggesting it.

Is there some other way it can be enabled for unit tests?
Maybe the null driver can depend on the unit tests being built?

I don't mind that the driver is being built.
I just don't want it included by default when statically linking a =
monolithic application.

I'm flexible on this RFC, so it's a very soft NAK from me.
If it can be disabled at build time, I'm OK with it. (But still =
concerned about setting the wrong precedence.)

> ---
>  drivers/meson.build | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 3fe3be48fb..9ed0dba786 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -80,6 +80,8 @@ endif
>  always_enable =3D ['bus/pci', 'bus/vdev']
>  # we always need a mempool driver, and ring is default, so make it
> mandatory
>  always_enable +=3D ['mempool/ring']
> +# unit tests take advantage of net/null driver, so always enable it
> +always_enable +=3D ['net/null']
>  enable_drivers +=3D always_enable
>=20
>  default_cflags =3D machine_args
> --
> 2.51.0

