Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6229EC01AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:26:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D64E140268;
	Mon, 23 Mar 2026 10:26:12 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 226944025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 10:26:10 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffSTS37ztzJ46fZ;
 Mon, 23 Mar 2026 17:26:04 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 794B940589;
 Mon, 23 Mar 2026 17:26:09 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 23 Mar 2026 10:26:09 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 23 Mar 2026 10:26:09 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Christophe Fontaine <cfontain@redhat.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
Thread-Index: AQHct5dZZG3T63zh0USsskRx8hX/xLW7uliAgAAjMOA=
Date: Mon, 23 Mar 2026 09:26:09 +0000
Message-ID: <d4fce425f578411b9a4a38cee47233ff@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
 <20260319114500.9757-3-cfontain@redhat.com>
 <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
In-Reply-To: <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

PiBJdCBzZWVtcyBteSBwYXRjaCBicm9rZSB0aGUgQ0kgb24gZGViaWFuL3VidW50dSwgYnV0IHdv
cmtzIG9uIEZlZG9yYS9DZW50b3MuDQo+IEkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoYXQgd2l0
aCBhIGNvbnRhaW5lciwgYW5kIGhvcGUgdG8gcHJvdmlkZSBhDQo+IHYzIHRoaXMgd2Vlay4NCg0K
U29ycnksIGRpZCBub3QgaGF2ZSB0aW1lIHRvIGxvb2sgYXQgaXQsIEkgZ3Vlc3MgSSdsbCB3YWl0
IGZvciB2MyBub3cuDQoNCkkgd29uZGVyIHdoYXQgd2FzIHRoZSBwcm9ibGVtIHRob3VnaC4gTG9v
a3MgbGlrZSBzb21lIFVCL2NvbXBpbGVyLWRlcGVuZGVudCB0aGluZy4NCg==
