Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7CC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 03:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 799B5427E9;
	Wed, 23 Sep 2026 05:25:41 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 190C3427AE
 for <dev@dpdk.org>; Wed, 23 Sep 2026 05:25:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 797247A007E;
 Tue, 22 Sep 2026 23:25:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 23:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1790133939; x=
 1790220339; bh=Hpj8QrvFGy7NHakZtpu6s6aCtuJVcBGYBE9WA7MU8K0=; b=o
 Uu1+lYvNCMLmkUsi+qeiSdd5SWJ5ZbvJMoXwoSAv2lydSlKVmc//KPjegbU/0PU9
 CtKaniaC9dWJIamK9j99UrkpKL074pmE7sptB+twIno9/TuLOlbldMNEB5EbQHin
 sBC8CS+V+RSUXDFdGXyuKkA3+YjhiIYGlMZN0QZhsCjDKo8u0CZbbUL5YVFMRspZ
 mUZobwUqH+a7g8+j7Lqur7NQhFdi+sjA5JS5VF/zsP4TWg4ua0yMIgOHqSXVf72o
 tmSDlTkdl3xVdJPTrJ815h9wsuQUWy645mkWgt3i1Tb7bypX97SzhxcQqY9omyfE
 xVotfGpynbIHCT7EHMR0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1790133939; x=1790220339; bh=Hpj8QrvFGy7NHakZtpu6s6aCtuJV
 cBGYBE9WA7MU8K0=; b=DnBGBIpkzcHc2rHDA+NQ1RnUPMsHDeX7Z7I+jCdu3Cm3
 b/TQuySFK5+9HrCh6ROW/hYYj7C6qopXlQxWa9PtuK6TRpm3kxD5Q7QrhRsir3ud
 IJMWn2NnWk8mw2GJRim6X/r/hys19xkqNGbAD16NwQl/FIMsHi7o0sb+OQZkg2Tb
 BvQGx40zhi/UFsEpRr4pkdCLhXBrcmyDXzeon4NM3czARJfvdzg79bKNmlvnte1r
 IOqHDHpEQno5TDMkCOhYklIGM5L7SEqeng7PUI1MrX0Dc08oSnNw//8TsRLCXpYE
 oCRv2qROOuu3pKz79HJcSWMjwxU07o6KZXDMZ/qq+w==
X-ME-Sender: <xms:s0azajIVodjyExGLapcjbq4B1Ay7zsLmmp-DXsVaNOg2MVP-fSbqOw>
 <xme:s0azatCDVk5sjKGWPa85w-sTETZ_WHGZ2a42CP1d12--gfic-sPpdqBCFemSZz_JO
 qhQr_36pHYwihD6AztkkbNzCaK9vVbzt1LDs8L3ejVQVDMqd_E3JA>
X-ME-Received: <xmr:s0azamzMswEJ6JPAfsPiqEvmIdIgy6-iF3daSoHtzUnt5pE9qQZfhQ9pt08JbUfAkrGUYSNDAfv-6bfUBOsWlru_VH5e>
X-ME-Proxy-Cause: dmFkZTGrBG7kOeveuLHzH2pK3Ti7f20TUn6dcMfWyP4UKUGjDQNslB7mwzbskPtuX8f4Ob
 fl0NjpJtOFW+MtP8K+jf/GD6zALbnTSXN6dYwby9VYspEVrCDzxwzD3CmtjMg05KxHDj6z
 z7Y5f+rhvcKZ9DOqAEmDfr69uk7lvDwQMW98sFiEmsA9ykBjO/PZp9BGtCDkhozD6RS8c9
 b0cPWPp7YiPhxeheQssC+tvM3J4tnCYIiGgCnD9uA/S6wfRWVkefBWWd0Cdp4PiahQsQOA
 zg6kmENNOEXz7sa30x1ry2DKGot93M6J1TGThq/6q5IGhrI0YHRRi9L0zlj/vF60AixHsV
 iyBLo213GK904W2vEaP/N9GUTkBp6uCxdXgKqWHGyvst6fhFKK1PS7VOpKJKwMvKP8fCUP
 Kq+gR31BifZmJ0HmZhqgruedUeMFFlTkHCVQaz3+cs0U7QEdVw7zCs0PZdqDj02iCTJPap
 MK8MLnMMAWcBfe+Ws9IIvxOJ/QxDWsDbGQPYx7iBG5+rQp3LTbzIkNFMwhXNs392i5umqm
 lyUwafy+dgSRoTLIQ1wZBZu0mrOVqJy4snvk7UHC0bprAC7LoXn0Nl8xA4cHZ2kEKDZnLD
 RA/jFhPjL46L3oSakuXIx6eZKazEdNH0qPigTq7bsALydjMqkwat9xdy3oRQ
X-ME-Proxy: <xmx:s0azapMmZwX41WBsaSAFMKOZ5v98kY99CG8Y2OwMqFMXlY6yie-Adg>
 <xmx:s0azat_pOX-Z-XrsJKx4Kr63XYttHiS6KQQVU3Uznk9oUIQfsQ1-yQ>
 <xmx:s0azahpv0Jek7Oykn-8BQMqOuXSpYZnjU1Y_J8NG8JEH5J8i0RjNAg>
 <xmx:s0azan6frYCgcdjPYrtq3XGPG5l_FdElmOsYmnuBY7c97w_fQNr7vA>
 <xmx:s0azai4Y6_HSTplAYt3_vgz4WVvR_30k-ruUR2fXOWqiKGIfnnCWkhB->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Tue, 22 Sep 2026 23:25:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 2/3] doc: improve style of overview matrices
Date: Wed, 23 Sep 2026 05:20:50 +0200
Message-ID: <20260923032502.770744-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923032502.770744-1-thomas@monjalon.net>
References: <20260923032502.770744-1-thomas@monjalon.net>
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

The yellow cross gets full opacity and appears in the column header.

The selector nth-child(2n-1) is replaced with the docutils class row-even.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/custom.css | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/guides/custom.css b/doc/guides/custom.css
index 7ab175db35..ce119acfda 100644
--- a/doc/guides/custom.css
+++ b/doc/guides/custom.css
@@ -19,11 +19,9 @@ th.head {
  * Usage: insert the following line in the doc.
  *        .. rst-class:: matrix
  */
-.wy-nav-content:has(.matrix) {
-	opacity: .99;
-}
 table.matrix {
 	cursor: default;
+	isolation: isolate;
 	overflow: hidden;
 }
 table.matrix.docutils.align-default tr > :is(th, td) > p {
@@ -61,7 +59,7 @@ table.matrix.docutils.align-default td:first-child {
 	padding-left: 1em;
 	text-align: left;
 }
-table.matrix.docutils.align-default tr:nth-child(2n-1) td {
+table.matrix.docutils.align-default tbody tr.row-even td {
 	background-color: rgba(210, 210, 210, 0.2);
 }
 table.matrix :is(th, td):not(:first-child):hover {
@@ -75,10 +73,11 @@ table.matrix :is(th, td):not(:first-child):hover::after {
 	left: 0;
 	position: absolute;
 	z-index: -1;
-	background-color: #ffb;
+	background-color: #ffa;
 }
-table.matrix.docutils.align-default tr:hover td {
-	background-color: #ffb;
+table.matrix.docutils.align-default thead th:not(:first-child):hover,
+table.matrix.docutils.align-default tbody tr:hover td {
+	background-color: #ffa;
 }
 
 /* Set full width for all responsive tables of a page.
-- 
2.55.0

