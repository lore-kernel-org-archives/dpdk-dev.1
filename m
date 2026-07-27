Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D04C53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 18:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52226400EF;
	Mon, 27 Jul 2026 20:14:42 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A0478400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 20:14:40 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3359990a91.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785176079;
 x=1785780879; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LFIqTKyqYo3tu0dMg+G3D2i2MDM3Jp2r6jfd8zoRtOQ=;
 b=sx1cJw/A1IvaruRahD2QQQ/FAX1NyLCokZHOcPcyvBZPs71Y85rAuBVzKYfiY0wLRP
 QlOTHJixCpm/R/UvL4a3D8G3WBjqICw2WSoaEdZkR6uFaicmR1lOhgmRvJCamJjyLjyM
 O4rxo8H2BeaQqS3Q3Tb5XZ4c8IGWM5JaElnfeBvMUgQFcdx9uv89wAoy8KSIJ7au6jV+
 NxDQuG3J53Uk1AgDnYsEBSOFPyuhoo0YgxMmr2WeG/rCpZJYgMKraCJ3gO29B/6C9qvi
 n6A/LJX040jiiXq1ftHRCCjsTz9SVcuOUvWk7vA6qc5clJ0K0IfdhPIBGACf5WZ5BKzq
 BdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176079; x=1785780879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFIqTKyqYo3tu0dMg+G3D2i2MDM3Jp2r6jfd8zoRtOQ=;
 b=gHEpRnCxOxQPA0G2ZJI4s1y0MjZgaO9fAW2jNzw5fdBv3t7gmpXhcD3xqCt5fAyomz
 kgiyLLBYhxzhfaqAF8aucJYRlHbA2KfWaYsnzKi1ooAueMFT0iplVhhDo2yxuyFgo/9r
 W1PD+ufIfLh/oePvNaKhPO+25St6vQbLMlenjjTxn65OqHkLTuIBMu3EyH9hjGvznd/b
 E2w7D5D/uOYZlwocsVoUUZqG2HVr8VlCtgsUC5S+0nZD+aJJXkGi/XkKtH7WDRv/P2nT
 bFDN3ZMYb7YBv3laWj1p0AUjSXQenEhF7+aNt92snyCs7dZ6/TFR3dRZkepkG0nz+t2y
 zZPQ==
X-Gm-Message-State: AOJu0YwfllWNep0ah8kPgX710bPqQ8NXSXPaYtT8duhUg0d4zt61sEsY
 YqBPt9FS2qYpsQSzOoh6GXTJqtnZoYvIn37Wvq9tJbf0ZsGhlj7G7D4FZRVevXQMRyLTriDL2oa
 DZto7
X-Gm-Gg: AR+sD10AxOBEJP+bVcUm/08ORHOD3BSpoagh8kITRebKtcdwQe6OAZkmE8hHiJi80mv
 yk0zwJ32HvO75B8udtexOjCikoluJIOzFFREfSkhf5eNfZdtUCXUoXdzolbIZsc3c0y5C3a0365
 biAk+S+vA4rMKHzeDRJ6Xl909qFuqhy0/QimFjvlsYvN7sYHx6vuUevbwn6XjnxMtgYqdGFQVtB
 GSquO2wPyq33H3DZuTYsg8D3CSm1NZh5XDwApas6fahEHz4adJ82sx8vWZBumJWOJXzwSd2y4B+
 DSjJB+/aVVve1opAVbogtwTIKAPdhRPVyQsYBno6ckS60OuRLYcoOdk0CZvqK5TWmUnHO/SxVqL
 R//rcJioq+do/t2MQyFz4XHXzW5vRKF/brjruS/7w4kG8aXuqXmdOZG2C8N+VjO7wCkFnrMax2K
 DojluK9dtlaY4Op/WKeshrsgnecH+CpK8FbzbkBez3YunSA9RdnFpv3XCQh/uMOrdDVnsjdN7Kk
 UuQfAuHwvQUHRgYYrlZbxPFaYCjMkQFGkZjnTwT
X-Received: by 2002:a17:90b:49:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-38f293d31abmr9175152a91.4.1785176079351; 
 Mon, 27 Jul 2026 11:14:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc593b57sm50449680eec.25.2026.07.27.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:14:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:03:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 03/39] eal: define new functionally distinct config structs
Message-ID: <20260727110338.777d5840@phoenix.local>
In-Reply-To: <20260721094555.2188496-4-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20260721094555.2188496-4-bruce.richardson@intel.com>
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

On Tue, 21 Jul 2026 10:45:11 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> +/**
> + * Internal EAL runtime state
> + * May be modified at runtime, so access must be protected by locks or atomic types
> + * as appropriate.
> + */
> +struct eal_runtime_state {
> +	uint8_t reserved;
> +};

This reserved field is still left after all the patches??
