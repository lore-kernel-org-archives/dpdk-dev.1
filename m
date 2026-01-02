Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA88FA374B
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F2C740267;
	Fri,  2 Jan 2026 15:27:22 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4AB6340262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 15:27:20 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djQwv1x9zzJ46B9;
 Fri,  2 Jan 2026 22:26:23 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id D88B040539;
 Fri,  2 Jan 2026 22:27:18 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:27:18 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:27:18 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v10 4/9] test: avoid overflowing huge directory path
Thread-Topic: [PATCH v10 4/9] test: avoid overflowing huge directory path
Thread-Index: AQHceQ7Dvcz17ilTbEC4tNucyPWA/7U+9Y/Q
Date: Fri, 2 Jan 2026 14:27:18 +0000
Message-ID: <21c43988241b4271ab76e196777dbffb@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-5-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-5-stephen@networkplumber.org>
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
> Sent: Monday 29 December 2025 21:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v10 4/9] test: avoid overflowing huge directory path
>=20
> Modify the part of the test that is scanning for hugepages
> mount point to use existing getmntent library calls.
>=20
> As a result, the maximum mount path is smaller which is ok
> since this is all handled by the standard library.
> And the resulting huge path arguments don't overflow.
>=20
> Hugepages aren't used on Window or FreeBSD so this is
> skipped there.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>
