Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9ED116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 479A0402D2;
	Fri, 28 Nov 2025 14:56:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 02054402B7
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i08WMl5D6NWLQHmHub7dOsWpx4WJRqW9Bpxqt4z3/BM=;
 b=O7jomPpF9s+/0gA+egjseIsONwffMv3Oa9FIm1U9pjVLfTz/0TeNVfALGt6JL+HtcJuQ+n
 xL6gRfMlhB+Y4JLXy+WkGy24Aq+d4Kt9OxNWO8l8xTPjCFhJSQEynCntgREXl4q6UMp0mt
 7FqMi/KiqCkWlVxwdndnB2qF2md2qtY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-dwBJrRpGMEa63H2VYFp55Q-1; Fri,
 28 Nov 2025 08:56:26 -0500
X-MC-Unique: dwBJrRpGMEa63H2VYFp55Q-1
X-Mimecast-MFC-AGG-ID: dwBJrRpGMEa63H2VYFp55Q_1764338185
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F65C1956071; Fri, 28 Nov 2025 13:56:25 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEED618004A3; Fri, 28 Nov 2025 13:56:22 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Rosen Xu <rosen.xu@altera.com>,
 Tianfei Zhang <tianfei.zhang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH 1/7] bus/ifpga: fix const pointer in device name parsing
Date: Fri, 28 Nov 2025 14:56:09 +0100
Message-ID: <20251128135616.2662164-2-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r6goiUiOmvJom_fzFudlOo895aBIUa1Xt5OiZwKn2uE_1764338185
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
../drivers/bus/ifpga/ifpga_bus.c: In function 'ifpga_parse':
../drivers/bus/ifpga/ifpga_bus.c:479:12: warning: assignment discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  479 |         c1 = strchr(name, '|');
      |            ^

Fixes: 05fa3d4a6539 ("bus/ifpga: add Intel FPGA bus library")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/ifpga/ifpga_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index ca9e49f548..fdce1f6b1f 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -468,8 +468,8 @@ ifpga_parse(const char *name, void *addr)
 	int *out = addr;
 	struct rte_rawdev *rawdev = NULL;
 	char rawdev_name[RTE_RAWDEV_NAME_MAX_LEN];
-	char *c1 = NULL;
-	char *c2 = NULL;
+	const char *c1 = NULL;
+	const char *c2 = NULL;
 	int port = IFPGA_BUS_DEV_PORT_MAX;
 	char str_port[8];
 	int str_port_len = 0;
-- 
2.51.1

