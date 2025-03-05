Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A71BC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74A2B40156;
	Wed,  5 Mar 2025 10:00:36 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 09786400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:00:34 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id ACC7920FF3;
 Wed,  5 Mar 2025 10:00:34 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] net/mana: avoid the use of variable length array
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 5 Mar 2025 10:00:33 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FABF@smartserver.smartshare.dk>
In-Reply-To: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/mana: avoid the use of variable length array
Thread-Index: AduNZtGdG7CN/9E2S6qAvyy4LoS2RAARPORw
References: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <longli@linuxonhyperv.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wei Hu" <weh@microsoft.com>
Cc: <dev@dpdk.org>,
	"Long Li" <longli@microsoft.com>
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

> From: longli@linuxonhyperv.com [mailto:longli@linuxonhyperv.com]
> Sent: Wednesday, 5 March 2025 01.38
>=20
> From: Long Li <longli@microsoft.com>
>=20
> The pathname can be defined as name[MAX_PATH]. This makes the driver
> compilable using MSVC.

The name is PATH_MAX, not MAX_PATH. It's correct in the code.

>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/mana/mana.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
> index c37c4e3444..d12dff6ce1 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -36,11 +36,8 @@ static rte_spinlock_t mana_shared_data_lock =3D
> RTE_SPINLOCK_INITIALIZER;
>=20
>  /* Allocate a buffer on the stack and fill it with a printf format
> string. */
>  #define MANA_MKSTR(name, ...) \

The macro is no longer generic, but tied to a path name, so the macro's =
name and description should be updated accordingly. E.g.:

/* Allocate a path name buffer on the stack and fill it with a printf =
format string. */
#define MANA_MKPATHSTR(name, ...) \

Don't forget search-replace for uses of the macro. (It's being used 6 =
times in this file.)

> -	int mkstr_size_##name =3D snprintf(NULL, 0, "" __VA_ARGS__); \
> -	char name[mkstr_size_##name + 1]; \
> -	\
> -	memset(name, 0, mkstr_size_##name + 1); \
> -	snprintf(name, sizeof(name), "" __VA_ARGS__)
> +	char name[PATH_MAX]; \
> +	snprintf(name, PATH_MAX, "" __VA_ARGS__)
>=20
>  int mana_logtype_driver;
>  int mana_logtype_init;
> --
> 2.34.1

With suggested changes,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

