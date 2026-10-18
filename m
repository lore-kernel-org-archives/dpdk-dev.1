Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7DDCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 01:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97DCD40276;
	Sun, 18 Oct 2026 03:49:44 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 5C1074026D
 for <dev@dpdk.org>; Sun, 18 Oct 2026 03:49:43 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-917c04630c2so13283636d6.3
 for <dev@dpdk.org>; Sat, 17 Oct 2026 18:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792288182; cv=none;
 d=google.com; s=arc-20260327;
 b=qKKcuEcJl+9jbPEYOcs6Tddw7h3xRtr+kHJ0JJojoRm+nUjTUnwQPvuv6H5Wv0C6ez
 BNMz4Bfu8TEhHP61H5AxYt8BBTrcrV2b9XHWh5kQl/u0kMHVE2e6EARSed5oWOm6Rj8b
 nlYx7rqrXxyPC6CjnRvBc151PKIQt+SiUm5CKqbUWI8Itw4mqxDP9VgI9xJhMq/RCDC5
 FbWRIO4WXt0nV4yzUhwQp7i67O8y7TwU9IvQC0VL7RYFmzsinGjpnkZvyL5lf8PgPVeY
 2ndbAME6AavlYcwW6ZLUOBt1ZgCoatnOoID1bQCdc+huTbX8+PxeswO69rdCxWCknfRo
 16Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ONlEL5aD90wqgBPjHrJqn5n3SRl1dVHYyzzTOQKsuII=;
 fh=b35vTgWglEd2pVIcjnL4K+SvjS63/7m2QB3LOI5iV+0=;
 b=WfoLp34h0wBXy2YTQ3LGm6emb0E6yma7sISbBU/p0niLkCjUR+q2If0h3GiPmBe9mn
 iKFCPK0gKpKCJbAZs6yM6n7IFvkCCSznAYsgk/Ty+DGJLNXOU6QLopQU3GMs/rpx3ejD
 NvwHQczGsi0kySXIXU/Ci/2aLJ6Uzdw25gGw/XwOUWFuoKLP/dRut6//YZIHfI6J3ICp
 pnfpht9n4d0oJeRjveyvkQ9Dx9ZQTYfdsuXflGaOHnD26kjDo95F2wdVYKKCXJrijCil
 0z7ZRi5AUAVZ3x1TgazpWbL7Ib4N3nsEYdgl862o5yj2SdRvKMmRZEhx0p9CmNt50X4a
 4WzQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goodkind.io; s=google; t=1792288182; x=1792892982; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ONlEL5aD90wqgBPjHrJqn5n3SRl1dVHYyzzTOQKsuII=;
 b=u6GF7UROhLi1jzi1CrHTTNy0qO9FKIGY4BYwL3JDHpUkVh6Qj8zVwqat4LZ3iBNLx1
 E4hRSym2eav0V1pZilBcx3LmZSFRyWUBJ+WwgGQzGXGvEW4otkm1A2BMNf5W9QsEthW0
 uWWa3Spd6s3QcQGSNkTpT343Zhu9sdTBPYaem9kzhbXwiSNnLbcj+89H4/v8D8CZIPRK
 gDkW5uDFAUetSLdToF7DlwCHBWRR3gUfyPjsSA72roa3/aVcm6J09TIWH4df6pTUNoqP
 189od47TYN8zZl/i4KyRFwEZi7Q/DD13rwxJqXFLfkOw9RtOC2R5sA221qE2gTrDhJo0
 SoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792288182; x=1792892982;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ONlEL5aD90wqgBPjHrJqn5n3SRl1dVHYyzzTOQKsuII=;
 b=Z58Cw7lPen4yUlQPp+p0zU9jVj8NJVnO6eBJ1WnnYEeeLi6xEXOSl65t4aXmkHC10Z
 NZcA69nTtQ9dk9tqZEqMWPQOYTXcX4BcaJsOrYSJ/8c0z3qISbXwGLeRJ+kGpk/yRWWB
 a0Y5Vl83GDwb4y6fEEzr294XsycHfPT/MiH7TD0bxerXdAZHtIXkZtiY3/sOH9GnJLVO
 mRGPYCQGc26kHSrcnTV2tuW0jfAKvn8Ga2HcxzoQmYk9Aa3YhH6/F6qNjk4OjI31ifaD
 XzT9gLuR8hgzkrEipYT+0Mnn23cEFWOj2lsC/HQsE8YPkO80PhUT+aRVUfaaargDVhum
 7Irg==
X-Gm-Message-State: AFq9FYKkJKtNoaa9zzjppSH8OnwZsFfhiEb44EBgKusPrTr4rKOQj2z/
 MckN/1cmQMzkxmXJ9H81KqDRBzAd4Tyk+g8Ijdwk3991ONn/39gpHt2a2HBk0qmGEB2tHaWncvC
 3YarL1AE4X0ezR47koz1GMNjZj4CB/Ncg+KOhPn2RUw==
X-Gm-Gg: AYBFou0C/CiNFP3jAYb4feK3pe4pCU5qpc/k4z5ZV8Ov55qWKjKOxW8CEOJefayD8iW
 YIM0ps3eqxlIQc2rSdBcUVR7Y4ObQsqFS+C2d4GF8iyFnBIHpTGSsHgF9C2KA7Jw2XFoxq/QgDg
 FyO8r8cSM87SNjcKPg+BaHxE3cRH0g5j8xFrV2v6D6/GUdFk0MTG9PaPbPwrSRyQIUM1PRdcyrI
 16YSdz8gAi/kWP2dk6WSvOEx9jqtUJ3rk7GFTDVi/ad2Q4I2GFF5yYmEtYQsLBnNWQAADJnQkWN
 mDMgNDAs/Hfe+zCJ6FMCnSEr+wuuotObbJGNqWpX9uocoR7be+uyDHJI
X-Received: by 2002:a05:6214:44a1:b0:91b:8cdd:90b7 with SMTP id
 6a1803df08f44-91bdf1a085fmr72735276d6.58.1792288182483; Sat, 17 Oct 2026
 18:49:42 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 17 Oct 2026 20:49:41 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 17 Oct 2026 20:48:58 -0500
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 18:42:59 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 18:39:25 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 18:39:07 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 18:37:12 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 20:33:58 -0500
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sun, 18 Oct 2026 03:30:16 +0200
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 21:19:06 -0400
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 18:14:58 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Sat, 17 Oct 2026 20:03:03 -0500
From: Alexander Goodkind <alex@goodkind.io>
Date: Sat, 17 Oct 2026 20:49:41 -0500
X-Gm-Features: AclHuK_Eds8EiEK-2t9_sNmEvGWDojtTyanlnw9ZcdPlcjSYcRQweUaAifnbi7w
Message-ID: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
Subject: [PATCH] net/bnxt: fix aliasing in firmware command writes
To: kishore.padmanabha@broadcom.com, ajit.khaparde@broadcom.com
Cc: dev@dpdk.org, stable@dpdk.org, thomas@monjalon.net, tarick@bedeir.com
Content-Type: text/plain; charset="UTF-8"
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

Use memcpy to copy each firmware command word into a local uint32_t
before writing it to the card. Replace the uint32_t pointer reads in
bnxt_hwrm_send_message() with byte access.

Fixes: 1cd45aeb3270 ("net/bnxt: support Stratus VF device")
Cc: stable@dpdk.org

Signed-off-by: Alexander Goodkind <alex@goodkind.io>
---

VPP could not initialize the interfaces on my PowerEdge XR11 with a
Broadcom BCM57504 card, using SR-IOV virtual functions inside an Ubuntu
LXC container on Proxmox. The debugger showed an empty command header
immediately before the driver wrote it to the card.

The original pointer reads violate GCC's strict-aliasing rule [1].
The patched driver initialized the interfaces and transferred packets
with DPDK 26.03.0 and VPP 26.06-release. Separate build and software
tests passed against the current Broadcom source.

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

 .mailmap                     |  1 +
 drivers/net/bnxt/bnxt_hwrm.c | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 5d1df79860..3143e642b5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,6 +65,7 @@ Alex Zelezniak <alexz@att.com>
 Alexander Bechikov <asb.tyum@gmail.com>
 Alexander Belyakov <abelyako@gmail.com>
 Alexander Chernavin <achernavin@netgate.com>
+Alexander Goodkind <alex@goodkind.io>
 Alexander Guy <alexander@andern.org>
 Alexander Kozyrev <akozyrev@nvidia.com> <akozyrev@mellanox.com>
 Alexander Matushevsky <matua@amazon.com>
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index ab1521953a..573a33b2de 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -483,7 +483,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,
void *msg,
 	unsigned int i;
 	struct input *req = msg;
 	struct output *resp = bp->hwrm_cmd_resp_addr;
-	uint32_t *data = msg;
+	const uint8_t *data = msg;
 	uint8_t *bar;
 	uint8_t *valid;
 	uint16_t max_req_len = bp->max_req_len;
@@ -526,7 +526,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,
void *msg,
 		short_input.req_addr =
 			rte_cpu_to_le_64(bp->hwrm_short_cmd_req_dma_addr);

-		data = (uint32_t *)&short_input;
+		data = (const uint8_t *)&short_input;
 		msg_len = sizeof(short_input);

 		max_req_len = BNXT_HWRM_SHORT_REQ_LEN;
@@ -534,9 +534,12 @@ static int bnxt_hwrm_send_message(struct bnxt
*bp, void *msg,

 	/* Write request msg to hwrm channel */
 	for (i = 0; i < msg_len; i += 4) {
+		uint32_t request_word;
+
 		bar = (uint8_t *)bp->bar0 + bar_offset + i;
-		rte_write32(*data, bar);
-		data++;
+		memcpy(&request_word, data, sizeof(request_word));
+		rte_write32(request_word, bar);
+		data += sizeof(request_word);
 	}

 	/* Zero the rest of the request space */

base-commit: af80aca47b05d46f4a5e1951de3ce8372bd726b6
-- 
2.54.0 (Apple Git-157)
