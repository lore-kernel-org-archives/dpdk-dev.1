Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466CAC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3E8242EB3;
	Fri, 16 Jan 2026 21:17:57 +0100 (CET)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66]) by mails.dpdk.org (Postfix) with ESMTP id 6BAA142E92
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:54 +0100 (CET)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8765b7f4c0so406066766b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594674;
 x=1769199474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDHwFEqKAUwO0LexrGRol35E2FgPQa7vxmmkv3fiikA=;
 b=DcngDuasTxF1vZQ++oCfcZdxI6g1b+SKAZpWrxOqkWLwUwop845dKXYZcEqMVr54Ya
 jUerPAU7CSG3wsGUY8Pxm0ClovoEeOuoGvIC95NJn6+EU6DEQXkhnjBcomwqkZ2rZj0D
 IbYjY3EA9t7z9Knsf3JbVtJT3VsedHbAyA2m8I4Y2i1g4K4Vez6vKy/3pt1wmzlThaCy
 /Y1iUlWXWUSVLORA5FntKgZRmYZLTvYPiwiMJ7KQC5z/LIO/BCksik4H9euZfJeSMd9x
 QgqGjUoqoT0SA1RW/VlUnbd4bciPebDVd4I3epurEx2BGlsfZ6gCS5WtlYRk7/QebIxu
 QC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594674; x=1769199474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dDHwFEqKAUwO0LexrGRol35E2FgPQa7vxmmkv3fiikA=;
 b=wemH8jIJ7bfri8b/YMm6sSbqjp51CB9oay1pgxouIYI4kQEQy17LPW4bdocD/ap4LG
 3HUGH2XOROmK8nxV/bQTJNf9lh7gekklh1AwxCMQw9v8KLREGWAbTIawUiORYW1PpxaX
 P0+9ws2RjRxm+CQAMeToeT1KnU1cn1aHDYOAYWf81Rxnx9WEXI7ba+nwkGlWpwjE9mQx
 E/9OWd9Z3N+cMhcoxqAxirIEvu29b+fEF6GoclBQ4iTmc4r/Lvho/+Bg5hdHyyNJD1qF
 EGnAVOuWIT30LXppSEWkgBM8XZyhNSIXIUZCvwJew/RiuzU89tBFDkCsSUv2LGQmz3d0
 kNXw==
X-Gm-Message-State: AOJu0YylrtwBY01JnGhL0lZyaOorB/WNJXyBiDWKIj5brm/P2QPx3rXM
 X8XRKzu1MGtI2yyrzl/zX4/ssq9sIj6PcKYIfa3i54Co2qoB3LRs3KDG1CG7/VEjWGFNfYFvVds
 r+2iSKD4=
X-Gm-Gg: AY/fxX5O1s2tHIEVXQrMd+GbAGys6lHXvKIbEpdeHXCb4SpHahqS7x8ZO2ZAf7JAXuJ
 Tw8EgbSV/ziSUkmlUEme808y8OJZ2W+CVwKK4QbsZtXkRaZohlZ7AAlqO67HXcs4eQNel5u/5la
 7JqcUC5/15bXBAzEvbnNzhUQSPm8S7s8vWk/Co3aTfY5OLDp7mfMotseBV7G7UZowMS8SO8W/SD
 +BbvhOe4d+fTmV2r2KYvrQjgmwfF/RkHkdRGwwW7Idu3uJ3TlubnSbgsZ9G4U4GR1emrRZrg6vB
 DorJ7J5SNXX7mW13xNCxifJqoPAbNTqGzI8v7UF/cPgq0iuAIvsmS7UcXINW5fyfXz+yXnOExRI
 k9qdOz3zneCxEiNJL4epZhI88bFTFrOFcLYLOanW7fm/siK2O2DoGnRc/W0wgSmshZJtiDVs8ia
 bCMBL2AciLL/vIT1zaglRKWLQFCyiik/1pOA0zWkMEpa1KFzhm0A==
X-Received: by 2002:a17:907:3e83:b0:b73:826a:9102 with SMTP id
 a640c23a62f3a-b8793041f7fmr391412866b.49.1768594673664; 
 Fri, 16 Jan 2026 12:17:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 06/12] doc: improve new driver guide readability
Date: Fri, 16 Jan 2026 12:14:24 -0800
Message-ID: <20260116201738.74578-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

Improve the new driver contribution guide
- Converting passive voice to active voice
- Using imperative mood for recommendations
- Removing "We recommend" and similar phrases
- Simplifying wordy constructions

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/new_driver.rst | 62 +++++++++++++-------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/doc/guides/contributing/new_driver.rst b/doc/guides/contributing/new_driver.rst
index 555e875329..23d986d941 100644
--- a/doc/guides/contributing/new_driver.rst
+++ b/doc/guides/contributing/new_driver.rst
@@ -6,10 +6,10 @@ Adding a New Driver
 ===================
 
 The DPDK project continuously grows its ecosystem by adding support for new devices.
-This document is designed to assist contributors in creating DPDK drivers,
+This document assists contributors in creating DPDK drivers,
 also known as Poll Mode Drivers (PMD).
 
-By having public support for a device, we can ensure accessibility across various
+By having public support for a device, we ensure accessibility across various
 operating systems and guarantee community maintenance in future releases.
 If a new device is similar to a device already supported by an existing driver,
 it is more efficient to update the existing driver.
@@ -20,8 +20,8 @@ Here are our best practice recommendations for creating a new driver.
 Early Engagement with the Community
 -----------------------------------
 
-When creating a new driver, we highly recommend engaging with the DPDK
-community early instead of waiting the work to mature.
+When creating a new driver, engage with the DPDK community early
+rather than waiting for the work to mature.
 
 These public discussions help align development of your driver with DPDK expectations.
 You may submit a roadmap before the release to inform the community of your plans.
@@ -29,31 +29,31 @@ Additionally, sending a Request For Comments (RFC) early in the release cycle,
 or even during the prior release, is advisable.
 
 DPDK is mainly consumed via Long Term Support (LTS) releases.
-It is common to target a new PMD to a LTS release. For this,
-it is suggested to start upstreaming at least one release before a LTS release.
+It is common to target a new PMD to an LTS release. For this,
+start upstreaming at least one release before an LTS release.
 
 
 Progressive Work
 ----------------
 
-To continually progress your work, we recommend planning
+To continually progress your work, plan
 for incremental upstreaming across multiple patch series or releases.
 
-It's important to prioritize quality of the driver over upstreaming
+Prioritize quality of the driver over upstreaming
 in a single release or single patch series.
 
 
 Finalizing
 ----------
 
-Once the driver has been upstreamed,
-the author has a responsibility to the community to maintain it.
+Once the driver is upstreamed,
+the author is responsible for maintaining it.
 
 This includes the public test report.
 Authors must send a public test report after the first upstreaming of the PMD.
 The same public test procedure may be reproduced regularly per release.
 
-After the PMD is upstreamed, the author should send a patch to update
+After the PMD is upstreamed, send a patch to update
 `the website <https://core.dpdk.org/supported/>`_
 with the name of the new PMD and supported devices via the
 `DPDK web mailing list <https://mails.dpdk.org/listinfo/web>`_.
@@ -64,7 +64,7 @@ For more information about the role of maintainers, see :doc:`patches`.
 Splitting into Patches
 ----------------------
 
-We recommend that drivers are split into patches,
+Split drivers into patches
 so that each patch represents a single feature.
 If the driver code is already developed, it may be challenging to split.
 However, there are many benefits to doing so.
@@ -73,17 +73,17 @@ Splitting patches makes it easier to understand a feature
 and clarifies the list of components/files that compose that specific feature.
 
 It also enables the ability to track
-from the source code to the feature it is enabled for,
-and helps users to understand the reasoning and intention of implementation.
+from the source code to the feature it enables,
+and helps users understand the reasoning and intention of implementation.
 This kind of tracing is regularly required for defect resolution and refactoring.
 
 Another benefit of splitting the codebase per feature is that
 it highlights unnecessary or irrelevant code,
 as any code not belonging to any specific feature becomes obvious.
 
-Git bisect is also more useful if patches are split per patch.
+Git bisect is also more useful if patches are split per feature.
 
-The split should focus on logical features rather than file-based divisions.
+Focus the split on logical features rather than file-based divisions.
 
 Each patch in the series must compile without errors
 and should maintain functionality.
@@ -92,20 +92,20 @@ Enable the build as early as possible within the series
 to facilitate continuous integration and testing.
 This approach ensures a clear and manageable development process.
 
-We suggest splitting patches following this approach:
+Split patches following this approach:
 
-* Each patch should be organized logically as a new feature.
+* Organize each patch logically as a new feature.
 * Run test tools per patch (See :ref:`tool_list`).
 * Update relevant documentation and `<driver>.ini` file with each patch.
 
-The following order in the patch series is as suggested below.
+The following order in the patch series is suggested.
 
 The first patch should have the driver's skeleton which should include:
 
 * Maintainers file update
 * Driver documentation
 * Document must have links to official product documentation web page
-* The new document should be added into the index (`index.rst`)
+* Add the new document to the index (`index.rst`)
 * Initial `<driver>.ini` file
 * Release notes announcement for the new driver
 
@@ -152,10 +152,10 @@ Time synchronization, PTP
 Performance documentation
 ================================  ================================
 
-After all features are enabled,
+After enabling all features,
 if there is remaining base code that is not upstreamed,
-they can be upstreamed at the end of the patch series.
-However, we recommend these patches are still split into logical groups.
+upstream it at the end of the patch series.
+However, still split these patches into logical groups.
 
 
 Additional Suggestions
@@ -185,12 +185,12 @@ Remember to do the following:
 Dependencies
 ------------
 
-At times, drivers may have dependencies to external software.
-For driver dependencies, same DPDK rules for dependencies applies.
-Dependencies should be publicly and freely available,
-drivers which depend on non-available components will not be accepted.
+At times, drivers may have dependencies on external software.
+For driver dependencies, the same DPDK rules for dependencies apply.
+Dependencies should be publicly and freely available;
+drivers that depend on unavailable components will not be accepted.
 If the required dependency is not yet publicly available,
-then wait to submit the driver until the dependent library is available.
+wait to submit the driver until the dependent library is available.
 
 
 .. _tool_list:
@@ -199,10 +199,10 @@ Test Tools
 ----------
 
 Build and check the driver's documentation.
-Make sure there are no warnings,
-and driver shows up in the relevant index page.
+Ensure there are no warnings
+and the driver shows up in the relevant index page.
 
-Be sure to run the following test tools per patch in a patch series:
+Run the following test tools per patch in a patch series:
 
 * `checkpatches.sh`
 * `check-git-log.sh`
-- 
2.51.0

