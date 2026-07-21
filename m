Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA74EC44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 14:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BFEA406A2;
	Tue, 21 Jul 2026 16:59:17 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 03C68402A7
 for <dev@dpdk.org>; Tue, 21 Jul 2026 16:59:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=QVenZCBm/yFXE+fcxr8JyJQ+OKpS53XyFWJRFLJawEc=;
 b=Ov4G2BDihPcCXqq6TrHGzSgFt9SnIi3foSLJP2QKc57p050CdJFKNSzSrpahhmb2J9C+iEG8V
 r/cQQiAEqUIan3eS1BsH3epOwYByrac8NRr05p3rgsLm4Y/iiPkRFxBVGJT5Y+lb/kVM1cjK8sy
 9pOu5ZmuXLgxU3sOBO9h/YY=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4LB44YKKzJ468C;
 Tue, 21 Jul 2026 22:58:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id D2CF640572;
 Tue, 21 Jul 2026 22:59:12 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 16:59:12 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v4 5/7] doc: add missing globs to doxy-api.conf.in
Date: Tue, 21 Jul 2026 15:58:38 +0100
Message-ID: <20260721145841.7424-6-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721145841.7424-1-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Public headers starting from `cmdline` (except for `cmdline.h` itself)
and `bpf_def.h` were not previously included in the documentation build.

Add missing file patterns (globs) to include all public headers.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 doc/api/doxy-api.conf.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd94468150..2cb152d6db98 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -88,7 +88,8 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/lib/vhost
 INPUT                   += @API_EXAMPLES@
 FILE_PATTERNS           = rte_*.h \
-                          cmdline.h
+                          cmdline*.h \
+                          bpf_def.h
 PREDEFINED              = __DOXYGEN__ \
                           RTE_ATOMIC \
                           RTE_HAS_CPUSET \
-- 
2.43.0

