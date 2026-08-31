Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82BAC624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EF9440269;
	Mon, 31 Aug 2026 17:47:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5B4704025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 17:47:28 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=URYDcTRqL5kVtqG0zKz8WnKwbU340nOI5dplMYCkNHU=;
 b=X2Awhxk/FcYPrHbT65bq4KDc3a9aAwiolgXvHUur4GEiBojbgbN4hDOuwglTtWgSRJMwhCc+S
 ckg9QghCxC+LCXuUr6m5tBjZlZam5zLD40oHJD93o4n3cKKFeJmJTgnkcRlPOOgVMWatqdGNn65
 Gv4b8SnkuYYX2mNe22Z0f6U=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYYJM38HYzHnH4s;
 Mon, 31 Aug 2026 23:46:43 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 6B5E14058B;
 Mon, 31 Aug 2026 23:47:27 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 17:47:27 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 31 Aug 2026 17:47:27 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] test/bpf: use unit test suite
Thread-Topic: [PATCH] test/bpf: use unit test suite
Thread-Index: AQHdOLO5mlj7DteyzkukSIduVk98kLa3030ggABP54CAACJB0A==
Date: Mon, 31 Aug 2026 15:47:26 +0000
Message-ID: <9d5e7e1f3c4b4f7bb398fbb2eb429446@huawei.com>
References: <20260830191349.604934-1-stephen@networkplumber.org>
 <8ecd0e24395d4a5eb53c6c4355f73cf7@huawei.com>
 <20260831081239.658c078d@phoenix.local>
In-Reply-To: <20260831081239.658c078d@phoenix.local>
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

> The only technical difference is that meson runs individual tests in
> parallel and have seen some failures on my machine.

To the best of my knowledge none of the BPF tests are timing-dependent. If =
they
fail to run in parallel it may very well be an issue that needs to be
investigated. If it happens again, can you save the logs and open a bug?

> But for me it is more about decluttering the output.

Hard for me to argue with this one, since it is highly subjective. But note
that for the price of 23 separate lines in the meson test output when one o=
f
the tests actually fails the output is significantly less cluttered, only
showing the output of the relevant test.

Do you think 20+ independent tests is too much for a single library? If we =
set
some hard limit like this then I suppose we have to collapse them. Then I w=
ould
elevate bpf_test elements to the level of test suite cases, three levels of
containers is too much and going to be real pain to walk through in gdb.
