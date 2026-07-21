Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2380AC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:07:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB410402A7;
	Tue, 21 Jul 2026 14:07:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AAA940294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 14:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784635658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUyKkolcqTLi2SXzPayVlQzhkVew54S8Ueu9mkznfj8=;
 b=MX9ih8IkmLyr25oOGT+GNxfgP7IPzns30fJFtKIdU1qeDwC6j+lmtE/BU8rufx18jnugm4
 rFx5xwcItO9zQdAK3Io58mBzFuhKTs7rEEaq47wUN0NRdeuZDiFA/8loNDOoc85siHq10N
 YWSx04cOoWSi45Bj65kf02/tO/rRRwE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-pkDJU9U6MYeFbdJMmGpfJQ-1; Tue, 21 Jul 2026 08:07:37 -0400
X-MC-Unique: pkDJU9U6MYeFbdJMmGpfJQ-1
X-Mimecast-MFC-AGG-ID: pkDJU9U6MYeFbdJMmGpfJQ_1784635656
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39ad2e6474dso56795511fa.0
 for <dev@dpdk.org>; Tue, 21 Jul 2026 05:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784635655; x=1785240455;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bUyKkolcqTLi2SXzPayVlQzhkVew54S8Ueu9mkznfj8=;
 b=AQ1YbW0n75IUIHTncPmnHQdGC880QChUO5J2IhFVtFFj91J5V5/gGGMjE7cCnqXB5u
 ForrZHDvGdWmDi9gtQ6HF4ow+EF+FUxclIrJIWhdS/Hj/1x5YaGpjvSC24Wn2PFRYGlI
 qEACYLdSp5yHycBO30zRPFtIsgZLUziWCEXN+diFmZ4T1nHQPfav3Qvdp1sIF27aMCnv
 DzDRMvmvSu6bv236t1EQM38GRd6q0NtIy4Y+k9eNmNtdLmTwHMRT0gjNjU3k0/F9VUfl
 hEjVFgzryA6WpOZzIwCLtSpM2wixtXaZIGoIpfEJNBwEi6YXOUxgzl4kT/tX6Cyu3YRZ
 VaMg==
X-Gm-Message-State: AOJu0YyEIrASuR8JjzEyQbskp1SJRDm3VMBVQu5LLtMur7rNSK/RSGUW
 V3rgAcwhMlwOlGTFi8OZdvldveVlHelqdUx/p21VCATWzY26HPnsQVxQHF+KK0TvL49m6glNJid
 5QhlQBOd46WM0ngTLWnia/PdcY0gDNaURUGTpfa8scBymzwgMxOGpbwAd8J6gCBcoKR1UP0ZveC
 ii/99cnXw5Kk2mqX1jvS8=
X-Gm-Gg: AR+sD11O3Jngroj5pNyS1bYxXpZjuZ6rV6YkjuGhFrkMlNdhou1oWIcpftpOfakwcKG
 hZyjY7JFS8SDzAnPRzmbMPqOAWE8wVTOyYzDeFjyXKcl0iRoiJ0Ar5TDMLOtoI6Oyj2uz3NIACj
 LeMtt0ycqSbuhBcWPNnr6Azr9fkswnVk++xMfQB3HP5xTBEjVG9Blf9YcCddTtS29YodNvi5V/i
 cErd6UpBrUtpJZ7ex6DjpG4j7SsH3R6ws6E2xXEsgCcx0O1
X-Received: by 2002:a05:651c:158d:b0:394:5c9a:f315 with SMTP id
 38308e7fff4ca-39eb2778d70mr38975541fa.14.1784635655627; 
 Tue, 21 Jul 2026 05:07:35 -0700 (PDT)
X-Received: by 2002:a05:651c:158d:b0:394:5c9a:f315 with SMTP id
 38308e7fff4ca-39eb2778d70mr38975471fa.14.1784635655117; Tue, 21 Jul 2026
 05:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260721115635.2209399-1-bruce.richardson@intel.com>
In-Reply-To: <20260721115635.2209399-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 21 Jul 2026 14:07:23 +0200
X-Gm-Features: AUfX_mwBGr8XSVNi7q4OUP2NT6G3FL0NjRWOlkE-iLee7ElBpmYtaBaC9HxlmJk
Message-ID: <CAJFAV8wu5ZF9gtG55eZKvSz_J-sE4DShoEX=_ZKXWC48+MMG7g@mail.gmail.com>
Subject: Re: [PATCH] test/event_eth_tx_adapter: skip tests if no eventdev
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Naga Harish K S V <s.v.naga.harish.k@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4YKWfu7RqEQ2P85kIT_CdPhspIBbfZYOChOXSC2yTYk_1784635656
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

On Tue, 21 Jul 2026 at 13:57, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> If there is no eventdev present, and the SW eventdev driver is not
> available, skip the eth tx adapter tests, rather than failing on event
> creation.
>
> Note: We keep the failure case where we do have the event/sw driver
> built, but fail to create an instance of it.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/test_event_eth_tx_adapter.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
> index bec298a8b8..18801028ce 100644
> --- a/app/test/test_event_eth_tx_adapter.c
> +++ b/app/test/test_event_eth_tx_adapter.c
> @@ -202,12 +202,13 @@ deinit_ports(void)
>  static int
>  testsuite_setup(void)
>  {
> -       const char *vdev_name = "event_sw0";
> -
>         int err = init_ports();
>         TEST_ASSERT(err == 0, "Port initialization failed err %d\n", err);
>
> +#ifdef RTE_EVENT_SW
>         if (rte_event_dev_count() == 0) {
> +               const char *vdev_name = "event_sw0";
> +
>                 printf("Failed to find a valid event device,"
>                         " testing with event_sw0 device\n");
>                 err = rte_vdev_init(vdev_name, NULL);
> @@ -215,6 +216,11 @@ testsuite_setup(void)
>                         vdev_name, err);
>                 event_dev_delete = 1;
>         }
> +#endif
> +       if (rte_event_dev_count() == 0) {
> +               printf("Failed to find a valid event device, skipping test\n");
> +               return TEST_SKIPPED;
> +       }

It seems strange to reevaluate this part here.

rte_vdev_init succeeded but we still have no eventdev object?
That should be a failure to me.


-- 
David Marchand

