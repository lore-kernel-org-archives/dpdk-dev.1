Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8FC982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 16:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E526E42E82;
	Fri, 16 Jan 2026 17:46:01 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 5BCB342E52
 for <dev@dpdk.org>; Fri, 16 Jan 2026 17:46:00 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso20271745e9.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768581960;
 x=1769186760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZBTKeBXRVGBjMCtpMEHDcv572VKd23KCkkf/xE2k2M=;
 b=gT6JZCZp9Azu6sHO0zhK1ZOrcqNt9dRaGjYNMJl+VAVm6KnIOVfcn1kl5XIn306Snl
 qwOh50/42V06E/kyVRjyBwM0fQREU0UeXdBMgQjizRx/EjZ+5wEiiK8oYu6PoQrkLNdF
 htdmjztjNZMmiyKqJFsWa6aVZXusLaHE+HVJssEQm/Rn6Y7tz4KjvZw4PqZvrx+6kuYJ
 qaqD9OLZK/hHV8fXjED+JtC1lrSEynumbmpfyR0eRLtMR+1zfCBlTrzjW1CVh7NDHN40
 YQP6LqPOC0/6ChgqzlSjUkhOaTC043nJ/zTwqL6yYocmW1zOxmehShJXIVmyJqtrKFm4
 wwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768581960; x=1769186760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZBTKeBXRVGBjMCtpMEHDcv572VKd23KCkkf/xE2k2M=;
 b=AGOQQhuSrkOe39sCTxfCi0kVYMN9xnPAa86xmaIMXu/Voe/BDYCGeN1/bxHZ6dJv1V
 ygRADt0+N6VpuoVc5Yfi1VR2rbTXkyyxuziCmTjM85XjeMJaU67UQXuXRvp97qbsDbPK
 w/D2JVr87umO25+QpLA40J3OKlWhsZ8OpLZZcVd7MXYvj91O2fHBwnJkeADNOEU8lVi/
 +DLTbUR0uYm+4x7TCegXaZ/bhbiShKFBQJxQavFx9cHNLBHHVoInHZDVcS2/hSF2KZuo
 cF9CJ2AtWJ604mYsb0WknttDWP2D0chvaxXn6K3gvSAKcVDJxvWsHke9XUudwluTDY+7
 er5w==
X-Gm-Message-State: AOJu0YxmQgpiUd8hB7fw2B364NOk89In/oqN7Qpzs+Ha0sut4ImPE+2y
 WlbBMuEbArr4gUDK9EarIN7/GLBtXgzogzy+pcYO+db4Sj801einP43XlmMSuFD+tNhhPg8JzcY
 1wggC
X-Gm-Gg: AY/fxX5nGCGXvkJWptDTlMyBeLXRsSJp+OOsUkzowBJ7MOqif934iRwyxmVqW21T2hF
 fATUZuyZyA4NzMPx3c4eHqA9C42xZw8BWSZGKmDl5em7B2ECxbEK7ML6V51gqk5VWf0ySu8t8Of
 e9yJF+aLejtatP8H9OPtDT+8su2wnQSg+A7B1htH4W5KhoRuf65aBfcSMDSDHlt6Ht8ex+bYWzE
 E9ej8y17pFZqhzWWrAdSwu7YPMFCzNSXu+2Aq/wuDiTCEp7EUx1PKKOkafmlPLRDUQMTl0U3/uY
 8tFDak6nxMnxH5sr7GbWZopcrjh6Mx/z0mK8KK4Wa89NtyvbosiCxtrKrokg4xzwLScTrnGun2e
 LM+SHDY1nf6TWGghBphKet0q+SM/nkTg+ni6ny8ba+rhlX8u3Lrdumi0g4cgx39Z/dh4ixpXWjW
 IjHjY0M3nlALaB/bQ53d/ByYjrcJgctRezLA2hGJoDkqRXqWMDV2Pr
X-Received: by 2002:a05:600c:310c:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-4801eaadcc0mr37254945e9.7.1768581958957; 
 Fri, 16 Jan 2026 08:45:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm106852075e9.12.2026.01.16.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 08:45:58 -0800 (PST)
Date: Fri, 16 Jan 2026 08:45:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: coolwilled <coolwilled@gmail.com>
Cc: dev@dpdk.org, users@dpdk.org
Subject: Re: Bug: crypto_snow3g failed in Auth snow3g + Cipher snow3g
Message-ID: <20260116084553.681355b0@phoenix.local>
In-Reply-To: <CAL2ZP-A=cnXozqacMbDUKd15KgHifSmBjqNDN+o340yJ+3t99w@mail.gmail.com>
References: <CAL2ZP-A=cnXozqacMbDUKd15KgHifSmBjqNDN+o340yJ+3t99w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 16 Jan 2026 18:45:15 +0800
coolwilled <coolwilled@gmail.com> wrote:

> Hi,
> I run "pdcp_autotest"  with --vdev=crypto_snow3g in app/dpdk-test in dpdk
> v25.11.
> When i = 42 in run_test_for_one_know_vec() in test_pdcp.c,
> It is PDCP control plane Auth snow3g gen + Cipher sonw3g enc,
> the case failed because the last 4 bytes is cleared in
> last for() loop in line 167 in  process_snow3g_cipher_op() in pmd_snow3g.c .
> 
> It can be fixed with following change:
> 
> diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> index b3c3b05a8a..45a8be5fc8 100644
> --- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
> +++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
> @@ -157,7 +157,7 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp, struct
> rte_crypto_op **ops,
>         for (i = 0; i < num_ops; i++) {
>                 if ((session->op == IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
>                         session->op == IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
> -                               ops[i]->sym->m_dst != NULL) {
> +                               ops[i]->sym->m_dst != NULL &&
> ops[i]->sym->m_dst != ops[i]->sym->m_src) {
>                         digest_appended[i] =
>                                 snow3g_digest_appended_in_src(ops[i]);
>                         /* Clear unencrypted digest from

Please turn this into a patch and use the process described in DPDK
contribution documentation.
