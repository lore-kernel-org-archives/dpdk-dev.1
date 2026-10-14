Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E2CC6B2C
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 20:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 377FB402A4;
	Wed, 14 Oct 2026 22:16:40 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id EEFD44013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 22:16:38 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 551C97A00FE
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:16:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 14 Oct 2026 16:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1792008998; x=1792095398; bh=PzYQmBAY66iOIU7zlr3H+
 qLExFk2EScDPhf7rEuQzaU=; b=nTtnMQGUrL3CYU59Wf3dq6KyZJMSqbXCOBzpW
 7l54SFT/FQoznEwCZ7wxZXnzkDHpsFTsLZIuWCwV1cz2rCZfJ+pW6/QsqK+fF5rk
 NGwrxlBEXSfHmZBt37axXsSBupKr7iki5fPGzGlGvBE5fZXLmzMyuLiNMJP9gW5h
 MBUqcg6suNVjYDdPuoa67UfWIHWtmRGdbB3vyGNiZbLt5xhlZyYzhy1jjF65pIPX
 2jXzKpn8Ri9ojAqvUSGpPtun2nqmLem2iqmHSbY91PWkhX65eJ8Gww/GPFG4+1Ax
 b0VWhmFFzsepKN1hcZNnDGTe0iOfl8keu40Znw6B8PRhN9ulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792008998; x=1792095398; bh=PzYQmBAY66iOIU7zlr3H+qLExFk2EScDPhf
 7rEuQzaU=; b=Ua5Pv99zloIObjpzuohlhGtuhv2nTvZb7xRAkfSm3LwDB/nqZLu
 1raVVJLdluujn5Iqe8nveZ+AfwAvuJmp6Gtud82Ic1j8vasUao1cXGOoUl+SvL2Q
 ZIPi8kE7XwAvuZQ2mDHGxVDiW5iW0p06BZtogpe821Rjz08YvNQORy+qpO2A67J0
 ptaPBxZcG2ufYQ7uzAeuU7R0aSNyeZxCu+iNnOTdKQFdUOeQbbbbChM5PuO6aRFg
 AEbjOFEnUauiD/ckOIcA1z26I5zc3xtMuZUs291p3ivaRA+dKjgzjwej0Tp+iJVv
 69hA4wvUAf3o3YRI4u/RY+GeiSP/LKeL8Eg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792008998; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:CZ4WL5PYAjjxJTnFHCTARH8sjJQOfCzReAjwnIiOewfMnMj
 ThtJA4GiCIGHSjOQ5LJsau0oASYRMIRB+Ma/o9yKpIlJnVyQt+AU4gf3rlqqf8Ag
 dbtwJRr5PtBSRmUdiXbXghwmtUBKFAy1a4FQ4IvZp1tNuwmGTBnHyCZ4IZ7D5fbz
 2i4xJNic8yPEkAJQW/1CVUF6gCNtTE2q01Witr8tNay+BUiwaYwB9VkJ312PqcYW
 QArP80lEy7grngE1l+0wt3K0ldR49sbA4wiItqBD6/j0aaY9O2kciCodiDYCztRb
 vXhK9eYmfpJGR1Lfq38alr6kmp+w/q478tcHD+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:/oOfA4n8r89IiSdR6s4Cn+B9pILnRECaCHF7c/fqjUY=:v5awn5ij+NBXCyZbtHX/Mvf35IxHBtbixJARlxSyUmE=;
X-ME-Sender: <xms:JePPaqQmDKlJlI5WMEOGvmKZLqylpx6uJnQsoq2B-_M7Zsv0K7CgZA>
 <xme:JePPakG3q1nInEx-Kz1oTu5TchGFva9EtCeGFc5l7QJ8MZPTCOBK444kANblItcJv
 iUCO4bdewYrWMgzciwwxOGnlqvcQa84uBJHskUafwK3_3MHNJllgA>
X-ME-Received: <xmr:JePPam8fQp6qDpcRZZE3TBe4xliqxq9wiX1E2P2b7uxk8cIXtAe0zPWenzsfjIUba-ROZdHMozqanh1ws7gkR7ZHQesh>
X-ME-Proxy-Cause: dmFkZTGm/K2d7EjUeLZTb8XO2A7jPppqidappRbCj92FmkhGpLSixV0fqnt+cN969boWZM
 +hYnWJt45FveTJnAYB0A6YXX3nvtOVbdi8Gab+Qbidtww9+B5/FYJhF3Npz7WyVm24xuIJ
 bz3C42SlFC+3cfFQ/tls1iBO19W2g0zujVPP+0Kx/vYs6ApMYnIYwOw8tgDigjuOMR2EJw
 mtfcRVdNLu9Xfqb5PvXgMxunQuWO16MVyA+LoQXFnqSSAn3jNGehRoQ+rU3YbGLDOTjdtL
 CT86ZqHqZdWf8ZYR5Oazh4XLbWCRCuPZuGZxERuc7jBSZlCd8Q8Cxkk08GLkML3JSh4yD/
 r0x1oJG10cAWRcdQMU8OQmG6GXNsGSEaGqjprCTdnhuhRel4vRGZEVYJRBlU15RdJraAx8
 8B6MpPfiMLw/E1xHVEXuyE/9Z/MTfK131PSCLJ8wZJ9WDwGgweKyXivq9SQGxhP0z3AXiR
 nnLXoYphDBKNxzDR8wBGJ924zNQaGTYe5VZGmUT3uWCWGoz8h3nRjuJAUu4ZH3z/0lF32E
 1+dGPRQwajtMrxlX7Fb6VXgPj2KPTJq9ApJUyE1csPJ15DnfqXbtsXEX3y8A+aOBXS9P6D
 6u8ON1++L2eSm8GQvscGXoYaG95NfWC6txiMiDbfBqCc7FBTG0QD5wXlDKlQ
X-ME-Proxy: <xmx:JuPPauITi7gtV9e27g7Kkjtta5HefIq8bbUEI5PwawbObUGYH9CQew>
 <xmx:JuPPapaL6gvi3uU8JyEGcCP55Lg5sOBT9fQP8ulRt3FA_zjaGN1dkw>
 <xmx:JuPPaoK2WHeL7igzC2Kf4ClkX5qFKj9Xi7fIFHrwWbiYS2foRB2n6w>
 <xmx:JuPPavD89-rtbtaXNlq4Egyngz0v4ZCR_SxjJGBSQrG929Fx3B0EHw>
 <xmx:JuPPapyFaEX5YruUEYkb8x7bK20hGzdgQ2S1Wc3hcqphXJd1S11yVgRd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 16:16:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] eal: enforce internal API check with Clang
Date: Wed, 14 Oct 2026 22:16:27 +0200
Message-ID: <20261014201627.571496-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
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

The __rte_internal macro is intended to prevent calls
to internal API functions unless ALLOW_INTERNAL_API is defined.
Unfortunately the check misses some calls to internal API
when built with GCC or Clang.
Clang can be better to diagnose such cases.

Clang 14 and later support the error attribute
and therefore select it instead of diagnose_if for __rte_internal.
Unlike diagnose_if, the error attribute only rejects
internal API calls that remain after optimization.
Internal API calls can therefore go easily unnoticed,
making internal API checks less strict with recent Clang.

Prefer diagnose_if when available to keep strong Clang diagnostics.
Retain the error attribute as a fallback for GCC.

Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/rte_compat.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/eal/include/rte_compat.h b/lib/eal/include/rte_compat.h
index 97c1540bd0..b62e49d676 100644
--- a/lib/eal/include/rte_compat.h
+++ b/lib/eal/include/rte_compat.h
@@ -32,17 +32,7 @@ __attribute__((section(".text.experimental")))
 #define __has_attribute(x) 0
 #endif
 
-#if !defined ALLOW_INTERNAL_API && __has_attribute(error) /* For GCC */
-
-#ifdef RTE_TOOLCHAIN_MSVC
-#define __rte_internal
-#else
-#define __rte_internal \
-__attribute__((error("Symbol is not public ABI"), \
-section(".text.internal")))
-#endif
-
-#elif !defined ALLOW_INTERNAL_API && __has_attribute(diagnose_if) /* For clang */
+#if !defined ALLOW_INTERNAL_API && __has_attribute(diagnose_if) /* For Clang */
 
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_internal
@@ -55,6 +45,16 @@ section(".text.internal"))) \
 _Pragma("GCC diagnostic pop")
 #endif
 
+#elif !defined ALLOW_INTERNAL_API && __has_attribute(error) /* For GCC */
+
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_internal
+#else
+#define __rte_internal \
+__attribute__((error("Symbol is not public ABI"), \
+section(".text.internal")))
+#endif
+
 #else
 
 #ifdef RTE_TOOLCHAIN_MSVC
-- 
2.55.0

