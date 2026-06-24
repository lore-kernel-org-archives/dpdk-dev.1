Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA67CDE001
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 15:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFE13402E7;
	Wed, 24 Jun 2026 17:17:45 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 39F9240150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 17:17:45 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13986d61b4eso2917503c88.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782314264;
 x=1782919064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8Zv+tkq2JOKwQVTpoFnwfeeol9wtezcC2o68kofllE=;
 b=c5IyZ1ZkwoY28h3HHunrBTjbuh3DMNhLjBrxAU9dVjvEOBrQxrjPrQmj2HSTLu8wrQ
 QTyQTfjUpyFplf9W0H6PFCiJcLLjoOQazOvNe7uXccySPPCsOTDvI8NsYWfIyGl5YVBw
 iyqSiUZCUDvD+bPcdBYGMDiRn+CLj82cpE+0smwmx30ccP1rqsemXIsPiKxzwpSU0+sE
 DC2ScoZmqZkBIk2QwA/RT+S4DfwcR0Tleiyg1+cTTTAETvrlvv8c/kR2/6d6tQHI4FSL
 kcJc4IgKg54JNcgsxU6MKvF1TG0865bUwgZ1gkZmr15nHC6/yjEFV0o3k2HVQHCjgnQF
 Xi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314264; x=1782919064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8Zv+tkq2JOKwQVTpoFnwfeeol9wtezcC2o68kofllE=;
 b=rqncvt0ZhCtjslU0nNxkbjHWxcbRVvBorG/Kof8haG/7dP3Hpmm3mIib5W0fqeIfns
 gAtESXY7dkkEtzlmEOSonMLwIG84FawSy/N0Wb7Re2xkXIXWy0CCtILi3r842ZWB+5pd
 CeiTrdaOqkqE/nq4D517GNy7WC77CvR3TWwUNzKQywHrdhsiJ7uqS6zrq1AaNuOw/U9C
 wOS5iJt0orR+K9r2u+a2lePVZGcezom8MMRut6/kJnISDoT3wsDC+pIvLYhU14YDgjIN
 RvYUztCloGopgGr5bKvBXC9T/tt4pAf2OI0lcio8NraQhBiyNLqkeS8AX4MNpnoBScBe
 sEkA==
X-Gm-Message-State: AOJu0Yw2HArge57Ac1+aNwf4CKMGde3ngQ5Kp5h2Ec79eFNHRyIjlUlt
 JhvfeRThtN9mb+j5qarhjws00wfE923VI3taFD5AMnDiE56JWnOCNzG3b2mFqvZkKug=
X-Gm-Gg: AfdE7cm7Dlk3UqjXtVXsM4cuXsQrBE4j3Qz67CIFSeygCypi1Lb4ctEG1awC0LINnBf
 7h9NbJ+vS2MM7b2CVL4P0Shsb3XrtvnqCNT/28VW8f5X1hQ+09DSLduwkjPSBYB0fyEI9e+Phn8
 sJojdPT4pTIzW9TjqP+hYDcW5A8EqOsLJkLgWk3zxVnlmAs3wrhcPDq3zvz8fvu0OWyItXvicjx
 WBheP+VQyCdBAMkSxLrY1sH6NA71nqRmYYfjdocqE4TfpLs1yczgTGINJHRnFEK6Sc9L0z4icif
 OciFcMGtccwUIprjBHXGzA+r1UPDM+rCfoxwHn30EZAj+ZV9e39zSlOO+PswG9A7Gs/Tu0aIsmS
 iW81g2KdZDm1a8U4MB9lgGB1/tCQxwza8pzCXT3BHNZzE1UbHS+++4YWy+5bN7tCSIx6W6kQ7od
 UTZhSXkEP9NkjIhDnSgbcRaEr1Qu2bik06YUBADOEOSvIpRzw65QEL9A==
X-Received: by 2002:a05:7022:672b:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-139ad676e84mr15408285c88.8.1782314264083; 
 Wed, 24 Jun 2026 08:17:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8ddcd34sm188803c88.0.2026.06.24.08.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:17:43 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:10:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Samar Yadav <samaryadav5@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com,
 tiwei.bie@intel.com, stable@dpdk.org
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
Message-ID: <20260624081036.6c6c82e8@phoenix.local>
In-Reply-To: <20260624085741.2195573-1-samaryadav5@gmail.com>
References: <20260624085741.2195573-1-samaryadav5@gmail.com>
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

On Wed, 24 Jun 2026 08:57:41 +0000
Samar Yadav <samaryadav5@gmail.com> wrote:

> +	pp = rte_zmalloc("virtio_user_proc_priv", sizeof(*pp), 0);
> +	if (pp == NULL)
> +		return -ENOMEM;
> +
> +	pp->kickfds = rte_malloc("virtio_user_proc_priv",
> +				 total_queues * sizeof(int), 0);
> +	pp->callfds = rte_malloc("virtio_user_proc_priv",
> +				 total_queues * sizeof(int), 0);

Better to use rte_calloc.
