Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A9606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dV+ya9Vr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6977640664;
	Wed, 18 Nov 2026 01:19:47 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 9717B40659
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:46 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so4060815e9.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961186; x=1795565986; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwR07hIeDdLOyVd0gtW4ffOGtNjGf55L3I8seuI+kNI=;
 b=dV+ya9VrmTspXc3xipw9uSgXfQJ88cQBCPilBtTnq1VU8fPjB0jcibmi28OVj7EQK6
 Ff3nJyR8jTiHjBKiTiPT7yhe8nbAW7FvIZebeR0GoDBHNKng+Q5XBI8ZdFaPyZpp+EY8
 Q2aS2fmuGRYqv2x8ukLVFUvh8uWdxJhH7JqrVsIdblYXwIMH3KgfWoCt6YkMCpG+nfBw
 R9azaDwvpkYCAr873gPZHXFJzX1QOBQwtUNMfuS1bR2QJXNkS++0M5KrZhjoM3y1eb4K
 W3FSNmJuKWJag4Bug7o3mf+fxOorAaQ4EdZ4R4pnfwUAanZRj02yIBb1QzCI5cOJfnIT
 ussw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961186; x=1795565986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwR07hIeDdLOyVd0gtW4ffOGtNjGf55L3I8seuI+kNI=;
 b=iA9lN/HqkvnL50fRH/HP3pj6y3a7slWkaN9eOqpz9EHGnC2xy1OijZfJeOaY1aElCU
 Xi1CBOmCfg3RY7lOxmhf0hBOA2ocHqj8cYOmQc7wl92NZqZNYZZRN7DSiSWnVCuSrIdj
 gVYovT2mEZiVJiMwqYXmVa+e8D9B1+wpvr+GmIh+ylZSXn6YUK1Bca9cnDqkCJN9Akd3
 z6XIYFrZH+3NRcsb/oYF/dHXHqZLxgktBOPXeGa28qAxi7mi4q7zQJ2jaWhWelrc0eBP
 vCy1Ol+Xhfn6F73GXN8M1PYkP5c3NpgeyKi+RtTgcwFXMhofr92Apo71NGdkS8Sv0ytS
 9Arg==
X-Gm-Message-State: APuU4Z/rbTCSDwRIJUg4oYGHtf4E5XgsWZ89kQQTaip9wW0ACACJ2m4c
 r38c58SBr7sF+nuDmRdIS+lonDH3GOzEb2TrZPlIMEsy5qPww56CACeP
X-Gm-Gg: AYBFou2qloHuDBD4STQozQq7bEIjvavw/OiMuYu0Q+rkcjnT6MII4u3gABI0Kb6M9QA
 PdC1ZVtW+AGRMJFdkRYmSBuWDKILGuM+fsC87pBjOmRXxfCBZavyxelr6vwWGAIYGCKs3SlkG6V
 KpVl1s2foBuJ11zk/e0AE4nB/imHNxJ/OS6QiEtMRd0HfWK13dPbWPlTFynYu1/TdzrYN9NQaTg
 bY01ronQrHeowWdEFcuJ6eun2CBE0KU2BEVZHRAzw8l8Okgj/dMaJ04ltnqGpdzbW7GaUPdn0EY
 /qRcElwMcadBZV8x4vbg8BlXITU0fEolwULLxdKjglrUid2BN9enIhfLULVJlq3rQqQUVg3O+/I
 OygAWyjN4+0C5khEl7voJAhld5QGFNs25LBU9ctlkuC287ajmIfRMmnokuRhvnkSV9VYIq3z6Y2
 cRvithhtAVxHLMutWYfHqTIIJZCPYW+E9HZ888AJZUa+DudJYu9wBwz3TJ/oLYuF8YpNpq151k8
 AwX/5jqxD4eHSKLAvBDT/mLn20Q7IAjEqlG3eIpONaoHi1BA6/RZwRU4bFixPHu0E98V6lrYcsa
 ZTsHd9zh69Aryy10Vn0oTzjb6YGO86l9zXIZaMRxhw==
X-Received: by 2002:a05:600c:6708:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4bb7d9fd2f6mr15920355e9.7.1794961186136; 
 Tue, 17 Nov 2026 16:19:46 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:45 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 6/7] dts: support virtio PCI ports
Date: Wed, 18 Nov 2026 02:19:17 +0200
Message-ID: <20261118001918.990884-7-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118001918.990884-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118001918.990884-1-iboukris@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DTS reads the logical name and the MAC address of a port from the
lshw entry of its PCI device. A virtio device has none there, because
lshw lists its network interface as a device of its own, on the virtio
bus, right after the PCI device. The test run setup then fails:

  Could not gather a valid MAC address and/or logical name for port
  port-0 in node SUT 1.

Copy to the entry of the PCI device what it lacks from the entry of
its interface.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 dts/framework/testbed_model/linux_session.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 786e8c4eb4..40cc87adaf 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -438,7 +438,14 @@ def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
     @cached_property
     def _lshw_net_info(self) -> list[LshwOutput]:
         output = self.send_command("lshw -quiet -json -C network", verify=True)
-        return json.loads(output.stdout)
+        ports = json.loads(output.stdout)
+        # The network interface of a virtio device is an entry of its own, on the virtio bus,
+        # right after the entry of the PCI device. Copy from it what the PCI entry lacks.
+        for device, interface in zip(ports, ports[1:]):
+            if "logicalname" not in device and interface.get("businfo", "").startswith("virtio@"):
+                configuration = interface.get("configuration", {}) | device.get("configuration", {})
+                device.update(interface | device | {"configuration": configuration})
+        return ports
 
     def refresh_lshw(self) -> None:
         """Force refresh of cached lshw network info."""
-- 
2.56.1

