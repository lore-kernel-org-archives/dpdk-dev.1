Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A510F92E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 175D5406FF;
	Tue, 31 Mar 2026 18:13:06 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 4496240615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:13:05 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EAF377A00DC;
 Tue, 31 Mar 2026 12:13:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 12:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1774973583; x=1775059983; bh=Qo0KCnVifLI00bnYaMh44
 wJYH+ny1yrCW06Z9nRw+jM=; b=SbUmsuq4Oaih75Edbu10K8b1p9EwOt8XLDC9D
 S4WKh0v8pkdKQEaECNRKcF6SYFzSc2+OF+XOfTGSA4TKei23avolP/wK059rcXKy
 D9CqT6v0ZprqUZ7u5FgUrYE1FJBovKCI4EsE+IWWpCoC0KiH5zRkkWLsHqHZHmpf
 my0U2A+Qg7dXonEp5wBZ1IEJFS4Jiju05mfCvAIUAVaT4/4RTbYCDiXlu2qqYe4B
 qBRMm7rM6hO4LDuFXqxkbxAO9W50ocVSY5LuecYX5cCosBEekk923MvpLnb8c7Ye
 Ltrg0vyxd8+TBJ5h3/u7t77xpFKEDnaDuZ+cGlZbXbcciAofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1774973583; x=1775059983; bh=Qo0KCnVifLI00bnYaMh44wJYH+ny1yrCW06
 Z9nRw+jM=; b=a1JUfGzCdhv6h4FH4uGqgzLH5lVe17Ygs4q4/IMV1feO5q7enSN
 VF21D6FdUZl3zD3ihTUu1DYFi2t58WPZ7YSZyYrIDbYEbyI2NTXLOoFHhjn/IG2y
 4JqLO2FmADSAuGBvvXaxayS/TKilisfQFXgIaM1JPndy8TX7rmLSi2+AZymFKv66
 vtWXqjTrwvsNrHqC0t6XY+FKGyE2TKytzzh4KJW2q4mEmVrB5U87tLldQL9TYMAB
 U8Y40YfEVMTFeb72XFvstD4m6Xqk2ziQadUfbBzH4GdrTC54l6EdoLgRyyhYWi4Q
 j7yormK92ac+ttLp/eWg4PB/0Xxbg7T5osQ==
X-ME-Sender: <xms:j_LLaTisCVitA-EuV1FNnK4jgPb4wvyyImEPJ13TW1gh0eK-5_OLGg>
 <xme:j_LLaXebSjI-iYW3v55WufqMcsMpDyG8bRLuuYYRAbduQfTriL23ft44bPksOCydT
 At3GpnZScJpxLa1jaXzCHXzGr9PNlIueIZjhUqBQ8JFETtbyo14rA>
X-ME-Received: <xmr:j_LLaQckoylwVJCrgi6rxZ6ZDRznr97M5WKhtNm7d-WdsMkF0zONJso7qy9FhwbSh3TQFOWwkMleC9GACEuiUcGOkmoGL_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeihecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudekfeel
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheplh
 hutggrrdhvihiiiigrrhhrohesrghrmhdrtghomhdprhgtphhtthhopehprhhosggssehi
 ohhlrdhunhhhrdgvughu
X-ME-Proxy: <xmx:j_LLaZ8kE37DTvAshUzlOIVt2j51q8WsnEuIqwGbbyTdVAM2q2EMeA>
 <xmx:j_LLaUntAvDNCgKD4x17dFWBfKjE5uB9Ld0nXjdGdRYBGLeEijstpw>
 <xmx:j_LLaT8fTOrWlkYma20Em-v9sGp_eek0CPEBm8Urv4UwvfKdzySCgg>
 <xmx:j_LLaanxYgTzna2oefs4Z-O13hl7UqEQLFhnHEQ1T6lVVnZeyYrqAA>
 <xmx:j_LLaeJZpPXf1r_pkLrkkGyX9AmvAUZrBlsFB-E42NvjUUTjV_hkiNg4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:13:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
	Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: fix Sphinx parsing of a docstring
Date: Tue, 31 Mar 2026 18:12:52 +0200
Message-ID: <20260331161253.462180-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.53.0
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

With Sphinx 9.1.0, the word "ports" is wrongly parsed as a reference,
and the doc fails to generate.
Splitting the docstring (as the next one) seems to be a workaround.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/api/testpmd/config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index e71a3e1ef0..1e59bccd08 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -30,7 +30,8 @@
 class PortTopology(StrEnum):
     """Enum representing the port topology."""
 
-    #: In paired mode, the forwarding is between pairs of ports, e.g.: (0,1), (2,3), (4,5).
+    #: In paired mode, the forwarding is between pairs of ports, e.g.:
+    #: (0,1), (2,3), (4,5).
     paired = auto()
 
     #: In chained mode, the forwarding is to the next available port in the port mask, e.g.:
-- 
2.53.0

