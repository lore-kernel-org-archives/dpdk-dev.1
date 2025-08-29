Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD158CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 02:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6004029E;
	Fri, 29 Aug 2025 04:34:11 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id DC22F40292
 for <dev@dpdk.org>; Fri, 29 Aug 2025 04:34:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCj0w3vTRz13NLT;
 Fri, 29 Aug 2025 10:30:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EC8CE1402F2;
 Fri, 29 Aug 2025 10:34:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 10:34:08 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v2 3/3] doc: update ABI versioning guide
Date: Fri, 29 Aug 2025 10:34:03 +0800
Message-ID: <20250829023403.4895-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250829023403.4895-1-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250829023403.4895-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Add a semicolon after RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
RTE_EXPORT_EXPERIMENTAL_SYMBOL in the guide.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/guides/contributing/abi_versioning.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 2fa2b15edc..0c1135becc 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -168,7 +168,7 @@ Assume we have a function as follows
   * Create an acl context object for apps to
   * manipulate
   */
- RTE_EXPORT_SYMBOL(rte_acl_create)
+ RTE_EXPORT_SYMBOL(rte_acl_create);
  int
  rte_acl_create(struct rte_acl_param *param)
  {
@@ -187,7 +187,7 @@ private, is safe), but it also requires modifying the code as follows
   * Create an acl context object for apps to
   * manipulate
   */
- RTE_EXPORT_SYMBOL(rte_acl_create)
+ RTE_EXPORT_SYMBOL(rte_acl_create);
  int
  rte_acl_create(struct rte_acl_param *param, int debug)
  {
@@ -213,7 +213,7 @@ the function return type, the function name and its arguments.
 
 .. code-block:: c
 
- -RTE_EXPORT_SYMBOL(rte_acl_create)
+ -RTE_EXPORT_SYMBOL(rte_acl_create);
  -int
  -rte_acl_create(struct rte_acl_param *param)
  +RTE_VERSION_SYMBOL(21, int, rte_acl_create, (struct rte_acl_param *param))
@@ -303,7 +303,7 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
     * Create an acl context object for apps to
     * manipulate
     */
-   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_create)
+   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_create);
    __rte_experimental
    int
    rte_acl_create(struct rte_acl_param *param)
@@ -320,7 +320,7 @@ When we promote the symbol to the stable ABI, we simply strip the
     * Create an acl context object for apps to
     * manipulate
     */
-   RTE_EXPORT_SYMBOL(rte_acl_create)
+   RTE_EXPORT_SYMBOL(rte_acl_create);
    int
    rte_acl_create(struct rte_acl_param *param)
    {
-- 
2.17.1

