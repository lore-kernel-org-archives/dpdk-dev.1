Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E5C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87F4D40ED6;
	Sun, 18 Jan 2026 20:13:53 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 88DFE40E48
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:51 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b872cf905d3so600079666b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763631;
 x=1769368431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkrgl8HEB7x0gd08apNK01AEyGvKpFuSIGwRYrAhj2c=;
 b=U7DPe7FAxGXi8B0gm2zB4sRGv4SPU7JMAY8PkWVBg1cAJuqbKCDctTwbDtND8hHdTN
 e5LO8w25vtRlU1sqqn90P4pXemV3ujmbS6MTGdhhq07+Oau4vAFTbH+PHhIdQ2x43Ejj
 HpKTnLkDhzPnHo0tgzES1mrNS4N+qABXfgJZYVUenySc3FRyJPawQ2HGrKt7H5u01msx
 CyknlgFPUS8q5AXpZd4Sx4bACdFbjWwkNnx0zo7nX78kOkXUoVZ/y7qEASsNBn9emtIY
 TyLP60n8P5gN2r/SFAucnsGkBbAES95eKxaLC1BJNX5Fu6mnWZ2pxYpF6nj/sgjeS4pv
 w9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763631; x=1769368431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rkrgl8HEB7x0gd08apNK01AEyGvKpFuSIGwRYrAhj2c=;
 b=Reg95HN+XXwtWROs+e5jnFOkSFN1Z8tECWUms1TzhJGa39hUKNGjixyhJdxYnfi5R2
 Rqwk8Ru+X7GMHw9RNrcMZSCFkZtwHy+p4ss8fpiCuZIgpmWwtcRRj4jAyQh0lCGkGoDV
 Dhm3lCtV/nkgJaOLj3j091QqcElEfsRvD4xoTGLLvl2BTAvDPc6/pmrRfog8PS6Lj4Zt
 AxuGcgERicQ9Kn2xVfLbtBFXlaw7TMCnTad7Rmawl97Tsx7EMi5mex2ui38hyc1Fs0ec
 3AebkR6ctXQA1ExrC16WV6l3uQF+jVfDhSdLMZFWkReutzipD5EVwq+U+YI0J1Y++TmH
 do9g==
X-Gm-Message-State: AOJu0YyxVBoDyT7cf5k28CT0x0dCo59M2RV9rbPt6piIdGUeu8FCYfgx
 uJJcJvh7KQJL8FgIkF4vGF27v2bs1/HLWZX5jPMAQ5gM+apPgYtzkY+34Ld2HQojhMrKmN56oaK
 iI7C9
X-Gm-Gg: AY/fxX5jnid0R1a4otNDsv26TvViD4PiggXn/YUMALDlbALHr5B4GbppH3boSTTaI2P
 NRDEAe+WLChHRJTw+LHTG6OSKTeSaVMQY4D0/iFc+XBB1MwosX9Es6XrGpJ3+qNPddc8bJMFGGY
 fbDUuXAJSew+76/iLh0CVY9w8M//uAwDwBThBEdfSapnFOHBdQZbPakLqzF9abXkQEOMqRZoIL8
 debtiFJi3Q4bih1yTmKc45VPA7YAdH7SAXweq/yo1vzFu/LdxTvWk5wb8kTTSGOcWnfU83P4EuA
 Ct61Lo+2c+uXc/vRkV9LhVcjeuwe9tqadOysOrMeuFzkFlunCL4rmfxXokf31AoQd3Tz6kgL8UA
 H3lN3kJw5UYaKZwc5VN2uwjbHPbQGiiWyqHU7+YLfsgK+2Zr94avtSTCwI3RbrNSDcTukISVAYF
 IcicQ+KUGVBc6EZqccNeYf70n4bnh+G9qgnA2eCLLLkB5ihlgCDQ==
X-Received: by 2002:a17:907:c1d:b0:b87:12d2:fa1a with SMTP id
 a640c23a62f3a-b87968a972cmr730952766b.12.1768763631027; 
 Sun, 18 Jan 2026 11:13:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 14/54] doc: correct grammar and formatting in compressdev
 guide
Date: Sun, 18 Jan 2026 11:10:17 -0800
Message-ID: <20260118191323.241013-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct several documentation issues:
- Add missing spaces in "physical (hardware)" and "virtual (software)"
- Change "For e.g." to "For example,"
- Change "checksums operation" to "checksum operations"
- Remove double space in code comment
- Change possessive form "device's processed queue"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/compressdev.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/compressdev.rst b/doc/guides/prog_guide/compressdev.rst
index 2a59c434c1..a878010c4c 100644
--- a/doc/guides/prog_guide/compressdev.rst
+++ b/doc/guides/prog_guide/compressdev.rst
@@ -5,7 +5,7 @@ Compression Device Library
 ==========================
 
 The compression framework provides a generic set of APIs to perform compression services
-as well as to query and configure compression devices both physical(hardware) and virtual(software)
+as well as to query and configure compression devices both physical (hardware) and virtual (software)
 to perform those services. The framework currently only supports lossless compression schemes:
 Deflate and LZS.
 
@@ -17,7 +17,7 @@ Device Creation
 
 Physical compression devices are discovered during the bus probe of the EAL function
 which is executed at DPDK initialization, based on their unique device identifier.
-For e.g. PCI devices can be identified using PCI BDF (bus/bridge, device, function).
+For example, PCI devices can be identified using PCI BDF (bus/bridge, device, function).
 Specific physical compression devices, like other physical devices in DPDK can be
 listed using the EAL command line options.
 
@@ -113,7 +113,7 @@ acceleration and CPU features. List of compression device features can be seen i
 RTE_COMPDEV_FF_XXX macros.
 
 The algorithm features are features which the device supports per-algorithm,
-such as a stateful compression/decompression, checksums operation etc.
+such as a stateful compression/decompression, checksum operations etc.
 The list of algorithm features can be seen in the RTE_COMP_FF_XXX macros.
 
 Capabilities
@@ -488,7 +488,7 @@ with each chunk size of CHUNK_LEN, would look like:
 
     uint8_t cdev_id = rte_compressdev_get_dev_id(<PMD name>);
 
-    /* configure the  device. */
+    /* configure the device. */
     if (rte_compressdev_configure(cdev_id, &conf) < 0)
         rte_exit(EXIT_FAILURE, "Failed to configure compressdev %u", cdev_id);
 
@@ -592,7 +592,7 @@ on the device's hardware input queue, for virtual devices the processing of the
 operations is usually completed during the enqueue call to the compression
 device. The dequeue burst API will retrieve any processed operations available
 from the queue pair on the compression device, from physical devices this is usually
-directly from the devices processed queue, and for virtual device's from an
+directly from the device's processed queue, and for virtual devices from an
 ``rte_ring`` where processed operations are placed after being processed on the
 enqueue call.
 
-- 
2.51.0

