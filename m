Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8236CCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 11:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B34ED40270;
	Fri, 31 Oct 2025 12:39:58 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 586D440150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:39:56 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cyfBn6w2dzHnH6S;
 Fri, 31 Oct 2025 11:38:57 +0000 (UTC)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A7D61402E9;
 Fri, 31 Oct 2025 19:39:54 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Oct 2025 12:39:54 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 31 Oct 2025 12:39:54 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/5] bpf enhancements
Thread-Topic: [PATCH 0/5] bpf enhancements
Thread-Index: AQHcScP7sKepPiqwfk6B7do9qDNUgbTcIBLg
Date: Fri, 31 Oct 2025 11:39:54 +0000
Message-ID: <c3c399ee3970498a87526af848920df0@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday 30 October 2025 17:34
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH 0/5] bpf enhancements
>=20
> This is a series of fixes and tests for BPF functionality.
> The new tests for Tx and Rx filtering require the infrastructure
> to build a bpf program (clang) and the tool to convert object
> file to header (xxd). If missing the test will get skipped.

Thank you for doing this, I will try to have a look next week.

About the overall approach to getting the BPF object file, I understand the=
 clang part, but do we really need to convert object files to headers and t=
hen write them back? Could we just pass these object files around as test r=
esources instead? Not that xxd was not present in most systems, but looks l=
ike extra work and complexity.
