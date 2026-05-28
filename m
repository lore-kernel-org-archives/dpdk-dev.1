Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6CCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC6C74067A;
	Thu, 28 May 2026 23:38:29 +0200 (CEST)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45]) by mails.dpdk.org (Postfix) with ESMTP id EB5C54064F
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:26 +0200 (CEST)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-65dead17c24so12481891d50.2
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004306;
 x=1780609106; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmzGF47WDx09uAvSD3CU57xcgvijExI0pbsb6RA3gTQ=;
 b=IYxxIDvFF8NFDn9EfyTsw/fk7PK9AZOFjxSkB7yW85mHRXks/pV8weuaisBnmM3al0
 Pr8NUynwEti/Jg/d9tiP61sludw0SJkXB4mX8oxmewgUBcN6Lx+W/AZPqFMql9/8Oh/f
 +mp4s5SLPfhSTp201lxbrOqQhDei9WSCwqL/psUgWf4xBuAp69y6tc5PvzZNwwEaKP9p
 onelIVMrWeskYuFmW82ZY78WHazqCSaGRdfyUz7DJqvHkKOvijYzQKDUfqkLZ2wmRC2m
 GXUFo537TvRUOA7bStsZ4lNM3Q0Y3yFyi9AVEG23n0Z4ofObrDdEScpaA4CumWxmC0TV
 6LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004306; x=1780609106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rmzGF47WDx09uAvSD3CU57xcgvijExI0pbsb6RA3gTQ=;
 b=B/iOvlpdSHqvOrRyut2mYKvfoAn+zV7TtjWDhHODustyCWnNAhASW3lz/afZrHajQg
 G3FKau8hytHNIIQWAZOHaBKYi6/JSdl2twGr34stAuFg0JafTKJVxRhFIoIjAPUejmWU
 Jc+sBJij1H2Mu9nfKFOvPXFpMswfy8qaIiUgd9tQCxPP7MhCTXw+gTPs92heEZ1a6Rcp
 Q9yYXuixI31okZA62vnl+U1b+HiheFldoHX/iMXqBr7BX8USRyAf27J1hKjcXzpTTrbf
 caTOdZaNDDq0HAiIaYKtWp+E9n4SMT7a7k9JU2QZ0/2f/vsjeForZiOTpHqE2g3ci5Lr
 ipog==
X-Gm-Message-State: AOJu0YyPdklkEkhTFnLV3eWSoBuSzVgKC8u+C+9r0GiFMjZMpwNERyRs
 khbxG7FKUTmHZwL58gINgz/GvfWi64/Aqlz+d12mG8obYKBgwUA+tA1FobHRIkWe9Ctc029gn+K
 Hfs8a
X-Gm-Gg: Acq92OEy2jdea8QJXqyw6ArbsonwIEMy7obWS79m0xTllO+8LXlJfJ+57iWYueKFldj
 puohd1gR8z2ij51IHTSVIeYGVWjK0uJlMIcCpVTQGvUOhAYGpLwoRXSKJIAn1Ety5OhtbeP/hAD
 Vsxb66PPAOAXT+JpLo5iEx/cTZl5T+7rshkHXSrW3j96Si1aJWe7rjMPwVM2GkcF578/ppg9iLE
 shebMo9XMKvXXyJLkW8LEkvMKou+Dk8Au9SWgaqI8b1oTRTrRSei/9qZEWp1fRXMjhaLuhwDEUi
 mG2a7wisEg5hgeKYvSuBjhAGrFbQkvU6ZPUJcOXPtsV6lE7B9FoTB6BQLvNSgZazXMKBSAqYUnU
 y7Xyrg/VEXgUMsQR8P2KP6luq2ZkHr6oqrIjOK26ruili5KBn8rA3hsHJRpllrXu3XcffQnUrFJ
 fy9a5yYAmrwYCo8eoWYgR0tqye2OLOghWIttMsiss38h0+Q64wVJNgayw/v7a5J4skzm6x6ZWJ
X-Received: by 2002:a05:690e:12cf:b0:65e:4272:2eb8 with SMTP id
 956f58d0204a3-6604e7212acmr556112d50.65.1780004306183; 
 Thu, 28 May 2026 14:38:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 6/8] doc: announce legacy flow director deprecation
Date: Thu, 28 May 2026 14:37:18 -0700
Message-ID: <20260528213816.562910-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
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

Add the formal deprecation notice for the legacy flow director API
and the matching 26.07 release note.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst   |  7 +++++++
 doc/guides/rel_notes/release_26_07.rst | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index d152e76fdc..5e2949d153 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -131,6 +131,13 @@ Deprecation Notices
   The legacy actions should be removed
   once ``MODIFY_FIELD`` alternative is implemented in drivers.
 
+* ethdev: Legacy flow director API will be removed in DPDK 26.11.
+  This affects: flow director data structures in ``rte_eth_ctrl.h``
+  (``rte_eth_fdir_*`` and ``rte_fdir_*`` types and the associated
+  ``RTE_ETH_FDIR_*`` / ``RTE_FDIR_*`` macros) and the driver-facing
+  definitions in ``ethdev_driver.h`` (``struct rte_eth_fdir_conf``,
+  ``enum rte_eth_fdir_pballoc_type``, ``enum rte_fdir_status_mode``).
+
 * cryptodev: Support for OpenSSL versions earlier than 3.0 is deprecated
   and will be removed. OpenSSL 1.1.1 reached end-of-life in September 2023.
   The minimum supported OpenSSL version will be 3.0,
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b4f8401e2..06689cdcca 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -100,6 +100,18 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* Removed legacy flow director artifacts that depended on deprecated API.
+  Users should use ``rte_flow`` API and testpmd ``flow``
+  command instead.
+
+  * app/testpmd: ``show port fdir``, ``clear port fdir``,
+    ``flow_director_filter``, ``port config ... pctype mapping ...``,
+    and ``port config ... hash_inset|fdir_inset|fdir_flx_inset ...``.
+
+  * net/i40e, net/ixgbe: the experimental
+    ``rte_pmd_{i40e,ixgbe}_get_fdir_info()`` and
+    ``rte_pmd_{i40e,ixgbe}_get_fdir_stats()`` functions.
+
 
 API Changes
 -----------
@@ -116,6 +128,8 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* Deprecated the legacy flow director API; removal scheduled for
+  DPDK 26.11. Use the ``rte_flow`` API instead.
 
 ABI Changes
 -----------
-- 
2.53.0

