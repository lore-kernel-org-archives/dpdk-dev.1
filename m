Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83564C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7B76402DD;
	Wed,  5 Mar 2025 22:34:42 +0100 (CET)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id 69FFE40279
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:34:41 +0100 (CET)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e60f212fee7so3049152276.1
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741210481; x=1741815281; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jvU4HHcW3QwQ2EPiMdGhIWY7HSZG4AQ4RnR+l1Rhq8A=;
 b=HyrNgoMyvorMd9La5U4RNdM2hABqcpOIzWUenG7G78efq83ienlmWi2VAp51vHc7VQ
 10A7P+dlfmzV+SsrDal16ZpN54VHyz6Dk3yQuGqCydXJRqg4FafNjeKiTRfQaVgePbQw
 yc9k4ghOC1Ce2Xr4peOf9AO3JkAA2OumiYoHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210481; x=1741815281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvU4HHcW3QwQ2EPiMdGhIWY7HSZG4AQ4RnR+l1Rhq8A=;
 b=TKs1jQKcfOwKlMvAJb/Wa/VzIBQB8OmEQKJyMtThZXjQSUQ6iGsY/gdLnal8ADrjnN
 Sfx4OWT/WX+EI/KLi/DE+Vc2QTXW8BrE2FzlGZEp7dWfAhKdjnYuSMtCe2WugYYnznj4
 xRTsYOHpVLVPnOVr5hVONM5Zr7/EHCjro/Uf2iBGC78u5s+2+6TrXUrdb03yiTHsApEM
 i/8RhIjvhd2nzN05AZNUQsSS8s8E4XmiiXB2VjQ5fUcDVSGblbcSU4UEaX7S3nnP3xq4
 42drZcl4QRMgK7OFV9A0DUbDVQNhteyR2+t83gnyss8PtZCUtwhj13S87hhCwhwtbFUd
 wOVg==
X-Gm-Message-State: AOJu0YyjwzaRQ1JOlUrsC8EGIn3tDtQ5s0GrF0nkq2Q0o80R6Qh1vylj
 SWXnvA+nwKbpi4g7H/8BZI9T5cO65+iZSt/1kMV7TCgHejiL3jdNMS4puPJQ3vp7acEGSZT9iSo
 d55CLrlNAAV64cH5NfxvyIwDv/OfaVlxbCdQ+ijvs5/yHimF2
X-Gm-Gg: ASbGncvdbmHXndZCateGvr+v+TfyKk4Tg63NaBpi8BFKmWF0Ez0I5VRN25NTQUs70fV
 ffiPTufRlbkPZRNZCbQOtJJBKt5DTH1wfCZZKFCOX/BBQa1ySNNiH1XQe+hI1xHyQzVm9f7JuYu
 1P8CVteW5BIkxpijMejy6Arfki29gkjgGmDQhCXgoMt8RHiNW4V4By7VgvO5eb
X-Google-Smtp-Source: AGHT+IFjaZo6cKcQKvEUyE5Nvn4Ee3nLiKZODPROnW4wA59VuAgzFJ+VaU1S4F2AkE7igAgmdiEZyBZuQ2fO5XZ1yqo=
X-Received: by 2002:a05:690c:338a:b0:6fd:a226:fb50 with SMTP id
 00721157ae682-6fda307bd1cmr77364457b3.13.1741210480714; Wed, 05 Mar 2025
 13:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-4-luca.vizzarro@arm.com>
 <CABD7UXNmGggR7MMysLVcyF=80WzOaee-eDcenVgFNoThrdPa4A@mail.gmail.com>
In-Reply-To: <CABD7UXNmGggR7MMysLVcyF=80WzOaee-eDcenVgFNoThrdPa4A@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:34:30 -0500
X-Gm-Features: AQ5f1JpuyNonRSDEZW5gRtFOZaEyDMMSgRibtkVBiFmKAc2FLwT0USk_HSFzc8c
Message-ID: <CABD7UXM5B970cR1NzEUZdDAnp_Vy1yhsMfzpAiwTLbF3zPeKDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] dts: add tmp directory facility
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Also, use is misspelled in the commit message
