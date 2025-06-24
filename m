Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B2C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 16:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA97A4026B;
	Tue, 24 Jun 2025 18:21:06 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1F4734025E
 for <dev@dpdk.org>; Tue, 24 Jun 2025 18:21:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRVVy1Gtrz6D9Cn;
 Wed, 25 Jun 2025 00:18:34 +0800 (CST)
Received: from frapeml100003.china.huawei.com (unknown [7.182.85.60])
 by mail.maildlp.com (Postfix) with ESMTPS id 7D4D11402F3;
 Wed, 25 Jun 2025 00:21:04 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100003.china.huawei.com (7.182.85.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 18:21:04 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Tue, 24 Jun 2025 18:21:04 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
Subject: RE: [PATCH v2 03/10] test/mempool: fix test without stack driver
Thread-Topic: [PATCH v2 03/10] test/mempool: fix test without stack driver
Thread-Index: AQHb5EY/UfouCu1UDkClX/TKGqNkR7QSfytQ
Date: Tue, 24 Jun 2025 16:21:04 +0000
Message-ID: <524c0591814c4176934340196408ad2a@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-4-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-4-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

Looks good.

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
