Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE364D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26486427CC;
	Wed, 14 Jan 2026 23:56:17 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 129D040EE3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:15 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so1820875e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431375;
 x=1769036175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APOune2Pk+qtoEGRZoFLE44PCt+x/rtPb3zyJeW4gW8=;
 b=x3vQdBNmXNVXjfSzDo9cziNttTa2nwGWo7vRsUFXb81t2nfIKpjGWKyXEev0xhU+A5
 5QEiy/9kJD88/zkUiay24a7FoowE4RxDAvYTX6y79w71fDvUvsOHwf1J75qf9NGxkDWc
 /ON9UKOQt1e6vIgkUsC70hfWnJdhzAKVRRMMxB3M4v7PqUwj75FqTP3kJrVnoAYkiiqg
 g38B1u/nDvJ2NcakIKSB3s+I6kpwMeF72xNCH5IK4y7tN5Ma1c/Wam7J0vPvdjhyU4MU
 9PdVwmK/U4V13v0YfWIsuQiYZuzelLPnhQFgVCXQpmSY0kKEcxmfvDtvKoex+zXiHyxD
 zKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431375; x=1769036175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APOune2Pk+qtoEGRZoFLE44PCt+x/rtPb3zyJeW4gW8=;
 b=I6LBn279iEcBAbRehdqE08YKsmfSt7in2S4wWhaSbLIwV3RgzjpmdelLedja8k9g+g
 VB5Ypa0TOGDKul+FgzDv9sr287j4MVrVOxaSRRPVuGJL9098jEJ67mLrS4zNQXbOXEPz
 YV5+wk92IDolzlT12yeXaGvXSvSS3PxUcrRRjndrP8Nec7qXLeC9BHAJqqbx22xmBLDh
 wegGMnKKxm0Vyuj6RRV/8+lWs/sJicPCHrJB7MIT6Da9u+Yvm9ggEnlaC1RUovHPVmL0
 2fvk2Uo6/5Ll3pB9WMxHx/6S/2vPKMQE35F0kj4J/tCFRl7sTPpJutndeMfMxFfNKfkG
 7eAQ==
X-Gm-Message-State: AOJu0YzBvQDpPLfnz0CciPo/EKLPepnzgU100PXC9qBFL3X5EMt5GEyM
 pyAIz2a3zHeReHq/ZSeKWowHhXi734FGZyEpUngiF/u3lCxl+73rbGYxeLFnSa/QRG+eV6y2dBI
 k6iPI8Ek=
X-Gm-Gg: AY/fxX5PaZP95rZl5lBnPxmeW974EnzMoUMvR0xqxWYxC80gcTfAkqLTy75PD85/p/O
 jAEqjmIlMgwRvzqxKQdHZPjFLReo/MrTRHP4ILwrXdGaCHMbOE1TRTRIb3BI0tMy1L7sP4gQV4F
 giZzNPwwGhewfYNVMhU/iuf4YBT848CNboKrNYNgM1pU/0vtXEm0Px71H6txnuqBLNNAmqvNWJQ
 msxzJ5afeJLcmdjeb13Qx88/TOT8CHs3f3mggCjBAzjWKYn03YVz2lSGhulS4nD5aYkWHs4CjyH
 YwWnvd2Z1GVCkaiWN2/TEeLWy4gLVL2e4zdisahmSOKpnXTilakmYJpniUwjTZ2S5me2XjEdFVH
 ZZk93RIwn/NXJQldy/627e0K1utoJoyA02VXtKghQ/QSnMMcrTrf3QNRePWqWXBUaU8M8GKXRc2
 yj9aQzgXxlTsZ/53cCIW7+wSSMomyyquoeYt2JV5lCsxs3iiD6uA==
X-Received: by 2002:a05:600c:3acb:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47ee3353e2emr59692475e9.21.1768431374593; 
 Wed, 14 Jan 2026 14:56:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/11] doc: improve stable releases documentation
Date: Wed, 14 Jan 2026 14:54:13 -0800
Message-ID: <20260114225555.127448-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Rewrite the stable releases and LTS documentation for clarity
- Converting passive voice to active voice
- Restructuring content with bullet points for scannability
- Simplifying verbose explanations
- Removing redundant phrasing
- Making backport criteria more concise

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/stable.rst | 147 ++++++++++++-----------------
 1 file changed, 60 insertions(+), 87 deletions(-)

diff --git a/doc/guides/contributing/stable.rst b/doc/guides/contributing/stable.rst
index 808e7fa779..6065163e75 100644
--- a/doc/guides/contributing/stable.rst
+++ b/doc/guides/contributing/stable.rst
@@ -6,84 +6,69 @@
 DPDK Stable Releases and Long Term Support
 ==========================================
 
-This section sets out the guidelines for the DPDK Stable Releases and the DPDK
-Long Term Support releases (LTS).
-
+This section outlines the guidelines for DPDK Stable Releases and Long Term Support (LTS) releases.
 
 Introduction
 ------------
 
-The purpose of the DPDK Stable Releases is to maintain releases of DPDK with
-backported fixes over an extended period of time. This provides downstream
-consumers of DPDK with a stable target on which to base applications or
-packages.
-
-The primary characteristics of stable releases is that they attempt to
-fix issues and not introduce any new regressions while keeping backwards
-compatibility with the initial release of the stable version.
+The purpose of DPDK Stable Releases is to maintain DPDK versions with backported
+fixes over an extended period. This allows downstream users to base applications
+or packages on a stable, well-maintained version of DPDK.
 
-The Long Term Support release (LTS) is a designation applied to a Stable
-Release to indicate longer term support.
+The primary goal of stable releases is to fix issues without introducing regressions,
+while preserving backward compatibility with the original version.
 
+LTS (Long Term Support) is a designation given to specific stable releases to indicate
+extended support duration.
 
 Stable Releases
 ---------------
 
-Any release of DPDK can be designated as a Stable Release if a
-maintainer volunteers to maintain it and there is a commitment from major
-contributors to validate it before releases.
-If a version is to be a "Stable Release", it should be designated as such
-within one month of that version being initially released.
+Any DPDK release may become a Stable Release if a maintainer volunteers to support it
+and major contributors commit to validating it before each release.
+This designation should be made within one month of the version's initial release.
 
-A Stable Release is used to backport fixes from an ``N`` release back to an
+Stable Releases are typically used to backport fixes from an ``N`` release to an
 ``N-1`` release, for example, from 16.11 to 16.07.
 
-The duration of a stable is one complete release cycle (4 months). It can be
-longer, up to 1 year, if a maintainer continues to support the stable branch,
-or if users supply backported fixes, however the explicit commitment should be
-for one release cycle.
-
-The release cadence is determined by the maintainer based on the number of
-bugfixes and the criticality of the bugs. Releases should be coordinated with
-the validation engineers to ensure that a tagged release has been tested.
-
-
-LTS Release
------------
+* The standard support duration is one full release cycle (4 months).
+* This may extend up to one year if the maintainer continues support or if users provide backported fixes.
+* The maintainer determines the release cadence based on the volume and criticality of fixes.
+* Coordinate releases with validation engineers to ensure proper testing before tagging.
 
-A stable release can be designated as an LTS release based on community
-agreement and a commitment from a maintainer. The current policy is that each
-year's November (X.11) release will be maintained as an LTS for 3 years,
-however that is dependent on continued community support for validation.
+LTS Releases
+------------
 
-After the X.11 release, an LTS branch will be created for it at
-https://git.dpdk.org/dpdk-stable where bugfixes will be backported to.
+A Stable Release can be promoted to an LTS release through community agreement
+and a maintainer's commitment.
 
-A LTS release may align with the declaration of a new major ABI version,
-please read the :doc:`abi_policy` for more information.
+* The current policy designates each November release (X.11) as an LTS and maintains it for 3 years,
+  contingent on community validation support.
+* After release, an LTS branch is created at https://git.dpdk.org/dpdk-stable
+  where bugfixes are backported.
+* An LTS release may align with the declaration of a new major ABI version.
+  See the :doc:`abi_policy` for more information.
 
-It is anticipated that there will be at least 3 releases per year of the LTS
-or approximately 1 every 4 months. This is done to align with the DPDK main
-branch releases so that fixes have already gone through validation as part of
-the DPDK main branch release validation. However, the cadence can be shorter or
-longer depending on the number and criticality of the backported
-fixes. Releases should be coordinated with the validation engineers to ensure
-that a tagged release has been tested.
+Release Cadence:
 
-For a list of the currently maintained stable/LTS branches please see
-the latest `stable roadmap <https://core.dpdk.org/roadmap/#stable>`_.
+* At least three LTS updates per year (roughly one every four months).
+* Aligned with main DPDK releases to leverage shared validation.
+* Frequency may vary depending on the urgency and volume of fixes.
+* Coordinate validation with test engineers.
 
-At the end of the 3 years, a final X.11.N release will be made and at that
-point the LTS branch will no longer be maintained with no further releases.
+For a list of the currently maintained stable/LTS branches, see
+the `stable roadmap <https://core.dpdk.org/roadmap/#stable>`_.
 
+At the end of the 3-year period, a final X.11.N release is made,
+after which the LTS branch is no longer maintained.
 
-What changes should be backported
+What Changes Should Be Backported
 ---------------------------------
 
-Backporting should be limited to bug fixes. All patches accepted on the main
-branch with a Fixes: tag should be backported to the relevant stable/LTS
-branches, unless the submitter indicates otherwise. If there are exceptions,
-they will be discussed on the mailing lists.
+Limit backports to bug fixes.
+
+All patches accepted on the main branch with a ``Fixes:`` tag should be backported
+to the relevant stable/LTS branches, unless the submitter indicates otherwise.
 
 Fixes suitable for backport should have a ``Cc: stable@dpdk.org`` tag in the
 commit message body as follows::
@@ -97,49 +82,37 @@ commit message body as follows::
 
      Signed-off-by: Alex Smith <alex.smith@example.com>
 
-
 Fixes not suitable for backport should not include the ``Cc: stable@dpdk.org`` tag.
 
-To support the goal of stability and not introducing regressions,
-new code being introduced is limited to bug fixes.
 New features should not be backported to stable releases.
-
-In some limited cases, it may be acceptable to backport a new feature
-to a stable release. Some of the factors which impact the decision by
-stable maintainers are as follows:
-
-* Does the feature break API/ABI?
-* Does the feature break backwards compatibility?
-* Is it for the latest LTS release (to avoid LTS upgrade issues)?
-* Is there a commitment from the proposer or affiliation to validate the feature
-  and check for regressions in related functionality?
-* Is there a track record of the proposer or affiliation validating stable releases?
-* Is it obvious that the feature will not impact existing functionality?
-* How intrusive is the code change?
-* What is the scope of the code change?
-* Does it impact common components or vendor specific?
-* Is there a justifiable use case (a clear user need)?
-* Is there a community consensus about the backport?
-
-Performance improvements are generally not considered to be fixes,
-but may be considered in some cases where:
+In limited cases, a new feature may be acceptable if:
+
+* It does not break API or ABI.
+* It preserves backward compatibility.
+* It targets the latest LTS release (to help with upgrade paths).
+* The proposer commits to testing the feature and monitoring regressions.
+* The proposer or their organization has a track record of validating stable releases.
+* It clearly does not impact existing functionality.
+* The change is minimally invasive and scoped.
+* It affects vendor-specific components rather than common ones.
+* There is a justifiable use case (a clear user need).
+* There is community consensus about the backport.
+
+Performance improvements are generally not considered fixes,
+but may be considered in cases where:
 
 * It is fixing a performance regression that occurred previously.
 * An existing feature in LTS is not usable as intended without it.
 
 APIs marked as ``experimental`` are not considered part of the ABI version
-and can be changed without prior notice. This is necessary for the API to be
-improved and stabilized and become part of the ABI version in the future.
-
-However, in LTS releases ``experimental`` API should not be changed as there
-will not be a future ABI version on the branch and compatibility with previous
-release of an LTS version is of the highest importance.
+and can be changed without prior notice in mainline development.
+However, in LTS releases, ``experimental`` APIs should not be changed,
+as compatibility with previous releases of an LTS version is paramount.
 
 The Stable Mailing List
 -----------------------
 
-The Stable and LTS release are coordinated on the stable@dpdk.org mailing
-list.
+Stable and LTS releases are coordinated on the stable@dpdk.org mailing list.
 
 All fix patches to the main branch that are candidates for backporting
 should also be CCed to the `stable@dpdk.org <https://mails.dpdk.org/listinfo/stable>`_
@@ -149,7 +122,7 @@ mailing list.
 Releasing
 ---------
 
-A Stable Release will be released by:
+A Stable Release is made by:
 
 * Tagging the release with YY.MM.n (year, month, number).
 * Uploading a tarball of the release to dpdk.org.
-- 
2.51.0

