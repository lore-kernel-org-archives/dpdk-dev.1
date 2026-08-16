Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA3C5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 16:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C904640294;
	Sun, 16 Aug 2026 18:56:07 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 56B8840289
 for <dev@dpdk.org>; Sun, 16 Aug 2026 18:56:06 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cc891373e0so33535815ad.2
 for <dev@dpdk.org>; Sun, 16 Aug 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786899365;
 x=1787504165; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C0DsydW+ktqyTvEyZ9end0t7uLhlan5TrTbNOiJtFtc=;
 b=NWCkJ+4n+oK8dNRqLMoRf/fe3IwENZzPbyWjhlCn6Ml6O/9Wq3sxLh0f7xSbhPR9qk
 0KiBf2705raEwXU4ByFH3iWh/h7XkggtMYvMN6UJ6y8LlcqOMAb2LOlulgrI2gCWLsEM
 Kf2y6DzvKAYULjmYwVvykA8LeDVm6r9ASr0uZSxXxlkqJhx5XAfFtP/W24H9y7ZUtGDz
 rE2z9R1s/lleK89lbOH8HSMEwIuFdvgIfQOw128Hrvr3+4AwgGXq0F2UqO3/M64BkjJ0
 X+E6QDoFmNhYqf/gyyNyLHr2bwRmGFASOynj7dRGEIs2pTSw6zbc5xmbHG8bnb4Cj2iU
 e5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786899365; x=1787504165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C0DsydW+ktqyTvEyZ9end0t7uLhlan5TrTbNOiJtFtc=;
 b=SbAIBGG0/b5JbKBMyL3BQhpl8Pd67vtWG7l8AF3rhq3Wvm5MWgZk98ZKX9Z+cauU0f
 NRstkWDsq+N0ib5n4rbOHNWwNRLvoBHLGGCoNjPnW6rMswPEVMpmCAJEtamhYUFFzLSu
 jzLG6jY990odtwF2HMIct3QQ/Zwxr3J+9kaWO/en9Gg84fyVqsn264OuRvBHWGKj+gGV
 /3mnPp/hNdMh2xJ3wtE3JkLl02G2fy38c7oL/ZSbmTLy0wJ28GAQ/FchL+KtuL5UGSin
 VZogZzZsQb9OpgnFFNayEvrupnZWR1weGRgmhOMShwZH+2P0AhYfCnxKimvvRwab8rvA
 8qUA==
X-Gm-Message-State: AOJu0Yy7mZm+9d3TuZLGigV0RFxdPD47anEPiuc/u6aLiCLBGcaArKj+
 QBXGY67kPqC9RGHzUbS7cGGhpcW3ABfyWlqoZz8bhnowf9l3pKeQnZnHyspmW+iToQo=
X-Gm-Gg: AR+sD1293a4pjbLHGa3dywg2/Li9uHiy8P9ALFTQKNANIluyU1e58NiHDn74S8S8C9q
 BfGiM5SC9NvB5LgOLx97wW+UMWs5GwQcHmRfelW1my65yVrOk5Fh7nqyMidwefQBOd0a7i7QA+I
 1qIX71kaIzGgvfKifoaAe1VO+D/0GYvZfTAjMv6AUhTBCv8SDqW6/OdtByQNa2LTSjaUGMdTlUm
 8opur0QpXmaQ+4t5gcGGE3MFHqVQ/bohZQv6/PgY3dlrbbwFKetuARX3KteC5uAfdIIBN9JIlcm
 UBm0MhOC2ze0dPdFAU25zG7olmZ7r4E5qwvKMtS4JOYci9Gimuv5bYgCnnSDqaldvkXLMb4qrNu
 Oe+5mI6Ma71wb4qFBsDjoR4r/MmWM1czyimtpAcMBTzVIku0ZQk6B60kPwR4yq1XMZiF1X1vs0J
 HHecFHuZAwZhTp4h51fxteEa+vybWFxMHDImMGuKwLivrtIsC6X6nnKhQXFFxptUZQxq708wXd1
 qvyx0p5r907rj6j2XN2NlrkMjBWgQ==
X-Received: by 2002:a17:903:2312:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d3b0dbbf0cmr200250785ad.8.1786899365215; 
 Sun, 16 Aug 2026 09:56:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03d4sm24972964eec.15.2026.08.16.09.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 09:56:05 -0700 (PDT)
Date: Sun, 16 Aug 2026 09:55:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 1/3] common/sfc_efx/base: update MCDI headers
Message-ID: <20260816095553.0e286581@phoenix.local>
In-Reply-To: <20260814125608.13358-2-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125608.13358-1-ivan.malov@arknetworks.am>
 <20260814125608.13358-2-ivan.malov@arknetworks.am>
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

On Fri, 14 Aug 2026 16:56:06 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Selectively import MCDI changes from the in-house libefx repository
> to meet the needs of the feature support patches that will follow.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> ---

A couple of checkpatch warnings on this patch.
Although merged to next-net, would still be good to fix.


### [PATCH] common/sfc_efx/base: update MCDI headers

WARNING:TYPO_SPELLING: 'Coalesed' may be misspelled - perhaps 'Coalesced'?
#155: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:12857:
+/* enum: TX Events Coalesed. */
                    ^^^^^^^^

WARNING:TYPO_SPELLING: 'Coalesed' may be misspelled - perhaps 'Coalesced'?
#197: FILE: drivers/common/sfc_efx/base/efx_regs_mcdi.h:12899:
+/* enum: RX Events Coalesed. */
                    ^^^^^^^^

total: 0 errors, 2 warnings, 378 lines checked

### [PATCH] common/sfc_efx/base: indicate dummy netport properties on VF

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#41: FILE: drivers/common/sfc_efx/base/efx_np.c:261:
+			    sizeof (*loopback_cap_maskp));

total: 0 errors, 1 warnings, 65 lines checked
