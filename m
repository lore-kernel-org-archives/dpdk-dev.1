Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E54C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C284D4060F;
	Mon, 31 Aug 2026 12:58:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 744104025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788173929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Wcpn61mjhkVQurrg0n//KA8D1zPwhVK1pcdrrvYBw4=;
 b=TF/j8lRx5NUUjRn8rftq0eXWkd8dQAUUPUvm4puazmnbryhRX40I/7rtY42NtUr+Qgx8U2
 TQj1sUgcmgmc7kwm2qi76oykqgupPnSzaY9WeEF3hTLpwFHNaWX8R7gcyHlYuPTZcMKiE7
 Zphx3/j1y9/Jys2/nOsl+yp52QBb+DA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-n_W6rnCPPlW5admV8UdjnA-1; Mon, 31 Aug 2026 06:58:47 -0400
X-MC-Unique: n_W6rnCPPlW5admV8UdjnA-1
X-Mimecast-MFC-AGG-ID: n_W6rnCPPlW5admV8UdjnA_1788173926
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a1acc0932fso12533351fa.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 03:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788173926; x=1788778726;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1Wcpn61mjhkVQurrg0n//KA8D1zPwhVK1pcdrrvYBw4=;
 b=K3RmncXPUAYIL0/Amg7Av6DemGMliIajzCjtwYNsDD4VBmBFwEZHX9Mjz9I4IeeIHs
 AS01vbT2odKsGkt4TgibSj7U6k0zlW4P4zE4VZHHVaJKaw6UUWeB+vCedSVfbmybFfve
 cztZMfWrBrqRxMhryE54HnpTKvECrmPYw23902FQHh/wcR8Bdcnf87XWopG4Nqun0DPf
 os4XYWZGKytmyH3Iy/COdGk+atecKrxOhfodBmGonGz/hsfBgf+UVHts7vT212+OBeAQ
 OryiEvv/zkUPFAjtIbLswyD6MDYTvILqWImVECm3L1lWxvvb727PtpH5bQCReVmRrm1A
 hZyg==
X-Gm-Message-State: AFuF++k66uHKCfLSFhynayOwsw0ro3k2mdmwenwDcKT4ASldCdBTp2ZY
 lVbbV4T6diXWYwbRS7gmoOMB6DJ7XkCavEc2U9onwkUYgtNsX/fAAPJ84NILSrNdvLn3yS9rjr/
 3MsxTbejGRyg5+NCFdP7MgCMiVEKo6g/jWOxB5eUkVO+YmVSRNC0+xt4oxeOESmEQ86wm2nugR4
 fWJQqIl3TEvtIwij3cLC9UMrnuXps=
X-Gm-Gg: AYBFou2DTqkBXkxUJsWp8fl+uHlCav0FD+J2Zn707CdyD9zjfuQ5LIov5VBlRLMheOR
 vzDxAY1DX0NW2bY93d8rUORxDELLSiBS/Q3NUYY61D9fZKTMMaRBvwBcF4TAANNC9DDBnifYRhB
 C+mV5ZND5f4EC/1TPPTyLFBXSoxpuZV03lJ+mAg7Q9E9W1jqHvG5Qm1HtK08BC+tafuX7kagYO/
 kObSpJkQOB569JKutqo2AUiuOL5FCqYisBhtPxJNr/VEGLc
X-Received: by 2002:a05:651c:15c2:10b0:39f:75f5:907d with SMTP id
 38308e7fff4ca-3a301801b4bmr35424291fa.2.1788173925856; 
 Mon, 31 Aug 2026 03:58:45 -0700 (PDT)
X-Received: by 2002:a05:651c:15c2:10b0:39f:75f5:907d with SMTP id
 38308e7fff4ca-3a301801b4bmr35424221fa.2.1788173925309; Mon, 31 Aug 2026
 03:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-8-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-8-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Aug 2026 12:58:32 +0200
X-Gm-Features: AcwNN1Xre71Md8jTGMX_rVS_n-P-u_g4f7T1F-hR1gv1ywNoxrmtxDs-midIxdY
Message-ID: <CAJFAV8zUKSvBfV-tCgeNCrcoCTUw4uVbvs9MYrsbfk-=Mm=yxQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] net/iavf: remove undocumented conditional macros
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nGgINKotb_Yy2g8x_0UNpE66YTcw53iyvwlFVEun4Kc_1788173926
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 31 Aug 2026 at 12:27, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The iavf driver included two #defines which enabled the QinQ and
> checksum offload in the code. The intent as documented in code comments
> was that any user not taking advantage of these features could remove
> the #defines to cut out some code. However, this was never actually
> publicly documented, and the use of these defines was never tested in
> any builds, making them fragile - if not already broken. Therefore, just
> remove these build time macros.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Though unrelated to current series, were the AVX512 knobs tested?

#define IAVF_RX_CSUM_OFFLOAD
#define IAVF_RX_VLAN_OFFLOAD
#define IAVF_RX_RSS_OFFLOAD
#define IAVF_RX_PTYPE_OFFLOAD
#define IAVF_RX_FDIR_OFFLOAD
#define IAVF_RX_TS_OFFLOAD


-- 
David Marchand

