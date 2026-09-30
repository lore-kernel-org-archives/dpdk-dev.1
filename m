Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F0FCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E44AC42ED5;
	Thu,  1 Oct 2026 00:44:10 +0200 (CEST)
Received: from mail-pj2-f37.google.com (mail-pj2-f37.google.com
 [74.125.227.165])
 by mails.dpdk.org (Postfix) with ESMTP id C4C5642EBF
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:08 +0200 (CEST)
Received: by mail-pj2-f37.google.com with SMTP id
 98e67ed59e1d1-3a4eda6744bso526580a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808248;
 x=1791413048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iv+Nkh/eE8re6ukWjTx7Nmesnh5iBL47Nj5jvnOgrJs=;
 b=sUoq3QMCkoSDQs3T3vgEb97ESeKNhCuqhXG7ufM9sABHkrcYTUBq8LBDut3Q590pSB
 DwWOtE2ONaZELTFtQHoE12jPlZ/yj41zzj4mKWnQn4GDubfQj2DPXLzPBsuSNgHrxnYe
 R2+jJjJK9DR4Bjm1f+VC9xVBWpAXwHA7eSMKBm9a51k3jiPtKOShENsWhVCz6c992QkP
 OXXqPaGn/ZcTfxBadqwWzjSylCY+3p2VGYcLsaCJQP8+j48tXLGqxBI42pjpNGUs+0lc
 9keQ4CwC8F9x946KIR9ThN0zyLSYEENT8+P1nI7svv4/eGTIFKzwK20/LE2MFFpMDgK8
 W7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808248; x=1791413048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iv+Nkh/eE8re6ukWjTx7Nmesnh5iBL47Nj5jvnOgrJs=;
 b=TW/NtPoKJZ4WAYqgTHYBEI9XEnPM+A29xHPpYajhdK9FhSiziFEghR7Pvj1TV1p+S4
 1sXiCJ2U3O2fzRBBmXQ+8Pl3vlXh/K0dhYFTSXUSVCFxbuVhSg3cO7KVaqXNZaN+F2Gt
 d1ec1eo3xebRJIje/ThNAxkEyhTD4K1mvYakQHYo4RenbT3WtYC4ByIYUFBVwvsAmygZ
 KxhHUaOowst7nI20ERehRtrZKS6R3gny3F3NX9q+UnsTocRt0ZNZSNvY45NjIoSDUExE
 exT4aMxBHPX83knGrq4VCYpouPQUEE8l4YSF4ucb8KXjonmRfGAYgMbOTV4gu+48v768
 imfA==
X-Gm-Message-State: AFq9FYJwczdDgjF/DVjetkFlAEybHxE1VVySM03t42lj+4AyLSziFis4
 BvtdE51z7oNzq8LnnzLEXADi+Vgi8Vj29tKj/5gz3czvXwD3GfEJUbiFYggdsMnhQEjjNMOUuub
 +Hjmg
X-Gm-Gg: AYBFou14yZjgQVwfymDL8GZcBcTQiTriXdBSLXa+V/RgddjavjTFyZrg873FotZvlPO
 O0Ii93jc45fJvnhfkh1jW1FeNQHrnhjoJwCl+FVdUyCozQebeo9ENW3OFtrTdpj+qABi42uE7+G
 EegV2hM5ysAG0KO0cczd0mrJDYM37fyKs3rEpX2LpQgwN2IB5KcAil3J4mfO+oSpUBUZKnZXrTD
 B1ZGleNGc5YEBvJRan+vu1Mgv/MZb26YN3Z3/KRYe7cdk56IQ0Hnr9UGoyKFx0v3A+i3tLZR9YZ
 O8XNyGVMGZaYnlAtojPQw1GP1+oM5V3i2jkr6ITbsEtxMtwBmg0s2KuuZB6V+hWFXpq2l35wt3V
 1OBgxgYAgFXIVyZYo/pNoiqEmsebHr7KTy1xwTUiHzL9Atn64+Yw85we9ihjHLcP99uQo7n2gsb
 Zo9BXfMU2NvDmw0bTkuYCrWFGAYkOZ+5dgxUlTrFp8QS6XfmNa1UGb1hptPqoLeBH+hjlCvrd8r
 ZPtLpJ0kJ2y47UoqybSnyH5VY+wvkPAk9Ubmg==
X-Received: by 2002:a17:90b:4b87:b0:3a4:a229:58b2 with SMTP id
 98e67ed59e1d1-3a4d1784a63mr2488640a91.38.1790808247823; 
 Wed, 30 Sep 2026 15:44:07 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 23/65] net/netvsc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:41 -0700
Message-ID: <20260930224340.58580-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

hn_set_parameter() does not check errno, so an out of range value is
accepted as ULONG_MAX, and the result is stored into 32-bit fields
without any range check.

This also drops support for octal, which base 0 accepted; hexadecimal
still works.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index e4fdf89873..fef532b605 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -202,11 +202,9 @@ eth_dev_vmbus_release(struct rte_eth_dev *eth_dev)
 static int hn_set_parameter(const char *key, const char *value, void *opaque)
 {
 	struct hn_data *hv = opaque;
-	char *endp = NULL;
-	unsigned long v;
+	uint64_t v;
 
-	v = strtoul(value, &endp, 0);
-	if (*value == '\0' || *endp != '\0') {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &v) < 0) {
 		PMD_DRV_LOG(ERR, "invalid parameter %s=%s", key, value);
 		return -EINVAL;
 	}
-- 
2.53.0

