Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC75CCF2C7
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 02:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F05402E5;
	Sun, 18 Oct 2026 04:29:32 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 08CC340276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 04:29:32 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso2622371eec.1
 for <dev@dpdk.org>; Sat, 17 Oct 2026 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goodkind.io; s=google; t=1792290571; x=1792895371; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVAinbJUjML8/TyamT8ADXVzRf4PTVRtmy7NKAOKIMU=;
 b=nd/vH2A2vYOLDDSiMQfHxqEXQgpjY+n/ZesOFMPX1KxZokx4ZW2zvXB/6aXzrhcNLy
 xVP9kTSFT40NjgFk8V9nt6Uk+KpX81WN4XEIb+/W8ZFu8oe7jMPVQR/MPhPife730qbY
 Ji4AtiGCVzgslQ2kc4m3eRkANw37hrNQ5OJCgXZGPJqTDGeBhTXPcZP4166XVQfTNr0v
 FgrkCute6reHix7SosjiOnMltMuRJAiwDoDGrWuPp1+EV2YU5+3K1PV+lhqZ6+OaX+gv
 ueEg5zura/qLIHf+uhWeyH4UdjIl+vyudQwxNQOpEzDPrRtmf4mWhGTCDTAQZQmm91qQ
 +1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792290571; x=1792895371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xVAinbJUjML8/TyamT8ADXVzRf4PTVRtmy7NKAOKIMU=;
 b=mRI1mnBW6qbAzErNxZwvqTxuEd3wnfolj6Np4HcHbWp6EEszn+AFZhn5KTZtnzjdWk
 Tsas47nTCbkticlhOZqeIpdepNqCn4nGxFF2LWekqPsLYabo0gVhGOeoeVc5i1c6ZqpJ
 6hT/Sxj8shMUecraZ3Au5p2w1V7oOtfZeKZXARPcu81zh6AgZiBIR5RPircV4nA9GR3i
 tPKyxB77l8fUF+U73MrxodWvF7ptbKtSr5CYa377SKfErue6yPf6XU3Xq9Imfq68v+S4
 IZg+QShIeOkBNzBwWznjqyenduJfZZ+G2Rv0Myr6zc46GB+2zR/DFL6zCwbSU0L2uXT1
 mmQg==
X-Gm-Message-State: AFq9FYIRG8Jc/cdWjqx6lFGyHeKt4Vqn79IQ5oRPdNarzPnSZQsdG9EH
 sKO8qjNIVH8Dv8VFljnXzUf38CoHHIgupCkDTZfnX4VjahdRVNYZgT+qR5g3sJuIcU0=
X-Gm-Gg: AYBFou0PvOGonKLKVjamJfMPSTM9vy24LLcS3gwgXdiPp5bAkSylV+cXesWGlk2GE6e
 7KZ6gvlIjjzMJDu17PWEhS3ZwFUrRojTm59qf29ATyrsv+4PJwm8ecdFQHZXVrq/6A+9YG62dJY
 u0fgExXhoh98VS18/ObfFjKRhTdGcv2AtMxkzvm9VxTkYpJLr8UANamSOPqea8BljF5iNxz9yev
 FlNCPrH6My55/W8mjokNY1i91skSy4lRFvtbM9/fcGcSyyBh6d2vOTuz/1p1yAqh8rmRAe5s/W5
 uKgTDisPGevkAtRIpnxsfy3nktRbuXVz2qw7XzTeA4Bqr1Zvq9a+pnMNjiJ9eVFv9c0Q0Ebdstt
 UqTQBTdwIeAb1cCPj0rV+SYyHSwZUWhG7p9J7i/Dlf+U629xwI4vGmN46nieRo1EPjNwpzON/t9
 1xtcjeHVsv6/410Q+RN8vNJVH4jnvWR1w5Ub2b2DVormPCGsY9+3kD03kjyBFj6g5NfTnHut34s
 jN1jX5kag45hDk=
X-Received: by 2002:a05:7300:10d:b0:35b:c271:df19 with SMTP id
 5a478bee46e88-361a2d37bc2mr5771538eec.32.1792290570588; 
 Sat, 17 Oct 2026 19:29:30 -0700 (PDT)
Received: from localhost ([2001:5a8:4296:4f00:a1c6:b570:cfa:f332])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-36082a7b33bsm36084130eec.24.2026.10.17.19.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 19:29:30 -0700 (PDT)
From: Alexander Goodkind <alex@goodkind.io>
To: kishore.padmanabha@broadcom.com,
	ajit.khaparde@broadcom.com
Cc: dev@dpdk.org,
	stable@dpdk.org,
	thomas@monjalon.net,
	tarick@bedeir.com
Subject: [PATCH v2] net/bnxt: fix aliasing in firmware command writes
Date: Sat, 17 Oct 2026 19:29:29 -0700
Message-ID: <20261018022929.91865-1-alex@goodkind.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
References: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
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

Use memcpy to copy each firmware command word into a local uint32_t
before writing it to the card. Replace the uint32_t pointer reads in
bnxt_hwrm_send_message() with byte access.

Fixes: 1cd45aeb3270 ("net/bnxt: support Stratus VF device")
Cc: stable@dpdk.org

Signed-off-by: Alexander Goodkind <alex@goodkind.io>
---

v2: The previous patch got corrupted during email delivery.

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
@@ -483,7 +483,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 	unsigned int i;
 	struct input *req = msg;
 	struct output *resp = bp->hwrm_cmd_resp_addr;
-	uint32_t *data = msg;
+	const uint8_t *data = msg;
 	uint8_t *bar;
 	uint8_t *valid;
 	uint16_t max_req_len = bp->max_req_len;
@@ -526,7 +526,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 		short_input.req_addr =
 			rte_cpu_to_le_64(bp->hwrm_short_cmd_req_dma_addr);
 
-		data = (uint32_t *)&short_input;
+		data = (const uint8_t *)&short_input;
 		msg_len = sizeof(short_input);
 
 		max_req_len = BNXT_HWRM_SHORT_REQ_LEN;
@@ -534,9 +534,12 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 
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

