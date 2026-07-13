Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001F1C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 14:07:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0EC140276;
	Mon, 13 Jul 2026 16:07:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3E9B740041
 for <dev@dpdk.org>; Mon, 13 Jul 2026 16:07:31 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0061D2033E;
 Mon, 13 Jul 2026 16:07:30 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: sxe2 driver bug due to mempool layer violation
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:07:29 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6596B@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6596A@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sxe2 driver bug due to mempool layer violation
Thread-Index: Ad0Sv8V+9EqmdmljRiqV2lDLvHpGjAADwbmQ
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <98CBD80474FA8B44BF855DF32C47DC35F6596A@smartserver.smartshare.dk>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Jie Liu" <liujie5@linkdatatechnology.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
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

> From: Morten Br=F8rup [mailto:mb@smartsharesystems.com]
> Sent: Monday, 13 July 2026 14.05
>=20
> Hi Jie Liu,
>=20
> Your sxe2 driver is accessing the flushthresh field in the mempool
> structure [1].
> This field is obsolete, as the mempool cache algorithm has been =
updated
> [2].
> If you need to bypass the mempool API and work directly with mempool
> internals, please keep your code up to date with the internals of the
> mempool library implementation.
>=20
> Please submit an updated version of your driver, or the patch to
> support AVX512 needs to be reverted. Jie Liu

As a temporary quick-fix, you can update the comparison on line 70 as:

- if (cache->len >=3D cache->flushthresh) {
+ if (cache->len > cache->size) {

>=20
> It looks like your driver introduced something similar to what the
> Intel common drivers were previously doing [3]; the Intel common
> drivers were updated accordingly [4].
>=20
> [1]: https://github.com/DPDK/dpdk/blob/v26.07-
> rc3/drivers/net/sxe2/sxe2_txrx_vec_avx512.c#L70
> [2]:
> =
https://github.com/DPDK/dpdk/commit/f5e1310f16e0909e7e7f71807123644c63b
> 23cba
> [3]:
> =
https://github.com/DPDK/dpdk/blob/v26.03/drivers/net/intel/common/tx.h#
> L315
> [4]:
> =
https://github.com/DPDK/dpdk/commit/062d6fe5d00d837ecb1a2b77b4a306e3619
> a7fde
>=20

