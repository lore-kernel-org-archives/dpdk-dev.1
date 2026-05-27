Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3275DCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 07:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B1140659;
	Wed, 27 May 2026 09:57:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 222A340615
 for <dev@dpdk.org>; Wed, 27 May 2026 09:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779868637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrMEDqz+qpiDYZtyLc2+ZaJIsiaRhlGljQq9IyvfGGg=;
 b=gLD94BDCcj9hhkWRMY8LyU+OfU+cCaDgHnmlikNpmnML/iSBTZb0n9cGA2Q769UYtwZaZE
 idNpZumOd5a9PM+9U2Nb/U1+zD1WZW0EgniZl2rMjJGn/aIixqJtGUrSbo8QzmrAzL5c4s
 5LqJEE5Bmaza90XnU/OVdSe1Ew1PXSk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-1HLADFhxMQO6Y1L8DWgYxA-1; Wed,
 27 May 2026 03:57:12 -0400
X-MC-Unique: 1HLADFhxMQO6Y1L8DWgYxA-1
X-Mimecast-MFC-AGG-ID: 1HLADFhxMQO6Y1L8DWgYxA_1779868631
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2D94195609D; Wed, 27 May 2026 07:57:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B67A7404; Wed, 27 May 2026 07:57:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 02/25] bus/uacce: set API version during scan
Date: Wed, 27 May 2026 09:56:26 +0200
Message-ID: <20260527075654.3780732-3-david.marchand@redhat.com>
In-Reply-To: <20260527075654.3780732-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3SHADgVnw8zP918n5tbyTuHFphUD2qVG9gN8BxQWCXw_1779868631
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

Move API version parsing from the match callback to the time where the
device object is allocated and filled, since this property is constant.

This avoids any side effect on the device object when calling the match
callback.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/uacce/uacce.c | 53 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index ade2452ad5..7633007296 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -148,12 +148,35 @@ uacce_read_attr_u32(const char *dev_root, const char *attr, uint32_t *val)
 	return 0;
 }
 
+static uint32_t
+uacce_calc_api_ver(const char *api, int *offset)
+{
+	int len = strlen(api);
+	int end = len - 1;
+	unsigned long ver;
+
+	while (end >= 0 && isdigit(api[end]))
+		end--;
+
+	if (end <= 0 || end == len - 1 || api[end] != 'v')
+		return 0;
+
+	ver = strtoul(api + end + 1, NULL, 10);
+	if (ver > UINT32_MAX)
+		return 0;
+
+	if (offset != NULL)
+		*offset = end + 1;
+	return (uint32_t)ver;
+}
+
 static int
 uacce_read_api(struct rte_uacce_device *dev)
 {
 	int ret = uacce_read_attr(dev->dev_root, "api", dev->api, sizeof(dev->api) - 1);
 	if (ret < 0)
 		return ret;
+	dev->api_ver = uacce_calc_api_ver(dev->api, NULL);
 	return 0;
 }
 
@@ -290,28 +313,6 @@ uacce_scan(void)
 	return -1;
 }
 
-static uint32_t
-uacce_calc_api_ver(const char *api, int *offset)
-{
-	int len = strlen(api);
-	int end = len - 1;
-	unsigned long ver;
-
-	while (end >= 0 && isdigit(api[end]))
-		end--;
-
-	if (end <= 0 || end == len - 1 || api[end] != 'v')
-		return 0;
-
-	ver = strtoul(api + end + 1, NULL, 10);
-	if (ver > UINT32_MAX)
-		return 0;
-
-	if (offset != NULL)
-		*offset = end + 1;
-	return (uint32_t)ver;
-}
-
 static bool
 uacce_match_api(const struct rte_uacce_device *dev, bool forward_compat,
 		const struct rte_uacce_id *id_table)
@@ -330,10 +331,9 @@ uacce_match_api(const struct rte_uacce_device *dev, bool forward_compat,
 }
 
 static bool
-uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
+uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *dev)
 {
 	bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
-	uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
 	const struct rte_uacce_id *id_table;
 	const char *map;
 	uint32_t len;
@@ -342,10 +342,8 @@ uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
 		if (!uacce_match_api(dev, forward_compat, id_table))
 			continue;
 
-		if (id_table->dev_alg == NULL) {
-			dev->api_ver = api_ver;
+		if (id_table->dev_alg == NULL)
 			return true;
-		}
 
 		/* The dev->algs's algrothims is separated by new line, for
 		 * example: dev->algs could be: aaa\nbbbb\ncc, which has three
@@ -361,7 +359,6 @@ uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
 		if (map[len] != '\0' && map[len] != '\n')
 			continue;
 
-		dev->api_ver = api_ver;
 		return true;
 	}
 
-- 
2.53.0

