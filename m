Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FDC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D747F4042F;
	Mon,  6 Jul 2026 15:44:17 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 678C1402E9
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:44:16 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id C5A771D000C3;
 Mon,  6 Jul 2026 09:44:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 09:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783345455;
 x=1783431855; bh=SuG8qq9v4HK0ibkaE5n4mVwkukUdNsZ67re9f78lSME=; b=
 Iptb0/QEG/+RxGR2tm/33xLwB88EtrcWN/XmbFbjWP3QKHxO2Y8+RWw2oVXYi2e8
 pqKuZOMcwo1BrRCjj67fVxW2ehUFID0hr7OO0Oul+avDmnkze2kHFWJRtGA9XWTI
 o39bTkSmyDWd3VSk2yLxxjD5W4rJ8e4U1Brpl3pgFrBWrBnblz4HYUOt5/2ZdkWs
 o1PakY7n4mJld6sOICBJLP951M6UBpBNAnzWeKBSCO89MuJ7u5eVFEDswEUYxPS1
 1J5mWI1FFqPfB9QdbiYkfCTn6To8KOJixguuTHiSZrn0+XdgO/IkaBEdDqoezaDG
 Q4R0/P+lOHYn908ySS3RWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783345455; x=
 1783431855; bh=SuG8qq9v4HK0ibkaE5n4mVwkukUdNsZ67re9f78lSME=; b=o
 B/ntcfGGaS9k5tkQ/n+2VnONJQfTKdk6IcwIz4si94067o6K+HfP+XcY+H+be39U
 uQQ5kVXQ1a/wfsN0Fbk1YfwbGLjJq1wB8RV9d2nFTVIXX2bmh4f9RzqTir/T6W0V
 4PDLGaXm8Du9X9tkgPVFNiz6zmlLATJmtFRc05rFuQ6uHSkJjvykwfMiVDXx9tpE
 QMX5E2klgYkEabNEoe+pu5MraJ5m0PEpqZy9En025b/BbPPUCUdUXNjMfhLWSNJx
 m1X6XCLZ+FLzOS8XxZPynyvAb77Nruj6YdIJGSasjgrdjtA4J7SZygPaqvpMFsUy
 H0xQlTtdypn80nAGftacQ==
X-ME-Sender: <xms:L7FLapHqhEXiQBDnwSUrV0FdFS3tckgPgjf6zT41jhu1Oi39tBehNQ>
 <xme:L7FLaioRmp1mbLRV9cgEjBkyJVrwmHTeWLdwHBFMmo-zzJVz8ZHIN5EX69AeDLzXX
 O0aenOE8t6tSNJ8soGvJODK_BVKRr6KW2e-dt-kf3c31Zc_bkAnPg>
X-ME-Received: <xmr:L7FLaqS9UaBYsOiefBNeGn_GETa7G-a6wg_S6spOuOq9_yff3HT1nOJRgv1790_3TmvPYfRbtu_cMm7kKVtYKBSicQ>
X-ME-Proxy-Cause: dmFkZTFzT2684wXQdmP9cTpp96CY4Duh3jVOhOp08ePRfz7xu7fEFzaYQVdQtlw9+JC8rD
 vgNKdfXUkAEfEXdFb8hA+nVg5AgJ0lx3g6tPktrEmQ1OIkXHMzWM3m41LiTJQcMFu11i+h
 eE8MkzauK5iJT7XdM39jMvpDJ9Z0GcpPw9sR8DAqVCJz4uq+LAYto6qAoxEztRuG9/1vxd
 V5RK0mgz8kNQDGa9mx5/7izMlhQf1Z/7C6T8Tthd9fRgBGoE4XDv+hziosTHet8PoTdT6s
 ZGf6uAbnpxzeiRC07q3YHE4bZJo0GXlz9XMHaEQeER4nqPMHUempIV9FYtPT1uVtfhQtB7
 3Z2B1268+TFSraGS/Hxbbag9AdcTJv0EoxvCZkXxCZ/kEDQDnNHObYyRI4h2peoI5W1uIx
 cR2u/hlNQcv/XRb9u0/WT1Ja8zVNIJwbHDpxHyt4j3xlYjNKlxmC/D9cC5tJMWJ5NgGbqx
 l3DOKhH5t34sdX+rgYrNL8rkopSrzCUk7We+RNXv9JCNlxOgUdP6fnP2geuhmYr+R+s6kM
 xHsFtP2GS6cjfs55E9I2VzyeEaX3XgdBOVBjC0Y5odtT0HHWwDkeWKjlIAET6uWPpaFfAY
 GgMa3JsrD1SacHC2PWZ7MlLtBw3hHXQc6sHiJZvzAotqB5zZg/HrDeCUyYeQ
X-ME-Proxy: <xmx:L7FLanMOMXASByp6z5s1RkiAPyeSgGLq4ax9F6a1UscaT042cfirCg>
 <xmx:L7FLalOBYBheMldrNBlYYIQjmNyU0qTPB7w_yY7yzU93Kl1ggyhiJw>
 <xmx:L7FLavslljCfq0-IDNnIf9GPZQ5KyURctn5m3BB3DiZyj1aD17yJmg>
 <xmx:L7FLanUp060h4jWRE3g1XVoeryqNskdlg8pczwqPAI3b6CUgJHAI9Q>
 <xmx:L7FLao0v5W30Md1dOZp2UfluZQncsJygVOfDA7rbpsyDFOlxMMHMoHfh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:44:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Emma Finn <emma.finn@intel.com>
Cc: Kai Ji <kai.ji@intel.com>, dev@dpdk.org
Subject: Re: [v2] crypto/qat: fix IPsec MB header include for ARM
Date: Mon, 06 Jul 2026 15:44:12 +0200
Message-ID: <pCnVKWLoT86aW9AGGIf2CQ@monjalon.net>
In-Reply-To: <20260706112727.2746447-1-emma.finn@intel.com>
References: <20260630100105.2330637-1-emma.finn@intel.com>
 <20260706112727.2746447-1-emma.finn@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

06/07/2026 13:27, Emma Finn:
> Update the header file to always include the platform-specific
> IPsec MB header. Additionally, guard DOCSIS BPI-related fields
> that depend on IPsec MB so they are not included for ARM build.
> 
> Fixes: 03c475d609eb ("crypto/qat: require IPsec MB for HMAC precomputes")
> 
> Reported-by: Thomas Monjalon <thomas@monjalon.net>
> Signed-off-by: Emma Finn <emma.finn@intel.com>
> ---
> v2:
> * Add guards around DOCSIS BPI

The guards skip some code, leaving some variables unused or unset.
I've fixed them:

--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -102,6 +102,9 @@ qat_bpicipher_preprocess(struct qat_sym_session *ctx,
 #ifndef RTE_ARCH_ARM
                bpi_cipher_ipsec(last_block, dst, iv, last_block_len, ctx->expkey,
                        ctx->mb_mgr, ctx->docsis_key_len);
+#else
+               RTE_SET_USED(dst);
+               RTE_SET_USED(iv);
 #endif
 #endif
 #if RTE_LOG_DP_LEVEL >= RTE_LOG_DEBUG

--- a/drivers/crypto/qat/qat_sym.h
+++ b/drivers/crypto/qat/qat_sym.h
@@ -242,6 +242,9 @@ qat_bpicipher_postprocess(struct qat_sym_session *ctx,
 #ifndef RTE_ARCH_ARM
                bpi_cipher_ipsec(last_block, dst, iv, last_block_len, ctx->expkey,
                        ctx->mb_mgr, ctx->docsis_key_len);
+#else
+               RTE_SET_USED(dst);
+               RTE_SET_USED(iv);
 #endif
 #endif
 #if RTE_LOG_DP_LEVEL >= RTE_LOG_DEBUG

--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -387,7 +387,8 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
        struct rte_crypto_cipher_xform *cipher_xform = NULL;
        enum qat_device_gen qat_dev_gen =
                                internals->qat_dev->qat_dev_gen;
-       int ret, is_wireless = 0;
+       int ret = 0;
+       int is_wireless = 0;
        struct icp_qat_fw_la_bulk_req *req_tmpl = &session->fw_req;
        struct icp_qat_fw_comn_req_hdr *header = &req_tmpl->comn_hdr;

Applied, thanks.


