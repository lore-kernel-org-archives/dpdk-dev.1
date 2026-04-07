Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907CFB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EB32402E3;
	Tue,  7 Apr 2026 05:52:22 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 8A3C1402B6
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:18 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-127380532eeso2679370c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533938;
 x=1776138738; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSIwLhfRDrpyOLBE8Pj8Pu9oHVF1+m6eJ/Vf/76VF9Y=;
 b=R0pmskhH/tzdFJMZKs6ePLDomEPdTsjor2vMiF8mY9zawVvYlqBHs1HQkIJQvpgA+/
 5OVMRthhvFpzNSd4cZZJNwQdrjP4aUbhMdzDgKkG05P95aYeUTHnMjvXSQCK8x3GmfX2
 P+S1PC/8PBeOzLmPUPdiPF8BSjtrQXLBGgioD2IQ0E0NkHvpuSoN3PQP08I4akiB5llP
 jqDa2wPc8n5jVEVZusAxuAtQJxmoNWlIaj9/e3OqoXeEGOqKikmA+8Lug3QSFr/K64Ka
 RtfNaZTIKSfAfDFAlcwjuMH3fLo+fAp6Rq+tj5xYud6t0y77vwicflqLzB+IfWbLIC3W
 iSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533938; x=1776138738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSIwLhfRDrpyOLBE8Pj8Pu9oHVF1+m6eJ/Vf/76VF9Y=;
 b=Zv0x2jzsHzzZCMyhqFNxhZDhmJz57v0DDcV2kd3zMzDd3s+bEgJEFEm0ZMBYFfunn/
 1j+ibRGNcaXZDdqJ0VI68P0IXvH25UD6Ix4pUOC86A3m6ok99LNqCE3rlDozBVeVeBjn
 1IphNRUgMamEEx6brXPINbk31vTZp9dYPGXUPfsXmugpmyjtjSKLY14tmSLIIG0K/MlD
 H5tMsibOipDo66N+qhVpRqVkEehIMC/Mx8d5bHEpw+xjA0O/RgcCHLW4djlhAWNqxjat
 eaDgbK8oetE2WTSARHm376wpXun7dOkvPNYbt4bzpUuTSKqLShJrXqLn0feJcCvKuQRe
 mBxQ==
X-Gm-Message-State: AOJu0YwzmtIuLXh8qIuR96nSlIXR/xrx2JWZ8c/t22I5S3MWMWJ449F2
 aTvSfLAyMfGohgvOIwBMOGeakd07qN+PfyaeH/ZsMV3dEVSiL6ESesgVrNUsHH+2TKi8BXGU7GF
 7O5+b
X-Gm-Gg: AeBDievIuXUa310flEtRmsJv+X6eqz4dOCgI+sakj1GgvT37eqxCaYdnCSWx+hXJWMk
 7JJ7gcZjVRN0YJ860ra9mWUnACeX8QFAicZWLserDZVKBpti9C3yd2QsQeYbzbpE+8Mp4NF0gFC
 1KsJG+6PPkBgBORDSKnVfrneLS++634v3iYC8d8JnFw6KIidOmflLq6JUt2UNGKkKEBIQt+Lko1
 OG48dTdtUJ4JZhzFKDNi1KDj6VCeYYod8knETlaT3PDM7YKI+dTsB8cccOAHDiToSpRyCnWVWBS
 a0qn/nMpkDXzfPq4MISDgOU6zYaB+O5Zgxwjr5HaSvZk7gBe6ehMsa8lK2dGBetQu1AZpoyk1fu
 NCsc8E+XnG2WEtC0TekOFnWpwpxvQ5jIQvoedRpi0OYZJCptT0yjCCF0jRZ2bybw/4K61Xyv1xy
 wH3idZIlTC0No3xKOckpY9ZjwzF7QKNIZW
X-Received: by 2002:a05:7023:b0c:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-12bfb700f5emr7740293c88.13.1775533937639; 
 Mon, 06 Apr 2026 20:52:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/23] examples/vmdq: fix shadow variable warning
Date: Mon,  6 Apr 2026 20:49:32 -0700
Message-ID: <20260407035209.650419-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Rename parameter of get_eth_conf to avoid conflicting
with global variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vmdq/main.c      | 8 ++++----
 examples/vmdq/meson.build | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 12ef5bffc2..8c9d885090 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -135,19 +135,19 @@ static struct rte_ether_addr vmdq_ports_eth_addr[RTE_MAX_ETHPORTS];
 
  /* Building correct configuration for vdmq. 8< */
 static inline int
-get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_pools)
+get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t max_pools)
 {
 	struct rte_eth_vmdq_rx_conf conf;
 	unsigned i;
 
-	conf.nb_queue_pools = (enum rte_eth_nb_pools)num_pools;
-	conf.nb_pool_maps = num_pools;
+	conf.nb_queue_pools = (enum rte_eth_nb_pools)max_pools;
+	conf.nb_pool_maps = max_pools;
 	conf.enable_default_pool = 0;
 	conf.default_pool = 0; /* set explicit value, even if not used */
 
 	for (i = 0; i < conf.nb_pool_maps; i++) {
 		conf.pool_map[i].vlan_id = vlan_tags[i];
-		conf.pool_map[i].pools = (1UL << (i % num_pools));
+		conf.pool_map[i].pools = (1UL << (i % max_pools));
 	}
 
 	*eth_conf = vmdq_conf_default;
diff --git a/examples/vmdq/meson.build b/examples/vmdq/meson.build
index 6fcde9815c..441678bbe5 100644
--- a/examples/vmdq/meson.build
+++ b/examples/vmdq/meson.build
@@ -10,4 +10,3 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

