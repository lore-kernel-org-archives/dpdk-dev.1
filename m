Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588E1CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA9240673;
	Wed, 15 Oct 2025 13:45:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 363854066F
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:44:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaijNwaZbfqd9dE7h1xNsGcIgCH+ne7QyrlO6OBo+Xs=;
 b=V0mjMhf/eLewvPVmXANrjptgGNIyvvawqC+yBnHmeBT2V2YKTwcsroY/WR3SiU/6ms/yWB
 A5tY1d5mtlHbuS+wg8BbLmVhQUK8THU7iHpmP6yT8hGhmVmFlMCprH+kv2maDov9ANrDN+
 4CMJc9q41QQl2X4Qtbqphc/XeWDysmk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-6affzBY0MVqyFj06hZMMmQ-1; Wed, 15 Oct 2025 07:44:57 -0400
X-MC-Unique: 6affzBY0MVqyFj06hZMMmQ-1
X-Mimecast-MFC-AGG-ID: 6affzBY0MVqyFj06hZMMmQ_1760528696
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-58affa258fcso439607e87.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528696; x=1761133496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaijNwaZbfqd9dE7h1xNsGcIgCH+ne7QyrlO6OBo+Xs=;
 b=jog7zSBUPEeoB87jbag6TweKUe+0zKOIqdjdkxsqKhmE9PyL6KQ1N0OuYPHq9usjQw
 2uW/DbkVshjq4/NdhxVyeIhV5FNIl+v8IzaXpypOUlaSMQHF4A6lnJQIuXGbHGjFMz5F
 3a9XjbHmSeEXOxmVkEMhUWAvqNKuijN67KPZDwkWe6jsDzrYh5yW3ys85szPEkfhupfS
 Pn+Nv6t1FyHqt6q20/Ct0bDYmef+yKrJJt83joIz4P8d9cyt1J71APIPeKO3a+nCImce
 H2sPC7BxGbDddkqlwlxiNDd90wXCuhLdX2NU1b48qRyTSKxx0giEgWzLChaSpv8wqTGn
 L32A==
X-Gm-Message-State: AOJu0YxIDtgzhRhpHuY8PDwQpgKDaUSIhaBNFjRHeZYiTMeKOaHD6+FN
 mq8WqLyC6rNLxN/fTUTDtw1yZoSypteIea3dlOY+t8VDoYliZ1HNoXf1Ow9h0oZir6fPqVdM5Na
 wlVsBIZs5S1rI6y6Y1VB7a4LBJ/MAbavYxD66ZGchvj8ZA3n+48f12TsDOlO2swYpBaYhv8xgy9
 sGxsUE/b4u7nFCkC0ghms=
X-Gm-Gg: ASbGncs3fntu4i+Z35Z++gI2RN+GZjr0U51iQIZOyok2nSi49GfbwmQv5qsEvhxfTBX
 xsEAtC3Sw4bwCsj/40LkcsCB2vODL+pHlDOb4ymoGY9dB/OstUBscxecZAB+6+FG6dmZVFunmJN
 TE+zzptFqFzRDlKNIK+wE=
X-Received: by 2002:a05:6512:2312:b0:58b:89:a17 with SMTP id
 2adb3069b0e04-5906f444d1amr8481490e87.18.1760528696017; 
 Wed, 15 Oct 2025 04:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5W/C+WsJZe75isdX2kmBjq0IHIsgYs7+KTn9AzgJgnFEI75KkaTLt1mrAFWc6YbCFyja55AgcgaWHTlLEL+0=
X-Received: by 2002:a05:6512:2312:b0:58b:89:a17 with SMTP id
 2adb3069b0e04-5906f444d1amr8481479e87.18.1760528695600; Wed, 15 Oct 2025
 04:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
 <20250916093550.1345901-3-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-3-maxime.coquelin@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:44:43 +0200
X-Gm-Features: AS18NWDzykjmSjEEdVH-Gu1W_xRzxfnldHy4YyxtlgyXsDEVgYx2U0RVi3pqRGE
Message-ID: <CAO55csz5EY5r5T_ZgjhsfSd5cXLkP5RJACdjpRjU0nrFWBWn1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: fix uninitialized VQ info in VDUSE vring
 setup
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iJX7Uhaf0x6szUPVFQnZMD5adACBXAWff_UAP6dNBW4_1760528696
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

On Tue, Sep 16, 2025 at 11:36=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Initialize vduse_vq_info structure to zero to avoid using
> uninitialized memory when setting up VDUSE virtual rings.
> This ensures all fields start with known values.
>
> Fixes: a9120db8b98b ("vhost: add VDUSE device startup")
> Cc: stable@dpdk.org
>
> Reported-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
Applied to next-virtio/for-next-net.

Thanks,
Maxime

