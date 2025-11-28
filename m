Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD7CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53EC3402DE;
	Fri, 28 Nov 2025 14:56:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 74120402E4
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq/c/LxZ7b39tAQAGBfFkCM2f+ZVDKxebSjZROuN1ZE=;
 b=EdpW+7fUTg8IZ/cYHuhhm/FOBg57O6w+bHSVenR0xxj8pl4crmKdEZYPjqsWX9YSqjpuwS
 yCD5GbW0MXuT2FJJ1w2B9DYD/Kp90TRCdqCyrIlFtrHhUwU2mBkFNkjci8d3jxp62YpjTd
 MOQ07n1HUzRh3gEZ+7jhAqEfwaIGJqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-rkdxNhQ3NC2JgWbc-LBUNQ-1; Fri,
 28 Nov 2025 08:56:31 -0500
X-MC-Unique: rkdxNhQ3NC2JgWbc-LBUNQ-1
X-Mimecast-MFC-AGG-ID: rkdxNhQ3NC2JgWbc-LBUNQ_1764338190
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 625921800447; Fri, 28 Nov 2025 13:56:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0550630001A4; Fri, 28 Nov 2025 13:56:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>,
 Huisong Li <lihuisong@huawei.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/7] bus/uacce: fix const pointer in device matching
Date: Fri, 28 Nov 2025 14:56:10 +0100
Message-ID: <20251128135616.2662164-3-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 22Ewyko8PToQO9pN8351i6GPnRYeMkCDZQ0fQtJLXvE_1764338190
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

With latest glibc (Fedora Rawhide):
../drivers/bus/uacce/uacce.c: In function 'uacce_match':
../drivers/bus/uacce/uacce.c:346:21: warning: assignment discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  346 |                 map = strstr(dev->algs, id_table->dev_alg);
      |                     ^

Fixes: 62b906cf06ba ("bus/uacce: introduce UACCE bus")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/uacce/uacce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 87e68b3dbf..79f990c54c 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -328,8 +328,8 @@ static bool
 uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *dev)
 {
 	const struct rte_uacce_id *id_table;
+	const char *map;
 	uint32_t len;
-	char *map;
 
 	for (id_table = dr->id_table; id_table->dev_api != NULL; id_table++) {
 		if (strcmp(id_table->dev_api, dev->api) != 0)
-- 
2.51.1

