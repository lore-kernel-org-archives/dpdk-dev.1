Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46046E9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20C9040696;
	Thu, 19 Feb 2026 18:51:26 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 8522D40677
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:51:22 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d4c4b494fcso781915a34.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523482;
 x=1772128282; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLSpoqHW+kRx+I4ZplRJyuWDxeuPc+YCTuCCAxCn760=;
 b=Aj+fN3KO8AydUFIup+GVBc2qDG2KMPMgfcoCseLzKsxJr9ILOkNz1STWlmqSuP75SL
 EGYgV6FVKAyFY0znccYns5Fv3PW+T6lVx/6VPjOq8bU1P2CBRs6/RpRhGVgXW2+aRXZu
 4PcPBzDfmOZZ/Q58zr1N0aFUZ6PpZgnCoAtfHV2UCuf2mzzVE0JKxqiJrpPMt9+P11k0
 iFZG+U1Av3Rqu81c/XKZxzxC0p6JeQAzhjy8GIPx2/DFlxDDGcA7e7fw7dHB50l2m0HU
 dx3zuTy3pibT5PusHLRvMtSWAk+myzt60gSY6uy9wgqPe2uo0a302YP9uyt0bGc6v4fx
 EP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523482; x=1772128282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLSpoqHW+kRx+I4ZplRJyuWDxeuPc+YCTuCCAxCn760=;
 b=dQCuJxVW7Gdm1cwT8nTHh4ogn9x9exAhU5DUHDv7+br26kWvgMHhahVd5O3m0Isewy
 1Mxs15cLq3G/pmwcNWfsyfP3XbjIlYyVbTnq/WzaFYQ1RCYQQWkD7GecOhSU8JOHicSo
 ATeluytRPhNHdwzc94uHs23AQ25pCXwPhxnz5McK+FWbk1ZUovGO51kTIcVBDAPuqJLE
 tI6Y/TBkrC7lIS+MRlZ0NTnojkV5HgmylzJk14M/yvBvPHv9ykbev93PkqiFgT/iJCWI
 qeZ87xKshkcc4zznxECB+jtAbEgRd5L8j1ElNFMefwekMyCcR16a9vqyoh1dRZJGxqzN
 zn2w==
X-Gm-Message-State: AOJu0YzBth8k3re1jj/puF+nZaaTNzAmZDwwsGHJ8HxfFG82a1Tm58Ag
 5UZIHQiTS4SzIQ9rQvf90p3lgBJp6TyI1kv+gCSg1RhdaiulPIgX5ym2Z9liMTAZzGA=
X-Gm-Gg: AZuq6aJQ7Cb5BXh3He+kVIkj+ytOQa6RYdYx9mrkfeLlX0R/MiQOWwoNzsFBjKxf2M7
 uY4HLJvedH7vlOCUuhzHYKUVQ5jZASWIar/EYzaQJzl7q6eKM8Si7jlQhwHesUI/rUyD3Q1171e
 DNpCtJsweWGH6wvgIsKyWTSibT/l7HIszYQoU8qm9J8QalwhTZm9jR92TWV9ZNpXJYwEdBisjXS
 0I5DLwlFk7ZcG/NS2gjSoTAD2UY79YhfHTMfhdf1678PPjv4tV6tytmD+M59pQ/go+W3dYG7NmC
 QIQtfsrAhVg6pkBPcBSahJQOPslxr6SpqBy1GQdCp79gbdMdCmUfUB4KKCOSWOuuDF5XWn47z5R
 TqZaj7KBFU+ZL/B3FNfuLFWjuUdpO5rb5dX2lXK0FrLgZ3hcQer7V35xxAbktpyMQa4MWXGnbGv
 dvRYSjyXrN/t6xJXZMj0GvLw2cBOxreY0+nM4i7m3bOpI8CA7te3BQIXzuZOxhQElb
X-Received: by 2002:a05:6830:b88:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7d4d0b0021fmr9608781a34.15.1771523481826; 
 Thu, 19 Feb 2026 09:51:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4d668434bsm13756856a34.9.2026.02.19.09.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:21 -0800 (PST)
Date: Thu, 19 Feb 2026 09:19:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nawal Kishor <nkishor@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, <asekhar@marvell.com>
Subject: Re: [PATCH v4 1/2] common/cnxk: add support for halos
Message-ID: <20260219091938.3593270c@phoenix.local>
In-Reply-To: <20260217103932.679806-2-nkishor@marvell.com>
References: <20251205055140.2395369-3-nkishor@marvell.com>
 <20260217103932.679806-1-nkishor@marvell.com>
 <20260217103932.679806-2-nkishor@marvell.com>
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

On Tue, 17 Feb 2026 16:09:21 +0530
Nawal Kishor <nkishor@marvell.com> wrote:

> +int
> +roc_idev_npa_halo_ena_get(void)
> +{
> +	struct idev_cfg *idev;
> +	int halo_ena;
> +
> +	idev = idev_get_cfg();
> +	halo_ena = 0;
> +	if (idev != NULL)
> +		halo_ena = __atomic_load_n(&idev->halo_ena, __ATOMIC_ACQUIRE);

Do not use __atomic_load_n, DPDK has migrated to rte_atomic_load_explicit

> diff --git a/drivers/common/cnxk/roc_idev_priv.h b/drivers/common/cnxk/roc_idev_priv.h
> index 98b6286bfe..dde555535b 100644
> --- a/drivers/common/cnxk/roc_idev_priv.h
> +++ b/drivers/common/cnxk/roc_idev_priv.h
> @@ -30,6 +30,7 @@ struct idev_cfg {
>  	struct npa_lf *npa;
>  	uint16_t npa_refcnt;
>  	uint32_t max_pools;
> +	int halo_ena;

Using int for a flag value is legacy C code style.
Use bool to save space and have some type safety.

> +	if (roc_feature_npa_has_halo() && roc_nix->sqb_halo_ena) {
> +		struct npa_cn20k_halo_s halo;
> +
> +		memset(&halo, 0, sizeof(struct npa_cn20k_halo_s));
> +		halo.nat_align = 1;
> +		halo.fc_ena = 1;
> +		halo.fc_stype = 0x3; /* STSTP */
> +		halo.fc_addr = (uint64_t)sq->fc;
> +		halo.fc_hyst_bits = 0; /* Store count on all updates */
> +		halo.unified_ctx = 1;

Using structure initialization is preferred over memset and individual values.

