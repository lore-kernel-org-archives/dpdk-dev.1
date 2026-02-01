Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A03E6529C
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 16:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAF11402A2;
	Sun,  1 Feb 2026 17:10:53 +0100 (CET)
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
 by mails.dpdk.org (Postfix) with ESMTP id BF8DF40150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 17:10:48 +0100 (CET)
Received: from sunyuechi$iscas.ac.cn ( [113.239.66.27] ) by
 ajax-webmail-APP-13 (Coremail) ; Mon, 2 Feb 2026 00:10:47 +0800 (GMT+08:00)
X-Originating-IP: [113.239.66.27]
Date: Mon, 2 Feb 2026 00:10:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: sunyuechi@iscas.ac.cn
To: dev@dpdk.org
Subject: Re: [PATCH v2] node: lookup with RISC-V vector extension
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <20260201160931.1896432-1-sunyuechi@iscas.ac.cn>
References: <20260201160931.1896432-1-sunyuechi@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4cc49012.1df11.19c19f8942f.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowADHDBEHe39pIUMLAA--.55509W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCREFAml-a6MWhQAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
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

Only modified release_26_03.rst.
