Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C869EC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7B3240A89;
	Tue, 15 Sep 2026 12:30:48 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id 2534D40A7A
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:30:48 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d43f9b11aso975217b3.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 03:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789468247; cv=none;
 d=google.com; s=arc-20260327;
 b=e3FChpHasrbEq2boBtKjlu3vuz7ECAKp8z56T2xFUs+2xHGW2R2Ju/XtOHt+k2Mtti
 9ikLduJI4+tlOs6Ep+ko0K+Xxgvz/a+wISWg5/h5WlTZyJoKCDkRhwkbiPPUKTk0zjRI
 +Vob23OtrZFPEkk3g2p5E2di2JuinaKO5OlYEStoaT985BvIWqksd/XSoaIz37HSmG49
 JXH/vNXhImqhgnLOf4QMSyUocFPUeFfGsp3ICZIbKgH203bvtyd1qnXYLziqCd2zYKzy
 t+VAEnaXPtXOde0UMGXYrP0hraZvonQD7ZdqASScCTE1nj0NC7vgz7k1JCdOVPWrOYk0
 AxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y1G3RURaIBX1PvfnGmkAQZVdRrquoqNSEetFGc+LHAA=;
 fh=8RjFmtlfWuSy06bfjnPnoyIhOCMMtPp9gudY6c5pWpY=;
 b=H/oZBw7F19Ls8IiyQmSwb+1Z7BsEINbMCZFn83w3Y4dbKm0YAIeu6h4DAlcrZiMlLT
 wqCTM44+jwk3YAsdcftadToW6vnEQDDq0D9yZwzOmyflNszqPRVgNn/0Ivd+WtFAo1P/
 L+5SY9tI2MJtgyAXzs/0+jbRT3WQ8j4xSTHuXIhROmHQzzPEe1IIoMMWjEniKa3vABZr
 DG8CSsngNPCAhNyw26M5OTqz83KQDYu0d6pMnvDTUb+2PJLNEVr4w9F8PSNn8AgMlUpq
 GpJdDxLGghB6cHo4D0vSvRXg3oKNKeJHi3q4zWY2AWP/z1NmBhDFX8vuqSAMoUUoR6Vt
 ZXEw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789468247; x=1790073047; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y1G3RURaIBX1PvfnGmkAQZVdRrquoqNSEetFGc+LHAA=;
 b=HCR6jlqrALl2sWUf02nvugoxxGox8mTHmM7iEGAnRuNz9j6taq9B+poiJgASsEvKIG
 O11RPYtW4CTAykxQWDclnI69wUvYZ1/c+ljxWD932GljhpK7bOm19qp/82u9FfU3gBlO
 t08KJQZSdetpw8x1+pvBHAbGbBYpGROLmNgbGrisEls/bffSz3mrchX3z04WG1RUBK8f
 30mwybnC0lx7v3GY45sGDOopBNdrnwbIjTcy3G0lIuVgufPI0lLFlEXEdboJ4jFZQkm5
 kYdcCm3tKk9oVXZIWqg2dbX9hIdv2hoWlp8YU6pkXXikDcPQp6fcMQgFtPx0L3U3NVHp
 qC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789468247; x=1790073047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y1G3RURaIBX1PvfnGmkAQZVdRrquoqNSEetFGc+LHAA=;
 b=rdpLrXdH+87Qfe5e60FOxniS7dQgR/SZ9Dt3LeBA3AQlBzvMPffiTjjFuB5Amj1+o0
 dPC1fssMQGuEH+jhcLmPbSzL5IEfdIFvaeGLCEWtfRiAREERzTyL2YGAhkwFs+xhgRpL
 BrQ1GEw+W6b7+xoos/FxQOn+Z1FUQS//S/1obAsjoWErHFWzzOjTuZ5nTQw8DvYvMKz4
 +R2tU3i0faLUcfifP+/6J37cNpRCAgs4R+45C44B75QrLahJfXumCTugldP/yjOo3CH2
 w2N1IdlA8VkOWgrVlflPshIUkK4nzGG3SHqFDmn5mH+YGEuA3f1UNK43OscC+ApXUbyS
 bckg==
X-Gm-Message-State: AFuF++lu4mLUWvndebAx+utGqoteBIuc/nNXqwlhlT9VdMxjwlAPFYEb
 JzTO6XswmkafClq18+jUp7JQn8qXSS1MvxgoMF/Tp9YOh39y4gNemiRwuVFayKvd0quRecQf93A
 dsSH9GEXfr201MuGu0ZnexGLI0y+kW0s=
X-Gm-Gg: AYBFou3TMrFcu6VHg/3Gq2Tsy1gqKovq8xq3WkwN/U+CUo75MB7uMz/S7U4GGyv42cO
 m/plKCRibkEonpp9jXNvo+CeQp3xlEQK0FtFJJQCVDd6ZuVz6sH3Y4/Meldy7np5/GzUf/SWVu+
 H7LSs3eBbf5Edu8QHpJXnlS7rBh6EfbYjrj1iR1okcqiga0Db3BaDcG+ShpfYvG93z5ouUr4lhP
 +9hz6t1YkXL4yxD0jZVx49+eEvCwesYc1CZfO1d8bs4GrOq/AunAHnBtVg+fH3JWlFQykAGWfkt
 aE20ye9WfG4OaWj4rjkSdCHqi308uEyip2TncT7iuX5jLJQUWH5pKSMxz2rTKPC0vWqI6wPCC7L
 Rwb0LtrhpuHPpAFIhtAbAB3ertD8uhx9krOn/m/J8AI/FcaERuJbze5TMX2nqPT8n21pknKMGwu
 /IKCwRt17Qbb1ZgVn+zA==
X-Received: by 2002:a05:690e:14c5:b0:66f:be14:1a2b with SMTP id
 956f58d0204a3-6715caba050mr138512d50.11.1789468247379; Tue, 15 Sep 2026
 03:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260721115635.2209399-1-bruce.richardson@intel.com>
 <20260721132349.2579128-1-bruce.richardson@intel.com>
In-Reply-To: <20260721132349.2579128-1-bruce.richardson@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 16:00:20 +0530
X-Gm-Features: AcwNN1VWSah5TRA1Qte0RNrkepkcyWSX6ULYGFq6CnxszMTM6juVNVBQtd8sSQM
Message-ID: <CALBAE1P=pOL6k+Y=+oVUGDzk_BAi-2SZiVPzofMYQgvinpyunQ@mail.gmail.com>
Subject: Re: [PATCH v2] test/event_eth_tx_adapter: skip tests if no eventdev
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Naga Harish K S V <s.v.naga.harish.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jul 21, 2026 at 6:54=E2=80=AFPM Bruce Richardson
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

Applied to dpdk-next-eventdev/for-main. Thanks

> ---
>  app/test/test_event_eth_tx_adapter.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_e=
th_tx_adapter.c
> index bec298a8b8..0c161897ce 100644
> --- a/app/test/test_event_eth_tx_adapter.c
> +++ b/app/test/test_event_eth_tx_adapter.c
> @@ -202,18 +202,23 @@ deinit_ports(void)
>  static int
>  testsuite_setup(void)
>  {
> -       const char *vdev_name =3D "event_sw0";
> -
>         int err =3D init_ports();
>         TEST_ASSERT(err =3D=3D 0, "Port initialization failed err %d\n", =
err);
>
>         if (rte_event_dev_count() =3D=3D 0) {
> +#ifdef RTE_EVENT_SW
> +               const char *vdev_name =3D "event_sw0";
> +
>                 printf("Failed to find a valid event device,"
>                         " testing with event_sw0 device\n");
>                 err =3D rte_vdev_init(vdev_name, NULL);
>                 TEST_ASSERT(err =3D=3D 0, "vdev %s creation failed  %d\n"=
,
>                         vdev_name, err);
>                 event_dev_delete =3D 1;
> +#else
> +               printf("Failed to find a valid event device, skipping tes=
t\n");
> +               return TEST_SKIPPED;
> +#endif
>         }
>         return err;
>  }
> --
> 2.53.0
>
