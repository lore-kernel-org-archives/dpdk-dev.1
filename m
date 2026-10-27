Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6B606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fo6RoXDL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BBAB40611;
	Tue, 27 Oct 2026 19:55:45 +0100 (CET)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mails.dpdk.org (Postfix) with ESMTPS id 56A33402BD
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:55:44 +0100 (CET)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdac8b7169eso197965a12.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127343; x=1793732143; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IqhFBwxaqj79VoqIQ1N2pX0siyTqwO4B/FdqloYfDdU=;
 b=Fo6RoXDLbBp21XObiP5i20xizj9589YNcguD4RAMl6/nFAFD43tNN8TgUAao4WTF5P
 /9zrgUYnIhNrYjA51GbBx5wB7mPlNsqVEj2MIc4+JoxUEd/R4H49HzF3hAKXnTNBpS5w
 YAgoYY28zYaNhnk42jDkyAm27PM4TSWAc4cPHtxLQ/FE5EzBmk+BSRw2rhsgL9j2PhS7
 GYQ3HeS0mRGALOmihDTEYLRl5zjHTTFJo2zOi51Vfo4OcuOV3SeJkr2e/5TVTbyTQYUM
 fJANORSHi9icQeBkpHH4hkOYpejXWGkz7sE3t7mtO5Vn8joTOmOs5oFx/rTY+BzwsJJ0
 t5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127343; x=1793732143;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqhFBwxaqj79VoqIQ1N2pX0siyTqwO4B/FdqloYfDdU=;
 b=UeC5BSreyzsDFNCsqQAZvHui8BHyoLhHr2ZbGaCBfVS4HQhKypPxWb4snSJCdHaY8M
 DBWVzFKmVEEAOKvxuJeMahLBULm05KXUn/wRA8AlK1AH0DhMEPQ7gg9ZTeSweKKpQiQe
 DLbWCjd8A8SUYRimEiL5AAaqu8fFItkry+Mhs8aMODMMrMFqN3/B4d0VZ87nOa8uhyKI
 s7wLvNOJSzHuJ9hZ6lJZ4ZOU2Ph/p/m1XsFqGof9vp048ofa7r90/CJXDe3Xu+ZRE+n5
 KnijaCkCz48V4O0qAsgmlF3XVNWTK1Qqz5T0T/SWHVWqNR1sQ9kXwb4hOCe7yiLKCEWF
 xLjQ==
X-Gm-Message-State: AFq9FYK2BLgxCfaxuaUrzg8cDcM1Fx0BtAHgclTncsBAgygCy3pjhF7M
 LCmg9mZhiCqJtHJ5hlCmH8A7cMBAvzXE2OQT++DhdxIVgP+UpAupgAmFn3H4R3e14i9lrh7Pqc+
 ICJUeFVrV8ADAkBktm2ESt2AROPTKxIYH0y3oYTj3Tsqc9y86uECaIwGsoxbBigYsDmLjIWJiJU
 cUB461omg82eo4mstS0WhbUk768+DiwP22MgifD3hcnmcNRjY8Jg==
X-Received: from pghe1.prod.google.com ([2002:a63:e001:0:b0:cd6:3b65:ef46])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7343:b0:3e2:490d:5143 with SMTP id
 adf61e73a8af0-3e9020cc9d9mr160869637.10.1793127342480; 
 Tue, 27 Oct 2026 11:55:42 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:10 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-2-jtranoleary@google.com>
Subject: [PATCH 1/9] net/gve: free flow subsystem on dev init failure
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If setting up device resources fails during gve_init_priv, tear down the
flow subsystem if it was initialized to avoid leaking the flow rule
bitmap.

Fixes: 82ef40fb2e7e ("net/gve: support flow API")
Cc: stable@dpdk.org

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 23a4c118b..90d8797b0 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1747,8 +1747,13 @@ setup_device:
 	}
 
 	err = gve_setup_device_resources(priv);
-	if (!err)
-		return 0;
+	if (err)
+		goto free_flow_subsystem;
+
+	return 0;
+free_flow_subsystem:
+	if (gve_get_flow_subsystem_ok(priv))
+		gve_teardown_flow_subsystem(priv);
 free_adminq:
 	process_priv->ctrl_ops->free_ctrl_plane(priv);
 	return err;
-- 
2.56.0.307.g5fe7bd680c-goog

