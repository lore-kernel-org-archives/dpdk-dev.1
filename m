Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A9CCD18F
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:35:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEF06402A8;
	Tue, 14 Oct 2025 10:35:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CB596402D3
 for <dev@dpdk.org>; Tue, 14 Oct 2025 10:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760430945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LXWnV80Ig2WUusXawkDJSpYPX6AE89HJ2IdwFF1pxg=;
 b=G7AeOwPEglKSlpdHvOJDjWOYgSvyaDg6l/z1ORV1ohsoooepbdMfvbursILM02uSTorFPX
 M+57R2i8Stmfm3tbYY7+BH/ghV1rBwBtDvMksGcDuy7VPYxcaX3KDf1bgSD+VmjP5z5rSa
 SZkjwx0L/1LBkkDgi2A+iBnHBDtQs9Q=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-beSPaWMPPIeJpvvNyM3vwA-1; Tue, 14 Oct 2025 04:35:42 -0400
X-MC-Unique: beSPaWMPPIeJpvvNyM3vwA-1
X-Mimecast-MFC-AGG-ID: beSPaWMPPIeJpvvNyM3vwA_1760430941
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-585b3594d16so3019870e87.0
 for <dev@dpdk.org>; Tue, 14 Oct 2025 01:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760430940; x=1761035740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LXWnV80Ig2WUusXawkDJSpYPX6AE89HJ2IdwFF1pxg=;
 b=parta9EWYnPgUlQjGPmgniGCQypo7dVJLBMohZFvLrhQdRFqfQftm+Zx+b2xp0pJVy
 N7zk7bPHSmgmHVk6UrThqhuON27f2vqx/y+WBSich85Bx0kXH1HE4EJi5uR3gPylmulV
 qdmpuAhEBAh12t0grpnZ/w05LsMH5MBryMkhPP5ctDxgoEg4SrYqCLtHU2hQ1w33wFyB
 6m25MPKmTeiLvynUQOkWNWqCS+I2qR2dESAJmpb8tu2Ip8LLTt9CGfc+gsTpBcczYCOG
 wIhGRc7IMyrm/26PSPUqbMM5zq7gNWhY6ImhY1hW2AGRqcI9enfdaHVvl/g9gzoWtW4e
 +0/g==
X-Gm-Message-State: AOJu0YwbGiTLNlEKGBmbaWg6GsrJ0yS5cUtIw4v2tgAFUHMOAa6zijw8
 2+PMXGaPlX5Za74hCBUTUQsbvAmihUVhVvIStOWRv87xooVCQ1v9VlgRvUNYIfBYUoGsAT2yozm
 sN4AyIx39Vm6AC6Gf9veblUTshZVd7sdIGci2I+qw491AfteocuCKUnsNiUgUoopfC9z+zsrNa1
 glgYMwTRTYTHnjl0anD7Y=
X-Gm-Gg: ASbGnctByo5kYt6wKPpYTDjf+IJQJZqN1+HbW3qMjzRpZnwyjpfTHZud1bXUtwJTnlT
 JA8MEwPyvhs5dMydNPFhCR5MaFiuDm4tAF+FSDXgmQdlnN8DllD7vIfi7jvN6nwPsS0JT05WAFF
 sM0qS8cdOxqjKZK91EJFaDvdw=
X-Received: by 2002:a05:6512:3e11:b0:57c:6376:b42d with SMTP id
 2adb3069b0e04-5906dae6b86mr5797874e87.29.1760430940574; 
 Tue, 14 Oct 2025 01:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE15PZ+gnpuuo6/Tmmp5Z3wJgASPpOM03+9fQEQiEpa/uweZtCwOKsRUB8+m2NbUlpZzYZyGMdR2sXS9ZqIx78=
X-Received: by 2002:a05:6512:3e11:b0:57c:6376:b42d with SMTP id
 2adb3069b0e04-5906dae6b86mr5797862e87.29.1760430940170; Tue, 14 Oct 2025
 01:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-3-bruce.richardson@intel.com>
In-Reply-To: <20251009130056.2630343-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 14 Oct 2025 10:35:28 +0200
X-Gm-Features: AS18NWAI22zajK9cNwa0AsPZLDxijEFj74i4QLiueeGYBeG6JmDYWpkTJ4iANyc
Message-ID: <CAJFAV8xehOLkz+cUxX66DqqLwN0sKOsdFi3-4aQFTMPpY+SLkw@mail.gmail.com>
Subject: Re: [PATCH v11 02/21] test/func_reentrancy: fix args to EAL init call
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f1iSAvFF7fDJIUqcmZpGVgco7V0uEWaM_mwjEzSA6HE_1760430941
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

On Thu, 9 Oct 2025 at 15:01, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The unit test for EAL init was passing in a NULL argv[0] value which is
> invalid. Update to have a valid string for argv[0].
>
> Fixes: 104a92bd026f ("app: add reentrancy tests")
> Fixes: 978ead0144c1 ("test/func_reentrancy: fix EAL init call")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

