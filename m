Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B5C43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 04:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D1A0402C5;
	Sat,  4 Jul 2026 06:03:27 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 857D5402BB
 for <dev@dpdk.org>; Sat,  4 Jul 2026 06:03:26 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3804e42ad5fso1357585a91.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783137805;
 x=1783742605; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a9Fpo+THKJ02+QA+bNli1MJG1Ex/dbmD3aiO0hh9ef0=;
 b=A9k+quCVrTQDEFsPA1cy5E+5zMzIhK5L0B211FHsmNI1i1U/hde7DOw9N7e9hpc0QG
 qNSWNAxt/6sHF90ufeEKocfJyJWXljytP+1tNiDePKgfrqLPa1aDdJf6W5UzsyAIZfmA
 y9I46rpbHq4mEU/v47wJ8GARb40hcw35L5wFRlXW2XKvnk8QLirsT8xNtuncOpSroMGe
 p6M1aUSrk32dKFqUZizORNplEf+JERmQN3oXRCK8AIG25+S4OcX68PdrZfQ9deVdne1K
 KFs1KxGQ81L2X3yxYiNUixFdYHbIAehLpzqxBXN7scPjuOAopfmIp3RqxwNa0oUd86ML
 RrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783137805; x=1783742605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9Fpo+THKJ02+QA+bNli1MJG1Ex/dbmD3aiO0hh9ef0=;
 b=NPFBzoLhjOBMaeZuqejHH94C3+HcaOZhzCDpHMYFLozI6/CT19UBMvOoq9KwiPEKyZ
 ENVIlLfejddk70KI4Rv6xpqFmb4zy+1gtxGjfhl3M7zfibhTEovmEfY43hcmD8J7j736
 YaYb/hNOHqjF4hom3pHYTRCLqe/LpXQqXadu/zpg2kcR0IKbWq0YJS/Vu4UFNnhXv6nH
 agJZI0Fl3s39/qKeVN/+y/DrzbMi99DUeXPvxzka/YS0YnURHo5RenQp52c4lcH8kK0B
 yAPGhxS40kN7BGT61dbQIZ7gcDrH1MsZVqP0+ASDznzdn1irkSeIdr2sAZIQdfSci+6H
 CjxA==
X-Gm-Message-State: AOJu0YyX6qQthSH7knvExDMjdC7rm0JPJwgYwkv4f1mRv5TgM+CRNxIt
 dTm8w8IzqYo2e3cFxkAfnS4B+pSnKlQiSkzJrV81AQ2v0/OrMNN9KAArYsXcUapwB6o18+fb8Vz
 tOLpP
X-Gm-Gg: AfdE7cnsu6OIUMTXpnvqXSzAlOv1HzMvt2oqWTUhymv35PHoll2oeAhsSEwpLNYVBtr
 h9Mrdx10epUWeYiROusjctDHeSbjOieasPP7FFR3fCxXhU+7dDqb34hbLPmRN4RQDsDl+/bmuUi
 /MERWlHQARnNCWpeAULm/sEDw4Exqvkx0QF0P5dA2+o+fCq9i5N5pLbVnq+YztbMrv2CTLw5ZwY
 SnOoW1whAHDU5+jxv8LMOhg7cp/vTkZSQY22cBPAKtsv8XcqAgaWxEgdd0f+D9Voe+Ps/aQXmqP
 7PimUbEwpD6yX7HCFeXZoYrZsE3vP8KcdNxv7CCQJ2euKkmCSCwzgSMV6UPs5rcW3j87+4oRF1M
 Bb8/4AAZeZkM6kuy5cs3R9Isi/JmTbXdaRl/YGAiONXZ0dNLwrr+u02PEv9h1hLMJrzOb1OOgQ9
 yeA8/UO9ck/FCq+9Sx+GewjqEcg6YTR/jbUyPNfIce59LDHN9C9t0=
X-Received: by 2002:a17:90b:4c88:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-38280d92182mr2133804a91.14.1783137805336; 
 Fri, 03 Jul 2026 21:03:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb80f5csm39177376eec.15.2026.07.03.21.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 21:03:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH] bpf: fix unitialized warning
Date: Fri,  3 Jul 2026 21:03:22 -0700
Message-ID: <20260704040322.157058-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Coverity complains unitialized use of structure.

Coverity ID: 504611
Fixes: 17509d474226 ("bpf/validate: fix BPF_ADD of pointer to a scalar")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a2..44db85a5a3 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -659,7 +659,7 @@ eval_apply_mask(struct bpf_reg_val *rv, uint64_t mask)
 static void
 eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
-	struct bpf_reg_val rs_buf;
+	struct bpf_reg_val rs_buf = { 0 };
 	struct bpf_reg_val rv;
 
 	if (RTE_BPF_ARG_PTR_TYPE(rs->v.type) != 0) {
-- 
2.53.0

