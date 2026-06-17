Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA1B40670;
	Wed, 17 Jun 2026 17:58:03 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 88B1140674
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:58:01 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304f590dd91so6797328eec.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781711881;
 x=1782316681; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiB/J9/7IK4UTDg3iAkkSXKyMtdCUPsyyxNMKGsMAHE=;
 b=NcEF6Pck9KN7xn5Ku2xumLIzkHmx462Ih79nn5V7Yi97B8NzdvogH5QJ1MD80PmnF2
 hJEFBQrCE2CPX3WFZ9APMSX9onfQW4qST8WgC1uCzJV6hnb91PuomRmldAxP8rpZLHG4
 BFbR+p4YkZRXjK/g0Z6oXSyesYa0k82Q1XzChJOJZUCXsaDzgNAaaOYhgx4cctBn9toX
 BimG+xNQsOSZUExu290dEmW8f1ggbcyKApSyqhnS0HTwPK4b2B7GxBvHAvrEVudZtTIi
 bh/Hh++c3catMjqJJBPjI17oQNvFu+4Sl8lDPQXUQCGnvA9lvTp9SMkCvf5ctJZOWiI0
 jU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711881; x=1782316681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yiB/J9/7IK4UTDg3iAkkSXKyMtdCUPsyyxNMKGsMAHE=;
 b=PUnRFiszw1M348RcFKh19lXNsvN1fFMbP+TfF6ejOGHkiudGoKSup2wYg480gYymgI
 zqyD91gnZA62VipowlXT/J3qSi2OICSzSmMdz00JHwZJLMfP1qx7Fkh1W8oJaGna9UtI
 FdcDnTOadsTXVFILVSDtP1dwK5F65x+jVOEdyCINPxaQQRU+RDIMDPsbvmrYFEY1QGqa
 a+MQuLS8UIoyi43KE9mcuNK3v32bwiadXLda4jzJKgFl2OvdoNntZ8WxyQuyT5HJV8nB
 Rth2Bj3oPFQaMBWaMo+8BGKmDaAj82d8NZVKaGS19PT+pmiSCoh20NJVW32S70h7qKYn
 9bjQ==
X-Gm-Message-State: AOJu0Ywrp0r948gfAMd5IMZp+WvJ3u94squ5HW+CesqVS+z83qharJIK
 +wktsNhkxsDdugjQC+XITcsrwNRavxJI6DnlroAc06+hLqGT2IDQEC7l63AGiuZ7B2k=
X-Gm-Gg: AfdE7clgPtAzvqyiN3JesS5/WAPGwjEdEWCqlZZvOmQG9PqQuFVfYZUKIau0bShi0TZ
 4rjByllemH/6W3diCWtmyMfURuH3ZKJGS9Par8VkYK84xhzLbVvDMQ1Uak49MREgc7HvV+V53G/
 dXlnXT9eaUALR7MMjUfHT+7MOeqyEDHnpvfzWWVyuVQtORFUfnKQ3EVG/gpssaKS/y9fCr/q+6I
 BBCvWWAL9dTVGUe2PomlY8mwilXsEIgHXRL1EOvfKSXnXLVOjfTybFFvgjyTeq8M0UNv78gFqmd
 LQ8dToHlQoOixp28FfSTVkDhZrBab03rVZ5nK5qyfIndaQLkFmFit9sSLtTVICoTdJYfq6EoK/6
 vCTkrEMicVK7fCPnyw44OqrUH+f/+sEjIi0jtNZtt0S0x5Y4EE0wuHeH4SyN2s1y64ytXpHWDos
 iEypHsGC0XO4kirQz3cNGxiLjTFk/30h1i5nnVBLU4R/ts2n++KPy2XA==
X-Received: by 2002:a05:7301:2a2f:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30bca0ec3ebmr2535572eec.35.1781711880636; 
 Wed, 17 Jun 2026 08:58:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30be0c45a16sm1647648eec.14.2026.06.17.08.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:58:00 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:53:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
Message-ID: <20260617085355.0a87d7ee@phoenix.local>
In-Reply-To: <20260617081309.19124-13-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-13-zaiyuwang@trustnetic.com>
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

On Wed, 17 Jun 2026 16:12:59 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> +void
> +set_fields_e56(unsigned int *src_data, unsigned int bit_high,
> +	       unsigned int bit_low, unsigned int set_value)
> +{

Function could be static here?

> +#define CL74_KRTR_TRAINNING_TIMEOUT	6000	/* 3000ms c74 trainning timeout */
> +#define AN_TRAINNING_MODE		0	/* 0: not dis an 1: dis an */

Checkpatch thinks this is a spelling error did you mean "training"

Another typo here.

WARNING: [TYPO_SPELLING] 'sequeence' may be misspelled - perhaps 'sequence'?
#  drivers/net/txgbe/base/txgbe_e56_bp.c:2465:
+  	/* 19. rxs calibration and adaotation sequeence */

