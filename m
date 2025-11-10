Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86206CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 17:18:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45F54026D;
	Mon, 10 Nov 2025 18:17:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 63F9940264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 18:17:58 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4xF16f0LzHnGjN;
 Tue, 11 Nov 2025 01:17:41 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 751EF14033C;
 Tue, 11 Nov 2025 01:17:57 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 10 Nov 2025 18:17:56 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 10 Nov 2025 18:17:56 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Thread-Topic: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Thread-Index: AQHcUbTTQ0Sz/b9pTEyJ8a2Nx5TSDrTsGpug///6NgCAABMTAA==
Date: Mon, 10 Nov 2025 17:17:56 +0000
Message-ID: <f69a9f56ea404e4b8d35655bb5ca9ea5@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
 <20251109200854.45942-4-stephen@networkplumber.org>
 <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
 <20251110090730.098cf34f@phoenix>
In-Reply-To: <20251110090730.098cf34f@phoenix>
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

> > Sorry for not noticing it earlier, we probably want these tests depend =
on
> > RTE_LIBRTE_BPF_ELF, otherwise they fail when libelf is not installed.
>=20
> I tested without elf and it build ok.

Strange, meson tests fail here...

