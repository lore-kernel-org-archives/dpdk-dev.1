Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4409C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F4D740647;
	Fri, 20 Feb 2026 18:06:26 +0100 (CET)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by mails.dpdk.org (Postfix) with ESMTP id 3E6C14026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:22 +0100 (CET)
Received: by mail-qt1-f195.google.com with SMTP id
 d75a77b69052e-506aa685d62so12494261cf.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607181;
 x=1772211981; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=ZI9+rtNetNwJU3JR/2ygaXMHD13kt+DkgRz3+54Wpc+L7RC4Ag2DxmOhnGHRmIv3+/
 gPdQ/hoSxJlTDUbFKI1JCtZdFiCuk1zcIS5zKjIzekNOFsWN31bq0ac5JX80RLFepJ4S
 W7+dBBRkRigJNHq8+q7M9VvoMY3oaTrklae2aQ71TlaIQiPJigRWV/+Ji3X0VlkZAhwz
 z+8X3dr9zguBpqwNwqL7dVID20A5rlmEMKUtf8cE9mJS04xJUQcliyN3RfaFx6zzrQak
 aWAhpmGUiizlVdCzsq4VeZTqE+V/gNlDEEcnpm7Kiz7hewCOb0uPWwYOOXKj0l8N8FAB
 ztqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607181; x=1772211981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=RuGreTInPs8Zn5pfIWHRS3gxZvZFEhJuL3U01KYqq7M5b/UtkmYnKAud2/vO4dWtCl
 Y92cbUujuHkk2e3tHC13sKa75PP8ZEmecXtTLxWjRIviU2Eu7duu9ZX5T9qZLcNC5YtA
 t6itxKmUm9hy9Qp24IMAVnHuKX039KZ/zLL2/9jyREKuIY7eBYXEJ+Yjdk7b9EyXJFCZ
 x/ahQTUpB+25NH3Dfjzz5jlQ4OWHvNDF6e459JO2W+dhPrONPxMF/G464snNtgQZpL/C
 c26CSm96YyDLfpOtjYgn2i+Y8Vo8EBbCLh/pXPKnuJ9zioRnqUoG6gCRLTuhTGrSfhfe
 uawQ==
X-Gm-Message-State: AOJu0Yyuf7qtVM9mYse7FflBTgjB9U/Evtl41jsTgD3nH+Uxq6S1LsjK
 YL6+J+PGLWg9qAiY/sJlUpJNSvZigrbluLkBdcBBtk+TJL6OVUMmMnBGtYEkCmVGxhLQarOi75Q
 Bhhww8pw=
X-Gm-Gg: AZuq6aL8WLxGJssneAMOL7Iii5WdprM4HDg7f4m85AmNVe3bQWgHv+5Fdkxpp8bA30q
 fLT0KD6ylENCaPUKUO7xyGEdG88Iozv12UAXi02F6hJAMu7Fp7MYw9Kw1xrFXlE+IiqV34P8rl2
 2DjKCNG2xZHQmwxOZS/JZ3aQqVcuqMvgdgij7Z7sYyhmrKFOJdVbbUBgyZkvxzPPcp8dNR+myc/
 UqbaknjmJ+70F00iHHt+7YZlOmNv350KMZuzBhqMiFmOOhOcju+CX3O7Bj+s3PzPOlGEGy8hpT2
 rKR4HQurAgwAtkyV2IU5SDbR/R4V4mo+aemvOXE1EoPMSLkaM4DUd3Gt90fA7FOEElJ4CsVwJIR
 PlDTFskp5f3rsoy2w47UgupKK/FL8YctIdotIWwQ+77UqSpczFe95x7/1xvt19ajAmNn3xmRwQb
 ZhKEfTpVc9OxVcfseKbzHgSB/UOBBev4g42WFph28MxNLvxjmYREuFjEgB049v7U3I1mpEeLZh
X-Received: by 2002:a05:622a:9:b0:4f1:ac12:b01c with SMTP id
 d75a77b69052e-5070bba05f1mr7965981cf.3.1771607181253; 
 Fri, 20 Feb 2026 09:06:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 02/10] net/tap: clarify TUN/TAP flag assignment
Date: Fri, 20 Feb 2026 09:02:02 -0800
Message-ID: <20260220170614.75560-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

Add parentheses in the ternary expression that relied on operator
precedence between '?:' and '|'. No functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index aa236cf967..e06e1ca079 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -155,7 +155,8 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * to check if a received packet has been truncated.
 	 */
 	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
-		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;
+		IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);
+
 	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
-- 
2.51.0

