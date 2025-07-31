Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF3C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 03:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 035674026A;
	Thu, 31 Jul 2025 05:19:16 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by mails.dpdk.org (Postfix) with ESMTP id A93D84025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 05:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HQ
 nGwjIeobqpKOTR5yzVlfWoi0/CdHbQdEd5LCMgbVE=; b=eGkvF3t42Ec7ZQSMu4
 yOMfeqWmKv2CGYDFzKgw1ef39QDEWKCI37/Iyuc7Aj1ZVuHhNax2zMEl50pdYaDK
 zKItGRnal59uxzBR1I3E48/fAGNGCqEn9pdaEGp0OfNK4NKbBxS4Z12OMXxwZ+S4
 x+wtmi5vwxevxe25xcoTWZ0zE=
Received: from localhost.localdomain.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCn53mr4IpodpUuIg--.62683S2; 
 Thu, 31 Jul 2025 11:19:08 +0800 (CST)
From: Huichao Cai <chcchc88@163.com>
To: konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org
Subject: [PATCH] acl: fix the value of the trans table
Date: Thu, 31 Jul 2025 11:19:05 +0800
Message-Id: <20250731031905.4430-1-chcchc88@163.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250725102151.6677-1-chcchc88@163.com>
References: <20250725102151.6677-1-chcchc88@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn53mr4IpodpUuIg--.62683S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDGrWfZw1fWw1kKrW8Crg_yoW3tFX_XF
 1kuF4DtryUXr1xJws7WF17JrZFqw40gFyav3yxK3ZF9398JrsrGFWktr95ZFnrCayavr9F
 qFWDKF4FgF4IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbsjjPUUUUU==
X-Originating-IP: [124.127.58.137]
X-CM-SenderInfo: pfkfuxrfyyqiywtou0bp/1tbiUg6bF2iK3lVODgAAs5
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

Maybe that's not a problem, because ACL can handle idle
packets normally, so I can't reproduce this issue with
external test cases at the moment, but I'm just describing
what idle nomatch node has to do if it wants to implement
an effect pointing to itself:

The reason why RTE_ACL_NODE_SINGLE node can point to itself
(regardless of the value of the packet data) is that it relies
on the node_index high 32-bit assignment to the maximum boundary
value (RTE_ACL_QUAD_SINGLE), and the idle nomatch node has the
same properties, so it should also be like RTE_ACL_NODE_SINGLE
node_ index instead of the current boundary value of 0, the reason
why the current idle nomatch node can point to itself is because
the idle data is 0, which has nothing to do with the node pointing
to its own attributes, it is just a coincidence of the data.

