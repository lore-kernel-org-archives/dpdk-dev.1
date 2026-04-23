Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474AEFDEE29
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 679B640272;
	Thu, 23 Apr 2026 19:29:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3939C40270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:29:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g1jkJ3BztzJ467W;
 Fri, 24 Apr 2026 01:28:56 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 1381840569;
 Fri, 24 Apr 2026 01:29:53 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Apr 2026 18:29:52 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 23 Apr 2026 18:29:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 0/6] fix process shared pthread mutexes
Thread-Topic: [PATCH v2 0/6] fix process shared pthread mutexes
Thread-Index: AQHczB0JHSvzs+8yLEart9DGG3ZxlrXs8gvg
Date: Thu, 23 Apr 2026 17:29:52 +0000
Message-ID: <c947851fa328492295c957ebbcf0178f@huawei.com>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.144.190]
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



> Several drivers and the ethdev layer initialize pthread mutexes
> in shared memory with default (process-private) attributes.
> This is undefined behavior when secondary processes use them.
>=20
> This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
> All are on control paths (firmware mailbox, hotplug, flow ops,
> PHY negotiation) where sleeping is acceptable.
>=20
> See POSIX spec:
> https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexat
> tr_getpshared.html
>=20
> Bugzilla ID: 662
>=20
> v2 - fix build on Windows which does not need this.
>=20
> Stephen Hemminger (6):
>   ethdev: fix flow_ops_mutex for multi-process
>   net/failsafe: fix hotplug_mutex for multi-process
>   net/atlantic: fix mbox_mutex for multi-process
>   net/axgbe: fix mutexes for multi-process
>   net/bnxt: fix mutexes for multi-process
>   net/hinic: fix mutexes for multi-process
>=20
>  drivers/net/atlantic/atl_ethdev.c      | 14 +++++++++++++-
>  drivers/net/axgbe/axgbe_ethdev.c       | 19 +++++++++++++++----
>  drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
>  drivers/net/bnxt/bnxt_txq.c            |  3 ++-
>  drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
>  drivers/net/bnxt/bnxt_util.h           |  2 ++
>  drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
>  drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
>  drivers/net/hinic/base/hinic_compat.h  | 13 ++++++++++++-
>  lib/ethdev/ethdev_driver.c             | 22 +++++++++++++++++++++-
>  12 files changed, 99 insertions(+), 19 deletions(-)
>=20
> --

LGTM
Just as a generic thought :
- as these new functions is practically identical in all drivers, would it =
make sense
  to create some helper function in drivcers/common or somewhere in other p=
lace
  and use it everywhere.=20
With or without suggested change:
Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

