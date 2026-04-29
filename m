Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E047FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 13:09:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8134340151;
	Wed, 29 Apr 2026 15:09:43 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id AC5BA400EF;
 Wed, 29 Apr 2026 15:09:42 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 42191EC0170;
 Wed, 29 Apr 2026 09:09:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 09:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1777468182; x=1777554582; bh=diD8PCZuknX848NVJOl+5
 EQ2vrPpYZxGPxhxl6JkfHE=; b=oQOuHy8VmhvYEwcvWhlh1ZmQYWosSMNIGNtcu
 54CdmMQ8J9cicsF9QCVZfyKxVaUuvJMszjmitgHU4sgCtszoNxUZadDAj9XSiSYK
 ZQyog1yIYqb2wPUy8MQas7Bq/Udgxq3qwRx/BpG0d9s3l/R3+jxW67GWRUHYoXol
 5pnBLuJTHbG6CS+cm4HunXi/mKu36V5LwyHiDIOZSEy4EAgvlgXBAI0gZbOLTWME
 pQiz083G6fXEr+iI5omQ+Wt8fllhaEPxNZiCWeQkbBL4MWVtRKsBgBXI20ek91jx
 azmYwuMwnVXvEZCXFWCpXIulemitA77Wg2cmT3a1DDUPIbtlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777468182; x=1777554582; bh=diD8PCZuknX848NVJOl+5EQ2vrPpYZxGPxh
 xl6JkfHE=; b=rEmhsx9gcwiw86ZpaMPocpybKSRTvMVW8LvCMM4v4HpnhLNL18r
 3iEareRw8lLAQLXmW5JAuilCGxigK0w6b9Kf/vfZx71rPbEYBNu25tr3YVljLfkf
 CRCcVgAoekaD8uzRhOkjTPZAYCpyXykvi5OWgUEoIxeC58gd7R2PBqTOXXMwiOEY
 kKtd4L9YCaPMaRvW3qt92MM6q/ZFlDu6U6092C+8W4juyildV0WYIWc1AqStL8ng
 lDoyc0dIFN5tPmsHxf+irhKe67UHmdy80i9IFIcUOcvr5+fXfXuSLAxYTGLIk4kU
 vLBSFV0+sflXgNs7lJfeDdUGkadlIQ7JSeA==
X-ME-Sender: <xms:FQPyabsie4wBcce2GUfL3NzKikGBVsA-62w8Ys75XknoUbEGgW2Aog>
 <xme:FQPyaX4ZnO5h0LyRAkLFG3BweV2O7_HQ1tv8hbQ4HZnUagH2fa_uPwU9Wbkqwvmyy
 Jxc0UVKgx-MUmsOFm2FH7iAmM7e-33KbidiMO2A4hAZgnrFnJU288E>
X-ME-Received: <xmr:FQPyaSQicSM2KXm4a7fkDaQpM-fNI0xICk8s0oy-uV98moNn3uRxo6UUTiuvd9uWgAhmI6YPSzYVGb0rzoIK_gYbtexnodk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghh
 rghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrug
 hsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghl
 sehngihprdgtohhm
X-ME-Proxy: <xmx:FQPyaerHNIgQgUdRRVzntE6Zkbrnuh3S73x9hpM2UCuBIH6j-uYjZA>
 <xmx:FQPyaYLt30TYnggMT1fkMGZrpIeyw7joJL3tsZSNM49P8XKXVHhjDg>
 <xmx:FQPyaZoWNLiFC7sqkcfT-HkOsF1IfXsruMqBkXj1AAhTpFjLan29oQ>
 <xmx:FQPyaYy4idG_qC8ir4DTJUvB47oC9tdR4qv9rdLWEMh0lRYk-h1czQ>
 <xmx:FgPyaXaJ77mr4CW0Dm-y95c3QW3lQX6zBYR3w3ALU6O8eUPkWYUhI-Pa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 09:09:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH] devtools: fix SPDX tag check
Date: Wed, 29 Apr 2026 15:09:35 +0200
Message-ID: <20260429130935.3681177-1-thomas@monjalon.net>
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

If a file has no SPDX tag and is not filtered out by no_license_list,
there will be an error when using its path containing a slash
in the sed command delimited with slashes.

It is fixed by using the pipe character as sed command delimiter.

Fixes: b99a3b8aa989 ("license: standardize SPDX tag")
Cc: stable@dpdk.org

Reported-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 devtools/check-spdx-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 2390941c74..f0fcddf0d3 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -41,7 +41,7 @@ check_spdx() {
     files_without_spdx=$(cat $tmpfile)
     git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
     for file in $files_without_spdx ; do
-	sed -i "/^$file$/d" $tmpfile
+	sed -i "\|^$file$|d" $tmpfile
     done
 
     warnings=$(($warnings + $(wc -l < $tmpfile)))
-- 
2.53.0

