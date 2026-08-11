Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FEC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5495E42707;
	Tue, 11 Aug 2026 17:55:11 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 1BB3C4026F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:55:10 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so26844646d6.1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786463709; x=1787068509; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+yiVsQ162Dvl98dkutNuLsLIoK1CoUHFKy/RM87LqCg=;
 b=QCrEOXp2/HPN7kXPA0rOR3bj81V5HeKeesASNLACGWGDiCLi37FozKJieLCBW/LpAT
 9QHcjwipZoNgd3E/h0AqadXt0TV8wcDJP2g6zg6xgHZIvA5o/jBQcXOft7FQNZICsJdP
 /+ev1KbsffQ/f+VMajMFocRGWuJRQzKeqL6eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463709; x=1787068509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+yiVsQ162Dvl98dkutNuLsLIoK1CoUHFKy/RM87LqCg=;
 b=YXNw068yabkWn74YQY+bxR+uEWAuLUzrXU9ZWr4+xusgVsgAhUyUkHYqOHyAt57Exe
 Or74VjLWd6re8QMZ+aCxSnPFhhMqZepTo/mtrXqHMdUhsj91CMt3Ek9hTQKvGHpOUP9Y
 aSKoCIbMEbDT8/zRpGWqgAdoQiCPNWPSi6WWTCL1qOuhW/tyCAxeIN2tgmVt3NXQwwAd
 W/Ho67Gl/vIHEBP/h30Ig+WhK5x5wb1q79k/iAORHPsZwhHgxVLs/rsKBfjow0PjVs6P
 xPvB+uxbO3gDiLoecxpjUtMTaW4OPtMbbirLgEoWes7hlRPg9gc6LC3khufe1TfyxEt7
 K3EA==
X-Gm-Message-State: AOJu0YxzTZSQzQHwKE5VOzsOM81FcseIl/n/BWI/GYi2yD1eNPY8KjYr
 e5+vuogAGlpVknOJpB8vc/1hBxNjFASTekpsHdXf/II0kivo2pfg8fblp0ikrepUzIDRuMC/qk/
 w74r4AkgvFVsCg1ieKtZBTU8g7qNPoVels30wgcPLHa4EsnqwJT1LvxDPkWO+aWpKRfq9+7ZPYJ
 TNXSIu5rENkoqmg9+/fix8Om+ipnU=
X-Gm-Gg: AR+sD12I4+ac7bGqe75FNql6F/gf38IT+nRYjZDpQGWc81pHximoVvspwjYY2yOAmZJ
 anH1nC0SbKG01KAWf5vHIPsAEBBsdxA/GpSKPTSsZpEkmkTi7eSJIf1nPZiH5VoSsQOe00XfPBv
 UO/iJ2z81YkLwWZ7zBAr7kn9AWakkWh+Bg4L9Q8bSLjHiDtqv+XPsN1qT+Ljky8/z69YYeLCt9r
 HUN0Okc9kQzy6ZdaFTfEb8OjxhovXDIoMSdJy2C7z2HmtZloqmzp2222/mPTx1GDaCdskR1Kw+M
 X/Zl2frDMShYyDE8TxZrdkNDQjSQR0ltuAU3YSOBsferCeOORbUaPHj/HE20f5VXjk4o3y/UMg6
 MycEl28dRZ9DTMP/rcDxIhpaIHLCDJFdVTSwmYKGszoMHstvv00AuwYq7i0oXmt6zTvVUtut4Rw
 idbp12PX2cR0UMojE1dtfneNsb6ArrmtaJK9vKN9DuNdA2OPu6500oXMvA8iSoCfXa1+Ozl4mki
 IpWZMopxsE=
X-Received: by 2002:a05:6214:4306:b0:8a0:d08c:a720 with SMTP id
 6a1803df08f44-90a668da06cmr40445296d6.17.1786463709191; 
 Tue, 11 Aug 2026 08:55:09 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c29fe59sm2120326d6.15.2026.08.11.08.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:55:08 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: update verbose output regex for VXLAN packets
Date: Tue, 11 Aug 2026 11:54:49 -0400
Message-ID: <20260811155450.486646-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155450.486646-1-abailey@iol.unh.edu>
References: <20260811155450.486646-1-abailey@iol.unh.edu>
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

From: Dean Marx <dmarx@iol.unh.edu>

The packet regex in extract_verbose_output could not
match verbose output from tunnel protocols like
VXLAN because it did not allow commas. VXLAN
verbose lines contain comma-separated fields,
which caused the regex to fail before reaching
the final field. This silently dropped the entire
packet from the parsed output. Added comma and
dot to the allowed characters in the regex.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
---
 dts/api/testpmd/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 7118f9470f..3d9b64d725 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -823,7 +823,7 @@ def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket]:
         prev_header: str = ""
         iter = re.finditer(
             r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+ packets)?)\s*"
-            r"(?P<PACKET>src=[\w\s=:-]+?ol_flags: [\w ]+)",
+            r"(?P<PACKET>src=[\w\s=:,.-]+?ol_flags: [\w ]+)",
             output,
         )
         for match in iter:
-- 
2.55.0

