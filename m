Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91064C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 10:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B2A4064F;
	Fri, 14 Feb 2025 11:05:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A77714064A
 for <dev@dpdk.org>; Fri, 14 Feb 2025 11:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739527557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tIPJO3Sbxdv/2L2/REoE4eR9Rj/1253UUNQUIJ8aupA=;
 b=ORgaLL3VM43JfgRGlKLgJU7rY078F6p930rBck9aXdt3/28G9hrCEiJzJ6Tigz0HzsnqBq
 bscgFu9HVjW3qeWWY0yR6zJ58bVEILbRGr+3ANDoEeHLFMWw7ixkb2ODyrQlALF/z1uXR+
 IkIeQIbX80o6LGBCO70+QAGJyvXmRys=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-wkUUi4skNQGrHJzcH7v2dg-1; Fri,
 14 Feb 2025 05:05:54 -0500
X-MC-Unique: wkUUi4skNQGrHJzcH7v2dg-1
X-Mimecast-MFC-AGG-ID: wkUUi4skNQGrHJzcH7v2dg_1739527553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0E3418D95EE; Fri, 14 Feb 2025 10:05:52 +0000 (UTC)
Received: from rh.Home (unknown [10.45.224.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46B66300018D; Fri, 14 Feb 2025 10:05:49 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: dsosnowski@nvidia.com, mkashani@nvidia.com, rasland@nvidia.com,
 orika@nvidia.com, Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Subject: [PATCH] net/mlx5: fix flow null ops seg fault
Date: Fri, 14 Feb 2025 10:05:45 +0000
Message-ID: <20250214100545.413991-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_8TT29jL2qsETXW0NP62T7IgAP1-9C61__esE6cI8U_1739527553
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

flow null driver ops may get selected and try to call .list_create
causing a seg fault.

Full details and back traces in bugzilla.

Add a null ops implementation for .list_create.

Bugzilla ID: 1661
Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 drivers/net/mlx5/mlx5_flow.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index a2ee237841..3fbe89a9d4 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -4032,4 +4032,18 @@ mlx5_flow_validate_item_nsh(struct rte_eth_dev *dev,
 }
 
+static uintptr_t
+flow_null_list_create(struct rte_eth_dev *dev __rte_unused,
+		      enum mlx5_flow_type type __rte_unused,
+		      const struct rte_flow_attr *attr __rte_unused,
+		      const struct rte_flow_item items[] __rte_unused,
+		      const struct rte_flow_action actions[] __rte_unused,
+		      bool external __rte_unused,
+		      struct rte_flow_error *error)
+{
+	rte_flow_error_set(error, ENOTSUP,
+			   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, NULL);
+	return 0;
+}
+
 static int
 flow_null_validate(struct rte_eth_dev *dev __rte_unused,
@@ -4151,4 +4165,5 @@ flow_null_counter_query(struct rte_eth_dev *dev,
 /* Void driver to protect from null pointer reference. */
 const struct mlx5_flow_driver_ops mlx5_flow_null_drv_ops = {
+	.list_create = flow_null_list_create,
 	.validate = flow_null_validate,
 	.prepare = flow_null_prepare,
-- 
2.48.1

