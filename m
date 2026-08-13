Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BBC5AD5A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 01:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3505D40298;
	Thu, 13 Aug 2026 03:34:11 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7DCE24026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 03:34:09 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso10719775ad.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786584848;
 x=1787189648; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wJiWlH30nrKlRDOL3/1GZKoTOit1rAwbiXkmMh2429E=;
 b=iS3iP98H8JpLchc2bcY7Qu6YpmtUQwHCYMSs9vojNsiZWbI8IPH/pk+/Fbsei11PIs
 WyCnF7AHgRQJDmboDP7CnMQrizlZ9c4qM8yygblY1gDHxdyZAn9zshWANcNBTg4+Rhjp
 F5nFvtvurT9emowJUW3GDs1zF/8yZLrDM/SS+yBwwkoPwpzk9dk/fUOq6QwUqh7n4iPA
 NGglvn/uRV4byEU4FgPM/2JqIrnxSpsoZAMp85kIEen/frO+HP3F1RA33QCRwbs5NUXx
 V7Y7CpDgKtCc9SN37kCjCSIDcViSX+I2pwcD8/cnuz+HcPbRjoQu2oZWzOik3+f/nbkM
 DcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786584848; x=1787189648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wJiWlH30nrKlRDOL3/1GZKoTOit1rAwbiXkmMh2429E=;
 b=VfB4mPYdL5FyAGREFeplkUt57toRvJ9bGkga4mVe6xA+F3O0HiEFjCXrI0Diux4H2b
 TJjxLBRSY2z5tOwelQLFiW5+0vNPLt+7qHYjsCoagIqoCV8s1rfVL5qS208RQ/IZ8cw9
 1HD9Xx0cdlqVAPtoJKfdpY0elgz+l3fqzpvurtiHArnvYUCTxAqZnxGYB1YvB77nmyrK
 4PZ0OQl9ZgmsAAbEsJ4LL7RjJ7k1oBy4TpJexHcm2/5uK3bh+8rkhTQC856MuCKmkq9+
 n4hEGn8VlzoqKUxEJXG3UEh/13MNYY756eDz+vaSrxFsOcHSESSbHn8hZZcwXyywCpCG
 PrHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RplPSSoQBLW6O8C9u+xA+3McOkmJF0TikslJ79a4mQCSmIRf+N0ppG+ewiy8fK8lAny/vE=@dpdk.org
X-Gm-Message-State: AOJu0Yyaze2rXIchx++0rZo1VkjMkHeU0ZgoPRXnipvC1/6ZrtpNofky
 azj5jMXsmM1ke4Ey5WxTNmaGs9cm7DlsdZKIb2JQ8ie4ae/XgoXMf25BQlsOKt59/50=
X-Gm-Gg: AR+sD12Wbkx1MCmeoGQs+CEBGZtZ5Z5QaTw9V5EAmBPwTU13myd13JequXdr03twW52
 m17oJjoJEKbhwoAnkwI/+N6uwYAAnVBG9OdL9sdzH4B5pwxgOqhgIDmbzcywFf6bsUOXJBWHwc0
 2UVEijvD3PSFaiNjy45cldkmqJww8S2EjlI1vsU5Xs0ltmDGEU5oSZwsqvIe9f6fB7NafDOV5Sz
 5evdxBMCsDB0zDNQC8n1xfUV6cNZsvzj2Xgw8sK8sL2wOfYrP/TPq0b/QhscnGglmHcdNSA1yiC
 tgPbueejFKYzWfHNmMP4AbF1/g0y4NvNLG9pwqPb2Ca4cJckQwvTGbgJDbxNlHJnvttiNsShhul
 4mdtAkAZ1HCHBOzQX/5pAfZUUGCfhy0Ch5oLpwmc/i3Ur/qAd1mbga5XSGhp9Y4jmpRFjwDd240
 lqJhj7glyJiFaJAkPDNnIDDMEA0s0tyIaHCp+VX+wYT2KMvfr8dH+XxkG6EJr/6NqXSJucybDiV
 PkTxnUzM3HiGPnLG7p60vz7Ho7U6A==
X-Received: by 2002:a17:90b:5784:b0:380:873:49cb with SMTP id
 98e67ed59e1d1-3931e2ba41bmr2774389a91.21.1786584848401; 
 Wed, 12 Aug 2026 18:34:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412da7d3cfsm2854007c88.15.2026.08.12.18.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 18:34:08 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:33:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v9 24/25] drivers: add dpaax destructor to gate EAL
 memory frees
Message-ID: <20260812183359.252e2b6e@phoenix.local>
In-Reply-To: <20260812174609.1100111-26-hemant.agrawal@nxp.com>
References: <20260811115731.3421032-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-1-hemant.agrawal@nxp.com>
 <20260812174609.1100111-26-hemant.agrawal@nxp.com>
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

On Wed, 12 Aug 2026 23:16:08 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> +/* Allocator stuff, make sure the eal memory pool is available when calling.*/
> +#define kmalloc(sz, _t) ((void)(_t), rte_malloc(NULL, sz, 0))
> +#define kzalloc(sz, _t) ((void)(_t), rte_zmalloc(NULL, sz, 0))
>  #define vmalloc(sz)	rte_malloc(NULL, sz, 0)
> -#define kfree(p)	rte_free(p)
> +
> +#define kfree(p) \
> +({ \
> +	if (!is_dpaax_in_destructor()) \
> +		rte_free(p); \
> +	else \
> +		pr_debug("Eal memory has been destroyed.\n"); \
> +})

Leaking memory is not a good fix for broken code.

 
+/*
+ * Track whether the process is executing DPDK destructors. During
+ * teardown the EAL memory subsystem may already be gone, so freeing
+ * EAL memory from a DPAAx destructor is unsafe. Drivers mark the
+ * destructor context via dpaax_enter_destructor() so that kfree()
+ * (see compat.h) can skip rte_free() in that window.
+ */
+static int s_dpaax_in_destructor;
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_enter_destructor)
+void dpaax_enter_destructor(void)
+{
+	s_dpaax_in_destructor = 1;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(is_dpaax_in_destructor)
+int is_dpaax_in_destructor(void)
+{
+	return s_dpaax_in_destructor;
+}

This is not thread safe
