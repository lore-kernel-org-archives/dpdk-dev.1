Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA1EEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AD6440431;
	Wed, 31 Dec 2025 19:58:19 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 7495E402D6
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:58:17 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b61f82b5fso14756460a12.0
 for <dev@dpdk.org>; Wed, 31 Dec 2025 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767207497;
 x=1767812297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDhqgKfky9Ufkv9NrN6XCWJUMw+0CDiBkOBk7wTvrSs=;
 b=IcxPbS+6uWD3jbbJ/zB+4edfZMXaf4q6VXs/ehPEv+LWR1jmNW8mTs0Gg05FY9bKFy
 tq5CSUtMLzpA9/DDR1dY8fGEa1T3/pu249N+g/nsKU6QuyYtjuu1lx1XYi6LKJkkHdRX
 DPUA5UIwm+YH3dySV1h+G+WaFqE0Nfjj1LmV3YgJzc5LmEcOCmSiQi+XRQEz1b7l65BQ
 ClZ4413zn/bGcyzGvZO5Z7YdmHUOWFwQA5ryC2on+rboDh+KWfDC8GOeWZRde0SATUMd
 Q2y6R/L9+p9b2ytD0XwhEAj4CSZPJolPQBYlj3F5eAhEzSlH+BW60G6u/qV0lS82Bl/w
 4Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207497; x=1767812297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDhqgKfky9Ufkv9NrN6XCWJUMw+0CDiBkOBk7wTvrSs=;
 b=k3DQjjOIO45O4t5yBqCQs5zNb5/UE1daiNlCMobseu9XSp6Ty4dd4T20hdPt8b++hs
 2EOK/USCmlQ+L/8Y9Jomi0yMRdmfbH2PxVzhkvRBO0XyfCA9+GxlZkJ8avSCUZalpMsJ
 auLyADbQa4Aln3RLMTrA6/nIaoIxICFK0wIs/fY5XcD/eYxwS8hk8Ln8hWupt19FUVWc
 RNwR7a/XbFsaG8GJodyJOzlnp7GCkcg85ToJAi3js4x6SQIv8WP5TsKtmlVvD+AeCmmM
 R3CsXgu85+caDx0mrAS2CCpCFoPQZgQJs0B+kieMMWQo+fZWGxh3GFvdBGy57nSqGEvV
 KV0w==
X-Gm-Message-State: AOJu0YxnkBlxd2T5mZJ1pAFwUcPU6oT2VI6vpfRmBmVGMracPIZFXIrp
 hzmLNxUSQDAHFD6+yy9HEY8rszXgHvJnYM473t24ZrbqqNe1r+05EuHeIyzpPPZFAq3/finRtv0
 SglIQ3bo=
X-Gm-Gg: AY/fxX48/y4o7iSyde7ZGrz+Egisf1xElprKs4N+JzObG238phmHVJehmC4gbqC89Ce
 IMO36lHLSfKHs7NRjuQ5xrnDRJuzDvDqDSyQSE4iJr/6DoF7CPjk4WBw2aTQD63+YoLnC1YD6VF
 ZZoQWTuQQVnJXtAc2/ixz3H66n1nZw7qpUWUUDhZUbuPICmRxUPrgOKD5JvBHvR4p5JhrJ4rIph
 fEzks6H3dlMWzkl06ZpLkM23WeIRSINMPOAmD5WE+9WNMsVu7TjKY0nxMwtaUHODpWizudh2zg9
 EmdIQRqWXh6bXt2l2WQ/zil3+E0GDNS4yfcfqfpggWSK0hLUlZyDZJ8OgZSWFcFcKkfAq2YEKxY
 fG3usdHdFAz1lbEEbDRDVotLmADs3Vuh4o7+jUNzhNcGlczt+I0Mi6/Z7gSc5k1OnZnrQTVhjHj
 0/ANDMFCsGoOcaSEt9/NzJ804qjGHhVJSR6XwtVrTG2oKnruEygQ==
X-Google-Smtp-Source: AGHT+IHaQqY2NpslqalSOIO5L33no6Yu5JbCtO6xcq8kisqNyKVTEoNCGIONynZ3B7vv34jgdxSGEA==
X-Received: by 2002:a05:6402:144a:b0:64b:6e44:2c6c with SMTP id
 4fb4d7f45d1cf-64b8ec9b1d3mr38069799a12.16.1767207497007; 
 Wed, 31 Dec 2025 10:58:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm39000103a12.21.2025.12.31.10.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 10:58:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [RFC 2/4] examples/vm_power_manager: replace /tmp with /run/dpdk
Date: Wed, 31 Dec 2025 10:56:26 -0800
Message-ID: <20251231185803.90528-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231185803.90528-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
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

Applications should not use /tmp to store unix domain sockets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/vm_power_management.rst | 13 ++-----------
 examples/vm_power_manager/channel_manager.h      |  2 +-
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 1955140bb3..eb9228f0eb 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -195,7 +195,7 @@ The XML structure is as follows:
       <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </controller>
    <channel type='unix'>
-      <source mode='bind' path='/tmp/powermonitor/{vm_name}.{channel_num}'/>
+      <source mode='bind' path='/run/dpdk/powermonitor/{vm_name}.{channel_num}'/>
       <target type='virtio' name='virtio.serial.port.poweragent.{vm_channel_num}'/>
       <address type='virtio-serial' controller='0' bus='0' port='{N}'/>
    </channel>
@@ -208,18 +208,9 @@ channel. Likewise, the port value ``{N}`` must be incremented for each
 channel.
 
 On the host, for each channel to appear in the path, ensure the creation
-of the ``/tmp/powermonitor/`` directory and the assignment of ``qemu``
+of the ``/run/dpdk/powermonitor/`` directory and the assignment of ``qemu``
 permissions:
 
-.. code-block:: console
-
-   mkdir /tmp/powermonitor/
-   chown qemu:qemu /tmp/powermonitor
-
-Note that files and directories in ``/tmp`` are generally removed when
-rebooting the host and you may need to perform the previous steps after
-each reboot.
-
 The serial device as it appears on a VM is configured with the target
 element attribute name and must be in the form:
 ``virtio.serial.port.poweragent.{vm_channel_num}``, where
diff --git a/examples/vm_power_manager/channel_manager.h b/examples/vm_power_manager/channel_manager.h
index 6f70539815..5fc93ae0be 100644
--- a/examples/vm_power_manager/channel_manager.h
+++ b/examples/vm_power_manager/channel_manager.h
@@ -22,7 +22,7 @@ extern "C" {
 #define CHANNEL_MGR_DEFAULT_HV_PATH "qemu:///system"
 
 /* File socket directory */
-#define CHANNEL_MGR_SOCKET_PATH     "/tmp/powermonitor/"
+#define CHANNEL_MGR_SOCKET_PATH     "/run/dpdk/powermonitor/"
 
 /* FIFO file name template */
 #define CHANNEL_MGR_FIFO_PATTERN_NAME   "fifo"
-- 
2.51.0

