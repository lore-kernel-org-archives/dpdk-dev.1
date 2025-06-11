Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0260C71136
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 16:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA371402DB;
	Wed, 11 Jun 2025 18:50:14 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3EDBE40144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 18:50:13 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4a43e277198so904011cf.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749660612;
 x=1750265412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0dlvGLKo4B0sIQDbIAvZ7VcbmAfpOj6tEwhlh9YTog=;
 b=TsNTvWVH/A/jcBC/12L5G4+bwtoesI0pKp3IvBIIuBfo/xAqbIW3IZU8j4Q7BI3R14
 7vDyjevWQjzFkB8hPpFXLQ4cWBn40G/3H61FmZim7iiQnb5n5Da3Ki+5doDm06qbdsvD
 tnTzW6GYY3zwqOWVDrLi3WXWESkHyPNtwwlNppFJqCc4Ft2ErKHYQbR4mNNvl3K14eR0
 uaapjmB3r1IPuELftkEngkDbS0k2pPTcEjz4ffUL1BOxtcYUreP34rgFJFI5d8oqbkRy
 iaeSRYZkw93n9edibHBNBfenrRcWwg3k9bWF7/nGHgHM+84vLekqOewCuH5wwB69LjzC
 RUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749660612; x=1750265412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0dlvGLKo4B0sIQDbIAvZ7VcbmAfpOj6tEwhlh9YTog=;
 b=Eg2CBvEvDepjeW2KJRv2OOhDJ8gHqbM+DW7tZDSyoB2+wsC7BY+CFp3XEw+6DRGxH6
 a8aYYAuw+LhWH3MRRBaJWhr/UkqPHfrlc9Zhi5UiLbCY0kwB2jy2VpLB4SdESDty+6Ex
 pPY3jM63blMhJuKs7rxtSgohR3WAYiv86KAuM3xmacAJDFMU53K3vRE/6rRjizQdwdCS
 XYRTk2LisMFV7vgqgxFBdZMyPEZvdFRq121e7ng8y27Izic6ywqSq9mw0Mu4kwMgF7+6
 K/YfbUrVkUksy+4kgCk6lnYM2jhezX94stHGjux/GzWxidrii8X7qK8693r42jEpFjfX
 exGA==
X-Gm-Message-State: AOJu0YyHdLYEgAQshOZonODvrRjcjyiO20P8QtLaip0JvrzGO5foP0Xp
 swYb5otnOLvfJgeOJHjZI79W1A4EeYscD2pxcHd3jZLQrqr/jhsVrlw/QRP2qo2X9eY=
X-Gm-Gg: ASbGncuE7fulVXFyqqDHIpzLMHjFsKty5KQV0pUzLhvLVda5pJ1ex2zW/l1y2ODQtpr
 l3PbqY6kXcDLyGD2niWo3T4oabx9bF08+563zg3dsjhKc316hEbm3UWMt3xSlYAxvfWMm5BwzEa
 VTW0xikYPvUQVPHk3aNoF6+l07sBFhmrkPOh88tDO4SNBSTlXWZSNvw5B1WukgHUhIuVpqgwquw
 tP9dCdnaHPekYuFpmXjbcuHR1Fj8PPm27jy5mPVrWCJ6LKRRTQMUF4Qy1gRue8nNWE1EMBg1Ls0
 Qf+VOZOiI9VIFCybt89mMNy1aht1jsOIYQMPyvotTAptLABSnrLTM4eCJZAgLBnfOFgyBvUq7Mx
 zx4oGIYxzHv5zaFzdLmzp+Sf3vkUcl6Q4uGA1lVQ=
X-Google-Smtp-Source: AGHT+IFqNYz+tGiC5eca9MVL9FsLi9tbJuUOgoOCSptQiKIH07UNaPHTShD2LR/EupwVDLIxYz10ZA==
X-Received: by 2002:a05:622a:1b14:b0:4a6:e7a8:65b2 with SMTP id
 d75a77b69052e-4a713b855aemr50358511cf.10.1749660612246; 
 Wed, 11 Jun 2025 09:50:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6198669acsm89955581cf.65.2025.06.11.09.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 09:50:12 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:50:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>, Vanshika
 Shukla <vanshika.shukla@nxp.com>
Subject: Re: [PATCH v4 07/11] net/dpaa2: support dpmac Tx stats
Message-ID: <20250611095008.24886ed5@hermes.local>
In-Reply-To: <20250611105149.655144-8-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
 <20250611105149.655144-8-g.singh@nxp.com>
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

On Wed, 11 Jun 2025 16:21:45 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> From: Apeksha Gupta <apeksha.gupta@nxp.com>
> 
> Added all mac counters including Tx stats buckets for
> packet sizes.
> 
> Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>

Spelling error, should get fixed.

### [PATCH] net/dpaa2: support dpmac Tx stats

WARNING:TYPO_SPELLING: 'trasmitted' may be misspelled - perhaps 'transmitted'?
#41: FILE: drivers/net/dpaa2/mc/fsl_dpmac.h:433:
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
                                   ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'trasmitted' may be misspelled - perhaps 'transmitted'?
#45: FILE: drivers/net/dpaa2/mc/fsl_dpmac.h:437:
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
                                         ^^^^^^^^^^

