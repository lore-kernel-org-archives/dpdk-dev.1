Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56181606A332
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=frpy/xxH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7390C427CF;
	Sat, 14 Nov 2026 02:44:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 91A2B40A70;
 Sat, 14 Nov 2026 02:44:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794620655; x=1826156655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P8VVYdCx50J0mmNuzBceNBVO83H3CH/GEn+nKPv5skY=;
 b=frpy/xxHFj6zX+Ids2atZKIN4DCL8A1JtJTWp1MKXGrGPfTBRiHKC7DF
 NwNrbl669wGUg7mwFW9g7i8vbydkrA3pYPAisU7hbzDJ2oa8FsS2yAJR2
 zmkc6lHvRZWeglLEZjZqzd2aCBLQJm1qTUXpHm7ghsF9/g+jYbsmQzVRD
 lY2rgGmZTo+Vu7NdZCGcmAIvqrtj3JuHUVfXPIwqVb/CC68nuX0CbUMb2
 nA7UBJXcGxx0MNniE1Kpn8HXqhvqtkCEnskE2qrj9Sava5TQ1SZ/xIJkl
 kBB1QGKQ2Q2PXNB3xC7Ja3HihKB1EmEATWx0FOnodMhKFaYjB64WpOD+S w==;
X-CSE-ConnectionGUID: M4lLVgm3QIuFOxZlTRihFg==
X-CSE-MsgGUID: 8eBl2ADXRAi0vkeOIFPKIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3325925"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3325925"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:44:14 -0800
X-CSE-ConnectionGUID: cu5LsxYgSZSSVK0PmTcAhg==
X-CSE-MsgGUID: KAct7Bh6SDmy6Ox0CDmgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10969979"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa013.fm.intel.com with ESMTP; 13 Nov 2026 17:44:12 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>, stable@dpdk.org
Subject: [PATCH v3 2/4] doc: fix i40e guide
Date: Sat, 14 Nov 2026 08:46:17 +0000
Message-Id: <20261114084619.190251-3-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114084619.190251-1-sandeep.penigalapati@intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct several errors in the i40e guide:

- use the full "Malicious Driver Detection" feature name.
- correct the queue region device argument description ("serves for"
  wording, the "off" entry formatting, and the "commits"/"cleans"/
  "restores" grammar).
- describe "set vf allmulti" as all-multicast mode instead of the
  copy-pasted promiscuous-mode description.
- minor grammar and spacing fixes.

Fixes: 04c8542f96f7 ("net/i40e: set TC strict priority mode")
Fixes: 0982ef81a665 ("doc: add DDP in i40e guide")
Fixes: 9accffad6593 ("net/i40e: add PF MDD event handler")
Fixes: 94b3c1a72507 ("net/i40e: move testpmd commands")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/i40e.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 29234dbf0f..1df006333b 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -43,7 +43,7 @@ Features of the i40e PMD are:
 - Dynamic Device Personalization (DDP)
 - Queue region configuration
 - Virtual Function Port Representors
-- Malicious Device Drive event catch and notify
+- Malicious Driver Detection event catch and notify
 - Generic flow API
 
 Linux Prerequisites
@@ -537,7 +537,7 @@ Display information about a GTP profile:
 
 Input set configuration
 ~~~~~~~~~~~~~~~~~~~~~~~
-Input set for any PCTYPE can be configured with user defined configuration,
+Input set for any PCTYPE can be configured with user defined configuration.
 For example, to use only 48bit prefix for IPv6 src address for IPv6 TCP RSS:
 
 .. code-block:: console
@@ -669,7 +669,7 @@ If a TC is set to strict priority mode, it can consume unlimited bandwidth.
 It means if APP has set the max bandwidth for that TC, it comes to no
 effect.
 It's suggested to set the strict priority mode for a TC that is latency
-sensitive but no consuming much bandwidth.
+sensitive but not consuming much bandwidth.
 
 DCB function
 ~~~~~~~~~~~~
@@ -721,7 +721,7 @@ Set flowtype mapping on a RSS queue region on a port::
 
 where:
 
-* For the flowtype(pctype) of packet,the specific index for each type has
+* For the flowtype(pctype) of packet, the specific index for each type has
   been defined in file i40e_type.h as enum i40e_filter_pctype.
 
 Set user priority mapping on a RSS queue region on a port::
@@ -734,13 +734,13 @@ Flush all queue region related configuration on a port::
 
 where:
 
-* ``on``: is just an enable function which server for other configuration,
+* ``on``: is just an enable function which serves for other configuration,
   it is for all configuration about queue region from up layer,
   at first will only keep in DPDK software stored in driver,
-  only after "flush on", it commit all configuration to HW.
+  only after "flush on", it commits all configuration to HW.
 
-* ``"off``: is just clean all configuration about queue region just now,
-  and restore all to DPDK i40e driver default config when start up.
+* ``off``: cleans all configuration about queue region just now,
+  and restores all to DPDK i40e driver default config when start up.
 
 Show all queue region related configuration info on a port::
 
@@ -765,7 +765,7 @@ set allmulticast (for VF)
 
 Set the multicast promiscuous mode for a VF from PF.
 It's supported by Intel i40e NICs now.
-In promiscuous mode packets are not dropped if they aren't for the specified MAC address::
+In all-multicast mode all multicast packets are received regardless of the multicast address filter::
 
    testpmd> set vf allmulti (port_id) (vf_id) (on|off)
 
@@ -858,7 +858,7 @@ where:
 
 * ``target``: A specific software ptype or a mask to represent a group of software ptypes.
 
-* ``mask``: A flag indicate if "target" is a specific software ptype(=0) or a ptype mask(=1).
+* ``mask``: A flag indicates if "target" is a specific software ptype(=0) or a ptype mask(=1).
 
 * ``pkt_type``: The new software ptype to replace the old ones.
 
-- 
2.34.1

