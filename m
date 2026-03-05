Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A64F30946
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 12:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90B284029D;
	Thu,  5 Mar 2026 13:53:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 648CC4027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 13:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772715220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+PUty2WlMtVnpS6FqJaG97EWLPvVnxue+KkVVlszEg=;
 b=HCt1v93HGSBTCsYMpfJGIMwdmrp4Xq0JOSPLj6RTChAhs6JIvlRzM5Xn4Ymvgq8nR3vzp9
 JdElO8uFAK4H33om3apMNt4TqFvvgAoVA1CFZ3zigxjbitHRPLYA0KcCEf7O+KKZjTcwFg
 +26Kmz2Vqll5RFfr9wUZml4f5QdPPEc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-CH-ml3mrNhaiWDTAELc69g-1; Thu, 05 Mar 2026 07:53:39 -0500
X-MC-Unique: CH-ml3mrNhaiWDTAELc69g-1
X-Mimecast-MFC-AGG-ID: CH-ml3mrNhaiWDTAELc69g_1772715218
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38a2ee00cbaso12049521fa.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 04:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772715217; x=1773320017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+PUty2WlMtVnpS6FqJaG97EWLPvVnxue+KkVVlszEg=;
 b=JlijOVhWxa0V+wdn+8jMN/P//2jC+1bgfTnkMVI9oJCvZzh4UMfT3sndZfMfOUk5v1
 Cd7RL2mRW+bC608Vk8PANBWa60JrUuUCMjJOQavB5hR99GpIb+wR8nypkVwklX0pPWTk
 DCCktcLlTgJnyr0C8l6OaXulhH67Qblco6pepWai5SKq5ChUMZ2HFWV98SxXuxQkbH2q
 g7EzPalIIvk0pCK57smI6rOQs/bzTYq6bdXt8t0AmHjc7dZnRW9zmipFRX/OyWfUx5lO
 cWSoiVat5UnbT1jCyIbtWA2cTijksvBngUL/huyoTM+vP2/Gm5sp684bFxIz7CvTSPM1
 Zg4g==
X-Gm-Message-State: AOJu0YyUOtxihVTQVU6UGtY8o0/c1Rw1va/fL3dLZpNmIki4DqxXhjAt
 1ovKynnhy6tX5M6J1Np20Mbjc2XWlOwqy8hxna6XsHXk+HkPERKS/A3Vq77SO70cwBZoIfKG263
 h9WiH+6xsLNuyBdJevpMUA3SNtCnzhAyXCYfmvPSQyGYToI2vn0rROCEl4OB9BhmpKZzOAvGdrZ
 hSj+hd5uQd6ZCJWLmcdm0=
X-Gm-Gg: ATEYQzxuOJnDuAoIohhL4RyuDKUYz9QQht54SdTG9PA6arrN3DQbHTnsmMM/50G5vKI
 jaP9FxIPAjze67OAJ6QxIKKt8PlQDYRSnNTLWUKt+HFP8keJVSmURB24k4uBvHPseb+MrE7rhEW
 tSxYeVqOpmus00CnI3kDD59CQHnbp9v82YjvsRrIu8EnoiQ8w1XnoRtZVaYLx7tLWgiI2ibEwin
 G9Bsm+EH7HZG0N765pJiYnxxoxXwEzZNsZzRt4743p5t5QVgFOcpBrQPtYp+yC8n2HVXg==
X-Received: by 2002:a05:651c:1118:10b0:383:18fb:fdf0 with SMTP id
 38308e7fff4ca-38a2c5b6bb7mr28653461fa.22.1772715217477; 
 Thu, 05 Mar 2026 04:53:37 -0800 (PST)
X-Received: by 2002:a05:651c:1118:10b0:383:18fb:fdf0 with SMTP id
 38308e7fff4ca-38a2c5b6bb7mr28653371fa.22.1772715216975; Thu, 05 Mar 2026
 04:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
In-Reply-To: <20260303162157.1634379-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 13:53:25 +0100
X-Gm-Features: AaiRm51tFBcKmwca5Tgt1r_f7PnTBv_nRBzV-7bhy36vmyiCGYhZ7OWYC0N9V_Q
Message-ID: <CAJFAV8z2vGkbe+HKDqiO2cvhxKJRjM1Ghc=F_YmOZj8zg-Ak0g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] net/ice: get link status updates via adminq message
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ww9p_ha3waidwQSen3Gdq4ILXcBlvLfI41sbvtG7TgE_1772715218
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

On Tue, 3 Mar 2026 at 17:22, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As explained in patch 2, change the link status tracking to be via receipt
> of an adminq message rather than directly querying the link status on
> interrupt. As part of this change, we can reduce the cost of using the
> adminq by removing the need to allocate and free memory but instead just
> use the stack to store any received adminq messages.
>
> V4: resubmit to recheck in CI, now that next-net-intel tree is clean
>
> V3: added patch 1 to reduce cost of querying the adminq.
>
> v2: rebase on next-net-intel
>
> Bruce Richardson (2):
>   net/ice: remove malloc call for admin queue msg
>   net/ice: get link status updates via adminq message
>
>  drivers/net/intel/ice/ice_ethdev.c | 62 ++++++++++--------------------
>  1 file changed, 21 insertions(+), 41 deletions(-)

Did a quick test with 2 E810 25G ports connected to another E810, with
and without LSC interrupt in testpmd, and in OVS.
Those ports link status gets updated quickly in all scenarios.
I did not test on a long duration, nor with other types of interrupts
in the mix.

For the series,
Tested-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

