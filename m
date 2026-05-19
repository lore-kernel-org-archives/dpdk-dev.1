Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5048CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BE1C40296;
	Tue, 19 May 2026 13:23:50 +0200 (CEST)
Received: from send242.i.mail.ru (send242.i.mail.ru [95.163.59.81])
 by mails.dpdk.org (Postfix) with ESMTP id F19FB4021E;
 Tue, 19 May 2026 09:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=49YBBxaGmphvgpwfsOfxhf1EupwWZTnHQOUlAiP7hEo=; t=1779175476; x=1779265476; 
 b=jl34EWKboVArg5wfX/Gm7K08mmC7lTLdoCsFRUxweN8AddFQpk6TnCK6p33kVAzJJs3wlKfrBFS
 vgLKO1pN3HoEOZYZRdUBAIGAlyBKEmMt8llLxP6J/2SBNDlN61laxZfy3rCs4OBj9gAX0+jGyz5ju
 I/aaNb9/nGSHF7vCAQ8/tYiFKgOICZR5mX7DPcZ0OhbZQS0o/X582LtUfgttGXZ90p1cO7Ua3GXvB
 SAVNlku7Wrkeb8Nftw89/YrtKxMlhsA+/k+VGyNr417MJf5cHZtp62WJfOXrFC4NvqdKj12PsVExw
 OkWuLrU3N2qFTtp3WWBj8BjPZXg1ZCsiwCqg==;
Received: by exim-smtp-7f87666bdf-q2m5r with esmtpa (envelope-from
 <lyulin.2003@mail.ru>)
 id 1wPEod-00000000JuT-1ZSJ; Tue, 19 May 2026 10:24:35 +0300
From: Denis Lyulin <lyulin.2003@mail.ru>
To: stephen@networkplumber.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Michael Baum <michaelba@nvidia.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org, stable@dpdk.org, lyulin.2003@mail.ru,
 adrien.mazarguil@6wind.com
Subject: [PATCH v2] ethdev: fix pointer check in GENEVE and RAW flow copy
Date: Tue, 19 May 2026 10:23:35 +0300
Message-Id: <20260519072335.16601-1-lyulin.2003@mail.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-7f87666bdf-q2m5r;
 auth=pass smtp.auth=lyulin.2003@mail.ru
 smtp.mailfrom=lyulin.2003@mail.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9EA22463D89EA19FF3A6DCFA4AE1896F6AE4036971BC3E451182A05F5380850404C228DA9ACA6FE27F195088306247C763DE06ABAFEAF6705E63A2508A331311162AA06E85E88963C88EE2A1A7F2CFE66
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2BC914B83EBB6BBD21D7A433FE9E21F81865A9FDC9ABEAA7E286D51C3BB96DD0900C819B32DFABC24A725E5C173C3A84C3CA5A41EBD8A3A0199FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FC26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B47272755C61AA17BA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCDD05361B700AE1BB3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F7900637E63F877465845756D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637F9425D8FA97DB4396D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006373A3D321D30E70233EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A574B8D71273AFA7F15002B1117B3ED696F3D3CD98E8C2163072305013E4AE841E3610D81D389A125CDE35189EBF2DEA281E618B5D5F965AFD68BB0711B762D62EB2D1C9E48B6DC60AE2A7E19323554B12787CBDA4B9FA07ACC7AFFFE36AC0058D4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6590DEDFD76944E0F92A47D15C56F91BEA7712365AA9AEE41988FCA8346DE67268B22BEBFA311BDDBACB8341EE9D5BE9A0A524196A687E4864BC8D306461BFA9258E15807E7C7EC1F1F52EE4E5D9E54FDA427302E973F6434ABEBD40BFDFB13F5F6F04D340E6049F1E406B106A8FD94427783DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEthEGB4bvUvwT9CndupHZBtQ==
X-Mailru-Sender: C0FC423AA8FD9F6963CC77E2AC28C4C9B56AB62530BD7959B951B70A5BD4BD8E0BC1EEB0647BB1471C83562A50431E28CFB1E98417576B9F6EFAE8183A2EAE0DD521319575DF8831E3C55DE776B662A175379CF7CCB93CA93DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailman-Approved-At: Tue, 19 May 2026 13:23:49 +0200
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
may be valid pointers. Also call of rte_flow_conv() with
RTE_FLOW_CONV_OP_ITEM_MASK and item->spec == NULL may lead to the
same problem.

In rte_flow_conv_item_spec() for GENVE_OPT and RAW item types the spec
pointer is used even if the function is called to copy last or mask.
It may cause a NULL pointer (spec) dereference.

This commit adds extra check of item->spec and if it is NULL, does not
copy further data relying on it

Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
Cc: michaelba@nvidia.com
Cc: adrien.mazarguil@6wind.com
Cc: stephen@networkplumber.org
Cc: stable@dpdk.org

Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
---
 lib/ethdev/rte_flow.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index fe8f43caff..7a51b667cf 100644
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
+		if (type == RTE_FLOW_CONV_ITEM_SPEC && spec.raw)
 			tmp = spec.raw->length & mask.raw->length;
-		else
+		else if (type == RTE_FLOW_CONV_ITEM_MASK && spec.raw && last.raw &&
+			 ((spec.raw->length & mask.raw->length) >=
+			  (last.raw->length & mask.raw->length)))
+			tmp = spec.raw->length & mask.raw->length;
+		else if (last.raw)
 			tmp = last.raw->length & mask.raw->length;
+		else
+			tmp = 0;
+
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

