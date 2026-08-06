Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A290C5AC80
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E127840663;
	Thu,  6 Aug 2026 19:16:44 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 7354040658
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:44 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-902fc790cd5so14846026d6.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036604; x=1786641404; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bGi+p7PfsUoHOYvyVg7Kub02U/KsciGXJCoLdP9CYSo=;
 b=Pnr6JV20V2kdhObBmBPSfJ3VibzepSDaHyCKVZfdVIzyoX94w0mKFdrdaKbbjK+eG9
 mo2hBV3FTlyRVU8GnpV5msyoo0zQK8o91e4twXNuL+OFzSK9x3bPupczEx15bgMXuE/H
 gObccOhAxY7+1141r04acArHMqGgqKiZkeAhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036604; x=1786641404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bGi+p7PfsUoHOYvyVg7Kub02U/KsciGXJCoLdP9CYSo=;
 b=RfQU2YXT2lJGPgyH7ctdzRAoK0PP03PdSb28v9TwXCRZc42JvSu9M+lv7Axu3v3XiR
 Cxi1CZ2hqiBtzQzbN4mIsP8NOoHEZFm5JWI9M2qcZag7UuDm8mtzv1HtKaT3eXb0KQGS
 RF3O5z4+sQ8VA5yfGL19+yteCgaQJy+pwd8lysVdW5jD6ZM9W4pPDMyunPDbWYx/ME+M
 tEZcdnS6l7eIMbf+XxF8Gqs/nZjQs5wPFQUUF8CjNrOIZbZQYb4AdqtSNWzc+rCVk62l
 499oicvyhvxYTshMIrZSPH5UyayFei/WvmQeVjJ5qUa48LalLCF8yoDbJHagwGBxqxyR
 dZNw==
X-Gm-Message-State: AOJu0YyOtAtJ5u1bIs6BeQJK8CjBEDuBdp4cb7sKD+50uAwvwzTK7yET
 LgZavDwsJwn246QyVofn6vGd5g0ah4VcBZkw+alDnQaqCisbCnsMIgA+Le0HUvVrs6H6Z2OtI9W
 +qMVU5OrU5ofLL2twOWFr3dl9PhlLFNugpeekKVrkfb4JnFFYcxt+qrIrQkVfEMzfHzleAmflxa
 NiLOToMdsYqio+l6e72PLaYPnJx5o=
X-Gm-Gg: AR+sD11Ihnk/0Rhl4noq8DqDqPzvC++Y2bdltQwOcSpPWlYT4g9XzYAovggJX/HodIY
 OYKfnVI3uMG+mJqTpveJ3uSDAwciI7pF0eIA9HSXNnD+CWS+ZGOARvCJ4fwEvt636/nxPpz+4Xx
 D7yeQNMXtfDKaEw5L/TMcfABWvOgFVk2uAsUam6vdTNSOBFBuYLdECuaKg6SVwsd30RHjp5kZOY
 NYYzVrCf/V5MOKVMIAI97An+NFBmXpYiCh13vY2za6nhH1nHrHkYTMrDxiiNqTczrIFTwd+4Rvu
 pJEx4/z9svyMEb66Hr2VzQ+9TxoizZ+i/Mg3sGTlQayel7L0GX2LOj04o7SLPaPOwiz72NW8CKp
 77rS3ZmO930n9lQLv2/RmTdKHR2lr9MnBT1UTkkTUQjlkxhi6XWg0qiPTVfiwn0IVff7K59JRI9
 /bDK4Ybi0nAfbM+41x+NrEsI08jvSAJHbfshq1AWW2N6IsJpZCtIsFE5sHO4hsH43TfO39PcCNW
 X7dVn830GEGu+t9mlo3bMItLCHsfZh3Xwb6lzNe
X-Received: by 2002:a05:6214:5413:b0:8ff:6304:da9 with SMTP id
 6a1803df08f44-90881081a82mr204268096d6.6.1786036603465; 
 Thu, 06 Aug 2026 10:16:43 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:42 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 1/7] doc: improve 26.07 release notes
Date: Thu,  6 Aug 2026 13:16:30 -0400
Message-ID: <20260806171636.656181-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
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

From: Bruce Richardson <bruce.richardson@intel.com>

* The change in mempool behaviour is the change in this release with the
  largest impact, so call that out first in the release notes, so as to
  get maximum visibility for it.

* For release note component updates where only a single item is called
  out, remove the bullet point character.

* The drivers should be in alphabetical order by category in the release
  notes, so move two drivers to give correct ordering.

* The format of the API section as documented does not have headings in
  bold. This simpler format is also what is used for the 25.11 and
  previous release notes. Update text for 26.07 to match the documented
  and previously used style.

* Some minor fixes for the text.

* Comments and empty section removed.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/rel_notes/release_26_07.rst | 193 +++++--------------------
 1 file changed, 39 insertions(+), 154 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 0a7eb2ee74..3d18ba2dd0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -6,69 +6,9 @@
 DPDK Release 26.07
 ==================
 
-.. **Read this first.**
-
-   The text in the sections below explains how to update the release notes.
-
-   Use proper spelling, capitalization and punctuation in all sections.
-
-   Variable and config names should be quoted as fixed width text:
-   ``LIKE_THIS``.
-
-   Build the docs and view the output file to ensure the changes are correct::
-
-      ninja -C build doc
-      xdg-open build/doc/guides/html/rel_notes/release_26_07.html
-
-
 New Features
 ------------
 
-.. This section should contain new features added in this release.
-   Sample format:
-
-   * **Add a title in the past tense with a full stop.**
-
-     Add a short 1-2 sentence description in the past tense.
-     The description should be enough to allow someone scanning
-     the release notes to understand the new feature.
-
-     If the feature adds a lot of sub-features you can use a bullet list
-     like this:
-
-     * Added feature foo to do something.
-     * Enhanced feature bar to do something else.
-
-     Refer to the previous release notes for examples.
-
-     Suggested order in release notes items:
-     * Core libs (EAL, mempool, ring, mbuf, buses)
-     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
-       - ethdev (lib, PMDs)
-       - cryptodev (lib, PMDs)
-       - eventdev (lib, PMDs)
-       - etc
-     * Other libs
-     * Apps, Examples, Tools (if significant)
-
-     This section is a comment. Do not overwrite or remove it.
-     Also, make sure to start the actual text at the margin.
-     =======================================================
-
-* **Added option to change memory limits per page size.**
-
-  Added the EAL option ``--pagesz-mem``
-  to override the default per-page-size memory limits.
-  Each maximum can be configured with a pair ``<pagesz>:<limit>``.
-
-* **Added option to disable auto probing.**
-
-  Added EAL options affecting the initial bus probing.
-
-  * ``-A`` or ``--no-auto-probing`` disable the initial bus probing: no device is probed during
-    ``rte_eal_init`` and the application is responsible for probing each device,
-  * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
-
 * **Changed mempool cache behaviour.**
 
   * The mempool cache flush/refill algorithm was improved,
@@ -83,6 +23,20 @@ New Features
   * The size of the ``struct rte_mempool_cache`` was kept
     for API/ABI compatibility purposes.
 
+* **Added option to change memory limits per page size.**
+
+  Added the EAL option ``--pagesz-mem``
+  to override the default per-page-size memory limits.
+  Each maximum can be configured with a pair ``<pagesz>:<limit>``.
+
+* **Added option to disable device auto probing.**
+
+  Added EAL options affecting the initial bus probing to find devices.
+
+  * ``-A`` or ``--no-auto-probing`` disables the initial bus probing: no device is probed during
+    ``rte_eal_init`` and the application is responsible for probing each device.
+  * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
+
 * **Added RISC-V vector paths.**
 
   * Increased the default SIMD bitwidth to allow using the vector extension.
@@ -112,7 +66,7 @@ New Features
 
 * **Added no-IOMMU mode to UACCE bus.**
 
-  Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
+  Added no-IOMMU mode for devices that do not have or do not enable IOMMU/SVA support.
 
 * **Added unplug operation support to VMBUS bus.**
 
@@ -131,13 +85,9 @@ New Features
   to support adding and removing memory regions without resetting
   the whole guest memory map.
 
-* **Added LinkData sxe2 ethernet driver.**
-
-  Added network driver for the LinkData network adapters.
-
 * **Updated Google gve driver.**
 
-  * Added hardware timestamping support on DQO queues.
+  Added hardware timestamping support on DQO queues.
 
 * **Updated Intel iavf driver.**
 
@@ -147,18 +97,22 @@ New Features
 
 * **Updated Intel ice driver.**
 
-  * Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
-    burst size, reducing Tx latency jitter for time-sensitive traffic.
+  Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
+  burst size, reducing Tx latency jitter for time-sensitive traffic.
+
+* **Added LinkData sxe2 ethernet driver.**
+
+  Added network driver for the LinkData network adapters.
 
 * **Updated Microsoft mana driver.**
 
-  * Added device reset support to the MANA PMD,
-    doing automatic recovery from hardware service reset events,
-    and notification to upper layers of the reset lifecycle.
+  Added device reset support to the MANA PMD,
+  doing automatic recovery from hardware service reset events,
+  and notification to upper layers of the reset lifecycle.
 
 * **Updated NVIDIA mlx5 ethernet driver.**
 
-  * Added support for selective Rx in scalar SPRQ Rx path.
+  Added support for selective Rx in scalar SPRQ Rx path.
 
 * **Updated NXP dpaa2 driver.**
 
@@ -189,16 +143,12 @@ New Features
   * Added ``eof`` devarg to use link state to signal end of receive file input.
   * Added unit test suite.
 
-* **Updated Marvell cnxk crypto driver.**
-
-  * Added support for ML-KEM and ML-DSA on CN20K platform.
-
 * **Updated Wangxun ngbe driver.**
 
-  * Implemented UDP Segmentation Offload (USO) in the transmit path.
-    The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised
-    since the driver's initial integration but the data path was missing;
-    it is now functional.
+  Implemented UDP Segmentation Offload (USO) in the transmit path.
+  The ``RTE_ETH_TX_OFFLOAD_UDP_TSO`` capability was advertised
+  since the driver's initial integration but the data path was missing;
+  it is now functional.
 
 * **Updated Wangxun txgbe driver.**
 
@@ -223,6 +173,10 @@ New Features
 
   On ARM, both IPsec MB and OpenSSL are required for full functionality.
 
+* **Updated Marvell cnxk crypto driver.**
+
+  Added support for ML-KEM and ML-DSA on CN20K platform.
+
 * **Updated lcore validation in power library.**
 
   Lcore ID validation was moved into the cpufreq framework before driver dispatch.
@@ -276,15 +230,6 @@ New Features
 Removed Items
 -------------
 
-.. This section should contain removed items in this release. Sample format:
-
-   * Add a short 1-2 sentence description of the removed item
-     in the past tense.
-
-   This section is a comment. Do not overwrite or remove it.
-   Also, make sure to start the actual text at the margin.
-   =======================================================
-
 * crypto/openssl: Removed support for OpenSSL 1.x versions from the OpenSSL crypto PMD.
 
   The OpenSSL crypto PMD now requires OpenSSL 3.0 as the minimum version,
@@ -304,25 +249,9 @@ Removed Items
 API Changes
 -----------
 
-.. This section should contain API changes. Sample format:
-
-   * sample: Add a short 1-2 sentence description of the API change
-     which was announced in the previous releases and made in this release.
-     Start with a scope label like "ethdev:".
-     Use fixed width quotes for ``function_names`` or ``struct_names``.
-     Use the past tense.
-
-   This section is a comment. Do not overwrite or remove it.
-   Also, make sure to start the actual text at the margin.
-   =======================================================
+* eal: Promoted ``rte_memeq_timingsafe()`` from experimental to stable.
 
-* **eal: promoted timing-safe memory comparison from experimental to stable.**
-
-  The inline function ``rte_memeq_timingsafe()`` is no longer marked experimental.
-
-* **ethdev: promoted flow metadata API from experimental to stable.**
-
-  The following ethdev symbols are no longer marked experimental:
+* ethdev: Promoted the following flow metadata symbols from experimental to stable:
 
   - ``rte_flow_dynf_metadata_register``
   - ``rte_flow_dynf_metadata_offs``
@@ -331,16 +260,15 @@ API Changes
   - ``rte_flow_dynf_metadata_get``
   - ``rte_flow_dynf_metadata_set``
 
-* **mlx5: promoted driver event and steering management APIs from experimental to stable.**
-
-  The following mlx5 functions are no longer marked experimental:
+* mlx5: Promoted the following driver event and steering management functions
+  from experimental to stable:
 
   - ``rte_pmd_mlx5_driver_event_cb_register``
   - ``rte_pmd_mlx5_driver_event_cb_unregister``
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
-* **ip_frag: changed handling of malformed fragments.**
+* ip_frag: Changed handling of malformed fragments.
 
   - Duplicate fragments are tolerated instead of failing reassembly.
   - Overlapping fragments are rejected on arrival rather than during reassembly.
@@ -354,55 +282,12 @@ API Changes
 ABI Changes
 -----------
 
-.. This section should contain ABI changes. Sample format:
-
-   * sample: Add a short 1-2 sentence description of the ABI change
-     which was announced in the previous releases and made in this release.
-     Start with a scope label like "ethdev:".
-     Use fixed width quotes for ``function_names`` or ``struct_names``.
-     Use the past tense.
-
-   This section is a comment. Do not overwrite or remove it.
-   Also, make sure to start the actual text at the margin.
-   =======================================================
-
 * No ABI change that would break compatibility with 25.11.
 
 
-Known Issues
-------------
-
-.. This section should contain new known issues in this release. Sample format:
-
-   * **Add title in present tense with full stop.**
-
-     Add a short 1-2 sentence description of the known issue
-     in the present tense. Add information on any known workarounds.
-
-   This section is a comment. Do not overwrite or remove it.
-   Also, make sure to start the actual text at the margin.
-   =======================================================
-
-
 Tested Platforms
 ----------------
 
-.. This section should contain a list of platforms that were tested
-   with this release.
-
-   The format is:
-
-   * <vendor> platform with <vendor> <type of devices> combinations
-
-     * List of CPU
-     * List of OS
-     * List of devices
-     * Other relevant details...
-
-   This section is a comment. Do not overwrite or remove it.
-   Also, make sure to start the actual text at the margin.
-   =======================================================
-
 * Intel\ |reg| platforms with Intel\ |reg| NICs combinations
 
   * CPU
-- 
2.55.0

