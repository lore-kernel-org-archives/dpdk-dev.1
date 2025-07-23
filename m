Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A30C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC97640E72;
	Wed, 23 Jul 2025 15:34:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11AB640E25
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS8HiwYCgPn0+3ybr77CgbMga0xQMTSohF18Noiv+Oo=;
 b=JmKdT2/z0pteTo1eZFgCcEyp+SE5MjH1TBq+K1/MXxyD7n3mUNbCaym6g5esyXw99ljw6e
 /iRwAr8MnWna48PyzBbyibUSN0PuZdw0SCG4DHxeWfM3yW01w0JOMfELPwbIH0oVJ/4qIl
 D6o96WwT+/CUoH4F/YjDcLMhdPMjsRI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-6hMAnmWaMmKFbBTo5M8VDw-1; Wed,
 23 Jul 2025 09:33:57 -0400
X-MC-Unique: 6hMAnmWaMmKFbBTo5M8VDw-1
X-Mimecast-MFC-AGG-ID: 6hMAnmWaMmKFbBTo5M8VDw_1753277635
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A9A18001DD; Wed, 23 Jul 2025 13:33:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3698195608D; Wed, 23 Jul 2025 13:33:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v5 21/22] test/func_reentrancy: fix EAL init call
Date: Wed, 23 Jul 2025 15:31:54 +0200
Message-ID: <20250723133157.159825-22-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8vtFRQlCZAtuqFpYLyMh-Ga-vw18EyrTR2kghq9ojZc_1753277635
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

../lib/eal/common/eal_common_options.c:1638:16: runtime error:
	null pointer passed as argument 2, which is declared to never be null

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_func_reentrancy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index 34d685d493..f4c6cbc548 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -66,15 +66,16 @@ static RTE_ATOMIC(uint32_t) synchro;
  * rte_eal_init only init once
  */
 static int
-test_eal_init_once(__rte_unused void *arg)
+test_eal_init_once(void *arg)
 {
 	unsigned lcore_self =  rte_lcore_id();
+	char *argv[] = { arg, NULL };
 
 	WAIT_SYNCHRO_FOR_WORKERS();
 
 	/* silent the check in the caller */
 	rte_atomic_store_explicit(&obj_count, 1, rte_memory_order_relaxed);
-	if (rte_eal_init(0, NULL) != -1)
+	if (rte_eal_init(RTE_DIM(argv) - 1, argv) != -1)
 		return -1;
 
 	return 0;
-- 
2.50.0

