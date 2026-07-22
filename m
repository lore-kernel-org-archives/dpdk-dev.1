Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DCC4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 09:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DC840274;
	Wed, 22 Jul 2026 11:36:07 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C37C2400EF
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:36:05 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tFASn0rUp1oXne5EkoEhawao+rsyMkBxgSOtMOJhTbw=;
 b=USMuTZkm7ESL1AzPP+ceTnAVoI+CpF4kO2ndhwUQYkBsXcunuZqX/sa0l611UcVZweLn4Fsk/
 Xq0h7GwGEcBQxukBqgkVb520SdqVAObmgHUM4CxH4KvJy45IzzV/lwGqAyNWVEEpJt4tSVs5G82
 /1NSllY2xZrdCkS+d3bF9DA=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4pyb4zf1zHnH7c
 for <dev@dpdk.org>; Wed, 22 Jul 2026 17:35:35 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C7F840570
 for <dev@dpdk.org>; Wed, 22 Jul 2026 17:36:01 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 22 Jul 2026 11:36:01 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 22 Jul 2026 11:36:01 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v4 7/7] doc: add missing headers to doxy-api-index.md
Thread-Topic: [PATCH v4 7/7] doc: add missing headers to doxy-api-index.md
Thread-Index: AQHdGSGiDCymJ3o79keWWJFJmf3QQ7Z5SGRQ
Date: Wed, 22 Jul 2026 09:36:01 +0000
Message-ID: <d020421a790c4c88b2e19bbb8243a83c@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
 <20260721145841.7424-8-marat.khalili@huawei.com>
In-Reply-To: <20260721145841.7424-8-marat.khalili@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

Recheck-request: iol-intel-Functional
