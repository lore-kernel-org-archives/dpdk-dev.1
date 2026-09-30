Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E7CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1121A42F17;
	Thu,  1 Oct 2026 00:44:20 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id B12AD42EE4
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:17 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so2644067a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808257;
 x=1791413057; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYRTEvEe46WC0C+AwHz4YjSYwURJM+70ApF8Le7oqy8=;
 b=yfDm8Yh8Wdl3xq70pKIY+Rv1JNgXuM32kNYbKBj4WqXjTEUEPizsRuQmW8r/Fi3Sbf
 AvEbmO7VGbrq+nqF/8lK31cq6Dzi/4yqbmR816VjwJ45UnPOTE97oKsPhMPzl3xoB3Z5
 rw1az/PWSQG5mYI+caUN++OiLPDLmrw4oiL+BwlNy1NMtlytrwQoB+C0Iy73jY8KU2/z
 7Dy70sPqBOS6Z7aJcGb50hT4mKIzGThsRiKIrRwQN9Xz2TpbmS704NkWDIw7qVuh4ncc
 6ms9/A/os4JJqpI7WNx0m4UNasf6uOzMUd+90HZT7eq8y0CedSSgAlHp62VH1iqxMuj4
 oEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808257; x=1791413057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DYRTEvEe46WC0C+AwHz4YjSYwURJM+70ApF8Le7oqy8=;
 b=n5Poq+91EM5rIVzJSFo9m+cSL7E7UE3hNPWrlMpqQVEAj7QN6hv7IGj46+c0n2yLys
 jyRo4J2fPTIdO0gATOFlVJezKpCKa2HJu99hQZrmPQgrur/mGYRGLBe3qyfIVGlPV04q
 VuecKPV0EhBAmRqTur6foszIFzDhEHHdr2PPHKSwauQxtQzXxeG/PU6xK1y66RAOOHU5
 D/Bheuhwa/FCnfxAZdN4hUj10RyDmDj4FQYw3mSDDplzW0GHccva9Z5zYJulcXq8P94s
 Mj8UgPlkWbLGbmv/yHHiJ/LqBzeqeYfk6znZhpuWVsa0Dk3uJHL9jDexNf+0MXq7ksge
 9F+w==
X-Gm-Message-State: AFq9FYJPIlj4g0ljlKj0q4RkJvqtFt22N7ZWgThiWhsAodCe6W4dMwBU
 8L89uLR9gRKGA2aVTfP9PNraDCRoEqEaOfCjBEpqDmbhPo17Q9XAoWeN6D/LeBmLasU903zPC8w
 h8+lmY1o=
X-Gm-Gg: AYBFou04+GATdKTDT5NEQ+9JCzpMCyNJjvpax6Q5U/G5KALEYF0z3/F3Q6qGr6ZaXu3
 ZhDu0lDPU14X90ziuvANVBJYbmjpQlCc1SumeqZqMA/LpYTdrZNKRJXFmu7xGMAt2kpAO/NNwoR
 iVCuH2+ykk0ag2VHIajFT2ZjYj3mqqSH+A/4RSd2TW7C2ZrZXKIaT50C2/gRU+nP8K890sAO72U
 jtSwJeBbjYzyPKr5Ubkzm7N+LcFh1A26ujIlR4B2cz8fMF2pQk/5Y3YvPM1vbd3ScV0twwROxgr
 a3NCMO+IvNPe9p0MPxSkrzy+Jaopg4h5AAi1Iibj+SSphIxzabzmBPeIUZrM3FzHX+RBI3W0e8g
 E3ouX/jljsY5FhWBpylSSh+MvG2pjogjf9s8vixZKVzySVDR8VXL/EOPPDwKymQXbGcCqEO4E6D
 zvyGECtjW3/pHfbVCdViLHwTKhk8CJfmIfiPNRQPxGbAp+Xa7OyzU3Qud/0jNO1ockd5rfqqnBW
 4hszKMklQ9SIfliq8D6ne7cApRfrGaf0IIxSg==
X-Received: by 2002:a17:90b:3ec7:b0:3a4:b0c4:1c90 with SMTP id
 98e67ed59e1d1-3a4d1b9bcb4mr2303287a91.58.1790808256815; 
 Wed, 30 Sep 2026 15:44:16 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v3 32/65] net/octeon_ep: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:50 -0700
Message-ID: <20260930224340.58580-33-stephen@networkplumber.org>
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

parse_flag() uses atoi(), which cannot report an error, so a malformed
value is silently taken as zero. The result was only ever used as a
boolean, so use rte_kvargs_handle_bool() and drop the local handler.

This also accepts the usual spellings such as "on" and "true" in
addition to 0 and 1.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeon_ep/otx_ep_ethdev.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 85b3c09155..3d6521d084 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -29,21 +29,11 @@ static const struct rte_eth_desc_lim otx_ep_tx_desc_lim = {
 	.nb_align	= OTX_EP_TXD_ALIGN,
 };
 
-static int
-parse_flag(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-
-	*(uint8_t *)extra_args = atoi(value);
-
-	return 0;
-}
-
 static int
 otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_epvf)
 {
 	struct rte_kvargs *kvlist;
-	uint8_t ism_enable = 0;
+	bool ism_enable = false;
 
 	if (devargs == NULL)
 		goto null_devargs;
@@ -52,11 +42,11 @@ otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_device *otx_
 	if (kvlist == NULL)
 		goto exit;
 
-	rte_kvargs_process(kvlist, OTX_ISM_ENABLE, &parse_flag, &ism_enable);
+	rte_kvargs_process_opt(kvlist, OTX_ISM_ENABLE, rte_kvargs_handle_bool, &ism_enable);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
-	otx_epvf->ism_ena = !!ism_enable;
+	otx_epvf->ism_ena = ism_enable;
 
 	return 0;
 
-- 
2.53.0

