Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A86ECFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB12A402DE;
	Fri, 28 Nov 2025 14:56:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 96149402DE
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zrTO8vK+K5oVsdQP0uzxcLGWr4CeREBx4x1snFX5Nk=;
 b=Ly91NeVKi81KQtz1n+R6PRR7+ZdMMQYO2py6h/0rT20gF06QP6KQyOOQHufwrGs4iqqQlT
 njJnQpXWFMK27q4XoCBzLY0DPekNQ/82CTocJKe6/IviB7KXTOaG4PqyzVfL8zX3kyxQer
 FrrTjM+Ilh3USTyVuC4mAFEeGBymNRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-MEHg7LfmN1auUiQm1T-UAg-1; Fri,
 28 Nov 2025 08:56:53 -0500
X-MC-Unique: MEHg7LfmN1auUiQm1T-UAg-1
X-Mimecast-MFC-AGG-ID: MEHg7LfmN1auUiQm1T-UAg_1764338212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9856E180047F; Fri, 28 Nov 2025 13:56:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E708730001A4; Fri, 28 Nov 2025 13:56:50 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Jakub Grajciar <jgrajcia@cisco.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 6/7] net/memif: fix const pointer in socket check
Date: Fri, 28 Nov 2025 14:56:14 +0100
Message-ID: <20251128135616.2662164-7-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L-_LalsoG4iKmPYbdkswQdsNOFk5xu0K-mqDkLAX8Nc_1764338212
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
../drivers/net/memif/rte_eth_memif.c: In function
	'memif_check_socket_filename':
../drivers/net/memif/rte_eth_memif.c:1848:13: warning: assignment discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1848 |         tmp = strrchr(filename, '/');
      |             ^

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/memif/rte_eth_memif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 9de6f97cd9..8d7060cd7c 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1836,7 +1836,8 @@ memif_set_rs(const char *key __rte_unused, const char *value, void *extra_args)
 static int
 memif_check_socket_filename(const char *filename)
 {
-	char *dir = NULL, *tmp;
+	char *dir = NULL;
+	const char *tmp;
 	uint32_t idx;
 	int ret = 0;
 
-- 
2.51.1

