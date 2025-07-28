Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94CEC83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 03:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 615194025A;
	Mon, 28 Jul 2025 05:53:35 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by mails.dpdk.org (Postfix) with ESMTP id 9D931400D5
 for <dev@dpdk.org>; Mon, 28 Jul 2025 05:53:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=SPCbUffYlVpYE0aYkOtUvaJNB+GGAmnPgkIRFk/pbbo=;
 b=n4LnjkwBxdyXzBbQHeCEb9sbn2uHDnnDd4XUjnkcXMNExrIaDmiFqHMl2bj7GN
 9dwiIBa4PQgeg/lwmqeloG5c9G7gegMXPpyxaPcD70MhFo3Zb9ybFTeZqcInMkKo
 Aq/EGNWA1RwIAjIUmkfwiGWnVvnjsJ8OwG3jyt717wpLA=
Received: from localhost.localdomain.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgBnIGs39IZo5PwoCQ--.59896S2;
 Mon, 28 Jul 2025 11:53:29 +0800 (CST)
From: Huichao Cai <chcchc88@163.com>
To: konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org
Subject: [PATCH] acl: fix the value of the trans table
Date: Mon, 28 Jul 2025 11:53:24 +0800
Message-Id: <20250728035324.3136-1-chcchc88@163.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250725102151.6677-1-chcchc88@163.com>
References: <20250725102151.6677-1-chcchc88@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgBnIGs39IZo5PwoCQ--.59896S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF17ArWkZrWxuw18XrW5ZFb_yoW8Ww1kpF
 WagF15Ka1kJFW3ZFWFkr18JF15XrW8Ar1DJF42yrW7Aas3Xa48KFW8tr18Cry2y3ykZayq
 v3W0q34xtr1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvD7-UUUUU=
X-Originating-IP: [124.127.58.137]
X-CM-SenderInfo: pfkfuxrfyyqiywtou0bp/1tbiUgWYF2iG71OhrwAAsE
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

Hi, Konstantin

To illustrate this issue, I made the following modifications to the test cases:
Modify the “test_data” content of the function "test_acl.c: test_build_ports_range":
delete the second test data, and leave only one test message data. This way, when
the function "acl_run_scalar.c: rte_acl_classify_scalar" processes the second message
data, it will use the idle data. Then modify the idle data in the function "acl_run.h:
acl_start_next_trie" to (to modify the idle, the const attribute was removed):
parms[n].data = (uint8_t *)idle;
parms[n].data[0] = 0x04;
parms[n].data[4] = 0x01;
When the function "acl_run_scalar.c: scalar_transition" processing this idle message,
because the ranges are 0 and the message data is not 0(0x01), the message data will
exceed all ranges. The calculated result x is 4, while the correct result should be 0. The
following is a comparison of the settlement results of x before and after modification
(I have printed each line of the calculation results of the function "acl_run_stcalar. c: scalar_translation"):

==before==:
Line 87: transition: 0x20000100
Line 88: ranges: 0x0
Line 89: index: 0x20000000
Line 90: addr: 0x100
Line 91: input: 0x0
Line 96: c: 0x0
Line 99: a: 0x80808080
Line 102: a: 0x80808080
Line 105: b: 0x0
Line 108: a: 0x80808080
Line 111: a: 0x80808080
Line 114: x: 0x0
Line 125: addr: 0x100

==after==:
Line 87: transition: 0x20000100
Line 88: ranges: 0x0
Line 89: index: 0x20000000
Line 90: addr: 0x100
Line 91: input: 0x1
Line 96: c: 0x1010101
Line 99: a: 0x80808080
Line 102: a: 0x7f7f7f7f
Line 105: b: 0x0
Line 108: a: 0x0
Line 111: a: 0x0
Line 114: x: 0x4
Line 125: addr: 0x104

