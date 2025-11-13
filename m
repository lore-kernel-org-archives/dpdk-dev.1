Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F4CD8CAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:29:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEE440A7A;
	Thu, 13 Nov 2025 18:29:37 +0100 (CET)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42]) by mails.dpdk.org (Postfix) with ESMTP id 3A93640151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 18:29:36 +0100 (CET)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-656de56ce7aso237056eaf.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763054975;
 x=1763659775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV3/bhvVGFDklC0x7Vlc+BjbX8DEVGEMr482rV+Nqxk=;
 b=yaaXWHkd0xkTtfxh8atIhsHQSpzbWH9fqse/pEZTDEkhu13/crwovbK+Ut0H9CfNRm
 BtPxOg/vAR+uwKpSJV511olUvvmGWkoMTWpm2JEcqfL77QZucL/eY4IFvP2JSKPmEHyp
 Gegkuog0A9kmXKGYESKPx+IH1y50VgAo77N+1hYb6zf/glploLFq1rGN95/RRz8pXlgE
 bLMbhb+4qUSupmfCEfDmiVX5LiwNhcBL88cYRlu+u42Ci8rspvwhKjpkvsbjGi6e0pT9
 rD/G0rxFZCAW8GD36YBck2DILSWq5VMalJOAU/dxO3KG5jcWnBVGj8smbeLLxePrOtDx
 7jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763054975; x=1763659775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TV3/bhvVGFDklC0x7Vlc+BjbX8DEVGEMr482rV+Nqxk=;
 b=THeloHWWB7BEbrJAGZBk55mMIimQA7Fws5PdCF1XR70LnPQzp7qUpztMxTOTMWbW6w
 fC8ttjr2ztZIgGmo9MLdBqfVgvZZ2VOSA6dz5VzA01bIv1HIHfuyldOxHFgWOQIcGg5h
 5swGmB2gyGmIni1aTjYj5a3llOBeENyMz7UP9LmhapQH2mazA51e0P4bM6NIYUFzjPAD
 6HjCxudwJyZVQSYVte1MKcKXAkogj7npcgyc0HYuOrqz/ejIUctInnYYUcMYxF05aIWP
 eCBHUSRhV+Gqo8cEeUOGhzGGKJ6KGylKCc79F3XUPdABT5+gwie5ZiOHs9IYXeDyC+j4
 0n0g==
X-Gm-Message-State: AOJu0YzdPGYZIzRbjSBDGsCPUYlD+RlUDXonhAWW2YUsYxhJS+bdyK7V
 trYuCoycGXPP8EqCnOUCq3Sv80dB2psot2GpPNvi3p4AA5Rf6+xF9tQxMJVX6tXspEE=
X-Gm-Gg: ASbGncscZDTD8ICweJVZcSWmvkzjuPL8WRn6jKgLFdKgHGeulqONUEk1o8fXnNbOFfq
 0EWIfg11vC43YO/fSOgeBxWhgyUmFwIXJbWMgf0JKObT6quswqnkoHYvXY7SxKH0pK0P+PJRwRt
 PQZjT8NUeSyy3IIQ7uqt6R9bP8qZrD3j5Dg/UOs6brNoc+oFgc58bC6HxRHwWt7vVFyntSO18BK
 H+StY+syigmPZDw/8tG4Ay0uYvjxuYyKESYNY5V1FI24XDoV8RKMAwrkfqmAH+eveaHXAcjqYhW
 tXrUrc388Wb4EH2IFLKpP7ScDb0SXmaoGD/ICTwamv38qI5H6AipeytdBdf2fIN9jjyWwb0SG9v
 gZJAZdc+BeDdhBGS4WBXhSH4hI64DkaJ0myUQpOrXvxD8plkH8W/0ig9WN5tHNWtt8KAPVqnS9O
 UW6GpXnnEXrNkJvoyReh+Dj2/FBEw+uHuhc50AIf9EskcU
X-Google-Smtp-Source: AGHT+IHsS3tNQsHyBY2PGRVSeK0NY6Y+g3admlF4VpQG1iQBQxZydLtkk7UBlFbAH+ejTKiREfy4Iw==
X-Received: by 2002:a05:6808:6411:b0:44f:8f27:e3d4 with SMTP id
 5614622812f47-450745e4a3cmr3663036b6e.67.1763054975206; 
 Thu, 13 Nov 2025 09:29:35 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6d2adasm1262388b6e.19.2025.11.13.09.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:29:35 -0800 (PST)
Date: Thu, 13 Nov 2025 09:29:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Bruce Richardson
 <bruce.richardson@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Jeff Guo <jia.guo@intel.com>
Subject: Re: [PATCH] net/ice: fix statistics read error
Message-ID: <20251113092910.015df6eb@phoenix>
In-Reply-To: <20251107074338.957352-1-zhichaox.zeng@intel.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
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

On Fri,  7 Nov 2025 15:43:38 +0800
Zhichao Zeng <zhichaox.zeng@intel.com> wrote:

> The statistics contain 40 bits. The lower 32 bits are read first, followed
> by the upper 8 bits.
>=20
> In some cases, after reading the lower 32 bits, a carry occurs from the
> lower bits, which causes the final statistics to be incorrect.
>=20
> This commit fixes this issue.
>=20
> Fixes: a37bde56314d ("net/ice: support statistics")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>

This works but may still have issues under really high load.
I have seen code like this (from ChatGPT)


/*
 * Safely read a 64-bit counter split across two 32-bit registers.
 * Handles rollover and avoids inconsistency if low overflows
 * between high and low reads.
 */
static inline uint64_t read_hw_counter_64(void)
{
    uint32_t hi1, lo, hi2;

    /*
     * Read high-low-high and check for wraparound:
     * if high changed, low overflowed during read =E2=80=94 reread.
     */
    do {
        hi1 =3D read_reg32_high();
        lo  =3D read_reg32_low();
        hi2 =3D read_reg32_high();
    } while (hi1 !=3D hi2);

    return ((uint64_t)hi1 << 32) | lo;
}
