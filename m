Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11298CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 03:42:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE82340292;
	Thu, 21 Aug 2025 05:42:33 +0200 (CEST)
Received: from lf-2-59.ptr.blmpb.com (lf-2-59.ptr.blmpb.com [101.36.218.59])
 by mails.dpdk.org (Postfix) with ESMTP id 2A6724026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 05:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1755747739; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+tGQTe5VZlKfYoSNWZs/mU2ogWG3rocbxaa9AxFsd10=;
 b=DUTYx1gXmRQby0HsjxW4ANtwXuuajhpNgHBcW996ad1lAv/4knaEqvTpU+UeqMcw6FsYNg
 tLYKQhvjpn2HoN5gYOCgGXC7ZiW/ukxYlaCIfRqxkTeihoffQBP+G7koitApdRj4Rkh0FC
 SYdsIfO0KMVxflVE7jeRCRoc9od6nwR/fbWmV9Y5ySffjhSkCCSJnkvNf12D0ch9nAhhsc
 zEMct9PKF7NHnn71N5WC7UKVg/tK5ImbZdMvfa9qcV9D4caXTis3b6CK4M6mW+zEC4plsT
 +nVKcBsbnpqRbgtjuPCQ9xfSac0kDu/4rBwlWupbKk16AbyKwB9S85sm4OWrfw==
Date: Thu, 21 Aug 2025 11:42:14 +0800
Received: from [127.0.0.1] ([114.92.133.222]) by smtp.feishu.cn with ESMTPS;
 Thu, 21 Aug 2025 11:42:14 +0800
Cc: "Na Na" <nana@yunsilicon.com>, "Rong Qian" <qianr@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>, <weihg@yunsilicon.com>, <jacky@yunsilicon.com>
Message-Id: <50ba16f1-3421-46e7-ac28-11907ec56b09@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268a69597+7ebd35+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
Subject: Yunsilicon XSC PMD roadmap for 25.11
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
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

Please find below Yunsilicon XSC PMD roadmap for 25.11 release:

1. Supports link status and link event
2. Supports getting FW version
3. Supports TSO
4. Supports Promiscuous mode
5. Supports Module EEPROM dump
6. Supports FEC mode
7. Supports link speed configuration
8. Code optimiztions and bug fix

-- 
Best regards,
Renyong Wan
