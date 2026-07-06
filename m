Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 829D440615;
	Mon,  6 Jul 2026 15:14:48 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2F672402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:14:46 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv4Ym0qbzzJ469G;
 Mon,  6 Jul 2026 21:13:48 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D60440584;
 Mon,  6 Jul 2026 21:14:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 15:14:44 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 6 Jul 2026 15:14:44 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v2 0/7] doc: build for all public headers
Thread-Topic: [PATCH v2 0/7] doc: build for all public headers
Thread-Index: AQHdDTXIX7jqjVyPAUmVvF+YYIUHTbZgd9mQ
Date: Mon, 6 Jul 2026 13:14:44 +0000
Message-ID: <6afc57f5e9a0490ebe2ede179a23a7f5@huawei.com>
References: <20260702200050.88710-1-marat.khalili@huawei.com>
 <20260706105256.79904-1-marat.khalili@huawei.com>
In-Reply-To: <20260706105256.79904-1-marat.khalili@huawei.com>
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

> Marat Khalili (7):
>   doc: detect ignored public headers
>   doc: document rte_os.h
>   doc: fix typos in rte_bus_pci.h
>   doc: fix typos in rte_bus_vmbus.h

Newer version of doxygen in CI discovered additional issues in
rte_avp_common.h, will address in v3 tomorrow.

>   doc: add missing globs to doxy-api.conf.in
>   doc: add missing drivers to doxy-api.conf.in
>   doc: add missing headers to doxy-api-index.md

