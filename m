Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254ACD4851
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 15:41:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 638EC402B6;
	Wed, 13 May 2026 17:41:14 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 21D8A40041
 for <dev@dpdk.org>; Wed, 13 May 2026 17:41:13 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8d67a483d3eso767274585a.1
 for <dev@dpdk.org>; Wed, 13 May 2026 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778686872; x=1779291672; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdMpQH9SFC3EjceAseAp1oUWrN2YolNfwGxVNW2zIyc=;
 b=aAesGIPinMK9dEyIr+IoAkLCIwrjHxtESZSUxhx7wFczRfTGjAR0XIhZoh4b9cJFC2
 9IHW4BiHktVsnMJYOqXBTCFc9DXdQw3HB0T4USDj4cBQbVzoEfZfFsnXYeNgZciuBz2e
 qrh9ayXjmYloOkDc1e+e5f0Ua26243tKiAXcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778686872; x=1779291672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qdMpQH9SFC3EjceAseAp1oUWrN2YolNfwGxVNW2zIyc=;
 b=Lrf8ulwnWactv2VcApiRhuOT3rbo/ocAMa7yYiW+dJpTZmhSVeRdmqHIAT3Yf+1rDF
 c47CHyoJPVs7lciFmSiMWOorqZAXTjufuvMR5hcdfSOOZcGjOuVSFFujxyGP1A+nuOzy
 zS1kuYbGszyZGVy003bjgdTyqRQBoWAUMslP4o3haJeLBjk5Awx9nSzXBV2KluQpBTRt
 Xm2C6wf583xoBXKnfPNEm4p+AacyWUKIT+CTjcIZSs7IsG1pWfhzn1DAW4bJ5QYD8uq/
 2503zwyH+/vRHecdLd9S8hp07fwfpF7o20ILp+4g2qo34lsERuI/bLYpkH089/IiVR9z
 G9PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ95JAqhEx9SvFE8t0FCxvjsP0CHMCyAcHFXA7wE3RsxMwLj52g7O2UMCSG1ExdruAym4m4=@dpdk.org
X-Gm-Message-State: AOJu0YzTSnN+A6VpbC8jyvkFdqVyXxWMQSZPdSHaHF9mNHlmH8my16yu
 2pVIjrcH0d6Pg4mOu3GNdT1uePXXh89tpmvtYnW5xaxmRGPnO7jo54u5e1I1+7JSco0=
X-Gm-Gg: Acq92OExSr9E2/vHxlJNKEtTVW3RuSYb17f4eCX8ho+6hYZSkhT1DAkPVMkp1hTS+5T
 urecKclpmaF5/TkOCqYjeaLZWnK2iBXEq7zbGjSwQ7Kzq5giB632asYx/QfyQW7QoaIx9bdqsFQ
 6cPvB3YBPPOcDJGdp+iVCPpwYFUUPatnFTd8/xM0j7UGu1yqwUkqqGF3cjVS65oQI0lxHDxwpW+
 ZVSK5oStnveIM3fmzMETSB3VDpU+DmxTvzRZaBtWG961b2Wkc+hR/jo4hvbTcP67nDoPveCChpG
 UbzxQtJmel5D9CU7U9fxp5VDkWCXTrlwo0NS1Lld6PDfe5oxzjS9d7EJephm0Yn3306WlU3PxG7
 1l5LvYrECkQkji85KLu1YPOd6UrAVi4TzyFbLq6vo7sVeoP8PucbbfzpdBY1I1j6b4hqwjU7CSm
 GZbEDg2BfSBxBFnGN2w9dxPRt4cJkAechkyzzSq0uC3uijJnX7FHXR/HG57N3t9+aPljBl2FstL
 iQ=
X-Received: by 2002:a05:620a:2586:b0:90c:9b5f:84f5 with SMTP id
 af79cd13be357-90f88d99c21mr576414985a.6.1778686872145; 
 Wed, 13 May 2026 08:41:12 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-90ef9fd7cd9sm364440385a.1.2026.05.13.08.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:41:11 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: clean cryptodev environment after a test run
Date: Wed, 13 May 2026 11:40:55 -0400
Message-ID: <20260513154055.134729-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507163659.40739-1-abailey@iol.unh.edu>
References: <20260507163659.40739-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Prior to this patch, the virtual functions created by DTS for crypto
devices were not properly cleanedu up. This could lead to a system to be
left in a bad state after running the cryptodev throughput test suite.
This patch properly cleans up the environment after cryptodev testing.

Bugzilla ID: 1923
Fixes: 8ee2df9da125 ("dts: add cryptodev package")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
v3:
* Added a missing type hint.

 dts/framework/testbed_model/linux_session.py | 29 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    |  8 ++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..aa53f1e5e2 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -181,6 +181,22 @@ def get_port_info(self, pci_address: str) -> PortInfo:

         return PortInfo(mac_address, logical_name, driver, is_link_up)

+    def unbind_ports(self, ports: list[Port]):
+        """Overrides :meth:`~.os_session.OSSession.unbind_ports`.
+
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        ports_pci_addrs = " ".join(port.pci for port in ports)
+
+        self.send_command(
+            f"{self.devbind_script_path} -u --force {ports_pci_addrs}",
+            privileged=True,
+            verify=True,
+        )
+
+        if self._lshw_net_info:
+            del self._lshw_net_info
+
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.

@@ -289,7 +305,18 @@ def create_vfs(self, pf_port: Port) -> None:
             self.refresh_lshw()

     def delete_crypto_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
+        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`.
+
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        if vfs := self.get_pci_addr_of_crypto_vfs(pf_port):
+            vf_pci_addrs = " ".join(vf for vf in vfs)
+            self.send_command(
+                f"{self.devbind_script_path} -u --force {vf_pci_addrs}",
+                privileged=True,
+                verify=True,
+            )
+        self.unbind_ports([pf_port])
         self.send_command(
             f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
             privileged=True,
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2c267afed1..f2dc9b20a9 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -573,6 +573,14 @@ def get_port_info(self, pci_address: str) -> PortInfo:
             ConfigurationError: If the port could not be found.
         """

+    @abstractmethod
+    def unbind_ports(self, ports: list[Port]) -> None:
+        """Unbind `ports` from any driver.
+
+        Args:
+            ports: The list of ports to unbind.
+        """
+
     @abstractmethod
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Bind `ports` to the given `driver_name`.
--
2.50.1

