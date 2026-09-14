Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88771C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEA4240B8C;
	Mon, 14 Sep 2026 13:09:06 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 9FB0A40272
 for <dev@dpdk.org>; Mon, 14 Sep 2026 13:09:05 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d4eb63f16so6534867b3.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 04:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789384145; cv=none;
 d=google.com; s=arc-20260327;
 b=eGEXiU3gpB7723dL6l3d2Xg3yrUkl/Co0LJfRnDTXR1vRVkfnBA1nzD8e3rpNrbRE4
 DeJIJgfLAxGx31bwz4ykSc/53+daQ83ybLYDfGkuBDHzpx2hqwcYyzMLIrcJgoZY/nwU
 4g3BqpmdQDZWlTJN7ShdpkOMY1iZ/hIWE0cBbSqfEaSnMr2Fxvr14uUfFpqClYHcOC9u
 k0Tl8M0PWDn0FbLi+9LO2vBukx4HR69186dmgGSmAHY7kxahVIqI8on9snCuzG02pT5S
 +2b3N10wxVgIphY1+zOqbJIZ7M9PnV3QxMLDY8CRuqzfeXHwYyXegGHCcPBoaS+rKnAF
 JumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8LPZViudTxfJOB1FmTk5zUPBHM/K2VVXUvLnaAKoeds=;
 fh=2grJHmj7tHl358i/C4agPU6R7LGAd1bREil6ub+U7gQ=;
 b=gY4fTIQ3ibpW7Q9htYXu8wTFb0X8FuiuYEe5e4NlXj0H8GhJFSnr7/95smgCAoD6wR
 wv/6ahvNCBjq8MUD7rYhlIocyfIrfyPOab5VNsYo0X0O/tncFhL4opC0Zn4VRCJ6m2N0
 OoqLd5xzIZlsgJupeucL06PqIdCT2YnTO+FnMg4kkDK8oQaXbNXseDFoqC/bt5iaVZc9
 iFQ1mr0y2JfbyZKLHICTPoczTycPnnUowq6OH6R0ViJdIm6RIvwdskkgOUiocjtFwi8x
 DMNztpQ02WJLbzvASH1HaK7X6gkMDO956KQHzBkaWPaq7SWzJIfWRaVjzw/pXPefIu/w
 8/XA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789384145; x=1789988945; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LPZViudTxfJOB1FmTk5zUPBHM/K2VVXUvLnaAKoeds=;
 b=Bz+OzOwym8yfFfw/SLu4j5pAeZgaSS7mbSVaKO+mHVizlNF6qKidAa6Tu3hzZTvBDD
 D1M7FfVT0YNgM0rqNKt8+MxcGxal1MXWlhrkD26700h5OeHkIOoxOC6HDOC/ke3fCXYV
 fZ2VvwbrCsYzYbh0hWEpT8K3YU3Tbo7Ichr/R5Pwe+Tn45oHN2cKf7j7XhEaCmIIrxM9
 HolY3TyaAFLx6MPtS8bibEdnWvXUN6ekcvtyc675BzUA6bzflsUqMK/s/vhzsznaOkRt
 bAcZY5ZIjCIAkBNsPlEY1h8cAMs+rphHwPoiU8YpHhYyiAJzQQEHgz6xQLSBZzkM1QpB
 tlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789384145; x=1789988945;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LPZViudTxfJOB1FmTk5zUPBHM/K2VVXUvLnaAKoeds=;
 b=J50tF3E+iufBRJxwbkWi4Hy0FHHQYufdkeYRC9txI4aeZaYgEoLsKZ6S+GSB7xYvfv
 sJNbb6yKMpqRxXJMS5Xjkugr84+Ll6OLlVBkXyfXXbOXTYJGbDDCsurRX/WkVhNQygkB
 +Kod6vAjvJLB/VbToFMTMaF9zy26PhzBf8zDM8TflGnFMY/n+NevewVbyWi4RoV2V81K
 ZgV255lpV5CAHxsTSCq6JTaGIgVnEt6/zPMdeRSMF3BO6+I2ttiJl0k0NMi9HL/dF/R3
 kqD9SKhU1PBsxI6e7Rnme0pH4LmYpQ1Vs5Ape0wJYhJ9Ro/+lVDzPn/prRaQdt/Xxp1h
 hcVA==
X-Gm-Message-State: AFuF++kWI8mbxH7gonnTt8tPavPCXs6LdGJNVv/REVkmF6fv0XiAQFY1
 uFljJXM/2xKQhbd2b8o5/DfDW6YwfEo3m8Nsq0ZCxuNdr7IEb3K42o37SLMbfNwbuREd1WEnZLE
 GfAbjQy1r1vQn9fPwjjKAvigB28gklmU=
X-Gm-Gg: AYBFou1QT+WFa7jHsQPHLv/DB2PJw58DMXaDDZCqx+0qa0267WAlapkL6cu371m/jtr
 b4V8evbRF+IVLLqNAaYV1i9VfnWFLi3t0ujqEhHUbYkv4cjYf5DXhraQZj1l2dpOeuqP7Q+b1kk
 DdyKi2USj4QdZdSdAxfYUkbOlQ2yiqPZH6y/BvFGB70EBjf190UZ/tBnoY7viD0lE0KbD9cXzAY
 bFVNFz+Qzfr4fNy/QQkyu5ArCNg1wpuRBYX64cXrc/L4recsZMh6360B7Q8rfsgUGiF1wD3RP5Z
 9FvtRILoWN5B4bLLVGgkUaa3K9kyOImPERHr28ePawinjKZt6Ema2e6zNHRuZtnuIuzJEeSvMpM
 +BPux1mMZ5oG1bdGltjSxC7HhlaUhiBe6jRqNHLGjhto1hJSn8e4Diw86h2ZyyciZMMelnIOsWE
 O2/xwzehIWgK2ere+v
X-Received: by 2002:a05:690c:9990:b0:87d:8589:214f with SMTP id
 00721157ae682-88d43187101mr3978927b3.32.1789384144943; Mon, 14 Sep 2026
 04:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260807101630.3571199-1-gakhil@marvell.com>
In-Reply-To: <20260807101630.3571199-1-gakhil@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 14 Sep 2026 16:38:39 +0530
X-Gm-Features: AcwNN1U60vLdv_ID9Q0s4H7P_lFqgkAfgoT-Fp44Jl-WYboCOHc3oyUE6nlsfjU
Message-ID: <CALBAE1PSNG70njKAnud-y9DwWRcwxT5EWKcw4sO2msJd5vp42w@mail.gmail.com>
Subject: Re: [PATCH] raw/cnxk_gpio: fix out of bound access for negative gpio
To: Akhil Goyal <gakhil@marvell.com>
Cc: dev@dpdk.org, jpalider@marvell.com, tduszynski@marvell.com, 
 jerinj@marvell.com, thomas@monjalon.net, stable@dpdk.org
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

On Fri, Aug 7, 2026 at 3:46=E2=80=AFPM Akhil Goyal <gakhil@marvell.com> wro=
te:
>
> cnxk_gpio_valid(struct cnxk_gpiochip *gpiochip, int gpio)
> validates the GPIO number with only an upper bound while gpio
> can be wrongly configured as negative value from application.
> Added a check to reject negative values.
>
> Fixes: ecc0dd455e9a ("raw/cnxk_gpio: add option to select subset of GPIOs=
")
> Cc: stable@dpdk.org
>
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/raw/cnxk_gpio/cnxk_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cn=
xk_gpio.c
> index 0549e326f9..e22fb7cf7b 100644
> --- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
> +++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
> @@ -795,7 +795,7 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct =
rte_rawdev_buf *rbuf)
>  static bool
>  cnxk_gpio_valid(struct cnxk_gpiochip *gpiochip, int gpio)
>  {
> -       return gpio < gpiochip->num_gpios && gpiochip->gpios[gpio];
> +       return (gpio >=3D 0) && (gpio < gpiochip->num_gpios) && gpiochip-=
>gpios[gpio];
>  }
>
>  static int
> --
> 2.43.0
>
