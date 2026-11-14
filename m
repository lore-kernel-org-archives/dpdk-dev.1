Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5763606A338
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BMuo7zFY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A2E740DC9;
	Sat, 14 Nov 2026 01:55:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id A4FC24025F;
 Sat, 14 Nov 2026 01:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794617743; x=1826153743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fyscUzRQZ1hOli3deKm65jMFCMvZWTkJXwb1gIY+X6s=;
 b=BMuo7zFYP4+5UcHIZM4vWHAjtchmOyhIFUJzlX2ulqgbgz/LxYDMmTGU
 rMZ5Qx/jbvEZyzZcHjd8ZYWIXpv9P0wn2S6DnfcjaoiiAct4GImY8duMB
 cAab0C3BXEfRdNO5z7ZtYWjtQaNx3EUvTGct5PKXleU6SyiTQiJPxiEwz
 OOUIlWjA7z5+rgpP+AfnwG017/2emRpoK4wR+RifkyjAgQotv4toR3L3V
 Oty3K/1nyVlTG9bMX65MIzcS7ElIIpnLTVR3+dEVbBACP6yGTbbmWpTtx
 Vd/IiVO75XTteN+6HnNnrAugyp1z7RHILE+VkmdnF3iq1wj0EpP9RzKbV Q==;
X-CSE-ConnectionGUID: MvQO6IftQ5Cxuey5g1XiVw==
X-CSE-MsgGUID: M1L/3aUMSiC5/m6mbRvErg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3471591"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3471591"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 16:55:43 -0800
X-CSE-ConnectionGUID: 42ecQOZrQNCvlKUl/LKmMA==
X-CSE-MsgGUID: j6FdkA1eRa6VbrN8leQ9NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9315575"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2026 16:55:41 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>, stable@dpdk.org
Subject: [PATCH v2 1/4] doc: fix ice guide
Date: Sat, 14 Nov 2026 07:57:29 +0000
Message-Id: <20261114075732.183996-2-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
References: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
 <20261114075732.183996-1-sandeep.penigalapati@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct several errors in the ice guide:

- correct the DDP Technology Guide title (617015 is the generic guide,
  not a telecommunications one) and add the missing Wireless Edge DDP
  reference (637554).
- rename the Comms guide reference from "Package" to the actual
  "Technology Guide" title.
- use "proto_xtr" (the actual devarg name) instead of "proto_ext".
- drop a duplicate assignment in the raw-flow C example.
- add a missing literal-block marker for the "acl=off" example.
- remove a stray space inside the IP address in the scapy example.
- minor grammar and spacing fixes.

Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
Fixes: e89aebf3b597 ("doc: update ice user guide")
Fixes: c2e129698dd6 ("doc: fix some statements for ice vector PMD")
Fixes: 9e984bc53bc9 ("net/ice: add option to disable ACL engine in DCF")
Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
Fixes: e6ef76212b28 ("doc: add generic flow in ice guide")
Fixes: b060d3157751 ("doc: explain protocol agnostic filtering in ice guide")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/ice.rst | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index faebfdcb63..a8ec27e745 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -26,11 +26,14 @@ Linux Prerequisites
 - Please follow the matching list to download specific kernel driver, firmware and DDP package from
   `https://www.intel.com/content/www/us/en/search.html?ws=text#q=e810&t=Downloads&layout=table`.
 
-- To understand what is DDP package and how it works, please review `Intel® Ethernet Controller E810 Dynamic
-  Device Personalization (DDP) for Telecommunications Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/617015>`_.
+- To understand what is DDP package and how it works, please review `Intel® Ethernet 800 Series Dynamic
+  Device Personalization (DDP) Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/617015>`_.
 
-- To understand DDP for COMMs usage with DPDK, please review `Intel® Ethernet 800 Series Telecommunication (Comms)
-  Dynamic Device Personalization (DDP) Package <https://cdrdv2.intel.com/v1/dl/getContent/618651>`_.
+- To understand DDP for Comms usage with DPDK, please review `Intel® Ethernet 800 Series
+  DDP for Comms Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/618651>`_.
+
+- To understand DDP for Wireless Edge usage with DPDK, please review `Intel® Ethernet 800 Series
+  DDP for Wireless Edge Technology Guide <https://cdrdv2.intel.com/v1/dl/getContent/637554>`_.
 
 Windows Prerequisites
 ---------------------
@@ -191,7 +194,7 @@ Runtime Configuration
   ``field_name`` is the name of mbuf dynamic field for protocol extraction data.
   ``field_offs`` and ``field_name`` will be checked whether it is valid. If invalid,
   an error print will be returned: ``Invalid field offset or name, no match dynfield``,
-  and the proto_ext function will not be enabled.
+  and the ``proto_xtr`` function will not be enabled.
 
   Protocol is : ``vlan, ipv4, ipv6, ipv6_flow, tcp, ip_offset``.
 
@@ -386,7 +389,7 @@ are chosen based on 2 conditions.
   is set to 512, AVX512 paths will be chosen.
 
 - ``Offload features``
-  The supported HW offload features are described in the document ice.ini,
+  The supported HW offload features are described in the document ``ice.ini``.
   A value "P" means the offload feature is not supported by vector path.
   If any not supported features are used, ICE vector PMD is disabled and the
   normal paths are chosen.
@@ -625,7 +628,7 @@ Generic Flow Support
 
 The ice PMD provides support for the Generic Flow API (RTE_FLOW), enabling
 users to offload various flow classification tasks to the E810 NIC.
-The E810 NIC's  packet processing pipeline consists of the following stages:
+The E810 NIC's packet processing pipeline consists of the following stages:
 
 Switch: Supports exact match and limited wildcard matching with a large flow
 capacity.
@@ -679,7 +682,7 @@ Raw patterns consist of two key components:
 **Pattern Mask**
   An ASCII hexadecimal string of the same length as the spec
   that determines which specific fields within the packet will be extracted and used for matching.
-  The mask control field extraction without affecting the packet type identification.
+  The mask controls field extraction without affecting the packet type identification.
 
 .. note::
 
@@ -868,7 +871,7 @@ Equivalent C code using the flow API:
    };
 
    struct rte_flow_error error;
-   struct rte_flow *flow = flow = rte_flow_create(port_id, &attr, pattern, actions, &error);
+   struct rte_flow *flow = rte_flow_create(port_id, &attr, pattern, actions, &error);
 
 To use masked bits (IPv4 source/destination addresses) to distribute such packets via RSS:
 
@@ -941,6 +944,7 @@ Additional Options
   By default, all flow engines are enabled. But if user does not need the
   ACL engine related functions, user can set ``devargs`` parameter
   ``acl=off`` to disable the ACL engine and shorten the startup time.
+  For example::
 
     -a 18:01.0,cap=dcf,acl=off
 
@@ -971,8 +975,8 @@ Additional Options
 
 #. Send the packet, and it should be displayed on tcpdump::
 
-      sendp(Ether(src='3c:fd:fe:aa:bb:78', dst='00:00:00:01:02:03')/IP(src=' \
-      192.168.0.2', dst="192.168.0.3")/TCP(flags='S')/Raw(load='XXXXXXXXXX'), \
+      sendp(Ether(src='3c:fd:fe:aa:bb:78', dst='00:00:00:01:02:03')/ \
+      IP(src='192.168.0.2', dst='192.168.0.3')/TCP(flags='S')/Raw(load='XXXXXXXXXX'), \
       iface="enp24s0f0", count=10)
 
 Per-Queue Tx Rate Limiting
-- 
2.34.1

