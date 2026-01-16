Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F139AC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1300942EBB;
	Fri, 16 Jan 2026 22:17:12 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 6B52242EB7
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:10 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so3920204a12.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598230;
 x=1769203030; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRxeyOv/HtY5k4pXFpD0GNB+atM14ohtpUqMaBnelmg=;
 b=m20jintkdQRG1LxHXVE8rtbUTQiCh0YdB9MmixhJzhDIXU6BWkQFiVCDUigbzyQsN5
 5JBYWCMW1/wcH7IGeJlQ3lWi7t7q2AiRJmy9Q4dXDdB+Y2BBq+Cd4Qp75osAM7gYwzjT
 pw388BwJVAagbhxC/AT/56MrHFQT25kGbGwODqq3w49BgziB567yXDi98DevGuALQEBz
 Hi2sEovRpokv3q2VXGnPYRpIwk2rFGNP7Vdn4NdrNrCV3oiVlEtoNUKHoAHUxxay2Z2c
 NAoAasU6TpJlSPmCNef2MDRd7GYVvBCygKAUVZjTsR/UL+H0HAi5ENo0kDT1AJKo0kkE
 mx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598230; x=1769203030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BRxeyOv/HtY5k4pXFpD0GNB+atM14ohtpUqMaBnelmg=;
 b=S5tzLpIAKiIHcWBuWGV57RhY5hyODsDUL5abHppcrgddqlkwVObF6N0uLAc5XTbYvU
 CKoiNEOeX3dEoakUAPTnSqVUndHRx5XLJFS8tnsg0DwBLoP6/f9g84GF4W9nbabOmIVu
 C5q4hRIxpwBPjyLDqpE7Z7psmXAsHG+uA7UVem42EFACrPe2HNe/i+DOOwil9C5i1mCl
 MJ7rDIvCgHdusH08V/1RvJkiDeYJpG0EpxmWnVXuuxMikyhetBg6jsFI2bgw8jAlIabw
 lMerqj/odNAfliX1sPYWdkiGtf4rBAtl+yu/54E3P4j/zA/whXPIKiSmBWCeFzhW7GDM
 ffZw==
X-Gm-Message-State: AOJu0YzYCaKaEmMFlY/R3cg6qJcROqaaOLBRW8rVRgOAydg0V4UBan1+
 alwW03PVeWiXZgIagMlrHWoUOBXwZ/VbG9I2C21aMxkZ3RfsI+VyfiO1HOi3gNu6SIw6NJh2I4T
 CmZ34
X-Gm-Gg: AY/fxX7HnOdc6rZ7mihiEyd4Xtdzmsd3EJECAjcjVl9jEqgB4cV017FKkli1iNiL+dY
 RYv1iJzE/5kLP9Fx4Sz8ISCj1ljWAQAeo7q7flYx+vmq50wfbBTvXy6oOKzG7dCFStCp9GjPCWU
 gdyJuKmvIuwOmjUTHlMVdLGWo5Y08tnYg/MbifX74Rghpd/heFZa8E4Tj7AodCBsr9IR5Go2P0I
 Jbs07k8Yw35zW30X26wpcFBlF5EiAMGkR1uCMYEK9j7W0M/7NV+md5lskj/bV+2ZVDpoTYgvR0c
 gWWik5YNgJUHENTRCvAkDPfEHiYJPd0JMBQgSdaFpwqeEm7etHEXTIo0FZ7jw6SYYQYMrK6Uugw
 E+RQmCeGCjWK29aelhZvxlihbx+z4Xb3Q/qLoXa28YWZP4u9Y09oqFLsOYUKWJYMmB/Tvkr8ne1
 FMpEmLa0AOV4GtSIKRFiWRZnXdnXBTygfF+17H950IGH7nj+FkoYD5QCyxH+jA
X-Received: by 2002:a17:907:9689:b0:b87:965:9078 with SMTP id
 a640c23a62f3a-b87968b7de1mr296854466b.7.1768598229896; 
 Fri, 16 Jan 2026 13:17:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 07/11] doc: correct grammar in ARM64 cross-compile guide
Date: Fri, 16 Jan 2026 13:06:23 -0800
Message-ID: <20260116211649.104776-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Change "files... is" to "files... are" for subject-verb agreement.
Use consistent spelling "toolchain" instead of "tool chain".
Change "distribution" to "distributions" for plural form.
Rephrase "Substitute <target_soc> with" for clarity.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
index e4de5c8d18..82dde17c35 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
@@ -44,7 +44,7 @@ NUMA is required by most modern machines, not needed for non-NUMA architectures.
    using the below guide. If you're using a different compiler,
    make sure you're using the proper executable name.
 
-The numa header files and lib file is generated in the include and lib folder
+The numa header files and lib file are generated in the include and lib folders
 respectively under ``<numa install dir>``.
 
 Meson prerequisites
@@ -185,7 +185,7 @@ provided the cross file has been modified accordingly::
 LLVM/Clang toolchain
 --------------------
 
-Obtain the cross tool chain
+Obtain the cross toolchain
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The latest LLVM/Clang cross compiler toolchain can be downloaded from:
@@ -236,7 +236,7 @@ use the following command to cross-compile DPDK for the target machine::
 Cross Compiling DPDK with LLVM/Clang toolchain using Meson on Ubuntu 18.04
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-On most popular Linux distribution it is not necessary to download
+On most popular Linux distributions, it is not necessary to download
 the toolchains, but rather use the packages provided by said distributions.
 On Ubuntu 18.04, these packages are needed:
 
@@ -260,7 +260,7 @@ option::
 
    meson setup soc_build -Dplatform=<target_soc>
 
-Substitute <target_soc> with one of the supported SoCs
+Replace <target_soc> with one of the supported SoCs.
 
 .. literalinclude:: ../../../config/arm/meson.build
    :start-after: Start of SoCs list
-- 
2.51.0

