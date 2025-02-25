Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDEC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8537D402E2;
	Tue, 25 Feb 2025 17:17:41 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3A28340299
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:17:40 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22104c4de96so102063085ad.3
 for <dev@dpdk.org>; Tue, 25 Feb 2025 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740500259;
 x=1741105059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiXF3PjtH4vbdU5xFZBwOI0T7YIdbluG+AM0OPowtH0=;
 b=c937J0qQIh1Y5aSwpqYEhFUh4+I0sOGFA4X04V8rvw9Xv0r4z0ESzji3iE6woy8F96
 1rM60PqlLbTSaqI4IxYkl/Vb6r1DBRcbaazzLj/tfhpF7+2c23s/KGyqcG+KiJ8Oh5Ur
 BTB5H5u2SKDtFSm5gnHJQPtm2qPl8xligEoBEl8X41nIHtxSNPtpxbJ+Yc9fqQe2UKKI
 ZuNvME16fdxKI/yiN7tH096lh0kuaz94iOmYk7LUB0kIKNunVi3CMoziKa2q2IM1bs80
 hqo0tVHszoX9/8tM+RR6hd1WLhb9G+njGm5JJN0r7Xf5XGtpweLw/4CoZh/x6Keb4m7N
 /9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740500259; x=1741105059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiXF3PjtH4vbdU5xFZBwOI0T7YIdbluG+AM0OPowtH0=;
 b=hOrRJxR+Yb1s8OYsDeZoT8ZRcVtwpc49gmHVAU8cTFhczDxT9eHDtS7/J3K8czG8PX
 XltojlrHqXWKpBZcyd3orpNEYB1qRyb+jKQ2wEEFjjrYZpYarqkTxUTrfJr+G5HfG5UJ
 w9tdjoNn061OcaRzpUwFD8zKVwKkhCBa0w6Bnhr49tCtwBL/SfoytZOAJi5GwrMt0CQw
 BxQ/M+xxQ4VTxkRxd9R2rinshh6WKUsEKquMFINkm9clIDiL0tzR9VGAOsZrLMIz0rLf
 4DNH/wsqqw255Oq0gZkM+PNTBczcuuvZLadLGaXd7XvG0FuypKw54ZsV3QMJlOtpm3Sz
 bVDA==
X-Gm-Message-State: AOJu0Yx9TIiTdxclsujtXTgOWuB4G+PxxXQ/IytzB6AA4S7iwh0R3qtm
 SdTLqcaHOVQxXRcxTodOnXhCKrm0VXA8RE/erbVtndvZ0e2S5f2QyGJAVERxIiM=
X-Gm-Gg: ASbGncu6eO1n1o6FZOG6ZNNw6eVDpj9Lq5NN8806WfMJ07tJDMqD4B+N3LPTMFjNV9F
 q2X66669i34wXNTwZdd5pKQtWb1RDWC0jPHnExlOpIorde7Vbotdyx+Bkog83BCfSxNmvRzqDnv
 P0GS138AYYCZgnF3gQqkqFN+HYhEnGTJdo9EdpUSn2jJ4uxa97vpVrmxy8oggCJxvMeh7wBqCwh
 VYVfwse+WLNDYjFALFnniURsbHCUPA6xkpuIPwDWwx4b90XA+b6IfwJes0VlW2+E6+msP9bKJw7
 h0NXswYZIputOGRKZKQVxuWPadzmiTg43xXk5CgirLw4+Ccbo9RtJ04nxLKlLoUsyhO6wrXUlaR
 ij+s=
X-Google-Smtp-Source: AGHT+IFssfcTPQ8aG2UzCsEbACqaROpRXr56uk9Soo/BWIHYdHNsD7/6Se1vymDrRLS6rbVhh6DQGA==
X-Received: by 2002:a17:902:f645:b0:21f:61a5:67a5 with SMTP id
 d9443c01a7336-22307e67516mr65178035ad.42.1740500259126; 
 Tue, 25 Feb 2025 08:17:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a000536sm16106905ad.45.2025.02.25.08.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:17:38 -0800 (PST)
Date: Tue, 25 Feb 2025 08:17:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org, oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 peng.zhang@corigine.com, stable@dpdk.org
Subject: Re: [PATCH] net/nfp: fix get represetor wrong port stats
Message-ID: <20250225081737.09e63d56@hermes.local>
In-Reply-To: <20250225013454.442170-1-chaoyong.he@corigine.com>
References: <20250225013454.442170-1-chaoyong.he@corigine.com>
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

On Tue, 25 Feb 2025 09:34:54 +0800
Chaoyong He <chaoyong.he@corigine.com> wrote:

> From: Long Wu <long.wu@corigine.com>
> 
> The 'ipackets'/'opackets' are used to record the number
> of packets on represetor port received/sent. But the
> code does not consider concurrent calculation of
> 'ipackets'/'opackets'. If multiple queues are calculated
> 'ipackets'/'opackets' simultaneously, it will result in
> incorrect results.
> 
> The previous logic has recorded the number of packets on
> each queue, therefore driver only needs to add the data of
> all queues to obtain the data of the representor port.
> 
> Based on this, modify code to fix the issue.
> 
> Fixes: 636e133ec891 ("net/nfp: update Tx and Rx for multiple PF")
> Fixes: 82a2c286f35a ("net/nfp: support xstats for flower firmware")
> Cc: peng.zhang@corigine.com
> Cc: chaoyong.he@corigine.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Long Wu <long.wu@corigine.com>

Applied to next-net and fixed spelling in commit message.
