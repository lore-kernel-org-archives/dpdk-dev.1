Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D60CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9974D4029D;
	Tue, 23 Jun 2026 18:15:00 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 995DE40150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:14:58 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl9BC3xGWzHnGjc;
 Wed, 24 Jun 2026 00:14:27 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 25E6240575;
 Wed, 24 Jun 2026 00:14:58 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 18:14:57 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 23 Jun 2026 18:14:57 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Thread-Topic: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Thread-Index: AQHc+lkWXE6IMRotik+EWsdt3Z9C1LZL3RYAgAAiGhCAAAKTAIAAX+iQ
Date: Tue, 23 Jun 2026 16:14:57 +0000
Message-ID: <6df2522c679741d985ea47bdd118b9c5@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <3BbIFKkFSyOqZrm3k570og@monjalon.net>
 <84ce7f7669404239864c61819267d9b6@huawei.com>
 <DGHVaJ2SRzSz_1-YcgGmxA@monjalon.net>
In-Reply-To: <DGHVaJ2SRzSz_1-YcgGmxA@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

PiBZZXMgd291bGQgYmUgbmljZSBzbyB3ZSB3aWxsIGhhdmUgYSBmdWxsIENJIHJ1biBvbiBpdA0K
PiBub3cgdGhhdCB0aGUgZGVwZW5kZW5jeSBpcyBtZXJnZWQgaW4gbWFpbi4NCg0KU3VibWl0dGVk
IHY0LCBpbmRlZWQgb25lIG9mIHRoZSBidWlsZHMgZmFpbGVkIGR1ZSB0byB0aGVvcmV0aWNhbGx5
IGluc3VmZmljaWVudA0Kc25wcmludGYgYnVmZmVyLiBXaWxsIHdhaXQgZm9yIHRoZSBkdXN0IHRv
IHNldHRsZSBhbmQgcmVzdWJtaXQgd2l0aCBhIGZpeC4NCg==
