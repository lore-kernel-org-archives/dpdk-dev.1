Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C8ACD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C31A94065D;
	Tue, 16 Jun 2026 10:02:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E9385402DB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 10:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781596972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rl9QEQoI1Jg59kbJyMVgFxfys2anm6T8z7glxiVI3Gs=;
 b=CEsCrZ1xNfvI/6aDvuTdB/75imm/sV6O3niUWUAcRcW467vCBeddqMtFe0rXXZO6vA+i2V
 exsurTj9b+8mT9FZVfmhqI7/2Zwk30w71NZOeMqFivPRQKSYBO8rKRQOB+y0UVJ9FOJV8+
 qOA5gb+y1Z7D3pfos8dmsCa+eENCBvM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-dCQ90aoQO7WQjOJRl0KjQg-1; Tue, 16 Jun 2026 04:02:50 -0400
X-MC-Unique: dCQ90aoQO7WQjOJRl0KjQg-1
X-Mimecast-MFC-AGG-ID: dCQ90aoQO7WQjOJRl0KjQg_1781596969
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39664f3e398so17493291fa.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 01:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781596969; x=1782201769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl9QEQoI1Jg59kbJyMVgFxfys2anm6T8z7glxiVI3Gs=;
 b=ign06m99n1HP2sHXMp8dd8Z5cnii5u5s4yPgOGafIaPGIQOtk4pNszpSCyyH6ImIxb
 Cufef5X/bEzJeybnPxUyrGqPQhdWcLzwmegn1r0ekP/zaxzYoMprXQD4EgU16vY8SG5f
 SXtQZWc5wXm5rG8WomEmTxC6V8HdrLfbKjTepvhw0p/mXxeuXKlHHBXKpr4/UxwgmC8w
 xlk6nh6ocl7dwzwccmfqaf/U16rnp1p+k1UNw29pIhrGo8MCkaTPapI8dupKbhrJWUsc
 WuDVwhnruk/weh8L4wRbu26KSr6EZ9vkeTEqcFNwS6VNLOoCgC/eUQgonwy1yYoXdD/V
 tdQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E88QZcvyZA6kg6lLB+QRXpNlfxRdAwpP+oaKhyDF9AR2cyjcuuz34YNlIod06Hs4dmpQ=@dpdk.org
X-Gm-Message-State: AOJu0YxOziV2Xjeh3cCvdRp8ozWcu/soichHbQ2dzmRqtPeQQz1l2rOb
 PPnYN1xxtwicXTq3oPuSYgeCzLjIA/KHs/yPY3HKkvHZg5D09xky6tZu7QkZQ+p8PjMrASaDqhF
 SvJ0osYmr3LmT/0KqX07dihC8mNQc1lWiy5V7VAcEuxPtpQ3vkmrGlllcBJVTfqpjm8UAY/oB2G
 s1bHrTHdSoEH1Tr37u7Fo=
X-Gm-Gg: Acq92OEJRZa2uBh6u1Xb/oqm4xxLJEIomvO7i5j9f02chJoeCoJ45GRadxGzhmb+DzQ
 fmrLriyLKZQq2MIGjFkYOkIIyM027MHICS75CcD9hEjZSF5n94wCFF1/tfD0Kr5X1Z4o84FF9RN
 bKu7SETFgkGSaYAjXC3Ot73mxHrhZ1es33Bllta+A9BFuDbu49R6qPys35Nsva8GVcAwspDYjKE
 fsFO+lZUzeRE/SF2NPlYjf+JyL+QvM9iB+2IOBidU97QSiSM5faYVkqfn49mkhOLbv0hQ==
X-Received: by 2002:a05:651c:505:b0:393:71d3:d019 with SMTP id
 38308e7fff4ca-3995c824bbemr8391441fa.15.1781596968946; 
 Tue, 16 Jun 2026 01:02:48 -0700 (PDT)
X-Received: by 2002:a05:651c:505:b0:393:71d3:d019 with SMTP id
 38308e7fff4ca-3995c824bbemr8391211fa.15.1781596968293; Tue, 16 Jun 2026
 01:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-3-maxime@leroys.fr>
In-Reply-To: <20260611154926.392670-3-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 10:02:36 +0200
X-Gm-Features: AVVi8CdtETiMsMEz2MXQ2i6rhdG0dTyHgPsR2vf-GWzbY_ukJGhvdedB63ZPY2U
Message-ID: <CAJFAV8xH9GOGF2aR7tp2uMsjhpJs-1gXW=xzG4Gak3T_n1KpNQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] eal/interrupts: keep real errno on epoll error
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, dev@dpdk.org, 
 stable@dpdk.org, Harman Kalra <hkalra@marvell.com>, 
 Cunming Liang <cunming.liang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MEmnrdoKjYSedlcyGRv8VAHh4WX1e3EDXBsqTLmSaU4_1781596969
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

On Thu, 11 Jun 2026 at 17:50, Maxime Leroy <maxime@leroys.fr> wrote:
>
> Some interrupt users have several vectors backed by the same eventfd
> (e.g. several Rx queues behind one DPAA2 portal eventfd). Adding the
> second vector to the same epoll instance then fails with EEXIST.
>
> Upper layers such as ethdev and bbdev already treat -EEXIST as a
> non-fatal duplicate registration (if (ret && ret != -EEXIST)), but
> rte_intr_rx_ctl() lost that information: rte_epoll_ctl() returned -1 and
> rte_intr_rx_ctl() flattened every failure to -EPERM.
>
> Return the negative errno from rte_epoll_ctl() (its documented contract
> is already "a negative value") and stop rte_intr_rx_ctl() from
> flattening errors to -EPERM, so EEXIST reaches the upper layers that
> already handle it; other failures carry their real errno.
>
> Fixes: 9efe9c6cdcac ("eal/linux: add epoll wrappers")
> Fixes: c9f3ec1a0f3f ("eal/linux: add Rx interrupt control function")
> Cc: stable@dpdk.org
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Reviewed-by: David Marchand <david.marchand@redhat.com>

Nit: the eal/ prefix is only for OS specific / arch specific changes.
The title prefix should be interrupt:


-- 
David Marchand

