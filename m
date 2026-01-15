Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79323D41149
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 09:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 795DE40EDC;
	Thu, 15 Jan 2026 10:11:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1BA6C40EDC
 for <dev@dpdk.org>; Thu, 15 Jan 2026 10:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768468287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeFg2S54C+Ny1orxFCc5pqMhmYJ+F8DYEc/0yCoCd5k=;
 b=iGUMlGCk5z3wLa7ts4+HqqfMGg4mL8EA+4QXFp9McTthueywkVLi1bZL6k4ukcH4MVTFej
 HPvEzavJ5n8mQcUlAhvXyeTtaNVN2SHUDjFXXiEV2sJO467Km2GmxFirww9IbyppyiZciF
 39R0XfP8TgzD8u+ilSCrhYvdWuwMA9g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-czWh4FtENrSXZVehVaTAGA-1; Thu, 15 Jan 2026 04:11:24 -0500
X-MC-Unique: czWh4FtENrSXZVehVaTAGA-1
X-Mimecast-MFC-AGG-ID: czWh4FtENrSXZVehVaTAGA_1768468283
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b6dfc0cbaso423259e87.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 01:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768468283; x=1769073083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeFg2S54C+Ny1orxFCc5pqMhmYJ+F8DYEc/0yCoCd5k=;
 b=mzVxSMJNXR//4WvWV9PYzM6Aa7SZK6Gr3aG6Zjb+HIWXjSS8KpTCoowEXFpFYcruLU
 /da2HMqnrLVopoGJrdNGIw/AOvHPTQvKpX8m97jcRLKF/5sguTUB9O+wJCo6Io9Bpyp4
 J8+qAgZ5N2XMt93JmFUan1+kGOepudBLKH/tjHMj9a/4Y+9+XgOH41u+TwIlOpTeOxG9
 F9N1YFNrjmTXRezz7fRIni+Z4yKUDXDIKSyb273Gruiiwzx44NrBZLjXffadwI/sst1m
 F9ggJAbo0ixctFxTUsBT57KYDFTLDhkaXsaZNdPpRikcjrAukitfaparPd52B8uhkQfy
 RNQA==
X-Gm-Message-State: AOJu0YwKaSEokLm/cIqHAj+8DbmEYGXAHbeeFLJQMF7LYyH36mhNp0Wt
 hI4CiAzuFTacctLvzM6bGDsxIpaaf7rBh7PTOhB1n9Phc7rIH6/5Esk5efathfoUrpsxHiaYqq1
 RQ0qED4JALH7wjz213Mx0sjXP/0qbplGtP0T/aHonco9qqRKP4Ww6aLsaf1mf1yxTOKrvFEOmWX
 /DVsj/BRNxfxch5FjljDQ=
X-Gm-Gg: AY/fxX6JQaaV2wEmIiEn6FgQQtVE61bwN7CuKw3Tk1sAMDYQbFqDnLqdFNWgI+ZNHiR
 ZGfA9acm0js135W7/QAjdwtTqsVo51z6tjwgD0WdpVuhnbLtSMg/w52fvqcUbA0t2Is61yKSGlz
 hixna6YDTLVL1HPtP/exaWnIhlFqJSd0E2opMRCnG1+/S/s/w/bivkq1RYrZkeBwqHJrLW
X-Received: by 2002:a05:6512:b99:b0:59b:7973:c015 with SMTP id
 2adb3069b0e04-59ba0f6b521mr2120723e87.16.1768468282800; 
 Thu, 15 Jan 2026 01:11:22 -0800 (PST)
X-Received: by 2002:a05:6512:b99:b0:59b:7973:c015 with SMTP id
 2adb3069b0e04-59ba0f6b521mr2120706e87.16.1768468282198; Thu, 15 Jan 2026
 01:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
 <20260114153445.2751895-3-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-3-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Jan 2026 10:11:10 +0100
X-Gm-Features: AZwV_Qjnd3RQBwpULPHivzEOyFBla9USp70XRpT0A0k8-sLSsLI1iSPzx5CAOXU
Message-ID: <CAJFAV8wOxRn-FuZgZZBKeCETobo4T7Lf5togizvcQ9ydAUxjcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: fix descriptor chain bounds check in
 control queue
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d5blzeR-nIAoIvoKzF-WBDOlHcW4P4QrcjvpFe3biq8_1768468283
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

On Wed, 14 Jan 2026 at 16:35, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The virtio_net_ctrl_pop() function traverses descriptor chains from
> guest-controlled memory without validating that the descriptor index
> stays within bounds and without a counter to prevent infinite loops
> from circular chains.
>
> A malicious guest could craft descriptors with a next field pointing
> out of bounds causing memory corruption, or create circular descriptor
> chains causing an infinite loop and denial of service.
>
> Add bounds checking and a loop counter to both descriptor chain
> traversal loops, similar to the existing protection in virtio_net.c
> fill_vec_buf_split().
>
> Fixes: 474f4d7840ad ("vhost: add control virtqueue")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks for the update.
Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

