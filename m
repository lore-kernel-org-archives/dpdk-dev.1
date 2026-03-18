Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B9FCD0C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 13:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B694026F;
	Wed, 18 Mar 2026 14:07:32 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 795CC40150
 for <dev@dpdk.org>; Wed, 18 Mar 2026 14:07:31 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbTc62YwLzJ46Zc;
 Wed, 18 Mar 2026 21:06:30 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 2583A40589;
 Wed, 18 Mar 2026 21:07:28 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 14:07:27 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 18 Mar 2026 14:07:27 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Christophe
 Fontaine" <cfontain@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjoFxWXyTh3g0OC9SlGIQcTMrW0I+zwgAAX+/CAAAZ24A==
Date: Wed, 18 Mar 2026 13:07:27 +0000
Message-ID: <4942136acefe4fc3b5157191749fe3d5@huawei.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <b10d0edcdaac4fd9a4f5a0261205670c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
Content-Type: text/plain; charset="iso-8859-1"
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

> > Handling immediate as unsigned is questionable, especially in the
> > BPF_IND case
> > it may produce incorrect results.
>=20
> In Classic BPF (cBPF), when the immediate "k" is negative (when cast to s=
igned integer), it is used
> for getting packet metadata (e.g. SKF_AD_VLAN_TAG gets the VLAN ID); othe=
rwise it is considered
> unsigned.

Yes. Since we don't support it, we should probably consider these offsets i=
nvalid.

And in the BPF_IND case one might be tempted to load end of some packet are=
a in
the register and use negative offsets, we probably should handle it correct=
ly.

> > To make things worse, `__rte_pktmbuf_read` is also buggy when passed
> > very large
> > lengths (again, technically not ARM eBPF fault).
>=20
> Are you referring to the potential integer wraparound in the off+len > rt=
e_pktmbuf_pkt_len(m)
> comparison?
> [BZ1724]
> Or some other bug in __rte_pktmbuf_read()?
>=20
> [BZ1724]: https://bugs.dpdk.org/show_bug.cgi?id=3D1724

Technically that one manifested itself in rte_pktmbuf_read (without
underscores), but essentially the root cause is the same. In the eBPF BPF_A=
BS
case we could potentially rely on `__rte_pktmbuf_read` for refusing to acce=
pt
negative values converted to large integers, but due to overflows we cannot=
.
