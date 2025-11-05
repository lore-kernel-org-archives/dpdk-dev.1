Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF7CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 00:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DEA340280;
	Wed,  5 Nov 2025 01:21:52 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 16E0E40269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 01:21:50 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-34029cee97fso6298560a91.1
 for <dev@dpdk.org>; Tue, 04 Nov 2025 16:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762302110;
 x=1762906910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=br3BjZu/O5jRZc9w6aGDsFaRlGDcjh9XJSpjPIJvgN4=;
 b=fca+FrVk3vCo/FSVpAClS9r6CIYzfQBIcwxeqNYa5xXXNG56J6KyO7OH46I8idYZcB
 MifU5IeqcYmO6uvHjjXPj9JLEiY5098BDbbw6neiBZkw2Us708P8/djDbGbCwnokjtGk
 VtJ2U/VNUezII51hYx4sGcQjLiATXwQr7jDXqjkNyZZWP6Il6nG34fLOOWAa8iJ1fRYO
 C/niV/eJ1fNzBrg4vqVgxD6o432AzVMHHLc6DUgrh4Av3KeKlms5kpRqeGbgyIBUyQOF
 GZr4sRE3D2weT29b8wyFQqEV15yT5oD8A1A0UghomqLy9qlluTiiPxUCjDq3HOFY8gxc
 hxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762302110; x=1762906910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=br3BjZu/O5jRZc9w6aGDsFaRlGDcjh9XJSpjPIJvgN4=;
 b=DRam8LRdVT8ZdYQRnfaAls3kd/J+pLYy/0iYSP/BZI8pW5sdkog5spmGrIcMiZ7e16
 ub10KtXNmNajC59tm30WtYYDI2fL9ov2Zm3qyaOmSd2N3UPrBC/bvueCVcuDoFhMUYHr
 A0YT9oeaWhaxHRZ2HbPgx0t4qC2dCybADlkyFfBhSzyvfba5qC3juTU7sAKywXeUAXjT
 TlboS6SBhnzWKv9ymfSlARmNM38FvcdqYlZFgMiujz7qvmGSfx9F4rtpQQPo3+/g7wlu
 5uRs7ovPPosHH7iNvXBN5uiY+PLsUbiKd0K2B6nj5eNqU+2Q4CQqp6L2hdVY1EwmRziD
 OuLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFMyKYZNJcLlaf27DRWgaZLnDbd2eNtOfjQ8sOWMGnQROF3FU2LvriVvWmpjDwzu8gsLI=@dpdk.org
X-Gm-Message-State: AOJu0Yy2qHu8R/npcRADFYB9lEs03jEB2ypbF6AG+FMlKrm183AuMplO
 J/03UqpaOPm/92oKaGVXMQS2PMpnKO+HKdts2mhEUBTGRdFS/YesFa1WkE8eBD8rIFk=
X-Gm-Gg: ASbGncvGcRKNxLhqwTcgD9P3cuRZaIdp1d0Dlukvesq18uoQ70G9HBdpvF0N8g0sdzJ
 s0dbkpLysYevFalaNRcAsK29P2uN/iUC2eApD/m8jcKrt9tJsMLFyjEzWk1kfF+rlx+l0XIqofe
 1UoM0/s4Ygyf6n/wqR1Im6HgJ3+nYghgC+emdKwRMGrwi/0OTSOgJfygNBK06nLBsw2MjdoG8op
 b5HSNdz2207hraqX++IfwkudLh88nnkD3K+iDAuc+UqFpHAwYSjUVoVKzQNsEDWjMGG1uK3Ix/I
 NsWUH4XVUQxuB2vKG9MrpjkoULzRK10bZ+UimTBXoerQg86oKgYNwJe9omLHLJ5dwPR4BCAP8BM
 MCnTjsBjgeJzaaXI01RRvW7UiLt3EsXqAlqn8xqRPc/0+//v6cD+rDr0Ga7DWuwmhZ8HHJ2iCcy
 2muOGeGwn2yvpJs92mtzZyB5iLG+o+QyqETQ==
X-Google-Smtp-Source: AGHT+IH7lzHZWQUOF/aw52azhyhVx5qtS1X8NjyfwwCOsqwRvnjKNJRc89rPckownWXkgD3irxwugw==
X-Received: by 2002:a17:90b:582b:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-341a6c4bf84mr1562323a91.15.1762302109963; 
 Tue, 04 Nov 2025 16:21:49 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a68aa1edsm797841a91.1.2025.11.04.16.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 16:21:49 -0800 (PST)
Date: Tue, 4 Nov 2025 16:21:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: Re: [PATCH 0/3] testpmd support stop specify lcore
Message-ID: <20251104162146.46daf538@phoenix>
In-Reply-To: <20251104040916.25864-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
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

On Tue, 4 Nov 2025 12:09:13 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patch support stop specify lcore for testpmd, and also include
> two bugfix which found when test DCB function.
> 
> Chengwen Feng (3):
>   app/testpmd: fix invalid txp when setup DCB forward
>   app/testpmd: fix wrong Rx queues when setup DCB forward
>   app/testpmd: support stop specify lcore
> 
>  app/test-pmd/cmdline.c                      | 63 +++++++++++++++++++++
>  app/test-pmd/config.c                       |  9 +--
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
>  3 files changed, 73 insertions(+), 6 deletions(-)
> 

If there is a stop lcore, why is there not a command to restart the lcore?
Looks like this just an optimization for DCB.
Could it be handled better by having testpmd not spawn lcores that
have no queues? 

