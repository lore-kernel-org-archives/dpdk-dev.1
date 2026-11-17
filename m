Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB700606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HsvcdRVW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B41402ED;
	Tue, 17 Nov 2026 23:00:39 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 77134402D5
 for <dev@dpdk.org>; Tue, 17 Nov 2026 23:00:38 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso3368355e9.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952838; x=1795557638; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwR07hIeDdLOyVd0gtW4ffOGtNjGf55L3I8seuI+kNI=;
 b=HsvcdRVWZ0IYKtzBe7ZI96fa7R5qk+OvOdC0mClVJRzuC97AV+e3TTOYxZ/tcT0fMH
 x6+KoKuFOU1AbKx7uz4jVIG2CjFRzkk3kJb54qzNtithaUbcGU07nni1Ika4l0e5EbFt
 +lxzoimsofIJrapCDr1bsjtlbMZDaFtZEBB2nwAIy/zLy0k8KNn9HNbKrsp48noyXdK+
 PKlqzS72Om1g/TwUV6VbsSwRJjIx4g2xS1dleYklUQ0XXHZSQDvI4JuY6YupgAtgZ4Ai
 TpNHqI1SEmZtuNHdwY0Xv5VT46jRYaqXobYzG68qqI7aJ89Ry1Hn10w7/sjawc15D9YK
 aDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952838; x=1795557638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwR07hIeDdLOyVd0gtW4ffOGtNjGf55L3I8seuI+kNI=;
 b=FHN7XchmYY/Oji/n4jAMDwZQG+pgLLdbbqfn3e3lXxNUDKVbUu7jLICxPLsq+jkRUN
 gIE7cdbOZmy2Msmt757B4x4xr84i/0LO4++Oih0IOhKPnwmcUMa89Ris3m3qNtZ3SNC8
 S1HQNOkyj/LQ9E57zXwbdJ+aAVnru84pZrc/RRsNsn2xXxL83qGA+2DYf/ypr8Cm2C4l
 4jHQMetm1dmAZ9Tbr/Yg9pu1cOsT2dgfVb229qR3yK42VCwKDi/GQBqUoSuI2MN9ERQN
 2gepzTCOSlpPwAkx/YdMiuIjxZG/LkxcJcbGwUiMOb/Kal9HLzKjBcQx2GXBgO98iUjm
 Ryvg==
X-Gm-Message-State: APuU4Z9XJVRe57AflWJVFZxLWqtOZCrIZvbS6crx/yBDLjBeKZ4VJ6Ji
 UuEtloW4rhmV/OWWu7Q00uMqimeXPpb5xkGtI68vd7fWEtgIl6Pk3biH
X-Gm-Gg: AYBFou3k/fw8wAvbGiZUoRUqJ9LFgyqDWEjTUf5/+qeq6mo6TZOv0IEQcvZsLzUDIgt
 iFZ0a4uafJXQAyMFaNC2Su5javpIn4aljb0zXafgrvyh8Sf223NyA6RdDU1yj9KVWwHqAiKkgMi
 o4ilsUukSSCnXZfKb8xsImVX+GMSbZpTgsxnHxNAkz1Kiba9w0x61Bn4iFqQ7bzPqImXxRzri2Z
 Aaq8eSX2KFiGsLLUsf4ClUORzD96yYakI60m9qmQS4nnDntpr5XA12gKMFWhm1d6Rcj0mpunGe/
 UTgJezeZFJUO8bw++sMoWuA1YOsFxx8C3OblN+G5eM6XQoH5/3Z+04iyE8eg+KYiznO0HuhjebN
 VWNfb12Ew3XKHoNLTetIV2mzJcttTeL+bos9l6taFvHNE8N5uXpsXJOBPIKwHtZ/JN4rY1FEm3g
 9vXIVdhmKAySaLI4n/S7G8kpaImYDNrpU7zUKqyQyjdFxvurAt3ZImGHbI+D+3jP/JhoHVpGD1t
 ASuoAVdbduxQPRd4pk4RicThcphbb1KEVdRW8gA7aHNTadS7ncmb+RIjNVMhsbjNxJ5NW98FYIy
 FIc7CUz+QLYYYCECYoH2
X-Received: by 2002:a05:600c:1f90:b0:4bb:7987:fbc4 with SMTP id
 5b1f17b1804b1-4bb7da263c5mr11004145e9.19.1794952837972; 
 Tue, 17 Nov 2026 14:00:37 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm1011390f8f.18.2026.11.17.14.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:00:37 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v2 4/5] dts: support virtio PCI ports
Date: Wed, 18 Nov 2026 00:00:00 +0200
Message-ID: <20261117220001.965310-5-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117220001.965310-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117220001.965310-1-iboukris@gmail.com>
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

