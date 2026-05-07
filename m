Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F4BCD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 660E440264;
	Tue, 12 May 2026 09:55:50 +0200 (CEST)
Received: from send240.i.mail.ru (send240.i.mail.ru [95.163.59.79])
 by mails.dpdk.org (Postfix) with ESMTP id 9552040265;
 Thu,  7 May 2026 13:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=ASjw3wiEDYBlJkJu0Mdhpi3qS97qW4kco424lmLFVRI=; t=1778152861; x=1778242861; 
 b=WwKIhcbNcvMm8cc4OGYul2hk33UJbej2Dpmf0hD+NVB7yNMAUC6ock+4yXs937gI7yx6rFSikiF
 xS5sUhez7+EuPhOZ1mNPn+fZ2s3B2CLm34f1jE694byej1SVRrHPFcHwgbvrHvy/rKBEbpeegmcrr
 X8tRsdzQIOyjl3a3b7n8gUIxtEvKcfgwKA0+NJQJ1zShKQpSJ2uSMQCN7BFEvvZiX541VNIVhKcyP
 EfYV23A/uptbM81HZu49II1r/RTTaRPb141aeHoeZxJlPqBcJCLb4gXT4iBpUvPK7KZXiNOPfwVZQ
 qQz7MXmFWd3wanFIbfR3WsTePC1lerxTrSuA==;
Received: by exim-smtp-747dbf5d84-qsgnt with esmtpa (envelope-from
 <lyulin.2003@mail.ru>)
 id 1wKwmp-00000000JCK-3nLC; Thu, 07 May 2026 14:21:00 +0300
From: Denis Lyulin <lyulin.2003@mail.ru>
To: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, adrien.mazarguil@6wind.com,
 Denis Lyulin <lyulin.2003@mail.ru>
Subject: [PATCH] ethdev: fix pointer check in GENEVE and RAW flow copy
Date: Thu,  7 May 2026 14:20:11 +0300
Message-Id: <20260507112012.119140-1-lyulin.2003@mail.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-747dbf5d84-qsgnt;
 auth=pass smtp.auth=lyulin.2003@mail.ru
 smtp.mailfrom=lyulin.2003@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9E2BE57020DCD98B8F23123D779142E8FD0F4EFF2B36BC1DF00894C459B0CD1B90607EBE39CD5B1BC8E7FD94675F335650F80A99C02BD79876466AB78BE28DF14A5D819213F947FA3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566652D4FC31077615B463679F6C871426F89F722617F7464B58C7D6F1C316525DA8EEF46B7454FC60B9742502CCDD46D0DEDCF5861DED71B2F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0E8801E8C4F941C018941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B669875440691429F6CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C224938BCB7A7EE7F5AC876E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8BCD5F9A9B9176DD283AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493D58E677C372A3F475E1C53F199C2BB95B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5B561E7A9265492C95002B1117B3ED6964950A3875B21D0C030C8F815570A3530823CB91A9FED034534781492E4B8EEAD730E4C6AD5E1DBB9C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659C56BCD98A8D50099B7B116AFB5020D9EF1096C3B8F3B89B8C962C280BFA228DE241171A31B0E6443B8341EE9D5BE9A0AABCD7B84F1127A8C8F3285DF9A5A6363851575AAB936ED57546A885F7A58241B4C41F94D744909CE5DDE6AB186FA14AA15C35E0BAFFE8D415811D22EBD454E4C3FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtibdRUtyPADYbfsKXrkNfZg==
X-Mailru-Sender: C0FC423AA8FD9F6963CC77E2AC28C4C9ECBB09D3ACA340F7B951B70A5BD4BD8E2211378C884CB6C86F332C5845F46A74CFB1E98417576B9F6EFAE8183A2EAE0DD521319575DF8831E3C55DE776B662A175379CF7CCB93CA93DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

When rte_flow_conv_item_spec() is called from rte_flow_conv_pattern(),
the spec, last and mask pointers are checked separately. If the API
is used incorrectly, the spec pointer may be NULL while last and mask
may be valid pointers.

In rte_flow_conv_item_spec() for GENVE_OPT and RAW item types the spec
pointer is used even if the function is called to copy last or mask.
It may cause a NULL pointer (spec) dereference.

This commit adds extra check of item->spec and if it is NULL, does not
copy further data relying on it

Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
Cc: michaelba@nvidia.com
Cc: adrien.mazarguil@6wind.com
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
---
 lib/ethdev/rte_flow.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index fe8f43caff..7cf585e6f5 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -672,13 +672,17 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 			   }),
 			   size > sizeof(*dst.raw) ? sizeof(*dst.raw) : size);
 		off = sizeof(*dst.raw);
-		if (type == RTE_FLOW_CONV_ITEM_SPEC ||
-		    (type == RTE_FLOW_CONV_ITEM_MASK &&
-		     ((spec.raw->length & mask.raw->length) >=
-		      (last.raw->length & mask.raw->length))))
-			tmp = spec.raw->length & mask.raw->length;
-		else
-			tmp = last.raw->length & mask.raw->length;
+		if (spec.raw && last.raw) {
+			if (type == RTE_FLOW_CONV_ITEM_SPEC ||
+			    (type == RTE_FLOW_CONV_ITEM_MASK &&
+			     ((spec.raw->length & mask.raw->length) >=
+			      (last.raw->length & mask.raw->length))))
+				tmp = spec.raw->length & mask.raw->length;
+			else
+				tmp = last.raw->length & mask.raw->length;
+		} else {
+			tmp = 0;
+		}
 		if (tmp) {
 			off = RTE_ALIGN_CEIL(off, sizeof(*dst.raw->pattern));
 			if (size >= off + tmp) {
@@ -696,8 +700,8 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 		spec.geneve_opt = item->spec;
 		src.geneve_opt = data;
 		dst.geneve_opt = buf;
-		tmp = spec.geneve_opt->option_len << 2;
-		if (size > 0 && src.geneve_opt->data) {
+		tmp = spec.geneve_opt ? (spec.geneve_opt->option_len << 2) : 0;
+		if (size > 0 && tmp > 0 && src.geneve_opt->data) {
 			deep_src = (void *)((uintptr_t)(dst.geneve_opt + 1));
 			dst.geneve_opt->data = rte_memcpy(deep_src,
 							  src.geneve_opt->data,
-- 
2.34.1

