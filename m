Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A252CC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 03:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9613242EAB;
	Wed, 23 Sep 2026 05:25:33 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 21751427AE
 for <dev@dpdk.org>; Wed, 23 Sep 2026 05:25:32 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 878C37A00C3;
 Tue, 22 Sep 2026 23:25:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 23:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1790133931; x=
 1790220331; bh=vC1pob0yponhgZJBFDY4dHK/QsNnm34InPU/fY/S7D4=; b=u
 YF1vGRiFeYUJqgA64esT/80cXRwRTiQ8gJkv2UGMoYuQjxDNeE+c/FQWy7iDmSWW
 R9SjnrOHxoxHTHYSnZxMubeVLeqJ1IIJiAH56BT6cFMiuho0TEnRVQquA6LhziCk
 beLphtE/A8kI/aWYhSMeKWQFh7z3dJttuMpDytNynK2AqGpUyYFtXLpOB7QcPpN8
 QMBFsXfM98cHFl1nQkej699fD9QuPdCMlT2uZqGZjxXLcoIH03Wua9aNd5Me9zA5
 DD7Gf7+/pkQqJ8TrdLF35g0s2skKKecAq6rNkOvDLpmeARNq19c6M2b0kpf0UH1G
 yQnotOR6RDq+iaJ0Z/qeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1790133931; x=1790220331; bh=vC1pob0yponhgZJBFDY4dHK/QsNn
 m34InPU/fY/S7D4=; b=ReGuwksm5Eiua0KlgN6F+npBgOH5uTQJPfupzZ4yeRCk
 F6W0JPfhP44Xd+0u8rOqcyED9djw+tixBfvhupXBmTIlZmrnQAahHNw/acpUhY+5
 LyGMsj6+CcoIpeODoRHNuARlYY6MD1lsaeCNl1E7S1B3h5xUZyzw8y/Zi/fP0wBM
 Sdk2jGTWWnIqi2+76nObBQgDRMJXz+NUUVp5FZelF8DqOFytOmohr9ZmNssDt4T5
 roebeQRjCSQEhFE0dBzoR2ebYwjjw2ytHW1WCNYlpw3RniduDEn/df1T+PN47blF
 /DlSkA8HndQuFWDATWtuNcoFFeFfpeIHMej+FuRfiw==
X-ME-Sender: <xms:q0azavh_IwFyWuTdy6GAI6ljGIPzUoRG5gB7rmUMinf6JLf15glG5g>
 <xme:q0azah7eU9zq57SrLc-CvfSG2qRW3l2KEKEVrKEv6ulo-ISitHYeR10a0GNwOPseK
 dU0cmMx6DsUV0W6J0hPdCgrI8reZH41krNrkY1EN3Ou62t2ncOEog>
X-ME-Received: <xmr:q0azaqJTnflH8obs8QjP6jWhY07GR-Puufwuqxx9WKEPRBfZyAk91rw8vyNzRTlZaDnyPAel1nDIkA62WNqqF4TQAqb9>
X-ME-Proxy-Cause: dmFkZTFUaVqAxTArtSVYM2iFYRTKRa0OrNsFmuwF0MWYvp75jlPa3pHB4eJsbATcSPa3OV
 JPFXEJIAKg4oqlDN6jXA7CeqSc87F+yq4SoMdcx1dygN0ZUkiNNp4EZfvIvylpkbP665uO
 Mv97s2XmdUjJkmtkcPR9XlrdrqXf1to/UbHelTQ3uAybhcsM5KKQNn0KuRCTF809JvvxrP
 +EeTd0LUvZFKUVdW/Lo1cxqTllc+bjl2sRVCXjBNlevyidPrsBBGAJIEHuYBZZ/B7Spd74
 iH2GLQyLdpQQxjqodJgiyGFo3LxZoc5yDSrhdlNjx7vkfpRKMUo9sazQogHu9OZ06TfpbE
 JpGNuXcE4EmHVMi+Mi+J/B+D89iGsDPdFIqIWC9LMT/F8lRCfUdkB/NTMFMceplTFF9eUS
 3znzWTUIogBNhivZ8PmSgk6qWgP+NefKYcphN1OBrik75iwcdnO0PeOK/OBChFl7JLI99A
 JZOxYwDoQWTQUUSc0S4t2Ghl7bNtPQcF+FFhqA8CVUXlmj4Z0yzYz1kbBs2hqpSFC3aQqD
 RNT679Wx9hc58PCSW6Fz6dhcReuk/ITRs2Spah5jOBgjvMltwDicNJWl7Wrenj+bikVgNG
 0jvDGYXFu9iQ6c0Twg/wu2meS0rxFv5CIDMu98MN3rt7NzuAn4SMiYV+Uucg
X-ME-Proxy: <xmx:q0azapE8GN0dcbNg8r0ibKJSJ-AXbIXOpbiOSLObSh_2XGxjezWkkw>
 <xmx:q0azagV7ivn9H2C-zQ66gY1zl45-ckDnL1VhddI-gpRwTkjlgd9Fqw>
 <xmx:q0azakhgjtHZLezbJM7Os6gcDFWsj2bgfxg9HEoWydBJ1V_Xamhlxg>
 <xmx:q0azahSkpPfmKQLO4aYEyuhQNzTJpgi-gLqXeJhrbPnq06fWnLwyKQ>
 <xmx:q0azavyhSyVD4Xx4JA_hepgVMJFkz2HDMR_1FqcrocuNb8GEkCs32VD3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Tue, 22 Sep 2026 23:25:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 1/3] doc: move CSS of overview matrices
Date: Wed, 23 Sep 2026 05:20:49 +0200
Message-ID: <20260923032502.770744-2-thomas@monjalon.net>
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

The CSS to transform overview tables in matrices
with small cells and yellow cross on hover
was inlined before each table.

It can be replaced by a common definition in a new CSS class.

Two basic rules are moved to the top of the file before this new class.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/conf.py    | 73 +---------------------------------
 doc/guides/custom.css | 92 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 85 deletions(-)

diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index 5f0a602741..18dd6f4663 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -253,7 +253,7 @@ def generate_overview_table(output_filename, table_id, section, table_name, titl
     outfile = open(output_filename, 'w')
     num_cols = len(header_names)
 
-    print_table_css(outfile, table_id)
+    print('.. rst-class:: matrix', file=outfile)
     print('.. _' + table_name + ':', file=outfile)
     print('.. table:: ' + table_name + '\n', file=outfile)
     print_table_header(outfile, num_cols, header_names, title)
@@ -311,77 +311,6 @@ def print_table_divider(outfile, num_cols):
     print_table_row(outfile, feature, line)
 
 
-def print_table_css(outfile, table_id):
-    template = """
-.. raw:: html
-
-   <style>
-      .wy-nav-content {
-         opacity: .99;
-      }
-      table#idx {
-         cursor: default;
-         overflow: hidden;
-      }
-      table#idx p {
-         margin: 0;
-         line-height: inherit;
-      }
-      table#idx th, table#idx td {
-         text-align: center;
-         border: solid 1px #ddd;
-      }
-      table#idx th {
-         padding: 0.5em 0;
-      }
-      table#idx th, table#idx th p {
-         font-size: 11px;
-         white-space: pre-wrap;
-         vertical-align: top;
-         min-width: 0.9em;
-      }
-      table#idx col:first-child {
-         width: 0;
-      }
-      table#idx th:first-child {
-         vertical-align: bottom;
-      }
-      table#idx td {
-         padding: 1px;
-      }
-      table#idx td, table#idx td p {
-         font-size: 11px;
-      }
-      table#idx td:first-child {
-         padding-left: 1em;
-         text-align: left;
-      }
-      table#idx tr:nth-child(2n-1) td {
-         background-color: rgba(210, 210, 210, 0.2);
-      }
-      table#idx th:not(:first-child):hover,
-      table#idx td:not(:first-child):hover {
-         position: relative;
-      }
-      table#idx th:not(:first-child):hover::after,
-      table#idx td:not(:first-child):hover::after {
-         content: '';
-         height: 6000px;
-         top: -3000px;
-         width: 100%;
-         left: 0;
-         position: absolute;
-         z-index: -1;
-         background-color: #ffb;
-      }
-      table#idx tr:hover td {
-         background-color: #ffb;
-      }
-   </style>
-"""
-    print(template.replace("idx", "id%d" % (table_id)), file=outfile)
-
-
 def setup(app):
     table_file = dirname(__file__) + '/nics/overview_table.txt'
     generate_overview_table(table_file, 1,
diff --git a/doc/guides/custom.css b/doc/guides/custom.css
index 9c19a28cc8..7ab175db35 100644
--- a/doc/guides/custom.css
+++ b/doc/guides/custom.css
@@ -4,19 +4,6 @@
 
 /* Override readthedocs theme */
 
-/* Set full width for all responsive tables of a page.
- * Usage: insert the following line in the doc.
- *        .. rst-class:: widepage
- */
-@media screen and (min-width: 1100px) {
-    .wy-nav-content-wrap:has(.widepage) {
-        background: #fcfcfc !important;
-    }
-    .wy-nav-content:has(.widepage) .wy-table-responsive {
-        overflow: visible !important;
-    }
-}
-
 /* Spacing before a list item must be bigger than spacing inside the item.
  * Complex list items start with a p.first element. */
 .section li > .first {
@@ -28,6 +15,85 @@ th.head {
 	background-color: #ccc;
 }
 
+/* Overview matrix with small cells and yellow cross.
+ * Usage: insert the following line in the doc.
+ *        .. rst-class:: matrix
+ */
+.wy-nav-content:has(.matrix) {
+	opacity: .99;
+}
+table.matrix {
+	cursor: default;
+	overflow: hidden;
+}
+table.matrix.docutils.align-default tr > :is(th, td) > p {
+	margin: 0;
+	line-height: inherit;
+}
+table.matrix.docutils.align-default tr > :is(th, td) {
+	text-align: center;
+	border: solid 1px #ddd;
+}
+table.matrix.docutils th {
+	padding: 0.5em 0;
+}
+table.matrix.docutils th,
+table.matrix.docutils.align-default tr > th > p {
+	font-size: 11px;
+	white-space: pre-wrap;
+	vertical-align: top;
+	min-width: 0.9em;
+}
+table.matrix col:first-child {
+	width: 0;
+}
+table.matrix.docutils.align-default th:first-child {
+	vertical-align: bottom;
+}
+table.matrix.docutils td {
+	padding: 1px;
+}
+table.matrix.docutils td,
+table.matrix.docutils.align-default tr > td > p {
+	font-size: 11px;
+}
+table.matrix.docutils.align-default td:first-child {
+	padding-left: 1em;
+	text-align: left;
+}
+table.matrix.docutils.align-default tr:nth-child(2n-1) td {
+	background-color: rgba(210, 210, 210, 0.2);
+}
+table.matrix :is(th, td):not(:first-child):hover {
+	position: relative;
+}
+table.matrix :is(th, td):not(:first-child):hover::after {
+	content: '';
+	height: 6000px;
+	top: -3000px;
+	width: 100%;
+	left: 0;
+	position: absolute;
+	z-index: -1;
+	background-color: #ffb;
+}
+table.matrix.docutils.align-default tr:hover td {
+	background-color: #ffb;
+}
+
+/* Set full width for all responsive tables of a page.
+ * Usage: insert the following line in the doc.
+ *        .. rst-class:: widepage
+ */
+@media screen and (min-width: 1100px) {
+    .wy-nav-content-wrap:has(.widepage) {
+        background: #fcfcfc !important;
+    }
+    .wy-nav-content:has(.widepage) .wy-table-responsive {
+        overflow: visible !important;
+    }
+}
+
 /* Class numbering table rows in the first column.
  * Usage: insert the following line before the table without indent.
  *        .. rst-class:: numbered-table
-- 
2.55.0

