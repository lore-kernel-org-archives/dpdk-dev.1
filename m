Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB6C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 848434279D;
	Fri,  4 Sep 2026 09:01:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D2C740297
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788505309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MpB2cBEaD8C0jhWhutcgQYrhokHs8mJX9CFNn41/4ss=;
 b=QICQk1cJ+0fjfQzo2AE12/37YfvImHy1bGUfrtC/lkwyx9jtfsNbjhB5VO8W3/ExZOL0Vc
 qc5Ik74xIcQZnEkB7DR6brCJoZPBg6CrEw4sTYwLmK4VPFbgureTL5M4oFM12FVe9Zc86c
 3ammr38iyEfw70rLtUuRxHBUR/sJ8mQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-N6UyrlQuN-6ACQnhHnisxw-1; Fri, 04 Sep 2026 03:01:47 -0400
X-MC-Unique: N6UyrlQuN-6ACQnhHnisxw-1
X-Mimecast-MFC-AGG-ID: N6UyrlQuN-6ACQnhHnisxw_1788505306
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb72bda2aso370568e87.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 00:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505306; x=1789110106;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MpB2cBEaD8C0jhWhutcgQYrhokHs8mJX9CFNn41/4ss=;
 b=SZ3xAwBj85zB6+ctp+OX81cRwiVZhogARFYJ9I4HG+CVzSIH5QTEeiYMU4+jN4zlzx
 R9CrDLTybqqqDPrZOXlwYmb/F73DVH5w5QnLLpF8B6NoKs0ar/WiY8xmsil+jyX+NylJ
 k12CYSeN8xmYo/rrWApUGNBtp7wHnyNi1lobwa/lAGtDLGh0CZwab5Fp0QILw8OWMcM4
 6d5MRnaBophnLyn9LvUhAoZlHYxuoGBZTEihjvwQmBeZNuGNks1uB/j2WhqvO3gQYunn
 9z0lNpwvvX/o21tsVIwwbTFmvSODIhbXqvlHJUBN4Rl0GvVIOd14uAwvvRmy3CJqSDYg
 CeGA==
X-Gm-Message-State: AFuF++mYuFkdCivCCB9bJ+WP+wlFIANInPrA1AFFTlCTpc34P5xjx0Au
 HHFxqfI/04750zbfEHkeCOgwkEbExZZA7upkmPYdjEOoukepOU69Aii4pl0vxfg+XG3t9vVlN0U
 sQp1cQGSJiq4vglHShQRiKwV8XyRVK7o98Gma4RNy0ytapmQ1krmBPWry3gawYIqmBRolBPQBqa
 yv54f7QVfBmTBvxfxHryY=
X-Gm-Gg: AYBFou3oD9Hjuf0nxmwSM/+8XIxgKUD1a3uoRXGxn/DmWlKUaB5FQRArWH5ORYuLvu9
 coSH5tt8HP9nb7hSKVST0+89oozGKer/JtrxyYnFSOHz7u5wMi+IfQUGUIoI992ILhefe8tj4cd
 XtomonU67/DGnsS43B55hVRvFBW3WXt7WDzvOvT9Mlm+6m3VuJ6yckTR8QIW+2XCmT/VANIRZqS
 STj8PSd0D5VFy9hS2eCYVMwLT6208FREMdgDYIuG7JuOORm
X-Received: by 2002:a05:6512:239f:b0:5b6:184c:7d9a with SMTP id
 2adb3069b0e04-5b6184c7ee4mr363137e87.35.1788505306238; 
 Fri, 04 Sep 2026 00:01:46 -0700 (PDT)
X-Received: by 2002:a05:6512:239f:b0:5b6:184c:7d9a with SMTP id
 2adb3069b0e04-5b6184c7ee4mr363129e87.35.1788505305744; Fri, 04 Sep 2026
 00:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-5-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-5-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 09:01:33 +0200
X-Gm-Features: AcwNN1VRvfnGtyWqXC-mBDYfSw-924K9rxKx7u2wkuCnHra6Bd4l7ij8bSWxHmY
Message-ID: <CAJFAV8zLjS+6Z-sXu_xw-Uu9Ecm3o28uMP+BUZ_P_iEQAym=yA@mail.gmail.com>
Subject: Re: [PATCH 04/13] net/iavf: deduplicate tunnel field fill functions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UnSyQ8ni6GbTdDiur2u848neEtMK2UYMS0nCgpSmZKE_1788505306
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

On Thu, 3 Sept 2026 at 19:02, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Each of the avx2 and avx512 Tx functions used two separate subfunctions
> to insert the tunneling fields into the context descriptor. Except for
> some minor differences (a flags guard on one) the two were identical, so
> remove the one missing the additional guard.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for the cleanup.

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

