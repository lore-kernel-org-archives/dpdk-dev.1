Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB8CD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 20:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4558040697;
	Mon,  8 Jun 2026 22:33:30 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 34F5B40678
 for <dev@dpdk.org>; Mon,  8 Jun 2026 22:33:29 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-307631dbfedso10469079eec.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780950808;
 x=1781555608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH1iYpVscFEkPpzI7mL8vZaJfY7JSyafPz6h6mkExcY=;
 b=am/ga/uW9aN61nPybR/pj+eewMVVe5REnRZ/8LbMqZa4acJZO5aXg7/BJ/WE6LUVj+
 JbB5BOx9AMnoIahImhKQws5je8yLYIvSLFOvT0pjpvhE/uSmcpfn+Q55gYkKbEWNmf9U
 2PDfnu8F6FaQGAENyj6SLd6PSLNdwe3yv9b5A1O5PhMXMXS9ANunRc/YU3n6t/KG7u0u
 OhMMf61nQV9Jv6JQ6KecvwytZpmtS35qaQhZc6YFGh7gycs/myGgyCGjFCzyUH5Ks4Ff
 HC1P8iK1eKk1a+GVOqmO4gXnpbE8oTEg0DYGuT9LMqFAvu8PtENBhDpaa39aHZURh1A1
 H7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780950808; x=1781555608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OH1iYpVscFEkPpzI7mL8vZaJfY7JSyafPz6h6mkExcY=;
 b=JPlQAKN5tGjJPPbVKqQkiRTsfNdXSWlqokji8oa9bWJLfLjWian6eUb/EzQJLxgkWH
 mtfSB9fvswRcNrJc/ClC4ylePY2a+o/yKfF1JdrgpvZgHGTXYVLXUNNCIr0NRMoKyWPE
 gxlPFToHqs4pfTQZ3vUKDGGO+HUDblDc0DmMHu07+JLyMBKfvFksacOaCkR80ozGfOwH
 EwUH0a/iDHtCAEt0E+jTC10dVv8Te444q35eZK2avqxi5JyiCGWd4jO/KQFJx0lKumLx
 koZDX71vpAIR0YS96cYNcy22RvLPGqMmmTmwP8OgiZbDSkPeDcWRF36WPr0y49002t2D
 peiQ==
X-Gm-Message-State: AOJu0Yxe30W9G7HywmWjwmUbVuTLI3mJwE+XnSNe3F31YElIpBGhOPuo
 5frhWgBp+8JN0ASyeH2urt2kox9l21QWbE87Ixit+odmZVslvcNEffB9D5UFvM/kw9zbVlUAY/g
 uqkLU
X-Gm-Gg: Acq92OHVovezUU0BlmnKZwtb3VsNdZTBLa+T52ZhVYVxdb/gMg+Z1qTkxpbQdPmdYY1
 7jkGqoVXZ1UC03PrZ+Jp/kQEhYbquwJ0OsGzzev+xGxNU6ogsXQ/O5U5yk7KR9PIqEsanFB/LnY
 1WS6LODG6HFCTwSXfx84e0IE5f35YG+aZ+eFovdEY0ensYLgEbiQUFCzzssEKXWTcxrmG8PRCsf
 +lScWrmOzpqrua9t6OqHwJDchh1ySB14M93wAMG2x4EtY5lheo1dKJh5rqZ/UTfRYSfNIV5V09R
 tR3ReOsmkRxB+1zB+XIDR5sac1CeEKD7e+Z99H2mlXpv2c4RhZgsanbqTPgRCLQyaR1EVs+WKHH
 2HBcK4Amj+ajaVwIMbRnsm3NrD/w0qouNNAsnR6WNcYXuUiweJksfQ30T5p1WxZHFn9xZIew02k
 75kZL8dqiSBMeqJF4jeVP+W8CkloHETTuHGeXfs+I1NKaBMx9ehugpfn9OOSNjSomoOldsJjtQ
X-Received: by 2002:a05:7300:2311:b0:306:f474:7389 with SMTP id
 5a478bee46e88-3077b721426mr8524332eec.25.1780950808195; 
 Mon, 08 Jun 2026 13:33:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm25804178eec.5.2026.06.08.13.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 13:33:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 3/4] test: bpf check that bpf_convert can be JIT'd
Date: Mon,  8 Jun 2026 13:28:49 -0700
Message-ID: <20260608203322.1116296-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608203322.1116296-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
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

Add followup in bpf conversion tests to make sure resulting
code was also run through JIT.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 79d547dc82..f5ab447ff6 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4569,6 +4569,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 	struct bpf_program fcode;
 	struct rte_bpf_prm *prm = NULL;
 	struct rte_bpf *bpf = NULL;
+	int ret = -1;
 
 	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
 		printf("%s@%d: pcap_compile('%s') failed: %s;\n",
@@ -4592,6 +4593,18 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 			__func__, __LINE__, rte_errno, strerror(rte_errno));
 		goto error;
 	}
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
+	{
+		struct rte_bpf_jit jit;
+
+		rte_bpf_get_jit(bpf, &jit);
+		if (jit.func == NULL) {
+			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
+			goto error;
+		}
+	}
+#endif
+	ret = 0;
 
 error:
 	if (bpf)
@@ -4603,7 +4616,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
 
 	rte_free(prm);
 	pcap_freecode(&fcode);
-	return (bpf == NULL) ? -1 : 0;
+	return ret;
 }
 
 static int
-- 
2.53.0

