Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC45C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 22:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD144065B;
	Fri, 18 Jul 2025 00:09:42 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 376D540658
 for <dev@dpdk.org>; Fri, 18 Jul 2025 00:09:41 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A15A87A00D4;
 Thu, 17 Jul 2025 18:09:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Thu, 17 Jul 2025 18:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1752790180; x=
 1752876580; bh=B2zg5ntWJvHQ4jPaWsnuLArAy2S/yPZjJqsZMqp9r3A=; b=k
 tj9+KoxblhPHphA83yNIN1HJdQDECDJzk4njRh1Z5tjVscwQ6ccFq92+aKDAwgPu
 XqxqlFyR4qXpfKEE6ykAF04XzY588ZmFGcxSDM0YdWynu64Oo77Zs60iqYkqIPXR
 DZgLYZKL1pQvG2cd2Jh7J4KUXcziizp927yVlbfirNN0UAw1iEALff+3Zz98R6Lb
 jmc98iCEsDY7YiozR7fHF1slYg3Ni2ImFsNLKBJtRwpDVuH64Cud3VVZV2VgZ9Ci
 IY9QC5jbkLQaRv60yWxz6PyV59Y2vIYvOf0X3zyPL/noAYqAPAY7noOmgrocBESm
 ifBn22lzA121RHPJje5Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1752790180; x=1752876580; bh=B2zg5ntWJvHQ4jPaWsnuLArAy2S/
 yPZjJqsZMqp9r3A=; b=bMU0CcpnFnm7oLdCibynW3vVWLCiZFpayMSjBD1Cj6QY
 FPll2UTN1OeoLCHSxUEvZKZZN6uOkc4TM8F3MCSKkiOVSf4TrPppk7qwuul6txYd
 h65q35z6cPT4Bs5KxY/ZtC+xK/n3qNs5/+DITeOGa7TUUmAkfyhldXZKjJqdLr27
 WgxlFPWON1REUC4XjjsKyKwrNM2Rb1MZzbh88V4Iq+qafrfk32954rU8jToxcni9
 XOcfrZnnyG8I/7G5v51cBMREVugp5eZR7IfbOUZyvZxeyACP1NiBK6UKvZrPWQoh
 E0yBeC6A0fVmp9eznPVoE/MXvWB99Jc6MQQmt4f1CA==
X-ME-Sender: <xms:pHR5aB4aZyoPiTtsETdfMQl6TGiAuGYiTzueB30r34HPWteKQ0wGeg>
 <xme:pHR5aKLftc--uyPpLJ9VZXpTktFoJuSRVx136pPQ7_Ky0-YFqahleakw6ZZ1UVdG7
 liVLEx__cB9X-Femw>
X-ME-Received: <xmr:pHR5aJHYUyNPCOGgkkr2AU8MtmiZS8IFY4xPmdrQ3v46DsAudoRyXsFjznh_37M0H-1bsFH5T_WqWacgLYg_E1Ad6CcG19o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdehgfeivdejgedtveehfefhte
 elfefgieevgfffveefjeegtdfguedthedtgeevnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhg
X-ME-Proxy: <xmx:pHR5aAXnEz9rdonTmxTt03O6Oxj0qZi0CnLarGRqFc9c23BVqrDlhg>
 <xmx:pHR5aEhcGXTjK6a6kVOGyzOjF4CaHdz07xOwhLwOmwGwiqDsSV_U6w>
 <xmx:pHR5aBTwOVsULcwtb3nt6nzVwpihbnQwY_DeHGI251GPhKLCphBNaQ>
 <xmx:pHR5aHEdeFFE_-rtko2jq1zV57m1Vw5RNi5F2a0mF2xkRbMv1M9opw>
 <xmx:pHR5aOJnwRgxNQxx_y91cyiIeyTgIuEMU-oE-kbYBPgBYBAxDE6rWpjb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 17 Jul 2025 18:09:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 2/4] doc: add table styles for guides
Date: Fri, 18 Jul 2025 00:05:42 +0200
Message-ID: <20250717220912.376503-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
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

Add 2 style classes for tables:
	- numbered-table: numbering table rows
	- punchcard: colouring filled cells

They can be used by inserting the class comment before the table:

.. rst-class:: numbered-table
.. rst-class:: punchcard

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/custom.css | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/doc/guides/custom.css b/doc/guides/custom.css
index 7db37ffc68..9c19a28cc8 100644
--- a/doc/guides/custom.css
+++ b/doc/guides/custom.css
@@ -27,3 +27,45 @@
 th.head {
 	background-color: #ccc;
 }
+
+/* Class numbering table rows in the first column.
+ * Usage: insert the following line before the table without indent.
+ *        .. rst-class:: numbered-table
+ */
+.numbered-table {
+	counter-reset: row-number;
+}
+.numbered-table tbody tr {
+	counter-increment: row-number;
+}
+.numbered-table tr td:first-child::before {
+	content: counter(row-number) " - ";
+	display: inline-block;
+	min-width: 2.5em;
+}
+.numbered-table tr td:first-child p {
+	display: inline-block;
+}
+
+/* Class highlighting non-empty table cells in green color.
+ * Usage: insert the following line before the table without indent.
+ *        .. rst-class:: punchcard
+ */
+.punchcard {
+	vertical-align: middle;
+}
+.punchcard th,
+.punchcard td:not(:first-child) {
+	text-align: center;
+}
+.punchcard tbody td {
+	padding: 4px 12px !important;
+}
+.punchcard tbody .row-odd td:not(:first-child):not(:empty) {
+	background-color: #cf9 !important;
+	color: #0c0 !important;
+}
+.punchcard tbody .row-even td:not(:first-child):not(:empty) {
+	background-color: #ce9 !important;
+	color: #0b0 !important;
+}
-- 
2.47.1

