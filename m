Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E29CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 983E740613;
	Tue, 11 Nov 2025 15:32:57 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6862D4060F
 for <dev@dpdk.org>; Tue, 11 Nov 2025 15:32:55 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-29568d93e87so38096185ad.2
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762871574;
 x=1763476374; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ry2gwy/HTl9c3fTQLd2Yrzmcil/ihz4+X1mcy5A+Vk=;
 b=POU2PgfQ2HGduCPW8a+Bojbo+HPgOkoU+qSrXBxXrpS3lqa3XjXzjQVeqN0Og6P9qM
 vVZb6rnUonv4AIQlNQ7xz9sjd6iIxyXx3fh8ax6PWditArB4aBu0AbQjOHSogolAZJXU
 GzBcuYzyo52xpcnb00cajSILDm+WDuqDG5qbar93ZfgvjKLRXmqNqMCcTW4UkQVImajQ
 FHrbZE03PXxuegtb19FLC6nMaRMSsGpWo9mG/ZBWoiIlvOaYea4roOfZEwa1r47ZBPfG
 HMFVfoh08Z/Yq7mglgmR3yROTSIQkYEV0fvrqfJIx/iBf4PfHHBsm+xTEVZFOe2jC3zy
 gppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762871574; x=1763476374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Ry2gwy/HTl9c3fTQLd2Yrzmcil/ihz4+X1mcy5A+Vk=;
 b=sJ3I0MrldNSoM+zoMOVNMGH/kdoqVBKypZ0wN/pEdNhe3rx833tGJ4kK5ALhyBRRJf
 0KTc9X1NzB2qwV+C3DEb24o6E0Vx3vDkaT0AMOSZDlwiqI+LfKtC2fMIyaaXmFND1J5O
 SBnnzsZzgXG2tYiRLmM703XUQ71ldA2JIVW32niTykOQpMpNo2MTw+le1h1CtJJjUgDV
 dKp1k/vbpRSurP/jqXC2H4atK1Dqgco2C9WVPCSWhBklSSirHn0xx2tRZUmLK5jULwy2
 igPVw6A4DqN7hsT4Y87cbcTSnqwImz8lapz+59tAuLR3VMfIyvN0mM6xoybFPeWRTJpT
 FY1w==
X-Gm-Message-State: AOJu0Yw9HuV36R2HGEydZUrjKygOvm/qL1iojONZc9s4aNUku99sd03s
 2QVC/RFrtbAW+BCPPlASiLCVj+TuCLkOCdHzFi+OFlGjr5jPJKU6tP7tyXSlqsAOToQ=
X-Gm-Gg: ASbGncuVo8JZzFij5x0yovTMDEAj1s2CKRY9KGkpfsl2roFuJpLgoR8KakS2/b91zHb
 5ByPy4V4V2ra3LdUElMxY95Ec/53q1oUPf/UOnABxGpTEwKg6/oq8HggXelRwz8HAzaAP6v7jrO
 mUYO8TqbmcbmYrC+LYSZlKbO0yRBDuTUIgiSjUvjZSr1ICL/NNjWi3eSWHk4U0TBQKnmmRvggjP
 MQxAgw59X8e3mSeUQ10pijWTX2D3avmjd0ae5DAP0bJUDcKj3gjrDa3n2mqI8Z928pLDKj3byG2
 o5xuXj4h3K1362DivAKevBBJnk1Yi3vfqLO/k8t1tAhrdpSdkLlJGyzf0qajJABbuld2vImzq+m
 shMfMnn8wAhNfAEzGkEsjkT52BIOkjOZ1Qf9pJS/L1cFDuSn/CODzBTjf4+4si8NcVwiMnfpJZl
 722cRE5yUR3uN06vZqOBh38kRIWQQfAnnKBQfIrxCQuhLy
X-Google-Smtp-Source: AGHT+IGeV3xG73GwXgLvNiawPkPd54jMD1tc1FdVm59bmTPKOffnNy4/9xXOnpUpUC0xDLsqwr1FNg==
X-Received: by 2002:a17:902:e5cb:b0:296:3f23:b93b with SMTP id
 d9443c01a7336-297e5403a5bmr182124175ad.2.1762871573259; 
 Tue, 11 Nov 2025 06:32:53 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a68a68e6sm21439319a91.4.2025.11.11.06.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 06:32:53 -0800 (PST)
Date: Tue, 11 Nov 2025 06:32:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Alvin Wang <alvin.wang@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/4] net/nbl: change default Rx extension header size
 to 12 bytes
Message-ID: <20251111063246.566977f8@phoenix>
In-Reply-To: <20251107073459.3532524-2-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251107073459.3532524-2-dimon.zhao@nebula-matrix.com>
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

On Thu,  6 Nov 2025 23:34:56 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> The default Rx extension header size is reduced from 16 bytes to 12 bytes.
> This reduction saves PCIe bandwidth by decreasing packet overhead.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

The other patches still need work, but this one is fine.
Queued to next-net
