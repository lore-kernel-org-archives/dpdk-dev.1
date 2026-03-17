Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA50F3383D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 14:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDAE4042C;
	Tue, 17 Mar 2026 15:47:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D048A40270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 15:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773758834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3JRmT3c5VCEHCaBoC3hCqgdM+eF9KzXQXBe5gSB2C4=;
 b=L4loDkE9oZ/cyeTtAjKJcCqRz8E7btu/LcqogAG1GPWwxWuq4h8hFCCYXwmTSrwkwQZCHB
 1vdaPbUuJHkdOa5vyFFjb4iM5q05rc9xMXDWldZrkXBTYnwzVnHP8cXGslrDv1dfk7qAR7
 Jlrw034cBF/gaPa8hr0gT5+y1SWvy/I=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-hY8LCLsENdayHWMsC_3_Yw-1; Tue, 17 Mar 2026 10:47:12 -0400
X-MC-Unique: hY8LCLsENdayHWMsC_3_Yw-1
X-Mimecast-MFC-AGG-ID: hY8LCLsENdayHWMsC_3_Yw_1773758830
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-128e8ac314eso1320810c88.1
 for <dev@dpdk.org>; Tue, 17 Mar 2026 07:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758830; x=1774363630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3JRmT3c5VCEHCaBoC3hCqgdM+eF9KzXQXBe5gSB2C4=;
 b=XBhsye7DgQAW4QmR7BLZNnd85kPNv9dS+Xwsc5uLySCS92G6VmTGGgez92DS7oM9hq
 8j5MfFxLaVFqHfyhYy5+YJ0WT8hQ4XfotRPk2c4KOmevsbrfHTnMgvIe8odzy/gKxYpg
 gxUDSxtdB1rRAwNo83zsOPlFKtV4IaCOrOMndKi+a8rO0jbZr2XFRyHvW28LhtCpOglw
 gMBnV9EOmAyg8IrNgB6MaTLEDbrKfliLWY5WpdtLQKmsXTD5j2RD+ro8DHfEInkp4vff
 wJqQ9kCvpyMaF+F0j9NLjXU2Dc5LBTccu1hwS4Az/+eazLaZNsr6KoFV+jI/ecB1soNG
 jKfg==
X-Gm-Message-State: AOJu0YwGLtSZbpVfRaT0zv/1orpfdovewnbupJl7xEK6sH0v2tvcPLZJ
 p8jyOgOQ4q/tUfQaaL1FIdgSkV1/JpsZpkXAUv4KoJCtqHlVpln2hTpgRYwCG61k8kIdieRJXKU
 oZ6imkaxRseTAPexZv8Mpdr6b8LRE+DH+7kw+mYB7YLFwBgc1IUcrUJyRAhiPIS5dA4krIJKQeg
 QtHk7bknXodmyV5I53AKo=
X-Gm-Gg: ATEYQzysVe0JBmWAWAPFocEe+946JLKngeXWMNJgydeffjyqHoLKLhTRLyH/VCJymon
 ECJOFc6b1YrnuLiHZFMv5Ocrk3aW2FvHKEMf9QM0u7ky3xEOwluIc01vGrl0kNQ1jxrgr9D216s
 YCu7lepmstxI2l1Zum1mqmwfdGBl1ytjPSLFIw4BeVgX2N5dIefAL8UtTtokH+huKsuqwOYiWeY
 JPLY9XDq6YL2mWRBZHbJEZKIvaU3HAd4Z0DACj/qkINZ+o2PGQoSO0lvnHUslgGYQ==
X-Received: by 2002:a05:7022:4186:b0:128:d4db:4478 with SMTP id
 a92af1059eb24-128f3dcdb90mr6698612c88.24.1773758830128; 
 Tue, 17 Mar 2026 07:47:10 -0700 (PDT)
X-Received: by 2002:a05:7022:4186:b0:128:d4db:4478 with SMTP id
 a92af1059eb24-128f3dcdb90mr6698590c88.24.1773758829512; Tue, 17 Mar 2026
 07:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-2-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-2-ktraynor@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 17 Mar 2026 15:46:58 +0100
X-Gm-Features: AaiRm52Ar4eTSELY32cRhWk6fVzR9fVByAqJmkkGMSWQObdD0qoZjzh1EPm12Ng
Message-ID: <CAO55cswNtnV4O7CH88WwGWu0+qoaXQyG+iUnY3UE1w8OvsmDuA@mail.gmail.com>
Subject: Re: [PATCH 1/4] vhost: fix resource leak
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>, 
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CdhyxS8vmIngacgEnzUUL7skEXptFdCEiKHWHzLVWXg_1773758830
X-Mimecast-Originator: redhat.com
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

Hi Kevin,

On Thu, Mar 12, 2026 at 11:36=E2=80=AFAM Kevin Traynor <ktraynor@redhat.com=
> wrote:
>
> When the return value check for pthread_mutex_init() was removed the
> out_free label and vhost_user_socket_mem_free() were removed.
>
> The free is still needed as vsocket was not being freed on out_mutex
> error path.
>
> Restore vhost_user_socket_mem_free() on error path.
>
> Fixes: 4d2aa150769b ("vhost: remove check around mutex init")
> Cc: stable@dpdk.org
>
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  lib/vhost/socket.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
> index ae95e7e6b0..278a2c01d8 100644
> --- a/lib/vhost/socket.c
> +++ b/lib/vhost/socket.c
> @@ -1037,4 +1037,5 @@ rte_vhost_driver_register(const char *path, uint64_=
t flags)
>                 VHOST_CONFIG_LOG(path, ERR, "failed to destroy connection=
 mutex");
>         }
> +       vhost_user_socket_mem_free(vsocket);
>  out:
>         pthread_mutex_unlock(&vhost_user.mutex);
> --
> 2.53.0
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

