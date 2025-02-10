Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1A7C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D72E740616;
	Mon, 10 Feb 2025 19:24:46 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 97840402B9
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:45 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-21f4af4f9ddso52970145ad.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211885;
 x=1739816685; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEmIOwQZus5+itBNF0Ph7L7cYX1yHFVXjg0C5B5PoDY=;
 b=DWVvcsXpK0EEUmgcBB49KJEL7+ZWnxoYS8p5oFK6GmSK7Ly+vH+k0wjm/MMOr6Uj0Z
 /WpW2gTqO9gv7PzRH7BI13p/kZTXkfUdm84+RVG15ObIdLwx1YyCroSWUUFhqz6WPk6y
 7GmbPfN/qAy/ryKrrw54ex4MCa+2I66bPzJ0Z2TZoe5cfMOJQokTwoanVMUwAtxEc3Mn
 fzbbO4yrNAMNOTJOhhHSnIp3XAkMw+goU5F45TUXhzei3j+DzdYT5xcLhOn9NPOcDm+M
 MfWKBWryd1+EvBGF8KmSrfkGbAWr0/RDM/vHeeEsS6v7xVhIu5TrRdc9LykEN0HxZPzA
 fedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211885; x=1739816685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEmIOwQZus5+itBNF0Ph7L7cYX1yHFVXjg0C5B5PoDY=;
 b=ppPOyMlfY0/UF5rFnURwnzVMBhGhVzvGPX7X3VaBJNs5RxeijQfNqu0TN2Gg1I3LO3
 My17EkA5VVs6bwfSHObxIfgqJhT0AmiJmcqiLMPkv8uNjOcyccFe0z8GD5xWnk79aLIE
 xj821TJxLJa8WE0ln4Wrb05Ng2E6IxoLreQ189aNSJp8Jh9HwFSIHce2p+TuYbly5mrK
 XiiDMzfPTLSx1jMfdz66cVO4Yy1riv6ZlJ5weuN/edQuBoyMrqdfiEMU+nofFb2l9PwA
 SkOqaaT+fKEZebaHaL8AntBf1bHatnTqOI7bz60y+UJpbpn/nsXDahUoKD8W65fSuN63
 WEyw==
X-Gm-Message-State: AOJu0YxD9PPf2vxVN4CorHbz/e7jRtvRqPQ4aLF2xO+dfij5XuWVeiKX
 mfKTTpRA3b0cQ8YQ9eJRFYcMXKeqtadlq9j3rkb9YM3k2RzE0JRaFH/ee8iOS2A=
X-Gm-Gg: ASbGncuRUIJ6C1RdH2ibYS6cIM5ac5BDclXOQhrsgSZub+gbZyg0H1Yw2SefKlahD57
 btoXMjYvrX0XBekb3zJxC3pP0TzBF2vjk/4RXQLf3j2yDgp6g5w1LF4mGHeFG1C3zAav8az5XVE
 Q07hV+EWH1OIAvIn0NxqWkB2uCaePy7FId3iA04bt50Ktx321T+PmVE8Djx9waf3ECQXyVDI7JW
 CbnmC5Bx3Zul/SzEogffMn+R01XyimsP4uC1eeSMstQnH9/lv3dxQZoqfMMTV6spGjYxSAK4sLM
 mG2ALhyf4omk6mR4S3wSFaw1vrag+HMD889HCFEJuL5SoE3ksHF+dWfy34SLqPtvABHo
X-Google-Smtp-Source: AGHT+IF8piH/1Ia7l403a66FHK4Q/BLUStXs0devfUd1lkgTOpT9lVZWadkkkYpde2zEDfbdZlQKfA==
X-Received: by 2002:a17:903:32cb:b0:215:b75f:a18d with SMTP id
 d9443c01a7336-21f4e6a069bmr207947235ad.11.1739211884842; 
 Mon, 10 Feb 2025 10:24:44 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:44 -0800 (PST)
Date: Mon, 10 Feb 2025 09:31:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 04/14] net/zxdh: modify dtb queue ops
Message-ID: <20250210093149.5dbf21ee@hermes.local>
In-Reply-To: <20250210014730.4105481-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014730.4105481-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:47:30 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index bab8b23a68..1f16f75a23 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -27,6 +27,7 @@ ZXDH_PPU_STAT_CFG_T g_ppu_stat_cfg;
>  static uint64_t g_np_fw_compat_addr[ZXDH_DEV_CHANNEL_MAX];
>  static ZXDH_VERSION_COMPATIBLE_REG_T g_np_sdk_version = {
>  	ZXDH_NPSDK_COMPAT_ITEM_ID, 1, 0, 0, 0, {0} };
> +uint32_t hardware_ep_id[5] = {5, 6, 7, 8, 9};

Shouldn't this be static (so not visible everywhere) and const?
