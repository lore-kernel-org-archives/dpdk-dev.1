Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D650C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 14:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8F0840E45;
	Wed, 28 May 2025 16:32:20 +0200 (CEST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 6351540E41
 for <dev@dpdk.org>; Wed, 28 May 2025 16:32:20 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so777378966b.1
 for <dev@dpdk.org>; Wed, 28 May 2025 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748442740;
 x=1749047540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/z6G+7kmsl6mAFXFo0RlLdfPX2FrE80UMhihvmfG/lU=;
 b=oI+IjlJDW5qDq6+fcUTKpKMVxCBXvnN3Makjh68o5VjwKXOI66+b8/hkFbIgGIitcZ
 EAZjZhaoJ35eZv0HD+mHLMaFt9fr5mAvCYnBtG24EFEe3tQHVm2WEQxHDSU9lqMd72fG
 /smdtwYAUKuvl0TTQueKx6NQ1aOL/HKqhNqYlejlLnJVT1xhzyDukxYFCNbyFvsNRd21
 cTwNGxUWvOb3t0g/pH1VvgZ3rccyQOLF/qtJwoYaE6zp+i0pPrlHyKPV3ONcbiIsLHvG
 jtrDxj8gO0vR2Uunb9Cj1jqAzXgx8fNGuD34fD/6FksXeBrMcHFsrGkv10e55KgloysY
 2tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442740; x=1749047540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/z6G+7kmsl6mAFXFo0RlLdfPX2FrE80UMhihvmfG/lU=;
 b=LQ/KqATItjaOuIaBXCyYs/i+smb3G5zUuBwQ98qeeGe0pSV6OCLOhAJqC3u1NDq2/j
 ZktiwVH0Oj/nGuHIKPQ61ao1jnfFGmBNCpGNMfhUe3/nuaV2PAym2ZhnOtCgXBx4Mmd+
 PFfUzoVrc4ulLYTuM+/P8hjDXxM1d9/SqtKhmhkv7JJ5l2jpZlwwdwcXrFuNvE0U8e9E
 bH2MnvZjVB/rqjPmgCio4OUuTTx7Ft+uPO4FxoTPJs4vpCJaoi0dzprumzeQJqFwgwE/
 Ul7PioYe+wpLwTeEak4SBDmt73kdzE7uo2Fk4mZnNr/nCYoDr5/mIypxuYrnkYLjIGfq
 lDxw==
X-Gm-Message-State: AOJu0Ywt099NBXKI8XWbnR6J4LQck99AjdKzJThmBLzEvHwUMV0LzSqa
 hpi5NyYmzaBbAWtx6SuVKK8/1nVkRLXhAj8g+N1SCY9GC67ee4tJn15zjlCsIhREb3Fi3cc7/Aj
 M3gvJX/s=
X-Gm-Gg: ASbGncvjibXEKNer9yFc9PPST3PL0OJiOPFkkkxqSOriuI9L1I/77eJD3pfYv9UxiMk
 IjRvNVVmBoLwsjxtRpDaD+HdeJe4wmNCU8DDkqp2jCqx+fG4ajJ9Zv5/NcL7xvOFXVDy/WWv2M2
 4EHqPfS3pc2faneesSNshfSAtyqUFm/Kxf7sofXI0hHOWl+NvUiKsHh8dTxmPFQBAmquhIpx+Zc
 Fo7+Bw21NIm7p/WInKvZn/aqKPi9lLo/Ivule3JT8/kAIo58GKhkE20GIFKznmEga98ebytK/sh
 Bt6YNlXVzM7y7nhLmmKA9AQEXWMRBoNtuunGIsOyM+rEvcmNniTZCm4Kw0MxYH3fgfSmx+ElTAM
 DQ09QDNgh4DZ+vQE5PjqNAK/xhXp1
X-Google-Smtp-Source: AGHT+IGsz5PcviYLUF5HgQjFckDmZ71+K8IYlpS3pFtGRG+hpXytzbZCcJTe6Lhniv3dH/tqPZjeaw==
X-Received: by 2002:a17:907:7ba9:b0:ad2:48f4:595c with SMTP id
 a640c23a62f3a-ad85b1df936mr1522591366b.34.1748442739942; 
 Wed, 28 May 2025 07:32:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19c8a45sm115804566b.39.2025.05.28.07.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:32:19 -0700 (PDT)
Date: Wed, 28 May 2025 07:26:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v1 01/10] bus/dpaa: avoid using same structure and variable name
Message-ID: <20250528072649.3f534c55@hermes.local>
In-Reply-To: <20250528115513.1023689-2-vanshika.shukla@nxp.com>
References: <20250528115513.1023689-1-vanshika.shukla@nxp.com>
 <20250528115513.1023689-2-vanshika.shukla@nxp.com>
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

On Wed, 28 May 2025 17:25:04 +0530
vanshika.shukla@nxp.com wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> rte_dpaa_bus was being used as structure and variable name both.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---

That is perfectly ok in C.
Would prefer that you not use rte_ for variable names that are
local to the driver.
