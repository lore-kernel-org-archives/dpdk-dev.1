Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C979CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 08:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7683E40281;
	Fri,  9 Oct 2026 10:56:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 77A2A4021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 10:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791536164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XyzNF9xbbedazEVL+uR1fXv47k6DwOVQWvdfHv20uFM=;
 b=cIf7xfjEia+1Sp9Ad2DDNrTWZYGx1EhJpf/1jbL0RLatiQsupVqeGrhbLQy8dBCCfgShNT
 Am0C3FTs7aTUP9y+D8dvq8e51WqoBmnEG3JXa3gjB/Lj31/FQASAigHiFcyhBAx4Z3gooe
 3mxVxjTiS+77i6TriRCe55xe+4NVlkY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-mriCQ46rMGi8QxQWlzAD3g-1; Fri, 09 Oct 2026 04:56:03 -0400
X-MC-Unique: mriCQ46rMGi8QxQWlzAD3g-1
X-Mimecast-MFC-AGG-ID: mriCQ46rMGi8QxQWlzAD3g_1791536162
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a7808b09adso37614351fa.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791536162; x=1792140962;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XyzNF9xbbedazEVL+uR1fXv47k6DwOVQWvdfHv20uFM=;
 b=LuUQOeNQECO5mAh2ntPRzg8ZGHdhzlp/GmGZOcOH66ieFxLhnEInT7VqtQrQZRpxVr
 +qZPntdjD6LytbjQZFj4rjB3zofAgyGELukILUowm2xTBSJ04y2XLaGGhcIiNn5UdzlF
 wy89LVslTTI6WBQ1gwXwdJiF6b4503Upuc31nA+UcCyDJTDX/4NjKkwHDPjTpCNHgz8I
 vFAsOnagRGYrryviKXUHEpnH7FzlBZmJm9eeYSblLwTd1Hj5XQAbmq6DODjZpbCMB1It
 tAGrYJM5/CtFcDX4frlAindHusuEpMKv6elFI9FLJISI3NLgcf0YdJ2N9/+oaGfYrvC8
 0QfA==
X-Gm-Message-State: AFq9FYInkZlAXEl20Q8igejNs0oXePJ87ux7Fkd//h4g3tjDS8U697wi
 ftoxaOWP4WGpgy2inAnrL1m0GdVa8I317MQs6ZCWgf5NQWaNAl7V0XXcfBXlNaCrfccH82G0JrD
 EC/Hx1CFaTn6nVYAe2v5m51P8v1CbSNKX0SXlUUhV+KNKkmKuaB2pIRgRO1Fs/sVLjK57qTKq8r
 2EhwEFE5iTNHyaYxVwE1Q=
X-Gm-Gg: AYBFou3el3xAFopnoKia5OITg/cIwIKKm4+YKD7bJ9cwdS4XMgUxrE/F54foUCOtM9c
 bbl4c+dWCaSOHsoJuuXNKP0ZfHhTukN+cXrA3WEnYGsua6rzGd8Vf3nSj7rq+d3g9QAKesAKs0d
 OYmVw6nTBbKTfesSninub3y+dl5LInlWY2rfvd1v4mbAvvCI+H16DNw3VANtNJcxY6adv+QDVUx
 nJyIdpcxBApmozQxEdwQhcUPw0mvV/r8kW1QId/5yrSIm6g
X-Received: by 2002:a05:6512:1255:b0:5b8:f52b:8135 with SMTP id
 2adb3069b0e04-5bcde6bf6b1mr462729e87.17.1791536161848; 
 Fri, 09 Oct 2026 01:56:01 -0700 (PDT)
X-Received: by 2002:a05:6512:1255:b0:5b8:f52b:8135 with SMTP id
 2adb3069b0e04-5bcde6bf6b1mr462716e87.17.1791536161389; Fri, 09 Oct 2026
 01:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261008154351.387445-1-bruce.richardson@intel.com>
In-Reply-To: <20261008154351.387445-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 9 Oct 2026 10:55:49 +0200
X-Gm-Features: AclHuK8GZ4PoDM60i0wBTbRJ4Y8rs4iR7cHV8Wvt3aCX4DpHDT_P141SEJVbLXM
Message-ID: <CAJFAV8zdGwbqmKa=oFLDAJWv=7_rRZ1zBy_gtk_=C5NCOUsPvQ@mail.gmail.com>
Subject: Re: [PATCH] dma/idxd: remove experimental on whole driver
To: Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>, 
 Luca Boccassi <bluca@debian.org>, Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, Conor Walsh <conor.walsh@intel.com>, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8cPp0SU6YUghMD36dL__jbEw8grDBacwXMrifi3Z9eM_1791536162
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

On Thu, 8 Oct 2026 at 17:44, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The idxd DMA driver was marked as experimental in MAINTAINERS file.
> Remove this designation as it's been stable for a long time now.
>
> Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>
> Putting the fixline as the original start of the driver implementation,
> since there is no good commit point to use to identify the stabilization
> of the driver. Since this change should be good to backport to all
> currently supported LTS releases, the orignal addition of the driver
> works fine as a commit being fixed.

No opinion on the backporting aspect.
At least the driver looks stable for a while, so the patch lgtm.


-- 
David Marchand

