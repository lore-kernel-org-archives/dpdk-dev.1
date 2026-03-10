Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5DFCC9CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4573402B8;
	Tue, 10 Mar 2026 07:35:14 +0100 (CET)
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
 by mails.dpdk.org (Postfix) with ESMTP id AAA264014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:35:12 +0100 (CET)
Received: from sunyuechi$iscas.ac.cn ( [42.7.145.216] ) by
 ajax-webmail-APP-12 (Coremail) ; Tue, 10 Mar 2026 14:35:11 +0800
 (GMT+08:00)
X-Originating-IP: [42.7.145.216]
Date: Tue, 10 Mar 2026 14:35:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: sunyuechi@iscas.ac.cn
To: P1erreCashon <2022302111412@whu.edu.cn>
Cc: "Yipeng Wang" <yipeng1.wang@intel.com>, 
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>, 
 dev@dpdk.org, gong-flying <gongxiaofei24@iscas.ac.cn>
Subject: Re: [PATCH v2] efd: lookup with RISC-V vector extension
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <20260304070605.1150502-1-2022302111412@whu.edu.cn>
References: <20260304070605.1150502-1-2022302111412@whu.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <136dbc4f.5c499.19cd674e5c8.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowABHUtKfu69pdmsVAA--.5984W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgsCAmmvomBAKQABsh
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
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

YGBgCiNlbGlmIGRlZmluZWQoUlRFX0FSQ0hfUklTQ1YpICYmIGRlZmluZWQoUlRFX1JJU0NWX0ZF
QVRVUkVfVikKI2luY2x1ZGUgPHJpc2N2X3ZlY3Rvci5oPgojaW5jbHVkZSAicnRlX2VmZF9ydnYu
aCIKYGBgCgpydGVfZWZkX3J2di5oIGFscmVhZHkgaW5jbHVkZXMgI2luY2x1ZGUgPHJpc2N2X3Zl
Y3Rvci5oPgoKYGBgCkVGRF9MT09LVVBfTlVNLApFRkRfTE9PS1VQX1JWVgpgYGAKCkl0IHNlZW1z
IHRoYXQgX05VTSBzaG91bGQgYmUgcGxhY2VkIGF0IHRoZSBlbmQ/Cg==
