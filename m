Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D67C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6213840270;
	Thu,  5 Jun 2025 16:57:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1ACCC40150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:57:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D114820467;
 Thu,  5 Jun 2025 16:57:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v6 1/1] net/intel: define __builtin_add_overflow for MSVC
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 5 Jun 2025 16:57:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCCB@smartserver.smartshare.dk>
In-Reply-To: <1749134845-30062-2-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 1/1] net/intel: define __builtin_add_overflow for MSVC
Thread-Index: AdvWKMS8c4COhsQOSfm05AHubItPFAAAFp5Q
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1749134845-30062-1-git-send-email-andremue@linux.microsoft.com>
 <1749134845-30062-2-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>,
 "David Marchand" <david.marchand@redhat.com>, <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	"Stephen Hemminger" <stephen@networkplumber.org>
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

+TO: David and Thomas, were part of the discussion
+CC: Stephen

> From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> Sent: Thursday, 5 June 2025 16.47
>=20
> __builtin_add_overflow is gcc specific. A macro needs to be defined
> for code using this to be compiled with MSVC.
> Since only one driver is using this, this patch adds the macro to
> that driver only. It can be moved to some common place if/when
> needed.

This seems to be consensus over adding it to rte_math.h, so:
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_osdep.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/intel/ice/base/ice_osdep.h
> b/drivers/net/intel/ice/base/ice_osdep.h
> index ad6cde9896..4f635f00a4 100644
> --- a/drivers/net/intel/ice/base/ice_osdep.h
> +++ b/drivers/net/intel/ice/base/ice_osdep.h
> @@ -128,6 +128,15 @@ writeq(uint64_t value, volatile void *addr)
>  #define wr64(a, reg, value) writeq((value), (a)->hw_addr + (reg))
>  #define rd64(a, reg)        readq((a)->hw_addr + (reg))
>=20
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __builtin_add_overflow(a, b, res) \
> +	_Generic((a), \
> +		uint8_t : _addcarry_u8, \
> +		uint16_t : _addcarry_u16, \
> +		uint32_t : _addcarry_u32, \
> +		uint64_t : _addcarry_u64)(0, a, b, res)
> +#endif
> +
>  #endif /* __INTEL_NET_BASE_OSDEP__ */
>=20
>  #ifndef __always_unused
> --
> 2.49.0.vfs.0.3

