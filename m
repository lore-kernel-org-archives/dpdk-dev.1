Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A497C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 15:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D655402DA;
	Wed,  9 Jul 2025 17:01:18 +0200 (CEST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) by mails.dpdk.org (Postfix) with ESMTP id E79A2402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 17:01:16 +0200 (CEST)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-87f74a28a86so2936241.2
 for <dev@dpdk.org>; Wed, 09 Jul 2025 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752073276;
 x=1752678076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYb3c+tpZU6cVUTudJoTu35YJvg33xuSef4JiGD+ls0=;
 b=vQXoYdixj2hTpWefPZIbtULijEdeQJppSB3yfPUrz3EqolbohKThCWqXsqSrtm7md4
 gJ7YiHmMFwLDftxFdtpm2AJYbfR198XKJdtVK9eis0X7DEE0omt4nILiMZjQksmou0yV
 tfHHjgTc2rbGyucWtoG9CBUZ+VotPEufQoRjwoQlecSXLySypfjRux+I89npEKpWZj46
 U6MirskzL6pZmBnqqWPm4MrAZQ99ZUKnb/RfkZZiDwDQ1vdh08xgh70aClU+9RsTVeCx
 r98QRZPjGEXjuRr29+7IJcD5dueIHfbo0xE3RoYYgM/4uczJtB2Y52e4bIPkssallDQa
 zvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752073276; x=1752678076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYb3c+tpZU6cVUTudJoTu35YJvg33xuSef4JiGD+ls0=;
 b=ScTPSizGjNkVvKocUVQwk1AVtPU62UiQ4l97dhclJO36dyL3FpQK4Drt8fn6G3KIAZ
 ZVSu6lza2BdXCjUoF69XC0qw91SyG/eL5E34cOAbuzV8e0SE9GsEsYSTgUVCTE3/CyWu
 NO9iSAiK3AIDdOLFAKDKKtZVAP40qVS9hQwOSZ39awlJRHtxZNtiqFIDcs+Iyzt2TaLz
 4I3bI5DeVJ9/tsDBQPS37QB8RxzBbzyYcij5OEGO5OOtKXfXJNz1Pdm51HsVL80XQaTe
 SLT8ZUI6/vr76pYCenaj0MQh+EszcfgFb/hAvUmKFlQWSah8a47VmHZM82sNyZTTJr66
 +oxg==
X-Gm-Message-State: AOJu0YyfpepaKkQ6Y1+43pu/bdpvdUBeuyqlbDfuCDdTSH5yGpOyKgfM
 xauDpM+7EkosCd6bTF/VPxp4BQli64dR0Z7k8TBjUhlxEDfmpCWWlwOhc5DNwyQxsTU=
X-Gm-Gg: ASbGncsn0VFcknNHrRN3KapF4giQo6iMzl7GitrYmiAN/ST4puJfOIQgO2nxc8DC8wl
 xQn/2mYryao4WRFlck1QdCFuwCQ3KDiCLHXxVCu+X7GxeD4a5wlM94XwIjp8+Dg0E/HriXKaNdW
 ZlyifGoPdCWxEzkFsIRJ0/tztHFIxGuNiwoXLpzSniUm7B+lNFhBLWIMuK4KtYcogyNxEX5/pN9
 kSFPvpcGI1fTekEwDtINCMxAZnqmnQrqPFyfcq1b4Q1gdmC511T8cFD5wOTIR5bGyubIXh9Qfnw
 ZTk3woQ8uS+OQPEK0nv2W+B9Ba5sa3OLYI7f8gogGBOIzQppXA+EAQun14mf2xEb4I14vMBCr/4
 NXDAg0YLUrOvZfyIqD6cVoW9y+3+cmpAsiYXWicVoYkmIDXxgxw==
X-Google-Smtp-Source: AGHT+IFhNWg8iPMnSwOSnvCzeUINaGUpkBLuqq2BvQv1dvobunPLqh5jGhiGSW6dJsBBtPn1LGAdKw==
X-Received: by 2002:a05:6102:5cc8:b0:4e9:d951:1433 with SMTP id
 ada2fe7eead31-4f54a9db1c4mr1989589137.12.1752073268450; 
 Wed, 09 Jul 2025 08:01:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78bf3sm98472101cf.52.2025.07.09.08.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 08:01:08 -0700 (PDT)
Date: Wed, 9 Jul 2025 08:01:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>
Subject: Re: [PATCH] examples/multi_process: fix cleanup on exit
Message-ID: <20250709080104.62fb27dc@hermes.local>
In-Reply-To: <20250708070954.165222-1-mkashani@nvidia.com>
References: <20250708070954.165222-1-mkashani@nvidia.com>
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

On Tue, 8 Jul 2025 10:09:54 +0300
Maayan Kashani <mkashani@nvidia.com> wrote:

> +static void
> +exit_cleanup(void)
> +{
> +	unsigned int i;
> +
> +	RTE_LOG(INFO, APP, "Close ports.\n");
> +	for (i = 0; i < num_ports; i++) {
> +		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +			if (rte_eth_dev_stop(ports[i]))
> +				rte_exit(EXIT_FAILURE, "Error stopping ports\n");
> +			if (rte_eth_dev_close(ports[i]))
> +				rte_exit(EXIT_FAILURE, "Error closing ports\n");
> +		}
> +	}

Could the ethdev cleanup be integrated into eal_cleanup() so applications
don't have to care?
