Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3766C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 07:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21573402E9;
	Tue,  1 Sep 2026 09:32:03 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D4B5D4027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 09:32:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0drFimXgP6uamOQDaNIInvisy/mwuWmc2z6lTRiEaM8=;
 b=AAupwFhn9kP9xZohFEbn3x2JLy1vNISMaGXKz7dAvNrGasYTla6U5rPP5nvQTPQ+sRqJC8BEs
 1tMQX26Y791dWn17+Pq1OzSs/+usaWlgdOSEsLdnXcVTVozfSgUSXMWmqDpkl6MLlQygllzRUEo
 S+myDD9N/KZ55+mxXqgVeWI=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYyGB5BGgzHnH3Y;
 Tue,  1 Sep 2026 15:31:14 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 01E3B4057C;
 Tue,  1 Sep 2026 15:32:00 +0800 (CST)
Received: from dubpemt500001.china.huawei.com (7.214.144.77) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 08:31:59 +0100
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpemt500001.china.huawei.com (7.214.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Sep 2026 08:31:59 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.045; 
 Tue, 1 Sep 2026 08:31:59 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "Randy Tice (rtice)"
 <rtice@cisco.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Topic: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Index: AQHdOXCgdP+ENN3UFk+QdyL24xrKUra49v0AgABcR9A=
Date: Tue, 1 Sep 2026 07:31:59 +0000
Message-ID: <a5c4c02c338c4427892a2dc08a43cc83@huawei.com>
References: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
 <20260831195516.71a00639@phoenix.local>
In-Reply-To: <20260831195516.71a00639@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.136]
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



> > Hi,
> >
> > I would like to get feedback on a proposed mbuf change before sending
> patches.
> >
> > Some deployments need a guaranteed private-data reservation in every pa=
cket
> mbuf, across multiple mbuf pools and across different consumers of the mb=
uf
> APIs.
> >
> > Today, each pktmbuf pool can request a private size when the pool is cr=
eated.
> That works when the application owns all pool creation policy directly. H=
owever,
> not all relevant mbuf pools are necessarily created by application code. =
Some
> pools may be created by libraries, drivers, or other components outside d=
irect
> application control.
> >
> > One example already in DPDK is vhost crypto, which creates its own mbuf=
 pool
> and supplies a private size for struct vhost_crypto_data_req. There are a=
lso
> driver-created pktmbuf-style pools, such as cnxk inline meta pools and TA=
P GSO
> context pools. These are examples of pool-creation paths where the applic=
ation
> may not directly control the private-size value used at creation time.
> >
> > A PMD-specific devarg could solve one instance of this problem, such as=
 a
> single driver-created pool, but that seems too narrow if the requirement =
is not
> inherently PMD-specific. A deployment with multiple drivers, libraries, o=
r other
> pool-creation paths outside application control could need the same base
> private-size adjustment. In that case, configuring the same value indepen=
dently
> through component-specific options would be fragile and easy to get wrong=
.
>=20
> Would be better to make it a config compile time option.
> Then drivers could use static_assert() to check for space.
> Doing it at runtime is harder to handle and enforce.

Why? As long as rte_pktmbuf_pool_create() is used by all consumers, it seem=
s
be straightforward to enforce extra room.=20
If we do need such option, my preference would be to have run-time configur=
able. =20
