Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E2ACA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4EC142EDD;
	Tue, 29 Sep 2026 18:40:33 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 0421642EAF
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:46 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2784719b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699925;
 x=1791304725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D574+uCnceRAP6vSmKiTiGViZJS779f1qW3F9bdMGlo=;
 b=fTy1wtDm+ZiMNPgWKYNctsdo6s53bM7MXS51FLrm9vfa850EYCbMHP8rgdEX2IV1dO
 OX2aENdJMz6dXmF5VFdseWqrlhbwXWHvak5UOLFA67R73A4s1yetp4bS7rDTBCr06HKX
 jUxbdu6l/uLocCQe4iDQ+5tIUT762+gNbK14weln36WNBGoQSSlLDh9aUKHWymqqFSV0
 H6/XkcSNklsqEP3umTttsE63w8GRxT1gTVW4kQKAs8PsIaq+Bhib2HeaQqd5EBaYBUxA
 wGcyKS7uLhERs0FmgeYHr3Z3Gft2qnk5InOwictgywI5VcoNHZLjx4vJCWPAbCCfG42y
 2Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699925; x=1791304725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D574+uCnceRAP6vSmKiTiGViZJS779f1qW3F9bdMGlo=;
 b=gXooigyjVohA2qvTm0x9dDct3c60jAmokwydQinTEsMydsPwk0lpIGZFfDeyVV7ZPw
 IfxyBxz7CYfvHIxnJnSRQ2k0bB/SeKSorXsaaGqfh/QT24g8iViRFxqNxgEikZSTV+FR
 Q5u/e7qYfyCAemfmMD7GBl0Z7Jvwc5NmYJ0caHdUXMIJdxsML/ZHDUQTTpFX/CNMeTBx
 HYU0ihtrsw5eikEFElF3mgeYvWBkjOB2oeN0BYTEKrnQWwvw1GIhCs+WAggGIAdiGeOy
 lk/sMX9IticfW7tHyd0pxk5HFfoBU5S2WzLTbciBKzBaUhs9BZg6NKvVtNaSTUEb1wnM
 MBFw==
X-Gm-Message-State: AFuF++nv2Md+WKehXEi3rhSRr8oP4VKBO6dugV7C49loDADrT37zJ3PK
 iL0a4zQXSPIKe+0Silt88fakLvk6dbTxVZZtELRNGIcEOB/QsC8a2+4xti4Bw2WOA18xaCOg5s4
 3xf0MJA4=
X-Gm-Gg: AYBFou2wuxLdy2huhuPFYycAE5oWkv4m48YuDPLyFR8lzJMoEzXJ42L0eCO1c2wm+sZ
 3TPl0vqZao4hWt625P7SJYv7VHMeFHZYEeoYIf/bPMAzw1LSENYpzMyllWpJiWw8mlVMD391uiS
 gdX5VGiIRsozSaqRADeR2mHhKYoL2rorqzJjcEj7wI69b2ayX/QgPpTxTAo0m8pia8TkMJxvbWS
 aEjgx14AdkvYiXIGrO6gNFcpNAy4NgUcUWK0blpypk838JHrgnyl6/PxnzLGArQLfRV7ZoBxPEF
 bRSEyJcEB3ngF5bzBb122IDmGN52Mu5R5v6ioI9AzcstV8LHIgpMZYEwIqm/42poXK5K0A0PbzG
 VTFddmJai+DOyuqNzJ6x2uj2AykKsZ5CNepCZN2Vl7yIYwJjPXxZEMnbWsM7tUWzG1L9PvjgbWZ
 ifH9nlemnQhprlc7Ug8EQWA2mgr0I8jnoIJFNkhiMlS7Pn92gpVWt7WbbarLoUWLDTofEZ+yOoA
 LGYTk/QkCz1be4PT2ahNv8PaLDoYQmED3lb8g==
X-Received: by 2002:a05:6a00:13a9:b0:882:956c:58e2 with SMTP id
 d2e1a72fcca58-882956c77b4mr7298677b3a.17.1790699924998; 
 Tue, 29 Sep 2026 09:38:44 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 41/61] net/nfp: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:44 -0700
Message-ID: <20260929163800.1108305-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

nfp_devarg_handle_int() infers overflow from the result being ULONG_MAX
rather than checking errno, so the literal value 18446744073709551615 is
rejected while a genuine overflow of any other value is not detected.

Both users of it parse a boolean, so use rte_kvargs_handle_bool() and
drop the local handler along with the open coded 0/1 check. The
documented "=0" and "=1" forms still work, and the usual spellings such
as "on" and "true" are now accepted as well.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_ethdev.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index 2f7ce812e4..2ad1f12e5b 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -48,28 +48,6 @@ struct nfp_net_init {
 	struct nfp_net_hw_priv *hw_priv;
 };
 
-static int
-nfp_devarg_handle_int(const char *key,
-		const char *value,
-		void *extra_args)
-{
-	char *end_ptr;
-	uint64_t *num = extra_args;
-
-	if (value == NULL)
-		return -EPERM;
-
-	*num = strtoul(value, &end_ptr, 10);
-	if (*num == ULONG_MAX) {
-		PMD_DRV_LOG(ERR, "%s: '%s' is not a valid param.", key, value);
-		return -ERANGE;
-	} else if (value == end_ptr) {
-		return -EPERM;
-	}
-
-	return 0;
-}
-
 static int
 nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 		const char *key_match,
@@ -77,7 +55,6 @@ nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 {
 	int ret;
 	uint32_t count;
-	uint64_t value;
 
 	count = rte_kvargs_count(kvlist, key_match);
 	if (count == 0)
@@ -88,20 +65,11 @@ nfp_devarg_parse_bool_para(struct rte_kvargs *kvlist,
 		return -EINVAL;
 	}
 
-	ret = rte_kvargs_process(kvlist, key_match, &nfp_devarg_handle_int, &value);
+	ret = rte_kvargs_process_opt(kvlist, key_match, rte_kvargs_handle_bool,
+			value_ret);
 	if (ret != 0)
 		return -EINVAL;
 
-	if (value == 1) {
-		*value_ret = true;
-	} else if (value == 0) {
-		*value_ret = false;
-	} else {
-		PMD_DRV_LOG(ERR, "The param does not work, the format is %s=0/1.",
-				key_match);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.53.0

