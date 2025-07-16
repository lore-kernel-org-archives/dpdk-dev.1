Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71769C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 13:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D66040A70;
	Wed, 16 Jul 2025 15:03:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ACD9640A71
 for <dev@dpdk.org>; Wed, 16 Jul 2025 15:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752671028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zvnkp3lDaPoSDrN5yPEIyexmh5X7pYS76l+yEj1G3Y=;
 b=g2mnyBXUo2GjUaxiaY7hTNL1VkMd46iIgZsbcEdgrxlyo5AHZt2E6wt9fj+KadrO/Y7YPT
 de/LxA0vGFJ/wodrTZHATb8G/1fbCs3Gdi4itxbziMIjCO/dTrGSXFocHx1r9lqkdX7Xw1
 jvOShbkGv8EdRAGE2dO6URlamZ9vZWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-dcXUxxSvNxCoAYbIvFXg4Q-1; Wed,
 16 Jul 2025 09:03:45 -0400
X-MC-Unique: dcXUxxSvNxCoAYbIvFXg4Q-1
X-Mimecast-MFC-AGG-ID: dcXUxxSvNxCoAYbIvFXg4Q_1752671024
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C45D1800C31; Wed, 16 Jul 2025 13:03:44 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAEFA18002AF; Wed, 16 Jul 2025 13:03:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 16/22] test/power: fix tests without power drivers
Date: Wed, 16 Jul 2025 15:02:03 +0200
Message-ID: <20250716130212.1736407-17-david.marchand@redhat.com>
In-Reply-To: <20250716130212.1736407-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250716130212.1736407-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7wLJBJLOyarAtNcavNN7PVTKqzjdLKXVxO9v1ZIwi0_1752671024
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

In the absence of drivers, skip tests instead of failing.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d38f51918..79d635b42b 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -145,10 +145,12 @@ source_file_deps = {
     'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
     'test_pmu.c': ['pmu'],
-    'test_power.c': ['power'],
-    'test_power_cpufreq.c': ['power'],
-    'test_power_intel_uncore.c': ['power'],
-    'test_power_kvm_vm.c': ['power'],
+    'test_power.c': ['power', 'power_acpi', 'power_kvm_vm', 'power_intel_pstate',
+        'power_amd_pstate', 'power_cppc'],
+    'test_power_cpufreq.c': ['power', 'power_acpi', 'power_intel_pstate', 'power_amd_pstate',
+        'power_cppc'],
+    'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
+    'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
     'test_prefetch.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
     'test_rand_perf.c': [],
-- 
2.50.0

