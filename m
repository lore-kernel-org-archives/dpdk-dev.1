Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7397C369AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 00:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C991340655;
	Wed, 16 Apr 2025 02:05:22 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 64BC240289
 for <dev@dpdk.org>; Wed, 16 Apr 2025 02:05:22 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-225477548e1so60126365ad.0
 for <dev@dpdk.org>; Tue, 15 Apr 2025 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744761921;
 x=1745366721; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzhTUnnb2pG+feyALhPzlGjpg+81Mru88Ti+iNB2bYI=;
 b=2qZrYP3OQiscYrm7Y/HvIpI0zxqpXTI5uZ/xOtcSNdVapCxz5uMWNycNGwVleZVdR8
 Fj7BTxkDCrbmgiDngMvxUVL/FArzpxAtVb9T7CIYoxxBlFJrkV9kBh12AlmEq6I8Ckan
 K8GAVG3I6+xql1Uyk30XEIzG6HPo+nzdMaO28J53zdKc8SvE5lzuvN/TYvQ3P3zKHhGT
 +0ijiSiqOSJmLRjYsOFhNU9WDKqFAn/jDZVTLiipQUk8xeSb5xSelHs6pjn/Ann1ztsV
 CrDKiS0WqSJBgxs2u+oEGQRfIgLgd6+cM9y5hypm9CXeOxDW8R/hVuQ8LapImBj03Uqg
 kZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744761921; x=1745366721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzhTUnnb2pG+feyALhPzlGjpg+81Mru88Ti+iNB2bYI=;
 b=Oe/SApgwF3w1z7BWGa1XywwEWdhnFKHpa1YbVQXEdYjRVzbNszxJD7wrTxz/2WMbCT
 7fXdbFeXsm1oxn+1TkbcmyzPVc52A9GFNqiCgLh0S0eqsdCp8PmD4RxTAy7LlOferAVa
 AznPQPiNsRgekVDwBnejNtA0zQG96wDIQVJjfVS13ppwaXtN3QP5Lips8czcOZerBK8G
 BF0PsLK3hbTm1hOzSKfIK2DX7Hk4JvFmGqxfaOTu/xyuGfbUhi7nZfDsIisbM/wJJ47o
 tUkubOFoD0TA+lRQhLljbZB39bu6I0FRBw0AQ7XDxnm+Jw5Skequdjmvl/R4FSQ1tVQ8
 hOzA==
X-Gm-Message-State: AOJu0YwMhoqhdaehXdU4WtH614t2wghhbMt+VzG/T5BgC4+buBGHKhRk
 svRkHh8pgFcnfOCVLh3Hvt+efd0cFGaGy2lkU0u4q1ea4IUGvFUjJOh+pFWcuNI=
X-Gm-Gg: ASbGncuw2IkONcKstNnP+hRLsy8tzqBPGvM9OXwQi2AHTetpA/yidHeLtFJYAKuEg9o
 zQawqGAx+rumoLGfX1NA32KKyMWmkNMNkqp+mMy9/UIwLpjzsefBPJeFzrjum25Vtvy1hyZGQrc
 djnKrPRjxxNLNx8xPO1S3e0jm2rL3iGd5+MPKW7yUkuTPxSsY5G8iCo2z5nzEhJu/hu7PWmugql
 PyZpcy1ILrNGUXDussHrSsm3ruF9ToDHAWouEb4yM9HfI1JCQhUHY7tJvZZWYT+W/KD36pu7+q2
 se0UZCl9GMUkOqOkDK9i6dVJmxzPz5PGI4wjZ4sau+muOS54cV+AfFKWP3MzQpH0Cq4U8tmXNid
 0MptUwjtjYnQQ+r9z
X-Google-Smtp-Source: AGHT+IFJRd82V1kNJkSXjqnzwqUG0lI9Fvln32pr3SeYwjkNKEYK6wR1Xivw6CfKEXrlDGBrUNIPNQ==
X-Received: by 2002:a17:903:228e:b0:223:66a1:4503 with SMTP id
 d9443c01a7336-22c31a6e008mr16132825ad.30.1744761921450; 
 Tue, 15 Apr 2025 17:05:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef100fsm1360925ad.34.2025.04.15.17.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 17:05:21 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:05:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/4] drivers: use macro to embed information in binaries
Message-ID: <20250415170517.6a7b37b4@hermes.local>
In-Reply-To: <1744680096-17683-5-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-5-git-send-email-andremue@linux.microsoft.com>
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

On Mon, 14 Apr 2025 18:21:36 -0700
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
> index b7f02f56e1..a4cbe6f42f 100644
> --- a/drivers/baseband/acc/rte_acc100_pmd.c
> +++ b/drivers/baseband/acc/rte_acc100_pmd.c
> @@ -4082,9 +4082,9 @@ static struct rte_pci_driver acc100_pci_vf_driver = {
>  		.drv_flags = RTE_PCI_DRV_NEED_MAPPING
>  };
>  
> -RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver);
> +RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver, __LINE__);

Rather than changing so many drivers, can't you just use __LINE__ in the macro?
