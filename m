Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5FCAC58F
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 08:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5FAF402A7;
	Mon, 15 Sep 2025 10:10:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CC71F40262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757923813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdPQfdd0rwyHzPa9kjW9OwjX5fe0D+QZDnPQvG1BRGw=;
 b=BkCnLR2Ltlyck0cfBR5hFEGBYtF4ot1lWOrFX2jvZ3QpTFeD0KQwp6eRoP70c1HXM1xQ1n
 ghXwqRH3bqSsj/EBMN9qkwnPQkhEGACBEZY9vB7pFNy2lw76qrMFqSkgtogjoXKPCAd2UZ
 CRTAMrWx1RjGhvNEMDTU4TVI9NDWNUc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-h7RWkEz-MXe1XXNIwTS8lw-1; Mon, 15 Sep 2025 04:10:09 -0400
X-MC-Unique: h7RWkEz-MXe1XXNIwTS8lw-1
X-Mimecast-MFC-AGG-ID: h7RWkEz-MXe1XXNIwTS8lw_1757923808
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55f75b4b1d4so2859784e87.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 01:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757923808; x=1758528608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdPQfdd0rwyHzPa9kjW9OwjX5fe0D+QZDnPQvG1BRGw=;
 b=Pfoy0sR08I6QqC9gwxDJRk0AUtjIKiBCzIBTCYIvCOeHAjPTeT5x7AiLf4py+imzJk
 d8spTpHXEwUkV7palSMud1yTdJAW7QFcw9+jASUJuZJe097Ygqpz7+lpa/8UzzjcsYm6
 kirsqUApk7ZH6AYGt2w6NOftPj5oN+tmXg9+DsmQAneBF+ZcE5MYVsfkeX06odkNnCaq
 Feh8kReqsDN98I223SRbmbUNhSfWR9oeTAvvdoGFmJr2vTCUsH8cuVzPyf4iYHqsIQxF
 yjgHk6PojoaSsvUEj+XxxubT4dcV0VDy3aKPgiK1YQ6jY6HZzmvDCNlGJNil54MLRBDq
 GG7A==
X-Gm-Message-State: AOJu0Yy5CbXfzEM8SzUZB7xgyF+LyjC0Ya9MXuL+ynM1RBlWK+SyRwIR
 LqbtrLxFu4KtZQe8dGv1l6queHrv+fUeQWJIKY71uqZmH9SJ/9RQvPl5Eb71andU9cMT/sftZLh
 +GPnjkVRR504BgplYpBRqiKp2C9MfEQN+kXFJqzC1/stXuHcXmU0ptJ3+T7jKGKWyR2qT4XUVP3
 3Ckk+eyOvFfU0kFGgE0fk=
X-Gm-Gg: ASbGncsOJmUJoFhjG/hklAHfFhYeVRCX/engNlT/lyfxAiZnwufYFvITmk19cRJFNlM
 vf6SNwZwMwHJPuhSrL0WebZ+CFOKCxSkj5Wjm9G7HtCZtCcEg+XiWBScWideA63eCSNPSxJbm0j
 F/Aq/K5EubZDQbqOxj/xSaFoy2fa7bt18qEfw1LQXZXhvmOjuZ59l/eA==
X-Received: by 2002:a05:6512:1256:b0:55f:6bc8:19b7 with SMTP id
 2adb3069b0e04-56d79b23437mr4711136e87.15.1757923808068; 
 Mon, 15 Sep 2025 01:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeuv1JGrq4evYRSc9WHJWHVVwu9Kau0hUZyjm3EExNMuzyGzT6SnKKYCCdoWX+G6XU9Qs38peMD9SD6CVaEEg=
X-Received: by 2002:a05:6512:1256:b0:55f:6bc8:19b7 with SMTP id
 2adb3069b0e04-56d79b23437mr4711131e87.15.1757923807641; Mon, 15 Sep 2025
 01:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-11-ciara.loftus@intel.com>
In-Reply-To: <20250818105914.169732-11-ciara.loftus@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 15 Sep 2025 10:09:56 +0200
X-Gm-Features: Ac12FXy6YN2Cvc9JXo4fOPbFzHJz8uH2y9nUQjZ7Cr8qAL_cqpRQ3CMbkbVoQj8
Message-ID: <CAJFAV8wu3jQh2WAY_aUdS-Y1xFMFFtYrGGh_hgbROmMaEpWcgQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LuW_eBim2LJf6cJU6LI9Z5iLxdzHGpgY0HVE6pYzRP0_1757923808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 18 Aug 2025 at 13:00, Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
> driver so remove the one erroneous use of it.
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I just noticed this fix in main.
Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")

This looks like something worth fixing in LTS.
Was it intentional not marking it for backport?


-- 
David Marchand

