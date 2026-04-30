Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BBFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 13:16:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E323A402A0;
	Thu, 30 Apr 2026 15:16:17 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 2EAC64021F;
 Thu, 30 Apr 2026 15:16:16 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 71C011D00036;
 Thu, 30 Apr 2026 09:16:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 09:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1777554975; x=
 1777641375; bh=1DsQ4ybPW4n0eXJmk2GijxUXyFcj6Tf65VEbCeXsbNk=; b=A
 iXk1OWpgDegJNvjD98mQi1IyipuAjQKev9jK33EqdYl/Kxxj/QfoJ1f5Tv3WGT/U
 5uITQ/sGHMMzUfYwn2OK0yaTqI3hefZSpGCXDY7BnsV2Qnmh8DILnhK74jegy12l
 V/IYVVoid6V7y7HYirsDv27b32NA2Vh38Dupjn/N1ieV30GGlEIUhQtyjW6p1b26
 OQ9alDsH4lh21ZgQ4CMdXi2uoKrKA4irIaqz2zCPhCspyjQkm53jvRk9bjpDzGdD
 M1HFgZCWk6kDrbK6JbL7c1uuuvWYkPpeHlX1odqO9FLhYzswKM+w8UMGKFppzKU4
 Q9zCmUURXKUbJv3MZAiUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1777554975; x=1777641375; bh=1
 DsQ4ybPW4n0eXJmk2GijxUXyFcj6Tf65VEbCeXsbNk=; b=cWwoUKkYeeQzq6veX
 o3BhuZqbHzhVb7GaniSb7Lpu9tlGro7nZaovrgSvsuHI/5M7xlAzCzWS6vEdFDKM
 okwdme9mrghsHpcf6shjlAhT+Dcl3f4Oz5f7BclBjH1bl5oP1VQlxzTB1+OW4iAM
 ZZ+jzYieba0JINWrH+YmrlVNxZIwOTJ6XVXqh73ziEJsNfoEPPVZK3I50UK3r/X8
 tYSLsiFZBDvKz2iFU6KkdwyzlqYZRjKsjj2hxKAsQFJdXWK2AyX4c1eOwx1Svk13
 v/P2Ahp0LJjfvCArt+1gAX1kXwSbUZXfkrAY1qY//skDr4e0vRCMKxh7td3YchAn
 JfMgg==
X-ME-Sender: <xms:Hlbzafn3Db7rchOIAWNBN_U4TYoRhuRu-xuN-hvPCIrAxYiqu3_LoQ>
 <xme:HlbzabykRAQtYgAH_ZS7efE8lzsFx6Er9aMzSTvc_bO33E3xBKVVNlLzK7KBUg3UY
 s2B3fvZ66BYE4Rr-vSwDAu3Ef4227l-xMmb3vvEGIxHW-s_SuQ>
X-ME-Received: <xmr:HlbzaRNUxLiXKKYcjZN8qz8FNx6jV2bMsWbwOqikDz-Y4pc_0ndM2Az0Vbo2J1AwSHTT2kVQXRrsx3U5U4Am7q7Lzk8tRpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghr
 tghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhgrthdrkhhhrghlih
 hliheshhhurgifvghirdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlse
 hngihprdgtohhm
X-ME-Proxy: <xmx:HlbzaXofFgK1y6HeAKAkVWSNRqyQg0aFiURd73ZrLmcjaM_UF9jhpA>
 <xmx:HlbzaaFd7tyjr92NaG6H6sErg8gbAEwryy-Uqu9k0ROmKD88XVsjfA>
 <xmx:HlbzaUrz9Qv5GFZzFcl9MZv0tBptf_kGW6x7m96VZyIPWaC_Tju4rQ>
 <xmx:Hlbzabbh-urwUViyDxqaybarYbCcfGO5fj0iBcGjfzKJ0PTIk7bXcQ>
 <xmx:H1bzaa-K60fEjESNFZhXfZfiE6bAUlR4aCa75PHGfuCPjvP3vq6389qW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 09:16:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2] devtools: fix SPDX tag check
Date: Thu, 30 Apr 2026 15:15:09 +0200
Message-ID: <20260430131600.329636-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429130935.3681177-1-thomas@monjalon.net>
References: <20260429130935.3681177-1-thomas@monjalon.net>
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

It could be fixed by using another character as sed command delimiter.
The chosen fix is to use grep instead of sed.

Fixes: b99a3b8aa989 ("license: standardize SPDX tag")
Cc: stable@dpdk.org

Reported-by: David Marchand <david.marchand@redhat.com>
Suggested-by: Marat Khalili <marat.khalili@huawei.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v1: replace / with |
v2: use grep instead of sed (Marat's suggestion)
---
 devtools/check-spdx-tag.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 2390941c74..41fc1fe01d 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -39,10 +39,8 @@ check_spdx() {
     fi
 
     files_without_spdx=$(cat $tmpfile)
-    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
-    for file in $files_without_spdx ; do
-	sed -i "/^$file$/d" $tmpfile
-    done
+    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list |
+    grep -vF "$files_without_spdx" > $tmpfile
 
     warnings=$(($warnings + $(wc -l < $tmpfile)))
     $quiet || cat $tmpfile
-- 
2.53.0

