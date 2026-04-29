Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F667CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 15:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF84740689;
	Wed, 29 Apr 2026 17:13:06 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id E7D5A40673
 for <dev@dpdk.org>; Wed, 29 Apr 2026 17:13:04 +0200 (CEST)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso9875034a34.2
 for <dev@dpdk.org>; Wed, 29 Apr 2026 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777475584;
 x=1778080384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkvsCKEhYvK74FFDKDVL0xPrtZ9MryjWAGR6mzjbZWA=;
 b=DMauph7E+mTLN1E5l/SONvVEfPGPD2//u6+OKKFZ17WMsPNTBzNnHsqbDRgNJeKAx/
 vYpXyfFWAnkP1hEe923PLOJLD8Sf5Ta3RA+3+Ct6s8VLqm1KwMTUEksX3qwUMia6w1ue
 9lTlCwsG6nuLpp1M+jOGC0bLsyaceIOa7tTFVlLQvDVm9ZzdKGm9VIGAuwVMcIqIp1qO
 BTejh0ZMrwRgVdKUl+m4RoGwbQgTrPHvpy8uBVc5b7jC/wAH1J8bGrX+xHIcaQY4NSK5
 uTyfParh1aW2P2STnzxTIsEIpICdVEvr14MkLQn4JTHuKvbcGvsz3Di0FlwlpBaZj07L
 KEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777475584; x=1778080384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkvsCKEhYvK74FFDKDVL0xPrtZ9MryjWAGR6mzjbZWA=;
 b=QdyjD/Lb5DYWXi4AqiZCsPTsLv4HIZrE+MpxzeggvYrFy12wcDOnoiXM/dOMZnrPge
 GPJ8Eo9fBo0OQmcTV4Rqr4ojX95VfzsXz8+Y/UUs9j6oK/SXXGgw9O/DCRUmEsGgOWIv
 gan+lO8nCA/fTR56YcbZAMVsSbQo57h8Dl+WBm3niwN5WuX7kWZyri2PwJGiZIXFiyim
 A8/L7saiO5OIma+GLEk45fPPSHjPzDvVZUs09W7HutyTBXw7F8QuPjFPC97kwFQaNo4v
 yeOikq2/a2e52rvwZPH0c6/1SIkeyooMoBRom/D6P+IDKE7BFqTjdfWgJeSSAqiF6uNC
 yEoQ==
X-Gm-Message-State: AOJu0Ywa1FziFb3XsrdUQfqriIjfxXK9ZO12rVYfJpXt3NxH0AkTlYI9
 N12nMVMe3b6GtqLfkZwNhyVnIH0luP3rfoH7TTL5jELq2mi9hzwDmH/GqK4qVElAO2Y=
X-Gm-Gg: AeBDietc31tybXzAjkKW53hLCObAGgmT57d4Zj8ccE1WcWoyex6WQGYGk5tAPWZKlEo
 zYpGzGpH6JiZZxPityXtPMChn7G+TfaxZd4IQYN4meI+WL7zeQjMHqyn8B79Jn5fGJNwIceJ0m7
 DLc0eD+mxQTK+07T7spWOuwIoQfehDnrOyiQjSuseqSsZP38DA1X4AJhM2RqnyWIK0IY36icm2R
 l4ty4L/5JO19TIEVr/kc5Xiq0nUd17c7OUMtofPcbo/N7GCwCySPEITL2GfJtjctdISb17YIsSJ
 lVcMyfPGZ3zdjpK33Rb/tqXefWQnXZRUD/mhbyYOmzZ6Q9StQ3eTeUFYxZSoMFoaot56fAU2byz
 rsyCVXq2OaH/E9VFqI0pzeyaOWdrpDpxbK4E0aagrnUqkHe25etCFIghIvul/TyRcbkCyLDVE0u
 XunCZKUxfHWw8oh2liTA6ukgqXM92QFsSfK2KSoL0aXWVU4g==
X-Received: by 2002:a05:6820:198b:b0:695:b571:e57a with SMTP id
 006d021491bc7-6965cb3a35bmr4056598eaf.33.1777475583967; 
 Wed, 29 Apr 2026 08:13:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e981839sm2161537fac.13.2026.04.29.08.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:13:03 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:12:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 12/20] net/txgbe: fix link stability for 25G NIC
Message-ID: <20260429081246.7e93cbba@phoenix.local>
In-Reply-To: <20260429102515.58880-13-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-13-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 29 Apr 2026 18:25:06 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The link was previously configured via firmware, but this approach
> resulted in unstable link behavior. To resolve the issue, re-add the
> PHY configuration flow directly into the driver.
>=20
> Fixes: ead3616f630d ("net/txgbe: support PHY configuration via SW-FW mail=
box")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

AI review feedback spotted some things:

Review of this patch is partial; the patch adds 2,489 lines in a new txgbe_=
e56.c file plus 1,742-line and 275-line headers, and a full per-function tr=
ace was not completed. From what I have looked at:
Info: drivers/net/txgbe/base/txgbe_e56.c defines a generic file-scope helpe=
r named compare for qsort. Even though it's static, the name is unhelpfully=
 generic; consider txgbe_e56_int_cmp or similar.
Warning: txgbe_setup_phy_link_aml(): when txgbe_set_link_to_amlite() return=
s TXGBE_ERR_TIMEOUT the function falls through to the out: label, which the=
n reads TXGBE_PORTSTAT and re-checks link_up. But in the timeout path link_=
up is whatever the earlier check_phy_link loop left it as, and the function=
 clears hw->link_valid only in this branch =E2=80=94 yet check_phy_link rea=
ds if (!hw->link_valid) *link_up =3D false;. After clearing link_valid, no =
further check_phy_link is called before the out: block reads link_up, so th=
e logic still works, but it's fragile. Worth a comment or restructure.
