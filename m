Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E1C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC8D4279F;
	Wed, 16 Sep 2026 15:07:53 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 557F640E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:07:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=96JuHJE19Wxc64q3fhchO8P4zrBX+f5eXDEBzvmPK5c=;
 b=aAxhtPeMOAXTIgOFrFVTcOBdC51ZiUlOpnd0Cu8MCPSvikmSSExA12pM0RdrUMnDcWpOvOTzx
 GWyOXdBQzXntIHwB1xuerb9ByqvC+EprUorr7gSCN8SlYh9/7sH80hdF69vcMItuJMY7g1z4tOA
 b+a532G+2KN0YqR5CcoGuD4=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hlK1L4c66zHnGjM;
 Wed, 16 Sep 2026 21:07:34 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 30D0A40575;
 Wed, 16 Sep 2026 21:07:49 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:07:48 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Wed, 16 Sep 2026 14:07:48 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] bpf: rename macros to match Linux kernel
Thread-Topic: [PATCH v2 2/2] bpf: rename macros to match Linux kernel
Thread-Index: AQHdQetdpayEykkTaEyeE6TiXC2t9rbRM7gw
Date: Wed, 16 Sep 2026 13:07:48 +0000
Message-ID: <792142d15a764d5e9f6d693aa2f42e0c@huawei.com>
References: <20260805094642.52433-1-marat.khalili@huawei.com>
 <20260911124414.63321-1-marat.khalili@huawei.com>
 <20260911124414.63321-3-marat.khalili@huawei.com>
In-Reply-To: <20260911124414.63321-3-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.58]
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



> BPF opcode macro names had small deviations from the ones defined in
> Linux headers, confusing humans and AI tools during code generation and
> analysis, since both are mostly trained on the Linux spelling.
>=20
> Rename them to match Linux counterparts.

But then, there would be a risk that inside DPDK code we will use
definitions provided by linux includes without even noticing that?
I understand that both should boil down to the same values, but still
sort of grey area here...
Shall we add 'RTE_' or '_RTE_' prefix to our own ones?=20

>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
