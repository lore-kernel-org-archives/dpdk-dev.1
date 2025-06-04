Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F50C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 20:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DAC4026C;
	Wed,  4 Jun 2025 22:43:32 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5E7C4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 22:43:30 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7cadd46eb07so34254285a.3
 for <dev@dpdk.org>; Wed, 04 Jun 2025 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749069810;
 x=1749674610; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8FHYW0ftw2OIyPtNDg4os5UrKIV55As73Xp34F8SfQ=;
 b=a4eHxjjdqde+fsAIJEVeibjiwsy21IYWOtdlDN1gr2dHZ2eWaR/W1bRb0ve3tlos5r
 WemHksgOeSbDrAw++3vilLZzfqRfl36VX5UlLQMhC4iyaXL7PJQOH1WvCLkZWZuv7vJ0
 8cbBIfGolVIdWaM5FT9m2Rf7XJsnBmf8pNSRxB0cRNdMpkV25MrW6x1qcmsv7qQk0Bgv
 wRdAlitkhFjcfaWDg0aKqVAZe9c5TNSodw90U3j+BM4lpN2sXE0Uz1YWoP1YUKu1ge0B
 9hB6MKEms7AlTK3+FaVhTQ2hKjaGArySUBLIQQVd9hQkSOBDL6GYIwmGyepcKEFd+Zvv
 /6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749069810; x=1749674610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8FHYW0ftw2OIyPtNDg4os5UrKIV55As73Xp34F8SfQ=;
 b=OvOfre6R0d+6dt9+GuTdJbmk/QYU7QZn5iftomfjP594wq/hZcnt3FAhqJAqOIf5q1
 7DqTkvQvq8ltY/AMwQ+rSsSNd/z4tbaipdAYRm+cBjIrPIcgPkyfO0Tvt9BAnPYpF5MC
 2cjJQMFQiLXMuHrpB4Je/2pgciGkRUeo4ea2Fqq51tJ/6v+ooRrtY65rCNNQ/CIK2sWX
 Idnfb/XNBZ980cU8ls6OWRUa1ePOjXIwbMBQuUG+4M93fACiIFOUXBbJUVeZnXoJa4zK
 FFmLaRFi/+NoxQCj8/kHM2SmvNz7mjrtXOpDy97iI3/MEv+c58YL2ooto6PsSayOEwID
 TTig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6HMagmSwXiWVr37rkMYaLgZNYoAmPcyA78jlsdxSA153vdyFp+LH4tclyJE77nBp8bM=@dpdk.org
X-Gm-Message-State: AOJu0YxG7DskSzqCP6jtvvL1cxgEH+vy3ErTWEhWy1OH2gh/2lAYlQXv
 94btd/aRRRkmbcjsgc3Tm7wl+66yTIfYYO8kF0zSxukQAda4aNEUxZuwgLkgs8BBtW4=
X-Gm-Gg: ASbGncudubFrW1DnkUziIASnikkKyY55hb3MDC7d0/NpSTSpBx0RfgvuIT/sJVWNmsi
 KdLX8cDqbIQVUyMjp8A2rhiCOmkZjtK134NzvuO56bmECQ0T61fjdd+zRwXYR2a4o9m3R1QTelc
 64QZfPw4daJODCAIFQGIHB6gndUNq5OyPYg54bDmf5xopW/6uS2AHkypZ8kDthWyi0N200Tpics
 h7HZRJvLl2Uo5ah9UpUUL0Sp4MCakTacBackV5z954d/t3aMIJXPDxPlRFhbjwB45skRRfDcHyv
 ue4XJTSVXyNzcee9MEQ/14KpayJ0O40qzKpG4O2IC3cUuavh5BUNj3apg3d1w2lwUlmQmTbFkrQ
 Mi/wuQJnWO9bsi1k2mLn8bU18wr7j
X-Google-Smtp-Source: AGHT+IFpaJrxuQZNR3VRq11YIRKaMPyMTF+4qSZDP2WqZhb3FIUPLqb7PqmQrbIVNcFsA0c9mvnhVg==
X-Received: by 2002:a05:620a:198a:b0:7c7:70dc:e921 with SMTP id
 af79cd13be357-7d21a8cc5eamr732462785a.36.1749069810112; 
 Wed, 04 Jun 2025 13:43:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a19548dsm1090384085a.67.2025.06.04.13.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:43:29 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:43:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v5 1/4] pci: add non-merged Linux uAPI changes
Message-ID: <20250604134325.2e23f0cf@hermes.local>
In-Reply-To: <20250602223805.816816-2-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-2-wathsala.vithanage@arm.com>
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

On Mon,  2 Jun 2025 22:38:01 +0000
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> This commit is a hack to prevent build failures the next commit in this
> patch series causes due to missing vfio uapi definitions.
> This commit should NEVER BE MERGED.
> Next commit in this patch series depends on additions to vfio uapi that
> enable TPH icotl in the vfio-pci driver in the Linux kernel.
> These additions have not yet been merged into the upstream kernel.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---

The series will not be reviewed or accepted until the kernel
changes are merged upstream and in a kernel release from Linus.
