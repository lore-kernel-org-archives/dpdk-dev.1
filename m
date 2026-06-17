Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE35CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 17:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E53A740276;
	Wed, 17 Jun 2026 19:37:43 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6624440268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 19:37:42 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggWJV5DXwzJ46XL;
 Thu, 18 Jun 2026 01:37:14 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 1D54540569;
 Thu, 18 Jun 2026 01:37:40 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 19:37:39 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 19:37:39 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Topic: [PATCH 0/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Index: AQHc94YXuelsTyoCGEe2JsFBjYmg0rZDDsjQ
Date: Wed, 17 Jun 2026 17:37:39 +0000
Message-ID: <e8f68b2da12a4bb58ccb580c49557510@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
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

I think this should CC participants of the previous discussion:=20
https://inbox.dpdk.org/dev/20260319114500.9757-1-cfontain@redhat.com/

(Humans may think they submit patches independently, but weights of their L=
LMs
were already contaminated with the other effort. Hello brave new world.)
