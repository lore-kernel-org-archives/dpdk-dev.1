Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B79B1098784
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 13:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28CB7402BE;
	Fri, 20 Mar 2026 14:33:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 34DDC400EF
 for <dev@dpdk.org>; Fri, 20 Mar 2026 14:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774013597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aDDiNjqJBxd5tmj90UVUlOUhxL7b5gMfjT8HWNYvAwU=;
 b=IVXs9zavz3fc1XzWHB+8DXkr9BTLwMsr7o6Loo000p6fEcF+QlcwStaXo29ebeoyR4IYeL
 /dhbf43mf+ZinMo8dVoUKOvsFxLZmeW2kGp77693vHJN5ch6LTkXpQUK0+X7ejREFLa139
 iHHttMWnDJMbWILXWsDr0jwFFgp/Ztk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-YWujZQJbNT-FF6XPXyWQ8Q-1; Fri,
 20 Mar 2026 09:33:16 -0400
X-MC-Unique: YWujZQJbNT-FF6XPXyWQ8Q-1
X-Mimecast-MFC-AGG-ID: YWujZQJbNT-FF6XPXyWQ8Q_1774013594
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 027AE1954B17; Fri, 20 Mar 2026 13:33:14 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA4FF1800763; Fri, 20 Mar 2026 13:33:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH] pipeline: fix build with sanitizers or debug options
Date: Fri, 20 Mar 2026 14:33:09 +0100
Message-ID: <20260320133309.1015506-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sVCBG58l8EmdjMFXeICznftF8cjYdA3_mndcH7MmBrY_1774013594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Similar to commit 84f5ac9418ea ("pipeline: fix build with ASan").

Here we are again. Depending on options (like debug, or ASan, or UBSan),
compilation can fail because of dumb construct like CHECK(0, XXX).
Dumb, because such an expression macro expands as: if (0) return -XXX;

../lib/pipeline/rte_swx_pipeline.c: In function ‘instr_movh_translate’:
../lib/pipeline/rte_swx_pipeline.c:3461:1: error: control reaches end of
	non-void function [-Werror=return-type]
 3461 | }
      | ^

Remove any such call when at the end of functions, using a regexp:
%s/CHECK(0, \(.*\))\(;\n}\)/return -\1\2/

Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/pipeline/rte_swx_pipeline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/pipeline/rte_swx_pipeline.c b/lib/pipeline/rte_swx_pipeline.c
index a9157815e4..8ceb1fe88d 100644
--- a/lib/pipeline/rte_swx_pipeline.c
+++ b/lib/pipeline/rte_swx_pipeline.c
@@ -2524,7 +2524,7 @@ instr_table_translate(struct rte_swx_pipeline *p,
 		return 0;
 	}
 
-	CHECK(0, EINVAL);
+	return -EINVAL;
 }
 
 static inline void
@@ -3049,7 +3049,7 @@ instr_extern_translate(struct rte_swx_pipeline *p,
 		return 0;
 	}
 
-	CHECK(0, EINVAL);
+	return -EINVAL;
 }
 
 static inline void
@@ -3457,7 +3457,7 @@ instr_movh_translate(struct rte_swx_pipeline *p,
 		return 0;
 	}
 
-	CHECK(0, EINVAL);
+	return -EINVAL;
 }
 
 static inline void
-- 
2.53.0

