Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D68C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07C8840E21;
	Thu,  6 Aug 2026 07:10:45 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id CC3F840E19
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:40 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cad8076b01so21724125ad.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993040;
 x=1786597840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dDsAMkn8os9PEx9/aUH5V1c2umBDnXc8oB0J5LoaNcI=;
 b=jUfZNeMFm+u6NBJBcKRwUFs/FGgVLxv2cE1DWkEkNJnW4QOq5FTw4tgmoFM+ZtFlOU
 +dusKWe3y6lV+EvzVVdoNdOitEXx0EYuVYw+Mvc7BZPvou+1VjBoiGpiE5nYlDZx2Ote
 rQKnpgW3JiYyEkEGJiRHm1njEli3O0RjZ9LCpwfNZKYZ/Kp8His8Al25M6wfqmWpKBgX
 ZDKBKUzHxY2QdYXF+O0+CLj7Uj5jggtwtjpy0hlzSNiHqDNy+qIp9ue0jf4zFdzRAZm9
 o9XyG7FPFOikW8uY1U5u5gm5knESfQMLQ16DyxLRdFN36VpQbiuE7LfYChoD19nzGlP9
 Pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993040; x=1786597840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dDsAMkn8os9PEx9/aUH5V1c2umBDnXc8oB0J5LoaNcI=;
 b=G52xB3PDzp7JOxWMjlPbaodrswsMz4hMI496Ka4Bs17mCQPLznMw8V7T1Dfn2dukQU
 3BU+2imv7AgP9EshOwGBG/mzSgSqHUYweucOU8NTymoJ30whrnkhD9GBogUvr/sE9OcF
 9R5bUic49ITY4S5LfrEbflnosjHbJc9638uixwszUuDbWGtjOy6gr6n2BTPDazicK1BG
 fGsXNnsJbgDL9FmHQqt+sLr+wku527HyVbWnoAh0pW4jHDmgvI2UbJlriyaTjrMrGxEd
 Gq5RI0XT7OkZ0YqTVHeFBv/hzeGgfrXInD5TzSquRPPHXmSYay9Q0iixjuiBrxdJhBm5
 CT0w==
X-Gm-Message-State: AOJu0YwPn5CmEowLOkoe1LNkWhh22i+8JTUQpdZAF9/It2lMDNv5Cvj2
 Qy7KIS5RTt2QGJfr6YQ1yRHpw4F206flMyI7KxD2k2vrH7VUB7YO5ROfgQ171VmqSrJsbLAV9f1
 tyDq9hm8=
X-Gm-Gg: AR+sD12GpLWpoLZ6Yi07/IuSBPn5SQSRcY7RDIg4V+v53IKG/GonRWdYNh6RbMeyvXp
 L5oLRYPJCIK5N0QmMiOKlnYiFHW9hAOSIPDENMlnRkdD/Tkb23qPyb8DUKHOhB3uFNe5z3SIq7O
 DaJYJjWyrFoKheymoUyqrM9e6wEDQrhhLval14t7y3LTM/XzN3WbPoF/AVrWnbCmy9Ly9kfZJoS
 80mbzDNyM6s/zMyCpuxpzWdDZCQwYpqcxtmezyaL8+i2jCVriYFgUSB09/k0kmNYuweFeLuH+R+
 Nt3ETmVL8a67jxDQ17D+Dn60feA4hHRCnwh8BRaZz0aXquVmfJljBLCC+MpY7y62xFVCtVigH0W
 xWHaU8L/em9KR7yKsGpaPfLFAb0cY2ScsqdibgzTStfqBj/9zWWDrGrQUfYEcIIDNIJogD4fLjI
 /DWJ5TwYrToI8tdpXCJI9KlsqW39qLswM1fRBSvazz9I/RDOG7Fz0B5e2T93ulr7EUONDz1FRWm
 MceYDKr2MiCvX5/ryRIdSp8lnk=
X-Received: by 2002:a17:903:46cf:b0:2ca:304:f93e with SMTP id
 d9443c01a7336-2d0caa11317mr157730565ad.22.1785993039960; 
 Wed, 05 Aug 2026 22:10:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 23/23] doc: add release note about rte_ethdev changes
Date: Wed,  5 Aug 2026 22:09:17 -0700
Message-ID: <20260806051004.166778-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

The changes to rte_ethdev are visible to applications,
which may need to include some network headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..3749cbd456 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,21 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed legacy flow director related API and files.
+
+  * Removed experimental APIs in:
+
+    * ixgbe: ``rte_pmd_ixgbe_get_fdir_info``, ``rte_pmd_ixgbe_get_fdir_stats``
+    * i40e: ``rte_pmd_i40e_get_fdir_info``, ``rte_pmd_i40e_get_fdir_stats``
+
+  * Removed testpmd commands:
+
+    The ``fdir`` option in ``show port`` and ``clear port`` were removed.
+
+  * Removed file ``rte_eth_ctrl.h``.
+    Drivers that still require FDIR related structures now use ``ethdev_fdir.h``
+    in driver SDK.
+
 
 API Changes
 -----------
@@ -93,6 +108,15 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Changed ethdev include files.**
+
+  * Dropped inclusion of ``rte_flow.h`` in ``rte_ethdev.h``.
+    Applications using flow API should include it directly.
+  * Network headers ``rte_ip.h``, ``rte_udp.h``, ``rte_tcp.h`` and ``rte_sctp.h``
+    are no longer indirectly included by ``rte_ethdev.h``.
+    Applications should include network headers as needed.
+  * Legacy flow director definitions are no longer included by ``rte_ethdev.h``.
+
 
 ABI Changes
 -----------
-- 
2.53.0

