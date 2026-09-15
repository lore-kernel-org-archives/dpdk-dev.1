Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD128C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F405742E44;
	Tue, 15 Sep 2026 15:39:41 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 3D87740DDC
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:39:41 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso2974755d50.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 06:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789479580; cv=none;
 d=google.com; s=arc-20260327;
 b=hpGeTa8PyYUcu/XK/nD41s3U7Plw6yyIzE5o1jPUlwbaKn08YvBUSjNCs6BUhidHHI
 ZncX8RG/PojfTEHnElkJ7afW1mNJBbDCRzK5PoJkVEf8CbnOMX6QAFtq9z93A7EDYTjB
 raS4Scck86vDN4T/kuJE3wqn+Bfqi3/Tphv7q5oA7OUWKbxppUSBsQeSBhbH4ghQ5GCN
 RYZffhqWbCt6apF22sIIiHzkA1VaBrmgcyqRjlNhp4WenqaJHpP6KXm0nwjE4ty9M4HN
 CT6K7ja8qBLuXjl3ho5Pzo0FbIyX1arP5IXPPU9T5VsDQsT03anRZ1nVeRK5iT5PGSQ0
 SKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mMKOMdbtEkp9wcgW4qVwMIB1+CVBh+JI/rOWxc5RC9w=;
 fh=lGafLbKMarUBBx+DhcjjdkLU9K039MEAwtaRTIfxaO4=;
 b=W0IeqD/s6b8PtFNP+ZN3K2FFc+FoPoo/coFFD1SB+qtzrQMwWkOGT9cmVoMIHO+876
 C8Do7XNyhNx78ddh1/ti2JR6i4OvKU38J/y6eMT5KgqM3kwwIOI5Ujmz3R3kAB7K5NCz
 Z4wZ1WIWEQgDYvVHnW0jjxqL+uGYmHdN04f2VtWkIAAi0laGLRwjqMyjh0NFj1sfOcaa
 XxQHuVSZXLatndaWfZ3Q00OG+7DSZZFXY0xsvWPKYzCR3V6WM0X4yg2vvw1L4uDrbAFO
 rmQ/CmdkYVD/RVvj7W6H+xipeGQVjW2k5tUYBIfX9sXWVKnyCa70I3QabpmM4LM4726R
 8Qnw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789479580; x=1790084380; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mMKOMdbtEkp9wcgW4qVwMIB1+CVBh+JI/rOWxc5RC9w=;
 b=EdlcpmSzYpgx4IG76mzU6Kvoc4GwnNQFJmtVOCxCsMI9GzNNmcH85JKzWEzgbLSeLp
 oEfKSPCYQq0oa2+fh5PqjfF3inLcyIXul1ohts+0WzElY9f9SbAfSXLoxGvaD7RlLV8W
 Ny0DEedBCuhz5bFId21ArC5g847yQv3HxgNn3VuUOaq0vvG1eAwf+r3he0qJUaHdvkqT
 9MoF6VDSeIt6OJk6UNlgEX9hdXxYqMAWAOusGFPGVcTdSeyG9ZItS7EWN/7rAU5/4M7/
 tRt1OyPbAg3clYB5tzKGvT5gcMT0jGSNh4aeU27FH0R06G7vEOdArn/BHCR7EIa6kNPq
 BW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789479580; x=1790084380;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMKOMdbtEkp9wcgW4qVwMIB1+CVBh+JI/rOWxc5RC9w=;
 b=oZGTEttjVAqBS6+nAJFQOICVzz0VZE7quoJirBHPOBhwFumcEjTJ055V9R4LPi4SVB
 iWm7Q9iL4AM+kAcNtnhzLofKjnZ9hdN1UiGrpuyn9rgqH1rVwWloLo4YEomaEM2oYwob
 YGH4d1g4ySNYEwo0iHPoUPa2kbNJLKnPSou7Mm99KhWQDHMBEJClW2ojXe09GKOtYfkN
 sr0j7C2iQi2hBCjGBe0sQYBe/m6eer9N2xik+IfNQN7CfZ6nPgGQ69MyfFn3vY+3uWvb
 CqE0iO3A3b5DA1QKSQ1J5WRQrLEfXUzI5haUTON5dx55xhiiddMBXfiobiEzlvVvVsGI
 g9nA==
X-Forwarded-Encrypted: i=1;
 AKwUvByr2laOqijbu3U0SlKWjfjIPGjzk99Sj6soxsOSqrcfR1dOjOlhbec4lG78uSIoT/K+jxk=@dpdk.org
X-Gm-Message-State: AFuF++mWtmv6d3y8GwSSgCvbuSme9snzY17RwQh2QzquDwLBXRmr+GWO
 KCuyFWFel1ae+WAKtshvio/6GaHI4WoJAIBUPwm84hUOqcamga0rVRFpyUZ1Kk+1RbUYbI/ZIjl
 Gm0fuIbTZGIjEmRKI7W/S7u8G93wuznY=
X-Gm-Gg: AYBFou1XSoYT/E6qtrdC5poh3zbwXU95Cg0ni9RbnTJmdbVZ09KnAgWJtUuR7PE/ew9
 lsLGDDPYDwtuRynRF3W3Q1Br43Q+DS3zQ2kRmZbwuOQli3ayKye5upQaoEpS7vp73rwGl6upaoF
 ewYzWPcV/L8Fj86xqFYp1GwDIxQzlRaW+pnhkeTC2Jc4tqQQHZe9LTDo83yllxidBlitiqagHby
 V/G5eb0hsdy4uul4EbYnxSmiy8ws9Dz1igCIERTGmedDhER2fxFWWpMaWXId1NPx9m59sa0JwJq
 iAzcbnaG9WmO8JBwNTl4pSeSfIK2h9VnZk5RdFbpZwE022Yf5iIrfiy95BGocY7+TLZHiS+0CO6
 +LFp3970WRP2E2mLt+u2JjNOluoi/sHKkG2Og5xV3/DbdD6IMBJep9OMFP46CuTwTrZGRC0g2NA
 wWTfUn4rtOjph7tkHt
X-Received: by 2002:a53:ef11:0:b0:66f:c1bc:87fc with SMTP id
 956f58d0204a3-6714e1ad84fmr1582178d50.85.1789479580483; Tue, 15 Sep 2026
 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260909020012.23261-1-pbhagavatula@marvell.com>
 <20260909020012.23261-2-pbhagavatula@marvell.com>
In-Reply-To: <20260909020012.23261-2-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 19:09:14 +0530
X-Gm-Features: AcwNN1VSjhTVADaZ1pVEvOgCWmCcOJZZVdgDbYqhhCQZksnIzWHGnBZBNxxPilw
Message-ID: <CALBAE1Pmig4wsgZiKri=1jz-RG=pLfP5Q9ft-0z0n2jqX4P3eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] event/cnxk: fix out of bounds access in eventdev
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>, dev@dpdk.org,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 9, 2026 at 7:30=E2=80=AFAM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> The devargs parsing helpers wrote to the parameter structure for as
> long as tokens remained, so supplying more tokens than expected
> overflowed the fixed-size structures. Bound each loop to the
> structure size and reject input that contains extra tokens.
>
> Likewise, cnxk_sso_xstats_get() and cnxk_sso_xstats_reset() indexed
> the xstats array with caller-supplied IDs that were never validated,
> so out-of-range IDs could access past the array. Skip any ID that
> falls outside the valid range.
>
> cnxk_tim_add_entry_tmo_hwwqe() used cnt as a count of LMT lines, not
> timers, when computing the remainder, so nb_timers >=3D 8 wrote past
> the LMT line. Convert cnt to a timer count first.
>
> Fixes: 38c2e3240ba8 ("event/cnxk: add option to control SSO HWGRP QoS")
> Fixes: 20345cbda6d3 ("event/cnxk: support WQE stashing")
> Fixes: b5a52c9d97e2 ("event/cnxk: add event port and queue xstats")
> Fixes: 8a3d58c189fd ("event/cnxk: add option to control timer adapters")
> Fixes: 822d4ef519f6 ("event/cnxk: add CN20K timer adapter")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Series applied to dpdk-next-net-eventdev/for-main. Thanks
