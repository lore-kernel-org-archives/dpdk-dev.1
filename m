Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0AEB28E2
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543D34029A;
	Fri,  6 Feb 2026 09:13:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E484C40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 09:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770365587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAnwFNUO27u3MZWxfSGhDE1ikiBmkuY9SU+iuRX5MWU=;
 b=L6glSJU7hb2w8pOjjDjzOtlpB7hXAiFk1N9fQuWkDwBQwCI9KVkPS//+UbHYXb2jTZUQO/
 nP79KRvQp7Ts4doH2GpRnGZ1C3Tm5OP8IFmBNCJ1M5UiHIF+M+LwFR0J+O9xnGsqaYGtNF
 B04W8jYVr5hcyrI6Y1Q4MSBZU8wCPPE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-F1rAGalLOgO_n0npkXJ1BA-1; Fri, 06 Feb 2026 03:13:05 -0500
X-MC-Unique: F1rAGalLOgO_n0npkXJ1BA-1
X-Mimecast-MFC-AGG-ID: F1rAGalLOgO_n0npkXJ1BA_1770365584
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59e34a1ef8fso1169647e87.3
 for <dev@dpdk.org>; Fri, 06 Feb 2026 00:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770365584; x=1770970384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAnwFNUO27u3MZWxfSGhDE1ikiBmkuY9SU+iuRX5MWU=;
 b=Uc1sOYObe0gmHRV6udE9TSQj22lAFctxVbBXReI8SjHj1sU667z/bfGYOMiVRMrLsb
 HvolDTCsuwUwdqJ89DSZifsouo3c2ywqLYp6N2oYkejrQ+1cQ9+Qq6xS2TIq7IDFtI1+
 XjlVELlR7XubbeEE9omHzTEMnP09Z4UQo9jgxkkDmhBl6L8D0tlakhh8wG6pGAwdpuGk
 imyzJbpdkwxKQQlFueBKTQbZwWRXfNeKyez9l9dgc4XOUNRAfLa40B7+89BmPMFiBn9j
 FvhOf3n+hpoJdsfROKX+FYEG/4yCpKH1qSycnFmyHAcQpWknBoCCe0Ye7bCAEjrhGpYk
 iyHA==
X-Gm-Message-State: AOJu0YxwwqqEvWgaon+RZ0bBJBheS6AusOiBKxeOgBn4rfUrNrKtNCQo
 XfV9MN9xavh1Dfpc2crxdrpU3+YLa+hLnJEjqiNoRJlH3TNaX/yAHKGgPfdAOuIfxi6sHUMz0Sx
 k6ULW4WrrasyCvf6TCUf45x4MVHzSQ0WZrgCumam+M/PGFPtGYLmkcBR16ABobLw+SAPyve3KJt
 hxjp5Qnncyg9/iHNqyG2I=
X-Gm-Gg: AZuq6aIl6KoSEC7Fh+mNXQv5zMF+h0v24/XfistvmXXviT2R8PBP7fMO69wcEOp2b5i
 u5xq3TEapeJB51WtnYvycu0cYUZiDh0Ihv/a8p54AuaHz0W8QrWUnzfJJtkfph6cc8i9kOFoHsK
 stQccvUZvZoVjPkFtCSZni3V7FSIwP516W4eGpBKJeZ+OPphbVGUWdpCBl2YEa6/ogSo9V2/q0B
 dLQNynxx5U+1AmD5KsOOxsk2W1q9MwGnpaZnaipZbNSiq/WBSYKbWVEtA==
X-Received: by 2002:a05:6512:1302:b0:59e:39af:a70f with SMTP id
 2adb3069b0e04-59e45156d7emr499237e87.35.1770365584201; 
 Fri, 06 Feb 2026 00:13:04 -0800 (PST)
X-Received: by 2002:a05:6512:1302:b0:59e:39af:a70f with SMTP id
 2adb3069b0e04-59e45156d7emr499230e87.35.1770365583793; Fri, 06 Feb 2026
 00:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
 <20260205213044.702908-3-thomas@monjalon.net>
In-Reply-To: <20260205213044.702908-3-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 09:12:50 +0100
X-Gm-Features: AZwV_QhVWYb1Ynu1wSFjPZN6o3pvmXaGaiLpES8OR63LAY6oOz1ZPQ9er_Mr0XY
Message-ID: <CAJFAV8w9nyJU92feqy9KJme4WeTnv5k4nOXgc3=hBsnGU1VMWA@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mem: avoid hugepage path overflow
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z7HPPSJSx2uWIH4imyDwDsO2VIhb1jrO-bCx984KQtg_1770365584
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

On Thu, 5 Feb 2026 at 22:30, Thomas Monjalon <thomas@monjalon.net> wrote:
> @@ -446,8 +447,14 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
>                 return 0;
>         }
>
> -       snprintf(hugedir_str, sizeof(hugedir_str),
> -                       "%s/%s", hpi->hugedir, eal_get_hugefile_prefix());
> +       ret = asprintf(&hugedir_str, "%s/%s",
> +                       hpi->hugedir, eal_get_hugefile_prefix());
> +       if (ret < 0) {
> +               EAL_LOG(ERR, "%s(): failed to store hugepage path", __func__);
> +               goto error;

On asprintf failure, hugedir_str content is undefined.
It is safer to reset hugedir_str to NULL before jumping to the error
label where free() is called.


-- 
David Marchand

