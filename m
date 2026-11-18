Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D110606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVlWAeEO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EED8402F0;
	Wed, 18 Nov 2026 09:28:31 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 3684F40611
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:29 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so11840955e9.1
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990509; x=1795595309; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LB7Tj2uWOrVm3dyS/0lXvhuw6erCuj/22shrU/ch9W4=;
 b=PVlWAeEOKt2RfGm5VMg3jfP5d3ZspN6/8hLLG35LwKg1NVkv//IZYVSKb5SEndCd6D
 aKLVMlOsW/Qt7Wq2zd1GqEPhLkWr3QHDdRfOznfqqJZqVHCkoAd07A6lSaamk5Nh57Of
 1K5WL5PJYDxdlJlwAe56z72zKBGlHa7DN81r37kEzmxkC1v1uQcWB6O15zesuyDwhcOQ
 aSU8aHmgkPL9a+SxqcgpOYV7iCCgV7dziglILEkum15vHoG1iL8q/DtrYymC+xKrND9N
 qdl2tt3WPU9D0S0Y48rg2uHhS7z9/78lKlbrAJSy/B/GL1+NJfOelmvMxVG5m2xBxxKn
 ZRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990509; x=1795595309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LB7Tj2uWOrVm3dyS/0lXvhuw6erCuj/22shrU/ch9W4=;
 b=idokuVzY4YslCK/pBCOat/UiS6Rdz7QCzAFLgpDP4Zvw9qWpc2vajXEFyOnmRcCkOt
 6Ee8xTo/mFIXqGRATODwt5jp2lrnF9z2WFGbQpYnDzpgghHlVcf72zi5mwZmt+I9PpJm
 ecwprwjNimwkGkJsQC8qeYDAntGpnDhjdEoFUfhkBripV90zg5DUmiJ8j9HG0+kx8dEc
 lLRFmym/IXcQuru8IJ7KSzQYX/vutcVTMDXEpu/22i8hjsldO8k0tNyv9L8TG4A1ne0w
 dK/y9fXEpqJMyAnoVR1VvvinNzG+4EAOCrbVAPf3CFX5Tkdgpz4fsRDBogB6/qw8NvGR
 TFjQ==
X-Gm-Message-State: APuU4Z/WlPK78MAXIZiIQqcgY9xOxzwO/ZTrwkqlRmlp+gfQ1HHgoKBf
 Tc2LfvgIg54bOx8I2D68DMzx6VRDsoyn62QXZ0MYn+DCLG+RiO75I+xx
X-Gm-Gg: AYBFou2wOd4lYVHCDJzm8rQg86c4A5DHc13L7aXIONY0VeQq+3fLLfOAWbK4oEaT4vC
 XiQ4LLZfntM/abDxv31HF+HHUjn5VWzfKQgvr+pWnkD9PGL78m/vNEg5ChwJ1bkost50TyWG95P
 daYkPky6q/2T0Yv7g6ZqIktONYQ1Fl+D55aiBUKPFQjHsy1WbiD2yGuY2b3Q5fnesxzRy0HvQum
 Ek8hvx9mkN8hHwI8gChFb84+Sq5H2CfvH8143jYs2ZZoBE0xcnW8XZS/YvdEh+JypgzL4PxI6tF
 10kPoHZE4T/2nlSyS4UXPeUQTZZCn8v0WRBjJVt5ADgc+D+hngu+rWsE81+uQnRM3gp/h5+hz+F
 +L61zT3lYWJm5EBc0cBTiJbLxpSesvPZb8Ia6IwybQTWt0ac7/YaVGookB52owtXX1Vi/uO573K
 Gj0aTzGqSTo9/Fl3Hvct1C0QaXfHuZ03NtV1oa1hgfOfIz++cUfqFDH2FD9scAQhFPkhNFcV5Ki
 O5igDIxKw2rE66ys4+GbG5MWhH0x9gINjB9caekRIUgK+sJqpSf2ur/gDqYDzc6CzD0DeVp5tQ+
 LPIoMEWJpeJulhYPQQXjbICRLs93gr9TdutsMcch0g==
X-Received: by 2002:a05:600c:6290:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb7d6cd48cmr34326415e9.1.1794990508574; 
 Wed, 18 Nov 2026 00:28:28 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:28 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v4 7/8] dts: support virtio PCI ports
Date: Wed, 18 Nov 2026 10:27:51 +0200
Message-ID: <20261118082752.1043794-8-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118082752.1043794-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
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
lshw lists its network interface as an entry of its own, on the
virtio bus, right after the PCI device. The test run setup then
fails:

  Could not gather a valid MAC address and/or logical name for port
  port-0 in node SUT 1.

Copy to the PCI entry what it lacks from the entry of its interface.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: shorter commit message, no code change.

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

