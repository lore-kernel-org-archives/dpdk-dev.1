Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2BC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 583F34021E;
	Wed, 16 Jul 2025 12:15:03 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 06EF74013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:15:00 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 5411D1D000DE;
 Wed, 16 Jul 2025 06:15:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 06:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1752660900; x=1752747300; bh=wh0eqOOU6DKn7MFpNX9BE
 HBDjWDzGNtlg2RbLQ9BCck=; b=vrZSRVS89FzaPdwI2Zt0a5eibA7ga+/J+ZS+6
 +oyXd9N450J0uZz4PLvww7GpDItgGRPWcmgqc6pIaM2Yg53Bt5il5j0AbWh5Tpso
 Qp8D9DecgAzl6JrWcT70kMLiiFVrNvGU2K11l+rCD9/Z8gOScxRO0geQnEMUcD2t
 1vnyczthq4/PlW5wtimzRaqO6iw/lgzPNyD6p3sUk3wCrWuyS3alc0RqMhSCmLBL
 pYkPPtPli5bObRSOYdv8hlqkhMn7+AfJeG7LHjfkUiWmguvoSefUHz448mS/69UX
 4z9C7rRj5I0ZAmpALH9c5vvUbQzJY5r1uDzI8gc0SFqVSf8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752660900; x=1752747300; bh=wh0eqOOU6DKn7MFpNX9BEHBDjWDzGNtlg2R
 bLQ9BCck=; b=XJjfkeLVLcO4hJkdGOCk2NiGjaqyfVyanxLTPUX5CD+0fxkM/mT
 eUC0efnpG0sO6mzqaQ3UxDF/4ZUOSKOFeCIW96e+41/PM2cOaolonGsFKy6ARdMC
 pDOdYwDhBeGfLDhTgukkOn1TAguzcIQUiYGPbhjyEPm2c+qN7AuVLDI1e/Zr62Zt
 NgFM7lzVblwn9Rq8FupgkH5wzLaKkOWCIXpJ5zvjAWvDAh/rKhXx7bQJpiT3lwd6
 Y8/x0k08mOIbUng7okEjnP8RBkCpad8ctPCSsXr9dN3Gjroc1bSht0WNa/Knzqmh
 fM8RHCImFzfMegovlQRCoMYgQnizSLsCxTA==
X-ME-Sender: <xms:o3t3aF-9nle6IOtjEuBjYpCMPrNPWFss-xWX-lher85aGtT-DaouwA>
 <xme:o3t3aE_I_uo59GWQLlxz5TwLLMeC5RTbYTGsMKhByTEif2pG1YufbRGtCPCz4Z7sS
 KFXFKYeuxDtFc7xXA>
X-ME-Received: <xmr:o3t3aDpY5scWS5dsIWIhEb5616UZ95EPwxtYo4RJTVXEfajygYlS82dxUWB0xLgUdO8mxuibnIKRIUKwMUc7zlFjeOaYcLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
 cuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdelvdduhedvudduveeuvdevheegud
 elgeeigfejheduhedttdegudffjeeihffgnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnh
 gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:o3t3aPoX8i0rovZ4ypUJQ6HLb_tTrynHPr120TiPEre7deX1FwbXcg>
 <xmx:o3t3aJlSjGC5ee7I1bJeVkpYK8bqY5SC6OvXpoaez-I34S0k2m3gTQ>
 <xmx:o3t3aJGWJaJ1xXK6ZQS1pvv5foDw1BjIg8SF5vC52Fz94RSRpm8TEw>
 <xmx:o3t3aKpOnhygsR2-IRHzgs05PPJqYlVdppRVo_U_QalFJrbqMSd2Bw>
 <xmx:pHt3aM_Veea1df-6_ekaTv9dZNqYgQySAMtInjoRLcXDLD_8tw_-tz8u>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 16 Jul 2025 06:14:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH] doc: make table headers more visible in guides
Date: Wed, 16 Jul 2025 12:14:55 +0200
Message-ID: <20250716101455.224877-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

Set a background color to table header
so that it is visually easier to read.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/custom.css | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/custom.css b/doc/guides/custom.css
index b662abb34e..7db37ffc68 100644
--- a/doc/guides/custom.css
+++ b/doc/guides/custom.css
@@ -22,3 +22,8 @@
 .section li > .first {
 	margin-top: 18px;
 }
+
+/* Table head row more visible */
+th.head {
+	background-color: #ccc;
+}
-- 
2.47.1

