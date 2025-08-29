Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596DCA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2721240263;
	Fri, 29 Aug 2025 15:04:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 079C74025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/wPi9BCROQHFcYMcuw6sOBkJ9uhw533GVdI40VGyEQ=;
 b=KN1XuzW+bCH93rDmFhCpqOc8W0dGPbFlffWBCoWJ49T96apOpycb766RoLNtAFyb6LNHa/
 PqTrO6PnByRp9Y23ZHSqHQqRTVUOEqc/ljYK0ZMc1xeXgqJwEUcckjeG7jWwXBRxBb2Z9d
 JKhgjN3ult6kT7e6PF/pd+i17MUC5w8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ydgX7oPPP72LDuKNz5yEpQ-1; Fri, 29 Aug 2025 09:04:24 -0400
X-MC-Unique: ydgX7oPPP72LDuKNz5yEpQ-1
X-Mimecast-MFC-AGG-ID: ydgX7oPPP72LDuKNz5yEpQ_1756472663
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-55f6bdc1771so275077e87.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 06:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472663; x=1757077463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/wPi9BCROQHFcYMcuw6sOBkJ9uhw533GVdI40VGyEQ=;
 b=uic25YK3zGSWQ40RJspwtGoh6BKqqNGKe6SEryxlhfh7LZr2j+7yHw8yagVgGfSO+h
 0AtgevtDTZy3Ts28kFOq+DHn1GK4INa7BD74R2Kl+b+eVm9FAXFZl91qRqXawzhrlsx4
 2vRXiM9MxlUBQSlsKNvyVEAPQvksW0iGbnXwPr5RSfUea+/3Y0bHrITItyd1/dOgaVgk
 Il6ta69kucS/DMu32KGrnNeHMC9eODBrdwZHY4VBpxikGeNqleb9bMJbmiiJoxl9IPk3
 1y4koy6DjOb6sfqBQcAl1/KYZIX1GF3FaA6KJkak0TOYFgnYU+cano9Bgsm4fUwdnF1N
 Kq6g==
X-Gm-Message-State: AOJu0YwcGjVZCP6Goa1tcotmRCc376deirwkpEmm4gpQad+PuKCE2ppT
 Xf/+ujtpPsAkt+ZX09AeQVtfKoiNQUjfo7omFvzbA8uMqLO94AOcbZayoKKVj26iup+nKT/rsMv
 XmDSeDzNiIJ8ZTASIKkM31H/6JsG0xxXHK9qUGTscaCHj8j4rmQIULWSzhPdxYMVHIG17upmD6o
 zxk67RAhWCRFjsWi3Ujy4=
X-Gm-Gg: ASbGncuhzHDM0fiBV6QfKc02yVfLPCL2VSiJzS38OLJts9DPWTu982HiE2Uv7L4SRD/
 6Wg9ikPSFokqv+2fIWVrfU1ktHIg3MxatxP05jDTJ4I347hNwNjaR/acFMud7t5Vx2/09s0s85G
 WPUGm5cXqy7Xm72YMXUtR7jnA=
X-Received: by 2002:a05:6512:141c:b0:55f:4ae5:8de8 with SMTP id
 2adb3069b0e04-55f4ae591c8mr4970707e87.46.1756472663256; 
 Fri, 29 Aug 2025 06:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZy5gOZDc3bz9V2ococE4I0vq2WTevHTTrG2dY/eXi+GKDDzNe5/iogm8dwwz5sHroutJ5QfJAAQT95IawOrQ=
X-Received: by 2002:a05:6512:141c:b0:55f:4ae5:8de8 with SMTP id
 2adb3069b0e04-55f4ae591c8mr4970693e87.46.1756472662756; Fri, 29 Aug 2025
 06:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 Aug 2025 15:04:10 +0200
X-Gm-Features: Ac12FXwkZwwIbQfK25AHvMwfsqo3sCknWEKvDuVWz4PD7_9HFJDLklKrXUYlm_w
Message-ID: <CAJFAV8y5C3-TZ-m-xECRZi3=tMqUE1BUahpE=-UfTxPWaXWRdQ@mail.gmail.com>
Subject: Re: [PATCH] test-flow-perf: Enable to build on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Wisam Jaddo <wisamm@nvidia.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WxvPJo-RFqhp-epLwzFj-_M4OyeOOa8TE7tbCp7wI1U_1756472663
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

Hello,

On Tue, 5 Aug 2025 at 22:00, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patch fixes some issues which were preventing this test to be
> built on Windows:
>
> - Remove VLAs (not supported by msvc).
> - Replace strsep() (which is not natively available on Windows)
>   with strtok_r().
> - Remove the "thousands" separator from printf() calls as it is
>   not available on Windows.

Can we use rte_size_to_str() instead?

> - Include the test in the Windows build.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Otherwise it lgtm.


-- 
David Marchand

