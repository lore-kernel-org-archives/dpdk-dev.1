Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED1D6CFAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 01:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 768F9402AF;
	Fri, 23 Jan 2026 02:01:24 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 337834028D
 for <dev@dpdk.org>; Fri, 23 Jan 2026 02:01:23 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so1306535f8f.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769130083;
 x=1769734883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6UiWaTdDsU84GALOxtEAo7d1wpXQPgeXA62amnYDgg=;
 b=llm14OD5saPfUN9eUpBxqf9X1UfvLCwbt/aG2QcpUJE+nWXsNXU8T4QmmuXAdrCFKN
 3/fbEEmxzNYpbeWeDyM89JyrvEEusZ4jmxR7S2QXYH4tq0iK/w0cYUf7J0l55uhdAagO
 T4/rHEP8IzthuTwXlDApYLmLbs2ggOUB5aNfTfd4jxX3M31IsNRhdf3OZDxZ9gySqKFS
 /p0aY73bSumzA2yqm1qBEpiooglKEXSGJ2JN1ieiMdJbwxcSylDiCyIGJPjPVsre/xPN
 iDeMUth3Rdz80QsPAWuRZvoR920BOed3HCNdb4m0mvmDx1qlLQTFJ24fuPkumrJlGwox
 JyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769130083; x=1769734883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u6UiWaTdDsU84GALOxtEAo7d1wpXQPgeXA62amnYDgg=;
 b=p3k0dIqkTF3y7zmA4SXEZlv7G76OF9AHGyYK5ipNSKtt+ygTSjXJN/jP8Gw+UFbwic
 ylhXGzPLMXluGtMXr9I7ZOLKmh5AKgQo4StnanFGiMulmW54BPPieCons/dcT5g3aomF
 2jIvm13+HnBHOJJ1WcevgMe4rdcVfnvcr08zPS/fU0jAsRG5uwU5Ry0OlxjXqYa6VgJq
 uQ/n8mkmH1lzjZWgSXpHKSFKmwbJXEPbHPECXQFeMchUtChGpYqvugw7CcdnXhdBSlX4
 UHCH9giKuIzDAOZeFCIkd0Bnb2MUg+hYm84qJZ2RqCoHsRyBckGifIl6WZx9kDHaIrX/
 FUXw==
X-Gm-Message-State: AOJu0YxC5GrJI0cD1TLQIM1Jjac17NI/cNR3TaF+WWsuLmqhburXF+Q3
 9unkkvPToLnui2O58sRcbPRtaoIktyciGNKL2Rngiu90eqWVOaAooOrxBuThdACZk8E=
X-Gm-Gg: AZuq6aIai02tTHqFYQcG83q+zg8KsluMDYAeLTPJxbJJ/CtHWAuHQrL4X2UloTaCeLB
 +5Ub5n2Lg+rCSEJRigYuiqXqSJAqNJXFbAuF8Z6ptFGeMVfxxktCIk5+vMvoIAIqlZoG8df3KHZ
 Djot+70zp7ZsID2TiP+ls2JqBx9p+51oiMkKnpN65a19BjyO3Q4gCQJFAOsl8sHX3HRNd9Vtplj
 EyCBI+IL0HA4l9iMYFJk9LzFQVl9lSz8FoZYaib3UBZeVX0j38NmZTb1Gzwqc5qmnjwEUEhHjyW
 RhI+V8V9/2Dla0pvs4dSNkBe2PT4pozhThlJ+cWxVULThk+wDtzzrGFXL7LsLJ8l+TcUqrSSaO1
 yGqb/DXfcKz3ovlJ7Mq1Bctg6v3TYmqq/wuNRI6UapFc4f12B3t+Bdpd1tjQ7jKziyWHyck2/Ck
 FBFHokCR4RN7l/nm1B25UbtLlSsmMkpmkFKp8JOVezooH44/o2/0Dl
X-Received: by 2002:a05:6000:2dc3:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-435b161bf47mr2359433f8f.60.1769130082599; 
 Thu, 22 Jan 2026 17:01:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c30293sm2709029f8f.19.2026.01.22.17.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 17:01:21 -0800 (PST)
Date: Thu, 22 Jan 2026 17:01:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/8] net/nfb: rework to real multiport
Message-ID: <20260122170117.1ff34114@phoenix.local>
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 22 Jan 2026 08:27:11 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---
> v4:
> * Cleaned usage of sprintf
> * Updated commit message for doc cleanup


Second AI opinion:
=== Patch Review: bundle-1675-nfb-multiport.mbox (via Grok) ===
### Review of DPDK Patch Series 'bundle-1675-nfb-multiport.mbox'

Below is a detailed review of the patch series against the DPDK coding standards and contribution guidelines as outlined in `AGENTS.md`. The feedback is organized by severity level: **Error**, **Warning**, and **Info**.

---

### **Errors (Must Fix)**

1. **Commit Message Body Missing for All Patches (All 8 Patches)**
   - **Issue**: The commit messages for all patches lack a detailed body describing the issue being fixed or the feature being added. According to the guidelines, the commit body must provide context for reviewers, describe the changes, and should not start with "It". Currently, the body only contains the `Signed-off-by` line after a brief one-liner in some cases.
   - **Location**: All patches (1/8 to 8/8).
   - **Action**: Add a detailed commit message body for each patch explaining the purpose, context, and impact of the changes. Ensure the body is wrapped at 75 characters.

2. **Missing Release Notes for Significant Driver Changes (Patches 2/8, 3/8, 4/8, 5/8)**
   - **Issue**: Patches introducing significant driver changes (multi-port support, VDEV support, port argument, MAC initialization per device) do not update the release notes adequately except for patch 8/8. The guidelines require release notes for API changes, new drivers, or significant subsystem updates to be updated in the current release notes file.
   - **Location**: Patches 2/8, 3/8, 4/8, 5/8.
   - **Action**: Ensure that significant changes are documented in the release notes file for the current release. Patch 8/8 updates `release_26_03.rst`, which is good, but earlier patches should also reference or contribute to this update if they are part of the same series.

3. **Missing Tests for New Features (Patches 2/8, 3/8, 4/8, 7/8)**
   - **Issue**: New features such as multi-port support, VDEV probing, port selection argument, and firmware version reporting do not mention accompanying tests in the `app/test` directory or hooks in `app/testpmd`. The guidelines mandate that new APIs and significant features must have corresponding tests and `testpmd` hooks.
   - **Location**: Patches 2/8, 3/8, 4/8, 7/8.
   - **Action**: Add unit tests in the `app/test` directory using the `TEST_ASSERT` macros and `unit_test_suite_runner` infrastructure. Ensure `testpmd` hooks are implemented for new features like port selection and firmware version reporting.

---

### **Warnings (Should Fix)**

1. **Documentation Gaps and Mismatches (Patches 2/8, 3/8, 4/8, 7/8)**
   - **Issue**: While patch 8/8 updates the documentation, earlier patches introducing new features (multi-port, VDEV, port argument, firmware version) do not update documentation atomically. The guidelines require that code and documentation updates be in the same patch. Additionally, ensure that PMD features match the `doc/guides/nics/features/` matrix.
   - **Location**: Patches 2/8, 3/8, 4/8, 7/8.
   - **Action**: Move relevant documentation updates into the respective patches introducing the features. Verify that `doc/guides/nics/features/nfb.ini` reflects all new features (e.g., multi-port support, VDEV) as introduced. Ensure device operations are documented per `features.rst` mappings.

2. **New APIs Not Marked as `__rte_experimental` (Patches 2/8, 3/8, 4/8, 7/8)**
   - **Issue**: New functions such as `nfb_eth_common_probe`, `nfb_eth_common_remove`, `nfb_eth_fw_version_get`, and others introduced in the patches are not marked as `__rte_experimental` in header files. The guidelines require new APIs to be marked as experimental.
   - **Location**: `drivers/net/nfb/nfb.h` and related patches (2/8, 3/8, 4/8, 7/8).
   - **Action**: Mark new public APIs as `__rte_experimental` in header files, ensuring the tag is alone on the line preceding the return type.

3. **Inappropriate Use of `rte_calloc` and `rte_zmalloc` (All Patches)**
   - **Issue**: The patches use `rte_calloc` and `rte_zmalloc` for allocations that do not necessarily require hugepage memory (e.g., `priv->queue_map_rx` in patch 1/8, `internals` in patch 2/8). The guidelines state that `rte_malloc` should only be used for DMA-accessible memory or shared memory between processes.
   - **Location**: Multiple locations across patches (e.g., `drivers/net/nfb/nfb_ethdev.c` in patch 1/8, line 579; patch 2/8, line 542).
   - **Action**: Replace `rte_calloc` and `rte_zmalloc` with standard `calloc` or `malloc` for control path allocations unless hugepage memory is explicitly required for DMA or multi-process sharing.

4. **Driver Global Variables Without Unique Prefixes (All Patches)**
   - **Issue**: Global variables and structures (e.g., `nfb_eth_dev_list` in patch 2/8) do not use a unique driver-specific prefix (e.g., `nfb_`). The guidelines require unique prefixes for global symbols to avoid clashes during static linking.
   - **Location**: `drivers/net/nfb/nfb_ethdev.c` (patch 2/8, line 29).
   - **Action**: Add a driver-specific prefix (e.g., `nfb_`) to global variables and structures to prevent namespace collisions.

5. **Missing `Cc: stable@dpdk.org` for Potential Backports (Patches 1/8, 6/8)**
   - **Issue**: Patches that could be candidates for stable backports (e.g., queue mapping preparation in 1/8, PCI ID updates in 6/8) do not include `Cc: stable@dpdk.org` as required by the guidelines.
   - **Location**: Commit messages of patches 1/8 and 6/8.
   - **Action**: Add `Cc: stable@dpdk.org` to commit messages for patches that fix issues or add compatibility and are suitable for backporting.

6. **Use of `snprintf` Return Value Without Proper Check (Patches 2/8, 3/8, 4/8)**
   - **Issue**: The return value of `snprintf` is checked for overflow in some cases but not consistently handled for errors (e.g., negative return values). The guidelines encourage explicit error handling.
   - **Location**: `drivers/net/nfb/nfb_ethdev.c` (patch 2/8, line 781); `drivers/net/nfb/nfb_vdev.c` (patch 3/8, line 67).
   - **Action**: Ensure `snprintf` return values are checked for both overflow and error conditions (< 0).

---

### **Info (Consider)**

1. **Minor Style Preferences for Commit Messages (All Patches)**
   - **Issue**: While the subject lines are generally within 60 characters and follow the correct prefix (`net/nfb:`), some could be more descriptive (e.g., patch 6/8: "add compatible cards to driver PCI ID table" could specify key cards like "add FB2CGHH and COMBO-400G1 to PCI ID table").
   - **Location**: Commit messages of all patches.
   - **Action**: Consider refining subject lines for clarity and specificity while maintaining the length limit and imperative mood.

2. **Optimization Suggestion for Queue Mapping Initialization (Patch 1/8)**
   - **Issue**: The initialization of `queue_map_rx` and `queue_map_tx` uses a simple 1:1 mapping loop. This could potentially be optimized using `memcpy` if the mapping is always linear in the default case.
   - **Location**: `drivers/net/nfb/nfb_ethdev.c` (patch 1/8, lines 587-590).
   - **Action**: Consider using `memcpy` or a similar approach for initializing large arrays if performance is a concern in this path (though this is a control path, so impact may be negligible).

3. **Alternative Approach for Port Selection Logic (Patch 4/8)**
   - **Issue**: The port selection logic using a bitmask (`port_mask`) is functional but could potentially be simplified by using a dynamic array or list for selected ports if the number of ports grows significantly in future hardware.
   - **Location**: `drivers/net/nfb/nfb_ethdev.c` (patch 4/8, lines 694-718).
   - **Action**: Consider if a more flexible data structure (e.g., a dynamic array) would be better for future scalability, though the current bitmask approach is acceptable for the current scope.

4. **Code Duplication in MAC Initialization (Patch 5/8)**
   - **Issue**: The `nfb_nc_rxmac_init` and `nfb_nc_txmac_init` functions have similar logic for iterating over interfaces and initializing MACs. This could be refactored into a common helper function to reduce duplication.
   - **Location**: `drivers/net/nfb/nfb_ethdev.c` (patch 5/8, lines 54-75 and 79-100).
   - **Action**: Consider refactoring the common logic into a helper function to improve maintainability.

---

### **Summary of Compliance with Guidelines**

- **Commit Message Format**: Non-compliant due to missing detailed bodies (Error). Subject lines are mostly compliant with minor improvements suggested (Info).
- **License/Copyright Compliance**: Compliant. All new files (e.g., `nfb_vdev.c` in patch 3/8) include proper SPDX identifiers and copyright notices.
- **C Coding Style Issues**: Mostly compliant with minor issues around `rte_malloc` usage and global variable naming (Warnings).
- **API and Documentation Requirements**: Non-compliant due to missing `__rte_experimental` tags, incomplete documentation updates in individual patches, and missing tests (Errors and Warnings).
- **Other Guideline Violations**: Missing release notes updates in relevant patches and potential backport tags (Errors and Warnings).

---

### **Action Plan for Contributors**

1. **Immediate Fixes (Errors)**:
   - Add detailed commit message bodies to all patches.
   - Ensure release notes are updated atomically with feature patches or reference the final documentation patch (8/8) explicitly.
   - Add tests and `testpmd` hooks for new features.

2. **High-Priority Improvements (Warnings)**:
   - Update documentation in the same patch as code changes.
   - Mark new APIs as `__rte_experimental`.
   - Replace inappropriate `rte_malloc`/`rte_calloc` usage with standard `malloc`/`calloc`.
   - Add driver-specific prefixes to global variables.
   - Add `Cc: stable@dpdk.org` where applicable.

3. **Optional Enhancements (Info)**:
   - Refine commit message subject lines for clarity.
   - Consider optimization and refactoring suggestions for maintainability and scalability.

Please address the **Errors** and **Warnings** before resubmission to ensure compliance with DPDK guidelines. If you have any questions or need further clarification on specific issues, feel free to ask.
