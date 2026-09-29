Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A346CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6803B42EC7;
	Tue, 29 Sep 2026 18:38:49 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id D26E742E1C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:28 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc78d59bb02so1662948a12.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699908;
 x=1791304708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iv+Nkh/eE8re6ukWjTx7Nmesnh5iBL47Nj5jvnOgrJs=;
 b=wGgqbjEebjRRffgcYwSoj8sZpIsyBCKrjlauCO3vekYk+b4kmJugtcz/C9cQxKzDbU
 7vCaNawHIfHKTnjFV403C5F1Iq3DZURAOS3Vohqph53+EBWoLDsl9bsg3LUM+oRDC+0x
 x/WiwW4Lyxh/Tr03lbWIYAPhmo/dY7xUY8zVjTUWpJRkBx16VsuaJHc9KcsQarAkOuQP
 mzR77QeBTiDwV/1Cpo2qXKVTnU8mbUvyjXAguIdWP6wP9K+E5pgFT6jrS5x2QNYOGZD/
 KV5vsSn+wlspixavhGbze9VEmbiQw8EXfCtDVkgUXm5Z6X7/vcUFTILQeaUM/b3z3vxu
 C0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699908; x=1791304708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Iv+Nkh/eE8re6ukWjTx7Nmesnh5iBL47Nj5jvnOgrJs=;
 b=Gre/GZk5KbnEn7mY9BC3qcMz04eq0yl1VvA7dh7M1K3oCGSQbUyuVGAuk4GUbuUaoz
 EGx54b/NOqfXKpyMJIaykw/vUvLXnXuKlXw9zdU7h47xSuLG8+qYL+oSzE7mPqKB/tbG
 GrWx5LIJtIXj3QyrwU/j3HFPOQy8DQyt99ilHj+WUjOTgBrmbQD3xmh/Rf3k0hJQ+hob
 81I1g17Efu9RQrK4fp8/n55EVcrV97NxrUjbwY/pnBbVSZz4mw31os0cHnT8xSW1Tme6
 /Iv5/GHZhs4FA4LWGUM/5eDjYRzV9ZBmoKaA3BKPWDjLUVuMiqSo/VtsgMuk8AlPwtxc
 vyNg==
X-Gm-Message-State: AFuF++lGO9MWa71AgiyAQZnLQNFWtRCCYlp0EmA674FwWI9VQk7qbeaE
 K8YmrHSJEYK4KADxKd0gTFWH5EJbMjEvThbLsIzNl/DFiu+HG2GRBpzWQW/PjBNBsamkL/SyP3h
 tWKvN7GU=
X-Gm-Gg: AYBFou24sctQoe2GMXZgr0rfdfpeWRFvJXDp0E+pjuvA41gF6xj13IbwQFonTLL2Sej
 JsJh1xvIbASX1tNbG0uF3DMXRZ7kfvab6dWjF50+6UNusbfBQXxd0urUaNOfwIfZzyq1y8TGQ2c
 4SuAyId8v8/jwFW1O024HGMcSslFpIALRKH8PGx9VO9tjfgsi78YmY/6clQlpDSiddjHOet7x59
 Yqwmkbjxj+XBOPi8aUQtdggg7dcj//xjvRlEXFACJNOuexprjo1hTsT1LC46OEIxFqM2PaX9pCd
 EzO0RNtV3K6MkrJmBKHohPq6UR+Fk9XQtGD9x1SWtFII7yQZjxKYIItausYbc7k7unkggLKnKmk
 75f/98VdeEr9bfb4Fskc27wFILuhp0U3+X1Af5klqhixleD1VaxludKu0BSLchKKnBjDfs3heEW
 VHlbW9C/LbKbtAZKkjk4/BPoj0H/3xFvCuZhZufUBmQwzZ3Q2v2MT/oZ7B1vSLMXCEKB0TUwIj3
 fUKRH7BEYeXeXfop7rbcrol8byOyuwo+O5HRw==
X-Received: by 2002:a05:6a20:eec8:20b0:3de:8825:15b with SMTP id
 adf61e73a8af0-3de88250292mr1145441637.12.1790699908027; 
 Tue, 29 Sep 2026 09:38:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 22/61] net/netvsc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:25 -0700
Message-ID: <20260929163800.1108305-23-stephen@networkplumber.org>
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

