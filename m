Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8363CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 08:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35DB40281;
	Fri,  9 Oct 2026 10:50:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBE444021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 10:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791535819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ui/vi81gkelKlgV7Cd9kS/NEcnmZUH0Niu0aix3u5lw=;
 b=WjKIc64iqEHRJmuA0NXS7sVrTEaw0WuNUxTJK5ZdJO970FyGAT/pdFYfDF6etJtc/K67QB
 gjwajL7jammcrtetNSBmjLDngA+9RWK0F5fbP/zaG3SWUTGoAyYYN3n5LegYwUFwUkrrmb
 xkB/kI+2oZs+InfZnVI9At1G1Q6t4hU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-jgl9DEmIPqmTyAfxus7C7A-1; Fri, 9 Oct 2026 08:50:18 +0000
X-MC-Unique: jgl9DEmIPqmTyAfxus7C7A-1
X-Mimecast-MFC-AGG-ID: jgl9DEmIPqmTyAfxus7C7A_1791535817
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5bb78051100so3843053e87.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 01:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791535816; x=1792140616;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ui/vi81gkelKlgV7Cd9kS/NEcnmZUH0Niu0aix3u5lw=;
 b=EPsswfbKe5dinqqGLsn3cYL++UWpj40fKv28FHZ9oDK7IDq23BTdeuGyoLOcJUGItD
 2ZhDP/3b30+8Ee0kw3nJwxfnR7P3Lay3kFbn4a0ffgRkt5LA5tDT6x71Mc8Fn2Rfovm0
 lPxGltfJD+6UACj9Jb+C7NQPLLYY4z2h9lhutlYFhjAYeJWYlHRa4nLF6+FjfZ1/HsJT
 ZgpieKJh0NE6Wre3/vdrYMmIkAOC2Wdd4FWSUZezCtcNXlJG/12izCleeVKaapi0qgYi
 BVAWuvezFpWbCwIkTwAewxRjFNsC5zXBGGCGzs/UtbE5Hey6fcjAWr9doIG75x54qJeH
 LzQg==
X-Gm-Message-State: AFq9FYLmJy1jkLmjJtwbcz/0N/nTNlWDoNu4723vai4VT8yiG2F2CSe9
 oQ4i5Jld/tn/jBCEbsI/WZojelSAmb4rybahYuYfPfMXKTIf3B7M/bYK0FpJA8a/JKp8THMSrln
 IjAr/eruCxWzxueDyNXfEtcsWlZC+4IUZI+kvuz+70d06u+zoIV9AFNu1RFGF0XyvhPhhmd36Jz
 s4agadqX2ROlPpD67x2zk=
X-Gm-Gg: AYBFou01F513ub8hbgOnhrqHfgauYbFjE73uYOYobVtXaI1O2yv7bOOefIrmPFs4KGj
 xeGAVdvnufrKuqYtPHIQvMUSftO57aSaX9sVEXWgrJnLHPHY3DrA9Z75xi4ca4SL4cNl8K84auX
 OJEJM8QpDZBPZlrZdUwP+bXPPqx7SKWDz5Q7LcJuCS5j8001ITIGDurXx8UC8cICrTO8teu5o62
 yPwK7xBD1tYzScZAWTqyXGmp6R6ebHMH7THxZRhmqQUck/q
X-Received: by 2002:a05:6512:618a:b0:5ba:4265:dc94 with SMTP id
 2adb3069b0e04-5bcde8e65e2mr450212e87.64.1791535816473; 
 Fri, 09 Oct 2026 01:50:16 -0700 (PDT)
X-Received: by 2002:a05:6512:618a:b0:5ba:4265:dc94 with SMTP id
 2adb3069b0e04-5bcde8e65e2mr450194e87.64.1791535815960; Fri, 09 Oct 2026
 01:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
In-Reply-To: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 9 Oct 2026 10:50:01 +0200
X-Gm-Features: AclHuK8ipc0PWrxy8ZFpJJ9xSRDGwLSw--w_3bziBxQq6vAdIrHJ6dqlqkJErX4
Message-ID: <CAJFAV8w_=HPgGnVEsnXMh7aUf1z6PJeAgMVYd-3NTan5vT2BZA@mail.gmail.com>
Subject: Re: [PATCH] net/ice: fix max number of descriptors for E830
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Soumyadeep Hore <soumyadeep.hore@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKVLkuMf7qI2FyNoy2nCJoMPYKGyVmB_mtjLJbQ77FA_1791535817
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

On Thu, 8 Oct 2026 at 06:17, Sandeep Penigalapati
<sandeep.penigalapati@intel.com> wrote:
>
> E830 supports at most 8096 descriptors per ring, but the advertised
> descriptor limits and the Rx/Tx queue setup checks used the generic
> maximum of 8160. Only the ring allocation honoured the E830 limit.
>
> An application could therefore request up to 8160 descriptors on E830.
> With Tx packet pacing enabled, the Tx time queue length (Tx descriptors
> plus a fetch margin) overflows the 13-bit queue length field, wraps to
> zero and triggers a Malicious Driver Detection event.
>
> Use ICE_MAX_NUM_DESC_BY_MAC() for the advertised limits and the queue
> setup checks so they match the ring allocation.
>
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

My two cents.

There are still some users of the unconditional macro:
drivers/net/intel/ice/ice_dcf_ethdev.c:         .nb_max = ICE_MAX_RING_DESC,
drivers/net/intel/ice/ice_dcf_ethdev.c:         .nb_max = ICE_MAX_RING_DESC,
drivers/net/intel/ice/ice_dcf_vf_representor.c:         .nb_max =
ICE_MAX_RING_DESC,
drivers/net/intel/ice/ice_dcf_vf_representor.c:         .nb_max =
ICE_MAX_RING_DESC,

Not sure it is a valid problem in DCF case.

At least, keeping the ICE_MAX_RING_DESC define seems a good way to
keep/reintroduce similar issues.


-- 
David Marchand

