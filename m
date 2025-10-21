Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8927CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 11:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B55402ED;
	Tue, 21 Oct 2025 13:42:27 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CB54F400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 13:42:26 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crVgl54Zmz6D8cp;
 Tue, 21 Oct 2025 19:39:15 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 650C31402F5;
 Tue, 21 Oct 2025 19:42:25 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 13:42:25 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 21 Oct 2025 13:42:25 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: BPF elf examples
Thread-Topic: BPF elf examples
Thread-Index: AQHcQf6K0uho3kqij0iYFJ1uvc0nH7TMeIOw
Date: Tue, 21 Oct 2025 11:42:25 +0000
Message-ID: <1c2a834602b440d6841ea8120ae37db2@huawei.com>
References: <20251020131631.2a6a0de3@phoenix.lan>
In-Reply-To: <20251020131631.2a6a0de3@phoenix.lan>
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

> -----Original Message-----
> Tried using AI to generate tests, and as usual it sort of worked but the
> example code generated won't load or work. Is there anywhere to find work=
ing
> DPDK examples of using BPF load?

Hello! I'm sitting on some patches adding a framework for generating BPF EL=
F=20
files using libelf and some basic unit tests based on it. Hopefully I'll be=
=20
able to upstream it within the next couple of months.

Generating ELF files is probably beyond the reach of current AI, but once t=
he=20
framework is there perhaps it could be used to add test cases, would be=20
interesting to try...
