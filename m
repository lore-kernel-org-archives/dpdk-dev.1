Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E615C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41E5C40374;
	Mon, 31 Aug 2026 10:35:02 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 99D6740395
 for <dev@dpdk.org>; Mon, 31 Aug 2026 10:35:00 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=yGG5SfHRNbjU6Rb2aDjAza5QxbremN0RkJBIC0YdbAk=;
 b=iw9NRGQ08DVYQC/WcpfmYlRE1BHPb/YTv21s5wDodEO5Eiuon5i+oqH0ytRgZbKJeID1GuOTY
 0IfCNmsnWVjAuxnu9rk8LRnYqrJB0PMjk1wMwKVQUN/REouSIzoDE4pTmFip+RUPSokE/Ep2y22
 omDXR3YRsCDaqHXV242feC0=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hYMjN0frGzHnGdK;
 Mon, 31 Aug 2026 16:34:16 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 773364058D;
 Mon, 31 Aug 2026 16:34:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 31 Aug 2026 10:34:59 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 31 Aug 2026 10:34:59 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] test/bpf: use unit test suite
Thread-Topic: [PATCH] test/bpf: use unit test suite
Thread-Index: AQHdOLO5mlj7DteyzkukSIduVk98kLa3030g
Date: Mon, 31 Aug 2026 08:34:58 +0000
Message-ID: <8ecd0e24395d4a5eb53c6c4355f73cf7@huawei.com>
References: <20260830191349.604934-1-stephen@networkplumber.org>
In-Reply-To: <20260830191349.604934-1-stephen@networkplumber.org>
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

Hi!

> The BPF tests registered 23 separate autotests. Collapse them into a
> single bpf_autotest suite run by unit_test_suite_runner().

Some of these tests still don't pass with sanitizer enabled.  With them
registered individually there was an option to ignore these failures or onl=
y
run the tests that are known to not contain UB. After lumping them in one s=
uite
running BPF tests under sanitizer is going to become much more difficult.

There are other reasons why more granular tests are good, like ease of trac=
king
or debugging failures. What are the benefits from collapsing them? What is =
the
 actual problem we are trying to solve?

If DPDK CI is running out of tmpfs again, there is a proper fix for that.

> Rename the old table-driven test_bpf() to test_bpf_progs() so that
> test_bpf() can be the suite entry point.

While having only one of the BPF tests called test_bpf was confusing, I'm n=
ot
sure new name is more clear.

> Move the #endif of the RTE_LIB_BPF guard to the end of the file. It
> closed mid-file, leaving the stack, ELF, convert and atomic tests
> outside the guard even though they all call rte_bpf functions.

This guard is unnecessary and I already sent a patch to delete it.
