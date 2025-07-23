Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CAC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0B840E3B;
	Wed, 23 Jul 2025 15:33:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 48475402DF
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zvnkp3lDaPoSDrN5yPEIyexmh5X7pYS76l+yEj1G3Y=;
 b=ikOgF1tAkjYZmdHVgpgr2t6gH/Ipk5mF2RiDgCMEba1rp8wP3rF3c/YAWMXP9I18a+6mcM
 Lzjo00x22vQFzOA61hd5QImm1qCUzLAfxbr1bfK0V51QKvNlFnyKbesA4yH58+ijETGTKs
 DKZTfkP+/IMprmuIG3tn6V1ybN7WTKY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-4q1q1ZNGNXSBAW_oZ9pEtg-1; Wed,
 23 Jul 2025 09:33:33 -0400
X-MC-Unique: 4q1q1ZNGNXSBAW_oZ9pEtg-1
X-Mimecast-MFC-AGG-ID: 4q1q1ZNGNXSBAW_oZ9pEtg_1753277611
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1FD219560A3; Wed, 23 Jul 2025 13:33:31 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7537730001A4; Wed, 23 Jul 2025 13:33:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 16/22] test/power: fix tests without power drivers
Date: Wed, 23 Jul 2025 15:31:49 +0200
Message-ID: <20250723133157.159825-17-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vAOZLqd4r2xva7Go1kxz4FOdxytR_zEJOnY0h_RLnH4_1753277611
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

