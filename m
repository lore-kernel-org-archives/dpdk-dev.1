Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140E606A31D
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZQRp5M0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46506402B0;
	Sat, 24 Oct 2026 15:22:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A62A64021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIbSK4M/biWpIgQASl4zsQFv/5OTXCz1T4UAsqPba74=;
 b=fZQRp5M0A4whRR92I9wtE3/XdE9NU3yfI56s2jloRzCNA/1hLfCBC1AULatVmXDfO0efeR
 sA5BIaDuzVvJ2c17YRVAxGsAHzyxjX+W4j7aZZetqwNH2su3JE8Uulx9LwIqJ53cr5xiGo
 kAbyz1skf8p2mAGBP0SLTSergRtNU+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-neZydLBaMgGa13R43Q5DQg-1; Sat,
 24 Oct 2026 09:22:06 -0400
X-MC-Unique: neZydLBaMgGa13R43Q5DQg-1
X-Mimecast-MFC-AGG-ID: neZydLBaMgGa13R43Q5DQg_1792848125
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8012B1800646; Sat, 24 Oct 2026 13:22:05 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB31C300019F; Sat, 24 Oct 2026 13:22:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 Wei Hu <weh@microsoft.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 05/12] net/mana: reset FD in interrupt handle
Date: Sat, 24 Oct 2026 15:21:30 +0200
Message-ID: <20261024132138.7239-6-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ej3yY0iz43ejbN6CxZCGVASF4lCOI51h9jqtd6jJVyo_1792848125
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The interrupt handle references the ibverbs async_fd which is owned
by the ibverbs context, not by this driver. Clear the FD reference
before freeing the interrupt handle to avoid a spurious leak warning.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/mana/mana.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 30b0ce90d6..0ea6d9a54a 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1796,6 +1796,8 @@ mana_reset_exit(struct mana_priv *priv)
 		else
 			DRV_LOG(DEBUG, "%d intr callback(s) removed", ret);
 
+		/* fd is owned by ibverbs, only clear reference here. */
+		rte_intr_fd_set(priv->intr_handle, -1);
 		rte_intr_instance_free(priv->intr_handle);
 		priv->intr_handle = NULL;
 	}
@@ -1915,6 +1917,8 @@ mana_intr_uninstall(struct mana_priv *priv)
 		return ret;
 	}
 
+	/* fd is owned by ibverbs, only clear reference here. */
+	rte_intr_fd_set(priv->intr_handle, -1);
 	rte_intr_instance_free(priv->intr_handle);
 	priv->intr_handle = NULL;
 
-- 
2.54.0

