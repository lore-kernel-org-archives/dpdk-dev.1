Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CC6F9D0F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 21:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87C2040696;
	Tue, 14 Apr 2026 23:10:26 +0200 (CEST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id 4BD274065D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 23:10:23 +0200 (CEST)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-662f30d3f1fso3461466eaf.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776201022;
 x=1776805822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaDAyMFaca26iuPqjWvb8SkDPBRVWcV+c0Unpuab6c4=;
 b=dea4a9Ve6hcvyGPB2tgUghM9PWdUvpvnyBjZJs2mNmj9RylfLAb2HZppiAF2a0t+Oa
 I841D2c0cNZpUMvM8CwiWCKTEAcVpk47o/T3KoQqYsES4WeukaTrAyb01uxpeRZ8H5aK
 1BtdTbjJOunwmU8Telry/nsirzJ9nKatAieblWTJvZN8FpDMStFjiHqqI0LM1zc0eea6
 6Dc8HAwfz3I8qEW4ALcN0WkCKu2mrPqOKwY07zBNd894CUTZ30+bpGghtA0fGG0xyRZ+
 dKeL+C4XIl2z3jhUros//763150Gn1YWQDKbID8dTMT29mCmtGV2snIST7pMrIFpv4m+
 fkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776201022; x=1776805822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yaDAyMFaca26iuPqjWvb8SkDPBRVWcV+c0Unpuab6c4=;
 b=hwi88VkmnGl5Y8Lotn2Z9a2iPK5bzlEPOANPecde+kCAX4ESNsJXO39bYKB6rjaThl
 ozeVj/ME11RrSLG34dyZyyChp3YAMZIZxYeBiNB+U4vJa9EfeGv4B2HAMIusI3AZtb46
 uJZLdtbsdfNPXwFDY3ZohKz0HPs5mkD3sqohM10kMTE9Qik3bG+8a6zEWoXc21yX7ZaD
 LuYbn5DphfJNyAncVJJRRAdHJz4+3LFA9KfWTpm9de6X22VkGyVSowr2iLeQugvrqp6t
 TANMdr/fCKxDB9JlA0R1ppOCzYEZhHUR76thjBtHTMOwRriTMdYZ6czsLr0xMLRHEHTz
 gR0g==
X-Gm-Message-State: AOJu0YzMuXOCF2Fj3yVwh5Da+k8HtRWGAGOayymA7uFnk77VPjhsZX7i
 +4VeLfz1W3WJyjM+7QZf720/litV6iMutW00A7pcHJifpJWL/lWUyiIHpg86nLEBJxqbLyYm3A1
 iPQnQ
X-Gm-Gg: AeBDiespcLJItxsa6Dc6kvNpLe75Iy4muTcbk64NczHnnP5ZPnca68NxNkzk7Q9sRVm
 4wWESFymuu5EVSw2TJ+tJgmbQF9TgE5uhU9HkJDRfkTuE/2InB8FNBjv0agzhgziUVy3WWR4oBT
 /ms5ikaOkO0qtDNGF+2bwI1h14HGH2exkFl5i6pDvdvYTjlngLVoyVvWD21vaU0OP2aCXxyEt87
 nxtdivA0VtoCvGPwi1siJ84OL4DAt2Bgbj5CQG05tPaMEWeiMurIlolAVv0fhGenGSVAakhiFbz
 1hM0SnMhwH2VFdsuoiPY9E34IcxWN0tiKBIc0cK38AhXdDEYKOJwo4l4Pf8m4LU5LnxNHghCyEV
 LgGe2DIWsKo8BG5AFtHwVyC+kvEVYJ+EqxOBOkmDttaSeZ7z7g1cQVK9Oz0DYGh4TrtI3LDqc/x
 DZT7SQRJAGHzuxV9pCGUg71WAJDyCm6yd+gdjMYmSnsfs=
X-Received: by 2002:a05:6820:c0d9:20b0:692:a19b:af77 with SMTP id
 006d021491bc7-692a1aafa54mr620230eaf.5.1776201022550; 
 Tue, 14 Apr 2026 14:10:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc82ea711sm7770224eaf.4.2026.04.14.14.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:10:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v14 6/6] MAINTAINERS: add section for AI review tools
Date: Tue, 14 Apr 2026 14:08:43 -0700
Message-ID: <20260414211012.951613-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414211012.951613-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Aaron Conole <aconole@redhat.com>
---
 MAINTAINERS                            | 8 ++++++++
 doc/guides/rel_notes/release_26_07.rst | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..c052b6c203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..aa9e1e962c 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added scripts and prompts for AI review.**
+
+  Added AGENTS.md file for AI review and supporting scripts to analyze
+  patches and review documentation.
+
 
 Removed Items
 -------------
-- 
2.53.0

