Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2EC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 07:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B684027E;
	Fri,  7 Aug 2026 09:15:54 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by mails.dpdk.org (Postfix) with ESMTP id 9395F40264
 for <dev@dpdk.org>; Fri,  7 Aug 2026 09:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9E
 l6XsEQfWvxcFT3I0E3LBsq/Al1xBXCTsclBFNOWmI=; b=p5oZuVWUCxOp4PLZkK
 X3eyvOlJcQYAyvxxYea6pl8gQcNmspb/25GZBh0EXUwhVk9M0qdvNShc8zJA0SXT
 E/e4pHURj/eRN1xncSqe05zVigOOjnBPKvgj9ITc0E+jEWXQHBcmq+vcx6jc+Ebe
 u8wy1rCVRXnjkQRxDnqaR820w=
Received: from LAPTOP-H6E44CS6.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3X+wjhnVq6np8Ng--.36602S2; 
 Fri, 07 Aug 2026 15:15:48 +0800 (CST)
From: Yang Xiaoliang <yang_xiaoliang1990@163.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Yang Xiaoliang <yang_xiaoliang1990@163.com>
Subject: [PATCH] doc: fix typo in l3fwd sample app guide
Date: Fri,  7 Aug 2026 15:15:46 +0800
Message-ID: <20260807071546.13795-1-yang_xiaoliang1990@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X+wjhnVq6np8Ng--.36602S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4xZw13tr4fCFy5ZFWxXrb_yoWfArb_Kr
 15W3y8XrWYyr1rXr13CFWxGryI9w4UXryUua1qgr4ayayIqrnIgr4kWFZrur4rZFnFqFW7
 J398X3Wxtw1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR__-BtUUUUU==
X-Originating-IP: [223.104.3.153]
X-CM-SenderInfo: 51dqwsp0ld0z5ldqwiqzzqqiywtou0bp/xtbC7wSiEGp1hiTBhQAA3g
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

Fix "menthod" typo, should be "method".

Signed-off-by: Yang Xiaoliang <yang_xiaoliang1990@163.com>
---
 doc/guides/sample_app_ug/l3_forward.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 452bd8cc6c..0395474337 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -210,7 +210,7 @@ In this command:
 
 *   The --mode option defines PMD to be used for packet I/O.
 
-*   The --eventq-sched option enables synchronization menthod of event queue so that packets will be scheduled accordingly.
+*   The --eventq-sched option enables synchronization method of event queue so that packets will be scheduled accordingly.
 
 If application uses S/W scheduler, it uses following DPDK services:
 
-- 
2.43.0

