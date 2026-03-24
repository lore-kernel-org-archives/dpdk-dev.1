Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE8FEC0EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:35:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F7D4060A;
	Tue, 24 Mar 2026 18:35:04 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 47C864021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:35:03 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-50b266413fbso45656061cf.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774373702; cv=none;
 d=google.com; s=arc-20240605;
 b=Gz87fgk+RD8n+v1lHz8NyZGkr9giil7qK+s36LESnszYKNi6HxVvlia1Tea5XxH9EA
 hGPcT98KlJs7Gs6r/wL6GcvgYB3VxRdB6leUI/hKVQB/p/jXZuZ/tiOffoquqfa5F7mW
 dpP3rbOWwywsolyblSy571xdoySDglf5wq4mHoNDC/6mZMkx7ZWdRwVNgEZr/1sOuBqF
 u0o9X9K55Q+hlwhPzbnO5SsVyP4z7Sd0yNBTeQI2qFpbg8xc2uhpTRqHTJUyLcL9W232
 /OEPBn9nZk0JbPlyTQtNYgypZvrgFpb5OVz1reb4+IG/ZS2iYq2zHb+z5COd0tbrXmLV
 8k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QdMLQHJfueIQofYoQXrdVWpCa7Ce0D2t1GTnNXBurvg=;
 fh=T6zuNLJD9hatQXoWg3boYcDul0IcDgSsUpFtNKJ2vuw=;
 b=XZvm/HLownVAe9Qcx/TU24uKqbOb2LkIksnYEttvjgdSqqbhHCQCo+HtytzcUb+lh1
 R+7AEue+kg+EIr5mASNAUJZGcro48Owu2+BOyYXXDaT25ryzqMqOW6s1UhmWI8vAtOx1
 IUns8CNY/OAu/3BA4Bqhk8YZjKtooKVtU8EwuwF7z//VJaNvjmTj1Y/cQ6UuiEdCO0TF
 t5l9tAPXivG+RO/97Qyw4KusbOaA0FhwTyzMoJYQpy3Gl0sz2bbjHz8iLvrPjqcqsbnn
 TMtbpHAU1fv5jIY9Dpmw/BPmXiAXntS1U/jqhe/0MfTAR1CBOEp2B7TP/HUZWsACTjOH
 TElg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774373702; x=1774978502; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdMLQHJfueIQofYoQXrdVWpCa7Ce0D2t1GTnNXBurvg=;
 b=pFmWPsOTdQK3ChLcfoSzd54k7xJmLtHKwifCZpMyhA9AAYVS7WVsF2QL2y1NVhS7vL
 IF2wSBjPlX5q7HjRQaraTf0WhRn7EHhokEuL9UxZuAcoEEzDkbRvc9bM+QtnkWtP/vpT
 Ll4g2BV4d+tYhDfmzEx6CzhXRp/MJl9SMkIrh1uqxNFwxuliXTkBZ8o2FjImrQ4SOIIW
 z5Ee3D6DNjPMgDE/dWk5l62oJI+Rqw0NLxS9NlMmoN3fH0ooD1un74BG39tYEYYzgEyg
 cA1yOC3XUZ5G8U8RwRPUd+YvlwaQfmim3Mu4sNSlMpKy8goJb93pNurCHf+7hP9Gho3M
 txQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774373702; x=1774978502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdMLQHJfueIQofYoQXrdVWpCa7Ce0D2t1GTnNXBurvg=;
 b=SDYXX7lH9AFv6wm8+j68ykY2LZZH/Wu2Y1+43juM/8T7smhOFvxC020dw4I3LV0eSj
 eTCRgJzxFUeAjkKq5di8BNzUq9oE/DKX8hj/pxW+LoeEBxcK7v66g6AmIcorQObI3k2A
 /6AXNvM46IawD7W3Pw6znlA2v47YOPwIMRQHNWBxiXJZvwpTKJw9qg++kQhFNNWnrQ41
 VPm1Yc9c+adLQhGm/2YY+XcWnXQd8co8GwrwEgwlhD8MD0TtQGKjJDL2lI2w9+8XfOPs
 ytA/H94BFY47bOfI8ld7v3WRFi2Q28YBkiYyDulAVpEh/f7BHLDITrXY8sSMbrUskm7J
 JmLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAMb90DSYVLsAlgheJFLGB9KN4ZKKxJ9xsrCu5ZPal7MCA3Fh4O+sCxAGMzdfGWnRgyYM=@dpdk.org
X-Gm-Message-State: AOJu0YxHHsnvGLvURj28TJNMSr0NYzy427e1ssPARA1HalW0Y+M7wdzE
 wICYRd69T6Eomj2Kct9i9eKOCaCKjVNFTeN0hAbbkvCuM/YeU8VyG9KnkWgS+oOuY6U3jJ/yvUD
 t5eE/ufPSTYCaL0COgB7ky8tzNam4C7CqRNuT
X-Gm-Gg: ATEYQzyAiLUPxojNl0D7K1H9Upt40yYOYSyRyIUjQfOct/4OcQ2/0qDBDyzPZom++ir
 g8qut+pXLJyyoznyg8jX21Eo7bcGd9ziZ9aArEVAPshSAo8Vo7xnnvq/sCUuthEChVwkNIchyk2
 M6kTRldhkOyLmaCbn3v62Kx0zh1JIF4RAcrWewMQodZlknVw34CTS3i2FGvkZge8jtOvh/r2mZP
 9ThdR3sDAP6K40vqrECEqicJ4dVA1+jELJykVbEs74v7Duk3esuPSGtdbmZvYutidK+Z5qCSZWN
 jtA=
X-Received: by 2002:a05:622a:22a9:b0:50b:4b2f:1606 with SMTP id
 d75a77b69052e-50b80c9ad0amr7571561cf.15.1774373702216; Tue, 24 Mar 2026
 10:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260304003406.252929-1-yashin.sergey@gmail.com>
 <20260304003406.252929-3-yashin.sergey@gmail.com>
In-Reply-To: <20260304003406.252929-3-yashin.sergey@gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 23:04:36 +0530
X-Gm-Features: AaiRm53E7UycanSYiB-jtm26gVu8hHREQ2dYv5Q4dekAvcoVWn--XQTOGXALhuA
Message-ID: <CALBAE1MYNXEZO4afP4R+hPxEYX7ExOvGiUZNxV1n7HRJ7RQurg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailmap: add Sergei Iashin
To: Sergei Iashin <yashin.sergey@gmail.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
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

On Wed, Mar 4, 2026 at 8:46=E2=80=AFPM Sergei Iashin <yashin.sergey@gmail.c=
om> wrote:
>
> Add my name and email mapping to .mailmap
>
> Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 6c4c977dde..85db3c11af 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1936,3 +1936,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@l=
inaro.org>
>  Zorik Machulsky <zorik@amazon.com>
>  Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
>  Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
> +Sergei Iashin <yashin.sergey@gmail.com>

Fixed the name order by making it as alphabetical
Squashed with 1/2 patch
Applied to dpdk-next-eventdev/for-main. Thanks


> --
> 2.39.5
>
