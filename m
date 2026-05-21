Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F82CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:46:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2174040684;
	Fri, 22 May 2026 00:46:05 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5EAEC40670
 for <dev@dpdk.org>; Fri, 22 May 2026 00:46:01 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1353c2f35cfso19611906c88.1
 for <dev@dpdk.org>; Thu, 21 May 2026 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403560;
 x=1780008360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HPpSFYLHst7GG8DHSmqmykwTOdxpGYVRDd1U8lGpQY=;
 b=uc50InMdXhwNn/MVrEzQyk2RAFQ2xuQYCvW4/A0WhhWF/TbvN3/DWkaQovMPxOePYD
 CUe3p2KQDfpg6x37ze+5jUVoLyW+7ZQU5xGFuzkTnPiw5tpWqYZAoQ5r85mGAHDCo5bM
 ONmCFETJQOmHZJG4Dd2Slj0WIRpVrRIq20CmYlbE9ZvgysmtGeDVq/tCmKbfGCnbO2om
 ZQU+lY81WHj4IivplfuRA/9ERs6DNYX81Cw5dnwDFE+IrPAgu0JFDdc8PES7vuzmxalc
 iMLE+lWa64I3pC1oTOb0hpf+KhzMFTijh3HTmdE2PMzDt8WSHWiNrAyTKxxl+v/E8Fmk
 Ixgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403560; x=1780008360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4HPpSFYLHst7GG8DHSmqmykwTOdxpGYVRDd1U8lGpQY=;
 b=JvjgcZ2NPFsdwRd3UR+TxJhXFYcu+/QLlslb1fTKE3v1beXl45FztC3mVx1pUqkkon
 L4qLRMAKnKi9DIKT2NzsBLQ3tkxaX18tuMD44QzwAE9VOnCgESwNKtVPW4zGuOV84aMC
 olFimJRfENqmZA4rFMVo+mQdcZgqgEijpkfZwRKtHSEST8OEx0VGAeQ9KM77QEg0j6Qr
 Mou9XLRaWci556B5Sd5Gv8FCcSLw+O3yDPmpOCSQSf17Xa5g0q2564ZVHpG5hlmPQQyf
 VoD5yiVjjkrHUjdRKRrRhDUxKhl0D6vfkBYkTCtidBKf+VfOPCTBde9H+1oTBew7WPgX
 yDEw==
X-Gm-Message-State: AOJu0Yyp+QyfGDTjbStrXOTNGd8/OWEPujrQmM3p3MRLYExzp0Sxcnag
 uRiIbajcR1USyiFJy+eMNa6NBspJQ/hOMnQkSfMN0CyfT9W8NYb7KjdCuz1ItkuKM1BmnwMXv8H
 7jtna
X-Gm-Gg: Acq92OEM78idjXQXP+V6Z8KsB1axrhu8ncoPXSByqSFMISM+3Jk92BT2xpqm4GadSaS
 s9z7hNaf7o8Tl7pv5vPlzRKbb8RnBDtzYJ8JHonpLXPZcXw6J9KlMDoMV5DpWe+oqJqPyXotCRs
 7Z5h5Dl0AFSdalsrO9Rzx+PuXygs4OYYu1R2mnW7SRkDSv0qg53iwvCp/96B6TqlEu4ewDOjRnA
 uo9EvOGzRtjxzE2uytGjizUC66fui7NR2BuWqY54x2anF9hMiRlfZFlUQ5cqy2N6a3xwQpypRo1
 FIAVtVleuYtCZBw8Kom7MyQdRtj9YoLw2Dkf+XJxunHvoqDncqM0XiQEWSws/1CNTfzluNJLl5r
 rlPenUckROBEdl4wP3bJ0FXIcSiqxhqP34xvOf4JaHRBwKWXVmlYy/a96vrdSlfeU9RIAzo4iHp
 FxloNJf+KgFPueq/w8fWIR2TrNGpADXnPjVUx4IwJgOGgWg/bu7oBKHaGHMN2wHmNac0u0OAER
X-Received: by 2002:a05:7022:252a:b0:136:602b:80ac with SMTP id
 a92af1059eb24-136602b8140mr488080c88.27.1779403560447; 
 Thu, 21 May 2026 15:46:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136621d3ae9sm496044c88.5.2026.05.21.15.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:46:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v15 7/7] MAINTAINERS: add section for AI review tools
Date: Thu, 21 May 2026 15:44:39 -0700
Message-ID: <20260521224550.927338-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521224550.927338-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260521224550.927338-1-stephen@networkplumber.org>
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
 MAINTAINERS                            | 6 ++++++
 doc/guides/rel_notes/release_26_07.rst | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b390446ed3..61a8a9ee68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,12 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/ai/
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..32fb5a4c55 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,11 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added scripts and prompts for AI review.**
+
+  Added AGENTS.md file for AI review and supporting scripts to analyze
+  patches and review documentation.
+
 
 Removed Items
 -------------
-- 
2.53.0

