Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1051CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17A8B402E3;
	Fri,  7 Nov 2025 18:45:54 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 43A7E4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 18:45:53 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d360R2znTzJ46BR;
 Sat,  8 Nov 2025 01:45:27 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 29EDF1400D9;
 Sat,  8 Nov 2025 01:45:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 18:45:51 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 7 Nov 2025 18:45:51 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Thread-Topic: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Thread-Index: AQHcTaV02m9YfHF+c0yX0F26edwMqbTnTMSQgAA0DTA=
Date: Fri, 7 Nov 2025 17:45:51 +0000
Message-ID: <2fd10b3a010f495b82cbbcfef29dd9df@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-4-stephen@networkplumber.org>
 <2951855794674cada3b9ab9574699917@huawei.com>
In-Reply-To: <2951855794674cada3b9ab9574699917@huawei.com>
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

P.S. When running with UB sanitizer:

RTE>>bpf_elf_load_autotest
BPF: resolve_xsym(40): EBPF_PSEUDO_CALL to external function: dummy_func1
../../src/lib/bpf/bpf_validate.c:247:24: runtime error: signed integer over=
flow: 9223372036854775807 + 2147483647 cannot be represented in type 'long =
int'
    #0 0x2b1fdca in eval_add ../../src/lib/bpf/bpf_validate.c:247
    #1 0x2b2b9dc in eval_alu ../../src/lib/bpf/bpf_validate.c:691
    #2 0x2b3b187 in evaluate ../../src/lib/bpf/bpf_validate.c:2446
    #3 0x2b3bf0f in __rte_bpf_validate ../../src/lib/bpf/bpf_validate.c:253=
7
    #4 0x2b19b33 in rte_bpf_load ../../src/lib/bpf/bpf_load.c:113
    #5 0x2b47d6d in bpf_load_elf ../../src/lib/bpf/bpf_load_elf.c:288
    #6 0x2b47fe8 in rte_bpf_elf_load ../../src/lib/bpf/bpf_load_elf.c:320
    #7 0x66b4b8 in test_bpf_elf_load ../../src/app/test/test_bpf.c:3382
