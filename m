Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B204E8538C
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 18:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ECB040296;
	Fri,  3 Apr 2026 20:35:34 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 1D5F34028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 20:35:33 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8a3b0242631so28742476d6.3
 for <dev@dpdk.org>; Fri, 03 Apr 2026 11:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775241332; x=1775846132; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LxhDqJlgRStyPH8MH9ZuwHn8mo0O2QEfUROM8OASbDw=;
 b=Niry/JX/Swl5DDGEyXEEW5zaM0cDNTAVOHewwPstCOp9PnYvthR24oq8O9scKdUu8s
 g1VU6rskAl8FbPeNdSN0pL35OxAspFQ29gyLPSbnKK5N9Iy+WsqbUcTljF3nYHcrxIb6
 INS44pmb7kMRQsfcER7YONnjckh8cJIMuq42Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775241332; x=1775846132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxhDqJlgRStyPH8MH9ZuwHn8mo0O2QEfUROM8OASbDw=;
 b=jHEiZgje8hXUpWtG/8jUri9Vc4ozoqxzb5+NI2OUiybhwj7m7pT57gtp8PbwBrrHtq
 WnjE4m+STuEez/v00pCemxVjANUnA2qemXBBcl7PjH4of3PrO0Yt4wxjEIjhlBALr+yj
 9T0cOB3MfhUleoxZaS2N5cWI6RZOv04l+5pRB5OFHqD3dU3hDAqePn22mesPQrxUk3w+
 yzLd0mmJH41lo2QfVBTxq5j70Q1e35CJNegz3H8u8wtnaOu9miL+NCIAF3uKpcToDNxK
 d/qreyG19s8FiFVn+S0HuW8syEGa7K5paUu9sIquiRM4/1rXlXoofNmvY41oD2mL/aQV
 yLqA==
X-Gm-Message-State: AOJu0YxNiPfDCsKOjSB0yeyluBHWPQOK00DLJbtRZj6aoIMnFYLm0jhQ
 JkdSwk+g4FWoerUQXHDuSXP+egG3EQxXeqiIoKTIjCB1B1dkNfjXVT2c/OHZZiMIqvw7jPo48AE
 ZT2FYiS7z1TqjgUzq4/AXKlFfAsuasWMw6phH46E4ueScAy64nlx/KKtZcdLLkgMInWoSfyy4W7
 qW/7l+zIq4mgXEhTT4c+MvJP1u/zw=
X-Gm-Gg: AeBDietDEejeMKAgVjGFL9ZbTPZMv9uMwFYftuED/aC1IY5C9kIei55jngnLxeAm5Y4
 CRnZDWFXvRtW4vyfZyxJrQQzLSBAI+fZTvzmXInF2aqihnhrDse2BU65bDNgLMLMBj5yD4tdK+R
 gjhQEKdr7FVtv0anJ1EjZzsXjk0U6lWEfEnvLWWjac7bzuMImdnCIPcY7XQEg7PsgWmfToQV6cT
 fHnNxaDwDHwmjxWQCURAWfXl/RIG3Vs2zSzypTfClTBOejgOnHZsX7qAfyyIiZDEkYvNQG8fM4e
 FCsiyNOzHj29w3loul1ANwYv/CH9sqqYyX7TTjfJ2DqbGCtv/5kA1yE6kxdg82zXRt0vJDRZs3+
 hHRcutwpauugBAXkDS0Vr6V/2I8dZZNtC6VkheBCtmig/QXZ2Mf5G17/DumEUHDpMuzQFBVgsGD
 ubn9LZ4LoipCra4CHgpULJerZc2z6v96ZY+hIjlmNKfVNvm9uq+bnhoh2gDur4nQnw
X-Received: by 2002:ad4:4eef:0:b0:899:eba1:3c14 with SMTP id
 6a1803df08f44-8a7025b7992mr71348236d6.18.1775241331893; 
 Fri, 03 Apr 2026 11:35:31 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a593330593sm61371806d6.3.2026.04.03.11.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 11:35:31 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, lylavoie@iol.unh.edu, dmarx@iol.unh.edu,
 knimoji@iol.unh.edu, ahassick@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: update modprobe command to be privileged
Date: Fri,  3 Apr 2026 14:35:19 -0400
Message-ID: <20260403183519.496825-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

The command to modprobe VFIO-PCI will not work without a privileged
command. This patch makes this change.

Bugzilla ID: 1924
Fixes: 1175f18ab85d ("dts: automate VFIO modprobe in node setup")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..63856ad9b5 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -245,7 +245,7 @@ def load_vfio(self, pf_port: Port) -> None:
                 privileged=True,
             )
         else:
-            self.send_command("modprobe vfio-pci")
+            self.send_command("modprobe vfio-pci", privileged=True)
         self.refresh_lshw()
 
     def create_crypto_vfs(self, pf_port: list[Port]) -> None:
-- 
2.50.1

