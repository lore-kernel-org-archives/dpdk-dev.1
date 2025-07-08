Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E5C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:32:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B586640B8D;
	Tue,  8 Jul 2025 14:31:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3679240A87
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751977917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APVY4IaacIPobMiLXe7TlBg+WHJ5V/G/TOblR1rA7lo=;
 b=QTW9jsdg53Akz2zDwhJ1gnpdaUepj2+HqF7qCbWPc4RDCusLbuK2XgBjJ5miE/VpqWXKvE
 TCoOrJBrADFdIU1gScjqjTZdDdJwQzAoRwtXqr58VbZrjhHFziy7xNspECwW27pM8FAzj3
 D36qhHvyhRqArCLIoB6xJgSyCyWdbic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-PQdwVintP72-TJf3LlmPSA-1; Tue,
 08 Jul 2025 08:31:56 -0400
X-MC-Unique: PQdwVintP72-TJf3LlmPSA-1
X-Mimecast-MFC-AGG-ID: PQdwVintP72-TJf3LlmPSA_1751977916
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8A6E180028F
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:31:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.95])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2F7319560AB
 for <dev@dpdk.org>; Tue,  8 Jul 2025 12:31:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v3 16/18] test/power: fix tests without power drivers
Date: Tue,  8 Jul 2025 14:28:20 +0200
Message-ID: <20250708122823.3406288-17-david.marchand@redhat.com>
In-Reply-To: <20250708122823.3406288-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F60BH_kasrjYpuXYn9uGjgp25SZWLjXaI-38opY0kJw_1751977916
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

