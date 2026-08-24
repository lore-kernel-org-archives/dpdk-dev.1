Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD73C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB04540270;
	Mon, 24 Aug 2026 17:01:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 99F5D400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:01:54 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CPyJjc4svMRXMMw8zdDXeIe+5ss0fU3/Hr+bvmTDwAA=;
 b=fBjCihSm1mYAY2wKUV0ma553qPUU79ye3Q0ipayf8LALOQjXvw8Rs3IwwruqcdIvpnyEGJQBf
 y/BoaVpHwIDC1KBi6h/xgIinB7vd1gbKclzASZpSXsbN5iO1hNuElj9O2mkKKLYcRunYMNya8Yd
 GRIJ9cWd9/xHXu+vfftj73Y=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTDdF4thwzHnGjq
 for <dev@dpdk.org>; Mon, 24 Aug 2026 23:01:21 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 9234040575
 for <dev@dpdk.org>; Mon, 24 Aug 2026 23:01:51 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:01:51 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 17:01:51 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/1] test/bpf: remove redundant library guard
Thread-Topic: [PATCH 1/1] test/bpf: remove redundant library guard
Thread-Index: AQHdJLmiClBoKquyYkCjEjIciNqWurataNtw
Date: Mon, 24 Aug 2026 15:01:51 +0000
Message-ID: <2a65d91bb0d342e6a82ab91892b35108@huawei.com>
References: <20260805090350.37661-1-marat.khalili@huawei.com>
In-Reply-To: <20260805090350.37661-1-marat.khalili@huawei.com>
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

Recheck-request: rebase=3Dmain, iol-unit-amd64-testing
