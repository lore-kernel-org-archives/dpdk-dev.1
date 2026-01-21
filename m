Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3CC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 225E242E69;
	Wed, 21 Jan 2026 22:01:34 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id A5F164027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:01:32 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so200163f8f.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029292;
 x=1769634092; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7Wwbg+5kD8e2z4Z1u1nJ5jdmIfWuKzWhIA3NAxJmFo=;
 b=EqLS6U72FDWX8p3U8OSht3ZWqflItbhlexytBex294hEqiZxPb+viO9ME01A0cND9Z
 YxpEqYmIcb3mjVpRpuKOIDA9C2z29wsImHIkLaMzCFULEPvmPnG2h5tkIFL5pgXbNMP+
 IROdoyI7EaCpxWiYIfiwJN2+kqMJ9r5gxaT90TPUxznDRfhwUVyIPRWhV3pi9D2Nc4lG
 wqOmb74i0LuKzcUrc7SSvcUWo7f52dSu2R4Rp/mwO4XXBqNV6cSdBef257J0UUGgdzIy
 tIteTiSee1Pj5Xsj9yuZKHke4rrLxnS6iesQMiKAhJefL208yDIl/K7/xmNuQoWDsAhI
 kAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029292; x=1769634092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7Wwbg+5kD8e2z4Z1u1nJ5jdmIfWuKzWhIA3NAxJmFo=;
 b=KKZAHZBaVPGURgY3QcDqVhAL0/543H/g8Dw3rskxmDMQmiBBNbdI8HPKVWFQ4HdtXJ
 zVTIAA4F8jEDWyOn6Ujpi6OQC2KuJhXdeAM1rh3XmkSld2TUV3KWhIX34d6WHNa3Tijg
 UJP9nR9OHO0I44FBVWnN/76YKst6au+hM/+N2jntqtFc+zFfYZ+PjArhTAST4BKAsM5b
 zJIIuyGj6FJ/nTSXo9WJ3wanxDAlywaaGS4TkVWDJqicO37ARmYnE8QjxG2OsSSpmSwU
 1wk55JX7Cb9KfsPC1suu/OLdeKLMq1BGdpKhjuvFS5+Q7GsJ/0Qn94Y57LHUGg2JQNcf
 z0zA==
X-Gm-Message-State: AOJu0YzHqDjjVzgYtgCxWKoc6dp2w+koKlQotIRtwtiwwV2DCS1gFt/c
 n2udtU+qAsQv7kk3JUaavoxfmHVvutNtMJqWSlwMte+Kcr4TyNT/hpppT6bfqOvbKoRHhGsgGyQ
 18lVZ
X-Gm-Gg: AZuq6aLgN+RPfejqRJ1M2TOypce1t/BqlR3iGVXY+rCTahQVg5V3hR4jmeoxFaGuGT4
 C8KPud152RoYYLo3gIP1NNMVmePbCOlstuK/Vjfs3yGK60jaMC3un2A8gq1rifz7AuY3ok1dLew
 nAW6X9YjNnaMwGDynm3Oqe2nQmkeGLiEFhnJVSlK/+xUaYJfBd6Qy91ALZUJUDaTXbqoLzMYntL
 00gWG585acqqoqW0hEvczFb/GArvjIY94ZaVb7KeVu9cRZSlFOYWZy4glgtaOC6CLuCam4hQ7Zl
 m9i505Txcc8iD5wtl0RJCTx8vefrOutMoUw47o60MdBGhtANXWAvxdIre/TgHvMy6qh/dA60BDJ
 37UuzYliDkJlGVx4pE0+iummjRVUXieDsqFRrOVIf+gmxxtDeRGdv6VOFVyh21m26bWZRvM0jpb
 Ruj1maBHSRp6Wdf4HvMAHT/jHdDUA9WCBmtF3uvNbVPCsMY0TlKRWa
X-Received: by 2002:a05:6000:2410:b0:430:f437:5a6d with SMTP id
 ffacd0b85a97d-43569998f5dmr27637958f8f.22.1769029292065; 
 Wed, 21 Jan 2026 13:01:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm37682258f8f.19.2026.01.21.13.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:01:31 -0800 (PST)
Date: Wed, 21 Jan 2026 13:01:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Pavan Nikhilesh <pbhagavatula@marvell.com>, Shijith Thotton
 <sthotton@marvell.com>
Subject: Re: [RFC 2/3] event/cnxk: add pause to spinloops
Message-ID: <20260121130126.6f8656eb@phoenix.local>
In-Reply-To: <20260121180845.889190-3-stephen@networkplumber.org>
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260121180845.889190-3-stephen@networkplumber.org>
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

On Wed, 21 Jan 2026 10:05:43 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
> index 09f84091ab..887c0800e2 100644
> --- a/drivers/event/cnxk/cnxk_tim_worker.h
> +++ b/drivers/event/cnxk/cnxk_tim_worker.h
> @@ -405,9 +405,9 @@ cnxk_tim_add_entry_mp(struct cnxk_tim_ring *const tim_ring,
>  			     : [crem] "r"(&bkt->w1)
>  			     : "memory");
>  #else
> -		while (rte_atomic_load_explicit((int64_t __rte_atomic *)&bkt->w1,
> +		while (rte_atomic_load_explicit((int64_t __rte_atomic  *)&bkt->w1,
>  						rte_memory_order_relaxed) < 0)
> -			;
> +			rte_pause();
>  #endif

I noticed while looking at the code there is assembly to do the wait for instructions.
Why doesn't this driver use the rte_unit_equal_64 instead?
