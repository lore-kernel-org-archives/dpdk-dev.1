Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEAC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 14:48:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4F54026C;
	Tue, 29 Jul 2025 16:48:11 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id C0525400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 16:48:09 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4aeb5eb611bso19780231cf.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753800489;
 x=1754405289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2rGmGzrbJvk7J+cGZZg56LuchEeFJdfS5nX+09K6K0=;
 b=3Md84sexSdLkNdgutlqchtLGc5KmEMBovJHGRBvoZLkF5umAbf+wFG8X+oZ6YX5Cj+
 hIHTpzlY4LOGVNXrFqMAvYSj+TBEfhlrBceJcFIXh8L5O0vy+oZ+M5zDuIWLaOxEfNYY
 v+E/Kq8x4Va8SH5pGKx537TIJcyXlhiiJsqV5hV2yj0Y//r/RhPdzVqCZ3pLXe7jm/pE
 AnfQLkL12tTOuXL84dJzEgAKyer5zbPjS1Q9MS4xg1ng3RH4ooAOLa86/5n0GME01jeh
 5ivmGdfHCqzAApUbxViELR6SLC0qMSjwBV3tQt/K2d7+IwSi5sSly++er/fxgFE0gK4j
 ubFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753800489; x=1754405289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2rGmGzrbJvk7J+cGZZg56LuchEeFJdfS5nX+09K6K0=;
 b=f/rqhcbFBdnLf31hR8Kwgn62qLiNmMKj4RgrTzrX/qPjRpok5hHMMtwdqDTaXP79aE
 svfB4OlrMAMzTKRPN9crbQAjygRasSKMuT1qhQrXa5kjvdKYS9NIUdvOExC12v6ii0jP
 hrVrNYQMuLiW5trXqqgUm2UgUatfKifBuH4ShWDEThgYkrWZjPZVBjUYKwy/z9DTAH0j
 8bFvhxx9OeRAluj5aa4GUYGExWEt9DmOm/8na4D/FVFl9SQKn/blfVCkpiAAgtQnO7Cb
 fXHW0aoz0ZrVPoWczqSvA3BelOpc2vWCSjAxszKnnE6ubnU5orvS19XiS53iN9O5+Eoo
 DaCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpp9+ilpRGCz/cKzV85SyqyxKjYXEGk29OfhgBGxqtTm19VWWlOVOU2rvKK+8Sqn1ScB8=@dpdk.org
X-Gm-Message-State: AOJu0YzLl/dFtM2t5Jc/2Y6mVX3GJYBjY7pm3CISJQBwWFIj1x0U9gZz
 CdEhOcgjwV7YYZsRy7MdFs9igjJgminnqzHyADSklerO1F3QtkWpBbuvFhoef0Efyy4=
X-Gm-Gg: ASbGncteUXCOIc6XydZQd1xIE6Jx/GdiCskdOHRZPOiUSYszAFQoYnWkwkVED7hm9xs
 u799HPpbqhdVSyNT+HZFMd6la8p8GAM7F2IFrFzWMxE01kVZk7e0ZQ+I2bqNwYMo5BBX7+1AAzY
 YBWQTlbdQP6ABNRV8R68N3Txc+AfiKNp/bh2nMDqGyGHqtEd2YfwUUM2a/CDHc2/SGNuziFOCgS
 geKx14gdmnaH+GCmuabuF2eAmiyz9S6yBm4fcjcxbq5RbqfTCXctKdooiahyj9BrnxJWpqH+toe
 XVT6DBu7A1RhTGp8Xn7IAqAYZiMzz3riOskHoT7uzPLdR6NHoM9HbwJ9RrD+tmYqT6Ra1SBqyq8
 f+ekkSn46CnQWrTale0UspIaJAVWB2zzBhJLKT0wFwGwWosnPO5ie3kQN/+EBnjEtDD+pltqEXZ
 0=
X-Google-Smtp-Source: AGHT+IF6NFg5trschOPCGLpwYdBr16SAEDJ844hnLnVEDSD4zmWewV+U1wGuDMGKtwC1qCgdOA3j6A==
X-Received: by 2002:ac8:7d10:0:b0:4ab:cf30:1892 with SMTP id
 d75a77b69052e-4ae8efe71e5mr184378491cf.22.1753800488745; 
 Tue, 29 Jul 2025 07:48:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ae99544ac5sm50254761cf.19.2025.07.29.07.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:48:08 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:48:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary
 process by monitoring primary
Message-ID: <20250729074804.496d01ca@hermes.local>
In-Reply-To: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
References: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
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

On Tue, 29 Jul 2025 02:39:19 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> In secondary processes, directly accessing 'dev->data->dev_private' can
> cause a segmentation fault if the primary process has exited or if the
> shared memory is no longer accessible. If a secondary process attempts
> to query device information (e.g., via testpmd), a NULL dereference
> may occur due to missing shared data.
> 
> The secondary process not only crashes on device close but also segfaults
> when executing commands like "show device info all" after the primary has
> exited.
> 
> This patch adds a mechanism in testpmd to monitor the primary process from the
> secondary using `rte_eal_primary_proc_alive()`, and exits secondary process
> when primary has exited.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---

When is testpmd doing a query after it detects primary exit?
That is the problem still.

