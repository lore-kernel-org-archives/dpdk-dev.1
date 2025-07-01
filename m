Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F57C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 14:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0985B402A5;
	Tue,  1 Jul 2025 16:05:25 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 38126402A5
 for <dev@dpdk.org>; Tue,  1 Jul 2025 16:05:24 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a7f46f9bb6so44636471cf.3
 for <dev@dpdk.org>; Tue, 01 Jul 2025 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751378723;
 x=1751983523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxxEsR4cvNOi1940pi9uIfhXxmYL9Kt69ob/MkjwRUI=;
 b=LrL2n5+WL49rvgFz3MRHKNQ1zROaaDvNHZiSJGo6Y2oGWOAyEchbLVVVivWbERYSVO
 6sjUspqhrFaPlkCguvRZPSe61Th1jLEmkN+AtnHCLYKnASEFTJnRTiPw85mgAO9hgCTB
 65Kck15+RFRsySIQzdfzq1X09j/t3s8wMxvfoMmwrjEf/iO2cBpPxXPn8grhuK4IBYmQ
 OsAE/A1IypR+NEvVc5eL8DtpDWSacj5669pXmY05rQ/1hWIGyRuQiFBVOM9MobCSCw2R
 O6ly9hX1lAUGRu5Gq7+R9F+cBgxjLI/IzvNocqi+b2HOJA1sujei0CeE6dXEQ8i9kS+K
 pGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751378723; x=1751983523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxxEsR4cvNOi1940pi9uIfhXxmYL9Kt69ob/MkjwRUI=;
 b=ClK3rYEs1xUVY5iCmBpAjDxvD0AdG2SWDym+ob4nk5uMi2wpAM1fk/mM92P9+UewJx
 D+ATaEiy1FN/DSJ3MmY+uzq6s5zR+VBDtaLhlMOAxLZPzlstqXX0sJiwm4VVXWHdMuAt
 2/NJqZozGz3WLSmnMcow+ocHVX4xYXsPwhZp+qoCpKjh20vAwLATA7orR5VRydoPdLCN
 wEurDp+NmTEjzJLqgX5pkjQeS9RZC2U0Jj2vz5QWBno9Eu8v562S9NVlpeH9V9SqVEXa
 SqzyzIAAMeYM84pXG7ADGeDlKaYZ8JHN3m4IFyMjqr6Qv1r5YlzSt3E3Z8iW/xs99PvB
 1Haw==
X-Gm-Message-State: AOJu0YwxsNwSKEk1Iz67F3CX1rVc6sahVfDF6RQlNAhHcu3UfPO0zgM0
 BkQuXJVsaBQpA6h/JdSK3RIY5IXN8y2/E6Of+iO2SwEsAEAKL4aJZvyuUm7EEOSXBlU=
X-Gm-Gg: ASbGncuxkJUM8UtuC5YYXkmWOPZG5Wla7OvnRjsynVYf9cE0hkayNbPbqmnKjhIKS5p
 eVUR4Pylv3pjDKGdoy/B4C9hLnv5yaQEFsn03mCiMUNZRw1M+R4rwYt9Ik6LpVnorqBbJgk0c4C
 Y9M1jwim13zt/ofTIAQIB7ZmBPf5VLwawfg1QonD/PzW4EHdPTt5uJJdz9kSDfHNkcPg4rVuAXA
 I/YbcJeQE7QCuHjixZ49OaHepiT0WPrpkHk8MuDY67ij1zxkPKUoieZsvPQSh8pIKIXHx9z4YLx
 gzz/wRiryHo77+KQh+G6rVzdxxYD/eYxWv32+mG5Y0J66h7dkvVXrR/dzb+k1xfLaJaPmnGTKsy
 FvDtNhgwnKJI827HCEGlUSsITvqBrFnZAHIJL99LxtKUXpR1hcA==
X-Google-Smtp-Source: AGHT+IFa7cR+I4x83YoXqejbj0IQQQ4+cI28YeTo9hl85c1znZ+M8Wu3fpuylzbEtQGVNbpLGHOHeg==
X-Received: by 2002:a05:622a:181b:b0:4a7:6215:37f5 with SMTP id
 d75a77b69052e-4a7fcb24d8dmr263522491cf.48.1751378723226; 
 Tue, 01 Jul 2025 07:05:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc1586f8sm75732241cf.33.2025.07.01.07.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 07:05:23 -0700 (PDT)
Date: Tue, 1 Jul 2025 07:05:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: Re: [PATCH v7 3/6] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Message-ID: <20250701070519.48e74f09@hermes.local>
In-Reply-To: <20250701042917.3000355-4-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
 <20250701042917.3000355-4-g.singh@nxp.com>
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

On Tue,  1 Jul 2025 09:59:14 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> @@ -62,6 +72,8 @@ rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr);
>  __rte_internal
>  int rte_dpaa2_bpid_info_init(struct rte_mempool *mp);
>  
> +int rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp, struct dpaa2_dpbp_cfg *dpbp_cfg);
> +

This patch series still needs work:
  - new API is not exported
  - new API is not marked external
  - new API needs a test

Ideally, you would figure out how to get same functionality without adding any
new exported API.
