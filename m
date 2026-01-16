Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE27C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE62242EAE;
	Fri, 16 Jan 2026 22:17:07 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 0BB8142EA6
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:07 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b87003e998bso595771166b.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598226;
 x=1769203026; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ID5QG8dGPFoX/UNSJK+RPgz+pUbdeFcGx5LaiBbrvJg=;
 b=Txns19FL8ANQqVrQJXsFVFwvJm1AoUXO5SG9iuL2qYV/4WqRpvmGNPyhzYPdeM9eo2
 4DvEhyDpfj8wFy0vEG4Y0Gu+aNIC6J5bDXCeAWB3L+pwE1/zD5eoDpAgvmAbS0baXbR8
 b5hdUE3t4FsrLrOuUhfwMg6Q94A8XbOeFlXiBzBfZlo4V50zDpl8QIbC2fjImgcTNboX
 SVTmSPyaPEFnqo/YddozLZ9lRC2Kc1QkWWzMW4O8cl1oTkM0lnNXpRVRR7JJdeX8rHlb
 Up0UQJfGERZ0XSHHvAtZ0tcRQO2e/IJDgq0/JO916LZiWA2WoFQkEKznWPny/jVwC3gZ
 W9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598226; x=1769203026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ID5QG8dGPFoX/UNSJK+RPgz+pUbdeFcGx5LaiBbrvJg=;
 b=Etlf+MAcisvoy9t1SCN1Zy27TA4kFpmFWV7e130bwqsOcBkUk7d1MKRkeXSB3IQ3lA
 3xMcf5fsge3jMvNe+1qNBnZSbNnlX56iJiYisPJuB0QvC159oIS4Fx0BU/n6secyQdbg
 O/eaMVgWe0pzV359PjODQsgpeqmGKxhMD3YBmIpAR2uNgXJdmtJlKS85kanhhP54vlM9
 5RYva2GAt8zsXKqQpXPgIBs7pE9PZ2LVv8ib3ZqIvXuwmxQfhQKcgvkvvgDvFC2zu1jf
 h3iaQ+V+w70eTQgkIzIvWxTQajEr7egK7icDL9tEjACaLoGWfl35dIT3ninEngJbbwC5
 ZHlQ==
X-Gm-Message-State: AOJu0YzDsk8ImvcNF3ZdfreLgofk/mPizCKwf1GulF5qvtwQXN4xZ6E6
 mePnSmIFr16SX98adDLZ+YtzgilGKqtnPUqCgts8u0yyeAiNJo/yx6yqYODOHB69CkGrZ7Wqd7d
 LMey+
X-Gm-Gg: AY/fxX7T70aefoO1DwJnVquB/rLun0xAUm5sLMLrfAIEUJg8AwDJWGmo74oaD4Pge4Z
 Zr0eKIhFeQNTREDzVOgeLAJNZX+llxUxbVGi8dIbJ4klntHZ0mBSCRp8cvhPxMp78qWpHKoS0nb
 jsfh4HpZfJeZe9ToxLtrAERPhJ57TJr2iO5RLfCkY/uXoNrL2yyWyWC/bRqjmuWHXZ64IZi9Avb
 tlD2bQq5KDid4Ye2sK60i0tg/bOW9N5a0T8i+F77BrLfEaXFIqB27yoj9YZqQKwY+UcgtTmHtLg
 Oec0ZJnsjl7qZoU4S+yRJEzxsefM6IMcIBdqpBhA9TiwC+E9ON3FITFVc0itHX0EFUaNnlCKerI
 qXkV7nR5QpBsCQ+QifdOReVjGqVoKMWPZfdbvn9HQUhSiyEELyluRjGZ8Lw5ZbGWg5lRD8Uynh0
 /6UrVrLdgIEnMbS+FZ8ZnuMHzfBcm6IRCd5lgQAuL1K+dMkXdD//iYb752D1wN
X-Received: by 2002:a17:907:7243:b0:b86:f558:ecbd with SMTP id
 a640c23a62f3a-b8793890124mr503288166b.13.1768598226623; 
 Fri, 16 Jan 2026 13:17:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 05/11] doc: correct grammar in Intel platform guide
Date: Fri, 16 Jan 2026 13:06:21 -0800
Message-ID: <20260116211649.104776-6-stephen@networkplumber.org>
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

Change "take" to "taken" in passive construction.
Change "you wants" to "you want".
Rephrase awkward "If it wants" construction.
Change "drivers needs" to "drivers need" for subject-verb agreement.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/nic_perf_intel_platform.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/linux_gsg/nic_perf_intel_platform.rst b/doc/guides/linux_gsg/nic_perf_intel_platform.rst
index 4a5815dfb9..601d7bdc7a 100644
--- a/doc/guides/linux_gsg/nic_perf_intel_platform.rst
+++ b/doc/guides/linux_gsg/nic_perf_intel_platform.rst
@@ -82,7 +82,7 @@ You can use ``lspci`` to check the speed of a PCI slot using something like the
 
 When inserting NICs into PCI slots always check the caption, such as CPU0 or CPU1 to indicate which socket it is connected to.
 
-Care should be take with NUMA.
+Care should be taken with NUMA.
 If you are using 2 or more ports from different NICs, it is best to ensure that these NICs are on the same CPU socket.
 An example of how to determine this is shown further below.
 
@@ -101,7 +101,7 @@ so the following is mainly for reference:
 
 #. Consider using Turbo Boost to increase the frequency on cores.
 
-#. Disable all virtualization options when you test the physical function of the NIC, and turn on VT-d if you wants to use VFIO.
+#. Disable all virtualization options when you test the physical function of the NIC, and turn on VT-d if you want to use VFIO.
 
 
 Linux boot command line
@@ -119,7 +119,7 @@ The following are some recommendations on GRUB boot settings:
 
       isolcpus=2,3,4,5,6,7,8
 
-#. If it wants to use VFIO, use the following additional grub parameters::
+#. To use VFIO, use the following additional grub parameters::
 
       iommu=pt intel_iommu=on
 
@@ -181,5 +181,5 @@ Configurations before running DPDK
    **Note**: To get the best performance, ensure that the core and NICs are in the same socket.
    In the example above ``85:00.0`` is on socket 1 and should be used by cores on socket 1 for the best performance.
 
-#. Check which kernel drivers needs to be loaded and whether there is a need to unbind the network ports from their kernel drivers.
+#. Check which kernel drivers need to be loaded and whether there is a need to unbind the network ports from their kernel drivers.
    More details about DPDK setup and Linux kernel requirements see :ref:`linux_gsg_compiling_dpdk` and :ref:`linux_gsg_linux_drivers`.
-- 
2.51.0

